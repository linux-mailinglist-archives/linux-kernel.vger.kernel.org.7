Return-Path: <linux-kernel+bounces-799918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F7B43152
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA74566F0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE7123B605;
	Thu,  4 Sep 2025 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0iZQuCoM"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649C1259C92
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961234; cv=none; b=CwB40SNDs4yV7stNmxYW5hfG0cCIh9//rsn/ChGndm8NQQQM7wOVitNlRGPILMJ1a0HSCFPn04vCLgSGkJ0wrIExGh8EKXuLG3FbL8zBg06IMZxZFo0x9ZTB/RjP46+ZlLCBy8qgHxkc9z1kwGzki8ZmItZ5An+Y+fm9FY6+BzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961234; c=relaxed/simple;
	bh=JjlQaSBT7py0q7gDkb/E4YVFsgpF8smvn6xkGMOw5Lc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hhN+13ErfvQM0Hm95qWyknq0eaEDT7TaoflD4ICMeznBinIL+6jj7z5WTxtMC1Uyu1AdAKwOtRTkf4MHmH774NCh7G+WDtwgn9rClLosgB1w5seIIVfI0EiAjRvN0TyG68SLx8jo6jRTXnpS4LAVdx++M9ThqTI1wmT8EV32xUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0iZQuCoM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24c99f6521dso7964685ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961233; x=1757566033; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bu2m9NwYUYP+oZqOMmXinOl1d0NFMuknff+TFeF8Tok=;
        b=0iZQuCoMOYGVVlH3ZDag8ra/mGobVz0qVgm1J5+xt3FgoOPfStKlfvJu232BM3zmRh
         jQtXqx35m+W9tFs2CFMFMrof9a6S/6LXsNEqdyXOo6LiQbHczzBE7vW7SlaSTybyAjd5
         dR1JG6kX4qBSPDTCZjj/eXVyBx+/+TG2t0ZyifiPOpw4QR/oHvjyDZXOMmAj6inoV7GC
         vaJY5Lidb9OXSsDHce7JWD777kMreO4RuDl4chG+Y2zazfz5RaZWvbdlqEkdKbpFhpwf
         XUupe8/r2uCfo8+cllT2l4/2sIk50Lo/b7HQdPFecrCkVHoPQLpZxUoK4xSkEGWDulaT
         L+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961233; x=1757566033;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu2m9NwYUYP+oZqOMmXinOl1d0NFMuknff+TFeF8Tok=;
        b=CfHYgeZ0uxez1sIr76p1OavSKSQXfs4GIxlNZaba9kH/fqwIo+acuvK6OwuP4u4+qq
         FDz5be3VmqswfpELJU3sKAx2Ivj10qGdbcwJeZggHoBVNK41EJe4xb5HiBEJc0nCIxOP
         YuaueRZDk3u3YQcBK2Qj8gmkSFRyqwguMas8U1SKW5t3VgRbnsRKe7Y4l8BA0PLglplU
         M4FvAlMVIQtCDlResBgSsPz6iLrcWiIX6ozRyp0uQLbcJYaOGr5eAfPEK3ez5TFJVihM
         hOjUJypHAo0KeNLm69PBCsiVkq7aR7w/Jc9uZKrBiSzgEWX4zol6OHE0ygXK8Qgd/Rt2
         saSg==
X-Forwarded-Encrypted: i=1; AJvYcCWIilAIFVcdNFH65dHFmJTOZzv7bAIH1w6b/2/W8STmgKl/KBAenZ6XCCELELW3aLbaCokCutkQLoXj7fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLBe8Wi3oIgDnqgmXND+kIsMlYGiS0gU/aZUlyUaY0y6Y5SBa3
	y8c+Ail+7vii6EUDK9G4SXzG8wi/+wznuQh2lN97Kg+pOhokxlvKLQK1cuSgwYIRQ6v4XyggtI3
	Sk73j4x8bXA==
X-Google-Smtp-Source: AGHT+IHzLCkpxX3Zcx/kL6W/qra9cEEG3LIfm+BCxJr83u1VsSF+iyijelb38kCbkTKGBacQXP6ZT7i5XCat
X-Received: from plhz7.prod.google.com ([2002:a17:902:d9c7:b0:24c:af07:f077])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5ca:b0:24b:1eb:857c
 with SMTP id d9443c01a7336-24b01eb87dcmr130196425ad.57.1756961232633; Wed, 03
 Sep 2025 21:47:12 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:39 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-9-irogers@google.com>
Subject: [PATCH v6 08/22] perf jevents: Add software prefetch (swpf) metric
 group for Intel
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

Add metrics that breakdown software prefetch instruction use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 65 ++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index dfee782596e8..b4ed137c91b3 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -261,6 +261,70 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelSwpf() -> Optional[MetricGroup]:
+  ins = Event("instructions")
+  try:
+    s_ld = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    s_nta = Event("SW_PREFETCH_ACCESS.NTA")
+    s_t0 = Event("SW_PREFETCH_ACCESS.T0")
+    s_t1 = Event("SW_PREFETCH_ACCESS.T1_T2")
+    s_w = Event("SW_PREFETCH_ACCESS.PREFETCHW")
+  except:
+    return None
+
+  all_sw = s_nta + s_t0 + s_t1 + s_w
+  swp_r = d_ratio(all_sw, interval_sec)
+  ins_r = d_ratio(ins, all_sw)
+  ld_r = d_ratio(s_ld, all_sw)
+
+  return MetricGroup("lpm_swpf", [
+      MetricGroup("lpm_swpf_totals", [
+          Metric("lpm_swpf_totals_exec", "Software prefetch instructions per second",
+                swp_r, "swpf/s"),
+          Metric("lpm_swpf_totals_insn_per_pf",
+                 "Average number of instructions between software prefetches",
+                 ins_r, "insn/swpf"),
+          Metric("lpm_swpf_totals_loads_per_pf",
+                 "Average number of loads between software prefetches",
+                 ld_r, "loads/swpf"),
+      ]),
+      MetricGroup("lpm_swpf_bkdwn", [
+          MetricGroup("lpm_swpf_bkdwn_nta", [
+              Metric("lpm_swpf_bkdwn_nta_per_swpf",
+                     "Software prefetch NTA instructions as a percent of all prefetch instructions",
+                     d_ratio(s_nta, all_sw), "100%"),
+              Metric("lpm_swpf_bkdwn_nta_rate",
+                     "Software prefetch NTA instructions per second",
+                     d_ratio(s_nta, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("lpm_swpf_bkdwn_t0", [
+              Metric("lpm_swpf_bkdwn_t0_per_swpf",
+                     "Software prefetch T0 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t0, all_sw), "100%"),
+              Metric("lpm_swpf_bkdwn_t0_rate",
+                     "Software prefetch T0 instructions per second",
+                     d_ratio(s_t0, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("lpm_swpf_bkdwn_t1_t2", [
+              Metric("lpm_swpf_bkdwn_t1_t2_per_swpf",
+                     "Software prefetch T1 or T2 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t1, all_sw), "100%"),
+              Metric("lpm_swpf_bkdwn_t1_t2_rate",
+                     "Software prefetch T1 or T2 instructions per second",
+                     d_ratio(s_t1, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("lpm_swpf_bkdwn_w", [
+              Metric("lpm_swpf_bkdwn_w_per_swpf",
+                     "Software prefetch W instructions as a percent of all prefetch instructions",
+                     d_ratio(s_w, all_sw), "100%"),
+              Metric("lpm_swpf_bkdwn_w_rate",
+                     "Software prefetch W instructions per second",
+                     d_ratio(s_w, interval_sec), "insn/s"),
+          ]),
+      ]),
+  ], description="Software prefetch instruction breakdown")
+
+
 def main() -> None:
   global _args
 
@@ -289,6 +353,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelSwpf(),
   ])
 
 
-- 
2.51.0.338.gd7d06c2dae-goog


