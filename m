Return-Path: <linux-kernel+bounces-898579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B54AC558C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 29E12350B87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBE2315777;
	Thu, 13 Nov 2025 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPU6hhSe"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F4314B96
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004117; cv=none; b=tFXTkBJ/Uqx9OKR71Be1dHq5CJGJ0hRjbf7ZesW18frJEaN9n8KfSMqXckbusDF6OdjcimpjiKoqASbaxx13mQOG0LMHIav6WN2AhHMzBeBu0kHhdlzPHx7pNjavmv3k2NIMyJE1iDMzs9oUlEATz4wKYbTudeylGLSqe3KawwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004117; c=relaxed/simple;
	bh=z5RnlpBZPvfr6INpWnWxPkma/Gch1LEd0hqJhYDXnfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=C/MYUIByToCMclsWKQwzsgpDSgiCcrZhHVe8DVfH9EVBqelmrK+i89kY+SzHU9jo0JGsu7MVe7nqDeuGDP/iwuQ701fKCdnVTFn6K5OPSELnOJPt4HNPauNAAvjFyshz/HN2r8k7MsJK0FuXckiKYeFiSrSCwB4j/C/N6xMh4H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPU6hhSe; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2982dec5ccbso8008835ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004115; x=1763608915; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmcjKuNFcJHZDe7xzYJ1gZ2K+daO0s8XALlHIa8vs3M=;
        b=gPU6hhSewe+CshiPg0Gt4zxBB4psQur9SdgNdowp4ws+fsxfTvxxHC0S//k08hihLV
         SVLRDD/09e9SfKpwsgs6ftXVeFzTSfsOB+WhmcS69XDIz8lc7XRToj1Fs3rhz//6UFQa
         gX6g5Pz0Wd05MlAM67r6wnOTS387Y5yA4EsQ/25IeeOFie5pwEY583S/qNMRRtJkTxPl
         nZoIAneyk/lp+uwLGkZ02qbPakIL1/WR3Ix7y2e8h88LsIQnSxzadpn/OWy9pcg7YDiS
         6g2MW7DPW4E6VovrS+gc1WXNhNt+nHNjdXKdqQZYiShGACJXDLUdgBylMSOoG0IjQXWx
         VvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004115; x=1763608915;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmcjKuNFcJHZDe7xzYJ1gZ2K+daO0s8XALlHIa8vs3M=;
        b=RxRq2GBNq7ofk+54WjgFh9OEftw5DDr8b+ncj+XgKqrL9P3r6nYxB2fjSW/Rj6i4Qn
         tjDh9BwYKQrerhvPRgjelar7fCPxYremM2QPkTpUo1zaiq6CqV0srrcU6Y3QJ4sWicgi
         lMjLAQ83REXggV+u/RDltaCcD2i6VzR/fpQzSbuBXLXF7ueJ3uy+mtIZK6+LXw1QRCgZ
         zg8JwOCBbEYT0C+yNR6XPayOyrLBmlQnIDLJ0P7KJjW7FF871ziozVPz2dF5zScP2e7A
         QBIH6n2Ur3srRbUqzPEU7OLpc3X1TyVbyZG24JRgCcXolgs8pNh9d65a14O1J7Z3K8ds
         gtKA==
X-Forwarded-Encrypted: i=1; AJvYcCVUhL/84g4dlHik9YLJtwo+JUs6Rn/dqUt6bUHUn0KZTvZAUJbzXbFIzWQACHVe9Ug9NOp6LZTQp1lJyf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFPT71lJ2WrGRchdk40WUHnjXefraZtIUbPiacD9B5ocYUPPEt
	xWJCUJtOttosu8tMHjXmRrkObCuVUgEln/pY1Qt/m70MO184Vtn5U9NAw4IIJOG40P1gawX2MJf
	4amoAnFWXTQ==
X-Google-Smtp-Source: AGHT+IHOUSMLa1YSvCkaGBpoVfvjCLq+Pz6jwy7ndCEZnQHlKP1tEJmdy8fGKp7SvMwY2P4ptvvIxoxDtYWx
X-Received: from dyboc10.prod.google.com ([2002:a05:7301:3f0a:b0:2a4:559f:7c4e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11c6:b0:297:d4e7:3066
 with SMTP id d9443c01a7336-2984ed490b0mr70140925ad.18.1763004115321; Wed, 12
 Nov 2025 19:21:55 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:20 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-33-irogers@google.com>
Subject: [PATCH v8 32/52] perf jevents: Mark metrics with experimental events
 as experimental
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

When metrics are made with experimental events it is desirable the
metric description also carries this information in case of metric
inaccuracies.

Suggested-by: Perry Taylor <perry.taylor@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 62d1a1e1d458..2029b6e28365 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -10,11 +10,13 @@ from typing import Dict, List, Optional, Set, Tuple, Union
 
 all_pmus = set()
 all_events = set()
+experimental_events = set()
 
 def LoadEvents(directory: str) -> None:
   """Populate a global set of all known events for the purpose of validating Event names"""
   global all_pmus
   global all_events
+  global experimental_events
   all_events = {
       "context\\-switches",
       "cpu\\-cycles",
@@ -32,6 +34,8 @@ def LoadEvents(directory: str) -> None:
             all_pmus.add(x["Unit"])
           if "EventName" in x:
             all_events.add(x["EventName"])
+            if "Experimental" in x and x["Experimental"] == "1":
+              experimental_events.add(x["EventName"])
           elif "ArchStdEvent" in x:
             all_events.add(x["ArchStdEvent"])
       except json.decoder.JSONDecodeError:
@@ -61,6 +65,18 @@ def CheckEvent(name: str) -> bool:
   return name in all_events
 
 
+def IsExperimentalEvent(name: str) -> bool:
+  global experimental_events
+  if ':' in name:
+    # Remove trailing modifier.
+    name = name[:name.find(':')]
+  elif '/' in name:
+    # Name could begin with a PMU or an event, for now assume it is not experimental.
+    return False
+
+  return name in experimental_events
+
+
 class MetricConstraint(Enum):
   GROUPED_EVENTS = 0
   NO_GROUP_EVENTS = 1
@@ -82,6 +98,10 @@ class Expression:
     """Returns a simplified version of self."""
     raise NotImplementedError()
 
+  def HasExperimentalEvents(self) -> bool:
+    """Are experimental events used in the expression?"""
+    raise NotImplementedError()
+
   def Equals(self, other) -> bool:
     """Returns true when two expressions are the same."""
     raise NotImplementedError()
@@ -249,6 +269,9 @@ class Operator(Expression):
 
     return Operator(self.operator, lhs, rhs)
 
+  def HasExperimentalEvents(self) -> bool:
+    return self.lhs.HasExperimentalEvents() or self.rhs.HasExperimentalEvents()
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Operator):
       return self.operator == other.operator and self.lhs.Equals(
@@ -297,6 +320,10 @@ class Select(Expression):
 
     return Select(true_val, cond, false_val)
 
+  def HasExperimentalEvents(self) -> bool:
+    return (self.cond.HasExperimentalEvents() or self.true_val.HasExperimentalEvents() or
+            self.false_val.HasExperimentalEvents())
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Select):
       return self.cond.Equals(other.cond) and self.false_val.Equals(
@@ -345,6 +372,9 @@ class Function(Expression):
 
     return Function(self.fn, lhs, rhs)
 
+  def HasExperimentalEvents(self) -> bool:
+    return self.lhs.HasExperimentalEvents() or (self.rhs and self.rhs.HasExperimentalEvents())
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Function):
       result = self.fn == other.fn and self.lhs.Equals(other.lhs)
@@ -384,6 +414,9 @@ class Event(Expression):
     global all_events
     raise Exception(f"No event {error} in:\n{all_events}")
 
+  def HasExperimentalEvents(self) -> bool:
+    return IsExperimentalEvent(self.name)
+
   def ToPerfJson(self):
     result = re.sub('/', '@', self.name)
     return result
@@ -416,6 +449,9 @@ class MetricRef(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, MetricRef) and self.name == other.name
 
@@ -443,6 +479,9 @@ class Constant(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Constant) and self.value == other.value
 
@@ -465,6 +504,9 @@ class Literal(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Literal) and self.value == other.value
 
@@ -527,6 +569,8 @@ class Metric:
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
+    if self.expr.HasExperimentalEvents():
+      self.description += " (metric should be considered experimental as it contains experimental events)."
     # Workraound valid_only_metric hiding certain metrics based on unit.
     scale_unit = scale_unit.replace('/sec', ' per sec')
     if scale_unit[0].isdigit():
-- 
2.51.2.1041.gc1ab5b90ca-goog


