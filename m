Return-Path: <linux-kernel+bounces-580289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE128A74FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 18:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2651888539
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9111F6699;
	Fri, 28 Mar 2025 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3hsMrep"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3171E1DE4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184307; cv=none; b=MlD08g3NTgj1IQhmmddTXmAi98og1N4Vprsm5OEkRF0P2bduB1QdIXRot9qT8r/pU0bCHJcoS+A+FvDNgBvpXtOP5kRT7KvL5JhNUwq5456ELwrSzx0EwoQtw8OdjqH9IeYmkn5LSi4dND4DcQYiVG8ePkX48EYHOnrr1UbUL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184307; c=relaxed/simple;
	bh=Vb8Zw2G8yDaioPTnls3nU7UxwtuE80WVgK353Gkw6uQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kHXikIvvQNPXswHILd2DXjf5ITAn+EAVQ4ftLRtuv++p5IlA7ou1FaijAartyXMY6X7UFF7P0YlMS0Wo1sNU4gHsBPjmH/2ol+26IEJvR0eC4oDoQryl0CtqZ3xqubaFQGpesOZjmYiV4u1XifX16zddP0nlqXcHwjtbQ4SvJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3hsMrep; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2254e500a73so32580925ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743184296; x=1743789096; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DD+qgAbA2jbLVZa6aUPEYkzjGKc51TnF+sfLKzMQeFc=;
        b=M3hsMrep6vRfvWrbAqkqb4WvIVmFWUSt1rhbF20uC9D5nbC7dCdVHk1P5vqlvisJlK
         4WEFT8Y6fPIKfyHAe4NpijQ4rB4jt8O1hG9M8miKPlH6xQVvruNts8oAsdEA96OIRlV+
         LdkRzhLmahZiJgNsY7xXDjMndb0R3QW47H2ZL2pK8Rb5Hw/MxldtPCvWIKAUxlyJ7sew
         jsDu78G2hbq5WL2ZRxvV123aEPEsHde76wkr6LqOjc9Xp6Le87e2SV+7mjDwuFsTp/Me
         Tk98yUxeYvaCxSOYf88ymW8RLdDh6gqzpBArrquRBFiF8l84wY4UA/3EWPirRe6ljkEm
         Wofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743184296; x=1743789096;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DD+qgAbA2jbLVZa6aUPEYkzjGKc51TnF+sfLKzMQeFc=;
        b=VKPZLZhswknH+SFH9vPnuiKl+6IdSQAprcB/iemy8sYuJO30zLSiHx1n6Cp67k2GhV
         ijlE50T1+2sVU8PWrfY8HB6+MnfDWSKxmJ9pafj1dmOLqU+4FpO8piIgCxdq75pI3JL/
         ThgwJKLjt5RapnphO0sp8ViUMytKUQXy0iAuQJQ1Kq4nGvCMDo8sAxO8MajEqYz9vxlU
         Vv3XXWh8hMrV/Sc5p715utA3d80o67hbuiR1N702k/osV+l3FNUAHeBtfwFv+vYH3myl
         QQL8AuZRn5B7iaq/E6gvvDkf4mToqh0PxqxZssyHGkBXPko3DMDuG+egvPLX/FWiOJLD
         nAwg==
X-Forwarded-Encrypted: i=1; AJvYcCUzPCUNJREr9dLB8vpOYFkXaGC3EbO2k8KPdKmh2xGLRjyORU3+1mxi/Qghf4Oh5gYiwgwI2+YH+VoNoZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfZtlOPKD6v0PHQHbY6BevuagmaEPq0RJAL4oALcH7IxcXUu2s
	ciArv2KIf4/eGPs3OZkZ1860bshGmhIzyqN1ZZCkior/BemArEeCjIBPcjQY7X2Ap1+m/WVzk1r
	2MlWcCA==
X-Google-Smtp-Source: AGHT+IFsmWWdQTvozkILE//7Ob6SL7BiANQFVN0YKIJqJ1MYj92y0pgJuWlRPXIkhznjT663QT8Nnjef/uc2
X-Received: from pltm7.prod.google.com ([2002:a17:902:6bc7:b0:223:58e2:570d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea02:b0:221:78a1:27fb
 with SMTP id d9443c01a7336-2292f94499emr1007995ad.11.1743184295682; Fri, 28
 Mar 2025 10:51:35 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:50:05 -0700
In-Reply-To: <20250328175006.43110-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328175006.43110-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328175006.43110-35-irogers@google.com>
Subject: [PATCH v5 34/35] perf vendor events: Update westmereep-dp events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Update event topic moving other topic events to cache and virtual
memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/westmereep-sp/cache.json         | 32 +++++++++++++++
 .../arch/x86/westmereep-sp/other.json         | 40 -------------------
 .../x86/westmereep-sp/virtual-memory.json     |  8 ++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
index 90cb367f5798..0cd571472dca 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
@@ -119,6 +119,38 @@
         "SampleAfterValue": "100000",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "L1I instruction fetch stall cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.CYCLES_STALLED",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "L1I instruction fetch hits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.HITS",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "L1I instruction fetch misses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.MISSES",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "L1I Instruction fetches",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.READS",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x3"
+    },
     {
         "BriefDescription": "All L2 data requests",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
index bcf5bcf637c0..c0cf8bae8074 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
@@ -15,46 +15,6 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "L1I instruction fetch stall cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.CYCLES_STALLED",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x4"
-    },
-    {
-        "BriefDescription": "L1I instruction fetch hits",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.HITS",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "L1I instruction fetch misses",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.MISSES",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "L1I Instruction fetches",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.READS",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x3"
-    },
-    {
-        "BriefDescription": "Large ITLB hit",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x82",
-        "EventName": "LARGE_ITLB.HIT",
-        "SampleAfterValue": "200000",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Loads that partially overlap an earlier store",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
index e7affdf7f41b..a1b22c82a9bf 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
@@ -128,6 +128,14 @@
         "SampleAfterValue": "200000",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Large ITLB hit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "LARGE_ITLB.HIT",
+        "SampleAfterValue": "200000",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Retired loads that miss the DTLB (Precise Event)",
         "Counter": "0,1,2,3",
-- 
2.49.0.472.ge94155a9ec-goog


