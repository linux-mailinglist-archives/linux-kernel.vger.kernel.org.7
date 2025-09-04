Return-Path: <linux-kernel+bounces-799914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A262B4314D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161F2686019
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58A42472A4;
	Thu,  4 Sep 2025 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ok3HM2uH"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12C3244685
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961227; cv=none; b=XGs0mahrR20WjyaGocwJWI5D+bMN7qSrhgqB5UdB9etg0crGncDyJPle0Kwb2ghpajbCgOIaP6LzjdF5EOeJGhMTfAt8Qbfj8QDo90a0ThIH/2n0ff/VCG8l2tvzJ7aB+0QhTYMpn62Eg+FdMUP1AYdnJbw9QXMBRweoIeKD+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961227; c=relaxed/simple;
	bh=DnCBmE4xK87Sv3hyk5xLp4ZbiKYtBCPdhaJpNRobkAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WMSf3xmp6Lko0lgqwu0k0xMa1UUnw1x8osn3fyrwnoOfn3C6qkOeh3yUXj6GdARhZ6smhI9QvuGdA1RewhPuXmeWosn0Bv93gG3vaHreHeN+HmuLfUcvshSsIAbrn/vb7AEjw7ynUQRfI5+Q+61yVC2dBqYx0zFPhSA1HnKWnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ok3HM2uH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174b3427so461170a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961225; x=1757566025; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3G8zcYg9JGKOxRo4IqvzwI2DTd0mcQtugg6AtT15mRc=;
        b=Ok3HM2uHWvJM/vMKpX8zN+FZAhh+fKSC0L88TN9zq01HFF1aZgLKPj4+Hho4CV3Rt9
         DtSY4ur3kW8uzqeGgouVk3cHKh5P4KT77S4cttkJbcMeeyuScyaUWru00kmwajDaLTiq
         79+wz/5SbQ6XB2ExD0dgDtJTBDzx2jEY7JXzWrstSx2u0HX3yIyMaIWrUyE0bLw9MvHs
         s8E4rQ2ZDvsqyn4V83LHdTFqR8ON3goBkRKCjAI9er5D3XA4vHscDWyYQOc5O8CHFrZp
         W+XYcKljsnGfDLS+6FMg4B4jH6trZQyik3sBhAEYWkJDSHgtmXUFi683rZ8ayXwlb8D9
         eakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961225; x=1757566025;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3G8zcYg9JGKOxRo4IqvzwI2DTd0mcQtugg6AtT15mRc=;
        b=Owyn5l8dyferA9JWMZtI90/B784Pd+1Nk6dztnuGI3FIrN978i/IcXi8e4x+izQJbw
         g4K84s1xy2tPs87TbRAaDoE1U86biO1UZgHsc6+5rm1l9sxmh+0InxESho9a6KAZDXfd
         AYqbjs5ldpJ+YBMygFIGl30PwHhrPID0hIL1h2DixEaihgcajyFMcHTpwJKgPk7y2fwC
         EcqpuEDOzcwIvGkwq7ONiDcrUsCCAvZJPNqIzHoHYzSOpq03jCtTwBM1DvlaYnrxFsmo
         MmSSG5lMsJ0p6Lg9PcJ/gAdNlctI/UvjKyGwoyF7zqYPzNh39nXFNzF7xRNDxyJchXVq
         cS3w==
X-Forwarded-Encrypted: i=1; AJvYcCVXpuvdlKd0TbTAPUHAXEdtwIEiv1QfPHDrs8s4TT3tKpAXDHzrgPL72Z9k86W/Al+K1HC/M9qyjJ3WsTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt1Z4Ae0qdPkebfX7uDd2M3oVBKYir/Kqd2Ec0DYNqiAs8bJd6
	N/42jfbJqufNut7fb9/ebjyEfn6N4O425Wzu7XTR4IP+fAmkCbRUIUZwJKTYCyKwT//WXcCYonK
	i5wnKp6nFfQ==
X-Google-Smtp-Source: AGHT+IHpgcJVMNlEzLD5ocJ7Nx7ZlktfJkvFI1S/iIp2hbQTjXIwkBte/hjR6eWcD5TA6JOydPV14ik/5xjn
X-Received: from plap20.prod.google.com ([2002:a17:902:f094:b0:24c:8b76:4f4b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22cf:b0:248:bae3:ecfb
 with SMTP id d9443c01a7336-24944b2940emr225476855ad.59.1756961224961; Wed, 03
 Sep 2025 21:47:04 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:35 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-5-irogers@google.com>
Subject: [PATCH v6 04/22] perf jevents: Add smi metric group for Intel models
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

Allow duplicated metric to be dropped from json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index b6d92e935c59..7d1c4c21a786 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,8 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
@@ -56,6 +56,25 @@ def Rapl() -> MetricGroup:
                      description="Running Average Power Limit (RAPL) power consumption estimates")
 
 
+def Smi() -> MetricGroup:
+    pmu = "<cpu_core or cpu_atom>" if CheckPmu("cpu_core") else "cpu"
+    aperf = Event('msr/aperf/')
+    cycles = Event('cycles')
+    smi_num = Event('msr/smi/')
+    smi_cycles = Select(Select((aperf - cycles) / aperf, smi_num > 0, 0),
+                        has_event(aperf),
+                        0)
+    return MetricGroup('smi', [
+        Metric('smi_num', 'Number of SMI interrupts.',
+               Select(smi_num, has_event(smi_num), 0), 'SMI#'),
+        # Note, the smi_cycles "Event" is really a reference to the metric.
+        Metric('smi_cycles',
+               'Percentage of cycles spent in System Management Interrupts. '
+               f'Requires /sys/bus/event_source/devices/{pmu}/freeze_on_smi to be 1.',
+               smi_cycles, '100%', threshold=(MetricRef('smi_cycles') > 0.10))
+    ], description = 'System Management Interrupt metrics')
+
+
 def main() -> None:
   global _args
 
@@ -81,6 +100,7 @@ def main() -> None:
   all_metrics = MetricGroup("", [
       Idle(),
       Rapl(),
+      Smi(),
   ])
 
 
-- 
2.51.0.338.gd7d06c2dae-goog


