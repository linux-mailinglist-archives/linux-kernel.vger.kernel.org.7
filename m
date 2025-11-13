Return-Path: <linux-kernel+bounces-898576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B462C558B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D720C4E147F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21354313E1F;
	Thu, 13 Nov 2025 03:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCIEOIV+"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E83313E24
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004111; cv=none; b=is5W+bw/w0V/v9IY3E5XtcnIkoBmLemZqIio+3GhAyr9i2i6ihFIYD1lJIpf8tBg9oAQB2FkW7brHMtppcYu5cuDGpk1sR/pAQoscdKXX74UpaynBo85X5wR25el1oMscMCJmUZcvwtgE0ml03/NcxyH0j47rsMMnpK0lxKVGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004111; c=relaxed/simple;
	bh=bHvFtE4aYOBFNZd/vQByOkidF4rhlFtBRoKPcO3DQF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rFat6dKFCmOcXJM8WfHPj4dKOmUE2XucCFbXqd1tdCU6sO8nQse3i3dCTWAhN6RkAVtC1Rq1/TTtSyOsYmfCr6+13AY7+A8j7GtaeCL4Notd6JhUymqKganOdg4kgN68qKV2VzatjniSKJODIJMSor0XlrDL+8viAhfw2BKhhHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qCIEOIV+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b9d73d57328so326975a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004109; x=1763608909; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUfD60rISo+k9JtkAjKYR1UHW6lfVIwWkmpIaKaNt/M=;
        b=qCIEOIV+BEdi4C/G20m/L0gFsATVXVMvz3IVtjgiPy5wWAG4ia4t2emQfkWFWCvX8P
         MAnXMtDMoJtdfaVbDA4NEFpaCQrWaeQ/Z9EeSaphUbtstNv9T+ORYFbCQsXBT9BCivGN
         oHJAsRZEw9TFdX37/sJjougiy5GyzgSbMZBixgVaiVtQl7VkGg/YldvD2/Q0Np06hPhY
         JftThw9XVeftn/rsjFp3sD6QbUiSdC0q6hMt7ZcrYaD0pxnAWOjFYIUehSd6u1wC1DVU
         duvQ1eNyRPvJj4eRxs0GIxYWf7/bbVFJcuVlqChFxlIUA9YAj90+vt6D6j/dipl/0gJL
         3BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004109; x=1763608909;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUfD60rISo+k9JtkAjKYR1UHW6lfVIwWkmpIaKaNt/M=;
        b=qSx6+7vAcW8bq7bWECrYuZPr18/9vbA5ApcvwuQ1ObNB8ZwWCTYmnCTkJSNOX2s8xY
         AWEmAuUFZEEAw3GcRb+3RGdplEjdKvQu6gV0q18iRKTOYs9QvOFczBNd3oYORVr+B9hG
         XcEA4Uty8NQJY3zr52iA4/sdnK6gR9clSibZEqMswE7yLf4UxBVwZWNAyIc9ceVrqRG9
         AOgNF06WN2ZMchlaXU3MR+BYW0utYerG+IYdieZa52hnN6wYuwVh9h4wHIwZ7QYCUbc4
         0O/sS0d/s5G6nqa+dl/oeRA3224M8AjcKD6bWPGK36GKBtttWrghnFZSocey1DXicost
         Er9A==
X-Forwarded-Encrypted: i=1; AJvYcCU7uc/2CyfLI58166QK1aaJvQS9Ir00hQ2xFf8VdykZRjcFK7BhvlgNLif4UHfR4dEdtbwQhWzKXhC0TBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BfWs3SgGtr399ZHus93yRZutYpCrAI2k910/yAVRx11FI+Qh
	/CjYLvvnpSmWy4IxEanAebwQj+6v8vAhz3TZ4c7jgoKu6t1uvdx2nvAYWkGD6d6uVihFnutgtSs
	ia9rF6bTDXg==
X-Google-Smtp-Source: AGHT+IFs5u4ROWbpZd/4BhunaP6M1PonK2/Ce4fD0dFAnkjTPUIRD+anTyFRoghu6YlPZnCBPcCSsEbEULgb
X-Received: from dlbbq19.prod.google.com ([2002:a05:7022:6713:b0:11b:1a9a:d2e8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:286:b0:298:8ec:9993
 with SMTP id d9443c01a7336-2984edc8d47mr69733895ad.38.1763004109471; Wed, 12
 Nov 2025 19:21:49 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:17 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-30-irogers@google.com>
Subject: [PATCH v8 29/52] perf jevents: Add idle metric for Intel models
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

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 61778deedfff..0cb7a38ad238 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -3,14 +3,25 @@
 import argparse
 import math
 import os
-from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
-                    LoadEvents, Metric, MetricGroup, Select)
+from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
+                    MetricGroup, Select)
 
 # Global command line arguments.
 _args = None
 interval_sec = Event("duration_time")
 
 
+def Idle() -> Metric:
+    cyc = Event("msr/mperf/")
+    tsc = Event("msr/tsc/")
+    low = max(tsc - cyc, 0)
+    return Metric(
+        "lpm_idle",
+        "Percentage of total wallclock cycles where CPUs are in low power state (C1 or deeper sleep state)",
+        d_ratio(low, tsc), "100%")
+
+
 def Rapl() -> MetricGroup:
     """Processor power consumption estimate.
 
@@ -70,6 +81,7 @@ def main() -> None:
     LoadEvents(directory)
 
     all_metrics = MetricGroup("", [
+        Idle(),
         Rapl(),
     ])
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


