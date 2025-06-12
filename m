Return-Path: <linux-kernel+bounces-682761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2316AD6440
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 02:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD233AB021
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 00:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78781EFF9F;
	Thu, 12 Jun 2025 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPktFv1n"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73B1D63EE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686570; cv=none; b=YWrAZx5zExTdYjBkOMhIfX93ra173QnjpI6I02ziu9GkA2hkye1fpPfmFP8/8M/rwRa+5U+Lk5TgVYH4Cyz/yifAYSSUvr+WaPHHrtHD5KVr6EaddDbAxGbFEz8U3Kir4K2mx6cWRypWRG4ob0nCm6bTfyxgnnZPI0b39g3AuSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686570; c=relaxed/simple;
	bh=wasH0pHYGsAhMzmVwzs/wv2DqJL9HK9hJ3CvKSfN/9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rg8MtbNnziLotdQ8uIKJeZQT+CGrDrPMlmBQKIwLqIYLPWkLife75jzEUyYynzW4Wxzt32ORMUBXNqryd53pVj4EFWvXiD3Iqtr/3Dc47MZBw20E63RsqDPARKi8nakm47WX4kw+dysYNzq0J4yhvVW5qIltWfqOXu2sh8Rd6XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dPktFv1n; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2d9e7fbff93so283095fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 17:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749686568; x=1750291368; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzvQ18iD72XAX5fJ6cv9i/Q9Qv4U3YmZb6o3Q7qH1Ko=;
        b=dPktFv1n56tS9ttUylsb+vwQVK0ripkZQMq5qSFnapFwwzWoSFKEGuyIDh7ytJLqRi
         Y4KUwsVODzpuRfxe+tS1+wPPQCohKjfOPl6QHzk/jD64QV7tx2oaCknu9TnrrMddpDw6
         iJzD/JedHsDQ2Wn2kQgJL3TrBhotuSClVxS7bYTZscdjd5254/gU74p78TPe7ob0fIUL
         Sa3YkTUgm0oWmfU5ZkbI4ILRPMgOg+XL61sIBjbbj10Lro0MvTQfE6ccghBlbm/ttD0E
         ZOwAvvzcMwPyK1C404qGo+PMyF6X708xqZMnn1m6mR6jRN6QaKXN7D3IsOz+/ravc5a8
         dY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749686568; x=1750291368;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NzvQ18iD72XAX5fJ6cv9i/Q9Qv4U3YmZb6o3Q7qH1Ko=;
        b=EjApblwePRHrCkHnF7YGtEpNxLwqKArl7kLG0/XNUorZDhJPFknqzuzs+7JZ9gHayx
         aGnUCbOKzT5gcmTYULQDhPsRQSUVxtZVCvFTuwrrAmBkkJkiG6SDr/5Ye6bg5jl7oQiP
         iK9CdSBeFdweHoeGLSS61p9Ig0mVbd72WPMXI67TGabZwcwGQAtYJI57/zOFSOp1s1CI
         UXcgOPjyKa4U/oer5ntaaaOugpOLXOZz/yaeDBysSujwxrH6ZoaRpdvgicZKUos4QdV8
         +uynr4c1odpIS4HgQxaF3tk2Wi+Jz1pDOJnZbPOfsUOFfAW33VXd3Y28HR0L5LILoydr
         lDrg==
X-Forwarded-Encrypted: i=1; AJvYcCUWkH9PPSzRNIg9+mioB85tJQ2VYkT60kf4MtqRF8/IiLdCCgZxdJ1PbKPr7dOXZmiizEAPxYN4Mn2YmV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4RaCwMiqSN6EP9KeoPmclJ+NbbOuE4Yv9ymZV4oYmRbd/C7y
	u1oq6rnQtQRj4oy5IN4jfLM1WmWqoeO6kjfr+9iUsUQ5Mu6Ee/QJZNjClkeIIYUjBWE40rFdxzv
	OipPK3F5jdQ==
X-Google-Smtp-Source: AGHT+IFkqeSGlho3Q9zraESNX5suGBSSIroKMX/t1g6ub8+VfS6trJYjt8f7879hGByuAjWZrHWwqCOoCVn7
X-Received: from oabgq22.prod.google.com ([2002:a05:6870:d916:b0:2e9:175e:cff3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:170b:b0:29e:6394:fd4a
 with SMTP id 586e51a60fabf-2ea96b78087mr3265500fac.2.1749686568072; Wed, 11
 Jun 2025 17:02:48 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:02:19 -0700
In-Reply-To: <20250612000224.780337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612000224.780337-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612000224.780337-11-irogers@google.com>
Subject: [PATCH v1 10/15] perf vendor events: Update MeteorLake events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.13 to v1.14.

Bring in the event updates v1.14:
https://github.com/intel/perfmon/commit/6c53969b8d1a83afe6ae90149c8dd4ee416=
027ef

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |  2 +-
 .../arch/x86/meteorlake/frontend.json         | 72 +++++++++++++++++++
 .../arch/x86/meteorlake/pipeline.json         |  2 +-
 4 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 5f27b3700c3c..1185ea93b44a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -23,7 +23,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.14,lunarlake,core
-GenuineIntel-6-(AA|AC|B5),v1.13,meteorlake,core
+GenuineIntel-6-(AA|AC|B5),v1.14,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/cache.json
index c980bbee6146..82b115183924 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -231,7 +231,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of L2 Cache Accesses that m=
iss the L2 and get BBL reject  short and long rejects (includes those count=
ed in L2_reject_XQ.any), per core event",
+        "BriefDescription": "Counts the number of L2 Cache Accesses that m=
iss the L2 and get BBL reject  short and long rejects, per core event",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.REJECTS",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/frontend.json
index 509ce68c2ea6..82727022efb6 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
@@ -49,6 +49,14 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged with having preceded with frontend bound behavior",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ALL",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Retired ANT branches",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -73,6 +81,43 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles/empty issue slots due=
 to a baclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_DETECT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles /empty issue slots du=
e to a btclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_RESTEER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged following an ms flow due to the bubble/wasted issue slot from=
 exiting long ms flow",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.CISC",
+        "PublicDescription": "Counts the number of  instructions retired t=
hat were tagged following an ms flow due to the bubble/wasted issue slot fr=
om exiting long ms flow",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged every cycle the decoder is unable to send 3 uops per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Retired Instructions who experienced a critic=
al DSB miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -85,6 +130,15 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ica=
che miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ICACHE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -286,6 +340,24 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instruction retired tagg=
ed after a wasted issue slot if none of the previous events occurred",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.OTHER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles/empty issue slots due=
 to a predecode wrong.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.PREDECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index a833d6f53d0e..22b25708e799 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -1076,7 +1076,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
-        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions. Available PDIST counters: 0",
+        "PublicDescription": "Counts all software-prefetch load dispatches=
 that hit the fill buffer (FB) allocated for the software prefetch. It can =
also be incremented by some lock instructions. So it should only be used wi=
th profiling so that the locks can be excluded by ASM (Assembly File) inspe=
ction of the nearby instructions. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
--=20
2.50.0.rc1.591.g9c95f17f64-goog


