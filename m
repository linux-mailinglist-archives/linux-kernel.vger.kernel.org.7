Return-Path: <linux-kernel+bounces-815788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84028B56B21
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A849116BDDD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5A02E612E;
	Sun, 14 Sep 2025 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPEd1TF/"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F4F2E718E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873523; cv=none; b=Yd6dbOx4ajIlQzowZkbtQOKcv1GvWtLcSKhIQCLLUuWSGBhCJzICmiY/d5OMu7palmvPXVdMb0myNMMdGxTHt41y4ftEncQLgGs4x+MfhRoQ9L0yijlQfEHVjgu8BYAHVe0V7GPPJdpB9p+iydPbTotfOT9X/npCfXdjTe5u0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873523; c=relaxed/simple;
	bh=h4sXefZhOxCEKIvBSymmqcVW8M/ts7r+91O3C+eEVL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NTn3Rjd6WNxEYHWlcgtAt1uV7OLv1atzl6GAkApmP/tjp+4/cybrLaPOwy/J9LBGf5Zul+MU+HNss62NKgpeV+pX4k9gFQ434ZUVw+yKQ78fWheOwgRU9BJKvpNlmZI4RssV5LbG0KQdOlHMlRV5YIomJA7roFCqME8zcH2Rkag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EPEd1TF/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24ca417fb41so33737875ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873521; x=1758478321; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RjylI1Ng5NnBN9pwU555o9z4A/tVaFnze9kkfZFImEo=;
        b=EPEd1TF/g+sUy8vUx5BrC3+BRQNE5M2b8/f4tYYAQXrzJPfVs1jpnEDjBfkiuEI4ab
         t02kCy2Igs4rm1q7+s/hEBNvqNQZ/hKk3CESncvBjcMccjtU0a7+bZ1EQKLUhNAfzcoH
         tbSiRy2vwoe4g9KU5gIUKAVFiXlpLzWujm7VPEMFkg8ssirvlSPMQGWeTH26I++yfFji
         1Qs8+wtYCdw53/8Nzr1aZQ3ATcB6LhVT4+e1UtYjNkHyTj4Hjy7JW7Uq91f+elEwSiO4
         9mI/WnNF6ya27hs7Sp1bQcSZthAdcznwlzUROj5IWD1ZW1avU2unTlaJqbFd8Jw5Ffg2
         0/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873521; x=1758478321;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjylI1Ng5NnBN9pwU555o9z4A/tVaFnze9kkfZFImEo=;
        b=vrAZgxcFrIP86sUVG+Q6KHqM9IFZMWs/96s9rYVou3obDJ7flj45Ptx7C4dle/4SdA
         5B411zGJzjSza8lXdwKOAvEp7zkersUgNf7hzLkAPaJwi+oXDyd2OnexjYbISo8vdb0n
         ERP5TnNyMPHgPxMclJO38yn7WCZN3jAzbyLHc7REb+7vN7CnsDmH3Bz6smNi1RSNScIo
         X/jQYK7Eqvizd2VB51AuKbpfbMS28+n49DlMT4LKWIaR+/F90tajmbkkATcz1pllQNqP
         FVIyx6F53yLBdPp0BOW19AVbZepCAcNA8SaeYmd4X7Y17E/K9pJ+JYR5c7h9SNtcZPfH
         JUgw==
X-Forwarded-Encrypted: i=1; AJvYcCU+giACo4dmb8VWHZN9RRJmgxlXqZFqyAmWu474Uaj+bJRedOP/thV2m4gpFtpbBZfyBjrV2K7QWcFqACE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA884cFQf702I9eKUTGcBuXY0bwWmzWF/5SAYl61/TiHbmWJ8f
	qIdpStp0mPubd8EO2orU6tj6W2Fz8IPRZ3fbK8SP8jppFCuR+V9DgeDueK45JDc1o+PjNUDM4Qy
	a2xya6XxJYA==
X-Google-Smtp-Source: AGHT+IGnn2xJFltc6k0PjS03jSoP/OrGc3R18b/p/EPkWiXKByR1WFESRAYFW+wv288N7SKObI6ml3yvLFPW
X-Received: from plaq13.prod.google.com ([2002:a17:903:204d:b0:25c:8c4a:ec84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c6:b0:25c:4902:7c0
 with SMTP id d9443c01a7336-25d23d1bb3bmr127571745ad.3.1757873520615; Sun, 14
 Sep 2025 11:12:00 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:18 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-19-irogers@google.com>
Subject: [PATCH v4 18/21] perf evlist: Avoid scanning all PMUs for evlist__new_default
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
2.51.0.384.g4c02a37b29-goog


