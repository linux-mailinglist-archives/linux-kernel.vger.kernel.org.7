Return-Path: <linux-kernel+bounces-791106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4F6B3B20E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AD1189F14E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97A925A2B5;
	Fri, 29 Aug 2025 04:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oVnSI49j"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8550259CAB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440721; cv=none; b=NF+jKCijbtlZxZzisgo6rHCX7+2Qg28xLU0GDPM1aa4BkOZJgpxqF5J4McUB9GE/USdwXkOgiqhIOnoHUVhfKg3uiLoDz9DVB4n8eJB42j++UwQDSLg4K4MCevo+o0lDpTYWQaH35mALx/PkkCElc7s1BbfsPQHyiNUcjxG2wy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440721; c=relaxed/simple;
	bh=X3vDvjqvG35mcSBEKEiYMzoLULKRdAJqjV/Yzj+ZVkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RkGIiIxsXeRK46IyDOdBHr1fZh76lQrXga4NtfepgWI7w3Q0KVgp6gOP2gPWsSJbLwMSD2HqbutCFY71bFHmVWPSc1+k8hSRA0IQ2PMFig3hRj3JeuMbBRpDRM/sUn/4CP1NN2qeLlu78Jf3j5aT+359/xGH9kTHnGmWLeFshuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oVnSI49j; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-327b00af618so1411706a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440719; x=1757045519; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGiCxp5GflCgGqMJOf1XbJaq5kTmFoGK28ybOIk7s4o=;
        b=oVnSI49j4UJI/QXwh9BnpFXWp31FNqRAz02CmbhzNA/MNZmyjQSNdaxs4sqJ4jBQCM
         6yTRP21+2lnS7rNbs75V1Tr/r62KO8Pl/TeZhtKqdGL+4DJeoAdOMJTvSvqH4e926qzo
         Izfh8fIHgfdcplTh63xUc22yGA0Xn3EnfV4VR5id7q/BXQrPhM0ka3VtkwkNcUn03IXA
         7L4oJLiudl7+1fwFetLx5BEzbnAvTJlfAWAKD2VYb7BPkPQhVe40w6VGbNl7/eUpawFb
         hCMOVWB65loMnRWIYbNIMGrpdn+HZV1GMnooT82GT6piwsKfPu4dk7gczrxCTq3bRX3d
         nEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440719; x=1757045519;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGiCxp5GflCgGqMJOf1XbJaq5kTmFoGK28ybOIk7s4o=;
        b=Rzk1YOiWxO9gt6GtgpivBjl5K/RI6x7RCfE4VoltiQKw+QmcJN/LrujhO1c+Xgxj5V
         ha/QsnUAjt3uU7CTFhFIoIjz12eRSftXlfiaZIwke9aqPzPClP8UiyzwtHPP8zhRSwzf
         kyMCoLI/0AilzT+CtaB89TbWvE5t5Pk/M1GuK/4J/UY2xr12CMwGuPF5xxqSTPa/MVxO
         42Ex5ThzUGoaQX/bpNPqt0A5xCMvCIJ7VkPuOcpdcG4GQmIZxrSSDyp9p64mZf258TOY
         hN0z/qToYt1J1PoGJUc4Ayoy5UPVeJastV6pGkjs6TipWGqKMwHWzZ3oQd4U9tgLaPte
         axIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5E6VNISpE/nBtQJMiDx+3+LdU2q5xCcjyl1uWYi+3XuEZs4Ad+I02H3zxPXtdm7q1RxCkRUqttZQ2DgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5rnV3YBuhbij5P86c5WBw8AL4vykra9G+u2Q3QpWvD047nM1
	sIj+2+edxdfqgeqd5lKiJwezVeZq1xTfVLSBPb/6d1KmG4S/MYtZpNf5qnUMWBiVd3HZXxokF6L
	gzbGEe/ML7w==
X-Google-Smtp-Source: AGHT+IFviBrND5KcpsivYt/iPIiB+1Bd1BHNBZ/v+eXs/k9kIhgmfVo1ny8/q2pD7hGreoWxfy79hHMDEwvb
X-Received: from pjvf12.prod.google.com ([2002:a17:90a:da8c:b0:325:8fba:708c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f85:b0:327:734a:ae7c
 with SMTP id 98e67ed59e1d1-327734ab066mr9763475a91.13.1756440719022; Thu, 28
 Aug 2025 21:11:59 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:57 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-17-irogers@google.com>
Subject: [PATCH v5 16/22] perf jevents: Add mem_bw metric for Intel
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
index 262bfd539262..82a5b037edf9 100755
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
2.51.0.318.gd7df087d1a-goog


