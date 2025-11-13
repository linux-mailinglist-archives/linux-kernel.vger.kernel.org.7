Return-Path: <linux-kernel+bounces-898565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA05C5587D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBD73B7069
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3930DEB8;
	Thu, 13 Nov 2025 03:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k/kISEgw"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2880230C63B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004092; cv=none; b=n8ZNlaBwvFQxpgzjSvGeKio95eUieVF5Rq9CTv5iG0FjgAHwaLDePGH5xaeb6VVSk8TQT3kqYnuC76B56Zhq5Qh6pFqa1LvJ7aYIAS8Sq9nBtUtlDEVEmPUefe0lU0nBk4l6UqZ8xZCct6ytZ6NDPtb3fdMWoBaoC+VG1Mzf3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004092; c=relaxed/simple;
	bh=H32Kmb4s4EUbi5GaQqYvBoOMfwS8An4o87KjgWVGEGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Qdw7oqMyo2RRSvI4qujdem3Y1N+zWmj1cEJNmbGw/pxTnC4hng0ymIyXlIu18QDBrmfcUKXd84jSRmAOdU9mRZXTC60itPOw+z470i+EXMhISN4DKnxnTo6UTbsWMN2FwrMkr8fSyf+ngSzIEsqr8EwUvfaInHXOY6OW81Fmd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k/kISEgw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2956f09f382so3586975ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004090; x=1763608890; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/xav7sGweATI1gLemlCd0Y/xoi8YTcN9Imv7Ww6cug=;
        b=k/kISEgwtPlECbgBwAeO6OesdCKOoRq4bygVdXTItN5ZJHU9IXxTi1UouxleTgXiHG
         f43UKQHU9aY8nMHhJRkrWtwkTniE/lOppzWVsHMs939MPdcrk413ayYaKXdehLUZFcPo
         +oyrlfgo67t1pNDULvLecOAMxTvW8YE9OkTn3Ha9m6NV+pV/2qdG2FI0zFxMdLWB6GVm
         67qoRDeZcO2jAO/ohGOzUEIkGVd8JRRXOt+unWXgglQKTwE497VUy3uPGGhnd/BCDqZ+
         DvWbNF0TDqPWuHeSuX+URIeHu+ejINXcHxO9ng+d0bb5WyFVsrDsbHZnUY4u/41MWoDZ
         0lHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004090; x=1763608890;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/xav7sGweATI1gLemlCd0Y/xoi8YTcN9Imv7Ww6cug=;
        b=PlTJ7RRmX3NOAU946mhuIrcr8EvYvHLOr2Cv05DS7mTQqTW2mNxCPErQQzjD1LHkBI
         qKmnAj2JIzV54/LfnH3FHOuwVuHgdPhxbsDO2WyGhNNgKQi3EnYOqVGCulP6EE+w5PCP
         ExM4VfK7LM9dIn2hwH/Vxmatu/pEk1dlgA051Kv5BWvgLmgfoLWi0f7srEOYfTqAWGZ6
         LvmUk6Q6ClSyNys5YPxdTBccWTnE+w7dxJTGBPMgCw+b8wPrPEXVFQZBXENtM8Ao6fgD
         dLqd9t7Bah6SNe8tr9+/2speGzJyiwbYXotSfRXdbuPZYGmGS5RmxynVws6oQEwONMzz
         n3UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV71x3KzLFZgDYv9z98y3nGxjcI3RjebnXJiKDDBcNMhGo15prc+JEoSiQymzEXkcm5e2C7WJvUCx0Xzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDf1JKLjBwXT5MEb9J7BgfhtjBLtRppfTbmaCUwdhUMcNhrGhz
	z9zu8fgvGPkyBer7t/32d8Ku+POYITwat6mkdisVYzJcViLEd7OWcJZeuWutXuFmDGyEqMipc4R
	jojxbDk9Llw==
X-Google-Smtp-Source: AGHT+IFVI3FgTE1LB1tkcrGzvX8YL/V7HJxOSDGDYv3mvmQNq20sUUzAhDgaaL0APymsq+Uiq0+1iYBcv0e2
X-Received: from dlbdz8.prod.google.com ([2002:a05:7022:ec8:b0:119:b185:ea72])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60c:b0:297:ec44:56f
 with SMTP id d9443c01a7336-2985a52b15amr20494665ad.14.1763004090460; Wed, 12
 Nov 2025 19:21:30 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:07 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-20-irogers@google.com>
Subject: [PATCH v8 19/52] perf jevents: Add software prefetch (swpf) metric
 group for AMD
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

Add metrics that give the utility of software prefetches on zen2, zen3
and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 101 +++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 1880ccf9c6fc..06cb56cbd617 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -121,6 +121,106 @@ def AmdBr():
                        description="breakdown of retired branch instructions")
 
 
+def AmdSwpf() -> Optional[MetricGroup]:
+    """Returns a MetricGroup representing AMD software prefetch metrics."""
+    global _zen_model
+    if _zen_model <= 1:
+        return None
+
+    swp_ld = Event("ls_dispatch.ld_dispatch")
+    swp_t0 = Event("ls_pref_instr_disp.prefetch")
+    swp_w = Event("ls_pref_instr_disp.prefetch_w")  # Missing on Zen1
+    swp_nt = Event("ls_pref_instr_disp.prefetch_nta")
+    swp_mab = Event("ls_inef_sw_pref.mab_mch_cnt")
+    swp_l2 = Event("ls_sw_pf_dc_fills.local_l2",
+                   "ls_sw_pf_dc_fills.lcl_l2",
+                   "ls_sw_pf_dc_fill.ls_mabresp_lcl_l2")
+    swp_lc = Event("ls_sw_pf_dc_fills.local_ccx",
+                   "ls_sw_pf_dc_fills.int_cache",
+                   "ls_sw_pf_dc_fill.ls_mabresp_lcl_cache")
+    swp_lm = Event("ls_sw_pf_dc_fills.dram_io_near",
+                   "ls_sw_pf_dc_fills.mem_io_local",
+                   "ls_sw_pf_dc_fill.ls_mabresp_lcl_dram")
+    swp_rc = Event("ls_sw_pf_dc_fills.far_cache",
+                   "ls_sw_pf_dc_fills.ext_cache_remote",
+                   "ls_sw_pf_dc_fill.ls_mabresp_rmt_cache")
+    swp_rm = Event("ls_sw_pf_dc_fills.dram_io_far",
+                   "ls_sw_pf_dc_fills.mem_io_remote",
+                   "ls_sw_pf_dc_fill.ls_mabresp_rmt_dram")
+
+    # All the swpf that were satisfied beyond L1D are good.
+    all_pf = swp_t0 + swp_w + swp_nt
+    good_pf = swp_l2 + swp_lc + swp_lm + swp_rc + swp_rm
+    bad_pf = max(all_pf - good_pf, 0)
+
+    loc_pf = swp_l2 + swp_lc + swp_lm
+    rem_pf = swp_rc + swp_rm
+
+    req_pend = max(0, bad_pf - swp_mab)
+
+    r1 = d_ratio(ins, all_pf)
+    r2 = d_ratio(swp_ld, all_pf)
+    r3 = d_ratio(swp_t0, interval_sec)
+    r4 = d_ratio(swp_w, interval_sec)
+    r5 = d_ratio(swp_nt, interval_sec)
+    overview = MetricGroup("lpm_swpf_overview", [
+        Metric("lpm_swpf_ov_insn_bt_swpf", "Insn between SWPF", r1, "insns"),
+        Metric("lpm_swpf_ov_loads_bt_swpf", "Loads between SWPF", r2, "loads"),
+        Metric("lpm_swpf_ov_rate_prefetch_t0_t1_t2", "Rate prefetch TO_T1_T2", r3,
+               "insns/sec"),
+        Metric("lpm_swpf_ov_rate_prefetch_w",
+               "Rate prefetch W", r4, "insns/sec"),
+        Metric("lpm_swpf_ov_rate_preftech_nta",
+               "Rate prefetch NTA", r5, "insns/sec"),
+    ])
+
+    r1 = d_ratio(swp_mab, all_pf)
+    r2 = d_ratio(req_pend, all_pf)
+    usefulness_bad = MetricGroup("lpm_swpf_usefulness_bad", [
+        Metric("lpm_swpf_use_bad_hit_l1", "Usefulness bad hit L1", r1, "100%"),
+        Metric("lpm_swpf_use_bad_req_pend",
+               "Usefulness bad req pending", r2, "100%"),
+    ])
+
+    r1 = d_ratio(good_pf, all_pf)
+    usefulness_good = MetricGroup("lpm_swpf_usefulness_good", [
+        Metric("lpm_swpf_use_good_other_src", "Usefulness good other src", r1,
+               "100%"),
+    ])
+
+    usefulness = MetricGroup("lpm_swpf_usefulness", [
+        usefulness_bad,
+        usefulness_good,
+    ])
+
+    r1 = d_ratio(swp_l2, good_pf)
+    r2 = d_ratio(swp_lc, good_pf)
+    r3 = d_ratio(swp_lm, good_pf)
+    data_src_local = MetricGroup("lpm_swpf_data_src_local", [
+        Metric("lpm_swpf_data_src_local_l2",
+               "Data source local l2", r1, "100%"),
+        Metric("lpm_swpf_data_src_local_ccx_l3_loc_ccx",
+               "Data source local ccx l3 loc ccx", r2, "100%"),
+        Metric("lpm_swpf_data_src_local_memory_or_io",
+               "Data source local memory or IO", r3, "100%"),
+    ])
+
+    r1 = d_ratio(swp_rc, good_pf)
+    r2 = d_ratio(swp_rm, good_pf)
+    data_src_remote = MetricGroup("lpm_swpf_data_src_remote", [
+        Metric("lpm_swpf_data_src_remote_cache", "Data source remote cache", r1,
+               "100%"),
+        Metric("lpm_swpf_data_src_remote_memory_or_io",
+               "Data source remote memory or IO", r2, "100%"),
+    ])
+
+    data_src = MetricGroup("lpm_swpf_data_src", [
+                           data_src_local, data_src_remote])
+
+    return MetricGroup("lpm_swpf", [overview, usefulness, data_src],
+                       description="Software prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
+
+
 def AmdUpc() -> Metric:
     ops = Event("ex_ret_ops", "ex_ret_cops")
     upc = d_ratio(ops, smt_cycles)
@@ -187,6 +287,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdSwpf(),
         AmdUpc(),
         Idle(),
         Rapl(),
-- 
2.51.2.1041.gc1ab5b90ca-goog


