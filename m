Return-Path: <linux-kernel+bounces-799907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE9DB43143
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 445E07B3115
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E6826F2A0;
	Thu,  4 Sep 2025 04:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B20lofRK"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878926E702
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960880; cv=none; b=fOP8axQsDuE5UCOK3a8z5MYikGjoTNUrXtgSGhbIYufKbekoFMa588zSOly9a5QqCuHIs9SdpbVdgQy3R3/X0nFB8b9GMQbm1Re4LAZTVpTYhTVMbymtCeXFCSOWtVQRhBkN0gVtDl0jRheneYu7juXfsNo7B3/aSSHm4UcYOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960880; c=relaxed/simple;
	bh=BivOpsCDlj6Ru6Y1v8vqQWzWVWfc4mJL7YxG+enkvi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=H/JcjHrKVCxhlRvz/bGYGcfcjhpcguKf6lUzfNTnO14Htvffj1VlxsfI3y6sOULgDPnQBC/vmONAtyF1m9mQEnNFNU3dvLkHPOLA8PUFIqP10g/IrAbkTHzseRep2XqykssC7iBWd4Ezwx6hOGF29IKu0v+31q+tc6dmXgXxNrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B20lofRK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24c8264a137so8450415ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960878; x=1757565678; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45l4Nbc70EVKZSax2ToeXyk5HR9RXkMGigjhQ29rNYU=;
        b=B20lofRKATaQjzpG+HB4MQ0TyuYNTL+1cCxyDxOhiMI1APGQsr4NDyfctmP7p7TE7x
         W7z9nIevG5I2d4oTxLNnDHY1alg3R/O+BTIMBTvgcPuYN20ET8dcztQAqOZ2p6ik2uok
         sZ5xmoBRxegaLo1nwRmOB8xuDYIipuaO9qXCgL94DMmTIbWDmoTGc1nTz3FZMeur+YsX
         ovUo5rLNkl7iBy+lydNEWmGY1AF9NuuIvE8ZV0F4icd2/x/jjU3b5JOyS4e8tQhxYYzI
         B0QY4/JQvXbY+AwjFY5rlqIs/eBxJQFdd1kixtIQXPbT+Rc2LjpLAMpONwC9dvdFbU4g
         3DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960878; x=1757565678;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45l4Nbc70EVKZSax2ToeXyk5HR9RXkMGigjhQ29rNYU=;
        b=hSpfJ3rpkGtg20bZtc/99e33f8Y/7vQG4JH1NHx4u9/8tqFXUR4dEnv+ILzjZYEfIv
         E8ODJiyV2GaEUDhdJ+3bkF8ZFQtZ3DKMdDNRCvYSe3qHwUCgStM0iK6JscHR0tE147bj
         KBhgJJpbVFln5xCSpnkXTw1AfSV2RLgxF7M26QbCoRA3DWH1UZ+lgbOTiSramDiwP7Pj
         Mm9vIf/S2wpesxTzmdvwK7mU/wrHmBFqC+5lqTB8W/TiwJkqHEmkIofxW/xak3HKDguZ
         sO+CWYeT6yooDSu+C5VoxTcmRzQd9Vj/h5I9Xno3N1HUofV6RFdOB0kLQOrW84Ky+Rne
         an4g==
X-Forwarded-Encrypted: i=1; AJvYcCVPSJk2kVkmpfcUu76VtUK8TqDEChzwA54cAFW8+LBJ9UbhttfKQ+H4RinFQ33fAVOnIyTnassgA03pD84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCM4uhhiwVpA1OwW1cbVcwh88tUMHs0mqnE0CDj5kIW27nP4yg
	2Pk7fQX5UwUIlKP/A42Qpx3fz0CG6+xBDOpJ0tnH9NsIVDSFr8H9Zlwm2944laWXZhDRxOl4H2I
	stFgJZlEd9g==
X-Google-Smtp-Source: AGHT+IFjrwY6H5XIxngL3wSepYwbC5YU2i0XhpZ085evNzhAMNsUpZLoTY71sUiT2wF+USz0iC3XmuS8kyGH
X-Received: from plbkc12.prod.google.com ([2002:a17:903:33cc:b0:246:5b98:9a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db06:b0:248:7b23:5129
 with SMTP id d9443c01a7336-24944a4152dmr263420495ad.16.1756960878298; Wed, 03
 Sep 2025 21:41:18 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:47 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-14-irogers@google.com>
Subject: [PATCH v6 13/13] perf jevents: Add uop cache hit/miss rates for AMD
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

Add metrics giving ratio of uop cache hits to misses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index a782e41dedca..d971fbf40318 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -571,6 +571,23 @@ def AmdSwpf() -> Optional[MetricGroup]:
                      description="Software prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
 
 
+def AmdUopCache() -> Optional[MetricGroup]:
+  try:
+    op_cache_hit = Event("op_cache_hit_miss.op_cache_hit")
+    op_cache_miss = Event("op_cache_hit_miss.op_cache_miss")
+  except:
+    return None
+  op_cache_total = op_cache_hit + op_cache_miss
+  return MetricGroup("lpm_uop_cache", [
+      Metric("lpm_uop_cache_hit_ratio", "Uop cache full or partial hits rate",
+             d_ratio(op_cache_hit, op_cache_total),
+             "100%"),
+      Metric("lpm_uop_cache_miss_ratio", "Uop cache misses rate",
+             d_ratio(op_cache_miss, op_cache_total),
+             "100%"),
+  ], description="Micro-op (uop) hit and miss rates.")
+
+
 def AmdUpc() -> Metric:
   ops = Event("ex_ret_ops", "ex_ret_cops")
   upc = d_ratio(ops, smt_cycles)
@@ -657,6 +674,7 @@ def main() -> None:
       AmdLdSt(),
       AmdHwpf(),
       AmdSwpf(),
+      AmdUopCache(),
       AmdUpc(),
       Idle(),
       Rapl(),
-- 
2.51.0.338.gd7d06c2dae-goog


