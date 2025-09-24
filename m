Return-Path: <linux-kernel+bounces-829967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D60B98567
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D8B17AA68A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371E225EFBF;
	Wed, 24 Sep 2025 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ey4EY/bC"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211B25A34F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693777; cv=none; b=DD0/4X5XW8QEj4BpDvvEmmO8jyaHMJw8MD5b3dwSXApaiqfkK+AKg08ttrzFTv72jqUbGe5ULiQ9JPuPRIC2EIy/zK1EXIFav275UTdNe/S2L64Se6Uw8RAqmd9xggML+bJ5Uutkw6h7rek4Bn/9cAoodkqRNba/FF2LlfcR2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693777; c=relaxed/simple;
	bh=4f8UteEAAKXXLnIaZVqboj+1JKF4R9D1H1JBFam/nTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uq+5hqfkGXQPDvcTloGsag1azzzHWKcx+7b0bnfyTHge8mmExynA1XIrC6t+KjYgsFVbyVs2koIA4qw7nVmAYGEvZBIFXmwOovdH9rujShp52XUHiD4BkzihFXRCGOP5hmd06QqXTfo1/HdhfPfMlF8yG2N+cI7QFBF2EXt75Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ey4EY/bC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-277f0ea6fc6so57472565ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758693775; x=1759298575; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P69iPSe+1qLG8k7P5qyASkPxZvhss/JJiTEkX7gdyIo=;
        b=Ey4EY/bCGZgqxF9lbwCURmKfuLujEU2dm+C7DvDKRaNUSYlCOHrSKb0NL1OuGXtQm/
         MMUbGyrVGZ/7lJ19oLtXCmITfXis7ZxZNofWsG4fFxEdQlZJ57ty2cB7CP+EuTyD6Vmj
         WsGA9GL9Mga72BXM03WqStghqGo3fUqiSJu4xyIbBQJK6OMa0oqu3QaFQ6i5RF/vF+2G
         eJpiEiG8PvcuCqLrrRvUjQiNTu+ujJ8C9Tpt0YirRFt66hJDw0uVKQw2Q+bMEcKaNkVv
         MAtxbfbHXAsCH9duGZq4pxLApevvZRJeA20Un230JAc4XzBdHVtSyWUaWWSDcaW3nTyh
         Dp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758693775; x=1759298575;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P69iPSe+1qLG8k7P5qyASkPxZvhss/JJiTEkX7gdyIo=;
        b=lpCdokdq96FGaKErEvshLg1kp5zynzUVOhYdgdV5a2YTE6KRu0sL1e7v0tGwmFLkKk
         Wb+2xDQAGmKgXVyC0neWg/6hMA60zwFhjFyaLGsmTOkbl78MF7MKfpaAvLXWBzly39Hq
         rUzETCMrSrcYTZI/L0DeuXpJaqgtnI/yrHdDJ26FMw3qx7JFb5UsIWkDSScVt4OuR2eZ
         q+ivgT5pLHxvXZAensyO5L/QTBmoGBxARJMJkR4QHVRpmtJCxgTMtAHaBDZxpAnHltxl
         GY+vd6WQCAkJBzLhchfIbSo7lSzrPWZIDOu4pTI4orKVQPUe4z3vizv9jQNLs1PfPXuN
         PKhA==
X-Forwarded-Encrypted: i=1; AJvYcCWGA+AV0QhtJMXlgZn+/DnKra258ZpcBlBJZu3v8c1EJRDfuz9qxUxsUafQkt0GJBiYgt8ef4vicyVdtv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz66raQ8mo61G1Ux8VpPvAQ+nzyIf2i9KnjHMHEg9N7YB6mtZ0b
	kOmtVRMkfrkZMOOcX+E35fCeHSDUlh+yHOoNgPesYdUMPTJxVhueeUbD3kOPa6DGFPJkWPXtIs1
	RHLUpvaTcNQ==
X-Google-Smtp-Source: AGHT+IFqqe+931Ht21O2+lNV2c4QoFc87BRwc5+qH3FUQ+AFS53EMxT79FCln5S8v0dPfoOMlzx2lj+mqr6d
X-Received: from plge16.prod.google.com ([2002:a17:902:cf50:b0:269:80e0:d704])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c8:b0:272:a900:c42b
 with SMTP id d9443c01a7336-27cc5434e1dmr57043505ad.31.1758693775135; Tue, 23
 Sep 2025 23:02:55 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:02:26 -0700
In-Reply-To: <20250924060229.375718-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924060229.375718-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924060229.375718-8-irogers@google.com>
Subject: [PATCH v1 07/10] perf vendor events intel: Update meteorlake events
 to v1.17
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
2.51.0.534.gc79095c0ca-goog


