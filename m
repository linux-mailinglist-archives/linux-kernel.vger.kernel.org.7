Return-Path: <linux-kernel+bounces-580296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B639A74FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3014B18954A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935351FCFCB;
	Fri, 28 Mar 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1KkcV6b"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE71EB5D1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184329; cv=none; b=JpYI8y1oJ5SJoojxJp62KT3W2CYgdZ6s1FJQ334uL4vWgBP/GTdPCCzc+039Nemvz9PAbxfUgD8PYDLfS3qZnxm/hFF38WJbt2yhmarT1w/XjsgmStmJ3IE0h1XRm4RDvyJ0UiXYyrOUrVCM4Xo3BAAHUDb4xymKkawQYucbc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184329; c=relaxed/simple;
	bh=vwiOL5YJQjquHqQuvdlinBDWaOShjPJfGTmJK6VtXXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Le8FvwkM90orlWE3mVloHDF3IubyVyWXHCv4/nCPWy77HT+z9eSXiwLthxSDaRb5hEvZ+U1zmu9toKGXxuTJTHsS9kOcw5ZnvEG2+lyaUHnE1RJnjcQFJPnJgGyBstQjg+trmM4VKtMVB8hzGP3tPzmh03pw5UPO6ZESeU7eVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1KkcV6b; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3032ea03448so4450218a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743184270; x=1743789070; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4zZWjmm4wrEqujzRHwQnqwy/ZhLYhPcABZTRJntJAw=;
        b=d1KkcV6bX/f1W8ZVDr42aVVLjVxXTA5L6wTcvzYjxX7cTz+es6eN453wB8A+WDFgMm
         2tsyEOeKA03ySyv0H1FAELhNSN/xp1AU1y+3WSy6HZwXQbVUAHLc0dPqgpABbB5gMKOb
         xSyMM62+AoxfFm6yAVERMIvM44TtyjEgjaiF3+GYDFLnB+GWRGUn3M8Y4iktoEAc84cZ
         nr3GXwe7KMkirGfrF7VDIRtSbzKzXVoMEEuw6EGc2VXBZ5HTc2yNfxSRJ8iipfWn/2GV
         H+uxCOVE9QGudvlsSEKA4tNbjkmBzjDieZHLdHSrNUMw3nCRoKD4EGCUhUL1OLsEFGM9
         +q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743184270; x=1743789070;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x4zZWjmm4wrEqujzRHwQnqwy/ZhLYhPcABZTRJntJAw=;
        b=ZqT9RktPcdYHZWO4F8HvwlTklL4ODqPciCkvQNK5o0BNf2MJH4kniZjJYx0efOa50A
         +cAlqyOJ8J7GAztfak3huX44Q24UzOGOOdEaUrWDyCOHAtZ7yT7n12TVz+J+PtnmiTif
         lPacWOiYhNLK5/ht2IYPR127c4/dMkEOlF3erOuUz4Xi6y/H+frIuRxWKqIDBMHyIEg2
         uGzNH1ij/l+bt95LzKAsSkR8zgT6h6+Yvy/ScoOefeWVF5RhN07FvXAp4xw/AjWJ3kQ5
         T75vHnNYa1dGxP8F+Bbe6oUnc13K7CKipFR+jH7GU5vZfbAtq3pVHcdFCn4O3GPfzVH5
         QQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsvR5ETrpZsAKosL8QuTT3kyYuUPui/3RgtOKYXxOXTwBBoYvEzzpwtKnta9VZyZU36AzDJStXR7OWrGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5A6mdeR4G9zvZCowY8BX1cSBhrzwqeyCyXW+H0dhjq0MvDgCU
	oFIhImj05BXlGwWKOcNxo8DM0mVdrID5mziErAan1KIGsbs4xF/z5G+alBczbAun6gGeE8PHYif
	OES/i1w==
X-Google-Smtp-Source: AGHT+IFvqxr5D5njhzC9jUj+80EwGLflfkqL/EKdyHFwuxih29pScbd/eRFHOMA0EbBLZboc1j5FDGDFC2Qw
X-Received: from pfbho20.prod.google.com ([2002:a05:6a00:8814:b0:736:af6b:e58d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d50d:b0:1f5:9016:3594
 with SMTP id adf61e73a8af0-2009f610b5cmr397652637.18.1743184270094; Fri, 28
 Mar 2025 10:51:10 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:49:53 -0700
In-Reply-To: <20250328175006.43110-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328175006.43110-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328175006.43110-23-irogers@google.com>
Subject: [PATCH v5 22/35] perf vendor events: Update meteorlake events/metrics
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
Content-Transfer-Encoding: quoted-printable

Update events from v1.12 to v1.13.
Update event topics, addition of PDIST counter into descriptions,
metrics to be generated from the TMA spreadsheet and other small clean
ups.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 352 ++++++++---
 .../arch/x86/meteorlake/floating-point.json   |  28 +-
 .../arch/x86/meteorlake/frontend.json         |  82 +--
 .../arch/x86/meteorlake/memory.json           |  90 ++-
 .../arch/x86/meteorlake/mtl-metrics.json      | 553 +++++++++---------
 .../pmu-events/arch/x86/meteorlake/other.json | 149 +----
 .../arch/x86/meteorlake/pipeline.json         | 252 +++++---
 .../arch/x86/meteorlake/uncore-memory.json    |  18 +
 .../arch/x86/meteorlake/virtual-memory.json   |  40 +-
 10 files changed, 901 insertions(+), 665 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 579b4fbd65d6..0c16c9b840a5 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -23,7 +23,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.11,lunarlake,core
-GenuineIntel-6-(AA|AC|B5),v1.12,meteorlake,core
+GenuineIntel-6-(AA|AC|B5),v1.13,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/cache.json
index ce351cd7caaf..c980bbee6146 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -1,9 +1,20 @@
 [
+    {
+        "BriefDescription": "Counts the number of L1D cacheline (dirty) ev=
ictions caused by load misses, stores, and prefetches.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x51",
+        "EventName": "DL1.DIRTY_EVICTION",
+        "PublicDescription": "Counts the number of L1D cacheline (dirty) e=
victions caused by load misses, stores, and prefetches.  Does not count evi=
ctions or dirty writebacks caused by snoops.  Does not count a replacement =
unless a (dirty) line was written back.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "L1D.HWPF_MISS",
         "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.HWPF_MISS",
+        "PublicDescription": "L1D.HWPF_MISS Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -13,7 +24,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
-        "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
+        "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -23,7 +34,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
-        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses. Av=
ailable PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -35,7 +46,7 @@
         "EdgeDetect": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
-        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses. Av=
ailable PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -45,7 +56,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALLS",
-        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses. Availa=
ble PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -55,7 +66,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
-        "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
+        "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -66,7 +77,7 @@
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
-        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles.",
+        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -76,27 +87,87 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "L2_LINES_IN.ALL",
-        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
+        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1f",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of cache lines filled into =
the L2 cache that are in Exclusive state",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.E",
+        "PublicDescription": "Counts the number of cache lines filled into=
 the L2 cache that are in Exclusive state. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines filled into =
the L2 cache that are in Forward state",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.F",
+        "PublicDescription": "Counts the number of cache lines filled into=
 the L2 cache that are in Forward state. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines filled into =
the L2 cache that are in Modified state",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.M",
+        "PublicDescription": "Counts the number of cache lines filled into=
 the L2 cache that are in Modified state. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines filled into =
the L2 cache that are in Shared state",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.S",
+        "PublicDescription": "Counts the number of cache lines filled into=
 the L2 cache that are in Shared state. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache lines that are =
evicted due to an L2 cache fill",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.NON_SILENT",
+        "PublicDescription": "Counts the number of L2 cache lines that are=
 evicted due to an L2 cache fill. Increments on the core that brought the l=
ine in originally.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Modified cache lines that are evicted by L2 c=
ache when triggered by an L2 cache fill.",
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.NON_SILENT",
-        "PublicDescription": "Counts the number of lines that are evicted =
by L2 cache when triggered by an L2 cache fill. Those lines are in Modified=
 state. Modified lines are written back to L3",
+        "PublicDescription": "Counts the number of lines that are evicted =
by L2 cache when triggered by an L2 cache fill. Those lines are in Modified=
 state. Modified lines are written back to L3 Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of L2 cache lines that are =
silently dropped due to an L2 cache fill",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.SILENT",
+        "PublicDescription": "Counts the number of L2 cache lines that are=
 silently dropped due to an L2 cache fill.  Increments on the core that bro=
ught the line in originally.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache.",
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.SILENT",
-        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event.",
+        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -106,7 +177,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.USELESS_HWPF",
-        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
+        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -116,37 +187,64 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
-        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES]",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES] Available PDIST coun=
ters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xff",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of L2 Cache Accesses that r=
esulted in a Hit from a front door request only (does not include rejects o=
r recycles), per core event",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "All requests that hit L2 cache. [This event i=
s alias to L2_RQSTS.HIT]",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.HIT",
-        "PublicDescription": "Counts all requests that hit L2 cache. [This=
 event is alias to L2_RQSTS.HIT]",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This=
 event is alias to L2_RQSTS.HIT] Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xdf",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of total L2 Cache Accesses =
that resulted in a Miss from a front door request only (does not include re=
jects or recycles), per core event",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache [Thi=
s event is alias to L2_RQSTS.MISS]",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.MISS",
-        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS]",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS] Available PDIST coun=
ters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x3f",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of L2 Cache Accesses that m=
iss the L2 and get BBL reject  short and long rejects (includes those count=
ed in L2_reject_XQ.any), per core event",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.REJECTS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "L2 code requests",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
-        "PublicDescription": "Counts the total number of L2 code requests.=
",
+        "PublicDescription": "Counts the total number of L2 code requests.=
 Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xe4",
         "Unit": "cpu_core"
@@ -156,7 +254,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
-        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
+        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xe1",
         "Unit": "cpu_core"
@@ -166,7 +264,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
-        "PublicDescription": "Counts demand requests that miss L2 cache.",
+        "PublicDescription": "Counts demand requests that miss L2 cache. A=
vailable PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x27",
         "Unit": "cpu_core"
@@ -176,7 +274,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_REFERENCES",
-        "PublicDescription": "Counts demand requests to L2 cache.",
+        "PublicDescription": "Counts demand requests to L2 cache. Availabl=
e PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xe7",
         "Unit": "cpu_core"
@@ -186,6 +284,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_HWPF",
+        "PublicDescription": "L2_RQSTS.ALL_HWPF Available PDIST counters: =
0",
         "SampleAfterValue": "200003",
         "UMask": "0xf0",
         "Unit": "cpu_core"
@@ -195,7 +294,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
-        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
+        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xe2",
         "Unit": "cpu_core"
@@ -205,7 +304,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
-        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
+        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xc4",
         "Unit": "cpu_core"
@@ -215,7 +314,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
-        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
+        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x24",
         "Unit": "cpu_core"
@@ -225,7 +324,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
-        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache. Available PDIST counte=
rs: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xc1",
         "Unit": "cpu_core"
@@ -235,7 +334,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
-        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
+        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x21",
         "Unit": "cpu_core"
@@ -245,7 +344,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.HIT",
-        "PublicDescription": "Counts all requests that hit L2 cache. [This=
 event is alias to L2_REQUEST.HIT]",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This=
 event is alias to L2_REQUEST.HIT] Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xdf",
         "Unit": "cpu_core"
@@ -255,6 +354,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.HWPF_MISS",
+        "PublicDescription": "L2_RQSTS.HWPF_MISS Available PDIST counters:=
 0",
         "SampleAfterValue": "200003",
         "UMask": "0x30",
         "Unit": "cpu_core"
@@ -264,7 +364,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
-        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS]",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS] Available PDIST co=
unters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x3f",
         "Unit": "cpu_core"
@@ -274,7 +374,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
-        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL]",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL] Available PDIST counters:=
 0",
         "SampleAfterValue": "200003",
         "UMask": "0xff",
         "Unit": "cpu_core"
@@ -284,7 +384,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
-        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xc2",
         "Unit": "cpu_core"
@@ -294,7 +394,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
-        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x22",
         "Unit": "cpu_core"
@@ -304,7 +404,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_HIT",
-        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full.",
+        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xc8",
         "Unit": "cpu_core"
@@ -314,7 +414,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_MISS",
-        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full.",
+        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x28",
         "Unit": "cpu_core"
@@ -324,7 +424,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "L2_TRANS.L2_WB",
-        "PublicDescription": "Counts L2 writebacks that access L2 cache.",
+        "PublicDescription": "Counts L2 writebacks that access L2 cache. A=
vailable PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -334,7 +434,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
-        "PublicDescription": "This event counts the number of cycles when =
the L1D is locked. It is a superset of the 0x1 mask (BUS_LOCK_CLOCKS.BUS_LO=
CK_DURATION).",
+        "PublicDescription": "This event counts the number of cycles when =
the L1D is locked. It is a superset of the 0x1 mask (BUS_LOCK_CLOCKS.BUS_LO=
CK_DURATION). Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -354,7 +454,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
+        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3. Available PDIST coun=
ters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x41",
         "Unit": "cpu_core"
@@ -374,7 +474,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
+        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3. Available PDIST counters: 0=
",
         "SampleAfterValue": "100003",
         "UMask": "0x4f",
         "Unit": "cpu_core"
@@ -398,6 +498,15 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which missed in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x35",
+        "EventName": "MEM_BOUND_STALLS_IFETCH.L2_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7e",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an ICACHE or ITLB miss which hit in the LLC. If the=
 core has access to an L3 cache, an LLC hit refers to an L3 cache hit, othe=
rwise it counts zeros.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -435,6 +544,15 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which missed in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.L2_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7e",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which hit in the LLC. If the cor=
e has access to an L3 cache, an LLC hit refers to an L3 cache hit, otherwis=
e it counts zeros.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -453,13 +571,22 @@
         "UMask": "0x78",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled to a store buffer full condition",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.SBFULL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Retired load instructions.",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
-        "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW.",
+        "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x81",
         "Unit": "cpu_core"
@@ -470,7 +597,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
-        "PublicDescription": "Counts all retired store instructions.",
+        "PublicDescription": "Counts all retired store instructions. Avail=
able PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x82",
         "Unit": "cpu_core"
@@ -481,7 +608,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ANY",
-        "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores.",
+        "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x83",
         "Unit": "cpu_core"
@@ -492,7 +619,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
-        "PublicDescription": "Counts retired load instructions with locked=
 access.",
+        "PublicDescription": "Counts retired load instructions with locked=
 access. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x21",
         "Unit": "cpu_core"
@@ -503,7 +630,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
-        "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary.",
+        "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x41",
         "Unit": "cpu_core"
@@ -514,7 +641,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
-        "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary.",
+        "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x42",
         "Unit": "cpu_core"
@@ -525,7 +652,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_HIT_LOADS",
-        "PublicDescription": "Number of retired load instructions with a c=
lean hit in the 2nd-level TLB (STLB).",
+        "PublicDescription": "Number of retired load instructions with a c=
lean hit in the 2nd-level TLB (STLB). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x9",
         "Unit": "cpu_core"
@@ -536,7 +663,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_HIT_STORES",
-        "PublicDescription": "Number of retired store instructions that hi=
t in the 2nd-level TLB (STLB).",
+        "PublicDescription": "Number of retired store instructions that hi=
t in the 2nd-level TLB (STLB). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0xa",
         "Unit": "cpu_core"
@@ -547,7 +674,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
-        "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB).",
+        "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x11",
         "Unit": "cpu_core"
@@ -558,7 +685,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
-        "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB).",
+        "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x12",
         "Unit": "cpu_core"
@@ -568,7 +695,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "MEM_LOAD_COMPLETED.L1_MISS_ANY",
-        "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss)",
+        "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss) Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0xfd",
         "Unit": "cpu_core"
@@ -579,7 +706,7 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
-        "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3. Available PDIST counters: 0",
         "SampleAfterValue": "20011",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -590,7 +717,7 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
-        "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache. A=
vailable PDIST counters: 0",
         "SampleAfterValue": "20011",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -601,7 +728,7 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
-        "PublicDescription": "Counts retired load instructions whose data =
sources were hits in L3 without snoops required.",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were hits in L3 without snoops required. Available PDIST counters: =
0",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -612,7 +739,7 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
-        "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache. Available P=
DIST counters: 0",
         "SampleAfterValue": "20011",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -623,7 +750,7 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
-        "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM.",
+        "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -634,7 +761,7 @@
         "Data_LA": "1",
         "EventCode": "0xd4",
         "EventName": "MEM_LOAD_MISC_RETIRED.UC",
-        "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock).",
+        "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock). Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -645,7 +772,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.FB_HIT",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready.",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready. Available PDIST counters:=
 0",
         "SampleAfterValue": "100007",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -656,7 +783,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source.",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -667,7 +794,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_MISS",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache.",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -678,7 +805,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
-        "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources.",
+        "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -689,7 +816,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
-        "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources.",
+        "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources. Available PDIST counters: 0",
         "SampleAfterValue": "100021",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -700,7 +827,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_HIT",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache.",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100021",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -711,7 +838,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_MISS",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache.",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "50021",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -820,6 +947,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "MEM_STORE_RETIRED.L2_HIT",
+        "PublicDescription": "MEM_STORE_RETIRED.L2_HIT Available PDIST cou=
nters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1049,11 +1177,23 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe5",
         "EventName": "MEM_UOP_RETIRED.ANY",
-        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses",
+        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that have any type of response. Available PDIST c=
ounters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1061,6 +1201,7 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by the L3 cache. Available PDI=
ST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1072,6 +1213,7 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by the L3 cache where a snoop =
was sent, the snoop hit, and modified data was forwarded. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1083,6 +1225,7 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by the L3 cache where a snoop =
was sent, the snoop hit, but no data was forwarded. Available PDIST counter=
s: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1094,10 +1237,35 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by the L3 cache where a snoop =
was sent, the snoop hit, and non-modified data was forwarded. Available PDI=
ST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "PublicDescription": "Counts demand data reads that have any type =
of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "PublicDescription": "Counts demand data reads that have any type =
of response. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1105,6 +1273,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1116,6 +1285,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by the L3 cache where a snoop was sent, the snoop hit, and modified data wa=
s forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1127,6 +1297,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
+        "PublicDescription": "Counts demand data reads that resulted in a =
snoop hit in another cores caches, data forwarding is required as the data =
is modified. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1138,6 +1309,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by the L3 cache where a snoop was sent, the snoop hit, but no data was forw=
arded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1149,6 +1321,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by the L3 cache where a snoop was sent, the snoop hit, and non-modified dat=
a was forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1160,6 +1333,31 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0001",
+        "PublicDescription": "Counts demand data reads that resulted in a =
snoop hit in another cores caches which forwarded the unmodified data to th=
e requesting core. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that have any type =
of response. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "PublicDescription": "Counts demand read for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1171,6 +1369,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were supplied =
by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1182,6 +1381,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were supplied =
by the L3 cache where a snoop was sent, the snoop hit, and modified data wa=
s forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1193,6 +1393,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
+        "PublicDescription": "Counts demand read for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that result=
ed in a snoop hit in another cores caches, data forwarding is required as t=
he data is modified. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1202,7 +1403,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
-        "PublicDescription": "Counts memory transactions reached the super=
 queue including requests initiated by the core, all L3 prefetches, page wa=
lks, etc..",
+        "PublicDescription": "Counts memory transactions reached the super=
 queue including requests initiated by the core, all L3 prefetches, page wa=
lks, etc.. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -1212,7 +1413,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DATA_RD",
-        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
+        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1222,7 +1423,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
-        "PublicDescription": "Counts both cacheable and Non-Cacheable code=
 read requests.",
+        "PublicDescription": "Counts both cacheable and Non-Cacheable code=
 read requests. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1232,7 +1433,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
-        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
+        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1242,7 +1443,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
-        "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM.",
+        "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1253,7 +1454,7 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "PublicDescription": "Counts cycles when offcore outstanding cache=
able Core Data Read transactions are present in the super queue. A transact=
ion is considered to be in the Offcore outstanding state between L2 miss an=
d transaction completion sent to requestor (SQ de-allocation). See correspo=
nding Umask under OFFCORE_REQUESTS.",
+        "PublicDescription": "Counts cycles when offcore outstanding cache=
able Core Data Read transactions are present in the super queue. A transact=
ion is considered to be in the Offcore outstanding state between L2 miss an=
d transaction completion sent to requestor (SQ de-allocation). See correspo=
nding Umask under OFFCORE_REQUESTS. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1264,7 +1465,7 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE=
_RD",
-        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1275,6 +1476,7 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
+        "PublicDescription": "Cycles where at least 1 outstanding demand d=
ata read request is pending. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1285,7 +1487,7 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
-        "PublicDescription": "Counts the number of offcore outstanding dem=
and rfo Reads transactions in the super queue every cycle. The 'Offcore out=
standing' state of the transaction lasts from the L2 miss until the sending=
 transaction completion to requestor (SQ deallocation). See the correspondi=
ng Umask under OFFCORE_REQUESTS.",
+        "PublicDescription": "Counts the number of offcore outstanding dem=
and rfo Reads transactions in the super queue every cycle. The 'Offcore out=
standing' state of the transaction lasts from the L2 miss until the sending=
 transaction completion to requestor (SQ deallocation). See the correspondi=
ng Umask under OFFCORE_REQUESTS. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1295,6 +1497,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "PublicDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD Availab=
le PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1304,7 +1507,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
-        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1314,7 +1517,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
-        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
+        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor. Available PDIST counters: 0"=
,
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1324,7 +1527,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
-        "PublicDescription": "Counts the number of off-core outstanding re=
ad-for-ownership (RFO) store transactions every cycle. An RFO transaction i=
s considered to be in the Off-core outstanding state between L2 cache miss =
and transaction completion.",
+        "PublicDescription": "Counts the number of off-core outstanding re=
ad-for-ownership (RFO) store transactions every cycle. An RFO transaction i=
s considered to be in the Off-core outstanding state between L2 cache miss =
and transaction completion. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1334,7 +1537,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "SQ_MISC.BUS_LOCK",
-        "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
+        "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -1344,6 +1547,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.ANY",
+        "PublicDescription": "Counts the number of PREFETCHNTA, PREFETCHW,=
 PREFETCHT0, PREFETCHT1 or PREFETCHT2 instructions executed. Available PDIS=
T counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0xf",
         "Unit": "cpu_core"
@@ -1353,7 +1557,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.NTA",
-        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
+        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1363,7 +1567,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
-        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
+        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1373,7 +1577,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T0",
-        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
+        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1383,7 +1587,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T1_T2",
-        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json =
b/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
index 28dc5e06ee31..ae9778aa755b 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
@@ -15,6 +15,7 @@
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FPDIV_ACTIVE",
+        "PublicDescription": "This event counts the cycles the floating po=
int divider is busy. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -24,7 +25,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.FP",
-        "PublicDescription": "Counts all microcode Floating Point assists.=
",
+        "PublicDescription": "Counts all microcode Floating Point assists.=
 Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -34,6 +35,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.SSE_AVX_MIX",
+        "PublicDescription": "ASSISTS.SSE_AVX_MIX Available PDIST counters=
: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -43,6 +45,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
+        "PublicDescription": "FP_ARITH_DISPATCHED.PORT_0 [This event is al=
ias to FP_ARITH_DISPATCHED.V0] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -52,6 +55,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
+        "PublicDescription": "FP_ARITH_DISPATCHED.PORT_1 [This event is al=
ias to FP_ARITH_DISPATCHED.V1] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -61,6 +65,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_5",
+        "PublicDescription": "FP_ARITH_DISPATCHED.PORT_5 [This event is al=
ias to FP_ARITH_DISPATCHED.V2] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -70,6 +75,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V0",
+        "PublicDescription": "FP_ARITH_DISPATCHED.V0 [This event is alias =
to FP_ARITH_DISPATCHED.PORT_0] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -79,6 +85,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V1",
+        "PublicDescription": "FP_ARITH_DISPATCHED.V1 [This event is alias =
to FP_ARITH_DISPATCHED.PORT_1] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -88,6 +95,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V2",
+        "PublicDescription": "FP_ARITH_DISPATCHED.V2 [This event is alias =
to FP_ARITH_DISPATCHED.PORT_5] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -97,7 +105,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
-        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events. Available PDIST counters: 0"=
,
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -107,7 +115,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
-        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events. Available PDIST co=
unters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -117,7 +125,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
-        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -127,7 +135,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
-        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events. Available PDIST co=
unters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -137,7 +145,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.4_FLOPS",
-        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events."=
,
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events. =
Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x18",
         "Unit": "cpu_core"
@@ -147,7 +155,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
-        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events.",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -157,7 +165,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
-        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events. Available PD=
IST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -167,7 +175,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
-        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events. Av=
ailable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -177,7 +185,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.VECTOR",
-        "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events.",
+        "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0xfc",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/frontend.json
index a10614513c8d..509ce68c2ea6 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
@@ -14,7 +14,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "BACLEARS.ANY",
-        "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
+        "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore. A=
vailable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -24,7 +24,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.LCP",
-        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk. Available PDIS=
T counters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -34,6 +34,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.MS_BUSY",
+        "PublicDescription": "Cycles the Microcode Sequencer is busy. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -43,7 +44,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
-        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
+        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE. Available PDIST counters: =
0",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -55,7 +56,7 @@
         "EventName": "FRONTEND_RETIRED.ANY_ANT",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x9",
-        "PublicDescription": "Always Not Taken (ANT) conditional retired b=
ranches (no BTB entry and not mispredicted)",
+        "PublicDescription": "Always Not Taken (ANT) conditional retired b=
ranches (no BTB entry and not mispredicted) Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -67,7 +68,7 @@
         "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x1",
-        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
+        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss. Availa=
ble PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -79,7 +80,7 @@
         "EventName": "FRONTEND_RETIRED.DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x11",
-        "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss.",
+        "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -100,7 +101,7 @@
         "EventName": "FRONTEND_RETIRED.ITLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x14",
-        "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss.",
+        "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -112,7 +113,7 @@
         "EventName": "FRONTEND_RETIRED.L1I_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x12",
-        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss.",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -124,7 +125,7 @@
         "EventName": "FRONTEND_RETIRED.L2_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x13",
-        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -136,7 +137,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600106",
-        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall.",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall. Available PDIST coun=
ters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -148,7 +149,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x608006",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall.",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -160,7 +161,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x601006",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -172,7 +173,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600206",
-        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall.",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -184,7 +185,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x610006",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall.",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -196,7 +197,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x100206",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -208,7 +209,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x602006",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops.",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -220,7 +221,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600406",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall.",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall. Available PDIST count=
ers: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -232,7 +233,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x620006",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall.",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -244,7 +245,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x604006",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall.",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall. Available PDIST coun=
ters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -256,7 +257,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600806",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops.",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -268,7 +269,7 @@
         "EventName": "FRONTEND_RETIRED.MISP_ANT",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x9",
-        "PublicDescription": "ANT retired branches that got just mispredic=
ted",
+        "PublicDescription": "ANT retired branches that got just mispredic=
ted Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -280,6 +281,7 @@
         "EventName": "FRONTEND_RETIRED.MS_FLOWS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
+        "PublicDescription": "FRONTEND_RETIRED.MS_FLOWS Available PDIST co=
unters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -291,7 +293,7 @@
         "EventName": "FRONTEND_RETIRED.STLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x15",
-        "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
+        "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -303,6 +305,7 @@
         "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x17",
+        "PublicDescription": "FRONTEND_RETIRED.UNKNOWN_BRANCH Available PD=
IST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -330,7 +333,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE_DATA.STALLS",
-        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity. Available PDIST counters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -342,6 +345,7 @@
         "EdgeDetect": "1",
         "EventCode": "0x80",
         "EventName": "ICACHE_DATA.STALL_PERIODS",
+        "PublicDescription": "ICACHE_DATA.STALL_PERIODS Available PDIST co=
unters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -351,7 +355,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_TAG.STALLS",
-        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -362,7 +366,7 @@
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_ANY",
-        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath.",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -373,7 +377,7 @@
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ.",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -383,7 +387,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
-        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path. Availab=
le PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -394,7 +398,7 @@
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_ANY",
-        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB).",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB). Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -405,7 +409,7 @@
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB). Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -415,7 +419,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
-        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB). Available PDIST c=
ounters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -426,7 +430,7 @@
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES_ANY",
-        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
+        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -438,7 +442,7 @@
         "EdgeDetect": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_SWITCHES",
-        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
+        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer. Availab=
le PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -448,7 +452,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
-        "PublicDescription": "Counts the number of uops initiated by MITE =
or Decode Stream Buffer (DSB) and delivered to Instruction Decode Queue (ID=
Q) while the Microcode Sequencer (MS) is busy. Counting includes uops that =
may 'bypass' the IDQ.",
+        "PublicDescription": "Counts the number of uops initiated by MITE =
or Decode Stream Buffer (DSB) and delivered to Instruction Decode Queue (ID=
Q) while the Microcode Sequencer (MS) is busy. Counting includes uops that =
may 'bypass' the IDQ. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -458,7 +462,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CORE",
-        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that when no operation was delivered to the back-end pipeline due=
 to instruction fetch limitations when the back-end could have accepted mor=
e operations. Common examples include instruction cache misses or x86 instr=
uction decode limitations. The count may be distributed among unhalted logi=
cal processors (hyper-threads) who share the same physical core, in process=
ors that support Intel Hyper-Threading Technology. Software can use this ev=
ent as the numerator for the Frontend Bound metric (or top-level category) =
of the Top-down Microarchitecture Analysis method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that when no operation was delivered to the back-end pipeline due=
 to instruction fetch limitations when the back-end could have accepted mor=
e operations. Common examples include instruction cache misses or x86 instr=
uction decode limitations. The count may be distributed among unhalted logi=
cal processors (hyper-threads) who share the same physical core, in process=
ors that support Intel Hyper-Threading Technology. Software can use this ev=
ent as the numerator for the Frontend Bound metric (or top-level category) =
of the Top-down Microarchitecture Analysis method. Available PDIST counters=
: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -469,7 +473,7 @@
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE",
-        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES=
_0_UOPS_DELIV.CORE]",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES=
_0_UOPS_DELIV.CORE] Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -481,7 +485,7 @@
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CYCLES_FE_WAS_OK",
         "Invert": "1",
-        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_N=
OT_DELIVERED.CYCLES_FE_WAS_OK]",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_N=
OT_DELIVERED.CYCLES_FE_WAS_OK] Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -491,7 +495,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
-        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle.",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -502,7 +506,7 @@
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
-        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DEL=
IV.CORE]",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DEL=
IV.CORE] Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -514,7 +518,7 @@
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
         "Invert": "1",
-        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLE=
S.CYCLES_FE_WAS_OK]",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLE=
S.CYCLES_FE_WAS_OK] Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json b/tools/=
perf/pmu-events/arch/x86/meteorlake/memory.json
index e4481fbc1e13..17b94f810d5a 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
@@ -5,6 +5,7 @@
         "CounterMask": "2",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L3_MISS",
+        "PublicDescription": "Cycles while L3 cache miss demand load is ou=
tstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -15,6 +16,7 @@
         "CounterMask": "6",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
+        "PublicDescription": "Execution stalls while L3 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x6",
         "Unit": "cpu_core"
@@ -88,7 +90,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
+        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -99,6 +101,7 @@
         "CounterMask": "2",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
+        "PublicDescription": "Cycles while L1 cache miss demand load is ou=
tstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -109,6 +112,7 @@
         "CounterMask": "3",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
+        "PublicDescription": "Execution stalls while L1 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -119,7 +123,7 @@
         "CounterMask": "5",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
-        "PublicDescription": "Execution stalls while L2 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock).",
+        "PublicDescription": "Execution stalls while L2 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock). Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_core"
@@ -130,7 +134,7 @@
         "CounterMask": "9",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
-        "PublicDescription": "Execution stalls while L3 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock).",
+        "PublicDescription": "Execution stalls while L3 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock). Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x9",
         "Unit": "cpu_core"
@@ -143,7 +147,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x400",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency. Available PDIST count=
ers: 0",
         "SampleAfterValue": "53",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -156,7 +160,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0",
         "SampleAfterValue": "1009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -169,7 +173,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0",
         "SampleAfterValue": "20011",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -182,7 +186,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x800",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency. Available PDIST count=
ers: 0",
         "SampleAfterValue": "23",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -195,7 +199,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0",
         "SampleAfterValue": "503",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -208,7 +212,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -221,7 +225,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency. Available PDIST counters=
: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -234,7 +238,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0",
         "SampleAfterValue": "101",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -247,7 +251,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0",
         "SampleAfterValue": "2003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -260,7 +264,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency. Available PDIST counters=
: 0",
         "SampleAfterValue": "50021",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -271,7 +275,7 @@
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
-        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8",
+        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8 Availab=
le PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -294,6 +298,18 @@
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by DRAM. Available PDIST count=
ers: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the L3 cache.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -301,10 +317,35 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were not supplied by the L3 cache. Available=
 PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by DRAM. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -312,6 +353,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00001",
+        "PublicDescription": "Counts demand data reads that were not suppl=
ied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -323,10 +365,23 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00001",
+        "PublicDescription": "Counts demand data reads that were not suppl=
ied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were supplied =
by DRAM. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -334,6 +389,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were not suppl=
ied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -345,6 +401,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00002",
+        "PublicDescription": "Counts demand read for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were n=
ot supplied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -354,6 +411,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
+        "PublicDescription": "Counts demand data read requests that miss t=
he L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -364,7 +422,7 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_L3_MISS_DEM=
AND_DATA_RD",
-        "PublicDescription": "Cycles with at least 1 Demand Data Read requ=
ests who miss L3 cache in the superQ.",
+        "PublicDescription": "Cycles with at least 1 Demand Data Read requ=
ests who miss L3 cache in the superQ. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -374,7 +432,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD"=
,
-        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache.",
+        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json b/t=
ools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
index 20c52630127e..0088be169f9b 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
@@ -75,7 +75,7 @@
         "MetricExpr": "tma_core_bound",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_allocation_restriction",
-        "MetricThreshold": "(tma_allocation_restriction >0.10) & ((tma_cor=
e_bound >0.10) & ((tma_backend_bound >0.10)))",
+        "MetricThreshold": "tma_allocation_restriction > 0.1 & (tma_core_b=
ound > 0.1 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -85,7 +85,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALL_P@ / (6 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
-        "MetricThreshold": "(tma_backend_bound >0.10)",
+        "MetricThreshold": "tma_backend_bound > 0.1",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend due to backend stalls. Note that uops must=
 be available for consumption in order for this event to count. If a uop is=
 not available (IQ is empty), this event will not count",
         "ScaleUnit": "100%",
@@ -97,7 +97,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.ALL_P@ / (6 * cpu_=
atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
-        "MetricThreshold": "(tma_bad_speculation >0.15)",
+        "MetricThreshold": "tma_bad_speculation > 0.15",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
         "ScaleUnit": "100%",
@@ -108,7 +108,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_DETECT@ / (6 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_detect",
-        "MetricThreshold": "(tma_branch_detect >0.05) & ((tma_ifetch_laten=
cy >0.15) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_branch_detect > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
         "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s.",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -118,7 +118,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ / (6 *=
 cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_branch_mispredicts",
-        "MetricThreshold": "(tma_branch_mispredicts >0.05) & ((tma_bad_spe=
culation >0.15))",
+        "MetricThreshold": "tma_branch_mispredicts > 0.05 & tma_bad_specul=
ation > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -128,7 +128,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_RESTEER@ / (6 * cp=
u_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_resteer",
-        "MetricThreshold": "(tma_branch_resteer >0.05) & ((tma_ifetch_late=
ncy >0.15) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_branch_resteer > 0.05 & (tma_ifetch_latenc=
y > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -137,7 +137,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.CISC@ / (6 * cpu_atom@CPU=
_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_cisc",
-        "MetricThreshold": "(tma_cisc >0.05) & ((tma_ifetch_bandwidth >0.1=
0) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_cisc > 0.05 & (tma_ifetch_bandwidth > 0.1 =
& tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -146,7 +146,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / (6 =
* cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_core_bound",
-        "MetricThreshold": "(tma_core_bound >0.10) & ((tma_backend_bound >=
0.10))",
+        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.1=
",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -156,7 +156,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.DECODE@ / (6 * cpu_atom@C=
PU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_decode",
-        "MetricThreshold": "(tma_decode >0.05) & ((tma_ifetch_bandwidth >0=
.10) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_decode > 0.05 & (tma_ifetch_bandwidth > 0.=
1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -165,7 +165,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ / (6 * c=
pu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_fast_nuke",
-        "MetricThreshold": "(tma_fast_nuke >0.05) & ((tma_machine_clears >=
0.05) & ((tma_bad_speculation >0.15)))",
+        "MetricThreshold": "tma_fast_nuke > 0.05 & (tma_machine_clears > 0=
.05 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -175,7 +175,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ALL_P@ / (6 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
-        "MetricThreshold": "(tma_frontend_bound >0.20)",
+        "MetricThreshold": "tma_frontend_bound > 0.2",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -185,7 +185,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ / (6 * cpu_atom@C=
PU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "(tma_icache_misses >0.05) & ((tma_ifetch_laten=
cy >0.15) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -194,7 +194,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / (6 =
* cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_ifetch_bandwidth",
-        "MetricThreshold": "(tma_ifetch_bandwidth >0.10) & ((tma_frontend_=
bound >0.20))",
+        "MetricThreshold": "tma_ifetch_bandwidth > 0.1 & tma_frontend_boun=
d > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -204,7 +204,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / (6 * =
cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_ifetch_latency",
-        "MetricThreshold": "(tma_ifetch_latency >0.15) & ((tma_frontend_bo=
und >0.20))",
+        "MetricThreshold": "tma_ifetch_latency > 0.15 & tma_frontend_bound=
 > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -564,7 +564,7 @@
         "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
         "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE_P@ / cpu_atom@CPU_CL=
K_UNHALTED.CORE@",
         "MetricName": "tma_info_system_mux",
-        "MetricThreshold": "((tma_info_system_mux > 1.1)|(tma_info_system_=
mux < 0.9))",
+        "MetricThreshold": "tma_info_system_mux > 1.1 | tma_info_system_mu=
x < 0.9",
         "Unit": "cpu_atom"
     },
     {
@@ -603,7 +603,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ITLB_MISS@ / (6 * cpu_ato=
m@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "(tma_itlb_misses >0.05) & ((tma_ifetch_latency=
 >0.15) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_ifetch_latency >=
 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -612,7 +612,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS@ / =
(6 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_machine_clears",
-        "MetricThreshold": "(tma_machine_clears >0.05) & ((tma_bad_specula=
tion >0.15))",
+        "MetricThreshold": "tma_machine_clears > 0.05 & tma_bad_speculatio=
n > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -622,7 +622,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.MEM_SCHEDULER@ / (6 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_mem_scheduler",
-        "MetricThreshold": "(tma_mem_scheduler >0.10) & ((tma_resource_bou=
nd >0.20) & ((tma_backend_bound >0.10)))",
+        "MetricThreshold": "tma_mem_scheduler > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -631,7 +631,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER@ / (6 *=
 cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_non_mem_scheduler",
-        "MetricThreshold": "(tma_non_mem_scheduler >0.10) & ((tma_resource=
_bound >0.20) & ((tma_backend_bound >0.10)))",
+        "MetricThreshold": "tma_non_mem_scheduler > 0.1 & (tma_resource_bo=
und > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -640,7 +640,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.NUKE@ / (6 * cpu_a=
tom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_nuke",
-        "MetricThreshold": "(tma_nuke >0.05) & ((tma_machine_clears >0.05)=
 & ((tma_bad_speculation >0.15)))",
+        "MetricThreshold": "tma_nuke > 0.05 & (tma_machine_clears > 0.05 &=
 tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -649,7 +649,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.OTHER@ / (6 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_other_fb",
-        "MetricThreshold": "(tma_other_fb >0.05) & ((tma_ifetch_bandwidth =
>0.10) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_other_fb > 0.05 & (tma_ifetch_bandwidth > =
0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -658,7 +658,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.PREDECODE@ / (6 * cpu_ato=
m@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_predecode",
-        "MetricThreshold": "(tma_predecode >0.05) & ((tma_ifetch_bandwidth=
 >0.10) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_predecode > 0.05 & (tma_ifetch_bandwidth >=
 0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -667,7 +667,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REGISTER@ / (6 * cpu_atom=
@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_register",
-        "MetricThreshold": "(tma_register >0.10) & ((tma_resource_bound >0=
.20) & ((tma_backend_bound >0.10)))",
+        "MetricThreshold": "tma_register > 0.1 & (tma_resource_bound > 0.2=
 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -676,7 +676,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REORDER_BUFFER@ / (6 * cp=
u_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_reorder_buffer",
-        "MetricThreshold": "(tma_reorder_buffer >0.10) & ((tma_resource_bo=
und >0.20) & ((tma_backend_bound >0.10)))",
+        "MetricThreshold": "tma_reorder_buffer > 0.1 & (tma_resource_bound=
 > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -685,7 +685,7 @@
         "MetricExpr": "tma_backend_bound - tma_core_bound",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_resource_bound",
-        "MetricThreshold": "(tma_resource_bound >0.20) & ((tma_backend_bou=
nd >0.10))",
+        "MetricThreshold": "tma_resource_bound > 0.2 & tma_backend_bound >=
 0.1",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -696,7 +696,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_RETIRING.ALL_P@ / (6 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
-        "MetricThreshold": "(tma_retiring >0.75)",
+        "MetricThreshold": "tma_retiring > 0.75",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -706,7 +706,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.SERIALIZATION@ / (6 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_serialization",
-        "MetricThreshold": "(tma_serialization >0.10) & ((tma_resource_bou=
nd >0.20) & ((tma_backend_bound >0.10)))",
+        "MetricThreshold": "tma_serialization > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -718,7 +718,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
         "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ + cpu_core@UOPS_D=
ISPATCHED.PORT_1@ + cpu_core@UOPS_DISPATCHED.PORT_5_11@ + cpu_core@UOPS_DIS=
PATCHED.PORT_6@) / (5 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
@@ -731,13 +731,13 @@
         "MetricExpr": "78 * cpu_core@ASSISTS.ANY@ / tma_info_thread_slots"=
,
         "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequence=
r_group",
         "MetricName": "tma_assists",
-        "MetricThreshold": "tma_assists > 0.1 & tma_microcode_sequencer > =
0.05 & tma_heavy_operations > 0.1",
+        "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
         "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists.",
         "MetricExpr": "63 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_threa=
d_slots",
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_avx_assists",
@@ -748,7 +748,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
+        "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
         "MetricGroup": "BvOB;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
@@ -765,13 +765,13 @@
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "MetricgroupNoGroup": "TopdownL1;Default",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
-        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_icache_misses + tma_itlb_misses =
+ tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches)",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
         "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
         "MetricName": "tma_bottleneck_big_code",
         "MetricThreshold": "tma_bottleneck_big_code > 20",
@@ -788,16 +788,16 @@
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dr=
am_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_store_fwd_blk + tm=
a_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_fb_full)=
))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_l=
atency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)=
))",
         "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
         "MetricName": "tma_bottleneck_cache_memory_bandwidth",
         "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
-        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_mem_b=
andwidth, tma_sq_full",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + =
tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_l1_=
latency_dependency / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_de=
pendency + tma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_=
bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_d=
ram_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_st=
ore_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_load=
s + tma_fb_full)) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tma_=
l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_split_l=
oads / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_dependency + tma=
_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_bound * (tma_s=
tore_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_split_stores / (tma_store_latency + tma_false_sha=
ring + tma_split_stores + tma_streaming_stores + tma_dtlb_store)) + tma_mem=
ory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound =
+ tma_dram_bound + tma_store_bound)) * (tma_store_latency / (tma_store_late=
ncy + tma_false_sharing + tma_split_stores + tma_streaming_stores + tma_dtl=
b_store)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound =
+ tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_l1_=
latency_dependency / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependen=
cy + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_=
bound * (tma_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma=
_l3_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_fb=
_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tm=
a_store_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tm=
a_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_split_l=
oads / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_=
latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_s=
tore_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_split_stores / (tma_dtlb_store + tma_false_sharin=
g + tma_split_stores + tma_store_latency + tma_streaming_stores)) + tma_mem=
ory_bound * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_boun=
d + tma_l3_bound + tma_store_bound)) * (tma_store_latency / (tma_dtlb_store=
 + tma_false_sharing + tma_split_stores + tma_store_latency + tma_streaming=
_stores)))",
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_bottleneck_cache_memory_latency",
         "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
@@ -806,16 +806,16 @@
     },
     {
         "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
-        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_serializing_operation + tma_ports_utilization) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_serializing_operation + tma_ports_=
utilization)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
+        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_ports_utilization + tma_serializing_operation) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_ports_utilization + tma_serializin=
g_operation)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
         "MetricGroup": "BvCB;Cor;tma_issueComp",
         "MetricName": "tma_bottleneck_compute_bound_est",
         "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
-        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy",
+        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: ",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
-        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses + t=
ma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) - (1 - c=
pu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D=
0x1@) * (tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_=
clears_resteers + tma_mispredicts_resteers * tma_other_mispredicts / tma_br=
anch_mispredicts) / (tma_mispredicts_resteers + tma_clears_resteers + tma_u=
nknown_branches)) / (tma_icache_misses + tma_itlb_misses + tma_branch_reste=
ers + tma_ms_switches + tma_lcp + tma_dsb_switches) + tma_fetch_bandwidth *=
 tma_ms / (tma_mite + tma_dsb + tma_lsd + tma_ms))) - tma_bottleneck_big_co=
de",
+        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - (1 - c=
pu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D=
1@) * (tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_cl=
ears_resteers + tma_mispredicts_resteers * tma_other_mispredicts / tma_bran=
ch_mispredicts) / (tma_clears_resteers + tma_mispredicts_resteers + tma_unk=
nown_branches)) / (tma_branch_resteers + tma_dsb_switches + tma_icache_miss=
es + tma_itlb_misses + tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * t=
ma_ms / (tma_dsb + tma_lsd + tma_mite + tma_ms))) - tma_bottleneck_big_code=
",
         "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
         "MetricName": "tma_bottleneck_instruction_fetch_bw",
         "MetricThreshold": "tma_bottleneck_instruction_fetch_bw > 20",
@@ -823,7 +823,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
-        "MetricExpr": "100 * ((1 - cpu_core@INST_RETIRED.REP_ITERATION@ / =
cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D0x1@) * (tma_fetch_latency * (tma_ms_s=
witches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_rest=
eers * tma_other_mispredicts / tma_branch_mispredicts) / (tma_mispredicts_r=
esteers + tma_clears_resteers + tma_unknown_branches)) / (tma_icache_misses=
 + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_=
dsb_switches) + tma_fetch_bandwidth * tma_ms / (tma_mite + tma_dsb + tma_ls=
d + tma_ms)) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_b=
ranch_mispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other=
_nukes / tma_other_nukes + tma_core_bound * (tma_serializing_operation + cp=
u_core@RS.EMPTY_RESOURCE@ / tma_info_thread_clks * tma_ports_utilized_0) / =
(tma_divider + tma_serializing_operation + tma_ports_utilization) + tma_mic=
rocode_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) * =
(tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
+        "MetricExpr": "100 * ((1 - cpu_core@INST_RETIRED.REP_ITERATION@ / =
cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1@) * (tma_fetch_latency * (tma_ms_swi=
tches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_restee=
rs * tma_other_mispredicts / tma_branch_mispredicts) / (tma_clears_resteers=
 + tma_mispredicts_resteers + tma_unknown_branches)) / (tma_branch_resteers=
 + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_m=
s_switches) + tma_fetch_bandwidth * tma_ms / (tma_dsb + tma_lsd + tma_mite =
+ tma_ms)) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_bra=
nch_mispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other_n=
ukes / tma_other_nukes + tma_core_bound * (tma_serializing_operation + cpu_=
core@RS.EMPTY_RESOURCE@ / tma_info_thread_clks * tma_ports_utilized_0) / (t=
ma_divider + tma_ports_utilization + tma_serializing_operation) + tma_micro=
code_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) * (t=
ma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
         "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
         "MetricName": "tma_bottleneck_irregular_overhead",
         "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
@@ -832,7 +832,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (=
tma_dtlb_load / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_depende=
ncy + tma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_bound=
 * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dra=
m_bound + tma_store_bound)) * (tma_dtlb_store / (tma_store_latency + tma_fa=
lse_sharing + tma_split_stores + tma_streaming_stores + tma_dtlb_store)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (=
tma_dtlb_load / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + =
tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound=
 * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l=
3_bound + tma_store_bound)) * (tma_dtlb_store / (tma_dtlb_store + tma_false=
_sharing + tma_split_stores + tma_store_latency + tma_streaming_stores)))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
@@ -841,16 +841,16 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * (t=
ma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma_d=
ata_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * =
tma_false_sharing / (tma_store_latency + tma_false_sharing + tma_split_stor=
es + tma_streaming_stores + tma_dtlb_store - tma_store_latency)) + tma_mach=
ine_clears * (1 - tma_other_nukes / tma_other_nukes))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (t=
ma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma_d=
ata_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_stores =
+ tma_store_latency + tma_streaming_stores - tma_store_latency)) + tma_mach=
ine_clears * (1 - tma_other_nukes / tma_other_nukes))",
         "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
         "MetricName": "tma_bottleneck_memory_synchronization",
         "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
-        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_contested_accesses, tma_data_sharing, tma_false_s=
haring, tma_machine_clears",
+        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_contested_accesses, tma_data_sharing, tma_false_s=
haring, tma_machine_clears, tma_remote_cache",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses=
 + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches))",
+        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switc=
hes + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
         "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
         "MetricName": "tma_bottleneck_mispredictions",
         "MetricThreshold": "tma_bottleneck_mispredictions > 20",
@@ -863,11 +863,11 @@
         "MetricGroup": "BvOB;Cor;Offcore",
         "MetricName": "tma_bottleneck_other_bottlenecks",
         "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
-        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls",
+        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls.",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead",
+        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead.",
         "MetricExpr": "100 * (tma_retiring - (cpu_core@BR_INST_RETIRED.ALL=
_BRANCHES@ + 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRE=
D.NOP@) / tma_info_thread_slots - tma_microcode_sequencer / (tma_few_uops_i=
nstructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_seque=
ncer) * tma_heavy_operations)",
         "MetricGroup": "BvUW;Ret",
         "MetricName": "tma_bottleneck_useful_work",
@@ -876,7 +876,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
-        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * sl=
ots",
+        "MetricExpr": "cpu_core@topdown\\-br\\-mispredict@ / (cpu_core@top=
down\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-re=
tiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
@@ -890,26 +890,26 @@
         "MetricExpr": "cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_=
thread_clks + tma_unknown_branches",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
         "MetricName": "tma_branch_resteers",
-        "MetricThreshold": "tma_branch_resteers > 0.05 & tma_fetch_latency=
 > 0.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES. Related metrics: tma_l3_hit_latency, tma_store_latency",
+        "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings)",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings).",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C01@ / tma_info_thread_cl=
ks",
         "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
         "MetricName": "tma_c01_wait",
-        "MetricThreshold": "tma_c01_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_c01_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings)",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings).",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C02@ / tma_info_thread_cl=
ks",
         "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
         "MetricName": "tma_c02_wait",
-        "MetricThreshold": "tma_c02_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_c02_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -918,7 +918,7 @@
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.1 & tma_microcode_sequencer > 0.0=
5 & tma_heavy_operations > 0.1",
+        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequencer > 0.=
05 & tma_heavy_operations > 0.1)",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources. Sample with: FRONTEND_RETIRE=
D.MS_FLOWS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -928,90 +928,91 @@
         "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation) =
* cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
-        "MetricThreshold": "tma_clears_resteers > 0.05 & tma_branch_restee=
rs > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears. Sam=
ple with: INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound, tma=
_machine_clears, tma_microcode_sequencer, tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that hit in the L2 cache",
-        "MetricExpr": "max(0, cpu_core@FRONTEND_RETIRED.L1I_MISS@ * cpu_co=
re@frontend_retired.l1i_miss@R / tma_info_thread_clks - tma_code_l2_miss)",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that hit in the L2 cache.",
+        "MetricExpr": "max(0, cpu_core@FRONTEND_RETIRED.L1I_MISS@ * cpu_co=
re@FRONTEND_RETIRED.L1I_MISS@R / tma_info_thread_clks - tma_code_l2_miss)",
         "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
         "MetricName": "tma_code_l2_hit",
-        "MetricThreshold": "tma_code_l2_hit > 0.05 & tma_icache_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_code_l2_hit > 0.05 & (tma_icache_misses > =
0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that miss in the L2 cache",
-        "MetricExpr": "cpu_core@FRONTEND_RETIRED.L2_MISS@ * cpu_core@front=
end_retired.l2_miss@R / tma_info_thread_clks",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that miss in the L2 cache."=
,
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.L2_MISS@ * cpu_core@FRONT=
END_RETIRED.L2_MISS@R / tma_info_thread_clks",
         "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
         "MetricName": "tma_code_l2_miss",
-        "MetricThreshold": "tma_code_l2_miss > 0.05 & tma_icache_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_code_l2_miss > 0.05 & (tma_icache_misses >=
 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) ITLB was missed by instructions fetches, th=
at later on hit in second-level TLB (STLB)",
-        "MetricExpr": "max(0, cpu_core@FRONTEND_RETIRED.ITLB_MISS@ * cpu_c=
ore@frontend_retired.itlb_miss@R / tma_info_thread_clks - tma_code_stlb_mis=
s)",
+        "MetricExpr": "max(0, cpu_core@FRONTEND_RETIRED.ITLB_MISS@ * cpu_c=
ore@FRONTEND_RETIRED.ITLB_MISS@R / tma_info_thread_clks - tma_code_stlb_mis=
s)",
         "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
         "MetricName": "tma_code_stlb_hit",
-        "MetricThreshold": "tma_code_stlb_hit > 0.05 & tma_itlb_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_code_stlb_hit > 0.05 & (tma_itlb_misses > =
0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by instruction fetches, perfor=
ming a hardware page walk",
-        "MetricExpr": "cpu_core@FRONTEND_RETIRED.STLB_MISS@ * cpu_core@fro=
ntend_retired.stlb_miss@R / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.STLB_MISS@ * cpu_core@FRO=
NTEND_RETIRED.STLB_MISS@R / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
         "MetricName": "tma_code_stlb_miss",
-        "MetricThreshold": "tma_code_stlb_miss > 0.05 & tma_itlb_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_code_stlb_miss > 0.05 & (tma_itlb_misses >=
 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for (instruction) code accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for (instruction) code accesses.",
         "MetricExpr": "cpu_core@ITLB_MISSES.WALK_ACTIVE@ / tma_info_thread=
_clks * cpu_core@ITLB_MISSES.WALK_COMPLETED_2M_4M@ / (cpu_core@ITLB_MISSES.=
WALK_COMPLETED_4K@ + cpu_core@ITLB_MISSES.WALK_COMPLETED_2M_4M@)",
         "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
         "MetricName": "tma_code_stlb_miss_2m",
-        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & (tma_code_stlb_=
miss > 0.05 & (tma_itlb_misses > 0.05 & (tma_fetch_latency > 0.1 & tma_fron=
tend_bound > 0.15)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 (instruction) code accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 (instruction) code accesses.",
         "MetricExpr": "cpu_core@ITLB_MISSES.WALK_ACTIVE@ / tma_info_thread=
_clks * cpu_core@ITLB_MISSES.WALK_COMPLETED_4K@ / (cpu_core@ITLB_MISSES.WAL=
K_COMPLETED_4K@ + cpu_core@ITLB_MISSES.WALK_COMPLETED_2M_4M@)",
         "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
         "MetricName": "tma_code_stlb_miss_4k",
-        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & (tma_code_stlb_=
miss > 0.05 & (tma_itlb_misses > 0.05 & (tma_fetch_latency > 0.1 & tma_fron=
tend_bound > 0.15)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by non-taken conditional bran=
ches",
-        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_NTAKEN_COST@ * cpu_co=
re@br_misp_retired.cond_ntaken_cost@R / tma_info_thread_clks",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by non-taken conditional bran=
ches.",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_NTAKEN_COST@ * cpu_co=
re@BR_MISP_RETIRED.COND_NTAKEN_COST@R / tma_info_thread_clks",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_cond_nt_mispredicts",
-        "MetricThreshold": "tma_cond_nt_mispredicts > 0.05 & tma_branch_mi=
spredicts > 0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_cond_nt_mispredicts > 0.05 & (tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to misprediction by taken conditional branches",
-        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_TAKEN_COST@ * cpu_cor=
e@br_misp_retired.cond_taken_cost@R / tma_info_thread_clks",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to misprediction by taken conditional branches.",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_TAKEN_COST@ * cpu_cor=
e@BR_MISP_RETIRED.COND_TAKEN_COST@R / tma_info_thread_clks",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_cond_tk_mispredicts",
-        "MetricThreshold": "tma_cond_tk_mispredicts > 0.05 & tma_branch_mi=
spredicts > 0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_cond_tk_mispredicts > 0.05 & (tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricExpr": "((min(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@ *=
 cpu_core@mem_load_l3_hit_retired.xsnp_miss@R, cpu_core@MEM_LOAD_L3_HIT_RET=
IRED.XSNP_MISS@ * (27 * tma_info_system_core_frequency) - 3 * tma_info_syst=
em_core_frequency) if 0 < cpu_core@mem_load_l3_hit_retired.xsnp_miss@R else=
 cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@ * (27 * tma_info_system_core_f=
requency) - 3 * tma_info_system_core_frequency) + (min(cpu_core@MEM_LOAD_L3=
_HIT_RETIRED.XSNP_FWD@ * cpu_core@mem_load_l3_hit_retired.xsnp_fwd@R, cpu_c=
ore@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (28 * tma_info_system_core_frequenc=
y) - 3 * tma_info_system_core_frequency) if 0 < cpu_core@mem_load_l3_hit_re=
tired.xsnp_fwd@R else cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (28 * tm=
a_info_system_core_frequency) - 3 * tma_info_system_core_frequency) * (cpu_=
core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DEMAND_DATA_RD.L=
3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@)=
)) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_=
MISS@ / 2) / tma_info_thread_clks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@ * min(=
cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@R, 24 * tma_info_system_core_fre=
quency) + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * min(cpu_core@MEM_LOA=
D_L3_HIT_RETIRED.XSNP_FWD@R, 25 * tma_info_system_core_frequency) * (cpu_co=
re@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DEMAND_DATA_RD.L3_=
HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@)))=
 * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MI=
SS@ / 2) / tma_info_thread_clks",
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
-        "MetricThreshold": "tma_contested_accesses > 0.05 & tma_l3_bound >=
 0.05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD, MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related =
metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_false=
_sharing, tma_machine_clears",
+        "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related m=
etrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_false_=
sharing, tma_machine_clears, tma_remote_cache",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1022,26 +1023,27 @@
         "MetricName": "tma_core_bound",
         "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2=
",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
-        "MetricExpr": "((min(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@=
 * cpu_core@mem_load_l3_hit_retired.xsnp_no_fwd@R, cpu_core@MEM_LOAD_L3_HIT=
_RETIRED.XSNP_NO_FWD@ * (27 * tma_info_system_core_frequency) - 3 * tma_inf=
o_system_core_frequency) if 0 < cpu_core@mem_load_l3_hit_retired.xsnp_no_fw=
d@R else cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@ * (27 * tma_info_sys=
tem_core_frequency) - 3 * tma_info_system_core_frequency) + (min(cpu_core@M=
EM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * cpu_core@mem_load_l3_hit_retired.xsnp_fw=
d@R, cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (27 * tma_info_system_cor=
e_frequency) - 3 * tma_info_system_core_frequency) if 0 < cpu_core@mem_load=
_l3_hit_retired.xsnp_fwd@R else cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ =
* (27 * tma_info_system_core_frequency) - 3 * tma_info_system_core_frequenc=
y) * (1 - cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DE=
MAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_=
HIT_WITH_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LO=
AD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@ * mi=
n(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@R, 24 * tma_info_system_core=
_frequency) + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * min(cpu_core@MEM=
_LOAD_L3_HIT_RETIRED.XSNP_FWD@R, 24 * tma_info_system_core_frequency) * (1 =
- cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DEMAND_DAT=
A_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH=
_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIR=
ED.L1_MISS@ / 2) / tma_info_thread_clks",
         "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issu=
eSyncxn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
-        "MetricThreshold": "tma_data_sharing > 0.05 & tma_l3_bound > 0.05 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_synch=
ronization, tma_contested_accesses, tma_false_sharing, tma_machine_clears",
+        "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_synch=
ronization, tma_contested_accesses, tma_false_sharing, tma_machine_clears, =
tma_remote_cache",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D0x1@ - =
cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D0x2@) / tma_info_core_core_clks =
/ 2",
+        "MetricExpr": "(cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cp=
u_core@INST_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2"=
,
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
         "MetricName": "tma_decoder0_alone",
-        "MetricThreshold": "tma_decoder0_alone > 0.1 & tma_mite > 0.1 & tm=
a_fetch_bandwidth > 0.2",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & t=
ma_fetch_bandwidth > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -1051,7 +1053,7 @@
         "MetricExpr": "cpu_core@ARITH.DIV_ACTIVE@ / tma_info_thread_clks",
         "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
-        "MetricThreshold": "tma_divider > 0.2 & tma_core_bound > 0.1 & tma=
_backend_bound > 0.2",
+        "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIV_ACTIVE",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -1061,7 +1063,7 @@
         "MetricExpr": "cpu_core@MEMORY_ACTIVITY.STALLS_L3_MISS@ / tma_info=
_thread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
-        "MetricThreshold": "tma_dram_bound > 0.1 & tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -1072,7 +1074,7 @@
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
         "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1081,28 +1083,28 @@
         "MetricExpr": "cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES@ / tma_in=
fo_thread_clks",
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
-        "MetricThreshold": "tma_dsb_switches > 0.05 & tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwi=
dth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_inf=
o_inst_mix_iptb, tma_lcp",
+        "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_ban=
dwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "(min(cpu_core@MEM_INST_RETIRED.STLB_HIT_LOADS@ * cp=
u_core@mem_inst_retired.stlb_hit_loads@R, cpu_core@MEM_INST_RETIRED.STLB_HI=
T_LOADS@ * 7) if 0 < cpu_core@mem_inst_retired.stlb_hit_loads@R else cpu_co=
re@MEM_INST_RETIRED.STLB_HIT_LOADS@ * 7) / tma_info_thread_clks + tma_load_=
stlb_miss",
+        "MetricExpr": "cpu_core@MEM_INST_RETIRED.STLB_HIT_LOADS@ * min(cpu=
_core@MEM_INST_RETIRED.STLB_HIT_LOADS@R, 7) / tma_info_thread_clks + tma_lo=
ad_stlb_miss",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_l1_bound_group",
         "MetricName": "tma_dtlb_load",
-        "MetricThreshold": "tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma=
_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS. Related metrics: tma_=
bottleneck_memory_data_tlbs, tma_dtlb_store",
+        "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_bottleneck_memory_data_tlbs, tma_dtlb_store",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(min(cpu_core@MEM_INST_RETIRED.STLB_HIT_STORES@ * c=
pu_core@mem_inst_retired.stlb_hit_stores@R, cpu_core@MEM_INST_RETIRED.STLB_=
HIT_STORES@ * 7) if 0 < cpu_core@mem_inst_retired.stlb_hit_stores@R else cp=
u_core@MEM_INST_RETIRED.STLB_HIT_STORES@ * 7) / tma_info_thread_clks + tma_=
store_stlb_miss",
+        "MetricExpr": "cpu_core@MEM_INST_RETIRED.STLB_HIT_STORES@ * min(cp=
u_core@MEM_INST_RETIRED.STLB_HIT_STORES@R, 7) / tma_info_thread_clks + tma_=
store_stlb_miss",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_store_bound_group",
         "MetricName": "tma_dtlb_store",
-        "MetricThreshold": "tma_dtlb_store > 0.05 & tma_store_bound > 0.2 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES. Related metrics: tma_bottleneck_mem=
ory_data_tlbs, tma_dtlb_load",
+        "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_bottleneck_=
memory_data_tlbs, tma_dtlb_load",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1111,8 +1113,8 @@
         "MetricExpr": "28 * tma_info_system_core_frequency * cpu_core@OCR.=
DEMAND_RFO.L3_HIT.SNOOP_HITM@ / tma_info_thread_clks",
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
-        "MetricThreshold": "tma_false_sharing > 0.05 & tma_store_bound > 0=
.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_bottleneck_memory_synchronization, t=
ma_contested_accesses, tma_data_sharing, tma_machine_clears",
+        "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_bottleneck_memory_synchronization, t=
ma_contested_accesses, tma_data_sharing, tma_machine_clears, tma_remote_cac=
he",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1122,7 +1124,7 @@
         "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_bottleneck_cache_memory_bandwidth, =
tma_mem_bandwidth, tma_sq_full, tma_store_latency, tma_streaming_stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_bottleneck_cache_memory_bandwidth, =
tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store_late=
ncy, tma_streaming_stores",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1133,18 +1135,18 @@
         "MetricName": "tma_fetch_bandwidth",
         "MetricThreshold": "tma_fetch_bandwidth > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1, FRONTEND_RETIRED.LATE=
NCY_GE_1, FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switches,=
 tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_=
frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1;FRONTEND_RETIRED.LATEN=
CY_GE_1;FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switches, t=
ma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_fr=
ontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - cpu_core@I=
NT_MISC.UOP_DROPPING@ / tma_info_thread_slots",
+        "MetricExpr": "cpu_core@topdown\\-fetch\\-lat@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / t=
ma_info_thread_slots",
         "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16, FRONTEND_RETIRED.LATENCY_GE_8",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1164,7 +1166,7 @@
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
         "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > 0.=
6",
-        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1174,16 +1176,16 @@
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_fp_assists",
         "MetricThreshold": "tma_fp_assists > 0.1",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals)",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals).",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the Floating-Point Divider unit was active",
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Floating-Point Divider unit was active.",
         "MetricExpr": "cpu_core@ARITH.FPDIV_ACTIVE@ / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
         "MetricName": "tma_fp_divider",
-        "MetricThreshold": "tma_fp_divider > 0.2 & tma_divider > 0.2 & tma=
_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_fp_divider > 0.2 & (tma_divider > 0.2 & (t=
ma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1192,8 +1194,8 @@
         "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ / (tma_retir=
ing * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
-        "MetricThreshold": "tma_fp_scalar > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma=
_port_1, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vector_2=
56b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1202,8 +1204,8 @@
         "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.VECTOR@ / (tma_retir=
ing * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
-        "MetricThreshold": "tma_fp_vector > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized=
_2",
+        "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1212,8 +1214,8 @@
         "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
-        "MetricThreshold": "tma_fp_vector_128b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_po=
rts_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1222,41 +1224,41 @@
         "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
-        "MetricThreshold": "tma_fp_vector_256b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_int_vector_128b, tma_int_vector_256b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_fp_vector_512b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_po=
rts_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - cpu_core@IN=
T_MISC.UOP_DROPPING@ / tma_info_thread_slots",
+        "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / tm=
a_info_thread_slots",
         "MetricGroup": "BvFB;BvIO;Default;PGO;TmaL1;TopdownL1;tma_L1_group=
",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "MetricgroupNoGroup": "TopdownL1;Default",
-        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4",
+        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4_PS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions , where one uop can represent mul=
tiple contiguous instructions",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
         "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.MACRO_=
FUSED@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_fused_instructions",
         "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions , where one uop can represent mu=
ltiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of l=
egacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Oth=
er_Light_Ops in MTL!)}",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of =
legacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Ot=
her_Light_Ops in MTL!)}",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations , instructions that require =
two or more uops or micro-coded sequences",
-        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
+        "MetricExpr": "cpu_core@topdown\\-heavy\\-ops@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations , instructions that require=
 two or more uops or micro-coded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.([ICL+] Note this may overcount=
 due to approximation using indirect events; [ADL+]). Sample with: UOPS_RET=
IRED.HEAVY",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences.([ICL+] Note this may overcoun=
t due to approximation using indirect events; [ADL+]). Sample with: UOPS_RE=
TIRED.HEAVY",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1265,26 +1267,26 @@
         "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / tma_info_thread_clks=
",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS, FRONTEND_RETIRED.L1I_MISS",
+        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect CALL instructions=
",
-        "MetricExpr": "cpu_core@BR_MISP_RETIRED.INDIRECT_CALL_COST@ * cpu_=
core@br_misp_retired.indirect_call_cost@R / tma_info_thread_clks",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect CALL instructions=
.",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.INDIRECT_CALL_COST@ * cpu_=
core@BR_MISP_RETIRED.INDIRECT_CALL_COST@R / tma_info_thread_clks",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_ind_call_mispredicts",
-        "MetricThreshold": "tma_ind_call_mispredicts > 0.05 & tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_ind_call_mispredicts > 0.05 & (tma_branch_=
mispredicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect JMP instructions"=
,
-        "MetricExpr": "max((cpu_core@BR_MISP_RETIRED.INDIRECT_COST@ * cpu_=
core@br_misp_retired.indirect_cost@R - cpu_core@BR_MISP_RETIRED.INDIRECT_CA=
LL_COST@ * cpu_core@br_misp_retired.indirect_call_cost@R) / tma_info_thread=
_clks, 0)",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect JMP instructions.=
",
+        "MetricExpr": "max((cpu_core@BR_MISP_RETIRED.INDIRECT_COST@ * cpu_=
core@BR_MISP_RETIRED.INDIRECT_COST@R - cpu_core@BR_MISP_RETIRED.INDIRECT_CA=
LL_COST@ * cpu_core@BR_MISP_RETIRED.INDIRECT_CALL_COST@R) / tma_info_thread=
_clks, 0)",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_ind_jump_mispredicts",
-        "MetricThreshold": "tma_ind_jump_mispredicts > 0.05 & tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_ind_jump_mispredicts > 0.05 & (tma_branch_=
mispredicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1297,7 +1299,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.COND_NTAKEN@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
@@ -1305,7 +1307,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional taken branches (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.COND_TAKEN@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
@@ -1313,15 +1315,15 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.INDIRECT@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
-        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1000",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per retired Mispredicts for retu=
rn branches (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per retired Mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.RET@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_ret",
@@ -1353,7 +1355,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) hits -=
 subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_latency + tma_fetch_bandwidth)) * (tma_dsb / (tma_mite + tma_dsb=
 + tma_lsd + tma_ms)))",
+        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_bandwidth + tma_fetch_latency)) * (tma_dsb / (tma_dsb + tma_lsd =
+ tma_mite + tma_ms)))",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_bandwidth > 10",
@@ -1362,7 +1364,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + t=
ma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_mite / (tma_mite + t=
ma_dsb + tma_lsd + tma_ms))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_lsd + tma_mite + tma_ms))",
         "MetricGroup": "DSBmiss;Fed;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_misses",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
@@ -1371,10 +1373,11 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + =
tma_lcp + tma_dsb_switches))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
         "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
+        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: ",
         "Unit": "cpu_core"
     },
     {
@@ -1445,12 +1448,12 @@
         "MetricExpr": "(cpu_core@FP_ARITH_DISPATCHED.PORT_0@ + cpu_core@FP=
_ARITH_DISPATCHED.PORT_1@ + cpu_core@FP_ARITH_DISPATCHED.PORT_5@) / (2 * tm=
a_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)",
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n).",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
-        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_EXEC=
UTED.THREAD\\,cmask\\=3D0x1@",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_EXEC=
UTED.THREAD\\,cmask\\=3D1@",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_core_ilp",
         "Unit": "cpu_core"
@@ -1465,15 +1468,15 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
",
-        "MetricExpr": "cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES@ / cpu_co=
re@DSB2MITE_SWITCHES.PENALTY_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
+        "MetricExpr": "cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES@ / cpu_co=
re@DSB2MITE_SWITCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
         "MetricGroup": "DSBmiss",
         "MetricName": "tma_info_frontend_dsb_switch_cost",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to retired DSB misses",
-        "MetricExpr": "cpu_core@FRONTEND_RETIRED.ANY_DSB_MISS@ * cpu_core@=
frontend_retired.any_dsb_miss@R / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.ANY_DSB_MISS@ * cpu_core@=
FRONTEND_RETIRED.ANY_DSB_MISS@R / tma_info_thread_clks",
         "MetricGroup": "DSBmiss;Fed;FetchLat",
         "MetricName": "tma_info_frontend_dsb_switches_ret",
         "MetricThreshold": "tma_info_frontend_dsb_switches_ret > 0.05",
@@ -1481,7 +1484,7 @@
     },
     {
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
-        "MetricExpr": "cpu_core@UOPS_ISSUED.ANY@ / cpu_core@UOPS_ISSUED.AN=
Y\\,cmask\\=3D0x1@",
+        "MetricExpr": "cpu_core@UOPS_ISSUED.ANY@ / cpu_core@UOPS_ISSUED.AN=
Y\\,cmask\\=3D1@",
         "MetricGroup": "Fed;FetchBW",
         "MetricName": "tma_info_frontend_fetch_upc",
         "Unit": "cpu_core"
@@ -1531,7 +1534,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to retired operations that invoke th=
e Microcode Sequencer",
-        "MetricExpr": "cpu_core@FRONTEND_RETIRED.MS_FLOWS@ * cpu_core@fron=
tend_retired.ms_flows@R / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.MS_FLOWS@ * cpu_core@FRON=
TEND_RETIRED.MS_FLOWS@R / tma_info_thread_clks",
         "MetricGroup": "Fed;FetchLat;MicroSeq",
         "MetricName": "tma_info_frontend_ms_latency_ret",
         "MetricThreshold": "tma_info_frontend_ms_latency_ret > 0.05",
@@ -1546,21 +1549,21 @@
     },
     {
         "BriefDescription": "Average number of cycles the front-end was de=
layed due to an Unknown Branch detection",
-        "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / cpu_core=
@INT_MISC.UNKNOWN_BRANCH_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
+        "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / cpu_core=
@INT_MISC.UNKNOWN_BRANCH_CYCLES\\,cmask\\=3D1\\,edge@",
         "MetricGroup": "Fed",
         "MetricName": "tma_info_frontend_unknown_branch_cost",
-        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node",
+        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node.",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to retired branches who got branch a=
ddress clears",
-        "MetricExpr": "cpu_core@FRONTEND_RETIRED.UNKNOWN_BRANCH@ * cpu_cor=
e@frontend_retired.unknown_branch@R / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.UNKNOWN_BRANCH@ * cpu_cor=
e@FRONTEND_RETIRED.UNKNOWN_BRANCH@R / tma_info_thread_clks",
         "MetricGroup": "Fed;FetchLat",
         "MetricName": "tma_info_frontend_unknown_branches_ret",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch",
+        "BriefDescription": "Branch instructions per taken branch.",
         "MetricExpr": "cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ / cpu_core@B=
R_INST_RETIRED.NEAR_TAKEN@",
         "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "tma_info_inst_mix_bptkbranch",
@@ -1580,7 +1583,7 @@
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
         "MetricThreshold": "tma_info_inst_mix_iparith < 10",
-        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW",
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW.",
         "Unit": "cpu_core"
     },
     {
@@ -1589,7 +1592,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx128",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting",
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting.",
         "Unit": "cpu_core"
     },
     {
@@ -1598,7 +1601,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx256",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting",
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting.",
         "Unit": "cpu_core"
     },
     {
@@ -1607,7 +1610,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting.",
         "Unit": "cpu_core"
     },
     {
@@ -1616,7 +1619,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting.",
         "Unit": "cpu_core"
     },
     {
@@ -1679,7 +1682,7 @@
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RETIR=
ED.NEAR_TAKEN@",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
         "MetricName": "tma_info_inst_mix_iptb",
-        "MetricThreshold": "tma_info_inst_mix_iptb < 6 * 2 + 1",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 13",
         "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth=
, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp",
         "Unit": "cpu_core"
     },
@@ -1825,7 +1828,7 @@
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
-        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D0x1@"=
,
+        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
         "MetricGroup": "Memory_BW;Offcore",
         "MetricName": "tma_info_memory_latency_load_l2_mlp",
         "Unit": "cpu_core"
@@ -1883,7 +1886,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to STLB misses by demand loads",
-        "MetricExpr": "cpu_core@MEM_INST_RETIRED.STLB_MISS_LOADS@ * cpu_co=
re@mem_inst_retired.stlb_miss_loads@R / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@MEM_INST_RETIRED.STLB_MISS_LOADS@ * cpu_co=
re@MEM_INST_RETIRED.STLB_MISS_LOADS@R / tma_info_thread_clks",
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "tma_info_memory_tlb_load_stlb_miss_ret",
         "MetricThreshold": "tma_info_memory_tlb_load_stlb_miss_ret > 0.05"=
,
@@ -1906,7 +1909,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to STLB misses by demand stores",
-        "MetricExpr": "cpu_core@MEM_INST_RETIRED.STLB_MISS_STORES@ * cpu_c=
ore@mem_inst_retired.stlb_miss_stores@R / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@MEM_INST_RETIRED.STLB_MISS_STORES@ * cpu_c=
ore@MEM_INST_RETIRED.STLB_MISS_STORES@R / tma_info_thread_clks",
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "tma_info_memory_tlb_store_stlb_miss_ret",
         "MetricThreshold": "tma_info_memory_tlb_store_stlb_miss_ret > 0.05=
",
@@ -1921,7 +1924,7 @@
     },
     {
         "BriefDescription": "",
-        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / (cpu_core@UOPS_EXE=
CUTED.CORE_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D0x1@)",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / (cpu_core@UOPS_EXE=
CUTED.CORE_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute",
         "Unit": "cpu_core"
@@ -1952,20 +1955,20 @@
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@ASSISTS.ANY@"=
,
         "MetricGroup": "MicroSeq;Pipeline;Ret;Retire",
         "MetricName": "tma_info_pipeline_ipassist",
-        "MetricThreshold": "tma_info_pipeline_ipassist < 100000",
+        "MetricThreshold": "tma_info_pipeline_ipassist < 100e3",
         "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired",
-        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D0x1@",
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
-        "MetricExpr": "cpu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D0x1@",
+        "MetricExpr": "cpu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "MicroSeq;Pipeline;Ret",
         "MetricName": "tma_info_pipeline_strings_cycles",
         "MetricThreshold": "tma_info_pipeline_strings_cycles > 0.1",
@@ -2018,23 +2021,22 @@
     },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / BR_INST_RETIRED.FAR_BR=
ANCH:u",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RETIR=
ED.FAR_BRANCH@u",
         "MetricGroup": "Branches;OS",
         "MetricName": "tma_info_system_ipfarbranch",
-        "MetricThreshold": "tma_info_system_ipfarbranch < 1000000",
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD_P@k / cpu_core@INS=
T_RETIRED.ANY_P@k",
         "MetricGroup": "OS",
         "MetricName": "tma_info_system_kernel_cpi",
-        "ScaleUnit": "1per_instr",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / cpu_core@CPU_CLK_UNHA=
LTED.THREAD@",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD_P@k / cpu_core@CPU=
_CLK_UNHALTED.THREAD@",
         "MetricGroup": "OS",
         "MetricName": "tma_info_system_kernel_utilization",
         "MetricThreshold": "tma_info_system_kernel_utilization > 0.05",
@@ -2042,7 +2044,7 @@
     },
     {
         "BriefDescription": "Average number of parallel data read requests=
 to external memory",
-        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / UNC_ARB_DAT_OCCUPANCY.RD=
@thresh\\=3D0x1@",
+        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / UNC_ARB_DAT_OCCUPANCY.RD=
@cmask\\=3D1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
         "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches",
@@ -2093,7 +2095,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active",
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD@",
         "MetricGroup": "Pipeline",
         "MetricName": "tma_info_thread_clks",
@@ -2104,7 +2106,6 @@
         "MetricExpr": "1 / tma_info_thread_ipc",
         "MetricGroup": "Mem;Pipeline",
         "MetricName": "tma_info_thread_cpi",
-        "ScaleUnit": "1per_instr",
         "Unit": "cpu_core"
     },
     {
@@ -2112,7 +2113,7 @@
         "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_ISSU=
ED.ANY@",
         "MetricGroup": "Cor;Pipeline",
         "MetricName": "tma_info_thread_execute_per_issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage.",
         "Unit": "cpu_core"
     },
     {
@@ -2124,14 +2125,14 @@
     },
     {
         "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "slots",
+        "MetricExpr": "cpu_core@TOPDOWN.SLOTS@",
         "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_info_thread_slots",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "(tma_info_thread_slots / (slots / 2) if #SMT_on els=
e 1)",
+        "MetricExpr": "(tma_info_thread_slots / (cpu_core@TOPDOWN.SLOTS@ /=
 2) if #SMT_on else 1)",
         "MetricGroup": "SMT;TmaL1;tma_L1_group",
         "MetricName": "tma_info_thread_slots_utilization",
         "Unit": "cpu_core"
@@ -2149,15 +2150,15 @@
         "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@BR_=
INST_RETIRED.NEAR_TAKEN@",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "tma_info_thread_uptb",
-        "MetricThreshold": "tma_info_thread_uptb < 6 * 1.5",
+        "MetricThreshold": "tma_info_thread_uptb < 9",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the Integer Divider unit was active",
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Integer Divider unit was active.",
         "MetricExpr": "tma_divider - tma_fp_divider",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
         "MetricName": "tma_int_divider",
-        "MetricThreshold": "tma_int_divider > 0.2 & tma_divider > 0.2 & tm=
a_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_int_divider > 0.2 & (tma_divider > 0.2 & (=
tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2167,7 +2168,7 @@
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_int_operations",
         "MetricThreshold": "tma_int_operations > 0.1 & tma_light_operation=
s > 0.6",
-        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain",
+        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2176,8 +2177,8 @@
         "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_128@ + cpu_core@INT_V=
EC_RETIRED.VNNI_128@) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_128b",
-        "MetricThreshold": "tma_int_vector_128b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric represents 128-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_int_vector_256b, tma_port_0, tma_port_1,=
 tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_int_vector_128b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
+        "PublicDescription": "This metric represents 128-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_256b, tma=
_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2186,8 +2187,8 @@
         "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_256@ + cpu_core@INT_V=
EC_RETIRED.MUL_256@ + cpu_core@INT_VEC_RETIRED.VNNI_256@) / (tma_retiring *=
 tma_info_thread_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_256b",
-        "MetricThreshold": "tma_int_vector_256b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fractio=
n the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_f=
p_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma_port_0, tma_por=
t_1, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_int_vector_256b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
+        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fractio=
n the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_f=
p_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b,=
 tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2196,8 +2197,8 @@
         "MetricExpr": "cpu_core@ICACHE_TAG.STALLS@ / tma_info_thread_clks"=
,
         "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS, FRONTEND_RETIRED.ITLB_MISS",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2206,7 +2207,7 @@
         "MetricExpr": "max((cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L1D_MISS@) / tma_info_thread_clks, 0)",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
-        "MetricThreshold": "tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & =
tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1D. Another example is loads who miss in the TLB.=
 These cases are characterized by execution unit stalls; while some non-com=
pleted demand load lives in the machine without having that demand load mis=
sing the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT. Related metrics: t=
ma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tma_ms_swi=
tches, tma_ports_utilized_1",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2216,7 +2217,7 @@
         "MetricExpr": "min(2 * (cpu_core@MEM_INST_RETIRED.ALL_LOADS@ - cpu=
_core@MEM_LOAD_RETIRED.FB_HIT@ - cpu_core@MEM_LOAD_RETIRED.L1_MISS@) * 20 /=
 100, max(cpu_core@CYCLE_ACTIVITY.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIVIT=
Y.CYCLES_L1D_MISS@, 0)) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_l1_bound=
_group",
         "MetricName": "tma_l1_latency_dependency",
-        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & tma_l1_bound=
 > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & (tma_l1_boun=
d > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache. The s=
hort latency of the L1D cache may be exposed in pointer-chasing memory acce=
ss patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2226,17 +2227,18 @@
         "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L1D_MISS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L2_MISS@) / tma_info_thread_clks",
         "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
-        "MetricThreshold": "tma_l2_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L2 cache under unloaded scenarios (poss=
ibly L2 latency limited)",
-        "MetricExpr": "(min(cpu_core@MEM_LOAD_RETIRED.L2_HIT@ * cpu_core@m=
em_load_retired.l2_hit@R, cpu_core@MEM_LOAD_RETIRED.L2_HIT@ * (3 * tma_info=
_system_core_frequency)) if 0 < cpu_core@mem_load_retired.l2_hit@R else cpu=
_core@MEM_LOAD_RETIRED.L2_HIT@ * (3 * tma_info_system_core_frequency)) * (1=
 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ /=
 2) / tma_info_thread_clks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "cpu_core@MEM_LOAD_RETIRED.L2_HIT@ * min(cpu_core@ME=
M_LOAD_RETIRED.L2_HIT@R, 3 * tma_info_system_core_frequency) * (1 + cpu_cor=
e@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_=
info_thread_clks",
         "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l2_bound_grou=
p",
         "MetricName": "tma_l2_hit_latency",
-        "MetricThreshold": "tma_l2_hit_latency > 0.05 & tma_l2_bound > 0.0=
5 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_l2_hit_latency > 0.05 & (tma_l2_bound > 0.=
05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L2 cache under unloaded scenarios (pos=
sibly L2 latency limited).  Avoiding L1 cache misses (i.e. L1 misses/L2 hit=
s) will improve the latency. Sample with: MEM_LOAD_RETIRED.L2_HIT",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2246,18 +2248,19 @@
         "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L2_MISS@ - cpu_cor=
e@MEMORY_ACTIVITY.STALLS_L3_MISS@) / tma_info_thread_clks",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
-        "MetricThreshold": "tma_l3_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT",
+        "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
-        "MetricExpr": "(min(cpu_core@MEM_LOAD_RETIRED.L3_HIT@ * cpu_core@m=
em_load_retired.l3_hit@R, cpu_core@MEM_LOAD_RETIRED.L3_HIT@ * (12 * tma_inf=
o_system_core_frequency) - 3 * tma_info_system_core_frequency) if 0 < cpu_c=
ore@mem_load_retired.l3_hit@R else cpu_core@MEM_LOAD_RETIRED.L3_HIT@ * (12 =
* tma_info_system_core_frequency) - 3 * tma_info_system_core_frequency) * (=
1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ =
/ 2) / tma_info_thread_clks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "cpu_core@MEM_LOAD_RETIRED.L3_HIT@ * min(cpu_core@ME=
M_LOAD_RETIRED.L3_HIT@R, 9 * tma_info_system_core_frequency) * (1 + cpu_cor=
e@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_=
info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
-        "MetricThreshold": "tma_l3_hit_latency > 0.1 & tma_l3_bound > 0.05=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT. Related metrics: tma_b=
ottleneck_cache_memory_latency, tma_branch_resteers, tma_mem_latency, tma_s=
tore_latency",
+        "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_bottleneck_cache_memory_latency, tma_mem_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2266,19 +2269,19 @@
         "MetricExpr": "cpu_core@DECODE.LCP@ / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
-        "MetricThreshold": "tma_lcp > 0.05 & tma_fetch_latency > 0.1 & tma=
_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. Related metr=
ics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidt=
h, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_info_=
inst_mix_iptb",
+        "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations , instructions that require =
no more than one uop (micro-operation)",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
         "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_light_operations",
         "MetricThreshold": "tma_light_operations > 0.6",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations , instructions that require=
 no more than one uop (micro-operation). This correlates with total number =
of instructions used by the program. A uops-per-instruction (see UopPI metr=
ic) ratio of 1 or less should be expected for decently optimized code runni=
ng on Intel Core/Xeon products. While this often indicates efficient X86 in=
structions were executed; high value does not necessarily mean better perfo=
rmance cannot be achieved. ([ICL+] Note this may undercount due to approxim=
ation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIST=
",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UopPI met=
ric) ratio of 1 or less should be expected for decently optimized code runn=
ing on Intel Core/Xeon products. While this often indicates efficient X86 i=
nstructions were executed; high value does not necessarily mean better perf=
ormance cannot be achieved. ([ICL+] Note this may undercount due to approxi=
mation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIS=
T",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2297,7 +2300,7 @@
         "MetricExpr": "max(0, tma_dtlb_load - tma_load_stlb_miss)",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_hit",
-        "MetricThreshold": "tma_load_stlb_hit > 0.05 & tma_dtlb_load > 0.1=
 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_hit > 0.05 & (tma_dtlb_load > 0.=
1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2306,43 +2309,43 @@
         "MetricExpr": "cpu_core@DTLB_LOAD_MISSES.WALK_ACTIVE@ / tma_info_t=
hread_clks",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_miss",
-        "MetricThreshold": "tma_load_stlb_miss > 0.05 & tma_dtlb_load > 0.=
1 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_miss > 0.05 & (tma_dtlb_load > 0=
.1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses.",
         "MetricExpr": "tma_load_stlb_miss * cpu_core@DTLB_LOAD_MISSES.WALK=
_COMPLETED_1G@ / (cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED_4K@ + cpu_core@D=
TLB_LOAD_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_LOAD_MISSES.WALK_COMP=
LETED_1G@)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_1g",
-        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & (tma_load_stlb_=
miss > 0.05 & (tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (tma_memory_boun=
d > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses.",
         "MetricExpr": "tma_load_stlb_miss * cpu_core@DTLB_LOAD_MISSES.WALK=
_COMPLETED_2M_4M@ / (cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED_4K@ + cpu_cor=
e@DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_LOAD_MISSES.WALK_C=
OMPLETED_1G@)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_2m",
-        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & (tma_load_stlb_=
miss > 0.05 & (tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (tma_memory_boun=
d > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses.",
         "MetricExpr": "tma_load_stlb_miss * cpu_core@DTLB_LOAD_MISSES.WALK=
_COMPLETED_4K@ / (cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED_4K@ + cpu_core@D=
TLB_LOAD_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_LOAD_MISSES.WALK_COMP=
LETED_1G@)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_4k",
-        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & (tma_load_stlb_=
miss > 0.05 & (tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (tma_memory_boun=
d > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
-        "MetricExpr": "cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ * cpu_core@me=
m_inst_retired.lock_loads@R / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ * cpu_core@ME=
M_INST_RETIRED.LOCK_LOADS@R / tma_info_thread_clks",
         "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
-        "MetricThreshold": "tma_lock_latency > 0.2 & tma_l1_bound > 0.1 & =
tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS. Related metrics: tma_store_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2353,7 +2356,7 @@
         "MetricGroup": "FetchBW;LSD;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_lsd",
         "MetricThreshold": "tma_lsd > 0.15 & tma_fetch_bandwidth > 0.2",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to LSD (Loop Stream Detector) unit. =
 LSD typically does well sustaining Uop supply. However; in some rare cases=
; optimal uop-delivery could not be reached for small loops whose size (in =
terms of number of uops) does not suit well the LSD structure",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to LSD (Loop Stream Detector) unit. =
 LSD typically does well sustaining Uop supply. However; in some rare cases=
; optimal uop-delivery could not be reached for small loops whose size (in =
terms of number of uops) does not suit well the LSD structure.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2364,17 +2367,17 @@
         "MetricName": "tma_machine_clears",
         "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation=
 > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_bottleneck_memory_synchronization, tma_clears_resteers, tma_contested_a=
ccesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_s=
equencer, tma_ms_switches",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_bottleneck_memory_synchronization, tma_clears_resteers, tma_contested_a=
ccesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_s=
equencer, tma_ms_switches, tma_remote_cache",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
-        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.DATA_RD\\,cmask\\=3D0x4@) / tma_info_thread_clks"=
,
+        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
         "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
-        "MetricThreshold": "tma_mem_bandwidth > 0.2 & tma_dram_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_bottleneck_cache_memory_bandwidth,=
 tma_fb_full, tma_sq_full",
+        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_bottleneck_cache_memory_bandwidth,=
 tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2383,34 +2386,34 @@
         "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@) / tma_info_thread_clks - tm=
a_mem_bandwidth",
         "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
-        "MetricThreshold": "tma_mem_latency > 0.1 & tma_dram_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_bottleneck_cache_memory_latency, tma_l3_hit_latency=
",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
+        "MetricExpr": "cpu_core@topdown\\-mem\\-bound@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
         "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_b=
ound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
",
+        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * cpu_core@MISC2_RETIRED.LFENCE@ / tma_info_thre=
ad_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_memory_fence",
-        "MetricThreshold": "tma_memory_fence > 0.05 & tma_serializing_oper=
ation > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_memory_fence > 0.05 & (tma_serializing_ope=
ration > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations , uops for memory load or store ac=
cesses",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
         "MetricExpr": "tma_light_operations * cpu_core@MEM_UOP_RETIRED.ANY=
@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_memory_operations",
@@ -2433,7 +2436,7 @@
         "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * cpu_=
core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_group;=
tma_branch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
-        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & tma_branch_r=
esteers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_bottleneck_mispredictions, tma_branch_mispredicts, tma_info_bad=
_spec_branch_misprediction_cost",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2449,18 +2452,18 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued , the Count Do=
main; [ADL+] cycles)",
+        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued -- the Count D=
omain; [ADL+] cycles)",
         "MetricExpr": "160 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_thre=
ad_clks",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_issueMV;tma_ports_utili=
zed_0_group",
         "MetricName": "tma_mixing_vectors",
         "MetricThreshold": "tma_mixing_vectors > 0.05",
-        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued , the Count D=
omain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investigat=
ing. Read more in Appendix B1 of the Optimizations Guide for this topic. Re=
lated metrics: tma_ms_switches",
+        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued -- the Count =
Domain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investiga=
ting. Read more in Appendix B1 of the Optimizations Guide for this topic. R=
elated metrics: tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details",
-        "MetricExpr": "max(cpu_core@IDQ.MS_CYCLES_ANY@, cpu_core@UOPS_RETI=
RED.MS\\,cmask\\=3D0x1@ / (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISS=
UED.ANY@)) / tma_info_core_core_clks / 2",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details.",
+        "MetricExpr": "max(cpu_core@IDQ.MS_CYCLES_ANY@, cpu_core@UOPS_RETI=
RED.MS\\,cmask\\=3D1@ / (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISSUE=
D.ANY@)) / tma_info_core_core_clks / 2",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_fetch_bandwidt=
h_group",
         "MetricName": "tma_ms",
         "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
@@ -2469,10 +2472,10 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D0x1\\,edge=
\\=3D0x1@ / (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISSUED.ANY@) / tm=
a_info_thread_clks",
+        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ =
/ (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISSUED.ANY@) / tma_info_thr=
ead_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
-        "MetricThreshold": "tma_ms_switches > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
         "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_bottleneck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_mac=
hine_clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_o=
peration",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2483,7 +2486,7 @@
         "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_non_fused_branches",
         "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2492,7 +2495,7 @@
         "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.NOP@ /=
 (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "BvBO;Pipeline;TopdownL4;tma_L4_group;tma_other_lig=
ht_ops_group",
         "MetricName": "tma_nop_instructions",
-        "MetricThreshold": "tma_nop_instructions > 0.1 & tma_other_light_o=
ps > 0.3 & tma_light_operations > 0.6",
+        "MetricThreshold": "tma_nop_instructions > 0.1 & (tma_other_light_=
ops > 0.3 & tma_light_operations > 0.6)",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2508,20 +2511,20 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types)",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types).",
         "MetricExpr": "max(tma_branch_mispredicts * (1 - cpu_core@BR_MISP_=
RETIRED.ALL_BRANCHES@ / (cpu_core@INT_MISC.CLEARS_COUNT@ - cpu_core@MACHINE=
_CLEARS.COUNT@)), 0.0001)",
         "MetricGroup": "BrMispredicts;BvIO;TopdownL3;tma_L3_group;tma_bran=
ch_mispredicts_group",
         "MetricName": "tma_other_mispredicts",
-        "MetricThreshold": "tma_other_mispredicts > 0.05 & tma_branch_misp=
redicts > 0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_other_mispredicts > 0.05 & (tma_branch_mis=
predicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
.",
         "MetricExpr": "max(tma_machine_clears * (1 - cpu_core@MACHINE_CLEA=
RS.MEMORY_ORDERING@ / cpu_core@MACHINE_CLEARS.COUNT@), 0.0001)",
         "MetricGroup": "BvIO;Machine_Clears;TopdownL3;tma_L3_group;tma_mac=
hine_clears_group",
         "MetricName": "tma_other_nukes",
-        "MetricThreshold": "tma_other_nukes > 0.05 & tma_machine_clears > =
0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_other_nukes > 0.05 & (tma_machine_clears >=
 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2531,7 +2534,7 @@
         "MetricGroup": "TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_page_faults",
         "MetricThreshold": "tma_page_faults > 0.05",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2541,7 +2544,7 @@
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
         "MetricThreshold": "tma_port_0 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_12=
8b, tma_int_vector_256b, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512=
b, tma_int_vector_128b, tma_int_vector_256b, tma_port_1, tma_port_5, tma_po=
rt_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2551,7 +2554,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
         "MetricThreshold": "tma_port_1 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b, tma_port_=
0, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_ve=
ctor_256b, tma_port_0, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2561,7 +2564,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_1. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128=
b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_1. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b=
, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_por=
t_5, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2570,8 +2573,8 @@
         "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (cp=
u_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_=
3_PORTS_UTIL@)) / tma_info_thread_clks if cpu_core@ARITH.DIV_ACTIVE@ < cpu_=
core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ e=
lse (cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTI=
VITY.2_3_PORTS_UTIL@) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
-        "MetricThreshold": "tma_ports_utilization > 0.15 & tma_core_bound =
> 0.1 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations",
+        "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2580,8 +2583,8 @@
         "MetricExpr": "max(cpu_core@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ - cpu_=
core@RESOURCE_STALLS.SCOREBOARD@, 0) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
-        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric",
+        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2590,7 +2593,7 @@
         "MetricExpr": "cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ / tma_info_thre=
ad_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
-        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL. Related m=
etrics: tma_l1_bound",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2601,8 +2604,8 @@
         "MetricExpr": "cpu_core@EXE_ACTIVITY.2_PORTS_UTIL@ / tma_info_thre=
ad_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
-        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma=
_int_vector_256b, tma_port_0, tma_port_1, tma_port_6",
+        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_=
int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5, t=
ma_port_6",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2612,24 +2615,24 @@
         "MetricExpr": "cpu_core@UOPS_EXECUTED.CYCLES_GE_3@ / tma_info_thre=
ad_clks",
         "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
-        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by (indirect) RET instruction=
s",
-        "MetricExpr": "cpu_core@BR_MISP_RETIRED.RET_COST@ * cpu_core@br_mi=
sp_retired.ret_cost@R / tma_info_thread_clks",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by (indirect) RET instruction=
s.",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.RET_COST@ * cpu_core@BR_MI=
SP_RETIRED.RET_COST@R / tma_info_thread_clks",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_ret_mispredicts",
-        "MetricThreshold": "tma_ret_mispredicts > 0.05 & tma_branch_mispre=
dicts > 0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_ret_mispredicts > 0.05 & (tma_branch_mispr=
edicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
+        "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdown\\-=
fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@=
 + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
         "MetricGroup": "BvUW;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -2643,7 +2646,7 @@
         "MetricExpr": "cpu_core@RESOURCE_STALLS.SCOREBOARD@ / tma_info_thr=
ead_clks + tma_c02_wait",
         "MetricGroup": "BvIO;PortsUtil;TopdownL3;tma_L3_group;tma_core_bou=
nd_group;tma_issueSO",
         "MetricName": "tma_serializing_operation",
-        "MetricThreshold": "tma_serializing_operation > 0.1 & tma_core_bou=
nd > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_core_bo=
und > 0.1 & tma_backend_bound > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD. Related metri=
cs: tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2653,8 +2656,8 @@
         "MetricExpr": "tma_light_operations * cpu_core@INT_VEC_RETIRED.SHU=
FFLES@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_other_ligh=
t_ops_group",
         "MetricName": "tma_shuffles_256b",
-        "MetricThreshold": "tma_shuffles_256b > 0.1 & tma_other_light_ops =
> 0.3 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers",
+        "MetricThreshold": "tma_shuffles_256b > 0.1 & (tma_other_light_ops=
 > 0.3 & tma_light_operations > 0.6)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2664,28 +2667,28 @@
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.PAUSE@ / tma_info_thread_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_slow_pause",
-        "MetricThreshold": "tma_slow_pause > 0.05 & tma_serializing_operat=
ion > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_slow_pause > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTED.=
PAUSE_INST",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
-        "MetricExpr": "(min(cpu_core@MEM_INST_RETIRED.SPLIT_LOADS@ * cpu_c=
ore@mem_inst_retired.split_loads@R, cpu_core@MEM_INST_RETIRED.SPLIT_LOADS@ =
* tma_info_memory_load_miss_real_latency) if 0 < cpu_core@mem_inst_retired.=
split_loads@R else cpu_core@MEM_INST_RETIRED.SPLIT_LOADS@ * tma_info_memory=
_load_miss_real_latency) / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@MEM_INST_RETIRED.SPLIT_LOADS@ * min(cpu_co=
re@MEM_INST_RETIRED.SPLIT_LOADS@R, tma_info_memory_load_miss_real_latency) =
/ tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
         "MetricThreshold": "tma_split_loads > 0.3",
-        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS_PS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
-        "MetricExpr": "(min(cpu_core@MEM_INST_RETIRED.SPLIT_STORES@ * cpu_=
core@mem_inst_retired.split_stores@R, cpu_core@MEM_INST_RETIRED.SPLIT_STORE=
S@) if 0 < cpu_core@mem_inst_retired.split_stores@R else cpu_core@MEM_INST_=
RETIRED.SPLIT_STORES@) / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@MEM_INST_RETIRED.SPLIT_STORES@ * min(cpu_c=
ore@MEM_INST_RETIRED.SPLIT_STORES@R, 1) / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
-        "MetricThreshold": "tma_split_stores > 0.2 & tma_store_bound > 0.2=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES",
+        "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES_PS. Related metrics: tma_port_=
4",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2694,8 +2697,8 @@
         "MetricExpr": "(cpu_core@XQ.FULL_CYCLES@ + cpu_core@L1D_PEND_MISS.=
L2_STALLS@) / tma_info_thread_clks",
         "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
-        "MetricThreshold": "tma_sq_full > 0.3 & tma_l3_bound > 0.05 & tma_=
memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_cache_memory_bandwidth, tma_fb_full, tma_mem_bandwidth",
+        "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, tma_m=
em_bandwidth",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2704,8 +2707,8 @@
         "MetricExpr": "cpu_core@EXE_ACTIVITY.BOUND_ON_STORES@ / tma_info_t=
hread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_store_bound",
-        "MetricThreshold": "tma_store_bound > 0.2 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES",
+        "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES_PS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2714,8 +2717,8 @@
         "MetricExpr": "13 * cpu_core@LD_BLOCKS.STORE_FORWARD@ / tma_info_t=
hread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
-        "MetricThreshold": "tma_store_fwd_blk > 0.1 & tma_l1_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading",
+        "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2724,8 +2727,8 @@
         "MetricExpr": "(cpu_core@MEM_STORE_RETIRED.L2_HIT@ * 10 * (1 - cpu=
_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.ALL_STORES@)=
 + (1 - cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.A=
LL_STORES@) * min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUE=
STS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO@)) / tma_info_thread_clks",
         "MetricGroup": "BvML;LockCont;MemoryLat;Offcore;TopdownL4;tma_L4_g=
roup;tma_issueRFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
-        "MetricThreshold": "tma_store_latency > 0.1 & tma_store_bound > 0.=
2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_branch_resteers, tma_fb_full, tma_l=
3_hit_latency, tma_lock_latency",
+        "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2744,7 +2747,7 @@
         "MetricExpr": "max(0, tma_dtlb_store - tma_store_stlb_miss)",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_hit",
-        "MetricThreshold": "tma_store_stlb_hit > 0.05 & tma_dtlb_store > 0=
.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > =
0.2",
+        "MetricThreshold": "tma_store_stlb_hit > 0.05 & (tma_dtlb_store > =
0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound=
 > 0.2)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2753,34 +2756,34 @@
         "MetricExpr": "cpu_core@DTLB_STORE_MISSES.WALK_ACTIVE@ / tma_info_=
core_core_clks",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_miss",
-        "MetricThreshold": "tma_store_stlb_miss > 0.05 & tma_dtlb_store > =
0.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound >=
 0.2",
+        "MetricThreshold": "tma_store_stlb_miss > 0.05 & (tma_dtlb_store >=
 0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_boun=
d > 0.2)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses.",
         "MetricExpr": "tma_store_stlb_miss * cpu_core@DTLB_STORE_MISSES.WA=
LK_COMPLETED_1G@ / (cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED_4K@ + cpu_cor=
e@DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_STORE_MISSES.WALK=
_COMPLETED_1G@)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_1g",
-        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & (tma_store_stl=
b_miss > 0.05 & (tma_dtlb_store > 0.05 & (tma_store_bound > 0.2 & (tma_memo=
ry_bound > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses.",
         "MetricExpr": "tma_store_stlb_miss * cpu_core@DTLB_STORE_MISSES.WA=
LK_COMPLETED_2M_4M@ / (cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED_4K@ + cpu_=
core@DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_STORE_MISSES.W=
ALK_COMPLETED_1G@)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_2m",
-        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & (tma_store_stl=
b_miss > 0.05 & (tma_dtlb_store > 0.05 & (tma_store_bound > 0.2 & (tma_memo=
ry_bound > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses.",
         "MetricExpr": "tma_store_stlb_miss * cpu_core@DTLB_STORE_MISSES.WA=
LK_COMPLETED_4K@ / (cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED_4K@ + cpu_cor=
e@DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_STORE_MISSES.WALK=
_COMPLETED_1G@)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_4k",
-        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & (tma_store_stl=
b_miss > 0.05 & (tma_dtlb_store > 0.05 & (tma_store_bound > 0.2 & (tma_memo=
ry_bound > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2789,7 +2792,7 @@
         "MetricExpr": "9 * cpu_core@OCR.STREAMING_WR.ANY_RESPONSE@ / tma_i=
nfo_thread_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueS=
mSt;tma_store_bound_group",
         "MetricName": "tma_streaming_stores",
-        "MetricThreshold": "tma_streaming_stores > 0.2 & tma_store_bound >=
 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_streaming_stores > 0.2 & (tma_store_bound =
> 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE. Related metrics: tma=
_fb_full",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2799,7 +2802,7 @@
         "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / tma_info=
_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;TopdownL4;tma_L4_group;=
tma_branch_resteers_group",
         "MetricName": "tma_unknown_branches",
-        "MetricThreshold": "tma_unknown_branches > 0.05 & tma_branch_reste=
ers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit) hence called Unknown Bran=
ches. Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2809,8 +2812,8 @@
         "MetricExpr": "tma_retiring * cpu_core@UOPS_EXECUTED.X87@ / cpu_co=
re@UOPS_EXECUTED.THREAD@",
         "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
         "MetricName": "tma_x87_use",
-        "MetricThreshold": "tma_x87_use > 0.1 & tma_fp_arith > 0.2 & tma_l=
ight_operations > 0.6",
-        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint",
+        "MetricThreshold": "tma_x87_use > 0.1 & (tma_fp_arith > 0.2 & tma_=
light_operations > 0.6)",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     }
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/other.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/other.json
index 46a21776a4e9..cb21bb933617 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/other.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.HARDWARE",
-        "PublicDescription": "Count all other hardware assists or traps th=
at are not necessarily architecturally exposed (through a software handler)=
 beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-ev=
ents.  This includes, but not limited to, assists at EXE or MEM uop writeba=
ck like AVX* load/store/gather/scatter (non-FP GSSE-assist ) , assists gene=
rated by ROB like PEBS and RTIT, Uncore trap, RAR (Remote Action Request) a=
nd CET (Control flow Enforcement Technology) assists. the event also counts=
 for Machine Ordering count.",
+        "PublicDescription": "Count all other hardware assists or traps th=
at are not necessarily architecturally exposed (through a software handler)=
 beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-ev=
ents.  This includes, but not limited to, assists at EXE or MEM uop writeba=
ck like AVX* load/store/gather/scatter (non-FP GSSE-assist ) , assists gene=
rated by ROB like PEBS and RTIT, Uncore trap, RAR (Remote Action Request) a=
nd CET (Control flow Enforcement Technology) assists. the event also counts=
 for Machine Ordering count. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -14,6 +14,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.PAGE_FAULT",
+        "PublicDescription": "ASSISTS.PAGE_FAULT Available PDIST counters:=
 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -28,105 +29,6 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that have any type of response.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -134,6 +36,7 @@
         "EventName": "OCR.FULL_STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800000010000",
+        "PublicDescription": "Counts streaming stores which modify a full =
64 byte cacheline that have any type of response. Available PDIST counters:=
 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -145,6 +48,7 @@
         "EventName": "OCR.PARTIAL_STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400000010000",
+        "PublicDescription": "Counts streaming stores which modify only pa=
rt of a 64 byte cacheline that have any type of response. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -156,6 +60,7 @@
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10800",
+        "PublicDescription": "Counts streaming stores that have any type o=
f response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -167,58 +72,18 @@
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10800",
+        "PublicDescription": "Counts streaming stores that have any type o=
f response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
-    {
-        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xa5",
-        "EventName": "RS.EMPTY",
-        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x7",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "CounterMask": "1",
-        "EdgeDetect": "1",
-        "EventCode": "0xa5",
-        "EventName": "RS.EMPTY_COUNT",
-        "Invert": "1",
-        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
-        "SampleAfterValue": "100003",
-        "UMask": "0x7",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Cycles when RS was empty and a resource alloc=
ation stall is asserted",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xa5",
-        "EventName": "RS.EMPTY_RESOURCE",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x1",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x75",
-        "EventName": "SERIALIZATION.C01_MS_SCB",
-        "SampleAfterValue": "200003",
-        "UMask": "0x4",
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "Cycles the uncore cannot take further request=
s",
         "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x2d",
         "EventName": "XQ.FULL_CYCLES",
-        "PublicDescription": "number of cycles when the thread is active a=
nd the uncore cannot take any further requests (for example prefetches, loa=
ds or stores initiated by the Core that miss the L2 cache).",
+        "PublicDescription": "number of cycles when the thread is active a=
nd the uncore cannot take any further requests (for example prefetches, loa=
ds or stores initiated by the Core that miss the L2 cache). Available PDIST=
 counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index 265f6c5a0248..a833d6f53d0e 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -15,7 +15,7 @@
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIV_ACTIVE",
-        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x9",
         "Unit": "cpu_core"
@@ -26,6 +26,7 @@
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.IDIV_ACTIVE",
+        "PublicDescription": "This event counts the cycles the integer div=
ider is busy. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -35,7 +36,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.ANY",
-        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists.",
+        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1b",
         "Unit": "cpu_core"
@@ -54,7 +55,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts all branch instructions retired.",
+        "PublicDescription": "Counts all branch instructions retired. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
@@ -72,7 +73,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
-        "PublicDescription": "Counts conditional branch instructions retir=
ed.",
+        "PublicDescription": "Counts conditional branch instructions retir=
ed. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x11",
         "Unit": "cpu_core"
@@ -82,7 +83,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_NTAKEN",
-        "PublicDescription": "Counts not taken branch instructions retired=
.",
+        "PublicDescription": "Counts not taken branch instructions retired=
. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -101,7 +102,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
-        "PublicDescription": "Counts taken conditional branch instructions=
 retired.",
+        "PublicDescription": "Counts taken conditional branch instructions=
 retired. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -120,7 +121,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "PublicDescription": "Counts far branch instructions retired.",
+        "PublicDescription": "Counts far branch instructions retired. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -139,7 +140,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
-        "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch.",
+        "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch. Available PDIST co=
unters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -186,7 +187,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PublicDescription": "Counts both direct and indirect near call in=
structions retired.",
+        "PublicDescription": "Counts both direct and indirect near call in=
structions retired. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -205,7 +206,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PublicDescription": "Counts return instructions retired.",
+        "PublicDescription": "Counts return instructions retired. Availabl=
e PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -224,7 +225,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
-        "PublicDescription": "Counts taken branch instructions retired.",
+        "PublicDescription": "Counts taken branch instructions retired. Av=
ailable PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -261,7 +262,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path.",
+        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
@@ -270,6 +271,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_COST",
+        "PublicDescription": "All mispredicted branch instructions retired=
. This precise event may be used to get the misprediction cost via the Reti=
re_Latency field of PEBS. It fires on the instruction that immediately foll=
ows the mispredicted branch. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x44",
         "Unit": "cpu_core"
@@ -288,7 +290,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
-        "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired.",
+        "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x11",
         "Unit": "cpu_core"
@@ -298,6 +300,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_COST",
+        "PublicDescription": "Mispredicted conditional branch instructions=
 retired. This precise event may be used to get the misprediction cost via =
the Retire_Latency field of PEBS. It fires on the instruction that immediat=
ely follows the mispredicted branch. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x51",
         "Unit": "cpu_core"
@@ -307,7 +310,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
-        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken.",
+        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -317,6 +320,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN_COST",
+        "PublicDescription": "Mispredicted non-taken conditional branch in=
structions retired. This precise event may be used to get the misprediction=
 cost via the Retire_Latency field of PEBS. It fires on the instruction tha=
t immediately follows the mispredicted branch. Available PDIST counters: 0"=
,
         "SampleAfterValue": "400009",
         "UMask": "0x50",
         "Unit": "cpu_core"
@@ -335,7 +339,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
-        "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired.",
+        "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -345,6 +349,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN_COST",
+        "PublicDescription": "Mispredicted taken conditional branch instru=
ctions retired. This precise event may be used to get the misprediction cos=
t via the Retire_Latency field of PEBS. It fires on the instruction that im=
mediately follows the mispredicted branch. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x41",
         "Unit": "cpu_core"
@@ -363,7 +368,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
-        "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch.",
+        "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -382,7 +387,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
-        "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect.",
+        "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect. Avail=
able PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -392,6 +397,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL_COST",
+        "PublicDescription": "Mispredicted indirect CALL retired. This pre=
cise event may be used to get the misprediction cost via the Retire_Latency=
 field of PEBS. It fires on the instruction that immediately follows the mi=
spredicted branch. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x42",
         "Unit": "cpu_core"
@@ -401,6 +407,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_COST",
+        "PublicDescription": "Mispredicted near indirect branch instructio=
ns retired (excluding returns). This precise event may be used to get the m=
isprediction cost via the Retire_Latency field of PEBS. It fires on the ins=
truction that immediately follows the mispredicted branch. Available PDIST =
counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0xc0",
         "Unit": "cpu_core"
@@ -428,7 +435,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
-        "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken.",
+        "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -438,6 +445,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN_COST",
+        "PublicDescription": "Mispredicted taken near branch instructions =
retired. This precise event may be used to get the misprediction cost via t=
he Retire_Latency field of PEBS. It fires on the instruction that immediate=
ly follows the mispredicted branch. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x60",
         "Unit": "cpu_core"
@@ -447,7 +455,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
-        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
+        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -466,6 +474,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET_COST",
+        "PublicDescription": "Mispredicted ret instructions retired. This =
precise event may be used to get the misprediction cost via the Retire_Late=
ncy field of PEBS. It fires on the instruction that immediately follows the=
 mispredicted branch. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x48",
         "Unit": "cpu_core"
@@ -475,7 +484,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C01",
-        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions. Availab=
le PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -485,7 +494,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C02",
-        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions. Availab=
le PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -495,7 +504,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
-        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x70",
         "Unit": "cpu_core"
@@ -521,7 +530,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
-        "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread.",
+        "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -531,7 +540,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
-        "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
+        "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted. Available PDIST counte=
rs: 0",
         "SampleAfterValue": "25003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -541,6 +550,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE",
+        "PublicDescription": "CPU_CLK_UNHALTED.PAUSE Available PDIST count=
ers: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -552,6 +562,7 @@
         "EdgeDetect": "1",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "PublicDescription": "CPU_CLK_UNHALTED.PAUSE_INST Available PDIST =
counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -561,7 +572,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
-        "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread.",
+        "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -578,7 +589,7 @@
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
         "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the eight programmable counte=
rs available for other events. Note: On all current platforms this event st=
ops counting during 'throttling (TM)' states duty off periods the processor=
 is 'halted'.  The counter update is done at a lower clock rate then the co=
re clock the overflow status bit for this counter may appear 'sticky'.  Aft=
er the counter has overflowed and software clears the overflow status bit a=
nd resets the counter to less than MAX. The reset value to the counter is n=
ot clocked immediately so the overflow status bit will flip 'high (1)' and =
generate another PMI (if enabled) after which the reset value gets clocked =
into the counter. Therefore, software will get the interrupt, read the over=
flow status bit '1 for bit 34 while the counter value is less than MAX. Sof=
tware should ignore this case.",
+        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the eight programmable counte=
rs available for other events. Note: On all current platforms this event st=
ops counting during 'throttling (TM)' states duty off periods the processor=
 is 'halted'.  The counter update is done at a lower clock rate then the co=
re clock the overflow status bit for this counter may appear 'sticky'.  Aft=
er the counter has overflowed and software clears the overflow status bit a=
nd resets the counter to less than MAX. The reset value to the counter is n=
ot clocked immediately so the overflow status bit will flip 'high (1)' and =
generate another PMI (if enabled) after which the reset value gets clocked =
into the counter. Therefore, software will get the interrupt, read the over=
flow status bit '1 for bit 34 while the counter value is less than MAX. Sof=
tware should ignore this case. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -598,7 +609,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
-        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the four (eight when Hyperthr=
eading is disabled) programmable counters available for other events. Note:=
 On all current platforms this event stops counting during 'throttling (TM)=
' states duty off periods the processor is 'halted'.  The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case.",
+        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the four (eight when Hyperthr=
eading is disabled) programmable counters available for other events. Note:=
 On all current platforms this event stops counting during 'throttling (TM)=
' states duty off periods the processor is 'halted'.  The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case. Avail=
able PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -615,7 +626,7 @@
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate",
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
-        "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the eight programmable counters available for other events.",
+        "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the eight programmable counters available for other events. Available PD=
IST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -633,7 +644,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_core"
     },
@@ -643,6 +654,7 @@
         "CounterMask": "8",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
+        "PublicDescription": "Cycles while L1 cache miss demand load is ou=
tstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -653,6 +665,7 @@
         "CounterMask": "1",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
+        "PublicDescription": "Cycles while L2 cache miss demand load is ou=
tstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -663,6 +676,7 @@
         "CounterMask": "16",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
+        "PublicDescription": "Cycles while memory subsystem has an outstan=
ding load. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -673,6 +687,7 @@
         "CounterMask": "12",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
+        "PublicDescription": "Execution stalls while L1 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0xc",
         "Unit": "cpu_core"
@@ -683,6 +698,7 @@
         "CounterMask": "5",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
+        "PublicDescription": "Execution stalls while L2 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_core"
@@ -693,6 +709,7 @@
         "CounterMask": "4",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
+        "PublicDescription": "Total execution stalls. Available PDIST coun=
ters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -702,7 +719,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
-        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
+        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty. Avail=
able PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -712,6 +729,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.2_3_PORTS_UTIL",
+        "PublicDescription": "Cycles total of 2 or 3 uops are executed on =
all ports and Reservation Station (RS) was not empty. Available PDIST count=
ers: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0xc",
         "Unit": "cpu_core"
@@ -721,7 +739,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
-        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
+        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -731,7 +749,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
-        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
+        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty. Available PDIST counters: =
0",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -741,7 +759,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
-        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
+        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty. Available PDIST counters: =
0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -752,6 +770,7 @@
         "CounterMask": "5",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
+        "PublicDescription": "Execution stalls while memory subsystem has =
an outstanding load. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x21",
         "Unit": "cpu_core"
@@ -762,7 +781,7 @@
         "CounterMask": "2",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
-        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
+        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -772,7 +791,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
-        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
+        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load. Available PDIST counters: 0"=
,
         "SampleAfterValue": "1000003",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -782,7 +801,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x75",
         "EventName": "INST_DECODED.DECODERS",
-        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
+        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -791,6 +810,7 @@
         "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
+        "PublicDescription": "Fixed Counter: Counts the number of instruct=
ions retired Available PDIST counters: 32",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -799,7 +819,7 @@
         "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter. A=
vailable PDIST counters: 32",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -826,6 +846,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
+        "PublicDescription": "INST_RETIRED.MACRO_FUSED Available PDIST cou=
nters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -835,7 +856,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
-        "PublicDescription": "Counts all retired NOP or ENDBR32/64 or PREF=
ETCHIT0/1 instructions",
+        "PublicDescription": "Counts all retired NOP or ENDBR32/64 or PREF=
ETCHIT0/1 instructions Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -844,7 +865,7 @@
         "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.PREC_DIST",
-        "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0.",
+        "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0. Available=
 PDIST counters: 32",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -854,7 +875,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -866,7 +887,7 @@
         "EdgeDetect": "1",
         "EventCode": "0xad",
         "EventName": "INT_MISC.CLEARS_COUNT",
-        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears",
+        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears Available PDIST count=
ers: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -876,7 +897,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
-        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
+        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
. Available PDIST counters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -886,7 +907,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
-        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
+        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event. Available PDIST counters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -898,6 +919,7 @@
         "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x7",
+        "PublicDescription": "Bubble cycles of BAClear (Unknown Branch). A=
vailable PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -907,7 +929,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UOP_DROPPING",
-        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
+        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons Available P=
DIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -917,6 +939,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.128BIT",
+        "PublicDescription": "INT_VEC_RETIRED.128BIT Available PDIST count=
ers: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x13",
         "Unit": "cpu_core"
@@ -926,6 +949,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.256BIT",
+        "PublicDescription": "INT_VEC_RETIRED.256BIT Available PDIST count=
ers: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0xac",
         "Unit": "cpu_core"
@@ -935,7 +959,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_128",
-        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions.",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions. Available PDIST counters: 0=
",
         "SampleAfterValue": "1000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -945,7 +969,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_256",
-        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions.",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions. Available PDIST counters: 0=
",
         "SampleAfterValue": "1000003",
         "UMask": "0xc",
         "Unit": "cpu_core"
@@ -955,6 +979,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.MUL_256",
+        "PublicDescription": "INT_VEC_RETIRED.MUL_256 Available PDIST coun=
ters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -964,6 +989,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.SHUFFLES",
+        "PublicDescription": "INT_VEC_RETIRED.SHUFFLES Available PDIST cou=
nters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -973,6 +999,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_128",
+        "PublicDescription": "INT_VEC_RETIRED.VNNI_128 Available PDIST cou=
nters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -982,6 +1009,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_256",
+        "PublicDescription": "INT_VEC_RETIRED.VNNI_256 Available PDIST cou=
nters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -1000,7 +1028,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
-        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
+        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address. Avail=
able PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1019,7 +1047,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
-        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
+        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x88",
         "Unit": "cpu_core"
@@ -1038,7 +1066,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
+        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x82",
         "Unit": "cpu_core"
@@ -1048,7 +1076,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
-        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
+        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1059,7 +1087,7 @@
         "CounterMask": "1",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_ACTIVE",
-        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector).",
+        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector). Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1070,7 +1098,7 @@
         "CounterMask": "6",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_OK",
-        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
+        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector). Available PDIST counters:=
 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1080,7 +1108,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa8",
         "EventName": "LSD.UOPS",
-        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
+        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector). Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1100,7 +1128,7 @@
         "EdgeDetect": "1",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.COUNT",
-        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type.",
+        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1133,8 +1161,9 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine with the use of microcode due to SMC=
, MEMORY_ORDERING, FP_ASSISTS, PAGE_FAULT, DISAMBIGUATION, and FPC_VIRTUAL_=
TRAP.",
+        "BriefDescription": "This event is deprecated.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SLOW",
         "SampleAfterValue": "20003",
@@ -1155,7 +1184,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SMC",
-        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
+        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1165,7 +1194,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe0",
         "EventName": "MISC2_RETIRED.LFENCE",
-        "PublicDescription": "number of LFENCE retired instructions",
+        "PublicDescription": "number of LFENCE retired instructions Availa=
ble PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -1184,7 +1213,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcc",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -1194,7 +1223,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SB",
-        "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
+        "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1204,16 +1233,59 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SCOREBOARD",
+        "PublicDescription": "Counts cycles where the pipeline is stalled =
due to serializing operations. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses) Available PDIST counters: 0",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_COUNT",
+        "Invert": "1",
+        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events) Av=
ailable PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x7",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when RS was empty and a resource alloc=
ation stall is asserted",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_RESOURCE",
+        "PublicDescription": "Cycles when RS was empty and a resource allo=
cation stall is asserted Available PDIST counters: 0",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.C01_MS_SCB",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were not consumed by the back-end pipeline due to lack of bac=
k-end resources, as a result of memory subsystem delays, execution units li=
mitations, or other conditions.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
-        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were not consumed by the back-end pipeline due to lack of ba=
ck-end resources, as a result of memory subsystem delays, execution units l=
imitations, or other conditions. The count is distributed among unhalted lo=
gical processors (hyper-threads) who share the same physical core, in proce=
ssors that support Intel Hyper-Threading Technology. Software can use this =
event as the numerator for the Backend Bound metric (or top-level category)=
 of the Top-down Microarchitecture Analysis method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were not consumed by the back-end pipeline due to lack of ba=
ck-end resources, as a result of memory subsystem delays, execution units l=
imitations, or other conditions. The count is distributed among unhalted lo=
gical processors (hyper-threads) who share the same physical core, in proce=
ssors that support Intel Hyper-Threading Technology. Software can use this =
event as the numerator for the Backend Bound metric (or top-level category)=
 of the Top-down Microarchitecture Analysis method. Available PDIST counter=
s: 0",
         "SampleAfterValue": "10000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1223,7 +1295,7 @@
         "Counter": "0",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
-        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
+        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations. Available PDIST counters: 0",
         "SampleAfterValue": "10000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1233,7 +1305,7 @@
         "Counter": "0",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
-        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "10000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1243,6 +1315,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
+        "PublicDescription": "TOPDOWN.MEMORY_BOUND_SLOTS Available PDIST c=
ounters: 0",
         "SampleAfterValue": "10000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -1251,7 +1324,7 @@
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
         "Counter": "Fixed counter 3",
         "EventName": "TOPDOWN.SLOTS",
-        "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3).",
+        "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3). Available PDIS=
T counters: 0",
         "SampleAfterValue": "10000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1261,7 +1334,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.SLOTS_P",
-        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
+        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core. Available PDIST counters: 0",
         "SampleAfterValue": "10000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1518,7 +1591,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x76",
         "EventName": "UOPS_DECODED.DEC0_UOPS",
-        "PublicDescription": "This event counts the number of not dec-by-a=
ll uops decoded by decoder 0.",
+        "PublicDescription": "This event counts the number of not dec-by-a=
ll uops decoded by decoder 0. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1528,7 +1601,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_0",
-        "PublicDescription": "Number of uops dispatch to execution  port 0=
.",
+        "PublicDescription": "Number of uops dispatch to execution  port 0=
. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1538,7 +1611,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_1",
-        "PublicDescription": "Number of uops dispatch to execution  port 1=
.",
+        "PublicDescription": "Number of uops dispatch to execution  port 1=
. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1548,7 +1621,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_2_3_10",
-        "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10",
+        "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10 Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1558,7 +1631,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_4_9",
-        "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9",
+        "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9 Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -1568,7 +1641,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_5_11",
-        "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11",
+        "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11 Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -1578,7 +1651,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_6",
-        "PublicDescription": "Number of uops dispatch to execution  port 6=
.",
+        "PublicDescription": "Number of uops dispatch to execution  port 6=
. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -1588,7 +1661,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_7_8",
-        "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8.",
+        "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -1598,7 +1671,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE",
-        "PublicDescription": "Counts the number of uops executed from any =
thread.",
+        "PublicDescription": "Counts the number of uops executed from any =
thread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1609,7 +1682,7 @@
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
-        "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core.",
+        "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1620,7 +1693,7 @@
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
-        "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core.",
+        "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1631,7 +1704,7 @@
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
-        "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core.",
+        "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1642,7 +1715,7 @@
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
-        "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core.",
+        "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1653,7 +1726,7 @@
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
-        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread.",
+        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1664,7 +1737,7 @@
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
-        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread.",
+        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1675,7 +1748,7 @@
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
-        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread.",
+        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1686,7 +1759,7 @@
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
-        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread.",
+        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1698,7 +1771,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALLS",
         "Invert": "1",
-        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
+        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread. Available PDIST counte=
rs: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1708,6 +1781,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.THREAD",
+        "PublicDescription": "Counts the number of uops to be executed per=
-thread each cycle. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1717,7 +1791,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.X87",
-        "PublicDescription": "Counts the number of x87 uops executed.",
+        "PublicDescription": "Counts the number of x87 uops executed. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -1736,7 +1810,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xae",
         "EventName": "UOPS_ISSUED.ANY",
-        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
+        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS). Available PD=
IST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1747,6 +1821,7 @@
         "CounterMask": "1",
         "EventCode": "0xae",
         "EventName": "UOPS_ISSUED.CYCLES",
+        "PublicDescription": "UOPS_ISSUED.CYCLES Available PDIST counters:=
 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1765,7 +1840,7 @@
         "CounterMask": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.CYCLES",
-        "PublicDescription": "Counts cycles where at least one uop has ret=
ired.",
+        "PublicDescription": "Counts cycles where at least one uop has ret=
ired. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1775,7 +1850,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.HEAVY",
-        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
+        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count. Available P=
DIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1805,6 +1880,7 @@
         "EventName": "UOPS_RETIRED.MS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
+        "PublicDescription": "UOPS_RETIRED.MS Available PDIST counters: 0"=
,
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1814,7 +1890,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.SLOTS",
-        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that are utilized by operations that eventually get retired (comm=
itted) by the processor pipeline. Usually, this event positively correlates=
 with higher performance  for example, as measured by the instructions-per-=
cycle metric. Software can use this event as the numerator for the Retiring=
 metric (or top-level category) of the Top-down Microarchitecture Analysis =
method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that are utilized by operations that eventually get retired (comm=
itted) by the processor pipeline. Usually, this event positively correlates=
 with higher performance  for example, as measured by the instructions-per-=
cycle metric. Software can use this event as the numerator for the Retiring=
 metric (or top-level category) of the Top-down Microarchitecture Analysis =
method. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1826,7 +1902,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALLS",
         "Invert": "1",
-        "PublicDescription": "This event counts cycles without actually re=
tired uops.",
+        "PublicDescription": "This event counts cycles without actually re=
tired uops. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/meteorlake/uncore-memory.json
index 783a4f7fd05b..ceb8839f0767 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/uncore-memory.json
@@ -99,6 +99,24 @@
         "PerPkg": "1",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "Any Rank at Hot state",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x19",
+        "EventName": "UNC_M_DRAM_THERMAL_HOT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Any Rank at Warm state",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x1A",
+        "EventName": "UNC_M_DRAM_THERMAL_WARM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "PRE command sent to DRAM due to page table id=
le timer expiration",
         "Counter": "0,1,2,3,4",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
index 305b96b26a4e..f300129e9e2d 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
@@ -13,7 +13,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
-        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -24,7 +24,7 @@
         "CounterMask": "1",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
-        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load.",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -43,7 +43,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
-        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault. Available =
PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0xe",
         "Unit": "cpu_core"
@@ -53,7 +53,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
-        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -73,7 +73,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
-        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -93,7 +93,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
-        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -113,7 +113,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle. Available PDIS=
T counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -132,7 +132,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
-        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -143,7 +143,7 @@
         "CounterMask": "1",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
-        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store.",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store. Available PDIST counters:=
 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -162,7 +162,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
-        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault. Available=
 PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0xe",
         "Unit": "cpu_core"
@@ -172,7 +172,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
-        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -192,7 +192,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
-        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -212,7 +212,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
-        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -232,7 +232,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle. Available PDIST coun=
ters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -260,7 +260,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.STLB_HIT",
-        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
+        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB). Available P=
DIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -271,7 +271,7 @@
         "CounterMask": "1",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_ACTIVE",
-        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
.",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -291,7 +291,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
-        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
+        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0xe",
         "Unit": "cpu_core"
@@ -311,7 +311,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
-        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
+        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -331,7 +331,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
-        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
+        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
 Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -351,7 +351,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
+        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
--=20
2.49.0.472.ge94155a9ec-goog


