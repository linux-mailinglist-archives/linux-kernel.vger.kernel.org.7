Return-Path: <linux-kernel+bounces-898589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED331C558DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49CA94E5A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3747631A81D;
	Thu, 13 Nov 2025 03:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3kp4QsgX"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325BC31A053
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004136; cv=none; b=BbwYu0oIaBh5xSZtYa/4/BvIBR58dK+8jL9yJlyDZZL2Dc9LRmc37C3Vw8iSrwUU4yEHKrYEWhqzahKjG8YRXqMi+mqKGdl1Ly1L6ebbCmiuQ45Sn6Jh+IMqxYXO3kXORmt4vICxKpic+D93ltfCJTvUDqrdTNH0N0oMsMwt0wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004136; c=relaxed/simple;
	bh=aof78n+qXDg0c8e2xLQ6nv2btzFyt+M0yFV/x/avhsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=M5GEITZlcCmdv4kiEJWmnLw+u/8hKLwdPgdJQZ6DIrgf+7fZFUNj+K0h+F+7YJ+8sN4PTeHHNdnia3GugpOxxAacH4TUNXGRLR+59ZmN04+5zpaWT80i+Ecat1I/kV2XiuCcLyxQ2XcHVteTlpjv2+zJP5A0ZsILA9asU+Bb2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3kp4QsgX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bc2a04abc5aso310456a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004134; x=1763608934; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rc3vNPxf2jUSlVFOyC9V3KttOj9emUQIRVikRtApQE=;
        b=3kp4QsgXV7mEsH7lDBZ/7gcrjbG9w7gFU2F5KOw8z8ivkm3n+O7ANmNE3hrTiUD/FC
         Hh36SP2MGP8QuKWCaw0vcwuexj+/BqsR556Pb+oEuN/2h+/SaRoUrjhsIW0lIXPXpaC4
         L/ApiFct/1z+1JZIEIwVHXf1x/M1kV6CBKyheiljGKYzLMf6UPSvHxacGR0zDl074JGG
         j+zrwRcLuEJrgrm+Y3UANxfPklCQE1cbWz6CMjuExI5w7Eh2amwfjyDl4JXvKOLLL9f4
         WFpRUVJNQhmWxucIY40ivDip3EgOK1N9jSzVweB+x420Dvnbx6Bk7lRyl3QG6gLWfkxH
         YeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004134; x=1763608934;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rc3vNPxf2jUSlVFOyC9V3KttOj9emUQIRVikRtApQE=;
        b=e6a+3TrUr3sH7Ws5TxNtD7gU4shiOCmmftaTEAlF8jFa5/Hroaqaw2PMdwj4kPL6qw
         uucBJoyZ+xuFqfTdKrT1CBUUnbRQ3QLVio79WN8Pjn5Thd1rEw4fP7JptxmVELn2tbjj
         pq/Sm0tM1XFtvaNQ4RbQaywX0P54cy2ZRQv4o566F4dVD/qvOwPSuzJVEy7kFLhPA95H
         jLib4NCrNzqpnbV3b+UgsQnd9xsz3QZMb9c3ewTOTtSdgBG+oZ6oQCTE4bxMikkPiITI
         /IvuHLJ3q3zzNmOoMvyu/Lcbe2KNPeF6CSwEAuF+qRZyLlcaURH1WwFtgwLMeqAUp9UV
         JQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJXS5RqF7hthCMpiejkPNElpUbzC9VaareRJK2DGk+UA1Bm871RutJOfmc0cM0TePYcYfzIybb0JfbCnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlZoCvk4ctgczWIbNeU+/B7wWnUB4etgbwADY7eBJYlau4F1w
	TfKAhQUiJ99OrfUDnA8RKMRFFs6749F0rimwaf8vfUP3pwTA7klLV+zaYd8JRFObQorc7/T03DA
	FC+BZM5ZtKQ==
X-Google-Smtp-Source: AGHT+IG451KaGljKW2LZv3uhYjbm+8KjnbK7p3zGZIkXlmpEzkSU86j96z3iWIVFLyDJsjPJwDfCrT09VOAG
X-Received: from dybqf8.prod.google.com ([2002:a05:7301:6488:b0:2a4:8a9d:ddc9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19d0:b0:298:1013:9d11
 with SMTP id d9443c01a7336-2984ee0354emr68940195ad.43.1763004134472; Wed, 12
 Nov 2025 19:22:14 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:30 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-43-irogers@google.com>
Subject: [PATCH v8 42/52] perf jevents: Add Miss Level Parallelism (MLP)
 metric for Intel
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Number of outstanding load misses per cycle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 77b8e10194db..dddeae35e4b4 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -624,6 +624,20 @@ def IntelL2() -> Optional[MetricGroup]:
     ], description="L2 data cache analysis")
 
 
+def IntelMlp() -> Optional[Metric]:
+    try:
+        l1d = Event("L1D_PEND_MISS.PENDING")
+        l1dc = Event("L1D_PEND_MISS.PENDING_CYCLES")
+    except:
+        return None
+
+    l1dc = Select(l1dc / 2, Literal("#smt_on"), l1dc)
+    ml = d_ratio(l1d, l1dc)
+    return Metric("lpm_mlp",
+                  "Miss level parallelism - number of outstanding load misses per cycle (higher is better)",
+                  ml, "load_miss_pending/cycle")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
     pipeline_events = json.load(
         open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
@@ -836,6 +850,7 @@ def main() -> None:
         IntelIlp(),
         IntelL2(),
         IntelLdSt(),
+        IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
     ])
-- 
2.51.2.1041.gc1ab5b90ca-goog


