Return-Path: <linux-kernel+bounces-799919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4507FB43153
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDFD686B00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27451264F9C;
	Thu,  4 Sep 2025 04:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZuBnXXSz"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E5725C818
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961237; cv=none; b=iiUeDbT7OcnD1s2g/QAARfVIvHqR3D56K8yu4zEUO0wxudR22zqiZNEUXZa5SWcVzbabK3Wh9ZIw2E5Ba+Qy9PUirpCPn93pr3eQ3/JZ/dZFTyMKGpP7dL76p9GHxmlgFRjYY/FL7YG8/8OKB3KTT2I/1l9IbW68JJbk+N+Jotk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961237; c=relaxed/simple;
	bh=o+Ieh5f7nEigRVrrQ1oFBbRlimMkO/0u27Jpnxj0Bd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Wb08vIRgEzIaw2zMy5/aLtKZSNoh7RJROw2ScOnSUkT51twU22ta8Yat2pqViABiS7qjpI3RrBU06Fs3imQsYIryzmUGHOf7aEMqqz/PW9S6h80Zy6f/P+qFjHPu5kIDz+LJ2vZZjyiXB1cE0von4XIR9MNR6neZR8GRBI/qrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZuBnXXSz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24868b07b5bso15160645ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961235; x=1757566035; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzi2AtTlZOwesAgn4m+DSLuE/Xk8AxtH2yHfI9nLvQs=;
        b=ZuBnXXSz6/2hBzn1S7dT+NXMOR8UoQcCDwp+qxJAT6O2Gnf/AKbi/0RURTbkjWz1MI
         c97xAguK4K/7pD95l1RLALnzCONWXo9UCFpHH7CF/x4sEgqZaIeL+xzLG6loFNSrN52u
         t+unAp5/N06k01BbdPYbwiR7ypdlEt6q20IrKWMmJhEEjjavMOA4vtSlsALWEJAowc44
         0uoVy27OhEIqssriEEr/KNM5j4TsmtK8fXJArUymsjZEUFFmqfFy/MoABWNzcQD6j5IQ
         84yU63BYP7pQFd3TljJkDxP7WhZUOzpGwLuv6uC2zi5v44vJzp8zByViaFiPiID+m8Ya
         0rWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961235; x=1757566035;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzi2AtTlZOwesAgn4m+DSLuE/Xk8AxtH2yHfI9nLvQs=;
        b=l9HfTDMiQGEBG/46RhOac7W4hbbGvbU4IEe3+Aw5OHes4/mpUtr4svYQvuVrz0uOX+
         lWM5kDiBFxOrOQPHyrS4e1hnr4CF6/JueXiS0xr0rBLJb6hH+P+dAEPVSeNHF5JKjQCC
         YZg4jDnSS/FnC1v67nvBaCxgp0neQ5TCKCCOigh1/XK110lnfPKaDuFgznpL06dJf8/A
         oeSrMzSMdQoJkpvKFE3Den3uw+0Q5rZiTFwFIgPX+2RIRMwOPp5iZi1Bu2p2+JO1zpDd
         /x/UtcKZl7K1tHCfIPtQjuxRI4Z7S1H8GufJPbcR1n5UW7p2sF/4CF5Zz1VsOYJHWyFn
         3Czw==
X-Forwarded-Encrypted: i=1; AJvYcCWbyTPEhO8zdFmFaF7hcnCLCR2BdC+S2GWICgCKtfrcavvj5Y2tCio84JVFDZJJZy85xkWMkw4n+6jLIs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxp2eUQ7Y5PET3BXv6W71O5Ez1RmOOymropYkceepEYIqMfB0y
	zy4fSg1bn655DKB1FqhR4paLyMAUfAR/61cktGpVMEgu+NFyUG/D/yEpv0E7sRXHjRJXB/GoeEP
	gSHHUJfjudg==
X-Google-Smtp-Source: AGHT+IEGzstwt9UTmaSuMIy+408+KXnAOSGoJNob6WBZfIdKqBTphBoO80XZXmpV3l/Csfez6aMfWBcNbhgk
X-Received: from plbmj15.prod.google.com ([2002:a17:903:2b8f:b0:24c:c58a:c192])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1cd:b0:248:a406:c818
 with SMTP id d9443c01a7336-24944b3c3fbmr205372535ad.42.1756961234619; Wed, 03
 Sep 2025 21:47:14 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:40 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-10-irogers@google.com>
Subject: [PATCH v6 09/22] perf jevents: Add ports metric group giving
 utilization on Intel
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

The ports metric group contains a metric for each port giving its
utilization as a ratio of cycles. The metrics are created by looking
for UOPS_DISPATCHED.PORT events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 33 ++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index b4ed137c91b3..52c592112c13 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,13 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, MetricRef, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
 import os
+import re
 from typing import Optional
 
 # Global command line arguments.
@@ -261,6 +262,33 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelPorts() -> Optional[MetricGroup]:
+  pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
+
+  core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                      "CPU_CLK_UNHALTED.DISTRIBUTED",
+                      "cycles")
+  # Number of CPU cycles scaled for SMT.
+  smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
+
+  metrics = []
+  for x in pipeline_events:
+    if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["EventName"]):
+      name = x["EventName"]
+      port = re.search(r"(PORT_[0-9].*)", name).group(0).lower()
+      if name.endswith("_CORE"):
+        cyc = core_cycles
+      else:
+        cyc = smt_cycles
+      metrics.append(Metric(f"lpm_{port}", f"{port} utilization (higher is better)",
+                            d_ratio(Event(name), cyc), "100%"))
+  if len(metrics) == 0:
+    return None
+
+  return MetricGroup("lpm_ports", metrics, "functional unit (port) utilization -- "
+                     "fraction of cycles each port is utilized (higher is better)")
+
+
 def IntelSwpf() -> Optional[MetricGroup]:
   ins = Event("instructions")
   try:
@@ -353,6 +381,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelPorts(),
       IntelSwpf(),
   ])
 
-- 
2.51.0.338.gd7d06c2dae-goog


