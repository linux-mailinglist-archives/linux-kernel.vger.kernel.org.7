Return-Path: <linux-kernel+bounces-799931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA42B4315F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEF2568624
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC027E1DC;
	Thu,  4 Sep 2025 04:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yAR3xII1"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789127BF7E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961259; cv=none; b=TtayanQq1wRDndQkELE7s3GSsNBxX2adCQu/RA5x4BzhQl24FdSEoiyS1Fcx7zlPtu9L024dtuHvX4T+P0pp6Ubnc4fhJdWSHhYXwjmOMlYlYh/pmscEbfzEh/Abe6w9tKPkuypicnYT/kiMnbOte0YzW8R8PqRzAZf8BOyCNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961259; c=relaxed/simple;
	bh=WgVcgUdPY54/oQ+eQT+NZOGinWPMmAbwiaLX87/GM0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gyeBc+N1xPtPFi2WAsAl5loC0gvVWPgrDmxNVHVZ7to1GOJK623lu3rvvCx/0lgfpREgSwqW3d/xwWmesYyDVIbBSFa3H+DegSvZXXyk1W6bWI2cnVcG9ubFdbPHHhzj7UT71Zff4J+Q8n9ziwHYm+577tOShPmuVeUquGgQ1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yAR3xII1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445803f0cfso9811805ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961258; x=1757566058; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeKqI6ebNZk2OSGf7DnIa24sXNm81pvOyP36Y1EWvxI=;
        b=yAR3xII13+c7nxK6jXxpaeWXk+YtpYYRsxaahrS5ddVl68UhVRAYKTl4CePZ6WJIef
         3lgvvSCTmgCf8LV8ZOXhayMVNrwDeHZqpMdFLQVRNNQonpjeP8JJ3onj5cHTVGzIUUQk
         nDJsODthAxFZHgI/eO0iBSJZ5jP4TZoPsaMONj4YUnAynhu6Tmk2KJW2YWxyNVSTpMKB
         bO6qWXohSvBXA5ssSoEZx721q8E+TlsT2I0HrSnjfCWyUVtTMQAYnAnZgwNum8XEF81F
         XEtU9pqYzb8Cwgw1I07kmNb33NSvAJnJ+brfXN9D5VOWrv/kod0RXJavrM0CNWwBdr2b
         c2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961258; x=1757566058;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeKqI6ebNZk2OSGf7DnIa24sXNm81pvOyP36Y1EWvxI=;
        b=E43T11XqD0LRmNPxGdTzjerrGTadwRlxYeLJXUFXKi3+ZH9bt6/JYqIE80Mp43Uefo
         bGEVzN616sgdD7nuM5TQB84NMBzOKa4N5VWoUWg2u75zzDB0peiRPtH8F2yXmprEYegO
         7lJ17v2BBo0yMrrlWzWa1v6GOFqALTZ2f7jIPSGgeeMqjTshTwgug81i2vym1ioznFpA
         qbczfZe9yFw/5v+8nidT2w1Kmf38u73HRCWImQXKsl7XIART1zww1JD7oiBCx71vxf23
         TEZhlbb5EdQmIsD+32eQ4rWCx6yqroNrQYaheZdfYqTlKs9aLDtQxCt0B5qlixNxg9IZ
         nZ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxi/+7y0uWyTGiPcD9CIspEmnCEJqnpQgSkdXx0HJ7HnaGHoGvAk4LJqroas4GjmbThmVgFuBoraxOINc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySC6VcSfHV33gRCP8KSCbvXyWM+LuYLMxuaI4xAY6I3aRXVjjB
	oVj7kRhbEwwWtPRtWWO0nFWjjmdDEwYyGxwO5jX6YR4yG2v7MlCek4QOwMcd4f7xYxd7mntK0G0
	jCfLBP+dmSA==
X-Google-Smtp-Source: AGHT+IGoORPmYjgWxJS10suOpl3A8FHJZo0ncTb0Cn+5QwvLUoT3l8NO/UcjqQFK/RincPcsu8phd8kZmz9j
X-Received: from ploc11.prod.google.com ([2002:a17:902:848b:b0:24b:bbf5:4bc7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22cf:b0:246:80b1:8c87
 with SMTP id d9443c01a7336-24944b2a6d0mr202623705ad.43.1756961257708; Wed, 03
 Sep 2025 21:47:37 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:52 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-22-irogers@google.com>
Subject: [PATCH v6 21/22] perf jevents: Add upi_bw metric for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Break down UPI read and write bandwidth using uncore_upi counters.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 47e8f1166870..e639e8998d87 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1009,6 +1009,27 @@ def UncoreMemBw() -> Optional[MetricGroup]:
   ], description = "Memory Bandwidth")
 
 
+def UncoreUpiBw() -> Optional[MetricGroup]:
+  try:
+    upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
+    upi_wrs = Event("UNC_UPI_TxL_FLITS.ALL_DATA")
+  except:
+    return None
+
+  upi_total = upi_rds + upi_wrs
+
+  # From "Uncore Performance Monitoring": When measuring the amount of
+  # bandwidth consumed by transmission of the data (i.e. NOT including
+  # the header), it should be .ALL_DATA / 9 * 64B.
+  scale = (64 / 9) / 1_000_000
+  return MetricGroup("lpm_upi_bw", [
+      Metric("lpm_upi_bw_read", "UPI read bandwidth",
+             d_ratio(upi_rds, interval_sec), f"{scale}MB/s"),
+      Metric("lpm_upi_bw_write", "DDR memory write bandwidth",
+             d_ratio(upi_wrs, interval_sec), f"{scale}MB/s"),
+  ], description = "UPI Bandwidth")
+
+
 def main() -> None:
   global _args
 
@@ -1050,6 +1071,7 @@ def main() -> None:
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
+      UncoreUpiBw(),
   ])
 
 
-- 
2.51.0.338.gd7d06c2dae-goog


