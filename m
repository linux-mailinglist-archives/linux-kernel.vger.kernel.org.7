Return-Path: <linux-kernel+bounces-737511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CCBB0AD86
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40624E82CE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CF417BB21;
	Sat, 19 Jul 2025 03:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dsha6KDL"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E4510A3E
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894332; cv=none; b=gvZMutxrrZ9qIbQP/Mcbt3gDlTm9w3cZFFvikcPDUvdal8f3xPMvg3z4A+l2i6bjiGlp84CIjbA4gikWoGQMx8PbtLqwrLbzQzNNcOqF0aOhYyKRPM6OqLwXU3arb23wzomP2y0zQ+z9MqZrZLSrLkdBP4VnkLvmImvwx/zRBP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894332; c=relaxed/simple;
	bh=HVbdRO3fXtbaJl20WHynvio6GFq0aXcE5wnvaZs5A18=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=TN/ug0cEt1EULs0Olxa46bj1pAwb0yJl6vYctKCeOc1yAeS6vKGIjx23G6mLcACN/Zi7iYOYSwVUp8kuo6X3yfsayhL8PLwRUIGTXqCmd8OeraD+ZFQj+CwLgn6AVywODRwv5FVF8EXa/2+oSAtJyfYHv6mM4mfPjTokGnfycek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dsha6KDL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2369261224bso27598005ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894330; x=1753499130; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZSAaYjQadlJ5t8OLt3QyjXK3Oc1PimyC7G7VWhUz2A=;
        b=Dsha6KDLhnrNScw1c1ndF7D3i/iE8XCQ3J03QPzNNADQkppdp4JYgxQfEp4TooZYil
         nqoAJprG6HgGlQsQ07Yh+8n0k6c+kQ0D9EOr41/M5XP98DM3lXOl2PIsjxZrqe6p4Vmg
         9wo/Ig6Aw+IAkXGj45cdqq5QdCoXT4L3r+OdwXgovFcDPPgRRhgk6DKdj4A3IDpzX4Om
         K4Nu1Lh/fwjxHXbksQjUmMmir+dHNaVOmJILynb+RPTflb71wN/VMVI48jaEEHFxgKGn
         gapyTTIFpCf4Jp/aAyrv+HOJxFZA83WWzNgl2Xf9C7Gbum0YT0PJeLjoTOFFAw5UiVDJ
         ETzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894330; x=1753499130;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZSAaYjQadlJ5t8OLt3QyjXK3Oc1PimyC7G7VWhUz2A=;
        b=XXjs7EALKP1Ux3ruVWIcsNf9p6fsAtHs3oT9uzV3Za0WPyp9ETkSxWIukxDIuV/pke
         CUGyhABPKfwbb+G1nlHGOg8cHvy73aaOCqQBYUQzTuzRpM/E2WmKDNjhcp72YU+c4vtZ
         NTQyFbVjDpD8FX6HXjOkNVJOohHaG0rN/mjXfKweEw+ESbUc8X0hwDLbhmj3E8WMZCR/
         9aVqseHWU3p2q4w0yUfj9Nd0tHyHQHbZ4gZVEDZ9aBXknTZdBkUacU2X44lNwT1wzm+R
         M3WArQ98YrpwJdYU6eneMjTth4dyDBDfzNP6tWSStUps6a8lzhqTEEto/hyAxe/lnxL0
         oC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUFgF+Vb4542v9Hkw4yWQ69mA270K67zo7bxrTzLkg2Rgk4xiuuvBaysUiL38utfBTrS85Mnyuw3inAyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdb90t8v4lE0zmL/dqfAjiCFXjbLisc/ZEBROiiIujaQvXUJvV
	3EXDv+5iCK6cPg+ULprd2aKb0ZSgRZQsRkKpzt5nq1zgP+6sGLioPdJnLZWYiHeOwbPvG8XfZKs
	AgGqDQJoUjw==
X-Google-Smtp-Source: AGHT+IE+gNU99Avc91IEZFlBaOvZsdVDrA/2mGusfGYOIagrdmcHM8Bp6WZxhUhREiHnXWPMTb7qw+gvXZNa
X-Received: from pjbsi4.prod.google.com ([2002:a17:90b:5284:b0:311:4aa8:2179])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da4b:b0:237:ed38:a5b3
 with SMTP id d9443c01a7336-23e256937femr184001685ad.8.1752894330554; Fri, 18
 Jul 2025 20:05:30 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-1-irogers@google.com>
Subject: [PATCH v3 00/15] Fixes for Intel TMA, particularly for hybrid
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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

Additionally the series corrects topdown event processing and starts
injecting slots events as preparation for TMA 5.1 whose updates will
be sent as a follow-up patch series.

v3: Fix CPU map computation for uncore/requires_cpu, don't simplify
    for the "any"(-1) CPU case. Combine with topdown slots/fix and
    injection previously:
    https://lore.kernel.org/lkml/20250718132750.1546457-1-irogers@google.com/
    This has a grouping fix added for the injected slots event.  Add
    new no grouping constraint for threshold + NMI for issue with
    alderlake metrics failing to schedule when thresholds are enabled
    along with the NMI watchdog.

v2: Add additional documentation of the cpu term to `perf list`
    (Namhyung), extend the term to also allow CPU ranges. Add Thomas
    Falcon's reviewed-by. Still open for discussion whether the term
    cpu should have >1 variant for PMUs, etc. or whether the single
    term is okay. We could refactor later and add a term, but that
    would break existing users, but they are most likely to be metrics
    so probably not a huge issue.

Ian Rogers (15):
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
  perf topdown: Use attribute to see an event is a topdown metic or
    slots
  perf parse-events: Fix missing slots for Intel topdown metric events
  perf metricgroups: Add NO_THRESHOLD_AND_NMI constraint

 tools/lib/perf/evlist.c                  | 119 +++++++++++++++-------
 tools/lib/perf/evsel.c                   |   9 +-
 tools/lib/perf/include/internal/evsel.h  |   3 +-
 tools/perf/Documentation/perf-list.txt   |  25 +++--
 tools/perf/arch/x86/include/arch-tests.h |   4 +
 tools/perf/arch/x86/tests/Build          |   1 +
 tools/perf/arch/x86/tests/arch-tests.c   |   1 +
 tools/perf/arch/x86/tests/topdown.c      |  76 ++++++++++++++
 tools/perf/arch/x86/util/evlist.c        |  24 +++++
 tools/perf/arch/x86/util/evsel.c         |  46 +++------
 tools/perf/arch/x86/util/topdown.c       |  59 +++++++----
 tools/perf/arch/x86/util/topdown.h       |   6 ++
 tools/perf/builtin-stat.c                |   9 +-
 tools/perf/pmu-events/jevents.py         |   1 +
 tools/perf/pmu-events/pmu-events.h       |  14 ++-
 tools/perf/tests/event_update.c          |   4 +-
 tools/perf/tests/parse-events.c          |  24 ++---
 tools/perf/util/evlist.c                 |  15 +--
 tools/perf/util/evlist.h                 |   1 +
 tools/perf/util/evsel.c                  |  55 ++++++++--
 tools/perf/util/evsel.h                  |   5 +
 tools/perf/util/expr.c                   |   2 +-
 tools/perf/util/header.c                 |   4 +-
 tools/perf/util/metricgroup.c            |  16 ++-
 tools/perf/util/parse-events.c           | 122 ++++++++++++++++++-----
 tools/perf/util/pmus.c                   |  29 +++---
 tools/perf/util/pmus.h                   |   2 +
 tools/perf/util/stat.c                   |   6 +-
 tools/perf/util/synthetic-events.c       |   4 +-
 tools/perf/util/tool_pmu.c               |  56 +++++++++--
 tools/perf/util/tool_pmu.h               |   2 +-
 31 files changed, 532 insertions(+), 212 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/topdown.c

-- 
2.50.0.727.gbf7dc18ff4-goog


