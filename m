Return-Path: <linux-kernel+bounces-811032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2392CB5232A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E90486B83
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85FF2EE26B;
	Wed, 10 Sep 2025 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUmheAyG"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1E1A01BF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538167; cv=none; b=NYGyP/JslWDCNbkUrs8XUNE2DiPnmsZO6hy8QyppZDsz0Y6qmXCpZLphiMghYDfCpcEdT8xxz8qrHoBKGgHWkHuJRhi+4HOg4zttneGJkJdHMhrHVgcvsMR1FOSDTZGad3OU+6qq2xzt7rA0gLojlXVVO8i7p2rxq0vGenOXYAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538167; c=relaxed/simple;
	bh=fMQBK6eRk1HlnNI+n9/QwIf2+NZf77j1GzwLL0pjOeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4S+oWBMIPENjETEbYkTbaitAQSvByRIxPCYEjo/FDmzx6/PTeCbVaDsQSXAt5J+SVWo+qt+4XDW/sOWuI4XsmgtLW3c5wwHRqG1yyaEkDlztm1/OWvTjaJpTruz28genvLnFAKjfA608oZIotPXYPwE4xNNvNvNnAOLnInM1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUmheAyG; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-80e33b9e2d3so686896385a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757538165; x=1758142965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1Cbhy+VanJPMX0Q1u/x/lX5tWRv6IISLLkoD+jnkuQ=;
        b=EUmheAyGonexZeHTjruV40cwAHkPKzuW4v9OZxQY4TZaiCf4e5fGnqProRJGs0L34D
         /zXefCSfZhOWVxfR2QmQHAGrhE2sB+yGSPmuRL+ZcptRIgQAI6+kQCRWGJMjnMZzxGEg
         cDpZySRxp5dWWk+ncrx0sWIrJST6S/Tn42mQnrEIxOmHtBgcbZ1fkqDVx5g1ilJMgl9R
         gXmp9+dKeBMRk+5Uo8jTOYs2mi1EHBUAvwyRn1Td5bCqzH85wlZwdJgc3QKiqi89Njq8
         sbXW8LCEx2cqI5RY9EozExLELsjtYZjef8Ij2mttQwQ7L1E2DmzGSnEm0Uc/Wxnm+TR3
         ve2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757538165; x=1758142965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1Cbhy+VanJPMX0Q1u/x/lX5tWRv6IISLLkoD+jnkuQ=;
        b=gXNM7OOUJzF6XtnwfcaZMaR6o8nFYpLzl4POJC9kIxQYsBetR75yzVNlMLPhUQsaZr
         DNiSGmhLKvaQI2+BEzt6QoYw0P3haFTcDfPuOaX3d1sXId2vGEc0rrbXoOYW6RZIB6nV
         yyVUsz0FM/zwBvF8uQLJbpcHRjIrbU0MX1q+PrcLxBhqdoqHi2hxqRgEb+dlLAYzzFNt
         aL12+wsS5Gl/nm7B8I17nb4IEfBJzxHFZQwZogqBgcfFO2aMU4mLITyLXznGXlbw6eDo
         rjz4woGttEh2EmJ3VBfsSYD7LcfSdig1dpjhs0cxbP5Jw6DU9qgPAX5odcHtBThEUF3P
         ngvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9falK69VOHQoeFPstM3/FUMsCib0cZZvC97Nuzhp5d9oqNlUj/5FTj+PHejCk3hCjVYNsrNflG/eQ2qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTunHWAEIAkcHrOOQCqNk3u5BZu/YA+VLSAVWWB+A4vhUQwp7t
	HKTezWhDuxOXK7Co+yGq7+fSDwKBuDj+RTp1hCpcu0JmRWpRCZ9gVH27
X-Gm-Gg: ASbGncujXADi+Fh8sJg6x4iKIQC1V2ghNnol3jzR1q7wCNxzJOXGUeKY5nLOUo9LXwV
	9+qYsvGYZmxUKlFsIv1E4ntgPzy4kKGjfkwoqbxQtkef0w69eYchVfr1ne5AQojD4mRhH5GXZBO
	/OIRvrwA8lV1UEj61N9ASkb97SyjbSvRgd5hrj2xBvJphfBvIAiGbiz8/vb9tzV61n4DDo54W1L
	Fr8DSQkkwHBk99qCgtUNsyD7dinKaMjBkBTNzZU/3A8bQL17bITb2W49fnWmC/4LM8wDS4DewD6
	HYeFEDU118hQiMdN2h998u/VZE4M396HWpapf+48H2uU44K7qAP7AHKTT7vFxcbwXULwTaqkryJ
	hdSobkQuhZ+LwC4EISaf858fmYKxUn/b540KwCwgSiNvMqaxNKSI=
X-Google-Smtp-Source: AGHT+IHlZ0IDGw1WASa6aDpHNf8Pgci8L2nEiRJ3kUYw3tN88C1KbvhkOPTx9cwxD3yo7KJ59NQSdw==
X-Received: by 2002:a05:620a:a101:b0:817:4e4a:6969 with SMTP id af79cd13be357-8174e68f614mr1358466985a.78.1757538164867;
        Wed, 10 Sep 2025 14:02:44 -0700 (PDT)
Received: from [172.20.7.106] ([63.116.149.204])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5faec7bbsm353446785a.63.2025.09.10.14.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 14:02:44 -0700 (PDT)
Message-ID: <e073e41d-3317-49a9-a2ee-c0e8def66dcd@gmail.com>
Date: Wed, 10 Sep 2025 17:02:37 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
Content-Language: en-GB
To: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, hannes@cmpxchg.org,
 rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
 shakeel.butt@linux.dev, 00107082@163.com, pasha.tatashin@soleen.com,
 souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250909234942.1104356-1-surenb@google.com>
 <ff28f071-f448-4f25-bea0-17db946e0acf@suse.cz>
 <CAJuCfpFf+D1C9esHXpR5WaJ_4=JmvZkYQMWY7KVYf42JLDTFZQ@mail.gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJuCfpFf+D1C9esHXpR5WaJ_4=JmvZkYQMWY7KVYf42JLDTFZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/09/2025 15:50, Suren Baghdasaryan wrote:
> On Tue, Sep 9, 2025 at 11:25 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 9/10/25 01:49, Suren Baghdasaryan wrote:
>>> While rare, memory allocation profiling can contain inaccurate counters
>>> if slab object extension vector allocation fails. That allocation might
>>> succeed later but prior to that, slab allocations that would have used
>>> that object extension vector will not be accounted for. To indicate
>>> incorrect counters, mark them with an asterisk in the /proc/allocinfo
>>> output.
>>> Bump up /proc/allocinfo version to reflect change in the file format.
>>
>> Since it's rare, is it worth the trouble?
> 
> Apparently they are seen in Meta's fleet which instigated this thread:
> https://lore.kernel.org/all/17fab2d6-5a74-4573-bcc3-b75951508f0a@gmail.com/
> 

Yes it happens on memory bound services!

>>
>>> Example output with invalid counters:
>>> allocinfo - version: 2.0
>>>            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
>>>            0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
>>>           0*       0* arch/x86/kernel/alternative.c:127 func:__its_alloc
>>>            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
>>>            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
>>>            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
>>>            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
>>>       49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
>>>        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
>>>            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device
>>>
>>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>>
>> Here a link might have been helpful :)
> 
> Right, here it is and suggestion is in the last paragraph:
> https://lore.kernel.org/all/20250519160846.GA773385@cmpxchg.org/
> 
>>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---

Acked-by: Usama Arif <usamaarif642@gmail.com>

>>> Patch is based on mm-new.
>>>
>>>  include/linux/alloc_tag.h | 12 ++++++++++++
>>>  include/linux/codetag.h   |  5 ++++-
>>>  lib/alloc_tag.c           |  7 +++++--
>>>  mm/slub.c                 |  2 ++
>>>  4 files changed, 23 insertions(+), 3 deletions(-)
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
>>> index e9b33848700a..a7f15117c759 100644
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
>>> @@ -90,7 +90,10 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
>>>       struct alloc_tag_counters counter = alloc_tag_read(tag);
>>>       s64 bytes = counter.bytes;
>>>
>>> -     seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
>>> +     if (unlikely(alloc_tag_is_inaccurate(tag)))
>>> +             seq_buf_printf(out, "%11lli* %7llu* ", bytes, counter.calls);
>>> +     else
>>> +             seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
>>>       codetag_to_text(out, ct);
>>>       seq_buf_putc(out, ' ');
>>>       seq_buf_putc(out, '\n');
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
>>>
>>> base-commit: f4e8f46973fe0c0f579944a37e96ba9efbe00cca
>>


