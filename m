Return-Path: <linux-kernel+bounces-785562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E7B34DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6961A86668
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5B12FE56E;
	Mon, 25 Aug 2025 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1LGrzPFo"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F212EFD90
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156338; cv=none; b=VWrZsxvHI5V4harsoB9dzfTTG068bT9BjiAhSAH6yw92/dxLXS3AlinRWr2nCeKmfUvvymrXxEb9IH231/7FP9B9xLOVtrRvECEICNLrvBj8UXvMEgFXOuv/GYkt8UnrqMxtEVXiixhMjySDrqXbCIt5BsCNJ1aOX5GcgOqSg8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156338; c=relaxed/simple;
	bh=7ZZYccK7pbZzVlX/n45DfA25/ZKv6f9dOGLxGdXzzb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oSv2E7q30+tzE9/aYhSJYQmPgLImRUksmWgx/eVTJjTBlPmt2EzkgO9SCefk8uaGCBA49Mr/yHTQRdfLO7gd+GrOK+PMBilo7XA4lYRlFoloGRPNlDUtcj9PgO+EtEf6yDp7dC4kAk6II/pCXsR/K0pGUi7HXqiua9IUcxe9UcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1LGrzPFo; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e870627e34so1762792385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756156335; x=1756761135; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qk8oGFA/uyU0ZUdIq1ApfIlRlwBW+Y7K33XHhOSqdfY=;
        b=1LGrzPFo+mPLg467UhKzgAZWveVo7dIcXJXZSsxq1iiNAN3B6dbEpfhLAPkReo5wfZ
         GT5tV3CQRUEytngN2Ip5H6hxqM4zNxtrB0LHsXfIuSGBJHqoB5E0xCvs1ktOTNxJXWuq
         17cLYpex2uBk+CjhrApdoys/Q9PHCiL3+EZeKmVaAfgn1/rj8pNPVDUXwmOleorluMUg
         Dak27Wl1ZIt29pvphYYxHiuhVftZcQsFEQfjA4wQ0XyQQkhna18rus8OEvyjd69yi/g9
         /nPuC7nZHn8SCXRGCJ0di5eD96jwiB9+xG6tWMOgSFHuv9dIe5thyk6TmR3ttmxd0d2y
         37ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756156335; x=1756761135;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qk8oGFA/uyU0ZUdIq1ApfIlRlwBW+Y7K33XHhOSqdfY=;
        b=LJrU1CtEIv/fQ5CxKf+uxrVPhdGh6s0k3BzFHiybgGMHVbbWpa4sT21XwyaM43uvsZ
         UWxeXrH2koQwXjHjdgjvX57t/+QAZaHEMz4GJtk8z0MC4GffpmSUw1t9HL+EVD5le+b9
         FzVXR3xpZSa+t7l223k5oIPk4MJHc7XEtUxdPoXeecey2F9W0pR2MqA1ONMHZ7ezd4Jy
         n2+p9wAfFKlmuH5MrlPX6bfk6ClAjCOCJFW29gg3gQ7hk8PX8RYugSkegnUrKGCtrII/
         cR/8du+ISc5N0w+Iwd7gN4qH2MMMSaxcCQIbtLgGmGNaN/sZA0k1ngYFJTNkiQiiY/O6
         D4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVnWXi9XzGnzUO889WxUE4Zky++24fLxhZ/Z0SMuYlqsWK56zu5iebAyzZmrHKE4PHeN6QbrBI984X4TWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq0r4BqjQ3C/zr9NIB8D6LVCEOVhHcXWFIAfLQpFxpq/otZh95
	oH4FT1FY7EaWmLDqmyQ6b8fzcKY4aVUcD2kuSGmhWKGfpRXXh0ApscbEwWwmqwEhzI5pnTeFjfU
	I3PhDvtO3xw==
X-Google-Smtp-Source: AGHT+IFtQ0ppmwDijKHBq8pxQbBR4WwH6ohRJXDXTfMDmQfyPnLqpC4qIuusDj+MeQPG3v9YNrag7AavM1An
X-Received: from qknor4.prod.google.com ([2002:a05:620a:6184:b0:7e8:14fd:d2c0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:408a:b0:7f3:caf0:8412
 with SMTP id af79cd13be357-7f3caf08452mr226815385a.46.1756156335052; Mon, 25
 Aug 2025 14:12:15 -0700 (PDT)
Date: Mon, 25 Aug 2025 14:12:03 -0700
In-Reply-To: <20250825211204.2784695-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825211204.2784695-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825211204.2784695-3-irogers@google.com>
Subject: [PATCH v1 2/3] perf stat: Don't skip failing group events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pass errno to stat_handle_error rather than reading errno after it has
potentially been clobbered. Move "skippable" handling first as a
skippable event (from the perf stat default list) should always just
be skipped.

Remove logic to skip rather than fail events in a group when they
aren't the group leader. The original logic was added in commit
cb5ef60067c1 ("perf stat: Error out unsupported group leader
immediately") due to error handling and opening being together and an
assertion being raised. Not failing this case causes broken groups to
not report values, particularly for topdown events.

Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Closes: https://lore.kernel.org/lkml/20250822082233.1850417-1-dapeng1.mi@linux.intel.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 48 +++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2c38dd98f6ca..ab567919b89a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -613,33 +613,40 @@ enum counter_recovery {
 	COUNTER_FATAL,
 };
 
-static enum counter_recovery stat_handle_error(struct evsel *counter)
+static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 {
 	char msg[BUFSIZ];
+
+	if (counter->skippable) {
+		if (verbose > 0) {
+			ui__warning("skipping event %s that kernel failed to open .\n",
+				    evsel__name(counter));
+		}
+		counter->supported = false;
+		counter->errored = true;
+		return COUNTER_SKIP;
+	}
+
 	/*
 	 * PPC returns ENXIO for HW counters until 2.6.37
 	 * (behavior changed with commit b0a873e).
 	 */
-	if (errno == EINVAL || errno == ENOSYS ||
-	    errno == ENOENT || errno == ENXIO) {
-		if (verbose > 0)
+	if (err == EINVAL || err == ENOSYS || err == ENOENT || err == ENXIO) {
+		if (verbose > 0) {
 			ui__warning("%s event is not supported by the kernel.\n",
 				    evsel__name(counter));
+		}
 		counter->supported = false;
 		/*
 		 * errored is a sticky flag that means one of the counter's
 		 * cpu event had a problem and needs to be reexamined.
 		 */
 		counter->errored = true;
-
-		if ((evsel__leader(counter) != counter) ||
-		    !(counter->core.leader->nr_members > 1))
-			return COUNTER_SKIP;
-	} else if (evsel__fallback(counter, &target, errno, msg, sizeof(msg))) {
+	} else if (evsel__fallback(counter, &target, err, msg, sizeof(msg))) {
 		if (verbose > 0)
 			ui__warning("%s\n", msg);
 		return COUNTER_RETRY;
-	} else if (target__has_per_thread(&target) && errno != EOPNOTSUPP &&
+	} else if (target__has_per_thread(&target) && err != EOPNOTSUPP &&
 		   evsel_list->core.threads &&
 		   evsel_list->core.threads->err_thread != -1) {
 		/*
@@ -651,29 +658,16 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 			evsel_list->core.threads->err_thread = -1;
 			return COUNTER_RETRY;
 		}
-	} else if (counter->skippable) {
-		if (verbose > 0)
-			ui__warning("skipping event %s that kernel failed to open .\n",
-				    evsel__name(counter));
-		counter->supported = false;
-		counter->errored = true;
-		return COUNTER_SKIP;
-	}
-
-	if (errno == EOPNOTSUPP) {
+	} else if (err == EOPNOTSUPP) {
 		if (verbose > 0) {
 			ui__warning("%s event is not supported by the kernel.\n",
 				    evsel__name(counter));
 		}
 		counter->supported = false;
 		counter->errored = true;
-
-		if ((evsel__leader(counter) != counter) ||
-		    !(counter->core.leader->nr_members > 1))
-			return COUNTER_SKIP;
 	}
 
-	evsel__open_strerror(counter, &target, errno, msg, sizeof(msg));
+	evsel__open_strerror(counter, &target, err, msg, sizeof(msg));
 	ui__error("%s\n", msg);
 
 	if (child_pid != -1)
@@ -761,7 +755,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 				continue;
 			}
 
-			switch (stat_handle_error(counter)) {
+			switch (stat_handle_error(counter, errno)) {
 			case COUNTER_FATAL:
 				err = -1;
 				goto err_out;
@@ -803,7 +797,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			if (create_perf_stat_counter(counter, &stat_config, &target,
 						     evlist_cpu_itr.cpu_map_idx) < 0) {
 
-				switch (stat_handle_error(counter)) {
+				switch (stat_handle_error(counter, errno)) {
 				case COUNTER_FATAL:
 					err = -1;
 					goto err_out;
-- 
2.51.0.261.g7ce5a0a67e-goog


