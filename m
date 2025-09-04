Return-Path: <linux-kernel+bounces-799925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9E4B43159
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451F15684D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6711B274FE3;
	Thu,  4 Sep 2025 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChqCHghZ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E665272E56
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961248; cv=none; b=NZ4p1LqgDVHfGbQ3Q9e6VnQGP8an2um7soEXujEotT5A3FxF2y+L01qYSu3svDoHhEh7d56AMpNvSdF74p2UToOUgPgjz5EEJcMqWhg56dsMHIsGH85Jwg+Q89kXTKsaRAmKK2bZKwXs6xLBOmGUFt9LglvNxmszKXFOuPoqKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961248; c=relaxed/simple;
	bh=RWxTmP9bErTpRh3MiSreSF6Ijc5xe2sVs1oxl7J9cPY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=E3uvwUPxJKebvM1sNTj6H6fjigCAJGvBltnBb33i1JhRKsnmSEEyjUnyX8oSNOXthtoH62pFKk/cT0WVLZd6XS+FCPyEJH9MoPT+7pZAXnOpKzttQFMJwrC5W+VaxdP6xETUQ53T/N/pU60qsZA0zdGK8FUTdJy4clduqcK4U8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChqCHghZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e41e946eso948288a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961246; x=1757566046; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDydOVVnbrc6TFkbkF/HCcYpcaepdAwyY0x1g/ePwfs=;
        b=ChqCHghZWgQ/4CGeH3xltHk67U4kT/yT7QAdFyKBni+D6XlalpZxxL67Zea4EIen0V
         ZLFAAaqjlL/L0WsXzq+mMFObwlz59Eud9NMrSQWpOV+Kz7aiDOWQEFrUbID+6FXMm+Dd
         1Chkf06rBLuHkrmYBforDDbe02YII9c3JDq3+RYU9uDD88IS8nbHLEIDboLFyMUnLEPZ
         l99SfHt/lxLnrB2FED4uYMPzrR/KHieyZI4pqGfdWpbaILSktl/plF8s+p+QH0ullkfh
         JswxPDSXMD5r/nh+IjNNHJRjl6p4a/ZafPTsjSRsezPqK2Sjf1KysBskkDlyk2ykVSJ9
         3oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961246; x=1757566046;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDydOVVnbrc6TFkbkF/HCcYpcaepdAwyY0x1g/ePwfs=;
        b=SXKnTxM2W4yUTRMxsJCXRi8CJDnEIFdRXhYkfFnqX5YuVdXN41tBjC7fhqewHAZeUX
         u35m3Wk/0VAGMkfyImCjL11Do7KUCmK88Hdbee2V3pf2SvdPfTHaTSDNL8IkxoQObRwW
         aX2AMWkicssyMC/imHWg1luRA32Bk8QrGk7WhdHcjQekJKX9Xu1/dNaaXKogOL11XlMQ
         fAiDTKWFOfDudl/FZoLnhA8+LEgCZjp8hYK88rQSf2aigfGqHf5mIER/9IgSOQOOFhyS
         L5XTuXL2v8YwCGua1AT7TpUz6jx03dikG7Q+O8uFT+okZKgMlDphu1qVAOifZlNHvzAm
         EQrA==
X-Forwarded-Encrypted: i=1; AJvYcCXV6L5GrrkwQexXYC7zX/oI/JGFlpl/gKnBgeGXWhHS7S3fSPZJxTDXLQ9UqhVKtFhuq/dmn9Jx8PWBWuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kEzz5B91XR7mkTVxWwtEl5BV6Ir+E1iJsFaI4hOZPIfVgKLD
	1mJk0FTF8HdW0V65OFpBkGuDrmOxlcfCDghbUp76EivRHW/x8UUXQH3TmZfg5P4i9ezRC/IDrk0
	cFim8F9gNgw==
X-Google-Smtp-Source: AGHT+IE6Y+fdsaIR18oM/DotikYbuFy1clsPgX/Q/otYDx0TymT9tgfvaSNYdaWhSNkqxMPbDYK+liV0WBSn
X-Received: from pjbsm7.prod.google.com ([2002:a17:90b:2e47:b0:329:d09b:a3f2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b51:b0:327:8bb0:4338
 with SMTP id 98e67ed59e1d1-32815414094mr22756248a91.2.1756961246462; Wed, 03
 Sep 2025 21:47:26 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:46 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-16-irogers@google.com>
Subject: [PATCH v6 15/22] perf jevents: Add Miss Level Parallelism (MLP)
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
index ff571256e100..fb15ba6b9f90 100755
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
2.51.0.338.gd7d06c2dae-goog


