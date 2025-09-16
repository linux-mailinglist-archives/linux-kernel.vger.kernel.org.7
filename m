Return-Path: <linux-kernel+bounces-819661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F893B5A446
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3045189BCBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CE631FEDF;
	Tue, 16 Sep 2025 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+WSPApj"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744429A33E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059574; cv=none; b=jGE8cyHK5W9xP8J4JqCWL1kbt2DvHZKrPB/JvocKjb/mSm2zVCwLXgzz4wEJiQCdl9sDzc3j0vryuSdpf5mvAltgSWAQ1yO1ouchy2pAfNwaiVymu3O5VnKst6pY+YtWrxd2bEuUxtnPeLN3mfr+oQIVxD1sYKVHzDw1BIY71hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059574; c=relaxed/simple;
	bh=DMj6/hgvW+/ribtKf/NvMgALA1rDNX5Vk9yBNDz70s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtY65n8sxV2OsLUzBG9CsEtDd3LBxVrB6LzAU7r6283du/R08iJqCw5re3ED4N7px1DS7IQYcLyJF18IHTPK8Z9dq0u+BV+oCdQjJQlH+jxpdmpYrpylHjq12yD0tsEcLudpM8cDxc5hzSIf7SMa0hBNjXsyKU2J4TPFL2rDlQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+WSPApj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2f10502fso16545545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758059571; x=1758664371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UiQ3OJfilcOmX87aswW76EUtbko6LYz1SDf94Zf2TEo=;
        b=F+WSPApjrgFv0IHvbBftb6VhpUfieuJZL20kWjd//rPeWwleONVT9dRXLRsLM4eY8f
         +YxDtbbb9YYoOwOG8VnO5uDo3KMwUm93SLjHoYw1tfFodwahsnM/SMAzK1/ZWxBib5Sm
         ILLNJYMQFOHziTUlmGpEx0FNHrFPU9WFL46yGAJUDL0xvNFbUDYQOvrCxfo6Zsxfo5+b
         b2UcyDG1nY3HblQVpRH5KLdgzZeijN71AF1oW/vk7m8lELaf04ZppxtqIh2CecjrD+6R
         T06t/CFl52/XDoFZID+Z5luNI+UI2efwuSS+ajqHGVUvSw5cJY7j2mwFD41yLVquL2Fv
         so+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059571; x=1758664371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UiQ3OJfilcOmX87aswW76EUtbko6LYz1SDf94Zf2TEo=;
        b=ozRIdQJd2qPIRct1bPzVp2JgPaGyKLQlGq2OLOwRkAHrB6Zc/D4pCkwTIxcAeYkGDf
         ALQviEzO+Pu+3e16RhtGrXbYnU/sVyopYPzFb2Y2Uu3uuVJZTkD8KaePWtwLhgtCe2Ib
         XbH9iZPusyqhwSBetjTR+HtM8v1FYYZ7antYmG5lari+ibZHZyAixqHA0h+OdlfEvJd/
         Cr8R39fe/vVdE08Ob6zttFTikiWXqxriGZnafxriiJXJ8gOYoRuRjdPoaKNrQuBxUjjG
         YEVxChHZGNXOuWpln19xn1CeLlfON+ViEwrXnJYNEumciCEKaMuNDbtDwuhxbuJI/m4z
         qmSw==
X-Forwarded-Encrypted: i=1; AJvYcCUMXbfxH5+WU5C/RXfCurf6CBcl2DMQoAjfmgpkvZ9P7fXIAu9VsibVrhkgIMKHEa9SrIjWzxdfQROD+uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gI935U4J1aPy06BOTGCqJAWPuaGanBHIn+k/3bYgscnyy76j
	Va0RdaJIktUwgLOp+a5LuBFG75AtyvN4kEPy81e3q8Hg3AffWzbmOUdh
X-Gm-Gg: ASbGncuk+2osiVb9OQKpHhEXNF1M5f7KvwFt0mBRdPBf+ZjRi0h5NllR6RW0o/8pHlm
	ph5RG90oRGyWBwU3AouqX4KoLSA3ReSfx+fmOzWH1eR11IDt9Vex+v8EKSjS7V+BjybPGUTQNqH
	fRHKoplVLmeB7YYRARF5wYq3XpklTADR5lvaKOweRoiMBvB3sRSa0n6iXPsh58MU3we4wvCdrbD
	GRX3HbIOVcyO7kMVhrXJdeunFmBzpqDADEM/OnLzUcfhEy6qmidgXjgI0A2KJ4BmVprHXrE+P/v
	Xnxx9iEXkWoEFgnN54+c5HpKKfycTFVI/t/1JMyOvUuJJZ/FjkVQ6j9vTvOaio2hT8oGxL4Qpg2
	KUT6ZipPutwwtkZHBG48we0XY17K9r8ZTT+as2PIv/PHlZcJmixfQYCJ6gkOsogD9mhznUk27dv
	Y/MMvcC2rfDd3O+Ggxrg==
X-Google-Smtp-Source: AGHT+IGhJXnMcHzLmeBfVYy84asxwzry7go5nv0En7vIcIJAS7k4xugn3PkxnQbwxosW/2KARZKAag==
X-Received: by 2002:a05:6000:4021:b0:3ce:f0a5:d594 with SMTP id ffacd0b85a97d-3e76578f304mr18235883f8f.13.1758059571129;
        Tue, 16 Sep 2025 14:52:51 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23? ([2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f321032a1sm27412195e9.2.2025.09.16.14.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 14:52:50 -0700 (PDT)
Message-ID: <e5e3d96a-d0aa-4466-8303-5a7e8f96bbe5@gmail.com>
Date: Tue, 16 Sep 2025 22:52:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
Content-Language: en-GB
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
 kent.overstreet@linux.dev, hannes@cmpxchg.org, rientjes@google.com,
 roman.gushchin@linux.dev, harry.yoo@oracle.com, shakeel.butt@linux.dev,
 00107082@163.com, pyyjason@gmail.com, pasha.tatashin@soleen.com,
 souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250915230224.4115531-1-surenb@google.com>
 <2d8eb571-6d76-4a9e-8d08-0da251a73f33@suse.cz>
 <CAJuCfpHXAhGZb1aOPyHOPiTWSwQJi570THqJQcjrVPf=4Dt3xQ@mail.gmail.com>
 <a8519bca-ae16-4642-84a1-4038b12e8bb0@gmail.com>
 <CAJuCfpFJabb02OK8Rj08d7WU_7AM674i=vsZxzfw7i7h-PGftQ@mail.gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJuCfpFJabb02OK8Rj08d7WU_7AM674i=vsZxzfw7i7h-PGftQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 16/09/2025 22:46, Suren Baghdasaryan wrote:
> On Tue, Sep 16, 2025 at 2:11 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 16/09/2025 16:51, Suren Baghdasaryan wrote:
>>> On Tue, Sep 16, 2025 at 5:57 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>
>>>> On 9/16/25 01:02, Suren Baghdasaryan wrote:
>>>>> While rare, memory allocation profiling can contain inaccurate counters
>>>>> if slab object extension vector allocation fails. That allocation might
>>>>> succeed later but prior to that, slab allocations that would have used
>>>>> that object extension vector will not be accounted for. To indicate
>>>>> incorrect counters, "accurate:no" marker is appended to the call site
>>>>> line in the /proc/allocinfo output.
>>>>> Bump up /proc/allocinfo version to reflect the change in the file format
>>>>> and update documentation.
>>>>>
>>>>> Example output with invalid counters:
>>>>> allocinfo - version: 2.0
>>>>>            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
>>>>>            0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
>>>>>            0        0 arch/x86/kernel/alternative.c:127 func:__its_alloc accurate:no
>>>>>            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
>>>>>            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
>>>>>            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
>>>>>            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
>>>>>        49152       48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create accurate:no
>>>>>        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
>>>>>            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device
>>>>>
>>>>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>> Acked-by: Usama Arif <usamaarif642@gmail.com>
>>>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>>>
>>>> With this format you could instead print the accumulated size of allocations
>>>> that could not allocate their objext (for the given tag). It should be then
>>>> an upper bound of the actual error, because obviously we cannot recognize
>>>> moments where these allocations are freed - so we don't know for which tag
>>>> to decrement. Maybe it could be more useful output than the yes/no
>>>> information, although of course require more storage in struct codetag, so I
>>>> don't know if it's worth it.
>>>
>>> Yeah, I'm reluctant to add more fields to the codetag and increase the
>>> overhead until we have a usecases. If that happens and with the new
>>> format we can add something like error_size:<value> to indicate the
>>> amount of the error.
>>>
>>>>
>>>> Maybe a global counter of sum size for all these missed objexts could be
>>>> also maintained, and that wouldn't be an upper bound but an actual current
>>>> error, that is if we can precisely determine that when freeing an object, we
>>>> don't have a tag to decrement because objext allocation had failed on it and
>>>> thus that allocation had incremented this global error counter and it's
>>>> correct to decrement it.
>>>
>>> That's a good idea and should be doable without too much overhead. Thanks!
>>> For the UAPI... I think for this case IOCTL would work and the use
>>> scenario would be that the user sees the "accurate:no" mark and issues
>>> ioctl command to retrieve this global counter value.
>>> Usama, since you initiated this feature request, do you think such a
>>> counter would be useful?
>>>
>>
>>
>> hmm, I really dont like suggesting changing /proc/allocinfo as it will break parsers,
>> but it might be better to put it there?
>> If the value is in the file, I imagine people will be more prone to looking at it?
>> I am not completely sure if everyone will do an ioctl to try and find this out?
>> Especially if you just have infra that is just automatically collecting info from
>> this file.
> 
> The current file reports per-codetag data and not global counters. We
> could report it somewhere in the header but the first question to
> answer is: would this be really useful (not in a way of  "nice to
> have" but for a concrete usecase)? If not then I would suggest keeping
> things simple until there is a need for it.
> 

I think its a nice to have. I can't think of a concrete usecase at present.

I guess a potential usecase is if you are trying to use memory allocation
profiling to debug OOMs and the missed objects size is very large. I guess we
wont know until this happens, but I would hope this number is usually small. 


