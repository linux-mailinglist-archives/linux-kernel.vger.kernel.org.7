Return-Path: <linux-kernel+bounces-898561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BC048C55888
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B68F34F4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF30C29BD8C;
	Thu, 13 Nov 2025 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emMhvJEk"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B238A3081A3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004085; cv=none; b=ZbwN3TPMtcjnsj6jdtS8ptMvivJvKLFBjn0DJ3jv09r00jVpf208kHle9I0i0zrzkzJz6YhudnivyjY96pCa/mv+xkncVBmvB4aGoonDyamU7dY8SgzledCevH4ASn+D+VYfr8ysJOnyrp0SrWeYy168Pi3DH0T4l+ZQClFg+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004085; c=relaxed/simple;
	bh=LzY4F0bP9vooYdMwnCs0XOQfXqV24IvjMtZPzidXt0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PSmBB1/sDKGXoZRn7eiz2NqLo4xMdWAiXuRf5febyWuK8/+otOVGU2v80pca300sxklXNqJt2e3IJhsUPkNdBjMumRazjoV7yXQggQyCC7YUCXwSCV77wCcbUhEE8PIXaL1ScsCwHavfNq1aMQRpqQQ+AyN2hhwBje6z8/ud+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emMhvJEk; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29555415c09so4334525ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004083; x=1763608883; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WHgdVqMo2mfd/A30qebWWpCOmKjeXKhdLt2i5lPgFpw=;
        b=emMhvJEkA1egMsRNAROoW91QCuBkynbacncHk8Xixl0xgDemWcz6sTXiS1FaT72sY1
         kZxq6aVtY2bXzILLAphVwZHP88LPSaBmOtD1Cd1UK9HMyH8RKDzsps5XV7Xjg0yKqV6R
         ykr8NixSIBuY2KJLuEVm+rbFn4cvFKEDRElKIB0VLpToFrojud/A43U5I+g56gWYdIXV
         JfYjkjcaZQuGEp8lESEbDml5fLAnZITG+LinPpbF6Cm/HRs2tYf0vyBUEpCiS/wXCOeA
         DHwYOK0QqN6efLj4fS1vLlUpKJA87UTwfQDyTClz8+Acjecq7z7jX1+78MWFGNlHDzvu
         Se6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004083; x=1763608883;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHgdVqMo2mfd/A30qebWWpCOmKjeXKhdLt2i5lPgFpw=;
        b=F0zjrHW+cKnH5ymd9HDbWUzZKH7X6+1rCnPRbkhHCX21kz2v9UGuG1Nkc4S9BukqZA
         8LcOSgX3Yce37xKrGJSdeWjg7sQRvem8SxX+Lj0KWURs/PfkihtAxtYtFd05mZuz2ojF
         GwmtHARt/XZ92nuizIdd6KcWafhiOGzsTAjxyTUT+PLlaiSpBqj/AaklZ13b9f4MxPpl
         WQCcmb1xqezbs0j1WYrGvjsIGEpMSBobqEX16pEBVcVes0c5cc+S6h/Ns228wSmwU/0A
         uPr5N1tmPIBXsOZJr2AN681coeOa5JkrnEDAj2sJKLRuXwevcIPRDH2gXuaAneDK6Yvk
         r1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4ROIqbQ7zCFE88+0B+RhfSUz4FiSD9JQNcxW3pagoMS5tQsIMcbYwk0xuAHZVk/NQ5EiD5bdjmkM6x+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0cTNu5mpxCrpjntEch8PyT8+vfUr2JetiwhoqkUMSUyHVYRTv
	+g9XfofDghz/epHJwGGf5f971yr1N/Na8cJioG2pCwh+oGhkPB+kQO8DJ+eH1VCA1FDoUdbTYmF
	vgKIxYtVI3Q==
X-Google-Smtp-Source: AGHT+IHI5BfWqNRWeHHy2eWM6vhQvh8vGmp+McD2FeB5AvGV3o0zzmWwQ4Ynyvw++nC0h7QZGP4/SJ5hwi4G
X-Received: from dlbbq7.prod.google.com ([2002:a05:7022:6707:b0:11b:65e:f6a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19ce:b0:295:70cc:8ec4
 with SMTP id d9443c01a7336-2984ede8153mr74025065ad.51.1763004083198; Wed, 12
 Nov 2025 19:21:23 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:03 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-16-irogers@google.com>
Subject: [PATCH v8 15/52] perf jevents: Add RAPL event metric for AMD zen models
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

Add power per second metrics based on RAPL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 31 +++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index bc91d9c120fa..b6cdeb4f09fe 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,13 +1,36 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 import argparse
+import math
 import os
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    LoadEvents, Metric, MetricGroup, Select)
 
 # Global command line arguments.
 _args = None
 
+interval_sec = Event("duration_time")
+
+
+def Rapl() -> MetricGroup:
+    """Processor socket power consumption estimate.
+
+    Use events from the running average power limit (RAPL) driver.
+    """
+    # Watts = joules/second
+    # Currently only energy-pkg is supported by AMD:
+    # https://lore.kernel.org/lkml/20220105185659.643355-1-eranian@google.com/
+    pkg = Event("power/energy\\-pkg/")
+    cond_pkg = Select(pkg, has_event(pkg), math.nan)
+    scale = 2.3283064365386962890625e-10
+    metrics = [
+        Metric("lpm_cpu_power_pkg", "",
+               d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+    ]
+
+    return MetricGroup("lpm_cpu_power", metrics,
+                       description="Processor socket power consumption estimates")
+
 
 def main() -> None:
     global _args
@@ -33,7 +56,9 @@ def main() -> None:
     directory = f"{_args.events_path}/x86/{_args.model}/"
     LoadEvents(directory)
 
-    all_metrics = MetricGroup("", [])
+    all_metrics = MetricGroup("", [
+        Rapl(),
+    ])
 
     if _args.metricgroups:
         print(JsonEncodeMetricGroupDescriptions(all_metrics))
-- 
2.51.2.1041.gc1ab5b90ca-goog


