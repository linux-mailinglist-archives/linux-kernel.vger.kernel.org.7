Return-Path: <linux-kernel+bounces-791067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C41AAB3B1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3851BA7D15
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC2420F067;
	Fri, 29 Aug 2025 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHFPYQzh"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3103F244677
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438327; cv=none; b=LJyqt915RpdPjmFwHw9JzWlAbjN45BhpH0jHQkBCdJLEX65d/PFX5s6J8yST1EVYZSNLvvdvZUYvws/TKJmzbQLIDFBS5lFTMxTjFpboY/BL/g/GfCjShgssM5ptgbntRD2bDbQ0JZqxNAKP07AgOTQw8LrdnRjRfkOpMoj3Sks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438327; c=relaxed/simple;
	bh=9Hbibjw3LzGMRwYGwD6kAO14AeY+5/BV94P2rvvO/1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=d4t6FO+fH0prl58lmw45THde4GzY4KWcXewY/j5fKi2QvjnsDiiWP8y7RfYaM5UICYrIW/eOap3jXG4uP5Gm6CNWm803MhBa80qcNU8Y0/Sg9vueZuLEu5Nu5yNK3KR5bvSg9ed2zY48UjDjETVUktRMfgW9DGWJ8m/6e9koGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHFPYQzh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e953a49de25so2123754276.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438325; x=1757043125; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KO2wQ/2lz2oBZIqRX2yZ/AaUoKZSlBZGjqjdjPcsVhQ=;
        b=tHFPYQzhKbVLP6a6wvn7xHwGH+CifuASB6VpHTp5hCX9LNfiOAn6q0tGAlEcoeYiXJ
         SQiYT48jptiMr8DcdEd0U7OD92U1PnYdB+/yfK24eKxV8KJYesMjqYUyRxTKUrobP3ds
         /5BWwZEEQL/VImnxj/NqYD07A8JyIVvltNXCkffj2GFQWl6Zd3AU3xz9Mzg4BCIQIc4L
         v+P6frgOZcK6fjghBL6EhVp5KNFLEoCfoqiEQy3qFGtb80NQe96hpRnDLp+2pjyfGXNo
         HxQSDhNgxSgFHUGtJqnAwRUlAIGB8Uo+ZHMRRw6q+Jgnrwussz/TqlvVUIiNmOOM8akb
         n6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438325; x=1757043125;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KO2wQ/2lz2oBZIqRX2yZ/AaUoKZSlBZGjqjdjPcsVhQ=;
        b=YADlLu/Eq07MqR0qPd/SwPsJrAW6JwyOJJIh/HiI/opS05ovHn8CrTmIG2t2W+v+H5
         PIX7+ukzyKoPno9Oocm+TZgtWAXv9uuBeN4nNzrsw88ghrNl4gCV4DJ2P/V1sntmED7N
         Av1vIyXqqrOShnSORo7mtvDcInYcuyoP72CPCKi6e4nTds4ln/53N9lEDaQ4+UNIFlSt
         TRmXZDa/y8zKqBfbGnHAugpZpdDhK/zLSCgK6p5JLR9tfFlv4GuXP7oFz18TPaz5W9XM
         911PhSkLqk7PvLNeowyzfwI3PcTYOHP/XGpCP6gQqwJmNF2C0OVWyEIkUAMyvFWkBCdr
         oZXg==
X-Forwarded-Encrypted: i=1; AJvYcCUxSYcsk8EyObkon3yUMOpCeFmcrtn9SG3P8+1XZep8LjuGWP536Qlkt7Sv5U8vdRRYmdQgDCTeXASnBVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfXgXu5lA1sdI6z5Qt2F5hGRB0Z9pA0qpZb3gWKDJPpf0iLSt
	UZrNIar76MHSZTaDgtV0/cz5RODBbwFj262CIICR1ndRd93V9Xst8r9oH8YBToOpu6yN/SVMhQW
	NqBVLvZ0vhQ==
X-Google-Smtp-Source: AGHT+IG84a7uVj/ZZ8zj/2yLFbZqkS6K3onxgn4Jw9R/Zjn7lRWUDPPoBmRmi3bbthNElPNuUaVXuBR5LHiS
X-Received: from ybas10.prod.google.com ([2002:a05:6902:680a:b0:e98:95a8:b6e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:2b87:b0:e97:258:a126
 with SMTP id 3f1490d57ef6-e970258a636mr5092153276.46.1756438325187; Thu, 28
 Aug 2025 20:32:05 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:35 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-11-irogers@google.com>
Subject: [PATCH v5 10/13] perf jevents: Add load store breakdown metrics ldst
 for AMD
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

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 71500ea2204f..13bf3eaf498f 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -275,6 +275,80 @@ def AmdItlb():
   ], description="Instruction TLB breakdown")
 
 
+def AmdLdSt() -> MetricGroup:
+  ldst_ld = Event("ls_dispatch.ld_dispatch")
+  ldst_st = Event("ls_dispatch.store_dispatch")
+  ldst_ldc1 = Event(f"{ldst_ld}/cmask=1/")
+  ldst_stc1 = Event(f"{ldst_st}/cmask=1/")
+  ldst_ldc2 = Event(f"{ldst_ld}/cmask=2/")
+  ldst_stc2 = Event(f"{ldst_st}/cmask=2/")
+  ldst_ldc3 = Event(f"{ldst_ld}/cmask=3/")
+  ldst_stc3 = Event(f"{ldst_st}/cmask=3/")
+  ldst_cyc = Event("ls_not_halted_cyc")
+
+  ld_rate = d_ratio(ldst_ld, interval_sec)
+  st_rate = d_ratio(ldst_st, interval_sec)
+
+  ld_v1 = max(ldst_ldc1 - ldst_ldc2, 0)
+  ld_v2 = max(ldst_ldc2 - ldst_ldc3, 0)
+  ld_v3 = ldst_ldc3
+
+  st_v1 = max(ldst_stc1 - ldst_stc2, 0)
+  st_v2 = max(ldst_stc2 - ldst_stc3, 0)
+  st_v3 = ldst_stc3
+
+  return MetricGroup("lpm_ldst", [
+      MetricGroup("lpm_ldst_total", [
+          Metric("lpm_ldst_total_ld", "Number of loads dispatched per second.",
+                 ld_rate, "insns/sec"),
+          Metric("lpm_ldst_total_st", "Number of stores dispatched per second.",
+                 st_rate, "insns/sec"),
+      ]),
+      MetricGroup("lpm_ldst_percent_insn", [
+          Metric("lpm_ldst_percent_insn_ld",
+                 "Load instructions as a percentage of all instructions.",
+                 d_ratio(ldst_ld, ins), "100%"),
+          Metric("lpm_ldst_percent_insn_st",
+                 "Store instructions as a percentage of all instructions.",
+                 d_ratio(ldst_st, ins), "100%"),
+      ]),
+      MetricGroup("lpm_ldst_ret_loads_per_cycle", [
+          Metric(
+              "lpm_ldst_ret_loads_per_cycle_1",
+              "Load instructions retiring in 1 cycle as a percentage of all "
+              "unhalted cycles.", d_ratio(ld_v1, ldst_cyc), "100%"),
+          Metric(
+              "lpm_ldst_ret_loads_per_cycle_2",
+              "Load instructions retiring in 2 cycles as a percentage of all "
+              "unhalted cycles.", d_ratio(ld_v2, ldst_cyc), "100%"),
+          Metric(
+              "lpm_ldst_ret_loads_per_cycle_3",
+              "Load instructions retiring in 3 or more cycles as a percentage"
+              "of all unhalted cycles.", d_ratio(ld_v3, ldst_cyc), "100%"),
+      ]),
+      MetricGroup("lpm_ldst_ret_stores_per_cycle", [
+          Metric(
+              "lpm_ldst_ret_stores_per_cycle_1",
+              "Store instructions retiring in 1 cycle as a percentage of all "
+              "unhalted cycles.", d_ratio(st_v1, ldst_cyc), "100%"),
+          Metric(
+              "lpm_ldst_ret_stores_per_cycle_2",
+              "Store instructions retiring in 2 cycles as a percentage of all "
+              "unhalted cycles.", d_ratio(st_v2, ldst_cyc), "100%"),
+          Metric(
+              "lpm_ldst_ret_stores_per_cycle_3",
+              "Store instructions retiring in 3 or more cycles as a percentage"
+              "of all unhalted cycles.", d_ratio(st_v3, ldst_cyc), "100%"),
+      ]),
+      MetricGroup("lpm_ldst_insn_bt", [
+          Metric("lpm_ldst_insn_bt_ld", "Number of instructions between loads.",
+                 d_ratio(ins, ldst_ld), "insns"),
+          Metric("lpm_ldst_insn_bt_st", "Number of instructions between stores.",
+                 d_ratio(ins, ldst_st), "insns"),
+      ])
+  ], description="Breakdown of load/store instructions")
+
+
 def AmdHwpf():
   """Returns a MetricGroup representing AMD hardware prefetch metrics."""
   global _zen_model
@@ -512,6 +586,7 @@ def main() -> None:
       AmdBr(),
       AmdDtlb(),
       AmdItlb(),
+      AmdLdSt(),
       AmdHwpf(),
       AmdSwpf(),
       AmdUpc(),
-- 
2.51.0.318.gd7df087d1a-goog


