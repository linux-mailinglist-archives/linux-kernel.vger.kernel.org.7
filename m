Return-Path: <linux-kernel+bounces-791044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8BFB3B173
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA30BA022FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DDE24E4C4;
	Fri, 29 Aug 2025 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjgJY+L6"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68433246327
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436866; cv=none; b=ZW3j1GTV5dBSTjALsHdUHM/H+r51Gb5kCHu8b34q6fhO2laZdDMUOOZdhglcHsRMUhnWdHz12sKDXpRVt//8APRyfkG5AVCSebtsayuTnWRZD3YDCpd46M+mozMSBbH7Mj9eRFa/u/0yoMdufINvQJNzgNpdljq2pVwbKhzSRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436866; c=relaxed/simple;
	bh=s70LreTJZvpj/UsPUpkL5mH/ObEy5UgYgmp7RgZyric=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kBhsC4DDwlCrmDAWraiP0+HRiaP1e7wnMuj/DAlR2Pb7yIBjxfc5qqEsrEc5eQG0ne+hPKj3b5g3QQWo8m9AY9Wy7WLhR4IbCS6DAarzTBU20TjpM7zcKMEyTbdRLZh2QTqOcjBbc+tHEI5PyYokBfk7WI7TV/+NvNh66Y+/YMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LjgJY+L6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-325ce9b32baso2008163a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436864; x=1757041664; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdhDBFzLixhDw1nJ2o5nfgu+L4QKWT2FN7h03sEUhSk=;
        b=LjgJY+L6B8ydp63HPto/iYa8CKeDI8XxbRSC4UU0FhySG6Kc67SElckYH4JkfLJcWj
         RnhLPRk8HktFoXT4Je9Kzxjh/gZZin4pNHY0ekR29JxeIsibpLdtsA/2rogMPKCyKeeT
         dkw/EvwHvEXaacvq8DTfa6DqUiaEqbAb5I8UC38NxKOSEx0Auh20L5FYFtwGIeR+Vqsd
         gw9M5QTMiaa8f8qs6YiOxPNO+K5yyHnFi6rZdOrZ0MoJiKt+iIK9HPCkTIIfqn9RZ7iN
         9qKZG0hL+IWV9bOW9CecjnPYzzr6oGYJ1EI5hq/gooky/eGgAkUhD4HaOAoiE1bSCHfe
         uxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436864; x=1757041664;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdhDBFzLixhDw1nJ2o5nfgu+L4QKWT2FN7h03sEUhSk=;
        b=dn85xdB1WRk5vOqczny2KVjPgRXQLocdp7A6u4vsn9kq+UEJDBGhh7sTo2wc1YqpdM
         F3+3HXQOgvSzBOlIpVxThWSZkPNmtmJ8CxvMSnw/CWBZ0qDFrQQ2RSWSdjUsXhavW/rj
         XbHYx0+vINP/yeoeNy+kmbJsx6W6rthYuEDuEjiVKLrrHoMFpyBUqymfZ20+EGo3y2VK
         nspbVWFud7OIyChui1Y1AjP+KKX0rqlCLUC7K6xNnx34WCqC0tOwr4Tdb8MuMdMKyj8D
         MbikKztqdEe8liE7nufEAYwZ/Lx3rOiLSOWOjuhpjvL3h8OAiUf2Qa5bnKwachLU81L8
         VDtA==
X-Forwarded-Encrypted: i=1; AJvYcCVIRp5LStNQFEFkr/6JXrapm7uv85P8yOiR+ELHnWXYG+zl/R8NPKF6sABtArqahsAZiqx8HBIEGElOLSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ7eO6JM/qQwEQR90xUu+p1ZoOe7l6aGNUL3T1m9B0esQKfpDq
	wXRy4N9TIKncpoYRf0KH4PmtxrcOyGZxZ+cdPLHMpzAMzPdAO7uOH+o6batKQJljo+B5RgSsEsa
	EM8I2hZ/S9w==
X-Google-Smtp-Source: AGHT+IEbT+wkcETwIt3TUVHTdsXkGurRbI70ZJMFBroFp7ZiFb9MonRdrQNpj5wIIoMAOuAeZRG7Q1KXiLsI
X-Received: from pjbpd15.prod.google.com ([2002:a17:90b:1dcf:b0:327:e9ca:a5ae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2683:b0:325:58f6:1f91
 with SMTP id 98e67ed59e1d1-32559056397mr24152621a91.11.1756436864622; Thu, 28
 Aug 2025 20:07:44 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:21 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-8-irogers@google.com>
Subject: [PATCH v5 07/12] perf jevents: Add threshold expressions to Metric
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

Allow threshold expressions for metrics to be generated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0f4e67e5cfea..e81fed2e29b5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -430,13 +430,15 @@ class Metric:
   expr: Expression
   scale_unit: str
   constraint: MetricConstraint
+  threshold: Optional[Expression]
 
   def __init__(self,
                name: str,
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS,
+               threshold: Optional[Expression] = None):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -447,6 +449,7 @@ class Metric:
     else:
       self.scale_unit = f'1{scale_unit}'
     self.constraint = constraint
+    self.threshold = threshold
     self.groups = set()
 
   def __lt__(self, other):
@@ -473,6 +476,8 @@ class Metric:
     }
     if self.constraint != MetricConstraint.GROUPED_EVENTS:
       result['MetricConstraint'] = self.constraint.name
+    if self.threshold:
+      result['MetricThreshold'] = self.threshold.ToPerfJson()
 
     return result
 
-- 
2.51.0.318.gd7df087d1a-goog


