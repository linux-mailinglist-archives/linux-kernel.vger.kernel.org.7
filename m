Return-Path: <linux-kernel+bounces-646171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8E0AB58E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 17:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4B5189E5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE3E2BE110;
	Tue, 13 May 2025 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZ4vE0Sc"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3762BE0FD
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150851; cv=none; b=WuwurTHJbMpPi1tH9SZT3D0x1jQ1ho+ClZxy5D8aEkn4l0FyHnAxEPy/7oBu7NukplzBAC/jb/tAOy6wN8MhuXrG/ljgQ7a3o4kFnzUFYJjJxMni7Z5x2FKOX68VIOdhfmFef1Lka0paYMG94teiw6QYkdQC0K5/UAWjlJCRYl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150851; c=relaxed/simple;
	bh=hyE02uffCisRLBkyOtw9LrSHs8FxQD7E+Xr/OIWSyzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/W/MYllXXlAWqPMkDph7zvDoIIE9DoplnLH0Un58RYo2rIAJNtNUkhqXIQNkHXxui8vsPaGls5VG6yjW6++nlk21ZLaTCuuVQQHAQP8tLksyCmTOLF28rWnR8XlP7qXnd0XaH7u6iFLkelqLZz3lebBiBFW1PZ7/dfIT+wZGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZ4vE0Sc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e39fbad5fso206385ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747150848; x=1747755648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea5n2QyD+yZiBVof1AFZWHWr5ChFbnoJqPYBlz0v8Nk=;
        b=OZ4vE0ScsPsdZ17IHe11+Vb2tbz04bQVN5J/qKJ7SIt9KgKhtTOc1tb7k6RoZx2s/M
         gzTvxokBrJRJKJqkvOSogBje3zT9bbHR1TNNs9S3MrLM22+Sd1aSp8zZYIQrJvhWmO3B
         xipvilt4HiP+BdtjZGJWXTIz8t/sI1N7zMr/3gRq3pbgHf4ml6ylys/xe4JkELm4GhSk
         XdSr1VdWvn0xvmAk6UTnxFGeL4l5fRtBxwY8Hq7CLQMYhSH0Eplj3xihnPWqiy17QqjO
         cPkyVgi19mYgW0S1Z52204h/T8NygFW7T08ddx4qntlcrFBfG5dLqGranFHokSUk7daa
         SQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747150848; x=1747755648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ea5n2QyD+yZiBVof1AFZWHWr5ChFbnoJqPYBlz0v8Nk=;
        b=uwyEyxFi/d+Bpu4MOWSQZYD0Iuscg9V1Jh1Eg1GxjX78Es44SfpnYztvo3b4oR5ltb
         e4FUrmlId0Uu/DrW1ya8MdPZrqn4VFbFAYPTbvxnJWSvuv/6A548eLy/wIMNEnqfhAIK
         ZjmOP//QuTFmUG1QI4AegVNWx6T/Y68mAa9pLarh36s+I68RUJr7gqQEEl3E2lXBc+1u
         bEzkN24prsjdZVrrgO7s9ltKXoHDkmgR2Dyd1wlxNBNkM1cCs2AjqNdYweFaZYYIWDnX
         si3HYgaUY7XucSnLU6H63oAMzHCcLn8cR5E4nnP93ePvOMquJ7LeGIJAnu4bYwsvgO66
         +QMg==
X-Forwarded-Encrypted: i=1; AJvYcCUBhFh5XIEORS/hgL77cSUjHN++DCP7l1AWG5kce+9lZ8VUHF/241eDjpO+sa8QPXDCwcQi4Z0RqaKHByc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwQN/dmAoXTbN01HJMVruN3U5WE3jDXvBNazEmYxXBVE/dBKty
	foHM2G9BTCVLPl6jLw9IgC0kqnDjrRVuuQBB0uA/+nEKl1IZhao1k78o2DuKbi7AF+Bk6i5YeIm
	EONs1Qz4Tk40/t+fYa1cNfPlKzr8NXEYecusNsawc
X-Gm-Gg: ASbGncvfqS3rIHgytD3qVMy/dv6WMXqCe6Rw0FRp4CUlwmgrWcG6qBXmid1L8rEze4g
	69n7zHzL0mNY8JbQz6H8HYbKBJsFr8jvrXL16p+V825elwSMP2MXvmMMXyOv/hbk8CyVIPL5c2j
	sHIdBqqRCNVXrx5waPqs9T80okMgrHcrzhiWKvjBqwvgV3sAQaFrLlKx/ylIagSA==
X-Google-Smtp-Source: AGHT+IHhK+BK/AEcSCCKlfbmPcEgf1Qc2uX6m1Sx/pAVBhn3HNL5/59AhXBRz1DYFBhpdS5MCdR6S3zmZOEBbB4VSpc=
X-Received: by 2002:a17:903:1cd:b0:21d:dd8f:6e01 with SMTP id
 d9443c01a7336-23180386216mr2827915ad.5.1747150848199; Tue, 13 May 2025
 08:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508163127.726660-1-thomas.falcon@intel.com>
In-Reply-To: <20250508163127.726660-1-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 May 2025 08:40:36 -0700
X-Gm-Features: AX0GCFvh8Qp2JsOiEjLENxYCp139FIA6Ble_962vLMn-hjg8Lfv4R65ej1rdHHs
Message-ID: <CAP-5=fVJWSyymbbk30Cx6Dhk-nTQJUUM-oOTrBCJuS6Q5az9Ag@mail.gmail.com>
Subject: Re: [PATCH v2] perf top: populate PMU capabilities data in perf_env
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 9:31=E2=80=AFAM Thomas Falcon <thomas.falcon@intel.c=
om> wrote:
>
> Calling perf top with branch filters enabled on Intel CPU's
> with branch counters logging (A.K.A LBR event logging [1]) support
> results in a segfault.

At some point we should add a `perf top` shell test and include
regression tests for cases like this.

> Thread 27 "perf" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7fffafff76c0 (LWP 949003)]
> perf_env__find_br_cntr_info (env=3D0xf66dc0 <perf_env>, nr=3D0x0, width=
=3D0x7fffafff62c0) at util/env.c:653
> 653                     *width =3D env->cpu_pmu_caps ? env->br_cntr_width=
 :
> (gdb) bt
>  #0  perf_env__find_br_cntr_info (env=3D0xf66dc0 <perf_env>, nr=3D0x0, wi=
dth=3D0x7fffafff62c0) at util/env.c:653
>  #1  0x00000000005b1599 in symbol__account_br_cntr (branch=3D0x7fffcc3db5=
80, evsel=3D0xfea2d0, offset=3D12, br_cntr=3D8) at util/annotate.c:345
>  #2  0x00000000005b17fb in symbol__account_cycles (addr=3D5658172, start=
=3D5658160, sym=3D0x7fffcc0ee420, cycles=3D539, evsel=3D0xfea2d0, br_cntr=
=3D8) at util/annotate.c:389
>  #3  0x00000000005b1976 in addr_map_symbol__account_cycles (ams=3D0x7fffc=
d7b01d0, start=3D0x7fffcd7b02b0, cycles=3D539, evsel=3D0xfea2d0, br_cntr=3D=
8) at util/annotate.c:422
>  #4  0x000000000068d57f in hist__account_cycles (bs=3D0x110d288, al=3D0x7=
fffafff6540, sample=3D0x7fffafff6760, nonany_branch_mode=3Dfalse, total_cyc=
les=3D0x0, evsel=3D0xfea2d0) at util/hist.c:2850
>  #5  0x0000000000446216 in hist_iter__top_callback (iter=3D0x7fffafff6590=
, al=3D0x7fffafff6540, single=3Dtrue, arg=3D0x7fffffff9e00) at builtin-top.=
c:737
>  #6  0x0000000000689787 in hist_entry_iter__add (iter=3D0x7fffafff6590, a=
l=3D0x7fffafff6540, max_stack_depth=3D127, arg=3D0x7fffffff9e00) at util/hi=
st.c:1359
>  #7  0x0000000000446710 in perf_event__process_sample (tool=3D0x7fffffff9=
e00, event=3D0x110d250, evsel=3D0xfea2d0, sample=3D0x7fffafff6760, machine=
=3D0x108c968) at builtin-top.c:845
>  #8  0x0000000000447735 in deliver_event (qe=3D0x7fffffffa120, qevent=3D0=
x10fc200) at builtin-top.c:1211
>  #9  0x000000000064ccae in do_flush (oe=3D0x7fffffffa120, show_progress=
=3Dfalse) at util/ordered-events.c:245
>  #10 0x000000000064d005 in __ordered_events__flush (oe=3D0x7fffffffa120, =
how=3DOE_FLUSH__TOP, timestamp=3D0) at util/ordered-events.c:324
>  #11 0x000000000064d0ef in ordered_events__flush (oe=3D0x7fffffffa120, ho=
w=3DOE_FLUSH__TOP) at util/ordered-events.c:342
>  #12 0x00000000004472a9 in process_thread (arg=3D0x7fffffff9e00) at built=
in-top.c:1120
>  #13 0x00007ffff6e7dba8 in start_thread (arg=3D<optimized out>) at pthrea=
d_create.c:448
>  #14 0x00007ffff6f01b8c in __GI___clone3 () at ../sysdeps/unix/sysv/linux=
/x86_64/clone3.S:78
>
> The cause is that perf_env__find_br_cntr_info tries to access a
> null pointer pmu_caps in the perf_env struct. A similar issue exists
> for homogeneous core systems which use the cpu_pmu_caps structure.
>
> Fix this by populating cpu_pmu_caps and pmu_caps structures with
> values from sysfs when calling perf top with branch stack sampling
> enabled.
>
> [1], LBR event logging introduced here:
> https://lore.kernel.org/all/20231025201626.3000228-5-kan.liang@linux.inte=
l.com/
>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
> v2: update commit message with more meaningful stack trace from
>     gdb and indicate that affected systems are limited to CPU's
>     with LBR event logging support and that both hybrid and
>     non-hybrid core systems are affected.
> ---
>  tools/perf/builtin-top.c |   8 +++
>  tools/perf/util/env.c    | 114 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/env.h    |   1 +
>  3 files changed, 123 insertions(+)
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 1061f4eebc3f..c2688e4ef3c4 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1729,6 +1729,14 @@ int cmd_top(int argc, const char **argv)
>         if (opts->branch_stack && callchain_param.enabled)
>                 symbol_conf.show_branchflag_count =3D true;
>
> +       if (opts->branch_stack) {
> +               status =3D perf_env__read_core_pmu_caps(&perf_env);
> +               if (status) {
> +                       pr_err("PMU capability data is not available\n");
> +                       goto out_delete_evlist;
> +               }
> +       }
> +
>         sort__mode =3D SORT_MODE__TOP;
>         /* display thread wants entries to be collapsed in a different tr=
ee */
>         perf_hpp_list.need_collapse =3D 1;
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 36411749e007..37ed6dc52cf3 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -416,6 +416,120 @@ static int perf_env__read_nr_cpus_avail(struct perf=
_env *env)
>         return env->nr_cpus_avail ? 0 : -ENOENT;
>  }
>
> +static int __perf_env__read_core_pmu_caps(struct perf_pmu *pmu,

Prefer "const struct perf_pmu *pmu" to show that it doesn't change within.

> +                                         int *nr_caps, char ***caps,
> +                                         unsigned int *max_branches,
> +                                         unsigned int *br_cntr_nr,
> +                                         unsigned int *br_cntr_width)
> +{
> +       struct perf_pmu_caps *pcaps =3D NULL;
> +       char *ptr, **tmp;
> +       int ret =3D 0;
> +
> +       *nr_caps =3D 0;
> +       *caps =3D NULL;
> +
> +       if (!pmu->nr_caps)
> +               return 0;
> +
> +       *caps =3D zalloc(sizeof(char *) * pmu->nr_caps);
> +       if (!*caps)
> +               return -ENOMEM;
> +
> +       tmp =3D *caps;
> +       list_for_each_entry(pcaps, &pmu->caps, list) {
> +
> +               if (asprintf(&ptr, "%s=3D%s", pcaps->name, pcaps->value) =
< 0) {
> +                       ret =3D -ENOMEM;
> +                       goto error;
> +               }
> +
> +               *tmp++ =3D ptr;
> +
> +               if (!strcmp(pcaps->name, "branches"))
> +                       *max_branches =3D atoi(pcaps->value);
> +
> +               if (!strcmp(pcaps->name, "branch_counter_nr"))
> +                       *br_cntr_nr =3D atoi(pcaps->value);
> +
> +               if (!strcmp(pcaps->name, "branch_counter_width"))
> +                       *br_cntr_width =3D atoi(pcaps->value);
> +       }
> +       *nr_caps =3D pmu->nr_caps;
> +       return 0;
> +error:
> +       while (tmp-- !=3D *caps)
> +               free(*tmp);
> +       free(*caps);
> +       *caps =3D NULL;
> +       *nr_caps =3D 0;
> +       return ret;
> +}
> +
> +int perf_env__read_core_pmu_caps(struct perf_env *env)
> +{
> +       struct perf_pmu *pmu =3D NULL;
> +       struct pmu_caps *pmu_caps;
> +       int nr_pmu =3D 0, i =3D 0, j;
> +       int ret;
> +
> +       nr_pmu =3D perf_pmus__num_core_pmus();
> +
> +       if (!nr_pmu)
> +               return -ENODEV;
> +
> +       if (nr_pmu =3D=3D 1) {
> +               pmu =3D perf_pmus__scan_core(NULL);

There is perf_pmus__find_core_pmu for this, not sure why this is in
pmu.h rather than pmus.h though.

Thanks,
Ian

> +               if (!pmu)
> +                       return -ENODEV;
> +               ret =3D perf_pmu__caps_parse(pmu);
> +               if (ret < 0)
> +                       return ret;
> +               return __perf_env__read_core_pmu_caps(pmu, &env->nr_cpu_p=
mu_caps,
> +                                                     &env->cpu_pmu_caps,
> +                                                     &env->max_branches,
> +                                                     &env->br_cntr_nr,
> +                                                     &env->br_cntr_width=
);
> +       }
> +
> +       pmu_caps =3D zalloc(sizeof(*pmu_caps) * nr_pmu);
> +       if (!pmu_caps)
> +               return -ENOMEM;
> +
> +       while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> +               if (perf_pmu__caps_parse(pmu) <=3D 0)
> +                       continue;
> +               ret =3D __perf_env__read_core_pmu_caps(pmu, &pmu_caps[i].=
nr_caps,
> +                                                    &pmu_caps[i].caps,
> +                                                    &pmu_caps[i].max_bra=
nches,
> +                                                    &pmu_caps[i].br_cntr=
_nr,
> +                                                    &pmu_caps[i].br_cntr=
_width);
> +               if (ret)
> +                       goto error;
> +
> +               pmu_caps[i].pmu_name =3D strdup(pmu->name);
> +               if (!pmu_caps[i].pmu_name) {
> +                       ret =3D -ENOMEM;
> +                       goto error;
> +               }
> +               i++;
> +       }
> +
> +       env->nr_pmus_with_caps =3D nr_pmu;
> +       env->pmu_caps =3D pmu_caps;
> +
> +       return 0;
> +error:
> +       for (i =3D 0; i < nr_pmu; i++) {
> +               for (j =3D 0; j < pmu_caps[i].nr_caps; j++)
> +                       free(pmu_caps[i].caps[j]);
> +               free(pmu_caps[i].caps);
> +               free(pmu_caps[i].pmu_name);
> +       }
> +       free(pmu_caps);
> +       return ret;
> +}
> +
>  const char *perf_env__raw_arch(struct perf_env *env)
>  {
>         return env && !perf_env__read_arch(env) ? env->arch : "unknown";
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index d90e343cf1fa..135a1f714905 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -152,6 +152,7 @@ struct btf_node;
>
>  extern struct perf_env perf_env;
>
> +int perf_env__read_core_pmu_caps(struct perf_env *env);
>  void perf_env__exit(struct perf_env *env);
>
>  int perf_env__kernel_is_64_bit(struct perf_env *env);
> --
> 2.49.0
>

