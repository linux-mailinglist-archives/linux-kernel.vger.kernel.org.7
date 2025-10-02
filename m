Return-Path: <linux-kernel+bounces-840510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F835BB4925
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F94189177A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B48D265CBE;
	Thu,  2 Oct 2025 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSgvXyjT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DF0261B9C
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423236; cv=none; b=UGQf0pJ5KaiUmPI7pWwj4TgNfdmkYeIvxQgJGuK709yjhK0Fq+0aI5/NojOQcxqQ+KP0l9fqaLsjYHENLCnHYbbcKvtSQZ1MDRm4c7yJFh1d8xH5ZMh037XfHRNspKnVvsewAQvvqt7quWZSlTPU1OwfA7P90q018S/fsk+Mtec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423236; c=relaxed/simple;
	bh=ibke5hIrVui4nGEtrIYn9QjlwZMC043RVeGvmwn63Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sbelz4SQmW9Lwe8GMfdoRvxAO6L1D7Mairvwo7bH6KuN94pP8/BOj0BXeqKHMcBOTXO6wBebtW2jFVwBuTgk42wZCTH4xqzRomOCqOX+WlELrDbSX+hMsLZSeBvAKyDN9U0iO+pTt2GbFws2yRhCSA2/fhdc4n1DTo/ug0u1Nn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSgvXyjT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759423234; x=1790959234;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ibke5hIrVui4nGEtrIYn9QjlwZMC043RVeGvmwn63Ww=;
  b=hSgvXyjT3DHqAfoWFP5Cp+tWXDaDSqEHhEYUFjXthPNNXL7iT96wtnzb
   ZooHof9dl92qGOJ+OHmLYyVRWjeaBAjpCQJuK5estSBemaInHeLMsYwIH
   zidshsY9pTv7Q9cKSjj6jTaRssniTDPkkT4q5PvaNLs3Y/AO1VOY3VPNt
   xrO8U3FdPjCOZJ4/7cux5o0RAEnr6//1F1hH4LpwUuAPQOzaUTTWlKrGD
   IsXxFvUhzSSK/9Ccb2dDwmIKWIKYXIdyKukYgPH0sr6Z10gLKgGd3L9Ry
   td4b1KaMdmkK3oEsRgkuOYeCI9aT2nBR3pcle8VbOICCnshDg+3d84bHi
   w==;
X-CSE-ConnectionGUID: eBP5Onp/RV2cUTM2GfQXaA==
X-CSE-MsgGUID: J275H933RqaWHLEGmQgt1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="79135883"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="79135883"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 09:40:29 -0700
X-CSE-ConnectionGUID: 8u4u+yw2TUab9+EwTMdbRg==
X-CSE-MsgGUID: IdoaEtPSQkufnv7O5PzOhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="183484713"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.249]) ([10.125.109.249])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 09:40:28 -0700
Message-ID: <19e5012a-3c58-4696-9e4e-39e2b7d2b5af@intel.com>
Date: Thu, 2 Oct 2025 09:40:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/21] x86/mm/pat: mirror direct map changes to ASI
To: Brendan Jackman <jackmanb@google.com>, Andy Lutomirski <luto@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
 mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org,
 david@redhat.com, derkling@google.com, junaids@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com,
 rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org,
 Yosry Ahmed <yosry.ahmed@linux.dev>
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-5-2d861768041f@google.com>
 <08338619-6aa1-4905-bdf8-bf1a90857307@intel.com>
 <DD7WQ97R8OG6.1CA5E2FU5ISMZ@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <DD7WQ97R8OG6.1CA5E2FU5ISMZ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/25 07:31, Brendan Jackman wrote:
> On Wed Oct 1, 2025 at 8:50 PM UTC, Dave Hansen wrote:
...
>> But let's say someone is doing something silly like:
>>
>> 	set_memory_np(addr, size);
>> 	set_memory_p(addr, size);
>>
>> Won't that end up in here and make the "unrestricted PGD" have
>> _PAGE_PRESENT==1 entries?
> 
> Er, yes, that's a bug, thanks for pointing this out. I guess this is
> actually broken under debug_pagealloc or something? I should check that.
> 
> This code should only mirror the bits that are irrelevant to ASI. 

It's actually anything that has _PAGE_PRESENT in cpa->mask_set. There
are a number of those. Some of them are irrelevant like the execmem
code, but there are quite a few more that look troublesome outside of
debugging environments.

>> Also, could we try and make the nomenclature consistent? We've got
>> "unrestricted direct map" and "asi_nonsensitive_pgd" being used (at
>> least). Could the terminology be made more consistent?
> 
> Hm. It is actually consistent: "unrestricted" is a property of the
> address space / execution context. "nonsensitive" is a property of the
> memory. Nonsensitive memory is mapped into the unrestricted address
> space. asi_nonsensitive_pgd isn't an address space we enter it's just a
> holding area (like if we never actually pointed CR3 at init_mm.pgd but
> just useed it as a source to clone from).
> 
> However.. just because it's consistent doesn't mean it's not confusing.
> Do you think we should just squash these two words and call the whole
> thing "nonsensitive"? I don't know if "nonsensitive address space" makes
> much sense... Is it possible I can fix this by just adding more
> comments?

It makes sense to me that a "nonsensitive address space" would not map
any sensitive data and that a "asi_nonsensitive_pgd" is the root of that
address space.

>>>  static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
>>>  {
>>>  	unsigned long numpages = cpa->numpages;
>>> @@ -2007,6 +2033,8 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
>>>  		if (!debug_pagealloc_enabled())
>>>  			spin_lock(&cpa_lock);
>>>  		ret = __change_page_attr(cpa, primary);
>>> +		if (!ret)
>>> +			ret = mirror_asi_direct_map(cpa, primary);
>>>  		if (!debug_pagealloc_enabled())
>>>  			spin_unlock(&cpa_lock);
>>>  		if (ret)
>>>
>>
>> Is cpa->pgd ever have any values other than NULL or init_mm->pgd? I
>> didn't see anything in a quick grep.
> 
> It can also be efi_mm.pgd via sev_es_efi_map_ghcbs_cas().

It would be _nice_ if the ASI exclusion wasn't so magic.

Like, instead of hooking in to __change_page_attr_set_clr() and
filtering on init_mm if we had the callers declare explicitly whether
their changes get reflected into the ASI nonsensitive PGD.

Maybe that looks like a new flag: CPA_DIRECT_MAP or something. Once you
pass that flag in, the cpa code knows that you're working on init_mm.pgd
and mirror_asi_direct_map() can look for *that* instead of init_mm.



