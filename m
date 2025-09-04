Return-Path: <linux-kernel+bounces-799927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF127B4315B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B593B583E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CF2277C90;
	Thu,  4 Sep 2025 04:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZRj5VL/"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03244276020
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961252; cv=none; b=X7YmxS0fllE3eiMtPve3stHa0/BluXTA0UdOTj8OcbLUhl1eg+W1BXQ1plzLlg/O4hfkbEJwv4dBt50lEk2mSWPc6Pu0Qf9UDFWIQxPL7oDgxCwNCH9Rw1XlVeHG5h8ycMI/aAN7eZxfgpCOCcJlGz8p+B++mGCWo9COueAvQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961252; c=relaxed/simple;
	bh=60AxySV/dmMVoRCj/GcMPkU9qf75oRSvrC+cz4keYjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=N0jXgLHlGHqmpoaPKkiofe0uLKuQhhJsyksY3jOdnnPpLcuLchwC9hJV1NS6NGw9YaV9RHdJJyiPfFCPeIcHk6J6UqCO15rUifbHgfo3k84rHwiVZEed6DDYWQc33wQ++k3jqoEnXkEtifPzecI95BQxXHYUrLMPBpvMVAowNd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZRj5VL/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24ca417fb41so8035055ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961250; x=1757566050; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Io76sF4baxRad2N7SLfDof4lYFnNY5EeWNuGzy0T8Ug=;
        b=cZRj5VL/uyYT3a6s6UtjbZv/xZaOOFiJlSOEpEKU6GP0KM2yevqgxCuZboRuCHeH/8
         Go6nhbi7bhYVwQPwPQE9N+33+qSxrE/ZS0iMAJWo5PzBfwRcLAmTCWSWlXg2fqB/0z/D
         BX9LMeU7sNEVcnDcYkyArLJuKpLTOkXDo6tcwvlqriE0UKYhIE1tNf56FxhRFSMUmD6F
         zHal/34E9QRQpQz3pjZusCBVEQOGD3fr01ByWyTHdxWxbS30WlAWpN26qgwZr6NkOMlu
         eh2pIVUSsg+4DNVGo53pbiR8H/6yjrU2rL/eTKAz8pyY75BHyaIWNsXyKWr+vNub5vsu
         Rkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961250; x=1757566050;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Io76sF4baxRad2N7SLfDof4lYFnNY5EeWNuGzy0T8Ug=;
        b=ElG4c+KtZRc9LJSzFJmR/dd6LN/ppFGukSm1yf7+YsCxMJajAJcoHzGZISGE+3cAsJ
         xQX+Qtp1cQjdeHMO3u5+StiPij9REM3PslTWHfFii60hmq29gva/bPMDkRrWdCBP9ucx
         JTCZnoaTvAzFgCe09iRLbZYTUdRXGQLTXF9iXf2hcFuFjeyO9d9zFeJIqj2tZHTMeyuJ
         jL7gf1xMoCj1HDYspZELZZkb+y4oBzhdfNo9vzVkURJcnHGaAmPo3XrdL58evz9DjU4U
         f3bN6azSYohPOUzjIjFfgOFVXCp6JimcJzYG3ZmZ5PrtPraqhbOIgj5TXSWRux/VP7/F
         KeNA==
X-Forwarded-Encrypted: i=1; AJvYcCXt5Lpcz2v39rnkNuPLpc7FyF4vUrInZYdX7LfhjvgfJQD1UBhCiQE54CvZoD74GtT2dXOWVj/5NXCp6Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfxjugIUuI823R5IkOoNVKZZhP8Ruac2KImHptG4BTSR1Rllkl
	GyU+/C/HAcbQMkzJsadozI8+xJIvtBwegRtoVjiSNUlP2adWyRCX7viQ+DRru6MDka5af4JOtBq
	c3ZuvRnsIrA==
X-Google-Smtp-Source: AGHT+IEVnXY/B5S1r8J+Ny8OVcr+d21wc7YVRwjOD7omQGHy9M7EgkbvrV73G95LnJfRePnt7fmYqhAG4VrG
X-Received: from plbkk13.prod.google.com ([2002:a17:903:70d:b0:240:718d:564a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a28:b0:24c:bd9f:211c
 with SMTP id d9443c01a7336-24cbd9f24bdmr27679775ad.54.1756961250104; Wed, 03
 Sep 2025 21:47:30 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:48 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-18-irogers@google.com>
Subject: [PATCH v6 17/22] perf jevents: Add local/remote "mem" breakdown
 metrics for Intel
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

Breakdown local and remote memory bandwidth, read and writes. The
implementation uses the HA and CHA PMUs present in server models
broadwellde, broadwellx cascadelakex, emeraldrapids, haswellx,
icelakex, ivytown, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f7a9186bdf40..30cf668c7769 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreMem() -> Optional[MetricGroup]:
+  try:
+    loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL", "UNC_H_REQUESTS.READS_LOCAL")
+    rem_rds = Event("UNC_CHA_REQUESTS.READS_REMOTE", "UNC_H_REQUESTS.READS_REMOTE")
+    loc_wrs = Event("UNC_CHA_REQUESTS.WRITES_LOCAL", "UNC_H_REQUESTS.WRITES_LOCAL")
+    rem_wrs = Event("UNC_CHA_REQUESTS.WRITES_REMOTE", "UNC_H_REQUESTS.WRITES_REMOTE")
+  except:
+    return None
+
+  scale = 64 / 1_000_000
+  return MetricGroup("lpm_mem", [
+      MetricGroup("lpm_mem_local", [
+          Metric("lpm_mem_local_read", "Local memory read bandwidth not including directory updates",
+                 d_ratio(loc_rds, interval_sec), f"{scale}MB/s"),
+          Metric("lpm_mem_local_write", "Local memory write bandwidth not including directory updates",
+                 d_ratio(loc_wrs, interval_sec), f"{scale}MB/s"),
+      ]),
+      MetricGroup("lpm_mem_remote", [
+          Metric("lpm_mem_remote_read", "Remote memory read bandwidth not including directory updates",
+                 d_ratio(rem_rds, interval_sec), f"{scale}MB/s"),
+          Metric("lpm_mem_remote_write", "Remote memory write bandwidth not including directory updates",
+                 d_ratio(rem_wrs, interval_sec), f"{scale}MB/s"),
+      ]),
+  ], description = "Memory Bandwidth breakdown local vs. remote (remote requests in). directory updates not included")
+
+
 def UncoreMemBw() -> Optional[MetricGroup]:
   mem_events = []
   try:
@@ -897,6 +923,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreMem(),
       UncoreMemBw(),
   ])
 
-- 
2.51.0.338.gd7d06c2dae-goog


