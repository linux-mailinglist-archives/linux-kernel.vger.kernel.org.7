Return-Path: <linux-kernel+bounces-898575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 855BCC558BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AB0B34283D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD6D2C326C;
	Thu, 13 Nov 2025 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TglDNn2e"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AD3128A2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004109; cv=none; b=pXq3zAcWTpaa5XMAzHT5oRKxAdB91AanBTK1HRrD4hio+wF2SMICwfCy+Rwxrq3SBTb6PY3zTZO73s5yApOUTpmg+35V6cB8syaKqLFuCtNbNgIAk6Y6boFjIzOrQ36CHIKUrNZqu9J0g1eAaRLtwu/3oqmtiGh+mxvHI5Fj9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004109; c=relaxed/simple;
	bh=r2UrYhm61SD5yyLdoCmXN9BNEALAkgCmf/uykNFhzbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=W1JF5j6Zu7iIMHIMXIoTQiWw933twjKaawmp/c6jafOraG0NfLvHcdBVZ/N2vaFRhMxQpU2vtP8o7PNiIXMnnVdyLANJelSIyXTJoobwNgZr8NOyRjxniaLaFHVljwSpqdv1fkBDLNbQgOT/x6vhdyQqWL/wlvGzPyreUwqkoys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TglDNn2e; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297dabf9fd0so4714205ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004107; x=1763608907; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JoGi9rMbDF7B/whY6ilXVrwbEGhJJ6yZ28PC3lW6tN0=;
        b=TglDNn2eNCLp8XVD8URaP5R5lYsZ7vjziNNDiRngr7HAtIjsFbefELPlHhsHpQa4ZE
         9cSBDZbtRqf5/jIt13/iqB1Z72ePmHt7lOYmH8IAxu2ZWrnlHhybUQYV2sRkWL9UV+Fs
         tJmVkjqLjw9Hwk6fB55xTe+nsm6Y2Z974e70qU0vJxfkoBFs39y8iGouEhOabIK8ucOp
         2G5tTEumFChBgY+sA5AW7ibyhagk9Rr4sJ3ar0m2tWYEJCDD2IATZ6PZRjQ455tRfkag
         wT8fBvxmGBK1xRIb/MpUuEVImDDDToBRr/T90+yN4HYoz1VuW5x9w7CciJTcflwTq/l6
         S4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004107; x=1763608907;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoGi9rMbDF7B/whY6ilXVrwbEGhJJ6yZ28PC3lW6tN0=;
        b=gZ0QYgA1XUfzUd1csMt7rIGCryu8kA8maH0efS26FFYJQQY3qr5Yq9nGiVRwfELZjh
         RGfPiwHtKVF5ol0XTkXbltFe589V4k0GQ83ylOO1Oisc5pmX+wJ75+szXh0+qCYEsJec
         m/8i7ubWCrggOXCft3xOuB4Uleo6dbDxM0T5QprpQYR+8/8KevSc9v784x3IaJT59TzT
         qXTfOIdisfgW6/Q2QlGN/+/R+wvYVG7sw68uha8M6EhBI7b7MCuHqr3Dufs1hqw1vMl9
         grJxavN5/89jnnI9jof1M2SCzTK00o+DI9yInZ0F/vl6AQk9rGLNfJoEaGwL1i/UcPMd
         oExQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP2/HKSN3xQhphezgdEXJ8uODUwJIEEGDDuQ6ZUJj7iF2revc2OkBJwKzdWowKV13mu8Swbcbvk/eWyfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySNw5gPCym0CZsceozNLh/2rSgTWolz/c5o9XDYqiyNSEYVxP7
	UkDlf4Qwu1sFsghB42QD1bEmSw6+Ves/Hqh02tdltGaX5iVv/nAGaxV1q9wGJa+HtTDG5Ewt7/s
	52rp5yzOLxw==
X-Google-Smtp-Source: AGHT+IFQG9GOkIf+nEvNCrJHxVthUiVLmkbajCBpSFkcPYvO21PGGwzhRTrNJ9xIQOxHi5Yji/heyhnMYr9K
X-Received: from dybkl22.prod.google.com ([2002:a05:7301:d16:b0:2a2:4de5:16b9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c6:b0:290:c0d7:237e
 with SMTP id d9443c01a7336-2984eda983dmr72287705ad.39.1763004107564; Wed, 12
 Nov 2025 19:21:47 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:16 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-29-irogers@google.com>
Subject: [PATCH v8 28/52] perf jevents: Add RAPL metrics for all Intel models
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

Add a 'cpu_power' metric group that computes the power consumption
from RAPL events if they are present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 44 ++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index b287ef115193..61778deedfff 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,48 @@
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
+    """Processor power consumption estimate.
+
+    Use events from the running average power limit (RAPL) driver.
+    """
+    # Watts = joules/second
+    pkg = Event("power/energy\\-pkg/")
+    cond_pkg = Select(pkg, has_event(pkg), math.nan)
+    cores = Event("power/energy\\-cores/")
+    cond_cores = Select(cores, has_event(cores), math.nan)
+    ram = Event("power/energy\\-ram/")
+    cond_ram = Select(ram, has_event(ram), math.nan)
+    gpu = Event("power/energy\\-gpu/")
+    cond_gpu = Select(gpu, has_event(gpu), math.nan)
+    psys = Event("power/energy\\-psys/")
+    cond_psys = Select(psys, has_event(psys), math.nan)
+    scale = 2.3283064365386962890625e-10
+    metrics = [
+        Metric("lpm_cpu_power_pkg", "",
+               d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+        Metric("lpm_cpu_power_cores", "",
+               d_ratio(cond_cores * scale, interval_sec), "Watts"),
+        Metric("lpm_cpu_power_ram", "",
+               d_ratio(cond_ram * scale, interval_sec), "Watts"),
+        Metric("lpm_cpu_power_gpu", "",
+               d_ratio(cond_gpu * scale, interval_sec), "Watts"),
+        Metric("lpm_cpu_power_psys", "",
+               d_ratio(cond_psys * scale, interval_sec), "Watts"),
+    ]
+
+    return MetricGroup("lpm_cpu_power", metrics,
+                       description="Running Average Power Limit (RAPL) power consumption estimates")
 
 
 def main() -> None:
@@ -33,7 +69,9 @@ def main() -> None:
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


