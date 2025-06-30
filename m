Return-Path: <linux-kernel+bounces-709920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AABEDAEE4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 18:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3CB176D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596762BE7B6;
	Mon, 30 Jun 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cw1Ai/kO"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8828F958
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301084; cv=none; b=ZHxWXLJGyxS7/VVi5utpIMZ8GJJaVWeKMqjXjRmlmm2uLZsKg4HWB46lqwx6ThNE10vhoRKlPpdIeH7CqXMvFRB1Czl6NgjsKOlsoPSnCFhcr8DTxZRtk0eTEsmjkghmKr97ZQrSB4+TGfk5um0ZgSi04yLD2n61z1Ic/Hth1cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301084; c=relaxed/simple;
	bh=cYTZPg8svo3KxFuZTNuW3cHUkqaMUCbO0YP/+BnH8PU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ip7AFyW/bqhBC7BPlQ0cfS2OMN4H1KD53HBz4U/F1Qe4CfHsqafdKGrXuLNwEmafLYu4915DP6GFPhmHX6XQIagkWutgdBqsX+WiWCWfUAfPrKv4jXFKUX+5hdCI4ivClHVr7d8LU9/8zpJHEWonrfHxyqjyFZou4jkKBAVX8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cw1Ai/kO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31220ecc586so4191766a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751301082; x=1751905882; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEFfMlrQSXMTOxWpbM5ZYbWnbe0uoXKpOhqRZp4q58Y=;
        b=Cw1Ai/kO8bwMxgcy72M97iaWAMpaJ5wGpMV4el2bDK0GLXPmP17L/9xmMliG77xkIl
         ekRrAnUoCy/O/iP8NPWYOl89Rhau7QXMgwd/iRqenII3hKAn9wbduaB+dMZXLPFOb66N
         YqtWfwMBSI+wBBiC5rKlEyEWIZ7n2vaw7xfayzzctHhWWanYWcm/d+7Ou+y8IMAqHwIj
         3x3qilvFiZut+1hl7nWt/n/aUw83UJQLj6/wf1VrNc0sUDYMxXmKD4ewmSrCtch0kP/b
         7Q4sowBT9uVwblgqFke74HlQ+7zme3Wgcwimdryl3YSu/YPNLuiXC6M/bA50LF9VzM1r
         WztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301082; x=1751905882;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pEFfMlrQSXMTOxWpbM5ZYbWnbe0uoXKpOhqRZp4q58Y=;
        b=E7U8q/cZDv5+HkDKP0ruUGRovbqSh9cwJDAGNOXyXNpmhj264+yqwtjckpO+Y4sx92
         605JJNwCQb4iibo/jhfebz0CoBa1bX5C1v6+w7VCZ/SkmYptGxN+aLGEpGC08EExfgVM
         Jjyf5/sEHJeHMdeF06qma3H8PRBKpftPWPvqUeu/3ixOCkFev4OpKzf94WPDl0wv+FSz
         hF9/AYNLEgFOsEAZZ8HhQ6QqJ8vPQlUxquZRBEnG9in0TT/5chZMLLZOVqa5cIY1Um0T
         wteHHPxkH38i2EATBzdgVAPJ7xZdGxTcmkp0UFuAKBchjEKZ4VPtrskNtfp4lDvWO+v8
         43ng==
X-Forwarded-Encrypted: i=1; AJvYcCWQAB7Hwt0YDNtXpJi2ryEZp1TbqdUQ5/UXK8U+sbLl6e8dNvufTS5R9hVUMfZyijXrh/XUJ3YIhnrJAHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6h9cKZyoVumw7EPeCiU8aLsAOnBvHLO9jI+g5tM7g/1LGfqJ8
	EtTPmFGr4w2DASI1dLM26dA0uti9Gdr3ua8TAYaJ1Ma7lSYNbJj+5KKYSpCIftuSvmxVhe9iUq5
	j/kiW/Cor3g==
X-Google-Smtp-Source: AGHT+IGYRCvLVAEEl69L7BJEilDHRz7k1qgcz5SMDXxTkc/k4z8tupZKnRSB5EjZQBS2LRhXXKxkajEB+wr1
X-Received: from pjbsq3.prod.google.com ([2002:a17:90b:5303:b0:2fa:1803:2f9f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e08:b0:313:d79d:87eb
 with SMTP id 98e67ed59e1d1-318c9327ab8mr20386475a91.35.1751301081934; Mon, 30
 Jun 2025 09:31:21 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:30:54 -0700
In-Reply-To: <20250630163101.1920170-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630163101.1920170-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630163101.1920170-10-irogers@google.com>
Subject: [PATCH v2 09/15] perf vendor events: Update LunarLake events
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.11 to v1.14.

Bring in the event updates v1.14:
https://github.com/intel/perfmon/commit/95634fec10542c0c466eb2c6d9a81e0c24f=
b1123
https://github.com/intel/perfmon/commit/84a49938387ac592af0a622273e4e8e4997=
e987d

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/lunarlake/cache.json   | 11 +++++++++++
 .../arch/x86/lunarlake/pipeline.json           | 18 ++++++++++++++----
 .../arch/x86/lunarlake/virtual-memory.json     | 18 ------------------
 tools/perf/pmu-events/arch/x86/mapfile.csv     |  2 +-
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/lunarlake/cache.json
index b1a6bb867a1e..ff37d49611c3 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
@@ -790,6 +790,17 @@
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "1000003",
+        "UMask": "0x101",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts retired load instructions with at leas=
t one uop that hit in the Level 0 of the L1 data cache. This event includes=
 all SW prefetches and lock instructions regardless of the data source.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT_L0",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the Level 0 of the L1 data cache. This event include=
s all SW prefetches and lock instructions regardless of the data source. Av=
ailable PDIST counters: 0",
+        "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/lunarlake/pipeline.json
index 4875047fb65c..6ac410510628 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
@@ -1247,9 +1247,19 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of demand loads that match =
on a wcb (request buffer) allocated by an L1 hardware prefetch",
+        "BriefDescription": "Counts the number of demand loads that match =
on a wcb (request buffer) allocated by an L1 hardware prefetch [This event =
is alias to LOAD_HIT_PREFETCH.HW_PF]",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4c",
+        "EventName": "LOAD_HIT_PREFETCH.HWPF",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to LOAD_HIT_PREFETCH.HWPF]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.HW_PF",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
@@ -1664,7 +1674,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of issue slo=
ts not consumed by the backend because allocation is stalled due to a mispr=
edicted jump or a machine clear.",
-        "Counter": "36",
+        "Counter": "Fixed counter 4",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
         "PublicDescription": "Fixed Counter: Counts the number of issue sl=
ots that were not consumed by the backend because allocation is stalled due=
 to a mispredicted jump or a machine clear.  Counts all issue slots blocked=
 during this recovery window including relevant microcode flows and while u=
ops are not yet available in the IQ. Also, includes the issue slots that we=
re consumed by the backend but were thrown away because they were younger t=
han the mispredict or machine clear.",
         "SampleAfterValue": "1000003",
@@ -1797,7 +1807,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of retiremen=
t slots not consumed due to front end stalls.",
-        "Counter": "37",
+        "Counter": "Fixed counter 5",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x6",
@@ -1903,7 +1913,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of consumed =
retirement slots.",
-        "Counter": "38",
+        "Counter": "Fixed counter 6",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x7",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
index defa3a967754..e60a5e904da2 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
@@ -36,24 +36,6 @@
         "UMask": "0x320",
         "Unit": "cpu_core"
     },
-    {
-        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to a demand load that did not start a page walk. A=
ccount for 4k page size only. Will result in a DTLB write from STLB.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x08",
-        "EventName": "DTLB_LOAD_MISSES.STLB_HIT_4K",
-        "SampleAfterValue": "200003",
-        "UMask": "0x20",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to a demand load that did not start a page walk. A=
ccount for large page sizes only. Will result in a DTLB write from STLB.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x08",
-        "EventName": "DTLB_LOAD_MISSES.STLB_HIT_LGPG",
-        "SampleAfterValue": "200003",
-        "UMask": "0x40",
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a demand load.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 53c0d19c51d4..5f27b3700c3c 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -22,7 +22,7 @@ GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
-GenuineIntel-6-BD,v1.11,lunarlake,core
+GenuineIntel-6-BD,v1.14,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.13,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
--=20
2.50.0.727.gbf7dc18ff4-goog


