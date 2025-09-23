Return-Path: <linux-kernel+bounces-828216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B7BB9430B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F6018A7BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C289D286400;
	Tue, 23 Sep 2025 04:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTpNqAQh"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCE284694
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601150; cv=none; b=dZLswsjuRLSpiZ0SCX1XY+XxRQZ8AFPQxcL0hav/Zt0lOTjMK9shdahyUHBqGPUropxNi+E9Xpvd+YhzvfC0aGYfS3yyy07caETb11BdCIEIfCpAUmmXnxBz8+PXyLSSkeUFV4mNF/e683T5bE24rcaz6XQg+xahWrvglH8Gmf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601150; c=relaxed/simple;
	bh=032C1jzLqg1fZhcoAFb+FaDYwGLmXHO7CCdHxbknGq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=piNmNR1mRSUzbZK+DSsN9H3Bw7/rlpbTeGsbyrR2GwQlzfSyw6P03B8PGSq9MMoYfJR+GR21yUQsBErzYw1kTTg57r40arefZMY50nTDXIzlzLCQk178beVRyTm+CUxvdfHGLcL1E5qfWAPJIhF7MLifQwgIhAuILluFHsh89yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTpNqAQh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b554a1a0ccaso1375222a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601148; x=1759205948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwMO8Ta7bp1LibQmtclIAbrG9qBpwQ1+Kt3cBbb/T8s=;
        b=oTpNqAQhRCKoICwyJ/yrxJEgQGTu1CJ49uTEpaJYJgTVbhfToCPcpkU3VT3OCkUx/R
         7Bv2tMLZ/MQL+AKLAKASDvwi1X+kkt48FXbeXrDincBs9g1oPZh/Srx+LxufXOrgtexz
         r/X2lEVXpFRLfhQ1ny5eI79PYNs7HDROIeBSGb9Y3M/lRzKbxbzpQ0/Q6fEJZMzu9Gp1
         1mlVeWnuoE8YgIvO84oeNl69hz69PFdVywEO15ibU9zb6mWXC4PbhhG3JWqQc7YNmAzD
         tVQgB9ir9fIyColiymFcw0wIpoB3HF2F8oX29Yk9XtCUJTRZJCXRKNh6p90mDFxEc7SN
         N6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601148; x=1759205948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwMO8Ta7bp1LibQmtclIAbrG9qBpwQ1+Kt3cBbb/T8s=;
        b=DnB8kXSTKllHz91bLeVlKPbZ04LyPabipMDMW8o6kwWbaEBCS3KvXEfstOeExfZeaZ
         59csToGaRBpruA09mT8cnrPejaQx/o+Lx+6/Kc7d32pwhQJZdjxG2rsuj0DWON1LkShl
         WSB2MSd30HlncgBSZVkBHOdyTk++tF4OFUOAQb19iBY/Fe1FVLBjs1ZqKZiHEK+nrxMA
         WhuluyyMdwuF9NlTpzBpYjDgwKDPq4MVDu6ftNOmP1lez7S2/+lqETaoL7dzgZoAXn4U
         lLQxhDgPcHvB8g8puoY1Sh+VejXtnUO0UuyJ/5Ekp83aGNJYE7JdZv+PeipL23FoRU78
         2h4w==
X-Forwarded-Encrypted: i=1; AJvYcCVa4kQIWAwAp2DoJ3YThx3QxUmGEla4J9Mch3WMvlurueKPADvQ7uxWUhRIW8bTTIQWaYPJ9t32jmfDuYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwehpQXloLk41lrBoAuBxWgIoI1CCzFT/RIs8j/eDI/V0kgGG0p
	UIDpPH1g4l1rK8eE6wJmoTIka9kdkk+F5mpNLaHzuL6aYZdCCWyIk7QHfnS6Vpo1CBgC7AWfgXT
	wi28zWTy9FQ==
X-Google-Smtp-Source: AGHT+IGe8GP61Ydjg84DDw7mr68WHwqJA6B1IuXFklbcyExUM+6bo8bx1rCAC4pfWRd2M5SEGLyum5HLuq1r
X-Received: from pgdp18.prod.google.com ([2002:a63:9512:0:b0:b55:1103:fe24])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca6:b0:248:4d59:93d4
 with SMTP id adf61e73a8af0-2cffc6461a9mr1772699637.45.1758601147799; Mon, 22
 Sep 2025 21:19:07 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:28 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-10-irogers@google.com>
Subject: [PATCH v5 09/25] perf pmu: Factor term parsing into a perf_event_attr
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
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Factor existing functionality in perf_pmu__name_from_config into a
helper that will be used in later patches.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 818be59db2c6..36b880bf6bbf 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1763,6 +1763,24 @@ static int check_info_data(struct perf_pmu *pmu,
 	return 0;
 }
 
+static int perf_pmu__parse_terms_to_attr(struct perf_pmu *pmu, const char *terms_str,
+					 struct perf_event_attr *attr)
+{
+	struct parse_events_terms terms;
+	int ret;
+
+	parse_events_terms__init(&terms);
+	ret = parse_events_terms(&terms, terms_str);
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
@@ -2595,21 +2613,8 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		struct perf_event_attr attr = {.config = 0,};
-		struct parse_events_terms terms;
-		int ret;
+		int ret = perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr);
 
-		parse_events_terms__init(&terms);
-		ret = parse_events_terms(&terms, event->terms);
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
2.51.0.534.gc79095c0ca-goog


