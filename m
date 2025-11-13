Return-Path: <linux-kernel+bounces-898577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDA4C558C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59C66350073
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524F4314A99;
	Thu, 13 Nov 2025 03:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQkcQQAr"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511EC3148CE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004113; cv=none; b=FaKG/1V3pkasKXAqgTbACyEZZcVcKLB2h0fJzycXvshPnN2Le3+j4dudAGrFm43JZfSj5pXiNzbz3V8Zw8LaAJFKInMLZKF3F4sVVgwShYnjD508gle3eLcB3Moiz1MGW/EOdsa2kvVUtofnrWSjWBM4rLsHomGBtYzR2JXA21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004113; c=relaxed/simple;
	bh=dtrcmDW/syC/1uX9xiFrYNyeKD9cKYmOXKfr3PnzzHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AYP3qesZ8Wlq0wXmeeoDfNCMjLAD6iOF70zLSxSwFov2MhC+rbIB9LxsbeGUlcODhZfhRGemYLXExSb4BBKVxU3LmvDKL/hGorGWh4Sm+MrtiyS119UfMt2vW/KYP/rm0JJJbW3lv4cWmvWUUB0tYMK++D8oVXuuM737WYZSvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NQkcQQAr; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29809acd049so4386805ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004112; x=1763608912; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmEuf1+eWrnDRkHWvOdDXellq4Hkis7ltgRYwnn7UgQ=;
        b=NQkcQQArSCJeI8oK7n88gtgksjeTe92hgvn9NTMy1DGBpLK8hjhBsebY5/u20E3Lxl
         9KeDLFf+MA72ggGpkRvydpWrrD2rllvn/JMLJrOCM1XGnz0sEfC9JiAAc1nDNqxg7F0u
         Ck6zVXxrOPRO2zrijAktDlg/5rtV7rdqoTVRCHNu3VnHrHx81oiOADpCOcGyuWZQZU7e
         gYhvGAq1GiYeQeEcMVgyLaI7VR51nWP8DikgnkWPFbEjdj4iM+DhznBi7gWCENCDBxof
         +0yAc1k9ysvWCkOe3pGjH2ooQDLKnc8FpLwVIoPnDcZKWAyoSbtfn0+pOD0AWVwJzZew
         wtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004112; x=1763608912;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmEuf1+eWrnDRkHWvOdDXellq4Hkis7ltgRYwnn7UgQ=;
        b=Ugyu/gFM8MP4wG++pm0J93Rzmqi1/mgVqZXdUgnvjVFKVi8fjFHB8WSZtkhHuM1qI2
         j+fx7EbfyHQd6X4jrEyhdjk3icEbcuUVnCG2lG4czFBk1IFCl7cFyExp+oBik32pOe7S
         KBrljdeQi2g/rn1dLEoAraY0RLx4W3r2FRp5gMXUGIns9QZ20d1zMr+QADEwelPAvm5g
         +7C4ku/+4XoinHLoPMp0rtUkCTvB5UykyqFpMq5/kMWa5O266P0ar4lz5TCEu6PO5Z0D
         QgWmiACnu6cqtkPJZaIUEbgAcPbIvfdpcrEukXDO1QDeviBYGs6KMmKB840OoCHjnpVX
         ngDw==
X-Forwarded-Encrypted: i=1; AJvYcCUCVhzgb9aGUQ53wQpC7V4Sg6wCObOjRoB/io90/eTjxrzYEUNs6JRF/uPqlqSnDdVK6baGfOYiXL7MGko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDb1StzHRf+059QPy8lfW5K2AhlJaX0eKvo53AUgT6rHAak7tO
	kn0R6DSC3bripLnsdIy6wEfJpwBKQK6o9WtgFPICa8MCXTmp0cU93vFrN7FVyBnibQqHygoWM4H
	3yYRRys+LGA==
X-Google-Smtp-Source: AGHT+IELChdLGepD16cMdJFlCGSq1vQv0//kOzXIur+0B6dP8L4hB1a2ag4vLjYxov3UcU9S5KBpkbBCw231
X-Received: from dlbqj6.prod.google.com ([2002:a05:7022:ec06:b0:11a:4c58:f398])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:944:b0:295:32ea:4cf6
 with SMTP id d9443c01a7336-2984ed27f0emr67157975ad.5.1763004111750; Wed, 12
 Nov 2025 19:21:51 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:18 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-31-irogers@google.com>
Subject: [PATCH v8 30/52] perf jevents: Add CheckPmu to see if a PMU is in
 loaded json events
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

CheckPmu can be used to determine if hybrid events are present,
allowing for hybrid conditional metrics/events/pmus to be premised on
the json files rather than hard coded tables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index e33e163b2815..62d1a1e1d458 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -8,10 +8,12 @@ import re
 from enum import Enum
 from typing import Dict, List, Optional, Set, Tuple, Union
 
+all_pmus = set()
 all_events = set()
 
 def LoadEvents(directory: str) -> None:
   """Populate a global set of all known events for the purpose of validating Event names"""
+  global all_pmus
   global all_events
   all_events = {
       "context\\-switches",
@@ -26,6 +28,8 @@ def LoadEvents(directory: str) -> None:
     if filename.endswith(".json"):
       try:
         for x in json.load(open(f"{directory}/{filename}")):
+          if "Unit" in x:
+            all_pmus.add(x["Unit"])
           if "EventName" in x:
             all_events.add(x["EventName"])
           elif "ArchStdEvent" in x:
@@ -36,6 +40,10 @@ def LoadEvents(directory: str) -> None:
         pass
 
 
+def CheckPmu(name: str) -> bool:
+  return name in all_pmus
+
+
 def CheckEvent(name: str) -> bool:
   """Check the event name exists in the set of all loaded events"""
   global all_events
-- 
2.51.2.1041.gc1ab5b90ca-goog


