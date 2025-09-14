Return-Path: <linux-kernel+bounces-815779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39642B56B10
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167BF17A91B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE222E1EF5;
	Sun, 14 Sep 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXX0pWHD"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EB32DEA67
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873504; cv=none; b=QnjNzheQO4v+TAQn4/Auw2AmBrW19K4JQrm7aM3NyBgm7QVo61VPv2W0rbmdQvrLvNIIsXRbik8zux7xC5Dg4oRHAJ4WNy4DibGEzKSPTPBPH3MnsmF8FwWl0sy1nYXSEGgeDDFyvCFWIU28o9VJaKsH/tYh395AIlR9OWaM4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873504; c=relaxed/simple;
	bh=/sGoxOpcqHieAabWs8RTqxWD9NIBXBKT+WIphoDadic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FLtIksoeQExWWIvYRRMggMolchPSmVGcJwS4sLw+lZoQIs51NS/1U3BXZhh1JA1HL8kck4Lr4xJHXL5NxgE4xSYkJQ+6G7rHfrEE9/SxqOvuGjUbMruuwFBRaFppxzT/+sYFm1TCn3+Ai2du9YP73DEctqan+uMYmwbnZAWNibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXX0pWHD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-263d67851edso17191635ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873502; x=1758478302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2x7UN9xYjTxwuiXaCS6BwXwGf6viS5ovD7MumSmPSqU=;
        b=PXX0pWHDl6B/+YaC3FSsGz3Mgs5KNt0g5YkgjdrgmMYLw4WZfocg/bBvGWBn2oJwqU
         n1rs+egNbPsp+sPoeo7nKDoFSI6idB6rbiJbrGv+2o0rmLj3sTTaxoFzJpJ28NGzEoOh
         cXPnWyhw4d7eB9n3XyOdwfORvzHEyGV1NMCtXkvCyUZEzBH+ngSW62SIB+lNXprnQuK7
         cPSZ4pjw3zRnKBsu4BmfkGdPX51Ph37f0oJ6UAgxGNS9zDGeP6a4kCR2givHGER3qhHL
         20kBWLQkDN5BWFYtHafVUBB5IKvi4rrHwrKguJbpbTvT1lmQ22AIwwibmgf8PTV0eXSh
         eeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873502; x=1758478302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2x7UN9xYjTxwuiXaCS6BwXwGf6viS5ovD7MumSmPSqU=;
        b=b3PgHUJWFh8fFI2r1YshnKv9+lNj9tn5qvV60wzafm4lmeKjbC9Ow1DyLF6iJR2s+j
         SyHF/zDESS81BWF5YMta02V++WdrKlb3ti7fBPQytVru9AkEUWIQBARTTN086aYHnNSp
         +XPvE4zsei18Ky2UGRzpUC+zJLepES8/lpJEcOsP8KlHZVodPWLsbXpbFdLwH84KLDfu
         xhKW60meggh5/opQKyrHHKM15Nz90aAAz96yUFi2lR7x+WOy32/A7DD4lWBI5PRHaEhK
         tskbvxha4HAGEllG1paVEazoYfZkMlt/izpn9rjDk8fi17vMDwE1nZzkogPjAtqvsFsC
         uUeg==
X-Forwarded-Encrypted: i=1; AJvYcCU6a+kYxL3u6cz9Be8GiyKbF23EoxZZ6JGiN8pY4Y3RXzxgNm5Im/hY+E4/quv35JauCGR8Wbs1KyMiU1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1praAXDM0sBSKfq45O4dMyWgLqlqn3kZzSRnfNqegPX5tD2F
	enWJ3YvXjD/jcj/3j+Il8Ui+Q1DtgXjCEBSHXjDZEqPQ9ZDThRl/vWY+gBqAw9IveHRQsWqngqr
	/lR7OcBoZ1w==
X-Google-Smtp-Source: AGHT+IGNmCa3OE/bNeEFCHWoQYVJlaarMANPWbYZySaIttgIKAho/oGbWPRsja1jumx3TcAcuLhNDi20QmO+
X-Received: from plbkx6.prod.google.com ([2002:a17:902:f946:b0:263:7af2:fcc9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22ce:b0:264:4e4a:904a
 with SMTP id d9443c01a7336-2644e4a929cmr31326135ad.53.1757873502281; Sun, 14
 Sep 2025 11:11:42 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:08 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-9-irogers@google.com>
Subject: [PATCH v4 08/21] perf pmu: Factor term parsing into a perf_event_attr
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

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
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
2.51.0.384.g4c02a37b29-goog


