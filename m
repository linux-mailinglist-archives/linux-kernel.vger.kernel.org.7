Return-Path: <linux-kernel+bounces-799900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D99BB4313D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD901BC7F08
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32232566E9;
	Thu,  4 Sep 2025 04:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7k+VBhn"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14CF248F59
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960867; cv=none; b=m30/16R+K4a0rlz/GFlWZvQEC5ai6dhtCd2s6gNMev+uM6Fd85WK4ApZrPY10MrE52TgigFgiH7GJaL/PsYUMGdUOlXe2CvMDYnuFJ2m5IhEbZ/AHlb5Kk2RPOF7VPjX+IM4b6WKIeNRAmkUmHeMdsJZ373kranIDfsspSImkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960867; c=relaxed/simple;
	bh=6K0QD66kCRONesOOSXpToMwtSEbB+9Zub/XmGa+S7Jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Z8VRQR5HmYJGdiReVi3H6+9cS/5luPRJP0lPcUGv5CVcm3ZlFQjoMOO6L9okJ/d4CMBn+K7uymRLIBoOHOZg8r+vNIF5dBqdRD91VmoVcDIxQYI2kqyKnKE9f+5qaYsoCCYGxwJ3r74/qf11BtyDYsGp0gNQtsTBpA7nSKxQ/l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7k+VBhn; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3234811cab3so632091a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960865; x=1757565665; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0P0hpfhKEVZyTrd9yoaGFjAKXoLRpJAs90AGXVle+OY=;
        b=v7k+VBhn0s8rI24gHG8pPg46UkfU3GKrl1+WMZn/x6lo1ql/djl6qs8iglPnGQzIQi
         sF7YFWSNlGLvkvloJdMpaJrSeDO1eRWYAH8vxSoPKEcICeHDKWyXPdaBusOkEjmfK/F0
         YB5BrdV6L/vx2yLSxXtYQtbPr9coLe9A3pUj9BuoAhRXUoUnZTIOLNvbfBl9PRJxsTIz
         uV9Fn9SI06UHMqzTDgEVHFfr9p+yo7akwKxSdZCEXUAMw+Hm5IXHStchEWSS8iLPSyNM
         KngwcQAoNM/Girwi9RRnlyu5DD9vUxuHTWgfQnKnW8KYOOcnunqUxAhgSFYkS4EZQpSb
         lEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960865; x=1757565665;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0P0hpfhKEVZyTrd9yoaGFjAKXoLRpJAs90AGXVle+OY=;
        b=syMVzV5L2zDTwcLBX3EiWCBSU4BY/4HpHhTDaUbWPYzkFPAxL9EAkVMJEYXUQHfoZc
         WUnmOpBDsZE/+5Fi5yARIgikNkb4wWGJM389z4B/zyWWltlV8qoWYhv/I8Kxti7c48Pl
         koe2TM2OOK14JknOtDAbNNm3PSIu1u4O0efL/vHleQ5ty6u+FFUSlJ2g3lQyclNoH9r2
         aD9rYMYdwjtsYjyAPOKYuBkh47rQ6IOgFG6a6AiAKnEocJWP8R4v/p7mLI2qCUytcu8Q
         JQDaNlyjGPtSjySa94cJHfXHLJOMnF2/j4Hcl3E1auV7PoBmsK7/GpxWhaC9pgfYaKhZ
         ob3g==
X-Forwarded-Encrypted: i=1; AJvYcCWUEDYBSl2aBoO7+W+Yb4Pv31/vxckn4GKcRvpq2RhP4FokuEKLz4jNAX8OYCAV8Lr8sjOyMVYgP47DyAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YympUGNSvRUIq0qrD6PVsVDPPE0eSrsvR/d/IIOL/Er/zPpIsN/
	cF4nedW09xKi1OiZaxVmH/2EO/Tpz7vg25CHH79JyPAK8N26JyomEG1mk6Eioehx4LrDzvh7FeU
	p5SEExmbFNw==
X-Google-Smtp-Source: AGHT+IHUi260lHOw6Y2vrQJWH/avJTQJcgWfR+8AhGWjK3nzSCHP2Tjzwut7yxw/ZjSu1kzZvy9y170N/rww
X-Received: from pjb8.prod.google.com ([2002:a17:90b:2f08:b0:329:ccdd:e725])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f84:b0:329:d85b:d9ee
 with SMTP id 98e67ed59e1d1-329d85bdae7mr10878853a91.23.1756960865311; Wed, 03
 Sep 2025 21:41:05 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:40 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-7-irogers@google.com>
Subject: [PATCH v6 06/13] perf jevents: Add hardware prefetch (hwpf) metric
 group for AMD
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

Add metrics that give the utility of hardware prefetches on zen2, zen3
and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 62 ++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index acbb4e962814..cecc0a706558 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,67 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdHwpf():
+  """Returns a MetricGroup representing AMD hardware prefetch metrics."""
+  global _zen_model
+  if _zen_model <= 1:
+      return None
+
+  hwp_ld = Event("ls_dispatch.ld_dispatch")
+  hwp_l2 = Event("ls_hw_pf_dc_fills.local_l2",
+                 "ls_hw_pf_dc_fills.lcl_l2",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2")
+  hwp_lc = Event("ls_hw_pf_dc_fills.local_ccx",
+                 "ls_hw_pf_dc_fills.int_cache",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache")
+  hwp_lm = Event("ls_hw_pf_dc_fills.dram_io_near",
+                 "ls_hw_pf_dc_fills.mem_io_local",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram")
+  hwp_rc = Event("ls_hw_pf_dc_fills.far_cache",
+                 "ls_hw_pf_dc_fills.ext_cache_remote",
+                 "ls_hw_pf_dc_fill.ls_mabresp_rmt_cache")
+  hwp_rm = Event("ls_hw_pf_dc_fills.dram_io_far",
+                 "ls_hw_pf_dc_fills.mem_io_remote",
+                 "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram")
+
+  loc_pf = hwp_l2 + hwp_lc + hwp_lm
+  rem_pf = hwp_rc + hwp_rm
+  all_pf = loc_pf + rem_pf
+
+  r1 = d_ratio(ins, all_pf)
+  r2 = d_ratio(hwp_ld, all_pf)
+  r3 = d_ratio(all_pf, interval_sec)
+
+  overview = MetricGroup("lpm_hwpf_overview", [
+      Metric("lpm_hwpf_ov_insn_bt_hwpf", "Insn between HWPF", r1, "insns"),
+      Metric("lpm_hwpf_ov_loads_bt_hwpf", "Loads between HWPF", r2, "loads"),
+      Metric("lpm_hwpf_ov_rate", "HWPF per second", r3, "hwpf/s"),
+  ])
+  r1 = d_ratio(hwp_l2, all_pf)
+  r2 = d_ratio(hwp_lc, all_pf)
+  r3 = d_ratio(hwp_lm, all_pf)
+  data_src_local = MetricGroup("lpm_hwpf_data_src_local", [
+      Metric("lpm_hwpf_data_src_local_l2", "Data source local l2", r1, "100%"),
+      Metric("lpm_hwpf_data_src_local_ccx_l3_loc_ccx",
+             "Data source local ccx l3 loc ccx", r2, "100%"),
+      Metric("lpm_hwpf_data_src_local_memory_or_io",
+             "Data source local memory or IO", r3, "100%"),
+  ])
+
+  r1 = d_ratio(hwp_rc, all_pf)
+  r2 = d_ratio(hwp_rm, all_pf)
+  data_src_remote = MetricGroup("lpm_hwpf_data_src_remote", [
+      Metric("lpm_hwpf_data_src_remote_cache", "Data source remote cache", r1,
+             "100%"),
+      Metric("lpm_hwpf_data_src_remote_memory_or_io",
+             "Data source remote memory or IO", r2, "100%"),
+  ])
+
+  data_src = MetricGroup("lpm_hwpf_data_src", [data_src_local, data_src_remote])
+  return MetricGroup("lpm_hwpf", [overview, data_src],
+                     description="Hardware prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
+
+
 def AmdSwpf() -> Optional[MetricGroup]:
   """Returns a MetricGroup representing AMD software prefetch metrics."""
   global _zen_model
@@ -278,6 +339,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdHwpf(),
       AmdSwpf(),
       AmdUpc(),
       Idle(),
-- 
2.51.0.338.gd7d06c2dae-goog


