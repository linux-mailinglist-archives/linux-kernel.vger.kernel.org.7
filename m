Return-Path: <linux-kernel+bounces-791039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6136BB3B16E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 183837B8D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E091DFD8F;
	Fri, 29 Aug 2025 03:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPAzt7FS"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D32224B01
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436857; cv=none; b=ITSTgkblEmYx7R2u51srQGZ3CwOQym9qC+NldSiXNEmtZpTCAqltamMZyL7VemdymcARj/wVuXizqMyw45+GD3jyQPXYszf6JkFA9UM6zxBs7qDUxVWpvgPagHQLppymnLEvZckQtoPMtc78EoxmCNwwy1QD6eQoNNXhw8wyC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436857; c=relaxed/simple;
	bh=DW95+ROWeRh1f+uKQY+1pJ9Rl60s07F9LROWdSTmwMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=W3Y8iIoDE2r2WnoMaMD5EgWJRWhDa7wXkoO09N0dOzgjMpfqAfWixV96sq3wENQ5+yVLGwwBBsGlS6ETlsSs5S1CmQyrcF95+RFxf33CCrxhPd4cLWNBOBJxVkxhuikhF+7BlaCCvmQ2ZEy4nA+rmwvwigpcLq3mrlh6Ppidoxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPAzt7FS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3259ff53c2eso2335361a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436855; x=1757041655; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQN8o0Ql3jo0PeWKZ5rEvbUgELTGNYwgjgL4vx70CkE=;
        b=vPAzt7FSYFyaaKm8O37AntQm+dGJgkknMz3DEK0IYps/FFQTwJF8EfnivkOtGwkPRP
         xIpIYp5fPLN/8A5eds5e6gPwQ4275qUOx/eX/Ac1ru+kb26KshjUmhENflG7dKtGdZGU
         b/YPVL83w2n676QGt4tzoh8N5jbQwG+Pl/0dY5NgNKEp5S5kHsyDc9mLK+uLKAOo0BEC
         xB9jGEDow8QX/V32W1hVGjd3ukH6rd+Z4EA70GHhhXFGgOdiNy2JKhrQ8w4afYZkzZvt
         Bxu4d3/DW+lYW/Svbugpyegw+mYfd1HSA1NStISSkEJ7qjk0HYY8vuKqxYc41SKu5C3D
         i/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436855; x=1757041655;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQN8o0Ql3jo0PeWKZ5rEvbUgELTGNYwgjgL4vx70CkE=;
        b=N2Es3O6gISd5UBPXSTEbn8lvCUti42/5oetfnhn8EmMTyd1LXlDN8JsT65fb9ip8HG
         VYBLou7WWJPOIs5M/BycdzeRhgP4i4rv1cyg0erf26/vM0KbkUbqk/jPuski97aZausa
         KUzAM+D7AR25GCvH9l2g/tsk9ROCqDoCOJ03GjFr6rIlccOZVBITnuJOSkvC4S2DIc9C
         f/AmBeXILM8TNEmGtsGE8xfwLpDG5PUu6EX45erpLEI1Rz2hYL96vFzmk/t75T/XRiRK
         xfDKZCkZvWJpCb//5u59QWDv2a2FaQ35wpAZtYi6+3QtejfbXTpkJukrwO6RrXKTCHXs
         oiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHXgzMwr6OKIPcx7ZQEcjNAAh2uVa8aw19XT24YTnwbr/dAiP1TKatYANHgpqjOjehRHEXChiqEJycs5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yoqdyETzzJs6HwO/7SqgiF0pfkR+z/UiKYNfFZMG5aHrvMVu
	okd28uQ2MPzRGsd+qOMnKDQDwS3cVkz0XXhJ+F+30ilsdKXQueQ4r9DpUGguK6UaezulAXTMfKl
	TqdZ1/4X/2g==
X-Google-Smtp-Source: AGHT+IFR/Hp+eBJPAAV7DMXkQEy7huzl6iYCK/AsfSYzwTRaHCQq1hJGtlXTIyhm0OUhww6jIR6wNjj3iO5D
X-Received: from pjbsq5.prod.google.com ([2002:a17:90b:5305:b0:325:220a:dd41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d50e:b0:248:fbec:7c9f
 with SMTP id d9443c01a7336-248fbec8090mr35229745ad.25.1756436855474; Thu, 28
 Aug 2025 20:07:35 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:16 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-3-irogers@google.com>
Subject: [PATCH v5 02/12] perf jevents: Update metric constraint support
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
2.51.0.318.gd7df087d1a-goog


