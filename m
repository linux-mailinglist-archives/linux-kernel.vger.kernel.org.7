Return-Path: <linux-kernel+bounces-898563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C00C55881
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97E4B4E295E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C4230C355;
	Thu, 13 Nov 2025 03:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/3YZ651"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707330AD13
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004089; cv=none; b=KVUmxUyzdf508SVJYVPhKdzTYuKLxHKYNBR2b6BXYmiudPy7gNXAehjdYrnbu3PjUQsAKTraOVf/0PmsllIXsZVU0oMnQ/IRmoY3JbSJTTdLM+2NsiHnrUBiIt9aeJpHo9PhpNbAyTLdnfdUs6ZEp7Z55T6OE11gJ1gXM90HISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004089; c=relaxed/simple;
	bh=B8lkbetWKiGNIsi91sd8YrgblwbzZ9lrZIRvSGABaSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uL+4nPyx3jszvmjVEbbdpCcBgfl8hobHkBsML+EZvgWVi9bkGQGCM73W2H3v4t5WqD9+1B7+XErNG5/T8JNg8mdHL23xTcrT7N/zPKi7SzqzZcdDoE7jfGhcLThiFsQR4EuSCSD2NmZzHwWCkhCtYt2EkHBxwexPxWC2W5kBTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/3YZ651; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29845b18d1aso4340275ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004087; x=1763608887; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GojlKXXeIlWC1RlOdbmNF9Co4cMdGfhXPPYbUElx0PE=;
        b=l/3YZ651OWUXlfGPzSFHq5kDMDijdeiG2WQkkYS0bp7zAe7xVtH75bpzbDZC9LvzVY
         Rm4niXI+n4dm99wil+AATajAowXSfTjRf29NfALKdVYOf9fpwOumHcLe4aAyGVNpPSYp
         AaPGFOm+l/Af1tcfb5p9gVD0bBlM4BWVj+NKkE3lkwt6OyeBQGGw5XULNXJ/nmGdZq8E
         30VVAMzf1r63WNED6FXtQc8jJEyOxFBkrDWgloYQlbDOV9VSvulqKzPZL8byjTNgkopB
         mPu5CeucO2M65gzLHK7iTacQupWzvTkdpjCDz1GQCfn0QcCTRkQGe08p5KFjXdVUr01s
         yyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004087; x=1763608887;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GojlKXXeIlWC1RlOdbmNF9Co4cMdGfhXPPYbUElx0PE=;
        b=NzlATl4InX0D56wgDgW/AyZgiaBtWfOLOg4QIgXnCHTT+2fg4c445ihv+yqA8806dU
         HOi5k7Woky+TRF6MOfcK3NiLd3b0gTBy5+6g9GsL7Nwym0/foDp4TTDQrAsPNUWHY0Ej
         9J9dmQ7ogWd3xA1WS6HwAWMJ15Z3a5N8aMMQEJATxmkR2JKgVZlbeAZ4tQxllZipY2I4
         wxxqjp2Em60gCngktjxj4vfPVH8t4zSebx7FfyIkM/+U4BKkEgLZg4SmSts+Vus95+XZ
         Y1Sq9Cq8XRn4SUCOPNh50r7m2NsA5J6d05q2LdqX3oOK6jFcJjjNHwp7chQy4um57Uws
         Z7/A==
X-Forwarded-Encrypted: i=1; AJvYcCUX37m3D/f1MyfI6NF64G4e2QDfxkuDLKq1MrUye9RBRbVMrXAnbFywM4jR3vwdBo6zcv4EOTZBvXEywys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/3dr9rCFRHd05CQz4vSaKxWzB7FeoCR0PWtMu0bYJPLz5mTAR
	OYuvyeXWrw1+w1tI3DuwIcg++GQvvVl3NaIrOdfMT+FgHiFyjcNq6K+cb5226RH2AJjDlgmX9hu
	q2VqYd2OrKQ==
X-Google-Smtp-Source: AGHT+IHsv0wCUr4pcyK7ZKuQfbUgkUGpid5htJyGlM0w6i46UINI2OHaBEkE4F63Sjg9i6YhTCkUksnrBVuN
X-Received: from dlbbs33.prod.google.com ([2002:a05:7022:921:b0:119:78ff:fe12])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b8b:b0:294:f711:baa
 with SMTP id d9443c01a7336-2984ed2b6e3mr66202765ad.2.1763004086743; Wed, 12
 Nov 2025 19:21:26 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:05 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-18-irogers@google.com>
Subject: [PATCH v8 17/52] perf jevents: Add upc metric for uops per cycle for AMD
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

The metric adjusts for whether or not SMT is on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index f51a044b8005..42e46b33334d 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -3,14 +3,26 @@
 import argparse
 import math
 import os
+from typing import Optional
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, Select)
 
 # Global command line arguments.
 _args = None
-
+_zen_model: int = 1
 interval_sec = Event("duration_time")
+ins = Event("instructions")
+cycles = Event("cycles")
+# Number of CPU cycles scaled for SMT.
+smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
+
+
+def AmdUpc() -> Metric:
+    ops = Event("ex_ret_ops", "ex_ret_cops")
+    upc = d_ratio(ops, smt_cycles)
+    return Metric("lpm_upc", "Micro-ops retired per core cycle (higher is better)",
+                  upc, "uops/cycle")
 
 
 def Idle() -> Metric:
@@ -45,6 +57,7 @@ def Rapl() -> MetricGroup:
 
 def main() -> None:
     global _args
+    global _zen_model
 
     def dir_path(path: str) -> str:
         """Validate path is a directory for argparse."""
@@ -67,7 +80,10 @@ def main() -> None:
     directory = f"{_args.events_path}/x86/{_args.model}/"
     LoadEvents(directory)
 
+    _zen_model = int(_args.model[6:])
+
     all_metrics = MetricGroup("", [
+        AmdUpc(),
         Idle(),
         Rapl(),
     ])
-- 
2.51.2.1041.gc1ab5b90ca-goog


