Return-Path: <linux-kernel+bounces-889760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7462AC3E74A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 05:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E3D3AA0EC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 04:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8116C1E376C;
	Fri,  7 Nov 2025 04:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SwQfGsX+"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B8208D0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 04:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762490293; cv=none; b=eLp4NP94b9961iPuXJJTv701wCUSFrWmLXA2tHyMwQhww+rjLAO9hU+sZobpEHanDyU4ZSOi6xZcSx8dYPuaHn2C2Q448LeY/odSM/lmAsrcpT9e5guCqkgSqMCyAhJo7/2sD0oRYPl4J7N4zIRXnHfjDE4zLrLELwkSbsi6Ywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762490293; c=relaxed/simple;
	bh=qdG6plmlznscjkVKGzgRe5CzJDrEntrDhN7+0vxQaIM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R00NYzpOXxuxqKvjKj87w4AwgjyuhFx4a6hp0Ic1YBbdusZKKuajTjzik+9zIJTUgRXVL0r3kfK+/9QRwMdiHqLbnCU8Wqg6rtN4Nur2k/rQJ1H7Ww0XrVb/odLMppfaGKUQspGXDIFY9XPLoWrSN09xao0T+ykB5CXbuNxalLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SwQfGsX+; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8b1d8f56e24so90802485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 20:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762490291; x=1763095091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3UWVH6RdXhh/3gX60BnohFEKOsKJIXMk6D/XT076U0=;
        b=SwQfGsX+J61Fc1mKqzD380eQnA8FYCfvgL1rOnzskPE6828fy9W3uzhQYCIEt+5qnk
         8jpuNOOWf6WhNJKLQ0oNRJTzYhBR7fLfVbD+P86aGlnGIfjeiyZz/otPzwf6RombmZ+C
         sOymvj0tOFsWb6AD47bjWPfqgWGUdsGV4c+BIgvIMxfUrxNpgiQB9zY29gWy4CRnPVmv
         0Ks4XJl0MX5o5kpcs/gfciQrYqyz33x7u2rma/deWDUS1G0520Tg22VYyGVOevRPHJE3
         MdVMWmSZ125T/L/1XFlR88YQaX8FyzC7JJzzxCYJ7CZmoJfl8YKTS8TQz1xO+oIOO093
         2GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762490291; x=1763095091;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3UWVH6RdXhh/3gX60BnohFEKOsKJIXMk6D/XT076U0=;
        b=rX2RiTjmrop7ldhOyO0KZ85xY1mRmMY85uZelMXaeKVsP1yFp7D6Ht2Me9CUS5bNa9
         UiJP27jcVoF3f0z6iGJZBTmyEllv2QyyL5YPt/Pf1bSQGQEMobxwWTIXRk7clDqh5Iax
         qbnVGviyXebPCGIsB/SA7+LXF5qoMShV2CfVNbYFeNfuMXjLQtdoWoTV321H3h5Jdx/0
         cKc8Tb/Z5JwQyUBVTRVtw+BOlMcieCO/LsfF9hAYEdOrV5KFtw9Nr09ZOx5n8vmuq/BF
         KDr/Wfwya6wbB2OlRucwKArVXICdXgB6/CLpT4uJyE4eP5qpsWEUvHNmdLf8YxYt6Vnq
         Wa8g==
X-Forwarded-Encrypted: i=1; AJvYcCUBmr3B+DnGpTqEmGWHPw40PhuvYeRgv8B3u2IFXDKMdsr1YHguuFnwBp+x6pJmHXujcotuansYRm7TQy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLhQOWSndZf38dGCjP88zxfiVaRF07BS329Adc4aswDiK794SU
	sU+eAUAtoIKLbIjgaKdh50KqECh2h8dqmxp2LKZtRZTyX+dtZQ5xGFe8nnpF95FPqasMP9i1leP
	msmVWBAGQ0w==
X-Google-Smtp-Source: AGHT+IGxVxXE8E8SYRM6e1uAaED9JGXrhaJSJKUsYeQ/jY1YR9T+CJrwpSaa+7zuahl81EHHmfOajDVYM/6f
X-Received: from qvlh19.prod.google.com ([2002:a0c:f413:0:b0:880:6bc3:488e])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:3018:b0:880:3508:d420
 with SMTP id 6a1803df08f44-8817673147amr26696886d6.31.1762490290730; Thu, 06
 Nov 2025 20:38:10 -0800 (PST)
Date: Fri,  7 Nov 2025 04:38:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107043807.1758889-1-zecheng@google.com>
Subject: [PATCH v5 0/3] sched/fair: Optimize cfs_rq and sched_entity
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

v5:
- Rebased on tip/sched/core (Resolved a minor conflict in patch 3)
- Friendly ping on the series as it's not receiving any comments

v4:
https://lore.kernel.org/all/20250903194503.1679687-1-zecheng@google.com/
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
 kernel/sched/fair.c  | 85 ++++++++++++++++----------------------------
 kernel/sched/sched.h | 48 ++++++++++++++++++++-----
 4 files changed, 86 insertions(+), 89 deletions(-)


base-commit: 977b9a00541929973fddfbc2f5e932469f7cdc81
--=20
2.51.2.1041.gc1ab5b90ca-goog


