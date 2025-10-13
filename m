Return-Path: <linux-kernel+bounces-851236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0641DBD5E14
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D98118A604C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DC22D323E;
	Mon, 13 Oct 2025 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/5/isp2"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53D27A129
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382496; cv=none; b=o1x0VeCfCa4xTA/uUBpMHnv7lkO1AG9tvQcSehBbRiMCCst7b2ub//kL1wOoPJvQZyXzANXzbDWu5d2v93XV0wPg1oo7j4gCSyy4/+VWOcxHH583jAEP1fGKVfjBFRL/bZNnaYKPoFYMm1D5AaIjVXBLROaGdUsFbUHYzUZfq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382496; c=relaxed/simple;
	bh=9cerGHwRDFQlS5C2NNzHZb/WekDyzi7TyfD/v1r0fHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMYf7bnIskwLuFscJQJARd9CmmsLN+lIXVFqUP1SvVEXy8SBiJ2i5J57RAxQn8CBnedISNXwHyOfYpKemAh706PZhmVBFmSnrw6jfdfmVZ31aYa2pIrMBQE9fHZPjEufr2Vlz6n/K1zoaPRHIbx7L0wzF8LMe7x6Qph7tMjsF9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/5/isp2; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-743ba48eb71so69660387b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760382493; x=1760987293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujdfIo/LIiujs0fZMnOKsR1U8QJjd2WFtcnuvuesTGA=;
        b=W/5/isp2P3vHtIlzqkQg9TzplSKZdRih/pM+E8Ni4qQ09tSYUmnXHHvzYDJLEA9J77
         copvhqkfp7WoAriGKKn2o8H7VgUB0eS4ur140u2AU2hnKCQt7qQ99XpYa8TK+GndWFcZ
         vAsUc96K3M2zuVK9IsApWylNUtlT84wGCg8aC9dcoElAEdkwDX9piSFvDNlK50sti77q
         Xu8tEAdY+cgLFV1zLiZG9s3LWcLAwEN5+T34PBA/TfrA74fFBx18Na1xbaSbrw+IccXq
         rv2WYf84gib+vk0r9sK4JvNBr3t/CK1sLPhoa+8AK4c0VyyTSbqst+IkSMzx4S3/3wsq
         UNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760382493; x=1760987293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujdfIo/LIiujs0fZMnOKsR1U8QJjd2WFtcnuvuesTGA=;
        b=Z2zByznKLQ5LFKocbQObZMoNwTdtcAxrFTCC3Fm7N39a4B2PzVk2OJVZMPGk/+vKZe
         IU6F/44wT5V/g0GPyz/7lLWc21RyC85Z+HpJahTCCkcgUg+RE6qlpjCMtsHRJBevlD+u
         FtIHBHs+V4hhv7HzrADt2kaum3N8bAYo73KzCWrZmYZJZNSyt/uefbGpM87JAUzkTRgR
         RWu13Aj3sQeuRU7xB91bRBiGyC/7PutIgUTbi+dAhBBVwnTLmlzzfPksAd7IZTPZWEh9
         qHtWUeS8z7I/U5VGzr30Dfgo7PQiFytptlsjWWFvt5XTed9CliqyHOqZ8dpSsDQ3OkdK
         ewsw==
X-Forwarded-Encrypted: i=1; AJvYcCUYzpse9+yUXpu7Gu19hJcuORF57pHfMzpOF8dUefEBAgskVNz25rRy5DCj2H/v4Hal5pQ4MNuCK5AGN7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwojlQdE23Wh+22ldJL/WhrQgZBJ5iOkCWlV12RegURjKLCmTif
	o+O0XC7r7znhLOYTgBCsaJEGQukVwOTeAIZwtWouvJENMDb3zHfge8tB
X-Gm-Gg: ASbGncs2UlnlONZHXoC1xwjjtuUsf4W2V8fh33pUYa31yN3WHLilCQbvg39f0kETZQ0
	liiLuiyeIieALdQc5jDhtR8GfmDPKZlxWtdNXHro2sGQGtL6Tkybl0vDHmGV6GfefJrAQMZX4Hn
	WcTdHrJH92PiZn2s75m/WBsh6xx8fApG8MdDEz+kHdHmPhMiSvbCJ6NR6Ru2IOT6GoI2s6Ahhst
	iRLkaAHI726Pp99lYTMOAAkr2XK82waAhFtYZw7OTz2JVKxm3LXBsrpuVaj8BzTAO74EDrFZu8G
	Riq47k320P4d5L/oPr4wcderKOSVNBA6zRbUgAl8wehxXY/aAwleHwSdq7Qfo/5MMdbHENvNag1
	Iw7jVO0LGPf2dWCiCwmN+RVtMiaVGRCMFRuir1YZZ8tnDsUHDQptzNwrZ6/MDHtoKbCu1ei7IGD
	LPQhc/GUHBWPZrhWt2vg==
X-Google-Smtp-Source: AGHT+IFNLr4wMsQCGrgyslhpHaWPtiAF3PRyiV2k7WpU2zBPgMgdftZMwasj706Op9vL79MYJUvfrw==
X-Received: by 2002:a05:690e:110:b0:636:2079:186e with SMTP id 956f58d0204a3-63ccc3e19bemr15520473d50.5.1760382493448;
        Mon, 13 Oct 2025 12:08:13 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-781465e0309sm2746337b3.37.2025.10.13.12.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 12:08:13 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v4 0/3] mm/page_alloc: Batch callers of free_pcppages_bulk
Date: Mon, 13 Oct 2025 12:08:08 -0700
Message-ID: <20251013190812.787205-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motivation & Approach
=====================

While testing workloads with high sustained memory pressure on large machines
in the Meta fleet (1Tb memory, 316 CPUs), we saw an unexpectedly high number
of softlockups. Further investigation showed that the zone lock in
free_pcppages_bulk was being held for a long time, and was called to free
2k+ pages over 100 times just during boot.

This causes starvation in other processes for the zone lock, which can lead
to the system stalling as multiple threads cannot make progress without the
locks. We can see these issues manifesting as warnings:

[ 4512.591979] rcu: INFO: rcu_sched self-detected stall on CPU
[ 4512.604370] rcu:     20-....: (9312 ticks this GP) idle=a654/1/0x4000000000000000 softirq=309340/309344 fqs=5426
[ 4512.626401] rcu:              hardirqs   softirqs   csw/system
[ 4512.638793] rcu:      number:        0        145            0
[ 4512.651177] rcu:     cputime:       30      10410          174   ==> 10558(ms)
[ 4512.666657] rcu:     (t=21077 jiffies g=783665 q=1242213 ncpus=316)

While these warnings are benign, they do point to the underlying issue of
lock contention. To prevent starvation in both locks, batch the freeing of
pages using pcp->batch.

Because free_pcppages_bulk is called with the pcp lock and acquires the zone
lock, relinquishing and reacquiring the locks are only effective when both of
them are broken together (unless the system was built with queued spinlocks).
Thus, instead of modifying free_pcppages_bulk to break both locks, batch the
freeing from its callers instead.

A similar fix has been implemented in the Meta fleet, and we have seen
significantly less softlockups.

Testing
=======
The following are a few synthetic benchmarks, made on three machines. The
first is a large machine with 754GiB memory and 316 processors.
The second is a relatively smaller machine with 251GiB memory and 176
processors. The third and final is the smallest of the three, which has 62GiB
memory and 36 processors.

On all machines, I kick off a kernel build with -j$(nproc).
Negative delta is better (faster compilation).

Large machine (754GiB memory, 316 processors)
make -j$(nproc)
+------------+---------------+-----------+
| Metric (s) | Variation (%) | Delta(%)  |
+------------+---------------+-----------+
| real       |        0.8070 |  - 1.4865 |
| user       |        0.2823 |  + 0.4081 |
| sys        |        5.0267 |  -11.8737 |
+------------+---------------+-----------+

Medium machine (251GiB memory, 176 processors)
make -j$(nproc)
+------------+---------------+----------+
| Metric (s) | Variation (%) | Delta(%) |
+------------+---------------+----------+
| real       |        0.2806 |  +0.0351 |
| user       |        0.0994 |  +0.3170 |
| sys        |        0.6229 |  -0.6277 |
+------------+---------------+----------+

Small machine (62GiB memory, 36 processors)
make -j$(nproc)
+------------+---------------+----------+
| Metric (s) | Variation (%) | Delta(%) |
+------------+---------------+----------+
| real       |        0.1503 |  -2.6585 |
| user       |        0.0431 |  -2.2984 |
| sys        |        0.1870 |  -3.2013 |
+------------+---------------+----------+

Here, variation is the coefficient of variation, i.e. standard deviation / mean.

Based on these results, it seems like there are varying degrees to how much
lock contention this reduces. For the largest and smallest machines that I ran
the tests on, it seems like there is quite some significant reduction. There
is also some performance increases visible from userspace.

Interestingly, the performance gains don't scale with the size of the machine,
but rather there seems to be a dip in the gain there is for the medium-sized
machine.

Changelog
=========
v3 --> v4:
- Patches 1/3 and 2/3 were left untouched, other than adding review tags
  and a small clairification in 2/3 to note impact on the zone lock.
- Patch 3/3 now uses a while loop, instead of a confusing goto statement.
- Patch 3/3 now checks ZONE_BELOW_HIGH once at the end of the function, and
  high is calculated just once as well, before the while loop. Both suggestions
  were made by Vlastimil Babka, to improve readability and to stick more closely
  to the original scope of the function.
- It turns out that omitting the repeated zone flag check and high calculation
  leads to a performance increase for all machine types.
  The cover letter includes the most recent test results.
- I've also included the test results in patch 3/3, so that the numbers are
  there and can be referenced in the commit log in the future as well.

v2 --> v3:
- Refactored on top of mm-new
- Wordsmithing the cover letter & commit messages to clarify which lock
  is contended, as suggested by Hillf Danton.
- Ran new tests for the cover letter, instead of running stress-ng, I decided
  to compile the kernel which I think will be more reflective of the "default"
  workload that might be run. Also ran on a smaller machines to show the
  expected behavior of this patchset when there is lock contention vs.
  lower lock contention.
- Removed patch 2/4, which would have batched page freeing for
  drain_pages_zone. It is not a good candidate for this series since it is
  called on each CPU in __drain_all_pages.
- Small change in 1/4 to initialize todo, as suggested by Christoph Lameter
- Small change in 1/4 to avoid bit manipulation, as suggested by SeongJae Park.
- Change in 4/4 to handle the case when the thread gets migrated to a different
  CPU during the window between unlocking & reacquiring the pcp lock, as
  suggested by Vlastimil Babka.
- Small change in 4/4 to handle the case when pcp lock could not be acquired
  within the loop in free_unref_folios.

v1 --> v2:
- Reworded cover letter to be more explicit about what kinds of issues
  running processes might face as a result of the existing lock starvation
- Reworded cover letter to be in sections to make it easier to read
- Fixed patch 4/4 to properly store & restore UP flags.
- Re-ran tests, updated the testing results and interpretation

Joshua Hahn (3):
  mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats change detection
  mm/page_alloc: Batch page freeing in decay_pcp_high
  mm/page_alloc: Batch page freeing in free_frozen_page_commit

 include/linux/gfp.h |  2 +-
 mm/page_alloc.c     | 83 ++++++++++++++++++++++++++++++++++++---------
 mm/vmstat.c         | 28 ++++++++-------
 3 files changed, 83 insertions(+), 30 deletions(-)


base-commit: 53e573001f2b5168f9b65d2b79e9563a3b479c17
-- 
2.47.3

