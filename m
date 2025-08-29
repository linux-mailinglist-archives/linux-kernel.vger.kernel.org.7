Return-Path: <linux-kernel+bounces-791105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF536B3B20D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902F77C85FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF841231A55;
	Fri, 29 Aug 2025 04:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3golQaZf"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022A257AC7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440719; cv=none; b=swH1imke8uiBRndwSk06TVN2AcuLtIz2rIfBP/7AnV6NL7DW6/FWAF+IZtrnxhyf82fCHQpEdnhqDE7ASmLAEItbKtFNI6IqKFOEpmWhO1PVCLS/RlTh0P899iWHsXmWbHO3fILlQKz0S2Mn2v399+wvjCwkFx9261HewV5/Dlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440719; c=relaxed/simple;
	bh=RAqBTlsz7iTfkuh3j5uys67bv7j8iaCJTuIX6mNvt/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Mimdein/TFJnSPhj6N8MD4mToutFk4W7Qrxt8hvJd+rO01Z+m+qVHsNVzV+JV6cv5qmS0LRcqP4xZYEAo205qOrNwe9n8dRTXmcW4zA+kcM8dZdtCX244TWkrzARPaOYNz3Yd2Obvc+RYX6Wgq+vRSUuXjqB2GIwOPZ6cgWqYAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3golQaZf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-327594fd627so1693637a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440717; x=1757045517; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M37/BCr0G7wFUjtgs9TA1CPDOATBHqDUNx+A2nDCLDk=;
        b=3golQaZfn9ZLUWwFQj37b/zzBBQ53wbnAi1ENsoiTFAVaGd5x2cJ2TsINelaNsRpXw
         PPkjUyeTlKPQvG1vQxra4cuupWh4eBmBsw4BlxgmSHMuc2FJfYlNQqBaGGESRGfwycFB
         5whEPhsp23VIhVCyQUF2Nho+XHKUfXet3VIHZvCQwSfs66pWYIkSLcNyZMzL5xsXpPkU
         zslmgnJ4o9ZomnFD3u1ndgmmkfUlCLM6E3PToqyGZDmZntm7OjZZYc/hTS9ZLTyMT0UZ
         siGvoNvJwMxNRkAj+5MDiF4rMjGmHhsnPA44lnaFblA0jQtST/m14X0o0Ty6DHNjrivU
         QdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440717; x=1757045517;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M37/BCr0G7wFUjtgs9TA1CPDOATBHqDUNx+A2nDCLDk=;
        b=WfpqznCSIgncKgE+QbelgEO57I6UIRmKkmDX/6ayaEnI0JF1AQZT02yTefEFWZ1NBm
         HWx/e4tJHPawUfyCJlkgORSeadb7taq/xHzMSQrhLO3dTnKK+fokwdTmtsE9mz+/8Byl
         EYQB3elFbQvaG2vDzN18TQz7enwMpfdLgiTDKsagkNB8hTiG+JE0m7d8YGoF01DdcV19
         nj2s10ou70Fwl0+gDSfLLDJOYFg/rCd4rxSV71WtTvbk6iVHihlZtkozyZbMqFl6FWgO
         fCLEFKcssTTXXxqx7NBVBacmQFkSU3gY0Pzfih0AWFSpxZ4ERfdTNvsApGY1NFm9xUE1
         NlYw==
X-Forwarded-Encrypted: i=1; AJvYcCWKxd6s2INiZ+9XhSfmUMMeCxSBIoSY03kV6ffyFxF34Y6Wjb539trFNWcXRTFhRKIQI0QKVut0wgYJrE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6Y20fpBymKQd/mo8/kPdJ58u5s9NvO20fLdUYxYu9BEIhDQI
	3j93P/8Ipiu2Zqq8GGikFeeHqpjFGTH3l/PCDguRzG7UNyAN9H+SYMRLakT17kJ1cynJloa8Vft
	hPRK6pApPQg==
X-Google-Smtp-Source: AGHT+IFaF8U3qHBbGql+g0XBidJWc2JoLHuvwPhanDRiVWnkGTBDVCZ99T8uFipFHHukDL9yt7SvOBC9ZHNg
X-Received: from pjbnc12.prod.google.com ([2002:a17:90b:37cc:b0:31f:2a78:943])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ece:b0:327:c0b6:305b
 with SMTP id 98e67ed59e1d1-327c0b632b3mr4490721a91.36.1756440717275; Thu, 28
 Aug 2025 21:11:57 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:56 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-16-irogers@google.com>
Subject: [PATCH v5 15/22] perf jevents: Add Miss Level Parallelism (MLP)
 metric for Intel
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

Number of outstanding load misses per cycle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f4d0676cdb77..262bfd539262 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -612,6 +612,20 @@ def IntelL2() -> Optional[MetricGroup]:
   ], description = "L2 data cache analysis")
 
 
+def IntelMlp() -> Optional[Metric]:
+  try:
+    l1d = Event("L1D_PEND_MISS.PENDING")
+    l1dc = Event("L1D_PEND_MISS.PENDING_CYCLES")
+  except:
+    return None
+
+  l1dc = Select(l1dc / 2, Literal("#smt_on"), l1dc)
+  ml = d_ratio(l1d, l1dc)
+  return Metric("lpm_mlp",
+                "Miss level parallelism - number of outstanding load misses per cycle (higher is better)",
+                ml, "load_miss_pending/cycle")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
   pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
 
@@ -819,6 +833,7 @@ def main() -> None:
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
+      IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
   ])
-- 
2.51.0.318.gd7df087d1a-goog


