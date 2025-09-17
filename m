Return-Path: <linux-kernel+bounces-821661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC00FB81E51
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEEC1C21A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC2D2F5A0B;
	Wed, 17 Sep 2025 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9Pn6vzK"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B688F27A927
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143402; cv=none; b=DiX3+QQAsFaF/SwG7WeSghm6FEu8zVdh8x9YHatMjuz6sFdNbBz5rH8gWyh+pqlm6uGL3gjy/tDNiJM46k6vklRSgBmadmrQopHar2ibrevPrqKYREDqpVDfYfaUzw/SmY+861eSk/kyd77oN0GMfNHGO05VuD1uVeFVg3RyIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143402; c=relaxed/simple;
	bh=avNKyzp8nxuiNbeGn/bf/gxnWM6kjcUCXW7Av4V6Jm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASusTVT8k0kfKGS40KSiaOH2MZ8KV82oyxasPjATmsfTk/DyrzptHfHo7PGR50sZdBWXbNlasN5o+mYTKoX+0KWwQ4zGCZU4Uv8hAJ+RQ0AKHInzKNSJ5OfdMAYNxPD8Tu0JOP+PsD1L297iBnZttPYs9kDzYjrQHjUoMT+GxEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9Pn6vzK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso2432945e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758143399; x=1758748199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKnemSHyXhT2vgBMl2/3OYWo/7PODj4kOYVIAoQ2M2M=;
        b=X9Pn6vzKHk7nKhj+H2laewUeA/pNKcL51dEmCDJUy9Qzmz8gO13+qu9m+CRtCSSCq7
         /4YjZci5M6YSw20+UiCt0R0w+r9Q06XE9mTCuqJsi4LpMWYQOYlhwwpxvrHQXH0naaVG
         6nchdLfQZEK8uGd1+A3jT1c8Vjr+kmx5vx/z8mYUqVuadSzMVEuzWhaujHFzDaHiXAkU
         tqm8z1rjcg6y2WezPu/QaWCc7ACU3GcfoMM0JPQe8TxgDFMhLuhE8cXhtP72mEGz1gMr
         jxUet4XlGOIyXJrfhaVg5tm36xmcAu/e1pGgd+67PztDhMSJnLu3uRJ+Lwon84ZrHpzB
         AThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758143399; x=1758748199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKnemSHyXhT2vgBMl2/3OYWo/7PODj4kOYVIAoQ2M2M=;
        b=Snjjmh7migyR585M3i3w71/wf1+zdnxys8Nyu3UdfAQMZ6RhTLY0THuC3pkAvQxdV/
         eEshSh+P/zuPZPNb1cPzW/1g9KeVarzYKNcG0y3vH1qPxTSiJ7bcvCawDiRzmFc9NffV
         nXEHLL/bf+u5EqDyWeEX6fZR58XszCEczzs6nUhLnY0vtbSqkFOd0pT0R9aBaZ/Ox3eX
         U5AK+t2EfNRlNZs3M+5xRaksofOivzCfLD+w87vl6hMknNHEg0iHosALNYT40IwApK43
         QOcib4yjXBPKJGVjx/EDilIwccaaFdyb60LSlqubdW90ur5XO4Cvw42CoOVGeCl5xCHX
         o9HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe+mjOGeFz9yWetVvjITo/1hdwpdUSrnksx9gwDKkkoVYm73X7DebPyZ3Sx5Y/BAMtXaX2nbfavL19poM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5OJocdR0ilIEVgswVAaOw5NAwylbgd7FTTzXcdyoK8YF7C1tM
	fa7XI/gCfUMU4TgYVkHOr5mRW/cMKHmO0vX2EfA5yrqQNm1mZI+Y/ppB
X-Gm-Gg: ASbGncv/3/yqJvdveY9Pjo2jiiFRmz3KoGhBItKGEC/WwNLqlfzrW0TcPMFBtswXuov
	Ahqw9RixoKbN7eIIMq79DBMtfWzBZZo6qwzuok4pAdMsgNDanQomja8EUZo5lSd8Y4YHq7zillQ
	vvTr7eHmvOL8rq0sBymsi2NmNX7CtJCSbCbPeq+GFz+twFVqOvXpO+tycQTKo9G60t84x5lMCyT
	yTCZ1BzwlMWbGMdUI3Ox1E+WATZjOQ+AwIM+T2pCRef9g0+5DbDz/JKRBVIf95hA9Qjc9os2bT5
	5a/W6mW1nj0wDaVuD4thbA8NNRnUzh3D0UWde+Hhz6OcaE8hs5hEbRQsu8o+JvHzBYmuSXIuqZL
	79CSpKWLM/qHtP1P+pr/hH4hyor7ai+Fqv1vjbcBrQdcdQu7zD4VJY6/LFtyEXdhJpRjnl9i0cX
	4Ia48gw+LLdQcyERVunm7hQhjT+zhs/sefSSSeyTogksKU+mM=
X-Google-Smtp-Source: AGHT+IHlVi0gbe1N0WWmvWmbviaim/Zxtf5abTYTF1UBjO3o2Fe2t3ZAzU7OG9ox7Dk+WqbVrxkwig==
X-Received: by 2002:a05:600c:198c:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-46206b20089mr30116355e9.29.1758143398813;
        Wed, 17 Sep 2025 14:09:58 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23? ([2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7410sm760713f8f.35.2025.09.17.14.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 14:09:58 -0700 (PDT)
Message-ID: <d451dce9-2217-4351-bc53-09967fa86cca@gmail.com>
Date: Wed, 17 Sep 2025 22:09:57 +0100
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
 <e5e3d96a-d0aa-4466-8303-5a7e8f96bbe5@gmail.com>
 <CAJuCfpEULVxMixDjrk_xg7+3+97dkcMmkDd++BaR17X4tDSs6Q@mail.gmail.com>
 <CAJuCfpGgVa9X7nXhqOUZWi+p+JGz1QofiXrTJ+BF=DU3m2-64w@mail.gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJuCfpGgVa9X7nXhqOUZWi+p+JGz1QofiXrTJ+BF=DU3m2-64w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 16/09/2025 23:27, Suren Baghdasaryan wrote:
> On Tue, Sep 16, 2025 at 10:26 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Tue, Sep 16, 2025 at 9:52 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>>
>>>
>>> On 16/09/2025 22:46, Suren Baghdasaryan wrote:
>>>> On Tue, Sep 16, 2025 at 2:11 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 16/09/2025 16:51, Suren Baghdasaryan wrote:
>>>>>> On Tue, Sep 16, 2025 at 5:57 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>>>>
>>>>>>> On 9/16/25 01:02, Suren Baghdasaryan wrote:
>>>>>>>> While rare, memory allocation profiling can contain inaccurate counters
>>>>>>>> if slab object extension vector allocation fails. That allocation might
>>>>>>>> succeed later but prior to that, slab allocations that would have used
>>>>>>>> that object extension vector will not be accounted for. To indicate
>>>>>>>> incorrect counters, "accurate:no" marker is appended to the call site
>>>>>>>> line in the /proc/allocinfo output.
>>>>>>>> Bump up /proc/allocinfo version to reflect the change in the file format
>>>>>>>> and update documentation.
>>>>>>>>
>>>>>>>> Example output with invalid counters:
>>>>>>>> allocinfo - version: 2.0
>>>>>>>>            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
>>>>>>>>            0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
>>>>>>>>            0        0 arch/x86/kernel/alternative.c:127 func:__its_alloc accurate:no
>>>>>>>>            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
>>>>>>>>            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
>>>>>>>>            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
>>>>>>>>            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
>>>>>>>>        49152       48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create accurate:no
>>>>>>>>        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
>>>>>>>>            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device
>>>>>>>>
>>>>>>>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>>>>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>>>>>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>>>>> Acked-by: Usama Arif <usamaarif642@gmail.com>
>>>>>>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>>>>>>
>>>>>>> With this format you could instead print the accumulated size of allocations
>>>>>>> that could not allocate their objext (for the given tag). It should be then
>>>>>>> an upper bound of the actual error, because obviously we cannot recognize
>>>>>>> moments where these allocations are freed - so we don't know for which tag
>>>>>>> to decrement. Maybe it could be more useful output than the yes/no
>>>>>>> information, although of course require more storage in struct codetag, so I
>>>>>>> don't know if it's worth it.
>>>>>>
>>>>>> Yeah, I'm reluctant to add more fields to the codetag and increase the
>>>>>> overhead until we have a usecases. If that happens and with the new
>>>>>> format we can add something like error_size:<value> to indicate the
>>>>>> amount of the error.
>>>>>>
>>>>>>>
>>>>>>> Maybe a global counter of sum size for all these missed objexts could be
>>>>>>> also maintained, and that wouldn't be an upper bound but an actual current
>>>>>>> error, that is if we can precisely determine that when freeing an object, we
>>>>>>> don't have a tag to decrement because objext allocation had failed on it and
>>>>>>> thus that allocation had incremented this global error counter and it's
>>>>>>> correct to decrement it.
>>>>>>
>>>>>> That's a good idea and should be doable without too much overhead. Thanks!
>>>>>> For the UAPI... I think for this case IOCTL would work and the use
>>>>>> scenario would be that the user sees the "accurate:no" mark and issues
>>>>>> ioctl command to retrieve this global counter value.
>>>>>> Usama, since you initiated this feature request, do you think such a
>>>>>> counter would be useful?
>>>>>>
>>>>>
>>>>>
>>>>> hmm, I really dont like suggesting changing /proc/allocinfo as it will break parsers,
>>>>> but it might be better to put it there?
>>>>> If the value is in the file, I imagine people will be more prone to looking at it?
>>>>> I am not completely sure if everyone will do an ioctl to try and find this out?
>>>>> Especially if you just have infra that is just automatically collecting info from
>>>>> this file.
>>>>
>>>> The current file reports per-codetag data and not global counters. We
>>>> could report it somewhere in the header but the first question to
>>>> answer is: would this be really useful (not in a way of  "nice to
>>>> have" but for a concrete usecase)? If not then I would suggest keeping
>>>> things simple until there is a need for it.
>>>>
>>>
>>> I think its a nice to have. I can't think of a concrete usecase at present.
>>>
>>> I guess a potential usecase is if you are trying to use memory allocation
>>> profiling to debug OOMs and the missed objects size is very large. I guess we
>>> wont know until this happens, but I would hope this number is usually small.
>>
>> Hmm. Missing a large allocation and not knowing about it can be a problem...
>> I'll start sketching a patch to see if tracking such a global counter
>> has any drawbacks and in the meantime I'm open to suggestions on how
>> to expose it to the userspace.
>>
>> About concerns on the IOCTL interface, would it be more usable if we
>> get the alloctop [1] or a similar tool which can be used to easily
>> issue such commands into kernel/tools?
>>
>> [1] https://android-review.git.corp.google.com/c/platform/system/memory/libmeminfo/+/3431860
> 
> Ugh, sorry. Externally accesible link would be
> https://android-review.googlesource.com/c/platform/system/memory/libmeminfo/+/3431860
> 

Yeah this would be nice to have. We do have something very similar in our infra, to basically
sort by size and store only top x entries.

When doing manually, I just do sort -g /proc/allocinfo|tail -n 30|numfmt --to=iec which is copied from
the kernel doc.

