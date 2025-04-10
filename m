Return-Path: <linux-kernel+bounces-598796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DA0A84B29
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 19:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FE64C0BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 17:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BC428F932;
	Thu, 10 Apr 2025 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H48Jm23n"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479C28EA41
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306612; cv=none; b=rL6aO8TjOxqi7ZbRn/QQjgHP5Fp4Wd+fzvbJX+vfEHlbzo9vmX1OD1OULgO930jB+zAh/FUYnWwyvYsysKvSdPV0EgCnUTebWhUQjfcb/d0miQCJSy6pCcvJsAqDgIl/ec+I0dIuVtgR8EIPzqyZHvd2bNddcknG/++sRPfAtdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306612; c=relaxed/simple;
	bh=X1Vcc+qhXCvLi9/obxnmkB3AaP6EATpW0kQwymqqBMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fJXHznOuH+cbAEW8bf1lRFp/OxYLjpSN8vZLHe0bpLFl9ZyxST9M8D+E9ohKl/6dV/L3TKjFErqFbSKNcfG+6U065HQ7Ppjg8iQTgjkMFLy06+dJuWrfRKCU1EneI21A3QSOg3HSJuZTFlLP+OAuNL8hfsvQBG25ZQZB6YyoGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H48Jm23n; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-306b51e31c7so873934a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306610; x=1744911410; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ozcx3/NEBUmkXi0QyyKv5MD92Ay8My7ba9iOvtFuV0=;
        b=H48Jm23neCtCAc4RWQtkGTwQCUP3gJ3Ej3+tuTTfSaGJNJgmPLYsAfcimzR0IAcYxQ
         /P+hg5kHPJtZ4gaNOn1dOHaqAcSr6jr/0jejCMPlZ7zV0NYj0sOEr2bxTqRLAVVNUOG4
         fgfDNcpxr5Nyg4Pvmo1D91r0itfdoRVkGaVgL0usUHdeC0vA3CEAkI8n6LuG2AXuZSKf
         08xYSV9coscZQpOugaGUfXOOdinPKPSz4H0RNwuiIX5HbpLOe/GMT71LKVodm2spDVh4
         z7Y4hQ54snq/2YevMM+h8kWYbQ/IKrdPGDCPKaEdfwEIiuiikXmjsPM0MwSFlta2N2Gm
         ZQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306610; x=1744911410;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ozcx3/NEBUmkXi0QyyKv5MD92Ay8My7ba9iOvtFuV0=;
        b=W9eT8EnjYmtbpxzRoj+LwbppT7dL5H2DAwtzfsBfMTFpVnhmFc3MbevlXhghJC5CbL
         aAMZ4MUIuYKiBajNxBGczECmsNUyXoWa1QWFK4GSz7hK3FqiOGUjsFucLxOhdwrNoZ5L
         2FxAtRal5g8qGVxANXD/8f39JllpAoeLZGpAevsnC8ezQYZRJ8zqPptP70/5rvpdCOX+
         FxoctqO5XGM1lQvbjnqOnHo88FJAaZJWzpFCP/3GHjqJSnZ4LdUbw2TGAETRwFWTEfq5
         AbTQ34Llff0GbZOXStMgbMP5eqfl9A+1XHkXunWDO32oDjeQHOxTkfnYvqlDyKraRgIq
         TamA==
X-Forwarded-Encrypted: i=1; AJvYcCXXq2O/9S86FUpJFl4njUKHighZxme/L3egZWQhfAzMmzpwFqz6JWKoct4FNkxIu0nSKzAWIZUt4sYMQLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Z20Oy+zfowOerbYpUZjyC84n5bp3XdLQ3RxHqwsR626VJDC1
	Uo+Wcz58k8uEJeqs0XjtkbkBECO+XO2uH20qDT4G/P7TZNtA56I2RIH93rQk9qegV5YIt0WZ0/l
	9+YKfkg==
X-Google-Smtp-Source: AGHT+IHdgEuNsiGXTbMC46t9gyRQdDCOonL+w+/N7Gojul8jN+3BYg75AGrbFGU24EeEJ5jxduYta8cOlPQ2
X-Received: from pjx7.prod.google.com ([2002:a17:90b:5687:b0:2ea:9d23:79a0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582f:b0:305:2d68:8d39
 with SMTP id 98e67ed59e1d1-30718b6f388mr6668076a91.12.1744306610002; Thu, 10
 Apr 2025 10:36:50 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:22 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-4-irogers@google.com>
Subject: [PATCH v2 03/12] perf parse-events filter: Use evsel__find_pmu
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than manually scanning PMUs, use evsel__find_pmu that can use
the PMU set during event parsing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5152fd5a6ead..ad5b40843b18 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2459,9 +2459,8 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 static int set_filter(struct evsel *evsel, const void *arg)
 {
 	const char *str = arg;
-	bool found = false;
 	int nr_addr_filters = 0;
-	struct perf_pmu *pmu = NULL;
+	struct perf_pmu *pmu;
 
 	if (evsel == NULL) {
 		fprintf(stderr,
@@ -2479,16 +2478,11 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		return 0;
 	}
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL)
-		if (pmu->type == evsel->core.attr.type) {
-			found = true;
-			break;
-		}
-
-	if (found)
+	pmu = evsel__find_pmu(evsel);
+	if (pmu) {
 		perf_pmu__scan_file(pmu, "nr_addr_filters",
 				    "%d", &nr_addr_filters);
-
+	}
 	if (!nr_addr_filters)
 		return perf_bpf_filter__parse(&evsel->bpf_filters, str);
 
-- 
2.49.0.604.gff1f9ca942-goog


