Return-Path: <linux-kernel+bounces-900019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE80C5964A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 730FC4EDEFF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B174343D75;
	Thu, 13 Nov 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBxfNVec"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83FC2F5A07
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057145; cv=none; b=srAt9FS9Ypx/FXF8WjezVROBfWlwNzqH7aqIDENmlPfPMYWI427N9MRju3uhZRogohgTstUNcnDqSbagaPWeTgyVE1YiFYr4wlUeNuhjJMq+eI57Cs6qIVprHxb1TCGhQm8Jsdb6kA+ghHcuOk+h3rFzrc+3nEzF1lYqx16KMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057145; c=relaxed/simple;
	bh=fIbR3VjoQNKuRWteZ/Rq8IE3DTA3Dc/bpXH7LDvk30o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=P55I/m4AykYLTpGncDkK18dqx30MEW43iQ1UWTDo/6uTjQS1+WxYgm7Gtq3hlTEzyLb7H7pHmCCvUFTItr61qW1p2y0T6P4AnZ3K/kml7c6P+4pvVgBrqyZTzSJw4Llffh6fw86CnLdZFGnb3e94v6dBrQ0f1YLQBrr/JPm2mrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBxfNVec; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bc0de474d4eso2283674a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057143; x=1763661943; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gyb0F2Qlt5M9tSooc4A/FTv6d1RAJam7XL9fTqtL1Ys=;
        b=HBxfNVecJ+vBbpsMTo9qdFmFNUwyjAzcSnkcS15jS+6Oj0/0wpGvtf5F/cCCIh38OS
         vdBWVc1otioAxlRgogybyKA3b+7esetSX+7G6n7wy1GbAkVKL/LcLp9JhKDfvlrj7wkk
         0qncAG3UGhFcjtuKA6c02TdGkTspfKVwZW6Q0aYakWfSdPZQmJX6tN/Tt9ebHsb6W09E
         wQPdF6jWarYEQTdoQaJdXLnDd4SebeSH6MV9VB/SiWqs1u1PGqKIieFDABjPTg0x2KfK
         tEcdAMpNT4U0mGjl54rgNVk09rk7tnTWBtTil6NOX4fudrxRhUGZu7xstMjeSp8EyGW1
         Kxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057143; x=1763661943;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyb0F2Qlt5M9tSooc4A/FTv6d1RAJam7XL9fTqtL1Ys=;
        b=OMMJAAYkO/NevVMbME53NwbBTKwaej1T53H06Eg28tVe83AqRgkZl4wqv0/GRnzGOR
         RFXAWLCLTqUSzQbYqKgD/ad6ao81bhwod3iUxKuHwI7FMfhEAlTcsFIJ9wfkSWnjwypI
         4eEvl1hHKz3I41AlBZLtRhRakpXaqXq1pQjnDgX+Rx0ZAToxbyWbCfcLIYJQ68HwkiT3
         R7lXoGW9lI8m2gHvpYOzNhDXampStw7TwpKWrliNArrBiPDQcicOEH2OGo6o9mlvsC1b
         oPpLPflTgXMBk4yFH7yWgznsD6nlFRikTVR6do7zCkpl8xU1ZN1JcpoMARIu506riEWS
         Ffog==
X-Forwarded-Encrypted: i=1; AJvYcCUQeFrmhNksXh7yBBIeLSNmVOtfsv/Un+V6mJrSmYzSBMXugnJql7XRmdm6/Hj+jToO26nA2S5xABB8nC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wL9EQP9CMcLbf/lMEjubq2im6HKOOYgotpvx+tCzXsXBS8Vt
	w1nOivPRRy9yucnaT7NuM7GzzI9WjA2hLiDjxTpU+Enhq4RYO8Tb/DeHFCNsjE0/Aj3QgwxESVD
	I61ZBd2hm8w==
X-Google-Smtp-Source: AGHT+IGp9up41YFf4S6Oc6MkFzcgJYUGUTSUzJW9WfOt4KpNF8fJnbTzSmBWND1D2Ef9BRuW2rfHT9+LwwKB
X-Received: from dlbds33.prod.google.com ([2002:a05:7022:2521:b0:11a:fa54:2242])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:a28:b0:2a4:4527:1f0
 with SMTP id 5a478bee46e88-2a4abb30665mr72844eec.34.1763057142821; Thu, 13
 Nov 2025 10:05:42 -0800 (PST)
Date: Thu, 13 Nov 2025 10:05:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113180517.44096-1-irogers@google.com>
Subject: [PATCH v4 00/10] perf stat fixes and improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

A collection of fixes aiming to stabilize and make more reasonable
measurements/metrics such as memory bandwidth.

Tool events are changed from getting a PMU cpu map of all online CPUs
to either CPU 0 or all online CPUs. This avoids iterating over useless
CPUs for events in particular `duration_time`. Fix a bug where
duration_time didn't correctly use the previous raw counts and would
skip values in interval mode.

Change how json metrics handle tool events. Use the counter value
rather than using shared state with perf stat. A later patch changes
it so that tool events are read last, so that if reading say memory
bandwidth counters you don't divide by an earlier read time and exceed
the theoretical maximum memory bandwidth.

Do some clean up around the shared state in stat-shadow that's no
longer used.

Change how affinities work with evlist__for_each_cpu. Move the
affinity code into the iterator to simplify setting it up. Detect when
affinities will and won't be profitable, for example a tool event and
a regular perf event (or read group) may face less delay from a single
IPI for the event read than from a call to sched_setaffinity. Add a
 --no-affinity flag to perf stat to allow affinities to be disabled.

v4: Rebase. Add patch to reduce scope of walltime_nsec_stats now that
    the legacy metric code is no more. Minor tweak to the ru_stats
    clean up.

v3: Add affinity clean ups and read tool events last.
https://lore.kernel.org/lkml/20251106071241.141234-1-irogers@google.com/

v2: Fixed an aggregation index issue:
https://lore.kernel.org/lkml/20251104234148.3103176-2-irogers@google.com/

v1:
https://lore.kernel.org/lkml/20251104053449.1208800-1-irogers@google.com/

Ian Rogers (10):
  libperf cpumap: Reduce allocations and sorting in intersect
  perf pmu: perf_cpu_map__new_int to avoid parsing a string
  perf tool_pmu: Use old_count when computing count values for time
    events
  perf stat-shadow: Read tool events directly
  perf stat: Reduce scope of ru_stats
  perf stat: Reduce scope of walltime_nsecs_stats
  perf tool_pmu: More accurately set the cpus for tool events
  perf evlist: Reduce affinity use and move into iterator, fix no
    affinity
  perf stat: Read tool events last
  perf stat: Add no-affinity flag

 tools/lib/perf/cpumap.c                |  29 ++--
 tools/perf/Documentation/perf-stat.txt |   4 +
 tools/perf/builtin-stat.c              | 210 +++++++++++++++----------
 tools/perf/tests/parse-metric.c        |   2 -
 tools/perf/tests/pmu-events.c          |   2 -
 tools/perf/util/config.c               |   3 +-
 tools/perf/util/drm_pmu.c              |   2 +-
 tools/perf/util/evlist.c               | 156 +++++++++++-------
 tools/perf/util/evlist.h               |  27 +++-
 tools/perf/util/hwmon_pmu.c            |   2 +-
 tools/perf/util/parse-events.c         |   9 +-
 tools/perf/util/pmu.c                  |  12 ++
 tools/perf/util/pmu.h                  |   1 +
 tools/perf/util/stat-shadow.c          | 152 ++++++++----------
 tools/perf/util/stat.h                 |  23 ---
 tools/perf/util/tool_pmu.c             |  78 ++++++---
 tools/perf/util/tool_pmu.h             |   1 +
 17 files changed, 407 insertions(+), 306 deletions(-)

-- 
2.51.2.1041.gc1ab5b90ca-goog


