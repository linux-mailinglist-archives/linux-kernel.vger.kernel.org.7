Return-Path: <linux-kernel+bounces-799884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B20FB43127
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E86D7C109A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383BD253944;
	Thu,  4 Sep 2025 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OP6gn1Ll"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F3248F58
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960345; cv=none; b=sOexz+TkoBZ+b6LrgZPn0tgrAmEwXsUCdU6Wmu4F+tK7UZEUKH4NaaoX4NXi6ns9DyBPE52t6M3QNCppqpwNcFEx2vJDnD8zljBzD4Psczv5zC31fRwKGmWlgRwZzCKEKtpWpCyJmexZ5qP2OOVg1cJVi6hGilzqrRAC/ZS2O7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960345; c=relaxed/simple;
	bh=FFQ/x33xzyhT+pBobfBGMnFQAl1Oel8/+ZnnHcvlzxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PnhasWss0wccFlJTg+E3hIDUQujqRCP49dRjsNM1BlmjQYqPi/upRvmchCkUH0zXCiMbpVOCcBAsZ0PJMLGMaSlQAwxyjH913V9gEqvHj5vi94Vylubmt/yQADqJgR8liKLuYS5/kg9vXBf5uWRDSj273qanouWc2IcjLC/wk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OP6gn1Ll; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24c9e2213f8so8488675ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960343; x=1757565143; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCXvDfYGDTlr+qC+I7oGN3PyicDpMP6nX3TsXqjq6Oo=;
        b=OP6gn1Ll0ejzHdn5bjhJdUe1gHQjD2706y0kMeHOLcy4dLplUn2h7qLUPhjKkgCx8Q
         oHIQfip01mjcL0/in2rJnAA4wSWe1poWyZK/IrgRUumrZD6gP+ZwNQYV7tNBf3+6iMYo
         EzSb4egeypN2Zpa03Kk8yjuioTuHiFV7vx96BkleHxaSB8h65G2M9CXHAmgRjne1PTqf
         9zO2BaGv8G5n16OYGBneb1Taoe7PTjIFk/QnetsqFxKsIOe4cxRih7Etodj/xM/9Z5mm
         5/PYdA9SKx5i50/ZHv742tcfH8G142+hJL3fwGkM2ZGWAgZqe/mndAJS0VLLGxD5AewU
         AeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960343; x=1757565143;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCXvDfYGDTlr+qC+I7oGN3PyicDpMP6nX3TsXqjq6Oo=;
        b=M/dfsHDorqfaEK1m7a4cO+Ye/GfCkBqOeYBuF13g2h5o04L6P5euMT2LiqAkZnR65m
         MGouaQyGJ2VhGP5khfkuRfQ+DXyf/S5VtdQ/5/zPsjpLaSRmRvCy8vgz/d+HAFRUTiJj
         rlOqCxcE+2TLp2LvA0BACFnqi4qelqnuQ1s7vJ0wtpW/JqAQg3KI5F3OoepzB+cd+Ysi
         QLR7NM15ipRO3THwH9ZzBefPB2QCMYlonhjjNAe9Ja86I3C/YagIuSMp+yEgRhsDy2TG
         YjRuA9j7vXCpOx1yXPSzb/+GwSQNSCQdhivpsfN6119oU8x+N9GHNWQUmJRdC3RHxshh
         6Reg==
X-Forwarded-Encrypted: i=1; AJvYcCVxID+gpO0jTyzNG21H4JDno65mqm6cVdWZf+OzXCCiLJxraOl/lNQO4Oi+0gZNcjp3O6dX0cdx5FHbx6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwarT0EKMhTBuDSBMr6bKzWaiWAcS3ii4nr4a+norCMpWx733O0
	WnTJxgMBeeeGkm5qDfGYw1+lbijQN+wDswrLjgcAOR3Ds5pNE1caGIsmvtC93TnYSqhBwrYwroy
	y1zDQngJRcg==
X-Google-Smtp-Source: AGHT+IH7GwRMdQR+RBPrmWyFZ/A4EthQI6tg5cMIYUtM2Dh9hmW/Nn6vUYomzB+1byco7CEhbd0iB57wU0zS
X-Received: from pldy2.prod.google.com ([2002:a17:902:cac2:b0:24b:4cb:e1e8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b06:b0:234:9656:7db9
 with SMTP id d9443c01a7336-24944aa33a5mr192938775ad.32.1756960343447; Wed, 03
 Sep 2025 21:32:23 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:32:01 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-7-irogers@google.com>
Subject: [PATCH v6 06/12] perf jevents: Term list fix in event parsing
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

Fix events seemingly broken apart at a comma.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 31eea2f45152..0f4e67e5cfea 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -568,6 +568,12 @@ def ParsePerfJson(orig: str) -> Expression:
               r'Event(r"\1")', py)
   # If it started with a # it should have been a literal, rather than an event name
   py = re.sub(r'#Event\(r"([^"]*)"\)', r'Literal("#\1")', py)
+  # Fix events wrongly broken at a ','
+  while True:
+    prev_py = py
+    py = re.sub(r'Event\(r"([^"]*)"\),Event\(r"([^"]*)"\)', r'Event(r"\1,\2")', py)
+    if py == prev_py:
+      break
   # Convert accidentally converted hex constants ("0Event(r"xDEADBEEF)"") back to a constant,
   # but keep it wrapped in Event(), otherwise Python drops the 0x prefix and it gets interpreted as
   # a double by the Bison parser
@@ -586,7 +592,6 @@ def ParsePerfJson(orig: str) -> Expression:
   parsed = ast.fix_missing_locations(parsed)
   return _Constify(eval(compile(parsed, orig, 'eval')))
 
-
 def RewriteMetricsInTermsOfOthers(metrics: List[Tuple[str, str, Expression]]
                                   )-> Dict[Tuple[str, str], Expression]:
   """Shorten metrics by rewriting in terms of others.
-- 
2.51.0.338.gd7d06c2dae-goog


