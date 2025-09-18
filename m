Return-Path: <linux-kernel+bounces-791110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A3B3B212
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D9D5612A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781D02356BA;
	Fri, 29 Aug 2025 04:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1DJvXOx6"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB7E25F780
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440728; cv=none; b=XgFYJ5aWPLCtepn8sUTZBsRim6T5OkTUwg0rJ7kTLmC7rLsY3CT4n1Sah6P4hyRWZDpPQFfwUY0cooEnkVQhWvSvU93QUu0qUn4/Hf6zuUYh1qJ4HrBPTzisSsHaOPoOpAsZT3tkrU54B509Tyl50AJ5314lpxBvXKHf6wajwgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440728; c=relaxed/simple;
	bh=OveSSrsdbXUtm3DY8E88W/ENi6DeY6oLaGwJEVQiJUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SjOhRYJJQUoEqWVLiJvArVXcfRtOscBXJoyTuKI6OvZ9R4U86dwdOr8UCP/ebk1ZTyNtkyLFYIjQiN6QgVJCy3bPCxOs7PXv5VGRfGFlg00Q6meqtvBOwIbr2YsWCaIiRb71DIZYGXbJy+Al1XGGz0FnOt6d1gar9ffKp3dNgxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1DJvXOx6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327642d9c82so1914160a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440726; x=1757045526; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLWhA+ESO+kJCjoazYB79GJG2/P0CXeJDsddPE86eU0=;
        b=1DJvXOx6IKGu5S12Z07t7CwPYs6p+WeT13BQ+J55vyeRTWtexm6YRWpufgzB4G+/CW
         p2v3nju6hA/XiAroyukVe1P4UGRtGapIGW11tOBEGvVUMFBIyaARRiS9WaccukhVv4IO
         Iy4+cAmoxNx+MBJA1IW3dfFOCl+JOVgQV1ALfdZnGUGYhA8nEaU9hyS5PVaXagT0FIl5
         66+PG0Yrq+AysyZbM1AWb0iZKkK/OHreWRa3HYTToY8eOTXjesZ0kjkbKh6bVAtPG2oQ
         x1NmvDxtIVqqPsxWoW/2HdGttDBfY5rL5NpaVD5cgUoiLcs+JiXgfGu57/xgJRbuKrBS
         57mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440726; x=1757045526;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLWhA+ESO+kJCjoazYB79GJG2/P0CXeJDsddPE86eU0=;
        b=Ny7E+wvjn8M0sNKkKKhumqsoZABUF4m0T5vggmyC3b9GOY0deJAFNrxqwW/OorzDK4
         ckh7ZnWiHb61rG62XTNE1WbzNyOss4eQvMgNixxJ8DSkesIc/zvB21f+BrW/1uvrl4GN
         tOSRfcTE7AMWqeI9Q4T3Sf6uZTzbF6YeuYFILQTlZOdnwfnXv6Jj2z9zX2AH+5m48AdC
         dMX7tqSGWpsShv+RFq9kGaNpTYlZpH/AxZAgV3tEun4SxuQpmyndOSUaSSXr6g540ipn
         OcC6Ap50JKofjnn0jPlEOl9C8jA978EmBIfCsbHZx0MFBESoHi/ALbLXg3yM6QH5koSE
         61pA==
X-Forwarded-Encrypted: i=1; AJvYcCXvir9R8wh82At/R44Md415eCBOXEzq3EIMiGA5peWtACSDmiQPhBOHkFDAUVmrDrEIUEh9JGIOVC3tlas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/n2uppnL9iuXUzUTQbNUWueV4Plc0kmAv6jpRH0vp4E/QX2V3
	/wVPAcTgB4P0Gvf2UpfFwmM1V7lnmHgHHqAW17EXHyrwV24Ez2cvcymOYtBnzPnml1lCjWUMC9f
	JMtUK35aCPw==
X-Google-Smtp-Source: AGHT+IH9HgCi1Q4YLlRI7Cu1K4HcV53M4C0wIWh386eRRsibCD+5otNOQxsgvKbC22GMUCR3f/pEeEIwXNQz
X-Received: from pjbnc12.prod.google.com ([2002:a17:90b:37cc:b0:321:c567:44cf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:56c7:b0:327:f20b:90b5
 with SMTP id 98e67ed59e1d1-327f20b914cmr48089a91.4.1756440726174; Thu, 28 Aug
 2025 21:12:06 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:11:01 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-21-irogers@google.com>
Subject: [PATCH v5 20/22] perf jevents: Add local/remote miss latency metrics
 for Intel
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

Derive from CBOX/CHA occupancy and inserts the average latency as is
provided in Intel's uncore performance monitoring reference.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 68 ++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index d822352139f2..ea7749d34081 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,8 +1,9 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
-                    Metric, MetricConstraint, MetricGroup, MetricRef, Select)
+from metric import (d_ratio, has_event, max, source_count, CheckPmu, Event,
+                    JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    Literal, LoadEvents, Metric, MetricConstraint, MetricGroup,
+                    MetricRef, Select)
 import argparse
 import json
 import math
@@ -612,6 +613,66 @@ def IntelL2() -> Optional[MetricGroup]:
   ], description = "L2 data cache analysis")
 
 
+def IntelMissLat() -> Optional[MetricGroup]:
+  try:
+    ticks = Event("UNC_CHA_CLOCKTICKS", "UNC_C_CLOCKTICKS")
+    data_rd_loc_occ = Event("UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL",
+                            "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+                            "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
+                            "UNC_C_TOR_OCCUPANCY.MISS_OPCODE")
+    data_rd_loc_ins = Event("UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL",
+                            "UNC_CHA_TOR_INSERTS.IA_MISS",
+                            "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
+                            "UNC_C_TOR_INSERTS.MISS_OPCODE")
+    data_rd_rem_occ = Event("UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE",
+                            "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+                            "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
+                            "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE")
+    data_rd_rem_ins = Event("UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE",
+                            "UNC_CHA_TOR_INSERTS.IA_MISS",
+                            "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
+                            "UNC_C_TOR_INSERTS.NID_MISS_OPCODE")
+  except:
+    return None
+
+  if (data_rd_loc_occ.name == "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE" or
+      data_rd_loc_occ.name == "UNC_C_TOR_OCCUPANCY.MISS_OPCODE"):
+    data_rd = 0x182
+    for e in [data_rd_loc_occ, data_rd_loc_ins, data_rd_rem_occ, data_rd_rem_ins]:
+      e.name += f"/filter_opc={hex(data_rd)}/"
+  elif data_rd_loc_occ.name == "UNC_CHA_TOR_OCCUPANCY.IA_MISS":
+    # Demand Data Read - Full cache-line read requests from core for
+    # lines to be cached in S or E, typically for data
+    demand_data_rd = 0x202
+    #  LLC Prefetch Data - Uncore will first look up the line in the
+    #  LLC; for a cache hit, the LRU will be updated, on a miss, the
+    #  DRd will be initiated
+    llc_prefetch_data = 0x25a
+    local_filter = (f"/filter_opc0={hex(demand_data_rd)},"
+                    f"filter_opc1={hex(llc_prefetch_data)},"
+                    "filter_loc,filter_nm,filter_not_nm/")
+    remote_filter = (f"/filter_opc0={hex(demand_data_rd)},"
+                     f"filter_opc1={hex(llc_prefetch_data)},"
+                     "filter_rem,filter_nm,filter_not_nm/")
+    for e in [data_rd_loc_occ, data_rd_loc_ins]:
+      e.name += local_filter
+    for e in [data_rd_rem_occ, data_rd_rem_ins]:
+      e.name += remote_filter
+  else:
+    assert data_rd_loc_occ.name == "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL", data_rd_loc_occ
+
+  ticks_per_cha = ticks / source_count(data_rd_loc_ins)
+  loc_lat = interval_sec * 1e9 * data_rd_loc_occ / (ticks_per_cha * data_rd_loc_ins)
+  ticks_per_cha = ticks / source_count(data_rd_rem_ins)
+  rem_lat = interval_sec * 1e9 * data_rd_rem_occ / (ticks_per_cha * data_rd_rem_ins)
+  return MetricGroup("lpm_miss_lat", [
+      Metric("lpm_miss_lat_loc", "Local to a socket miss latency in nanoseconds",
+             loc_lat, "ns"),
+      Metric("lpm_miss_lat_rem", "Remote to a socket miss latency in nanoseconds",
+             rem_lat, "ns"),
+  ])
+
+
 def IntelMlp() -> Optional[Metric]:
   try:
     l1d = Event("L1D_PEND_MISS.PENDING")
@@ -981,6 +1042,7 @@ def main() -> None:
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
+      IntelMissLat(),
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
-- 
2.51.0.318.gd7df087d1a-goog


