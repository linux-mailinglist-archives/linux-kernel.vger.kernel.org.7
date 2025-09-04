Return-Path: <linux-kernel+bounces-799939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C22E6B4316B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791A71BC0380
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B248245014;
	Thu,  4 Sep 2025 04:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qnqrWyrv"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E81A242909
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961590; cv=none; b=uwE5Me6xvu0nem9l540eDUsMEm9jtqto3XvnFYummZTkaZNsCoeKHnswudSlr2MMLMydzCyGgLswKVME9mKbWVrkQBnjpVAUdw0naFYzKQA1rm6VgnyfArkMGZbF4GTF8UWWLM8qPrghyfkylgKKUwAiynsgA4b9sLZA9MJamVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961590; c=relaxed/simple;
	bh=2nRqbW0WkwURucWNeXjSn7fOr+Pzwf5yXF518XDNXM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IIiL+Nw9t/kTQ7RPyrJdJQrw3lKJlV5h3bkwfqEuNAUkQl2TWdVoHcbFjxmsgZpxIdXt8XrpgJOMQ7Flhb7Z408C4rxFEtEd5Byz6JaTox8/mRBFvHy5VfNi4fT8cx/ZZ3vUbXS84eaa9XC2wrgvQFV+pxShf9IFsgOHNSSAw3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qnqrWyrv; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4f93fe3831so772425a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961588; x=1757566388; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtHpdxRTquFPiYRPRab1l8zsx1u08uaZD16J/LBQO3w=;
        b=qnqrWyrv2tPKm7zoL3dlRGiJgeFZ8SzO5KH1k3WjqxwbJCy3JWiloQPajd1g++0/Fy
         x7NOnQscchTAux6qZ3q3KKZjT7ylscXb4CpEY0uucwmNAzlmQi+s9eQVaqjDIAeq1a6O
         Qj43t0z4lV9CTYawGvsHTVRW00wPC4qT2U+3vNfSLchvrG2eQ4LpDGli/Y4q9ie+cckU
         aI9vT2U6BRF6Nj2QBgseU8CEoV5ecu8Gr8k0yLDy3r/nv28lHMJGCWNxis4AJmb4uCyV
         EB8vRLOmXtQqQgP7mzr+QwRTcKGcrkTWpSSsVj04aME7FK0V4dJbjcok/OwQv6nFquZt
         +pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961588; x=1757566388;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtHpdxRTquFPiYRPRab1l8zsx1u08uaZD16J/LBQO3w=;
        b=c3nzxQxbNX2prbnG6CTnrhUGY8I+5bq6zS+DPTqMZK1eBvx1Jtld1oiwYzJja76XXt
         yFfuxrXubDyjCYtk1vvO0RxfzwHEEFUAxoxga1kURr1IOkSeXf47xEg5BsE9D0qjBcMb
         2IwgAQOXrsAVhnET27mbirCEmCdZUjkpyoBNxg8YyXnkBCLfQkXIXzgkAXHw9aoMb4ku
         wIP0kyvjQKcK1qDYyjuBQhackv88V3AWrYzId+vKmqNrUoR0GBv21v6gyQajRTk8zK5S
         hyKtclIh5h6QqozozTbVuGiZ4sLiIIF8+3PYWPjzjx/Y9c7r9krCOWOWu2dNBqfscsMy
         vQcA==
X-Forwarded-Encrypted: i=1; AJvYcCUvR0/dBuYXYVvkBvO2x1fWhjMN/cSkfffloMy2n2OcqHR3kIMdyMiN0PslCUrPxOxOrnu9UNkYUcqNvhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEhu0lRiRTRoFLVnisBvDXcyOb/2RjTlAttJ3LcXhD5/vP5TkJ
	PA2ixk9TYd/0r2uQYz4blrKPCdg+Kx8t41MXW70gl3nH1x4bQbtXWkuWstOo1MZskCYVO7RNJOv
	R9Bz9MB6W9w==
X-Google-Smtp-Source: AGHT+IFfn8Z/EBKXtxnsGTFeSUhOaMoxR9/CtQzY5LIl4n+S7uUV99sy7Ex91B89Eo6PSM9JfdFgb+9St60E
X-Received: from plcz17.prod.google.com ([2002:a17:903:4091:b0:24c:b394:50e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e543:b0:24a:9b12:5248
 with SMTP id d9443c01a7336-24a9b125499mr209610835ad.54.1756961588337; Wed, 03
 Sep 2025 21:53:08 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:52:53 -0700
In-Reply-To: <20250904045253.1007052-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904045253.1007052-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904045253.1007052-4-irogers@google.com>
Subject: [PATCH v6 3/3] perf jevents: Validate that all names given an Event
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
index 2029b6e28365..585454828c2f 100644
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
       "context\\-switches",
       "cpu\\-cycles",
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
2.51.0.338.gd7d06c2dae-goog


