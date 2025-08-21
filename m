Return-Path: <linux-kernel+bounces-780757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8DDB308FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA4767B2AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95CD2DAFC9;
	Thu, 21 Aug 2025 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2YscNyg"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9522EAB84
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814728; cv=none; b=Crdnj5QxRXL1nghSUEeu4rSLyHxQ8m/fCxDIgx90rvh/mlc20TsqZAVO5fNyXcS4Gvji7O8Q95RGBZj9vwHPLhYalD1LalOO10zBxPy8WQjGVV3kjMXJFSvWrM6sWrlPXmr8eLbhj3PJbhdNEEEWXUwqERq0tDtGHzJRNDeRbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814728; c=relaxed/simple;
	bh=fbQi14GqPscWDRXsuaN+KHcS/bYHMtgBEgiE1yKNiWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QK6qHMnZlIzTVeBA0f/6oK9JgccQvhYafE9kPhp59dYxFsBpihcceSmzi9qx1eOZvcDGOcVxKqQvlYcz7u61xn4ZdN3k2mSFNKMxWO/wKvU2PPPyhtkEySRhPEE8+hi+MH8efWCo3/2hh4I3p/GjpAYASE/2IdQFxCHWFeyOeTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2YscNyg; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266ce853so2802183a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755814726; x=1756419526; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTccXPd7+v6/+rANPjgROi6ymWhIsKsDtgiSee4TJ28=;
        b=W2YscNygGieDSHMEeIgrlNztBrJOoV7MZt0jYr/kld0J3grEdETY8Bu8eQizkHEE0H
         TuDwhm+5gnfdVFM9v48kw1ENiY+xEBJoxa+LOB7GUnMotpI+5K9j2m1788Y+fuIYf4+1
         L+TazcblVRMourvTHrREmo6cIddV6JriX2MArksSwH7BrYtLmnfd4BozvsvvnNNtEpOX
         otezFxg51OpgMcqPf1v+R4WsHm0OfRHBZuhI1Sc/txlcXnoI0KtqZ9JIVJxBbhtt5r5K
         XuRk6tYSffTQSYvGCDujuFKv9C+7ljn9WLCR5mWt7XfA6oChME/NEBMns/+YUNF3T4V9
         1vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814726; x=1756419526;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTccXPd7+v6/+rANPjgROi6ymWhIsKsDtgiSee4TJ28=;
        b=eNNEP+A4QE7BqkJowWxEkrycw3a8USc+TlVaCrh3m5CEfo5TefjVZCV08W3TxBWicG
         rmxKBhCE5hHGaDrbfaIOuVH6Wqsh8C/IYp4XrWhrXzYXkuzEbXi7CIjnl6INm4QYb5dQ
         Oh0KLxjIWYUSzBOU2mi9GLNl3JRShMKV76h7hg4z+afWYDbsHzlayY8JbTDfj53/Tj7f
         Fk6N79F3ERTEUoJRlP/7p6iMq8kgej2nSZGYqc8aNLZpZPn4e+lRW+Hkmm2HmBkaJDGS
         6foVVN9ck2EkU8C2KcXEbG+Ew5eBFuyHbHBgZWs49Qdfg7Sr30w4sNOqlrc9HCvlwE+9
         mrsg==
X-Forwarded-Encrypted: i=1; AJvYcCWye8cij2+n5A2raZxb6+NdqT+TP37q36sQ1e1Yi2k/YStwEvmvADemZTf4VpcxGOyKLXPXxwc37PPnYxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc1562/IRvWlMP91jo9xx4seCIAMYBPni+tqFQ2qDvqxSVNBMK
	B6Z9UTYIKAxijGJqmYJ+uCfiVVIodunKSRtgHjQMlWB/logmRWjCcst1UhqwEt/wop9EWrECjaG
	Mik0WrZGOtA==
X-Google-Smtp-Source: AGHT+IHYTLEVbWOFzSCLICihvRMf6bXyZv9JRpV/nHlthIixzEwFOPWfEWnbOTko7BA1kkfGaRewlPLUh7vf
X-Received: from pjbqa5.prod.google.com ([2002:a17:90b:4fc5:b0:321:c2d6:d1c3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d88:b0:31f:11d6:cea0
 with SMTP id 98e67ed59e1d1-32517d1dd5bmr1283481a91.27.1755814726056; Thu, 21
 Aug 2025 15:18:46 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:18:33 -0700
In-Reply-To: <20250821221834.1312002-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821221834.1312002-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821221834.1312002-4-irogers@google.com>
Subject: [PATCH v1 3/4] perf evsel: Fix uniquification when PMU given without suffix
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The PMU name is appearing twice in:
```
$ perf stat -e uncore_imc_free_running/data_total/ -A true

 Performance counter stats for 'system wide':

CPU0                 1.57 MiB  uncore_imc_free_running_0/uncore_imc_free_running,data_total/
CPU0                 1.58 MiB  uncore_imc_free_running_1/uncore_imc_free_running,data_total/
       0.000892376 seconds time elapsed
```

Use the pmu_name_len_no_suffix to avoid this problem.

Fixes: 7d45f402d311 ("perf evlist: Make uniquifying counter names consistent")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d264c143b592..9a6e2d556d35 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -4048,9 +4048,9 @@ bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_con
 
 void evsel__uniquify_counter(struct evsel *counter)
 {
-	const char *name, *pmu_name;
-	char *new_name, *config;
-	int ret;
+	const char *name, *pmu_name, *config;
+	char *new_name;
+	int len, ret;
 
 	/* No uniquification necessary. */
 	if (!counter->needs_uniquify)
@@ -4064,15 +4064,23 @@ void evsel__uniquify_counter(struct evsel *counter)
 	counter->uniquified_name = true;
 
 	name = evsel__name(counter);
+	config = strchr(name, '/');
 	pmu_name = counter->pmu->name;
-	/* Already prefixed by the PMU name. */
-	if (!strncmp(name, pmu_name, strlen(pmu_name)))
-		return;
 
-	config = strchr(name, '/');
-	if (config) {
-		int len = config - name;
+	/* Already prefixed by the PMU name? */
+	len = pmu_name_len_no_suffix(pmu_name);
+
+	if (!strncmp(name, pmu_name, len)) {
+		/*
+		 * If the PMU name is there, then there is no sense in not
+		 * having a slash. Do this for robustness.
+		 */
+		if (config == NULL)
+			config = name - 1;
 
+		ret = asprintf(&new_name, "%s/%s", pmu_name, config + 1);
+	} else if (config) {
+		len = config - name;
 		if (config[1] == '/') {
 			/* case: event// */
 			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 2);
@@ -4084,7 +4092,7 @@ void evsel__uniquify_counter(struct evsel *counter)
 		config = strchr(name, ':');
 		if (config) {
 			/* case: event:.. */
-			int len = config - name;
+			len = config - name;
 
 			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 1);
 		} else {
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


