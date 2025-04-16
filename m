Return-Path: <linux-kernel+bounces-603616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC9AA88A21
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 19:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABE11654D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 17:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5B728DEE2;
	Mon, 14 Apr 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwwyyVNB"
Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739028E60E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652532; cv=none; b=YHqn0Fr6MIWbMCRMefxrGoIM9i6WXGfwkgEQNlGIUhpWNKsug8jmI8zq78sopaUZeFl2rtzI6WGEgX4tVva9o+iZwYmFmHLSHZrU7jrUqDmMqB97Okiok9nXcxS4ee01m1sbp9uPIIMHrOa11+Z+mDmzxCGoIl/MnjCaOFT6jVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652532; c=relaxed/simple;
	bh=R62rwMee94H0rnPIOO0lHetf2H/4+Du7n6a2l3MvTjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CLcIlmVafGMHsbJZkOvi8/Fsanlb0xO4jL6O0moDcoz44y/3xfD9xkwABMjLcPg1DlYAy/W+qfT8aIAgcKW9vcUjoG9pGEc/UmIMDgQSSim2Dt+Qx8DGyDBoPZFkE+Wojff4HlVkwNs/Mrzhb3MgLhrsAeS1QoJ6EE7gPMfOTmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CwwyyVNB; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-3ff0944ab23so3554999b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652530; x=1745257330; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTJEV/tjpAK53HcSV+hpcQMNf976ySouQHMzXMjrJnQ=;
        b=CwwyyVNBZgkVuv5aeEZVM9kJuwZZ7eu1jVxJBGpBFnlLYFe2LWfd0LQ1t53e3EMJZe
         qm6IU02AZInq7gNa3sv/wl4F58y3QSICt5z0L8snL5MEZWBOlOd/m7quR845Y5dxL1iB
         cRA+bJ23rdh4w3mOV5NJ9UYSr2bEJgiT0N7CNI3vw7ZsTJR/jWgBZZMNFFVHTMp0+AE2
         6L6vyBL+8cI98sauMxUwq51pH4xHZs+EH4ePXn3qDxwaEPS61Whn3M6H6E4R3+5cIG/q
         4XeCChkdEdWenWqJhplyJ8wqjRcEV+ZUIQBPPYCnqVR37bYwrL785xA5IrOE7TTmFDHN
         jw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652530; x=1745257330;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTJEV/tjpAK53HcSV+hpcQMNf976ySouQHMzXMjrJnQ=;
        b=lauR8pT0Ndv5HlUf9A+WiJBHU4nWXXJCs9MEv0BRfoK/Wl7i5Lqsy8fvqtNv1iQw1q
         e5A8qzJer8N4mQKKlbaM0VsaqyU0RebEhJz4+CCqtz3hxhXQL/Z2MixMzh3gSpg6C+GV
         flgWFK3IuUKKVj/Cot+cDDnVj+KC2pWyrsz65Bvo1uopAG77b8PNBp+4fVWFJSQ0Zc5M
         X/67Wk9hbLMXCbEc87U09oFfO11QLOvC+cqfoXh6DsveRSju9RKAk7jVqeik/mKGgOl7
         bU0qI7dFrYftnfcA8Z8t/ptw/af1qNZwAzLMp9laeQggbTTd6J7BpP61KkKaDr4/SPlV
         9IeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW1xNA88m+GIjdSrxia3xr4ZjH/nOridYj/BsqyTuL3K9TlRIx5Up9sMevBtCyL4Zs+VwTEMEmXnQUDrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4DC2znThxdvxuf3Fmn6QOPukQLStbiHt6dOZfY1snwnWAdQX
	iZBFHJ5lSMhk41JbHwgymppmrudpS5vzn+cc1oT9dBUYs1Ar6llZbeXIHiGapTQDzpmhBwHOBD6
	/ScfMug==
X-Google-Smtp-Source: AGHT+IH+UMuFH9H0s3bHooULbZSWFshQucW+flyS9sfdNKc8Btka99t1duhHoCLHChL1OaTuf7tcOHadbuE6
X-Received: from oabuu9.prod.google.com ([2002:a05:6870:ae09:b0:2c2:5b99:3e17])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:19a5:b0:3f6:abec:2ba4
 with SMTP id 5614622812f47-40085089067mr9037803b6e.23.1744652529815; Mon, 14
 Apr 2025 10:42:09 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:25 -0700
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-8-irogers@google.com>
Subject: [PATCH v5 07/16] perf intel-tpebs: Inline get_perf_record_args
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

Code is short enough to be inlined and there are no error cases when
made inline. Make the implicit NULL pointer at the end of the argv
explicit. Move the fixed number of arguments before the variable
number of arguments. Correctly size the argv allocation and zero when
feeing to avoid a dangling pointer.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Weilin Wang <weilin.wang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.49.0.604.gff1f9ca942-goog


