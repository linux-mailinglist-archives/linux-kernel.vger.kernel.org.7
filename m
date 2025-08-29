Return-Path: <linux-kernel+bounces-791095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5571DB3B1FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164E0203432
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC5723B62C;
	Fri, 29 Aug 2025 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hq6GpZA0"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E05239570
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440700; cv=none; b=FZEowaPqYX3E3v3AxO+oQBz8Uri/gmSc4uo43F6K9takTdxNb7YdQGq5hkN5411r7pUXxW3BRdzZGOY18DuisxS4/HRUotxCP2Qil2+uMfNeqP957JPbJmSDca5tX7mPqXSggwxq/GfFluzqp7VOdIZRnnq9CQI5tPYMnPs/gGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440700; c=relaxed/simple;
	bh=MCG6CjoNW6uxd3dkTAQbhonZPPggN4P+ZXSpzIAMvPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=E657yQda6eI8WRZAVkshz3+JZJVNbTAxWy+S+dPlG4ODDuV3JqK7Ynd23WqcRxUKJF9L6jX3+wzhB9UzBsQfO5b1A9mnu4rIwo2t7mXZ6mhwsnBQ28BNu4zufuO0HN/w1/m/SI01lxu19Vdx8JVEEE6MHeNxFZVMDAwGtW4rSog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hq6GpZA0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b49de53348aso1071637a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440699; x=1757045499; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcVJ+u3sdC6BnMWHfOHUF/wdZM6izAkF1pUn3DY+eV0=;
        b=Hq6GpZA0HnP8SHNru10Fe0Q496kqLnnjgAd4zHN+XuEwtMgwUYcymMgPOjrIxJ0L7g
         ureQLEmPFp9eazB/5c0oOEXJTf6M1d8sBMdXKimt+M4fUH/HQtFnd/drj5BTJ1rgYV9l
         Nus1/6X+v0PnxTrnZi2DGxpwP9fxFihwxZATpOcrofU1Xp5B8W+t6WjeKh1tpZUBRjHM
         NOkE6J/SNICTG1jLswh26nz2eCjhcCJGJreBzuuXo+O6WygxCvXB1GG9smSa5Cst/5td
         adY82wPqT7ki5A02i4mzuVuu2Ldh4c4ky1K9sBAi7ymfKWWl5KCkbXXCHobsaAgb1hcg
         TO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440699; x=1757045499;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcVJ+u3sdC6BnMWHfOHUF/wdZM6izAkF1pUn3DY+eV0=;
        b=AqyLeewJcdWmRFyaEB9a4OLDLpdr2qfx9/3qCoEemq8vhurhJnpFj0hn6oJoyzy/BE
         FKkRvSi+uMgmAgoM0dd+D/CqgqY7yIQA0h5B6OVNho9t3mXOmto2Q2SXRfEPL1ZVapIB
         M2d9d+Col2eyalFn8x632HqFqEPSUvmhY2RW81bAncjWrHN1blm8PGqhQchtkX03/PhZ
         3sBc0hTKDGfJYHuBFhBTkGPW6lxZIrjvsMVGUnh+CQ8BFejg8/+i0/tCazA3rgkYBtoe
         63GOamXbXPMN9d8AM8aTltG7klnAvfjUr5ZpmO7byo/6DIkntVKB+TYA57jYzx/tu4Oq
         q0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVWDkPVm1qjG8TLwZMhksvflrPyaIH8yfHD+mNweUJsGpA0/lI3RUel4FaksW0CJ3btwS3zsbYyLBl52Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL9Bp/Mz8wPoJ6pFbYm3LUkLhBwuiidoZpBI+MfaSAys+Ws/ZP
	m6kqVYVuxmq2hadQjRRjgiStUU6ef8cZeZOiQxwd/2JyOCeBDpi2ddtKdVj0Dyb3BxVvv6zAsWw
	XRiikWOzL3w==
X-Google-Smtp-Source: AGHT+IFMf2p7oY8yto0U37ftJV8URBCPGTUxXUA8ACJh9GFlq97G4+JtuI0Gz8WySzkyYotspgt5TUkUvgtt
X-Received: from pjj6.prod.google.com ([2002:a17:90b:5546:b0:31f:6ddd:ef5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d93:b0:243:27d2:61cd
 with SMTP id adf61e73a8af0-2438fad28f4mr14375530637.27.1756440698627; Thu, 28
 Aug 2025 21:11:38 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:46 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-6-irogers@google.com>
Subject: [PATCH v5 05/22] perf jevents: Mark metrics with experimental events
 as experimental
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

When metrics are made with experimental events it is desirable the
metric description also carries this information in case of metric
inaccuracies.

Suggested-by: Perry Taylor <perry.taylor@intel.com>
---
 tools/perf/pmu-events/metric.py | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 4f62f252abef..b77485b47666 100644
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
       "context\-switches",
       "cycles",
@@ -31,6 +33,8 @@ def LoadEvents(directory: str) -> None:
             all_pmus.add(x["Unit"])
           if "EventName" in x:
             all_events.add(x["EventName"])
+            if "Experimental" in x and x["Experimental"] == "1":
+              experimental_events.add(x["EventName"])
           elif "ArchStdEvent" in x:
             all_events.add(x["ArchStdEvent"])
       except json.decoder.JSONDecodeError:
@@ -60,6 +64,18 @@ def CheckEvent(name: str) -> bool:
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
@@ -81,6 +97,10 @@ class Expression:
     """Returns a simplified version of self."""
     raise NotImplementedError()
 
+  def HasExperimentalEvents(self) -> bool:
+    """Are experimental events used in the expression?"""
+    raise NotImplementedError()
+
   def Equals(self, other) -> bool:
     """Returns true when two expressions are the same."""
     raise NotImplementedError()
@@ -248,6 +268,9 @@ class Operator(Expression):
 
     return Operator(self.operator, lhs, rhs)
 
+  def HasExperimentalEvents(self) -> bool:
+    return self.lhs.HasExperimentalEvents() or self.rhs.HasExperimentalEvents()
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Operator):
       return self.operator == other.operator and self.lhs.Equals(
@@ -296,6 +319,10 @@ class Select(Expression):
 
     return Select(true_val, cond, false_val)
 
+  def HasExperimentalEvents(self) -> bool:
+    return (self.cond.HasExperimentalEvents() or self.true_val.HasExperimentalEvents() or
+            self.false_val.HasExperimentalEvents())
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Select):
       return self.cond.Equals(other.cond) and self.false_val.Equals(
@@ -344,6 +371,9 @@ class Function(Expression):
 
     return Function(self.fn, lhs, rhs)
 
+  def HasExperimentalEvents(self) -> bool:
+    return self.lhs.HasExperimentalEvents() or (self.rhs and self.rhs.HasExperimentalEvents())
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Function):
       result = self.fn == other.fn and self.lhs.Equals(other.lhs)
@@ -383,6 +413,9 @@ class Event(Expression):
     global all_events
     raise Exception(f"No event {error} in:\n{all_events}")
 
+  def HasExperimentalEvents(self) -> bool:
+    return IsExperimentalEvent(self.name)
+
   def ToPerfJson(self):
     result = re.sub('/', '@', self.name)
     return result
@@ -415,6 +448,9 @@ class MetricRef(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, MetricRef) and self.name == other.name
 
@@ -442,6 +478,9 @@ class Constant(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Constant) and self.value == other.value
 
@@ -464,6 +503,9 @@ class Literal(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Literal) and self.value == other.value
 
@@ -526,6 +568,8 @@ class Metric:
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
+    if self.expr.HasExperimentalEvents():
+      self.description += " (metric should be considered experimental as it contains experimental events)."
     # Workraound valid_only_metric hiding certain metrics based on unit.
     scale_unit = scale_unit.replace('/sec', ' per sec')
     if scale_unit[0].isdigit():
-- 
2.51.0.318.gd7df087d1a-goog


