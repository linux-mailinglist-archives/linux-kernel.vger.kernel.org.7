Return-Path: <linux-kernel+bounces-735971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD27B09631
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6A21897165
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA7422A4D6;
	Thu, 17 Jul 2025 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLHPVMcf"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE052F88
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786160; cv=none; b=tV6n5hKhB6601qe1qE3YW8b7pvuh7x0lSr5fRqsAFdAtTA+NlCUQamXeZJgTPSsqmr4uOjMX3ND1wgntzfWvPE90ELNupQf/gtJH5oZ0XxmzGbPp+8KSExZK41EuT8jWPwXk8stv5BefP8+kFoljTcXwea185kDpRYVYAF0qsPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786160; c=relaxed/simple;
	bh=bCCI2zvUeW+gZ95v4lkX9Vu3DsGU7yXnViX2eqAKJ7I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=QgRT6u1DkUwWx5kdl8fAUCNXIfwGA2CuhFBJsUIsk+pR7tY2PPQopBbXbT9cFdy9qIFccYw34DjJKGW90OQLFTxd096fi71FwfVM9uFq/zowEcEPCo1FrGaprfq5tY6Afqm+AFxluvkwKIcNLjq7tJL0pTKlvIFIwuB+6CeUTZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLHPVMcf; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2e92a214e2eso842378fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786157; x=1753390957; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EUH7/AbQMHdQqD+cQPUAn1qDYsUVoUhx4dva1qRM1T4=;
        b=WLHPVMcfqK1aCli8hV71AgQUU3vmgqDwtqWLTMAvm7YgIbgZqWfpl9CgMb0GJZRSmI
         55485NDzTFlI1DNAbiLgItRCAW7gyD+N/Le8BiZck+rEUt9m6pZjxALiyHubYXeXTSMk
         /njCTzI8NCMGflF4iSbru3rz7fx5Wkmz/Hpi2U5F07Xq+6pPhfGEAgy/WnUokCTkQ844
         oURKTt/MvFNZmF5YsH4vX1ajfSGmVLPtbbViuXWRvsuQJjnMu8NLN3ryWmbxmBzX2nRG
         gruvPj7BFQdJtcwic72elNdzIACw67KNndIB0cJqG6oI6XiF3PgzKeIzy4n6UUUOXg9N
         X/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786157; x=1753390957;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUH7/AbQMHdQqD+cQPUAn1qDYsUVoUhx4dva1qRM1T4=;
        b=KgL4ftijvimVIZ0EeWBm97RP3fGc3GaOn7v2/tzjPV4KYMXu3pcImIKkaN24TZ8BEp
         XI+8/4A4So2e8KMpPffAYgvF+7SlUAdaM87TUy45ZN6eiywLrydVHg3DHzbkR3pFdGUQ
         aktkQ7eI1sU5SZwpztqV0014XKjIox1GNt94KNST4Qq4+umI65mt7s//OEEzQIdNoX4U
         sZk96UVpdRaQbth4cQwpWRhHOVugSfw8W6DhKLcXLwzF8ana7cA0rjYvvT2ADBsM7eIZ
         f9GDYHkaYhm2sjrCSZ3uI4VNkULtqNh2TCJuGg67F9A9Xx1j/jAuyoIBb5IeKjZdO75I
         C8fw==
X-Forwarded-Encrypted: i=1; AJvYcCXsJeN5mWB0xdSjfHsrF3oim27p5RIIul8zxLUlFWKFjG6YF5xu6uFIHypXLqDf1//W5Sn0iQe9gmJGdMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSe9t0u1BFgbHzfNO13/2UtE5bnklczhHDExsfV7ktJVTKqt5j
	nrRtEke3CF1P0Cn3sKr5NvVzGUSbQen2dTUzb4wOQ6CXNQFjadm6jHPKhvArZ8ZMcRUmJBR0HUl
	hcvDR2taWnw==
X-Google-Smtp-Source: AGHT+IGkT2rIGjpqUTb43dbha9PwKAQOwATfoofE8ueKnjC1omTJdss35zG/q9MzKaq5J5XtMYUkuxWIU4Yc
X-Received: from oabov6.prod.google.com ([2002:a05:6870:cb86:b0:2ff:99a8:c5f2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:46aa:b0:2ff:a87d:5c71
 with SMTP id 586e51a60fabf-300ea46cd02mr365109fac.33.1752786157607; Thu, 17
 Jul 2025 14:02:37 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-1-irogers@google.com>
Subject: [PATCH v2 00/12] CPU mask improvements/fixes particularly for hybrid
From: Ian Rogers <irogers@google.com>
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

On hybrid systems some PMUs apply to all core types, particularly for
metrics the msr PMU and the tsc event. The metrics often only want the
values of the counter for their specific core type. These patches
allow the cpu term in an event to give a PMU name to take the cpumask
from. For example:

  $ perf stat -e msr/tsc,cpu=cpu_atom/ ...

will aggregate the msr/tsc/ value but only for atom cores. In doing
this problems were identified in how cpumasks are handled by parsing
and event setup when cpumasks are specified along with a task to
profile. The event parsing, cpumask evlist propagation code and perf
stat code are updated accordingly.

The final result of the patch series is to be able to run:
```
$ perf stat --no-scale -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' perf test -F 10
 10.1: Basic parsing test                                            : Ok
 10.2: Parsing without PMU name                                      : Ok
 10.3: Parsing with PMU name                                         : Ok

 Performance counter stats for 'perf test -F 10':

        63,704,975      msr/tsc/
        47,060,704      msr/tsc,cpu=cpu_core/                        (4.62%)
        16,640,591      msr/tsc,cpu=cpu_atom/                        (2.18%)
```

This has (further) identified a kernel bug for task events around the
enabled time being too large leading to invalid scaling (hence the
 --no-scale in the command line above).

v2: Add additional documentation of the cpu term to `perf list`
    (Namhyung), extend the term to also allow CPU ranges. Add Thomas
    Falcon's reviewed-by. Still open for discussion whether the term
    cpu should have >1 variant for PMUs, etc. or whether the single
    term is okay. We could refactor later and add a term, but that
    would break existing users, but they are most likely to be metrics
    so probably not a huge issue.

Ian Rogers (12):
  perf parse-events: Warn if a cpu term is unsupported by a CPU
  perf stat: Avoid buffer overflow to the aggregation map
  perf stat: Don't size aggregation ids from user_requested_cpus
  perf parse-events: Allow the cpu term to be a PMU or CPU range
  perf tool_pmu: Allow num_cpus(_online) to be specific to a cpumask
  libperf evsel: Rename own_cpus to pmu_cpus
  libperf evsel: Factor perf_evsel__exit out of perf_evsel__delete
  perf evsel: Use libperf perf_evsel__exit
  perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
  perf parse-events: Minor __add_event refactoring
  perf evsel: Add evsel__open_per_cpu_and_thread
  perf parse-events: Support user CPUs mixed with threads/processes

 tools/lib/perf/evlist.c                 | 118 ++++++++++++++++--------
 tools/lib/perf/evsel.c                  |   9 +-
 tools/lib/perf/include/internal/evsel.h |   3 +-
 tools/perf/Documentation/perf-list.txt  |  25 +++--
 tools/perf/builtin-stat.c               |   9 +-
 tools/perf/tests/event_update.c         |   4 +-
 tools/perf/util/evlist.c                |  15 +--
 tools/perf/util/evsel.c                 |  55 +++++++++--
 tools/perf/util/evsel.h                 |   5 +
 tools/perf/util/expr.c                  |   2 +-
 tools/perf/util/header.c                |   4 +-
 tools/perf/util/parse-events.c          | 112 ++++++++++++++++------
 tools/perf/util/pmus.c                  |  29 +++---
 tools/perf/util/pmus.h                  |   2 +
 tools/perf/util/stat.c                  |   6 +-
 tools/perf/util/synthetic-events.c      |   4 +-
 tools/perf/util/tool_pmu.c              |  56 +++++++++--
 tools/perf/util/tool_pmu.h              |   2 +-
 18 files changed, 323 insertions(+), 137 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


