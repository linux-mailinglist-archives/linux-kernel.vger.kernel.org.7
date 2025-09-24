Return-Path: <linux-kernel+bounces-829962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8909DB98557
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF914C338F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA46247293;
	Wed, 24 Sep 2025 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnqqvAYH"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338B6242D69
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693767; cv=none; b=guaa6hqpZUYvuBXaDygunib2qTxoBjNvDWxPgRIuQfCEI9GWh6ESh6L0uRNd5mKiwMXXOpYfGG4fktHand/sHNrkzz8TPfK9gF9UWihf+dd/l3bexdl34IUn/TX77Rdy8fyhlL8GS+Oo3OkpRaosjI4sD+gBQ0EGAWl6jWRBa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693767; c=relaxed/simple;
	bh=g30opf6VhHg/JBJ6y5WhF9NixWedtLeYlci2OOULEYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=b1+9i/T+g++RXFhSkLfCKCiJlS0WlOVulBCdfN/+eyu4kAbc3YYVmT+jrlSPFtGfOCbsO8Z22GjPu3uEyAX2ql/Bvd2DsjehaZyBambv17g9rOG3LzBQlYBz0KZHfmpULAYsITbWSR9Q0ljc65PoGQGpRNE5hYlzmE5jugEItA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnqqvAYH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2699ed6d43dso64377585ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758693765; x=1759298565; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owyN4Zki/R7ckDuMRtN4QsY9lPIQex6HJCLQg2seOJ4=;
        b=mnqqvAYH2YJfJEwEIinjmpc3jo4DdFj4NTYsMiqLwIlIHGZS+kF2V8cwW97j1V/jIJ
         5gwaQFc9QYMtjNe9REhynoVrlBtXisbeCkVy6OwAonyd/akgjK88zkd+5elUvYSzY4yH
         Fi1ZLRfl3iCmjo/Zl7zyFM7/P2IcAbUvJW/z2qsjmQZ0CLkqENqR3eZz0Mb77tklI55M
         5aJDPRlUtRQCOm9OyNigaCTvnikX1hgZZLKjYE892r2z/q3bdoh56W4FPUZGDHNZjkZb
         4G084dABTLbu//xdfuuhb6yhyitTyTbQEJJwfO4O+NeA0YeoZQNEO6AzTuXuQmrC9liy
         lYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758693765; x=1759298565;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=owyN4Zki/R7ckDuMRtN4QsY9lPIQex6HJCLQg2seOJ4=;
        b=cMssI3V/xSsBZFl5xrZkY3av5n66pNDJNv/Kls/w60z7NoufAetivkmwATVUc2lLDx
         L4+TNl3VaQXxAbVmzuPnJ/i+SE4UdkShJEFmfIS8TqkcsCG0sYkubUsZWz0UakqYgEzL
         eRhAcL/umF/0oBEZ/TlLvRgfRT/6LQV7OscZ3z57Akc3gzyG2MzI97JTFcyJ4da/cMjo
         5EjqZ5dGeQ9rR0kFRS8JdgDd9F5YEpfYBtEcStKduEOALP4XFpLArZMVZd217nUju87M
         Q9h0/9A14veFPaBNIIjKJb+NRXKNjig5FidvPVYOasGrc6oeIXmKfyaWUME60V7WEXL2
         GbQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWav96x6zFUCM5995RLDSHcMb5a5J0BTx8lB/BUfC+wEAm7s7Bz9XhRuin9ADyW8z2LKwLvRc1S4gDZCjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1sc9VDCqrYkQypKlm5oru0H498+kwKn3ocA4iu0V+nm6yy8f8
	DhSdQlZ+TPhAPLqPGCj7fkh53SqypcmND/YXbLSA4IlO+yKTScldp8LCGwhWTS3GENUngbJdAHX
	QPaHddWRPDQ==
X-Google-Smtp-Source: AGHT+IFZXxwPnRz45KIVCNFGnWFxnZ2I7fRjVrzX9I+gA9n4ud9E04ktP+U5rMG8rswO99Ac0wLZcq7E/YbA
X-Received: from plbjf23.prod.google.com ([2002:a17:903:2697:b0:24c:7829:4af6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b0e:b0:268:1034:ac8b
 with SMTP id d9443c01a7336-27cc344ee6emr55421885ad.26.1758693765427; Tue, 23
 Sep 2025 23:02:45 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:02:21 -0700
In-Reply-To: <20250924060229.375718-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924060229.375718-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924060229.375718-3-irogers@google.com>
Subject: [PATCH v1 02/10] perf vendor events intel: Update arrowlake events to v1.13
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
2.51.0.534.gc79095c0ca-goog


