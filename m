Return-Path: <linux-kernel+bounces-791060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19316B3B19C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FA01BA6D08
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE00231A55;
	Fri, 29 Aug 2025 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrLibCtm"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1701C221FB4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438314; cv=none; b=i7EKkjwCbVhxUQIUwLIhTO6fAKVv/ceF8bo5kkkcbC4EKLxiwWaB3hdNNC5kzx9W1nTXfnUJNWOXx+jkbjOLdipRM+8C0A64d2SzGKbnCYeD/1LxYooBAwKMOQPeMAgPopFzKSxa5EZEnwTkfx1VjObvjEMzSZ/CxKmkU+jX160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438314; c=relaxed/simple;
	bh=0hmtggqLeq5FZz3J/tcXe5RX6ni47uj1egDznrFtV+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MfFdsVK6KTE9AtY6Or6az1UVoc45e3f9sMZoV3Z4+FrgKrz7dCg/XB2dVzdFrkYGSEdnEXAjf3FlVv7Xr4NlXKR15yYl5aKuj3Y4/L2lscDeevNk4h3k+o2FArbYLD6V2wZ6plcz5xi68lJ1+Bk7H1qpYRTPxI1F9GWv20aR0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VrLibCtm; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4c2c09a760so1254844a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438312; x=1757043112; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LGdhiSVnvTWsQxfBgDtDf70Ls0jjr8wD8lE+3rfd64=;
        b=VrLibCtm+d4Ry5G2zkhJVvUNcdXyzMHe30SppyIl1BvqSNFjF68kc2VGjGeuZBeARo
         y64izYesc5Xb8T0J7JPdzW3YzVCmvVeFl54j81NXet+8lx9WPrUWofKzxjLrfpdbSaKB
         8sqAoWfr+0umSK0AZh5kZfIaXIz89X08bRDaWy4T0o5YL+2yQCr9/wiTJYKBaVkiYXlQ
         /JwmZZhwc5Y3+Iqe7YVx33JNyY/VK9+Ubqs7YD2jF2jCOc49hjjdG8Vf9yqzOpuM/uqj
         5s6zeLNL4fZnNn8LdhXeKSP4K6Xx4RseenksllTW+meNZs8c8zyuKAcwBFONGX0ikQuJ
         neSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438312; x=1757043112;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LGdhiSVnvTWsQxfBgDtDf70Ls0jjr8wD8lE+3rfd64=;
        b=PIU7f+sZ3eC9M0t2HOshrw42uIPOuhJ84+/AKxVDSWQ/TfNH7g9cTY9zI1kIosc0dW
         CHgCjuE+wPwxLM5o0q/3WW5A60Gn/rLlilPfo6uUkyqHmi6sdMXnnimDkAttYi+tKDJR
         ov6ybLt4vWqTdFq7tpUDyE6WyRLRJrngdH1k1nkNNovKyKXHlRpjVew+u1ttI/OgOHW5
         RNNUml4LMfrmop74aqehjnXEMxABjOjH8ncZkn34yUDlcp6UXR5MiBE1E/Q3SkKpgjSj
         lrbFX8YBvLQ19HfHETN1HNqTMP5y2QSiMkmChsSb0YUpCcqa6t7zLZEgw4EbGTy/DUYr
         ojkg==
X-Forwarded-Encrypted: i=1; AJvYcCXBga1Ob4xxWDC3idL7tLQEtiEpHun2sJ5RZjCsJUm2L70vnCwSomllJfC7qtEk5gqOWqHo9GqfdquJD2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywj9vNWw6Cess8IzbjKoK0jxR/KTgCJkNyJoN3RtJZQG6GQ+zT
	pF2oLHt4D//FgBQ64D0lChwzNWwUzxOaGXgWKwvIKNSywyfpbVhqZj2+UroSgYAnrha+lPrTdaC
	v9zSxAHXSRQ==
X-Google-Smtp-Source: AGHT+IHNI+7cwsIV3L+Ri+qfg2uOAy15bKI1YaCe6UsneLEmJ4EuP/aIRZUmC5XyYMKnwVQnVRwF2bPfwA0k
X-Received: from plmd12.prod.google.com ([2002:a17:903:ecc:b0:248:c91f:34f3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea09:b0:249:112c:f947
 with SMTP id d9443c01a7336-249112d0302mr7415985ad.19.1756438312306; Thu, 28
 Aug 2025 20:31:52 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:28 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-4-irogers@google.com>
Subject: [PATCH v5 03/13] perf jevents: Add upc metric for uops per cycle for AMD
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

The metric adjusts for whether or not SMT is on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 0dd13ddd67d5..3c36078ce727 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,8 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, Select)
 import argparse
 import json
 import math
@@ -10,8 +10,17 @@ import os
 
 # Global command line arguments.
 _args = None
-
+_zen_model: int = 1
 interval_sec = Event("duration_time")
+cycles = Event("cycles")
+# Number of CPU cycles scaled for SMT.
+smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
+
+def AmdUpc() -> Metric:
+  ops = Event("ex_ret_ops", "ex_ret_cops")
+  upc = d_ratio(ops, smt_cycles)
+  return Metric("lpm_upc", "Micro-ops retired per core cycle (higher is better)",
+                upc, "uops/cycle")
 
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
@@ -45,6 +54,7 @@ def Rapl() -> MetricGroup:
 
 def main() -> None:
   global _args
+  global _zen_model
 
   def dir_path(path: str) -> str:
     """Validate path is a directory for argparse."""
@@ -65,7 +75,10 @@ def main() -> None:
   directory = f"{_args.events_path}/x86/{_args.model}/"
   LoadEvents(directory)
 
+  _zen_model = int(_args.model[6:])
+
   all_metrics = MetricGroup("", [
+      AmdUpc(),
       Idle(),
       Rapl(),
   ])
-- 
2.51.0.318.gd7df087d1a-goog


