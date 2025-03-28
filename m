Return-Path: <linux-kernel+bounces-580271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70F6A74FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 18:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A051789C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 17:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821771E7C3F;
	Fri, 28 Mar 2025 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXQhq+d8"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEAC1DE89C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184253; cv=none; b=A6vjACSLtWQIweqqm+GrP02ZA9L5/dKNs+wKvDR5RUK+yjG3qroN2E+Hi7nLvGj1Z4u0kk8nWnw6HJQWCJZHJm0PWNn4kNX+LNbNN35iCcV9mAYJ3alXG13mSpROT1c5NDYpNFsyuVIoPW/2ykNrUTsFkkV0M94j19v3ZC6zXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184253; c=relaxed/simple;
	bh=rkvVl/Q+qYiwXKQ//61u4Zw/6nRhvM6zT8ukW7RErfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lt0PCGcek4aW+VQKFAvrE07PJqj6VXgIEwfC0Dt+ijxTl87sIEabmIvcmkvwyue9D0neS+0BLsMgAXGfoYGiD4MfD28eycpQSqF5RM3LMm/usql/5XJ82/5cTvNF0DE5kLZgC9E02Q0/hpAtH23/SL410VP/BjbTpe3+SgqVvcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXQhq+d8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso4340176a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743184244; x=1743789044; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3WcPhFkskxjE/YuDzOyZCYFRFnRR8kF1HIb1Zi7W2k=;
        b=cXQhq+d8hjbL7pyAGbauuiu63TNbWRkDe/VLjyIS3/viZRYE1X8GPVC2BgEP5x9Vje
         IKWrM6qIwC0xeQh4VBfgE8siZ6Q5GsIsuQvHbkrdYZy4bLD6pIa6hTSE9qY8Mpti+1eI
         d0NbzsGSQ8iEjrC3ZZTFhLbFpTeDqBiru6HWElkuk3l91J0OR1lsoYbKKCoqtiBv8Ipt
         zQCa9TuN6G5W4jf3P8XKjT3QKGinNLrtDcUbne+Gb/x3IMbgejEfcwM/oSelQxUzyJXZ
         z6p2MMlYRh73eV9cq1tMRB0vUNudYGxFl2UhXgMxNHaM70lCdDErW3KUsPSlnpm7P25X
         Duag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743184244; x=1743789044;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y3WcPhFkskxjE/YuDzOyZCYFRFnRR8kF1HIb1Zi7W2k=;
        b=a5dGc9ugwQbzn97SFmVutUDTOG0Z6r8db/eSoOxFYQzGtcVnc+jie5icZrzLjIMEIB
         2yZMwP8CM/Tx3M7JUPuxtTc1IbdGH1aF1+SMiDmp9CJHMFr4glqt7a5MktUm4BE2d6RW
         xx9CvIS38z8vG/qH9ouMCMptpJ1ycxYH6qGTZtBR5VOxI0WWgZX/Pf4llAb5AVQSC0ZI
         uPZh2AVIgQ7DGGK+o1k0eeUjpYNPqN67SBPWYNXNur2wLFYIYOnzrQB4rlXD2Ce+UY0v
         LR2+H4gx1gCoMJM/9c6Q3xRYZQMEDnucedNo7FTeN0Xywk+gndn0fC/kE+oAEjPZ9Ksu
         rlsw==
X-Forwarded-Encrypted: i=1; AJvYcCU0AUY6Yv9uBsyLNheCaWHz0m4/oG9PqC27HvgmpYU4QduehZXT0v3jdlT7P/eYDYzBO0DAq8D64DPQ0ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywye4KJmJUOlIRozMSLjm/UlHEPBKxw+/Sxk9ZuwEzRRI9y7YXI
	Kxd2n7SzvzPEpOo2bwayXhHBhYMYEY5cdZjCJe3U65xbZMIgMCDEN9omQJctIpKEZK8ujsEFbjz
	91c4NbQ==
X-Google-Smtp-Source: AGHT+IEyp+JxGND1jy4nKKLaWXyzHyqASxZqCSwp9WAdz+/RT28y2dhBtHgILb5K//5JXTrXABlH0Kno3JVD
X-Received: from pjyp8.prod.google.com ([2002:a17:90a:e708:b0:2ef:78ff:bc3b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:43:b0:2ff:58e1:2bc9
 with SMTP id 98e67ed59e1d1-30532145956mr225599a91.25.1743184244374; Fri, 28
 Mar 2025 10:50:44 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:49:41 -0700
In-Reply-To: <20250328175006.43110-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328175006.43110-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328175006.43110-11-irogers@google.com>
Subject: [PATCH v5 10/35] perf vendor events: Update elkhartlake events
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

Update event topic moving other topic events to cache and memory. Add
PDIST counter into descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/elkhartlake/cache.json           | 296 ++++++++++++-
 .../arch/x86/elkhartlake/floating-point.json  |   1 +
 .../arch/x86/elkhartlake/memory.json          | 261 +++++++++++
 .../arch/x86/elkhartlake/other.json           | 404 +-----------------
 .../arch/x86/elkhartlake/pipeline.json        |  31 +-
 .../arch/x86/elkhartlake/virtual-memory.json  |   4 +
 6 files changed, 595 insertions(+), 402 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/cache.json b/tools/=
perf/pmu-events/arch/x86/elkhartlake/cache.json
index 7882dca9d5e1..3410caf8a57a 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/cache.json
@@ -161,6 +161,7 @@
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of load uops retired that =
hit in DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
@@ -171,6 +172,7 @@
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HITM",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of load uops retired that =
hit in the L3 cache, in which a snoop was required and modified data was fo=
rwarded from another core or module. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
@@ -181,6 +183,7 @@
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of load uops retired that =
hit in the L1 data cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
@@ -191,6 +194,7 @@
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of load uops retired that =
miss in the L1 data cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
@@ -201,6 +205,7 @@
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of load uops retired that =
hit in the L2 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
@@ -211,6 +216,7 @@
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of load uops retired that =
miss in the L2 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
@@ -221,6 +227,7 @@
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of load uops retired that =
hit in the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
@@ -231,7 +238,7 @@
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL",
         "PEBS": "1",
-        "PublicDescription": "Counts the number of memory uops retired.  A=
 single uop that performs both a load AND a store will be counted as 1, not=
 2 (e.g. ADD [mem], CONST)",
+        "PublicDescription": "Counts the number of memory uops retired.  A=
 single uop that performs both a load AND a store will be counted as 1, not=
 2 (e.g. ADD [mem], CONST) Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x83"
     },
@@ -242,7 +249,7 @@
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "1",
-        "PublicDescription": "Counts the total number of load uops retired=
.",
+        "PublicDescription": "Counts the total number of load uops retired=
. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x81"
     },
@@ -253,7 +260,7 @@
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PEBS": "1",
-        "PublicDescription": "Counts the total number of store uops retire=
d.",
+        "PublicDescription": "Counts the total number of store uops retire=
d. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x82"
     },
@@ -264,6 +271,7 @@
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of load uops retired that =
performed one or more locks. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x21"
     },
@@ -274,6 +282,7 @@
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of memory uops retired tha=
t were splits. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x43"
     },
@@ -284,6 +293,7 @@
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of retired split load uops=
. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x41"
     },
@@ -294,6 +304,7 @@
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of retired split store uop=
s. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x42"
     },
@@ -304,6 +315,7 @@
         "EventName": "OCR.ALL_CODE_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0044",
+        "PublicDescription": "Counts all code reads that were supplied by =
the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -314,6 +326,7 @@
         "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0044",
+        "PublicDescription": "Counts all code reads that were supplied by =
the L3 cache where a snoop was sent, the snoop hit, and modified data was f=
orwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -324,6 +337,7 @@
         "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0044",
+        "PublicDescription": "Counts all code reads that were supplied by =
the L3 cache where a snoop was sent, the snoop hit, but no data was forward=
ed. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -334,6 +348,7 @@
         "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0044",
+        "PublicDescription": "Counts all code reads that were supplied by =
the L3 cache where a snoop was sent, the snoop hit, and non-modified data w=
as forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -344,6 +359,7 @@
         "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0044",
+        "PublicDescription": "Counts all code reads that were supplied by =
the L3 cache where a snoop was sent but the snoop missed. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -354,6 +370,18 @@
         "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0044",
+        "PublicDescription": "Counts all code reads that were supplied by =
the L3 cache where no snoop was needed to satisfy the request. Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.COREWB_M.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3000000010000",
+        "PublicDescription": "Counts modified writebacks from L1 cache and=
 L2 cache that have any type of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -364,6 +392,29 @@
         "EventName": "OCR.COREWB_M.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3001F803C0000",
+        "PublicDescription": "Counts modified writebacks from L1 cache and=
 L2 cache that were supplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have an outstanding request. Returns the number of cycles unt=
il the response is received (i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.COREWB_M.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8003000000000000",
+        "PublicDescription": "Counts modified writebacks from L1 cache and=
 L2 cache that have an outstanding request. Returns the number of cycles un=
til the response is received (i.e. XQ to XQ latency). Available PDIST count=
ers: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that have any type of response. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -374,6 +425,7 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by the L3 cache. Available PDI=
ST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -384,6 +436,7 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by the L3 cache where a snoop =
was sent, the snoop hit, and modified data was forwarded. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -394,6 +447,7 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by the L3 cache where a snoop =
was sent, the snoop hit, but no data was forwarded. Available PDIST counter=
s: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -404,6 +458,7 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by the L3 cache where a snoop =
was sent, the snoop hit, and non-modified data was forwarded. Available PDI=
ST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -414,6 +469,7 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by the L3 cache where a snoop =
was sent but the snoop missed. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -424,6 +480,18 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by the L3 cache where no snoop=
 was needed to satisfy the request. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that ha=
ve any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "PublicDescription": "Counts cacheable demand data reads, L1 data =
cache hardware prefetches and software prefetches (except PREFETCHW) that h=
ave any type of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -434,6 +502,7 @@
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0001",
+        "PublicDescription": "Counts cacheable demand data reads, L1 data =
cache hardware prefetches and software prefetches (except PREFETCHW) that w=
ere supplied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -444,6 +513,7 @@
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
+        "PublicDescription": "Counts cacheable demand data reads, L1 data =
cache hardware prefetches and software prefetches (except PREFETCHW) that w=
ere supplied by the L3 cache where a snoop was sent, the snoop hit, and mod=
ified data was forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -454,6 +524,7 @@
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_NO_FWD"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0001",
+        "PublicDescription": "Counts cacheable demand data reads, L1 data =
cache hardware prefetches and software prefetches (except PREFETCHW) that w=
ere supplied by the L3 cache where a snoop was sent, the snoop hit, but no =
data was forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -464,6 +535,7 @@
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_WITH_FW=
D",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0001",
+        "PublicDescription": "Counts cacheable demand data reads, L1 data =
cache hardware prefetches and software prefetches (except PREFETCHW) that w=
ere supplied by the L3 cache where a snoop was sent, the snoop hit, and non=
-modified data was forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -474,6 +546,7 @@
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0001",
+        "PublicDescription": "Counts cacheable demand data reads, L1 data =
cache hardware prefetches and software prefetches (except PREFETCHW) that w=
ere supplied by the L3 cache where a snoop was sent but the snoop missed. A=
vailable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -484,6 +557,30 @@
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_NOT_NEEDED"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0001",
+        "PublicDescription": "Counts cacheable demand data reads, L1 data =
cache hardware prefetches and software prefetches (except PREFETCHW) that w=
ere supplied by the L3 cache where no snoop was needed to satisfy the reque=
st. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that ha=
ve an outstanding request. Returns the number of cycles until the response =
is received (i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000001",
+        "PublicDescription": "Counts cacheable demand data reads, L1 data =
cache hardware prefetches and software prefetches (except PREFETCHW) that h=
ave an outstanding request. Returns the number of cycles until the response=
 is received (i.e. XQ to XQ latency). Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -495,6 +592,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0001",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -506,6 +604,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HITM Available PDIST counters: 0"=
,
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -517,6 +616,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0001",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_NO_FWD Available PDIST counte=
rs: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -528,6 +628,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0001",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_WITH_FWD Available PDIST coun=
ters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -539,6 +640,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0001",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_MISS Available PDIST counters: 0"=
,
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -550,6 +652,30 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0001",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_NOT_NEEDED Available PDIST counte=
rs: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000001",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that have any type =
of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -560,6 +686,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were supplied =
by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -570,6 +697,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were supplied =
by the L3 cache where a snoop was sent, the snoop hit, and modified data wa=
s forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -580,6 +708,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were supplied =
by the L3 cache where a snoop was sent, the snoop hit, but no data was forw=
arded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -590,6 +719,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were supplied =
by the L3 cache where a snoop was sent, the snoop hit, and non-modified dat=
a was forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -600,6 +730,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were supplied =
by the L3 cache where a snoop was sent but the snoop missed. Available PDIS=
T counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -610,6 +741,18 @@
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were supplied =
by the L3 cache where no snoop was needed to satisfy the request. Available=
 PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have an outstan=
ding request. Returns the number of cycles until the response is received (=
i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that have an outsta=
nding request. Returns the number of cycles until the response is received =
(i.e. XQ to XQ latency). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -620,6 +763,18 @@
         "EventName": "OCR.FULL_STREAMING_WR.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x801F803C0000",
+        "PublicDescription": "Counts streaming stores which modify a full =
64 byte cacheline that were supplied by the L3 cache. Available PDIST count=
ers: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache hardware prefetches and =
software prefetches (except PREFETCHW and PFRFO) that have any type of resp=
onse.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L1D_AND_SWPF.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10400",
+        "PublicDescription": "Counts L1 data cache hardware prefetches and=
 software prefetches (except PREFETCHW and PFRFO) that have any type of res=
ponse. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -630,6 +785,18 @@
         "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0400",
+        "PublicDescription": "Counts L1 data cache hardware prefetches and=
 software prefetches (except PREFETCHW and PFRFO) that were supplied by the=
 L3 cache where a snoop was sent, the snoop hit, and modified data was forw=
arded. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10040",
+        "PublicDescription": "Counts L2 cache hardware prefetch code reads=
 (written to the L2 cache only) that have any type of response. Available P=
DIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -640,6 +807,7 @@
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0040",
+        "PublicDescription": "Counts L2 cache hardware prefetch code reads=
 (written to the L2 cache only) that were supplied by the L3 cache. Availab=
le PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -650,6 +818,7 @@
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0040",
+        "PublicDescription": "Counts L2 cache hardware prefetch code reads=
 (written to the L2 cache only) that were supplied by the L3 cache where a =
snoop was sent, the snoop hit, and modified data was forwarded. Available P=
DIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -660,6 +829,7 @@
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0040",
+        "PublicDescription": "Counts L2 cache hardware prefetch code reads=
 (written to the L2 cache only) that were supplied by the L3 cache where a =
snoop was sent, the snoop hit, but no data was forwarded. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -670,6 +840,7 @@
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0040",
+        "PublicDescription": "Counts L2 cache hardware prefetch code reads=
 (written to the L2 cache only) that were supplied by the L3 cache where a =
snoop was sent, the snoop hit, and non-modified data was forwarded. Availab=
le PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -680,6 +851,7 @@
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0040",
+        "PublicDescription": "Counts L2 cache hardware prefetch code reads=
 (written to the L2 cache only) that were supplied by the L3 cache where a =
snoop was sent but the snoop missed. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -690,6 +862,29 @@
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0040",
+        "PublicDescription": "Counts L2 cache hardware prefetch code reads=
 (written to the L2 cache only) that were supplied by the L3 cache where no=
 snoop was needed to satisfy the request. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that have an outstanding request. Returns th=
e number of cycles until the response is received (i.e. XQ to XQ latency)."=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000040",
+        "PublicDescription": "Counts L2 cache hardware prefetch code reads=
 (written to the L2 cache only) that have an outstanding request. Returns t=
he number of cycles until the response is received (i.e. XQ to XQ latency).=
 Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10010",
+        "PublicDescription": "Counts L2 cache hardware prefetch data reads=
 (written to the L2 cache only) that have any type of response. Available P=
DIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -700,6 +895,7 @@
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0010",
+        "PublicDescription": "Counts L2 cache hardware prefetch data reads=
 (written to the L2 cache only) that were supplied by the L3 cache. Availab=
le PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -710,6 +906,7 @@
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0010",
+        "PublicDescription": "Counts L2 cache hardware prefetch data reads=
 (written to the L2 cache only) that were supplied by the L3 cache where a =
snoop was sent, the snoop hit, and modified data was forwarded. Available P=
DIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -720,6 +917,7 @@
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0010",
+        "PublicDescription": "Counts L2 cache hardware prefetch data reads=
 (written to the L2 cache only) that were supplied by the L3 cache where a =
snoop was sent, the snoop hit, but no data was forwarded. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -730,6 +928,7 @@
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0010",
+        "PublicDescription": "Counts L2 cache hardware prefetch data reads=
 (written to the L2 cache only) that were supplied by the L3 cache where a =
snoop was sent, the snoop hit, and non-modified data was forwarded. Availab=
le PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -740,6 +939,7 @@
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0010",
+        "PublicDescription": "Counts L2 cache hardware prefetch data reads=
 (written to the L2 cache only) that were supplied by the L3 cache where a =
snoop was sent but the snoop missed. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -750,6 +950,18 @@
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0010",
+        "PublicDescription": "Counts L2 cache hardware prefetch data reads=
 (written to the L2 cache only) that were supplied by the L3 cache where no=
 snoop was needed to satisfy the request. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10020",
+        "PublicDescription": "Counts L2 cache hardware prefetch RFOs (writ=
ten to the L2 cache only) that have any type of response. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -760,6 +972,7 @@
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0020",
+        "PublicDescription": "Counts L2 cache hardware prefetch RFOs (writ=
ten to the L2 cache only) that were supplied by the L3 cache. Available PDI=
ST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -770,6 +983,7 @@
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0020",
+        "PublicDescription": "Counts L2 cache hardware prefetch RFOs (writ=
ten to the L2 cache only) that were supplied by the L3 cache where a snoop =
was sent, the snoop hit, and modified data was forwarded. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -780,6 +994,7 @@
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0020",
+        "PublicDescription": "Counts L2 cache hardware prefetch RFOs (writ=
ten to the L2 cache only) that were supplied by the L3 cache where a snoop =
was sent, the snoop hit, but no data was forwarded. Available PDIST counter=
s: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -790,6 +1005,7 @@
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0020",
+        "PublicDescription": "Counts L2 cache hardware prefetch RFOs (writ=
ten to the L2 cache only) that were supplied by the L3 cache where a snoop =
was sent, the snoop hit, and non-modified data was forwarded. Available PDI=
ST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -800,6 +1016,7 @@
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0020",
+        "PublicDescription": "Counts L2 cache hardware prefetch RFOs (writ=
ten to the L2 cache only) that were supplied by the L3 cache where a snoop =
was sent but the snoop missed. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -810,6 +1027,29 @@
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0020",
+        "PublicDescription": "Counts L2 cache hardware prefetch RFOs (writ=
ten to the L2 cache only) that were supplied by the L3 cache where no snoop=
 was needed to satisfy the request. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that have an outstanding request. Returns the numb=
er of cycles until the response is received (i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000020",
+        "PublicDescription": "Counts L2 cache hardware prefetch RFOs (writ=
ten to the L2 cache only) that have an outstanding request. Returns the num=
ber of cycles until the response is received (i.e. XQ to XQ latency). Avail=
able PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.L1WB_M.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1000000010000",
+        "PublicDescription": "Counts modified writebacks from L1 cache tha=
t miss the L2 cache that have any type of response. Available PDIST counter=
s: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -820,6 +1060,18 @@
         "EventName": "OCR.L1WB_M.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1001F803C0000",
+        "PublicDescription": "Counts modified writebacks from L1 cache tha=
t miss the L2 cache that were supplied by the L3 cache. Available PDIST cou=
nters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writeBacks from L2 cache that=
 miss the L3 cache that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.L2WB_M.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2000000010000",
+        "PublicDescription": "Counts modified writeBacks from L2 cache tha=
t miss the L3 cache that have any type of response. Available PDIST counter=
s: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -830,6 +1082,7 @@
         "EventName": "OCR.L2WB_M.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2001F803C0000",
+        "PublicDescription": "Counts modified writeBacks from L2 cache tha=
t miss the L3 cache that were supplied by the L3 cache. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -840,6 +1093,18 @@
         "EventName": "OCR.PARTIAL_STREAMING_WR.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x401F803C0000",
+        "PublicDescription": "Counts streaming stores which modify only pa=
rt of a 64 byte cacheline that were supplied by the L3 cache. Available PDI=
ST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10477",
+        "PublicDescription": "Counts all data read, code read and RFO requ=
ests including demands and prefetches to the core caches (L1 or L2) that ha=
ve any type of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -850,6 +1115,7 @@
         "EventName": "OCR.READS_TO_CORE.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0477",
+        "PublicDescription": "Counts all data read, code read and RFO requ=
ests including demands and prefetches to the core caches (L1 or L2) that we=
re supplied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -860,6 +1126,7 @@
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0477",
+        "PublicDescription": "Counts all data read, code read and RFO requ=
ests including demands and prefetches to the core caches (L1 or L2) that we=
re supplied by the L3 cache where a snoop was sent, the snoop hit, and modi=
fied data was forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -870,6 +1137,7 @@
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0477",
+        "PublicDescription": "Counts all data read, code read and RFO requ=
ests including demands and prefetches to the core caches (L1 or L2) that we=
re supplied by the L3 cache where a snoop was sent, the snoop hit, but no d=
ata was forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -880,6 +1148,7 @@
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0477",
+        "PublicDescription": "Counts all data read, code read and RFO requ=
ests including demands and prefetches to the core caches (L1 or L2) that we=
re supplied by the L3 cache where a snoop was sent, the snoop hit, and non-=
modified data was forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -890,6 +1159,7 @@
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0477",
+        "PublicDescription": "Counts all data read, code read and RFO requ=
ests including demands and prefetches to the core caches (L1 or L2) that we=
re supplied by the L3 cache where a snoop was sent but the snoop missed. Av=
ailable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -900,6 +1170,18 @@
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0477",
+        "PublicDescription": "Counts all data read, code read and RFO requ=
ests including demands and prefetches to the core caches (L1 or L2) that we=
re supplied by the L3 cache where no snoop was needed to satisfy the reques=
t. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e an outstanding request. Returns the number of cycles until the response i=
s received (i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000477",
+        "PublicDescription": "Counts all data read, code read and RFO requ=
ests including demands and prefetches to the core caches (L1 or L2) that ha=
ve an outstanding request. Returns the number of cycles until the response =
is received (i.e. XQ to XQ latency). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -910,6 +1192,7 @@
         "EventName": "OCR.STREAMING_WR.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0800",
+        "PublicDescription": "Counts streaming stores that were supplied b=
y the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -920,6 +1203,7 @@
         "EventName": "OCR.UC_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x101F803C0000",
+        "PublicDescription": "Counts uncached memory reads that were suppl=
ied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -930,6 +1214,7 @@
         "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010003C0000",
+        "PublicDescription": "Counts uncached memory reads that were suppl=
ied by the L3 cache where a snoop was sent, the snoop hit, and modified dat=
a was forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -940,6 +1225,7 @@
         "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004003C0000",
+        "PublicDescription": "Counts uncached memory reads that were suppl=
ied by the L3 cache where a snoop was sent, the snoop hit, but no data was =
forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -950,6 +1236,7 @@
         "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008003C0000",
+        "PublicDescription": "Counts uncached memory reads that were suppl=
ied by the L3 cache where a snoop was sent, the snoop hit, and non-modified=
 data was forwarded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -960,6 +1247,7 @@
         "EventName": "OCR.UC_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1002003C0000",
+        "PublicDescription": "Counts uncached memory reads that were suppl=
ied by the L3 cache where a snoop was sent but the snoop missed. Available =
PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -970,6 +1258,7 @@
         "EventName": "OCR.UC_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1001003C0000",
+        "PublicDescription": "Counts uncached memory reads that were suppl=
ied by the L3 cache where no snoop was needed to satisfy the request. Avail=
able PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -980,6 +1269,7 @@
         "EventName": "OCR.UC_WR.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x201F803C0000",
+        "PublicDescription": "Counts uncached memory writes that were supp=
lied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json=
 b/tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json
index 79a4beba4b78..f47d97dfe0d9 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json
@@ -23,6 +23,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.FPDIV",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of floating point divide u=
ops retired (x87 and SSE, including x87 sqrt). Available PDIST counters: 0"=
,
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     }
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/memory.json b/tools=
/perf/pmu-events/arch/x86/elkhartlake/memory.json
index 34306ec24e9b..417cd78fc048 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/memory.json
@@ -13,6 +13,7 @@
         "EventCode": "0x13",
         "EventName": "MISALIGN_MEM_REF.LOAD_PAGE_SPLIT",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of misaligned load uops th=
at are 4K page splits. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
@@ -22,9 +23,21 @@
         "EventCode": "0x13",
         "EventName": "MISALIGN_MEM_REF.STORE_PAGE_SPLIT",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of misaligned store uops t=
hat are 4K page splits. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Counts all code reads that were supplied by D=
RAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000044",
+        "PublicDescription": "Counts all code reads that were supplied by =
DRAM. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts all code reads that were not supplied =
by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -32,6 +45,7 @@
         "EventName": "OCR.ALL_CODE_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000044",
+        "PublicDescription": "Counts all code reads that were not supplied=
 by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -42,6 +56,18 @@
         "EventName": "OCR.ALL_CODE_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000044",
+        "PublicDescription": "Counts all code reads that were not supplied=
 by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all code reads that were supplied by D=
RAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000044",
+        "PublicDescription": "Counts all code reads that were supplied by =
DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -52,6 +78,7 @@
         "EventName": "OCR.COREWB_M.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3002184000000",
+        "PublicDescription": "Counts modified writebacks from L1 cache and=
 L2 cache that were not supplied by the L3 cache. Available PDIST counters:=
 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -62,6 +89,18 @@
         "EventName": "OCR.COREWB_M.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3002184000000",
+        "PublicDescription": "Counts modified writebacks from L1 cache and=
 L2 cache that were not supplied by the L3 cache. Available PDIST counters:=
 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by DRAM. Available PDIST count=
ers: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -72,6 +111,7 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were not supplied by the L3 cache. Available=
 PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -82,6 +122,29 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were not supplied by the L3 cache. Available=
 PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by DRAM. Available PDIST count=
ers: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "PublicDescription": "Counts cacheable demand data reads, L1 data =
cache hardware prefetches and software prefetches (except PREFETCHW) that w=
ere supplied by DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -92,6 +155,7 @@
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000001",
+        "PublicDescription": "Counts cacheable demand data reads, L1 data =
cache hardware prefetches and software prefetches (except PREFETCHW) that w=
ere not supplied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -102,6 +166,30 @@
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000001",
+        "PublicDescription": "Counts cacheable demand data reads, L1 data =
cache hardware prefetches and software prefetches (except PREFETCHW) that w=
ere not supplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "PublicDescription": "Counts cacheable demand data reads, L1 data =
cache hardware prefetches and software prefetches (except PREFETCHW) that w=
ere supplied by DRAM. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 OCR.DEMAND_DATA_AND_L1PF_RD.DRAM Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -113,6 +201,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000001",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 OCR.DEMAND_DATA_AND_L1PF_RD.L3_MISS Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -124,6 +213,30 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000001",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 OCR.DEMAND_DATA_AND_L1PF_RD.L3_MISS_LOCAL Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were supplied =
by DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -134,6 +247,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were not suppl=
ied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -144,6 +258,18 @@
         "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were not suppl=
ied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) and =
software prefetches for exclusive ownership (PREFETCHW) that were supplied =
by DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -154,6 +280,7 @@
         "EventName": "OCR.FULL_STREAMING_WR.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x802184000000",
+        "PublicDescription": "Counts streaming stores which modify a full =
64 byte cacheline that were not supplied by the L3 cache. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -164,6 +291,18 @@
         "EventName": "OCR.FULL_STREAMING_WR.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x802184000000",
+        "PublicDescription": "Counts streaming stores which modify a full =
64 byte cacheline that were not supplied by the L3 cache. Available PDIST c=
ounters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000040",
+        "PublicDescription": "Counts L2 cache hardware prefetch code reads=
 (written to the L2 cache only) that were supplied by DRAM. Available PDIST=
 counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -174,6 +313,7 @@
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000040",
+        "PublicDescription": "Counts L2 cache hardware prefetch code reads=
 (written to the L2 cache only) that were not supplied by the L3 cache. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -184,6 +324,29 @@
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000040",
+        "PublicDescription": "Counts L2 cache hardware prefetch code reads=
 (written to the L2 cache only) that were not supplied by the L3 cache. Ava=
ilable PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000040",
+        "PublicDescription": "Counts L2 cache hardware prefetch code reads=
 (written to the L2 cache only) that were supplied by DRAM. Available PDIST=
 counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000010",
+        "PublicDescription": "Counts L2 cache hardware prefetch data reads=
 (written to the L2 cache only) that were supplied by DRAM. Available PDIST=
 counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -194,6 +357,7 @@
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000010",
+        "PublicDescription": "Counts L2 cache hardware prefetch data reads=
 (written to the L2 cache only) that were not supplied by the L3 cache. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -204,6 +368,29 @@
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000010",
+        "PublicDescription": "Counts L2 cache hardware prefetch data reads=
 (written to the L2 cache only) that were not supplied by the L3 cache. Ava=
ilable PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000010",
+        "PublicDescription": "Counts L2 cache hardware prefetch data reads=
 (written to the L2 cache only) that were supplied by DRAM. Available PDIST=
 counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000020",
+        "PublicDescription": "Counts L2 cache hardware prefetch RFOs (writ=
ten to the L2 cache only) that were supplied by DRAM. Available PDIST count=
ers: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -214,6 +401,7 @@
         "EventName": "OCR.HWPF_L2_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000020",
+        "PublicDescription": "Counts L2 cache hardware prefetch RFOs (writ=
ten to the L2 cache only) that were not supplied by the L3 cache. Available=
 PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -224,6 +412,18 @@
         "EventName": "OCR.HWPF_L2_RFO.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000020",
+        "PublicDescription": "Counts L2 cache hardware prefetch RFOs (writ=
ten to the L2 cache only) that were not supplied by the L3 cache. Available=
 PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000020",
+        "PublicDescription": "Counts L2 cache hardware prefetch RFOs (writ=
ten to the L2 cache only) that were supplied by DRAM. Available PDIST count=
ers: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -234,6 +434,7 @@
         "EventName": "OCR.L1WB_M.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1002184000000",
+        "PublicDescription": "Counts modified writebacks from L1 cache tha=
t miss the L2 cache that were not supplied by the L3 cache. Available PDIST=
 counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -244,6 +445,7 @@
         "EventName": "OCR.L1WB_M.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1002184000000",
+        "PublicDescription": "Counts modified writebacks from L1 cache tha=
t miss the L2 cache that were not supplied by the L3 cache. Available PDIST=
 counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -254,6 +456,7 @@
         "EventName": "OCR.L2WB_M.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2002184000000",
+        "PublicDescription": "Counts modified writeBacks from L2 cache tha=
t miss the L3 cache that were not supplied by the L3 cache. Available PDIST=
 counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -264,6 +467,7 @@
         "EventName": "OCR.L2WB_M.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2002184000000",
+        "PublicDescription": "Counts modified writeBacks from L2 cache tha=
t miss the L3 cache that were not supplied by the L3 cache. Available PDIST=
 counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -274,6 +478,7 @@
         "EventName": "OCR.OTHER.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184008000",
+        "PublicDescription": "Counts miscellaneous requests, such as I/O a=
ccesses, that were not supplied by the L3 cache. Available PDIST counters: =
0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -284,6 +489,7 @@
         "EventName": "OCR.OTHER.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184008000",
+        "PublicDescription": "Counts miscellaneous requests, such as I/O a=
ccesses, that were not supplied by the L3 cache. Available PDIST counters: =
0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -294,6 +500,7 @@
         "EventName": "OCR.PARTIAL_STREAMING_WR.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x402184000000",
+        "PublicDescription": "Counts streaming stores which modify only pa=
rt of a 64 byte cacheline that were not supplied by the L3 cache. Available=
 PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -304,6 +511,7 @@
         "EventName": "OCR.PARTIAL_STREAMING_WR.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x402184000000",
+        "PublicDescription": "Counts streaming stores which modify only pa=
rt of a 64 byte cacheline that were not supplied by the L3 cache. Available=
 PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -314,6 +522,18 @@
         "EventName": "OCR.PREFETCHES.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000470",
+        "PublicDescription": "Counts all hardware and software prefetches =
that were not supplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000477",
+        "PublicDescription": "Counts all data read, code read and RFO requ=
ests including demands and prefetches to the core caches (L1 or L2) that we=
re supplied by DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -324,6 +544,7 @@
         "EventName": "OCR.READS_TO_CORE.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000477",
+        "PublicDescription": "Counts all data read, code read and RFO requ=
ests including demands and prefetches to the core caches (L1 or L2) that we=
re not supplied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -334,6 +555,18 @@
         "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000477",
+        "PublicDescription": "Counts all data read, code read and RFO requ=
ests including demands and prefetches to the core caches (L1 or L2) that we=
re not supplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000477",
+        "PublicDescription": "Counts all data read, code read and RFO requ=
ests including demands and prefetches to the core caches (L1 or L2) that we=
re supplied by DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -344,6 +577,7 @@
         "EventName": "OCR.STREAMING_WR.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000800",
+        "PublicDescription": "Counts streaming stores that were not suppli=
ed by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -354,6 +588,18 @@
         "EventName": "OCR.STREAMING_WR.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000800",
+        "PublicDescription": "Counts streaming stores that were not suppli=
ed by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x100184000000",
+        "PublicDescription": "Counts uncached memory reads that were suppl=
ied by DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -364,6 +610,7 @@
         "EventName": "OCR.UC_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x102184000000",
+        "PublicDescription": "Counts uncached memory reads that were not s=
upplied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -374,6 +621,18 @@
         "EventName": "OCR.UC_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x102184000000",
+        "PublicDescription": "Counts uncached memory reads that were not s=
upplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x100184000000",
+        "PublicDescription": "Counts uncached memory reads that were suppl=
ied by DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -384,6 +643,7 @@
         "EventName": "OCR.UC_WR.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x202184000000",
+        "PublicDescription": "Counts uncached memory writes that were not =
supplied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -394,6 +654,7 @@
         "EventName": "OCR.UC_WR.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x202184000000",
+        "PublicDescription": "Counts uncached memory writes that were not =
supplied by the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/other.json b/tools/=
perf/pmu-events/arch/x86/elkhartlake/other.json
index 57613207f7ad..2cdc6b64f31d 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
@@ -113,26 +113,7 @@
         "EventName": "OCR.ALL_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10044",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all code reads that were supplied by D=
RAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.ALL_CODE_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000044",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all code reads that were supplied by D=
RAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.ALL_CODE_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000044",
+        "PublicDescription": "Counts all code reads that have any type of =
response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -143,180 +124,7 @@
         "EventName": "OCR.ALL_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x8000000000000044",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.COREWB_M.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3000000010000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have an outstanding request. Returns the number of cycles unt=
il the response is received (i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.COREWB_M.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8003000000000000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that ha=
ve any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that ha=
ve an outstanding request. Returns the number of cycles until the response =
is received (i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8000000000000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_RD.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8000000000000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_RFO.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have an outstan=
ding request. Returns the number of cycles until the response is received (=
i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_RFO.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8000000000000002",
+        "PublicDescription": "Counts all code reads that have an outstandi=
ng request. Returns the number of cycles until the response is received (i.=
e. XQ to XQ latency). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -327,146 +135,7 @@
         "EventName": "OCR.FULL_STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800000010000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L1 data cache hardware prefetches and =
software prefetches (except PREFETCHW and PFRFO) that have any type of resp=
onse.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L1D_AND_SWPF.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10400",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_CODE_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10040",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_CODE_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000040",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_CODE_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000040",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that have an outstanding request. Returns th=
e number of cycles until the response is received (i.e. XQ to XQ latency)."=
,
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_CODE_RD.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8000000000000040",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10010",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_DATA_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000010",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_DATA_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000010",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10020",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_RFO.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000020",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_RFO.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000020",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that have an outstanding request. Returns the numb=
er of cycles until the response is received (i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_RFO.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8000000000000020",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.L1WB_M.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1000000010000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts modified writeBacks from L2 cache that=
 miss the L3 cache that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.L2WB_M.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2000000010000",
+        "PublicDescription": "Counts streaming stores which modify a full =
64 byte cacheline that have any type of response. Available PDIST counters:=
 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -477,6 +146,7 @@
         "EventName": "OCR.OTHER.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x18000",
+        "PublicDescription": "Counts miscellaneous requests, such as I/O a=
ccesses, that have any type of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -487,6 +157,7 @@
         "EventName": "OCR.PARTIAL_STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400000010000",
+        "PublicDescription": "Counts streaming stores which modify only pa=
rt of a 64 byte cacheline that have any type of response. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -497,46 +168,7 @@
         "EventName": "OCR.PREFETCHES.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10470",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.READS_TO_CORE.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e an outstanding request. Returns the number of cycles until the response i=
s received (i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.READS_TO_CORE.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8000000000000477",
+        "PublicDescription": "Counts all hardware and software prefetches =
that have any type of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -547,6 +179,7 @@
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10800",
+        "PublicDescription": "Counts streaming stores that have any type o=
f response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -557,26 +190,7 @@
         "EventName": "OCR.UC_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100000010000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.UC_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x100184000000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.UC_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x100184000000",
+        "PublicDescription": "Counts uncached memory reads that have any t=
ype of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -587,6 +201,7 @@
         "EventName": "OCR.UC_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x8000100000000000",
+        "PublicDescription": "Counts uncached memory reads that have an ou=
tstanding request. Returns the number of cycles until the response is recei=
ved (i.e. XQ to XQ latency). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -597,6 +212,7 @@
         "EventName": "OCR.UC_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200000010000",
+        "PublicDescription": "Counts uncached memory writes that have any =
type of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
index e4e7902c1162..0fc2e821b14a 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
@@ -5,7 +5,7 @@
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
-        "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
+        "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for. Available PDIST counters: 0",
         "SampleAfterValue": "200003"
     },
     {
@@ -14,6 +14,7 @@
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.CALL",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of near CALL branch instru=
ctions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xf9"
     },
@@ -23,6 +24,7 @@
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of far branch instructions=
 retired, includes far jump, far call and return, and interrupt call and re=
turn. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xbf"
     },
@@ -32,6 +34,7 @@
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of near indirect CALL bran=
ch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
@@ -41,6 +44,7 @@
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.JCC",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of retired JCC (Jump on Co=
nditional Code) branch instructions retired, includes both taken and not ta=
ken branches. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
@@ -50,6 +54,7 @@
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of near indirect JMP and n=
ear indirect CALL branch instructions retired. Available PDIST counters: 0"=
,
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
@@ -59,6 +64,7 @@
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of near relative CALL bran=
ch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfd"
     },
@@ -68,6 +74,7 @@
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.RETURN",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of near RET branch instruc=
tions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
@@ -77,6 +84,7 @@
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of taken JCC (Jump on Cond=
itional Code) branch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
@@ -86,7 +94,7 @@
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
-        "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path.",
+        "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path. Available PDIST count=
ers: 0",
         "SampleAfterValue": "200003"
     },
     {
@@ -95,6 +103,7 @@
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of mispredicted near indir=
ect CALL branch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
@@ -104,6 +113,7 @@
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.JCC",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of mispredicted JCC (Jump =
on Conditional Code) branch instructions retired. Available PDIST counters:=
 0",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
@@ -113,6 +123,7 @@
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of mispredicted near indir=
ect JMP and near indirect CALL branch instructions retired. Available PDIST=
 counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
@@ -122,6 +133,7 @@
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RETURN",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of mispredicted near RET b=
ranch instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
@@ -131,6 +143,7 @@
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of mispredicted taken JCC =
(Jump on Conditional Code) branch instructions retired. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
@@ -206,7 +219,7 @@
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
-        "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses fixed counter 0.",
+        "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses fixed counter 0. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -216,7 +229,7 @@
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
-        "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses a programmable general purpose performance counter.",
+        "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses a programmable general purpose performance counter. Available=
 PDIST counters: 0",
         "SampleAfterValue": "2000003"
     },
     {
@@ -225,6 +238,7 @@
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.4K_ALIAS",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked because it initially appears to be store forward blocked, but subse=
quently is shown not to be blocked based on 4K alias check. Available PDIST=
 counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -234,6 +248,7 @@
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ALL",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked for any of the following reasons:  DTLB miss, address alias, store =
forward or data unknown (includes memory disambiguation blocks and ESP cons=
uming load blocks). Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
@@ -243,6 +258,7 @@
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DATA_UNKNOWN",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked because its address exactly matches an older store whose data is no=
t ready. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -252,6 +268,7 @@
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked because its address partially overlapped with an older store. Avail=
able PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -464,6 +481,7 @@
         "EventCode": "0xc2",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "PEBS": "1",
+        "PublicDescription": "Counts the total number of consumed retireme=
nt slots. Available PDIST counters: 0",
         "SampleAfterValue": "1000003"
     },
     {
@@ -480,6 +498,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.ALL",
         "PEBS": "1",
+        "PublicDescription": "Counts the total number of uops retired. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "2000003"
     },
     {
@@ -488,6 +507,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.IDIV",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of integer divide uops ret=
ired. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -497,7 +517,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MS",
         "PEBS": "1",
-        "PublicDescription": "Counts the number of uops that are from comp=
lex flows issued by the Microcode Sequencer (MS). This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows.",
+        "PublicDescription": "Counts the number of uops that are from comp=
lex flows issued by the Microcode Sequencer (MS). This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -507,6 +527,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.X87",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of x87 uops retired, inclu=
des those in MS flows. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     }
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json=
 b/tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json
index f9a6caed8776..bf56d72bb4a7 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json
@@ -242,6 +242,7 @@
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DTLB_MISS",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked due to a first level TLB miss. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -252,6 +253,7 @@
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of memory uops retired tha=
t missed in the second level TLB. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x13"
     },
@@ -262,6 +264,7 @@
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of load uops retired that =
miss in the second Level TLB. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x11"
     },
@@ -272,6 +275,7 @@
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_STORES",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of store uops retired that=
 miss in the second level TLB. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x12"
     }
--=20
2.49.0.472.ge94155a9ec-goog


