Return-Path: <linux-kernel+bounces-592639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F786A7EF9F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 23:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FED189578B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 21:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2341254B14;
	Mon,  7 Apr 2025 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0ZdOWDY"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919F254AE5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060237; cv=none; b=BMEiz9PkTn2AF3+gfeK5wQGpHoBvKVOyxICJ6e97yaSbvY45qAZ3T+C+71asFadU6ZT4Ek7IDSqxH00XXKuOtZIctZp1m+kFOIdnKVJ7mR678/fR2N7p7QxprSX0DypBTw0gl8vJAVStdKaQcosgTGOvnEtVhPfABtBARxXKnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060237; c=relaxed/simple;
	bh=6EEZTd9lf9aeTITKws4CXHLVcUfJH0Aqr7eXP+eg5Q0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ejZWGEhHbFGOcn4DlXR0cgVrE52HzAYePxXufi8pxXZdHwft9riaN3pXGNVLCbXhNH8sqRLPJZavdu31lRFOh/ip7R3UCOsTlniTOn8IZaX13I8MR3sMVdOgvI9HjXW3kCZ0XdN7CbdbCRjpkLf9wgVuQU1F+SPf+wUgvho888c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0ZdOWDY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c7d0d35aso6781887b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 14:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744060235; x=1744665035; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4eUmflRE5uebU4/SNO43FiJCwVtS3ISrTa0e4ce5bk=;
        b=b0ZdOWDYPzkKlLBSwuPn98o9jZQxubFiLbREpnTjOoNZyWrPhzmFJJd7vboG48wi+3
         F+vU6GoDAp/mMNSJi3r88OHFCREUMRAbWCmUA76aaW2IaLpUSLBrZoxKJTDGMIJv3QeZ
         7j3/naKX9qQcl+uI2Xt8UCiN4+nkiPtjrH7+4ZW2WMKBs3teWk/qTL3rm/p6NB/kZaqK
         UQ24uEPIwnOasz86px5ugdD8iOEEsULBODJ0lzZcgU51A9z2UXEEKSbnBwpTwyJY7vgB
         pj2B2/VgV/4JcbgkSV4zGuo2u2MUDyl3sjd/4r+yeAAQHILwSyJ75uqLnPsTfV/PS4rp
         xyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060235; x=1744665035;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4eUmflRE5uebU4/SNO43FiJCwVtS3ISrTa0e4ce5bk=;
        b=R8ZAOPbQ/n6tBkJHs8IZpaLxfGxz4WZMkrV7JAuXWdrrn1tykGsMCE+mCj+FmQIQcd
         kr43KNj9SVcbBMkNyGeaFe72KBJloT0jptwZP0ivoq372Vjr+PWtEA5hifeYQmolbxMy
         4Q/c0HqjFs8H8wSSdiDPUcDRNbNtL9Bkqv1QF2OBeZs/Rvf/Tjqm496wY1b39FPvpShL
         Kx1LSkEL/gdWwcFmSM85BnPEGzqTKLxGW05M7+ZNoC2zaT3sKJfz9M6FNqm4oGOeJ/cR
         xNQfwIt2+G/64/YAjlVwn8xhgA+Y0btEPKX3zHdEou+QC1xc/9wZaq5RnNv+oT+SMJcI
         ZxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVamCx5/HO7ynYAVyDYIgXWtAisJJYT7qG+NrOYxCENECR1K9B5COqSSpdGywACqm+NVFMg80aPHKPXjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HrPSuZAxP1ei1+zIPQ511RwJActod8tJYmMBZBTPGNehd+sH
	SxBRCgQggjKRg1uX6aRai1zBYJmrolIVBmJVtZ3F/qhSwVS057bNoG+1yO26RQczPdX++8s9iRu
	sOri/xQ==
X-Google-Smtp-Source: AGHT+IG2gReaDEhE7AblA2Y3U9htDI7NfqmCOk34FgpaGt3QgefP3GK+JbE++vQfUPtqb40kDnRoF1PxAKTC
X-Received: from pgbgb3.prod.google.com ([2002:a05:6a02:4b43:b0:af9:1196:c39c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c896:b0:1f5:889c:3cbd
 with SMTP id adf61e73a8af0-20113d5539amr17830240637.35.1744060234905; Mon, 07
 Apr 2025 14:10:34 -0700 (PDT)
Date: Mon,  7 Apr 2025 14:09:29 -0700
In-Reply-To: <20250407210937.131681-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407210937.131681-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407210937.131681-9-irogers@google.com>
Subject: [PATCH v3 08/16] perf intel-tpebs: Ensure events are opened, factor
 out finding
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

Factor out finding an tpebs_retire_lat from an evsel. Don't blindly
return when ignoring an open request, which happens after the first
open request, ensure the event was started on a fork of perf record.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 61 +++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index c4c818f32239..e42f3ec39a64 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -45,6 +45,8 @@ struct tpebs_retire_lat {
 	int sum;
 	/* Average of retire_latency, val = sum / count */
 	double val;
+	/* Has the event been sent to perf record? */
+	bool started;
 };
 
 static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
@@ -94,6 +96,9 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
 	tpebs_cmd.out = -1;
 	ret = start_command(&tpebs_cmd);
 	zfree(&tpebs_cmd.argv);
+	list_for_each_entry(t, &tpebs_results, nd)
+		t->started = true;
+
 	return ret;
 }
 
@@ -214,6 +219,19 @@ static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
 	return result;
 }
 
+static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
+{
+	struct tpebs_retire_lat *t;
+
+	list_for_each_entry(t, &tpebs_results, nd) {
+		if (t->tpebs_name == evsel->name ||
+		    !strcmp(t->tpebs_name, evsel->name) ||
+		    (evsel->metric_id && !strcmp(t->tpebs_name, evsel->metric_id)))
+			return t;
+	}
+	return NULL;
+}
+
 /**
  * evsel__tpebs_prepare - create tpebs data structures ready for opening.
  * @evsel: retire_latency evsel, all evsels on its list will be prepared.
@@ -221,16 +239,11 @@ static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
 static int evsel__tpebs_prepare(struct evsel *evsel)
 {
 	struct evsel *pos;
-	struct tpebs_retire_lat *tpebs_event;
-
-	list_for_each_entry(tpebs_event, &tpebs_results, nd) {
-		if (!strcmp(tpebs_event->tpebs_name, evsel->name)) {
-			/*
-			 * evsel, or an identically named one, was already
-			 * prepared.
-			 */
-			return 0;
-		}
+	struct tpebs_retire_lat *tpebs_event = tpebs_retire_lat__find(evsel);
+
+	if (tpebs_event) {
+		/* evsel, or an identically named one, was already prepared. */
+		return 0;
 	}
 	tpebs_event = tpebs_retire_lat__new(evsel);
 	if (!tpebs_event)
@@ -262,12 +275,19 @@ int evsel__tpebs_open(struct evsel *evsel)
 {
 	int ret;
 
-	/*
-	 * We should only run tpebs_start when tpebs_recording is enabled.
-	 * And we should only run it once with all the required events.
-	 */
-	if (tpebs_cmd.pid != 0 || !tpebs_recording)
+	/* We should only run tpebs_start when tpebs_recording is enabled. */
+	if (!tpebs_recording)
 		return 0;
+	/* Only start the events once. */
+	if (tpebs_cmd.pid != 0) {
+		struct tpebs_retire_lat *t = tpebs_retire_lat__find(evsel);
+
+		if (!t || !t->started) {
+			/* Fail, as the event wasn't started. */
+			return -EBUSY;
+		}
+		return 0;
+	}
 
 	ret = evsel__tpebs_prepare(evsel);
 	if (ret)
@@ -352,7 +372,6 @@ int evsel__tpebs_open(struct evsel *evsel)
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	__u64 val;
-	bool found = false;
 	struct tpebs_retire_lat *t;
 	struct perf_counts_values *count;
 
@@ -367,19 +386,13 @@ int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
 	tpebs_stop();
 	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
-	list_for_each_entry(t, &tpebs_results, nd) {
-		if (t->tpebs_name == evsel->name ||
-		    (evsel->metric_id && !strcmp(t->tpebs_name, evsel->metric_id))) {
-			found = true;
-			break;
-		}
-	}
+	t = tpebs_retire_lat__find(evsel);
 
 	/* Set ena and run to non-zero */
 	count->ena = count->run = 1;
 	count->lost = 0;
 
-	if (!found) {
+	if (!t) {
 		/*
 		 * Set default value or 0 when retire_latency for this event is
 		 * not found from sampling data (record_tpebs not set or 0
-- 
2.49.0.504.g3bcea36a83-goog


