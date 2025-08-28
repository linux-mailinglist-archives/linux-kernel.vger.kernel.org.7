Return-Path: <linux-kernel+bounces-790726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288B6B3AC4E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13120206E84
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6502434320C;
	Thu, 28 Aug 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Am798Kkg"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA0341AAD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414810; cv=none; b=TV38FNcMEX6dbd/nUotEq3jiIgqyH6UFO7TXRk/UHaSS0BOpiQoxyITz9JWGwUU8gpaTeodj49OFN0ne01Nc1v1j/y5JdbnhmPQC04DKQzuoM5ZwoXbBOZIWQ1NSTk8Eoul+taFQvc6tBFvix6t5NJD4iB5GbIdZIgor9SET5c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414810; c=relaxed/simple;
	bh=1YfEmHI4Uy2vFFO0+JK7swMQARnybRABQBKgXst1srQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YpVR4RdK+eXR5EHsBPTFEEIOIRM4wtYYHrXvB+FBwmnUFS/d0+QkfkCYpVJEP/qXLGI5zTc5wl0GRCyKUhcFRBYeExopHtsQSA/HwRvBfiZ1pn5zJoR0rN+oAkC3vrATYO6ohi5EMd6vpPYLzbsvnOupSoNJP/DzsjuGWcjcv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Am798Kkg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32769224506so1363477a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414808; x=1757019608; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBs0PRHAkWTSJvYcU2kUxuzj8mrp6f+56Zk47OKuWSk=;
        b=Am798KkggTztQ0gcShBiDJE46Ii0QEjzPFHpWW2SvGOzfWgjSXhU7KZ7ZQPYnA3I1s
         heOZzwZAg/A3JAbhkBs/ScCk0sLD3uC5/36nxB7+ANy+TV85wYSNouvSNSNLLRE4kd//
         hh4fcBaUmFzT/MkxVDMnMElTm3Gd3o+wG82rEnFSHDyGfE3qilnKc46MbzyhcDDLmxtf
         D+wmP7Kl9+lRydmluuntoAULPiaUYUHUDUpItU8F0MWC39n6UT+xreYKdJeLJ+ePJ3t0
         klC6jq1YGRFqOZTX4H84zh7WFsLvgqFdzZ5jKm1Uy4CjEBBh4f5DBWYLTEIEy/qtrrtk
         VzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414808; x=1757019608;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBs0PRHAkWTSJvYcU2kUxuzj8mrp6f+56Zk47OKuWSk=;
        b=pNdYU+ExjIwSiw3oq22P8ijhRhkLoKIRmSaL/cPj5L3ezyXMk2pghKEXslZCPaFeTF
         F1lKSGALpgR7FnzUUhdCRtKQQPwyeJ2mQVPWnIOtkbUrwsaU9FszRpx22bF9iTlN/4vc
         EmKABUJjMaEPUcUuTorDtqIT4/YCptCYQz+Nxnd9ZItffJ9mlgiNB526fHtmXq9pumvS
         wyZ+Sl7vz8sfL2PHlDhxqGNm4z89zLW3RuIujAKtrPIfsqOto9dd9uTV1uJEcrPLRynm
         t0q1+8s1djJYFkAirGvRQwCdO/ccegicgtWdl0ie+IWV4o13LXSNiTCOKP5Fv2gZ5M4e
         d+vA==
X-Forwarded-Encrypted: i=1; AJvYcCW0BkiIIC6W+lztngMa+tkjS+oytbV5tPQP3zDxGLv43I6zALObX5VZMrpniQLfdQKl2gyJwMP1+Bgmudw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5i4PjdirxmRwLFwVlHbCtB0SUn+u+5CrPcqB+vG9hEALsyVE7
	/lq3GIM2qv+QADbt32d/+/TLhIcegAv5b2QsAkHFh9UH/47jyVfDIYv9c28WMoyvjNgwGfCIEqN
	y7o1lkfqpuQ==
X-Google-Smtp-Source: AGHT+IGuPwLkOkQo0DJt7x8cNegFJuftnP1xNEIw9iOMCKI99ZduyIjWNQ+zrz0cmtgY1a9ytGVF8xuJp87t
X-Received: from pjx8.prod.google.com ([2002:a17:90b:5688:b0:327:5037:f8c2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7cb:b0:327:a665:da89
 with SMTP id 98e67ed59e1d1-327a665dc18mr5865595a91.18.1756414808028; Thu, 28
 Aug 2025 14:00:08 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:23 -0700
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828205930.4007284-9-irogers@google.com>
Subject: [PATCH v3 08/15] perf pmu: Factor term parsing into a perf_event_attr
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
Content-Type: text/plain; charset="UTF-8"

Factor existing functionality in perf_pmu__name_from_config into a
helper that will be used in later patches.

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
2.51.0.318.gd7df087d1a-goog


