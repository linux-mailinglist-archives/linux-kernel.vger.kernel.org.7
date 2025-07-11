Return-Path: <linux-kernel+bounces-727938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C9FB0219A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4B21890207
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888342ED156;
	Fri, 11 Jul 2025 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=neon.tech header.i=@neon.tech header.b="Qrdb+uvR"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0E1EA6F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250971; cv=none; b=O0RtdeD1vUIMpJIHOi9iIAhlCJoq51xqEvteju8aI3eXMOD1ZsZheJ9QsqSnq9qut0CA3299opvqLhz/5wG0XHvILoj3hYewZ5CzqDl/SCYcL81B+9PKPPA4Kj5jlcPxCmdhfTB2LsAzU6cu7YaAxsaH35XhEVr6kMCijrn954c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250971; c=relaxed/simple;
	bh=dpgDp6wkqSGiqP1/XPepQWOh8flqlAdPBlBxlxtRbqk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JSj7Ot/SPU6M4ruQNwfnZywNvNF3v+ZW8CpkL2BNrSmWzxQDRWXIxnBcuG5BlwkpyNeijht4y653zy4620D8KENN28WBz42/rA4htg0/AhyPogU+MpHPDmMBRvlzqvXWWaOHgvi8xXnmkpzR1D50PHIn6JpfSLKc+qSGHl9q1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neon.tech; spf=pass smtp.mailfrom=neon.tech; dkim=pass (1024-bit key) header.d=neon.tech header.i=@neon.tech header.b=Qrdb+uvR; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neon.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neon.tech
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so1963542f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neon.tech; s=google; t=1752250968; x=1752855768; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2y1Y/GJGb0njvYUDEFciSrzXxfCPZzSLs33lH/7dOE=;
        b=Qrdb+uvRwcnmhXep4LCrZKqhSkp/n+meVCuIBaXBjh/GoUFh1b41dEtOPQ1yAnv8Lr
         x8cwRoXNHBwTpA/YKsFMQhegLQLn2aOv57hwrAiHjTadoNid0zZ2V4Cd2lJuip1jOKv8
         QEQnDQ58YUoQF5cR5xVn+WCm62AFJeWcL584M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250968; x=1752855768;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p2y1Y/GJGb0njvYUDEFciSrzXxfCPZzSLs33lH/7dOE=;
        b=nYq6t8uleGey+Z2LQ3EOSiO/yfwl9ps2/hWHut+lrPUCz57JLT7cEb8kHiN29CxEqc
         lhg+xZ9LP5tZ66bTRC00FKSQxbcA4GIN9ED3dNp5Ti4MgUaP2DPE2nUuZDUzH3hQIJQ3
         KJYBSFp1SWaU0babsgUtL2VyjmApUgIfzXYTsNItf+Nnft+KfuYsQ3lOwZvonmDkMQOD
         ds39tTezhhcW3cD3wIGX8HrkdonKSU22PgCFaIUANI5Opm0Tq/TToGwrE2+S/B1RIBeK
         Zk2c4JdNgADtnRnVZDnolu3enSlterlfHqGpHz8HV4I974AJ/S36fTkZsUeZrgfYSnY2
         Ozrg==
X-Gm-Message-State: AOJu0Yw0VEzf4WSgpvTT5+r8TeaLfHaauGSxce/brFk+SLL/6OMTKhKx
	frxcjHczPcpMk/SZP3se3KnblU67n/YsYgl+t7sd6yRcEw2gw2YValI4yrwAlnd/hfTwo99iwMu
	dcsKH7xlnVg==
X-Gm-Gg: ASbGncuzBxorMPnkmdXaVMfskVOrUQVhqHkT/A3Yw56077VyHjFC+QTzUgKzofuY4z4
	de3tbDDUaCfM4EfcFRXaMcKw/739YUFrcQqTbARgyIDSiTrjTH+i63so0KRKnL9FYTrYJ2L07wB
	0IJAAUNwFow8A+5X6SuPoZhCZXMCHBpaVvhFgNsOxAU8SYi3+MTzUh10VAO7jAyo9EDD9Xl9bCX
	EsX1DbyIjZzv3o4jyDu4+2OaSAwOM0EUAgUoAHGL6YMB0L7110S6UqzcDDebE7y/e7Ye+xNt7U4
	hL+RQ42j4tMUmKSLjlHEZst8UJU6tckahsTwfSVm5i8AQOFK4U0FjjtBc1SdY0z6rNNTwHK6ovY
	NZxRg252ezLBV/vqrQgW4O1Yb
X-Google-Smtp-Source: AGHT+IHrq1KxO4C9XkLwcbd5YmQer0iQoLTN8/f9ozINMiPvxSBkFT1/D2d2CFHQkihBBN4Zk1K6vQ==
X-Received: by 2002:a5d:6f16:0:b0:3b4:58ff:ed1 with SMTP id ffacd0b85a97d-3b5f18f80e2mr3545065f8f.52.1752250967637;
        Fri, 11 Jul 2025 09:22:47 -0700 (PDT)
Received: from [192.168.86.142] ([90.253.47.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5f16a6016sm2884419f8f.69.2025.07.11.09.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 09:22:47 -0700 (PDT)
Message-ID: <4fe0984f-74dc-45fe-b2b6-bdd81ec15bac@neon.tech>
Date: Fri, 11 Jul 2025 17:22:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Oleg Vasilev <oleg@neon.tech>, Arthur Petukhovsky <arthur@neon.tech>,
 Stefan Radig <stefan@neon.tech>, Misha Sakhnov <misha@neon.tech>
From: Em Sharnoff <sharnoff@neon.tech>
Subject: [PATCH v5 0/4] x86/mm: Improve alloc handling of phys_*_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi folks,

See changelog + more context below.

tl;dr:

* Currently alloc_low_page() uses GFP_ATOMIC after boot, which may fail
* Those failures aren't currently handled by phys_pud_init() and similar
  functions.
* Those failures can happen during memory hotplug

So:

1. Add handling for those allocation failures (patches 1-3)
2. Use GFP_KERNEL instead of GFP_ATOMIC (patch 4)

Previous version here:
https://lore.kernel.org/all/7d0d307d-71eb-4913-8023-bccc7a8a4a3d@neon.tech/

=== Changelog ===

v2:
- Switch from special-casing zero values to ERR_PTR()
- Add patch to move from GFP_ATOMIC -> GFP_KERNEL
- Move commentary out of the patch message and into this cover letter
v3:
- Fix -Wint-conversion issues
v4:
- new patch: move 'paddr_last' usage into phys_{pud,pmd}_init() so the
  return from those functions is no longer needed.
- new patch: make phys_*_init() and their callers return int
v5:
- resend; bumped base commit.

I'm not sure if patch 2/4 ("Allow error returns ...") should be separate
from patch 3/4 ("Handle alloc failure ..."), but it's easy enough to
combine them if need be.

=== Background ===

We recently started observing these null pointer dereferences happening
in practice (albeit quite rarely), triggered by allocation failures
during virtio-mem hotplug.

We use virtio-mem quite heavily - adding/removing memory based on
resource usage of customer workloads across a fleet of VMs - so it's
somewhat expected that we have occasional allocation failures here, if
we run out of memory before hotplug takes place.

We started seeing this bug after upgrading from 6.6.64 to 6.12.26, but
there didn't appear to be relevant changes in the codepaths involved, so
we figured the upgrade was triggering a latent issue.

The possibility for this issue was also pointed out a while back:

> For alloc_low_pages(), I noticed the callers don’t check for allocation
> failure. I'm a little surprised that there haven't been reports of the
> allocation failing, because these operations could result in a lot more
> pages getting allocated way past boot, and failure causes a NULL
> pointer dereference.

https://lore.kernel.org/all/5aee7bcdf49b1c6b8ee902dd2abd9220169c694b.camel@intel.com/

For completeness, here's an example stack trace we saw (on 6.12.26):

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  ....
  Call Trace:
   <TASK>
   phys_pud_init+0xa0/0x390
   phys_p4d_init+0x93/0x330
   __kernel_physical_mapping_init+0xa1/0x370
   kernel_physical_mapping_init+0xf/0x20
   init_memory_mapping+0x1fa/0x430
   arch_add_memory+0x2b/0x50
   add_memory_resource+0xe6/0x260
   add_memory_driver_managed+0x78/0xc0
   virtio_mem_add_memory+0x46/0xc0
   virtio_mem_sbm_plug_and_add_mb+0xa3/0x160
   virtio_mem_run_wq+0x1035/0x16c0
   process_one_work+0x17a/0x3c0
   worker_thread+0x2c5/0x3f0
   ? _raw_spin_unlock_irqrestore+0x9/0x30
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xdc/0x110
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x35/0x60
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

and the allocation failure preceding it:

  kworker/0:2: page allocation failure: order:0, mode:0x920(GFP_ATOMIC|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
  ...
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5b/0x70
   dump_stack+0x10/0x20
   warn_alloc+0x103/0x180
   __alloc_pages_slowpath.constprop.0+0x738/0xf30
   __alloc_pages_noprof+0x1e9/0x340
   alloc_pages_mpol_noprof+0x47/0x100
   alloc_pages_noprof+0x4b/0x80
   get_free_pages_noprof+0xc/0x40
   alloc_low_pages+0xc2/0x150
   phys_pud_init+0x82/0x390
  ...

(everything from phys_pud_init and below was the same)

There's some additional context in a github issue we opened on our side:
https://github.com/neondatabase/autoscaling/issues/1391

=== Reproducing / Testing ===

I was able to partially reproduce the original issue we saw by
modifying phys_pud_init() to simulate alloc_low_page() returning null
after boot, and then doing memory hotplug to trigger the "failure".
Something roughly like:

  - pmd = alloc_low_page();
  + if (!after_bootmem)
  + 	pmd = alloc_low_page();
  + else
  + 	pmd = 0;

To test recovery, I also tried simulating just one alloc_low_page()
failure after boot. This change seemed to handle it at a basic level
(virito-mem hotplug succeeded with the right amount, after retrying),
but I didn't dig further.

We have also been running this in our production environment, where we
have observed that it fixes the issue.


Em Sharnoff (4):
  x86/mm: Update mapped addresses in phys_{pmd,pud}_init()
  x86/mm: Allow error returns from phys_*_init()
  x86/mm: Handle alloc failure in phys_*_init()
  x86/mm: Use GFP_KERNEL for alloc_low_pages() after boot

 arch/x86/include/asm/pgtable.h |   3 +-
 arch/x86/mm/init.c             |  29 ++++++---
 arch/x86/mm/init_32.c          |   6 +-
 arch/x86/mm/init_64.c          | 116 ++++++++++++++++++++++-----------
 arch/x86/mm/mem_encrypt_amd.c  |   8 ++-
 arch/x86/mm/mm_internal.h      |  13 ++--
 6 files changed, 113 insertions(+), 62 deletions(-)


base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.39.5


