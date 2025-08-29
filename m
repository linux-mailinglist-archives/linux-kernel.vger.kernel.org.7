Return-Path: <linux-kernel+bounces-791091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F33FB3B1F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC4D7B487A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED64B228C9D;
	Fri, 29 Aug 2025 04:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SuOgsGsH"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BF1224AED
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440693; cv=none; b=CFQhyNZBZES7BzQuCzlyPIRLhXr2AmxWLzFqjRcNHbh+QpWjZN8P7fi4c8wmrhfqzJgunFdMa/v6n7edKW/vj8MJMJdjth6gr2Dj+5y1WRNahgy3b5DeMBMECCB5AJDYSD32JpGkuzK4b4fc7jZMLMvIhxvcJHdSy3mjWLjuv1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440693; c=relaxed/simple;
	bh=X53nJP/mZS69ATwldN5hzVeFfJtRGo/KKlDopKhn654=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aCWmyMH410q6+3EF9tDnS2bUu++wZtmQ1K5GotJfyiumyZO2IST7KsB7KOYWl2b0OwK4T55N7Jcxue8FK3kjkpQ0ZR3X39q2MZWwQssDtjAvxrsJSehkTMZ0HJN8ByjyxCKwEg75g2d2YRAMRQJCBoW6obtpyOp7QCgw6cjGqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SuOgsGsH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-325b2959306so2820740a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440691; x=1757045491; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwyQMYLw0FpA9KIhHv/Z7rR87mgRlDW94bg1brpZvR4=;
        b=SuOgsGsHK7316pBCftFv9kpKJtnaHTtrNOzVMs/ViCawNH4x8kLzujw2kX1S93YwP5
         ggNNvCnZbp0PI0tAzFXbAxiNb0VymsPyiKZ43peT1I/4NeN++OjowpPEEY59aGBeRutS
         Mu0rlG0g/vyx7qXZpwWyUlFLrtY37EE491FdOttbDekBU44RiIH52IJM2YMCnWAmIoI3
         AVLPneuCaIcO4NxpXeUrJA78nwrEiYtLAQOMazZZxd/R5wPGIsn3J1J0brj2HNWIdz5L
         yLEGKrtU1ujzLsxzXdAzmPP8SSJEdF1emxpdHLPuYTArc74HNIq7AjqOM3iXTsjDNUcV
         NiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440691; x=1757045491;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwyQMYLw0FpA9KIhHv/Z7rR87mgRlDW94bg1brpZvR4=;
        b=lMfRVUJ1EOo+8N+5+ZxaV1y1CMZMzs2gc3yru2m1rk4LbpriS/C7rfmzql1UQM5gZK
         PuSOd9jtqqo/yyg+/IGWlFnCxelVy/QVGS5rcV9lFHngGOc9a6hckGt7OkKctECNZT0s
         1j26KXeq/4BzOXC8cQY/62gAUJ2r9HJkCfG247uPdBaH48PrYjbiB7NCadSlC6yMhz/n
         bJvYpD8P7M6ax+7/cSRgee/l6eQ06PxT/d7zLDrs+SSQSVy032dKg3Ksv3PjQWbwiIIH
         CatkN9Y6sLRkxDPfpL2TmzBkHZqdSp6o3TLCGEckwExMi0WKTcFNrN8EQWYI1BogCOFJ
         VtqA==
X-Forwarded-Encrypted: i=1; AJvYcCURGi2B/BqRItWzThrBipEHZZXvnomAmNG9VfLSJjesNEWTrupkxPZbwly3tRZemcdOFauTE8k5dIUOi5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGO7OAqbngnEBgvg3YVVGTBdW7s+jmbSI97b8dWk+7zxrMjDvP
	zHKyD5sXr9BlIFK32k3m43pgGNzNvhiKF0LNP2xnlOirk1fVmpxum/WFcY9u2ykEvixr21HzIUw
	Nev0NgByi2A==
X-Google-Smtp-Source: AGHT+IGm9qOaeF502kiWAPj5LuS4z4uHx+FEp9wstbo7flY1Wq6p+EFdIC0W7y/pGCJIh9prVw+wf0JZrWmJ
X-Received: from pjj15.prod.google.com ([2002:a17:90b:554f:b0:327:e8e0:b288])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e18e:b0:327:e6b0:c515
 with SMTP id 98e67ed59e1d1-327e6b0c875mr1352918a91.9.1756440691249; Thu, 28
 Aug 2025 21:11:31 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:42 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-2-irogers@google.com>
Subject: [PATCH v5 01/22] perf jevents: Add RAPL metrics for all Intel models
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

Add a 'cpu_power' metric group that computes the power consumption
from RAPL events if they are present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 45 ++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 04a19d05c6c1..df4322ec82d9 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,13 +1,49 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    LoadEvents, Metric, MetricGroup, Select)
 import argparse
 import json
+import math
 import os
 
 # Global command line arguments.
 _args = None
+interval_sec = Event("duration_time")
+
+def Rapl() -> MetricGroup:
+  """Processor power consumption estimate.
+
+  Use events from the running average power limit (RAPL) driver.
+  """
+  # Watts = joules/second
+  pkg = Event("power/energy\-pkg/")
+  cond_pkg = Select(pkg, has_event(pkg), math.nan)
+  cores = Event("power/energy\-cores/")
+  cond_cores = Select(cores, has_event(cores), math.nan)
+  ram = Event("power/energy\-ram/")
+  cond_ram = Select(ram, has_event(ram), math.nan)
+  gpu = Event("power/energy\-gpu/")
+  cond_gpu = Select(gpu, has_event(gpu), math.nan)
+  psys = Event("power/energy\-psys/")
+  cond_psys = Select(psys, has_event(psys), math.nan)
+  scale = 2.3283064365386962890625e-10
+  metrics = [
+      Metric("lpm_cpu_power_pkg", "",
+             d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+      Metric("lpm_cpu_power_cores", "",
+             d_ratio(cond_cores * scale, interval_sec), "Watts"),
+      Metric("lpm_cpu_power_ram", "",
+             d_ratio(cond_ram * scale, interval_sec), "Watts"),
+      Metric("lpm_cpu_power_gpu", "",
+             d_ratio(cond_gpu * scale, interval_sec), "Watts"),
+      Metric("lpm_cpu_power_psys", "",
+             d_ratio(cond_psys * scale, interval_sec), "Watts"),
+  ]
+
+  return MetricGroup("lpm_cpu_power", metrics,
+                     description="Running Average Power Limit (RAPL) power consumption estimates")
+
 
 def main() -> None:
   global _args
@@ -31,7 +67,10 @@ def main() -> None:
   directory = f"{_args.events_path}/x86/{_args.model}/"
   LoadEvents(directory)
 
-  all_metrics = MetricGroup("",[])
+  all_metrics = MetricGroup("", [
+      Rapl(),
+  ])
+
 
   if _args.metricgroups:
     print(JsonEncodeMetricGroupDescriptions(all_metrics))
-- 
2.51.0.318.gd7df087d1a-goog


