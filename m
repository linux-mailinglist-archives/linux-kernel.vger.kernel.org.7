Return-Path: <linux-kernel+bounces-819617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA37B5A3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5523189388F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5778B289E16;
	Tue, 16 Sep 2025 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixZAgSNW"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701EE260575
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057093; cv=none; b=bg+Xj4A3u8Nu4jDJszZ1TnNIOZvXcsQS/fNQKTLqAPHNcIzBlDLomvPRU635tkytfnaGBxOe48asru8wlm8umB33bJ0Q7bJ5GFySRi3D5iNe9cyL4i8le4eK9lagt3DZszaGBtxeafhBXdNARXOtqumZY784rdmZMaaGQnO5hk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057093; c=relaxed/simple;
	bh=SVrvUrTflh6kNI7kHFkWQhtLvupTkdEN2v3gad7rUOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCijjwlKD9J5D36CRNP0mbVY6rzbe4YOqrZLFyze+GSpeUPgyY4BhWqEHvwjAp9czgxLBUo8FmZUTht/GpaDqQImhPDuFMDJd9whgCZT5NugMeisuY4NH2z7kIY8HTVRLkix0OV7vznC1nhervCnzqTGtZGgLN/m/lxxu21nt6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixZAgSNW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e98c5adbbeso1534127f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758057090; x=1758661890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtDJfjQiYsrnTHsWR0+0nQzBkXZjKOyy+WheYP6UDhg=;
        b=ixZAgSNWYDgSBIrn5UU2kqkmPlkdpJndkAGAtNvoDYvKmVYniE2KXCop2exr6kCSUA
         u8ANKjP4bdLDNHCtDnEnhIFRDBARbgDBcvFIhFPfAuPqv8ld56Leve3xDCS3+3yFnWNn
         z1lctKgx4KYtOfsujmn+OifhL9D6wFX2CkwG+tFU0jDZ6O7YadC6UQwZqqdIKc49y7LX
         DGP4UOdTuQr0MRG1q5Qw+BL22qurPiLy6vMjO73AbPfp5wOFmMkkub5Nxalp3savkxMw
         wVBfG51HAbLjA4moPe1zot/vSvOseNVycrrvDUm0FyXT8yv+XG9D4uK2ejlwhoZ7WfMC
         bwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758057090; x=1758661890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtDJfjQiYsrnTHsWR0+0nQzBkXZjKOyy+WheYP6UDhg=;
        b=AvKP9z179Z/9c0d76MqX2y3KB1NW0HqWI2DqK8sC8GLRoaUIE/lFvFy0PLMK3y4T5A
         hV8cPbsioFHlj0mJ+ZP8w2trn3nq+91VbN8Tsp8KqXnRGmgk69h4NUHbBFQ1ORZEYHYM
         UJnuN7uwQqAnYj94tJ0Tx4HMMob/W083xGJzEV5TD9bBfQ9l27b/iTyivSv8PAQiezTO
         7sHxGNwgFEzoHuOyyRxEQENj1um/Nq7xz/tauZLINt6QBzXxSW6Cod+xpRkyQXtzYaNV
         Bb/w/BqnEmE1++iHx/CHfY2D2WFRwKCqSE9uDhrXdOlZpTv6HyHi1EpXEQmbnrulm8LF
         7c0g==
X-Forwarded-Encrypted: i=1; AJvYcCVnjZ5PHukRYTsxnQTLrjqRBC1cLwx8qOcDdB4gNa9n3E0gxidCkSOVLNKXUhgjZQRvlMf7BeMwJJX3emU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTk2yDM94OMw4Yhfea6AZbtqty98BJeD4Vat6lAkHcPxpfoNCJ
	cIuzARziUDrDHn/Zh1Kjhx/VqnmUD0r9CDAT+Oon1t3/kbSMYdpGQk1P
X-Gm-Gg: ASbGncu3yHaZVwYlQTTLzIyGe1nyfI8x4vZ7oyP5xUw9UL1MgACETy5Mg6xo9XIgulA
	38KC5kzlzc6jNA7mlQdjajI2tyukehNZ/fIjrX5U/dMqsk2cGiJ+0Myh68AuJIXf7jXpR/Ml6/1
	PytsjRNTVR/7drulV/+Y9EuC13krUUvCpCQg2sNWTbgC2RCruoBPyTtOarLKdvFL2TC92WfxEDK
	EIUasAu1z5KKZYV+1XvJphfjYPQ0kSqRC0TdaBoPoevjqJqvra2T7Yj5wVpi/0b2jytz983fg0/
	fFoHKP1G0rFz+QIDFZPu6v1VMNb8Qpe5Zqntr3JTKhu7xjedBBVkSVekhfecYjrZRDykZvvlk3l
	4tMBm90k+VTT3VdrWClYenzJNNTttyqp7DEw3tiXM1ANKHom1shC5Bw0mSW+N9s0/AGEQKvmjyi
	zawhEILzWOwOboVn3Xfg==
X-Google-Smtp-Source: AGHT+IGWzzxWWQNqBAnxTryYw1NnlFT90s6alDAM47xpOX2EwWsri1rCI5Ayd3E8HPgQkVOwyM3zng==
X-Received: by 2002:a05:6000:24c7:b0:3e0:c28a:abbb with SMTP id ffacd0b85a97d-3e765594a59mr17596887f8f.13.1758057089497;
        Tue, 16 Sep 2025 14:11:29 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23? ([2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e900d8f0e9sm14410982f8f.35.2025.09.16.14.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 14:11:27 -0700 (PDT)
Message-ID: <a8519bca-ae16-4642-84a1-4038b12e8bb0@gmail.com>
Date: Tue, 16 Sep 2025 22:11:27 +0100
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
To: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, hannes@cmpxchg.org,
 rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
 shakeel.butt@linux.dev, 00107082@163.com, pyyjason@gmail.com,
 pasha.tatashin@soleen.com, souravpanda@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250915230224.4115531-1-surenb@google.com>
 <2d8eb571-6d76-4a9e-8d08-0da251a73f33@suse.cz>
 <CAJuCfpHXAhGZb1aOPyHOPiTWSwQJi570THqJQcjrVPf=4Dt3xQ@mail.gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJuCfpHXAhGZb1aOPyHOPiTWSwQJi570THqJQcjrVPf=4Dt3xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 16/09/2025 16:51, Suren Baghdasaryan wrote:
> On Tue, Sep 16, 2025 at 5:57 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 9/16/25 01:02, Suren Baghdasaryan wrote:
>>> While rare, memory allocation profiling can contain inaccurate counters
>>> if slab object extension vector allocation fails. That allocation might
>>> succeed later but prior to that, slab allocations that would have used
>>> that object extension vector will not be accounted for. To indicate
>>> incorrect counters, "accurate:no" marker is appended to the call site
>>> line in the /proc/allocinfo output.
>>> Bump up /proc/allocinfo version to reflect the change in the file format
>>> and update documentation.
>>>
>>> Example output with invalid counters:
>>> allocinfo - version: 2.0
>>>            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
>>>            0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
>>>            0        0 arch/x86/kernel/alternative.c:127 func:__its_alloc accurate:no
>>>            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
>>>            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
>>>            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
>>>            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
>>>        49152       48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create accurate:no
>>>        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
>>>            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device
>>>
>>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>>> Acked-by: Usama Arif <usamaarif642@gmail.com>
>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>
>> With this format you could instead print the accumulated size of allocations
>> that could not allocate their objext (for the given tag). It should be then
>> an upper bound of the actual error, because obviously we cannot recognize
>> moments where these allocations are freed - so we don't know for which tag
>> to decrement. Maybe it could be more useful output than the yes/no
>> information, although of course require more storage in struct codetag, so I
>> don't know if it's worth it.
> 
> Yeah, I'm reluctant to add more fields to the codetag and increase the
> overhead until we have a usecases. If that happens and with the new
> format we can add something like error_size:<value> to indicate the
> amount of the error.
> 
>>
>> Maybe a global counter of sum size for all these missed objexts could be
>> also maintained, and that wouldn't be an upper bound but an actual current
>> error, that is if we can precisely determine that when freeing an object, we
>> don't have a tag to decrement because objext allocation had failed on it and
>> thus that allocation had incremented this global error counter and it's
>> correct to decrement it.
> 
> That's a good idea and should be doable without too much overhead. Thanks!
> For the UAPI... I think for this case IOCTL would work and the use
> scenario would be that the user sees the "accurate:no" mark and issues
> ioctl command to retrieve this global counter value.
> Usama, since you initiated this feature request, do you think such a
> counter would be useful?
> 


hmm, I really dont like suggesting changing /proc/allocinfo as it will break parsers,
but it might be better to put it there?
If the value is in the file, I imagine people will be more prone to looking at it?
I am not completely sure if everyone will do an ioctl to try and find this out?
Especially if you just have infra that is just automatically collecting info from
this file.

>>
>>> ---
>>> Changes since v1[1]:
>>> - Changed the marker from asterisk to accurate:no pair, per Andrew Morton
>>> - Documented /proc/allocinfo v2 format
>>> - Update the changelog
>>> - Added Acked-by from v2 since the functionality is the same,
>>> per Shakeel Butt, Usama Arif and Johannes Weiner
>>>
>>> [1] https://lore.kernel.org/all/20250909234942.1104356-1-surenb@google.com/
>>>
>>>  Documentation/filesystems/proc.rst |  4 ++++
>>>  include/linux/alloc_tag.h          | 12 ++++++++++++
>>>  include/linux/codetag.h            |  5 ++++-
>>>  lib/alloc_tag.c                    |  4 +++-
>>>  mm/slub.c                          |  2 ++
>>>  5 files changed, 25 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
>>> index 915a3e44bc12..1776a06571c2 100644
>>> --- a/Documentation/filesystems/proc.rst
>>> +++ b/Documentation/filesystems/proc.rst
>>> @@ -1009,6 +1009,10 @@ number, module (if originates from a loadable module) and the function calling
>>>  the allocation. The number of bytes allocated and number of calls at each
>>>  location are reported. The first line indicates the version of the file, the
>>>  second line is the header listing fields in the file.
>>> +If file version is 2.0 or higher then each line may contain additional
>>> +<key>:<value> pairs representing extra information about the call site.
>>> +For example if the counters are not accurate, the line will be appended with
>>> +"accurate:no" pair.
>>>
>>>  Example output.
>>>
>>> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
>>> index 9ef2633e2c08..d40ac39bfbe8 100644
>>> --- a/include/linux/alloc_tag.h
>>> +++ b/include/linux/alloc_tag.h
>>> @@ -221,6 +221,16 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
>>>       ref->ct = NULL;
>>>  }
>>>
>>> +static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
>>> +{
>>> +     tag->ct.flags |= CODETAG_FLAG_INACCURATE;
>>> +}
>>> +
>>> +static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
>>> +{
>>> +     return !!(tag->ct.flags & CODETAG_FLAG_INACCURATE);
>>> +}
>>> +
>>>  #define alloc_tag_record(p)  ((p) = current->alloc_tag)
>>>
>>>  #else /* CONFIG_MEM_ALLOC_PROFILING */
>>> @@ -230,6 +240,8 @@ static inline bool mem_alloc_profiling_enabled(void) { return false; }
>>>  static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
>>>                                size_t bytes) {}
>>>  static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
>>> +static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag) {}
>>> +static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag) { return false; }
>>>  #define alloc_tag_record(p)  do {} while (0)
>>>
>>>  #endif /* CONFIG_MEM_ALLOC_PROFILING */
>>> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
>>> index 457ed8fd3214..8ea2a5f7c98a 100644
>>> --- a/include/linux/codetag.h
>>> +++ b/include/linux/codetag.h
>>> @@ -16,13 +16,16 @@ struct module;
>>>  #define CODETAG_SECTION_START_PREFIX "__start_"
>>>  #define CODETAG_SECTION_STOP_PREFIX  "__stop_"
>>>
>>> +/* codetag flags */
>>> +#define CODETAG_FLAG_INACCURATE      (1 << 0)
>>> +
>>>  /*
>>>   * An instance of this structure is created in a special ELF section at every
>>>   * code location being tagged.  At runtime, the special section is treated as
>>>   * an array of these.
>>>   */
>>>  struct codetag {
>>> -     unsigned int flags; /* used in later patches */
>>> +     unsigned int flags;
>>>       unsigned int lineno;
>>>       const char *modname;
>>>       const char *function;
>>> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
>>> index 79891528e7b6..12ff80bbbd22 100644
>>> --- a/lib/alloc_tag.c
>>> +++ b/lib/alloc_tag.c
>>> @@ -80,7 +80,7 @@ static void allocinfo_stop(struct seq_file *m, void *arg)
>>>  static void print_allocinfo_header(struct seq_buf *buf)
>>>  {
>>>       /* Output format version, so we can change it. */
>>> -     seq_buf_printf(buf, "allocinfo - version: 1.0\n");
>>> +     seq_buf_printf(buf, "allocinfo - version: 2.0\n");
>>>       seq_buf_printf(buf, "#     <size>  <calls> <tag info>\n");
>>>  }
>>>
>>> @@ -92,6 +92,8 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
>>>
>>>       seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
>>>       codetag_to_text(out, ct);
>>> +     if (unlikely(alloc_tag_is_inaccurate(tag)))
>>> +             seq_buf_printf(out, " accurate:no");
>>>       seq_buf_putc(out, ' ');
>>>       seq_buf_putc(out, '\n');
>>>  }
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index af343ca570b5..9c04f29ee8de 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -2143,6 +2143,8 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
>>>        */
>>>       if (likely(obj_exts))
>>>               alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
>>> +     else
>>> +             alloc_tag_set_inaccurate(current->alloc_tag);
>>>  }
>>>
>>>  static inline void
>>


