Return-Path: <linux-kernel+bounces-791058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D2FB3B198
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55451BA6D01
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F22222BA;
	Fri, 29 Aug 2025 03:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAaVks2y"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D9217F23
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438312; cv=none; b=QTDx+DT9cUqKSmw4cHIwQDi25VZcRHEp4tylkQ5vGoEvvNseIbg/4yh9inKiol/Yfv/dUdIgyWTRAgqikR5m9EzArieEfRd6KGZ/7NOrSYufwzgcxv2NE1M2oFt+M3dz1djpqayxc+rdpTpQHYjQHmtxlKG51Wfokhx8Q+4CzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438312; c=relaxed/simple;
	bh=f6tZULxXzOYJabi15j8Tzs5VwOMZcIv+Utk6vqhZv0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lM5WdZtaDz4O9UCE+bWCDcvIG+Io8dvhIgSFw/kBa77+pPUIbpT1rQrxnY6uP6d16IPcEWVwlOrKxqM/FpUqTFDk62p4zOQvTIW7hGPG3OoP+K25L7cS4QvMZGfoyuum0rSiwrcAPUiUzT5hTLyCykO8VyR6sGEbKYj3QN8UGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hAaVks2y; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4c3547bd78so1292973a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438310; x=1757043110; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2KPWVxhZfNI2wSoQnR4yc5PGFGxNKw8RrtXTGVAxeo=;
        b=hAaVks2yAFjjb2X6Js4bA4rqLOUlc+/4LyADOF6i92T7VXBS+vkCEnKzteejHuaE/R
         XKlJk5+Y2VACGCy0ubzX5tfnmhNGZXpSQDvS11pevNcF+avthf1FWz1mVVK+EMa460DO
         sKB4RnTOhvNcLNFQX0t4p4hB3UddcbwBbbJzN4Pn0fX1zhVEiQNB8kE4CwUHkKpwgv4K
         JXKO988CKzY6rZ22BhgcBdI1yZp00EiE8lfviyF0dxOkJ7MzriUXZ+l23TYzj2zhfh2l
         gdvARDjGY9CwiyB70OvaYI+Cvyae/Txfp37pFO7NkUuwbZyFbXJce4EEdvXfSxflVoBZ
         2pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438310; x=1757043110;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2KPWVxhZfNI2wSoQnR4yc5PGFGxNKw8RrtXTGVAxeo=;
        b=tU3pZPphUi1OSZGvPVVKSRXge9/f1Oyzja84K9r3OBEj53pHWXLuU/Jw2LABp4XIc8
         384Epg8vJfAwT5AE1C9WV88ibzlZPzvqb7mQN8fQYBdezWb5bHXTlBrpCgfOYaGI/Uw7
         Trdy8/qNSbuN75c+ov/1cktgY82KOL88uUQ0h+IfvdcDzO8p1UO4+mToyj6g156wXdeA
         bRaehi/cGlvk1ocYVAQ+mK5QGMAEkSsvSv2HXFKtglRX0migEfglvM4AL6VqfooMyTYj
         kmSlFODa1gOgDqnji1O+3dsIj1SKtuafDXDWunWF/SeiDfm0O5GzdiUeeV5WXsUAHM9Z
         G8aA==
X-Forwarded-Encrypted: i=1; AJvYcCV9DgAE+uHToWIg+z/QRWaJsEsqKBDUtRlaGYoKpsB3qcLVI0xWQ9cOcf14YFs3uwCGIzDRI200scfkKbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4u32KHZFh8GjZfqIhHB34OLqssScnAJ4QQRspRhDagfIMZ/LY
	nJGGAT7UPr2zSBuUTJotp8+GretJFJdMFQePNYadZ6H2gM+kt+2861HpKq8ijqBovcNhjdBzPTS
	jyRwyrkwVAg==
X-Google-Smtp-Source: AGHT+IG1joouvBqPMX2hF04OOQp5MJw306wbLSPjyrev6oBcRL+UG3HbKsN/piOLACw1lxmtS40dAi2bJK9C
X-Received: from pjk15.prod.google.com ([2002:a17:90b:558f:b0:327:e57c:38aa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:99aa:b0:240:101c:4417
 with SMTP id adf61e73a8af0-24340b8da85mr36531605637.4.1756438310394; Thu, 28
 Aug 2025 20:31:50 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:27 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-3-irogers@google.com>
Subject: [PATCH v5 02/13] perf jevents: Add idle metric for AMD zen models
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

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 2261836eae19..0dd13ddd67d5 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,7 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
-                    LoadEvents, Metric, MetricGroup, Select)
+from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
+                    MetricGroup, Select)
 import argparse
 import json
 import math
@@ -12,6 +13,16 @@ _args = None
 
 interval_sec = Event("duration_time")
 
+def Idle() -> Metric:
+  cyc = Event("msr/mperf/")
+  tsc = Event("msr/tsc/")
+  low = max(tsc - cyc, 0)
+  return Metric(
+      "lpm_idle",
+      "Percentage of total wallclock cycles where CPUs are in low power state (C1 or deeper sleep state)",
+      d_ratio(low, tsc), "100%")
+
+
 def Rapl() -> MetricGroup:
   """Processor socket power consumption estimate.
 
@@ -55,6 +66,7 @@ def main() -> None:
   LoadEvents(directory)
 
   all_metrics = MetricGroup("", [
+      Idle(),
       Rapl(),
   ])
 
-- 
2.51.0.318.gd7df087d1a-goog


