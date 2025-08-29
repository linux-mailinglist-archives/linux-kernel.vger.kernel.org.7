Return-Path: <linux-kernel+bounces-791064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9C4B3B1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 367937A94DB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D514220E029;
	Fri, 29 Aug 2025 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSSg8bn3"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A250823D28B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438323; cv=none; b=SelfSz3O8+SiLuK2n315Fw6skO0L6RksEnpLQsosEJljn3duDsyDOvMckcedU5JkbIluu1vCsYpGcEkaod0Pk2o2+O4nz9QwkHA/PlAawlxkNxQeT5M3+Lg+TVwdcV4gceL98ZoEAIufGO9L9514OjXqgLqaRUmYF8jWdQVYh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438323; c=relaxed/simple;
	bh=lwmduiXMPylmx2p4goBcEcl5mo4b7khmf4uz1YB5Rns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=p+bCm7Y3mWAoTZViEFqz2Q7/IBfgSzFYPYF0Z2kttVxQ8Nua9XC7V9AJzO0xnIzQsmwrQwy41eJUcYo4U9KXAWXAxlsviwAU3Gtw5f3gtpCJvYjrAe8/UWLAKWbzyKg1QErJnuWz3JH3nbWjCyqxBUpGdnBy0bbLfA392W+FwyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSSg8bn3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-248d9301475so20965805ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438320; x=1757043120; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5JolLGg61q6SOmr3cF75+JHWqY5QYSUqQxMmL2WnA4=;
        b=rSSg8bn3yD5zkeZBOK4orqcLex5QuabU5pRXes0p9iZCguWuLCoy1IeGwraTgw2t+C
         qIks37I/1B7rGxZpOikCZlhrTHZ+kkaJz6J9zuDY8/ILyPEnRKvN8DME7sbcfw8htznZ
         MwQV8wzJaRIUazvkn5CtXED0mkrp1dXOGaNgSC1UkA9mBI0Dw2QTe99DaDx/dhg86IKZ
         fWtXP6ELqoBd9bCiRmuRRAIBz0QiklrPNPIf+SsyJeaRcJ3SWzV/cDdwmOO5wWCbP3fC
         PKW3/RDkcmk9T5JvuZpkPIAc1wvAY2LsnSHVOZ/Nfw7FYurxgfJm0WvgRTSy6dWfCluo
         CjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438320; x=1757043120;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5JolLGg61q6SOmr3cF75+JHWqY5QYSUqQxMmL2WnA4=;
        b=Y8jbqM9ea/cvj34yRXuew37lNsxoNIQ7/+d2wE93gLvWnuel7/E+y+y2lTCxOacs8M
         paiBoFjOn7ta9MVU6GGm10M9fKnMs3DHwS57hJLNJJ/FHBoHKVHS0+aFeXfaj40Eovr1
         PoK3OuPdjumY6VhSuwgZMX48g9ojGOcHeRIirkLhdqsNMPCpfRF367yNtocAym/JP7UN
         wxuQyl5f2Xan7KhxGOR2K6gmktd+qZr4+Nf0qUeWe6pKygRD/0X5a4r/ZfrQ9b3MUQKD
         FW8KbPeW28o2skyUV5fXSQDeB9WXnZUklnsYm7Y39M/DiDd+KoEWPTFNSrW9Z/OFZXDU
         k3tw==
X-Forwarded-Encrypted: i=1; AJvYcCWiH7taFgLo02NJw/SWJK1lzsC1p5T7awqr/eMMeRpe1of/imXa3GApqnKB6YpMuKelcMRG5tbirq4sWgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZACmPGTwXr2qTcCw1s8A3qXt4WZLzBwjU+gD4sjhJhoSTLcf
	NZmYc7VlY+JephlgQ+cd6aY/4fks5KKA3LugKrR8NtPQuhTsVamU8GpIpm24Z1jXM0gelUdWiHV
	+0obIRsK+YA==
X-Google-Smtp-Source: AGHT+IEHgqCd5KefCLHmp4SgJFYGz0bXyVdzvcwuFaVTzyXAsyS2sBq8Bx5rhu9Y9X2TldXIiKNNHzQrZGfa
X-Received: from plbmo11.prod.google.com ([2002:a17:903:a8b:b0:23f:cd4f:c45d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:943:b0:242:fb32:a51b
 with SMTP id d9443c01a7336-2462ee5b26fmr370011825ad.19.1756438319879; Thu, 28
 Aug 2025 20:31:59 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:32 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-8-irogers@google.com>
Subject: [PATCH v5 07/13] perf jevents: Add itlb metric group for AMD
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
index 98dfd5e9bd2f..8f7265a732e3 100755
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
2.51.0.318.gd7df087d1a-goog


