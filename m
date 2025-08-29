Return-Path: <linux-kernel+bounces-791158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EE3B3B296
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B25417B2C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87C521579F;
	Fri, 29 Aug 2025 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHMMB876"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024F2253A0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445574; cv=none; b=TbKU2EE4K3SRvip+5Ti/Vyp5CnCd+j91C8ElohCm/KTifA1EnAvKVDR1R/4jBygH41D5vR3ooWXgO0IrycErHXWM44KCGuGXQLl0vmqNysdh2QqoitHanqXtC8YxPyrMZMuRdjvPIrPlDhenP1MZqcwoiHfhxqmzCDh9A0Bzn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445574; c=relaxed/simple;
	bh=fwAL01LE19lhQ9UMyPpq4PFhYNoK6DT1X94dohuXWL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cau2wNBXib2MHAbC+VOXGMMYBHc/E5F/5P047GCLsdG2KAoCDKJqt1WiZlF6nTstdNfBCq4WOjL1IPo2xejmIMGd2KfqAd3sbK4mo1RoeMrduMAXXPsrobHb+Wfqm3BpxwC69ZNOOpI+gW9LEDMHQRxiSjRFyKytCsYgDAyHT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHMMB876; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457ef983fso34129565ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756445572; x=1757050372; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pU2fAeE5oM19Gv08YDHyl9/3IFT39lq/g2I7zGvb/Xc=;
        b=LHMMB876jLun872dFqLtXNrEzb9/HB65UEX79j0mbz5/J4QQGCbUrxdHb0OcvORILu
         h29CaKSkfMun6ysZGw6Gh+Szf3u8bWE6+4pVTULYwF+aOe+jbi9OLKlc0qGPVVwpL/P2
         Ppy2FOrYRDDcqy+Ytug/hE7ypGBkrYK4POqbL3kMl16/eBFRL+DeImk4VAelLxkpb9V5
         isYCFRpSHohY64aFgDwr7fZihMvbXbYbmdcmEpzD+OaT/DH66YyciMPmN/3J/LNhDtcl
         KmyT+ULgNEgvucHUXQk5k+y1yQnsLAX9Dxq5gh/oxS0RKCGKiOevybP4gLiZezEyBtOZ
         dc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756445572; x=1757050372;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pU2fAeE5oM19Gv08YDHyl9/3IFT39lq/g2I7zGvb/Xc=;
        b=ky61HY9WqOIKuiRsbwPVCIDvSEnbW3TniK616maoPH/PMVuhSZBiCrChCe3a8Jc61r
         UPvkzRR5sy1w5LmqUMH0d9UkQQqrOMAf4jun2JPiRTPcJxGgf9lp4xsEPnUIcYUGKOF5
         ARdre87IgD953xMI2lx7GVqBGUooWIDNrbqKtVNXjtZF1yzsyXdfXsRbSz6NuPzI30yO
         Rlf2+GgMe7ujxgHVI5MGwjAOemAwYNWg5TTGplIPDO0JrkQRzEIAlxx0d62kKZcZBiya
         xaueppuzBB1pkf9r4KzQlKDer8kwoWR24M0Q9IzNTaRK7tjTTz+UunM35bp7NEfBfWVw
         38dg==
X-Forwarded-Encrypted: i=1; AJvYcCVEg8GCV5oiyw7FtnsQYcYwy9T3IrQcbyiqcuGfh0QvCOWMC4Aq0N2VdbNWMGV8vC1kxj2otXWw/AtrM8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3kwLQ1eCJuxYjjAUS85BNr+EUxBkjRhyuZvnPiKl7/HWFuVE
	DvYCMa0VQjGrkOBBXfHwNJx2/HmdtG5YU/RkmWSgkLWr/B/G2VL4udqzqVEa+HUgWy6Q1sdS3qc
	aMFQ2iFO+XA==
X-Google-Smtp-Source: AGHT+IEXo8lujkPD6NwKIYSQQ44USgnCa80S8P2/L/lAYZbF7W+ElqRCMv4FbfFb51L26IXnQPyD74pxYC28
X-Received: from pjbdb3.prod.google.com ([2002:a17:90a:d643:b0:327:5941:b2fd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c403:b0:242:9bca:863c
 with SMTP id d9443c01a7336-2462ef47b04mr396377635ad.54.1756445571769; Thu, 28
 Aug 2025 22:32:51 -0700 (PDT)
Date: Thu, 28 Aug 2025 22:32:35 -0700
In-Reply-To: <20250829053235.21994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829053235.21994-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829053235.21994-4-irogers@google.com>
Subject: [PATCH v5 3/3] perf jevents: Validate that all names given an Event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Validate they exist in a json file from one directory found from one
directory above the model's json directory. This avoids broken
fallback encodings being created.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 315350f3b6ed..92dcd4cd9d54 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -11,12 +11,14 @@ from typing import Dict, List, Optional, Set, Tuple, Union
 all_pmus = set()
 all_events = set()
 experimental_events = set()
+all_events_all_models = set()
 
 def LoadEvents(directory: str) -> None:
   """Populate a global set of all known events for the purpose of validating Event names"""
   global all_pmus
   global all_events
   global experimental_events
+  global all_events_all_models
   all_events = {
       "context\-switches",
       "cycles",
@@ -42,6 +44,20 @@ def LoadEvents(directory: str) -> None:
         # The generated directory may be the same as the input, which
         # causes partial json files. Ignore errors.
         pass
+  all_events_all_models = all_events.copy()
+  for root, dirs, files in os.walk(directory + ".."):
+    for filename in files:
+      if filename.endswith(".json"):
+        try:
+          for x in json.load(open(f"{root}/{filename}")):
+            if "EventName" in x:
+              all_events_all_models.add(x["EventName"])
+            elif "ArchStdEvent" in x:
+              all_events_all_models.add(x["ArchStdEvent"])
+        except json.decoder.JSONDecodeError:
+          # The generated directory may be the same as the input, which
+          # causes partial json files. Ignore errors.
+          pass
 
 
 def CheckPmu(name: str) -> bool:
@@ -64,6 +80,25 @@ def CheckEvent(name: str) -> bool:
 
   return name in all_events
 
+def CheckEveryEvent(*names: str) -> None:
+  """Check all the events exist in at least one json file"""
+  global all_events_all_models
+  if len(all_events_all_models) == 0:
+    assert len(names) == 1, f"Cannot determine valid events in {names}"
+    # No events loaded so assume any event is good.
+    return
+
+  for name in names:
+    # Remove trailing modifier.
+    if ':' in name:
+      name = name[:name.find(':')]
+    elif '/' in name:
+      name = name[:name.find('/')]
+      if any([name.startswith(x) for x in ['amd', 'arm', 'cpu', 'msr', 'power']]):
+        continue
+    if name not in all_events_all_models:
+      raise Exception(f"Is {name} a named json event?")
+
 
 def IsExperimentalEvent(name: str) -> bool:
   global experimental_events
@@ -403,6 +438,7 @@ class Event(Expression):
 
   def __init__(self, *args: str):
     error = ""
+    CheckEveryEvent(*args)
     for name in args:
       if CheckEvent(name):
         self.name = _FixEscapes(name)
-- 
2.51.0.318.gd7df087d1a-goog


