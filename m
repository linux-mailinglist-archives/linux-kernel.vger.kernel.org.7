Return-Path: <linux-kernel+bounces-828225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A1DB9434D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0C016788A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2127D2C327E;
	Tue, 23 Sep 2025 04:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKvZoDtc"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B712C158B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601173; cv=none; b=S2hIrwtjJdR2Aonh15dC8G8HIGMusXmzJTjw0jWDbtwZJm6oq7GU41HOJB7osNt2WZ6N9ADC5fi7L1Dob7GkCmeo8JiU/FS8BYG618kxVDGLoPeCXRvWmvR+gG4hLQpnzD4AcX1K4PIGpAgUOZKo316Djh8WEOuG4rO7a24fNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601173; c=relaxed/simple;
	bh=42iBM+j6OaHjeb87rjIgQvbVIu0m2YAxZp+bcUWwqIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TCPQ1MVtpa3sdYJSowNJLrfnFM99RIoPu8DooF3O6ua6DA3h9EQBbNNC23eglgVtVM1iE8tmp6itq4IutkyL//iAsyF4RBGgjwToS5Ijsrxoj+Mth4LX+YSTuHEY1uw9C/YHjR1ClEsDdx/03h1iekrT3DbCg9TfzJVb016O+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKvZoDtc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77f18d99ebaso2381292b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601170; x=1759205970; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RMlKXhObDH6+v/xxS2IL1R5qtxgnEu4dYtMPfrzR6FE=;
        b=hKvZoDtcdwBPAan5T2DrEj4d+X8aBKozt49vTB5XfjoYt2zvcuXegWnc9LuQ0t8JKn
         u1nDpUfC/1Jmc+gkhhxqzq8xZq2FOKWHTRDE5229D2Fb09puCIPtFER2xnZ1ajE07rxp
         lNvd10t8Lo+fFp8UbNsCFKaZJwGB9fQIu6hTxqOSaxlO19SMfUETs5p0IZV9KVMxP+wh
         2AraBYn1XWjrN+2z4v7pQGS0qLXa2a4UMrjzPOlYxLGb5KZnDtuCEOFoz7HpPJF4c3Fg
         oz9rxJgQ97W0ufq/Utfc7qKyA1Kk1fCgN6P9KqUdlWTadOijIF/os1w1iKMrw3Fz9VYf
         QNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601170; x=1759205970;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMlKXhObDH6+v/xxS2IL1R5qtxgnEu4dYtMPfrzR6FE=;
        b=mKW6x4dn1ckDRhUW+E4U67q8DcvQzkxJcXVARMN5bBUm4ekIzbaSJERqdzTgjh3EWE
         LGIAiGvG3wQX7si93Kgs6swEjcJ/ILI3IZle4/trdTq2wY9eAEE71QsVKTVTqEV+oPg4
         37muF1lbqU1wgxuCDnvOkTQzyfrs4FqoLTA01JwxlvQM/WK56M+KKUXQzbxN4dSVFjEu
         GPQOLBE4fEs5XgDF3XLc8IEzEznFgOxDkOnV8Si7klASaPRQGIgKNWS5rx0B2heHq8HI
         xe2t/ArliDvh7QOGQh9RWw+gKCRxAZPuJOpH26ZRyPVspWtPPRNly1iIUFXgc3wNO82v
         zJCg==
X-Forwarded-Encrypted: i=1; AJvYcCU87AfXAYcXC7BB/gPy5uyCEGsL02Vl2Rqptf/egOk3ifa6iZKZon0LSiQh+Lu6MKIrrBRq82K35cnGdvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFbYZPI/Iv1usic2Mn1ZvvHfHJvM2g9/ZVq7HZ8OtgwW460OqP
	OAdAl6TKb1243Uj4Wt6ScqWbUn/GUsf+9GtdLWniR/BYZLStYhZozxFConR/hdj1qjEw/9+9Q6x
	KTuW16As+ag==
X-Google-Smtp-Source: AGHT+IF0UoFkxTH6FU00wEtyjymwn+KsC7TsbR+8Lhcdy4noVLIgU/fBCTXNE1X42uS8iAeiRcTzZy4xoEKs
X-Received: from pjbsb16.prod.google.com ([2002:a17:90b:50d0:b0:323:25d2:22db])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748e:b0:2b7:e136:1f30
 with SMTP id adf61e73a8af0-2cff213742cmr1861087637.55.1758601169838; Mon, 22
 Sep 2025 21:19:29 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:38 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-20-irogers@google.com>
Subject: [PATCH v5 19/25] perf evlist: Avoid scanning all PMUs for evlist__new_default
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Rather than wildcard matching the cycles event specify only the core
PMUs. This avoids potentially loading unnecessary uncore PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 80d8387e6b97..e8217efdda53 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -101,16 +101,24 @@ struct evlist *evlist__new_default(void)
 {
 	struct evlist *evlist = evlist__new();
 	bool can_profile_kernel;
-	int err;
+	struct perf_pmu *pmu = NULL;
 
 	if (!evlist)
 		return NULL;
 
 	can_profile_kernel = perf_event_paranoid_check(1);
-	err = parse_event(evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
-	if (err) {
-		evlist__delete(evlist);
-		return NULL;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		char buf[256];
+		int err;
+
+		snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
+			 can_profile_kernel ? "P" : "Pu");
+		err = parse_event(evlist, buf);
+		if (err) {
+			evlist__delete(evlist);
+			return NULL;
+		}
 	}
 
 	if (evlist->core.nr_entries > 1) {
-- 
2.51.0.534.gc79095c0ca-goog


