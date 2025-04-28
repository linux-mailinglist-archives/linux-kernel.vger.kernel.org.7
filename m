Return-Path: <linux-kernel+bounces-622896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D113A9EE2D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 12:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B2617CE86
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 10:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA72225F98A;
	Mon, 28 Apr 2025 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kazm+oxf"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B4525EF9F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745836997; cv=none; b=E3VfVDsQ5qWzc64062AWSg9rODjG5vnHDBGSMbwcw6xDo6og7L5ysYwFh1XYEaxkov6OSZEtM5UBv7VGuHg8KyRcI9IhKPOc/+Jq1x/pKu4QYlgvNppfWBwG1HuAOO7d80X+jW6f94g/PwgnF2ftBFmfGPrhXPbMhgidklqnZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745836997; c=relaxed/simple;
	bh=nkbUVd8tt1EFPFLGh6p3WeF8nyIWVjkHQiFP1VJdPug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV+u3+OdBfJsAkdcNvqg+e9vKdox4bdZ1nl8DruuoDOYDli2X1izecTR+2v8LGlC6zOc8w9l/lUZZgtBwaAbHmj6h+U2ajKg1D5VXCykUK3NKkd6oulZrHILQ4A1PtIWRX3v7GmxkhCcs/TS3hl9wuqSILeIVJXr+t1J2FrjXLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kazm+oxf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so537244466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 03:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745836993; x=1746441793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IK7dIbpaTofEG9W0MKimUJmh49eq3Exd9JjSGC+MWSc=;
        b=Kazm+oxfKwjAj8M4zdio0rwbB3UiNl9mbUPujQVzUE2VQS15oF9/xWv15pwhVhniEo
         mccfcly5VH6fZyiqoTwXczifk4OLBXAOzSdqULuh1R/+BGHRY+XHcj/2JkfWYEH++KAj
         SjTd3R/q1d04aVmjAUwtxDImXZ+xLTSh546HbyLsAVQRW5dm6kE44l4ispIwTnEu9Wu9
         EAh+UeJ6VLcBw+rG34K1XEedN/SpLO6qw9/h7Vd/V5BZ9UzD4ezZ0omn9FqyFmjyw7WG
         ls0uGmru0K+eIz3D5uM6LPIviNxlHUBEqTPoNHK9faad1QQHu+jyQbGSQsikBQTo6fzs
         Qo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745836993; x=1746441793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK7dIbpaTofEG9W0MKimUJmh49eq3Exd9JjSGC+MWSc=;
        b=eyeXiaqIYhZPSl4VsMNsGtjeN+U+K6E1/UzbQSDKXF1kQxqPIJ/qKetN1yxX8FtTmx
         c4GNywmW6OEHlMGU4mu3+2HsjwE4gPVFb9aVG3nA4I5+z1xlHWEL5koOBbtrjtM6dU7J
         bplOjvkzw17GeF9hkdMuicI5LfroO2CX+avlCrBeha5MEM5lrxFUHFezHzCyINzM/xMC
         cDUrL/UP9EBt7ZsrNwR7vEs3q015110A0bcsNouBTZIxdbJ+WWbVXfl3YT8HO64TORAx
         PLPWhDC5bTVy46IgRNT9YgkEE+g6jS1GqrhucOLzMH7zUGVZcDthealozbJn/Rdo4VAl
         l1oQ==
X-Gm-Message-State: AOJu0YxHIhYR2m98ux0cw0eh/WYvvhZtEBoXMGLSzgjURLWH9YLByzBk
	A6Jto8ByKzdARXPv4WPlyCEX/E1UZq87OWPCObght5/VWqtRjuOpndnxz4m5PgEb6HeVcE21Z4f
	wPg==
X-Gm-Gg: ASbGncuSUTuPQxkGO5+PggtxS2GEuCbgWUgTZJoUcsMflg/hmnpXdanYeOShULzi9mQ
	XQih6mahLlwY2qdKNa1w2l8Kzc8buClanFDlIMVvHDcI0TyQNlzBIN4+w1xv9Ouj1jbU7SS9h/j
	pjPOOKzRQqd6VBHffcNtcSVuTi2XV2B8hLnVFVqJMfoZfrVsodjv9pygLCabuySrVS3O5mqbFhs
	xw1kHL6Xn+WDSCL9mCqqEoXy3YgRkB9YS3sDrVo0dktk4GAhE7wVRrXqHAK0PxTEzYuipsfcJ1c
	Xxi62MF95njeDUsalWXM9z2cOk7O/e1kglU0GxmahzpNQlegwHTFv4bzB2TEzJWEi7sUI4IfUXv
	GA6EhKAM=
X-Google-Smtp-Source: AGHT+IHt49FasoPmpJdwq6ZuKmCYrd001aZAosiZ+1FBattCQmgQzn5vUSNbKU2Sq0zUGcO1M3eAxQ==
X-Received: by 2002:a17:907:7b9a:b0:ace:be13:64e5 with SMTP id a640c23a62f3a-acebe136fabmr63079166b.26.1745836993362;
        Mon, 28 Apr 2025 03:43:13 -0700 (PDT)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace733aa401sm569796166b.35.2025.04.28.03.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 03:43:12 -0700 (PDT)
Date: Mon, 28 Apr 2025 10:43:07 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 00/12] mm: BPF OOM
Message-ID: <aA9bu7UJOCTQGk6L@google.com>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428033617.3797686-1-roman.gushchin@linux.dev>

On Mon, Apr 28, 2025 at 03:36:05AM +0000, Roman Gushchin wrote:
> This patchset adds an ability to customize the out of memory
> handling using bpf.
> 
> It focuses on two parts:
> 1) OOM handling policy,
> 2) PSI-based OOM invocation.
> 
> The idea to use bpf for customizing the OOM handling is not new, but
> unlike the previous proposal [1], which augmented the existing task
> ranking-based policy, this one tries to be as generic as possible and
> leverage the full power of the modern bpf.
> 
> It provides a generic hook which is called before the existing OOM
> killer code and allows implementing any policy, e.g.  picking a victim
> task or memory cgroup or potentially even releasing memory in other
> ways, e.g. deleting tmpfs files (the last one might require some
> additional but relatively simple changes).
> 
> The past attempt to implement memory-cgroup aware policy [2] showed
> that there are multiple opinions on what the best policy is.  As it's
> highly workload-dependent and specific to a concrete way of organizing
> workloads, the structure of the cgroup tree etc, a customizable
> bpf-based implementation is preferable over a in-kernel implementation
> with a dozen on sysctls.
> 
> The second part is related to the fundamental question on when to
> declare the OOM event. It's a trade-off between the risk of
> unnecessary OOM kills and associated work losses and the risk of
> infinite trashing and effective soft lockups.  In the last few years
> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> systemd-OOMd [4]). The common idea was to use userspace daemons to
> implement custom OOM logic as well as rely on PSI monitoring to avoid
> stalls. In this scenario the userspace daemon was supposed to handle
> the majority of OOMs, while the in-kernel OOM killer worked as the
> last resort measure to guarantee that the system would never deadlock
> on the memory. But this approach creates additional infrastructure
> churn: userspace OOM daemon is a separate entity which needs to be
> deployed, updated, monitored. A completely different pipeline needs to
> be built to monitor both types of OOM events and collect associated
> logs. A userspace daemon is more restricted in terms on what data is
> available to it. Implementing a daemon which can work reliably under a
> heavy memory pressure in the system is also tricky.
> 
> [1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@bytedance.com/
> [2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
> [3]: https://github.com/facebookincubator/oomd
> [4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html
> 
> ----
> 
> This is an RFC version, which is not intended to be merged in the current form.
> Open questions/TODOs:
> 1) Program type/attachment type for the bpf_handle_out_of_memory() hook.
>    It has to be able to return a value, to be sleepable (to use cgroup iterators)
>    and to have trusted arguments to pass oom_control down to bpf_oom_kill_process().
>    Current patchset has a workaround (patch "bpf: treat fmodret tracing program's
>    arguments as trusted"), which is not safe. One option is to fake acquire/release
>    semantics for the oom_control pointer. Other option is to introduce a completely
>    new attachment or program type, similar to lsm hooks.

Thinking out loud now, but rather than introducing and having a single
BPF-specific function/interface, and BPF program for that matter,
which can effectively be used to short-circuit steps from within
out_of_memory(), why not introduce a
tcp_congestion_ops/sched_ext_ops-like interface which essentially
provides a multifaceted interface for controlling OOM killing
(->select_bad_process, ->oom_kill_process, etc), optionally also from
the context of a BPF program (BPF_PROG_TYPE_STRUCT_OPS)?

I don't know whether that's what you meant by introducing a new
attachment, or program type, but an approach like this is what
immediately comes to mind when wanting to provide more than a single
implementation for a set of operations within the Linux kernel,
particularly also from the context of a BPF program.

> 2) Currently lockdep complaints about a potential circular dependency because
>    sleepable bpf_handle_out_of_memory() hook calls might_fault() under oom_lock.
>    One way to fix it is to make it non-sleepable, but then it will require some
>    additional work to allow it using cgroup iterators. It's intervened with 1).
> 3) What kind of hierarchical features are required? Do we want to nest oom policies?
>    Do we want to attach oom policies to cgroups? I think it's too complicated,
>    but if we want a full hierarchical support, it might be required.
>    Patch "mm: introduce bpf_get_root_mem_cgroup() bpf kfunc" exposes the true root
>    memcg, which is potentially outside of the ns of the loading process. Does
>    it require some additional capabilities checks? Should it be removed?
> 4) Documentation is lacking and will be added in the next version.
> 
> 
> Roman Gushchin (12):
>   mm: introduce a bpf hook for OOM handling
>   bpf: mark struct oom_control's memcg field as TRUSTED_OR_NULL
>   bpf: treat fmodret tracing program's arguments as trusted
>   mm: introduce bpf_oom_kill_process() bpf kfunc
>   mm: introduce bpf kfuncs to deal with memcg pointers
>   mm: introduce bpf_get_root_mem_cgroup() bpf kfunc
>   bpf: selftests: introduce read_cgroup_file() helper
>   bpf: selftests: bpf OOM handler test
>   sched: psi: bpf hook to handle psi events
>   mm: introduce bpf_out_of_memory() bpf kfunc
>   bpf: selftests: introduce open_cgroup_file() helper
>   bpf: selftests: psi handler test
> 
>  include/linux/memcontrol.h                   |   2 +
>  include/linux/oom.h                          |   5 +
>  kernel/bpf/btf.c                             |   9 +-
>  kernel/bpf/verifier.c                        |   5 +
>  kernel/sched/psi.c                           |  36 ++-
>  mm/Makefile                                  |   3 +
>  mm/bpf_memcontrol.c                          | 108 +++++++++
>  mm/oom_kill.c                                | 140 +++++++++++
>  tools/testing/selftests/bpf/cgroup_helpers.c |  67 ++++++
>  tools/testing/selftests/bpf/cgroup_helpers.h |   3 +
>  tools/testing/selftests/bpf/prog_tests/oom.c | 227 ++++++++++++++++++
>  tools/testing/selftests/bpf/prog_tests/psi.c | 234 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/test_oom.c | 103 ++++++++
>  tools/testing/selftests/bpf/progs/test_psi.c |  43 ++++
>  14 files changed, 983 insertions(+), 2 deletions(-)
>  create mode 100644 mm/bpf_memcontrol.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/oom.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/psi.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_oom.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_psi.c
> 
> -- 
> 2.49.0.901.g37484f566f-goog
> 

