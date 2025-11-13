Return-Path: <linux-kernel+bounces-898567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 041AFC55891
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B7AF4E41CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E08030FC07;
	Thu, 13 Nov 2025 03:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klDcIh/5"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AAC30E858
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004096; cv=none; b=cM1mtnIOAsorjNZu1B4oIzLp3u7H3cCo+cJr+zDcMpue59R3YOsX9RjyyZWSLzBXlt65S/p92R2Hb23mDpS8WHJ7BNwNUWSquGJkWdOmd50TlftRX3L4NBS4eIwRZAagh2F4uzdNZKbe3ohyulNhfcLkC/5mq+AYegnH8WVRwpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004096; c=relaxed/simple;
	bh=vVf1zggOS+cbysH1e1f3vAJed1lJ5J4Qc02uFoFTyaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=naFfkkFMEYtU1FjBuiouuW2fXKJbxwvdfrlCSQZzVFWr62eSxLStBWqqcHIRpRjFpaCFYDBDk/vrqF9s9XHl3uXD64jKQxyDGuG0opcKLhoeus2MxFPxrqSye4RWcHlN89ZiDsakfSXYpb4gQFBwD0UlSbbKN9eenY9dsvdNJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klDcIh/5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2955555f73dso3102645ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004094; x=1763608894; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEEB3yyqtAo5Qxm1rwxLoJUAtOyPomalYOsJIghAkIk=;
        b=klDcIh/5XAp7nsttFkXwQbM6lPm7xKQ/i8SBhsRSMfFLQ4sSrTys/sjSxy56syT8lv
         EcN1+j2TJo9eZV8FCRHFLDEdL4TG/EGQNpmhSOvtNaLrom3C/7AcdsmwLTCanFWT6GXd
         F+WfREshj1BoxmWuZu6ldxscp+JNSgcf1UyTnsP2Vrj1HvBjEKJ6mT6MfrWk8Qu2c+5K
         fq0vEScQwoO7aziGZa8n4CT4al31Xxrqx/ZIbcOQVdTLEhv2XwLao5S4uMz/sfFlVB/f
         TpkJGpuaREwVrm+61ZsNyBJysBjER2Msdr/HEsK3MtLLsuqGPn4LaJYM7cTRSdCLtkBz
         mpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004094; x=1763608894;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEEB3yyqtAo5Qxm1rwxLoJUAtOyPomalYOsJIghAkIk=;
        b=SjXj9BSe0UXX6bM6mOfm3vSXT+ZVBAckZhmyWa7J81JEcODoEU5yYfIbN/JoAHg+oJ
         7PfHziZjcqB1bKENO17BbzWbTlYXYtbp78RF0tJ6uVLeXQJyrtvl6s71V0i10+qz8eA5
         UfA1E+CyadNvXfx3wiFfd/u1lDZvsSKlITKXJyTFwezmXP4Cu84AHvCohbFXhuCJcViO
         zF8MrYuO+qqSsmTismbunWA88uqJNmOugAgdq4QF7PEgMY23b/tEjCUMYZJVhnEfmfzN
         ufM76yVaAOyeGq5o950YYp1e1K8K17LQhEVs1a6jjygrg/vkvGc8OmVkTAY2k97gwOKn
         PRGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlikkmoMBbU5OoyAU29DjvXlTZUdgc42H0NARyVDEbuthMQqMaM2E8+fn+7b2oQNGpc8HguDJOpc1UeXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHZGRj37qWROSJXGOeOaqTyGZRivwrAUf894ZcZHXkUd4UGIR4
	JhXJI4qYliIM3mKtKYnMjSZpnT7qRDNYEjoLY33Ur54PqVZ15uABj7v1IUuSxrDNbW85bdiO1qK
	6svJblq7yjQ==
X-Google-Smtp-Source: AGHT+IGUz3F16Agc4RAbW/D2wPHIL7padu48afgt8r6+R526ENldbnLOQuTELkamEGtmJn58t9Ko7urqGG4Z
X-Received: from dlbbk16.prod.google.com ([2002:a05:7022:4290:b0:11b:13:9d43])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:944:b0:295:32ea:4cf6
 with SMTP id d9443c01a7336-2984ed27f0emr67149315ad.5.1763004094319; Wed, 12
 Nov 2025 19:21:34 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:09 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-22-irogers@google.com>
Subject: [PATCH v8 21/52] perf jevents: Add itlb metric group for AMD
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

Add metrics that give an overview and details of the l1 itlb (zen1,
zen2, zen3) and l2 itlb (all zens).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 49 ++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index be27a4947e45..60f4ecedae6c 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -121,6 +121,54 @@ def AmdBr():
                        description="breakdown of retired branch instructions")
 
 
+def AmdItlb():
+    global _zen_model
+    l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
+    l2m = Event("l2_itlb_misses")
+    l2r = l2h + l2m
+
+    itlb_l1_mg = None
+    l1m = l2r
+    if _zen_model <= 3:
+        l1r = Event("ic_fw32")
+        l1h = max(l1r - l1m, 0)
+        itlb_l1_mg = MetricGroup("lpm_itlb_l1", [
+            Metric("lpm_itlb_l1_hits",
+                   "L1 ITLB hits as a perecentage of L1 ITLB accesses.",
+                   d_ratio(l1h, l1h + l1m), "100%"),
+            Metric("lpm_itlb_l1_miss",
+                   "L1 ITLB misses as a perecentage of L1 ITLB accesses.",
+                   d_ratio(l1m, l1h + l1m), "100%"),
+            Metric("lpm_itlb_l1_reqs",
+                   "The number of 32B fetch windows transferred from IC pipe to DE "
+                   "instruction decoder per second.", d_ratio(
+                       l1r, interval_sec),
+                   "windows/sec"),
+        ])
+
+    return MetricGroup("lpm_itlb", [
+        MetricGroup("lpm_itlb_ov", [
+            Metric("lpm_itlb_ov_insn_bt_l1_miss",
+                   "Number of instructions between l1 misses", d_ratio(
+                       ins, l1m), "insns"),
+            Metric("lpm_itlb_ov_insn_bt_l2_miss",
+                   "Number of instructions between l2 misses", d_ratio(
+                       ins, l2m), "insns"),
+        ]),
+        itlb_l1_mg,
+        MetricGroup("lpm_itlb_l2", [
+            Metric("lpm_itlb_l2_hits",
+                   "L2 ITLB hits as a percentage of all L2 ITLB accesses.",
+                   d_ratio(l2h, l2r), "100%"),
+            Metric("lpm_itlb_l2_miss",
+                   "L2 ITLB misses as a percentage of all L2 ITLB accesses.",
+                   d_ratio(l2m, l2r), "100%"),
+            Metric("lpm_itlb_l2_reqs", "ITLB accesses per second.",
+                   d_ratio(l2r, interval_sec), "accesses/sec"),
+        ]),
+    ], description="Instruction TLB breakdown")
+
+
 def AmdHwpf():
     """Returns a MetricGroup representing AMD hardware prefetch metrics."""
     global _zen_model
@@ -350,6 +398,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdItlb(),
         AmdHwpf(),
         AmdSwpf(),
         AmdUpc(),
-- 
2.51.2.1041.gc1ab5b90ca-goog


