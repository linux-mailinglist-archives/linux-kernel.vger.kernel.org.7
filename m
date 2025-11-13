Return-Path: <linux-kernel+bounces-898590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2414C558E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 412A14EA2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445C731B111;
	Thu, 13 Nov 2025 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUvLhWKo"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF0D31A81B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004138; cv=none; b=t3iBUtGwKx4+K115fvzOyVYErgfdN2Zm2hmK/MJJW51WfLrmCdwQLsWSb6/1KZGBTylJLEBmZGMH9YTnDKY50GzedI0e5rQwPOwW+Z7+W1R9AK563+BmnWiNT3Cu7xpEI5y8YI5EEZsHCS7Xwnn1uH0Jw5m+gJd0LGONs0NJIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004138; c=relaxed/simple;
	bh=qX35Itbhc9e/KIdUgyGaBHn9MzSy4DTE28eCMkaEh7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=g6BO7X/0rABRGo2gXHcWYw9aHre6CPxzBWNi7/jmViaXCrazdJ2NZKoUogL3Sk2ET6ShhM230XgoBp7GYBxYr9BfhgQvoAPhlNEhPv8nZKlmqDN9LITXPF7SBC1eUJ3IfEMSFrJc0LNf0DHIzU9zO7sB8TTj3ikoauL9QDaoBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUvLhWKo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297fbfb4e53so6660125ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004136; x=1763608936; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QzgYRCX3pVVtIR05a0Z3xw8tCxI0VGc5K9zhDx5EIhk=;
        b=cUvLhWKoonICsbKEv72LykSer5MYgUi4KT8aOE0AN1wn7yvjzXveqiTJ7CaRCxSLnw
         Oa5VYhv54IVcw/owIJ4ju1Y/Ft9oAjaV9teKdQKP3i7oMhAtVjU/+CnY5ctIn6Fgeizn
         SNX3CUTH8ssaHu/9k5nA897oSirdwTMJNzPcmUUP+dORsOKi/Uv6ulLYMOfTvk6Tt69s
         13X2NMiHbJjLTWOr/hNxBolzu+KSX9V5ZK+o9uq0zDoRgOEPAHusyvJy51Zwo3h0BrnQ
         EIsBPPMf0aneXlWT/mLUeIzVZ+leI0+BcN24WfWzVJf89pJU1ctC5I7LiKDRKi26JxIY
         uhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004136; x=1763608936;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QzgYRCX3pVVtIR05a0Z3xw8tCxI0VGc5K9zhDx5EIhk=;
        b=WtvO72WmlvBl+Gx6c8HUobM+r0QF31SAagvs8f/Nj9VB9UyAw+d4ZvBcjcUvJyiHRa
         T3x5tvxqcAhi+tgduZyELzJ1EztTl5oDQbbO81WzC/f8rYSQRh7HkXT6IN6Skt2aqNFJ
         2pq56IKUiGe5RqrkUXcSEso+QRBuVdCpxJr+s4L2RazlFtZQmXjK/No9Y8wXifuluZfI
         gF6vHj/sy3oJKMlKy1ujZ3ew6QdO+uqmaWNp2RyAau0FIT1dVueqsqQWiP0UM6t6jQz2
         1rcv0bdFQfQ2TOHNzCrmG4kOc+oKO2XjcDL/qxrCT7s7/xO9V5WJAW0LZb7pZZuj/Z9O
         mbig==
X-Forwarded-Encrypted: i=1; AJvYcCWuexM48HR7QMZ5FeXTowTbDFnXvg9PU41Bzhuws+DhytcAl31yBeIBoHp2rddDK6jrZhqVKeprMnz66QY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ca0UysxKl4dOfzt5d8KpgJ31IjNu9nEQ4yHithl0JfH+f+NM
	85G19d7yZEzJTATZdlNraJTBJnzygX8FkyRlc6/ZHyW6HAYb0tO7UYUCSC9H7I/zfp9ZyK0rY+Q
	XA3ldPtiugw==
X-Google-Smtp-Source: AGHT+IEZCezrht0wRpY2FhdRaSwQk3QXkFXPVCUQaWzxv4AjxTWJNrJV8HcgONax7nnWJC9i563gEFQ3KSOW
X-Received: from dyblc25.prod.google.com ([2002:a05:7301:1319:b0:2a4:6a22:9865])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c2:b0:246:7a43:3f66
 with SMTP id d9443c01a7336-2984ed30d18mr75545335ad.7.1763004136368; Wed, 12
 Nov 2025 19:22:16 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:31 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-44-irogers@google.com>
Subject: [PATCH v8 43/52] perf jevents: Add mem_bw metric for Intel
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
index dddeae35e4b4..f671d6e4fd67 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -815,6 +815,67 @@ def IntelLdSt() -> Optional[MetricGroup]:
     ], description="Breakdown of load/store instructions")
 
 
+def UncoreMemBw() -> Optional[MetricGroup]:
+    mem_events = []
+    try:
+        mem_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
+                                    f"/arch/x86/{args.model}/uncore-memory.json"))
+    except:
+        pass
+
+    ddr_rds = 0
+    ddr_wrs = 0
+    ddr_total = 0
+    for x in mem_events:
+        if "EventName" in x:
+            name = x["EventName"]
+            if re.search("^UNC_MC[0-9]+_RDCAS_COUNT_FREERUN", name):
+                ddr_rds += Event(name)
+            elif re.search("^UNC_MC[0-9]+_WRCAS_COUNT_FREERUN", name):
+                ddr_wrs += Event(name)
+            # elif re.search("^UNC_MC[0-9]+_TOTAL_REQCOUNT_FREERUN", name):
+            #  ddr_total += Event(name)
+
+    if ddr_rds == 0:
+        try:
+            ddr_rds = Event("UNC_M_CAS_COUNT.RD")
+            ddr_wrs = Event("UNC_M_CAS_COUNT.WR")
+        except:
+            return None
+
+    ddr_total = ddr_rds + ddr_wrs
+
+    pmm_rds = 0
+    pmm_wrs = 0
+    try:
+        pmm_rds = Event("UNC_M_PMM_RPQ_INSERTS")
+        pmm_wrs = Event("UNC_M_PMM_WPQ_INSERTS")
+    except:
+        pass
+
+    pmm_total = pmm_rds + pmm_wrs
+
+    scale = 64 / 1_000_000
+    return MetricGroup("lpm_mem_bw", [
+        MetricGroup("lpm_mem_bw_ddr", [
+            Metric("lpm_mem_bw_ddr_read", "DDR memory read bandwidth",
+                   d_ratio(ddr_rds, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_ddr_write", "DDR memory write bandwidth",
+                   d_ratio(ddr_wrs, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_ddr_total", "DDR memory write bandwidth",
+                   d_ratio(ddr_total, interval_sec), f"{scale}MB/s"),
+        ], description="DDR Memory Bandwidth"),
+        MetricGroup("lpm_mem_bw_pmm", [
+            Metric("lpm_mem_bw_pmm_read", "PMM memory read bandwidth",
+                   d_ratio(pmm_rds, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_pmm_write", "PMM memory write bandwidth",
+                   d_ratio(pmm_wrs, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_pmm_total", "PMM memory write bandwidth",
+                   d_ratio(pmm_total, interval_sec), f"{scale}MB/s"),
+        ], description="PMM Memory Bandwidth") if pmm_rds != 0 else None,
+    ], description="Memory Bandwidth")
+
+
 def main() -> None:
     global _args
 
@@ -853,6 +914,7 @@ def main() -> None:
         IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
+        UncoreMemBw(),
     ])
 
     if _args.metricgroups:
-- 
2.51.2.1041.gc1ab5b90ca-goog


