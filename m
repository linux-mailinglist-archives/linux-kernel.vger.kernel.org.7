Return-Path: <linux-kernel+bounces-872513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FF5C115A6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F791A27421
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14777328607;
	Mon, 27 Oct 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="csqLXZwG"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C8326D6E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596052; cv=none; b=QSEuBGYbQSgpXNHKiA2cSZ+UgBVaHlIBMGlM5GOYVM6souS+fgsah+4tjKEJWWl5yZqPel02Dg2dTo3lUjH2jQ5U7c2X6h2pXDCaanNBFTlC6eqevovNMSz3tABDqRrk0B3FPsOK3U1HoqA3Bc4Ne1i4FzCjE9mTi5SJF1u+IoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596052; c=relaxed/simple;
	bh=mAN/Rswpb/UtOyKD+TS4Ra6NqcklqGSOtWim+CasLtM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=rphwDtKMmbAumK5Qjnpq+mmO0s3pi8FK3kE8piIUmAVkQqTavBxw0DrWjUANEgq6z2wN750ilI3LSx5vsHKZrNAVyahTmg95LlRIeoxf1Ys6eMkExoAxZ5DSDahW0md2QuPsUrePte4zSXAvec0RIU0XBgHKE9Yir2wX0Ey48to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=csqLXZwG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290da17197eso82313075ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761596050; x=1762200850; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m/myEBpRozesu2w234EynG8m+Hnsu/W8ut8v1znhGoM=;
        b=csqLXZwGWJj0bkJMlxv9toiooGrnOqrtw9TVltaNpsyq8l6HJHGzKyVyTSucOjOyRs
         30qUfnMrT44Gh4Q2vz7wo7J9fwuUmRnCvRPWtr8emP1hMSL06y/VVcQHzwxvlo1UrnY6
         0t9wbvkUWwyiqZNWWwVLI7K8JRDLaDUGNrCUBBqcLGKlZVt10bLm3PNEOXXrqQkbOPSO
         4jziE8JSmM70r3IctFDe3dxqCf2ZXEBQlCvbOmOLhWv6MhQ5avDvbI+Gdf875K7xS9xs
         m885b9GjxQPp6M84XZyAIAnimM20I9PzXWD3kGAWEipCD35E/loHo2xGO+UzYOIvFfs9
         lTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761596050; x=1762200850;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/myEBpRozesu2w234EynG8m+Hnsu/W8ut8v1znhGoM=;
        b=tBBUfqSrL0XTFxnDwKBNVpq5r849ckKV9a8Qgfm3w1B/ZWVPH4urK+zIkp16ar0ccA
         JYW1BSRVphM1X1iOMUnZ/DabdhjwOkhxytmaok6eKMGWDnEiT1Y0cMNjvVNWjMlOtG/Q
         bTNgeFF9pq1dLIHQ9/B3Mh0fZWyvihkKIsoevCFQVZF2NjS40nc4nXsI8H/PEWCKcsCU
         HHt6RuXFOc5obNERgZdEbblJTWzmk6srHL4iKzzyXeZwxahBWTu/VK0Zh+x+SqcnUXJx
         dRQdsDNgxgXIEt33CrcCHaUB5Y1dIBYnj3DrnqYT4vMDEZjUv7zYlAqbO9L/xDxIQtXP
         cQdA==
X-Forwarded-Encrypted: i=1; AJvYcCUJwNLA5THtHQbgZRzuXzp/xzzqJffbI7oxZrpy8qqI99bWQlv4378wI7bNSidrjB1VaMagE9rd9kas6XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBsSPIedZqoT2jX9yHEMO0X+JSiqElHixHeQgee7tHRGC55PG
	5r2yj4aMmaIrKe0h/1YU8a6B7JY1a9Eik89UN+liek1w/m72MeBMTu8+sCmA+/jD8+StVL1ktF3
	Xh0WSJWCHTQ==
X-Google-Smtp-Source: AGHT+IEEr+QxbR9iWTtqW0oEL6qFys/t6qykydk9CS7D0GsjSL3QfQJOzOQ9bLGpboYgL5UUjHBx7HFlKx83
X-Received: from pjrv13.prod.google.com ([2002:a17:90a:bb8d:b0:33b:51fe:1a81])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea0c:b0:269:91b2:e9d6
 with SMTP id d9443c01a7336-294cb5196eamr13665815ad.46.1761596050012; Mon, 27
 Oct 2025 13:14:10 -0700 (PDT)
Date: Mon, 27 Oct 2025 13:14:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251027201405.3715599-1-irogers@google.com>
Subject: [PATCH v1] perf test workload: Add thread count argument to thloop
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
 tools/perf/tests/workloads/thloop.c | 41 ++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
index 457b29f91c3e..dbb88bcf49e0 100644
--- a/tools/perf/tests/workloads/thloop.c
+++ b/tools/perf/tests/workloads/thloop.c
@@ -31,21 +31,50 @@ static void *thfunc(void *arg)
 
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
+	thread_list = calloc(nt, sizeof(pthread_t));
+	if (thread_list == NULL) {
+		fprintf(stderr, "Error: malloc failed for %d threads\n", nt);
+		goto out;
+	}
+	for (int i = 1; i < nt; i++) {
+		int ret = pthread_create(&thread_list[i], NULL, thfunc, test_loop);
+
+		if (ret) {
+			fprintf(stderr, "Error: failed to create thread %d\n", i);
+			goto out;
+		}
+	}
+	alarm(sec);
 	test_loop();
-	pthread_join(th, NULL);
+	for (int i = 1; i < nt; i++)
+		pthread_join(thread_list[i], /*retval=*/NULL);
 
-	return 0;
+	err = 0;
+out:
+	free(thread_list);
+	return err;
 }
 
 DEFINE_WORKLOAD(thloop);
-- 
2.51.1.851.g4ebd6896fd-goog


