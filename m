Return-Path: <linux-kernel+bounces-791041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B63BB3B170
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0797B9163
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3BD23D2B2;
	Fri, 29 Aug 2025 03:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyUlXrg+"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281A2367CF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436861; cv=none; b=MTk1fvePLb11QwSeMLal0GxLW/0rFewPBmFu/oJzh/e211loGUHTXt+Nan+xG6+85kXG0tE9D/377DpR3sZa4PJ5h7TvQOxWw8NKKdsKaORyrYHHFcRx86F8mNdCLYzrhFazLd2VtXO0JP5atyoX+5BYLu/LwCG+uUUAjXGOmVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436861; c=relaxed/simple;
	bh=t4ReXMJgriC5I4KqqQbRdSp1YY/UN9E1HoYL0hXqW28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PS9Y9Cufjfl8oJCzvgLyIDQaHYqO8VIbwr6iZR2cJy6Drh579slUodJmh+EHnrXA7WZt79vbPsNpKHmoOHqGeqqc0+dVWmu19DKmP4rKBW0eDJ9yTd9XZNswNf082tByIaPlbqA/DYM8/D8biRPBicWHS0cWLKcP6TRU5Iq+TiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyUlXrg+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-246cf6af2f4so31822445ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436859; x=1757041659; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=miRE9bQUs9E5F/zguUv2KfDf7fNpSn7w0KCF34UFGOo=;
        b=vyUlXrg+MN+B1jM0EiKGPLrWDQYjunQmt+WWpNSNtgaqEavo5i5C6Y3n3DSJnZ2Jbl
         b+irn7Rs3J7O2zMozQovv+daqm+1hwFHm5Lm7RnQfy1gs/HhIwaMd6qYQ/y60y2IWOA2
         nTyPG8oP9pFr1fNXeQTPQN5ZnQSyxyDTsco1JZIi5Zdscrchil+KcQaig93eytpm4tAw
         SALv5SM2JowLi6u2uK2Gcm6KDDH+skYvBuM/H3CbYepA6tasxJD7bikQLeGyZmnZ+e2k
         Fc4mIYyAouoCzb1hoMeHrZoDdoC8OFFRg35bOy0fOVB5+9p1Bz8WnEJSt+eck+UZVWIZ
         c+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436859; x=1757041659;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miRE9bQUs9E5F/zguUv2KfDf7fNpSn7w0KCF34UFGOo=;
        b=A9Rhbn/DA8byOUTTmR3Q/zLl6aDhXM/J3lcobNqFTVe+I6TqiQDYXM/yjv9wNw0IAR
         pRtq+REyDez31PGr3RXnfafoaf5aTk2nBeaHc6amc2+nvVJjMkgOXj3fcXCcDdyAbb6N
         19iQTD3WZwA93UKXvNQ+/6r9QBsMHvBrhAn66RzxlgQRE4S+hYWo/RH11QcO8dyJvhHy
         JzqThTAroqDo9qwxJhngHxHrHw5SqCnPuWJFnJZXm9XnUsLUtyWNtS0Hxw1qvYOMyb0f
         xGfkrDAS6ChFRSDIDoi0djHbYREPn+ZCPzDhOFsLeLCULE3skt3eyzNcOzLAWMk5cm/j
         VTRg==
X-Forwarded-Encrypted: i=1; AJvYcCUhxVAu+xPTZRNFQ9yqQ12Jj0Bsvxz1mHoX0inG+xr8Gb5GTW3htZTUe0J6lJh34oHb0/7h3gHk5signsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Xv0qDYxBqfsaPXk+Bm8jMN42czNb2G2B0vCQd4cg2+VfIXvN
	wvlrvNzXLhw8ZK72y05UyM7PqKFa6qRWvn19ITm5E1P5asL8qFMqZiYF7XGSP5fMzHoP6O3yKR6
	2fJo4ta3Xeg==
X-Google-Smtp-Source: AGHT+IGIZiYj6zApZF0kJzHfxqReG02e/qq1X9hh5OsvTs758zszvYqfayhjbJhomTpvOiQotDK/zGCPfRj7
X-Received: from plqs5.prod.google.com ([2002:a17:902:a505:b0:248:7327:44b8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aef:b0:248:e3ef:13fc
 with SMTP id d9443c01a7336-248e3ef16e4mr61366975ad.16.1756436858995; Thu, 28
 Aug 2025 20:07:38 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:18 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-5-irogers@google.com>
Subject: [PATCH v5 04/12] perf jevents: Allow metric groups not to be named
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

It can be convenient to have unnamed metric groups for the sake of
organizing other metrics and metric groups. An unspecified name
shouldn't contribute to the MetricGroup json value, so don't record
it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 1de4fb72c75e..847b614d40d5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -455,7 +455,8 @@ class Metric:
 
   def AddToMetricGroup(self, group):
     """Callback used when being added to a MetricGroup."""
-    self.groups.add(group.name)
+    if group.name:
+      self.groups.add(group.name)
 
   def Flatten(self) -> Set['Metric']:
     """Return a leaf metric."""
-- 
2.51.0.318.gd7df087d1a-goog


