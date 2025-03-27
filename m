Return-Path: <linux-kernel+bounces-579226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB3DA740DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 23:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D871611C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 22:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8221EB5EB;
	Thu, 27 Mar 2025 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1gClDRK"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E981EB5C4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114291; cv=none; b=Wi5VSG1UAKU4/bEBkm8qTfb7eZsAwbK7ma6uGUX7CGdvMq/UG3B76ue8766du62+O/9HhSSv78eqoVNfl2ABqp1q1AdoJHgfSDKkWVQ8H/5ZExn7BDycGzSqfMiIB1+ZlpwwgzgqyvpQCXrthpnLy0LpvNAe5vRyHdwwVrZLL8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114291; c=relaxed/simple;
	bh=rEKsyl5VeXsQYB6M9jGct7xgL9z+rZvIbO9f2wNkGrg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cax+tta54s72AYeDz0yMacPp97m4Vo6Oi8t2E/IcdEBX8vz0nCDkw5U9cBjlls1qJXx9gSj7ctrbc/jxnN54LxvDHGotIwBUkxHUfazDqx+fijJC0qMvPywWNLPxgUq2g0AJjxk8vryF04/usn4OxN0jOGbAOEp79PRpuLqTkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1gClDRK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22406ee0243so21390465ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743114285; x=1743719085; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlkA6u2yJZ2VVf9mufqU92QMT0mRmr2z4j7mWj8ghPE=;
        b=U1gClDRKAS12n6q6joF5E0AahmBPEHPNsvizceShK+QUhV5wZ2IjLpoPbI0TLNajPG
         ccRX1bvRPa5JliLBI8ZDcNz9AcPibNPABOKYt+4BWFWWKyGLxTWuJOysSgfgD/oQApX7
         /EABXSrKLx9YZQIg/sPQ+TD55eYt4zmcd5w35IBKkCwhmWRKp7azYv9t0xW7iTRxGTlD
         fdc5LitVIPbx/0YC9Gbe647e7t2d2FZuA+O1sLxDS0qXbAzuxKdEHUM4XTcbgHl7TDtc
         TP1Kg9hpSFLLoC+g/OPFBBiBl1iKzMeBA2ghE2I2IYz1vPxUa51ARPdq2hhcLs50JAu+
         TSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743114285; x=1743719085;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlkA6u2yJZ2VVf9mufqU92QMT0mRmr2z4j7mWj8ghPE=;
        b=DEyxzwW90G2OpUO1HDq77JrqK6TQ220PkXSksDJg50imGWVy9e+zgkP6f2QAVg5si6
         1runeeiaXcgGIyYU+vMlepKnC2D28koM+6jvNZDNtMr1BtqmI2Brc9dZ93qx+buGNLBg
         3/DCRS96V73eoxW/kBfOTYTY5gYlXpsug481ylaZZO0Z+a84WmUMORLo2lN5SPb5IrhQ
         UcnrkdGbKwkLflFKDQZ/CdG72IeR68fCEcUdRpQkAfVmHqXB8ydnYPBFD8CR54yMB5j2
         FQkALwJuFWU0Ws1hu2/xTPJJX3y4870cGT3rJxmJyoq+FsrNbwGlE6F3ka9R8rNGZL0I
         tMKg==
X-Forwarded-Encrypted: i=1; AJvYcCUN66VtuhSok9OcK40kAjIqEKf4qVZk49MUHpdGSBdlXt2W1zjWsxAyyCFCvYd3+WBeWEmmbWhpi3at/GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2yQoy+vy4Ht9cZn02SrYY2j5mXkeSynfjqUDqIizPtW1h7AR
	O/J73m1DlpF/F6abi6z64H6AORq0KZcYGK5qsy5BWyupyX64OiIE0BtC7hdaelRm7uUBaXdJ3s5
	BY0UPtw==
X-Google-Smtp-Source: AGHT+IEF4opHdQ9Hxc/L3dIlu/t5hGdGcMjfAr8Zk7owIyWx6hP8pRb7hQ6+NgLwhnNBu3HWyYaFkj2cXNWd
X-Received: from pgkn22.prod.google.com ([2002:a63:ee56:0:b0:af2:3541:76e2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748f:b0:1f5:7ba7:69d3
 with SMTP id adf61e73a8af0-1fea2ec32e9mr9618026637.15.1743114285492; Thu, 27
 Mar 2025 15:24:45 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:23:28 -0700
In-Reply-To: <20250327222331.117701-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327222331.117701-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327222331.117701-34-irogers@google.com>
Subject: [PATCH v4 33/35] perf vendor events: Update westmereep-dp events
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
 .../arch/x86/westmereep-dp/cache.json         | 32 +++++++++++++++
 .../arch/x86/westmereep-dp/other.json         | 40 -------------------
 .../x86/westmereep-dp/virtual-memory.json     |  8 ++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
index 30845c7dbf08..f6f95f3ff301 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
index bcf5bcf637c0..c0cf8bae8074 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
index 53d7f76325a3..84c920637b12 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
@@ -152,6 +152,14 @@
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


