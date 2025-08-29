Return-Path: <linux-kernel+bounces-791112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44060B3B214
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F831C86FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B8425F780;
	Fri, 29 Aug 2025 04:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p97Magzl"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ABC236435
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440732; cv=none; b=Y2726barH7WUmM6+2NMLu0YbH4V5xAQKdv9j0kJJIz3M5cUZCnLSpRiM/4TCwr/HnX8VLrcqwSUzsCzW87eA8ymMy9ON3XCJ1wBm4sbCzghrxN8TH74VuQEU8qSglsd+OIgHDb2sEtw6YGII3sTfTVZiw9oPpKsjaKCmNUy62lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440732; c=relaxed/simple;
	bh=qC9qZKKpYDUm+kJyCEJpPENdOECbimVQo+edYHDXXIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=o6vcoQjQHDe1UFu1bYag2yUMvg75aKzOc88B0MgSWN0NJsBEEG1utwIwO7jWWPqYiMPmpUrC8wiMztByM28P8GxQAXS9/FlWfVCmD7CmA7Fcn4+ZQs5TYax/7QoTDQpck3vjkp5ynzHkExwXzp19T++FW84beSD3IDrQXYLvWw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p97Magzl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581953b8so17575915ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440730; x=1757045530; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLMEPbiOl1CA0uGgkj22XdQGVWtN3/kulLXNUlnyl2g=;
        b=p97Magzl/nKZgt0COjJuR2mu8LNzhjoPoIuFwDCA/vtxJNJ/nyjZ90Ck5VqdK+StU4
         LIjDOW3fsNqmG2vCV9/n3ZaX6wXkXLrQsy/33sl2GeevMNk++mjXmQzINtp6vQIM4+0u
         fcUOZi19AFvu4AKeCjrLbzdNYo/n+ADPmocbCaWcIIqQuSJ1ZVdMKVXzwkwqWoun4sEx
         HGQbBooKilUn6yPULNctJH0mxHZz3jmyL0lmbm7Wy7MA6192vCU4ejEPRjuDrU7g5ZBP
         p92hGMTuZxXB/Y0cmglp6zqeuUGYXBYgLLSJ16jzWcxyniUo8Y0FWnbRKM9obM6B4Gtd
         VYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440730; x=1757045530;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLMEPbiOl1CA0uGgkj22XdQGVWtN3/kulLXNUlnyl2g=;
        b=SMJqVYgxglwR7evHkhrtb5Om0PEWeDFZfTywtXX+gaJ1fTUT0+6ij2RXkSTwDoOnEC
         zNVfpDNQw1Enj9TTMdvDenqqUXa1fnvMz74E7YFhcKT9Hq0Z/PnObWc6iZB7sR0BKn4c
         jPMoQUfZYdwLMPLI2tbWj3zz28BV8r+3izT6v73k+0E4xdQxqq1rcymoGKkbFYAI93Xw
         WJc4pFJ4a3r0fiuDT2WwtM71w92Oc99K3e6pOVkEN7KKv6CzsDEV42qtyA8XmxAPy9Uj
         QbTosgPKz17H2EhdjEKJyJtZiULYqv5lxeKy8SxNsVoictuQHmF1mfjZW9vtlPBMAvdB
         ERTA==
X-Forwarded-Encrypted: i=1; AJvYcCVCGJwcDTTXiWcqN6xSiNiyfB7L+deicJr5I8ndIG1cLbcgB24fjY9Fg1O9hujMGsn4251mstAITssNrPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Q3rPtcjfatUaoF4Xm+FUMoq4siUaFwvoHL6tYrf5jU0Zph06
	qhb6keJKlYGuS01QIlKXZDuM+nRcqe4nprCsjZtBJUtn1xDFWOJwA/vyYEO98ZPmEbe6giL+Rmo
	VqUDpsOx2xQ==
X-Google-Smtp-Source: AGHT+IHDsva2lKFanEaCvFFadJFWsw5tY+H9T7b+ytrl0xjAXY/bleP9SdCSpagPCUKeSl3MKOb5pT7fhOqm
X-Received: from plbbg1.prod.google.com ([2002:a17:902:8e81:b0:248:7880:829c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:17c3:b0:23f:f96d:7579
 with SMTP id d9443c01a7336-2462ef446c2mr321044585ad.37.1756440729973; Thu, 28
 Aug 2025 21:12:09 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:11:03 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-23-irogers@google.com>
Subject: [PATCH v5 22/22] perf jevents: Add mesh bandwidth saturation metric
 for Intel
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

Memory bandwidth saturation from CBOX/CHA events present in
broadwellde, broadwellx, cascadelakex, haswellx, icelakex, skylakex
and snowridgex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 19c7357c496a..7250e8c8eeba 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1009,6 +1009,22 @@ def UncoreMemBw() -> Optional[MetricGroup]:
   ], description = "Memory Bandwidth")
 
 
+def UncoreMemSat() -> Optional[Metric]:
+  try:
+    clocks = Event("UNC_CHA_CLOCKTICKS", "UNC_C_CLOCKTICKS")
+    sat = Event("UNC_CHA_DISTRESS_ASSERTED.VERT", "UNC_CHA_FAST_ASSERTED.VERT",
+                "UNC_C_FAST_ASSERTED")
+  except:
+    return None
+
+  desc = ("Mesh Bandwidth saturation (% CBOX cycles with FAST signal asserted, "
+          "include QPI bandwidth saturation), lower is better")
+  if "UNC_CHA_" in sat.name:
+    desc = ("Mesh Bandwidth saturation (% CHA cycles with FAST signal asserted, "
+            "include UPI bandwidth saturation), lower is better")
+  return Metric("lpm_mem_sat", desc, d_ratio(sat, clocks), "100%")
+
+
 def UncoreUpiBw() -> Optional[MetricGroup]:
   try:
     upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
@@ -1071,6 +1087,7 @@ def main() -> None:
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
+      UncoreMemSat(),
       UncoreUpiBw(),
   ])
 
-- 
2.51.0.318.gd7df087d1a-goog


