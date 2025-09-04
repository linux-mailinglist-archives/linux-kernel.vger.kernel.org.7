Return-Path: <linux-kernel+bounces-799929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63496B4315E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51471B20E8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEBA27A935;
	Thu,  4 Sep 2025 04:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfn2ymuF"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE27242D79
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961256; cv=none; b=Xf3kSAnmwlEdckRaivEQHtoa+lffEZx448ACD6O7ohkSMNF9IhRVKjkLJxY5tQ/d7ZHMKKv/x4IiHVdmLbi2wKEDR5dcfq5YwQCL4KMsNmhWW+xfGPYo9Bybhcz7SlfI3GJaOZm37lAZfiIf1qUSnRznQuwOuBe0ZcJF68olPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961256; c=relaxed/simple;
	bh=k/LoRE9LKJb9pgXdFQrX4Vgw4BybtXTPIpuakLBhaK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pwMk51y10+ibGjzNrsTARjs7vF9rw/zLfBGALLv5gwMbGQhlZh1pd183xLB9JNKih5vvZTiI2NVpE2Dbe4BXvlsOqUOrgAuZwb1PFI1a0xoXbTi8LQl1LCgmiEJ5KhiL7P+wgfdpuTIAaJ1MR8gd8cJ97z8IuAo0cfnql2oiVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dfn2ymuF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24a94fef521so11174295ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961254; x=1757566054; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/I9QWCdSsiagbzi91mQV5Lxu5w6XmpsGaYWx/t/qFo=;
        b=dfn2ymuFCJXp++Yww2SK+BUbXtSa/BKmbIBwxWaG7/tzrbqRG//tdnhL42+uMmtPpV
         PNQCi19F4xEQOyYah864wNNcBtP0NYuHf46q/hDFmqPhF+3ETI3N4gKzcezP/HHt+zoz
         5Y6oGdnFEmQfO3ErrZhIcLKkJyuPQxEuTMCRaiHtNCyhPI+6eVu+9FRFaUEDPhXAT5Vj
         oi6AaSwsXYmd4+UxpwbsV3Flstb7cL/VTU9gnimVKW2QEaENOcb3OO9Ov3nAOrnPN3xD
         2zB9XjHpyR0nwsjtMh6KtDUiqUzUY3El0kP94VuJHZvESRhIaXNJXgsSOBpjiEs2aqcC
         2Y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961254; x=1757566054;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/I9QWCdSsiagbzi91mQV5Lxu5w6XmpsGaYWx/t/qFo=;
        b=H0J75xcp+qPID2thU2S+mkYvFRNHEXGh0fRUOiy9iEzz/WSdVWXrg2Vno272xK7BFO
         0GEqr9IJq74mX+0zHFyWl4+H6pBFArQZxtiqxv0QEU5079w0iD/p/GyzN4wq2bCGHrmt
         OtV8xbPZs2J2UO0Pln3olJQivftji2xaQaIwkaXMBr3QwKu9gJzctuurj/Ncm+okdJve
         uyzJ6MMs1Mga2uxqrRmrkLbpP4rf7J6bt8x+kSkCaXk6HiHGQpUqMq/PTVxqaUOkL2jb
         8AB8OBe4i7c8l5yVL1KOppUuHGemOL8R7I4lKYSIIC5bEqLGQQ4qV+/sI8hKx2Ea0N7a
         +pcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSf+FULq4pOzxtNdWCXzqvi1VYiW2WreH/AiL3wc++2FamscSWYnLbrwyL9wCyJtHW3QWWOzLTAQzxoyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN5OEa6BRo6+2S/ydnqMol5bt/DG30b5Xe+AzU8n5LGWkr8ixo
	8Gj2WwSqyjCaA9OboGt5mG/Dz4SXwp6gqSObkt68quoKeWHQDqfNTwsYFgSXIXH0rJ6gNPdGq/J
	mVAH/mLEkPA==
X-Google-Smtp-Source: AGHT+IE/N6MAKEsx+XK77LYz++Lo9hdGu6bLFSU5sb1Lb2ne7u2hi/FDM1GhURNwOObmL2M/3v+fFsv7zKmk
X-Received: from plbh15.prod.google.com ([2002:a17:902:eecf:b0:24c:c013:50b5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94d:b0:246:bce2:e837
 with SMTP id d9443c01a7336-24944b55120mr261214965ad.49.1756961254122; Wed, 03
 Sep 2025 21:47:34 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:50 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-20-irogers@google.com>
Subject: [PATCH v6 19/22] perf jevents: Add C-State metrics from the PCU PMU
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

Use occupancy events fixed in:
https://lore.kernel.org/lkml/20240226201517.3540187-1-irogers@google.com/

Metrics are at the socket level referring to cores, not hyperthreads.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 669b5668a753..befaf0fcd961 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreCState() -> Optional[MetricGroup]:
+  try:
+    pcu_ticks = Event("UNC_P_CLOCKTICKS")
+    c0 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C0")
+    c3 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C3")
+    c6 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C6")
+  except:
+    return None
+
+  num_cores = Literal("#num_cores") / Literal("#num_packages")
+
+  max_cycles   = pcu_ticks * num_cores;
+  total_cycles = c0 + c3 + c6
+
+  # remove fused-off cores which show up in C6/C7.
+  c6 = Select(max(c6 - (total_cycles - max_cycles), 0),
+              total_cycles > max_cycles,
+              c6)
+
+  return MetricGroup("lpm_cstate", [
+      Metric("lpm_cstate_c0", "C-State cores in C0/C1", d_ratio(c0, pcu_ticks), "cores"),
+      Metric("lpm_cstate_c3", "C-State cores in C3", d_ratio(c3, pcu_ticks), "cores"),
+      Metric("lpm_cstate_c6", "C-State cores in C6/C7", d_ratio(c6, pcu_ticks), "cores"),
+  ])
+
+
 def UncoreDir() -> Optional[MetricGroup]:
   try:
     m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
@@ -958,6 +984,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreCState(),
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
-- 
2.51.0.338.gd7d06c2dae-goog


