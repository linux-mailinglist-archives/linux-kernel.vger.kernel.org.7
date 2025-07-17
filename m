Return-Path: <linux-kernel+bounces-735979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF21B09639
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9C15A2468
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D03322B584;
	Thu, 17 Jul 2025 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/R0KDpt"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445824469E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786177; cv=none; b=SeSJXK1oauEvwxhOo12K3QH8jI3I43/u+z3sPfSSz++ptgTvPFNBGvsDFH1RBy1zQ0ftdTKZGfyJWWQL07wvrPyFgOHdiVzMmD8gk3yHs41EJNq4txH5reJZaxcvD63ZPJGuBY/RG55u399i2o6UPsOScNiSWJNXZp9+9bq1a+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786177; c=relaxed/simple;
	bh=9zUQeTccp3718gUxjT/0ylX/P1DJl6kmckROyxaibeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=K8Hm3jtSLGETY+sZxvXlSEAaHxhZQFo5dkCuALocCHVMmubewa4oqgFyBsm1wAWFpM28gfqDigvOYeaZ2wePr7YmF3Wt4v3JvH7F04onqkDMK6Xnn69hyJiF0GVzNyyHdKYQ2uNP4dqrnTaEK0KdBg0LjY2wvFZvTprT7yuZNAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/R0KDpt; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2d9e7fbfedaso1609047fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786175; x=1753390975; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJ/d8adwiFNGcK/vA7cpk18Ivr6shkjwDMIS9Lqkdas=;
        b=S/R0KDptUsOmZ7WfpcmNg6SG639Zq1aIYEjSdATDuM80IIHgOez39KCoXFmSQ98u8T
         wZ7xqcgJ7LOUSYqEHTR+yL3hF25ZC0LXI+YvdAiCDLKtshY/iIyot/WwsTRjSF1U/T7+
         xbLYYGaHG/WWjD+fEOzesZYmWlWstuIuZrLK4AfVt5J6D8+gsvhC0m/NC8XTvvslDdfH
         qGMuv3zho/RUAOeAM94xz73LBJLrs/hKp9J/xzhMjRCtY3WVf0tUPBrQQRaODjLqCsxn
         qlsu46Lq1Dc5Dd30UKc7b7rDC+dAYqJziDbyb18JEse8kSrsWpb+4DxwMWzd0W0W+a01
         +J9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786175; x=1753390975;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ/d8adwiFNGcK/vA7cpk18Ivr6shkjwDMIS9Lqkdas=;
        b=X/CjFzGh3MaX9UI+Zj01F6SeV1nZk/byjtxcCDJGOSy3QUzI+7qhDv+XF62n/CGwWo
         0ip4D4x2RNhLCF5f/eFBStG8lUk1D/qlLi57mz9UGWdp5nU0AuZzD5MvbBKERf+4oVzT
         ZTdTPos6PrdJLR7PJk1S6tBITuzmEOGfhweuPAbSfX8P5O96dVID3wp9bJhpRj4a8KA3
         QxVz2Si4Wl++WQDzATN72A/rwJsXp2fl/xwX6/5gwoZOhYPS7nyFwGWpPTR9R/m13Nqk
         HKDqPNA/ZX0skpi8aRB+gxKO7OjEr3gckYKIPFI2054of63VFyZxFeD6MVfq2MjRpiVZ
         Orpg==
X-Forwarded-Encrypted: i=1; AJvYcCV3dhHJokv1yKzXbEBNldMwYA0ITP6y7HEgtGuHXqISiq02Vb+a4Fbw8JfISlhOhQe4FlerJyZo5Vio0Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEd1ABpHY5SQnhrV3sftWpE3GpzzpaZBzSCA9qKq4GqPWE8rVn
	4eGxxbB7QVHXq6j6uSq9rC8S+LGtEoMQ9qn1yPS1ffTvanKWTnjNxDa1BMsZXBn/ytIINBmxHn5
	SdE8daUV9Ig==
X-Google-Smtp-Source: AGHT+IFQrdkpOXC1FDEwFmziGHAaQ0FWIYgGoq1nF194P7haGyxFG4Dt7+N/y2IceE5nPHxNl0Pw1Ki0bHrG
X-Received: from oabdu25.prod.google.com ([2002:a05:6870:3a19:b0:2ff:b181:6d0c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:828:b0:2da:843d:e530
 with SMTP id 586e51a60fabf-2ffb22019a1mr6167320fac.2.1752786175170; Thu, 17
 Jul 2025 14:02:55 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:30 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-10-irogers@google.com>
Subject: [PATCH v2 09/12] perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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


