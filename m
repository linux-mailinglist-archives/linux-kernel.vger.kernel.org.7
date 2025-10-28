Return-Path: <linux-kernel+bounces-874117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFFAC1590D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86DDF505073
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22429343D91;
	Tue, 28 Oct 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ayq5EY2V"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5F22367B0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665917; cv=none; b=AaurAHsBbiIhLf+UWaC24GSi4rDAhQgY1T7xeShwIV1lKH0sioqHGSLc1EkmrgiLvK/D0ubQQng/FS5io3B+y9pEMDft9A9e0GZQAjECdWcUVEJlM+jXhhvaOH+ZH9ERNQbzHjaBEJzYbsHIaXD/XQ68yqoqoNNHTDVoGe/8Xm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665917; c=relaxed/simple;
	bh=8aJ7RCMolVhgm0esdxXTYhaHsDH2PgxB0ZdrzK0aDH0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=kH7p2pVLXnHObjdy+nDnLGlSE5FM7hG/8Wd3fM0pnArtDgqtR2fowXD1h0ZtagpJdYcacporZujp5t8D/CBDZJMIbDOhrXcQ6zJwJ7v6oPTUXAIYdqRo1ske38n37ehpXwxRc+fCjTO8Grf7fXph7qo3FOfElJdAWHl1xnjk7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ayq5EY2V; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2930e2e8e7fso50319095ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761665915; x=1762270715; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j3RgjPX6qcL4gH8q8/DJ2NiBHunt2U+fGlLP8/lcz+4=;
        b=ayq5EY2VyIcKGdjsqQOlv1lgCQBcbbJ0xeagX/FPkEQk982EvVedHOKl1ipimh9EMv
         86E1qh2F7lbO82xcM4k464T6+QXiuk+GjPdJmbXHPcxVpPsEiJgOuGLJitE0nrlu5GTa
         5CZA1HkSfhN30QtBKb7ilxrFEEv+VNJkhR8YonTuBBG/B8ithcc94SI3YRnQkZ2fLJMY
         7AuUAhO8yV/t3odJ8fV7sz6+wkU5u0XuziKJeQSW3bjv50a2ez1W9uRktA3P8BztWqHH
         14zDY1CV5EY0uirEJRXq3awfjlNJ+A57YTgDecxvsav9ifkEvE/tFzVVXXsp2rN6tOma
         SkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665915; x=1762270715;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j3RgjPX6qcL4gH8q8/DJ2NiBHunt2U+fGlLP8/lcz+4=;
        b=lfOHT/hd3dyabQUfL6uwYMPQ8LObEZLspyU2VrdnSoB91EJt+gSu/aTdXSpevDMBWv
         q2JEiMRegqU2Zp4r+yxqpL2D74VpZmJAae/blfzSqU4SuyUpWCyIYuOTQnZm+8s1+IwW
         3nsCr5zfB6rkyFj1KZBkMF67pA2xBaNk1oCQ1LUlRVfelASHah0SUvqQ6VfVEugNQsFD
         pJZcK23AknkFml7eu/ucC47UCPloSSagH9VcEwlNliFbB2Y77mF8BZHjUy6ih06zp4Ss
         vurmagwNygrIF2GozotzpdfBr+gAdijHotUK3VjwaL5TvV4JQLUPM1Y4qT/MB+jR563t
         LMug==
X-Forwarded-Encrypted: i=1; AJvYcCX6HMiAueiFRJ8aAXzRPSBKF3Eyl+0QsSz6mtex/qygvbj8iAWknbBPgSdp1KpnXn1OPIFpq0ntddYqYz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm3QGcHP+W6bKXq5Xc2rQs1ynU6i6pP5TWas3hkol0eF9epfn5
	5lfmLA2mo1kjvuE44bLf7S0AiYxclKC5C8NX4VIklmhQOkzwRnVorS2ff4/seg3u3PI69dKjCJG
	euS4ScHL+XQ==
X-Google-Smtp-Source: AGHT+IH6vp7LNz1krWqBJUvMVVa+KG04FBPh9OwGZAOJAtiIT6D1L6yZGR5noKXy9oz35N/XrcI/30PCe8BF
X-Received: from plsu9.prod.google.com ([2002:a17:902:bf49:b0:290:d4c5:90ad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c2:b0:28e:7841:d437
 with SMTP id d9443c01a7336-294cb51090amr43843535ad.38.1761665915319; Tue, 28
 Oct 2025 08:38:35 -0700 (PDT)
Date: Tue, 28 Oct 2025 08:38:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028153821.4003666-1-irogers@google.com>
Subject: [PATCH v2] perf test workload: Add thread count argument to thloop
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow the number of threads for the thloop workload to be increased
beyond the normal 2. Add error checking to the parsed time and thread
count values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Perform the pthread_join unconditionally and ensure started
    threads terminate.
---
 tools/perf/tests/workloads/thloop.c | 45 ++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
index 457b29f91c3e..bd8168f883fb 100644
--- a/tools/perf/tests/workloads/thloop.c
+++ b/tools/perf/tests/workloads/thloop.c
@@ -31,21 +31,52 @@ static void *thfunc(void *arg)
 
 static int thloop(int argc, const char **argv)
 {
-	int sec = 1;
-	pthread_t th;
+	int nt = 2, sec = 1, err = 1;
+	pthread_t *thread_list = NULL;
 
 	if (argc > 0)
 		sec = atoi(argv[0]);
 
+	if (sec <= 0) {
+		fprintf(stderr, "Error: seconds (%d) must be >= 1\n", sec);
+		return 1;
+	}
+
+	if (argc > 1)
+		nt = atoi(argv[1]);
+
+	if (nt <= 0) {
+		fprintf(stderr, "Error: thread count (%d) must be >= 1\n", nt);
+		return 1;
+	}
+
 	signal(SIGINT, sighandler);
 	signal(SIGALRM, sighandler);
-	alarm(sec);
 
-	pthread_create(&th, NULL, thfunc, test_loop);
-	test_loop();
-	pthread_join(th, NULL);
+	thread_list = calloc(nt, sizeof(pthread_t));
+	if (thread_list == NULL) {
+		fprintf(stderr, "Error: malloc failed for %d threads\n", nt);
+		goto out;
+	}
+	for (int i = 1; i < nt; i++) {
+		int ret = pthread_create(&thread_list[i], NULL, thfunc, test_loop);
 
-	return 0;
+		if (ret) {
+			fprintf(stderr, "Error: failed to create thread %d\n", i);
+			done = 1; // Ensure started threads terminate.
+			goto out;
+		}
+	}
+	alarm(sec);
+	test_loop();
+	err = 0;
+out:
+	for (int i = 1; i < nt; i++) {
+		if (thread_list && thread_list[i])
+			pthread_join(thread_list[i], /*retval=*/NULL);
+	}
+	free(thread_list);
+	return err;
 }
 
 DEFINE_WORKLOAD(thloop);
-- 
2.51.1.851.g4ebd6896fd-goog


