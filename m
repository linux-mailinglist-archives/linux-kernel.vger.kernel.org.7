Return-Path: <linux-kernel+bounces-828226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE16AB94350
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D95A16E2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD982D23BF;
	Tue, 23 Sep 2025 04:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhsfhb/K"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D662D062E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601175; cv=none; b=FuUFmajik7l0uNJsD42egDzSIoKJyYxjgBZriwxv9eYpSRYvU457gXUt6nV3IyX0/YPHqbxOZxNTV9TrIO3PHSTWE+TC4brxFcuyUnHliYYMPFOWdFbB7gU7Evxnp8EuAQO3n9iE32ztuTELvXxS9rI73gpX2R920fr/tGaUTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601175; c=relaxed/simple;
	bh=lv+orrYEZfCCmS3CajyfSe+YtFwMzynEb1XCScLZ0M4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nInUWnsNyx3MN0mRijDWuQ8zKwZjxtCJdRRSM8txdxm/Dk0/+h5/9A16Ym1nqr/gTpKNJWLt4AmnzWuAJs5LOT4VBli8CLKMof3Q9BcTlsRPWzvVc9UiR76LSv4zsYMHVsAObYXrZQUoOBEvTEbbexxFQGtEL5fX9Dgb73LcjVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uhsfhb/K; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-31d8898b6f3so7502468fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601172; x=1759205972; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IRX7WpoC8G1Z7bNmqvaEWKqeWN2XUOf87Rof+WADfg=;
        b=uhsfhb/KJWq6LHP4NRDXNrxzTJhqAS8Xzf9nFiqMGQgTUIgjTzDDvQczxXtXhzkfk2
         IiLAPRPyj6dOUcEF1iXd7lgjxsOnNyZglwoqsWJPFAqQvD0sH9E15bKmy4nULdzq3h6n
         gmWQuirIe1NutkY+KXF14fwa1Tm1gSYFAr0kNCcuf0zg8xICi0Bs+Zn/sXespjVsITZv
         dRbhydwbnVas2RPgafswjKN7sHI1EeSfTjAfx50tK+NMrEz/0lccFIqT6emx6812yoNb
         svSyY6gRiIXWnJjcgt3RmerA6iSGBLIyZJpDZYjy7MyRJEwbzPulhXFBa4KYU1I3X/Ur
         A9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601172; x=1759205972;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IRX7WpoC8G1Z7bNmqvaEWKqeWN2XUOf87Rof+WADfg=;
        b=O+jDsShOdtAJJwSNxE2IwTCy1KWQv7DZ6lHz1BhA3jQRf4zFIBjfcwuK/33M21Xw+9
         nBAwprquWMciIU3PK1/caTQ86vCJM/b5xZGty0k2Vbl0WIUm7tzuPpHGSwH3fRO+hfxM
         mi1ocMYsOYe4Ud+cJbf23/4U+yLG8K1Xw7X0/PM94IL5wbHhEiFkesd0kyPZk0Q+QBOH
         m7qQCx6uk6y5C8dGX1uk5lITa8aCpcCbrrtlt+CcXsw0T/wolEBTnd96+radXsZlvD7w
         8G9cExrY/AUBXGthDKXRwFrPYYJJHdszgZKTvEbxa20grQjZN7l7vZ4YcBfCupKO7vWk
         NwNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0NM4LbCYtO7GeL0FOi3eGvx7szK8RPKKEvCnMAEBIRkLjHz5aLcjqMCz1HuTnP7TxOTSjGty1XcH/CLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTO84P1feRDb/eTvV502MKgQ3nR5X0tWy9DeMwAzazueBSDPTA
	YTfRgNNFIjgq/DVnlLzvUBM4cFq8rX1KoD3FRTkZqBlswB49DAyUiO/ISmcZnGGlptILceZ4LP0
	yLQ5MI73rzg==
X-Google-Smtp-Source: AGHT+IFm2t8vmJw3QRHR6MvOJLGoUifxl76lzDWUPBaX7/fgazIrjqZoHY3k6QqXJKKw+7NdIrd//E2gECNS
X-Received: from oacpd2.prod.google.com ([2002:a05:6871:7a82:b0:331:4705:d868])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:e191:b0:345:bfde:34d3
 with SMTP id 586e51a60fabf-34c85bd80famr575929fac.40.1758601171876; Mon, 22
 Sep 2025 21:19:31 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:39 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-21-irogers@google.com>
Subject: [PATCH v5 20/25] perf evsel: Improvements to __evsel__match
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

Ensure both the perf_event_attr and alternate_hw_config are checked in
the match. Don't mask the config if the perf_event_attr isn't a
HARDWARE or HW_CACHE event. Add common early exit cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6a31f9699b49..8c60f79a76ca 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1863,16 +1863,19 @@ bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
 	u32 e_type = evsel->core.attr.type;
 	u64 e_config = evsel->core.attr.config;
 
-	if (e_type != type) {
-		return type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
-			evsel->alternate_hw_config == config;
-	}
-
-	if ((type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) &&
-	    perf_pmus__supports_extended_type())
+	if (e_type == type && e_config == config)
+		return true;
+	if (type != PERF_TYPE_HARDWARE && type != PERF_TYPE_HW_CACHE)
+		return false;
+	if ((e_type == PERF_TYPE_HARDWARE || e_type == PERF_TYPE_HW_CACHE) &&
+		perf_pmus__supports_extended_type())
 		e_config &= PERF_HW_EVENT_MASK;
-
-	return e_config == config;
+	if (e_type == type && e_config == config)
+		return true;
+	if (type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
+	    evsel->alternate_hw_config == config)
+		return true;
+	return false;
 }
 
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
-- 
2.51.0.534.gc79095c0ca-goog


