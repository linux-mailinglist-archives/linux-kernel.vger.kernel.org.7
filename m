Return-Path: <linux-kernel+bounces-591829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EC0A7E57C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 18:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC7F47A1FAE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10E2080D5;
	Mon,  7 Apr 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rXOeo5DL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HqDvZPJY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC820767E;
	Mon,  7 Apr 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041481; cv=none; b=OgMPjrckm4kczwFMb+jIoViswFr3EN0vm+BBA9LtXvL7eTBbiMw0xCYcqkqE0OhKZ8+CcYYoXSUh3JH7VS6WYEr7ROknpB+q5iCT9CO2ORaA5Ix5hjrBs99k3bcYdjhV8aQYCDGU6dfymNH6g/fa1+FXLTMzJjjmfGKdUtT0dro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041481; c=relaxed/simple;
	bh=mWGLharooGo32OIQNO3rDXASVaGUyz/0z+zu69VsSrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxqOFsfTLbv7FVz7Ek49L5LK4+JTT1vqErW5LYiTQ8I1p/P7HNJiHqaTEQf7wX2XyyYgYXIs/yGFdDG7nFOiWgMhSSsdYW0t1r04CafTRzpPraxRI5ZRndu8V+2KhMYh6pGGFLBsjRQRzYkXnPlzcXnIq56y6yvNE0RPmvcRK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rXOeo5DL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HqDvZPJY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744041474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBMYbwXiMOU2UymY/zoloIR1I7IP4crxFi/K0K2eyvU=;
	b=rXOeo5DLZUN7tzVyJ2xh137BAj9gTnZ2uI+NVLXwFUBGpkLF79uMfRK9MivOPfKp1VQCu/
	TfKAzqYIxn/GGM1/BLGTL+Mxd8+xrKMnPFtXu6Fw/vUa2WySucG/IsC3F4mC7GsfiNCfxJ
	uPKgyghZzZhDjT/jH6BDbZZgqCzvy2BYnszwTbN/suMANPCWXMp4uHbqBn9ZoiJrNtQPkh
	hfPa/2e7SAwp70qBeq/G9ZaiPcqX7BKG8wOSn5vnVGZgPKNS/fPxDh+k3J6fGhUigYhkIS
	txWOW5bv2DJA9vvzVUOUIzeeytW1+fXRzFHIRHJeIBiZvB+ex5IhwIgCLF43tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744041474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBMYbwXiMOU2UymY/zoloIR1I7IP4crxFi/K0K2eyvU=;
	b=HqDvZPJYs0DGBJo+a9RrmCfcdDsS86utD46Me3EXamrXvJZ/3uyZHFSu4FvritgmhKLtZ6
	9gXZanQxpEqvwCBg==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v11 18/19] tools/perf: Allow to select the number of hash buckets.
Date: Mon,  7 Apr 2025 17:57:41 +0200
Message-ID: <20250407155742.968816-19-bigeasy@linutronix.de>
In-Reply-To: <20250407155742.968816-1-bigeasy@linutronix.de>
References: <20250407155742.968816-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the -b/ --buckets argument to specify the number of hash buckets for
the private futex hash. This is directly passed to
    prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS)

and must return without an error if specified. The size of the private
hash is verified with PR_FUTEX_HASH_GET_SLOTS.
If the PR_FUTEX_HASH_GET_SLOTS failed then it is assumed that an older
kernel was used without the support and that the global hash is used.

Cc: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/perf/bench/Build                 |  1 +
 tools/perf/bench/futex-hash.c          |  6 +++
 tools/perf/bench/futex-lock-pi.c       |  4 ++
 tools/perf/bench/futex-requeue.c       |  5 +++
 tools/perf/bench/futex-wake-parallel.c |  8 +++-
 tools/perf/bench/futex-wake.c          |  3 ++
 tools/perf/bench/futex.c               | 58 ++++++++++++++++++++++++++
 tools/perf/bench/futex.h               |  4 ++
 8 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/bench/futex.c

diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index 279ab2ab4abe4..b558ab98719f9 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -3,6 +3,7 @@ perf-bench-y +=3D sched-pipe.o
 perf-bench-y +=3D sched-seccomp-notify.o
 perf-bench-y +=3D syscall.o
 perf-bench-y +=3D mem-functions.o
+perf-bench-y +=3D futex.o
 perf-bench-y +=3D futex-hash.o
 perf-bench-y +=3D futex-wake.o
 perf-bench-y +=3D futex-wake-parallel.o
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index b472eded521b1..c843bd8543c74 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -18,9 +18,11 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/prctl.h>
 #include <linux/zalloc.h>
 #include <sys/time.h>
 #include <sys/mman.h>
+#include <sys/prctl.h>
 #include <perf/cpumap.h>
=20
 #include "../util/mutex.h"
@@ -50,9 +52,11 @@ struct worker {
 static struct bench_futex_parameters params =3D {
 	.nfutexes =3D 1024,
 	.runtime  =3D 10,
+	.nbuckets =3D -1,
 };
=20
 static const struct option options[] =3D {
+	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads=
"),
 	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in second=
s)"),
 	OPT_UINTEGER('f', "futexes", &params.nfutexes, "Specify amount of futexes=
 per threads"),
@@ -118,6 +122,7 @@ static void print_summary(void)
 	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs =3D %d\n",
 	       !params.silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
 	       (int)bench__runtime.tv_sec);
+	futex_print_nbuckets(&params);
 }
=20
 int bench_futex_hash(int argc, const char **argv)
@@ -161,6 +166,7 @@ int bench_futex_hash(int argc, const char **argv)
=20
 	if (!params.fshared)
 		futex_flag =3D FUTEX_PRIVATE_FLAG;
+	futex_set_nbuckets_param(&params);
=20
 	printf("Run summary [PID %d]: %d threads, each operating on %d [%s] futex=
es for %d secs.\n\n",
 	       getpid(), params.nthreads, params.nfutexes, params.fshared ? "shar=
ed":"private", params.runtime);
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock=
-pi.c
index 0416120c091b2..40640b6744279 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -41,10 +41,12 @@ static struct stats throughput_stats;
 static struct cond thread_parent, thread_worker;
=20
 static struct bench_futex_parameters params =3D {
+	.nbuckets =3D -1,
 	.runtime  =3D 10,
 };
=20
 static const struct option options[] =3D {
+	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads=
"),
 	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in second=
s)"),
 	OPT_BOOLEAN( 'M', "multi",   &params.multi, "Use multiple futexes"),
@@ -67,6 +69,7 @@ static void print_summary(void)
 	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs =3D %d\n",
 	       !params.silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
 	       (int)bench__runtime.tv_sec);
+	futex_print_nbuckets(&params);
 }
=20
 static void toggle_done(int sig __maybe_unused,
@@ -203,6 +206,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	mutex_init(&thread_lock);
 	cond_init(&thread_parent);
 	cond_init(&thread_worker);
+	futex_set_nbuckets_param(&params);
=20
 	threads_starting =3D params.nthreads;
 	gettimeofday(&bench__start, NULL);
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requ=
eue.c
index aad5bfc4fe188..0748b0fd689e8 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -42,6 +42,7 @@ static unsigned int threads_starting;
 static int futex_flag =3D 0;
=20
 static struct bench_futex_parameters params =3D {
+	.nbuckets =3D -1,
 	/*
 	 * How many tasks to requeue at a time.
 	 * Default to 1 in order to make the kernel work more.
@@ -50,6 +51,7 @@ static struct bench_futex_parameters params =3D {
 };
=20
 static const struct option options[] =3D {
+	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
 	OPT_UINTEGER('t', "threads",  &params.nthreads, "Specify amount of thread=
s"),
 	OPT_UINTEGER('q', "nrequeue", &params.nrequeue, "Specify amount of thread=
s to requeue at once"),
 	OPT_BOOLEAN( 's', "silent",   &params.silent, "Silent mode: do not displa=
y data/details"),
@@ -77,6 +79,7 @@ static void print_summary(void)
 	       params.nthreads,
 	       requeuetime_avg / USEC_PER_MSEC,
 	       rel_stddev_stats(requeuetime_stddev, requeuetime_avg));
+	futex_print_nbuckets(&params);
 }
=20
 static void *workerfn(void *arg __maybe_unused)
@@ -204,6 +207,8 @@ int bench_futex_requeue(int argc, const char **argv)
 	if (params.broadcast)
 		params.nrequeue =3D params.nthreads;
=20
+	futex_set_nbuckets_param(&params);
+
 	printf("Run summary [PID %d]: Requeuing %d threads (from [%s] %p to %s%p)=
, "
 	       "%d at a time.\n\n",  getpid(), params.nthreads,
 	       params.fshared ? "shared":"private", &futex1,
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/fute=
x-wake-parallel.c
index 4352e318631e9..6aede7c46b337 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -57,9 +57,12 @@ static struct stats waketime_stats, wakeup_stats;
 static unsigned int threads_starting;
 static int futex_flag =3D 0;
=20
-static struct bench_futex_parameters params;
+static struct bench_futex_parameters params =3D {
+	.nbuckets =3D -1,
+};
=20
 static const struct option options[] =3D {
+	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads=
"),
 	OPT_UINTEGER('w', "nwakers", &params.nwakes, "Specify amount of waking th=
reads"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display=
 data/details"),
@@ -218,6 +221,7 @@ static void print_summary(void)
 	       params.nthreads,
 	       waketime_avg / USEC_PER_MSEC,
 	       rel_stddev_stats(waketime_stddev, waketime_avg));
+	futex_print_nbuckets(&params);
 }
=20
=20
@@ -291,6 +295,8 @@ int bench_futex_wake_parallel(int argc, const char **ar=
gv)
 	if (!params.fshared)
 		futex_flag =3D FUTEX_PRIVATE_FLAG;
=20
+	futex_set_nbuckets_param(&params);
+
 	printf("Run summary [PID %d]: blocking on %d threads (at [%s] "
 	       "futex %p), %d threads waking up %d at a time.\n\n",
 	       getpid(), params.nthreads, params.fshared ? "shared":"private",
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 49b3c89b0b35d..a31fc1563862e 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -42,6 +42,7 @@ static unsigned int threads_starting;
 static int futex_flag =3D 0;
=20
 static struct bench_futex_parameters params =3D {
+	.nbuckets =3D -1,
 	/*
 	 * How many wakeups to do at a time.
 	 * Default to 1 in order to make the kernel work more.
@@ -50,6 +51,7 @@ static struct bench_futex_parameters params =3D {
 };
=20
 static const struct option options[] =3D {
+	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash bu=
ckets"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads=
"),
 	OPT_UINTEGER('w', "nwakes",  &params.nwakes, "Specify amount of threads t=
o wake at once"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display=
 data/details"),
@@ -93,6 +95,7 @@ static void print_summary(void)
 	       params.nthreads,
 	       waketime_avg / USEC_PER_MSEC,
 	       rel_stddev_stats(waketime_stddev, waketime_avg));
+	futex_print_nbuckets(&params);
 }
=20
 static void block_threads(pthread_t *w, struct perf_cpu_map *cpu)
diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
new file mode 100644
index 0000000000000..8109d6bf3ede2
--- /dev/null
+++ b/tools/perf/bench/futex.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <err.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/prctl.h>
+#include <sys/prctl.h>
+
+#include "futex.h"
+
+void futex_set_nbuckets_param(struct bench_futex_parameters *params)
+{
+	int ret;
+
+	if (params->nbuckets < 0)
+		return;
+
+	ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets);
+	if (ret) {
+		printf("Requesting %d hash buckets failed: %d/%m\n",
+		       params->nbuckets, ret);
+		err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
+	}
+}
+
+void futex_print_nbuckets(struct bench_futex_parameters *params)
+{
+	char *futex_hash_mode;
+	int ret;
+
+	ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);
+	if (params->nbuckets >=3D 0) {
+		if (ret !=3D params->nbuckets) {
+			if (ret < 0) {
+				printf("Can't query number of buckets: %d/%m\n", ret);
+				err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
+			}
+			printf("Requested number of hash buckets does not currently used.\n");
+			printf("Requested: %d in usage: %d\n", params->nbuckets, ret);
+			err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
+		}
+		if (params->nbuckets =3D=3D 0)
+			ret =3D asprintf(&futex_hash_mode, "Futex hashing: global hash");
+		else
+			ret =3D asprintf(&futex_hash_mode, "Futex hashing: %d hash buckets",
+				       params->nbuckets);
+	} else {
+		if (ret <=3D 0) {
+			ret =3D asprintf(&futex_hash_mode, "Futex hashing: global hash");
+		} else {
+			ret =3D asprintf(&futex_hash_mode, "Futex hashing: auto resized to %d b=
uckets",
+				       ret);
+		}
+	}
+	if (ret < 0)
+		err(EXIT_FAILURE, "ENOMEM, futex_hash_mode");
+	printf("%s\n", futex_hash_mode);
+	free(futex_hash_mode);
+}
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index ebdc2b032afc1..dd295d27044ac 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -25,6 +25,7 @@ struct bench_futex_parameters {
 	unsigned int nfutexes;
 	unsigned int nwakes;
 	unsigned int nrequeue;
+	int nbuckets;
 };
=20
 /**
@@ -143,4 +144,7 @@ futex_cmp_requeue_pi(u_int32_t *uaddr, u_int32_t val, u=
_int32_t *uaddr2,
 					val, opflags);
 }
=20
+void futex_set_nbuckets_param(struct bench_futex_parameters *params);
+void futex_print_nbuckets(struct bench_futex_parameters *params);
+
 #endif /* _FUTEX_H */
--=20
2.49.0


