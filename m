Return-Path: <linux-kernel+bounces-832953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0BDBA0D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FBE384267
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92C230F544;
	Thu, 25 Sep 2025 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPN1exK7"
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF530DD34
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821266; cv=none; b=m8UP8Ipo++E5lECRJcPSB4xg25Z1aNb1R1cb8gybXKSFL/yKLl76ZFVr4WROzzY36DOhWpIVV3jlf/t1ioAYSVry8Enjx5Zv0ao3VXqS0YHU7RmvXyZJn92v2yo2ZHfoPBu15LRMgoKCPvKif1pCuvHmHOAFEsf3BfoMreL3tNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821266; c=relaxed/simple;
	bh=EAObBkCcZxkebzS0aO/7L9VgKPcfjGIRR3rnlLj/NwE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iiuHj/4eKf2y4h5qpgA4yryD9aTiXe6MeodPsoQMT7Il7jVEzGW622/J+BTNVXX08JAKIfI6ue7WLFZlV7bDjyjkphIS37L+OC5TNx6nZQ6twpqYZ7AbNoUIRhJ0PK3Y1IKpYNKnOSv0VUnP1BAELHLA0C3v819zBC4oK1HFCQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RPN1exK7; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-635472b7ef5so279297d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821263; x=1759426063; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UxVraSbpPctO4hYAXHMNfzoFwgjKEIAFDPsL9j0NaTY=;
        b=RPN1exK7L2z5Wb7nmZU2lXYRlpJ8fyYZnjFObxpBRhJPAGPF3fk4pTRsu81P3ip6Ul
         y13Y839VFxoIKa22ly3QLmF7oQe/asy8EDcH/EDym2URGhXIowBAjUuW5aJ0fBK6INK6
         3EWmqjtsemVZIfRSrO1ujkqtFlDC8y8ZPm9TsAfMgyEcUB1Kg8dqLocgtYfEriDqK6h0
         0nv2ClrTcCvAaEVmm29aa7G5AoYwrU0greIMma4AP+ccju++U/NzDqCvX5G9PL75an9S
         uE645a5Yyh0CGZIZGKEEcYWBEV8KeTo4qe6f98icQ9qBOjWMmD1kVNhd4po6uT+jgXvs
         emqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821263; x=1759426063;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxVraSbpPctO4hYAXHMNfzoFwgjKEIAFDPsL9j0NaTY=;
        b=iOSfHRqSl3yOcHZSq8vnM7rH9RPMFdlwbMTZNdF6XsEwg+81DCll4YiSQnEEFJdNEW
         p55EWtiAIT0vx7o7ygLe1wgqOXDdntVcUOd+bYXoULA/M9lMnsX3J9s22W82jwDJYyNa
         hwhV76jE5YXq7f4PDlcOR7Hyl5MBF4snCIkLPcV4bsPzm2UGIj/1jyHy3GIHac+ulofU
         Xa+h94OBtUoRmWjVc8/7KbNG8gbuHumrP0hB461bcWLdiAKXKgtDX+U9cN6SzxNQi5LP
         EyAljNVCdDU0hDe8CH2qXWoY+Po/CW6MMUoEOvPJBm1OCmuxKEwTwB9pDXdK3bIr73JE
         WNWA==
X-Forwarded-Encrypted: i=1; AJvYcCUvjvF6G9K4Qcap5bTZ2FHjekViq4Rd9KZpWJKPRTF8QvYnkXXUDnL01EhunE1oU9CxA8quxmZdlC+8In8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4sOhgG8QaAvzBBbIw7n2bTTVPwOSv6QUiCLWHbdbZ9KThZbhb
	7Qr3MCym+0flfldSCseHYskO+c2dXd25dJFvUGzikPR4UmkKHr3/z5Olr63ieZQXRQPmz3iFuWx
	oFbWA9pUVDQ==
X-Google-Smtp-Source: AGHT+IFFc5BlC0dIErbWqNCgrS2ViEIDDRdF30aQkF5/WJsq64pQCEH3ZIFKoU95QM7taLBtqRtw+GaCwjjV
X-Received: from ybbgf10.prod.google.com ([2002:a05:6902:600a:b0:ea5:cc46:92d5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a53:b043:0:b0:5ff:6c94:7f48
 with SMTP id 956f58d0204a3-6361d4ea3aemr1960328d50.16.1758821263588; Thu, 25
 Sep 2025 10:27:43 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:27:27 -0700
In-Reply-To: <20250925172736.960368-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172736.960368-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172736.960368-2-irogers@google.com>
Subject: [PATCH v2 01/10] perf vendor events intel: Update alderlake events to v1.34
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
2.51.0.536.g15c5d4f767-goog


