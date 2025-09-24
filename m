Return-Path: <linux-kernel+bounces-829965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61236B98560
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136F42E6EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C2D23F42D;
	Wed, 24 Sep 2025 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCoLwcds"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0400253944
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693773; cv=none; b=eXPOKS+eFo9bqfKps35+QMH+OJsIOqBoxuF/0vS0Ldy5Et4Fy/tJdtBzULdeRVRPQOJJB64wp5QS/urSSi1InbxH18h/L42cor3vPKZcNBXfNz2cmE1AGpIVaeMhdCKIh9493RgJhMSlyDy3lA2osjBmi2ue6UtpLCsTuXZb9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693773; c=relaxed/simple;
	bh=04iKahiFUELOtK/+gdpcmz1tb+qT1JapSHueyVrk8rA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MoE/BZzsQDRBpfJZelWZtRi8EHqApiEnA9Zr/ZHtP4OWWaZ6RmT+FyTEyIE14dF3du5l4rxQSosaRGgk+l74sywKYjQ7aaFaEE4BeRFN67nEHBd2Pwd+BIsm1uDKEUrN92avyZobwKN9TqbxOSoUFQoSxuscyOt3kDsF9ISYrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PCoLwcds; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27356178876so34200855ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758693771; x=1759298571; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3EahEFF7irEF9/nJSo2aSdXMCQM+mnokEIIxRNmppQ=;
        b=PCoLwcds3DSynSWW+Q71yaQVWDmg0jT7FAePK32Z5x16nHujZXP0I6DEUhWB9YLquu
         4mI2lEpbpT7ycoGYK2J3nEGF+hNUJXM+hKupev1K/IjU05DbknviZJpydB/wBw87Qf19
         NXzCuSplzMDadSXRRqk8BtVU+D8Uq08ALwrGQti907kz7QiokhA5jAUyFZOiJ+ddmANm
         0HQs1FRnRuJiYE5MTOjtFuT0ruzoWfcwqeBWy9PVpiacMBHvyv6pMjnHLQo/7UlcgXKF
         MnYjsC9/DvUoWmDTPaTZacpsPhI8B2vnH/8VlwYP4DLaNHPVs+6t5BAl0g7jvZyuQavG
         McFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758693771; x=1759298571;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3EahEFF7irEF9/nJSo2aSdXMCQM+mnokEIIxRNmppQ=;
        b=bx3/5kpyMuM6puIxJ8hpCp/OmikyciV3FJn91iE7YPAoMwb1SwS1oDtBJfbVNrCodv
         mpjZ6RmuvYbtt79JNvb0t72RD1OyAVoC3/NgaEQEPvKTIOIuIjSjVPrGYVuEAXH+Cs9I
         XxuGwwBA0p9AYA/3hu1k0m1FTGHjmvKHSx6ty3/SfZ9wiSTJ+ZWFin47FEWEilcvyyGv
         YzNCS50LXaEKy1VnPGvFvVJREX0v8fIVwMEhbi/wm9WPsJfDsQj/l+1wfTgHk/I8mN/U
         AG57QctmChIBzMJjgEBpBvUM2Kn+nvO7YSLuWAZsXHIhNna3DhV/KrF/1ApgK3WVURnU
         o7oA==
X-Forwarded-Encrypted: i=1; AJvYcCU4wFs3QAd0cyQEp2hZGy8OtWFceO4IYAjm6DHULqrVvBKt5rHPNyCkHCM/aoXTz4STaDkg3iw9IPqpXUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfdCKxzQonyYOLq6kvDuFiG9k363M8CpG+XfiiPny+KWZbD98
	aZvqsfpRXAjFb3Tu21KSGE7sa097EbirR8ryCkGAGQKaDXktLd+cthktMvnwy+sNLIEkz5LrCsL
	o8yKTCaftzQ==
X-Google-Smtp-Source: AGHT+IEK/HaL9qv07YhVGTKf2TZlDkUqytUIv4gZMRb35saf2RfHmVBGEOS/XhQTpRkikkvfNkNrqeFoTeml
X-Received: from ploc14.prod.google.com ([2002:a17:902:848e:b0:269:b6ad:8899])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d512:b0:278:daab:7940
 with SMTP id d9443c01a7336-27cc1e1acf3mr75769275ad.17.1758693771103; Tue, 23
 Sep 2025 23:02:51 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:02:24 -0700
In-Reply-To: <20250924060229.375718-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924060229.375718-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924060229.375718-6-irogers@google.com>
Subject: [PATCH v1 05/10] perf vendor events intel: Update graniterapids
 events to v1.15
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update graniterapids events to v1.15 released in:
https://github.com/intel/perfmon/commit/8af960a34864d291ad5a5a9f8fdf5a40486b78a1
https://github.com/intel/perfmon/commit/943667ba5b3f3203e47aede6bc7d017a26b89a26

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../graniterapids/uncore-interconnect.json    |  10 +-
 .../arch/x86/graniterapids/uncore-memory.json | 112 ++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 3 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
index 6667fbc50452..5eb1145f204f 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
@@ -833,11 +833,19 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1F",
         "EventName": "UNC_I_MISC1.LOST_FWD",
-        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x10",
         "Unit": "IRP"
     },
+    {
+        "BriefDescription": "Misc Events - Set 1 : Received Invalid : Secondary received a transfer that did not have sufficient MESI state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_INVLD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Snoop Hit E/S responses",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
index 9d385be59e3d..f559e27e2815 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
@@ -56,6 +56,33 @@
         "UMask": "0xcf",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 regular reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_NON_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc3",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 auto-precharge reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_PRE_REG",
+        "PerPkg": "1",
+        "UMask": "0xc2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 auto-precharge underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_PRE_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc8",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "CAS count for SubChannel 0 regular reads",
         "Counter": "0,1,2,3",
@@ -74,6 +101,15 @@
         "UMask": "0xc4",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_UNDERFILL_ALL",
+        "PerPkg": "1",
+        "UMask": "0xcc",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "CAS count for SubChannel 0, all writes",
         "Counter": "0,1,2,3",
@@ -121,6 +157,33 @@
         "UMask": "0xcf",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 regular reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_NON_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc3",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 auto-precharge reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_PRE_REG",
+        "PerPkg": "1",
+        "UMask": "0xc2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 auto-precharge underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_PRE_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc8",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "CAS count for SubChannel 1 regular reads",
         "Counter": "0,1,2,3",
@@ -139,6 +202,15 @@
         "UMask": "0xc4",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_UNDERFILL_ALL",
+        "PerPkg": "1",
+        "UMask": "0xcc",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "CAS count for SubChannel 1, all writes",
         "Counter": "0,1,2,3",
@@ -188,6 +260,46 @@
         "PublicDescription": "DRAM Clockticks",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "PMMNT is sending REF* commands while being in specified Refresh rate",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_M_MNTCMD_REFRATE.REFAB1X",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "PMMNT is sending REF* commands while being in specified Refresh rate",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_M_MNTCMD_REFRATE.REFAB2X",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "PMMNT is sending REF* commands while being in specified Refresh rate",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_M_MNTCMD_REFRATE.REFSB1X",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "PMMNT is sending REF* commands while being in specified Refresh rate",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_M_MNTCMD_REFRATE.REFSB2X",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "# of cycles MR4 temp readings forced 2x refresh",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 888d38e49766..6c0a6c3d2451 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-CF,v1.20,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.10,grandridge,core
-GenuineIntel-6-A[DE],v1.12,graniterapids,core
+GenuineIntel-6-A[DE],v1.15,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.24,icelake,core
-- 
2.51.0.534.gc79095c0ca-goog


