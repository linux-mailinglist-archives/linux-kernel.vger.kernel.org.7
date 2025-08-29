Return-Path: <linux-kernel+bounces-791061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC4BB3B19D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8015A17D63B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C12922FE18;
	Fri, 29 Aug 2025 03:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMby2EK8"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936922F386
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438316; cv=none; b=XC9pAZMksD6DMLNEIIgq/yfHb++APsHVrm2UNkatlemWRrOrb5bzTEQM+2fXPUUA3UCSVeQ5h9NsRPSP5pjXjtWN4XMk6d88t9Kd2eRkJmQm2ZNBVUgMqqUi+R89KBXlqIPGesekmjkPKzVWdgSy02Rdn0Gk4vVlkViLcoKLePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438316; c=relaxed/simple;
	bh=c3ejxxmCpih2FejWuj1uI7JXyYijFQDEVDox/rS/kio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ETH8Aq4of0y1Udbw5cSDdj8ch/ABJqPXEeVUtKrbh+1x8eBgeg4kpWegvg528jZjYtlGnXl+kWnfw3Hd4123UcP1q6HZGysobl05F7NF/dkvmwCeF6h1DhOgwgX/5G39wlNeOgDNzYFOMFqNqj3J5oc/wbuPFxX87BC6IleFnW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMby2EK8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24895637fe1so18550465ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438314; x=1757043114; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AoMWzySU45oKrnsAGKA2ac/gq6rzQnZKhL6Vg5y4z4c=;
        b=OMby2EK8sro081ivtaG4nciZ8O33BUhbn3nw/jgLGpt97K1fI1NhkeLtqp0NV8Y980
         fPtE4VhqUki+C2Moe8VbLrrRHxcVBcWISE+EHcqCwhvORte0rFSFdqVEtD97xojDAZ7j
         4zVLH5NWBrDkaa2FxSJ/MmF8aSQNDkXFaF/a6O5GCaZDCmvsaP6EYdgqb4uI8evLiSOt
         LiirhnLtJoEgbSjfgMgoFhVUJsdMCTA35nHKwYdMQScwByOJyAj8LG4+CRUX6opTS/ky
         oDRSF8fdgaKUQv/Eu09K4WhZX16H3bY1fWGRVS1r9vjYTCk6gMzEHQKzw0I1znmRtw1C
         FPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438314; x=1757043114;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoMWzySU45oKrnsAGKA2ac/gq6rzQnZKhL6Vg5y4z4c=;
        b=SqJtvx5CBBwkChwMr46D5GYKDNdUzYDEGLzdNn0RvCW9fxP//UZG8+ZEXj+KsZcLCy
         6iki8MqOGRRbtXJO9w+r7z4oSJnFyK5LKYRVZoFdJNsQMTJ27i2xeMcRplMmIa3bAZa4
         50JoeDCts8BlvUBEDr7d9ljJdh2YgQV9g3mwhRbkC8gdhtEfpcF7M/9/c/k7Qap7+G4w
         ULCk0hw5Pip2EnKBrCkWmbQ/VWiSaFYIATQ6TbL9mttlcZRpTvw6O7nuoDwYxApRtVaI
         BsmIry1qIJcTdHM1GwxWPKck8F8Dz/AQDsYvD4r0stsRcJD7sQLLDn+pwDhSQHeupZbQ
         /cRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlHG6sJSI/A5TXkF2JbL+DnWCx0yAqQ+vNtbMRWKgiQNTMmcQMDgDdkc567BMjyNXNwJAJy2+TiSGPpSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDtiRpX1lTQDDURpFykbBuPgYYvkIHdO2J59/Ee9ZxKfDueZ/
	RRUxquXm/7utevgWVlzjkXR8+5mJyrZijHsm7a2Q4O04kJfrN10mMIJsfKq5rLVv1rFO12fulIH
	BxOjeILqBoQ==
X-Google-Smtp-Source: AGHT+IGDpZCeQHu8P5QFeXYfRIGjydBHiyNGTL4cQZaEokQB/kxuwm2ylp5bN7HDVQ9zEnM1p6Nt4kdd+fFG
X-Received: from plxj4.prod.google.com ([2002:a17:902:da84:b0:246:b41d:2524])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1249:b0:240:7247:f738
 with SMTP id d9443c01a7336-2462edee76fmr351166985ad.1.1756438314047; Thu, 28
 Aug 2025 20:31:54 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:29 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-5-irogers@google.com>
Subject: [PATCH v5 04/13] perf jevents: Add br metric group for branch
 statistics on AMD
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

The br metric group for branches itself comprises metric groups for
total, taken, conditional, fused and far metric groups using json
events. The lack of conditional events on anything but zen2 means this
category is lacking on zen1, zen3 and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 105 +++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 3c36078ce727..9171d23039cc 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -7,15 +7,119 @@ import argparse
 import json
 import math
 import os
+from typing import Optional
 
 # Global command line arguments.
 _args = None
 _zen_model: int = 1
 interval_sec = Event("duration_time")
+ins = Event("instructions")
 cycles = Event("cycles")
 # Number of CPU cycles scaled for SMT.
 smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
 
+def AmdBr():
+  def Total() -> MetricGroup:
+    br = Event("ex_ret_brn")
+    br_m_all = Event("ex_ret_brn_misp")
+    br_clr = Event("ex_ret_msprd_brnch_instr_dir_msmtch", "ex_ret_brn_resync")
+
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    misp_r = d_ratio(br_m_all, br)
+    clr_r = d_ratio(br_clr, interval_sec)
+
+    return MetricGroup("lpm_br_total", [
+        Metric("lpm_br_total_retired",
+               "The number of branch instructions retired per second.", br_r,
+               "insn/s"),
+        Metric(
+            "lpm_br_total_mispred",
+            "The number of branch instructions retired, of any type, that were "
+            "not correctly predicted as a percentage of all branch instrucions.",
+            misp_r, "100%"),
+        Metric("lpm_br_total_insn_between_branches",
+               "The number of instructions divided by the number of branches.",
+               ins_r, "insn"),
+        Metric("lpm_br_total_insn_fe_resteers",
+               "The number of resync branches per second.", clr_r, "req/s")
+    ])
+
+  def Taken() -> MetricGroup:
+    br = Event("ex_ret_brn_tkn")
+    br_m_tk = Event("ex_ret_brn_tkn_misp")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    misp_r = d_ratio(br_m_tk, br)
+    return MetricGroup("lpm_br_taken", [
+        Metric("lpm_br_taken_retired",
+               "The number of taken branches that were retired per second.",
+               br_r, "insn/s"),
+        Metric(
+            "lpm_br_taken_mispred",
+            "The number of retired taken branch instructions that were "
+            "mispredicted as a percentage of all taken branches.", misp_r,
+            "100%"),
+        Metric(
+            "lpm_br_taken_insn_between_branches",
+            "The number of instructions divided by the number of taken branches.",
+            ins_r, "insn"),
+    ])
+
+  def Conditional() -> Optional[MetricGroup]:
+    global _zen_model
+    br = Event("ex_ret_cond")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+
+    metrics = [
+        Metric("lpm_br_cond_retired", "Retired conditional branch instructions.",
+               br_r, "insn/s"),
+        Metric("lpm_br_cond_insn_between_branches",
+               "The number of instructions divided by the number of conditional "
+               "branches.", ins_r, "insn"),
+    ]
+    if _zen_model == 2:
+      br_m_cond = Event("ex_ret_cond_misp")
+      misp_r = d_ratio(br_m_cond, br)
+      metrics += [
+          Metric("lpm_br_cond_mispred",
+                 "Retired conditional branch instructions mispredicted as a "
+                 "percentage of all conditional branches.", misp_r, "100%"),
+      ]
+
+    return MetricGroup("lpm_br_cond", metrics)
+
+  def Fused() -> MetricGroup:
+    br = Event("ex_ret_fused_instr", "ex_ret_fus_brnch_inst")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    return MetricGroup("lpm_br_cond", [
+        Metric("lpm_br_fused_retired",
+               "Retired fused branch instructions per second.", br_r, "insn/s"),
+        Metric(
+            "lpm_br_fused_insn_between_branches",
+            "The number of instructions divided by the number of fused "
+            "branches.", ins_r, "insn"),
+    ])
+
+  def Far() -> MetricGroup:
+    br = Event("ex_ret_brn_far")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    return MetricGroup("lpm_br_far", [
+        Metric("lpm_br_far_retired", "Retired far control transfers per second.",
+               br_r, "insn/s"),
+        Metric(
+            "lpm_br_far_insn_between_branches",
+            "The number of instructions divided by the number of far branches.",
+            ins_r, "insn"),
+    ])
+
+  return MetricGroup("lpm_br", [Total(), Taken(), Conditional(), Fused(), Far()],
+                     description="breakdown of retired branch instructions")
+
+
 def AmdUpc() -> Metric:
   ops = Event("ex_ret_ops", "ex_ret_cops")
   upc = d_ratio(ops, smt_cycles)
@@ -78,6 +182,7 @@ def main() -> None:
   _zen_model = int(_args.model[6:])
 
   all_metrics = MetricGroup("", [
+      AmdBr(),
       AmdUpc(),
       Idle(),
       Rapl(),
-- 
2.51.0.318.gd7df087d1a-goog


