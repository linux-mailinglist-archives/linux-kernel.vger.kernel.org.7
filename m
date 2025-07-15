Return-Path: <linux-kernel+bounces-732471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE5B0674E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B664E0483
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D68F270ECB;
	Tue, 15 Jul 2025 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oD1gVVFn"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD0B672
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609359; cv=none; b=JzukflfjXFHyNaqFIp6huGLPVWHo7NKdX9fw/Djw6dAOEkoRER3u0BKZWjHg9Eddy6UcNUISI/9YdSUR/mu6vbbj1sLfKOOBUbTDXfu0CN6O0IxGyVSZtstw+wRvEozB9B+oyr3Zh3KYjo8BQRNsXoCMmFGNBX9Tw4Yjq/vjnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609359; c=relaxed/simple;
	bh=12q3VCBZrNOc2nq+dHbl5NnMmeNaOvVfPA3h3X1cfRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tJ7i1C2f7Xz4LaVGGbmtWK8eM2Z+uKyA4pWPlDHqMRSX6l1twVCU2/plGf/i4rVujXbHsYwOqw6fIyDcpuhvOxuRVIRBmcI36NpbympL1pP8yXMhdT/GjFFkrTxYwMmlA4C8aS/Yj4b9V59YDgh2bZ0mL/RnMKjjvyYDvshX8h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oD1gVVFn; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so46835ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752609357; x=1753214157; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8NGzdL+oq3HRN7zaWJJ87MC6Pv7VHTg9tCKEmTKJZY=;
        b=oD1gVVFnku0DcBVPrLxKsCOF1nJAenNORJ2oOkMzXTOQxW5doJvgHRi2kAfcZMUeC6
         w3NWuLy643LRLaEz+rkNO5aKY2KsWf75MPIRsd1FHHX86AJnTLPyKr2A7wXG2VDYiTu9
         eLKaOUBOTTQ9N7iSAn8okzvnaaktdjx6bvncFatA2s3gNlQCSBh3LEOdDbQ0F4uS751B
         S2SA+WLb3t7Asi7Q2Vn1FKa8jb2oy2yEvJ2hoS4FWsnOXTKrPkWD7JCs0hfOe7NqyJfz
         o+ApMnj9KJlv/asqNXu71lH6i0NjlLj9Kafvh6KPjIViExnFBZ/4+jSH+I6CdfR0ub5Z
         CnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752609357; x=1753214157;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8NGzdL+oq3HRN7zaWJJ87MC6Pv7VHTg9tCKEmTKJZY=;
        b=Z4iEHvcGZu9xBx5gmS7TfPkPcTrnKy8b1iB6r3orksylqUYqH+Bm3fVWKYg8oLrLOp
         Pa/IfnZd9LK4Qn+aPorekPLw5G5ZTkqB+IAhx8T4ZwE2WH8KaIt7cg3i8e3FY5/+Z4oS
         tljv5BTrjCJfgAyvLhyLFQjdf5zrVpCW9oxlzdry2Q1wZMGS+dWlia2GjlQd/8PzMsf+
         MmqcK3UKkxFBKyX0tiAZuHAHxnjs/wPzUsU0IunXUNkq8i4QAEi8/MA7HFSRkln4PcBl
         9l0dnRsbPL2fHbVPBeeJUYX2Y2Ozut6jhGsTW6VYrjV43PXktQaoeQcv6xc6Ouj9ceVt
         O/xA==
X-Forwarded-Encrypted: i=1; AJvYcCUBwaSNapozMyUl+CTbSW+HDpNVHTDi0nxPbEcS6YDpTjjBsWTQPQ0nFBKnuEURffs7aJYa/4JkuVQF0NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAY0Q0q9WgmJsUnp4W+FFLwWJsYxCDKFoF7eGF6kDnu6+OOjt
	6LpRB9EVHqrZ3WV6pP716b0dAiBEA3AyymlUarPsjoz1VhyRFKqhkphXx5nTMJMfv05igM2RsxM
	/+QxF1RZF77T6b7U8DeUOnHVEj6FxTc8KALhxS8MK
X-Gm-Gg: ASbGnctojBQF9ot9AjaG4VTn/cnJdABrVP5DAmv2Lz8JAlMQANgMllm7zNW5cmi/PuV
	4NEqGooCCeR/afbVdL4jkk+jtpthErbI7vsX+Lhstyb39LUS+2hdtHoXemc21As5VY4GJAS/vK4
	qFPgnJkZw1oGft8fnw93hO6KC0XlJftOE+WMLzbeSJEM62UuLoeRZ5W52Vtplr7LJvI48FIJLMy
	FD6kIuD+eZJlcFqA9IWmTVu7zFajOZkzIS6fng0AnM6kR8=
X-Google-Smtp-Source: AGHT+IEMaV3yeSFiMGvf4PnpbpG4ighbGc4V9C9Mlt98DW7OT44WBnEtK5ZInX/eQq32VHLE0L0Xn9gxQYIhun7fjis=
X-Received: by 2002:a05:6e02:2290:b0:3dd:c526:434f with SMTP id
 e9e14a558f8ab-3e282e478femr90005ab.9.1752609357070; Tue, 15 Jul 2025 12:55:57
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Jul 2025 12:55:45 -0700
X-Gm-Features: Ac12FXzzPScp-mVL9bARhLKOMJXjxqb02Nbekgkj01rdRvZZwU0lmA8JhBTzNh4
Message-ID: <CAP-5=fUu6_gOD8=5pNc2XbWc6ueHR_FpM6XF51=mdf9L0V0X2w@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] CPU mask improvements/fixes particularly for hybrid
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 12:24=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On hybrid systems some PMUs apply to all core types, particularly for
> metrics the msr PMU and the tsc event. The metrics often only want the
> values of the counter for their specific core type. These patches
> allow the cpu term in an event to give a PMU name to take the cpumask
> from. For example:
>
>   $ perf stat -e msr/tsc,cpu=3Dcpu_atom/ ...
>
> will aggregate the msr/tsc/ value but only for atom cores. In doing
> this problems were identified in how cpumasks are handled by parsing
> and event setup when cpumasks are specified along with a task to
> profile. The event parsing, cpumask evlist propagation code and perf
> stat code are updated accordingly.
>
> The final result of the patch series is to be able to run:
> ```
> $ perf stat --no-scale -e 'msr/tsc/,msr/tsc,cpu=3Dcpu_core/,msr/tsc,cpu=
=3Dcpu_atom/' perf test -F 10
>  10.1: Basic parsing test                                            : Ok
>  10.2: Parsing without PMU name                                      : Ok
>  10.3: Parsing with PMU name                                         : Ok
>
>  Performance counter stats for 'perf test -F 10':
>
>         63,704,975      msr/tsc/
>         47,060,704      msr/tsc,cpu=3Dcpu_core/                        (4=
.62%)
>         16,640,591      msr/tsc,cpu=3Dcpu_atom/                        (2=
.18%)
> ```
>
> This has (further) identified a kernel bug for task events around the
> enabled time being too large leading to invalid scaling (hence the
>  --no-scale in the command line above).
>
> Ian Rogers (12):
>   perf parse-events: Warn if a cpu term is unsupported by a CPU
>   perf stat: Avoid buffer overflow to the aggregation map
>   perf stat: Don't size aggregation ids from user_requested_cpus
>   perf parse-events: Allow the cpu term to be a PMU
>   perf tool_pmu: Allow num_cpus(_online) to be specific to a cpumask
>   libperf evsel: Rename own_cpus to pmu_cpus
>   libperf evsel: Factor perf_evsel__exit out of perf_evsel__delete
>   perf evsel: Use libperf perf_evsel__exit
>   perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
>   perf parse-events: Minor __add_event refactoring
>   perf evsel: Add evsel__open_per_cpu_and_thread
>   perf parse-events: Support user CPUs mixed with threads/processes

Ping.

Thanks,
Ian

>  tools/lib/perf/evlist.c                 | 118 ++++++++++++++++--------
>  tools/lib/perf/evsel.c                  |   9 +-
>  tools/lib/perf/include/internal/evsel.h |   3 +-
>  tools/perf/builtin-stat.c               |   9 +-
>  tools/perf/tests/event_update.c         |   4 +-
>  tools/perf/util/evlist.c                |  15 +--
>  tools/perf/util/evsel.c                 |  55 +++++++++--
>  tools/perf/util/evsel.h                 |   5 +
>  tools/perf/util/expr.c                  |   2 +-
>  tools/perf/util/header.c                |   4 +-
>  tools/perf/util/parse-events.c          | 102 ++++++++++++++------
>  tools/perf/util/pmus.c                  |  29 +++---
>  tools/perf/util/pmus.h                  |   2 +
>  tools/perf/util/stat.c                  |   6 +-
>  tools/perf/util/synthetic-events.c      |   4 +-
>  tools/perf/util/tool_pmu.c              |  56 +++++++++--
>  tools/perf/util/tool_pmu.h              |   2 +-
>  17 files changed, 297 insertions(+), 128 deletions(-)
>
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

