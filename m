Return-Path: <linux-kernel+bounces-898555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A34C1C55876
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9ECE234888D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9CC303A11;
	Thu, 13 Nov 2025 03:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1qGVfBI3"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35380302157
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004075; cv=none; b=KDjUQofGQdowoY5rwONQht6W2HWASP/Uy8FYu0oxqOhYKmJfEzpnFVDL3jX6pDNVevRuBRmUTDqUeZNsvTJ6biG5mfVLfw4cwTHHacRGeSSrN3/kQOJMaLM++7CSzEZ91h/nZkoOI2aeOEkWrxj3ms1f63e36zlTPzIgVVXx+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004075; c=relaxed/simple;
	bh=l8YI2kijCrvx8hpO3K53GLyELF8uGdR0pAwA2XzQtu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hAo/m4wzl0fYHU0w7OBw+D/oN2FQOJAKYNbE4derGCX2mdvslzGfkWpfI2/d4wXVdy9Srlem4v9NAqru/nJ5RbIdHeNasFvwUIGeMLeXjJNXmB1ESNgYQk9wbnxDMZuxbpctw4CUSdA3wkMWsQciAJajoOewyE1WKNSY0q5Je+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1qGVfBI3; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29845b18d1aso4338685ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004074; x=1763608874; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eW7d37sVo4I2qTdDjDtWxDxMAZ85R454kXJd8JyW8PM=;
        b=1qGVfBI3FPFW+WlwS7fCsYDuQZCmTaTbmq5au8u7vkf5Fu8NemhqWcMUECTfZi6uJW
         ycuRePCzWVfcv9F3Oqy2sKIxMtW63oDZ8jHUSLLqPiceeipkCaRZS4sO6hsdwE1L0+xj
         tfEYJizmeE+FZvptM9uBauq+dlyX4X8IS8Uw8wzUEPpq7TFCvLZy1b6+sLRgl6UoowJV
         WkLyOF/dG/lSJuryToQDXX/KsfoHxMC3EEyQX84p6IjVrOexSbJH89A2a4LcAfnXMDxu
         GxDZbzAd7MS4LEWn72QusmHOEqVhWdsQj/0g8R0Na6SKpEAZPwKCYdOt94dvukwKZwm7
         nFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004074; x=1763608874;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eW7d37sVo4I2qTdDjDtWxDxMAZ85R454kXJd8JyW8PM=;
        b=PX/m2TEQiN/WSbwFJQ6JSVZF1OOU81qdoYM9sgL6UtjR04KqUPvjXmGRcRgioMO2Qb
         6FnK/jR1FUsnBNo1eZlVwqjBDXIIpU9mnKnELuozqRdRByLsbgQJh3Mu2QMZi+qw4YJw
         nyblrnBvJCcvKVR0WhosGUWZlbUHuhr5wkQem6lXCu8qv5hM2bACtFPR7nOc8eN0fAQJ
         8cJu+6GgxDcvNTdYzpoOSvsc3wN6hbxiWObG1qouii0eEcvBo1t3kvclANWRNfPJdm7K
         5RT8hws+srejopQXW85Y5kHJnczc2nqj20BprUxbgB0wZMUjhO5VNzjpuzl4tkfL4JmK
         DLkg==
X-Forwarded-Encrypted: i=1; AJvYcCXv+Jrve//dfHZJRMpZQlwuY2hIS73OYN1BWQRN79X3tOmIdQ3g53dfplgmOyd86eNHnZq5gbRnTCxYrZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4qIVdslfCnMFlR0SjlVR1jIBjh3iwG/snnNxApfU/eVAHh01h
	VWm0C94yGQ9Px/ApUlxRESyOUXeXyI6/bjv+s/TEN651mM81auhgnyKynm4riHyVVXqyxaOWbzJ
	81qX1oNvswg==
X-Google-Smtp-Source: AGHT+IEcnTx+9eVhJEewale9PaV7e8ZMaoXfn2kM7AawOJ/bTqz1khtL99S/1RU2BLIbUDH1LiKTinAZaygK
X-Received: from dybcr3.prod.google.com ([2002:a05:7300:ac83:b0:2a4:75f7:2135])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b8b:b0:294:f711:baa
 with SMTP id d9443c01a7336-2984ed2b6e3mr66196885ad.2.1763004073616; Wed, 12
 Nov 2025 19:21:13 -0800 (PST)
Date: Wed, 12 Nov 2025 19:19:58 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-11-irogers@google.com>
Subject: [PATCH v8 10/52] perf jevents: Move json encoding to its own functions
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

Have dedicated encode functions rather than having them embedded in
MetricGroup. This is to provide some uniformity in the Metric ToXXX
routines.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 34 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index e81fed2e29b5..b39189182608 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -484,15 +484,6 @@ class Metric:
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     return {}
 
-class _MetricJsonEncoder(json.JSONEncoder):
-  """Special handling for Metric objects."""
-
-  def default(self, o):
-    if isinstance(o, Metric):
-      return o.ToPerfJson()
-    return json.JSONEncoder.default(self, o)
-
-
 class MetricGroup:
   """A group of metrics.
 
@@ -523,8 +514,11 @@ class MetricGroup:
 
     return result
 
-  def ToPerfJson(self) -> str:
-    return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
+  def ToPerfJson(self) -> List[Dict[str, str]]:
+    result = []
+    for x in sorted(self.Flatten()):
+      result.append(x.ToPerfJson())
+    return result
 
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     result = {self.name: self.description} if self.description else {}
@@ -533,7 +527,23 @@ class MetricGroup:
     return result
 
   def __str__(self) -> str:
-    return self.ToPerfJson()
+    return str(self.ToPerfJson())
+
+
+def JsonEncodeMetric(x: MetricGroup):
+  class MetricJsonEncoder(json.JSONEncoder):
+    """Special handling for Metric objects."""
+
+    def default(self, o):
+      if isinstance(o, Metric) or isinstance(o, MetricGroup):
+        return o.ToPerfJson()
+      return json.JSONEncoder.default(self, o)
+
+  return json.dumps(x, indent=2, cls=MetricJsonEncoder)
+
+
+def JsonEncodeMetricGroupDescriptions(x: MetricGroup):
+  return json.dumps(x.ToMetricGroupDescriptions(), indent=2)
 
 
 class _RewriteIfExpToSelect(ast.NodeTransformer):
-- 
2.51.2.1041.gc1ab5b90ca-goog


