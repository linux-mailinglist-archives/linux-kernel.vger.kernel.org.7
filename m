Return-Path: <linux-kernel+bounces-791069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30698B3B1A5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36915841C3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D97253F3A;
	Fri, 29 Aug 2025 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FU2wvjC1"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2824C66F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438331; cv=none; b=pztDzQu0/+0D747VX+QbrXv8PcQgOLiXMsoaXBWWi84H+JuSBMlJyTofc6k5bjUDD8P/wY8tLtsgvpds7RmE+1fFBXiFGDHHOc2xu8mt3giA8Q9XkS90G5HSgv8v2L9Vy1tgtdpiOjFDWo1OjadoH71+1nRO8dhAPTuhFft+r+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438331; c=relaxed/simple;
	bh=YLBmUKqyByKfChncNXeVqpD0TLc2h2paQwqWcHTkg5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=izyHWCWehFATCvkKY9OhPnuFZQ0OFMuuRXtMWEmYjbgoKWRBpMoxyzjuEgmvu9Kv0fTE3wXEBo0fTYcO9iVSlst2asQJ1PZXZi6KRP2MWSqCkcmqwUcv3qZEzqMtb3B2DwuNdh8neJvEXnSSBXiZIh7QDP8hrvPuGlBH6/N6QGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FU2wvjC1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3276af4de80so2395307a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438329; x=1757043129; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azgTYDxidAa0Wg9n60KfmwRnNMDXPxnP7j6zRI4fODQ=;
        b=FU2wvjC1wPtEbzvphn3i4KvgAx6PxYRmViQYGe4V6RpNeIzF1H7BkiFeNpuLMgECeb
         pSs7L4U8H8SWNdr+MKywL6ZTlN1UezfZZjx91dLNcwYcbwoVkpgL3+5bj+tP3gHUVdta
         eV8OYg5h+z0Bmc4clXH6TejtkWdONf3U0723aKJELz4IlCHIEca9tcN5XP+V4sK+Kvlm
         dnBMlEMller5CLOpSv8poAsfzyzCMDG5zy++eBKKgxz+dnT3LnfFxUUewFsv+xo4Geho
         EzcbjRDhJGoGDl3fX0fpeoU+KsjAxwpa5urw0HKBzgVLyUAwKDIffM7th9IetXrd6C5u
         8NrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438329; x=1757043129;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azgTYDxidAa0Wg9n60KfmwRnNMDXPxnP7j6zRI4fODQ=;
        b=FHJoWXyqGw5IJZSXKjl05Rje5nAaJMjO+L1pqFpIjqputD/dcajkPcSBmkcF3dexeA
         UsQqxLhJ62AcnBIHgkGJSfzC63EwwfvUOWw3HaP/vtpjPgK7QWtA98kL1Td9IwX2CNnn
         sdf46hqfAeWj/3RhY99dZAUTZRkb4+nnyPeEh4WeK0GyAUREDqvoaw13qrLbnvKmFHj0
         NxNXvEsmciGvPxiYvH8DOdOLFXV1U+sIfNulNWLXlqtxgw8kkF0QBD6m3PGY8yWs8wWq
         NERHrnH6ZJI6gNU+U82/rSPT7b3g0bcTxu+fL8E6r/ONpYe7IUdUrg1c9N+7mXC/+boM
         HFCw==
X-Forwarded-Encrypted: i=1; AJvYcCU38Y0a7D99zDgKUd8D734yaeo9NRVEVLAqFCxZR0noo9EHvk7jsxoISSy/B4IDrKt/OM3YkSmnM+xx0d0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mb8FIVVSiAaFdg8Z6B7bQG3KvpTU9IEbTvcXMCFAsGPW3jIu
	OidinM4cp5yLLsixqCVWniAhNIp8I+MiKVCo/LgodM5T4bU82bzwaZYP+wpDmcOmYBi5WcP43ic
	CE+upsSIxGg==
X-Google-Smtp-Source: AGHT+IHOiZutmCPWmceroMLgbMji6CBXE8Gx9EyD41EFFhxkLVIZbmvadQT7TJATRvQTfh0weEfaVKws5J/J
X-Received: from pjbsc11.prod.google.com ([2002:a17:90b:510b:b0:321:c36d:1b8a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ecb:b0:327:e34e:eb16
 with SMTP id 98e67ed59e1d1-327e34eed17mr1435964a91.1.1756438329101; Thu, 28
 Aug 2025 20:32:09 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:37 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-13-irogers@google.com>
Subject: [PATCH v5 12/13] perf jevents: Add context switch metrics for AMD
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

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 2101598e8b04..0578ca7fdf92 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,37 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdCtxSw() -> MetricGroup:
+  cs = Event("context\-switches")
+  metrics = [
+      Metric("lpm_cs_rate", "Context switches per second", d_ratio(cs, interval_sec), "ctxsw/s")
+  ]
+
+  ev = Event("instructions")
+  metrics.append(Metric("lpm_cs_instr", "Instructions per context switch",
+                        d_ratio(ev, cs), "instr/cs"))
+
+  ev = Event("cycles")
+  metrics.append(Metric("lpm_cs_cycles", "Cycles per context switch",
+                        d_ratio(ev, cs), "cycles/cs"))
+
+  ev = Event("ls_dispatch.ld_dispatch")
+  metrics.append(Metric("lpm_cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+
+  ev = Event("ls_dispatch.store_dispatch")
+  metrics.append(Metric("lpm_cs_stores", "Stores per context switch",
+                        d_ratio(ev, cs), "stores/cs"))
+
+  ev = Event("ex_ret_brn_tkn")
+  metrics.append(Metric("lpm_cs_br_taken", "Branches taken per context switch",
+                        d_ratio(ev, cs), "br_taken/cs"))
+
+  return MetricGroup("lpm_cs", metrics,
+                     description = ("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def AmdIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -619,6 +650,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdCtxSw(),
       AmdIlp(),
       AmdDtlb(),
       AmdItlb(),
-- 
2.51.0.318.gd7df087d1a-goog


