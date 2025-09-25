Return-Path: <linux-kernel+bounces-832954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2589BA0D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77F61C21D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C69930FF10;
	Thu, 25 Sep 2025 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNlFQJjO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E8A30EF71
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821268; cv=none; b=c6MINlymSQb5uBwyKFjp8eNgqiUA947ChoCA11DaaNIJwqAXlZN1LbmwxQD4Xdd5ei7BF7jyttMz44Q4NdzkEia8WgYKJJqb5AslgvxqVSGYAvpKRubQfW+nFXeincaTaNIzSB4FZ6UiutfjMmyACbS2e6B+udC3QupX54nAsYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821268; c=relaxed/simple;
	bh=J3PZ7RcWoZldXhQjhYW17zoSCLWf9Jf7hf3gKsZ/P94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kNbloMUieyoVBGTGg40tOcLusPg4FIO1u9pDceG4PfD7GyvM9HcKiMHpeYFU/f67Wa93ytBjHTXGTpmlMHc5uhZm7pinlBZzltnBHUSWSFbm073vpYJg4uWa+YB7+m4tSp70dliGMl4uoJmVqveyKlg/YoCdr+8L3l9AHrFkwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNlFQJjO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-71e7181cddeso14396557b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821265; x=1759426065; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sNCocgva6CbFz3BhwDX2MUKg2BtePZAcfnLx9zB958=;
        b=iNlFQJjOz2GgF41PHOE2/UJzR922iQJcBGocfL1uG8pAGUo0tZWPsmz5/tTVAk6VFj
         dwOuUULZpwFiOwaY52cZf04fd4U+eLQoif+9sPUxS3XTztU70oAeXbmRbn6ansCpcOwS
         voYQsgFTnD0Q1tO7jfoJIzvJNYIkgIO30DITQ8Ru0MMxoTgOXeD/aCb8yFp136o6k07e
         JxMz9qYAlZzM1zIs/c8OP/KAujrj/jaNYSGN3NLcHBnV2GpkuVCBcKJhn6e9/qEX9PyG
         brC3XoDYtFdrfpGnlC2GiP2XoofjZOiBel2u9F1XcfvFn5TB4aCvAp1xgpl01rnrJDJL
         GgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821265; x=1759426065;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8sNCocgva6CbFz3BhwDX2MUKg2BtePZAcfnLx9zB958=;
        b=apBH9ANBZslCYfeFKmWjMWxXB8GRPlLX1fEAM2pGXShxB5G3r2lYZhhs+P6ypY75sv
         nPr7EEXI9qTvMvdPbQ44QEnJJADYKYwSahXmo0v+OA2a8w8XwbWKYrhAPhSuuSw5GoE9
         cCR/aLE9/FBo0SnPo751hcfS5KDjW50z5jYo5JAZ6tr2XO+5V7xkQGhJrtGu/7vJQBJN
         Qx+k/HEDqQ94OOTE1+cqRnezJqPUi0GOTHs/P1A2SqpqwQiTkUJFBkahw7q5a/+UghcI
         JDES0d/ZTYMXZtRUaAoEzN4qVNKXCjsW/TgD6dHGbCxAlhHpg41rUXVD7SbTzhQNROEt
         EPuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuDWNrgTtzrydSUdC2pLxBS3Va347+28ERI/OhwtVpRv/ru6G33/BuwDwoiF1VwH90CPfl6YHi1IvMD1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXqZQermjsYN0e/wVdC/h1SZLLbimXHP+8iI8v+E8giw93dZEU
	xgpyOWRtDitt8v1ibEP31GFbRw0Qjvksda4dwQ06aw4NPKWv+NJYUFa77KkSNY0Rx2kkoIQqqWC
	D7TKjMCu93A==
X-Google-Smtp-Source: AGHT+IGTSwIJqq1toQVlypj4vZy4BKhG9NXBIoUUUIYlGVJKGyFJc73zwTwW/kf30QhrFfNWCM7xSi2wnBkW
X-Received: from ywblh8.prod.google.com ([2002:a05:690c:5608:b0:735:8634:be69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:6c08:b0:75f:58d0:38cc
 with SMTP id 00721157ae682-764018516ddmr42489547b3.27.1758821265473; Thu, 25
 Sep 2025 10:27:45 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:27:28 -0700
In-Reply-To: <20250925172736.960368-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172736.960368-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172736.960368-3-irogers@google.com>
Subject: [PATCH v2 02/10] perf vendor events intel: Update arrowlake events to v1.13
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
Content-Transfer-Encoding: quoted-printable

Update arrowlake events to v1.13 released in:
https://github.com/intel/perfmon/commit/718cdcec8b9637819af5e9eff8f705f731b=
0f971

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/arrowlake/cache.json  | 46 +++++++++++++++++--
 .../pmu-events/arch/x86/arrowlake/memory.json |  6 +--
 .../pmu-events/arch/x86/arrowlake/other.json  |  2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/arrowlake/cache.json
index f5168b55a6f4..30dd56b487ba 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
@@ -1435,9 +1435,33 @@
         "UMask": "0xf",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts writebacks of modified cachelines that=
 hit in the L3 or were snooped from another core's caches.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.COREWB_M.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x7E001E00008",
+        "PublicDescription": "Counts writebacks of modified cachelines tha=
t hit in the L3 or were snooped from another core's caches. Available PDIST=
 counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts writebacks of non-modified cachelines =
that hit in the L3 or were snooped from another core's caches.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.COREWB_NONM.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x7E001E01000",
+        "PublicDescription": "Counts writebacks of non-modified cachelines=
 that hit in the L3 or were snooped from another core's caches. Available P=
DIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1449,7 +1473,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop hit in another cores caches, data forwarding i=
s required as the data is modified.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1461,7 +1485,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop hit in another cores caches which forwarded th=
e unmodified data to the requesting core.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1473,7 +1497,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1485,7 +1509,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were su=
pplied by the L3 cache where a snoop hit in another cores caches, data forw=
arding is required as the data is modified.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1495,6 +1519,18 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts all data read, code read, RFO and ITOM=
 requests including demands and prefetches to the core caches (L1 or L2) th=
at hit in the L3 or were snooped from another core's caches.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x7E001E04477",
+        "PublicDescription": "Counts all data read, code read, RFO and ITO=
M requests including demands and prefetches to the core caches (L1 or L2) t=
hat hit in the L3 or were snooped from another core's caches. Available PDI=
ST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Any memory transaction that reached the SQ.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/arrowlake/memory.json
index 1e6360347c0f..aba1e27e5e37 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/memory.json
@@ -334,7 +334,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -346,7 +346,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -358,7 +358,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were no=
t supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/arrowlake/other.json
index 51bc763a5887..ab7aac14e697 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/other.json
@@ -66,7 +66,7 @@
     },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 4b706599124d..8daaa8f40b66 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,7 +1,7 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.34,alderlake,core
 GenuineIntel-6-BE,v1.34,alderlaken,core
-GenuineIntel-6-C[56],v1.12,arrowlake,core
+GenuineIntel-6-C[56],v1.13,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
 GenuineIntel-6-56,v12,broadwellde,core
--=20
2.51.0.536.g15c5d4f767-goog


