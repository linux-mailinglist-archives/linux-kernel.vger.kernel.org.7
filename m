Return-Path: <linux-kernel+bounces-832956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A204BA0D63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6801C2317A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4343E30DEAD;
	Thu, 25 Sep 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjyiWwZd"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D304330FF36
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821271; cv=none; b=fe8Ry7cX5nvPAqyhe6IVgTq+ncIDucMu9N4Jj/bN0gTv5zV8gxbl50130pB4W4j4iHXMrO2Eu7phlR8WdoOZ6Hld8wJWM/NJgh5gYRRiUCiOsealEyufaa6mVFdgxnKcjESbL9GjaI2HIHHTRCB6mu1t+qcpGezGtDqFd4S55Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821271; c=relaxed/simple;
	bh=PpkXYXg9GXehn9kAhfMc34VfzpX2CR6PHHD0O+cL6Jc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mMqO17766LtIidDyjuM+obaKEZIE/ZFksTwl2GM3pUCutu6c9JTcwQVUzpmcGLCIqf2JYf7OfMgj6jynnwAZ/9O9hRQUYYhtlbOYyALUS4LKGQimjKoG1m44vXkBAWPBWL7cx1XGlag9/opUum3VlN0iE1I41Sln6We5HICu9kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjyiWwZd; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7810af03a63so1106532b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821269; x=1759426069; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqwTAn1UWldDlHvSlgVybH00KpadDuea+reoIjfCw60=;
        b=KjyiWwZdAWkRI3WewTYHBVkjHmdNwoyOJDmI5+8VF5reZ+/mvC1XddMTMxr9gJkRl2
         LkwGL7iwSeb95JCYYCEFcV6z5n71r9Ub/HB+mUWfJxTZRvBvjXzZktVLL0tzrxaIfWXP
         WZNQ9FRkJZoJ8XqzU0zl9R/8oKKqyla7yn6T3b98i38+WsvlhGGxL4Y/FV7YVZnJXNrq
         bYs7vvWWrMU9UDZ5Rm237SaSr0H+XrpSBosH0DKJBYJA6qYIY94u4X3sZzmju8n1eJlw
         9u3Bg73WvbFBVQJ3BSrycgw8/7bUtK3a1pKBLrLd4iezYoB96LfIKiZfg2ITAV5uurK/
         cMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821269; x=1759426069;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqwTAn1UWldDlHvSlgVybH00KpadDuea+reoIjfCw60=;
        b=q6zoAbQ41ATDBKsOO3plSGhzMWKYqmjPGQay0yXfz/3Q87OlLr9yIetfKJtj63RJH0
         UkxKXCiZ3OJX31c4MUF6WenB+Wqq+QnDUozcrSndWHydLIyMFJ3U+RiGH0YkhxqxREub
         yMKLgK6hw1UM8NoZ7iSt/Oe1i2pKLk8pJJ8A2hKZ7EGjd2F1JkR0uSDlavXDCwTb+qy/
         +xYEa38UBcNNcKxZ706rMXrvHRvVYAPO/QSMpXTvYyeC4lJCpfYYekp6T2GL8cdl/aRG
         vlSljdkPAEGPy7UF0ll4NtzHKHsan5Y1XC0LqyT9v++ygkl7h4tLXc+UzEUpTeRxnKV5
         19iA==
X-Forwarded-Encrypted: i=1; AJvYcCWULYJs57VszpIuBVXplXEZHTpNSe4Ys7xMa+hTwEy9CJJdlUJ8Bga5vXAml5LlqLHRQvatMqGBWEnV0oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIkKTowpdajhrfQEivNS1LwyXcuc6sGvV5t3tOxWO907yR3KIL
	e6bhGcapmd+0fsBE/UEd6mJb1Uf/diBxBmoT+EEnd5PDEN0tGWS2EHaswCPA0EB1qnP3f/1LWh8
	Uq++7b8/GnA==
X-Google-Smtp-Source: AGHT+IGkMXXQiMjZDL94qNso3pCiau3Vfe8C6wq/0r4dAPUmCQUz8U9eIU/wu75tDxbflA1r2g7/cUcrYlQS
X-Received: from pgbcq4.prod.google.com ([2002:a05:6a02:4084:b0:b55:a4b:fe47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d12:b0:2e5:c9ee:96fa
 with SMTP id adf61e73a8af0-2e7d53bff65mr4520614637.34.1758821269156; Thu, 25
 Sep 2025 10:27:49 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:27:30 -0700
In-Reply-To: <20250925172736.960368-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172736.960368-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172736.960368-5-irogers@google.com>
Subject: [PATCH v2 04/10] perf vendor events intel: Update grandridge events
 to v1.10
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

Update grandridge events to v1.10 released in:
https://github.com/intel/perfmon/commit/c3028836415b8b5d31b8439eefc087492148c19f

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/grandridge/cache.json | 20 +++++++++----------
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/grandridge/cache.json b/tools/perf/pmu-events/arch/x86/grandridge/cache.json
index 877052db1490..9abddb06a837 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/cache.json
@@ -286,7 +286,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
@@ -297,7 +297,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
@@ -308,7 +308,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
@@ -319,7 +319,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
@@ -330,7 +330,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
@@ -341,7 +341,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
@@ -352,7 +352,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
@@ -363,7 +363,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
@@ -374,7 +374,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
@@ -385,7 +385,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index dec7bdd770cf..888d38e49766 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -12,7 +12,7 @@ GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.20,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
-GenuineIntel-6-B6,v1.09,grandridge,core
+GenuineIntel-6-B6,v1.10,grandridge,core
 GenuineIntel-6-A[DE],v1.12,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
-- 
2.51.0.536.g15c5d4f767-goog


