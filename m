Return-Path: <linux-kernel+bounces-592638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A507CA7EF9C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 23:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D19217C7D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 21:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CCA25486E;
	Mon,  7 Apr 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGcFkcbe"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C8E25484B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060234; cv=none; b=o26tX4tccJJlozbS/27KoZFm7+go6JA9M9+0iAauO4EXLEwgMf0V4stkn4XdDsccvw1veXuB7TnNb6Pa5pKth0VTv9JguuO+6NNU0Vd4VezzUG5y+ZO3eR5LjRcGuF7Qz3lu0rMbWmr5l7S9JSh8lLuJ3mF4qK2LrA7B1rMJ5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060234; c=relaxed/simple;
	bh=dmk99xLT8Nx0mz4ddF1+mWBkWibkJI69saN0P2VeVFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bgg9aDzZID9ej6bX8nxyfKT0C+mQtcY9QVxeBv2cv8D5Gg24xT3y/oGqqlYok+xeewOjq+lFGUpxzzbO+oWhYcTuA6ovYrPzOebX3lG3FWWUq0j991hmRUAJNoWeSHhgjR9RqpSBrha15T4IsYMrzEacA20OP6Y0MZ1R18gDPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGcFkcbe; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b00aa1f50d1so348874a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744060233; x=1744665033; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hurkMSaqLGDLbW/1AFRFsncWr/nyXd3OBuzAUIRrz+4=;
        b=XGcFkcbeC+e2Aiggw3tosm5r1SjWZJqwqnHUCR225LsXmflF+TJfr7QvJwGWLZTO3c
         UZrp8F44vEncjKI03XYxDMzWwC+LgffFPFmSbCWWNDstekgq8AEnDCD8AWB2CX4bV+29
         WgIkbHFarU3wpeen6KEiAv0Ce5UhM+QvXDXyWX0D8Mjk80X0Pa/pv43eYdHTyvBoBNJj
         dGsOdaQrXwQQCdVUD5nIWhDFrhMus15h9t3xJ2+gl0BIufVpKFd2zzzpUDynzZPuHzAY
         qoduNqUBjVWW+/iQBSpjhQ97VIt0GPhJEn6xgf1M0H0SL5qPTiSHKYOUDuij+OQZBiCW
         fbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060233; x=1744665033;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hurkMSaqLGDLbW/1AFRFsncWr/nyXd3OBuzAUIRrz+4=;
        b=sRKPcgD1f9kXkPVv0zufHeqZJbgfszjDF9JOTtJUp7JR2IvkINPJfkoqqy+IQAAJaA
         VZukYPlc/DHJXNDiPjmxL83O9ZrwCrWNlhvrvTGdNxvU4pFtAESzWvf1YasE2P/1K9YH
         rqntolVkxcGsgTx/+6vkgus261L9dCtjRN0ZOkICzLBf9NEDlZ9kGl5kmvsVZEnvGEo/
         aokPcwz+F9DiTdjhmItFnj2gQdoRdbMUpzyjnS3+EFHY8dn3ZU5GIbuotPluFJaCyc+1
         X9JHeUQMfrrVjjTNxKMePUf7/yZCb6MdgBee/Vbegdt9RCDLJNg0CSng69NFj8xTJjgQ
         bYwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfdTL+qxRuTq3q6OwvaQMR+/DUPRQWIVX2+DLCiSPh+wg/imwI8L8o4iPLqV6ocq8g89WykmgRvrx+cqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT589Owo7IdgL7TFoJAX7ou9P3Lb+zewcDLDWKAm7AfwJyF0oT
	7/ojJNbeNP4wbtYQK1ExO35hBg7TkosBy8sMY/1kNpiTw2uL9Q7HWBMBnhfIf9xG0TN1EDfuh+Z
	dsB1zNQ==
X-Google-Smtp-Source: AGHT+IHxbggJBMjv0kTrMcvBAtE/UmKuR2I5q/zXUAd4FNzjEiQbmTkyWuNrkiEcvkeLqrJ3n+r4Y7hqCjfu
X-Received: from pjur6.prod.google.com ([2002:a17:90a:d406:b0:2fc:ccfe:368])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2709:b0:2f9:c139:b61f
 with SMTP id 98e67ed59e1d1-306a48650dfmr22917867a91.14.1744060232771; Mon, 07
 Apr 2025 14:10:32 -0700 (PDT)
Date: Mon,  7 Apr 2025 14:09:28 -0700
In-Reply-To: <20250407210937.131681-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407210937.131681-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407210937.131681-8-irogers@google.com>
Subject: [PATCH v3 07/16] perf intel-tpebs: Inline get_perf_record_args
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

Code is short enough to be inlined and there are no error cases when
made inline. Make the implicit NULL pointer at the end of the argv
explicit. Move the fixed number of arguments before the variable
number of arguments. Correctly size the argv allocation and zero when
feeing to avoid a dangling pointer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 75 +++++++++++++----------------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index e3bed86145b9..c4c818f32239 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -47,72 +47,53 @@ struct tpebs_retire_lat {
 	double val;
 };
 
-static int get_perf_record_args(const char **record_argv, char buf[],
-				const char *cpumap_buf)
+static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
 {
-	struct tpebs_retire_lat *e;
-	int i = 0;
+	const char **record_argv;
+	int tpebs_event_size = 0, i = 0, ret;
+	char control_fd_buf[32];
+	char cpumap_buf[50];
+	struct tpebs_retire_lat *t;
+
+	list_for_each_entry(t, &tpebs_results, nd)
+		tpebs_event_size++;
 
-	pr_debug("tpebs: Prepare perf record for retire_latency\n");
+	record_argv = malloc((10 + 2 * tpebs_event_size) * sizeof(*record_argv));
+	if (!record_argv)
+		return -ENOMEM;
 
 	record_argv[i++] = "perf";
 	record_argv[i++] = "record";
 	record_argv[i++] = "-W";
 	record_argv[i++] = "--synth=no";
-	record_argv[i++] = buf;
 
-	if (!cpumap_buf) {
-		pr_err("tpebs: Require cpumap list to run sampling\n");
-		return -ECANCELED;
-	}
-	/* Use -C when cpumap_buf is not "-1" */
-	if (strcmp(cpumap_buf, "-1")) {
+	scnprintf(control_fd_buf, sizeof(control_fd_buf), "--control=fd:%d,%d",
+		  control_fd[0], ack_fd[1]);
+	record_argv[i++] = control_fd_buf;
+
+	record_argv[i++] = "-o";
+	record_argv[i++] = PERF_DATA;
+
+	if (!perf_cpu_map__is_any_cpu_or_is_empty(evsel->evlist->core.user_requested_cpus)) {
+		cpu_map__snprint(evsel->evlist->core.user_requested_cpus, cpumap_buf,
+				 sizeof(cpumap_buf));
 		record_argv[i++] = "-C";
 		record_argv[i++] = cpumap_buf;
 	}
 
-	list_for_each_entry(e, &tpebs_results, nd) {
+	list_for_each_entry(t, &tpebs_results, nd) {
 		record_argv[i++] = "-e";
-		record_argv[i++] = e->name;
+		record_argv[i++] = t->name;
 	}
-
-	record_argv[i++] = "-o";
-	record_argv[i++] = PERF_DATA;
-
-	return 0;
-}
-
-static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
-{
-	const char **record_argv;
-	size_t tpebs_event_size = 0;
-	int ret;
-	char buf[32];
-	char cpumap_buf[50];
-	struct tpebs_retire_lat *t;
-
-	cpu_map__snprint(evsel->evlist->core.user_requested_cpus, cpumap_buf,
-			 sizeof(cpumap_buf));
-
-	scnprintf(buf, sizeof(buf), "--control=fd:%d,%d", control_fd[0], ack_fd[1]);
-
-	list_for_each_entry(t, &tpebs_results, nd)
-		tpebs_event_size++;
-
-	record_argv = calloc(12 + 2 * tpebs_event_size, sizeof(char *));
-	if (!record_argv)
-		return -ENOMEM;
-
-	ret = get_perf_record_args(record_argv, buf, cpumap_buf);
-	if (ret)
-		goto out;
+	record_argv[i++] = NULL;
+	assert(i == 10 + 2 * tpebs_event_size || i == 8 + 2 * tpebs_event_size);
+	/* Note, no workload given so system wide is implied. */
 
 	assert(tpebs_cmd.pid == 0);
 	tpebs_cmd.argv = record_argv;
 	tpebs_cmd.out = -1;
 	ret = start_command(&tpebs_cmd);
-out:
-	free(record_argv);
+	zfree(&tpebs_cmd.argv);
 	return ret;
 }
 
-- 
2.49.0.504.g3bcea36a83-goog


