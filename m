Return-Path: <linux-kernel+bounces-791068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631BB3B1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E72897BBED4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769A521D3F4;
	Fri, 29 Aug 2025 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="01EkYCyN"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E4247280
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438329; cv=none; b=s28ZwrS9/eOQms8th2WWankcWM88q3UQax3L04KOAgUocz3K0CGZZ4hapSLHAnr+h60X+9RNLSwCj8fWpFvgDLQnVawU8E7xq9DFwzaj3503cQaTJUdmwcyr59GMsXdNQNv37g2Rw4ktzLcRsUMIcFxyJKoQOJO3FCNUWpMdNg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438329; c=relaxed/simple;
	bh=epB32bgqoBg+Y9IczPEeSot7J5GpkAAMYtGdLSFAUEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GLI1OhOa9iqExOSAHxml2dfKq8Qmbn2VniMJKlN8PTsQom6K09VJzNeScxwxNCnnMMzM9oe3utIsXkHknMsgyehkE71Pjziw5VaLerW+zBhwg9c32yko8SlKrhq+yVGXb3vOvCrKeppWhhOa+3Josz1JczNYGl2WUIzRa38Wxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=01EkYCyN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244570600a1so19145895ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438327; x=1757043127; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6o45Rbe1ZhPS/kWrkC4UpT//UnRPcEEIFEGMxNVhUzE=;
        b=01EkYCyN9+LBjLGkw3/aFDe1JoYX5Em1aOjdUqQQWN1Tt26R/H+uBVS5baalOgCMqk
         Pg17hJdOrnmgxTNVihfvS15WEWwqtOdtv3VnS7GNUjxUYwBK62sNf6Vn3vfyyIbytrMU
         hFaXk0MjO2MlS9G7Hiq89qUyCW9nwAQZRyXVOgnY1TZZqW9BzAZpXsGlgRxbTdA+Ucm1
         pV5wdZg9SFE0s5X/pCYaYBmEfUSxf2T4M3zjUi+PImhLrfNRHXahoxYf/tYLCuc/+hNt
         +QIkXD9jCoOceEiZCdbSqLMvNKH3PY7+sQSP3lE9mrKFZQh8g3IFXWh76oOLFraTLCMo
         +Y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438327; x=1757043127;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6o45Rbe1ZhPS/kWrkC4UpT//UnRPcEEIFEGMxNVhUzE=;
        b=LETQyq7u6bsCigFBBbC/Qg7GNiprL+jaMOpaoMSL82S8Dup+Y6GQmHKp8L9tRqHcyy
         qRUHa+DLxxN06CgqIa7HIJUB9CHPBSQePenrk3xqBdkkEV9RhPd8Aocm5f8gg/Wm0d7H
         oiTeOwYImCEHx/Pivphlv4DyJ0gc8CuLeeP/0Dwa1dA1LctJktUW9kVat8v7POPWAhxd
         /ehgwFKzqQR2mg+jwU9C9nO4UfKxEM/aBAmIxS2qix4PhvNjeYDIKr9uis8Jj6Hl4zwU
         hzeE44hZj5buJPmBAtmIMaxIZo4kgRCrPdy4DX8OcH1uXDWMhXOHF+oqeDHOpnh8AaU5
         U8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyB0dTgYfiO3GepnwhWrT5GxugjaBApb73FcvoJI9BsGC1k54Et0hnuFSqxbA622rzzq1uCx9jLjmQR9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqVpaakLAeDitoO58dU5nf6LxPtYQI5xqEm0xvcPKyEYNVDSxp
	CKp8hmKjFpleDuSqipoXFOW+hsUU4AX9UfhEFcUPE9jV/3kJckHo1+HMKEa8VuKTubPaQyRVKm9
	rVSTm06Ezow==
X-Google-Smtp-Source: AGHT+IGWFJKyKtY4P8UpIxPqLRFXmtn3fkygNqVRq1CXNPMFQs466KbnXI/f1SsdBuMKTvK8/3nFXr3dKqwg
X-Received: from plbmg11.prod.google.com ([2002:a17:903:348b:b0:240:2ea7:26fe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2cf:b0:248:dfaf:2aee
 with SMTP id d9443c01a7336-248dfaf3002mr61506385ad.28.1756438327192; Thu, 28
 Aug 2025 20:32:07 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:36 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-12-irogers@google.com>
Subject: [PATCH v5 11/13] perf jevents: Add ILP metrics for AMD
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 13bf3eaf498f..2101598e8b04 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,41 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("ex_ret_instr")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), cycles) for x in range(0, 4)]
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
@@ -584,6 +619,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdIlp(),
       AmdDtlb(),
       AmdItlb(),
       AmdLdSt(),
-- 
2.51.0.318.gd7df087d1a-goog


