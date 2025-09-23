Return-Path: <linux-kernel+bounces-828208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2F2B942D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E425B18A46D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA53E274FFC;
	Tue, 23 Sep 2025 04:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2oDf8trK"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C74F26C386
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601132; cv=none; b=G+XDggTticbuTYY0+i/di5FyPe8i/cvc+1Np0WEIknW9k6EWRr3CMT6n21lFPrhksSzw0wb0HjlYSfihwuLRuohcE7TP+J4Cal/U/PlZifvDdfW3htCvfhOewJ9kkaHm0OUXAWjMPiIqZfbk4acWxnyN49JRCYN5mSQAZP3Ed0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601132; c=relaxed/simple;
	bh=kZUHpU6S8UVYRUQDdu4Y2Rk+Jy5km31ZCsLgDDgmx3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CeItpbMCga/9RatBv6WVEgmNsQIFjEDE2KNrXZpNNBqnf/HQSbzXo9S+IR/heHhrl+saFl9vJK6fqvcHuiJYHn4NauFMQWII3qB6nomwGck8yM7o998nUV8htw185/D4p8H/zYkg5Sp0XSQ8ePN3SOUQvjc+9nzTKtSnZfHlp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2oDf8trK; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b522037281bso3942990a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601130; x=1759205930; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAneJQAQnPj35Q6fil29jmDxaONd3Bnz5JZuwitT6KQ=;
        b=2oDf8trK5Mpjy18SHbfWQQfK6Kog4/izu9Kjj4hQcpLLKJVwi/myF7kAe07RapFNw1
         +xWGRDWDhZp/+/Kd03Y8yLHPs7U2Ih521WeY7jbEUBmCdgFUZpJZYL7YBjCYhxrftZlF
         hAHYyOjvKrlCahTc8pRCek7A0x9zNM+rFOw4FVWo+o5YBTC2NgmSwgpcDcxVnptCykXj
         TzV6k2oermnv+Pt+sZNB4MH+/tVix9us0ccYxdBXvKG9spHYa6INOXj2NzTtoHmPOgD9
         ODq5sKhcZ8a6z1I7Gms2ZYbm2phEdFRAt+muX/KIf3e/m46IMIuBDSGVuilSRilqgZVS
         dZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601130; x=1759205930;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAneJQAQnPj35Q6fil29jmDxaONd3Bnz5JZuwitT6KQ=;
        b=EHlrUi+zrkXOFDeeT2aMOq0N3jZiyQIvzWg+nKg6fAEOKpUB7NQAbzxPjpiRJZCKym
         ZadTVldQWBkzoJ8luP4zt2OF2W6weW6Jc76kXu7odryDagNiFoEV48GFqBNmh3tnNpFJ
         /fIo0X4bNvDMn0yqViq6KhfRLfnCoVztmui67+MSDtN7b2iDAbYcg0j5BmZgFZbsKEzQ
         oZr6qRk38MIC9FaEPeSNJ8ewJUXJtKgiNIsfnde6lhTsWH+OJE9LUPqGrS3pmDf9x98d
         MEDTpRl3T7I7uMr9nxmbdN2VqllLNU67ApzrplBU3BIa2KYR4oGXmeGUOgJTDetbAT8D
         bLuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnauyvFzBqaZrAWFUzAfuYOwBmOu7UpT+nqOzeZ039l0cLuDpAXvp+qA1XW5wNJCm9fiG3PDjCPH0K/dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDcLl4sT+m79y8R651QH0n9GA+VArHa4FXi3axHR8eGTH1WeC
	Nn8UP3ENONPzsVcf0JYDf51J7KsgVB0x2BGqeQQLzC8KneHxfjholXhayvsHgXTxV4EHz29qYL2
	0z+IlpmOJeQ==
X-Google-Smtp-Source: AGHT+IF6cYJDVK0H1bznB4eKbhN5Iu7fH1Fhc2pqoTFchudp7dMnQGWMpjFfFdl4jZSERPz88R1Nl3DJuiwZ
X-Received: from pgbds10.prod.google.com ([2002:a05:6a02:430a:b0:b4e:3302:ce42])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9990:b0:246:354:e0ff
 with SMTP id adf61e73a8af0-2cfd603fad0mr1701034637.8.1758601130012; Mon, 22
 Sep 2025 21:18:50 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:20 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-2-irogers@google.com>
Subject: [PATCH v5 01/25] perf stat: Allow retry for default events
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

Default events are marked skippable. Checking skippable first means
retrying and adding modifiers like exclude kernel isn't
performed. Push the skippable checking after fallbacks are tried and
avoid warning multiple times for the event.

Fixes: 9eac5612da1c ("perf stat: Don't skip failing group events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ab567919b89a..303628189004 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -616,16 +616,7 @@ enum counter_recovery {
 static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 {
 	char msg[BUFSIZ];
-
-	if (counter->skippable) {
-		if (verbose > 0) {
-			ui__warning("skipping event %s that kernel failed to open .\n",
-				    evsel__name(counter));
-		}
-		counter->supported = false;
-		counter->errored = true;
-		return COUNTER_SKIP;
-	}
+	bool warned = false;
 
 	/*
 	 * PPC returns ENXIO for HW counters until 2.6.37
@@ -635,6 +626,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 		if (verbose > 0) {
 			ui__warning("%s event is not supported by the kernel.\n",
 				    evsel__name(counter));
+			warned = true;
 		}
 		counter->supported = false;
 		/*
@@ -642,13 +634,15 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 		 * cpu event had a problem and needs to be reexamined.
 		 */
 		counter->errored = true;
-	} else if (evsel__fallback(counter, &target, err, msg, sizeof(msg))) {
+		goto skip_or_fatal;
+	}
+	if (evsel__fallback(counter, &target, err, msg, sizeof(msg))) {
 		if (verbose > 0)
 			ui__warning("%s\n", msg);
 		return COUNTER_RETRY;
-	} else if (target__has_per_thread(&target) && err != EOPNOTSUPP &&
-		   evsel_list->core.threads &&
-		   evsel_list->core.threads->err_thread != -1) {
+	}
+	if (target__has_per_thread(&target) && err != EOPNOTSUPP &&
+	    evsel_list->core.threads && evsel_list->core.threads->err_thread != -1) {
 		/*
 		 * For global --per-thread case, skip current
 		 * error thread.
@@ -658,15 +652,29 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 			evsel_list->core.threads->err_thread = -1;
 			return COUNTER_RETRY;
 		}
-	} else if (err == EOPNOTSUPP) {
+		goto skip_or_fatal;
+	}
+	if (err == EOPNOTSUPP) {
 		if (verbose > 0) {
 			ui__warning("%s event is not supported by the kernel.\n",
 				    evsel__name(counter));
+			warned = true;
 		}
 		counter->supported = false;
 		counter->errored = true;
 	}
 
+skip_or_fatal:
+	if (counter->skippable) {
+		if (verbose > 0 && !warned) {
+			ui__warning("skipping event %s that kernel failed to open .\n",
+				    evsel__name(counter));
+		}
+		counter->supported = false;
+		counter->errored = true;
+		return COUNTER_SKIP;
+	}
+
 	evsel__open_strerror(counter, &target, err, msg, sizeof(msg));
 	ui__error("%s\n", msg);
 
-- 
2.51.0.534.gc79095c0ca-goog


