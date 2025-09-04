Return-Path: <linux-kernel+bounces-799903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BBFB43140
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9421C20486
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8632261588;
	Thu,  4 Sep 2025 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fhnm3bf7"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9D259C87
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960872; cv=none; b=SzflsxPCcBG5FLqcVgCNf0wNiLp0pmSXhw1VHyDBAoudpDx0e1C+rRW6g/auOFuCpUqBnO5SQKLMwCGsT91va3QxSmYwtVxrti53L54JRase4J5O8nu8hclwQ7Om1/7tV+aEYLxWB2wMErTKpDGjZQuZ7epUfYWHIzJPybkcOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960872; c=relaxed/simple;
	bh=cK6B3yKp/oAwbABBw+loVZPkiLk4KXwkSqwQNA4O3+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EulclXIs/PFSIuHsqWcdVxiS9phL7QdlVj+sKB5cv4Py2GIiUbBBgFVxhf7tOkTlkYFA6fWGa4321TO9I4hvLMfCHl1fUEwLN0KvVv6S+olMdbEWrYQkeAfPnDcM0LLFr3JmbgOxneszlBSMO+AC7cImAj+N0q4/uNsygrfFS6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fhnm3bf7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24afab6d4a7so11782005ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960870; x=1757565670; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPHDZybzkw0C8ovc4q8vLwc6Rbl59eyCCQCaehdkrpk=;
        b=Fhnm3bf70urcFPH2Md/L2iKvwlnBr33zhr2HMTnBSoUJKYBMbL11AWSNqGM7Vk2K1T
         94gXdyjEQYDyOWqk+iaxU3Uw5wT/mP2Rf5WJnSg3KIk9RTzmDgHRGj3GMvyVAsW5sEcK
         z3++O8qbWaMWVaALjCieuTpcPUBlcJ7FBOrH3tyWWjsI2/RrJFNB7FCrUusXME8jNHq+
         dSYoeoY+1TYNu/7N6I8GN0MzN1eHzlhUfliF+8oy8W4bugu5YlfYEbbwIiymr+gLx2Rt
         owpSSandbfqYiJ2kJcSUecoIu3wm6zuBVVIuSoJRGSJQZnqPNthbrG+AHji6HnSUhqSD
         Klwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960870; x=1757565670;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPHDZybzkw0C8ovc4q8vLwc6Rbl59eyCCQCaehdkrpk=;
        b=d6Q7a0P/8SLuvptxNNZP7xzB0aWIBD4c2hNxRmN6X6vJ5fO1g2MIFlmLhzaXdntmWh
         6RErgf1cZXzbvs2U9Lps9gJkbgPV/qAb/+rEWBIkyGprNh5vT73MMfnpxi0aPYv/lV/R
         I4XFi7t/IpCsxXMg/g8CrYrsTUaHJGvcCKGUgOE6W9MoeHayNGKP23Vq7y/NRKKjHKk0
         cY2xFhCeHWKCsCva4O6xt830yGp68SSg+1Ilc/rW9szJAr9TsDZ+dioytHeqQsFf/1vP
         XxDhSKcmOEygw/KLq+EeLqhVtLNFwpfk6IXL1fmeYGAcOHHES18AV05LUiEM3XAgL4J/
         E1Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUkP2Mh4dgwvJWGgecmi+Tk7uw1k0LdOjsuGxo7r9KKqRZQkSnKG+hE33v1KItAxl9qCBmURxmiOfvK+s4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01+nUhvD/unOp4fzWECz9fW1OSwD6bl7kXyUsarSJOV/Cp86A
	4WgZWFeiemgrXFXGoJWxTk2xCuW9jVFaM9FTM8NYZhTdkcNLi82PS8VQ5d1xLgfZeZanzdy4Ovo
	uxtZvNonbrg==
X-Google-Smtp-Source: AGHT+IEp7Y+oDlmnZtPDeCg1m5xYLuWN0BCan/DBqboMzndp2bfnN2yKn31ewBo/bKD2LHOlSwifiCuIlmr+
X-Received: from plcz17.prod.google.com ([2002:a17:903:4091:b0:24c:b394:50e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b46:b0:248:e6cd:e14b
 with SMTP id d9443c01a7336-24944b19648mr67886695ad.56.1756960870146; Wed, 03
 Sep 2025 21:41:10 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:43 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-10-irogers@google.com>
Subject: [PATCH v6 09/13] perf jevents: Add uncore l3 metric group for AMD
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
index c3f0f1439c01..a2d1b642b62e 100755
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
2.51.0.338.gd7d06c2dae-goog


