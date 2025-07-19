Return-Path: <linux-kernel+bounces-737551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD05BB0ADCE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FC51AA7148
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5C422538F;
	Sat, 19 Jul 2025 03:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VntBegkC"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C3221DB1
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752896748; cv=none; b=addTjYr4I0OAWSmhsNDNyQb4XXJbGWXgmDftpENBTRKPDDRLBnpQ/T7u/RF/OAdUfC4/gRzwOjD92WTbNh6Su12VhEcTqP5NKKLpHlepVXLlav3s9TX5wm4i+pWHmBjraa4BlkbnaW01Y4ujC4hYB3p4ULfpq9Pyubp8tvSaeV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752896748; c=relaxed/simple;
	bh=d7IJ/wsOkNu5sSHZzR2prXyO50/Ref/jxlV0ql+z+NI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Kb4i3e2asR7qLSszUBsA93iKS9hPAfi7/OFtD3VyXwd0aOS0HtzE8oBxzicoFnc4U5Wyz6agTz0T3DxdChKB4lFEoc7sb2toJ6p6Ea8x8sxoIblowkXsZuYQMvZVvj0A90yL2zV+VuM+l7RMRS/JK4xzOzeJJvJNgLS1GMLXDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VntBegkC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235e3f93687so39051675ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752896744; x=1753501544; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6RYOfo1e+dPbu+hizmy1GF6v7IsXdR4N/AmArIYOVY=;
        b=VntBegkC2ievT5F7PNCF6dhtf+hAjqexYUxBKaeBFz5F78UDAwDHBBohetMGfBVdaS
         Je5J9i0/yu5Td4n/t7/bTbdsLqayShetiES+Rg5UTYHQ8piku96l7NNF3iN7SpceQJDU
         7w3Z91wXq3si7vOrcI0mxFtWgbAj9+eAwDOz39rALd+V9t+7ultCzGx4G1nXxxKnCLYF
         vF5CAQG0eN6tRxzmjog3HnNWpAzixwpdaCRtnyaYnWr9oHXyxrBwD4Rt/RVMzlHjHY3v
         jD1XbV0xE7rZoJeW8oZosoGfPkD2rs1bWnNu1e1xzHwsbW6zmAkT9SMwg8ST6/IRHMFw
         Jn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752896744; x=1753501544;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e6RYOfo1e+dPbu+hizmy1GF6v7IsXdR4N/AmArIYOVY=;
        b=dHq6N3mKJvtEWtl2r4tScju6aO5IUunwOQ8GgVqIuH0dd+JiyYlklzqRC/MVYq9EhZ
         IwD31mGze1GxYp9ko2fuZMUTJrgyxPUKQ7THmq4VahH1GyrJ6kLVNKNPAnbeA4vT2Dqr
         5NhwNR9gZ4mWVn8LAesgccS+EaKO0gvAzD6KuAYE+IO54QWu8HvD3lwQe+qUZqIdwsl9
         uaw8/pOzuMlWfPPEIiAFFamnN4k2DXUUmzm3SpwCmkHevWnaNA2fFzmoaOCRRvAqkLWP
         Y72zj7wBK7xdoENFTxEBWSX1rbAzOepShSlajdJUuTxdb+UOxtDSHKmPQyPuuCq7++7K
         TTag==
X-Forwarded-Encrypted: i=1; AJvYcCUy7jelX1IuAIhAUy8l0JN1+/8NkKOIfp9TRuk9p3SQGkfXqH/9lfKrLi9WbiRHq1Au+7jK9V9Aq267hmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhSqYtf5zpFh1AeNdqS7oHF13GsrEeu2bx3RgaM6wzz0/U1LoA
	CzVq28PlXE0kb9H/nS0qwtj0ZLyHWI9OTrCKe5/9S3GI5Et31AWURZiobKKMF+LWayt6igTnh8K
	omNRKqg0Dhw==
X-Google-Smtp-Source: AGHT+IEmJ05wRNcEOFielnUom5fSKxLwns2GRmqAaFvTgIxLuFUzeTNvIf+wRzW6R0ncoPw5VOrWm5FsAUBr
X-Received: from plhv12.prod.google.com ([2002:a17:903:238c:b0:234:8c63:ac2b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecd0:b0:235:711:f810
 with SMTP id d9443c01a7336-23e256be344mr197508685ad.23.1752896743769; Fri, 18
 Jul 2025 20:45:43 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:45:06 -0700
In-Reply-To: <20250719034515.2000467-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719034515.2000467-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719034515.2000467-11-irogers@google.com>
Subject: [PATCH v1 10/19] perf vendor events: Update ivybridge/ivytown metrics
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update metrics from TMA 5.0 to 5.1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/ivybridge/ivb-metrics.json       | 30 ++++++++---------
 .../arch/x86/ivytown/ivt-metrics.json         | 33 +++++++++----------
 2 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/to=
ols/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
index de651ff9f846..969cb519eec1 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
@@ -1,49 +1,49 @@
 [
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency",
         "ScaleUnit": "100%"
@@ -80,7 +80,6 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5) / (3 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
@@ -98,7 +97,6 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
         "MetricGroup": "BvOB;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
@@ -139,7 +137,6 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
@@ -561,7 +558,7 @@
         "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Mem;Backend;CacheHits",
         "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
@@ -574,7 +571,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * msr@tsc@ / 1e9 =
/ tma_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -586,7 +583,7 @@
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized"
     },
@@ -775,7 +772,6 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 - UOPS_DISPATCHED_PORT.PORT_4) / (2 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
@@ -926,7 +922,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUT=
E) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) / tma_info=
_core_core_clks)",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUTE=
) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) / tma_info_=
core_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -935,7 +931,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / tma_info_core_core_clks=
)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1=
_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / tma_info_core_core_clks"=
,
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
         "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -944,7 +940,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
2_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_clk=
s)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_2=
_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_clks=
",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tool=
s/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
index 714d5e6d21e7..1cdd197ac883 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
@@ -1,49 +1,49 @@
 [
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency",
         "ScaleUnit": "100%"
@@ -80,7 +80,6 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5) / (3 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
@@ -98,7 +97,6 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
         "MetricGroup": "BvOB;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
@@ -139,7 +137,6 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
@@ -561,7 +558,7 @@
         "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Mem;Backend;CacheHits",
         "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
@@ -574,7 +571,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * msr@tsc@ / 1e9 =
/ tma_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -586,7 +583,7 @@
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized"
     },
@@ -626,6 +623,7 @@
     },
     {
         "BriefDescription": "Average number of parallel data read requests=
 to external memory",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x18=
2@ / UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x182\\,thresh\\=3D1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
@@ -795,7 +793,6 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 - UOPS_DISPATCHED_PORT.PORT_4) / (2 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
@@ -805,6 +802,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "200 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM * =
(1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LO=
AD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD=
_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS +=
 MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED=
.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L=
LC_MISS_RETIRED.REMOTE_FWD))) / tma_info_thread_clks",
         "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
         "MetricName": "tma_local_mem",
@@ -955,7 +953,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUT=
E) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) / tma_info=
_core_core_clks)",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUTE=
) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) / tma_info_=
core_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -964,7 +962,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / tma_info_core_core_clks=
)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1=
_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / tma_info_core_core_clks"=
,
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
         "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -973,7 +971,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
2_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_clk=
s)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_2=
_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_clks=
",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1000,6 +998,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "310 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRAM *=
 (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOA=
D_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS =
+ MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRE=
D.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_=
LLC_MISS_RETIRED.REMOTE_FWD))) / tma_info_thread_clks",
         "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
         "MetricName": "tma_remote_mem",
--=20
2.50.0.727.gbf7dc18ff4-goog


