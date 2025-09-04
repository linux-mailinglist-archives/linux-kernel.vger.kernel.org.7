Return-Path: <linux-kernel+bounces-799906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEEFB43164
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E569188CBDB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB4026E173;
	Thu,  4 Sep 2025 04:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XB7yMj44"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C926C391
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960878; cv=none; b=GXJoHGcHZe745UId/Dy+lgwWmxz83secS694FVWNu7cA6R8H3TD0f8wpWIJeK42STDDKKOFFzflr06dE8+TEDzOsprGYAjs88Wwegr7v01JntaG4YeM2Xp3PQKfkyyoF+RlnVvjHAducWPDnRAqlMkAks0cGzVcHOVRX9Kj3ha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960878; c=relaxed/simple;
	bh=DGrU1rY5HwKPFf/jKSY3EHnF4vVKF3aEB2+Ri1iicow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hOJzIFDX2WBBOHWYWg5KD/vS8gJgFqjV0vXUjD70wqGMX072zych/IAhFDKAuj+G+WwNHA8f0OH6doiP8Xp815CeXqC+BdxGYbZAxV7B6MydTn/qo+RIY93ebUCvlu/NWDMEGdpN5wmdjbl9jPwdOGYferPxQ+UHZUYT35Q6Mk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XB7yMj44; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244582bc5e4so8073565ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960876; x=1757565676; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dc8J/lSfrT/Zse7jOcyUvktlEEeGzgdaoDiuhDp7bGg=;
        b=XB7yMj44cFxs5V+UqD5BMuBhsFExfm5RoVDktmRaCuHYoylZY07f15LPg9apKAU6tw
         kaC4qGmvZgMY73Pdxpcb5U13sAvDp7XJOdbzfFOaNBX81EZFW5omRAWq8Ns5g2M/I4DC
         +f6VtTlsbRjXHbeL6s5YcG7g178K/CDp8sDwap254qzJ7fQBj5Exmxzmg24SURTx4Ghw
         Ys0obb+xrrwQbU1r6caLnZLhiJnmqdzsKZHiTUc1gCYaBLacqxDg3hGQ3XF7cjquWrcq
         PbVucYYExKUsxiQZOLlzpsX3SNUR88sZ1FKKMOj+l2VL8xM3nnKZj8RA8BbP5j2UmTaa
         OlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960876; x=1757565676;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc8J/lSfrT/Zse7jOcyUvktlEEeGzgdaoDiuhDp7bGg=;
        b=M1NNn0hvg4NFwqzlxxlzdxMxhEpGhyUxnqjLVYzc/DMgbVP6znU0TMKU0Be2uv4Vmg
         D/25mdl1lk8xMkjL2wCFgvE7fRM/trYAhygb1dhZFYxR2dVsximJCivqclsL9zxn8Fsu
         m7ccSCPwwxyOCQjdw8A2Tdsh6hS2kQflUFgs2/I47hN1xqkyqQ2IP13uoF00LS/y2stT
         zTTAU5zLD/rc+/87E1ufSVuif5jZLX/wjmu5cWsT3G5NMvuhgYeBQiUnmgyOIeSljorx
         kY3GuGqpm08WV9h9LvQxqpTqKbArhIHZXRiG1UmGyl5tq0mVPjZUx21LwLriJ5C64y5W
         27tg==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZpMg/SFuaAQKCb5QYxqFW3ICCARFCXW9TqTa5AbV6R8JYZg3ogro/w0vlvtpJyk08TQdDxggoAxAr3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfuYInHx4zesOyjpFE2b1ie/mhvY5totLzsfYmIkAwThuZcVD
	GG4TjbjM2GaHg/dGiLOPZz5GHWJ848ieFuxXaYIyVR3TSj/vU2eOyBddN+teyN8K4sSCOgN0usy
	0WnPWLGfIew==
X-Google-Smtp-Source: AGHT+IHPmc7iwLBJHkLwlvpUXlXB1HQEMNXkq93kwZbAReOSDquHWYNpl9VKjtBZ0JeiLgPQf/c0bawYvYvA
X-Received: from plbli6.prod.google.com ([2002:a17:903:2946:b0:24c:a22d:44d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32d2:b0:242:a1ee:6c3f
 with SMTP id d9443c01a7336-24944871fa4mr187409025ad.4.1756960876363; Wed, 03
 Sep 2025 21:41:16 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:46 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-13-irogers@google.com>
Subject: [PATCH v6 12/13] perf jevents: Add context switch metrics for AMD
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
index 6f1259796c8d..a782e41dedca 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,37 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdCtxSw() -> MetricGroup:
+  cs = Event("context\\-switches")
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
2.51.0.338.gd7d06c2dae-goog


