Return-Path: <linux-kernel+bounces-805860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A50B48E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BB407A311C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA72307493;
	Mon,  8 Sep 2025 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZHVTDzP2"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B759305955
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336455; cv=none; b=FusUGNEIzNci1TkDOEVTc/RPyRefPZDv56HOE3T2Q/gj2u7IrHlTpJwUQzFoxQkjEBSfa69g3i7A17P610eFeCYDjxHwpLzOoU4FC+SXpIe3zEW1cBddAo6s2cEUyxuM1+iUpRQxky67bf4jjF7+PH8Gz2YlK74URjxZ883hdrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336455; c=relaxed/simple;
	bh=6tn7+XAUCXK6gOY4I5v6Fgzx71/GzkYiXDlQMIfdo7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UG7nvVJFtLO+EZoT8CCLQEF5gZ9RCLstKm0gf3q7Kc6s51psHnRy102RaGlUxuhyhqf7N+m76CJcSubdbYM5IovDml4hiokwB3lNZovt0njBsfvAuw1Q/F7FuJu4Nl9f0YauQudrIOwszVB5Xb6UvudKGLwPKKRz5nHGF7Kh5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZHVTDzP2; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2c3d74d7-2e18-4bcd-bbd2-b1b4a65862c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757336450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UEOYJP0r+FFEln8Mu2fBE+f5b200C2wDFYA086EimI=;
	b=ZHVTDzP2UPiVcytca0ZHAwFNZVGPLOdPOqnYKDdTAzYXFUko3aCbR6tPN+cirWmoPrrj8n
	65LaSZSRpRF3LfaKc/ZtGmLhVuZPo8mhlV7S/FKPPbROvEjqVZZUNfIQtE2WH22/xfk8p7
	MGubcn4ZA9ESmNWa5ugvxiooZfdikAI=
Date: Mon, 8 Sep 2025 21:00:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] mm: skip mlocked THPs that are underused early in
 deferred_split_scan()
Content-Language: en-US
To: Kiryl Shutsemau <kirill@shutemov.name>,
 David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 usamaarif642@gmail.com, ziy@nvidia.com
References: <20250908090741.61519-1-lance.yang@linux.dev>
 <niywtremc5kfhs3lenmfxvbiiizyexnaw3m25twedmzovfoeno@lk2o46tfdklk>
 <9a0c07b9-5bf0-4251-8609-fbaf0ca75bf9@redhat.com>
 <5j6i2o6umqwxabdfncbrdytmvdma4yrraxe6hu4csckcniduya@sm3mlablwbad>
 <f58a472f-4a36-40e7-94d2-229125ae7373@redhat.com>
 <7pmksyuurzi2df5r7d2lpku63rbimjy5e3dzmleb63ik4257ge@2sm7yqfqvolf>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <7pmksyuurzi2df5r7d2lpku63rbimjy5e3dzmleb63ik4257ge@2sm7yqfqvolf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/8 20:45, Kiryl Shutsemau wrote:
> On Mon, Sep 08, 2025 at 02:04:05PM +0200, David Hildenbrand wrote:
>> On 08.09.25 13:44, Kiryl Shutsemau wrote:
>>> On Mon, Sep 08, 2025 at 01:32:05PM +0200, David Hildenbrand wrote:
>>>> On 08.09.25 12:38, Kiryl Shutsemau wrote:
>>>>> On Mon, Sep 08, 2025 at 05:07:41PM +0800, Lance Yang wrote:
>>>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>>>
>>>>>> When we stumble over a fully-mapped mlocked THP in the deferred shrinker,
>>>>>> it does not make sense to try to detect whether it is underused, because
>>>>>> try_to_map_unused_to_zeropage(), called while splitting the folio, will not
>>>>>> actually replace any zeroed pages by the shared zeropage.
>>>>>
>>>>> It makes me think, does KSM follows the same logic as
>>>>> try_to_map_unused_to_zeropage()?
>>>>>
>>>>> I cannot immediately find what prevents KSM from replacing zeroed mlocked
>>>>> folio with ZERO_PAGE().
>>>>>
>>>>> Hm?
>>>>
>>>> I assume if you're using mlock and at the same time enable KSM for a
>>>> process/VMA, you're doing something wrong.
>>>>
>>>> In contrast, THP is supposed to be transparent (yeah, I know ...).
>>>
>>> Yeah, I guess it is user error.
>>>
>>> Maybe we should make ksm_compatible() return false for VM_LOCKED?
>>> KSM breaks mlock() contract.
>>
>> I was thinking the same and falsely remembered that we would already be
>> checking for that.
>>
>>>
>>> But it can be risky if someone already relies on this broken behaviour.
>>
>> Could be.
>>
>> Staring at QEMU, we have the following parameters:
>>
>> 	mem-merge=on|off
>>
>>      	Enables or disables memory merge support. This feature, when 	
>>          supported by the host, de-duplicates identical memory pages
>>          among VMs instances (enabled by default).
>>
>> And
>>
>> 	-overcommit mem-lock=on|off|on-fault
>>
>> 	"Run qemu with hints about host resource overcommit. The default
>> 	 is to assume that host overcommits all resources."
>>
>>
>> Now, I would assume that anybody who sets "-overcommit mem-lock=on" either
>>
>> (a) Has KSM disabled on that machine.
>>
>> (b) Sets mem-merge=off
>>
>> as well. But QEMU would allow for configuring it.


That's really interesting ;)

I guess it's likely that people are already relying on that behavior,
even if it's flawed.

> 
> ksm_madvise(MADV_MERGEABLE) succeeds on !vma_ksm_compatible(), so it
> wouldn't be functional breakage, but may result in unexpected increase
> of memory consumption.

Hmm... it's hard to argue that nothing is broken.

An application losing the memory savings from KSM might not fit in
memory at all and could be taken down by the OOM killer ;p

> 
>> Interestingly, mm_populate()->populate_vma_page_range() wants to break COW.
>> [*]
>>
>> But if the app later calls fork(), we still allow for cow-sharing pages with
>> the child. (another case of "don't do it", like KSM I guess)
> 
> CoW has bunch of these "don't do it". :P
> 
>> [*] it doesn't do it for mappings that start out R/O. I think we might end
>> up with sharedzero pages in that case, but not sure if worth fixing.
>>
>> -- 
>> Cheers
>>
>> David / dhildenb
>>
> 


