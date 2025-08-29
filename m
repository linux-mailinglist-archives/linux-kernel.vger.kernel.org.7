Return-Path: <linux-kernel+bounces-791066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A878EB3B1A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E3B5669C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E411024635E;
	Fri, 29 Aug 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1RhhSsb"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7A242D84
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438326; cv=none; b=F8Z2tMq81FWxHjpccml07E2nls7XEhUY5wd7ju3pCEJYEkwlfZ67zZCYjOWeM3bW/g+yxMlgtAaPXWJG9L7wgOghXCeT52GPwnKp3wBFOG76PpQI6ze/ktIdyNcEaQPd5a6mC4AhqrdpIvo091dfceFzS9oyKJwFeJyIuqrYFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438326; c=relaxed/simple;
	bh=mnGCQoVCpWKnS1efSKzWUWHETYIVpoK2sS6bGiha554=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lmJKu7YGr6QGSxuy6r6ovpi3bucwFUGji0vFi3IpzdPTIFmWmTyBxrzQrht4SZH8speZEqNsSH1jhDq55JoyHfKE0Jd1MEfCNvGI6Ch3uHyGGFs6TNxgQ/+DLFwKkCIbmNWU10TqXsRoYppxLuGHRYKZpwR1tURhmNQmFK+BPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1RhhSsb; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7fc5584a2e5so124943385a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438324; x=1757043124; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5R53CM2TPsjTVnqMuru1HC/vS2z5OSjStJIxd3R0X+w=;
        b=d1RhhSsbT1HeejibdehA6zJzSGFoTQ7yB1Cpr3zeXVCqbDv0yFntab+wud7SdBjv5J
         7cUUaVLACoXNswKhi2wlD4CUCo/69nouBz3Qmj2x43IGDUmL+ZmDiDCPwN8PEZUNZAVE
         kjZA0f4UizEw5bzoC++EaewOBM580j0Fb2cieF+Z8/uo1sfaLSXSR/Kf1Y1KpUF/8ZiG
         xNYcCyB2A/VG4XoQckbOIRbII+EHy6SBVAb9u7+mPrmGu45/hkeMWMThoefuzGb16EO8
         T5+atoWycESd0FMJGtH8XjmIk0jd8v07skhPt6B8bkFF3pxABL5InS34HTFAnTKq1Kc3
         bV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438324; x=1757043124;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5R53CM2TPsjTVnqMuru1HC/vS2z5OSjStJIxd3R0X+w=;
        b=Fjspv3+xQd9WcPNg7tB+g0W6Bd6YTc1opVrm0gDN/SStBT/e3XZ601U9Ud75GDrMs8
         o/PMahYHUzkZHeNKw54CnvFJDZXBlBsO9aSgDZzb/yyNxHNjASxKHbQDMiF4Pap89O8u
         B7gTWZuy5WXUm+J37hYaoLZc4n++IhWneSHn+vJceE7P9QZ1Ypo0HPyxTzdRBWvC08te
         Qw893h3G8Uymzj8bmvSWdvRCEIk/Dl0ikGHb4U/DS2wV/brzTripBxLrYS9rC2EeP42H
         dYoThqIBqZrpHOwNsi+jpjibDZ/RPkIpUyDPnY3V+mC6IA0SbFpJHZemxiM0FLsi5Vga
         srbA==
X-Forwarded-Encrypted: i=1; AJvYcCVB2lg/UVJ58U31K6RMpn6hRsVx6y8FoAM51LfG0JTcyVGWVxCM1p3XfKScBnyZqfaVfL1ioY+EJyz/Tb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTVCz3zrqh2Q3WeP8BEbrzwbJkzI0qjex3B4S/eEvvpTn1wKL6
	23zC7w9d9bod9HPAidAnH5ncMbqq41HHcC/Y5y4FmUtes/AX9TMJcxI592VT1S1Z1SQWKZyevHi
	wJ1yW5FsHcg==
X-Google-Smtp-Source: AGHT+IE5KwZNXbrjkrGlNCyrW1riQSZJaDMhR8fcmb36i7fQTK2aprs5AGLAz7G1Hsr/ljtWTDIKNCwWp6Y3
X-Received: from qknov6.prod.google.com ([2002:a05:620a:6286:b0:7e6:9480:7485])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4409:b0:7ea:1060:ccc0
 with SMTP id af79cd13be357-7ea10f53884mr2440632985a.8.1756438323478; Thu, 28
 Aug 2025 20:32:03 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:34 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-10-irogers@google.com>
Subject: [PATCH v5 09/13] perf jevents: Add uncore l3 metric group for AMD
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

Metrics use the amd_l3 PMU for access/miss/hit information.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 38ff7d1caafe..71500ea2204f 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -466,6 +466,22 @@ def Rapl() -> MetricGroup:
   return MetricGroup("lpm_cpu_power", metrics,
                      description="Processor socket power consumption estimates")
 
+def UncoreL3():
+  acc = Event("l3_lookup_state.all_coherent_accesses_to_l3",
+              "l3_lookup_state.all_l3_req_typs")
+  miss = Event("l3_lookup_state.l3_miss",
+               "l3_comb_clstr_state.request_miss")
+  acc = max(acc, miss)
+  hits = acc - miss
+
+  return MetricGroup("lpm_l3", [
+      Metric("lpm_l3_accesses", "L3 victim cache accesses",
+             d_ratio(acc, interval_sec), "accesses/sec"),
+      Metric("lpm_l3_hits", "L3 victim cache hit rate", d_ratio(hits, acc), "100%"),
+      Metric("lpm_l3_miss", "L3 victim cache miss rate", d_ratio(miss, acc),
+             "100%"),
+  ], description="L3 cache breakdown per CCX")
+
 
 def main() -> None:
   global _args
@@ -501,6 +517,7 @@ def main() -> None:
       AmdUpc(),
       Idle(),
       Rapl(),
+      UncoreL3(),
   ])
 
   if _args.metricgroups:
-- 
2.51.0.318.gd7df087d1a-goog


