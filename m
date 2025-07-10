Return-Path: <linux-kernel+bounces-726656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18372B00FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B791C4806F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600312BE053;
	Thu, 10 Jul 2025 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRRZnrCL"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D59523B633
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191501; cv=none; b=bwz8WzpOI2QIKQJIphDkgqnjxqe1mE6Gv2innjkEMLpHuS2FfmdsYDOXeiCUQwrMRNY2gklZ9TsBjY6iJpAuBn8VeUB0tkUjjPjJfVYLsTkndbZclFgjXJLD7sWbtc3D3O1yf/z4VtfXAPfKyYq5da/9aX0su6jKhsdygzTcpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191501; c=relaxed/simple;
	bh=mR3hKL4006lNXeWoyrAObzB7lC9oJY+/4hZS1S/YOZE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=GQnwzDuyS2yBb66UGHHjwrW6g866tOYXspDEJ0ajqxHTBEVhQD+jmSXHlRe1xzdOCqC80Fu0R3sJpGP4M4RgjItCXF9XsVkrn7kIzVvKN2aYh0E4TojDaayQsSXxziBsZ8i1Kx+6gPJ3jBw5H6Gf5+kPveeT/qRiAxsw+CMbCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fRRZnrCL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2365ab89b52so12709135ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191499; x=1752796299; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=celNuYroIp3J9KU0cyOBYFGwYA9LApothfDFpqHh4Cg=;
        b=fRRZnrCLNIFE6L6hdsjhhGX8tkk+BuyrQMzzsK5eAaYs3RktXiPlF//fp/84VEGPK6
         YL45mXVYLKpqVyQR4k2aiPQXI52AcKpnAL4sIDnar4LC7dvNOxhRhI5E/H0W3NWSZRE6
         mE0oz8IHHxtBtYzmRgYBjo5GAIBsfDgdTU5UlAeka+KOb7tTOg639UIwsY2HUBAv379w
         Z6YM767rFpkIR8dVzMcyNTJxSEmy77xidADb9xs5Vw2Ipdn3An9kj+3iYVrLwV1+N1tF
         9Lp2NGETuQBzgNuMGNqs59nMVaQuSboYt7Lx9KhFjj2HwwiAAoS7PXmdKBviSyXLY5PO
         sFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191499; x=1752796299;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=celNuYroIp3J9KU0cyOBYFGwYA9LApothfDFpqHh4Cg=;
        b=EgelDQ5hxGzGi7s2M0UxZrMPNmNLKv27T4IEA23gImyMK9FK2VLGaX3VlGYyMirn0d
         k3l1qigA+hKuPvd+IZwB1tUHC9Md6Hbck8Qk8PU+EZncZik1KDzU8N87Bruzh7zgIxbR
         iAgT2CHVJKPTVNmxDfPb705oKD/w8lLKyCNYG9wVy3ADBB15EDiCn1rHcXAA5yi6eo8W
         LkbickDRXc4+1lqGN0wNbzdy4b/z5101ht68RfkivsYNskGSKyn47dF5MZFHw16PeDt+
         n2LHtS8eRRCQb8ciPjo4AJCMgHELKDbW82BrZczbzgC/ytIGHZImpLbPvJUwoN3XqaE9
         I5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXc3ITfV6fs7dG7EEr8gVGUQ20KooT8HnaRgKxjeE/lOnazz5Vu6cuY3JXvh6o1GLBJjDVqa3bW9bxwLnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJRuB4iSFvtQWCJ4lvleJWtCKCGUL8JlmYmrxYMYdY2wss9U1
	zIjUO+MTThzYyucdIjR5IwTNbfPR0mXzXGPFL2OnwPhhweKA7+IFY8RWXuEtb5UgC3WwjZ6yqdX
	UZBkhoyreSg==
X-Google-Smtp-Source: AGHT+IH0qlHvzStd/u22pfsY3LHyMX+NS0a+bVXLPUmTEZZm2IrjRnrWU9RK3i+o0882hJrB6xDHFPdp7XGa
X-Received: from plbms15.prod.google.com ([2002:a17:903:acf:b0:22e:4a61:5545])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c951:b0:237:ec18:eab9
 with SMTP id d9443c01a7336-23dede856d2mr20641775ad.32.1752191499497; Thu, 10
 Jul 2025 16:51:39 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-1-irogers@google.com>
Subject: [PATCH v2 00/13] Python motivated fixes and cleanup
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Various fixes and clean ups done as part of creating the ilist app,
the v4 patch series of which is posted here:
https://lore.kernel.org/lkml/20250628000929.230406-1-irogers@google.com/

These patches are separated out to give something smaller to review
before adding features. As requested by Namhyung.

v2: Additional evlist copying fixes found by testing on hybrid. Add
    fix to set the error for out of bound cpu map and thread map item
    calls.

Ian Rogers (13):
  perf hwmon_pmu: Avoid shortening hwmon PMU name
  perf parse-events: Minor tidy up of event_type helper
  perf spark: Fix includes and add SPDX
  perf pmu: Tolerate failure to read the type for wellknown PMUs
  perf metricgroup: Factor out for-each function and move out printing
  perf stat: Move metric list from config to evlist
  perf expr: Accumulate rather than replace in the context counts
  perf jevents: If the long_desc and desc are identical then drop the
    long_desc
  perf python: In str(evsel) use the evsel__pmu_name helper
  perf python: Fix thread check in pyrf_evsel__read
  perf python: Correct pyrf_evsel__read for tool PMUs
  perf python: Improve leader copying from evlist
  perf python: Set index error for invalid thread/cpu map items

 tools/perf/builtin-script.c              |   3 +-
 tools/perf/builtin-stat.c                |  25 ++-
 tools/perf/pmu-events/empty-pmu-events.c | 128 +++++------
 tools/perf/pmu-events/jevents.py         |   3 +
 tools/perf/tests/expand-cgroup.c         |  24 +--
 tools/perf/tests/parse-metric.c          |  16 +-
 tools/perf/tests/pmu-events.c            |  30 +--
 tools/perf/util/cgroup.c                 |  23 +-
 tools/perf/util/cgroup.h                 |   3 +-
 tools/perf/util/evlist.c                 |   3 +
 tools/perf/util/evlist.h                 |   6 +
 tools/perf/util/expr.c                   |   6 +-
 tools/perf/util/hwmon_pmu.c              |   2 +-
 tools/perf/util/metricgroup.c            | 261 ++++-------------------
 tools/perf/util/metricgroup.h            |  10 +-
 tools/perf/util/parse-events.c           |  31 ++-
 tools/perf/util/parse-events.h           |   2 +-
 tools/perf/util/pmu.c                    |  37 +++-
 tools/perf/util/print-events.c           | 133 ++++++++++++
 tools/perf/util/print-events.h           |   2 +
 tools/perf/util/python.c                 | 123 ++++++++++-
 tools/perf/util/spark.c                  |   8 +-
 tools/perf/util/spark.h                  |   1 +
 tools/perf/util/stat-display.c           |  16 +-
 tools/perf/util/stat-shadow.c            |  13 +-
 tools/perf/util/stat.h                   |  12 +-
 26 files changed, 473 insertions(+), 448 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


