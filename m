Return-Path: <linux-kernel+bounces-799916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3E0B4314F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099FF1B2025A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5EB25742C;
	Thu,  4 Sep 2025 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FI3Cf0tp"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764572309B2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961230; cv=none; b=oZ37KGErLRizZrS6AXUc/wXc3XLUdunhJKh1rKhGZeeec00sq/Du16bpi01PyrekvSg4IC6YovX3fex/eWt1KC7jMBNXcsFeOBTYy6nI/bQhn3zgg1CRMnxvfBwde6mIzM/NMhka4qyPTPDMaKeQLSO71hS2UTrSveTBJsQg4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961230; c=relaxed/simple;
	bh=XqWtaIj6K0pucwkatrwiDZVEYWRyQheKPib6CZJKBqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Oq6l1erCr6CCtTsRIG78vxgdD5ICPJFAvqxtlh65Gx8dU2Ul1gXxtGaqQHntNIaB8JB6dvacXWNhc9bhWFBlkXVpJwFw50AYGm20gSfIsgcrVvRlubvoG9WE1/KJE2IbS1FA8CBsK0xW5zL40v5tQJ8+BZ1y0lYbhSGqbaXeaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FI3Cf0tp; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32b58eeb874so508850a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961229; x=1757566029; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3oN/oOalds6TOESEZO2XD43cMiUpOPUx/fjrARlRsWU=;
        b=FI3Cf0tpIfWeW6qXUQWDO+L/dArh0wW4aRRBHWK4UfopB1FM6nYVI1Ig5GDYs+98hk
         Vt39JTgbImsUy+3/RrCqqi8ZXaRrIq78jI8ZtchYZxOse0iPcro1/BYb0bH6vEOvgu3C
         3MqCHOmoWIVlStOhQcWROAgVj/+8GqBW4sXdWogPAYbZTYUrqASAgbashejnBw0uby7j
         e02xJObZZ8hZkm0xDkcEMBqE2CnWkGvOa4ycBt65+l5kuljJ/G8NxJ8UvzygrpNnuLra
         teOuuKwRx5Wd19sgqdrsTxYWsn3bRJia75uyoVJSQCO0hMVRkYUpH/xK7HZLwTF5gV7c
         a6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961229; x=1757566029;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oN/oOalds6TOESEZO2XD43cMiUpOPUx/fjrARlRsWU=;
        b=JRaL9v4Dy2COMMz3aVFDc9lD5LM2OnjjP/DUH2a9FJEbAsVRTmIFcM1bLnjT+bBvvs
         K0Mg2+Z0GdmYgihU2WdxWFyaXWY329iFnXvqiX1ez0CSyaja4+s+lPZ5wUDZqiKQfl6R
         BpAsxYtvAEpGW2BMk/eRptshAXpswPnNhNNU6UZeAiWtEp23fByi+KD+LVxNrJHREciN
         bq/9ghHiuMoUIfBXBHjrDNtQpnFXaylADRqA0FxU/slXrZcBrULSyHAe4HG8l0z6QZ6I
         gn4l9jUZBfNfG0rV17Po0s/de+M3kDNnH8kMOZHEQ9mbFMskDT0sOm6JTEm4a6yUOc0O
         1LPg==
X-Forwarded-Encrypted: i=1; AJvYcCXmXhm9ueg8wzsNIe8zTCR9i2kcCJSyoxsu8gXraQeKAvHpec33ZqBbMw7TXKbQR8mSAup+KaF9v8b22E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoWtKV9M/3lqU0m/jz9l7TFSK8gvOx2ljxTdeRgm5EkFX9LQkR
	cUHwGSpBfHoNbmcsTqToGZXDnl6Gh/GnzAPo2nD4uqE9oFyZYht0u2xIcRLdUZmFHhhx31PAfwF
	+1iJKNfxNLw==
X-Google-Smtp-Source: AGHT+IHHKaCDn1qrZv8IGjhja+YWfuOiVcV/nZpMmjMikxjYSYE06l215FPdIN3sznwjmGN36scFjdFRIL9C
X-Received: from pjss23.prod.google.com ([2002:a17:90a:1c17:b0:329:6cd6:660a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c81:b0:32b:95b9:3eb0
 with SMTP id 98e67ed59e1d1-32b95b9430amr1428715a91.0.1756961228792; Wed, 03
 Sep 2025 21:47:08 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:37 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-7-irogers@google.com>
Subject: [PATCH v6 06/22] perf jevents: Add tsx metric group for Intel models
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
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Allow duplicated metric to be dropped from json files. Detect when TSX
is supported by a model by using the json events, use sysfs events at
runtime as hypervisors, etc. may disable TSX.

Add CheckPmu to metric to determine if which PMUs have been associated
with the loaded events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 50 ++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 7d1c4c21a786..6d29d9ff0a48 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -7,6 +7,7 @@ import argparse
 import json
 import math
 import os
+from typing import Optional
 
 # Global command line arguments.
 _args = None
@@ -75,6 +76,54 @@ def Smi() -> MetricGroup:
     ], description = 'System Management Interrupt metrics')
 
 
+def Tsx() -> Optional[MetricGroup]:
+  pmu = "cpu_core" if CheckPmu("cpu_core") else "cpu"
+  cycles = Event('cycles')
+  cycles_in_tx = Event(f'{pmu}/cycles\\-t/')
+  cycles_in_tx_cp = Event(f'{pmu}/cycles\\-ct/')
+  try:
+    # Test if the tsx event is present in the json, prefer the
+    # sysfs version so that we can detect its presence at runtime.
+    transaction_start = Event("RTM_RETIRED.START")
+    transaction_start = Event(f'{pmu}/tx\\-start/')
+  except:
+    return None
+
+  elision_start = None
+  try:
+    # Elision start isn't supported by all models, but we'll not
+    # generate the tsx_cycles_per_elision metric in that
+    # case. Again, prefer the sysfs encoding of the event.
+    elision_start = Event("HLE_RETIRED.START")
+    elision_start = Event(f'{pmu}/el\\-start/')
+  except:
+    pass
+
+  return MetricGroup('transaction', [
+      Metric('tsx_transactional_cycles',
+             'Percentage of cycles within a transaction region.',
+             Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
+             '100%'),
+      Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted transactions.',
+             Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
+                    has_event(cycles_in_tx),
+                    0),
+             '100%'),
+      Metric('tsx_cycles_per_transaction',
+             'Number of cycles within a transaction divided by the number of transactions.',
+             Select(cycles_in_tx / transaction_start,
+                    has_event(cycles_in_tx),
+                    0),
+             "cycles / transaction"),
+      Metric('tsx_cycles_per_elision',
+             'Number of cycles within a transaction divided by the number of elisions.',
+             Select(cycles_in_tx / elision_start,
+                    has_event(elision_start),
+                    0),
+             "cycles / elision") if elision_start else None,
+  ], description="Breakdown of transactional memory statistics")
+
+
 def main() -> None:
   global _args
 
@@ -101,6 +150,7 @@ def main() -> None:
       Idle(),
       Rapl(),
       Smi(),
+      Tsx(),
   ])
 
 
-- 
2.51.0.338.gd7d06c2dae-goog


