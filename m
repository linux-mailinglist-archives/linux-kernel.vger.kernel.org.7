Return-Path: <linux-kernel+bounces-805426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AE7B48867
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973DD1899430
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D502F069C;
	Mon,  8 Sep 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YKK4rjvH"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CEA2F3639
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323689; cv=none; b=s79mLt7fewZi7s3UGn/K3i/yNNlnsB8s3LUKcRLWMlB4z507Rd7PKMDmGrcVbfpS0O2Sn7yRGVA6DnoyQMZAuq9u+9KVtT8IGZ8c/JnTDS5lY2wqLUyRk3hiADcn+PRDj4Obq/R9ibghlLtStMxFj8rtvzpremy0k8GyTHB7FNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323689; c=relaxed/simple;
	bh=9Yc350bOoXWQnnKCxgDF3bTAxz3r3C7tm41X5x1rijg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=io4XHtnXd6BTfqMN68fHausSFQUzIc9vZIFg+mc2K6lBEhBbDAjrKZSHGy7RHvc4WcGCXF/5a7qMwgVW16gWFArCir1GsJv5+2KUNHPHQPJAzG9v1F1Xehs2Ff3n/kHBNUSnB+SsRQJa+r+uTVcRozEEvi0ETkB4nCNcorFDO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YKK4rjvH; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bae1831b-decf-46bd-a264-1cf3ccaa64a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757323682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9h4BcOvxOwjHrG9H029E2+yuGVDQtSI0hF0Jbh8AA8=;
	b=YKK4rjvHR8VZawK48xv2K7mntDx6rWV7+SqBIHraZETqNuF8fOfhd4Y2sdUoiQqY2YB+jk
	mNgxRaoD3QRENGOklPO0EtqdTQxLshJhKJCMQLZfOR+5Nm5xMK2QlD7dGJiIZlv6NAgbag
	s8hbCIzzfMwZpwZTUYQinBbGyesZdBE=
Date: Mon, 8 Sep 2025 17:27:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] mm: skip mlocked THPs that are underused early in
 deferred_split_scan()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 usamaarif642@gmail.com, ziy@nvidia.com, akpm@linux-foundation.org
References: <20250908090741.61519-1-lance.yang@linux.dev>
 <73c8a52c-37c5-45f4-b76e-f15267412242@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <73c8a52c-37c5-45f4-b76e-f15267412242@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/8 17:12, David Hildenbrand wrote:
> On 08.09.25 11:07, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When we stumble over a fully-mapped mlocked THP in the deferred shrinker,
>> it does not make sense to try to detect whether it is underused, because
>> try_to_map_unused_to_zeropage(), called while splitting the folio, 
>> will not
>> actually replace any zeroed pages by the shared zeropage.
>>
>> Splitting the folio in that case does not make any sense, so let's not 
>> even
>> scan to check if the folio is underused.
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
> 
> Feel free to drop that, I only tweaked you description :)

Well, I'd actually prefer to keep it. Thanks for setting me straight on
try_to_map_unused_to_zeropage() ;p


> 
> Acked-by: David Hildenbrand <david@redhat.com>

Cheers,
Lance


