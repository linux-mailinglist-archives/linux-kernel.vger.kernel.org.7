Return-Path: <linux-kernel+bounces-852879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D63BABDA27F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4976C582FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6D226F292;
	Tue, 14 Oct 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4b/A88W"
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2A2877CF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453415; cv=none; b=ZFZtPuMhpqkSik9IxEjhPF2ispCpPDufGhOXg9iv3NFP+Qh5QAzl6laoMC5vb6lKPhrerPXyFnGTLYisspZ6ZhzzTBjG9MejvgSYrspx+6pxWH+ScQlLRjB0u50C5fYi0Ch1ycs2p8iT7FzihicjRvD5Dv0tRHQ1V+J5eIm14UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453415; c=relaxed/simple;
	bh=4vNLbvvhmYF0LRt7Rdg0U7ko6N5QtnXTeJjM15o0jbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8Nn7CzR48YFOji/RPU1rCYfAFcrlfTdEbmu5E+TQsju5EoXTc6V+1a4pL3Np3i04kEtPnykg9X3eeMuOLcHFVxqezDFxoyaTPlybKcm1nd698D2b50SwAerrxUqx+pPMAYD/49s0lJhg3vt8QrHC/DFew/xs5pwsiRoAPw2JB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4b/A88W; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-635355713d9so5236974d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760453413; x=1761058213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AhiUCIRsJh9/X6gFFF6AAeo3W+sNR4EDIfl/mL10GSE=;
        b=O4b/A88Wj016g2TpD+XbPrFSmPuJb4vWttLld1lPSa0OAAd5L2tlcZf1dJz+mEg6F9
         kpCOfOr2hGfeytwSH8bcpgzJlNZC6qmfM0xGkWWwQCumxSGoGGL5jVTvdYDmYZo8RQpy
         DMVPsw14Bjq0QuiGLGVdggO3zWLZnjpe4WY/vo9pF1LAwryq5yJF+0PhrNZ+rC15QPx3
         9MBJjpvF+yIYAqAWREWlqbE+fPMuLN5/RF/VVGJ3M94vg5EQgA4QX7lo3k+YAxyBB6p7
         DtuhCdL9h4+nkcGyR+MeboAcjrFC2L24DDPSXu5SrEmskXSkCF4dCR4Qme+ppV24CTuv
         lcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453413; x=1761058213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhiUCIRsJh9/X6gFFF6AAeo3W+sNR4EDIfl/mL10GSE=;
        b=S+vwcd29PaMTkArngXPyuQ4GDYdRepAcBpbKfUlS1ymeECdMrLLqkyggkY7oZG5beC
         lwrz8LQCXWxavsxbwm367V216GxZIjr8pgXybGRGN8Z/mYl+6NAz6u7pcFG8CwHtnh6J
         fT1jSQBrXPcIt6aoYZ9avBFmYrkb0jhIpvaA8RCg6nHnKNAHMU1b3u1PbF/Ny/ditKmk
         ExINSzFRAXrb/CYzgQ+SAjHV9BeNEjzMEFujAFZ7pZkL2IgtzZ27FUPVKiUzNx1xt0pg
         bV+31xUie0WkpcGtm0gfYkXcN69ZdHKGPyLRsRqldXa7+E7hOwuwjZMqPbA7Frjqdtgd
         v9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYcR+ZMXX3Gy0CIXMoPmjJN7qTj345lLx18XEHIfg8dPpJidc/1aypHjUAYYN5bTl/O4JZE10xYaknFt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYGzLyZ/SJDEae5CV2ru7WAZWpEDBDOvBFPJyzwBAYPFzcJv5Q
	OU6yoD/G6X8J3yAiT9H1XHB7kkkp6Ukrz4bVXdLkLrlJjL4apff7gTPSwdXEYA==
X-Gm-Gg: ASbGncv6tOJEooTuHrDol4ewFj0xKPuny4tIAp9iJAW8dfxTPvxlEP4L4uqf5Q9f7V+
	2/AKPSn6y2ufkZsIczgHGEeht01PpDSx4+lyOBcsC5dM2oTIzsVjUifd3Gwha6kZwgaGa6vMe3v
	cILHNfM2WujlC67f5jxqiyQ2+O76RLLoUhvzSCbcm9SjhopHHyLky6uBJLJ/gFDuToTYpJsqIKR
	KAse7h4HUr+jvNiF8yWzk1O9nXjSvmhUR4BvsRCad5BjsziSITyGYAaBzG7ll6Qx/v1XbfR+SB4
	3otZXxnkLrFj8R8VgVQg9UMPjJJ4WQznFpmi0Moo5nfcHlI232UzW9LS0PySr8ACbEkoDaHKS00
	7eur0i2qIMWUvy5VRRgCdulJddBm8mgtLxzTAOW6OafXOMcK8/OsUzjK16eWtOLGxv6ekQIFIl+
	XubXk+ODqMNcnrEBCfUA==
X-Google-Smtp-Source: AGHT+IFVB7X559i8Ow1TBdbFEuH19J9C6JBi6GTmKNR0KPidIxIOmo+0oh4Oa2lzmnmK9+xR9kM4RA==
X-Received: by 2002:a53:a081:0:b0:62a:b339:20d4 with SMTP id 956f58d0204a3-63ccb82412emr16372072d50.21.1760453412563;
        Tue, 14 Oct 2025 07:50:12 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63cd952e16fsm4812844d50.12.2025.10.14.07.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:50:12 -0700 (PDT)
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
Subject: [PATCH v5 0/3] mm/page_alloc: Batch callers of free_pcppages_bulk
Date: Tue, 14 Oct 2025 07:50:07 -0700
Message-ID: <20251014145011.3427205-1-joshua.hahnjy@gmail.com>
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

While these warnings don't indicate a crash or a kernel panic, they do point
to the underlying issue of lock contention. To prevent starvation in both
locks, batch the freeing of pages using pcp->batch.

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
machine. One possible theory is that because the high watermark depends on
both memory and the number of local CPUs, what impacts zone contention the
most is not these individual values, but rather the ratio of mem:processors.

Changelog
=========
v4 --> v5:
- Wordsmithing
- Patches 1/3 and 2/3 were left untouched.
- Patch 3/3 no longer checks for the to_free == 0 case. It also now checks
  for pcp->count > 0 as the condition inside the while loop, and the early
  break checks for the opposite condition. Note that both to_free and
  pcp->count can become negative due to high-order pages that are freed, so
  we must check for (to_free <= 0 || pcp->count <= 0), instead of just
  checking for == 0.
- Testing results were left unchanged, since the new iterations did not lead
  to any noticable differences in the results.

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
 mm/page_alloc.c     | 82 ++++++++++++++++++++++++++++++++++++---------
 mm/vmstat.c         | 28 +++++++++-------
 3 files changed, 82 insertions(+), 30 deletions(-)


base-commit: 53e573001f2b5168f9b65d2b79e9563a3b479c17
-- 
2.47.3

