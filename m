Return-Path: <linux-kernel+bounces-829961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052DCB98554
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072F819C3D03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DEB243370;
	Wed, 24 Sep 2025 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ma5q2+q1"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBBB23D7C3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693765; cv=none; b=WBZSjwhoSJDAzdTDA4OKCb1c1WVq05B5mKs+1lAXctUbiE0kHD30VtgZBHESkEFxAKfHCN+UqtVes1TMD+89wYpWcGn/axLB3/ozzUTnFJDaGux6X8M9T+n7MM28XZwmMXPZ51FYQ9gzWedp89k9gJz3WreBnX7yMAq/Z9CEHrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693765; c=relaxed/simple;
	bh=Ozua6/BW5UuFbpCg0FHDmGoWQdaJSjFMqj1wv2uvy3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NChd4/vWP3M/qpxvaampzObK/mX3JeSvJdETAnCYiHa3wPIkdcke0hIoupVqaHNZ7OB/L9rJ4w992Y+EcLv3EppTsjo0MiLnsCKNGjKasRupUSXGeyXrmTD8oJSlKwzTh/RDdurKyphO4sLI7GZMPimH9NR4vidQIMxLyn2yyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ma5q2+q1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458345f5dso93695375ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758693764; x=1759298564; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Vk9l4AUq7CTqMThMt9/9gMzCRxcRdsa0lSeQ8Ld27k=;
        b=Ma5q2+q1I2VV0IneknMMNeO/oNJLHerf6k2RTYtJSra5c0xj+3IWUOtB86avA7Y2gC
         k9JQ2RdYsWGHoFDGRaN/C0rzfhzfmH4ldJt2L2vCS76QsfnS25811TEs+HcfVr/msDCb
         r1VwOtlKwUfKA47GzVoKkCKqcn52EyPoOK4hGOzUBtGqGF9xu9U9vcF6aoPReEcVUvZT
         kDKHTQyLM2Tz11mljIVwX5i3b0v8wylkqJUBABRTWGO2U7SO9Rir/McU2ya0nqQPWHxb
         h27hpBxCmTfNhpwjvgZUDQgru9zqCZDKaV0x1gd+9gDxfKYlucCu/3KH+uM9lKRx0UMW
         ftZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758693764; x=1759298564;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Vk9l4AUq7CTqMThMt9/9gMzCRxcRdsa0lSeQ8Ld27k=;
        b=ea1K4HMDdYTunp8QpKzxPeWRKAsL0ZfqLT/dNY9h3xTUN7yjkkEM6VZi9l0LYDNHTv
         bfsURKEejVwdsMkInj1u7G9vfp6TFdbxbhEInioyOnI5hwvBLb3A4v0WuBhPSDUkOQDa
         G4r0YCAjWy4UAKyXgnkXeOR7HScI6JZ/s9WpzIBb+t78Bo4+ozvWenx37WO8T9cT0x1O
         xTIFhiikLL50HNTBXoaFneSHdkih7xwtHjLAs18P3ryv5nTJSXLZzaR7u0h/qPxw+mOM
         wx6z6Ihj6ghwp8oaEir5qxBOJFeSKlV0PtjUbwXUK0E03Gc/LWgQCC5UTHsnGhVN+Q7+
         yiPg==
X-Forwarded-Encrypted: i=1; AJvYcCX33eyAKB8CSdL9jSXgq0384C5OZCCKfhE+m4an+VqVBBsOfvIfQ4v6o1M7QvPgQ21cPFbqjA3Oj7v1bVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpjV2X9yd2etAhN8xwOkak27/UYBIVP71ze/1LstJVONUlGEnM
	ENkog6lNo71zHrDVR6Yab8G9Dy5I5i1EIKpgMV3HPedxTVwVMxwIejB4R2mxlXL6CsMWSsdmBbb
	cPEJ2DlrdXQ==
X-Google-Smtp-Source: AGHT+IFlWiauUk8EbSxn3sXF/UaKrU6UOsxiB/XsWCah+2/yHZXJiweDcFuAxLl//qhqqMxn/mWbHmYILg6j
X-Received: from plsl15.prod.google.com ([2002:a17:903:244f:b0:24b:1657:c088])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f547:b0:269:ae5a:e32b
 with SMTP id d9443c01a7336-27cc18532ecmr62772295ad.13.1758693763653; Tue, 23
 Sep 2025 23:02:43 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:02:20 -0700
In-Reply-To: <20250924060229.375718-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924060229.375718-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924060229.375718-2-irogers@google.com>
Subject: [PATCH v1 01/10] perf vendor events intel: Update alderlake events to v1.34
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

Update alderlake events to v1.34 released in:
https://github.com/intel/perfmon/commit/80b773ebcf601b0e48e31f2184ffef933c4d842e

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/alderlake/cache.json  | 36 +++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  4 +--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
index 6a56c9ad8e43..4cd535baf703 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -1062,6 +1062,30 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts writebacks of modified cachelines that hit in the L3 or were snooped from another core's caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.COREWB_M.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C0008",
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
+        "MSRValue": "0x1F803C1000",
+        "PublicDescription": "Counts writebacks of non-modified cachelines that hit in the L3 or were snooped from another core's caches. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that have any type of response.",
         "Counter": "0,1,2,3,4,5",
@@ -1302,6 +1326,18 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts all data read, code read, RFO and ITOM requests including demands and prefetches to the core caches (L1 or L2) that hit in the L3 or were snooped from another core's caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C4477",
+        "PublicDescription": "Counts all data read, code read, RFO and ITOM requests including demands and prefetches to the core caches (L1 or L2) that hit in the L3 or were snooped from another core's caches. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts L1 data cache software prefetches which include T0/T1/T2 and NTA (except PREFETCHW) that have any type of response.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index d9daab4d8461..4b706599124d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.33,alderlake,core
-GenuineIntel-6-BE,v1.33,alderlaken,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.34,alderlake,core
+GenuineIntel-6-BE,v1.34,alderlaken,core
 GenuineIntel-6-C[56],v1.12,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
-- 
2.51.0.534.gc79095c0ca-goog


