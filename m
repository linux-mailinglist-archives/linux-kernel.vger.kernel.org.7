Return-Path: <linux-kernel+bounces-774841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D579BB2B842
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A5D1B23270
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846D130F55F;
	Tue, 19 Aug 2025 04:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zys62qpD"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F08252906
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576522; cv=none; b=okMrIkA/NrYjDetwJOtQW6JhVWDGniei5UI7UPq3lWcYnfDOAscta3AV1YqTGgrrPC7hsjE42DWJlWXiTVX+aw3fHRcRxjMIxsxn/Z909+wjCRInWBMGg8tHkq/XSazPWkTzBpFpcVpWztZSY+EY0iy5HCbbzsXR2otIbB+jrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576522; c=relaxed/simple;
	bh=mqOS5432ysXTn726wxB3qOGmVAshuSniG9nDiWDQ/7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHgGS8MydcWgMZd6hS820VU/b60vkygK4eZwJAOKubB7guI2KoE2lXjlu6Km7w+vx3keoB+NssMk57j4BJEq3qIEdBA1E6j+Pwl94OjvFex6TsT3DUe0Fxbn6FC0RBLRpwYf//fiJ6tLsT64wIdFvWqP+I9THERLmSl2uxHMUlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zys62qpD; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b0bf04716aso149371cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755576520; x=1756181320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNqSNNC+ZFCES/MshdQXARqO1gw350ZAtbqLST4gBOI=;
        b=zys62qpDsrpJRnfA6rBgEar49qidzoAqCChCpHPiy4c0ibTJc1YQY6fqj0IkenAt/S
         ZPP90TZU4nRrzbF8etwFKfs6BXyeDKNwhMwAXdbkad+1zFq8xPgdm8XtnI0PHCg/Q7wi
         Ib4SI2UFefk8z0gjv1C42dgdVMTkNPtOGd96liD2AEJYNV6mXUZs9caPtvBpmDFE2M0E
         WSs2ch2XU6nYx8YimGnwUKx92holIhn8ViwvlhILK5yLQmCsKTClH/fmLOrRqL3scf8Z
         j/qxHcgDs3XC9hJ6++nWDwFqlNdjb5galLBAjKV8i92HL9z/pnsmZQtikmJ0P9gNBr4M
         epcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755576520; x=1756181320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNqSNNC+ZFCES/MshdQXARqO1gw350ZAtbqLST4gBOI=;
        b=oX0lYX7euQYPxUoOJ0FSbT0OaHgHYjjKraaQ2Lw4ENAs5lx3t09MpE3NCHAUG6tgXF
         mNNUAR83oajG8PV0cfyKWZBtcLnHnAmp5uT0qSzRIsxzzErP6OhxsMt6ae8OHciQcsAB
         /Cq4OqtNc0HfdkfkL/S6A2uwbxlradtbUJ3+AkLFi2UX3Au5xAdCcAox8C2yVSSTSQmI
         TPqGIwnhjHOuH0iS/90oQq6GiOdPYefev6f3Ctgkc8L2LmOqU5nVaUe0++xacMHSdMtE
         wl6f6JzQoYgZ42/YiZJ4KZjXb7jlVtZeJvfAJhwCu338HjZBdbW8SIKwFrEOBY7kfzhl
         XWqg==
X-Forwarded-Encrypted: i=1; AJvYcCUvFJvQqtXWjevQJ226yXLK7yElaWK4SfsSXsey6w67+yh6CmfNtIK+lRw5YMkmc1b1arArKn+emQogLuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6VpwevaHZ0VWjjqsSEoSlKub4h9FE9Z8fcuyjwUVoET5Yy9Ls
	bX15eriMQHy/7dxei4HG1jx4k8G9ibxw7/HDlgmegl6JRFuLsu9ga4x77LQiSoL9GX1V1VyWocn
	FlzxGzcaqz91x4SplaJDY2fCiErKhKbzEVSNoEfZv
X-Gm-Gg: ASbGncvpUlTF/S5p6H9p4MBw50eO18udMOgXFYcWmIb8zWHyhlwBjuQppOAAvkSn6eS
	FFp9884vJnxHuggnufUy9DxKJPHMDmbd023yfKDmhDQ075C4jMNWwU0umH64OXyxuujGNG9Z/j8
	FXV1uit9NQ+8V//jhKRylZ3XBFEqqN3orKt/EqbIJYJKNAQLciJhXLlB0NxbIpU1l141rp9GFtg
	uZtv8gv7MJC3GWgSuhE+g0=
X-Google-Smtp-Source: AGHT+IFbOGhUADqzf95dASxlMKGD6EvhrQL79SeIVQlkcYOfoGLJstTR7NEg3Eq1GC78cXJ92MVmgcUXRVtBajn4l6U=
X-Received: by 2002:a05:622a:20e:b0:4a6:907e:61ca with SMTP id
 d75a77b69052e-4b286426f44mr2557321cf.12.1755576519480; Mon, 18 Aug 2025
 21:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-1-roman.gushchin@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 18 Aug 2025 21:08:27 -0700
X-Gm-Features: Ac12FXx5DzlOVZAr-jbHhyctpcejdOKxZN_ofbcE7rl2HgLn0PJM0Trumx_iDt8
Message-ID: <CAJuCfpG1+bnFwpc4bxut_5tFtFc-s7+u2YF-suefoXq2-NijJw@mail.gmail.com>
Subject: Re: [PATCH v1 00/14] mm: BPF OOM
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:01=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> This patchset adds an ability to customize the out of memory
> handling using bpf.
>
> It focuses on two parts:
> 1) OOM handling policy,
> 2) PSI-based OOM invocation.
>
> The idea to use bpf for customizing the OOM handling is not new, but
> unlike the previous proposal [1], which augmented the existing task
> ranking policy, this one tries to be as generic as possible and
> leverage the full power of the modern bpf.
>
> It provides a generic interface which is called before the existing OOM
> killer code and allows implementing any policy, e.g. picking a victim
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

s/on/of ?


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
> [1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@byt=
edance.com/
> [2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
> [3]: https://github.com/facebookincubator/oomd
> [4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd=
.service.html
>
> ----
>
> v1:
>   1) Both OOM and PSI parts are now implemented using bpf struct ops,
>      providing a path the future extensions (suggested by Kumar Kartikeya=
 Dwivedi,
>      Song Liu and Matt Bobrowski)
>   2) It's possible to create PSI triggers from BPF, no need for an additi=
onal
>      userspace agent. (suggested by Suren Baghdasaryan)
>      Also there is now a callback for the cgroup release event.
>   3) Added an ability to block on oom_lock instead of bailing out (sugges=
ted by Michal Hocko)
>   4) Added bpf_task_is_oom_victim (suggested by Michal Hocko)
>   5) PSI callbacks are scheduled using a separate workqueue (suggested by=
 Suren Baghdasaryan)
>
> RFC:
>   https://lwn.net/ml/all/20250428033617.3797686-1-roman.gushchin@linux.de=
v/
>
>
> Roman Gushchin (14):
>   mm: introduce bpf struct ops for OOM handling
>   bpf: mark struct oom_control's memcg field as TRUSTED_OR_NULL
>   mm: introduce bpf_oom_kill_process() bpf kfunc
>   mm: introduce bpf kfuncs to deal with memcg pointers
>   mm: introduce bpf_get_root_mem_cgroup() bpf kfunc
>   mm: introduce bpf_out_of_memory() bpf kfunc
>   mm: allow specifying custom oom constraint for bpf triggers
>   mm: introduce bpf_task_is_oom_victim() kfunc
>   bpf: selftests: introduce read_cgroup_file() helper
>   bpf: selftests: bpf OOM handler test
>   sched: psi: refactor psi_trigger_create()
>   sched: psi: implement psi trigger handling using bpf
>   sched: psi: implement bpf_psi_create_trigger() kfunc
>   bpf: selftests: psi struct ops test
>
>  include/linux/bpf_oom.h                       |  49 +++
>  include/linux/bpf_psi.h                       |  71 ++++
>  include/linux/memcontrol.h                    |   2 +
>  include/linux/oom.h                           |  12 +
>  include/linux/psi.h                           |  15 +-
>  include/linux/psi_types.h                     |  72 +++-
>  kernel/bpf/verifier.c                         |   5 +
>  kernel/cgroup/cgroup.c                        |  14 +-
>  kernel/sched/bpf_psi.c                        | 337 ++++++++++++++++++
>  kernel/sched/build_utility.c                  |   4 +
>  kernel/sched/psi.c                            | 130 +++++--
>  mm/Makefile                                   |   4 +
>  mm/bpf_memcontrol.c                           | 166 +++++++++
>  mm/bpf_oom.c                                  | 157 ++++++++
>  mm/oom_kill.c                                 | 182 +++++++++-
>  tools/testing/selftests/bpf/cgroup_helpers.c  |  39 ++
>  tools/testing/selftests/bpf/cgroup_helpers.h  |   2 +
>  .../selftests/bpf/prog_tests/test_oom.c       | 229 ++++++++++++
>  .../selftests/bpf/prog_tests/test_psi.c       | 224 ++++++++++++
>  tools/testing/selftests/bpf/progs/test_oom.c  | 108 ++++++
>  tools/testing/selftests/bpf/progs/test_psi.c  |  76 ++++
>  21 files changed, 1845 insertions(+), 53 deletions(-)
>  create mode 100644 include/linux/bpf_oom.h
>  create mode 100644 include/linux/bpf_psi.h
>  create mode 100644 kernel/sched/bpf_psi.c
>  create mode 100644 mm/bpf_memcontrol.c
>  create mode 100644 mm/bpf_oom.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_psi.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_oom.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_psi.c
>
> --
> 2.50.1
>

