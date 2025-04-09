Return-Path: <linux-kernel+bounces-595318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB8AA81CB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 08:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3724917F505
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 06:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E3C1DF754;
	Wed,  9 Apr 2025 06:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpVVhA44"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2951DE4EF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179058; cv=none; b=IHuQSGhfLaQwQAuohCItcCU946IcUwfKA3FL6C4qjWPUM1/lCwfRpHyroLEK7J9CxdPLEGvfNSY4g18gaNccal+o4N51/X7974vesPpDoAy540LTSfdsKU8q3dj3HKgOazHfLd907y/PL6Z3LyAuBobxcLbAtFZNR2tiLpbsYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179058; c=relaxed/simple;
	bh=ifUhHpvB3YWjewd+FCiG+bnPL8N1hMQyEOj1ALhK2zo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=enSkIod9zjS9m/hdbDE7hQnkM3NqQjoU7+hRUSv4yyuWQDZ1ZN9LqqNk5mYnkMaJ8KJLZP6ocdMqA40dISc9ul5j4zfDWJu+td7JDlAp/es5Uj/20MhXQEpQFhPNiI7IX47sw+ApbNFiUeahEjvvVlYLMd0t7TYMbyhCfhpWuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fpVVhA44; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2c268416ff5so1498482fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 23:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179056; x=1744783856; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kljzr7zwrGyBJiGR5feDDMzqEBYffKkoUZPkiCSQTN4=;
        b=fpVVhA44Y2m2+TlzZGUrbfOSvev7enE20WJmJNTdDXDFMERa97HZjuxoP6SR06IvQY
         PemvLwfB7shm1C+TTf8ygs2QdkLkCEPPEGYpmtust1fvXQ+JJpYFKc+C9a7Lmdmno1sw
         eWL3DNyZIRYIli0tkdfI0xzWCOl4DcAnGKFD9l9Rrrvhp0hC8YDsMV46wyijjG4si7Ok
         A6dDnjKG3faPp2iayK+JGdaJrUNWCQ4HaQzWbEtFZDPLHP1pnaNTzuGflS1lkDF72wTO
         Pvs/JzEYFzKPKZlaVxhdi/jilz1Qyrx6MGn5cVqWNWHijOZipjLBp00j03qC+YEggqFh
         Bpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179056; x=1744783856;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kljzr7zwrGyBJiGR5feDDMzqEBYffKkoUZPkiCSQTN4=;
        b=RSbZ/B/2oNZIsZBiBPR/snjjqmEg4E6/94BwjzlmLOFp44TlMmYsfogp2Nv1qTMsTw
         CcHCew5MFV3e+ItJqUu+EANOtdNNoriIMOlnhi8BehdYwkx91o5Y6vU7483Q36kwGt5u
         4gK7V4m86pUftkUOKVCDiTfTpfhSlLJfYOo65g3MRUUrkc9Pl0yrF/+sGkMEjlRLnYH8
         yi+SvmKDK9IeQ124doRVogcwQEtiaxcqnPVzDvp7RFwiZ8waZ8f+BQCSv6+ZuEKRKBxL
         zpOHvj3FBx/fI34BgowU/XlKKk/HOf3EjXNIJq0Yw0YedrqPL3f5JGol/MxtoEJ5qD72
         CutQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc5WfkNe7130Tt9xSSgr+/ar4vrWFUIrT6GiUaF/HNMzco2+JbsMeKnQXfjA0JrsNhySNOJMCWYcNqMaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0thPHwIwxAIBbea0LEwQhn6ga5eOQiY9EeiYQz5Wnue1UQKv
	Nqgr0vu19iw/6egM1106WemuFGIGiXXaK+gks9vUN7FvcX98zyO2Uar3UBhDb7s1GlmMeiEBah+
	KSUM8Wg==
X-Google-Smtp-Source: AGHT+IEpAbci5D2K+zrEKBctEU7OjBR99gLmABLkKFhH8ddfFXAcjMioCvNvAVxx/8hAxWgkTErdlti5tTxo
X-Received: from oabwh16.prod.google.com ([2002:a05:6871:a690:b0:2c2:13d6:cf76])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:3a85:b0:297:2479:a35b
 with SMTP id 586e51a60fabf-2d0917334f5mr642451fac.1.1744179056381; Tue, 08
 Apr 2025 23:10:56 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:29 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-3-irogers@google.com>
Subject: [PATCH v4 02/16] perf intel-tpebs: Simplify tpebs_cmd
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

No need to dynamically allocate when there is 1. tpebs_pid duplicates
tpebs_cmd.pid, so remove. Use 0 as the uninitialized value (PID == 0
is reserved for the kernel) rather than -1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 55 ++++++++++++-----------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 3503da28a12f..74b43faab986 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -28,11 +28,10 @@
 #define PERF_DATA		"-"
 
 bool tpebs_recording;
-static pid_t tpebs_pid = -1;
 static size_t tpebs_event_size;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
-static struct child_process *tpebs_cmd;
+static struct child_process tpebs_cmd;
 
 struct tpebs_retire_lat {
 	struct list_head nd;
@@ -83,16 +82,6 @@ static int get_perf_record_args(const char **record_argv, char buf[],
 	return 0;
 }
 
-static int prepare_run_command(const char **argv)
-{
-	tpebs_cmd = zalloc(sizeof(struct child_process));
-	if (!tpebs_cmd)
-		return -ENOMEM;
-	tpebs_cmd->argv = argv;
-	tpebs_cmd->out = -1;
-	return 0;
-}
-
 static int start_perf_record(int control_fd[], int ack_fd[],
 				const char *cpumap_buf)
 {
@@ -110,10 +99,10 @@ static int start_perf_record(int control_fd[], int ack_fd[],
 	if (ret)
 		goto out;
 
-	ret = prepare_run_command(record_argv);
-	if (ret)
-		goto out;
-	ret = start_command(tpebs_cmd);
+	assert(tpebs_cmd.pid == 0);
+	tpebs_cmd.argv = record_argv;
+	tpebs_cmd.out = -1;
+	ret = start_command(&tpebs_cmd);
 out:
 	free(record_argv);
 	return ret;
@@ -156,14 +145,13 @@ static int process_feature_event(struct perf_session *session,
 	return 0;
 }
 
-static void *__sample_reader(void *arg)
+static void *__sample_reader(void *arg __maybe_unused)
 {
-	struct child_process *child = arg;
 	struct perf_session *session;
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 		.path = PERF_DATA,
-		.file.fd = child->out,
+		.file.fd = tpebs_cmd.out,
 	};
 	struct perf_tool tool;
 
@@ -189,12 +177,12 @@ static int tpebs_stop(void)
 	int ret = 0;
 
 	/* Like tpebs_start, we should only run tpebs_end once. */
-	if (tpebs_pid != -1) {
-		kill(tpebs_cmd->pid, SIGTERM);
-		tpebs_pid = -1;
+	if (tpebs_cmd.pid != 0) {
+		kill(tpebs_cmd.pid, SIGTERM);
 		pthread_join(tpebs_reader_thread, NULL);
-		close(tpebs_cmd->out);
-		ret = finish_command(tpebs_cmd);
+		close(tpebs_cmd.out);
+		ret = finish_command(&tpebs_cmd);
+		tpebs_cmd.pid = 0;
 		if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
 			ret = 0;
 	}
@@ -219,7 +207,7 @@ int tpebs_start(struct evlist *evsel_list)
 	 * We should only run tpebs_start when tpebs_recording is enabled.
 	 * And we should only run it once with all the required events.
 	 */
-	if (tpebs_pid != -1 || !tpebs_recording)
+	if (tpebs_cmd.pid != 0 || !tpebs_recording)
 		return 0;
 
 	cpu_map__snprint(evsel_list->core.user_requested_cpus, cpumap_buf, sizeof(cpumap_buf));
@@ -284,10 +272,11 @@ int tpebs_start(struct evlist *evsel_list)
 		ret = start_perf_record(control_fd, ack_fd, cpumap_buf);
 		if (ret)
 			goto out;
-		tpebs_pid = tpebs_cmd->pid;
-		if (pthread_create(&tpebs_reader_thread, NULL, __sample_reader, tpebs_cmd)) {
-			kill(tpebs_cmd->pid, SIGTERM);
-			close(tpebs_cmd->out);
+
+		if (pthread_create(&tpebs_reader_thread, /*attr=*/NULL, __sample_reader,
+				   /*arg=*/NULL)) {
+			kill(tpebs_cmd.pid, SIGTERM);
+			close(tpebs_cmd.out);
 			pr_err("Could not create thread to process sample data.\n");
 			ret = -1;
 			goto out;
@@ -416,18 +405,10 @@ void tpebs_delete(void)
 {
 	struct tpebs_retire_lat *r, *rtmp;
 
-	if (tpebs_pid == -1)
-		return;
-
 	tpebs_stop();
 
 	list_for_each_entry_safe(r, rtmp, &tpebs_results, nd) {
 		list_del_init(&r->nd);
 		tpebs_retire_lat__delete(r);
 	}
-
-	if (tpebs_cmd) {
-		free(tpebs_cmd);
-		tpebs_cmd = NULL;
-	}
 }
-- 
2.49.0.504.g3bcea36a83-goog


