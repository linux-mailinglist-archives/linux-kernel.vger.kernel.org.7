Return-Path: <linux-kernel+bounces-790389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4673B3A672
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D83188CC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96073376B0;
	Thu, 28 Aug 2025 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6Cv36DM"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653EA334733
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398779; cv=none; b=qz5iSekV+s0id83+bV0Ld8941VXilCrICw/wZiLEvRWXCkIeHvZYRDzDQ6y8VhanFGaqgXC13lhpAo0jWEutdjJnlM/weYxU9uBJFml9AyQVr7zIKQ2Ygxb11VFJBvWG4+ELzedn1q5S8EN1o469RIMy6sAO1gkcJkQljlR2ez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398779; c=relaxed/simple;
	bh=+fCw9E0zStC9lJI/2pWnt73NRryaNZPcIQmzoUTfvjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Y28ao6oCd6yFll7HNIkmAJTR4z4+9hxh7MLLQLsqQuoiINQOQI2u0DJOl3WmlTrbDEjsv9BJUY/y7U8tK3q1duw8LN/zTYs3bUcCcBmY/bkW5jqRc4CkuTFI1omCFW0sXTzvbt41GCVCIM73snBUcfWyqYmoWQfsgp2Ue8uVUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6Cv36DM; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so1173922b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756398777; x=1757003577; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kqRfHxs/ATgD/29kOhNAqjiBmhk8/trbtDTSb3oG9uk=;
        b=k6Cv36DMfvqDKwDCBr2wqNH3GwwCrRXkSKpeqBJ5iHJ1VOQcHx6yU1xS499ZhIICb1
         HZrrBmxTbCLG/EgpYcQ8bGSMhukLbIG/Pjfr6DZIc0IcoaAZHRXGTGIOGfqNZ8ZFqjeW
         h+xzaJ5A24AxOTXldv9rACGkUqGP08pw+rVWwXmf1BRjBC7SE/p/PDXHlb4jHIHQFJQr
         x0zudm+tIOc4+b3JbFMvYu4CjTKMTNXyCAV1JAcUKb8evf0zfBseshcBgjDomya0rdmJ
         rUDBfN54C69GFdlUABZnSbaAY9SrCsqZSOVYyM5/IYx+tsAHbwFvDPTb/PY4Pxm9SJqQ
         9LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398777; x=1757003577;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqRfHxs/ATgD/29kOhNAqjiBmhk8/trbtDTSb3oG9uk=;
        b=hh4HmRZuoGoRA5ckzY45e6VTGy+7IBzkuvdz7IaEYPC5ZAUpOpM6aNhfQrnlTiYa+H
         yvAP+af0gsrJ1UzM5/Q/Tk3ELII9k7m3O5A+E+I6PMbY5hAJgGoAED9+ujK1Kf42PnAB
         iPtvgjEhVU7d6L8ff6TuRA+mvN1KWCM0dW6h2XBDhtWzppcZjlASHVXPCr5Am/rX+6+0
         Oee4YYuVsy8tSFeopsqzi9/FBiP4/Skr1+Hce2WMm8jot+dFRK6+iLFDCMuebPPlVp44
         HaVshIRLA+CpUKGMaU0xR/LicXhKLIRWRmSQCTPhL6uloyaaZ24Wx4jTwCzqDc2bNmsJ
         HcXw==
X-Forwarded-Encrypted: i=1; AJvYcCUXBhs3OMXVG0SNX5Xp/Z1ukLXVYwNcRJf0IE0ifpc9b2XF1yH0eSDftZuED3aPnQdcqnign/ar6+4EEzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0/ypOyvg7Rd0/9oflHjxk/JyA+JTNZArX6szyJoZxn5SaKpL
	9Eeqr9OKKruWO4UtQaRhAF0peGP6DdV46dUxjfm3Ijbs2O5i3QZT8QcUbCYXFGxf8auj6E0yqjI
	ViZREZsuC3A==
X-Google-Smtp-Source: AGHT+IFqAqtXwytBjJ9HAFggv6uFpz8G5fB1n+L066mtNrZmRCERndU1VZkqbV5duONMFP5tkKf3OORrxho8
X-Received: from pfoo28.prod.google.com ([2002:a05:6a00:1a1c:b0:76e:9a1b:e821])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1398:b0:770:534f:afa5
 with SMTP id d2e1a72fcca58-770534fb2e4mr21051261b3a.19.1756398776616; Thu, 28
 Aug 2025 09:32:56 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:32:18 -0700
In-Reply-To: <20250828163225.3839073-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828163225.3839073-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828163225.3839073-9-irogers@google.com>
Subject: [PATCH v2 08/15] perf pmu: Factor term parsing into a perf_event_attr
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
2.51.0.268.g9569e192d0-goog


