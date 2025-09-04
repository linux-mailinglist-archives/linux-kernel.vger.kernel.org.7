Return-Path: <linux-kernel+bounces-799922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693E5B43156
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66073686C21
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805BA26F47D;
	Thu,  4 Sep 2025 04:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3av9POgR"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE2E26738D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961243; cv=none; b=e/m3S/DtedSRvCbYtqJ+q9y5VZeBKRI2Jb3gnJyTUQOeOg03WmCv8SYnPrfuqKOwZ3hzRqXyRFka74PozQx8n2g5MpzJYf+ZvCIBmaIlcMjqsgXetxGzbgg1lYNdm9Cu/J3bogCrFCBKCZmtkzMW1P5WGRHLEPxYI3wIs3U2hi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961243; c=relaxed/simple;
	bh=PpQHL0d6V8xOg8pqWLbR7dUgsq0pVfL3clldVMyFhgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=m4Eb+AN1UUbP4BtBmvn+jXPouXIoyoRw5FGy1yXkpbK7rVKXERcLDJL+JRRVVoq4uARPHRbvmlZJAFW5prvDRslRFubcZFngIMF6pBsTBp6c2gSVEwj909fYC3iM2UwgRYzy3yhrkWIV+IDs33DG4jNceqcLx9iiDQxOBCs+6Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3av9POgR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3280d0d4d11so795414a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961241; x=1757566041; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kaKRGdUZa0HDA/qvm+gsWcBuhLqkSgUPDzW3C/x/7m4=;
        b=3av9POgREKovpo/YkLUrdf2xaDKQJyI3WweeahSDbfsSX5glwYyZ9Z4CoLj+/EUjSt
         GBUhRHsW7UHT5adZcSyzDWqBNuvrj7lOIlIziZEB5nFjWW/PQV1rZ0/YvkKbg0G8CKXl
         k1fZm24mioQBH0hSenixKoqOqCw9EWMuqNEN2q1HtXcl+egJ9vqpMFjWu3znV1ZxiYrJ
         KbQF2LmpUhRYnm+vmzKVyKmrd+O9xCFDOfzxgvruj6p+MqxqCgySmVGJjbD2HRFmvKtf
         OxMv8nPP9hrHKJUi1r2XobAvpygHJPYq5CaxxEsa06t72rw3mD0YuU+9gBmtr/kRLJQU
         UR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961241; x=1757566041;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaKRGdUZa0HDA/qvm+gsWcBuhLqkSgUPDzW3C/x/7m4=;
        b=YtDdFjtu2aj8Xc/RzZaggHUitBsZGUlWcjXPzIS7617kVmsEInMNue+hUQ7HaMeQgA
         f3A36zXfvVcv8TXdZDASHOmZ7mAiJV66Mu6svHlJiKhvikP4yMxvUnec2Y2QESCWmR/a
         kVkLfNWtMiS2jp0L6MYDvCnFf7SQfp0VPj55Lqm5b71Ba+IDMe3EX31c8UwycWVNe2Dk
         ym6sTijmPrYh28/aBS/EV2nNsGNtjO79NPMnzsAE24sPfqB3W169a9YAQwTKzv0y4lfm
         BFmBWy22ebfvA4xS+sGKLCQB9ZPTVB5RqskhWRUTegVr84FSw39HokJR97SD2bg4TMf6
         xqLA==
X-Forwarded-Encrypted: i=1; AJvYcCUOcYAis3ztI/VDF7GCTslR9t1FT/TcfaHQZUjsXs6k2xAM5WVk75wwQqoApVXDj7sfdzhYxLbdUSmv1Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTEMvj7IUBTBNBPXi5+klUlgZxJvJ/rUjMPN7ev0W+Wb9lA2o4
	U2bInCe7d8xTGu2TivQuLAuBSIT/4jXqgAynFqJLob2b3HbU5CBPaLyIB2W1+D6hodZVcJQoIK3
	K7ALl1J60iA==
X-Google-Smtp-Source: AGHT+IG45/fFeX93ZeKkr/HR2xvBZF93/+EcEx8cGfx8b5y0nWHANWDJQT98tSHklPaIuw4siWutt7ZLzEok
X-Received: from pjbof5.prod.google.com ([2002:a17:90b:39c5:b0:32b:9b90:e87c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:524b:b0:32b:7e7e:8168
 with SMTP id 98e67ed59e1d1-32b7e7e8228mr3977483a91.19.1756961240962; Wed, 03
 Sep 2025 21:47:20 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:43 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-13-irogers@google.com>
Subject: [PATCH v6 12/22] perf jevents: Add ILP metrics for Intel
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 040dbca0a74e..ba3983920fb3 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -262,6 +262,44 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelIlp() -> MetricGroup:
+  tsc = Event("msr/tsc/")
+  c0 = Event("msr/mperf/")
+  low = tsc - c0
+  inst_ret = Event("INST_RETIRED.ANY_P")
+  inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+  core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                      "CPU_CLK_UNHALTED.DISTRIBUTED",
+                      "cycles")
+  ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), core_cycles) for x in range(0, 4)]
+  ilp.append(d_ratio(inst_ret_c[4], core_cycles))
+  ilp0 = 1
+  for x in ilp:
+    ilp0 -= x
+  return MetricGroup("lpm_ilp", [
+      Metric("lpm_ilp_idle", "Lower power cycles as a percentage of all cycles",
+             d_ratio(low, tsc), "100%"),
+      Metric("lpm_ilp_inst_ret_0",
+             "Instructions retired in 0 cycles as a percentage of all cycles",
+             ilp0, "100%"),
+      Metric("lpm_ilp_inst_ret_1",
+             "Instructions retired in 1 cycles as a percentage of all cycles",
+             ilp[0], "100%"),
+      Metric("lpm_ilp_inst_ret_2",
+             "Instructions retired in 2 cycles as a percentage of all cycles",
+             ilp[1], "100%"),
+      Metric("lpm_ilp_inst_ret_3",
+             "Instructions retired in 3 cycles as a percentage of all cycles",
+             ilp[2], "100%"),
+      Metric("lpm_ilp_inst_ret_4",
+             "Instructions retired in 4 cycles as a percentage of all cycles",
+             ilp[3], "100%"),
+      Metric("lpm_ilp_inst_ret_5",
+             "Instructions retired in 5 or more cycles as a percentage of all cycles",
+             ilp[4], "100%"),
+  ])
+
+
 def IntelL2() -> Optional[MetricGroup]:
   try:
     DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
@@ -633,6 +671,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelIlp(),
       IntelL2(),
       IntelLdSt(),
       IntelPorts(),
-- 
2.51.0.338.gd7d06c2dae-goog


