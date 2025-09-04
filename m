Return-Path: <linux-kernel+bounces-799895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5556AB43138
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2937F684F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097DD23B618;
	Thu,  4 Sep 2025 04:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gFBPCwan"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601622D4F9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960858; cv=none; b=ci/2FP0F8npRcLIjNsslzYW+bGJdzUJfDDuNtRm+p/gvYgAhGZ68buZpefUk/ewfoqoP33cTzAl88WIzd6shx4BcojMvyzddYLtlwp1xoebnyes0miekvXZIWHELjKrD+C5Zbljx3sl7HYaEWWa1PBGXF9LPMcD5QSb113JbHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960858; c=relaxed/simple;
	bh=ct4EsjDYvT8D6RU6l6ZXP2/EiFKtPYBEt5d1gdoMMBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ThBy8i/GfBrYaK9idX08Q3VDZ+8LG5iWwd9SHoHQBN2bvtbEUUfkGw7/U89857ZHIMKwhWskbug8gbZi4WdyPZC1YE+C0fTwJ6/fKEpz9KGTkqAdq6aGQ88I2Gmq4NpRJvdvsd82ce0+MoOmEXSYpdDow5hcuX6Zp7WJtz5LC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gFBPCwan; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329745d6960so516298a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960856; x=1757565656; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZlMQ2hpher2+A8HnGEEuDpYhum4NprFD7MnC9JheXk=;
        b=gFBPCwanb+VMbUcgY6tN3ETxGAFogsNeINFMNFndRfokhYbO5lFrcI3xuwV3EaBW/p
         rZ7RfJIWmN0GO5/J95Y2q1ZviB8YXa+iy57QL+cRrcqte2T6qb5w0ipnPSFhsEtDoMHe
         QoR6Fma4DohQQPi0M7PQC49UJnAI+ReF13eOdII0p9rN99wnK6WPu+FtKH1Wx3njFTNa
         dnh+zkFVjcDAkgwPtjrHlXVRd3wR00V0L3HzyPxrVUIq3WlB3oIXlHgRfWgzjSx5lyXu
         3NCOSXceE0IaJL5MnhfLLNXWLnsTvY5e8lhep5Elj5ua72uae6Th113gC264/WG8mFW0
         Fc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960856; x=1757565656;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZlMQ2hpher2+A8HnGEEuDpYhum4NprFD7MnC9JheXk=;
        b=ek0eO4+mwTJ9rCGEA/HkwzmyE9lACgmrhxj6dypl8BnNxcaI9gcspVpiZez8bYoM/4
         EiWsTH2ltpI75nr4StqYwqc5lt5jabcmPWwgTND4d5NlqY8xnDoBGO7gTS2CpLMX86yZ
         BNF/XnKo0ko3ikOA4qhYFUb+IY1ibNLO2QKv/kApklJef8aIkoFvrDFKHDKLky3wmQa/
         ReBoe8eSjpBquwCFU1XrV+l6wPL6Ybw8fH1qv/4T9OckytQ2iDv6x99Z+loJC8aFBqcZ
         ad0hEkVrCYhJ0SoWLeICLt01RNwNwnlKWwtyNqVKkCbSnoI/Z/A4JEgBIBxKLZqhDYKq
         tVIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvf0QBOavrV3vMtumzbzDbaCMDVoR5sqQzOyxMJB82I213aZYVqocYZf5f4q4gjPYvVDDqOP9eTc9nMKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/hvvGSIe+RvmIef2vg4wabVly55xPbj/uywcLvuzxngwTOm4
	96yBDqFQrkDLb8tVG0i0b54TpVcCK/mxQ8+p2cZjU6ONmvsiJp3A/uAlk5cKa0E3BQ+k2qziJvj
	RPL4DDLkIWQ==
X-Google-Smtp-Source: AGHT+IHWrsFiz5ME3g634fgcVqQ3OP4YlmcV9NibIpAcfhK1x+scm/EFqcTusq+hvgFk8KWxbkVGtAGDP6LY
X-Received: from plbkn12.prod.google.com ([2002:a17:903:78c:b0:240:4fbf:cd20])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8c8:b0:24b:25f:5f7f
 with SMTP id d9443c01a7336-24b025f66f6mr119779135ad.60.1756960856173; Wed, 03
 Sep 2025 21:40:56 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:35 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-2-irogers@google.com>
Subject: [PATCH v6 01/13] perf jevents: Add RAPL event metric for AMD zen models
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
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Add power per second metrics based on RAPL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 31 +++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 4f728e7aae4a..6fff81cd4db3 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,14 +1,37 @@
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
+  """Processor socket power consumption estimate.
+
+  Use events from the running average power limit (RAPL) driver.
+  """
+  # Watts = joules/second
+  # Currently only energy-pkg is supported by AMD:
+  # https://lore.kernel.org/lkml/20220105185659.643355-1-eranian@google.com/
+  pkg = Event("power/energy\\-pkg/")
+  cond_pkg = Select(pkg, has_event(pkg), math.nan)
+  scale = 2.3283064365386962890625e-10
+  metrics = [
+      Metric("lpm_cpu_power_pkg", "",
+             d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+  ]
+
+  return MetricGroup("lpm_cpu_power", metrics,
+                     description="Processor socket power consumption estimates")
+
+
 def main() -> None:
   global _args
 
@@ -31,7 +54,9 @@ def main() -> None:
   directory = f"{_args.events_path}/x86/{_args.model}/"
   LoadEvents(directory)
 
-  all_metrics = MetricGroup("",[])
+  all_metrics = MetricGroup("", [
+      Rapl(),
+  ])
 
   if _args.metricgroups:
     print(JsonEncodeMetricGroupDescriptions(all_metrics))
-- 
2.51.0.338.gd7d06c2dae-goog


