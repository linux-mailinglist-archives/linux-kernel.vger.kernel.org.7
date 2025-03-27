Return-Path: <linux-kernel+bounces-579206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4CBA740C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 23:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8465D3BE4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182161E04B9;
	Thu, 27 Mar 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3LVhzpV"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB11DFD89
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114237; cv=none; b=gULYH0sfxQKU0gD0+CEnzJwutVhhISm0ubHM6d1Q+6+BD5IVOBMY+ig18B/undXT87/bA6GqLWzhEWUPHVdD72X5Up/L7pYcocKl2lJyIMiW+6YRgxzx2tirrIITIkffGso8XTTbnP5JgnI2aKrPwDGkBG6nZaG+kUXJOfL7FOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114237; c=relaxed/simple;
	bh=cCjLhes+TYhKXuwsMR/qWhU0czXBqgptV5m84Sd8jT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eDtr+D1/cYwZEeiBkLpmoprcimKq1hukJGHY2BqdWuvYiFp9DHP3eUOWQGrwES6IYa6DfpS24yOUxBf3ngOf7396Gnpp6fdeerULjdieUmmwHpjfwqR3UL+dn9t9yof3BHEcAJHbkUUbuFPdxSXLlZKVG0N+EfRMdyAViBKv/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d3LVhzpV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff799be8f5so2414581a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 15:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743114235; x=1743719035; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ci61odk+LoCVVTxj71uRGjzojEhx30vJGG3FJ+WtUHE=;
        b=d3LVhzpV/fLBszxQkpQmz9yh3Kx/gIaaLcqpjx6nSLzO63Zxq2ZrCYxJ7X4hOhXcv9
         N82tOmPXX+EGpMtAsGFs6GncnWkmX1Vdv9ZcJYw3IYMgiXB0evre7UwMkb1yis2xyd/Q
         3zDQGfHd0Ifo7GpdCRAfP/4msGyMoKIRpRdX/1cXMeg2CgbDvsnYH85rPLu9kThsBM/3
         D6Rl5e2dujtszG8KKBaO8zFvH8JBnotwveqz/yQFSY7mfJOcvERuSIxtpKj37WGYHJDw
         GErIgd56UJo0qFu5eaR+IX2z6nm8jgBxMbLLeKaU/0oyHc1jcLEIICq4oBw3SFEEu69A
         NzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743114235; x=1743719035;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ci61odk+LoCVVTxj71uRGjzojEhx30vJGG3FJ+WtUHE=;
        b=BuBKj0yBm+pmA6GPLf3Eo+oz9t8vn6+IBym1sujcpN8U0+gR6KG4kRJWTk5y4C2l/0
         8PrYMc65Sg4DjwPnCTQK7ms++AdhQZdVqe8HBYmeze9SBWsNMf2MBtL54NjP5iJGGFw1
         HKGwGU4QsbMUut1qzHcycI17XSWDonklILMnVpLubqjesoaf0fC20k/SEQCbJvDBy5eo
         46ywGvXcuCJYKGZRq8eSUxR8gHJ2aFtDx5M8AYTgJ1wgoInb6h7tdXQUBIZtkYcDCv0d
         hCJi46l+dO2yhU832D+6TMfid1XibhEgcVjfR7BE42m/BLLsOT7oVWXGknrnVI1/2z2P
         yKMg==
X-Forwarded-Encrypted: i=1; AJvYcCUTY48JjaSUi6vZXitvWPKUQ+gMJbsdpSNPBPNvIYOpKzO3umX1vDVNEOUUKrgIGIWpWxPtdy0YezQKhYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuh7daURvNP8iSTQcwQwFjxI0edBOnjRGBOAaKF/992+xNHqhc
	e6RCeSsnmk5UnJv7ecQBpna+QUgQ434pc3Xe9SP6xJj8TPviuqDwQOPTCJN2Tpe+YzL6hT40WSM
	dYYe1Og==
X-Google-Smtp-Source: AGHT+IE9XAV2rl6CdlHDyTyODZYSheGWYRIBQgR+jppsMFbpmemW85BAj3OCP2jDyapFg2tO65s3DG0SXbEj
X-Received: from pjuj8.prod.google.com ([2002:a17:90a:d008:b0:303:248f:d6db])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e185:b0:2ee:cded:9ac7
 with SMTP id 98e67ed59e1d1-303a8164d83mr8353392a91.20.1743114234812; Thu, 27
 Mar 2025 15:23:54 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:23:04 -0700
In-Reply-To: <20250327222331.117701-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327222331.117701-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327222331.117701-10-irogers@google.com>
Subject: [PATCH v4 09/35] perf vendor events: Update clearwaterforest events
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

Update event topic of OCR.DEMAND_DATA_RD.ANY_RESPONSE and
OCR.DEMAND_RFO.ANY_RESPONSE to be cache.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/clearwaterforest/cache.json      | 20 +++++++++++++++++
 .../arch/x86/clearwaterforest/other.json      | 22 -------------------
 2 files changed, 20 insertions(+), 22 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json

diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
index 875361b30f1d..17f8bfba56bc 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
@@ -140,5 +140,25 @@
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
deleted file mode 100644
index 80454e497f83..000000000000
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
+++ /dev/null
@@ -1,22 +0,0 @@
-[
-    {
-        "BriefDescription": "Counts demand data reads that have any type of response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    }
-]
-- 
2.49.0.472.ge94155a9ec-goog


