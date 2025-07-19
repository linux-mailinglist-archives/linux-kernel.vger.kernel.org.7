Return-Path: <linux-kernel+bounces-737552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B7DB0ADD3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1291AA8049
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A23221D3C0;
	Sat, 19 Jul 2025 03:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VtZEC/+n"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9591DFD8F
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752896749; cv=none; b=ACTDp8ZclGU9PnlvMAQLV4KghrrW13bu+dtKvXfYOCzxv6/+OVzYGADks50DfcG7fMXOfCLsEUmd96Vzc/WfvwxZfzKEyDWXkeuMsupdrTdZOZQcKuvKAZZzTKWlfcK5K5WNu4wTaZi5c0TreRlEwp6Icxj8cSXOg5RJeHiTsX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752896749; c=relaxed/simple;
	bh=2ugETdmoTGWuhDfvHrq4hWMBatZ2WjF566K63lIG0jc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ifYHU4a/BfKGf/JkiuU+dIEeHiL8PxY2hN3CLegaKAo+7BBOUoBzcP8GBn2wijRdlXMqzKS+N5N0kYnUTfWR9fGOv7LD5+DecM6K1vcJDSzuQRcJ0531qoDTXA+Cas2ICKSwmetD3hBN8tto4QLaqqNHtCp3PLbkdwN1+K0QdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VtZEC/+n; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so3985132a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752896735; x=1753501535; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fI/s2K4vL5PP6+xuepiTMMS6LZf6OBMfzqt8uLyDIxs=;
        b=VtZEC/+ndR0j/TOhRNsfpIZLJj0dVS1amzD926pc67d1LOluczY7usVoouMomL5/5R
         aH2dhi6I7oUykvoOslZr10sjQwE9qDMLYHD/UgVB9zfS6k0igP5Gk609MKGnUeBZA0Rf
         SLRIrbuKRB0yY+Oi2zql/NjcnzH01oqwOdoIHR30y89w/RBr7OUgIIIRziYw7liDtWH7
         917FrG6Z3UiQHqYDidfZqaQl/Q57jjyLkXR72fP3Ls4rD7LrImkf710fvCOEFMfE0owB
         QGcXwa3U8GK+p6Kn64yeT/PwfBiYVYvHRuaUelVj7KS5YVEuRGCqdegmKi9PJvaXtRn3
         vXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752896735; x=1753501535;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fI/s2K4vL5PP6+xuepiTMMS6LZf6OBMfzqt8uLyDIxs=;
        b=GXkd/cUIZz9OpV/gXdCAtjz9h3PFNYE8+Di2u4XXliWNi5vwfgjEv8mNFwKBfw0YaU
         PKxTEM9H6RzQ/ubGbtCJsN4Koq3LsDJuEvQbVTBhE9mc1A7BQQu3j4PKM9oyQQee26S4
         exIGI2U7XNI8y/LY3DxsdT7xNpyPiqjloj0WUrRaIGhquF0s8F2iSHlvN4GG9gRIEmO9
         QFlLGDFWkT01mYvDwpLPGCZDA6MYT0FYkUXqnRdoqnJqKagdMlq1/x5TdxkKfMeI1omA
         wYv1UVTrlEoJcC62Oc/eEbYkJoYhI8+JWZ/MQvQksqXWk1ss4y6gbLwaC9n4uJEWUwSf
         Bpxw==
X-Forwarded-Encrypted: i=1; AJvYcCU54lvywR/uc3ocGivnY/PwycCJYv4wEjCTzfUW93idRyDaHmGTQLvsnb9ufu2zaaNb2ZuJJyvNQNb6NjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmjNBJDW72T7ahYx4X11KuBW3XjSvS6cskOiUQzhow4fWIFD/+
	X+D1Ak6TGSgjlARGBpYal4a4tdJwCw5aPlUxYQ5rwRhDpz4WAyBlM8/xyexDBjClTGYUJSApEuT
	wT/KcNHhB6g==
X-Google-Smtp-Source: AGHT+IGUU/eRRQ3/zYkipYuq5msRtezt4I9RkMFamcX6fmn1zwSnAKhrQ19M6Ll5ameuxIz2Nwz7Mp10bVGl
X-Received: from pjbrs12.prod.google.com ([2002:a17:90b:2b8c:b0:312:187d:382d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cc4:b0:313:f9f6:309f
 with SMTP id 98e67ed59e1d1-31c9f44dfc3mr16997190a91.34.1752896734667; Fri, 18
 Jul 2025 20:45:34 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:45:01 -0700
In-Reply-To: <20250719034515.2000467-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719034515.2000467-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719034515.2000467-6-irogers@google.com>
Subject: [PATCH v1 05/19] perf vendor events: Update emeraldrapids events/metrics
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.14 to v1.16. Update metrics from TMA 5.0 to 5.1.

The event updates come from:
https://github.com/intel/perfmon/commit/9020e49e790349f86141a1f6ef6f009f189=
a0f48
https://github.com/intel/perfmon/commit/a0567b56185fea4b968391aae344e9d8ed9=
782d8

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/emeraldrapids/cache.json         | 100 +++++------
 .../arch/x86/emeraldrapids/emr-metrics.json   | 131 ++++++++------
 .../x86/emeraldrapids/floating-point.json     |  43 ++---
 .../arch/x86/emeraldrapids/frontend.json      |  42 +++--
 .../arch/x86/emeraldrapids/memory.json        |  30 ++--
 .../arch/x86/emeraldrapids/other.json         |  28 ++-
 .../arch/x86/emeraldrapids/pipeline.json      | 167 +++++++-----------
 .../arch/x86/emeraldrapids/uncore-memory.json |  82 +++++++++
 .../x86/emeraldrapids/virtual-memory.json     |  40 ++---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 10 files changed, 363 insertions(+), 302 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json b/tool=
s/perf/pmu-events/arch/x86/emeraldrapids/cache.json
index 10bdb193c16f..e96f938587bb 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
@@ -4,7 +4,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.HWPF_MISS",
-        "PublicDescription": "L1D.HWPF_MISS Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     },
@@ -13,7 +12,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
-        "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace. Available PDIST counters: 0",
+        "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -22,7 +21,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
-        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses. Av=
ailable PDIST counters: 0",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -33,7 +32,7 @@
         "EdgeDetect": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
-        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses. Av=
ailable PDIST counters: 0",
+        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -43,7 +42,6 @@
         "Deprecated": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALL",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 L1D_PEND_MISS.L2_STALLS Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -52,7 +50,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALLS",
-        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses. Availa=
ble PDIST counters: 0",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -61,7 +59,7 @@
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
rom any request type. Available PDIST counters: 0",
+        "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -71,7 +69,7 @@
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
-        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles. Available PDIST counters: 0",
+        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -80,7 +78,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "L2_LINES_IN.ALL",
-        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
         "SampleAfterValue": "100003",
         "UMask": "0x1f"
     },
@@ -89,7 +87,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.NON_SILENT",
-        "PublicDescription": "Counts the number of lines that are evicted =
by L2 cache when triggered by an L2 cache fill. Those lines are in Modified=
 state. Modified lines are written back to L3 Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of lines that are evicted =
by L2 cache when triggered by an L2 cache fill. Those lines are in Modified=
 state. Modified lines are written back to L3",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
@@ -98,7 +96,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.SILENT",
-        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
@@ -107,7 +105,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.USELESS_HWPF",
-        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
@@ -116,7 +114,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
-        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES] Available PDIST coun=
ters: 0",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES]",
         "SampleAfterValue": "200003",
         "UMask": "0xff"
     },
@@ -125,7 +123,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.MISS",
-        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS] Available PDIST coun=
ters: 0",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS]",
         "SampleAfterValue": "200003",
         "UMask": "0x3f"
     },
@@ -134,7 +132,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
-        "PublicDescription": "Counts the total number of L2 code requests.=
 Available PDIST counters: 0",
+        "PublicDescription": "Counts the total number of L2 code requests.=
",
         "SampleAfterValue": "200003",
         "UMask": "0xe4"
     },
@@ -143,7 +141,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
-        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once. Ava=
ilable PDIST counters: 0",
+        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
         "UMask": "0xe1"
     },
@@ -152,7 +150,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
-        "PublicDescription": "Counts demand requests that miss L2 cache. A=
vailable PDIST counters: 0",
+        "PublicDescription": "Counts demand requests that miss L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x27"
     },
@@ -161,7 +159,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_REFERENCES",
-        "PublicDescription": "Counts demand requests to L2 cache. Availabl=
e PDIST counters: 0",
+        "PublicDescription": "Counts demand requests to L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0xe7"
     },
@@ -170,7 +168,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_HWPF",
-        "PublicDescription": "L2_RQSTS.ALL_HWPF Available PDIST counters: =
0",
         "SampleAfterValue": "200003",
         "UMask": "0xf0"
     },
@@ -179,7 +176,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
-        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches. Available PDIST counters: 0",
+        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
         "SampleAfterValue": "200003",
         "UMask": "0xe2"
     },
@@ -188,7 +185,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
-        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads. Available PDIST counters: 0",
+        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
         "SampleAfterValue": "200003",
         "UMask": "0xc4"
     },
@@ -197,7 +194,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
-        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions. Available PDIST counters: 0",
+        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
         "SampleAfterValue": "200003",
         "UMask": "0x24"
     },
@@ -206,7 +203,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
-        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache. Available PDIST counte=
rs: 0",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0xc1"
     },
@@ -215,7 +212,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
-        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once. Available PDIST counters: 0",
+        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
         "UMask": "0x21"
     },
@@ -224,7 +221,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.HWPF_MISS",
-        "PublicDescription": "L2_RQSTS.HWPF_MISS Available PDIST counters:=
 0",
         "SampleAfterValue": "200003",
         "UMask": "0x30"
     },
@@ -233,7 +229,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
-        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS] Available PDIST co=
unters: 0",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS]",
         "SampleAfterValue": "200003",
         "UMask": "0x3f"
     },
@@ -242,7 +238,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
-        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL] Available PDIST counters:=
 0",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL]",
         "SampleAfterValue": "200003",
         "UMask": "0xff"
     },
@@ -251,7 +247,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
-        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache. Available PDIST counters: 0",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0xc2"
     },
@@ -260,7 +256,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
-        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache. Available PDIST counters: 0",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x22"
     },
@@ -269,7 +265,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_HIT",
-        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full. Available PDIST counters: 0",
+        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full.",
         "SampleAfterValue": "200003",
         "UMask": "0xc8"
     },
@@ -278,7 +274,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_MISS",
-        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full. Available PDIST counters: 0",
+        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full.",
         "SampleAfterValue": "200003",
         "UMask": "0x28"
     },
@@ -287,7 +283,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "L2_TRANS.L2_WB",
-        "PublicDescription": "Counts L2 writebacks that access L2 cache. A=
vailable PDIST counters: 0",
+        "PublicDescription": "Counts L2 writebacks that access L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x40"
     },
@@ -296,7 +292,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3. Available PDIST coun=
ters: 0",
+        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
         "SampleAfterValue": "100003",
         "UMask": "0x41"
     },
@@ -305,7 +301,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3. Available PDIST counters: 0=
",
+        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
         "SampleAfterValue": "100003",
         "UMask": "0x4f"
     },
@@ -394,7 +390,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "MEM_LOAD_COMPLETED.L1_MISS_ANY",
-        "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss) Available PDIST counters: 0",
+        "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss)",
         "SampleAfterValue": "1000003",
         "UMask": "0xfd"
     },
@@ -563,7 +559,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "MEM_STORE_RETIRED.L2_HIT",
-        "PublicDescription": "MEM_STORE_RETIRED.L2_HIT Available PDIST cou=
nters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
@@ -572,7 +567,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe5",
         "EventName": "MEM_UOP_RETIRED.ANY",
-        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses Available PDIST counters: 0",
+        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses",
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
@@ -999,7 +994,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
-        "PublicDescription": "OFFCORE_REQUESTS.ALL_REQUESTS Available PDIS=
T counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
@@ -1008,7 +1002,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DATA_RD",
-        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type. Available PDIST counters: 0",
+        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -1017,7 +1011,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
-        "PublicDescription": "Counts both cacheable and non-cacheable code=
 read requests. Available PDIST counters: 0",
+        "PublicDescription": "Counts both cacheable and non-cacheable code=
 read requests.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -1026,7 +1020,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
-        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore. Available PDIST counters: 0",
+        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1035,7 +1029,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
-        "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM. Available PDIST counters: 0",
+        "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -1045,7 +1039,6 @@
         "Deprecated": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 OFFCORE_REQUESTS_OUTSTANDING.DATA_RD Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -1055,7 +1048,6 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "PublicDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DAT=
A_RD Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -1065,7 +1057,7 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE=
_RD",
-        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -1075,7 +1067,6 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
-        "PublicDescription": "Cycles where at least 1 outstanding demand d=
ata read request is pending. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1085,7 +1076,6 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
-        "PublicDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEM=
AND_RFO Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -1094,7 +1084,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
-        "PublicDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD Availab=
le PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -1103,7 +1092,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
-        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -1112,7 +1101,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
-        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor. Available PDIST counters: 0"=
,
+        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -1121,7 +1110,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "SQ_MISC.BUS_LOCK",
-        "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory. Avai=
lable PDIST counters: 0",
+        "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -1130,7 +1119,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.ANY",
-        "PublicDescription": "Counts the number of PREFETCHNTA, PREFETCHW,=
 PREFETCHT0, PREFETCHT1 or PREFETCHT2 instructions executed. Available PDIS=
T counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0xf"
     },
@@ -1139,7 +1127,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.NTA",
-        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1148,7 +1136,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
-        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -1157,7 +1145,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T0",
-        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -1166,7 +1154,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T1_T2",
-        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     }
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json =
b/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
index 34e1cbcd722c..af0a7dd81e93 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
@@ -1,28 +1,28 @@
 [
     {
         "BriefDescription": "C1 residency percent per core",
-        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c1\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C1_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Pkg_Residency",
         "ScaleUnit": "100%"
@@ -78,6 +78,12 @@
         "MetricName": "io_bandwidth_read",
         "ScaleUnit": "1MB/s"
     },
+    {
+        "BriefDescription": "Bandwidth of inbound IO reads that are initia=
ted by end device controllers that are requesting memory from the CPU and m=
iss the L3 cache",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR * 64 / 1e6 / d=
uration_time",
+        "MetricName": "io_bandwidth_read_l3_miss",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the local CPU socket"=
,
         "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_LOCAL * 64 / 1e6 / =
duration_time",
@@ -96,6 +102,12 @@
         "MetricName": "io_bandwidth_write",
         "ScaleUnit": "1MB/s"
     },
+    {
+        "BriefDescription": "Bandwidth of inbound IO writes that are initi=
ated by end device controllers that are writing memory to the CPU",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_MISS_ITOM + UNC_CHA_TOR_INS=
ERTS.IO_MISS_ITOMCACHENEAR) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_write_l3_miss",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the local CPU socket",
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM_LOCAL + UNC_CHA_TOR_IN=
SERTS.IO_ITOMCACHENEAR_LOCAL) * 64 / 1e6 / duration_time",
@@ -111,19 +123,19 @@
     {
         "BriefDescription": "Percentage of inbound full cacheline writes i=
nitiated by end device controllers that miss the L3 cache",
         "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM / UNC_CHA_TOR_INSE=
RTS.IO_ITOM",
-        "MetricName": "io_percent_of_inbound_full_writes_that_miss_l3",
+        "MetricName": "io_full_write_l3_miss",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Percentage of inbound partial cacheline write=
s initiated by end device controllers that miss the L3 cache",
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR + UNC_CH=
A_TOR_INSERTS.IO_MISS_RFO) / (UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR + UNC_CH=
A_TOR_INSERTS.IO_RFO)",
-        "MetricName": "io_percent_of_inbound_partial_writes_that_miss_l3",
+        "MetricName": "io_partial_write_l3_miss",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Percentage of inbound reads initiated by end =
device controllers that miss the L3 cache",
         "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR / UNC_CHA_TOR_=
INSERTS.IO_PCIRDCUR",
-        "MetricName": "io_percent_of_inbound_reads_that_miss_l3",
+        "MetricName": "io_read_l3_miss",
         "ScaleUnit": "100%"
     },
     {
@@ -335,7 +347,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_inf=
o_thread_slots",
+        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
         "MetricGroup": "BvOB;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
@@ -369,40 +381,40 @@
         "MetricThreshold": "tma_bottleneck_branching_overhead > 5",
         "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)"
     },
+    {
+        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
+        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_amx_busy=
 + tma_divider + tma_ports_utilization + tma_serializing_operation) + tma_c=
ore_bound * tma_amx_busy / (tma_amx_busy + tma_divider + tma_ports_utilizat=
ion + tma_serializing_operation) + tma_core_bound * (tma_ports_utilization =
/ (tma_amx_busy + tma_divider + tma_ports_utilization + tma_serializing_ope=
ration)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_utili=
zed_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
+        "MetricGroup": "BvCB;Cor;tma_issueComp",
+        "MetricName": "tma_bottleneck_compute_bound_est",
+        "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
+        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: "
+    },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_l=
atency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)=
))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + 0 / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * t=
ma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency) + tma_memory_bound=
 * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_b=
ound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma_dat=
a_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tma_l1=
_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma=
_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_laten=
cy_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
         "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_bottleneck_cache_memory_bandwidth",
-        "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
+        "MetricName": "tma_bottleneck_data_cache_memory_bandwidth",
+        "MetricThreshold": "tma_bottleneck_data_cache_memory_bandwidth > 2=
0",
         "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full"
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
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
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + 0 / (tma_dram_=
bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * tma=
_mem_latency / (tma_mem_bandwidth + tma_mem_latency) + tma_memory_bound * (=
tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses + tma_=
data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * tma_=
l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tma_=
l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_l1_latenc=
y_dependency / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + t=
ma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound =
* (tma_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bo=
und + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_fb_full =
+ tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_stor=
e_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_split_loads /=
 (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_latenc=
y + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_b=
ound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_s=
tore_bound)) * (tma_split_stores / (tma_dtlb_store + tma_false_sharing + tm=
a_split_stores + tma_store_latency + tma_streaming_stores)) + tma_memory_bo=
und * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tm=
a_l3_bound + tma_store_bound)) * (tma_store_latency / (tma_dtlb_store + tma=
_false_sharing + tma_split_stores + tma_store_latency + tma_streaming_store=
s)))",
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
-        "MetricName": "tma_bottleneck_cache_memory_latency",
-        "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
+        "MetricName": "tma_bottleneck_data_cache_memory_latency",
+        "MetricThreshold": "tma_bottleneck_data_cache_memory_latency > 20"=
,
         "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency"
     },
-    {
-        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
-        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_amx_busy=
 + tma_divider + tma_ports_utilization + tma_serializing_operation) + tma_c=
ore_bound * tma_amx_busy / (tma_amx_busy + tma_divider + tma_ports_utilizat=
ion + tma_serializing_operation) + tma_core_bound * (tma_ports_utilization =
/ (tma_amx_busy + tma_divider + tma_ports_utilization + tma_serializing_ope=
ration)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_utili=
zed_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
-        "MetricGroup": "BvCB;Cor;tma_issueComp",
-        "MetricName": "tma_bottleneck_compute_bound_est",
-        "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
-        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: "
-    },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
-        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - (1 - I=
NST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.MS\\,cmask\\=3D1@) * (tma_fetc=
h_latency * (tma_ms_switches + tma_branch_resteers * (tma_clears_resteers +=
 tma_mispredicts_resteers * tma_other_mispredicts / tma_branch_mispredicts)=
 / (tma_clears_resteers + tma_mispredicts_resteers + tma_unknown_branches))=
 / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_m=
isses + tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_ms / (tma_ds=
b + tma_mite + tma_ms))) - tma_bottleneck_big_code",
+        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - (1 - I=
NST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.MS\\,cmask\\=3D1@) * (tma_fetc=
h_latency * (tma_ms_switches + tma_branch_resteers * (tma_clears_resteers +=
 tma_mispredicts_resteers * tma_other_mispredicts / tma_branch_mispredicts)=
 / (tma_clears_resteers + tma_mispredicts_resteers + tma_unknown_branches))=
 / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_m=
isses + tma_lcp + tma_ms_switches) + tma_ms)) - tma_bottleneck_big_code",
         "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
         "MetricName": "tma_bottleneck_instruction_fetch_bw",
         "MetricThreshold": "tma_bottleneck_instruction_fetch_bw > 20"
     },
     {
         "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
-        "MetricExpr": "100 * ((1 - INST_RETIRED.REP_ITERATION / cpu@UOPS_R=
ETIRED.MS\\,cmask\\=3D1@) * (tma_fetch_latency * (tma_ms_switches + tma_bra=
nch_resteers * (tma_clears_resteers + tma_mispredicts_resteers * tma_other_=
mispredicts / tma_branch_mispredicts) / (tma_clears_resteers + tma_mispredi=
cts_resteers + tma_unknown_branches)) / (tma_branch_resteers + tma_dsb_swit=
ches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) + t=
ma_fetch_bandwidth * tma_ms / (tma_dsb + tma_mite + tma_ms)) + 10 * tma_mic=
rocode_sequencer * tma_other_mispredicts / tma_branch_mispredicts * tma_bra=
nch_mispredicts + tma_machine_clears * tma_other_nukes / tma_other_nukes + =
tma_core_bound * (tma_serializing_operation + RS.EMPTY_RESOURCE / tma_info_=
thread_clks * tma_ports_utilized_0) / (tma_amx_busy + tma_divider + tma_por=
ts_utilization + tma_serializing_operation) + tma_microcode_sequencer / (tm=
a_few_uops_instructions + tma_microcode_sequencer) * (tma_assists / tma_mic=
rocode_sequencer) * tma_heavy_operations)",
+        "MetricExpr": "100 * ((1 - INST_RETIRED.REP_ITERATION / cpu@UOPS_R=
ETIRED.MS\\,cmask\\=3D1@) * (tma_fetch_latency * (tma_ms_switches + tma_bra=
nch_resteers * (tma_clears_resteers + tma_mispredicts_resteers * tma_other_=
mispredicts / tma_branch_mispredicts) / (tma_clears_resteers + tma_mispredi=
cts_resteers + tma_unknown_branches)) / (tma_branch_resteers + tma_dsb_swit=
ches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) + t=
ma_ms) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_=
mispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other_nukes=
 / tma_other_nukes + tma_core_bound * (tma_serializing_operation + RS.EMPTY=
_RESOURCE / tma_info_thread_clks * tma_ports_utilized_0) / (tma_amx_busy + =
tma_divider + tma_ports_utilization + tma_serializing_operation) + tma_micr=
ocode_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) * (=
tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
         "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
         "MetricName": "tma_bottleneck_irregular_overhead",
         "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
@@ -434,7 +446,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of remaining bottlenecks =
in the back-end",
-        "MetricExpr": "100 - (tma_bottleneck_big_code + tma_bottleneck_ins=
truction_fetch_bw + tma_bottleneck_mispredictions + tma_bottleneck_cache_me=
mory_bandwidth + tma_bottleneck_cache_memory_latency + tma_bottleneck_memor=
y_data_tlbs + tma_bottleneck_memory_synchronization + tma_bottleneck_comput=
e_bound_est + tma_bottleneck_irregular_overhead + tma_bottleneck_branching_=
overhead + tma_bottleneck_useful_work)",
+        "MetricExpr": "100 - (tma_bottleneck_big_code + tma_bottleneck_ins=
truction_fetch_bw + tma_bottleneck_mispredictions + tma_bottleneck_data_cac=
he_memory_bandwidth + tma_bottleneck_data_cache_memory_latency + tma_bottle=
neck_memory_data_tlbs + tma_bottleneck_memory_synchronization + tma_bottlen=
eck_compute_bound_est + tma_bottleneck_irregular_overhead + tma_bottleneck_=
branching_overhead + tma_bottleneck_useful_work)",
         "MetricGroup": "BvOB;Cor;Offcore",
         "MetricName": "tma_bottleneck_other_bottlenecks",
         "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
@@ -450,7 +462,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
         "DefaultMetricgroupName": "TopdownL2",
-        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tm=
a_info_thread_slots",
+        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;Default;TmaL2;TopdownL2=
;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
@@ -551,7 +563,6 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(76.6 * tma_info_system_core_frequency * (MEM_LOAD_=
L3_HIT_RETIRED.XSNP_FWD * (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMA=
ND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD=
))) + 74.6 * tma_info_system_core_frequency * MEM_LOAD_L3_HIT_RETIRED.XSNP_=
MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_=
info_thread_clks",
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
@@ -658,7 +669,7 @@
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
tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store_late=
ncy, tma_streaming_stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_bottleneck_data_cache_memory_bandwi=
dth, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store=
_latency, tma_streaming_stores",
         "ScaleUnit": "100%"
     },
     {
@@ -786,7 +797,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
         "DefaultMetricgroupName": "TopdownL2",
-        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_in=
fo_thread_slots",
+        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
         "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;tma_re=
tiring_group",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
@@ -1297,19 +1308,19 @@
     {
         "BriefDescription": "Off-core accesses per kilo instruction for mo=
dified write requests",
         "MetricExpr": "1e3 * OCR.MODIFIED_WRITE.ANY_RESPONSE / tma_info_in=
st_mix_instructions",
-        "MetricGroup": "Offcore",
+        "MetricGroup": "Offcore;Server",
         "MetricName": "tma_info_memory_mix_offcore_mwrite_any_pki"
     },
     {
         "BriefDescription": "Off-core accesses per kilo instruction for re=
ads-to-core requests (speculative; including in-core HW prefetches)",
         "MetricExpr": "1e3 * OCR.READS_TO_CORE.ANY_RESPONSE / tma_info_ins=
t_mix_instructions",
-        "MetricGroup": "CacheHits;Offcore",
+        "MetricGroup": "CacheHits;Offcore;Server",
         "MetricName": "tma_info_memory_mix_offcore_read_any_pki"
     },
     {
         "BriefDescription": "L3 cache misses per kilo instruction for read=
s-to-core requests (speculative; including in-core HW prefetches)",
         "MetricExpr": "1e3 * OCR.READS_TO_CORE.L3_MISS / tma_info_inst_mix=
_instructions",
-        "MetricGroup": "Offcore",
+        "MetricGroup": "Offcore;Server",
         "MetricName": "tma_info_memory_mix_offcore_read_l3m_pki"
     },
     {
@@ -1335,21 +1346,21 @@
     {
         "BriefDescription": "Average DRAM BW for Reads-to-Core (R2C) cover=
ing for memory attached to local- and remote-socket",
         "MetricExpr": "64 * OCR.READS_TO_CORE.DRAM / 1e9 / tma_info_system=
_time",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
+        "MetricGroup": "HPC;Mem;MemoryBW;Offcore;Server",
         "MetricName": "tma_info_memory_soc_r2c_dram_bw",
         "PublicDescription": "Average DRAM BW for Reads-to-Core (R2C) cove=
ring for memory attached to local- and remote-socket. See R2C_Offcore_BW."
     },
     {
         "BriefDescription": "Average L3-cache miss BW for Reads-to-Core (R=
2C)",
         "MetricExpr": "64 * OCR.READS_TO_CORE.L3_MISS / 1e9 / tma_info_sys=
tem_time",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
+        "MetricGroup": "HPC;Mem;MemoryBW;Offcore;Server",
         "MetricName": "tma_info_memory_soc_r2c_l3m_bw",
         "PublicDescription": "Average L3-cache miss BW for Reads-to-Core (=
R2C). This covering going to DRAM or other memory off-chip memory tears. Se=
e R2C_Offcore_BW."
     },
     {
         "BriefDescription": "Average Off-core access BW for Reads-to-Core =
(R2C)",
         "MetricExpr": "64 * OCR.READS_TO_CORE.ANY_RESPONSE / 1e9 / tma_inf=
o_system_time",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
+        "MetricGroup": "HPC;Mem;MemoryBW;Offcore;Server",
         "MetricName": "tma_info_memory_soc_r2c_offcore_bw",
         "PublicDescription": "Average Off-core access BW for Reads-to-Core=
 (R2C). R2C account for demand or prefetch load/RFO/code access that fill d=
ata into the Core caches."
     },
@@ -1379,7 +1390,7 @@
         "MetricName": "tma_info_memory_tlb_store_stlb_mpki"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Mem;Backend;CacheHits",
         "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
@@ -1426,7 +1437,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * msr@tsc@ / 1e9 =
/ tma_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -1438,16 +1449,28 @@
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized"
     },
+    {
+        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [=
GB / sec]",
+        "MetricExpr": "(64 * UNC_M_PMM_RPQ_INSERTS / 1e9 / tma_info_system=
_time if #has_pmem > 0 else 0)",
+        "MetricGroup": "MemOffcore;MemoryBW;Server;SoC",
+        "MetricName": "tma_info_system_cxl_mem_read_bw"
+    },
+    {
+        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
+        "MetricExpr": "(64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / tma_info_system=
_time if #has_pmem > 0 else 0)",
+        "MetricGroup": "MemOffcore;MemoryBW;Server;SoC",
+        "MetricName": "tma_info_system_cxl_mem_write_bw"
+    },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
         "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / tma_info_system_time",
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_cache_memory_ban=
dwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full"
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_data_cache_memor=
y_bandwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
@@ -1513,7 +1536,6 @@
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (tma_info_system_socket_clks / tma_info_system_t=
ime)",
         "MetricGroup": "Mem;MemoryLat;SoC",
         "MetricName": "tma_info_system_mem_read_latency",
@@ -1674,12 +1696,12 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric([SKL+] roughly; [LNL]) estimates =
fraction of cycles with demand load accesses that hit the L1D cache",
+        "BriefDescription": "This metric ([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache",
         "MetricExpr": "min(2 * (MEM_INST_RETIRED.ALL_LOADS - MEM_LOAD_RETI=
RED.FB_HIT - MEM_LOAD_RETIRED.L1_MISS) * 20 / 100, max(CYCLE_ACTIVITY.CYCLE=
S_MEM_ANY - MEMORY_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_l1_bound=
_group",
         "MetricName": "tma_l1_latency_dependency",
         "MetricThreshold": "tma_l1_latency_dependency > 0.1 & (tma_l1_boun=
d > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache. The s=
hort latency of the L1D cache may be exposed in pointer-chasing memory acce=
ss patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
+        "PublicDescription": "This metric ([SKL+] roughly; [LNL]) estimate=
s fraction of cycles with demand load accesses that hit the L1D cache. The =
short latency of the L1D cache may be exposed in pointer-chasing memory acc=
ess patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
         "ScaleUnit": "100%"
     },
     {
@@ -1693,7 +1715,6 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L2 cache under unloaded scenarios (poss=
ibly L2 latency limited)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "4.4 * tma_info_system_core_frequency * MEM_LOAD_RET=
IRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) =
/ tma_info_thread_clks",
         "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l2_bound_grou=
p",
         "MetricName": "tma_l2_hit_latency",
@@ -1712,12 +1733,11 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "32.6 * tma_info_system_core_frequency * (MEM_LOAD_R=
ETIRED.L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2=
)) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_bottleneck_cache_memory_latency, tma_mem_latency",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_bottleneck_data_cache_memory_latency, tma_mem_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -1800,6 +1820,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (10=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_thread_clks",
         "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
@@ -1832,7 +1853,7 @@
         "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
         "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_bottleneck_cache_memory_bandwidth,=
 tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_bottleneck_data_cache_memory_bandw=
idth, tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
         "ScaleUnit": "100%"
     },
     {
@@ -1841,13 +1862,13 @@
         "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
         "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_bottleneck_cache_memory_latency, tma_l3_hit_latency=
",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_bottleneck_data_cache_memory_latency, tma_l3_hit_la=
tency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
         "DefaultMetricgroupName": "TopdownL2",
-        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_in=
fo_thread_slots",
+        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
         "MetricGroup": "Backend;Default;TmaL2;TopdownL2;tma_L2_group;tma_b=
ackend_bound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
@@ -1857,7 +1878,6 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * MISC2_RETIRED.LFENCE / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_memory_fence",
@@ -1910,7 +1930,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details.",
-        "MetricExpr": "max(IDQ.MS_CYCLES_ANY, cpu@UOPS_RETIRED.MS\\,cmask\=
\=3D1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY)) / tma_info_core_core_clks =
/ 2",
+        "MetricExpr": "max(IDQ.MS_CYCLES_ANY, cpu@UOPS_RETIRED.MS\\,cmask\=
\=3D1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY)) / tma_info_core_core_clks =
/ 2.4",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_fetch_bandwidt=
h_group",
         "MetricName": "tma_ms",
         "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
@@ -1945,6 +1965,7 @@
     },
     {
         "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_i=
nt_operations + tma_memory_operations + tma_fused_instructions + tma_non_fu=
sed_branches))",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_other_light_ops",
@@ -2006,6 +2027,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (EX=
E_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_3_PORTS_UTIL)) / tm=
a_info_thread_clks if ARITH.DIV_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - EXE_=
ACTIVITY.BOUND_ON_LOADS else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EX=
E_ACTIVITY.2_3_PORTS_UTIL) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
@@ -2015,6 +2037,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
+        "MetricConstraint": "NO_THRESHOLD_AND_NMI",
         "MetricExpr": "(EXE_ACTIVITY.EXE_BOUND_0_PORTS + max(RS.EMPTY_RESO=
URCE - RESOURCE_STALLS.SCOREBOARD, 0)) / tma_info_thread_clks * (CYCLE_ACTI=
VITY.STALLS_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
@@ -2024,6 +2047,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricConstraint": "NO_THRESHOLD_AND_NMI",
         "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
@@ -2033,7 +2057,6 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
@@ -2043,7 +2066,6 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_thread_clks",
         "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
@@ -2072,7 +2094,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_=
thread_slots",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
         "MetricGroup": "BvUW;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -2100,7 +2122,6 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_slow_pause",
@@ -2132,7 +2153,7 @@
         "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, tma_m=
em_bandwidth",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_data_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, =
tma_mem_bandwidth",
         "ScaleUnit": "100%"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/floating-point.js=
on b/tools/perf/pmu-events/arch/x86/emeraldrapids/floating-point.json
index 8c9207750c82..bc475e163227 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/floating-point.json
@@ -5,7 +5,6 @@
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FPDIV_ACTIVE",
-        "PublicDescription": "ARITH.FPDIV_ACTIVE Available PDIST counters:=
 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -14,7 +13,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.FP",
-        "PublicDescription": "Counts all microcode Floating Point assists.=
 Available PDIST counters: 0",
+        "PublicDescription": "Counts all microcode Floating Point assists.=
",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -23,7 +22,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.SSE_AVX_MIX",
-        "PublicDescription": "ASSISTS.SSE_AVX_MIX Available PDIST counters=
: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
@@ -32,7 +30,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
-        "PublicDescription": "FP_ARITH_DISPATCHED.PORT_0 [This event is al=
ias to FP_ARITH_DISPATCHED.V0] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -41,7 +38,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
-        "PublicDescription": "FP_ARITH_DISPATCHED.PORT_1 [This event is al=
ias to FP_ARITH_DISPATCHED.V1] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -50,7 +46,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_5",
-        "PublicDescription": "FP_ARITH_DISPATCHED.PORT_5 [This event is al=
ias to FP_ARITH_DISPATCHED.V2] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -59,7 +54,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V0",
-        "PublicDescription": "FP_ARITH_DISPATCHED.V0 [This event is alias =
to FP_ARITH_DISPATCHED.PORT_0] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -68,7 +62,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V1",
-        "PublicDescription": "FP_ARITH_DISPATCHED.V1 [This event is alias =
to FP_ARITH_DISPATCHED.PORT_1] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -77,7 +70,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V2",
-        "PublicDescription": "FP_ARITH_DISPATCHED.V2 [This event is alias =
to FP_ARITH_DISPATCHED.PORT_5] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -86,7 +78,7 @@
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
gister need to be set when using these events. Available PDIST counters: 0"=
,
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -95,7 +87,7 @@
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
e MXCSR register need to be set when using these events. Available PDIST co=
unters: 0",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -104,7 +96,7 @@
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
to be set when using these events. Available PDIST counters: 0",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -113,7 +105,7 @@
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
e MXCSR register need to be set when using these events. Available PDIST co=
unters: 0",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -122,7 +114,7 @@
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
nd FTZ flags in the MXCSR register need to be set when using these events. =
Available PDIST counters: 0",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events."=
,
         "SampleAfterValue": "100003",
         "UMask": "0x18"
     },
@@ -131,7 +123,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE",
-        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14=
 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calc=
ulations per element. The DAZ and FTZ flags in the MXCSR register need to b=
e set when using these events. Available PDIST counters: 0",
+        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14=
 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calc=
ulations per element. The DAZ and FTZ flags in the MXCSR register need to b=
e set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x40"
     },
@@ -140,7 +132,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE",
-        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 16 computation oper=
ations, one for each element.  Applies to SSE* and AVX* packed single preci=
sion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP1=
4 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 cal=
culations per element. The DAZ and FTZ flags in the MXCSR register need to =
be set when using these events. Available PDIST counters: 0",
+        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 16 computation oper=
ations, one for each element.  Applies to SSE* and AVX* packed single preci=
sion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP1=
4 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 cal=
culations per element. The DAZ and FTZ flags in the MXCSR register need to =
be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
@@ -149,7 +141,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.8_FLOPS",
-        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision and 512-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 8 computation operations, one for each element.  Applies =
to SSE* and AVX* packed single precision and double precision floating-poin=
t instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14=
 RCP RCP14 DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice=
 as they perform 2 calculations per element. The DAZ and FTZ flags in the M=
XCSR register need to be set when using these events. Available PDIST count=
ers: 0",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision and 512-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 8 computation operations, one for each element.  Applies =
to SSE* and AVX* packed single precision and double precision floating-poin=
t instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14=
 RCP RCP14 DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice=
 as they perform 2 calculations per element. The DAZ and FTZ flags in the M=
XCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x60"
     },
@@ -158,7 +150,7 @@
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
sing these events. Available PDIST counters: 0",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events.",
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
@@ -167,7 +159,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
-        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events. Available PD=
IST counters: 0",
+        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -176,7 +168,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
-        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events. Av=
ailable PDIST counters: 0",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -185,7 +177,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.VECTOR",
-        "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events. Available PDIST counters: 0",
+        "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events.",
         "SampleAfterValue": "1000003",
         "UMask": "0xfc"
     },
@@ -194,7 +186,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.128B_PACKED_HALF",
-        "PublicDescription": "FP_ARITH_INST_RETIRED2.128B_PACKED_HALF Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -203,7 +194,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.256B_PACKED_HALF",
-        "PublicDescription": "FP_ARITH_INST_RETIRED2.256B_PACKED_HALF Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -212,7 +202,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.512B_PACKED_HALF",
-        "PublicDescription": "FP_ARITH_INST_RETIRED2.512B_PACKED_HALF Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -221,7 +210,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF",
-        "PublicDescription": "FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF A=
vailable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -230,7 +218,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.SCALAR",
-        "PublicDescription": "FP_ARITH_INST_RETIRED2.SCALAR Available PDIS=
T counters: 0",
+        "PublicDescription": "FP_ARITH_INST_RETIRED2.SCALAR",
         "SampleAfterValue": "100003",
         "UMask": "0x3"
     },
@@ -239,7 +227,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.SCALAR_HALF",
-        "PublicDescription": "FP_ARITH_INST_RETIRED2.SCALAR_HALF Available=
 PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -248,7 +235,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.VECTOR",
-        "PublicDescription": "FP_ARITH_INST_RETIRED2.VECTOR Available PDIS=
T counters: 0",
+        "PublicDescription": "FP_ARITH_INST_RETIRED2.VECTOR",
         "SampleAfterValue": "100003",
         "UMask": "0x1c"
     }
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/frontend.json b/t=
ools/perf/pmu-events/arch/x86/emeraldrapids/frontend.json
index 9fe9d62b867a..793c486ffabe 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/frontend.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "BACLEARS.ANY",
-        "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore. A=
vailable PDIST counters: 0",
+        "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13,7 +13,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.LCP",
-        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk. Available PDIS=
T counters: 0",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
         "SampleAfterValue": "500009",
         "UMask": "0x1"
     },
@@ -22,7 +22,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.MS_BUSY",
-        "PublicDescription": "Cycles the Microcode Sequencer is busy. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x2"
     },
@@ -31,7 +30,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
-        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE. Available PDIST counters: =
0",
+        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -249,7 +248,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE_DATA.STALLS",
-        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
         "SampleAfterValue": "500009",
         "UMask": "0x4"
     },
@@ -260,7 +259,6 @@
         "EdgeDetect": "1",
         "EventCode": "0x80",
         "EventName": "ICACHE_DATA.STALL_PERIODS",
-        "PublicDescription": "ICACHE_DATA.STALL_PERIODS Available PDIST co=
unters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x4"
     },
@@ -269,7 +267,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_TAG.STALLS",
-        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
@@ -279,7 +277,7 @@
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_ANY",
-        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -289,7 +287,7 @@
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -298,7 +296,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
-        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path. Availab=
le PDIST counters: 0",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -308,7 +306,7 @@
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_ANY",
-        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB). Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -318,7 +316,7 @@
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB). Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -327,7 +325,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
-        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB). Available PDIST c=
ounters: 0",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -337,7 +335,7 @@
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES_ANY",
-        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE. Avai=
lable PDIST counters: 0",
+        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -348,7 +346,7 @@
         "EdgeDetect": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_SWITCHES",
-        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer. Availab=
le PDIST counters: 0",
+        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -357,7 +355,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
-        "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS). Available PDIST counters: 0",
+        "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS).",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     },
@@ -366,7 +364,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CORE",
-        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE] Available PDI=
ST counters: 0",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -376,7 +374,7 @@
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE",
-        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES=
_0_UOPS_DELIV.CORE] Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES=
_0_UOPS_DELIV.CORE]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -387,7 +385,7 @@
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CYCLES_FE_WAS_OK",
         "Invert": "1",
-        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_N=
OT_DELIVERED.CYCLES_FE_WAS_OK] Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_N=
OT_DELIVERED.CYCLES_FE_WAS_OK]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -396,7 +394,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
-        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_BUBBLES.CORE] Available PDIST counters=
: 0",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_BUBBLES.CORE]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -406,7 +404,7 @@
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
-        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DEL=
IV.CORE] Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DEL=
IV.CORE]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -417,7 +415,7 @@
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
         "Invert": "1",
-        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLE=
S.CYCLES_FE_WAS_OK] Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLE=
S.CYCLES_FE_WAS_OK]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json b/too=
ls/perf/pmu-events/arch/x86/emeraldrapids/memory.json
index 7c3f9b76d367..5e6c1f05c981 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json
@@ -5,7 +5,6 @@
         "CounterMask": "6",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
-        "PublicDescription": "Execution stalls while L3 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
@@ -14,7 +13,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -24,7 +23,6 @@
         "CounterMask": "2",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
-        "PublicDescription": "Cycles while L1 cache miss demand load is ou=
tstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -34,7 +32,6 @@
         "CounterMask": "3",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
-        "PublicDescription": "Execution stalls while L1 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
@@ -44,7 +41,7 @@
         "CounterMask": "5",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
-        "PublicDescription": "Execution stalls while L2 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock). Available PDIST counters: 0",
+        "PublicDescription": "Execution stalls while L2 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock).",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -54,7 +51,7 @@
         "CounterMask": "9",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
-        "PublicDescription": "Execution stalls while L3 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock). Available PDIST counters: 0",
+        "PublicDescription": "Execution stalls while L3 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock).",
         "SampleAfterValue": "1000003",
         "UMask": "0x9"
     },
@@ -478,7 +475,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
-        "PublicDescription": "Counts demand data read requests that miss t=
he L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -487,7 +483,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD"=
,
-        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache. Available PDIST counters: 0",
+        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -505,7 +501,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_EVENTS",
-        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to none of the previous 3 categories (e.g. interrupt). Availabl=
e PDIST counters: 0",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to none of the previous 3 categories (e.g. interrupt).",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
@@ -514,7 +510,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MEM",
-        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to various memory events (e.g. read/write capacity and conflict=
s). Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to various memory events (e.g. read/write capacity and conflict=
s).",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -523,7 +519,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MEMTYPE",
-        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to incompatible memory type. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to incompatible memory type.",
         "SampleAfterValue": "100003",
         "UMask": "0x40"
     },
@@ -532,7 +528,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_UNFRIENDLY",
-        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to HLE-unfriendly instructions. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to HLE-unfriendly instructions.",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -541,7 +537,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.COMMIT",
-        "PublicDescription": "Counts the number of times RTM commit succee=
ded. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of times RTM commit succee=
ded.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -550,7 +546,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.START",
-        "PublicDescription": "Counts the number of times we entered an RTM=
 region. Does not count nested transactions. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of times we entered an RTM=
 region. Does not count nested transactions.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -559,7 +555,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CAPACITY_READ",
-        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional reads Available PDIST counters: 0",
+        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional reads",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
@@ -568,7 +564,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
-        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional writes. Available PDIST counters: 0",
+        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional writes.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -577,7 +573,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CONFLICT",
-        "PublicDescription": "Counts the number of times a TSX line had a =
cache conflict. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of times a TSX line had a =
cache conflict.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/other.json b/tool=
s/perf/pmu-events/arch/x86/emeraldrapids/other.json
index a58d65556609..21f49f609ed4 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/other.json
@@ -4,10 +4,34 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.PAGE_FAULT",
-        "PublicDescription": "ASSISTS.PAGE_FAULT Available PDIST counters:=
 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
+    {
+        "BriefDescription": "HW_INTERRUPTS.MASKED",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcb",
+        "EventName": "HW_INTERRUPTS.MASKED",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "HW_INTERRUPTS.PENDING_AND_MASKED",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcb",
+        "EventName": "HW_INTERRUPTS.PENDING_AND_MASKED",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of hardware interrupts received by the=
 processor.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcb",
+        "EventName": "HW_INTERRUPTS.RECEIVED",
+        "PublicDescription": "Counts the number of hardware interruptions =
received by the processor.",
+        "SampleAfterValue": "203",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3",
@@ -25,7 +49,7 @@
         "CounterMask": "1",
         "EventCode": "0x2d",
         "EventName": "XQ.FULL_CYCLES",
-        "PublicDescription": "number of cycles when the thread is active a=
nd the uncore cannot take any further requests (for example prefetches, loa=
ds or stores initiated by the Core that miss the L2 cache). Available PDIST=
 counters: 0",
+        "PublicDescription": "number of cycles when the thread is active a=
nd the uncore cannot take any further requests (for example prefetches, loa=
ds or stores initiated by the Core that miss the L2 cache).",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
index 48bec483b49a..1fa7957956df 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
@@ -6,7 +6,6 @@
         "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIVIDER_ACTIVE",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 ARITH.DIV_ACTIVE Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x9"
     },
@@ -16,7 +15,7 @@
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIV_ACTIVE",
-        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
         "SampleAfterValue": "1000003",
         "UMask": "0x9"
     },
@@ -27,7 +26,6 @@
         "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FP_DIVIDER_ACTIVE",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 ARITH.FPDIV_ACTIVE Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -37,7 +35,6 @@
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.IDIV_ACTIVE",
-        "PublicDescription": "This event counts the cycles the integer div=
ider is busy. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -48,7 +45,6 @@
         "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.INT_DIVIDER_ACTIVE",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 ARITH.IDIV_ACTIVE Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -57,7 +53,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.ANY",
-        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists.",
         "SampleAfterValue": "100003",
         "UMask": "0x1b"
     },
@@ -217,7 +213,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C01",
-        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions. Availab=
le PDIST counters: 0",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -226,7 +222,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C02",
-        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions. Availab=
le PDIST counters: 0",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -235,7 +231,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
-        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction. Available PDIST counters: 0",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
         "SampleAfterValue": "2000003",
         "UMask": "0x70"
     },
@@ -244,7 +240,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
-        "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread. Available PDIST counters: 0",
+        "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -253,7 +249,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
-        "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted. Available PDIST counte=
rs: 0",
+        "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
         "SampleAfterValue": "25003",
         "UMask": "0x2"
     },
@@ -262,7 +258,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE",
-        "PublicDescription": "CPU_CLK_UNHALTED.PAUSE Available PDIST count=
ers: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     },
@@ -273,7 +268,6 @@
         "EdgeDetect": "1",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
-        "PublicDescription": "CPU_CLK_UNHALTED.PAUSE_INST Available PDIST =
counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     },
@@ -282,7 +276,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
-        "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread. Available PDIST counters: 0",
+        "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -299,7 +293,7 @@
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
the counter value is less than MAX. Software should ignore this case. Avail=
able PDIST counters: 0",
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
the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -316,7 +310,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. Available PDIST counters: 0",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
         "SampleAfterValue": "2000003"
     },
     {
@@ -325,7 +319,6 @@
         "CounterMask": "8",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
-        "PublicDescription": "Cycles while L1 cache miss demand load is ou=
tstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -335,7 +328,6 @@
         "CounterMask": "1",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
-        "PublicDescription": "Cycles while L2 cache miss demand load is ou=
tstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -345,7 +337,6 @@
         "CounterMask": "16",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
-        "PublicDescription": "Cycles while memory subsystem has an outstan=
ding load. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
@@ -355,7 +346,6 @@
         "CounterMask": "12",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
-        "PublicDescription": "Execution stalls while L1 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0xc"
     },
@@ -365,7 +355,6 @@
         "CounterMask": "5",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
-        "PublicDescription": "Execution stalls while L2 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -375,7 +364,6 @@
         "CounterMask": "4",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
-        "PublicDescription": "Total execution stalls. Available PDIST coun=
ters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -384,7 +372,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb7",
         "EventName": "EXE.AMX_BUSY",
-        "PublicDescription": "Counts the cycles where the AMX (Advance Mat=
rix Extension) unit is busy performing an operation. Available PDIST counte=
rs: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -393,7 +380,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
-        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty. Avail=
able PDIST counters: 0",
+        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -402,7 +389,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.2_3_PORTS_UTIL",
-        "PublicDescription": "Cycles total of 2 or 3 uops are executed on =
all ports and Reservation Station (RS) was not empty. Available PDIST count=
ers: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0xc"
     },
@@ -411,7 +397,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
-        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty. Ava=
ilable PDIST counters: 0",
+        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -420,7 +406,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
-        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty. Available PDIST counters: =
0",
+        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -429,7 +415,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
-        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty. Available PDIST counters: =
0",
+        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -439,7 +425,6 @@
         "CounterMask": "5",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
-        "PublicDescription": "Execution stalls while memory subsystem has =
an outstanding load. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x21"
     },
@@ -449,7 +434,7 @@
         "CounterMask": "2",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
-        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
         "SampleAfterValue": "1000003",
         "UMask": "0x40"
     },
@@ -458,7 +443,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
-        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load. Available PDIST counters: 0"=
,
+        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
         "SampleAfterValue": "1000003",
         "UMask": "0x80"
     },
@@ -467,7 +452,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x75",
         "EventName": "INST_DECODED.DECODERS",
-        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions. Available PDIST cou=
nters: 0",
+        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -492,7 +477,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
-        "PublicDescription": "INST_RETIRED.MACRO_FUSED Available PDIST cou=
nters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -501,7 +485,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
-        "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions Available PDIST counters: 0",
+        "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -518,7 +502,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent. Available PDIST counters: 0",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -529,7 +513,7 @@
         "EdgeDetect": "1",
         "EventCode": "0xad",
         "EventName": "INT_MISC.CLEARS_COUNT",
-        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears Available PDIST count=
ers: 0",
+        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears",
         "SampleAfterValue": "500009",
         "UMask": "0x1"
     },
@@ -538,7 +522,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
-        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
. Available PDIST counters: 0",
+        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
         "SampleAfterValue": "500009",
         "UMask": "0x80"
     },
@@ -547,7 +531,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.MBA_STALLS",
-        "PublicDescription": "INT_MISC.MBA_STALLS Available PDIST counters=
: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     },
@@ -556,7 +539,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
-        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event. Available PDIST counters: 0",
+        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
         "SampleAfterValue": "500009",
         "UMask": "0x1"
     },
@@ -567,7 +550,6 @@
         "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x7",
-        "PublicDescription": "Bubble cycles of BAClear (Unknown Branch). A=
vailable PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x40"
     },
@@ -576,7 +558,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UOP_DROPPING",
-        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons Available P=
DIST counters: 0",
+        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
@@ -585,7 +567,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.128BIT",
-        "PublicDescription": "INT_VEC_RETIRED.128BIT Available PDIST count=
ers: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x13"
     },
@@ -594,7 +575,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.256BIT",
-        "PublicDescription": "INT_VEC_RETIRED.256BIT Available PDIST count=
ers: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0xac"
     },
@@ -603,7 +583,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_128",
-        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions. Available PDIST counters: 0=
",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
@@ -612,7 +592,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_256",
-        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions. Available PDIST counters: 0=
",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0xc"
     },
@@ -621,7 +601,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.MUL_256",
-        "PublicDescription": "INT_VEC_RETIRED.MUL_256 Available PDIST coun=
ters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x80"
     },
@@ -630,7 +609,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.SHUFFLES",
-        "PublicDescription": "INT_VEC_RETIRED.SHUFFLES Available PDIST cou=
nters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x40"
     },
@@ -639,7 +617,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_128",
-        "PublicDescription": "INT_VEC_RETIRED.VNNI_128 Available PDIST cou=
nters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
@@ -648,7 +625,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_256",
-        "PublicDescription": "INT_VEC_RETIRED.VNNI_256 Available PDIST cou=
nters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     },
@@ -657,7 +633,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
-        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address. Avail=
able PDIST counters: 0",
+        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -666,7 +642,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
-        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
         "SampleAfterValue": "100003",
         "UMask": "0x88"
     },
@@ -675,7 +651,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
         "SampleAfterValue": "100003",
         "UMask": "0x82"
     },
@@ -684,7 +660,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
-        "PublicDescription": "Counts all software-prefetch load dispatches=
 that hit the fill buffer (FB) allocated for the software prefetch. It can =
also be incremented by some lock instructions. So it should only be used wi=
th profiling so that the locks can be excluded by ASM (Assembly File) inspe=
ction of the nearby instructions. Available PDIST counters: 0",
+        "PublicDescription": "Counts all software-prefetch load dispatches=
 that hit the fill buffer (FB) allocated for the software prefetch. It can =
also be incremented by some lock instructions. So it should only be used wi=
th profiling so that the locks can be excluded by ASM (Assembly File) inspe=
ction of the nearby instructions.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -694,7 +670,7 @@
         "CounterMask": "1",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_ACTIVE",
-        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector). Available PDIST counters: 0",
+        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -704,7 +680,7 @@
         "CounterMask": "6",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_OK",
-        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector). Available PDIST counters:=
 0",
+        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -713,7 +689,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa8",
         "EventName": "LSD.UOPS",
-        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector). Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -724,7 +700,7 @@
         "EdgeDetect": "1",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.COUNT",
-        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -733,7 +709,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SMC",
-        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear. Available PDIST counters: 0",
+        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -742,7 +718,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe0",
         "EventName": "MISC2_RETIRED.LFENCE",
-        "PublicDescription": "number of LFENCE retired instructions Availa=
ble PDIST counters: 0",
+        "PublicDescription": "number of LFENCE retired instructions",
         "SampleAfterValue": "400009",
         "UMask": "0x20"
     },
@@ -751,7 +727,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcc",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT. Available PDIST counters: 0",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -760,7 +736,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SB",
-        "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end. Available PDIST counters: 0",
+        "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -769,7 +745,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SCOREBOARD",
-        "PublicDescription": "Counts cycles where the pipeline is stalled =
due to serializing operations. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -778,7 +753,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa5",
         "EventName": "RS.EMPTY",
-        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses) Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
         "SampleAfterValue": "1000003",
         "UMask": "0x7"
     },
@@ -790,7 +765,7 @@
         "EventCode": "0xa5",
         "EventName": "RS.EMPTY_COUNT",
         "Invert": "1",
-        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events) Av=
ailable PDIST counters: 0",
+        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
         "SampleAfterValue": "100003",
         "UMask": "0x7"
     },
@@ -799,7 +774,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa5",
         "EventName": "RS.EMPTY_RESOURCE",
-        "PublicDescription": "Cycles when Reservation Station (RS) is empt=
y due to a resource in the back-end Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -812,7 +786,6 @@
         "EventCode": "0xa5",
         "EventName": "RS_EMPTY.COUNT",
         "Invert": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 RS.EMPTY_COUNT Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x7"
     },
@@ -822,7 +795,6 @@
         "Deprecated": "1",
         "EventCode": "0xa5",
         "EventName": "RS_EMPTY.CYCLES",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 RS.EMPTY Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x7"
     },
@@ -831,7 +803,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
-        "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources. Available PDIST counters: 0",
+        "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources.",
         "SampleAfterValue": "10000003",
         "UMask": "0x2"
     },
@@ -840,7 +812,7 @@
         "Counter": "0",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
-        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations. Available PDIST counters: 0",
+        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
         "SampleAfterValue": "10000003",
         "UMask": "0x4"
     },
@@ -849,7 +821,7 @@
         "Counter": "0",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
-        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction. Ava=
ilable PDIST counters: 0",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
         "SampleAfterValue": "10000003",
         "UMask": "0x8"
     },
@@ -858,7 +830,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
-        "PublicDescription": "TOPDOWN.MEMORY_BOUND_SLOTS Available PDIST c=
ounters: 0",
         "SampleAfterValue": "10000003",
         "UMask": "0x10"
     },
@@ -875,7 +846,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.SLOTS_P",
-        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
         "SampleAfterValue": "10000003",
         "UMask": "0x1"
     },
@@ -884,7 +855,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x76",
         "EventName": "UOPS_DECODED.DEC0_UOPS",
-        "PublicDescription": "UOPS_DECODED.DEC0_UOPS Available PDIST count=
ers: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -893,7 +863,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_0",
-        "PublicDescription": "Number of uops dispatch to execution  port 0=
. Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution  port 0=
.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -902,7 +872,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_1",
-        "PublicDescription": "Number of uops dispatch to execution  port 1=
. Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution  port 1=
.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -911,7 +881,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_2_3_10",
-        "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10 Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -920,7 +890,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_4_9",
-        "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9 Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -929,7 +899,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_5_11",
-        "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11 Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -938,7 +908,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_6",
-        "PublicDescription": "Number of uops dispatch to execution  port 6=
. Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution  port 6=
.",
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     },
@@ -947,7 +917,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_7_8",
-        "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8. Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8.",
         "SampleAfterValue": "2000003",
         "UMask": "0x80"
     },
@@ -956,7 +926,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE",
-        "PublicDescription": "Counts the number of uops executed from any =
thread. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of uops executed from any =
thread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -966,7 +936,7 @@
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
-        "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -976,7 +946,7 @@
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
-        "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -986,7 +956,7 @@
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
-        "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -996,7 +966,7 @@
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
-        "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -1006,7 +976,7 @@
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
-        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread. Available PDIST counters: 0",
+        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1016,7 +986,7 @@
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
-        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread. Available PDIST counters: 0",
+        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1026,7 +996,7 @@
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
-        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread. Available PDIST counters: 0",
+        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1036,7 +1006,7 @@
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
-        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread. Available PDIST counters: 0",
+        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1047,7 +1017,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALLS",
         "Invert": "1",
-        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread. Available PDIST counte=
rs: 0",
+        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1059,7 +1029,6 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALL_CYCLES",
         "Invert": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UOPS_EXECUTED.STALLS Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1068,7 +1037,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.THREAD",
-        "PublicDescription": "Counts the number of uops to be executed per=
-thread each cycle. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1077,7 +1045,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.X87",
-        "PublicDescription": "Counts the number of x87 uops executed. Avai=
lable PDIST counters: 0",
+        "PublicDescription": "Counts the number of x87 uops executed.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -1086,7 +1054,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xae",
         "EventName": "UOPS_ISSUED.ANY",
-        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS). Available PD=
IST counters: 0",
+        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1096,7 +1064,6 @@
         "CounterMask": "1",
         "EventCode": "0xae",
         "EventName": "UOPS_ISSUED.CYCLES",
-        "PublicDescription": "UOPS_ISSUED.CYCLES Available PDIST counters:=
 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1106,7 +1073,7 @@
         "CounterMask": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.CYCLES",
-        "PublicDescription": "Counts cycles where at least one uop has ret=
ired. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles where at least one uop has ret=
ired.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -1115,7 +1082,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.HEAVY",
-        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count. Available P=
DIST counters: 0",
+        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1126,7 +1093,6 @@
         "EventName": "UOPS_RETIRED.MS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
-        "PublicDescription": "UOPS_RETIRED.MS Available PDIST counters: 0"=
,
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -1135,7 +1101,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.SLOTS",
-        "PublicDescription": "Counts the retirement slots used each cycle.=
 Available PDIST counters: 0",
+        "PublicDescription": "Counts the retirement slots used each cycle.=
",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -1146,7 +1112,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALLS",
         "Invert": "1",
-        "PublicDescription": "This event counts cycles without actually re=
tired uops. Available PDIST counters: 0",
+        "PublicDescription": "This event counts cycles without actually re=
tired uops.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -1158,7 +1124,6 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
         "Invert": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UOPS_RETIRED.STALLS Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     }
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.jso=
n b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.json
index 68be01dad7c9..90f61c9511fc 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.json
@@ -2769,6 +2769,88 @@
         "UMask": "0x3",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x45",
+        "EventName": "UNC_M_DRAM_REFRESH.HIGH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of DRAM Refreshes Issued : Counts the=
 number of refreshes issued.",
+        "UMask": "0x24",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x45",
+        "EventName": "UNC_M_DRAM_REFRESH.HIGH_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x45",
+        "EventName": "UNC_M_DRAM_REFRESH.HIGH_PCH0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x45",
+        "EventName": "UNC_M_DRAM_REFRESH.HIGH_PCH1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x45",
+        "EventName": "UNC_M_DRAM_REFRESH.PANIC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of DRAM Refreshes Issued : Counts the=
 number of refreshes issued.",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x45",
+        "EventName": "UNC_M_DRAM_REFRESH.PANIC_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x45",
+        "EventName": "UNC_M_DRAM_REFRESH.PANIC_PCH0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x45",
+        "EventName": "UNC_M_DRAM_REFRESH.PANIC_PCH1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "ECC Correctable Errors",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/virtual-memory.js=
on b/tools/perf/pmu-events/arch/x86/emeraldrapids/virtual-memory.json
index 3d3f88600e26..609a9549cbf3 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/virtual-memory.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
-        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB). Available PDIST counters: 0",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -14,7 +14,7 @@
         "CounterMask": "1",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
-        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load. Available PDIST cou=
nters: 0",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -23,7 +23,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
-        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault. Available =
PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
         "UMask": "0xe"
     },
@@ -32,7 +32,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
-        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -41,7 +41,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
-        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -50,7 +50,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
-        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -59,7 +59,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle. Available PDIS=
T counters: 0",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -68,7 +68,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
-        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB). Available PDIST counters: 0",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -78,7 +78,7 @@
         "CounterMask": "1",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
-        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store. Available PDIST counters:=
 0",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -87,7 +87,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
-        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault. Available=
 PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
         "UMask": "0xe"
     },
@@ -96,7 +96,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
-        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -105,7 +105,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
-        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -114,7 +114,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
-        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -123,7 +123,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle. Available PDIST coun=
ters: 0",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -132,7 +132,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.STLB_HIT",
-        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB). Available P=
DIST counters: 0",
+        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -142,7 +142,7 @@
         "CounterMask": "1",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_ACTIVE",
-        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -151,7 +151,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
-        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
         "UMask": "0xe"
     },
@@ -160,7 +160,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
-        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -169,7 +169,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
-        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
 Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -178,7 +178,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     }
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 12017f568606..e3ac2dede20a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -9,7 +9,7 @@ GenuineIntel-6-4F,v23,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.25,cascadelakex,core
 GenuineIntel-6-DD,v1.00,clearwaterforest,core
 GenuineIntel-6-9[6C],v1.05,elkhartlake,core
-GenuineIntel-6-CF,v1.14,emeraldrapids,core
+GenuineIntel-6-CF,v1.16,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.09,grandridge,core
--=20
2.50.0.727.gbf7dc18ff4-goog


