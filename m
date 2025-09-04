Return-Path: <linux-kernel+bounces-799882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A69B4311F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246F45613AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A2F24395C;
	Thu,  4 Sep 2025 04:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVZbuCnb"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A223E347
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960341; cv=none; b=OcBsP1AIDOLPwHpVn4fhjiGq14VD0DWDzob4ilUjMGikHsmT6+BxZlEeYLsShWFTFIGwhmcJ+pVzhN0F6sNjIg1qKQt9ZMWiI2tq0JKUbjEApK6HCQUPYDqhTWexq/pLGF3a3e2YL3OKRQT3laKMLsYfKu9gARcJiEkohXxoccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960341; c=relaxed/simple;
	bh=sJpAsx8mv13dx5/WPM3rBOP4a+4Z8onR4PgYsxydnM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GmlgcMBJ9VJ6mhR+VoxRo4RU0CT1gQnUdMhQ//RfLdyK3dXLuMBiBs1PONVzfkxQKN+LTPxLSHNNyh4sEmOA7savyYzH2yTYImj9b1OFr0Vioerp+fP4waUNuvDaTPnFZh9u0gZedIQHIXZU9wnbQMi8hlzkIrnebDk7dw0Yc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVZbuCnb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24cba71c71fso4874485ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960339; x=1757565139; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i4KblLTIcCyuYf67LpT+wj9Bc/JO2zogWh7Nn9T00cU=;
        b=XVZbuCnbFirnqmbTJpolKXBKNAKWTAgMvKf52GV9KHElorgKJV6TrMfJ+dkyHkmgIT
         Hxekgt35aVX39UtcpP3ETsmMsuC+6b648RFpOmQ6qMy1wLYhdgFEgB1mB8zocupdyTmR
         w0qMr5gVrFzzHEoaVzvJREek8mW0ddoQ3WVOtQiKxD88je9ckgIEFd8A/HrSmIRNiaaz
         HIA9auLKmEpu47G7PEbC43eOy08/9i55FBTzgd/EzhmcEB1KxkznmkRV3Hi53aqtEY85
         hZZRDhW7VM4fNrxYKVXFAeyLCx+e3358UR/bSdwOnSGdASONiGiU8v6Ed7j38Jd39Sc4
         BGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960339; x=1757565139;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4KblLTIcCyuYf67LpT+wj9Bc/JO2zogWh7Nn9T00cU=;
        b=tlPMvrPxegV/ChuIR1hDlGmRFaXK7uYMtFx5YsL2DGZp4hov7HDwKta+RO/juAOPVW
         FqTlq0/USoEDWKDtnUBxPTSBCBvXgJeXFPvSouPkaTOLiFPrVcqjbm3lJiybxptcUSfh
         2takIlKpJiZzUOkEZbVEmlMRrCq6k4VgZZ+GCRKDq7wneoQPNDHLVN45vLdqJb6kUtVn
         xjnVlwLuBrgk8ik6cnFegOQcGCJjiK9anwi1eEYAK3BwWjUWNgtUz/fMPsx12vMCOlpw
         inzr84xh4VpIjRUcwILKQ4zDZi1e/BS1jJdBIEKFE2IXDzRQJ5atdz2WflL3OQa9hCPh
         bVuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq24mBQhXTd9OIdzCsQcj8n0kWUZDCoDe4/2iGXCq7PV9XWZ/rqeiYo8DLHi6cXOlaBbdt9CSd/6szC+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUQa4mDLe9AuuqRDlh1A7XaPwYwRVcOSLYkuJLhDhDjYUnsi8
	8OSRRg6Rs45S5kXwJ4ExU98g0sHKSQNixuVknOhLqzEKFOyCEhbrl7HeQjAuN4MC8+mnBr8+5e0
	f5bQGfk9yKg==
X-Google-Smtp-Source: AGHT+IGxW7TBij4TdZWKoXUnYmxnIDkSyPeGRhAu0ENkJ9eeD7HNZ2OHN/FfNe5z9vzdeahi2zHg8J7OT5Dm
X-Received: from plnr5.prod.google.com ([2002:a17:903:1905:b0:24a:a3ce:a5d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf09:b0:248:df64:ec6a
 with SMTP id d9443c01a7336-24944a27103mr206219885ad.15.1756960339205; Wed, 03
 Sep 2025 21:32:19 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:31:59 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-5-irogers@google.com>
Subject: [PATCH v6 04/12] perf jevents: Allow metric groups not to be named
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
2.51.0.338.gd7d06c2dae-goog


