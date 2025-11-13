Return-Path: <linux-kernel+bounces-898570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CE7C558A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85D3F34C94E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CAB311959;
	Thu, 13 Nov 2025 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTKpKdRm"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7D3101D4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004101; cv=none; b=bFyo2wOGiARlG1D2geFFVAo/pWVTAlB/xLf0tNO+syCWRt1Hh+UokLCeMPbczq50d9tmPprK+Azpqgb4aniapwia7PizxY37wmqsbcbHsQb187mYVxzGE3AnOH3MOPM4DAlm9hRns4EJBrkvtq6+jY+ahIG/d+4hMTyCLdTb3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004101; c=relaxed/simple;
	bh=yg0mt3Fzot10P+eNDcOUbH/iz4GunqXxO6YAxrwdE44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=U4IN5lZIr8epMYgmxW22a9ptgmbzimjuegJKMMtiAqjj5vITUY1lkhqGO+WvKClLMWXtoeX4q73EiyWvZl5Ya4AEYStVfr7JyrXLUFoRkqvj8XYLgt96/Kbunn/spcqjAda/tRyy1moRQ5lfdQfmHUtgHivvMFlC5nj+cobz3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wTKpKdRm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29845b18d1aso4341655ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004100; x=1763608900; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=reofRYC+oJf3mFk6RisvPqv+0Lly+TkhvyT/wiXYQcg=;
        b=wTKpKdRmEf7Q4f/IFvlOOvb59yj8CzCuXZnd244JOF2ngeDxP5J+b1NFSENBOfWtMw
         93/uH/XmMVerwhf3jGvgpC7usQ3ftiVs3xJTksQhY1tSlEjKJMGSHh4UpbNkiQtSkxZH
         ULVSnEFyBrfO/qEWKPMwtL/Ej9Z9uzpx5WVhq2Ack4I06Bu3/LR9ZapDtx3kNMPXOiQf
         b5D9o2ySmemtcdpmuBfHCR6txfJfA0AnzX1S8Y0QpUY4OF/GPCqUFzlCtX9sU4NRFFcH
         SB5ZXljtbAO8ae3frYxN3b4KzPB8Eq0Q71TsiepFH+GBq+v3kQZ5kaUtyGmRM0QDvxlk
         5tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004100; x=1763608900;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reofRYC+oJf3mFk6RisvPqv+0Lly+TkhvyT/wiXYQcg=;
        b=gCQDSCsOpdm47OKA/qC3ukozNTWfKNBbYyCwwPqyK617aELe1XBFBaApfC80ljtPZh
         YVFb7eKhYxD0/m7J3H3IYlitZcBRTf2D7nZo7v915dMLgVvuMnPFgD9vs7qjcUmXOp+3
         jK7Ms8Uel8Vso4/LL48KIce1kDhl2fetRVdd9xWG4TY7QQFJHVAk63dS1qtwM1cJ20bo
         jZxte1daViR0zb9z8pJ+8MFU1C8UXk2JOOaAxzm81LZFx/qXPKexTvHrhqOR8CELsFuK
         52dA0JW6hACq5l/rJ34hU4z2Urdgcxpue+bS2zKF9B93P3K1MUrDM+a3Jb6ve2d7DgZf
         evyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF7fULSFuyIqnPG2+L/vMEUeHUijsm+xL/K24ic0JG4upphK6jA+DoT3l04aNT2FV330GAcVqbgK7o2tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2z42445cDAwenGY6gZ2g9j34yiZrJ5B6eOmGlb5Bofc6SQNX/
	4HupjNzzshllHGYhjpdofEVk8tipHUjdjM8G9he6Tfgsxfie3RnrJt5NsOOfL3JS2X8T8e8STD6
	uGWmrXCvq2w==
X-Google-Smtp-Source: AGHT+IFFURIhDsoWperE6E0wEJSVGWWpEc1yQCNVIRrUkX8FAAk/DyUqxwrEiSLSauum95UUhWMUe3eG7LIc
X-Received: from dlah19.prod.google.com ([2002:a05:701b:2613:b0:119:49ca:6b93])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e788:b0:295:560a:e499
 with SMTP id d9443c01a7336-2984ed2b60emr69691935ad.5.1763004099859; Wed, 12
 Nov 2025 19:21:39 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:12 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-25-irogers@google.com>
Subject: [PATCH v8 24/52] perf jevents: Add load store breakdown metrics ldst
 for AMD
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

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index d748b5c1d791..53f7c2198147 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -279,6 +279,80 @@ def AmdItlb():
     ], description="Instruction TLB breakdown")
 
 
+def AmdLdSt() -> MetricGroup:
+    ldst_ld = Event("ls_dispatch.ld_dispatch")
+    ldst_st = Event("ls_dispatch.store_dispatch")
+    ldst_ldc1 = Event(f"{ldst_ld}/cmask=1/")
+    ldst_stc1 = Event(f"{ldst_st}/cmask=1/")
+    ldst_ldc2 = Event(f"{ldst_ld}/cmask=2/")
+    ldst_stc2 = Event(f"{ldst_st}/cmask=2/")
+    ldst_ldc3 = Event(f"{ldst_ld}/cmask=3/")
+    ldst_stc3 = Event(f"{ldst_st}/cmask=3/")
+    ldst_cyc = Event("ls_not_halted_cyc")
+
+    ld_rate = d_ratio(ldst_ld, interval_sec)
+    st_rate = d_ratio(ldst_st, interval_sec)
+
+    ld_v1 = max(ldst_ldc1 - ldst_ldc2, 0)
+    ld_v2 = max(ldst_ldc2 - ldst_ldc3, 0)
+    ld_v3 = ldst_ldc3
+
+    st_v1 = max(ldst_stc1 - ldst_stc2, 0)
+    st_v2 = max(ldst_stc2 - ldst_stc3, 0)
+    st_v3 = ldst_stc3
+
+    return MetricGroup("lpm_ldst", [
+        MetricGroup("lpm_ldst_total", [
+            Metric("lpm_ldst_total_ld", "Number of loads dispatched per second.",
+                   ld_rate, "insns/sec"),
+            Metric("lpm_ldst_total_st", "Number of stores dispatched per second.",
+                   st_rate, "insns/sec"),
+        ]),
+        MetricGroup("lpm_ldst_percent_insn", [
+            Metric("lpm_ldst_percent_insn_ld",
+                   "Load instructions as a percentage of all instructions.",
+                   d_ratio(ldst_ld, ins), "100%"),
+            Metric("lpm_ldst_percent_insn_st",
+                   "Store instructions as a percentage of all instructions.",
+                   d_ratio(ldst_st, ins), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_ret_loads_per_cycle", [
+            Metric(
+                "lpm_ldst_ret_loads_per_cycle_1",
+                "Load instructions retiring in 1 cycle as a percentage of all "
+                "unhalted cycles.", d_ratio(ld_v1, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_loads_per_cycle_2",
+                "Load instructions retiring in 2 cycles as a percentage of all "
+                "unhalted cycles.", d_ratio(ld_v2, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_loads_per_cycle_3",
+                "Load instructions retiring in 3 or more cycles as a percentage"
+                "of all unhalted cycles.", d_ratio(ld_v3, ldst_cyc), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_ret_stores_per_cycle", [
+            Metric(
+                "lpm_ldst_ret_stores_per_cycle_1",
+                "Store instructions retiring in 1 cycle as a percentage of all "
+                "unhalted cycles.", d_ratio(st_v1, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_stores_per_cycle_2",
+                "Store instructions retiring in 2 cycles as a percentage of all "
+                "unhalted cycles.", d_ratio(st_v2, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_stores_per_cycle_3",
+                "Store instructions retiring in 3 or more cycles as a percentage"
+                "of all unhalted cycles.", d_ratio(st_v3, ldst_cyc), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_insn_bt", [
+            Metric("lpm_ldst_insn_bt_ld", "Number of instructions between loads.",
+                   d_ratio(ins, ldst_ld), "insns"),
+            Metric("lpm_ldst_insn_bt_st", "Number of instructions between stores.",
+                   d_ratio(ins, ldst_st), "insns"),
+        ])
+    ], description="Breakdown of load/store instructions")
+
+
 def AmdHwpf():
     """Returns a MetricGroup representing AMD hardware prefetch metrics."""
     global _zen_model
@@ -528,6 +602,7 @@ def main() -> None:
         AmdBr(),
         AmdDtlb(),
         AmdItlb(),
+        AmdLdSt(),
         AmdHwpf(),
         AmdSwpf(),
         AmdUpc(),
-- 
2.51.2.1041.gc1ab5b90ca-goog


