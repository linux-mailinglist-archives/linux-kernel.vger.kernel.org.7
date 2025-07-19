Return-Path: <linux-kernel+bounces-737520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C66C1B0AD8F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CBCAA2666
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DCE2222DD;
	Sat, 19 Jul 2025 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYvdJpiw"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C5224B14
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894348; cv=none; b=msS5f1w+dn+VLGYQd9pYCf4xjykAyf9Gc87XojmjbWQ2CjCzBTyITUvnVMfeUL10ZmMflkWMgb7ZwAXnuyVxAcadglfj2EbO1O7efLQlDEFPGnLH0qneOozslHC2OnKlAnpZW+4AwxYM0adSiUvaPiVbRJqIfvVki41q3EtkgYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894348; c=relaxed/simple;
	bh=9zUQeTccp3718gUxjT/0ylX/P1DJl6kmckROyxaibeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RrITZN7j03EfVuel9Aq9nJLZOxn61oiV0Em5RLaC/BK/v2hTif0LEfcZ51pnY4oZFPqAHs5FjrvG9OX0mEF0tIfs6RcucyKJ+mwl+GN/SE2anh/dHf48PEEni3HdRyh3kjGTjd68WfOkhv0adnjf8gIpL0cXnihfD36aiL7vOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYvdJpiw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23536f7c2d7so44687505ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894347; x=1753499147; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJ/d8adwiFNGcK/vA7cpk18Ivr6shkjwDMIS9Lqkdas=;
        b=bYvdJpiw7dxBQpA1GpziKDskaL/G3rB7DxavjGQVgJX3U+LIbFrrg2BaAqxwieWWC/
         ggcQ7p9L7/TPYzyzAGjxD7o/uJrmpRrH0hnEiltBgVJV4HmS2mSWMLIQRfD1TomLp1Fj
         HndaBe1l3i/GFnCWpbVB/Q26h8Onb1NrFLofYnBwzG8h7tSuOrMw1W6ufOw96YExPurD
         YhSMfKt+crxVNz/fqhDF6n/lfh/24xCXz9eGLBGtJ+eSjgFzu6rqwGz9dpurUymGZvtJ
         mmH67cJKUrE52zcI/lUhMIdGxtgnhWix6rm9/Ife2lgEDHmdQq4zFpKespoYwZC5nAcg
         IEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894347; x=1753499147;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ/d8adwiFNGcK/vA7cpk18Ivr6shkjwDMIS9Lqkdas=;
        b=RPfeYdXDqDZhfRj8DM1n2O+ozKmSDmr1VedPq4Ra5Yj30Z1D7nXJKHTOKwVF8pN2bH
         hpPjJbniGKmMa3YVvTX6OmlGGocJmanq9ZnAUcJ/QC3GNc7oOBAinV0gnI92Y4S3/Dxm
         4WBYI3CZwGi3GyhM64yHSzsFVjReVQ1g2DbKClE12GXzNbwGUm8XyBqEEjVCWH8LLs19
         6gZTvKOzp6uwkLYRxObxuTwr5H729eL8JjudhMnt0i9QA7COY5aSHfr9+84Y39BbCkaJ
         XC3vQEqogeHYATd2B52Ii7RojIVT044LwSWyLtM8a5Kv2yK3pwT5aX03yWhQZBTsm6wL
         4jIA==
X-Forwarded-Encrypted: i=1; AJvYcCVp+6xHT2Yf82/+GjHd4TeOwnbmYqs0aerHZ/dclnNJ8I8U7b7I4k30MDfK8jmskqdEGwD44Y7v7qvGuOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxeMBJY8rbGAOHc630yWoD4o+sKe6xY4jvNsfr4rFy4B3gQdLb
	bNcFdQX0OnEJhPUtEjtRtfCN83SfMLJaC3z2ZAGoZ8FrXedjM9TQsGWC6LsroIvUKE6DqxIcsiY
	AtJmbrGgFnw==
X-Google-Smtp-Source: AGHT+IEB+pdxCUFskM3zmnoHCS0R9y7J1DhdQMJx0Yjnf/P70GiRb2Ww+gtayc9A6phNdIH+SPcnHMedriJE
X-Received: from plbky6.prod.google.com ([2002:a17:902:f986:b0:236:71ef:2187])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce0a:b0:23a:bc47:381f
 with SMTP id d9443c01a7336-23e25763d49mr160412775ad.36.1752894346988; Fri, 18
 Jul 2025 20:05:46 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:11 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-10-irogers@google.com>
Subject: [PATCH v3 09/15] perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow a PMU to be found by a perf_event_attr, useful when creating
evsels.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 29 +++++++++++++++++------------
 tools/perf/util/pmus.h |  2 ++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 409b909cfa02..9137bb9036ed 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -814,24 +814,18 @@ bool perf_pmus__supports_extended_type(void)
 	return perf_pmus__do_support_extended_type;
 }
 
-struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
+struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr)
 {
-	struct perf_pmu *pmu = evsel->pmu;
-	bool legacy_core_type;
-
-	if (pmu)
-		return pmu;
+	struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
+	u32 type = attr->type;
+	bool legacy_core_type = type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE;
 
-	pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-	legacy_core_type =
-		evsel->core.attr.type == PERF_TYPE_HARDWARE ||
-		evsel->core.attr.type == PERF_TYPE_HW_CACHE;
 	if (!pmu && legacy_core_type && perf_pmus__supports_extended_type()) {
-		u32 type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+		type = attr->config >> PERF_PMU_TYPE_SHIFT;
 
 		pmu = perf_pmus__find_by_type(type);
 	}
-	if (!pmu && (legacy_core_type || evsel->core.attr.type == PERF_TYPE_RAW)) {
+	if (!pmu && (legacy_core_type || type == PERF_TYPE_RAW)) {
 		/*
 		 * For legacy events, if there was no extended type info then
 		 * assume the PMU is the first core PMU.
@@ -842,6 +836,17 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 		 */
 		pmu = perf_pmus__find_core_pmu();
 	}
+	return pmu;
+}
+
+struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
+{
+	struct perf_pmu *pmu = evsel->pmu;
+
+	if (pmu)
+		return pmu;
+
+	pmu = perf_pmus__find_by_attr(&evsel->core.attr);
 	((struct evsel *)evsel)->pmu = pmu;
 	return pmu;
 }
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 86842ee5f539..7cb36863711a 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -5,6 +5,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+struct perf_event_attr;
 struct perf_pmu;
 struct print_callbacks;
 
@@ -16,6 +17,7 @@ void perf_pmus__destroy(void);
 
 struct perf_pmu *perf_pmus__find(const char *name);
 struct perf_pmu *perf_pmus__find_by_type(unsigned int type);
+struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr);
 
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
-- 
2.50.0.727.gbf7dc18ff4-goog


