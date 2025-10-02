Return-Path: <linux-kernel+bounces-840751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8755FBB5255
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69983C269F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73D71B424F;
	Thu,  2 Oct 2025 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWmq1T46"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C9C79DA
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438001; cv=none; b=o5Tdxxw4dKWbrJbYFmuUQyVKaZs56mvj17cOCPDENR/q2etsVPjSJ61d9+KlT4mOGlCPi/7MaM3BXMWl9tbQ0UZgtbQ8cn/fhUUoYuAigF9vtsrT50k17diYx+nT4Id3D13aGZnzn9PD2fkd3jLKA+g4kuwew1SjedJRB5KEYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438001; c=relaxed/simple;
	bh=2vN5F5hDsFA0mp9W2X20FNJ1TR3GstBLvf7PXiziZRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1PLSkqbENBd5dFDM9b5bMGduzqnxSthrs4ngpmOXsDa0c4YxLd1SqljczdkSH/HU05nxcE7MNu9Tfdo+Ao8364okUinuH5ioZjXov2iZliTra9ynwuKJf8Dmgum+3/vkcXK2v1NTkkB3An3tw2Ho9/3vYoU8pK1Capp4MZ3cTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWmq1T46; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6353ff1a78dso1488217d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759437998; x=1760042798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ay/9vezBY6puwDg2MjgpOWz9DbnBpP+YhoVm026fczg=;
        b=iWmq1T46w/JGFO7WctCrj8iE1DeanAYYJdN3W9tBQjWNiVkd8bCZ+OWn2QZiaP19Cu
         nIGJ/M9kdkbk2QUgnun8sH/rWtXMWJf79gYeueQCzcFJt2U5uvi+hSsKy6bzli2wJt4Z
         z9lDtfJi72q0sThhweO68w1CMOwmKb/NHbDlBIWGETyZbyh5pqAVAWDAWGLyMbsurdXV
         1Uj4AI3U1Gc47TF+SdItOQ1iOF0yKTaysSzeQDYLa6td02aYDFI0RzyFd9t5M/nhV2Bc
         bIHagkpM8KioexPXUT8zITzScHwi0cWPQZOyv2dLxpIQDMSlJKkJpH79vesyh3SheRv2
         N9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437998; x=1760042798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ay/9vezBY6puwDg2MjgpOWz9DbnBpP+YhoVm026fczg=;
        b=KV5DiwqJ9MpcD2sBVJZOr0UBFMa8nT5LKALwrC1PbsQZdNrQUb5YGndVZOKsT/EmUv
         l3nzkh4VKMUmIwIm35n51uvlBIyr45MKeasPGZs+6as7e3iWakyzUxVvWNgPUmlZ+1/C
         R+FUIlyJqvNr6z67k5Z3OUZ2qozxgrpLnTTvsIZ4j9P9Y/peenJQxJRdeSCyLlUWdSOf
         OM0o40Spk5ZsYujq+uSkjTIvKGUWJJbwAmyrljecWtPXctY5qpUaSFWeDXD+EveNWnYR
         xWcMFIM6BMPzeoYL6go2hBOKJvpd3ns8YvyJj/9GBRsghtY7+41yjJQ92lEhwGa6eG6a
         q2iA==
X-Forwarded-Encrypted: i=1; AJvYcCWtmjDuzA0LmksX/b8x4OEZxP7r9iRrIBFxoFyOoE/t/EzaG87lNUDX0RzKyElPtCR3gIeFNul+4yCABLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87cVnitzCSwVg4DlZma5Bb4cwIECh17aBAYI1xM++MQ0ezF7I
	+cWTbzO1q82uAPnW8HAYw1DBBHTSGq+gQyMNgPNFVZ9aNPxkQCmssxCk
X-Gm-Gg: ASbGncvodyfoCboTcJj+hoOqxwzzEHCOJd5+VVi/QuRCT6Zs5Qd9mPmWmg+F1HV/YQt
	Zg/tBI/OR8YF0krQ3mQ4qjYhEFh6unDxutQhlaZtmuBd3IZnKa6bR7YqdkpgFV3gbvmqj5WmkWn
	IhbNC3PfQ2vDcSf/3BTQF0j8FwKqOw4pPPUeP6vsCgnfXQvqFt+C3NGOEBmja1xl+YJ55ojP0cc
	4rOc9lfDa0Qn6ZVzPYvpiITm+mFOBC0ZAPK3Z2JjZenVgYxjfRUHckye6X9kdFMcTvJAplZpsy0
	Id0m9615SW/9obkuDiwwUC1+32kF8Wl/u6MgHAGSgAmOpCuNYo7mdODlsQlI3yEo3NUox+WsWk/
	ZpZay95cs3yeYGN7VnW29pZuYs/cdZ3lbxpSCM6PFM1heMvagGXLlkn35yGPTzWQCaw6QYmxCcw
	j/Kw==
X-Google-Smtp-Source: AGHT+IHpcCTVRqgenU3vW+3sLcFVGrhQQKAHnHEh2WSWX6kMoKdNV+yXAl0xqxgPOXUh0ujYau5cmw==
X-Received: by 2002:a53:d6c9:0:b0:635:4ecd:759f with SMTP id 956f58d0204a3-63b9a0fcb2fmr503983d50.45.1759437998068;
        Thu, 02 Oct 2025 13:46:38 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63b845a65e4sm1038716d50.10.2025.10.02.13.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:46:37 -0700 (PDT)
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
	Hillf Danton <hdanton@sina.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v3 0/3] mm/page_alloc: Batch callers of free_pcppages_bulk
Date: Thu,  2 Oct 2025 13:46:30 -0700
Message-ID: <20251002204636.4016712-1-joshua.hahnjy@gmail.com>
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

Because free_pcppages_bulk is called with both the pcp and zone lock,
relinquishing and reacquiring the locks are only effective when both of them
are broken together (unless the system was built with queued spinlocks).
Thus, instead of modifying free_pcppages_bulk to break both locks, batch the
freeing from its callers instead.

A similar fix has been implemented in the Meta fleet, and we have seen
significantly less softlockups.

Testing
=======
The following are a few synthetic benchmarks, made on two machines. The
first is a large, single-node machine with 754GiB memory and 316 processors.
The second is a relatively smaller single-node machine with 251GiB memory
and 176 processors.

On both machines, I kick off a kernel build with -j$(nproc).
Lower delta is better (faster compilation).

Large machine (754GiB memory, 316 processors)
make -j$(nproc)
+------------+---------------+----------+
| Metric (s) | Variation (%) | Delta(%) |
+------------+---------------+----------+
| real       |        0.4627 |  -1.2627 |
| user       |        0.2281 |  +0.2680 |
| sys        |        4.6345 |  -7.5425 |
+------------+---------------+----------+

Medium machine (251GiB memory, 176 processors)
make -j$(nproc)
+------------+---------------+----------+
| Metric (s) | Variation (%) | Delta(%) |
+------------+---------------+----------+
| real       |        0.2321 |  +0.0888 |
| user       |        0.1730 |  -0.1182 |
| sys        |        0.7680 |  +1.2067 |
+------------+---------------+----------+

Small machine (62GiB memory, 36 processors)
make -j$(nproc)
+------------+---------------+----------+
| Metric (s) | Variation (%) | Delta(%) |
+------------+---------------+----------+
| real       |        0.1920 |  -0.1270 |
| user       |        0.1730 |  -0.0358 |
| sys        |        0.7680 |  +0.9143 |
+------------+---------------+----------+

Here, variation is the coefficient of variation, i.e. standard deviation / mean.

Based on these results, there is definitely some gain to be had when
lock contention is observed in a larger machine, especially if it is running
on one node. It leads to both a measurable decrease in compilation time for
both the real and system times (i.e. relieving lock contention).

For the medium machine, there is negligible regression in real time
(<< coefficient of variation), although it leads to a measurable increase
in the system time.

For the small machine, there is a negligible performance gain in real time,
but has a similar regression to the medium machine.

Despite the regressions (~1%) of system time in the smaller machines, it
seems to be (1) not observable in realtime and (2) is much smaller than the
gain made in the large machine.

Changelog
=========
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


base-commit: 71fffcaf9c5c5eb17f90a8db478586091cd300c5
-- 
2.47.3

