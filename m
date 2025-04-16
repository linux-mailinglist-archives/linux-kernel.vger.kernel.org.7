Return-Path: <linux-kernel+bounces-603610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737FCA88A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 19:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26EC3B6DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E582528B512;
	Mon, 14 Apr 2025 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+w8eaZ9"
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789AE289374
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652522; cv=none; b=BWlX5u3WNYw8aSqy9qpUoLGQExlUH91KzrR34UIGlzs0oW+RU4XulDT7pXV+vflIq0gp0EB1GjgehZ2WxPvklm69QpqQffXC0oQ98bCOhdSkB0QAtJm+gyISXyRiVlBHwHUmE1opJIQr3C37xXmgMBHbyzkATLneUTLzKAbzuE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652522; c=relaxed/simple;
	bh=GYcCF2ln1JP9ulMcXVsY5IXeTj02wNp7Ku5VYlensd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EWNPInqJ5RPnjj+kUPYHWCrX1Mr3gJ3D1BnqIvRNuXyAjKjHHRWs6Dz+2pFWxQF0i6s9GE6NDhWgwshidirSqEe1A/F7/tt0lfGU8WhEuNNzvBWH8ca96S9HG7sAvPHG1NwkcvKNfPMCGDq/zD6RCAWtUylBmfW8szatf/O9Qlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+w8eaZ9; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-72b7c00f3c6so1659400a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652519; x=1745257319; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Xjqd/eHoa9qdRaFqxZ6wL6dtilUZmMfUfX3xchqEoQ=;
        b=D+w8eaZ9LWeAy3RsxYoZ6weGow39NJQ23GjJJS906dhIFQpX3Hyyp3QzFUaB6/LKcl
         e/pXOPXKP/fkBcl3Zw/vbmFjqtjCU358sofL1Ye7/gkQ1U32yR9+GZhaCF/PjqPkd2H7
         pHJzWBPpRfozLPmBhv9ao0/SV0QKBQoACzosBdV1nQGKF2u+QuCEkEbngUSoRyhbwBcs
         YuOB+ryPZmgMMQ7kLFiwxv2JFYUBeQ8+G0r6YhWTlMAJSiy6uFVMzO290+2DVdhcTey6
         3Jqlvlqxm+bQVz7aelHeFpE9EqYiFJ4RiQpmV6sFCDlVHTn59mkH7AFfVaXC8GZttpfI
         zkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652519; x=1745257319;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Xjqd/eHoa9qdRaFqxZ6wL6dtilUZmMfUfX3xchqEoQ=;
        b=EruvPfm7JVXDNEVUXGHh/GYe10d1PC3+3GJWf1UpbuI5UfnR1KP48phSReP/Ej3CBv
         YIgQnarDhO2J/TdQD8W4P6PCXzfdHIVavqkGpy/XQez2Cn65q9ZzTGgDljhIq0DVeDN7
         +WK/dxLDMEagE3Kp2rB6PMub4osh/t5X2tKHz024fo7PTajlS+1swh8dwIdJcoicLQ8i
         K3JXp0PXy7zeVba8TIGsgizXuZt3Zz+8MESACwrdB8YmVQ9XA+x7vPkHUEAqnzsmiC8Q
         1K9WVkz7nibz553CNkH07hqwqSQWScfk3smi6taqyVXzSB3w9YjA2kPHZ3/m8rz1zI0R
         tkIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFKsHx2VOGdHyLxYBxdWbGRzAbxO4oe3FrxpgexW6e2dGH2BGiLcKeMIf8moVAzP4RNdYsMs6a6gh+HrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08/BRRvvwibTKi6zV0IcPopq9hluVJEBgOZWsaGbkyoGKHi9+
	mRGamdoWq+lFOV/CBCU2pEQwak2J6iza9T/+Ee8cRCGkprOOi9y/6B83AkuKfoth8xrU/s6l+xX
	ZaanZDQ==
X-Google-Smtp-Source: AGHT+IHAIHvmg45ZH8ZmmVp/o/FWbJr3iih77T1GTi8Z3PZ66JhZvV5CYV4n9hK5Yd6wEJ4qlbsRbrKYH0jU
X-Received: from oacoz11.prod.google.com ([2002:a05:6871:788b:b0:29d:f69c:1743])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:470c:b0:72a:1ecc:d23a
 with SMTP id 46e09a7af769-72e86341148mr8606745a34.15.1744652519541; Mon, 14
 Apr 2025 10:41:59 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:20 -0700
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-3-irogers@google.com>
Subject: [PATCH v5 02/16] perf intel-tpebs: Simplify tpebs_cmd
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

No need to dynamically allocate when there is 1. tpebs_pid duplicates
tpebs_cmd.pid, so remove. Use 0 as the uninitialized value (PID == 0
is reserved for the kernel) rather than -1.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Weilin Wang <weilin.wang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.49.0.604.gff1f9ca942-goog


