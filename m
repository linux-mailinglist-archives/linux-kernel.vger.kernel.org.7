Return-Path: <linux-kernel+bounces-829964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E127B9855D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BE81B22113
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8326923D7F8;
	Wed, 24 Sep 2025 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRfGfZ63"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1415724A05D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693771; cv=none; b=ZngoC7Ne08QppBqrkt7ouw08oUIqR9adCbe8LdpWuBkd9I7PO+ABVAhKIjYJgpSNY2bFP6sAZzDKE6Epns5h+FewZp/YVeFIg5tbqzvfK/F2vp+cqQxDhPKa+oaaeTzb4EnZyEoV5kmqeoCaLat+VWkxt4DELxJIBEd1uasihXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693771; c=relaxed/simple;
	bh=VlBzm4sQ+K7RqzqDXx9u2XN09xpSsntef8scOgjmO6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ldAXCc0MzchlThSMUMIuxRI2zXy+XmfAcJjdhOHAX39nO4pNQQchh1NXQhtRk1qLAyWKJ9Dg7bn/q3zlkaexNDkESOp5DtZ9NDcg2DQaU1F9TrWXR/zn3eGXbDanGk3fehwj2Jn1pjKmAEQmnjbkcU4a8uDCaMtRQbuDVgiNQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JRfGfZ63; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2699ebc0319so67508115ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758693769; x=1759298569; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plTyOlm01Lu+32dYRONMwBTr1DEdYenlGFnsI+q2WIg=;
        b=JRfGfZ63uplY/3kO0SH/mnxwrO0qw0P3/Ss+vQShCoGCy6L2xMZElzQscMKjSU5SHf
         Es3+sx+SuzXcTfI1HofQUTxAs4PbtPohhWV5A1XpR52jg0g/5x20azRWjUH3tKd1eY8L
         CJ75IMUmrSCcIXkzf8gqupTanfjHHC87JY+nSqTWHScCcTDX7+q0jA21IwB1nfbLP2aH
         zD2+1kzyMWkmiBEyr3MCOR6retTJV9/Iwh5ZFpKuukX9SuL36BwFkP5BGSxe5jBbnFp5
         CbGB5JqRDUb51Ytsvoiim4Lr8sffXYvEYwVvU2GPci4OHSsxzWJ3HxMfN7YsaX4A5Cz5
         dwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758693769; x=1759298569;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plTyOlm01Lu+32dYRONMwBTr1DEdYenlGFnsI+q2WIg=;
        b=TKikLB3YXkoKPESF3Wka6ANyRhS01IJ6Uh3mbnxtD0n2IblDsQp2t5Rm7Sa4c5c6TT
         K8qV2sSf9nDs6VWLp1Iv5w9hkwydrTH8bPTZODWJych4DyKbqvXqFXyXZkH8STMggptB
         gjK47TMGbDsabRvn6zFKCBwQzv1CzXXqweMgL45sLoBJ2ebehffwlqRsEs7B9PM61242
         hehUwczUsYQ1soM2wm3UXSNNmtLceeiFBM3cxioKLPg4ojwt88kA8BF/1/5JrZSJgQbc
         sAad86S4LcbkLRWL6QeLJ9Gu042I2f6m8iAsE+p7j0DgMjdgFJdPcy9LM1O4cUaxA5yg
         E/hA==
X-Forwarded-Encrypted: i=1; AJvYcCUE1a69ssNn3WvGkIe9zAjK9fqGfbSweRE5PfKS0+3NVSOCydEahz/AbS/OmxTsREdIYHTWE9HReMFSfmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIVsx97X3mPNboqPAJWJbYotmH55cafoQwDA+6g8pLf9kpxdGM
	EDWro3KxVvz+DaSra3rjSJzgmkRqmEK+hgUrA/KCSVwkIuNNZrd5tD3C5FCwsrK7cQSrdI2ehmm
	zzwBYOfVCKA==
X-Google-Smtp-Source: AGHT+IHLH36G0jqLqswFH+QMg2Fx2jrBGAbZ/gMyA8lOGOWb1W/XupEgWZBVdhuGX7CQVIvpG4t7VJBhwVqL
X-Received: from plec19.prod.google.com ([2002:a17:902:f313:b0:269:937c:75b3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c7:b0:27d:69de:edca
 with SMTP id d9443c01a7336-27d69def40amr48076015ad.13.1758693769329; Tue, 23
 Sep 2025 23:02:49 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:02:23 -0700
In-Reply-To: <20250924060229.375718-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924060229.375718-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924060229.375718-5-irogers@google.com>
Subject: [PATCH v1 04/10] perf vendor events intel: Update grandridge events
 to v1.10
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
2.51.0.534.gc79095c0ca-goog


