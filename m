Return-Path: <linux-kernel+bounces-898583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A8AC558CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E1304E49A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068DB3176ED;
	Thu, 13 Nov 2025 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrvfzhlX"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69693164AA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004125; cv=none; b=iz0cxLTE085ZAmh9awb/Da/MoTJVGIBB6IJQ8PrONRi5o6MpXXj2nyBiHxAOomafgWC+BuYRlHbGUuqzIfstyV0ceJlY9bpapY4H9eclzmX9D6rVHLuo0l6JmQprvrKKSlrcguI1fdbH+YflNzAaxiLsxNKuH7z71t4fFKxOSxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004125; c=relaxed/simple;
	bh=ReOI/yw7wKiQdecqgoKq7L03iNCYJDFt1sIl3LZIdPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=S3XVmf2SIVgR+w/Zli1EIeX0MTvB4nwothAbIpfRBuQtaQQf9BY9QLBVfT2URYuKilxnsFxRlkWgLdfSN++XLwnsYZZhVUZxHFgIR4qpO0jfbvUySgpVU4Q+ILkJwafP+5ZVuO/5AbouDTuOTK5BiumVmIFRmkKHkpL+hif7RB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrvfzhlX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2956cdcdc17so3960125ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004123; x=1763608923; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDpei4kCaCeIleN5UbRvrQ+OXCtwgMX3eQqxpgwlAMM=;
        b=hrvfzhlXLnvSHoUqjvM4McJKhrpRqPKr5YVYE9xY17CGjmB/xahJ2s6oMjMa1gNZGM
         uBgd0ihQ8zigY+LdKDrqGz8qHn4f5JUX52EnU0cP4nBK+I/ng/74QKCayKF0clz9Njo0
         qK+A97feHHEF5EuerMR9dSb+QKVasCGUXE6VfB0OgNsqSyv47oeAie/wmABjHCI35W4+
         HVQOPzdOU0ydqMXPQNg80IcXCoGRf4S0wyUBCHH2HHCo5btAZvDOcdN6D2guAsa+GnWy
         Cdt+AsNs5SWJkILUCRvO4P2jFg7t5FPTSMfSGh94+b55X/asVSgB3FnUh1xHNAX9FmK7
         7IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004123; x=1763608923;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDpei4kCaCeIleN5UbRvrQ+OXCtwgMX3eQqxpgwlAMM=;
        b=R/mg6WLz2PAqfHKIUZ7CzdZg0JIsMCtcXxG+kevikzYc5C1QVZhN2Wffoi50zoLm05
         Hs28rzAcvNWN7Gjm3VV6aOXMnramUJsDepaI2yFTMxKF4zPl1E9eTbqjrKbjV70SKwBG
         +H0jN4PIM2gCirOl96JkWvkYe5sVCjDF6+o9Md1iGZ3xsin1+46GxspzBrp9/UxqUNlh
         UtphLVcesSiQIBZiwJ9hNBq6oZpYxRUODV9C0bqebn5ZXkHIOQ8SPVIYGMkrgK0tWZGA
         e01/1FVNbBTrTQIkL7r65QDGRzEoMRAFemvt7WKmSqgJmXPff6b7C4OB6E5PSbBAv6hc
         yHkg==
X-Forwarded-Encrypted: i=1; AJvYcCV/j9wgupW9EGM2vnBe3p+ziSHeUAIZc4fdFNrRtbwO4lM5QLdXJcH727eB42lgdgvJ1tMk7C4/mYsKRsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFjec1IuG8b1d7aBirA7MW5Cspohl/hGQ8Z0fMvN+oarGIO53Q
	NQ3ECa6rPzLDIn/8x1krKLMroNoyjxOzBhViTfjYx3xNbTR9HBoJYYSLHQmaFiClH9hs/n/9Le8
	CGP3cmUG4qA==
X-Google-Smtp-Source: AGHT+IEcHxhuA5X7tAwArcHTSLd4uPktHr67wK87JmqzBFDGMyDOjNJyoGY6BxIloszi7vK/EhVrRowzrs9X
X-Received: from dlbcy1.prod.google.com ([2002:a05:7022:b81:b0:119:78ff:fe1a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a28:b0:298:485d:557d
 with SMTP id d9443c01a7336-2984edcaaaamr65279345ad.45.1763004123184; Wed, 12
 Nov 2025 19:22:03 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:24 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-37-irogers@google.com>
Subject: [PATCH v8 36/52] perf jevents: Add ports metric group giving
 utilization on Intel
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The ports metric group contains a metric for each port giving its
utilization as a ratio of cycles. The metrics are created by looking
for UOPS_DISPATCHED.PORT events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 35 ++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 919a058c343a..7fcc0a1c544d 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,14 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 import argparse
+import json
 import math
 import os
+import re
 from typing import Optional
 from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, MetricRef, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, MetricRef, Select)
 
 # Global command line arguments.
 _args = None
@@ -261,6 +263,34 @@ def IntelBr():
                        description="breakdown of retired branch instructions")
 
 
+def IntelPorts() -> Optional[MetricGroup]:
+    pipeline_events = json.load(
+        open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
+
+    core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                        "CPU_CLK_UNHALTED.DISTRIBUTED",
+                        "cycles")
+    # Number of CPU cycles scaled for SMT.
+    smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
+
+    metrics = []
+    for x in pipeline_events:
+        if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["EventName"]):
+            name = x["EventName"]
+            port = re.search(r"(PORT_[0-9].*)", name).group(0).lower()
+            if name.endswith("_CORE"):
+                cyc = core_cycles
+            else:
+                cyc = smt_cycles
+            metrics.append(Metric(f"lpm_{port}", f"{port} utilization (higher is better)",
+                                  d_ratio(Event(name), cyc), "100%"))
+    if len(metrics) == 0:
+        return None
+
+    return MetricGroup("lpm_ports", metrics, "functional unit (port) utilization -- "
+                       "fraction of cycles each port is utilized (higher is better)")
+
+
 def IntelSwpf() -> Optional[MetricGroup]:
     ins = Event("instructions")
     try:
@@ -356,6 +386,7 @@ def main() -> None:
         Smi(),
         Tsx(),
         IntelBr(),
+        IntelPorts(),
         IntelSwpf(),
     ])
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


