Return-Path: <linux-kernel+bounces-799881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76441B4311E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2754B563DF3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC82405FD;
	Thu,  4 Sep 2025 04:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+yV2qPW"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3546223ABB9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960339; cv=none; b=mzobIS6ZBAL1TjXjkS6ggyafBWzYdcm0HUGajQ7EUE5mCPlUobKW8Er4UFnFt4zwtlzU3lmCzw84TipaCeqtrfqQgSENpFw8nXBNKGb9j1+d4DnukQAhhMkbCDGVSmq+rHTdtQlBTLmhRagJ1KOA7B275kX6c3DL5CmRLLAU3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960339; c=relaxed/simple;
	bh=0RPBjnceF5UpLiqTTakM2AaSGE5p69eLJpir3NTUx0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=e6FfGZrZIO1XtptzwLuiJRP8bTRvVc7g9FLXdOphYtI5+Bl0xKCHp2s+rwpZxCvk9H3BnkORkFsrbm1s8x2k3estRQ3pCUWd5LHvnm+Xi7W+HMg5YqTDnIUbnPYc6uWDbOi1C8u+YqDwoIeC0H7Wp/OK7hV7xrGmhazy7kaBuRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+yV2qPW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-248942647c5so22335835ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960337; x=1757565137; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2lfIBu5f1DxfhgEKiV2IDDjUkUIidIMEUpWK67aUsc=;
        b=Y+yV2qPWblknkHxJboQnnlEc/8ruGV17CtFCeivcYu/NS3UjsBoz4IvCXrvQOZBLyw
         iVPGPjE5ojL1kk89iRyLF3zgCcNwIq6hsgFrS/Yo/iJkCGKogx2UFVFqjOZNH5qyP3e9
         4H8zZnD5GFhbUz5GmaGqHgQrf9ByIbxCW1doUnCQhdaUt7NmZWvJWptgGpAW7CJbc/HE
         VjHscczmMZOFFHKPKxS4N9ujGFKMT5w4YL7CXs0xAC4LgbRvaO+rOh98L/gq9HWSSMH6
         szGqy4US3IpRrkPIEQ5dFkwxCiUQgGwIvKVPwtlOW3xXOQ46cPWdIzyAIxsdLMArDdBn
         1VTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960337; x=1757565137;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2lfIBu5f1DxfhgEKiV2IDDjUkUIidIMEUpWK67aUsc=;
        b=GcXmsTBmWKNn2NU41noJerYN8wTuHww/EAoRZbhaWQEBnzr0+7d9gfP+WFfNcGYBVn
         0sdfThxwSKB5BwGHpxZET1EX1VFrm0gi/qz1jvmFB2HszU/IyCqzRjjb/U423067bXtJ
         nxqxaLvseYcbvCq4Z2FVaADoIoLanv65gDKFd+62Om4s6k6s0ltIG2dQ4lSsd0opDiH+
         8gXJyZ1AXLZ6MWSaf2vI0zV4K6YRQSehmPLBXJfFJsD81BPADdW6s7MC7nQcjIJBzRM2
         zSkUx66QFHQCeUKr5qO8Z6N79s0VvL7E4l8/VMtGS9esYrOCD2HD5rzIQmvSrllU8Uee
         h1zA==
X-Forwarded-Encrypted: i=1; AJvYcCXl43nkxPPYvsdZP4B0u+ug/xOJuwJs0TfdpCWwwTx61Trdz7zLoQPyE1H3EDOgBZ9+YqwSg/OVnL7DgbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsvLj9Equ3z923FzMrDJMRG61ihYJMKzsMORs68mPP51zbuKoz
	NZpoTZNM6WhoQu+zc0++9/4djW8joqc4R/xqwIkUJ0vTPKiOJCgTCQQgoeUV33ZrEOK8Zrh+RfI
	JYeVxllEH1g==
X-Google-Smtp-Source: AGHT+IF/ZqUKvU90sQ2w6nn0OeK1VO0/1UHdn3i3JpViVGm3hRUc0lal3yb0JJNQn2HdGoQ4pPEVbxu4o+X9
X-Received: from plev14.prod.google.com ([2002:a17:903:31ce:b0:242:fe10:6c5f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54f:b0:24c:af27:b71
 with SMTP id d9443c01a7336-24caf271a3dmr38228775ad.20.1756960337405; Wed, 03
 Sep 2025 21:32:17 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:31:58 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-4-irogers@google.com>
Subject: [PATCH v6 03/12] perf jevents: Add descriptions to metricgroup abstraction
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

Add a function to recursively generate metric group descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 8a718dd4b1fe..1de4fb72c75e 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -475,6 +475,8 @@ class Metric:
 
     return result
 
+  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+    return {}
 
 class _MetricJsonEncoder(json.JSONEncoder):
   """Special handling for Metric objects."""
@@ -493,10 +495,12 @@ class MetricGroup:
   which can facilitate arrangements similar to trees.
   """
 
-  def __init__(self, name: str, metric_list: List[Union[Metric,
-                                                        'MetricGroup']]):
+  def __init__(self, name: str,
+               metric_list: List[Union[Metric, 'MetricGroup']],
+               description: Optional[str] = None):
     self.name = name
     self.metric_list = metric_list
+    self.description = description
     for metric in metric_list:
       metric.AddToMetricGroup(self)
 
@@ -516,6 +520,12 @@ class MetricGroup:
   def ToPerfJson(self) -> str:
     return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
 
+  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+    result = {self.name: self.description} if self.description else {}
+    for x in self.metric_list:
+      result.update(x.ToMetricGroupDescriptions(False))
+    return result
+
   def __str__(self) -> str:
     return self.ToPerfJson()
 
-- 
2.51.0.338.gd7d06c2dae-goog


