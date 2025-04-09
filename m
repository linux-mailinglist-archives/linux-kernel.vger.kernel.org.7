Return-Path: <linux-kernel+bounces-595320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675D0A81CBA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 08:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676204A4233
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 06:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6DB1E1DF6;
	Wed,  9 Apr 2025 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxidZXyG"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12B1DF98B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179064; cv=none; b=KOE6fMMj8qzbS91f+64/SYnI7Nn5v4qIBUCK2ODFup87RI9Cs9lCy2GijWmIoKoOcurHv2m2LKvF1UOVnXPNlBwfqnJkawRywYeH5rwbTeZlWylVtHRbgX/GprMdczf2Z4v06OiNRJGMegydnln2e0JgWVIoa+xi76lfMsNo3mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179064; c=relaxed/simple;
	bh=JVanJEDpcMknG2x/X1wULUkE8JUqUZb8O7VIacDzqk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rznlcuUzuIItzRFJAJH4Pxfa+jowSZ3KLIDagstQ+HLihsd58beN+VMMZ5MAWlhszs3hffZTj2LN7QvQkQuvuqNTyJ5+TawB+ozVLKHEKFxwk4kTx0rNj2YuCNm5HcJhakzv9GshKbP1qLr7JpGi6rOdUYJnkprjUD/tjQF55L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxidZXyG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2254e500a73so50101825ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 23:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179060; x=1744783860; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpNqTL2jhuFhMzQj4yTZFm6mW4YS6L/CEY0JlzRGbe8=;
        b=bxidZXyGo/w9wsSfKSKPUtqKSoqljEBNS5RNNPKVVkUvmU2cqZfBsmBnRFCdcl+EN6
         se/GxLhzMg6r/cFdAfrJfJjnIHIThuL+hqJK8//CrbtCBgrtMFUDFHRYuEqr7cnYO9IX
         xe0I0qcqBTP0Nzn14BWP1vrviJyCRU/iP3GVdjSRyxLrKvom9dqhrlWFfYlZP0E3UPOh
         3ojuWl8htt2I65fvwwkCbNbmNwM/JNtp5kDaHoq+8w5ipJJVvLR0da8x24HaeGIUHlqr
         VbjwG8gDvMJZXjo+4aWAAfK1FENnnuWTrO0Hb//C2SW2zTodRLPGrSgYN9H5W6APPPoI
         ESOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179060; x=1744783860;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpNqTL2jhuFhMzQj4yTZFm6mW4YS6L/CEY0JlzRGbe8=;
        b=THTBeueONG36uHIlq68SLObs8r9SDFnJ7YzQS/c3Li/bH5Mc8f5JWLqXZSfIHJaBYP
         jk9fqnFqq/6pY7LkG2yTxvHB7D9jFPPqqdYMQ8jRWwH9Iq/vYT3P5uQeOPIzOd/dsRiZ
         5zwfVKGDCiFbElP0IHc4faw2SEUfahoRFyXrBRJpnhlijXafOg7MbXf8Bd2TdYVXYv0r
         vyf3A4es/nIxpjxGMSwWnTmM/fOLzE8iiWjFbDsq7NW1YJHYzv+Zhco9XGXqJbrQaRGf
         aE0fOwGM18BA02h3MyhBpfnT4qIBGn5WnVpj1sMYUSUnDFDoc1EnoPuhhRj68V2VHZ7Z
         jZmw==
X-Forwarded-Encrypted: i=1; AJvYcCW9r4hc17JyT+kIv5N6YeT9VUWQj5bNGSF1aIhgWoiJ1UiJe9z8Q7Ey3EbiFAVolo3F/l4Fv9h+eKGRZQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFcvxRY+kqrHol9sSA+bwleYw+PUNpEW2sw+Rg7pq2IqHLgJ+y
	VOBETFamXGV+MFQ2uzwGXevTp116wJLNt0RIx4JBKoJqLBF6VeW/DeY3wwVFvXsA9/yYyP/0+bq
	hVpm2+g==
X-Google-Smtp-Source: AGHT+IErAnuwCeBZmsAOzHhsP16PjdkMPY2pHH2AhY36Fl2RSK5pWlpIq5/WuBh19xUKYE8JuHUefEIkZNqY
X-Received: from plbbb5.prod.google.com ([2002:a17:902:bc85:b0:220:ecac:27e5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d507:b0:224:1579:5e8e
 with SMTP id d9443c01a7336-22ac296e733mr26282625ad.1.1744179060093; Tue, 08
 Apr 2025 23:11:00 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:31 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-5-irogers@google.com>
Subject: [PATCH v4 04/16] perf intel-tpebs: Separate evsel__tpebs_prepare out
 of evsel__tpebs_open
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

Separate the creation of the tpebs_retire_lat result out of the
opening step. This is in preparation for adding a prepare operation
for evlists.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 133 ++++++++++++++++++++++------------
 1 file changed, 86 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 566e0ddcad88..2186818b2c9b 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -37,7 +37,7 @@ static struct child_process tpebs_cmd;
 struct tpebs_retire_lat {
 	struct list_head nd;
 	/* Event name */
-	const char *name;
+	char *name;
 	/* Event name with the TPEBS modifier R */
 	const char *tpebs_name;
 	/* Count of retire_latency values found in sample data */
@@ -190,6 +190,82 @@ static int tpebs_stop(void)
 	return ret;
 }
 
+static char *evsel__tpebs_name(struct evsel *evsel)
+{
+	char *name, *modifier;
+
+	name = strdup(evsel->name);
+	if (!name)
+		return NULL;
+
+	modifier = strrchr(name, 'R');
+	if (!modifier) {
+		pr_err("Tpebs event missing modifier '%s'\n", name);
+		free(name);
+		return NULL;
+	}
+
+	*modifier = 'p';
+	return name;
+}
+
+static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
+{
+	struct tpebs_retire_lat *result = zalloc(sizeof(*result));
+
+	if (!result)
+		return NULL;
+
+	result->tpebs_name = evsel->name;
+	result->name = evsel__tpebs_name(evsel);
+	if (!result->name) {
+		free(result);
+		return NULL;
+	}
+	list_add_tail(&result->nd, &tpebs_results);
+	tpebs_event_size++;
+	return result;
+}
+
+/**
+ * evsel__tpebs_prepare - create tpebs data structures ready for opening.
+ * @evsel: retire_latency evsel, all evsels on its list will be prepared.
+ */
+static int evsel__tpebs_prepare(struct evsel *evsel)
+{
+	struct evsel *pos;
+	struct tpebs_retire_lat *tpebs_event;
+
+	list_for_each_entry(tpebs_event, &tpebs_results, nd) {
+		if (!strcmp(tpebs_event->tpebs_name, evsel->name)) {
+			/*
+			 * evsel, or an identically named one, was already
+			 * prepared.
+			 */
+			return 0;
+		}
+	}
+	tpebs_event = tpebs_retire_lat__new(evsel);
+	if (!tpebs_event)
+		return -ENOMEM;
+
+	/*
+	 * Eagerly prepare all other evsels on the list to try to ensure that by
+	 * open they are all known.
+	 */
+	evlist__for_each_entry(evsel->evlist, pos) {
+		int ret;
+
+		if (pos == evsel || !pos->retire_lat)
+			continue;
+
+		ret = evsel__tpebs_prepare(pos);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /**
  * evsel__tpebs_open - starts tpebs execution.
  * @evsel: retire_latency evsel, all evsels on its list will be selected. Each
@@ -197,10 +273,7 @@ static int tpebs_stop(void)
  */
 int evsel__tpebs_open(struct evsel *evsel)
 {
-	int ret = 0;
-	struct evsel *pos;
-	struct evlist *evsel_list = evsel->evlist;
-	char cpumap_buf[50];
+	int ret;
 
 	/*
 	 * We should only run tpebs_start when tpebs_recording is enabled.
@@ -209,49 +282,13 @@ int evsel__tpebs_open(struct evsel *evsel)
 	if (tpebs_cmd.pid != 0 || !tpebs_recording)
 		return 0;
 
-	cpu_map__snprint(evsel_list->core.user_requested_cpus, cpumap_buf, sizeof(cpumap_buf));
-	/*
-	 * Prepare perf record for sampling event retire_latency before fork and
-	 * prepare workload
-	 */
-	evlist__for_each_entry(evsel_list, pos) {
-		int i;
-		char *name;
-		struct tpebs_retire_lat *new;
-
-		if (!pos->retire_lat)
-			continue;
-
-		pr_debug("tpebs: Retire_latency of event %s is required\n", pos->name);
-		for (i = strlen(pos->name) - 1; i > 0; i--) {
-			if (pos->name[i] == 'R')
-				break;
-		}
-		if (i <= 0 || pos->name[i] != 'R') {
-			ret = -1;
-			goto err;
-		}
-
-		name = strdup(pos->name);
-		if (!name) {
-			ret = -ENOMEM;
-			goto err;
-		}
-		name[i] = 'p';
-
-		new = zalloc(sizeof(*new));
-		if (!new) {
-			ret = -1;
-			zfree(&name);
-			goto err;
-		}
-		new->name = name;
-		new->tpebs_name = pos->name;
-		list_add_tail(&new->nd, &tpebs_results);
-		tpebs_event_size += 1;
-	}
+	ret = evsel__tpebs_prepare(evsel);
+	if (ret)
+		return ret;
 
 	if (tpebs_event_size > 0) {
+		struct evlist *evsel_list = evsel->evlist;
+		char cpumap_buf[50];
 		struct pollfd pollfd = { .events = POLLIN, };
 		int control_fd[2], ack_fd[2], len;
 		char ack_buf[8];
@@ -268,6 +305,9 @@ int evsel__tpebs_open(struct evsel *evsel)
 			goto out;
 		}
 
+		cpu_map__snprint(evsel_list->core.user_requested_cpus, cpumap_buf,
+				 sizeof(cpumap_buf));
+
 		ret = start_perf_record(control_fd, ack_fd, cpumap_buf);
 		if (ret)
 			goto out;
@@ -321,7 +361,6 @@ int evsel__tpebs_open(struct evsel *evsel)
 		close(ack_fd[0]);
 		close(ack_fd[1]);
 	}
-err:
 	if (ret)
 		tpebs_delete();
 	return ret;
-- 
2.49.0.504.g3bcea36a83-goog


