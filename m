Return-Path: <linux-kernel+bounces-748810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3124B1462A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1983F542992
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7E2202F79;
	Tue, 29 Jul 2025 02:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WReMhAPy"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ACE220F20
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756019; cv=none; b=Isqy2CoXAw2d/j9LI4xhdaYS4ZHkimwLX01bS2/yJAWCu4GnVUQmQWLquOc2cdqw48IbIUVP9enAJf0V5SoKAQ5IvX8RILwQxl2JxqrsQUVv0a/df9+NoFPhw+SKNRPY+k2yWBUgTwRGmsIthFFNckB+uVvV/+Tpk09yH9+qGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756019; c=relaxed/simple;
	bh=78XwSvfsUo5qjFzpcoZ2YE5qIEQTQanZ2gjLZQMR2U4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QDroAM+ixLl0dVPnpDCbfQwP/56irc/Nu9JNmKpo6P6eiFiDYXtXswOyWzdj3ntErsT6ovAKeUXDV/7aWu0Y9hkxxPt7I6sTMkEyZ1V7Y390Z+NM8kirBrpGsd98givyrWHvOL0uV9ehtDbZwjkoNcvpha3GNq83QS/Vc86yRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WReMhAPy; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-75e28bcec3bso8113041b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753756017; x=1754360817; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpJZQW2XhZpV9woIMXPe23IdtVvXCXsSMOWR9kV9OUE=;
        b=WReMhAPyKngyzGyRBpodM2hg4ltB+BKpDYYCyPo9/W66DPi539LagpZ4OU15ZH0N81
         hqu+6b/GXf/c8d+7xCq+xYV7XEHxPkvdUvZHHB58Ua1PGC5/s1YGro0KVvunPfenY21H
         yPcw3mA3P4g5cfgbZH0T85XfwPBPaYx9ybV7MBMpL1sD7DkJKfWKl2BBnG5XSGW8B2DC
         yBkwSL2AVi9iLCfWjBhzos6j/Oigkw7AFcqZmV5rDK0N12Jz/pXlYSxrlG8jWFvDdHpv
         bHKTnNfqixNRP14+Ftrc7CrVvYMHn1Ust7wSWIwXo0boERAwURlABFPXGaUa9eJMFMy3
         ncLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756017; x=1754360817;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpJZQW2XhZpV9woIMXPe23IdtVvXCXsSMOWR9kV9OUE=;
        b=nmLG6Ahrc7SbW+7KE/tj5trSo/6QoSOseyKI1Wrb+AOljc+jcIJreWM4opeOIKH9L+
         sX8eIDc08SR+LyIyUNWs+jMQAn9BaMeAzp8dc482yaALLui7IFQW0gQgtCQdYRef2TQc
         wEO4KzC5Yrdxqysy+/qFEPOJr49tY1Qb9EG6Gyzp/RtCuvbkLI2Kx0V6mELz5X1o7NEh
         W14b2OO8qLlJWUC7nXxeAwL9+6XDqP45efbcWdHuspEXCrNV91MC+5RbZzZPHc8ubOaR
         8rSB5oZvRCFcufwxOFVyUgiiVRtW6uAp69evVxfwTMjGpyovTxXlNgexf8xkUQENGeSf
         92LA==
X-Forwarded-Encrypted: i=1; AJvYcCVoa94O5pkoexPsG14L1HA9LZd9YKlCB6dUuRcdOVWFxcnF3wOjKFOMLEiSUHrwMiEMPFAz58EVEFDaRdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5v63CU8EW8zCBkbv99H19jlRbOYuoMCdJ9GmuAp0ShXtYZBpX
	oDlegn7IG4AXizVRNAkD9uLyhH4SuVNRjc0ECGffZRaWscfdttaZKNnwEHEE7nXbPaEgPHXjENK
	LMqaCMw==
X-Google-Smtp-Source: AGHT+IF3BgulVEdztgtpO3hFWLE1HkY5w4Qq15DrebDHOcpen7DayFyYTAX+bxT3j4xX+6CCPymj3m5uGog=
X-Received: from pfoo28.prod.google.com ([2002:a05:6a00:1a1c:b0:748:f16c:14c5])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10cb:b0:748:f750:14c6
 with SMTP id d2e1a72fcca58-76336f1bcb7mr20458767b3a.14.1753756016683; Mon, 28
 Jul 2025 19:26:56 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:26:40 -0700
In-Reply-To: <20250729022640.3134066-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729022640.3134066-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729022640.3134066-8-yuzhuo@google.com>
Subject: [PATCH v1 7/7] perf bench sync: Add latency histogram functionality
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, 
	Yuzhuo Jing <yuzhuo@google.com>, Andrea Parri <parri.andrea@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Barret Rhoden <brho@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add an option to print the histogram of lock acquire latencies (unit in
TSCs).

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/perf/bench/sync.c | 97 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/tools/perf/bench/sync.c b/tools/perf/bench/sync.c
index 2685cb66584c..c85e9853c72a 100644
--- a/tools/perf/bench/sync.c
+++ b/tools/perf/bench/sync.c
@@ -15,14 +15,19 @@
 #include <sys/cdefs.h>
 
 #include "bench.h"
+#include "../util/tsc.h"
 
 #include "include/qspinlock.h"
 
 #define NS 1000000000ull
 #define CACHELINE_SIZE 64
 
+#define DEFAULT_HIST_INTERVAL 1000
+
 static unsigned int nthreads;
 static unsigned long nspins = 10000ul;
+static bool do_hist;
+static u64 hist_interval = DEFAULT_HIST_INTERVAL;
 
 struct barrier_t;
 
@@ -45,6 +50,7 @@ struct worker {
 	struct lock_ops *ops;
 	struct barrier_t *barrier;
 	u64 runtime;		// in nanoseconds
+	u64 *lock_latency;	// in TSCs
 };
 
 static const struct option options[] = {
@@ -52,6 +58,10 @@ static const struct option options[] = {
 		"Specify number of threads (default: number of CPUs)."),
 	OPT_ULONG('n',		"spins",	&nspins,
 		"Number of lock acquire operations per thread (default: 10,000 times)."),
+	OPT_BOOLEAN(0,		"hist",		&do_hist,
+		"Print a histogram of lock acquire TSCs."),
+	OPT_U64(0,	"hist-interval",	&hist_interval,
+		"Histogram bucket size (default 1,000 TSCs)."),
 	OPT_END()
 };
 
@@ -109,6 +119,25 @@ static void lock_loop(const struct lock_ops *ops, unsigned long n)
 	}
 }
 
+/*
+ * A busy loop to acquire and release the given lock N times, and also collect
+ * all acquire latencies, for histogram use.  Note that the TSC operations
+ * latency itself is also included.
+ */
+static void lock_loop_timing(const struct lock_ops *ops, unsigned long n, u64 *sample_buffer)
+{
+	unsigned long i;
+	u64 t1, t2;
+
+	for (i = 0; i < n; ++i) {
+		t1 = rdtsc();
+		ops->lock(ops->data);
+		t2 = rdtsc();
+		ops->unlock(ops->data);
+		sample_buffer[i] = t2 - t1;
+	}
+}
+
 /*
  * Thread worker function.  Runs lock loop for N/5 times before and after
  * the main timed loop.
@@ -127,7 +156,10 @@ static void *sync_workerfn(void *args)
 	lock_loop(worker->ops, nspins / 5);
 
 	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &starttime);
-	lock_loop(worker->ops, nspins);
+	if (worker->lock_latency)
+		lock_loop_timing(worker->ops, nspins, worker->lock_latency);
+	else
+		lock_loop(worker->ops, nspins);
 	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &endtime);
 
 	/* Tail loop (not counted) to keep the above loop contended. */
@@ -139,6 +171,57 @@ static void *sync_workerfn(void *args)
 	return NULL;
 }
 
+/*
+ * Calculate and print a histogram.
+ */
+static void print_histogram(struct worker *workers)
+{
+	u64 tsc_max = 0;
+	u64 *buckets;
+	unsigned long nbuckets;
+
+	if (hist_interval == 0)
+		hist_interval = DEFAULT_HIST_INTERVAL;
+
+	printf("Lock acquire histogram:\n");
+
+	/* Calculate the max TSC value to get the number of buckets needed. */
+	for (unsigned int i = 0; i < nthreads; ++i) {
+		struct worker *w = workers + i;
+
+		for (unsigned long j = 0; j < nspins; ++j)
+			tsc_max = max(w->lock_latency[j], tsc_max);
+	}
+	nbuckets = (tsc_max + hist_interval - 1) / hist_interval;
+
+	/* Allocate the actual bucket.  The bucket definition may be optimized
+	 * if it is sparse.
+	 */
+	buckets = calloc(nbuckets, sizeof(*buckets));
+	if (!buckets)
+		err(EXIT_FAILURE, "calloc");
+
+	/* Iterate through all latencies again to fill the buckets. */
+	for (unsigned int i = 0; i < nthreads; ++i) {
+		struct worker *w = workers + i;
+
+		for (unsigned long j = 0; j < nspins; ++j) {
+			u64 latency = w->lock_latency[j];
+			++buckets[latency / hist_interval];
+		}
+	}
+
+	/* Print the histogram as a table. */
+	printf("Bucket, Count\n");
+	for (unsigned long i = 0; i < nbuckets; ++i) {
+		if (buckets[i] == 0)
+			continue;
+		printf("%"PRIu64", %"PRIu64"\n", hist_interval * (i + 1), buckets[i]);
+	}
+
+	free(buckets);
+}
+
 /*
  * Generic lock synchronization benchmark function.  Sets up threads and
  * thread affinities.
@@ -191,6 +274,12 @@ static int bench_sync_lock_generic(struct lock_ops *ops, int argc, const char **
 		workers[i].barrier = &barrier;
 		workers[i].ops = ops;
 
+		if (do_hist) {
+			workers[i].lock_latency = calloc(nspins, sizeof(*workers[i].lock_latency));
+			if (!workers[i].lock_latency)
+				err(EXIT_FAILURE, "calloc");
+		}
+
 		/* Set CPU affinity */
 		pthread_attr_init(&thread_attr);
 		CPU_ZERO_S(cpuset_size, cpuset);
@@ -228,6 +317,12 @@ static int bench_sync_lock_generic(struct lock_ops *ops, int argc, const char **
 	printf("Lock-unlock latency of %u threads: %"PRIu64".%"PRIu64" ns.\n",
 			nthreads, avg_ns, avg_ns_dot);
 
+	/* Print histogram if requested. */
+	if (do_hist)
+		print_histogram(workers);
+
+	for (unsigned int i = 0; i < nthreads; ++i)
+		free(workers[i].lock_latency);
 	free(workers);
 
 	return 0;
-- 
2.50.1.487.gc89ff58d15-goog


