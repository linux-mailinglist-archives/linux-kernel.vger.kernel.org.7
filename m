Return-Path: <linux-kernel+bounces-592633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D3EA7EF97
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 23:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB5E17C239
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 21:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C271235BF9;
	Mon,  7 Apr 2025 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKB5aZ6T"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63072225779
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060227; cv=none; b=GiI7hcZBBnPVqlSEVxDOUoya63p5pf7qLrFq/WGb3dESMRNxXwazN4TgMf4Bd9pfd6r9tXogt7olwskGNuGcj5e0qN7lGx4qNeZNCTDJsJchs+r8QfHWKqXuEUfxGeONOW880cvAkpHJdAa/kD3vG9fDGJnMIlaagcyT33Irzyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060227; c=relaxed/simple;
	bh=2l/1oKHeKrpT+PnW/axoFCb0/bWcsP4vJAsPyglQu90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=G5mVz1TDSpZH1AOaIXHb9wW7OcYHHEU7stMrnVHFWuLfSJwwMKyT4k/7LR3XD6FB9VMSw1TBrTWLZBHvA2vXyiRlm6v30Pw1+X3PxmJYlXfbIW7jnbhgdJq0Me8xtYpNnNRZotWhg82ESUgzhlVBkw0al1nIP/j28WTvjSSk7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IKB5aZ6T; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-227ea16b03dso68112135ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744060224; x=1744665024; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0w8p9z7uIDU2rw9JTfItdCw1PZrvXFzExYD6rhP3a4=;
        b=IKB5aZ6TGaEuUOoHR3vthZg6WPaoEtcwCIsykYKcs3nML9cpL3F1gsqvqcUfSI/N8l
         e74Gz56fhyDKlb/FmB2T6QgE9lhWtpFbHRouDOwVDGmyOHD0WjeivMkfL8uqIkn85tQs
         2ZrBFuNWN13Y3yE3hQ0O3JdKWFOi7BXXFZ0xUhV1W0lRnHmu17OWSXi60k7SI6nDU1sB
         bv59Mbc0QZq3gGFRu9jMio2jsPAyTf0mgdiopGla9JrGtH6r9vTY+NGf3cN/7udzll1c
         cdMWp8SPQNYgn3SiRgOFg+j/pwytEsMmfuv4z1O2az8Qo/bQC2eRgA+CDh/vvHwB0QGu
         kA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060224; x=1744665024;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0w8p9z7uIDU2rw9JTfItdCw1PZrvXFzExYD6rhP3a4=;
        b=EZbMqbT5ESEXt3WcjWkrO7XANQqHaFyNa9OmpnVar7BDoQ1k2UyBugKycHH3mN3Ydg
         8cKSNMP+os7i7DsCEPBEKw1IFeIICglD9jaS3w4EsZBdChudMPxDC7gMYDjsMmWv4q5R
         WHhO24DOdftHVjIG3G84aATek1Vk0U0PHtWNl5ujYXJEwcimuzPkPTsT/0geqUoTAlD8
         le50EmuQlbN0k4rR2RHl4tcEu3+Knx/ZZUWqzKXJchg7HfE1A7oKChIjqJscaB2gNxhn
         5O365t+DBRGAAx8u0+3DKo8P9TgN/Pd6mXTVPYVXq5YZkeIu3TL0Dbn6EPtHSA6cHqeI
         FzsA==
X-Forwarded-Encrypted: i=1; AJvYcCUSyCt+GIyyQFCMDIriutK460wKBBQ7TAhe6rcZzfrO06oqx+ZEQhp+1P4rqFmeIv1eqRLh/lw2mtkWCho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPRLRraWMl7fXBXbQPwnY1fyPATuPcXsRw+IM4eD3Ds2Dmg9FJ
	gyhtGNjEoOMbld4bi41fhuqlXIk3UqY3gdE13ilcxs1EWeWDqGbO90j5RhC5UXXfaaCkevSF7IP
	hhH48Vw==
X-Google-Smtp-Source: AGHT+IEdWPPIqwn5SQ6gdoZhbvYZj7NCxoOyVuJtRMp0USM7fGqNRDiVzvwVugZTgrPnttBZw5vpC9OJwKMM
X-Received: from plpj21.prod.google.com ([2002:a17:903:3d95:b0:226:342c:5750])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d487:b0:220:efc8:60b1
 with SMTP id d9443c01a7336-22a8a0a38c6mr196325175ad.39.1744060224626; Mon, 07
 Apr 2025 14:10:24 -0700 (PDT)
Date: Mon,  7 Apr 2025 14:09:24 -0700
In-Reply-To: <20250407210937.131681-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407210937.131681-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407210937.131681-4-irogers@google.com>
Subject: [PATCH v3 03/16] perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Try to add more consistency to evsel by having tpebs_start renamed to
evsel__tpebs_open, passing the evsel that is being opened. The unusual
behavior of evsel__tpebs_open opening all events on the evlist is kept
and will be cleaned up further in later patches. The comments are
cleaned up as tpebs_start isn't called from evlist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c       |  2 +-
 tools/perf/util/intel-tpebs.c | 33 ++++++++++++++++-----------------
 tools/perf/util/intel-tpebs.h |  2 +-
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1974395492d7..121283f2f382 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2595,7 +2595,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	struct perf_cpu cpu;
 
 	if (evsel__is_retire_lat(evsel))
-		return tpebs_start(evsel->evlist);
+		return evsel__tpebs_open(evsel);
 
 	err = __evsel__prepare_open(evsel, cpus, threads);
 	if (err)
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 74b43faab986..566e0ddcad88 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -12,6 +12,7 @@
 #include <linux/zalloc.h>
 #include <linux/err.h>
 #include "sample.h"
+#include "counts.h"
 #include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -189,18 +190,16 @@ static int tpebs_stop(void)
 	return ret;
 }
 
-/*
- * tpebs_start - start tpebs execution.
- * @evsel_list: retire_latency evsels in this list will be selected and sampled
- * to get the average retire_latency value.
- *
- * This function will be called from evlist level later when evlist__open() is
- * called consistently.
+/**
+ * evsel__tpebs_open - starts tpebs execution.
+ * @evsel: retire_latency evsel, all evsels on its list will be selected. Each
+ *         evsel is sampled to get the average retire_latency value.
  */
-int tpebs_start(struct evlist *evsel_list)
+int evsel__tpebs_open(struct evsel *evsel)
 {
 	int ret = 0;
-	struct evsel *evsel;
+	struct evsel *pos;
+	struct evlist *evsel_list = evsel->evlist;
 	char cpumap_buf[50];
 
 	/*
@@ -215,25 +214,25 @@ int tpebs_start(struct evlist *evsel_list)
 	 * Prepare perf record for sampling event retire_latency before fork and
 	 * prepare workload
 	 */
-	evlist__for_each_entry(evsel_list, evsel) {
+	evlist__for_each_entry(evsel_list, pos) {
 		int i;
 		char *name;
 		struct tpebs_retire_lat *new;
 
-		if (!evsel->retire_lat)
+		if (!pos->retire_lat)
 			continue;
 
-		pr_debug("tpebs: Retire_latency of event %s is required\n", evsel->name);
-		for (i = strlen(evsel->name) - 1; i > 0; i--) {
-			if (evsel->name[i] == 'R')
+		pr_debug("tpebs: Retire_latency of event %s is required\n", pos->name);
+		for (i = strlen(pos->name) - 1; i > 0; i--) {
+			if (pos->name[i] == 'R')
 				break;
 		}
-		if (i <= 0 || evsel->name[i] != 'R') {
+		if (i <= 0 || pos->name[i] != 'R') {
 			ret = -1;
 			goto err;
 		}
 
-		name = strdup(evsel->name);
+		name = strdup(pos->name);
 		if (!name) {
 			ret = -ENOMEM;
 			goto err;
@@ -247,7 +246,7 @@ int tpebs_start(struct evlist *evsel_list)
 			goto err;
 		}
 		new->name = name;
-		new->tpebs_name = evsel->name;
+		new->tpebs_name = pos->name;
 		list_add_tail(&new->nd, &tpebs_results);
 		tpebs_event_size += 1;
 	}
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 63c16e759a71..cc98203719c8 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -10,7 +10,7 @@ struct evsel;
 
 extern bool tpebs_recording;
 
-int tpebs_start(struct evlist *evsel_list);
+int evsel__tpebs_open(struct evsel *evsel);
 void tpebs_delete(void);
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
 
-- 
2.49.0.504.g3bcea36a83-goog


