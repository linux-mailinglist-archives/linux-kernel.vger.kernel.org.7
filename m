Return-Path: <linux-kernel+bounces-832959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D62DBA0D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1FF94E3B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1662D31326C;
	Thu, 25 Sep 2025 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5oaRuSx"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944833128AB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821278; cv=none; b=WrUS/KtgSXNPP41eNXISoYowfS7K1x8QdP2WoHem+YUhGIAeAjtaFR28gSQX9RzsMIL2ocIP1RIU9gyLU+KMqhSJY5zo81AihZibH3wJbfwK/2t0bcvZK97SAYnH82bW65psBvsuLAmR/rFLZVm7T3oFW3eUD+w+GoU/r4TCNo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821278; c=relaxed/simple;
	bh=UZ1nenpXOHL/GiJ2SoPlc1AsNZtWkGDydwrp4T1IWEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fMTKXtjK+FVHFWzwXmVzl/bup+CpN+aoYmZjjKiOc+endHq7tyKs+BKaOgmgO2JlmQrrOdYhQHPUjXfSFDHSvOWV8+4eRa23zbnLLs8SZ8L8sWHQRct1sWpX9pebnZg/6dr/kIFe+w+gcUKSwuiBWOWAX5m5W/4dHda7QLtstXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5oaRuSx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-738a1926b60so14645397b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821275; x=1759426075; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W08ly8/Vh/q1BQgG1o3PTQUXDuImGkhSqbuKUD38INk=;
        b=W5oaRuSxLcm3FCH/r9r3g9zaep3hRrQgRdNJHX1n283YdNmrUL4XRnG6bxmFvxv7ZR
         9H/ML8QWgQY1MeHG83Q9dn4Mx6e5GY0eSFZwT3C3RRwZpehs5g3V85C+c5Cjh71zBCLs
         tfxTiTI3n+lVH2wGNT4zXJY33CzXmitsYRh7sI8nBRJbSNjbVMvA4AgsfY/w9dxAEKoZ
         fOIuYhe8Jz4dblZeBuif+5vzOX5onslJG5nWwLMZ4bkedlod9XTusUCzmbeeWU122M89
         Psm/6BPwq8jMBbeGNm5xkI/oLEWfY3XmsBWtsJv+3aiQVCur6I6m1MZ3YphdC5uzJT0G
         kcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821276; x=1759426076;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W08ly8/Vh/q1BQgG1o3PTQUXDuImGkhSqbuKUD38INk=;
        b=DTUgYp/M+r5aiH9oujd3ftha8v20YSki+cwfiXfEbo/hQ89UVjn6/P8WKzRqBBVXvD
         W+2Q+IEbauxqKIm1JNHMOB3Sg3R2b9QP2DSFskzYBvteBGDbV61E/3wDYvF4AEIZoL33
         3GwYg4eVBfrtmWgt5XvSDgyheaIOoq5sPvZMGb9MrznZIRFnEKdBYw5ewkZSkenkTvqr
         mxHm0OyO8+xWnA7iikOxRJd5fqWKsSnrqQW4gZUKIq8qEoUqF27ERC8MwWxLfc6TUBql
         qpgtcwQ2blqAIAp4o7jpshPVPRaB0xLkhXAS61fyfCts5trzg2vkJ5j0XQGHx72Q0F7B
         BUEw==
X-Forwarded-Encrypted: i=1; AJvYcCXx5z+Uv0DrX9f8kXT+ZeoUoJx/xKZ3EdxN1QvyDx0lGiP3P92m4AeqykrNkGK+gmldLOKX6/YE9IAqD34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwboP1dp2CHJcMhoZLWNoiNu6ChRZTRsJVof+erkqlvGZGN3bQ2
	0ljFeklI42cMGCRlTcPxwNCEfc1z1/ok5onTuU27OlbLMhTFI6GHopIfyYcMWIHnu/7xgQJK7Af
	6HENyF+4ZhQ==
X-Google-Smtp-Source: AGHT+IHLZFcjDP1uOdSHMiRmqGh++GyPeC0pnmKnx0I1q+4QQqOyYsHBabeG4rCVjRJ5ZOi0XOjmMJDYy4wX
X-Received: from ywblh8.prod.google.com ([2002:a05:690c:5608:b0:735:8634:be69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:4908:b0:739:ca5d:d97c
 with SMTP id 00721157ae682-763fa52a40dmr37249747b3.15.1758821275661; Thu, 25
 Sep 2025 10:27:55 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:27:33 -0700
In-Reply-To: <20250925172736.960368-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172736.960368-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172736.960368-8-irogers@google.com>
Subject: [PATCH v2 07/10] perf vendor events intel: Update meteorlake events
 to v1.17
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update lunarlake events to v1.17 released in:
https://github.com/intel/perfmon/commit/ec387ac70602283d01da32c2ff5fe9cb15d3d25b

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 36 +++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index aa0e2b0c4ba4..3a15a0f75b96 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -23,7 +23,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.18,lunarlake,core
-GenuineIntel-6-(AA|AC|B5),v1.16,meteorlake,core
+GenuineIntel-6-(AA|AC|B5),v1.17,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-CC,v1.00,pantherlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
index f1d8db284a02..d4731e300d6d 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -1178,6 +1178,30 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts writebacks of modified cachelines that hit in the L3 or were snooped from another core's caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.COREWB_M.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0008",
+        "PublicDescription": "Counts writebacks of modified cachelines that hit in the L3 or were snooped from another core's caches. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts writebacks of non-modified cachelines that hit in the L3 or were snooped from another core's caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.COREWB_NONM.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C1000",
+        "PublicDescription": "Counts writebacks of non-modified cachelines that hit in the L3 or were snooped from another core's caches. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that have any type of response.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1394,6 +1418,18 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts all data read, code read, RFO and ITOM requests including demands and prefetches to the core caches (L1 or L2) that hit in the L3 or were snooped from another core's caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C4477",
+        "PublicDescription": "Counts all data read, code read, RFO and ITOM requests including demands and prefetches to the core caches (L1 or L2) that hit in the L3 or were snooped from another core's caches. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Any memory transaction that reached the SQ.",
         "Counter": "0,1,2,3",
-- 
2.51.0.536.g15c5d4f767-goog


