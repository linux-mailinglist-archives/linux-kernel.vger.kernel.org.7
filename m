Return-Path: <linux-kernel+bounces-846872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE0BBC94C8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABA114E5BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A8B2E8B7F;
	Thu,  9 Oct 2025 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ged5pxMR"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267F2E2280
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016561; cv=none; b=CoX1tMzPsJtYvw6beeeOv1o+dEN0IUQPqt1L5irPXPI4S6URc/H1xQ2QpHKXPhYFf33tMiuqA/pht+896fGygiiridCTvf9oLEDBjhTODd73xmw55T+qQ+CWAOxqeCgXNIsc0rNwEaIO3QNSCwFuT0lpJ5P5ke3z5z5rsOk7Oko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016561; c=relaxed/simple;
	bh=F04HxWzDm/pjovjMWYNweIL92Azt+kQc7Q1+4Lm96So=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=mUYjmWu48HFds3wTjzzGokmp1P/e+wyR3Lu3y75rdeI05OY6uxfmD1EHnhMyLS79D0Buh8I+DpFWGpXGZV574svPwqkbyPDXYvI4RFZTDATSc9gvmNIMy2fNq3GDdFR0t6LEna4LhxedRJ+xYN8fzaNIWv3FSAAnwrttrwjdCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ged5pxMR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-780fdbbdd20so1340633b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760016559; x=1760621359; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=czSuGa3Xrx5+Hnp2HdUeEuGq/5HbxJTVy8tEzAMc4TI=;
        b=ged5pxMRO9fixIY5x+mf6Ld+SjRbMXamm05Wwh07KmSfj00xmrPAUmEJpI64CrX8EG
         GCw9c6wPmK7SUNoXbN2xnwYdHg93Akx+McnzvS9k4gz8gFcNuXjUfuf1mm50yaSR13av
         ZenYf5nYotYq7m093O8dM4k6h20XRf967DQtxTlVuYSU8VTo+hpHx7tRJnpq8lu6gmPs
         wyigNjxAoHfMON6XE++2PQUkl0wL1I09CKsmOwOJVp1w+/Z/iK7wzdXHorJNU3s2CrW8
         4wn6B9/vo+sFnqYJ2BzvhEN2ZCVKdZDSrzZ0iRGZtpIwgWYFUX6y707tSlt/rFW4RMrT
         e/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760016559; x=1760621359;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=czSuGa3Xrx5+Hnp2HdUeEuGq/5HbxJTVy8tEzAMc4TI=;
        b=DHUiR06uTsTL/Zlv4SwKO3ma/UuBorTTPjp1Xg8WeLd9QE/QCAqGkFRqhRTe+yq7DR
         2NsSMEL3Vr83IbmjP89B7DWcab4FS12iMSE2/qKWbzebPQy2lIqfRzbQEUVxv1HV0//K
         auM5oR2PlgapupWhofCvjI1JGsL4+Wbz5hudybZRbVVwsJVWzeJnBUZL9+KtrcjgOqNW
         VegTCM1xe9a1puoG/hFgHXM95WwxwPYNR97weVM4HLbHji5UKdHS1Np2ttgvUrFVYmlv
         M/Pbo1klAcPUhRyYllgUY+hvzZwa4AwBx6W33oeKvGSaif9myF/d507qCO474kVwn+8c
         kcvg==
X-Forwarded-Encrypted: i=1; AJvYcCUp3tKv7yQN3eekxR1DWyvziOwHO4tgoDVeN9ueBhLWDctCOUzX/uEGD3dQgTazC9+32SS/8XbLvcXmdl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKs7bUi2zgtQ5eRuxgXDHC/O6OAyOkl8OS7jHnsH8xQBfArVLD
	+XDvbVO1SMYcccaOCtCM6bCJWtdMqrCDfRh66/7f2LZTPwB4VZgS+43DFERGsUAsnlVbGD0qM+D
	pkzyu95BFRQ==
X-Google-Smtp-Source: AGHT+IHfxqv166X4AUPtM/17tlCxKQ3yjpMASPUTxGYK8qeTy43As53cuJcW6JVnrubxiY9FmqCIlEi281mW
X-Received: from pjblt3.prod.google.com ([2002:a17:90b:3543:b0:33b:51fe:1a7e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0b:b0:2ee:e2ea:7a23
 with SMTP id adf61e73a8af0-32da85103f1mr10724900637.46.1760016558758; Thu, 09
 Oct 2025 06:29:18 -0700 (PDT)
Date: Thu,  9 Oct 2025 06:29:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251009132912.141116-1-irogers@google.com>
Subject: [PATCH v3] perf bpf_counter: Fix opening of "any"(-1) CPU events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The bperf BPF counter code doesn't handle "any"(-1) CPU events, always
wanting to aggregate a count against a CPU, which avoids the need for
atomics so let's not change that. Force evsels used for BPF counters
to require a CPU when not in system-wide mode so that the "any"(-1)
value isn't used during map propagation and evsel's CPU map matches
that of the PMU.

Fixes: b91917c0c6fa ("perf bpf_counter: Fix handling of cpumap fixing hybrid")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 13 +++++++++++++
 tools/perf/util/bpf_counter.c |  7 ++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7006f848f87a..f1c9d6c94fc5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2540,6 +2540,7 @@ int cmd_stat(int argc, const char **argv)
 	unsigned int interval, timeout;
 	const char * const stat_subcommands[] = { "record", "report" };
 	char errbuf[BUFSIZ];
+	struct evsel *counter;
 
 	setlocale(LC_ALL, "");
 
@@ -2797,6 +2798,18 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
 
+	evlist__for_each_entry(evsel_list, counter) {
+		/*
+		 * Setup BPF counters to require CPUs as any(-1) isn't
+		 * supported. evlist__create_maps below will propagate this
+		 * information to the evsels. Note, evsel__is_bperf isn't yet
+		 * set up, and this change must happen early, so directly use
+		 * the bpf_counter variable and target information.
+		 */
+		if ((counter->bpf_counter || target.use_bpf) && !target__has_cpu(&target))
+			counter->core.requires_cpu = true;
+	}
+
 	if (evlist__create_maps(evsel_list, &target) < 0) {
 		if (target__has_task(&target)) {
 			pr_err("Problems finding threads of monitor\n");
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index ca5d01b9017d..a5882b582205 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -460,6 +460,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	struct bperf_leader_bpf *skel = bperf_leader_bpf__open();
 	int link_fd, diff_map_fd, err;
 	struct bpf_link *link = NULL;
+	struct perf_thread_map *threads;
 
 	if (!skel) {
 		pr_err("Failed to open leader skeleton\n");
@@ -495,7 +496,11 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	 * following evsel__open_per_cpu call
 	 */
 	evsel->leader_skel = skel;
-	evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
+	assert(!perf_cpu_map__has_any_cpu_or_is_empty(evsel->core.cpus));
+	/* Always open system wide. */
+	threads = thread_map__new_by_tid(-1);
+	evsel__open(evsel, evsel->core.cpus, threads);
+	perf_thread_map__put(threads);
 
 out:
 	bperf_leader_bpf__destroy(skel);
-- 
2.51.0.710.ga91ca5db03-goog


