Return-Path: <linux-kernel+bounces-853596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A230BDC0F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 244A74F731E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862FA3019B9;
	Wed, 15 Oct 2025 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W+RsocPB"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901EF2FBE00
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493140; cv=none; b=uds2vDtK3Ab4xcPtX8AWMXRPE6pJ6XTDfJ8D2+862KiDro6Rc8he0Sbu2wCaQ4q8GXL8lylmwi08zLlb0XU8xWkYH6ys0Z6SAyoKnNJTmrRjrArvGu/a4kuNYfJNRj4iT1TrNe6jNVNv7lHpYvdyrd9XNwHnm19B5T05sTCPHdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493140; c=relaxed/simple;
	bh=PAc/r4C2JTSM2V5og7USFw5NZsZvvwCgeBzUk1JAgr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEwgoQOAgY4738Z0ih9d4eS+jEqRVBxpYPKusaF+McF0CjwRSZlnZmePoh2mug6NWS9LshFrOACah2egaGNQh80ymAkB2Pb00gXCQw3Cy79z3ISWWIzllHDoKRK842iV74x+7D3Zlc33UWAejT7sIQXav2lG2apdxWsV6PKoUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W+RsocPB; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2495f0c5-b23e-49f1-85a9-0c55d8913554@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760493134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zgcZcBwEZHvov/1clD5IPA2OcJJtZnj/AiNz3lCc0iU=;
	b=W+RsocPBKrJlRE7cyN7uXBBi5IBWaiBP5MC6Jt74OoXWBwQphjOadPM3Ebb5Qlg9dwnidT
	4RDurvWqeAKMFW6HMCpbYp81uloFv4pkiZdSoqnxYcOD0GZXvzNFrhwLIxO2qeQNKgngN7
	K0Cx9T5+1qoTJt7yP+Ah/2Pmear6Nno=
Date: Wed, 15 Oct 2025 09:52:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Content-Language: en-US
To: akpm@linux-foundation.org
Cc: David Hildenbrand <david@redhat.com>, Liam.Howlett@oracle.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, dev.jain@arm.com,
 hughd@google.com, ioworker0@gmail.com, kirill@shutemov.name,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mpenttil@redhat.com,
 npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com,
 richard.weiyang@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <20251008032657.72406-1-lance.yang@linux.dev>
 <f33735d3-b38d-4b6a-aeba-b415e6b24ea2@lucifer.local>
 <0bfdbccd-9d4a-409f-ae43-b44bb7347d70@linux.dev>
 <f7392f43-b8f1-4e6a-b9c8-25ad8a47f82c@lucifer.local>
 <95a223b1-8d57-40c3-8226-678b1db233aa@redhat.com>
 <57cffedc-65c0-44f1-8364-3a3ff9bdc760@lucifer.local>
 <b0e88b97-3c55-4be3-9782-4ab5e5d72ebe@linux.dev>
 <c176f6d1-2f43-4920-8133-f405e6756c5a@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <c176f6d1-2f43-4920-8133-f405e6756c5a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


@Andrew could you please drop this patch from mm-new ;)

Thanks,
Lance

On 2025/10/15 00:27, Lorenzo Stoakes wrote:
> On Wed, Oct 15, 2025 at 12:09:42AM +0800, Lance Yang wrote:
>> Hi David, Lorenzo,
>>
>> Thanks to both of you for the deep dive on this!!!
> 
> That's ok :)
> 
>>
>> The code we've been discussing was moved to a new helper by
>> another patch series[1], so let's call it a day on this
>> thread and leave it as-is and just review/change the logic
>> at its new home :)
> 
> Ahh, please do make that clear in future, I reviewed this on the basis it
> was a dependency of [1] :)
> 
> I separately reviewed that on that basis.
> 
> Will reply there...
> 
>>
>> [1]
>> https://lore.kernel.org/linux-mm/20251008043748.45554-1-lance.yang@linux.dev/
>>
>> Thanks a lot!
>> Lance
> 
> Cheers, Lorenzo


