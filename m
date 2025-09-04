Return-Path: <linux-kernel+bounces-799880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E908B4311D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFA61BC41D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B4223F27B;
	Thu,  4 Sep 2025 04:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWH0F62a"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17523815C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960339; cv=none; b=sWeoBnNRwb2ZBX1XiW3Y77xVABr7AHcDrghadbVjrbD3u/B46mhQLS0Vu/ytgikXQVgVGB/Um/eKx1FLSJPm76Je6yvFn2rYtFsXed/ykM2/7SMJofXIg+mJMDyslBRvjCHrHVzRFAk6j9I5e1FvVwh/esxcwansSF9ulRrbWyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960339; c=relaxed/simple;
	bh=LuTtqrZtMK/LT91ZBhYeb6dv2+IYGH4Y7JmRH9yoVWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GcfEtRBDr3pf04CMZLt/J5sZOQDwhCiRdLlE/Z6CVN/Vf1A/e0toEdvNkW0nM2NFsAVzD7Q9xI2szxymd/AAK8WaermHMCMXRmW+AkXFw4mDyYVPaZQwUrpAbVKPjN6xnnXUXHKhVQ33fqjsN2lm/YWug091flNdyUbPsZcvmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qWH0F62a; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7238c2008b8so10171897b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960336; x=1757565136; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAXms+yNTcz9MOzTz+T4V/K7WtgdGpeN8pxEyZvcsEg=;
        b=qWH0F62aS+0d9k2Nmyc7cj8FhsmHgwrdeQAsWurIvg3fLOHfiIcEwAGnJ1REnqyd6W
         yrMrqZqg8azJaI5hiItyFvTsK9M60rD9m3qOZ/soC1M/5HbxKJ2zSZZhk4zN8lNiBBvx
         DBaGaVLpag+7bmGSr2N+DTTZUbukw/clcA9cHnqS6hqgl07CEskP3tL1qr0mIbt863mo
         pjnFeOMRcBdBIfWeHFxdRcjTOXK9GwqVp3OcxC6FQ5KOQgD7zvaVbku6Sz/a4ax7OJhV
         q4BEjdz3nXtD7XgIqwAQJ8sp1iDKIlLVbkgywHAIgrmUZpq0BwbBbexHi7X/8qD0UATx
         pCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960336; x=1757565136;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAXms+yNTcz9MOzTz+T4V/K7WtgdGpeN8pxEyZvcsEg=;
        b=wPHTTEOgiK3YGEd2TWgr/u9Nihq1xW84FJILK9dwgg1Q4EURxHnDgyw4t5sLwWPr9+
         MQ0PbJ4XjNS2mOtRSorjCj31zAMESiR8Js8AJy9jfIpcsQK1keD3+RJ6c6GhpF6kEYgi
         /ykb2z05X4YqEX9dwo99B5VyxZE5RpoVoJrsDVNmbikUGDF63vGKgO2S651Op1E+XEVr
         B4LKKXXpfHXWo4nr83DZBjwWBttYfiFZRnnBUWl/R6zukSLYC+jRII8OvaTpxHqWPa9u
         BLYHPQHQgF18yg/oL4sORqFeSkunccovZ5ZRzA7UgzRq4J7uzPpDYFKP4iWjetfhAMLw
         D9WA==
X-Forwarded-Encrypted: i=1; AJvYcCUTOGYnd7XWQ3UBJpOsQwxAIEdWvvnH2oa4Nuo6RPOh1GAbJQ++ASCsOLyJQtLwgV1g5Oeyq5S1YjhfoOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvTYBrLWz1UttoRKE9yn48H8hh1R4uRKPWDCLe+WppG4Nma0EP
	Q0WX0gfAC3OmcfFCZGgV64C+z3hM4hsZE2Kgs9YvmxqrrA5xv1lwOCI5pEpXVuKP1PdHYhEukYn
	D7/4kHO/jzw==
X-Google-Smtp-Source: AGHT+IG+eJur2f22n7KQAymFYTrbd/O0gLRQuIRAxqa77rwiU5CGGfSQr4EMFEWvBCN1nq3atksUkihmbzFH
X-Received: from ywbci4.prod.google.com ([2002:a05:690c:a84:b0:721:b03:972b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:23cd:b0:600:6ffd:899f
 with SMTP id 956f58d0204a3-601786c8ebfmr1342251d50.36.1756960335787; Wed, 03
 Sep 2025 21:32:15 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:31:57 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-3-irogers@google.com>
Subject: [PATCH v6 02/12] perf jevents: Update metric constraint support
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

Previous metric constraints were binary, either none or don't group
when the NMI watchdog is present. Update to match the definitions in
'enum metric_event_groups' in pmu-events.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 92acd89ed97a..8a718dd4b1fe 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -4,8 +4,14 @@ import ast
 import decimal
 import json
 import re
+from enum import Enum
 from typing import Dict, List, Optional, Set, Tuple, Union
 
+class MetricConstraint(Enum):
+  GROUPED_EVENTS = 0
+  NO_GROUP_EVENTS = 1
+  NO_GROUP_EVENTS_NMI = 2
+  NO_GROUP_EVENTS_SMT = 3
 
 class Expression:
   """Abstract base class of elements in a metric expression."""
@@ -423,14 +429,14 @@ class Metric:
   groups: Set[str]
   expr: Expression
   scale_unit: str
-  constraint: bool
+  constraint: MetricConstraint
 
   def __init__(self,
                name: str,
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: bool = False):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -464,8 +470,8 @@ class Metric:
         'MetricExpr': self.expr.ToPerfJson(),
         'ScaleUnit': self.scale_unit
     }
-    if self.constraint:
-      result['MetricConstraint'] = 'NO_NMI_WATCHDOG'
+    if self.constraint != MetricConstraint.GROUPED_EVENTS:
+      result['MetricConstraint'] = self.constraint.name
 
     return result
 
-- 
2.51.0.338.gd7d06c2dae-goog


