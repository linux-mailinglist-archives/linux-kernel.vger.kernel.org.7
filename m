Return-Path: <linux-kernel+bounces-805681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D38DCB48C3F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBA21B24FA6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C722FDE8;
	Mon,  8 Sep 2025 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kRT2hkhn"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D919343B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331193; cv=none; b=NwJIC4qi5mWASrh0jItiK19VrSIjfYNfAZ2P+24gKu1pCduN5IiJu6eJJNTx4F6D2kREdiwyCPT32I2i6sdxa2rjtMBitGSl9BF7xQvUnhRevtCzluc32gLOauHfrkjSFQpVTIviLUtSoOKAMP5r3GuWWshV1+7wmzjyMD8NoGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331193; c=relaxed/simple;
	bh=Sdz+T/QY+Hr7kdMGBEOZ2qC7Rpwzx7gXnuK0VCRWYvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeOwoJ1Sfzoa+Fb+DYTinZq/1hfy9876LN2WVzWwHS5PXQlAdcxXlUoavs1v4AT+MP9qgt22nJAgE+R5F1VI8sNuWCvlAr2lBOSWo7b9NdArE/qSh9/eFnRik+3P9c4YRlqXnjhL/xVKSs3hen0M0sxt9G1nPhA0do7+bjsPW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kRT2hkhn; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b92419d3-c8ae-47b0-b9f2-0c0c46057cf9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757331188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vn4jY7Xjd2fdDYa7yxhH+NTKe/jBHKzgZ5tbZmQYF4k=;
	b=kRT2hkhnbQKFtxIl9NrbFTgJXv0leQwOgL9BNmlffAtJSdBHL+TPh+NyWFYcX9BpGYC6LW
	uyhOlGipnNbSwVgRBnVr6+n5N4iJvakW+FtPX9EpP+WnND8XdZbd9p9XmuK+xLiJcBlEe1
	I29E+1GW0ycC0Q3vOwIFKohpFa8gafA=
Date: Mon, 8 Sep 2025 19:32:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] mm: skip mlocked THPs that are underused early in
 deferred_split_scan()
Content-Language: en-US
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, david@redhat.com, Liam.Howlett@oracle.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, dev.jain@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 usamaarif642@gmail.com, ziy@nvidia.com
References: <20250908090741.61519-1-lance.yang@linux.dev>
 <niywtremc5kfhs3lenmfxvbiiizyexnaw3m25twedmzovfoeno@lk2o46tfdklk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <niywtremc5kfhs3lenmfxvbiiizyexnaw3m25twedmzovfoeno@lk2o46tfdklk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/8 18:38, Kiryl Shutsemau wrote:
> On Mon, Sep 08, 2025 at 05:07:41PM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When we stumble over a fully-mapped mlocked THP in the deferred shrinker,
>> it does not make sense to try to detect whether it is underused, because
>> try_to_map_unused_to_zeropage(), called while splitting the folio, will not
>> actually replace any zeroed pages by the shared zeropage.
> 
> It makes me think, does KSM follows the same logic as
> try_to_map_unused_to_zeropage()?
> 
> I cannot immediately find what prevents KSM from replacing zeroed mlocked
> folio with ZERO_PAGE().
> 
> Hm?

Good catch!

Surprisingly, my test shows that KSM is indeed able to replace a zeroed
mlocked THP with ZERO_PAGE(). And MADV_MERGEABLE allows a VMA to be marked
as mergeable even if it's already locked(VM_LOCKED) ...


