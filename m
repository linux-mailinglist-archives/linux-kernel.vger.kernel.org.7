Return-Path: <linux-kernel+bounces-832958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ACBBA0D69
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E914A11B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA330E853;
	Thu, 25 Sep 2025 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1WeBAo/o"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1B3126AC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821276; cv=none; b=eqBGMapT0wLWrJDX0kmr9XJuJKTM10EHG/J4J73G3JvDUY139QjWaEY2SnwX80aYa9K+EegYaSEcOcbhZIizojmTt88Cnbk4dMpllKcus+zUN3fQR1RLro2e+xqRAWGMuyoV9CQH/dtVfiD8ax18TIfOJjbDLEoJFwP0cw6fQzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821276; c=relaxed/simple;
	bh=Ui4Ao0TJHbelPZCMLJYCckLU3NwnOtCNmtgUjYnJoX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sGXL1q+EcU9g6fW3oqU+wy1CBKKxEef/R0wJamvuXHebUWknwLmXMUuFPv2xh5ze4BckjlVt2HaNl/AhB4jqAFEXFdrMHx/4yR+n5beFI5XDd3x7VmcZfYjM9hhty2LoDY/6DYNvlZs7S8Pn8Pr3yl43GoCEb1qeTWk3pWmzseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1WeBAo/o; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so696974b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821274; x=1759426074; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3o78gGKSzgfihbjVTXXsG1dia2s8gz/WHdqTEr3yWU=;
        b=1WeBAo/owTiJGZNzi/oVcTe/4XeXFw+rUSnglX7MCVBZnrfLdsPOG6xVfhyk1EeGD8
         XTrCbQ1Wt1bRAqy5KP/IpOSh52PE0rOQRK85F6xZC0p+PaM9rJ6TdG5mU+jX+xV7WEI1
         i52X2weJXVJOmwsiwDdYpS6jldnfiiBzWO1367Wef1mSudpJuv0+tp7GwgrGNrsCpiXb
         CYspbYiWlBIiJJFRJ06FeeVp76OE6aj/RkUhsqY6EIacP8o3VGMNXZOfeou/MsC9RNyM
         LT5gPWugABP1d1Ep/mMplB5Lrb5AAdVYuDBghYLyKLEAbU+AsLcoZ5T2YCfA1xPj5Yua
         +g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821274; x=1759426074;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W3o78gGKSzgfihbjVTXXsG1dia2s8gz/WHdqTEr3yWU=;
        b=VnYnIvB6VgjO7fLU2khRzH8vj4ShNBBpVvBafy5b9JPsSLYyth5kF/JpHP1rp1IykF
         7FwhQgcbv6eKholuFV0VyXoH8ia+qYzwem+QxNnvZTDarl15rFexGu/0NCfih14cclnD
         MV0ks4tCtidEbYjLDfJZ3VAbO2SyMI7N74EZNW2LuxMPzF7QgPwnFselqbBdby14Exo4
         qJOYp0oe/qekV1Jd2M8ag2nQNFhY7l2zbrMigKXJ7ifvmLgWo/vJm70WrBvKdg80r7fL
         +Uh7tlkcGv217Xrn8bp9QroD+/iuOpoBQONhbsJKWHHfdx+irEnF+ohHXJHXD6VBumKL
         MSew==
X-Forwarded-Encrypted: i=1; AJvYcCXCm8rT8KwfCfXQqVTC3ZyCnoNSreDFcVPqfPkVAj67SBIorY0tRNcu9AB9Clj3UC49a7pl+u1H2rcvYy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF1Em98lIUrjVRa6HECAUUFh5JPTwuayA4HyINrbKEJr79ZK9v
	3OUWZMc+i492pXWUs6NAu3woI8iovpehwaO7wsXNKHSAlKQb1P/hqDirOkaps+FNkjMwusM0gpu
	/O2NSZSkThw==
X-Google-Smtp-Source: AGHT+IG8qnKfgUvoWmnrZHupDLsW05tNwDUCKVqmeVzYIhAWzleX3ESuN4a4w/MOLirgOUJF2nzImv+m1icY
X-Received: from pgam16.prod.google.com ([2002:a05:6a02:2b50:b0:b55:6d4:19ea])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918e:b0:262:c083:bb38
 with SMTP id adf61e73a8af0-2e7a438eda1mr5734157637.0.1758821273736; Thu, 25
 Sep 2025 10:27:53 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:27:32 -0700
In-Reply-To: <20250925172736.960368-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172736.960368-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172736.960368-7-irogers@google.com>
Subject: [PATCH v2 06/10] perf vendor events intel: Update lunarlake events to v1.18
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

Update lunarlake events to v1.18 released in:
https://github.com/intel/perfmon/commit/04e11e566618d781b854f526d7e394ed504=
20638

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/lunarlake/cache.json  | 46 +++++++++++++++++--
 .../pmu-events/arch/x86/lunarlake/memory.json |  6 +--
 .../pmu-events/arch/x86/lunarlake/other.json  |  2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/lunarlake/cache.json
index 29bcb847178f..402ca8fc50b6 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
@@ -1305,6 +1305,18 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts writebacks of modified cachelines that=
 were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.COREWB_M.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x7E001E00008",
+        "PublicDescription": "Counts writebacks of modified cachelines tha=
t were supplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts writebacks of non-modified cachelines =
that have any type of response.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1317,6 +1329,18 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts writebacks of non-modified cachelines =
that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.COREWB_NONM.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x7E001E01000",
+        "PublicDescription": "Counts writebacks of non-modified cachelines=
 that were supplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1355,7 +1379,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1367,7 +1391,7 @@
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
@@ -1379,7 +1403,7 @@
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
@@ -1415,7 +1439,7 @@
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
@@ -1427,7 +1451,7 @@
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
@@ -1437,6 +1461,18 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts all data read, code read, RFO and ITOM=
 requests including demands and prefetches to the core caches (L1 or L2) th=
at were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x7E001E04477",
+        "PublicDescription": "Counts all data read, code read, RFO and ITO=
M requests including demands and prefetches to the core caches (L1 or L2) t=
hat were supplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Any memory transaction that reached the SQ.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/lunarlake/memory.json
index 25021cb76f61..caa387e10259 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/memory.json
@@ -352,7 +352,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -376,7 +376,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache and were supplied by the system memory (DRAM, MSC, or MM=
IO).",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -412,7 +412,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were no=
t supplied by the L3 cache and were supplied by the system memory (DRAM, MS=
C, or MMIO).",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/lunarlake/other.json
index 59949f9541d8..1df716442549 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/other.json
@@ -151,7 +151,7 @@
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
index 6c0a6c3d2451..aa0e2b0c4ba4 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -22,7 +22,7 @@ GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
-GenuineIntel-6-BD,v1.17,lunarlake,core
+GenuineIntel-6-BD,v1.18,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.16,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
--=20
2.51.0.536.g15c5d4f767-goog


