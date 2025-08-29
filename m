Return-Path: <linux-kernel+bounces-791094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E475B3B1FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EC87C820E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5C6239E61;
	Fri, 29 Aug 2025 04:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdx5xElg"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44B224891
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440698; cv=none; b=PMWTHa60sxDw7PipydM93CxxmRWjsfIY6BJ5zIuQgSvTjC+BanILghGjCh/1/c8+bfRr8+PXGhRq0OTQ5+8PHF0y6KFcdupwhBZ1h+JtKCiMYrjB6vI+KSAGNWaLY6ZtxA3k9u0v5kk4IlO93E1Q56K9Vjf5iNFMFVIIer+mD3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440698; c=relaxed/simple;
	bh=Lj1TxfTdhC1agPvRb6StALeOwsuDc6E3yrG6gjoa+Lo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MCQYEUbQfta+YArJb45YZNz7IZUnb/ENlrb9sdrHqRQ+VPwkR1ItlJTCzl9hSSaVA+2HmEYGJO9tWuZAutI1n5tYDKzX6rKlwq97qZbe8+57Ruv1wdyWE9cUTrhtwbHgcrZrup7KckVWYf3RGdHWqKeaehTuDdquHvticzTYFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdx5xElg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e72dfbso2448476a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440697; x=1757045497; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWyndJocq5wXKzLumVZv4tX78BF9vwSGLU+R4CMfK6M=;
        b=gdx5xElge24gnDiaCg324ZCB7SGdULBU6t0oxiKPouseuRDwJL9u6L8yPU2PhsOk+A
         AlcxFhPAjAxvZt4zp2LdWZtblG6GBIolBdupE3O+JknZfkS7QAesslo10+VQ1BIX+Z70
         csGvYQZ/we/GaGdZ4LWYAizOk8gLLwHbZpEgMVkia1/yAT/Wg7UGuylxMdZpM/CDYuso
         5Gnx6KZQn42siGxZDYx9szzjoDDfQWKibjXZXEy30Qgr0yIkwc9mmaZUp4tnHy1NCa4j
         GuEZ6zLvjgidQ/pbz12kpu3Ksh5v5+MpLi6vJVzSJU3+Jxdpg0jqpSssrTp2bfS73no0
         gXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440697; x=1757045497;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWyndJocq5wXKzLumVZv4tX78BF9vwSGLU+R4CMfK6M=;
        b=eYpJ80qvlF/A153VmL99A/QA+2rXkDvoLnsmjBXzy1eKOKgNTxaK906f7UdBEfmI8U
         tX42w7/TtGkNl5SIhDMs7zThEmMDN6gA1keE6RAnFXYIskdPvHDigq8OTJQH/PRYm1+r
         CqEdvR3sJJRtjn+76OedD0U/XICCa6skTkg4zP/7lyR5kFKBTN0+CAgz9/rRXdZK/m0d
         SMCn2w8YZBihwWmOq7EVV1JJ2Wils/8rSMxAlOqwbaIq9BHmKlHgKRzK2H87ChaWJV12
         rskBkxtoxbc/lNZPtYe7m1DplNGQm+0ONxxp4Ra5BBPm3+TMADase728hqMokpvqfVaV
         4Eqg==
X-Forwarded-Encrypted: i=1; AJvYcCV6UEPZ5QWvkpscfquGfIW7gAoV1gR0vp2caAApoVGFrKwRsR2DBYqewT8f9zY9YC2xO/0j0xR+U0WXFYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4MEd9oWIuSojwSlab4RuYlM897qV10nVwv97++IoLI+3aA7jp
	FlqD9AHuBX+bo3K5Q1DvZk0BAnhVrNBzyCaegQ7sowcViCNYVl/J0/AQq1eBL3MR2D4jANn0rAn
	YUXB6TYGriA==
X-Google-Smtp-Source: AGHT+IGgxPdxoRBfj1e4QkTolOamcDyFLHq/wP2LRKKmIQn1SERZR2QSFugXp1s2TEzQ7YSySJOjfdPEFpE4
X-Received: from pjbpl10.prod.google.com ([2002:a17:90b:268a:b0:325:7c49:9cce])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f87:b0:327:e781:3d2e
 with SMTP id 98e67ed59e1d1-327e7813ef0mr1236053a91.33.1756440696865; Thu, 28
 Aug 2025 21:11:36 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:45 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-5-irogers@google.com>
Subject: [PATCH v5 04/22] perf jevents: Add smi metric group for Intel models
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
index 0bb28f4c8316..1e4790717cec 100755
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
2.51.0.318.gd7df087d1a-goog


