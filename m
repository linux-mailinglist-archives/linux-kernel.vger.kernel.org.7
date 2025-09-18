Return-Path: <linux-kernel+bounces-799926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1C1B4315A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC223AB01B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464C2765D7;
	Thu,  4 Sep 2025 04:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNjFcAR5"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236AD274B56
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961250; cv=none; b=EUpdHBeYpHKKmcsOHCMoIUg6XrNUAVseZ9uPlx25L+uGzc/L6xr10tRko/adOg2FkmA3PzU7ggGfCIqeWH09YmT9Yx/m8ukQH7wRyWnximfHB7JC7h5ozcLJnuszyJwJQFGIs1rA4kxbHhv5ct+BJELzpyhZDzXiqShpG7FPsac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961250; c=relaxed/simple;
	bh=4id6qW52RVk7CeazVVAcMIC89FYm5r4jYb0uX897eSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iiL6vNQrnSQlHpXpdNS+wu0jTT4vFDX8G5SvGcdaaTMUMw/OtPMLfrri2nho/68KON/nrAdBjW6LNCxbcMPa5ZkRi9vxrMKVxCx/HoNY/bwTDBhsT+BNLW9OZYOYoQrMNWHTtrebK/8f5H+7LcyeHKNVrqsoeyEUyG/ilTghJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DNjFcAR5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329dbf4476cso471433a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961248; x=1757566048; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+5O5k9vf/egK0S2NKVuj4To6PYUImPr8SKd2g1CviQ=;
        b=DNjFcAR5HUEcxFju64W5VtSgCbuKD09wX5BE+gj8sduBPGdZWWasfxS4A9dXYRCfQR
         neAWdHuKaR4QxFtOebHDryjjnVCh0tmjh390EeBlyBWoKJGdSLOTXtMPHSX/8x39vXq8
         DWGaIWF2p8NVPIZNntr1QJ54q0lExJ8UbaSt46HwMqgibQjaiKJVXTZyx3WNvfEs5N3a
         O0t9U3XobLJfoeANLQ12hwXnSmOIEJl717mylk704QKRmB2Ko6jYeM7AlMpujhhu1pC/
         ptkV9snNdRjus7UWzFdUWsj2zMwz+FzhQ+BTx7cylGxXqvckmwO3W85vJooyXpkzXLxw
         tWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961248; x=1757566048;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+5O5k9vf/egK0S2NKVuj4To6PYUImPr8SKd2g1CviQ=;
        b=P255m0yi4EFoPOP1krSIbB3By+2tOaL93Y3Qo8er+frD5Kl5OWhYsbDRQlQj2NpdSl
         0/jk76w4O3mzfodrdGI4+oAQ8atQkOCtyh2JI8w5EjqVQ2CHykX4oWliN0R4rVqroV5F
         SU84CJZc1kuz7KlXwyBZkFegwkbqkcVuaUSEqutm+6g4wRjBaqxd8bF7KfHpyee9NNaB
         elPZKyK5RcfxwpUVWv5kzMhg5d7TYFJBnAWsLI/OKhcYLEdRhFNEx+7SN388ZfTgwzyw
         pA5NFwuIoZVr+y8yUquOMVJhek4aHVHSebpCgP6BDLpn3tCiqLwGy2ZdqBuHgkmSTkve
         6o8A==
X-Forwarded-Encrypted: i=1; AJvYcCXCcoGxI2HbPfhR2GxFKVsiyKmZIW8/wSMYGfOZzuE/jxhGbasetBcXp1yrPr+1v9+H4lPvJivcfEDRdLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMsHVBr2IiieZ4P/shrN7ctQGekkM1aILfEdHQt8fpyXFOJgWb
	GxOausnZ7PlNfmPab4sjwDIE1c3HgQIGVg/gCw41oE1NL3zGeSktN8M0pZMvsX2CLxSnPMxGaGh
	ksR8MnYAkng==
X-Google-Smtp-Source: AGHT+IFYziPi1GDhMclIV4oWwi7zK4Wp+hElBtFL1C1PkD+rIIM0YRmOjZ9tGKC4vg/FKO7NR0NYP3N6XOn5
X-Received: from pjtu6.prod.google.com ([2002:a17:90a:c886:b0:320:e3e2:6877])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5828:b0:329:f7fe:19a5
 with SMTP id 98e67ed59e1d1-329f7fe1a6amr8716450a91.29.1756961248464; Wed, 03
 Sep 2025 21:47:28 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:47 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-17-irogers@google.com>
Subject: [PATCH v6 16/22] perf jevents: Add mem_bw metric for Intel
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

Break down memory bandwidth using uncore counters. For many models
this matches the memory_bandwidth_* metrics, but these metrics aren't
made available on all models. Add support for free running counters.
Query the event json when determining which what events/counters are
available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index fb15ba6b9f90..f7a9186bdf40 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,67 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreMemBw() -> Optional[MetricGroup]:
+  mem_events = []
+  try:
+    mem_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
+                                f"/arch/x86/{args.model}/uncore-memory.json"))
+  except:
+    pass
+
+  ddr_rds = 0
+  ddr_wrs = 0
+  ddr_total = 0
+  for x in mem_events:
+    if "EventName" in x:
+      name = x["EventName"]
+      if re.search("^UNC_MC[0-9]+_RDCAS_COUNT_FREERUN", name):
+        ddr_rds += Event(name)
+      elif re.search("^UNC_MC[0-9]+_WRCAS_COUNT_FREERUN", name):
+        ddr_wrs += Event(name)
+      #elif re.search("^UNC_MC[0-9]+_TOTAL_REQCOUNT_FREERUN", name):
+      #  ddr_total += Event(name)
+
+  if ddr_rds == 0:
+    try:
+      ddr_rds = Event("UNC_M_CAS_COUNT.RD")
+      ddr_wrs = Event("UNC_M_CAS_COUNT.WR")
+    except:
+      return None
+
+  ddr_total = ddr_rds + ddr_wrs
+
+  pmm_rds = 0
+  pmm_wrs = 0
+  try:
+    pmm_rds = Event("UNC_M_PMM_RPQ_INSERTS")
+    pmm_wrs = Event("UNC_M_PMM_WPQ_INSERTS")
+  except:
+    pass
+
+  pmm_total = pmm_rds + pmm_wrs
+
+  scale = 64 / 1_000_000
+  return MetricGroup("lpm_mem_bw", [
+      MetricGroup("lpm_mem_bw_ddr", [
+          Metric("lpm_mem_bw_ddr_read", "DDR memory read bandwidth",
+                 d_ratio(ddr_rds, interval_sec), f"{scale}MB/s"),
+          Metric("lpm_mem_bw_ddr_write", "DDR memory write bandwidth",
+                 d_ratio(ddr_wrs, interval_sec), f"{scale}MB/s"),
+          Metric("lpm_mem_bw_ddr_total", "DDR memory write bandwidth",
+                 d_ratio(ddr_total, interval_sec), f"{scale}MB/s"),
+      ], description = "DDR Memory Bandwidth"),
+      MetricGroup("lpm_mem_bw_pmm", [
+          Metric("lpm_mem_bw_pmm_read", "PMM memory read bandwidth",
+                 d_ratio(pmm_rds, interval_sec), f"{scale}MB/s"),
+          Metric("lpm_mem_bw_pmm_write", "PMM memory write bandwidth",
+                 d_ratio(pmm_wrs, interval_sec), f"{scale}MB/s"),
+          Metric("lpm_mem_bw_pmm_total", "PMM memory write bandwidth",
+                 d_ratio(pmm_total, interval_sec), f"{scale}MB/s"),
+      ], description = "PMM Memory Bandwidth") if pmm_rds != 0 else None,
+  ], description = "Memory Bandwidth")
+
+
 def main() -> None:
   global _args
 
@@ -836,6 +897,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreMemBw(),
   ])
 
 
-- 
2.51.0.338.gd7d06c2dae-goog


