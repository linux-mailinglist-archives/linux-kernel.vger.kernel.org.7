Return-Path: <linux-kernel+bounces-799901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543AAB4313F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8FB1C20412
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC07E258CE9;
	Thu,  4 Sep 2025 04:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4TG155OZ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDCA254855
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960869; cv=none; b=numhYBYoMYEPn/wWgnndjJ8SQtQXcIrHEaUCtLPEo21jV6uBDHw1g5iVz0J4sAxe7UC+uxTTB3jsgWfpddBR0F2CdtOMUoOXhZoF8Yje157Bd+t+qXeyZqFN3IU4aCyfk5NS8b8JoRVBzVcKFkGiaZvjaBuqZTIvXKBK6kq1npo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960869; c=relaxed/simple;
	bh=n71EwqXEyxFzyBXTXHsi/GYekTFJItMlQdS/XUW3o58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=n6+5B43u33svTcoaa7D2zSORJuldA/55xxS5VFqjBSD0POUVQfju9D4+FjnCLfdos4p92r5PU/wKM6ssQD2yCPLoJ9dvmPYqpYHx6HKVaRUnsPwOWip/xuwCy2wQcGY4Hs99c5KZSIglxwalP9aJvKWwZPDu0tMiwTnZpYjTYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4TG155OZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24cc4458e89so7396945ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960867; x=1757565667; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kECjm07dTbm03ElO9+d/ucpfxsbPWw5fbO2IeYKMCFA=;
        b=4TG155OZErEvaOZ5Aveo37jkixAeFX1ycaEd7f1KxabHs3RcWzKW+AtTC2YeGcmNjj
         jWsbAQwQ7exvAoeaMNZmb1PYBw/tT/xDJSYJEpeTZX8BrLaVWFWRp5L/FckKAuYvzNVI
         z6WBH0YxG8jMFfgHILDz4eYzXQW/dn4AZFhveaPwnCyhP/MSqdgHwYZrMPGcR4k2B0Fk
         4pPdHOpJkdDLrGV7wFYf1oXomdsBi/wfW407mRFjRnXPeaid8Mfux3w9hJnGGiaFZ8xl
         LGLDeb43dVV8xzAy4bGv4lrqzu4r+2H+A/8jBD7fq+l+llVnPiTz1A/bRnpIgdoIqdzd
         5IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960867; x=1757565667;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kECjm07dTbm03ElO9+d/ucpfxsbPWw5fbO2IeYKMCFA=;
        b=giloU3lajwP2P9mSIqbTNEzhZuEoqx4sF1zbs1lwxDEghBLa9a9FI+kW98j//QBM/c
         +yW9Y6U9tjOp+ZePYbOCwgvoZ/LXMhMnrkD23w30fweYDcp9LQMIVoytV1K5rP45om5F
         XVE6feowaBBuwUSAtRa1tTy/RZD2oNlx5QsBYS3DZTLIDl2t5FSrx+4r1UaqNnAKej08
         IwfFjR9Z+5krTYH7DHiWR3zfon0UFOw5v38tkVfAbKrzPw28rWPyZS/XyJVau69cPqdY
         5G0kv3ZlneWSUSY0CX6WMbpyTbnVRoqNlp7/ayF8LYbKVarXv4JXPE9ua7VAomK32rKX
         VSmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2VucrLBBjF6W7ecauJTk+PJAUKEdUSeEA54quXXZn55VvZOrFBzSTXSSliSpbuzFLm7ymyNSbaCQzdKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30j3aKjtffNQgWc3SCgcGPd26yjTOr4HdpvJeoqqb4xsRdSkG
	WsvyR9p97JC/vWlopgLJsBRDCojZT3OxXQcc86Y2GtBLeU6oqD/pF3btOMOPmn9RbEKFyydCExQ
	oSkkXu+hkfg==
X-Google-Smtp-Source: AGHT+IFRopwXzAbURDRcPYjPfS0BiDYtMflnHslLrKj7Zz1CgEaLsiEdNlyW7xbQjYbywcT5oVy09XaBF3Dd
X-Received: from pjbdy4.prod.google.com ([2002:a17:90b:6c4:b0:32b:8466:a680])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4e:b0:24a:979e:c06a
 with SMTP id d9443c01a7336-24a979ec489mr204013015ad.60.1756960866863; Wed, 03
 Sep 2025 21:41:06 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:41 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-8-irogers@google.com>
Subject: [PATCH v6 07/13] perf jevents: Add itlb metric group for AMD
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

Add metrics that give an overview and details of the l1 itlb (zen1,
zen2, zen3) and l2 itlb (all zens).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index cecc0a706558..40128903eb7d 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,53 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdItlb():
+  global _zen_model
+  l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
+  l2m = Event("l2_itlb_misses")
+  l2r = l2h + l2m
+
+  itlb_l1_mg = None
+  l1m = l2r
+  if _zen_model <= 3:
+    l1r = Event("ic_fw32")
+    l1h = max(l1r - l1m, 0)
+    itlb_l1_mg = MetricGroup("lpm_itlb_l1", [
+        Metric("lpm_itlb_l1_hits",
+               "L1 ITLB hits as a perecentage of L1 ITLB accesses.",
+               d_ratio(l1h, l1h + l1m), "100%"),
+        Metric("lpm_itlb_l1_miss",
+               "L1 ITLB misses as a perecentage of L1 ITLB accesses.",
+               d_ratio(l1m, l1h + l1m), "100%"),
+        Metric("lpm_itlb_l1_reqs",
+               "The number of 32B fetch windows transferred from IC pipe to DE "
+               "instruction decoder per second.", d_ratio(l1r, interval_sec),
+               "windows/sec"),
+    ])
+
+  return MetricGroup("lpm_itlb", [
+      MetricGroup("lpm_itlb_ov", [
+          Metric("lpm_itlb_ov_insn_bt_l1_miss",
+                 "Number of instructions between l1 misses", d_ratio(
+                     ins, l1m), "insns"),
+          Metric("lpm_itlb_ov_insn_bt_l2_miss",
+                 "Number of instructions between l2 misses", d_ratio(
+                     ins, l2m), "insns"),
+      ]),
+      itlb_l1_mg,
+      MetricGroup("lpm_itlb_l2", [
+          Metric("lpm_itlb_l2_hits",
+                 "L2 ITLB hits as a percentage of all L2 ITLB accesses.",
+                 d_ratio(l2h, l2r), "100%"),
+          Metric("lpm_itlb_l2_miss",
+                 "L2 ITLB misses as a percentage of all L2 ITLB accesses.",
+                 d_ratio(l2m, l2r), "100%"),
+          Metric("lpm_itlb_l2_reqs", "ITLB accesses per second.",
+                 d_ratio(l2r, interval_sec), "accesses/sec"),
+      ]),
+  ], description="Instruction TLB breakdown")
+
+
 def AmdHwpf():
   """Returns a MetricGroup representing AMD hardware prefetch metrics."""
   global _zen_model
@@ -339,6 +386,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdItlb(),
       AmdHwpf(),
       AmdSwpf(),
       AmdUpc(),
-- 
2.51.0.338.gd7d06c2dae-goog


