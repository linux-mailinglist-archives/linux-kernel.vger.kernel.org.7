Return-Path: <linux-kernel+bounces-799897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A371B4313A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3221BC7EA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D93242D78;
	Thu,  4 Sep 2025 04:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBxvYu5E"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BE823D7E5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960861; cv=none; b=cNq7eLqdgRK0eRUjcUl/oA55Vgyzffa1IqiDTe0iMaKg6TEzlF9e3bOWjmVE/jsj2W38xirpTHvwvugpTu32LnboqKz2NMOOlBtYu93FrQjVLo9b77yUkhYD+LuvyQW4H/qVeQYODZL3scM5VBXOOqsM0qVOjja56MLxHR69xBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960861; c=relaxed/simple;
	bh=4pt9FIkHAZ5Xw3Q3jAERRLTnj/Qqp2bLN3zztKZ3NDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HhSkGFwCAjQ9OXDAHVFD/D5wrsg+rYIkI1hccIOW+y2s9HhY2tAhh44UT/KvbSlQXoCFhOdP/0nHos4L2NAs4NAuPeQt9AJcSB54pLphnbXRem+s50b6XzhBi6/EURD5DM71Oftu8nQ389mNBjISbvyh3ZCZ2/6oPXN/yUFSXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBxvYu5E; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24cb39fbd78so8469485ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960860; x=1757565660; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqdl8vLdPtWOH3bXXSF+6lIx5IOBzCwED92UAgNuVi0=;
        b=BBxvYu5Eo6lITAzwy2NOFQVSjqqG7X1BYKH1ZHg2TX2E1s2/9oIdQHOsWz7+BZyZO1
         QxS6RyCS4ai9sowOsPb865oL6+MGipjI3Dg/D7NiLR/dptFmOM90mNOfnRuOzirpNg8l
         o2d0oAuKDE5spYyW1IQz5ndk8F3kHULBGnstnOLzuyieu9hb9ghl4TwmeBV0P5ZX9AFn
         OkKL9qHxywb2CARBK5K4fGTsuD3X1TDhB43oIhVmgMvaZN69gVVsmfxKw2QTm0HNQDvR
         U4VJc6KtUBkyRLGr5XPCz/ta245ZqWT+uVxc2+ZA2Yebu+asntaCgMeKERalk3wtQ7Vq
         tX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960860; x=1757565660;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqdl8vLdPtWOH3bXXSF+6lIx5IOBzCwED92UAgNuVi0=;
        b=RxtBA65EmTYrqmXOsKcQNMKdTdemJ2d2QlQelJXyClL9lIoWtJQbiXFDGMRnI+1NZO
         HfIfooJYG0PMDkAXOWHjvCHCt9kMVxI054brf22MNASns9oQwTFR4OQYtqmiWIX5qJuG
         pWOu8cKiB+aXGp+9f+38etZaSWYj4QWchTXvSf7gPUvqY1HpXnO60dDnq3toROGSufc4
         LgOMf4iSwrcJIvh7Fec2iI6bWNpqM+x2OXmuwicv8Fq7+qVJNtkf9tjNINufecBifJsM
         +KIanOAPF1EizJWeCWVlALrGUusvAfScgi9H45wXLO6zQzRh5zEDM6jXQJJikKKnU5j2
         5fpg==
X-Forwarded-Encrypted: i=1; AJvYcCWvdDzbH88E2e6AFT6AOXzegrsBlId7/5SRqnei+ZwKvCnXTJnE/XEMnkd96wr6MXH7sscfsDYXRWmjmjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH6VEygAJ5BVsFbFDjNobddEwf0KmFJloeRMW9poJQl+x100KX
	886Hc+Mj4iCcdcxgBo5HPgy9SZFlHB4O0I4Nus+olCOZIsKRVXgYyf0/hceXMbApZRYuni/esqh
	Pm89nktVC3w==
X-Google-Smtp-Source: AGHT+IHmbbEQKIEE17+d6qgom3CpI4YxAaIwfg9AXhSe/jShxfEf8sr4p6TGGDoIk5OB/pcXTCrszOyHqAOL
X-Received: from pltg8.prod.google.com ([2002:a17:902:6b48:b0:240:1821:d2d2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b6f:b0:246:a56e:b155
 with SMTP id d9443c01a7336-249449038admr228484985ad.22.1756960859742; Wed, 03
 Sep 2025 21:40:59 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:37 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-4-irogers@google.com>
Subject: [PATCH v6 03/13] perf jevents: Add upc metric for uops per cycle for AMD
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
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The metric adjusts for whether or not SMT is on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 335e8a7e0537..f734f1127ff3 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,8 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, Select)
 import argparse
 import json
 import math
@@ -10,8 +10,17 @@ import os
 
 # Global command line arguments.
 _args = None
-
+_zen_model: int = 1
 interval_sec = Event("duration_time")
+cycles = Event("cycles")
+# Number of CPU cycles scaled for SMT.
+smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
+
+def AmdUpc() -> Metric:
+  ops = Event("ex_ret_ops", "ex_ret_cops")
+  upc = d_ratio(ops, smt_cycles)
+  return Metric("lpm_upc", "Micro-ops retired per core cycle (higher is better)",
+                upc, "uops/cycle")
 
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
@@ -45,6 +54,7 @@ def Rapl() -> MetricGroup:
 
 def main() -> None:
   global _args
+  global _zen_model
 
   def dir_path(path: str) -> str:
     """Validate path is a directory for argparse."""
@@ -65,7 +75,10 @@ def main() -> None:
   directory = f"{_args.events_path}/x86/{_args.model}/"
   LoadEvents(directory)
 
+  _zen_model = int(_args.model[6:])
+
   all_metrics = MetricGroup("", [
+      AmdUpc(),
       Idle(),
       Rapl(),
   ])
-- 
2.51.0.338.gd7d06c2dae-goog


