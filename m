Return-Path: <linux-kernel+bounces-799911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD51B4314A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDD4685B18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2D123B638;
	Thu,  4 Sep 2025 04:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BDxeKVin"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6B21D011
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961221; cv=none; b=loCCp7bD7SswBWoefjtWV8+Z9jobft8AaKaFLw9nnaVexoRgZGDxpPDwWv8bgqwoiMrIIBgMNg04ABtjAX/nYYFO89TiEeVifujcMAf4fuhZ1TilubwDk1IEiXSCexn9uFEeGLj9bvjLJazcz5kFpvyW60D6PRKDYJj1txmOSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961221; c=relaxed/simple;
	bh=6cSGTKSnTGH2Qc6S4lYcUebBr6/mwIVeBJ3QYJxoSN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TRvFeR2o0mRIWTwA7yMS8egzr/LOztAfK4qhdiaqpXyy4R9DMW3HgwFXhQ53lW0KGKyXkCtg+9RjLK51cWtB0eE1Rhw4GUMIfUOgDZ8jy/Jh76kpNmRfqwEuOCFneX3lYIbTDk/flVXR3a5zm+WuiywdgKn3df49NuSiK85T5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BDxeKVin; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24c99bd543aso9798055ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961219; x=1757566019; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8P/veAk1QofA7phTO6Z5L/IvYDAAxC26ISaoB1KMoo=;
        b=BDxeKVinZ0uezfCDb7rolRBtKR74QQZqvpTlCxLAkwvbOaEqKLbiPS8aS+pj9LZ+64
         lSHqJYY91Rui3Mn6saSGZYhg8F9m+5fCCK/PGtUFdzbk50pJc2zXmLHE+51IEjNxdXWC
         JBbZN1VKd0/6DA3JH1t/qGIWuiHGKFejgsyuP7WlWR6uDzitq+xwRuHgEPh5PavIFXmE
         HPaG7zAc+bV4SwVmRZbrHmGV/jry+oq0Coew7FeIBKE1Nie3xSAfI+9sbvVSftSThzrT
         M0HYuatJ9Hua5l5L5sDwT3AalUzlpTo1WfZrqFLLdxIoGp8BTyJ/MRnxs/i0P5i1R4p2
         /JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961219; x=1757566019;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8P/veAk1QofA7phTO6Z5L/IvYDAAxC26ISaoB1KMoo=;
        b=iEqKk1LTyjbp3y5xT3Cl9rRgX6Ml58QPl9XkNb8/yQY5+vF9hRy7D6XGy2UPMBF3uN
         h38wfWgxmmgXmUuvgY6wWdn0FEVN2gO1ncVcF5DHo6bxC6PevzQloeLa+QGZymFgSfs1
         e3azyDFGtHKezyHp4BF5uK9FiTyeAKdAiDcMOlO3k/z9N5tnpHGFJ/Cd710lqUq9c3Bo
         qgMkygIMQgDX/IJhSbzGrYX/wvpU0ztVtS/5YWttMEmx+zXzJcnpnNhZdcLDOFAJWMvr
         UQCgxbXfkAL+dhTFQNNOBv3ASdG2UNEs7uKtU+PAdvLLGMqLZcFFNyoGW7hoyg0awW/c
         8e1w==
X-Forwarded-Encrypted: i=1; AJvYcCWSjE60pJQT1xSuZncJfD2hlJb1BPRdxkdTQYUPLee5mFKSSRT2s4o4p2kQhLefJmEfqNUavp+W6bthvLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX4+E/NqAWJpaxATQUzUcy//pi9bUCK9Ukz3FskzGQtZBX4EoW
	loEJCCAQimjvIOar4TBktcC7x+fGTNTQUzJPfVs8m3vrccAf95L6WOfCVCaGlj5Dmio6lWW6KjX
	0GVVafBtxiQ==
X-Google-Smtp-Source: AGHT+IG3qXljQYBVs9jDwDu4dhi6m61Vg/y9HfuIddMKpjtXWzfjSppXhzZAxHG2Lds2q4QynEEpS0LpEltH
X-Received: from plcb12.prod.google.com ([2002:a17:902:d30c:b0:24a:f84b:af0d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:40d1:b0:24c:b83f:c6b9
 with SMTP id d9443c01a7336-24cb83fcb3fmr28056375ad.7.1756961219284; Wed, 03
 Sep 2025 21:46:59 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:32 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-2-irogers@google.com>
Subject: [PATCH v6 01/22] perf jevents: Add RAPL metrics for all Intel models
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
index 04a19d05c6c1..1de3c2b2187e 100755
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
+  pkg = Event("power/energy\\-pkg/")
+  cond_pkg = Select(pkg, has_event(pkg), math.nan)
+  cores = Event("power/energy\\-cores/")
+  cond_cores = Select(cores, has_event(cores), math.nan)
+  ram = Event("power/energy\\-ram/")
+  cond_ram = Select(ram, has_event(ram), math.nan)
+  gpu = Event("power/energy\\-gpu/")
+  cond_gpu = Select(gpu, has_event(gpu), math.nan)
+  psys = Event("power/energy\\-psys/")
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
2.51.0.338.gd7d06c2dae-goog


