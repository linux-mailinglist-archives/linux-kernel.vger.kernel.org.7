Return-Path: <linux-kernel+bounces-789332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B00CB393FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9226F460EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398E28EA72;
	Thu, 28 Aug 2025 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/ybYm5a"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6628750C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363370; cv=none; b=K1YJipvdpoUbkcO/vqAZcUfxQ5kIyUwuqVc+bpt62Ar2IRq6FFM076o41SBWwWnt8a6PbFXfVItJ/rp8JFpkDmsV31k1iHMxmJsNnUln8UY+CC0WRvZ2cofrdl5SXKZL26ZOHW6pu01hdC6D5MBMEjwvNLtXVpO2P1lc0pXhG3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363370; c=relaxed/simple;
	bh=5koWobhFKzB/i1OAVyIFe0t++WfN/R7tTbQmx48qFnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EbOPshKVTEjhfQkYznqzg7CpAfoLEFQAUw/pXI4CvRwUge6RgwbQQmQgHypjO0QAhwPJgdDpccF2aW750CQmthDBlCuzPUWsnJQzqg84jVa4aiQ8+7XC8GrVvaTH6pEAaAa8et1dOqtCy0cUx/cFUfrKtcOtWB2lgbPn/WWGdqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/ybYm5a; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e4c3af5fso720784a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363368; x=1756968168; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSMhtCRMX1JJ8a2M6HYUBkzFAQBtsVFer7zAsyKI4O4=;
        b=b/ybYm5aM71jXGL8iGZxxyOW46CEtTBzcTVWCvOSiz88EHQUvZKbkttTnIWoLVxvMI
         0uED7fYObzIdpzrllCaKO2qNILxz7Pd/lWq9FD10NDlAUPol5+ie1/NOmatqcX4Ip+nA
         I/4wftJy9IbsceYuI3D7Wxm+VgR/F+fIx9+hnbR97H0imAcIe9eyJTHsPIQLjJIq7ieJ
         l1WieAerk2rHbvKQHWKbrEGOsv2ZeLdsNAwFW3oHVbrq+wAz/kzCi7uA64wqbuOgEEsb
         hC/L8/e85KWKTEaUxAZJPMIaHdoeNzjhHQUqNmaJoNBQD7SWUjSievZD7LB6FsH18/4U
         sLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363368; x=1756968168;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSMhtCRMX1JJ8a2M6HYUBkzFAQBtsVFer7zAsyKI4O4=;
        b=srCDrI2xh37Erb4AtRl6+UGoo+tVn8aZdPjMGc2zYri0q8qo5eFHwefafeqCNeoaIV
         a+wmhyfG+Bzwl07XJq1ChTZq/Lgiw+V4bKWbQlDrqyZk+3bRw4SEWPu/k7XQLtp1wree
         aPFRxQjseDQ8jONqR537dhRB9EjEtQ3nJh/atyFMva895XgzyDFsUgoZ8PRl+VOy1wz4
         z2FTpDNg70S88m6YcrDVUlFDH+Eq0B8Js+YTy+6ZyraRyLSMQ0Y0uZLmbi/P+rP8czJT
         OyPrON+PFzxl8XPTui4nhGfOJMl82qzqjXXwgjGbUutIYyP7Hijn6/kh2UGJHIt2s7Xx
         Bhgg==
X-Forwarded-Encrypted: i=1; AJvYcCV5y8cc1l1KrkpgK1EE8k/n7comsAO5ADNJcfWIrqj93cyFTU1oCJjNr0bHLuaUZMjG+p8KzaKAeuDng1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdVXRTmY4bLT6gfhB3EiLj2XAV6TljhH2Ccb1c6Zf7OwE3fjt
	EeClwXcCoPYdtHe24C1heEmpf8kM0NhKfSww7fMuAfCtVROmIohYAEl3/Sitn1Rumws85/2GYBO
	QaP1nRi4Mlg==
X-Google-Smtp-Source: AGHT+IH8HcjjRK1HgbbucgHYh74YcyS5gY/Fw9YglOPLN7eSqnlPft8E6lWMp2zvZmV4LCuilyL+qsWiUvLz
X-Received: from pjbsv14.prod.google.com ([2002:a17:90b:538e:b0:321:c23e:5e41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b4e:b0:327:734a:ae8f
 with SMTP id 98e67ed59e1d1-327734ab092mr6455393a91.12.1756363367923; Wed, 27
 Aug 2025 23:42:47 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:24 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-7-irogers@google.com>
Subject: [PATCH v1 06/13] perf pmu: Factor term parsing into a perf_event_attr
 into a helper
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
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Factor existing functionality in perf_pmu__name_from_config into a
helper that will be used in later patches.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ddcd4918832d..e590de26a7f5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1766,6 +1766,24 @@ static int check_info_data(struct perf_pmu *pmu,
 	return 0;
 }
 
+static int perf_pmu__parse_terms_to_attr(struct perf_pmu *pmu, const char *terms_str,
+					 struct perf_event_attr *attr)
+{
+	struct parse_events_terms terms;
+	int ret;
+
+	parse_events_terms__init(&terms);
+	ret = parse_events_terms(&terms, terms_str, /*input=*/NULL);
+	if (ret) {
+		pr_debug("Failed to parse terms '%s': %d\n", terms_str, ret);
+		parse_events_terms__exit(&terms);
+		return ret;
+	}
+	ret = perf_pmu__config(pmu, attr, &terms, /*apply_hardcoded=*/true, /*err=*/NULL);
+	parse_events_terms__exit(&terms);
+	return ret;
+}
+
 /*
  * Find alias in the terms list and replace it with the terms
  * defined for the alias
@@ -2598,21 +2616,8 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		struct perf_event_attr attr = {.config = 0,};
-		struct parse_events_terms terms;
-		int ret;
+		int ret = perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr);
 
-		parse_events_terms__init(&terms);
-		ret = parse_events_terms(&terms, event->terms, /*input=*/NULL);
-		if (ret) {
-			pr_debug("Failed to parse '%s' terms '%s': %d\n",
-				event->name, event->terms, ret);
-			parse_events_terms__exit(&terms);
-			continue;
-		}
-		ret = perf_pmu__config(pmu, &attr, &terms, /*apply_hardcoded=*/true,
-				       /*err=*/NULL);
-
-		parse_events_terms__exit(&terms);
 		if (ret == 0 && config == attr.config)
 			return event->name;
 	}
-- 
2.51.0.268.g9569e192d0-goog


