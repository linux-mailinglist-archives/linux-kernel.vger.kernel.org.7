Return-Path: <linux-kernel+bounces-799887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA870B4312B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8190A1BC6BE8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6876D25EFBE;
	Thu,  4 Sep 2025 04:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SwcugEqo"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B0230D0F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960349; cv=none; b=VrZuleSgdX0GQry+UdywmAyO2GI/OvbkfUZZRn9DiOt5HXPiLrUj6+lFif9zD2zuJNDU891IGOTi1GX9F38Ic0l5VEzqeXZjJINuO2GQus3T9Yj6sqpaAqVbKlLcemILxorIu/zIqodqhJy5UoScbPDHLlbW4ZVWU9iUynZG1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960349; c=relaxed/simple;
	bh=ui2NdSfnCSI3LKNJX9yOFKQUdrXm+Z6DoI/4/pw3Rac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JNZ5Zm5fjQXOGqfYRH+Chp75kJXogCWuim+v9bT8EUg/g8L6YC1ljF/AswAK6sxm5wqxxBsj0Oi+iv521lOZd+eAy7XmQFQNh3MAHP9+hD1NRKtOqg61zhoR9ANO3g7v7al6cOll2LtiRknrh7TS7EuARbt6htVBNb3+VZ8215I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SwcugEqo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24b2336e513so9313895ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960348; x=1757565148; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rY976CsvGExY3BkK5ltk0kMiD/v7wyV09FcFSRUtR+E=;
        b=SwcugEqoec/1wzEA2Y8DGg+rxFpBz/3raSFWIJncK5pqjueIZNurvT5E/c+ZvYFh5P
         do7VcJFAf/ZF1YMUzZhaaG+x4jOodIO0zAJfseqJ8n4M0gBUDrH5mIKzq5d4oyqrlLov
         xTkeb/FgLbMhu+yMbQWa7GI873KeVLXtwV+6nfjDEUP654IEzEhJiREZB1QB5HmU6PFC
         C1a+NSVXJjPQZgOUIixiUHs89wJxEMVumhOGMoFnkNlmcAmAnTI+HA2JD4NnuoxW0Vr4
         Bg3qryQxZgeCPHQqIH0ED/jaFl/5R/J0gvcTjqMSmu1T7QGuV8x2DOSU7k5U1BKQK+SV
         nwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960348; x=1757565148;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rY976CsvGExY3BkK5ltk0kMiD/v7wyV09FcFSRUtR+E=;
        b=KAbwqFlQ3AEKJkAc8tsBt//LSYWbbcMguDv/dusP6sVAqTGdLBXIAVzWFszyRDbkRK
         wH4MPg85n0rd/tkxIf8nmN7w1rIx4kU2O6ehXT879ikdFFHovUYBHUiy0oRkX9FAlhA2
         80SbDEM6wltDxtJPl4v+84KtkoAMRSDR//a72NvGjXt/UEO+w7KR40cWHanVkNWXPMm9
         8L7TdiTRuOLieqKmEBApKzagopBF8lRSNRAzuraCewcOkqWAFSRBQ0o0lkf3Wis1EGtL
         HRdOlp0jkO9IO5tvI/ZOleioInHsu0VFGLhO9cFKrU/UxVNgzOlpu18gg5cQFzZfDtLS
         zc/g==
X-Forwarded-Encrypted: i=1; AJvYcCXfqaDi/S7TCm4GGYE0FGHZTNLslMF4/ddlIKKTHnMkMTcHCYYB01L+2lnncxJVNN+NDHlNZwPh2ooaw40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybsm2p701PBfV1RgxKCfR3ZIuW++2q1IwgntO8HTrOE7pSSelQ
	YGjHAoKk3BiCUknKQNplV1qzYs99ZEERRR1WfEi11fann+hca9O9cBuvx0Er44VMLa6bXL/Z4vA
	jCR2BC6ENEg==
X-Google-Smtp-Source: AGHT+IHQjGaaw0xJYft2AtK/lNOIJoRU1I5rB+ZoDKT0YFs3WNJS6Oo23FyOeJ+gplrMorT1zATLWNom1sBF
X-Received: from plgt2.prod.google.com ([2002:a17:902:e842:b0:24c:cd65:485c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e888:b0:249:1f5f:f9a2
 with SMTP id d9443c01a7336-249446d298dmr219922095ad.0.1756960347412; Wed, 03
 Sep 2025 21:32:27 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:32:03 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-9-irogers@google.com>
Subject: [PATCH v6 08/12] perf jevents: Move json encoding to its own functions
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

Have dedicated encode functions rather than having them embedded in
MetricGroup. This is to provide some uniformity in the Metric ToXXX
routines.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 34 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index e81fed2e29b5..b39189182608 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -484,15 +484,6 @@ class Metric:
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     return {}
 
-class _MetricJsonEncoder(json.JSONEncoder):
-  """Special handling for Metric objects."""
-
-  def default(self, o):
-    if isinstance(o, Metric):
-      return o.ToPerfJson()
-    return json.JSONEncoder.default(self, o)
-
-
 class MetricGroup:
   """A group of metrics.
 
@@ -523,8 +514,11 @@ class MetricGroup:
 
     return result
 
-  def ToPerfJson(self) -> str:
-    return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
+  def ToPerfJson(self) -> List[Dict[str, str]]:
+    result = []
+    for x in sorted(self.Flatten()):
+      result.append(x.ToPerfJson())
+    return result
 
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     result = {self.name: self.description} if self.description else {}
@@ -533,7 +527,23 @@ class MetricGroup:
     return result
 
   def __str__(self) -> str:
-    return self.ToPerfJson()
+    return str(self.ToPerfJson())
+
+
+def JsonEncodeMetric(x: MetricGroup):
+  class MetricJsonEncoder(json.JSONEncoder):
+    """Special handling for Metric objects."""
+
+    def default(self, o):
+      if isinstance(o, Metric) or isinstance(o, MetricGroup):
+        return o.ToPerfJson()
+      return json.JSONEncoder.default(self, o)
+
+  return json.dumps(x, indent=2, cls=MetricJsonEncoder)
+
+
+def JsonEncodeMetricGroupDescriptions(x: MetricGroup):
+  return json.dumps(x.ToMetricGroupDescriptions(), indent=2)
 
 
 class _RewriteIfExpToSelect(ast.NodeTransformer):
-- 
2.51.0.338.gd7d06c2dae-goog


