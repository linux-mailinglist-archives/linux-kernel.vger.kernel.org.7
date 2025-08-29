Return-Path: <linux-kernel+bounces-791070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7367B3B1A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B8367BC4F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BCC22156C;
	Fri, 29 Aug 2025 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VdjIH+qz"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDEC221546
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438334; cv=none; b=tBy551vRjBeFWs+0hcwDjMVZxtgaYL8DccnKq8V4ehuwVn4qKl128M9bdZWx9PNHlMDVA6AuhMH9ANJCk2lnW5cX13MyMDVDdinwfBTN63D7VNbGVxD2z5oicfYzbgMkPq5DocAou2jv/sk9pLtwcqUikL2enRhihDwwfP7S7NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438334; c=relaxed/simple;
	bh=UWuqUFoPAbtNw47XnAvBqrdOwtohVNIOBeexM7UAGKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AXu9GlBlGe1EPndRX/hZtCjBpoJF+PgSsCVxGvCWZD/nAHY4h3XwN0Y1BfsRaE1L1Rey/Lmh+y3jnOUJyc76+C6A1CWEbeWj2PtZeSGgu0SW+Ii/Ka7aP8o0GtdtFV5HHzdz2axls2iJKVUv+nW4GRBSxoro4aJ5LOidcngG2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VdjIH+qz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471757d82fso1288900a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438331; x=1757043131; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QGW1t2fTrlxsy99oh9r+8W3JLxNT7O01vCVlWKIguI=;
        b=VdjIH+qzsUOn4WEaym3bsio8QUzhrrIF9GbeEp4y02I+hPE1yMStpesMDm4N0HNZrT
         i7MxL0WVbBFGwwKCNVwSDGgq+f9Gva6kIXumRioEAvdyT5kvCdQ2ujRyujAW3Gj7fB3l
         sSMlIcVQXfH5sdjhryi6iW/rQGFmAOVXHdCI8Ti21nCAwUBSAWJzBCjXY3k+mJi19j6Q
         kpIqtCYi5/cpKfPh4kpWnuTu9uD18Svyre0236If4AcIogDz+TWmECFDkQS/y3LZcVRq
         m8aQtwgNaeMtYSxItC+IVr2MChxvv8DCP1CbhyLrmD2kZCrFPBOCb/jpv1QsMqikk9Qa
         wvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438331; x=1757043131;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QGW1t2fTrlxsy99oh9r+8W3JLxNT7O01vCVlWKIguI=;
        b=qkrjVNkB4dkQkfPfrcs7tmUno76kU+E6zQ/RjushvomtQH6lvI8F3Ar35U3v2xxaoO
         6RiiauWrAiFgw080fFtz0T7iT3uZObsSNApt/lmRav9nArtKKmQwMbfaYvUU4DY27yun
         28Td1V425g35czs3k6kcH1eIEEI22L4NsGGQuYPWVZBA4A5q5t5mb3uZWob8K44Fo86J
         k7+k0ROOlN2pAhl0uG7E4wJxwSOtF6S0ZI6FHCzyMpX6R1DqSJLjwsfw6tlLDJGIukwf
         iAdfCYz8geM6OeFuqT1VfZlmzrKglVSgB+jxSEJMXyivjuqHRZ3bnkMTHgSNIlLaC8iD
         DSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJOCvI4Nqf0IkU4WpUSp5eajuukXmNGrfLZArXMnzksw3bXeE0EB5ouuPeDX8UtSq2+GHWAOwplUPO8ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXrq89vvPWQOJ/1+GKeREN1xitVLo6M3UcOlDnZmHTqup9Fiq9
	VHU6jA6LFmVkDZR0xCjcGYymDCU8eur76fIxzy6Y9nX8G25cAvAXjwHHqmlwgqx6ObjRDKbQ6Fn
	hyTfI/dAztA==
X-Google-Smtp-Source: AGHT+IFruY13+0TIPjlDfpbi3fSgUGsWRBLlzXlFgq9LQVQaDvQ7884Pr78k5HIex9b+grU3F8xjr/hDvs29
X-Received: from pjbsb4.prod.google.com ([2002:a17:90b:50c4:b0:325:8ff7:fd4e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d83:b0:327:9345:7097
 with SMTP id 98e67ed59e1d1-32793457259mr9000011a91.10.1756438330967; Thu, 28
 Aug 2025 20:32:10 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:38 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-14-irogers@google.com>
Subject: [PATCH v5 13/13] perf jevents: Add uop cache hit/miss rates for AMD
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
index 0578ca7fdf92..d51f4c3fe0cb 100755
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
2.51.0.318.gd7df087d1a-goog


