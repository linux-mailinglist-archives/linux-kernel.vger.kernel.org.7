Return-Path: <linux-kernel+bounces-898557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFC4C5586A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD3FA4E18CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E26930596B;
	Thu, 13 Nov 2025 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHBE/nU/"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499EA2989B7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004079; cv=none; b=D5k3BTzzxrrUoZp2AiTOnOU0RaYliNWvNnUTCo1yfOKitNU/q/noIc5KLUOzCTyd5Rvy8oRvlLKgBHBg+2CNfExPF5bk/P269MkNECxAgqioSKsgqWrJu00eRjrM9mWozJu/Dpe9RE/zamXLMgCi7UbXq17k9nzTKzlEDXJ52u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004079; c=relaxed/simple;
	bh=S1p+yEIWKmlOuwkc2RFrG5ZPvCF6Q3F5ykdkFTvIhxs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oZW10t6PamjXlEiYzQrsugkJRKgVlwxdAnwvVP4wCBxnIqRD4tLL97vcJkyiCttkYGwAXEOjuQvKFKUjNATRNvenihrf5sVr5pNObFrDC0yVfjdoOXaO3ZH0HcjPzl9TK9e5wpfRTn9uf0603jt0D5d0iINLFnlUgmpkgjXnwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHBE/nU/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34378c914b4so533797a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004078; x=1763608878; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GoM4uSXCA6CGzeSczR6SGCvajUfHPXwjqqeVHJsq28=;
        b=VHBE/nU/fumzGNLpVVnIqbqfXZrNE5XGP/B56ESbRYjeuOMaORimlR8xuzCvH+iEhL
         RAd98LVAwYP8twpoc9lE6POermFAEyVr7L6ElnCdahO0kQhLJZJETNpLZSyWEbd9RhGn
         Mo1KiPfriLldwci5Tyg7grTeobWTSpj4kj0wIInWzIU+6snz+jTa4odGs/iHq7ldBAJA
         T0IlIi4mMdoafIfcRjQssCEVuT/2hgpHemR7BcxdxR4L2SGN1nw0bz/eRBc1EeJMPjKA
         ZXIORqZJALkwoaK/eB/6LEjzMiZ8b45xfJEbmCgEsZHrOyFH7JkUCSfvx35edKMWes1w
         X+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004078; x=1763608878;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GoM4uSXCA6CGzeSczR6SGCvajUfHPXwjqqeVHJsq28=;
        b=Kb0odOXoiKKtLSjor17tt5gcFhbqXvgvw5WOLQ7FTzxOdyP6v1/xnRIDNslhGIvCup
         vEPvb6zo98oztW+hMG7RF2PYf7D8+8iBCEHY9RnZ4GkfNuK5bXPfC+3zMBuWX9f8ODOe
         YK0ynLAFuhCstMqQQHzzmQLzCDyeDd83QklImB98N73hUiA4p+e6ODG0FuZId8C+kKbW
         1VcTqu3vSwqfUdQnulAU1FT71vOcb/UchurEradUJVaTKbv1VB1JJSayrekT/YXpgOUE
         oeM/poETJxXmJYRyQbwv8HqCBRDPb0fi2ErbZdImTiqmBwcENtzRAKE/PpYOJZfnCmGu
         /4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWV8ldnWhhFn8BN2dHvjhiMwwIpnyJq4PPMAlzlk3aAY069UMFqm49W6yXEw8Yx61e0v5HGK2TmECjkyZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJmm4zUKChbefz1ArT0Rs8IKL0x6zVxsRrEwONd/lbUaFa5E0
	ENqZGGzGP8bhPF6AF+myLz41bS58i5citGXZcqn7TKFJUDFJDj7QYwu/7ED5ufZIyGI+2MxkAEx
	/yxxt4yC3/A==
X-Google-Smtp-Source: AGHT+IG5nBgQyb0tQ5Wgrbm72paCCXQH17KCARhUYhe9s1wIJyHK5FZWjUO47LlQ9KaCyQ2iGhz9H5qrVSjd
X-Received: from pjnj12.prod.google.com ([2002:a17:90a:840c:b0:340:4910:738f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1646:b0:32b:baaa:21b0
 with SMTP id 98e67ed59e1d1-343dde1030cmr6855910a91.6.1763004077385; Wed, 12
 Nov 2025 19:21:17 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:00 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-13-irogers@google.com>
Subject: [PATCH v8 12/52] perf jevents: Skip optional metrics in metric group list
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
2.51.2.1041.gc1ab5b90ca-goog


