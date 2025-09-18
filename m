Return-Path: <linux-kernel+bounces-799889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD761B4312D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B63E44E53B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A967A26A0C5;
	Thu,  4 Sep 2025 04:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQ1CtVtb"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86642641EE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960353; cv=none; b=pKmnh16X8BerrIEpnW4/1zeip/ohHsaqN0mR/Z2nN6ppOARfQY6CVexNVe4imKve1vVP2+6fwdHVv0J4BJSuGPO3aUO+kkJiHDsdyIOBPpBLQTMx201jgnwjXudwztrkvZ4BJp/L7xPrhAoLp4VhZHiyAv2nO61qKLDCU8zEhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960353; c=relaxed/simple;
	bh=dIlZN+Gnq+Pv5HEv7+ksLpTCYIxfcbn+jjj/qtsjp1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MRgMXshFiExkXDNuYkhpssk0vo/ejSE6UomSNfAuZgWPQJi3uxXSQod0bUmpbCNU7ih3Rl0hcfKRKMOrwzXY3KLmlVKdsHkB+1gRjwQESB5cpNqFaxYZ7jFiD9HW8eJpG5+3EGbzmaLTGnHN/4KhAYT9BEiayCnQwuZDDLzGUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQ1CtVtb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-325e31cecd6so471862a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960351; x=1757565151; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kj89/Vi/3/nUoe6eIg4s6aNnEGzrJCs7XuJ/Hgh7cMM=;
        b=wQ1CtVtbHapajgBj08aLNB8CPI/WdKYJ0ZiA7/9xpDVDxldhUrMqE1EH8WBBJZ7UQM
         xzX48G6h9ekNnvWtEkPoRixxXoB1h8zfh58dTqwKtQntXHA595n+9Paj9ozzPPaIMM73
         MyWZoM7sDw06fUFC/yKtNO2OrgFA4wAaVFAlNhxAbOxixWUxoCLp3B424RzyP1QY63Fk
         vS4ivqTAm3gFOYPYpmYYeuKB9oJLk5QryTeE1JFKPA6jDAhD1hJwxTl/phJhi+mdb1N3
         M4aDESGFyXQ+VGGLezgT4NqzOJffauMvhRFSlan4k36RW/8QVXPT9nVln3nIXCXJbmDk
         2XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960351; x=1757565151;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kj89/Vi/3/nUoe6eIg4s6aNnEGzrJCs7XuJ/Hgh7cMM=;
        b=ti6AjYzO4EJVmpIoCqgkGAMjqW0w3dgbdyzmDWEzq5RUZOI6YnyGMOm/N5DKQxOd9D
         NTOQYqGMdmrU7b800kd71lEGPQJbaS4ihstmqzk3QP7JjAV6X64/GUjihnNobg7aYz/R
         mCtw+jXW9vg6pzkU+pg1hMXCuLdxo1PjIMWSSrp8PNrZ/DhsKj8tGmI+v+1724TB4hzH
         DXszK3VjWcTWqmq77wfsQlxRZ4JsvTfLaRF9raSkGWpc4G+OihpDDeawOlw9wNJhD952
         Rl08C+GHKKaglUMF52Eql1SeXVak+3eN0P+sNg6R2lwGLH3LX4xUkIYbR/T7xZ9xOh1B
         iZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdkLP1Vg8rJ3LZhJLLivAJOw+7BfstLDUu0DntA5QYnugJDN6BZd2z758gjqtOA4eDGtlOKeE3+7JejPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/0sonNrJlbqKE1mRoVCaUwVVlCkY8kZf0spGAma8Y/Denc++
	mELh56uXyJ4jlapI3mXo0Qmg3AgvSRG3DQqz+VjOG+rloLkieUya9AKk3BYuEfTFv82gm3Q4kFY
	1mYi/30pj4A==
X-Google-Smtp-Source: AGHT+IGgjt+IiGsGSAAjlyLV/quvNNUrswmcbROBM/SIWa0AxVHu52i8VUE/NkmFDhksdxI2sqtyfjPWgnZQ
X-Received: from pjk4.prod.google.com ([2002:a17:90b:5584:b0:31e:c1fb:dbb2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c05:b0:324:e794:70b1
 with SMTP id 98e67ed59e1d1-32815412ac1mr24371288a91.4.1756960351105; Wed, 03
 Sep 2025 21:32:31 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:32:05 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-11-irogers@google.com>
Subject: [PATCH v6 10/12] perf jevents: Skip optional metrics in metric group list
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
2.51.0.338.gd7d06c2dae-goog


