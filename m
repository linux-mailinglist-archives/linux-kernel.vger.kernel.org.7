Return-Path: <linux-kernel+bounces-830744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC06B9A711
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535193A5110
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF1B3093BF;
	Wed, 24 Sep 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKUbLzww"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1773F309F07
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726011; cv=none; b=BigNNJ3K6cKhDod5MpawLSJiArfteubZJdsSPpPzuj7Lp7wXqypWhspR0K5ph2VPXXa3DEL9zyGFDpARyRHfUHfntCDmbR0MPwBkMlbOXtLk1UUrtHT/x5JCYuc8t8sVpeDy6bMDl/CYgEqMnZmPsAoSx9xgVkp8BCLo6owGOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726011; c=relaxed/simple;
	bh=AsqQ4X85WS4twpg8jxPX55Rh1ZNTmckZyPofl8c3byg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rq1blgh1iK+R0j7JxtKEM5UQEXrLl22Qz7QpSF+1CTtzZnM/tW8rFQ/wOJdrDRwwmpb3OjbGtsDJubloEu2KwxS8ZldrcbKtZyhTmTrIVpqg/wReGetO73uLnsk1tRBI6FLB5y1UGk7L0Kqmruuo4haLztJVl1mGeB7X0wcRts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKUbLzww; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e23a66122so11665315e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726007; x=1759330807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=927/lHF2vNu0XxZ1FGlpxq1I27djjd2ax6gbW3uqrWQ=;
        b=bKUbLzwwRgtgcjmyEAxHTguDUAniB/kdPkmXBwSdF7FBcOcZyjFUsI2xImo5y3YuAl
         RgIJ8jiwVfNT4luYzgJYimhxSgG2KLJgWdxDI1lewxsK7bMc5RQA0MalYg+19p51MF1F
         CkhTg5ZyP5BjAAlcCH9BSaQB2CVpnpeCJsJk/vEisLzs/5QxsfNHAHJ3NGHPo4uWT2OP
         AFOE9OZKH97jg38RZt0y3xKLD5aU+mH1MVXNFC8f1Unkthf3xE6b5uW1zXBOtQkwEZLe
         rI5JPtkNBbCxP6ZyNSBhaCmYG6eLopUaRJ+L/lTfLPj4eW4J7JjbgESKbP6lqzU/Xq41
         SJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726007; x=1759330807;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=927/lHF2vNu0XxZ1FGlpxq1I27djjd2ax6gbW3uqrWQ=;
        b=NFWSjPhvUf4IgSnrG3NBPanZrIjS+vMa87LirNhC0im9Vk3skxjJ+0eUgLzs/iT/nl
         GM3NiNjNNZE3wdVrvA924V3ZLE+tbsYkSbyAtIoJA45FDXDdQWCZ0F7VZlp9POYwCiHb
         1+GOHMIuChxfmpsUb0yRKXphuGcbP2vOKNslA+KP3vZe3C0AlvHqth9Q2L+313i+kYe9
         VfRG7HW0xIZejawD/BMXSYELmMJ/yNPLtX9AzKY6c+wf4JIVSz4pahH91YEE03sSkTkd
         L8GAUP49nTQEbLD4qvJ6gGhQ82POAaxu9BInUmyU381a87jlWXhjGn9PZOUnUkOCPBck
         tsug==
X-Forwarded-Encrypted: i=1; AJvYcCXG3lHCfMhQveQQXRex1OPRyIocHAn4J5sXLxDMbFb6z+ZXtsL/BXRe+mq1iJKbmwU+HeYsAxqPH/Vj3g4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdz+8lKdWYu3YbN2LNivNUjpiXtSMqJLI1oBCK0x/jHOEFEUwp
	K5KwfFYiUvhvhGedPcjbe4ayhUUDYaKtmX6qxkGWzB6xTGpru0uzOkddp9Vv2g1a4Z30Bnkvzfn
	RVbQaimyKEE8mJQ==
X-Google-Smtp-Source: AGHT+IHBYuTfCDyMl4IXnL9KHYj5g7KpkNQnHbq4nxEziZs+xO/jJjkNAvzvrh9akC6IylkUFnRqISJyOAfYRg==
X-Received: from wrbfm4.prod.google.com ([2002:a05:6000:2804:b0:3ec:dc85:55e8])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:61e:b0:408:ffd8:2742 with SMTP id ffacd0b85a97d-40e4adc167fmr240695f8f.33.1758726005002;
 Wed, 24 Sep 2025 08:00:05 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFgH1GgC/x2MQQqAIBAAvxJ7bqG0sPpKdNhsrYXQUIhA+nvSc
 RhmMiSOwgmmKkPkW5IEX6CtK7AH+Z1RtsKgGtU3o9K4dkhJ8KKi6DyDRdOtvR40GeUslO6K7OT 5n/Pyvh+w7EPGYwAAAA==
X-Change-Id: 20250923-b4-asi-page-alloc-74b5383a72fc
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Subject: [PATCH 00/21] mm: ASI direct map management
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
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
Content-Type: text/plain; charset="utf-8"

As per [0] I think ASI is ready to start merging. This is the first
step. The scope of this series is: everything needed to set up the
direct map in the restricted address spaces.

.:: Scope

Why is this the scope of the first series? The objective here is to
reach a MVP of ASI that people can actually run, as soon as possible.
Very broadly, this requires a) a restricted address space to exist and
b) a bunch of logic for transitioning in and out of it. An MVP of
ASI doesn't require too much flexibility w.r.t. the contents of the
restricted address space, but at least being able to omit user data from
the direct map seems like a good starting point. The rest of the address
space can be constructed trivially by just cloning the unrestricted
address space as illustrated in [1] (a commit from the branch published
in [0]), but that isn't included in this series, this is just for the
direct map.

So this series focuses on part a). The alternative would be to focus on
part b) first, instead just trivially creating the entire restricted
address space as a clone of the unrestricted one (i.e. starting from an
ASI that protects nothing).

.:: Design

Whether or not memory will be mapped into the restricted address space
("sensitivity") is determined at allocation time. This is encoded in a
new GFP flag called __GFP_SENSITIVE, which is added to GFP_USER. Some
early discussions questioned whether this GFP flag is really needed or
if we could instead determine sensitivity by some contextual hint. I'm
not aware of something that could provide this hint at the moment, but
if one exists I'd be happy to use it here. However, in the long term
it should be assumed that a GFP flag will need to appear eventually,
since we'll need to be able to annotate the sensitivity of pretty much
arbitrary memory.

So, the important thing we end up needing to design here is what
the allocator does with __GFP_SENSITIVE. This was discussed in [2] and
at LSF/MM/BPF 2024 [3]. The allocator needs to be able to map and unmap
pages into the restricted address space. Problems with this are:

1. Changing mappings might require allocating pagetables (allocating
   while allocating).

2. Unmapping pages requires a TLB shootdown, which is slow and anyway
   can't be done with IRQs off.

3. Mapping pages into the restricted address space, in the general case,
   requires zeroing them in case they contain leftover data that was
   previously sensitive.

The simple solution for point 1 is to just set a minimum granularity at
which sensitivity can change, and pre-allocate direct map pagetables
down to that granularity. This suggests that pages need to be physically
grouped by sensitivity. The second 2 points illustrate that changing
sensitivity is highly undesirable from a performance point of view. All
of this adds up to needing to be able to index free pages by
sensitivity, leading to the conclusion that we want separate freelists
for sensitive and nonsensitive pages.

The page allocator already has a mechanism to physically group, and to
index pages, by a property, namely migratetype. So the approach taken
here is to extend this concept to additionally encode sensitivity. So
when ASI is enabled, we basically double the number of free-page lists,
and add a pageblock flag that can be used to check a page's sensitivity
without needing to walk pagetables.

.:: Structure of the series

Some generic boilerplate for ASI:
	x86/mm/asi: Add CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
	x86/mm/asi: add X86_FEATURE_ASI and asi=

Minimal ASI setup specifically for direct map management:
	x86/mm: factor out phys_pgd_init()
	x86/mm/asi: set up asi_nonsensitive_pgd
	x86/mm/pat: mirror direct map changes to ASI
	mm/page_alloc: add __GFP_SENSITIVE and always set it

Misc preparatory patches for easier review:
	mm: introduce for_each_free_list()
	mm: rejig pageblock mask definitions
	mm/page_alloc: Invert is_check_pages_enabled() check
	mm/page_alloc: remove ifdefs from pindex helpers

One very big annoying preparatory patch, separated to try and mitigate
review pain (sorry, I don't love this, but I think it's the best way):
	mm: introduce freetype_t

The interesting bit where the actual functionality gets added:
	mm/asi: encode sensitivity in freetypes and pageblocks
	mm/page_alloc_test: unit test pindex helpers
	x86/mm/pat: introduce cpa_fault option
	mm/page_alloc: rename ALLOC_NON_BLOCK back to _HARDER
	mm/page_alloc: introduce ALLOC_NOBLOCK
	mm/slub: defer application of gfp_allowed_mask
	mm/asi: support changing pageblock sensitivity

Misc other stuff that feels just related enough to go in this series:
	mm/asi: bad_page() when ASI mappings are wrong
	x86/mm/asi: don't use global pages when ASI enabled
	mm: asi_test: Smoke test for [non]sensitive page allocs

.:: Testing

Google is running ASI in production but this implementation is totally
different (the way we manage the direct map internally is not good,
things are working nicely so far but as we expand its footprint we're
expecting to run into an unfixable performance issue sooner or later).

Aside from the KUnit tests I've just tested this in a VM by running
these tests from run_vmtests.sh:

compaction, cow, migration, mmap, hugetlb

thp fails, but this also happens without these patches - I think it's a
bug with the ksft_set_plan(), I'll try to investigate this when I can.

Anyway if anyone has more tests they'd like me to do please let me
know. In particular I don't think anything on the list above will
exercise CMA or memory hotplug, but I don't know a good way to do that.
Also note that aside from the KUnit tests which do a super minimal
check, nothing here cares about the actual validity of the restricted
address space, it's just to try and catch cases where ASI breaks non-ASI
logic.

If people are interested, I can start a kind of "asi-next" branch that
contains everything from this patchset plus all the remaining prototype
logic to actually run ASI. Let me know if that seems useful to you
(I will have to do it sooner or later for benchmarking anyway).

[0] [Discuss] First steps for ASI (ASI is fast again)
    https://lore.kernel.org/all/20250812173109.295750-1-jackmanb@google.com/
[1] mm: asi: Share most of the kernel address space with unrestricted
    https://github.com/bjackman/linux/commit/04fd7a0b0098a
[2] [PATCH RFC 00/11] mm: ASI integration for the page allocator
    https://lore.kernel.org/lkml/20250313-asi-page-alloc-v1-0-04972e046cea@google.com/
[3] LSF/MM/BPF 2025 slides
    https://docs.google.com/presentation/d/1waibhMBXhfJ2qVEz8KtXop9MZ6UyjlWmK71i0WIH7CY/edit?slide=id.p#slide=id.p
    CP:
    https://lore.kernel.org/all/20250129124034.2612562-1-jackmanb@google.com/

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (21):
      x86/mm/asi: Add CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
      x86/mm/asi: add X86_FEATURE_ASI and asi=
      x86/mm: factor out phys_pgd_init()
      x86/mm/asi: set up asi_nonsensitive_pgd
      x86/mm/pat: mirror direct map changes to ASI
      mm/page_alloc: add __GFP_SENSITIVE and always set it
      mm: introduce for_each_free_list()
      mm: rejig pageblock mask definitions
      mm/page_alloc: Invert is_check_pages_enabled() check
      mm/page_alloc: remove ifdefs from pindex helpers
      mm: introduce freetype_t
      mm/asi: encode sensitivity in freetypes and pageblocks
      mm/page_alloc_test: unit test pindex helpers
      x86/mm/pat: introduce cpa_fault option
      mm/page_alloc: rename ALLOC_NON_BLOCK back to _HARDER
      mm/page_alloc: introduce ALLOC_NOBLOCK
      mm/slub: defer application of gfp_allowed_mask
      mm/asi: support changing pageblock sensitivity
      mm/asi: bad_page() when ASI mappings are wrong
      x86/mm/asi: don't use global pages when ASI enabled
      mm: asi_test: smoke test for [non]sensitive page allocs

 Documentation/admin-guide/kernel-parameters.txt |   8 +
 arch/Kconfig                                    |  13 +
 arch/x86/.kunitconfig                           |   7 +
 arch/x86/Kconfig                                |   8 +
 arch/x86/include/asm/asi.h                      |  19 +
 arch/x86/include/asm/cpufeatures.h              |   1 +
 arch/x86/include/asm/set_memory.h               |  13 +
 arch/x86/mm/Makefile                            |   3 +
 arch/x86/mm/asi.c                               |  47 ++
 arch/x86/mm/asi_test.c                          | 145 ++++++
 arch/x86/mm/init.c                              |  10 +-
 arch/x86/mm/init_64.c                           |  54 +-
 arch/x86/mm/pat/set_memory.c                    | 118 ++++-
 include/linux/asi.h                             |  19 +
 include/linux/gfp.h                             |  16 +-
 include/linux/gfp_types.h                       |  15 +-
 include/linux/mmzone.h                          |  98 +++-
 include/linux/pageblock-flags.h                 |  24 +-
 include/linux/set_memory.h                      |   8 +
 include/trace/events/mmflags.h                  |   1 +
 init/main.c                                     |   1 +
 kernel/panic.c                                  |   2 +
 kernel/power/snapshot.c                         |   7 +-
 mm/Kconfig                                      |   5 +
 mm/Makefile                                     |   1 +
 mm/compaction.c                                 |  32 +-
 mm/init-mm.c                                    |   3 +
 mm/internal.h                                   |  44 +-
 mm/mm_init.c                                    |  11 +-
 mm/page_alloc.c                                 | 664 +++++++++++++++++-------
 mm/page_alloc_test.c                            |  70 +++
 mm/page_isolation.c                             |   2 +-
 mm/page_owner.c                                 |   7 +-
 mm/page_reporting.c                             |   4 +-
 mm/show_mem.c                                   |   2 +-
 mm/slub.c                                       |   4 +-
 36 files changed, 1205 insertions(+), 281 deletions(-)
---
base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
change-id: 20250923-b4-asi-page-alloc-74b5383a72fc

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


