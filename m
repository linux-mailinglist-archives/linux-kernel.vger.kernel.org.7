Return-Path: <linux-kernel+bounces-739708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CE7B0C9E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AED91AA2F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614492E1749;
	Mon, 21 Jul 2025 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2nRDaue"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C701FE44B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119864; cv=none; b=KPGXuwSc827NMol1iYCm5P2wchKf2I36rwPcRL7Aa7d1WKQEoAmFLkDZDVvsU03yEBX6nboZwVw/DHKx0xHZmWg8+lsUdSPeZQZaIHoWrU075L3LKkCBKQJd5ONjHKsTszqnvQrQFYtyETwn7Bm71VrRg59R5p71LsyGMJppBf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119864; c=relaxed/simple;
	bh=gMH6XWwqPJ0KzuGVPJGnJLnVUyLkQtBSTcgdZ47J/ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHPo89+ltQC7Or2y5uNEx+L9svty+/2uwYYbDuEfp2aoRNXA7i91RzaopfRcjhsvDHhzhfhO49v/3B+upk+zjQ6cjOYlzUYyGsSonr8zQmS3kUhvgKFYIs+lhLYLJTph07lAtmO+xYMHiKwygNeq1OEdabvGK+GyTyTGUGAT7k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2nRDaue; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so15945ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753119861; x=1753724661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE+GRkINH0q4J2wZRJaye5qXuEiNH8J9d8HS1b8aa/0=;
        b=q2nRDaueapAE9RsJIiVuwpV3/7RpUa1KVuj1isWGsJQnGupYzaTVPbpkE8VWMtyN3W
         T9YtLSe+NNESSQShslcM+UHdTjaEFvC4qsphz6Pll/UTK+LOUnwtHEBc/rJTLXQ34ms6
         CCcOHWNBFYpsp5ocu7HtUdue/b/sEOzlup8PDkaGf/6JX46KmWUiJGJNiN89k4TnOlUO
         oLtabyHzjHjo2xq9oFabfJ3jyTaWZ5olTuQWulqQiOUI6MrdfPW4cnjjJtnnQfDL07xD
         Y8CXysJSHoV3yBdmcY+2jIhyC0g+KMz0985kVc4ktHCHLqkbS4HEWYZCnEqMYmL1K3bj
         mBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753119861; x=1753724661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YE+GRkINH0q4J2wZRJaye5qXuEiNH8J9d8HS1b8aa/0=;
        b=vU93Pw51/8zwHWOlTZne12cMKFHzvTtE0h/JmnIP99nA0OpUNkfFU8FYJriUxVbKnq
         vL2tK5y/s+E8N4M2eKRXBh/Wl682KBeETtrDJuJpT41d628T3KV4246lgVJrtb3bhZYw
         IP8Fh+GKgoYcGXX1K1+hlO7bXx3xODk6wBpoSPGl62t+0L+mm2IGUwG9ubNG6kDaHv6j
         wDlGpkTma6OLd8Zk5UIl88CVlUPcH9jz5rc5Brcz60zBgWf78ZaDKv2OjMaMT3nIU+bs
         Dolg/XG9BOq1Ke33HFkmk0OZ7e0SM22LfsO+9ZlnowN4NBaETJVWkSoux/DQ6jRwOANP
         z61A==
X-Forwarded-Encrypted: i=1; AJvYcCXjzCdPbtTUPCpAjbGVDzMaur9Gpv69aq/ekk9RkAhCpvTXEQeQyoKvF5yPMhHCwwlNejRM3b6b9thli/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywti/l++J3pk9rzdbPnYmBb+C6reNxi8vbuwTYMQ70XAWuAcUnf
	WXF3xVWQgKMRl3IflrWIsKiQl91vOvdXrp+fg5cza2kHH1iNUwd6hvc2SONhYD4N07DIESZDS5k
	TJxWexs1qaYcCuc7NAXd5yR6BQi6xakI+08lAEexO
X-Gm-Gg: ASbGncvK+zNQ9nMK9RKtp5szs9eEBRE2fGfUFJOiN3icws1e9AN76hCrOUkp5wMx1WT
	kyG1L1CigjJe8gNKYw5JKK+a+NRaPFB/5aKGFUlrcdOyNVYmNCRX310rmWC6854AeR0xQaCBP9i
	aeNq+JRI3iE3/a7B7JsBf58L49exWv81qPzAx5woOwuCg2PRLLB0oUA6aOKUbgQOahXS429UY8s
	+ki1tiR7Y9U8wL2UYoBUQSRMnmDxND62yZbvzjiP/6FQg0=
X-Google-Smtp-Source: AGHT+IE/4lxd9uJmJPv3nO7QV8baVIIzg/+rljpFRzhFU7B8j4jxoE37cl3owIVq9o4mocY9dMBk9h4rCz0IpR6VZhA=
X-Received: by 2002:a05:6e02:3e01:b0:3ce:7852:1e9 with SMTP id
 e9e14a558f8ab-3e2be737d19mr579535ab.17.1753119860921; Mon, 21 Jul 2025
 10:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com> <2b51b856-a1c6-4ff1-b336-ae612e5d1cf5@linaro.org>
In-Reply-To: <2b51b856-a1c6-4ff1-b336-ae612e5d1cf5@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Jul 2025 10:44:09 -0700
X-Gm-Features: Ac12FXxaaDJDO0VKiKSgcp4ANMZy6A7aiK0cEXQ5buqzS7Dfb2CtcNPbs8e4DcM
Message-ID: <CAP-5=fXmzETmP3Ra3z_nM-Go2X6SRZ3im+bA0CLvdXS=VtJWOw@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] CPU mask improvements/fixes particularly for hybrid
To: James Clark <james.clark@linaro.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 9:13=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 27/06/2025 8:24 pm, Ian Rogers wrote:
> > On hybrid systems some PMUs apply to all core types, particularly for
> > metrics the msr PMU and the tsc event. The metrics often only want the
> > values of the counter for their specific core type. These patches
> > allow the cpu term in an event to give a PMU name to take the cpumask
> > from. For example:
> >
> >    $ perf stat -e msr/tsc,cpu=3Dcpu_atom/ ...
> >
> > will aggregate the msr/tsc/ value but only for atom cores. In doing
> > this problems were identified in how cpumasks are handled by parsing
> > and event setup when cpumasks are specified along with a task to
> > profile. The event parsing, cpumask evlist propagation code and perf
> > stat code are updated accordingly.
> >
> > The final result of the patch series is to be able to run:
> > ```
> > $ perf stat --no-scale -e 'msr/tsc/,msr/tsc,cpu=3Dcpu_core/,msr/tsc,cpu=
=3Dcpu_atom/' perf test -F 10
> >   10.1: Basic parsing test                                            :=
 Ok
> >   10.2: Parsing without PMU name                                      :=
 Ok
> >   10.3: Parsing with PMU name                                         :=
 Ok
> >
> >   Performance counter stats for 'perf test -F 10':
> >
> >          63,704,975      msr/tsc/
> >          47,060,704      msr/tsc,cpu=3Dcpu_core/                       =
 (4.62%)
> >          16,640,591      msr/tsc,cpu=3Dcpu_atom/                       =
 (2.18%)
> > ```
> >
> > This has (further) identified a kernel bug for task events around the
> > enabled time being too large leading to invalid scaling (hence the
> >   --no-scale in the command line above).
> >
> > Ian Rogers (12):
> >    perf parse-events: Warn if a cpu term is unsupported by a CPU
> >    perf stat: Avoid buffer overflow to the aggregation map
> >    perf stat: Don't size aggregation ids from user_requested_cpus
> >    perf parse-events: Allow the cpu term to be a PMU
> >    perf tool_pmu: Allow num_cpus(_online) to be specific to a cpumask
> >    libperf evsel: Rename own_cpus to pmu_cpus
> >    libperf evsel: Factor perf_evsel__exit out of perf_evsel__delete
> >    perf evsel: Use libperf perf_evsel__exit
> >    perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
> >    perf parse-events: Minor __add_event refactoring
> >    perf evsel: Add evsel__open_per_cpu_and_thread
> >    perf parse-events: Support user CPUs mixed with threads/processes
> >
> >   tools/lib/perf/evlist.c                 | 118 ++++++++++++++++-------=
-
> >   tools/lib/perf/evsel.c                  |   9 +-
> >   tools/lib/perf/include/internal/evsel.h |   3 +-
> >   tools/perf/builtin-stat.c               |   9 +-
> >   tools/perf/tests/event_update.c         |   4 +-
> >   tools/perf/util/evlist.c                |  15 +--
> >   tools/perf/util/evsel.c                 |  55 +++++++++--
> >   tools/perf/util/evsel.h                 |   5 +
> >   tools/perf/util/expr.c                  |   2 +-
> >   tools/perf/util/header.c                |   4 +-
> >   tools/perf/util/parse-events.c          | 102 ++++++++++++++------
> >   tools/perf/util/pmus.c                  |  29 +++---
> >   tools/perf/util/pmus.h                  |   2 +
> >   tools/perf/util/stat.c                  |   6 +-
> >   tools/perf/util/synthetic-events.c      |   4 +-
> >   tools/perf/util/tool_pmu.c              |  56 +++++++++--
> >   tools/perf/util/tool_pmu.h              |   2 +-
> >   17 files changed, 297 insertions(+), 128 deletions(-)
> >
>
> Tested-by: James Clark <james.clark@linaro.org>

Much appreciated, thanks James!

There's a v2 patch set but the Tested-by will be good for the majority
of patches that are unchanged in that:
https://lore.kernel.org/lkml/20250717210233.1143622-1-irogers@google.com/
I'm of course interested in getting RFC feedback on:
https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com/
which introduces an extra state to avoid gathering enabled time on
CPUs an event can't run on.

Thanks,
Ian

