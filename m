Return-Path: <linux-kernel+bounces-823496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83571B86A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CB73BD091
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF812D248F;
	Thu, 18 Sep 2025 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHGvh+Cl"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A3E221F29
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223132; cv=none; b=Pjev+mA1liM2bwm/jySM8v5RLRT//juZsBsZiypZpDvnibkEVx9sbAoBJGjjEV0MMBzX5HdI9QB2NNYAjaISFrBZkejEoZZgYujXA9ID+rdxazYafBQlTuQCjvdjtr0aMl+7DOt41ggpc9Aa24+XXr2yApzGD8a9bhrneUODuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223132; c=relaxed/simple;
	bh=cDgYun9e3nfOkp2u7si1gQ6Ej2mQhklTpFE58Ry2Zyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QP2LLcMjrX1/uScicsG3sPB6UA5ZVbQK5OBozHnefKVbFusqNQqHK+Q5uTvyheiw0pHMQeDfLAIL0soIGyZ5vcQoPOmm3Gky0ENqSCgykOeb2Ceidt6ZKC93teq4gnCLcbUfB5Ds4mHsMZ84fihZnfpK7YUZdwCk3L1KhZi2bX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aHGvh+Cl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07c081660aso232515966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758223129; x=1758827929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkfBROQ63QjcyPULBJPG+lmDgTQB5feRr1b7wuFJ0TA=;
        b=aHGvh+ClA2jp6X5UEDTBxFnst+BCIPBxIiTeLD7nrMQS/J1CT7vsm3iApAVyRRnOjr
         +zOoY0GDPdV+j1IxUsw5ySORhhi+rJqk94O5J/71zBFhn7vKeT1aGnq9OgzW0K2TzO8B
         VN0OrsdcqfjnR0clmZwrt4yWHW+Et2RRuvRI/Hz/evyaItkHEDRH98LZyN3CPNjHUZKc
         bZsfhb9JQK1S0APdfsQF1SBAgki4Ch0Nq0CnGgoN6+UIH5IENG5EEHDXEOG7A6doypC+
         wS1TJ9Em+/mIft84nBLoW9sc9jt8Lba4YWAxuOpiVWYDPPuKcSkS15rswrbqN8rF5Bxn
         mayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758223129; x=1758827929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkfBROQ63QjcyPULBJPG+lmDgTQB5feRr1b7wuFJ0TA=;
        b=b58pjgxp5xVJkgnh7zE7yrXv/NPfavUnArhP+hcspll0GoiAi5kC6GByFdg5CvHgvq
         kuXqqFvuqZlZTw9SUJImMXX9qKhvBGj/7+hdjZp3UFAyauu64zNkUfzNGttS8cpiYKL+
         CEBkvFpg0UxLDYGehGDR0pNyKDMRmUFtSLdDuv7OFSom5tFIOcT4rzJGYNtNbaiGHfUe
         Md/TTz0qB2WmHo6Xy9zh8vaUo00oCykcG98AJtu4Uzn73FqJmB1V0emB+NGQwg9AiI2y
         sdfYzSCEQKPJfL1j9BqwK6Mk2TmJCUTZQ6IqCZxqMQMKd6MCl1XXASIsmPROXDTp/BVt
         Uvkg==
X-Forwarded-Encrypted: i=1; AJvYcCWUkj79HPI0uT7YfL/yolhK3bUkb9VvYMJ09xSwgqS5/jRsFUY8QC3ev28OmUhpyPIZ4Ona6GFOIcm66Es=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl94ziiTXDyWRwlSRGp1ya7UkLMtstJmA1ARvajgFMg6Vt9a1A
	KXZoIWsW6+UvyX4IQn8vf8tDYohwpbD0bbjMCCRg+bxDnlHFJxsWAqQqPtXSsrDgHEMX2l7U64D
	pkZAmIXNW79E9xR3T6yuNVZOdDclo7xxy3AVRAeI7
X-Gm-Gg: ASbGncs8DvtMqf2XAb9AS7PoskjRQi2scHR47IiuzOPGpASoRdxgXtL9zbpvcj93P4Q
	z08UL2m2FvNwgK2d1FKeh0Z7HC29JN35X34eewFx3YrdcRYuhJDxWiC06aMV+oXHFzat6wfG0HW
	o8qgS2GqVC0ExS/6rHBc6oYroSES1hzsYQJCCKv9ZJobp8OIe8npSxipLzDqlj//jVpEPPRShoX
	9lEmtBDBg+DCoxpbi7KbHP8ixH9WXzh5SNywSStcyVx3wB45O2ZhphJY33Cjg==
X-Google-Smtp-Source: AGHT+IEa+50co5NfXzdAdPMYDRiSCqa7VovylIoYc2O24EGioaJHVSRA03KMY6RvRApScHBj5yBqahNt+5Lm3cNbZFo=
X-Received: by 2002:a17:906:d7b6:b0:b22:84c4:190c with SMTP id
 a640c23a62f3a-b24f6e92fdbmr29598366b.61.1758223128884; Thu, 18 Sep 2025
 12:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903194503.1679687-1-zecheng@google.com>
In-Reply-To: <20250903194503.1679687-1-zecheng@google.com>
From: Zecheng Li <zecheng@google.com>
Date: Thu, 18 Sep 2025 15:18:36 -0400
X-Gm-Features: AS18NWAdrIz2KNBC05HZuNErWKDS8GplLMeH_DPPOapw8EEmM0axhf_Ye9R4eZA
Message-ID: <CAJUgMyLPcWvvUzr5VJE5sttFwk9rEz9E-DB3MDkU+hF1NzJy5Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] sched/fair: Optimize cfs_rq and sched_entity
 allocation for better data locality
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Rik van Riel <riel@surriel.com>, Chris Mason <clm@fb.com>, 
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Xu Liu <xliuprof@google.com>, 
	Blake Jones <blakejones@google.com>, Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Gentle ping on this patch series. Any feedback would be appreciated.

Thanks,
Zecheng

On Wed, Sep 3, 2025 at 3:45=E2=80=AFPM Zecheng Li <zecheng@google.com> wrot=
e:
>
> Hi all,
>
> This patch series improves CFS cache performance by allocating cfs_rq
> and sched_entity together in the per-cpu allocator. It allows for
> replacing the pointer arrays in task_group with a per-cpu offset.
>
> v4:
> - Rebased on tip/sched/core
> - Intel kernel test robot results
> https://lore.kernel.org/all/202507161052.ed3213f4-lkp@intel.com/
>
> v3:
> https://lore.kernel.org/all/20250701210230.2985885-1-zecheng@google.com/
> - Rebased on top of 6.16-rc4.
> - Minor wording and comment updates.
>
> v2:
> https://lore.kernel.org/lkml/20250609193834.2556866-1-zecheng@google.com/
> - Allocate cfs_rq and sched_entity together for non-root task group
>   instead of embedding sched_entity into cfs_rq to avoid increasing the
>   size of struct rq based on the feedback from Peter Zijlstra.
>
> v1:
> https://lore.kernel.org/lkml/20250604195846.193159-1-zecheng@google.com/
>
> Accessing cfs_rq and sched_entity instances incurs many cache misses.
> This series of patches aims to reduce these cache misses. A struct
> cfs_rq instance is per CPU and per task_group. Each task_group instance
> (and the root runqueue) holds cfs_rq instances per CPU. Additionally,
> there are corresponding struct sched_entity instances for each cfs_rq
> instance (except the root). Currently, both cfs_rq and sched_entity
> instances are allocated in NUMA-local memory using kzalloc_node, and
> tg->cfs_rq and tg->se are arrays of pointers.
>
> Original memory layout:
>
>         tg->cfs_rq =3D kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
>         tg->se =3D kcalloc(nr_cpu_ids, sizeof(se), GFP_KERNEL);
>
>         +----+       +-----------------+
>         | tg | ----> | cfs_rq pointers |
>         +----+       +-----------------+
>                         |     |     |
>                         v     v     v
>                     cfs_rq cfs_rq cfs_rq
>
>         +----+       +--------------------+
>         | tg | ----> | sched_entity ptrs  |
>         +----+       +--------------------+
>                         |     |     |
>                         v     v     v
>                         se    se    se
>
> Layout after Optimization:
>
>         +--------+      | CPU 0  |      | CPU 1  |      | CPU 2  |
>         |   tg   |      | percpu |      | percpu |      | percpu |
>         |        |         ...             ...             ...
>         | percpu |  ->  | cfs_rq |      | cfs_rq |      | cfs_rq |
>         | offset |      |   se   |      |   se   |      |   se   |
>         +--------+      +--------+      +--------+      +--------+
>
> The optimization includes two parts:
>
> 1) Co-allocate cfs_rq and sched_entity for non-root task groups.
>
> - This benefits loading the sched_entity for the parent runqueue.
>   Currently it incurs pointer chasing, i.e., cfs_rq->tg->se[cpu]. After
>   co-locating, the sched_entity fields can be loaded with simple offset
>   computations from cfs_rq.
>
> 2) Allocate the combined cfs_rq/se struct using percpu allocator.
>
> - Accesses to cfs_rq instances in hot paths are mostly iterating through
>   multiple task_groups for the same CPU. Therefore, the new percpu
>   layout can reuse the base pointer, and they are more likely to reside
>   in the CPU cache than the per-task_group pointer arrays.
>
> - This optimization also reduces the memory needed for the array of
>   pointers.
>
> To measure the impact of the patch series, we construct a tree structure
> hierarchy of cgroups, with =E2=80=9Cwidth=E2=80=9D and =E2=80=9Cdepth=E2=
=80=9D parameters controlling
> the number of children per node and the depth of the tree. Each leaf
> cgroup runs a schbench workload and gets an 80% quota of the total CPU
> quota divided by number of leaf cgroups (in other words, the target CPU
> load is set to 80%) to exercise the throttling functions. Bandwidth
> control period is set to 10ms. We run the benchmark on Intel and AMD
> machines; each machine has hundreds of threads.
>
> Tests were conducted on 6.15.
>
> | Kernel LLC Misses | depth 3 width 10    | depth 5 width 4     |
> +-------------------+---------------------+---------------------+
> | AMD-orig          | [2218.98, 2241.89]M | [2599.80, 2645.16]M |
> | AMD-opt           | [1957.62, 1981.55]M | [2380.47, 2431.86]M |
> | Change            | -11.69%             | -8.248%             |
> | Intel-orig        | [1580.53, 1604.90]M | [2125.37, 2208.68]M |
> | Intel-opt         | [1066.94, 1100.19]M | [1543.77, 1570.83]M |
> | Change            | -31.96%             | -28.13%             |
>
> There's also a 25% improvement on kernel IPC on the AMD system. On
> Intel, the improvement is 3% despite a greater LLC miss reduction.
>
> Other workloads without CPU share limits, while also running in a cgroup
> hierarchy with O(1000) instances, show no obvious regression:
>
> sysbench, hackbench - lower is better; ebizzy - higher is better.
>
> workload  | base                  | opt                   | metric
> ----------+-----------------------+-----------------------+------------
> sysbench  | 63.55, [63.04, 64.05] | 64.36, [62.97, 65.75] | avg latency
> hackbench | 36.95, [35.45, 38.45] | 37.12, [35.81, 38.44] | time
> ebizzy    | 610.7, [569.8, 651.6] | 613.5, [592.1, 635.0] | record/s
>
> Zecheng Li (3):
>   sched/fair: Co-locate cfs_rq and sched_entity
>   sched/fair: Remove task_group->se pointer array
>   sched/fair: Allocate both cfs_rq and sched_entity with per-cpu
>
>  kernel/sched/core.c  | 40 ++++++++-------------
>  kernel/sched/debug.c |  2 +-
>  kernel/sched/fair.c  | 83 ++++++++++++++++----------------------------
>  kernel/sched/sched.h | 48 ++++++++++++++++++++-----
>  4 files changed, 85 insertions(+), 88 deletions(-)
>
>
> base-commit: 5b726e9bf9544a349090879a513a5e00da486c14
> --
> 2.51.0.338.gd7d06c2dae-goog
>

