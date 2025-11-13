Return-Path: <linux-kernel+bounces-898571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC32C55897
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41C444E5C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1463126A6;
	Thu, 13 Nov 2025 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuejWpjQ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799CD311941
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004104; cv=none; b=hSwa/0QOeC8S8nVDIYof0FmWwPJmFn8f3BdUZygW3CfQHgJyuSGTK6KoyVHk03N3BsVkd+0tV3vn+WK54yL1dMqngPvnZF/yYq0PTdHYh7+WYrdaGZCbhftBA2869rmN1KtnJxHC/k/yNvgOZ05HnlIVMU1MDXCHZPP3DE2TKsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004104; c=relaxed/simple;
	bh=ogGh2om0DC9PMjOzZti3DANsfTcUWimWRSDgAsS7fkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LxFOuVuyF+P2X04iKIdz8JwZv2Si5/NdddolA+bGlO9o7uHK8NKY5soUk8c0p2Q6effJYrOLK43JMtF1pKAsVE4CQVee6/IqmAcslsd3l6I8YJLp1d8fP2nlY8Jug9dMzFy9lr18gPPvmtK7XHlp6TJSA1pZa0JFpSMAwlSQaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LuejWpjQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297f8a2ba9eso9498625ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004102; x=1763608902; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwOooBJgARuZx3xvFM9lWStOej6it0RXeAICfjsNzzw=;
        b=LuejWpjQTFIJ2gDghn1Wt9MBrBUBBS4OixSxkB8kSZtciFMdpwsEORoDQfoulyo5fw
         2GZYTeUgYUQZK4QymBKr9cC2nnYDnAsQyODNM5YJZHMgNicLIodFKtr4RDGRxwTTh16r
         xfUTqYuhQGo6ZoIU0yLxh1xLt7iHLwAPwNb7rfO/y28v3MMULSIUVTB2mstVJ7sL2bn5
         idJCBVrt9cvXxy8Reg28MiWS6YwIw7lWBqONgLmo+oOAo8izL/0cF6phExM1uqPPps5T
         3q2j3xskdpl5gVq/rHW2GWpZY4KTK9xXhDj0GzfTWNKkJL6DyDDDpV+k4ecvnK+TDrJs
         fNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004102; x=1763608902;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwOooBJgARuZx3xvFM9lWStOej6it0RXeAICfjsNzzw=;
        b=YjnLGhKUO7NivabD5ddbc/KMRhdSOG0PSvTuHbdebZKlkzfai5un1jpySX4YDrWOlG
         laOFauO8TLxnOH47qeXYyhtGcMq3xk5gQQkcEEuHeSpHsOGz/Mx1x+urYtMmqqc3vuEl
         oMbUHZ3hWHUa4u32AyTMRjx/sDwlkMh0/jNpSPtOwmDZFIJJMcHMqQeWtQJ3NEXU6zaT
         IjM1ikkcX7Ck7tRHQcflXFxOzwAo5OftXASKPtPGzh0Z2nyMXaH6OTyAZ/whFJwnMNfH
         2A5koI41jotSgZOVsApejHxUz4Hvs7OTnt2AnBUMB/+AkTo2Jq0OYO8VJv7EiSD/X3ox
         BdMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2OJUiolKL2crKgYH0W0RzEdXYykKxZM1uWNrxvGllDrA9x63AiZyQhaRkURiqG9So7/8i2YJxdBVrNNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbaVlWkH8vncnrxiONY/vM4fQn/7J+2xMR69c/InP3cSru52EF
	anLisoczStBOBwqsZYnqKa8yBq47JU7wQoIvvcCOe3bnEYCmxrSJxFvk7Fl6WDuPRvzquXEEALF
	0b6odDiI0fA==
X-Google-Smtp-Source: AGHT+IEhvLLZuZN0ZsEhaTGlzhZ6B8CVINpNvIBTNMAGx56cbqlPEsYvdUwZE7aEMtKifSEHxmFO/vdDfPvN
X-Received: from dybfx25.prod.google.com ([2002:a05:7300:c399:b0:2a4:6f7f:e6f0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b63:b0:298:4ee2:19f3
 with SMTP id d9443c01a7336-2984ee21a2cmr68747545ad.49.1763004101727; Wed, 12
 Nov 2025 19:21:41 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:13 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-26-irogers@google.com>
Subject: [PATCH v8 25/52] perf jevents: Add ILP metrics for AMD
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 53f7c2198147..9a39e23075b8 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -121,6 +121,42 @@ def AmdBr():
                        description="breakdown of retired branch instructions")
 
 
+def AmdIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("ex_ret_instr")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), cycles)
+           for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], cycles))
+    ilp0 = 1
+    for x in ilp:
+        ilp0 -= x
+    return MetricGroup("lpm_ilp", [
+        Metric("lpm_ilp_idle", "Lower power cycles as a percentage of all cycles",
+               d_ratio(low, tsc), "100%"),
+        Metric("lpm_ilp_inst_ret_0",
+               "Instructions retired in 0 cycles as a percentage of all cycles",
+               ilp0, "100%"),
+        Metric("lpm_ilp_inst_ret_1",
+               "Instructions retired in 1 cycles as a percentage of all cycles",
+               ilp[0], "100%"),
+        Metric("lpm_ilp_inst_ret_2",
+               "Instructions retired in 2 cycles as a percentage of all cycles",
+               ilp[1], "100%"),
+        Metric("lpm_ilp_inst_ret_3",
+               "Instructions retired in 3 cycles as a percentage of all cycles",
+               ilp[2], "100%"),
+        Metric("lpm_ilp_inst_ret_4",
+               "Instructions retired in 4 cycles as a percentage of all cycles",
+               ilp[3], "100%"),
+        Metric("lpm_ilp_inst_ret_5",
+               "Instructions retired in 5 or more cycles as a percentage of all cycles",
+               ilp[4], "100%"),
+    ])
+
+
 def AmdDtlb() -> Optional[MetricGroup]:
     global _zen_model
     if _zen_model >= 4:
@@ -600,6 +636,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdIlp(),
         AmdDtlb(),
         AmdItlb(),
         AmdLdSt(),
-- 
2.51.2.1041.gc1ab5b90ca-goog


