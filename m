Return-Path: <linux-kernel+bounces-799920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 656A3B43154
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219225675DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92D626A0D0;
	Thu,  4 Sep 2025 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GcfaIp6I"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A332261B64
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961239; cv=none; b=MurLsOvItnraTIlBqmf2EuAPnn4BY7i2u6/hgbZXYKY8Dw1DZh/0dgoE4g6SpBWD+ZSLf1CdgfzcGe9KjdkZINT5zmpqV/51s81W1UduZ5khumvWlZAz+5tuYAVYnOIaQ+yTfRT+PU7gycLL29kvIgMhPlZ6hiIlhjDAydhXD8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961239; c=relaxed/simple;
	bh=xaoyupMMTilaFjJvjKInJ55nFWSQH02YaM+rNbkJA7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aNbAC6Ho7N47QwMw9tL3lbCl6VohFitR4/gzgkFYvswW7N3QaO0aMCo7/a2aO7xgxZuU3uzM+b0MQ7eYW12vnCphwm+TdGB7J/gsZ8fVhoavmMAEZizoCIDYWvLq72mmfdOmy7RsmoThuTMKR8TXqM9POWhZ5eqZlSNscw+axTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GcfaIp6I; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24b4aa90c20so8491915ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961237; x=1757566037; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8j14N23nLFt2iLv3D1VvajDViJgG7KjVtQ4DAsNYGM=;
        b=GcfaIp6IRQeysnaZ+KutKHooC7B7FvQxiQomoSzApysTMNSxWlDqjUSowETh17AvZn
         RO6jbn/iQBDejRO3j3zM1OOY7j9tT6puRUYMp/zO4yMMKWNRGmVVcWX0+D+xdErIsQtk
         MT1brKCTFj6PL4rT/NdKsCKKzJAYmUx6ZTg9uQAOkCtJs1jqu3TsQGfCoXX8tC5UMOLQ
         xiSLdBwCDNx003XWCPsHXTb8dnbuEq3rMGBr9uFI2o5r6TcEDH/22XEf73iFbcu59jiY
         MI4Xr7A3PDzOjzPJUlpqd1vG0yjzTDoMWZbyXGb0An3m01r5+900WSTyjjVwvayqs9J6
         kLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961237; x=1757566037;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8j14N23nLFt2iLv3D1VvajDViJgG7KjVtQ4DAsNYGM=;
        b=dYf/Gpgd4L/hFonmonbcfxnP8tEJoSLC4ohGB1BAL3nGvkOjZWrHGBIrnMp7ODBf1/
         3nOt2uYKOujDDHDYwJvByXcwB2rCIY7xZNPxXwBHQa/ma73e1QAVH/9KbduF2WZctEuI
         vPUtNyV6lXSM57JY6Sdmy4PXoQf9oukA8jKfRW91QkqROgRz3PlFnHeAeWtu3kJnUbf9
         8uKEBuJ6OMu7TWFHch/4N6gvgweIsHkVF40TAkMQrtO9Cgpy6m4evzrxZgowvCl/k2FD
         9TCxyD54fUsuHNyXEtaHQhugM55yXCCzvktHcQN3s+6fEIVynjJAwY8sgrN5j3ereogO
         y1wA==
X-Forwarded-Encrypted: i=1; AJvYcCXy7tJu13+P5ct0GN8DGVrpdUZAXELCAQATjDT5mHm2PfExI6S4yGQKUq5PqMuQn2JWDLZ1WPUcWE7EwFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPoyUA4/7SfrEv4ErUaXARguFUDRnlibzyMhrPYW04O/zvjygD
	l28gCllMZ25B+3isikYvwwBcsQgAXcIqxwbduyHylIGbU2rvM4IiB2yE00TYg6CjgAiiPn11bto
	wjHR6R5cYeA==
X-Google-Smtp-Source: AGHT+IFA66Y5TbZXQ8aachh/JFnmpiXpFQPh4cTx1CCGUVPMxZwBH9G+DVkWlwXPayDHHVvRBKgevYzk1ygL
X-Received: from plbkr7.prod.google.com ([2002:a17:903:807:b0:246:727:7f8f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f89:b0:246:c816:a77c
 with SMTP id d9443c01a7336-2494488b157mr200713485ad.8.1756961236612; Wed, 03
 Sep 2025 21:47:16 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:41 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-11-irogers@google.com>
Subject: [PATCH v6 10/22] perf jevents: Add L2 metrics for Intel
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

Give a breakdown of various L2 counters as metrics, including totals,
reads, hardware prefetcher, RFO, code and evictions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 170 +++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 52c592112c13..c3677807136b 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -262,6 +262,175 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelL2() -> Optional[MetricGroup]:
+  try:
+    DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
+  except:
+    return None
+  try:
+    DC_MISS = Event("L2_RQSTS.DEMAND_DATA_RD_MISS")
+    l2_dmnd_miss = DC_MISS
+    l2_dmnd_rd_all = DC_MISS + DC_HIT
+  except:
+    DC_ALL = Event("L2_RQSTS.ALL_DEMAND_DATA_RD")
+    l2_dmnd_miss = DC_ALL - DC_HIT
+    l2_dmnd_rd_all = DC_ALL
+  l2_dmnd_mrate = d_ratio(l2_dmnd_miss, interval_sec)
+  l2_dmnd_rrate = d_ratio(l2_dmnd_rd_all, interval_sec)
+
+  DC_PFH = None
+  DC_PFM = None
+  l2_pf_all = None
+  l2_pf_mrate = None
+  l2_pf_rrate = None
+  try:
+    DC_PFH = Event("L2_RQSTS.PF_HIT")
+    DC_PFM = Event("L2_RQSTS.PF_MISS")
+    l2_pf_all = DC_PFH + DC_PFM
+    l2_pf_mrate = d_ratio(DC_PFM, interval_sec)
+    l2_pf_rrate = d_ratio(l2_pf_all, interval_sec)
+  except:
+    pass
+
+  DC_RFOH = None
+  DC_RFOM = None
+  l2_rfo_all = None
+  l2_rfo_mrate  = None
+  l2_rfo_rrate  = None
+  try:
+    DC_RFOH = Event("L2_RQSTS.RFO_HIT")
+    DC_RFOM = Event("L2_RQSTS.RFO_MISS")
+    l2_rfo_all = DC_RFOH + DC_RFOM
+    l2_rfo_mrate  = d_ratio(DC_RFOM, interval_sec)
+    l2_rfo_rrate  = d_ratio(l2_rfo_all, interval_sec)
+  except:
+    pass
+
+  DC_CH = None
+  try:
+    DC_CH = Event("L2_RQSTS.CODE_RD_HIT")
+  except:
+    pass
+  DC_CM = Event("L2_RQSTS.CODE_RD_MISS")
+  DC_IN = Event("L2_LINES_IN.ALL")
+  DC_OUT_NS = None
+  DC_OUT_S = None
+  l2_lines_out = None
+  l2_out_rate = None
+  wbn = None
+  isd = None
+  try:
+    DC_OUT_NS = Event("L2_LINES_OUT.NON_SILENT",
+                      "L2_LINES_OUT.DEMAND_DIRTY",
+                      "L2_LINES_IN.S")
+    DC_OUT_S = Event("L2_LINES_OUT.SILENT",
+                     "L2_LINES_OUT.DEMAND_CLEAN",
+                     "L2_LINES_IN.I")
+    if DC_OUT_S.name == "L2_LINES_OUT.SILENT" and (
+        args.model.startswith("skylake") or
+        args.model == "cascadelakex"):
+      DC_OUT_S.name = "L2_LINES_OUT.SILENT/any/"
+    # bring is back to per-CPU
+    l2_s  = Select(DC_OUT_S / 2, Literal("#smt_on"), DC_OUT_S)
+    l2_ns = DC_OUT_NS
+    l2_lines_out = l2_s + l2_ns;
+    l2_out_rate = d_ratio(l2_lines_out, interval_sec);
+    nlr = max(l2_ns - DC_WB_U - DC_WB_D, 0)
+    wbn = d_ratio(nlr, interval_sec)
+    isd = d_ratio(l2_s, interval_sec)
+  except:
+    pass
+  DC_OUT_U = None
+  l2_pf_useless = None
+  l2_useless_rate = None
+  try:
+    DC_OUT_U = Event("L2_LINES_OUT.USELESS_HWPF")
+    l2_pf_useless = DC_OUT_U
+    l2_useless_rate = d_ratio(l2_pf_useless, interval_sec)
+  except:
+    pass
+  DC_WB_U = None
+  DC_WB_D = None
+  wbu = None
+  wbd = None
+  try:
+    DC_WB_U = Event("IDI_MISC.WB_UPGRADE")
+    DC_WB_D = Event("IDI_MISC.WB_DOWNGRADE")
+    wbu = d_ratio(DC_WB_U, interval_sec)
+    wbd = d_ratio(DC_WB_D, interval_sec)
+  except:
+    pass
+
+  l2_lines_in = DC_IN
+  l2_code_all = (DC_CH + DC_CM) if DC_CH else None
+  l2_code_rate = d_ratio(l2_code_all, interval_sec) if DC_CH else None
+  l2_code_miss_rate = d_ratio(DC_CM, interval_sec)
+  l2_in_rate = d_ratio(l2_lines_in, interval_sec)
+
+  return MetricGroup("lpm_l2", [
+    MetricGroup("lpm_l2_totals", [
+      Metric("lpm_l2_totals_in", "L2 cache total in per second",
+             l2_in_rate, "In/s"),
+      Metric("lpm_l2_totals_out", "L2 cache total out per second",
+             l2_out_rate, "Out/s") if l2_out_rate else None,
+    ]),
+    MetricGroup("lpm_l2_rd", [
+      Metric("lpm_l2_rd_hits", "L2 cache data read hits",
+             d_ratio(DC_HIT, l2_dmnd_rd_all), "100%"),
+      Metric("lpm_l2_rd_hits", "L2 cache data read hits",
+             d_ratio(l2_dmnd_miss, l2_dmnd_rd_all), "100%"),
+      Metric("lpm_l2_rd_requests", "L2 cache data read requests per second",
+             l2_dmnd_rrate, "requests/s"),
+      Metric("lpm_l2_rd_misses", "L2 cache data read misses per second",
+             l2_dmnd_mrate, "misses/s"),
+    ]),
+    MetricGroup("lpm_l2_hwpf", [
+      Metric("lpm_l2_hwpf_hits", "L2 cache hardware prefetcher hits",
+             d_ratio(DC_PFH, l2_pf_all), "100%"),
+      Metric("lpm_l2_hwpf_misses", "L2 cache hardware prefetcher misses",
+             d_ratio(DC_PFM, l2_pf_all), "100%"),
+      Metric("lpm_l2_hwpf_useless", "L2 cache hardware prefetcher useless prefetches per second",
+             l2_useless_rate, "100%") if l2_useless_rate else None,
+      Metric("lpm_l2_hwpf_requests", "L2 cache hardware prefetcher requests per second",
+             l2_pf_rrate, "100%"),
+      Metric("lpm_l2_hwpf_misses", "L2 cache hardware prefetcher misses per second",
+             l2_pf_mrate, "100%"),
+    ]) if DC_PFH else None,
+    MetricGroup("lpm_l2_rfo", [
+      Metric("lpm_l2_rfo_hits", "L2 cache request for ownership (RFO) hits",
+             d_ratio(DC_RFOH, l2_rfo_all), "100%"),
+      Metric("lpm_l2_rfo_misses", "L2 cache request for ownership (RFO) misses",
+             d_ratio(DC_RFOM, l2_rfo_all), "100%"),
+      Metric("lpm_l2_rfo_requests", "L2 cache request for ownership (RFO) requests per second",
+             l2_rfo_rrate, "requests/s"),
+      Metric("lpm_l2_rfo_misses", "L2 cache request for ownership (RFO) misses per second",
+             l2_rfo_mrate, "misses/s"),
+    ]) if DC_RFOH else None,
+    MetricGroup("lpm_l2_code", [
+      Metric("lpm_l2_code_hits", "L2 cache code hits",
+             d_ratio(DC_CH, l2_code_all), "100%") if DC_CH else None,
+      Metric("lpm_l2_code_misses", "L2 cache code misses",
+             d_ratio(DC_CM, l2_code_all), "100%") if DC_CH else None,
+      Metric("lpm_l2_code_requests", "L2 cache code requests per second",
+             l2_code_rate, "requests/s") if DC_CH else None,
+      Metric("lpm_l2_code_misses", "L2 cache code misses per second",
+             l2_code_miss_rate, "misses/s"),
+    ]),
+    MetricGroup("lpm_l2_evict", [
+      MetricGroup("lpm_l2_evict_mef_lines", [
+        Metric("lpm_l2_evict_mef_lines_l3_hot_lru", "L2 evictions M/E/F lines L3 hot LRU per second",
+               wbu, "HotLRU/s") if wbu else None,
+        Metric("lpm_l2_evict_mef_lines_l3_norm_lru", "L2 evictions M/E/F lines L3 normal LRU per second",
+               wbn, "NormLRU/s") if wbn else None,
+        Metric("lpm_l2_evict_mef_lines_dropped", "L2 evictions M/E/F lines dropped per second",
+               wbd, "dropped/s") if wbd else None,
+        Metric("lpm_l2_evict_is_lines_dropped", "L2 evictions I/S lines dropped per second",
+               isd, "dropped/s") if isd else None,
+      ]),
+    ]),
+  ], description = "L2 data cache analysis")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
   pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
 
@@ -381,6 +550,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelL2(),
       IntelPorts(),
       IntelSwpf(),
   ])
-- 
2.51.0.338.gd7d06c2dae-goog


