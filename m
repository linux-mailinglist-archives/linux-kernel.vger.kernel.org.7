Return-Path: <linux-kernel+bounces-825147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E3AB8B1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676C35A3F37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83F830F954;
	Fri, 19 Sep 2025 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3rWMeBh"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D927F00A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311547; cv=none; b=J0wD+iwsvtCTbRiJmcIJLaa/h3GnXToMT8dbgAw0ZNgzKq5PEdFNmPdyJrIPAMwaM6ybSGbNajK8YGywKP5Nkd1NpBq/vLC9fAq+k8hJPajlj9rckKUxaLtmfM5+rSjalT9Zn5B+m1NkNW6Hl6QA5MzUOHH3fU9QkZ6lX1h19fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311547; c=relaxed/simple;
	bh=cZz0fWjbPpHeext8MDKoJ6fMtyElgMiindxZ8BdUwts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+5UrZk2sA5A5LJTb9sfv0ySwVh6PAoGcNmYw1RNoec7L4rzpg9Pgl7k3VUm8fWgMBDi1Vq8UXsH0QLa0W9syGGXfn3flxgaAnSsc210+lm8TSb+iv6FMXjY8lM/omsAat6VHD/fCvAeDfZUYxk1ZbDdGbgMEWGr5bWCYIamIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3rWMeBh; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-ea3dbcc5525so1837216276.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311545; x=1758916345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BhEwl8pjUtCVBar7ssCbBQPYD+y8By4S7sJUUFiinZg=;
        b=U3rWMeBh8E/2Ykwi//q7WteCnfBjHhTs7NwXLcUZM4GGqmByfkGxhRhCBi03eF89yB
         0lKNu/O6OC2a/5Cd0usQFAIVVx3avDIsLH94gYK6v/KBzqBUgib3SP63wrIggr15Iw99
         dqQCiBwOjvotAF/QTWy39i59TgLrBzL8FLYLQ94IynXCdzgZp8sZruO3xJS7Kc/od7KG
         Py/gaMPG+PuIvfZQwvNjlvxo3pysdTcrPRvWot/uuPhyNkbwTb4Y2wJl/JysVJ6IhXTq
         yyspRqIIcVxcf6OWZU0/TiUOq2c+Zj1wfGZD1oUpFKAdPuhYgZ8T4ehyKqgeijeuPNeo
         4ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311545; x=1758916345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhEwl8pjUtCVBar7ssCbBQPYD+y8By4S7sJUUFiinZg=;
        b=rN4mW/G+ETuObx/ZYJ0pPZLjrOW7Rv38ACfxb60bd34MGq0PPNRXaWoPDdZqoOI6jq
         nyf5L3NZbpxEtxU9YHIewWNA6LsxTmOfCi1CSN9tfsnpmdqvsLTFoeuYIBSQVvzK5gg+
         z3u0oTCgube4tne/31eCkhQSdVp6OSelYZnmAE3B7FBd6QLCtcUVwxUPxNS5JN9B5YcB
         69tJWkIcwcwPoD0gFHpuoq9tOiY7grG5hq4tjQlan1O4qy+JPXI+XIW5bX0woxOZJKLf
         fKXxGic5EVHgQouICyJ/oxXZcH/x5z2FIG2askcL1cDOxdA4E+Iyfc8ZX7N2Hn9e23QC
         y0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUjPwSt0+ZuEJG5uAX01zU746jP99cB/JPvSE1M5LqQLg2BHS1DgzdnIJ/UaDpaqLkRf33CH8ZaOLlfpQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH6jM/vlnZOVggoH0j21KA6xFtpXQqaVTUH6HB8AXAQKaYCTx5
	khawoU8T9xiF/J48ido///zIQjRuwvl3Ce3+49dy3eyAizAyYf4X4Dzm
X-Gm-Gg: ASbGnctrIYHm+5uMOWSLWKS8TQwYxmBXc9RMUERufSLmYOi8M7aGlw/xSPhujRbWR+0
	AUjBgWgtUN3wA7ZXaAxU1zHcbTkxFtw6qCHE7xdT0h490y50r2J7lBbWgX/tuB9yOa/iUYWP5sn
	FckGqmyHNnqkU6I5JYNUdX1gKNU1nhYNj/vpCACuobXsbS2V6v9Qx4LWSSfv324/3LUxUe0vCWB
	tQNOEItrCaOBtV1PlShz4/2/vl/jyX6k9lPzhbjX8iCPkoch8ED98qK9L8Xjjf+xm1YJy2D1n0y
	EeXax6zyJAPnwP3XYpoRNgtNmzEqcPaSnJNQ5l6F+LDfGeVpgovxtsRJYDHR7Di2tchbH4PaDxN
	GrIK+Y42NtItiS/btm1HXh9iNj7dudeuIDKOVhZJLpvZ2TrKyYL5sU4B4mWcj5tHN
X-Google-Smtp-Source: AGHT+IHxfeVdvX9Ciy91R5deOME+aYv7ueJmUkVtXCCRJQe6Fue8/urAgnuJqKKsNGsZiuMfMWy42A==
X-Received: by 2002:a05:690c:2603:b0:734:f858:b1e7 with SMTP id 00721157ae682-73d3ce7a14emr44257107b3.27.1758311544831;
        Fri, 19 Sep 2025 12:52:24 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739716c0506sm16663587b3.9.2025.09.19.12.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:52:24 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH 0/4] mm/page_alloc: Batch callers of free_pcppages_bulk
Date: Fri, 19 Sep 2025 12:52:18 -0700
Message-ID: <20250919195223.1560636-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While testing workloads with high sustained memory pressure on large machines
(1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
Further investigation showed that the lock in free_pcppages_bulk was being held
for a long time, even being held while 2k+ pages were being freed [1].

This causes starvation in other processes for both the pcp and zone locks,
which can lead to softlockups that cause the system to stall [2].

[ 4512.591979] rcu: INFO: rcu_sched self-detected stall on CPU
[ 4512.604370] rcu: 	20-....: (9312 ticks this GP) idle=a654/1/0x4000000000000000 softirq=309340/309344 fqs=5426
[ 4512.626401] rcu: 	         hardirqs   softirqs   csw/system
[ 4512.638793] rcu: 	 number:        0        145            0
[ 4512.651177] rcu: 	cputime:       30      10410          174   ==> 10558(ms)
[ 4512.666657] rcu: 	(t=21077 jiffies g=783665 q=1242213 ncpus=316)

And here is the trace that accompanies it:

[ 4512.666815] RIP: 0010:free_unref_folios+0x47d/0xd80
[ 4512.666818] Code: 00 00 31 ff 40 80 ce 01 41 88 76 18 e9 a8 fe ff ff 40 84 ff 0f 84 d6 00 00 00 39 f0 0f 4c f0 4c 89 ff 4c 89 f2 e8 13 f2 fe ff <49> f7 87 88 05 00 00 04 00 00 00 0f 84 00 ff ff ff 49 8b 47 20 49
[ 4512.666820] RSP: 0018:ffffc900a62f3878 EFLAGS: 00000206
[ 4512.666822] RAX: 000000000005ae80 RBX: 000000000000087a RCX: 0000000000000001
[ 4512.666824] RDX: 000000000000007d RSI: 0000000000000282 RDI: ffff89404c8ba310
[ 4512.666825] RBP: 0000000000000001 R08: ffff89404c8b9d80 R09: 0000000000000001
[ 4512.666826] R10: 0000000000000010 R11: 00000000000130de R12: ffff89404c8b9d80
[ 4512.666827] R13: ffffea01cf3c0000 R14: ffff893d3ac5aec0 R15: ffff89404c8b9d80
[ 4512.666833]  ? free_unref_folios+0x47d/0xd80
[ 4512.666836]  free_pages_and_swap_cache+0xcd/0x1a0
[ 4512.666847]  tlb_finish_mmu+0x11c/0x350
[ 4512.666850]  vms_clear_ptes+0xf9/0x120
[ 4512.666855]  __mmap_region+0x29a/0xc00
[ 4512.666867]  do_mmap+0x34e/0x910
[ 4512.666873]  vm_mmap_pgoff+0xbb/0x200
[ 4512.666877]  ? hrtimer_interrupt+0x337/0x5c0
[ 4512.666879]  ? sched_clock+0x5/0x10
[ 4512.666882]  ? sched_clock_cpu+0xc/0x170
[ 4512.666885]  ? irqtime_account_irq+0x2b/0xa0
[ 4512.666888]  do_syscall_64+0x68/0x130
[ 4512.666892]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 4512.666896] RIP: 0033:0x7f1afe9257e2

To prevent starvation in both the pcp and zone locks, batch the freeing of
pages using pcp->batch. 

Because free_pcppages_bulk is called with both the pcp and zone lock,
relinquishing and reacquiring the locks are only effective when both of them
are broken together. Thus, instead of modifying free_pcppages_bulk to break
both locks, batch the freeing from its callers instead. 

In our fleet, we have seen that performing batched lock freeing has led to
significantly lower rates of softlockups, while incurring relatively small
regressions (relative to the workload and relative to the variation).

The following are a few synthetic benchmarks, made on a machine with
250G RAM, 179G swap, and 176 CPUs. 

stress-ng --vm 50 --vm-bytes 5G -M -t 100
+----------------------+---------------+----------+
|        Metric        | Variation (%) | Delta(%) |
+----------------------+---------------+----------+
| bogo ops             |        0.0120 |  -0.0011 |
| bogo ops/s (real)    |        0.0109 |  -0.0091 |
| bogo ops/s (usr+sys) |        0.5560 |  +0.1049 |
+----------------------+---------------+----------+

stress-ng --vm 10 --vm-bytes 30G -M -t 100
+----------------------+---------------+----------+
|        Metric        | Variation (%) | Delta(%) |
+----------------------+---------------+----------+
| bogo ops             |        1.8530 |  +0.4728 |
| bogo ops/s (real)    |        1.8604 |  +0.2029 |
| bogo ops/s (usr+sys) |        1.6054 |  -0.6381 |
+----------------------+---------------+----------+

Patch 1 simplifies the return semantics of decay_pcp_high and
refresh_cpu_vm_stats, which makes the change in patch 3 more semantically
accurate. 

Patch 2, 3, and 4 each address one caller of free_pcppages_bulk, and ensures
that large values passed to it are batched. 

This series is a follow-up to [2], where I attempted to solve the same problem
by relinquishing only the zone lock within free_pcppages_bulk. Because this
approach is different in nature, I decided not to send this as a v2, but
as a separate series altogether. 

[1] For instance, during *just* the boot of said large machine, there were
    2092 instances of free_pcppages_bulk being called with count > 1000.
[2] https://lore.kernel.org/all/20250818185804.21044-1-joshua.hahnjy@gmail.com/

Joshua Hahn (4):
  mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats change detection
  mm/page_alloc: Perform appropriate batching in drain_pages_zone
  mm/page_alloc: Batch page freeing in decay_pcp_high
  mm/page_alloc: Batch page freeing in free_frozen_page_commit

 include/linux/gfp.h |  2 +-
 mm/page_alloc.c     | 65 ++++++++++++++++++++++++++++++++-------------
 mm/vmstat.c         | 26 +++++++++---------
 3 files changed, 61 insertions(+), 32 deletions(-)


base-commit: 097a6c336d0080725c626fda118ecfec448acd0f
-- 
2.47.3

