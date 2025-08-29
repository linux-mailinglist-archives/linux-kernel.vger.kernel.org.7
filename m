Return-Path: <linux-kernel+bounces-791047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC2EB3B176
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626CE16D200
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AB222E406;
	Fri, 29 Aug 2025 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QkEsJEg"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EF42580E1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436871; cv=none; b=OUdch0JgMKuN2u6FpFUxYmjZwCt05baUiD/bl2+SKC6IDcsDsqGwUhWBi8njjPpUMtqPQH7+ucet9df27DsyHLg5xa8uKjyE5/7bOC8bryJF1QlW7lsZYcwakpnbM/MGFrvkqim5s3WBEeTgHIZ09Qj7UiBnvCGJKjB/Dc/Weig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436871; c=relaxed/simple;
	bh=vPT4VQvFRG2eLzpiomf4pL9pOT2iHADuHZfUC5NZtbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ssuv2TSTHT019FI4SmW5w0aT1rPXL1cSKHGJtR15EjMTnehfsVFkSfxiKM18raWY11CjcqE0wkzAp9O22jLhRbLuzBFjpu4TTPclczwk73n3zt0EJjWxyd5T+lwCmKILcbvg1wSxHSNvfB7FcMqvkfO8aGKu/PlFAUxoot8oXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QkEsJEg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e931cb2a9d4so2311181276.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436869; x=1757041669; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HQ9OhIA434ZXQq0lhegQ9wYn9PPiz6by3gG/UF8TfU=;
        b=2QkEsJEgJ2QQgd0UBSgHuG0KOD9XoEWK1QTE9oXO5Quq79qyhrlYnaed3cVjZHIxHQ
         SGeRdRpkZRAg8phj7qHyjkQtrHvsqW/Ph+a3PlBxgDf4gfaqa8bf37Rz+2Cxjq9YVrXG
         fBky+vMW1EaFECsFCqJGhIIgh7MorCX0SRACquDF4LQPTLS9ZdkorXH24Mzgmv4DOJf9
         ymizpVXzFbYPvjeZMJ5cPgUBJO6w0fgdh2Y7E//bh60zwTdyj7g3E3A2K6qtP1r9LGCc
         IwsIfMLP9rlwcAC4nbLwtQZcngMsB3KJ2EbO7wFusF3h+I4fruZ4umXXzF3qN5mmen7D
         +hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436869; x=1757041669;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HQ9OhIA434ZXQq0lhegQ9wYn9PPiz6by3gG/UF8TfU=;
        b=H3OQF7dwjSmGETrrkv+7pia68kbrY4q0INqmkDkz8MyvTjA8wJs9xFRPZK5Q8DAZQP
         RuNpo9ylQKGCd7NqpzKuOJIue1gOVw8tJDw3CDmk5Okge1zZARdwN97OQmSXL5jWEu5W
         bOpRvx6XkruyAegZLgStGPsglD4HSrWno2GYYflyXYX6481DKcyN0JZaET2zRWsr/UTs
         mWZ/PEd8DS27hGxm8lMkDD/L7w7QAwdNXZooavONCGCUkYmQt4HfNwh8uNu+JE0chT13
         9LycL7kiHhu3RavunmdrJtnO3ILT43SzERHaHeGVEQtYbxZQ0/1gOyB3TwyjRnrXU5fR
         t6JA==
X-Forwarded-Encrypted: i=1; AJvYcCU9L0ZTx33I6rkYL4xI4uMzMDO1JG5CNXgSK3vFMv9wg7QrO5RQovrnNs8h4GllYAjJUNVftfLOM7t/nlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbBO4UahbIQf+i/tKAR33VwUIatMHVQq52qVkggO6S9qAyFdi
	Jk/iqjkF62CiiKrxyae2ruDldkN+BCAEHIQNJlb27Y3uGO1ZsPgPe/8TOHALOMdroTIHvLOpAtR
	C76rmF3iHTA==
X-Google-Smtp-Source: AGHT+IGdzjHIa0BbGqS0yZ9Tt3V+4NRLwYmzIEe6Qk7aryOvtgBfXEMbMlaQBPpL6a2bVgBwK4ll1x4z/3MX
X-Received: from ybdq11.prod.google.com ([2002:a25:f40b:0:b0:e93:3801:f5e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:1506:b0:e87:b880:7dee
 with SMTP id 3f1490d57ef6-e951c22463dmr33733875276.12.1756436869532; Thu, 28
 Aug 2025 20:07:49 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:24 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-11-irogers@google.com>
Subject: [PATCH v5 10/12] perf jevents: Skip optional metrics in metric group list
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

For metric groups, skip metrics in the list that are None. This allows
functions to better optionally return metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index b39189182608..dd8fd06940e6 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -493,13 +493,15 @@ class MetricGroup:
   """
 
   def __init__(self, name: str,
-               metric_list: List[Union[Metric, 'MetricGroup']],
+               metric_list: List[Union[Optional[Metric], Optional['MetricGroup']]],
                description: Optional[str] = None):
     self.name = name
-    self.metric_list = metric_list
+    self.metric_list = []
     self.description = description
     for metric in metric_list:
-      metric.AddToMetricGroup(self)
+      if metric:
+        self.metric_list.append(metric)
+        metric.AddToMetricGroup(self)
 
   def AddToMetricGroup(self, group):
     """Callback used when a MetricGroup is added into another."""
-- 
2.51.0.318.gd7df087d1a-goog


