Return-Path: <linux-kernel+bounces-791097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7376CB3B1FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425A217D488
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924432264CA;
	Fri, 29 Aug 2025 04:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdOXeAuF"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1B225417
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440704; cv=none; b=qdZRb2ES2saCUXtQ5h1+H5XEsvzLE0fCQqkJMLeFpJxKRHkQw1T3trBouvApIw8aUdLPJ7EIkwWkEF5BF92S7Ex8GeO39Y4TUyorTK+RvIJEsjkNDRSrEdM81+xaBFZP77EJQROboXG8X1OixXJfkc0bTuknhtQtidpdcdSxc4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440704; c=relaxed/simple;
	bh=G/t4i0AD/wXY46jSWn8fPOGWm9EJPElV8fdpB14Hqqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=A3RuScuQYZi2LKXnNyBeMwe7yZuKSjKk58Sh0FhEtVIy7RAp5A0ggYEMFpVf1oaVPCjLaRbJT5yYVl5zS9ww0t3UgwNPhUitzPp4OKfuJsZjY+apcefzPPPQA8/tZfl7sGd3fYMSovjs1mlVIccV0JZb/rfm7dxzPlRNyTD0VKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KdOXeAuF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32515e8e4cbso2780483a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440700; x=1757045500; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHLltxQv707jyq7uE7p0UrQqauyWghAPg6sL6mEpwW0=;
        b=KdOXeAuFbZeWMjQ0BC8c423t66frHN8IWkEAdcZsnYyqRjR/Q7/vKbARJ+zRbp5Zkj
         enBNGFhqQB517XPHfbY/130sI1qwlJ+aVy+mLGsVpkhOEdUWkNxU93pOyMR4d6hoSsUO
         SrjSHqT3A221u84MXdDqVMkmVGrg35NsNZNR3ti0O3Htd3aekCPOZK3m1hfVeimHDsHM
         GY3CWBAQVTDv0b2jaqTzDqNmaVAdG02pBWsy8QoEAR4txa3CHOpE6AeRwx9QKDUCZkC5
         FptP16bgfEYSgZ/pUH6FWD3xMjO+gZwi6I/bEYnsSpEUP0Q8tCzgnDoVwHA4O3pWKyFI
         PUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440700; x=1757045500;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHLltxQv707jyq7uE7p0UrQqauyWghAPg6sL6mEpwW0=;
        b=kgfA4sr85UzhLvjQDz9rcCHPVU6LpAGY2kO9TSm9ozthYL45Eq4HXpKX3AQgyT05Sw
         YcSjmAwuQMm6JGqQ+IpDuevNtsyWgyUxoDRC3kqqZyPZ122v1jEf9p57Okma2uSWTsfm
         PxQ6MDvz/X0dW5WtWcS2GX2ckDl5OF+Su/1aqlL1+7gcT8M/sZ72Zq2uUbRuajYATN5R
         IR7mGhGY21JWv5aUXPOShzez1DCB1CEPirD9N+7LimOzKzJeGdoeUZD+WtYw+qyaBWe2
         zQsz5VfTbIWkexamSpxApDWfnezXmYbWoVdkkTeYAi61+D3oaVaP/oZ85VnWwjFoPIfR
         y5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVFVQuRnWI4a1GrE+5rFACri7UVRlLgQdGJlEERYDYsllqDusrIjG9IuAdCHlhDn49oeS/Nr31GrX9MilU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8WZa2Sl7UD3B/uYxJIifzrSUe5EdPmDOl7KyoGQVowoNYQFHw
	STJOQJ+AlWLjpecU5vPJAhRYpIUnC6TFBZ7hzz2XvsFpSZN5leKTsRNHPCly6eTbS35TWtFrjWe
	K1T3og0hIoA==
X-Google-Smtp-Source: AGHT+IFfpTgVoPoMxVch6at38Y2vDYbk+oRvzq0Cy165fE8ad3D5ZjTVH0tIcualVhI+K4bYl/JUesxhYn9O
X-Received: from pju9.prod.google.com ([2002:a17:90a:d49:b0:327:b1f8:7689])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0c:b0:249:147:95bb
 with SMTP id d9443c01a7336-24901479934mr26325865ad.13.1756440700494; Thu, 28
 Aug 2025 21:11:40 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:47 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-7-irogers@google.com>
Subject: [PATCH v5 06/22] perf jevents: Add tsx metric group for Intel models
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

Allow duplicated metric to be dropped from json files. Detect when TSX
is supported by a model by using the json events, use sysfs events at
runtime as hypervisors, etc. may disable TSX.

Add CheckPmu to metric to determine if which PMUs have been associated
with the loaded events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 50 ++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 1e4790717cec..a353e682df96 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -7,6 +7,7 @@ import argparse
 import json
 import math
 import os
+from typing import Optional
 
 # Global command line arguments.
 _args = None
@@ -75,6 +76,54 @@ def Smi() -> MetricGroup:
     ], description = 'System Management Interrupt metrics')
 
 
+def Tsx() -> Optional[MetricGroup]:
+  pmu = "cpu_core" if CheckPmu("cpu_core") else "cpu"
+  cycles = Event('cycles')
+  cycles_in_tx = Event(f'{pmu}/cycles\-t/')
+  cycles_in_tx_cp = Event(f'{pmu}/cycles\-ct/')
+  try:
+    # Test if the tsx event is present in the json, prefer the
+    # sysfs version so that we can detect its presence at runtime.
+    transaction_start = Event("RTM_RETIRED.START")
+    transaction_start = Event(f'{pmu}/tx\-start/')
+  except:
+    return None
+
+  elision_start = None
+  try:
+    # Elision start isn't supported by all models, but we'll not
+    # generate the tsx_cycles_per_elision metric in that
+    # case. Again, prefer the sysfs encoding of the event.
+    elision_start = Event("HLE_RETIRED.START")
+    elision_start = Event(f'{pmu}/el\-start/')
+  except:
+    pass
+
+  return MetricGroup('transaction', [
+      Metric('tsx_transactional_cycles',
+             'Percentage of cycles within a transaction region.',
+             Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
+             '100%'),
+      Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted transactions.',
+             Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
+                    has_event(cycles_in_tx),
+                    0),
+             '100%'),
+      Metric('tsx_cycles_per_transaction',
+             'Number of cycles within a transaction divided by the number of transactions.',
+             Select(cycles_in_tx / transaction_start,
+                    has_event(cycles_in_tx),
+                    0),
+             "cycles / transaction"),
+      Metric('tsx_cycles_per_elision',
+             'Number of cycles within a transaction divided by the number of elisions.',
+             Select(cycles_in_tx / elision_start,
+                    has_event(elision_start),
+                    0),
+             "cycles / elision") if elision_start else None,
+  ], description="Breakdown of transactional memory statistics")
+
+
 def main() -> None:
   global _args
 
@@ -101,6 +150,7 @@ def main() -> None:
       Idle(),
       Rapl(),
       Smi(),
+      Tsx(),
   ])
 
 
-- 
2.51.0.318.gd7df087d1a-goog


