Return-Path: <linux-kernel+bounces-898593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E62CC558FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F3234EB368
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CBD31D382;
	Thu, 13 Nov 2025 03:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrYnxX41"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040431A81B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004144; cv=none; b=pmWF+vdBp/kSMg5zISNkysi4pmli0/hUyJxNvnB+rOExxvfmoOMkAvVE6R8IiceO9OQHClFSR+3xdt/0EF0F8frbLLG9WQEyXHHCQJiaBFRMudZJ/jvsxXZpFsy2CaINtXOfEJCmwLF1HzZ3dOMbyPcBDyE+A0jaozbSyDKiLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004144; c=relaxed/simple;
	bh=ihHX9rfQI+mk7JQWS3ayfuEUt8pdUkdVHim6eGZCJlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GmLdNIqFZtppL4xrb1VlFSD0PiOc4C3GcQlutsSZhK1Cl96h+0ByFE/o7/iU4zkcGmjXS+dSqJ19RpnDxp9mqjLY3TP50tzicww/M7xvSRvnShGHTxvbKNtrBFH3SvNs1u8DIrF5XEh3qfuIgawpcIG3j3Q/ZMgWNWCRT3V+JBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CrYnxX41; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b522037281bso303560a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004142; x=1763608942; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jEfyet2B1xXlE/uoLh/D9/nC+lDkr1+Ax7UiiYEKLs=;
        b=CrYnxX41U2jMXpMeddKa+IeNILLq82KTcMjLKwPDFJjp4ZrfMmc14EIUXpgExnA+/p
         uYFUrVQV3atsZB3/oNl+L+Rus9ojNISXS6rfv6MNkJd/E4X5IZmoLESYfIY48Sh1LFQ9
         HN9dvNQbTtaDbrWbrZmRYbUJc8ULpWnP7on0sROzAtaS/8vcNaDF0Dc+NAX+aFYBD1LX
         8dAjfDV+j5Q8gV/OTGP7L4275BynvgM9cYirw4dxHzn7BjxQ3dTLzFYgR21fLEzPITRS
         JTAX63P5QOx+1oZ1P+iRmDdJ71eBzqucG1C0cHlSPNef7EOK9bwJlYEv6I+N0DqxroMu
         0kHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004142; x=1763608942;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jEfyet2B1xXlE/uoLh/D9/nC+lDkr1+Ax7UiiYEKLs=;
        b=kYFiVJOJTm/RIwgLIVJFLiK2XODZceTy9Sqphj5fAZGnDUnoL1Ux0rhH8GKY0/9Q7v
         jGGWxtSAX8QcR0J6K5HCcig0FtCa4WkDeWsg3h5TWYK0DYA2IDe0URFug9knSNPOPcRI
         z0Bokfuxy5l+9yeXjmrG4ZruYJAWPSpTtuU0RBHeMTHseuvL0Of5SgBRq08OTSbdEPBc
         S/Fv6+DfIeBA5K+UstUr/0+F3HDk/nnvHVRJLJHTQjapwPpDBRNImMruuiU/z9ULLb62
         bovEjHAZffykvxc5+Yg9goTP3SG4IzasN+KOKBGnDDGNptH9dqQzo4d5ZRoJ73irDa3A
         TnVg==
X-Forwarded-Encrypted: i=1; AJvYcCVBypGLoljZSx/pc3QWhdK/KlKMx09IbEcoT2/DsKemMskFx4DOMmnaPB7kdLnXoc6Lr+emJlG/Pa7AEX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3oDaKyZafN8Q/O+wIKsu5P2qHWwHQYPse15vKrjUM2GlcBD/
	aQFGuMv8D54xQUULa2+OQHSzsXqjrgXXTxxVCTaZecTl7qMbdkuppjj4a/Sq8YmHVSA/QC6a/0t
	khjOEwUuZIw==
X-Google-Smtp-Source: AGHT+IGpyPmryq9xTvHz9AjmIUhc8XIqDl1ryeGRMzQwFxEm0NYqkC5Odg5FUHwKSjdli29SyJ1qcArAzA/u
X-Received: from dybli13.prod.google.com ([2002:a05:7301:128d:b0:2a4:7052:5652])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18b:b0:295:9cb5:ae07
 with SMTP id d9443c01a7336-2984edaca29mr76719475ad.38.1763004141690; Wed, 12
 Nov 2025 19:22:21 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:34 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-47-irogers@google.com>
Subject: [PATCH v8 46/52] perf jevents: Add C-State metrics from the PCU PMU
 for Intel
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

Use occupancy events fixed in:
https://lore.kernel.org/lkml/20240226201517.3540187-1-irogers@google.com/

Metrics are at the socket level referring to cores, not hyperthreads.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 24ceb7f8719b..118fe0fc05a3 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -815,6 +815,35 @@ def IntelLdSt() -> Optional[MetricGroup]:
     ], description="Breakdown of load/store instructions")
 
 
+def UncoreCState() -> Optional[MetricGroup]:
+    try:
+        pcu_ticks = Event("UNC_P_CLOCKTICKS")
+        c0 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C0")
+        c3 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C3")
+        c6 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C6")
+    except:
+        return None
+
+    num_cores = Literal("#num_cores") / Literal("#num_packages")
+
+    max_cycles = pcu_ticks * num_cores
+    total_cycles = c0 + c3 + c6
+
+    # remove fused-off cores which show up in C6/C7.
+    c6 = Select(max(c6 - (total_cycles - max_cycles), 0),
+                total_cycles > max_cycles,
+                c6)
+
+    return MetricGroup("lpm_cstate", [
+        Metric("lpm_cstate_c0", "C-State cores in C0/C1",
+               d_ratio(c0, pcu_ticks), "cores"),
+        Metric("lpm_cstate_c3", "C-State cores in C3",
+               d_ratio(c3, pcu_ticks), "cores"),
+        Metric("lpm_cstate_c6", "C-State cores in C6/C7",
+               d_ratio(c6, pcu_ticks), "cores"),
+    ])
+
+
 def UncoreDir() -> Optional[MetricGroup]:
     try:
         m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
@@ -979,6 +1008,7 @@ def main() -> None:
         IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
+        UncoreCState(),
         UncoreDir(),
         UncoreMem(),
         UncoreMemBw(),
-- 
2.51.2.1041.gc1ab5b90ca-goog


