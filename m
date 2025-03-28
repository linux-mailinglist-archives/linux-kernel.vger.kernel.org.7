Return-Path: <linux-kernel+bounces-580260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C97A74FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 18:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FB21786B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 17:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DF41DE2B9;
	Fri, 28 Mar 2025 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4pzd9O9"
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FCB1DD886
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184226; cv=none; b=FsAs3ywdQp5s3V1aaYGRqT+cAeeYgtEWIjy22a4h9I9eh+d+zjSWX0yajAoUIsII53LgxpfTM9T6V8G5l3kcF6iEBz5RfD4Euk1wGLcLBnUeEzBaoBT+ml0o0+4h/IhvS1s60K7Mt8rcpUS+l3iaWbGaUN5rrnRtPrF7BxbHyh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184226; c=relaxed/simple;
	bh=gT7Hz1uhxAm7Xg1QdrvNrx/1kWV6DiYfS43pzzmXpsk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=CgknkQJM+6/eNC3bFi3UfzPDCScsqCVmO5DT3rcx0B9gfVbQmpNAx7k/5PKGcoFklKOpzgTi/pZ49K+ZF6i36wfFn42gKh72Pnshof/kC/lCJmv5odl6Q/6K1KEjZm88UnXihqm3/lKhV6IogCsjyydKIuRz1gwc1+knRTIE42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4pzd9O9; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-72a115fffe6so1754956a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743184223; x=1743789023; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zbTM8OInu1q1YS33g7PUCrwITRsqJUS24BClPiX1Wzk=;
        b=G4pzd9O9xd5eMw5/9w2kg8HAKlHP4ivdgXQYe56eZln8ANmXl6rQg0MyEJu8DmwFUS
         +SGbWXfoyZS4nm8dzMlGH9sx2Av6TjrZbM0A+0w/QXVMitUezarowLlrO90wYfdiBFbC
         Q3GhWiN8QsTdvxnAgwVfKyUTUsaPH3coU3ORPoVrjR9uqW3BDzbIMsrlgWbLcOELbCt/
         pkj9WKJJaqYyiRRxmYZPDWKD8+J7cuQMt3nRFyqXxpYiY/pQXeh4Q90MatE9jNNSp7jk
         GW1BvVIuX2hvD+CkLKeBT06Z1kL1alzlXGr8QJqgf3NwA3ApUJOeWlJmbF3784wHrIkt
         DJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743184223; x=1743789023;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbTM8OInu1q1YS33g7PUCrwITRsqJUS24BClPiX1Wzk=;
        b=PTi2DnulToZtLmLjdMNuEY3HdL6gyUiidTTQYz7gyBOyCi6SG/kV3fhu19/3n2vlyd
         jnsqhIAom8p+tskI0x0UCxAfIQvxuYXfcFAQoSpa0Exico8QjIdIYhccsESUNr4gOW3B
         mch712K4/PSZeW/JHdZEF0AcLOmAr+Jfn8/SZwWfVokmZPrkm/tTB02nloE39VSKNAft
         Nc+uTrTHu5udh8BrdlygolQWM01tJB3ytqaoGVgVt8n3OcAC41cCcN4pBnaI+FCDLroA
         7hGl9Qiu66E4nLOZCn6fdzZJEDo6eASTJJl48PEKyuji17e5HEfowiYFkbmcdBLcSGpe
         kyHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpiireXaVuDMCtxUHaRAdWk1ykR4A/jfLJvaIjBSqRO6VbIERs7weDxNGj/Ll/VBmwRDHYItsvpWjK3No=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOjQPuxei2two25JsIktyzzSPnZ+t5ZPHWXHeSfbSckL4jcOEU
	6Bvu4mU7+R+tPt44mTc1g21vgp++krbWBa+M1W99zS3U+rsUjnMEmPFrW4kF3KRa19drilsXLuk
	FsgbE0w==
X-Google-Smtp-Source: AGHT+IFNrMaAdSKxQuXzGJm/OG2s7vA2eWnYzAil1Oiu3gulveYQaEAeydkDC5ptLzTOPvTrSI0LKZVfvQXk
X-Received: from oabli19.prod.google.com ([2002:a05:6871:4213:b0:2c1:6d20:7b92])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:4909:b0:72b:a5e0:f76
 with SMTP id 46e09a7af769-72c6377daaemr220898a34.4.1743184223431; Fri, 28 Mar
 2025 10:50:23 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:49:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328175006.43110-1-irogers@google.com>
Subject: [PATCH v5 00/35] GNR retirement latencies, topic and metric updates
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add default mean, min and max retirement latency values to GNR
events. Update the topics on a number of events previously
"other". Switch TMA metrics to the generated version. Add TMA 5.02
metrics for sandybridge, ivytown, ivybridge and jaketown.

Events and metrics generated from the data and scripts in:
https://github.com/intel/perfmon

v5: Additional metrics constraints from:
    https://github.com/intel/perfmon/pull/299
    PDIST descriptions added from:
    https://github.com/intel/perfmon/pull/292
    Original retirement latency, .. updates in:
    https://github.com/intel/perfmon/pull/298

v4: Generate grandridge metrics from the spreadsheet using conversion
    with the core type of crestmont.

v3: Generate sierraforest metrics from the spreadsheet using
    conversion with the core type of crestmont.

v2: Fix arrowlake PMU/cpu prefixes.

Ian Rogers (35):
  perf vendor events: Update alderlake events/metrics
  perf vendor events: Update AlderlakeN events/metrics
  perf vendor events: Update arrowlake events/metrics
  perf vendor events: Update bonnell events
  perf vendor events: Update broadwell metrics
  perf vendor events: Update broadwellde metrics
  perf vendor events: Update broadwellx metrics
  perf vendor events: Update cascadelakex events/metrics
  perf vendor events: Update clearwaterforest events
  perf vendor events: Update elkhartlake events
  perf vendor events: Update emeraldrapids events/metrics
  perf vendor events: Update grandridge events/metrics
  perf vendor events: Add graniterapids retirement latencies
  perf vendor events: Update haswell metrics
  perf vendor events: Update haswellx metrics
  perf vendor events: Update icelake events/metrics
  perf vendor events: Update icelakex events/metrics
  perf vendor events: Update ivybridge metrics
  perf vendor events: Update ivytown metrics
  perf vendor events: Update jaketown metrics
  perf vendor events: Update lunarlake events/metrics
  perf vendor events: Update meteorlake events/metrics
  perf vendor events: Update nehalemep events
  perf vendor events: Update nehalemex events
  perf vendor events: Update rocketlake events/metrics
  perf vendor events: Update sandybridge metrics
  perf vendor events: Update sapphirerapids events/metrics
  perf vendor events: Update sierraforest events/metrics
  perf vendor events: Update skylake metrics
  perf vendor events: Update skylakex events/metrics
  perf vendor events: Update snowridgex events
  perf vendor events: Update tigerlake metrics
  perf vendor events: Update westmereep-dp events
  perf vendor events: Update westmereep-dp events
  perf vendor events: Update westmereep-dp events

 .../arch/x86/alderlake/adl-metrics.json       | 489 +++++++--------
 .../pmu-events/arch/x86/alderlake/cache.json  | 284 ++++++---
 .../arch/x86/alderlake/floating-point.json    |  29 +-
 .../arch/x86/alderlake/frontend.json          |  78 +--
 .../pmu-events/arch/x86/alderlake/memory.json |  82 ++-
 .../pmu-events/arch/x86/alderlake/other.json  | 209 +------
 .../arch/x86/alderlake/pipeline.json          | 308 +++++++---
 .../arch/x86/alderlake/virtual-memory.json    |  43 +-
 .../arch/x86/alderlaken/adln-metrics.json     |  54 +-
 .../pmu-events/arch/x86/alderlaken/cache.json | 107 +++-
 .../arch/x86/alderlaken/floating-point.json   |   1 +
 .../arch/x86/alderlaken/memory.json           |  50 ++
 .../pmu-events/arch/x86/alderlaken/other.json | 102 +---
 .../arch/x86/alderlaken/pipeline.json         |  55 +-
 .../arch/x86/alderlaken/virtual-memory.json   |   3 +
 .../arch/x86/arrowlake/arl-metrics.json       | 566 +++++++++---------
 .../pmu-events/arch/x86/arrowlake/cache.json  | 200 ++++++-
 .../arch/x86/arrowlake/frontend.json          |  39 +-
 .../pmu-events/arch/x86/arrowlake/memory.json |  36 +-
 .../pmu-events/arch/x86/arrowlake/other.json  | 197 +-----
 .../arch/x86/arrowlake/pipeline.json          | 230 ++++++-
 .../pmu-events/arch/x86/bonnell/other.json    |   8 -
 .../pmu-events/arch/x86/bonnell/pipeline.json |   8 +
 .../arch/x86/broadwell/bdw-metrics.json       | 256 ++++----
 .../arch/x86/broadwellde/bdwde-metrics.json   | 180 +++---
 .../arch/x86/broadwellx/bdx-metrics.json      | 268 ++++-----
 .../arch/x86/cascadelakex/cache.json          | 404 +++++++++++++
 .../arch/x86/cascadelakex/clx-metrics.json    | 389 ++++++------
 .../arch/x86/cascadelakex/other.json          | 404 -------------
 .../arch/x86/clearwaterforest/cache.json      |  35 ++
 .../arch/x86/clearwaterforest/memory.json     |   2 +
 .../arch/x86/clearwaterforest/other.json      |  22 -
 .../arch/x86/clearwaterforest/pipeline.json   |   6 +-
 .../arch/x86/elkhartlake/cache.json           | 296 ++++++++-
 .../arch/x86/elkhartlake/floating-point.json  |   1 +
 .../arch/x86/elkhartlake/memory.json          | 261 ++++++++
 .../arch/x86/elkhartlake/other.json           | 404 +------------
 .../arch/x86/elkhartlake/pipeline.json        |  31 +-
 .../arch/x86/elkhartlake/virtual-memory.json  |   4 +
 .../arch/x86/emeraldrapids/cache.json         | 284 +++++++--
 .../arch/x86/emeraldrapids/emr-metrics.json   | 475 +++++++--------
 .../x86/emeraldrapids/floating-point.json     |  43 +-
 .../arch/x86/emeraldrapids/frontend.json      |  78 +--
 .../arch/x86/emeraldrapids/memory.json        | 231 ++++++-
 .../arch/x86/emeraldrapids/other.json         | 332 +---------
 .../arch/x86/emeraldrapids/pipeline.json      | 259 +++++---
 .../x86/emeraldrapids/virtual-memory.json     |  40 +-
 .../pmu-events/arch/x86/grandridge/cache.json | 155 ++++-
 .../arch/x86/grandridge/counter.json          |   2 +-
 .../arch/x86/grandridge/frontend.json         |   8 +
 .../arch/x86/grandridge/grr-metrics.json      | 204 ++++---
 .../arch/x86/grandridge/memory.json           |   2 +
 .../pmu-events/arch/x86/grandridge/other.json |  29 +-
 .../arch/x86/grandridge/pipeline.json         |  52 +-
 .../arch/x86/grandridge/uncore-cache.json     |  45 +-
 .../arch/x86/grandridge/uncore-memory.json    | 338 +++++++++++
 .../arch/x86/graniterapids/cache.json         | 305 +++++++---
 .../arch/x86/graniterapids/counter.json       |   5 +
 .../x86/graniterapids/floating-point.json     |  43 +-
 .../arch/x86/graniterapids/frontend.json      | 105 ++--
 .../arch/x86/graniterapids/gnr-metrics.json   | 487 +++++++--------
 .../arch/x86/graniterapids/memory.json        | 206 ++++++-
 .../arch/x86/graniterapids/other.json         | 243 +-------
 .../arch/x86/graniterapids/pipeline.json      | 261 +++++---
 .../arch/x86/graniterapids/uncore-cache.json  |  42 ++
 .../graniterapids/uncore-interconnect.json    |  90 ++-
 .../arch/x86/graniterapids/uncore-memory.json | 240 ++++++++
 .../x86/graniterapids/virtual-memory.json     |  40 +-
 .../arch/x86/haswell/hsw-metrics.json         | 206 ++++---
 .../arch/x86/haswellx/hsx-metrics.json        | 222 ++++---
 .../pmu-events/arch/x86/icelake/cache.json    |  60 ++
 .../arch/x86/icelake/icl-metrics.json         | 385 ++++++------
 .../pmu-events/arch/x86/icelake/memory.json   | 160 +++++
 .../pmu-events/arch/x86/icelake/other.json    | 220 -------
 .../pmu-events/arch/x86/icelakex/cache.json   | 273 +++++++++
 .../arch/x86/icelakex/icx-metrics.json        | 399 ++++++------
 .../pmu-events/arch/x86/icelakex/memory.json  | 190 ++++++
 .../pmu-events/arch/x86/icelakex/other.json   | 463 --------------
 .../arch/x86/ivybridge/ivb-metrics.json       |  76 ++-
 .../arch/x86/ivybridge/metricgroups.json      |   5 +
 .../arch/x86/ivytown/ivt-metrics.json         |  80 ++-
 .../arch/x86/ivytown/metricgroups.json        |   5 +
 .../arch/x86/jaketown/frontend.json           |   8 +
 .../arch/x86/jaketown/jkt-metrics.json        |  40 +-
 .../arch/x86/jaketown/metricgroups.json       |   5 +
 .../pmu-events/arch/x86/jaketown/other.json   |   8 -
 .../pmu-events/arch/x86/lunarlake/cache.json  | 182 +++++-
 .../arch/x86/lunarlake/frontend.json          |  39 +-
 .../arch/x86/lunarlake/lnl-metrics.json       | 560 ++++++++---------
 .../pmu-events/arch/x86/lunarlake/memory.json |  75 ++-
 .../pmu-events/arch/x86/lunarlake/other.json  | 358 +----------
 .../arch/x86/lunarlake/pipeline.json          | 253 +++++++-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  14 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 352 ++++++++---
 .../arch/x86/meteorlake/floating-point.json   |  28 +-
 .../arch/x86/meteorlake/frontend.json         |  82 +--
 .../arch/x86/meteorlake/memory.json           |  90 ++-
 .../arch/x86/meteorlake/mtl-metrics.json      | 553 ++++++++---------
 .../pmu-events/arch/x86/meteorlake/other.json | 149 +----
 .../arch/x86/meteorlake/pipeline.json         | 252 +++++---
 .../arch/x86/meteorlake/uncore-memory.json    |  18 +
 .../arch/x86/meteorlake/virtual-memory.json   |  40 +-
 .../pmu-events/arch/x86/nehalemep/cache.json  |  32 +
 .../pmu-events/arch/x86/nehalemep/other.json  |  40 --
 .../arch/x86/nehalemep/virtual-memory.json    |   8 +
 .../pmu-events/arch/x86/nehalemex/cache.json  |  32 +
 .../pmu-events/arch/x86/nehalemex/other.json  |  40 --
 .../arch/x86/nehalemex/virtual-memory.json    |   8 +
 .../pmu-events/arch/x86/rocketlake/cache.json |  60 ++
 .../arch/x86/rocketlake/memory.json           | 160 +++++
 .../pmu-events/arch/x86/rocketlake/other.json | 220 -------
 .../arch/x86/rocketlake/rkl-metrics.json      | 385 ++++++------
 .../arch/x86/sandybridge/frontend.json        |   8 +
 .../arch/x86/sandybridge/metricgroups.json    |   5 +
 .../arch/x86/sandybridge/other.json           |   8 -
 .../arch/x86/sandybridge/snb-metrics.json     |  36 +-
 .../arch/x86/sapphirerapids/cache.json        | 343 ++++++++---
 .../x86/sapphirerapids/floating-point.json    |  43 +-
 .../arch/x86/sapphirerapids/frontend.json     |  78 +--
 .../arch/x86/sapphirerapids/memory.json       | 231 ++++++-
 .../arch/x86/sapphirerapids/other.json        | 382 +-----------
 .../arch/x86/sapphirerapids/pipeline.json     | 259 +++++---
 .../arch/x86/sapphirerapids/spr-metrics.json  | 469 ++++++++-------
 .../x86/sapphirerapids/virtual-memory.json    |  40 +-
 .../arch/x86/sierraforest/cache.json          |  25 +
 .../arch/x86/sierraforest/memory.json         |  24 +
 .../arch/x86/sierraforest/other.json          |  49 +-
 .../arch/x86/sierraforest/pipeline.json       |   9 +
 .../arch/x86/sierraforest/srf-metrics.json    | 204 ++++---
 .../arch/x86/sierraforest/uncore-cache.json   |  32 +
 .../arch/x86/sierraforest/uncore-memory.json  | 240 ++++++++
 .../arch/x86/skylake/skl-metrics.json         | 367 ++++++------
 .../pmu-events/arch/x86/skylakex/cache.json   |  74 +++
 .../pmu-events/arch/x86/skylakex/other.json   |  74 ---
 .../arch/x86/skylakex/skx-metrics.json        | 385 ++++++------
 .../pmu-events/arch/x86/snowridgex/cache.json | 296 ++++++++-
 .../arch/x86/snowridgex/floating-point.json   |   1 +
 .../arch/x86/snowridgex/memory.json           | 261 ++++++++
 .../pmu-events/arch/x86/snowridgex/other.json | 404 +------------
 .../arch/x86/snowridgex/pipeline.json         |  31 +-
 .../arch/x86/snowridgex/virtual-memory.json   |   4 +
 .../arch/x86/tigerlake/tgl-metrics.json       | 383 ++++++------
 .../arch/x86/westmereep-dp/cache.json         |  32 +
 .../arch/x86/westmereep-dp/other.json         |  40 --
 .../x86/westmereep-dp/virtual-memory.json     |   8 +
 .../arch/x86/westmereep-sp/cache.json         |  32 +
 .../arch/x86/westmereep-sp/other.json         |  40 --
 .../x86/westmereep-sp/virtual-memory.json     |   8 +
 .../pmu-events/arch/x86/westmereex/cache.json |  32 +
 .../pmu-events/arch/x86/westmereex/other.json |  40 --
 .../arch/x86/westmereex/virtual-memory.json   |   8 +
 151 files changed, 12770 insertions(+), 9855 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json

-- 
2.49.0.472.ge94155a9ec-goog


