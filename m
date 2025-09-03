Return-Path: <linux-kernel+bounces-799328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BA5B42A1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1F01BC817F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646F0369356;
	Wed,  3 Sep 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cW3oElhy"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32591E2823
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928710; cv=none; b=lxHSoHfRAK0xDLFl6LEJobcblYZhaV7uDgKmplqQvH36w8sr9HsWymmKDZCRRYWlJJQRR7Ttz8J9OZ/jIIdJyIqf9jEQjMHNJo9fK8ZGGahUdJ4KbDXymW0jx53/wRuNHFnx5raUaOzD9vq4y4De5TAm7pOe7ALRUogr/BS8x0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928710; c=relaxed/simple;
	bh=uWzjqmQIG4k31OlBFSmCoKMTTMiPti69jEIbMuo41wA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lNhjF+krPTPFF3y76uUqjpNnPAg3OjOHUQ3pg/w92bjC9m/QTTPo7k3BVaIC0wQx8T6Y+DWJC1CAbfmYBBNOZ38wx/9i8qM8ViBR8OjQLreXcpU2s3mANVSvJIKiY+Pjxkx21CUdZuxbVH8lHk7aV6Zcur/8jRoJlK8cBEhubiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cW3oElhy; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e9bde4276dbso551079276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756928708; x=1757533508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iehMtbdD4LBLObSEFMyTyur8BiJApXl+pKwM8Q2hU7k=;
        b=cW3oElhyf57lAM8lrln4K0Z7lAJkx6f4lD5Zgx5LqSTxZj22NOHdbG889/+37ha5dQ
         84Fj5yqrVzOwufX58PpbJO9htFKOj0QE2kzbWfM0us6zIxKkfWygPHHyltV1MFOQjoxV
         udqTzSaO3Unh9/xJr1UHSH8bfMIZcDG7AiydtTH0/PVmz8K0/knG4DjDAh3/0oyNE/a4
         JGXZaWsB00wPz1WTewyU2C8KnI8W0BKx6NeBYmNKQ34EtKMxEFjue7tP1gmIOjScQDHn
         buSr5DzQYh1bviE+3+BG9ooE2yggmPv0dJ2wwdYJbEkIR9sh8/HXArQJmo8rql+x6Bf1
         VDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756928708; x=1757533508;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iehMtbdD4LBLObSEFMyTyur8BiJApXl+pKwM8Q2hU7k=;
        b=PSekY/Z3IMkIOW+534iRfKAUx6BCa4SJLiRE8YrQDIt+01uQY1zTgw5vzFc7567/pP
         VejmEDQYJBc5aKGc5umsaTUXi9rOoYtNzOZtpWKkF2tZRX5McwObCcrh6q0SdbyQnLre
         4E/BJZcYJ6O3SN5y0WKjpwipWd1XmGAO9gtC0qG76aX74GWRLW7cvqWdLNYmKfhNh4WS
         8p0rArWfqszK4GG1uGEdA8Pu6PXDvMMqTc5xKdlljAgHLK6PSDfADtzYza1Jw8VbPFla
         MhqI7zi7Cm/wp5vK/y1yxdonpMxG7X6PwbFs3tK+ybwLOdxxNV7vHz/iIPyeUAqwkahU
         7QNw==
X-Forwarded-Encrypted: i=1; AJvYcCVqakUoy6bUTWmPh8dkh28fkWSn5jyDVXnKaLbSLZMtx3JoeeZmoQkqcRJIyIkEiFTlorXm125V4eu5CTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqW/ln8VDIX22PbfJ7J8kD/GzxagNwDWVEB2QU1Kd9rFRJnGfs
	mFRvRfpBXNlDYLxRWR/LctPSUfZZVOpz2psHinpyv+pMy10Gncxy8wH7nwQncaV+ombPJ33YnD9
	X54n4WOVvaQ==
X-Google-Smtp-Source: AGHT+IG4UWSHWswdmh/H0fjdii02QFhJD2yg5dlshis1dtwlmtDmIpE2xaZHVN3xrXbr3pY/rcP0sqoqGlWO
X-Received: from ywr7.prod.google.com ([2002:a05:690c:9987:b0:71a:2cf5:ad7])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:4194:b0:5fc:229:51c9
 with SMTP id 956f58d0204a3-601756acdb8mr853410d50.5.1756928707912; Wed, 03
 Sep 2025 12:45:07 -0700 (PDT)
Date: Wed,  3 Sep 2025 19:44:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903194503.1679687-1-zecheng@google.com>
Subject: [PATCH v4 0/3] sched/fair: Optimize cfs_rq and sched_entity
 allocation for better data locality
From: Zecheng Li <zecheng@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Rik van Riel <riel@surriel.com>, Chris Mason <clm@fb.com>, 
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Xu Liu <xliuprof@google.com>, 
	Blake Jones <blakejones@google.com>, Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org, 
	Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

This patch series improves CFS cache performance by allocating cfs_rq
and sched_entity together in the per-cpu allocator. It allows for
replacing the pointer arrays in task_group with a per-cpu offset.

v4:
- Rebased on tip/sched/core
- Intel kernel test robot results
https://lore.kernel.org/all/202507161052.ed3213f4-lkp@intel.com/

v3:
https://lore.kernel.org/all/20250701210230.2985885-1-zecheng@google.com/
- Rebased on top of 6.16-rc4.
- Minor wording and comment updates.

v2:
https://lore.kernel.org/lkml/20250609193834.2556866-1-zecheng@google.com/
- Allocate cfs_rq and sched_entity together for non-root task group
  instead of embedding sched_entity into cfs_rq to avoid increasing the
  size of struct rq based on the feedback from Peter Zijlstra.

v1:
https://lore.kernel.org/lkml/20250604195846.193159-1-zecheng@google.com/

Accessing cfs_rq and sched_entity instances incurs many cache misses.
This series of patches aims to reduce these cache misses. A struct
cfs_rq instance is per CPU and per task_group. Each task_group instance
(and the root runqueue) holds cfs_rq instances per CPU. Additionally,
there are corresponding struct sched_entity instances for each cfs_rq
instance (except the root). Currently, both cfs_rq and sched_entity
instances are allocated in NUMA-local memory using kzalloc_node, and
tg->cfs_rq and tg->se are arrays of pointers.

Original memory layout:

	tg->cfs_rq =3D kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
	tg->se =3D kcalloc(nr_cpu_ids, sizeof(se), GFP_KERNEL);

	+----+       +-----------------+
	| tg | ----> | cfs_rq pointers |
	+----+       +-----------------+
	                |     |     |
	                v     v     v
	            cfs_rq cfs_rq cfs_rq

	+----+       +--------------------+
	| tg | ----> | sched_entity ptrs  |
	+----+       +--------------------+
	                |     |     |
	                v     v     v
	                se    se    se

Layout after Optimization:

	+--------+      | CPU 0  |	| CPU 1  |	| CPU 2  |
	|   tg   |      | percpu |	| percpu |	| percpu |
	|        |         ...             ...             ...
	| percpu |  ->  | cfs_rq |	| cfs_rq |	| cfs_rq |
	| offset |      |   se   |	|   se   |	|   se   |
	+--------+      +--------+	+--------+	+--------+

The optimization includes two parts:

1) Co-allocate cfs_rq and sched_entity for non-root task groups.

- This benefits loading the sched_entity for the parent runqueue.
  Currently it incurs pointer chasing, i.e., cfs_rq->tg->se[cpu]. After
  co-locating, the sched_entity fields can be loaded with simple offset
  computations from cfs_rq.

2) Allocate the combined cfs_rq/se struct using percpu allocator.

- Accesses to cfs_rq instances in hot paths are mostly iterating through
  multiple task_groups for the same CPU. Therefore, the new percpu
  layout can reuse the base pointer, and they are more likely to reside
  in the CPU cache than the per-task_group pointer arrays.

- This optimization also reduces the memory needed for the array of
  pointers.

To measure the impact of the patch series, we construct a tree structure
hierarchy of cgroups, with =E2=80=9Cwidth=E2=80=9D and =E2=80=9Cdepth=E2=80=
=9D parameters controlling
the number of children per node and the depth of the tree. Each leaf
cgroup runs a schbench workload and gets an 80% quota of the total CPU
quota divided by number of leaf cgroups (in other words, the target CPU
load is set to 80%) to exercise the throttling functions. Bandwidth
control period is set to 10ms. We run the benchmark on Intel and AMD
machines; each machine has hundreds of threads.

Tests were conducted on 6.15.

| Kernel LLC Misses | depth 3 width 10    | depth 5 width 4     |
+-------------------+---------------------+---------------------+
| AMD-orig          | [2218.98, 2241.89]M | [2599.80, 2645.16]M |
| AMD-opt           | [1957.62, 1981.55]M | [2380.47, 2431.86]M |
| Change            | -11.69%             | -8.248%             |
| Intel-orig        | [1580.53, 1604.90]M | [2125.37, 2208.68]M |
| Intel-opt         | [1066.94, 1100.19]M | [1543.77, 1570.83]M |
| Change            | -31.96%             | -28.13%             |

There's also a 25% improvement on kernel IPC on the AMD system. On
Intel, the improvement is 3% despite a greater LLC miss reduction.

Other workloads without CPU share limits, while also running in a cgroup
hierarchy with O(1000) instances, show no obvious regression:

sysbench, hackbench - lower is better; ebizzy - higher is better.

workload  | base                  | opt                   | metric
----------+-----------------------+-----------------------+------------
sysbench  | 63.55, [63.04, 64.05] | 64.36, [62.97, 65.75] | avg latency
hackbench | 36.95, [35.45, 38.45] | 37.12, [35.81, 38.44] | time
ebizzy    | 610.7, [569.8, 651.6] | 613.5, [592.1, 635.0] | record/s

Zecheng Li (3):
  sched/fair: Co-locate cfs_rq and sched_entity
  sched/fair: Remove task_group->se pointer array
  sched/fair: Allocate both cfs_rq and sched_entity with per-cpu

 kernel/sched/core.c  | 40 ++++++++-------------
 kernel/sched/debug.c |  2 +-
 kernel/sched/fair.c  | 83 ++++++++++++++++----------------------------
 kernel/sched/sched.h | 48 ++++++++++++++++++++-----
 4 files changed, 85 insertions(+), 88 deletions(-)


base-commit: 5b726e9bf9544a349090879a513a5e00da486c14
--=20
2.51.0.338.gd7d06c2dae-goog


