Return-Path: <linux-kernel+bounces-799910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39678B43149
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAD2189F42F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8372264DB;
	Thu,  4 Sep 2025 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="anVop20P"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79272606
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961219; cv=none; b=Bm+dz6xO08A7JhMf2kCyxSc2Vgb6WTr06hcvcNuprxuQrgUqN6nMyJjtBnA2//j0aTxjcY2x/di4soY4JcHr58B4prZZ2Wqxfw6bKiXH2/Tqz2FQn5izeCellW3+drvbfqC04Eiari30AYaIQiwIBlqwumvJCeqXBiW6/XskrSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961219; c=relaxed/simple;
	bh=pPyp3QRjBeWrI3i4sYy6PLgjCOb/UwGJMUURA3x5r6w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=aKGTEvBBGvjCcgE0h+y2lS6dC5iENPb6Giqvm35lQGF1PyoZYl+LzkvNDJLN663jY28wlWYbytias/6tR5J5mZUmrugwiHWGnARVeZEniZWx67oJB8yBE+NUBJLTjgUUt2gk7egDKrQjf1mBYwm9d7Q/9qe+fYYFeU/CDjB5KrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=anVop20P; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24caf28cce0so13524745ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961217; x=1757566017; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/wtsXCe1crNN38ftHJgewPigR80FliDToDCVsI9MI00=;
        b=anVop20PG/XlQ3vhCgSlfHiUyxqTg45O9JefAY2dgSVIS+FERSnNb6Ex4qUc8j0iRg
         yHn5EKDzbWeAwC1hs5EwwZ+ihCYF3XE6C15J26zCdxdniYw+H5sSKgxJ6Qz8WDdUNDa1
         E4hwDv2WqU4ReqOEDcgTRpbez0xBnFph9A9MsFsrl1JxjBNTj47xwZKj91x4Ti4Jp0w9
         hwFqWhp4Ep2qtYTlejoB+LgeMd5I1lv/EJWZLNQ9Kd3+pGOWSYbs2lJ7jDqb2mqVUcC/
         ZP29IOUIUxs5vx8m/9hd8UtTJ4THf2pP9Hhun1qMxKM3BvOHhfXuby5D33IXneNl1HbH
         x8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961217; x=1757566017;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wtsXCe1crNN38ftHJgewPigR80FliDToDCVsI9MI00=;
        b=f9KDI0VknWhdxEVz3UKPpiSMVlR4WFOJL7jYNnCcvqwZp2573UvjruxKTEv54JObkU
         w4ytDDDeCgFd0okLPZLpDhiZ3yfCnN38S0OSmu6ZgDT3mHQADJGkGn83uJP/g2BNLOJy
         3WlrEjC/15qKhua6T3T/1OQq4vXMsFro59ZZW8OTiiBsJP8v5Z35oBSgVZmvj89Nl44B
         7+Ttqq8CJTo42NKNx7KxU9JG5iffCQCcVm539bcG+MIZX+C2OWFhnNXsth3p2mumm4eq
         mlpNP7R11AGrNUp/EjMy6ED8UxPiSLmq3TgS2ss9IpSlkMFVkCmo8Ny2VtDH5kD+QK/f
         5Edw==
X-Forwarded-Encrypted: i=1; AJvYcCVA1SR6t3o0hjh0oRTjaaPuT9Tnr29eL8UFpTx3Ub8ncIuoPBfazox9/MHLZdUBqYX3aQLA5MhsSXyADkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPXi0uAXygkfzwigc9L7ntVa/tndyRY0zAicmhZS0ikdsGCxfy
	lnWcRqlrSQm1NRkH9rinJhfOZWLJNg6Dtyo3Pqakbdbn7TRGXXfis6dm+gReSjTY/nXJj337hZS
	Y0mkGgdbAXw==
X-Google-Smtp-Source: AGHT+IF34w+kQLc2ZC8drlP5SsQkO22teeaHkgdZb57HUZXLMO0e/RDCO0PDXEXa8o+uxKIoXzNAP2o4zOpb
X-Received: from plau17.prod.google.com ([2002:a17:903:3051:b0:24a:95a5:6aca])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c952:b0:248:d9af:de27
 with SMTP id d9443c01a7336-2494486f95cmr256615945ad.1.1756961217305; Wed, 03
 Sep 2025 21:46:57 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-1-irogers@google.com>
Subject: [PATCH v6 00/22] Python generated Intel metrics
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

Generate twenty sets of additional metrics for Intel. Rapl and Idle
metrics aren't specific to Intel but are placed here for ease and
convenience. Smi and tsx metrics are added so they can be dropped from
the per model json files. There are four uncore sets of metrics and
eleven core metrics. Add a CheckPmu function to metric to simplify
detecting the presence of hybrid PMUs in events. Metrics with
experimental events are flagged as experimental in their description.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20250829033138.4166591-1-irogers@google.com/

v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
    Das <sandidas@amd.com>) which didn't alter the generated json.

v5. Rebase. Fix description for smi metric (Kan). Prefix all metric
    names with lpm_ (short for Linux Perf Metric) so that python
    generated metrics are clearly namespaced. Kan requested a
    namespace in his review:
    https://lore.kernel.org/lkml/43548903-b7c8-47c4-b1da-0258293ecbd4@linux.intel.com/
    The v5 series is:
    https://lore.kernel.org/lkml/20250829041104.4186320-1-irogers@google.com/

v4. Experimental metric descriptions. Add mesh bandwidth metric. Rebase.
    https://lore.kernel.org/lkml/20240926175035.408668-1-irogers@google.com/

v3. Swap tsx and CheckPMU patches that were in the wrong order. Some
    minor code cleanup changes. Drop reference to merged fix for
    umasks/occ_sel in PCU events and for cstate metrics.
    https://lore.kernel.org/lkml/20240314055919.1979781-1-irogers@google.com/

v2. Drop the cycles breakdown in favor of having it as a common
    metric, spelling and other improvements suggested by Kan Liang
    <kan.liang@linux.intel.com>.
    https://lore.kernel.org/lkml/20240301185559.2661241-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240229001806.4158429-1-irogers@google.com/

Ian Rogers (22):
  perf jevents: Add RAPL metrics for all Intel models
  perf jevents: Add idle metric for Intel models
  perf jevents: Add CheckPmu to see if a PMU is in loaded json events
  perf jevents: Add smi metric group for Intel models
  perf jevents: Mark metrics with experimental events as experimental
  perf jevents: Add tsx metric group for Intel models
  perf jevents: Add br metric group for branch statistics on Intel
  perf jevents: Add software prefetch (swpf) metric group for Intel
  perf jevents: Add ports metric group giving utilization on Intel
  perf jevents: Add L2 metrics for Intel
  perf jevents: Add load store breakdown metrics ldst for Intel
  perf jevents: Add ILP metrics for Intel
  perf jevents: Add context switch metrics for Intel
  perf jevents: Add FPU metrics for Intel
  perf jevents: Add Miss Level Parallelism (MLP) metric for Intel
  perf jevents: Add mem_bw metric for Intel
  perf jevents: Add local/remote "mem" breakdown metrics for Intel
  perf jevents: Add dir breakdown metrics for Intel
  perf jevents: Add C-State metrics from the PCU PMU for Intel
  perf jevents: Add local/remote miss latency metrics for Intel
  perf jevents: Add upi_bw metric for Intel
  perf jevents: Add mesh bandwidth saturation metric for Intel

 tools/perf/pmu-events/intel_metrics.py | 1065 +++++++++++++++++++++++-
 tools/perf/pmu-events/metric.py        |   52 ++
 2 files changed, 1114 insertions(+), 3 deletions(-)

-- 
2.51.0.338.gd7d06c2dae-goog


