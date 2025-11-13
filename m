Return-Path: <linux-kernel+bounces-898582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248EC558D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A1E8344ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC7F2F90F0;
	Thu, 13 Nov 2025 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usfpI3SH"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5A31619B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004123; cv=none; b=afwDYyP9q0C81Z46/XLls63FcKLsmbtd/EyQbISdCDWlE3bvfaN6L+GE6Q+2XPNp1AqJOajMwB0VgJqxT1+Fy/OVKqgnOwdH/gaiLM+ocfnjg0700/yHpKXVnOdMpv5vRgHf7+e7w1MBHC8g2+QMABJBLA3yl/MXzvvMe6j/nh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004123; c=relaxed/simple;
	bh=yVmvGvYb7C+jMsZDbt7D5PQZZC8wRrAcVHDCtuGBsC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OXPn3I+d0pW63ZHQDU4NTpTXraTuv2kfkUQZx+Bf52TJ3ZKnqCngHFZ8y7pIKDd4k/bFbuHA8vUtE/3drKhX7SQ52PtVzWkAYw6d/Meegn2kVrXMGAC9xmk97AxB96wXecPQWCpu3EDbkHM7UxDbAjTAKEPUJQo6bcfcqjzjpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usfpI3SH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b99d6bd6cc9so345878a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004121; x=1763608921; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGDim4Ss4cIrUgdOZW5zIcnGg/eQaYNuaW0FNpSWZdc=;
        b=usfpI3SHOniVPYIvmYbRkOO4NheNgDSrUAmiDSq6gWIHzamvbfbD3/Syp464PRu/PT
         VZV411bB8xboHxjLGddVx2/gS5MiE4xNoZgl9APOsb3m5i3d+oiyQK5WJ/m0e/+7y6YU
         PIYxyCJAjKLiTWvVS0KXX8ehjeRiK14DV4dDUBJNunt2YhWLDQ5ehD/sxsphFDLs1AM3
         Jq2/i2FKwrL9QMlPGe+bIN8jKZK2uTLbnStRvt7hAD783Op4Vk9rOsTYMAXoxWEgxZkp
         GpoLoaDBj60MUfcbtRtIaAM+wW1/9E1Dwzg8IayfTQ7hZT76x6naNJxvzG3zlOIocPf7
         MZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004121; x=1763608921;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGDim4Ss4cIrUgdOZW5zIcnGg/eQaYNuaW0FNpSWZdc=;
        b=HdldeBmII6fFQvXIKDanX65CdLNZ5H6Z6P573KRHS3Em90yyuR0A3JFai2q2CSvsw6
         ma121B4accenFUO47MteCIFTH9Lj1rNk4OkL1pkfIyrlb1wRcsmw4QTiFWscGWxBhv2o
         3pOPZ8DuyxC2cGI8y0jrPbQEKiR0tWDSpN+ZzdilTz/UBvnK0EQ6o9sXVl1XpHTx6Tux
         z+mW4NYkuUSgdHYNNGTMBUscDVd4HXDVyi9m6PcgZ9LX/3SE+CCU0t2ZfJHeQFMXJmqn
         mxtdIMkDRMkVSC/da48BRjrB+uDAP8X32WWteUe7JwiyvhbtuYGB+kZBRb9lb34jM/BL
         6Qcw==
X-Forwarded-Encrypted: i=1; AJvYcCUhh0teNDlD++FVbzsylWzmoyJEc9iMCSzpUTTrbhlvA4UO3B1jIlqCd8VHu0/BxAceRlVed191ciPg00Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqKnRi5w2jRL8TSwdh0dnxnvY77/0a9uFWB1lGEEC5a5yvIXbv
	7DpkWmew570GAk1CuQKWT+V4FdSB2T9r7tY9Gs8hLDydhNUu5rffbcAa4s4Xho4lFm5mw1EDBM3
	oY91BCBnFTg==
X-Google-Smtp-Source: AGHT+IEtX7wMRMEYuyE0bXrmIH0iCuyLNbVC9w/ucRaeW8uIrwt8nzLGat3rZT3vAZw+fsaXYqK5C8GB5OLi
X-Received: from dlbvv20.prod.google.com ([2002:a05:7022:5f14:b0:119:c913:cce9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94f:b0:295:888e:9fff
 with SMTP id d9443c01a7336-2984ed410f1mr74215585ad.20.1763004121277; Wed, 12
 Nov 2025 19:22:01 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:23 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-36-irogers@google.com>
Subject: [PATCH v8 35/52] perf jevents: Add software prefetch (swpf) metric
 group for Intel
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

Add metrics that breakdown software prefetch instruction use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 66 ++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index e1944d821248..919a058c343a 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -261,6 +261,71 @@ def IntelBr():
                        description="breakdown of retired branch instructions")
 
 
+def IntelSwpf() -> Optional[MetricGroup]:
+    ins = Event("instructions")
+    try:
+        s_ld = Event("MEM_INST_RETIRED.ALL_LOADS",
+                     "MEM_UOPS_RETIRED.ALL_LOADS")
+        s_nta = Event("SW_PREFETCH_ACCESS.NTA")
+        s_t0 = Event("SW_PREFETCH_ACCESS.T0")
+        s_t1 = Event("SW_PREFETCH_ACCESS.T1_T2")
+        s_w = Event("SW_PREFETCH_ACCESS.PREFETCHW")
+    except:
+        return None
+
+    all_sw = s_nta + s_t0 + s_t1 + s_w
+    swp_r = d_ratio(all_sw, interval_sec)
+    ins_r = d_ratio(ins, all_sw)
+    ld_r = d_ratio(s_ld, all_sw)
+
+    return MetricGroup("lpm_swpf", [
+        MetricGroup("lpm_swpf_totals", [
+            Metric("lpm_swpf_totals_exec", "Software prefetch instructions per second",
+                   swp_r, "swpf/s"),
+            Metric("lpm_swpf_totals_insn_per_pf",
+                   "Average number of instructions between software prefetches",
+                   ins_r, "insn/swpf"),
+            Metric("lpm_swpf_totals_loads_per_pf",
+                   "Average number of loads between software prefetches",
+                   ld_r, "loads/swpf"),
+        ]),
+        MetricGroup("lpm_swpf_bkdwn", [
+            MetricGroup("lpm_swpf_bkdwn_nta", [
+                Metric("lpm_swpf_bkdwn_nta_per_swpf",
+                       "Software prefetch NTA instructions as a percent of all prefetch instructions",
+                       d_ratio(s_nta, all_sw), "100%"),
+                Metric("lpm_swpf_bkdwn_nta_rate",
+                       "Software prefetch NTA instructions per second",
+                       d_ratio(s_nta, interval_sec), "insn/s"),
+            ]),
+            MetricGroup("lpm_swpf_bkdwn_t0", [
+                Metric("lpm_swpf_bkdwn_t0_per_swpf",
+                       "Software prefetch T0 instructions as a percent of all prefetch instructions",
+                       d_ratio(s_t0, all_sw), "100%"),
+                Metric("lpm_swpf_bkdwn_t0_rate",
+                       "Software prefetch T0 instructions per second",
+                       d_ratio(s_t0, interval_sec), "insn/s"),
+            ]),
+            MetricGroup("lpm_swpf_bkdwn_t1_t2", [
+                Metric("lpm_swpf_bkdwn_t1_t2_per_swpf",
+                       "Software prefetch T1 or T2 instructions as a percent of all prefetch instructions",
+                       d_ratio(s_t1, all_sw), "100%"),
+                Metric("lpm_swpf_bkdwn_t1_t2_rate",
+                       "Software prefetch T1 or T2 instructions per second",
+                       d_ratio(s_t1, interval_sec), "insn/s"),
+            ]),
+            MetricGroup("lpm_swpf_bkdwn_w", [
+                Metric("lpm_swpf_bkdwn_w_per_swpf",
+                       "Software prefetch W instructions as a percent of all prefetch instructions",
+                       d_ratio(s_w, all_sw), "100%"),
+                Metric("lpm_swpf_bkdwn_w_rate",
+                       "Software prefetch W instructions per second",
+                       d_ratio(s_w, interval_sec), "insn/s"),
+            ]),
+        ]),
+    ], description="Software prefetch instruction breakdown")
+
+
 def main() -> None:
     global _args
 
@@ -291,6 +356,7 @@ def main() -> None:
         Smi(),
         Tsx(),
         IntelBr(),
+        IntelSwpf(),
     ])
 
     if _args.metricgroups:
-- 
2.51.2.1041.gc1ab5b90ca-goog


