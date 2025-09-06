Return-Path: <linux-kernel+bounces-804364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A360B473D4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AB01C238D5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460752405E7;
	Sat,  6 Sep 2025 16:12:29 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D72B1C5F10;
	Sat,  6 Sep 2025 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757175148; cv=none; b=Ugz6qql01v2HF52ZgNJ5JmMtZxreRhySJWXMk3XxdJyBd0yiWbLKsboCUeM+frCXxCxfzPbUacp/LInqBphY2ks2gytVm4B9UESBKtfgxrsRUg5tsUB4+GFzbh2PQN/RmnEDcANPI+QlDNup69jbViQ05oK/X1cjmBQMhcWdWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757175148; c=relaxed/simple;
	bh=LmI7AEFb+MJHqjsE5/o117SBbAvFLlBYg+pRzcMvKJU=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=cLrq4uc53Y6PvTdCKBoAon0eS5QCKuyBK9UXaV8njkPJsiKXZ+54m49bb+v2WTMc2AuxACy+DRamN0ik9sjxV0uy3HQMN+FSRNfRSDNdqmXewxJ0c+fnecWwCwGeUADbqUFLzU/ntvo6pJKTkR0aLrO4UEXKe4MlFHG4SETMhco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cJysX5B47z5PM38;
	Sun, 07 Sep 2025 00:12:16 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 586GC3oG010567;
	Sun, 7 Sep 2025 00:12:03 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 7 Sep 2025 00:12:05 +0800 (CST)
Date: Sun, 7 Sep 2025 00:12:05 +0800 (CST)
X-Zmail-TransId: 2afa68bc5d550ee-400f9
X-Mailer: Zmail v1.0
Message-ID: <20250907001205573L3XpsQMIQnLgDqiiKYd3H@zte.com.cn>
In-Reply-To: <20250907001101305vrTGnXaRNvtmsGkp-Ljk_@zte.com.cn>
References: 20250907001101305vrTGnXaRNvtmsGkp-Ljk_@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>, <corbet@lwn.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIdjIgbGludXgtbmV4dCAxLzVdIHRvb2xzL2RlbGF5dG9wOiBhZGQgZmxleGlibGUgc29ydGluZyBieSBkZWxheSBmaWVsZA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 586GC3oG010567
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Sun, 07 Sep 2025 00:12:16 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68BC5D60.001/4cJysX5B47z5PM38

From: Fan Yu <fan.yu9@zte.com.cn>

The delaytop tool only supported sorting by CPU delay, which limited
its usefulness when users needed to identify bottlenecks in other
subsystems. Users had no way to sort processes by IO, IRQ, or
other delay types to quickly pinpoint specific performance issues.

Add -s/--sort option to allow sorting by different delay types.
Users can now quickly identify bottlenecks in specific subsystems
by sorting processes by the relevant delay metric.

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
 tools/accounting/delaytop.c | 153 ++++++++++++++++++++++++++++--------
 1 file changed, 121 insertions(+), 32 deletions(-)

diff --git a/tools/accounting/delaytop.c b/tools/accounting/delaytop.c
index 9afb1ffc00ba..52718714496b 100644
--- a/tools/accounting/delaytop.c
+++ b/tools/accounting/delaytop.c
@@ -42,6 +42,7 @@
 #include <linux/genetlink.h>
 #include <linux/taskstats.h>
 #include <linux/cgroupstats.h>
+#include <stddef.h>

 #define PSI_CPU_SOME "/proc/pressure/cpu"
 #define PSI_CPU_FULL	"/proc/pressure/cpu"
@@ -61,6 +62,7 @@
 #define TASK_COMM_LEN	16
 #define MAX_MSG_SIZE	1024
 #define MAX_TASKS		1000
+#define MAX_BUF_LEN		256
 #define SET_TASK_STAT(task_count, field) tasks[task_count].field = stats.field
 #define BOOL_FPRINT(stream, fmt, ...) \
 ({ \
@@ -68,17 +70,11 @@
 	ret >= 0; \
 })
 #define PSI_LINE_FORMAT "%-12s %6.1f%%/%6.1f%%/%6.1f%%/%8llu(ms)\n"
-
-/* Program settings structure */
-struct config {
-	int delay;				/* Update interval in seconds */
-	int iterations;			/* Number of iterations, 0 == infinite */
-	int max_processes;		/* Maximum number of processes to show */
-	char sort_field;		/* Field to sort by */
-	int output_one_time;	/* Output once and exit */
-	int monitor_pid;		/* Monitor specific PID */
-	char *container_path;	/* Path to container cgroup */
-};
+#define SORT_FIELD(name) \
+	{#name, \
+	offsetof(struct task_info, name##_delay_total), \
+	offsetof(struct task_info, name##_count)}
+#define END_FIELD {NULL, 0, 0}

 /* PSI statistics structure */
 struct psi_stats {
@@ -130,6 +126,24 @@ struct container_stats {
 	int nr_io_wait;			/* Number of processes in IO wait */
 };

+/* Delay field structure */
+struct field_desc {
+	const char *name;	/* Field name for cmdline argument */
+	unsigned long total_offset; /* Offset of total delay in task_info */
+	unsigned long count_offset; /* Offset of count in task_info */
+};
+
+/* Program settings structure */
+struct config {
+	int delay;				/* Update interval in seconds */
+	int iterations;			/* Number of iterations, 0 == infinite */
+	int max_processes;		/* Maximum number of processes to show */
+	int output_one_time;	/* Output once and exit */
+	int monitor_pid;		/* Monitor specific PID */
+	char *container_path;	/* Path to container cgroup */
+	const struct field_desc *sort_field;	/* Current sort field */
+};
+
 /* Global variables */
 static struct config cfg;
 static struct psi_stats psi;
@@ -137,6 +151,17 @@ static struct task_info tasks[MAX_TASKS];
 static int task_count;
 static int running = 1;
 static struct container_stats container_stats;
+static const struct field_desc sort_fields[] = {
+	SORT_FIELD(cpu),
+	SORT_FIELD(blkio),
+	SORT_FIELD(irq),
+	SORT_FIELD(swapin),
+	SORT_FIELD(freepages),
+	SORT_FIELD(thrashing),
+	SORT_FIELD(compact),
+	SORT_FIELD(wpcopy),
+	END_FIELD
+};

 /* Netlink socket variables */
 static int nl_sd = -1;
@@ -158,18 +183,59 @@ static void disable_raw_mode(void)
 	tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_termios);
 }

+/* Find field descriptor by name with string comparison */
+static const struct field_desc *get_field_by_name(const char *name)
+{
+	const struct field_desc *field;
+	size_t field_len;
+
+	for (field = sort_fields; field->name != NULL; field++) {
+		field_len = strlen(field->name);
+		if (field_len != strlen(name))
+			continue;
+		if (strncmp(field->name, name, field_len) == 0)
+			return field;
+	}
+
+	return NULL;
+}
+
+/* Find display name for a field descriptor */
+static const char *get_name_by_field(const struct field_desc *field)
+{
+	return field ? field->name : "UNKNOWN";
+}
+
+/* Generate string of available field names */
+static void display_available_fields(void)
+{
+	const struct field_desc *field;
+	char buf[MAX_BUF_LEN];
+
+	buf[0] = '\0';
+
+	for (field = sort_fields; field->name != NULL; field++) {
+		strncat(buf, "|", MAX_BUF_LEN - strlen(buf) - 1);
+		strncat(buf, field->name, MAX_BUF_LEN - strlen(buf) - 1);
+		buf[MAX_BUF_LEN - 1] = '\0';
+	}
+
+	fprintf(stderr, "Available fields: %s\n", buf);
+}
+
 /* Display usage information and command line options */
 static void usage(void)
 {
 	printf("Usage: delaytop [Options]\n"
 	"Options:\n"
-	"  -h, --help				Show this help message and exit\n"
-	"  -d, --delay=SECONDS	  Set refresh interval (default: 2 seconds, min: 1)\n"
-	"  -n, --iterations=COUNT	Set number of updates (default: 0 = infinite)\n"
-	"  -P, --processes=NUMBER	Set maximum number of processes to show (default: 20, max: 1000)\n"
-	"  -o, --once				Display once and exit\n"
-	"  -p, --pid=PID			Monitor only the specified PID\n"
-	"  -C, --container=PATH	 Monitor the container at specified cgroup path\n");
+	"  -h, --help               Show this help message and exit\n"
+	"  -d, --delay=SECONDS      Set refresh interval (default: 2 seconds, min: 1)\n"
+	"  -n, --iterations=COUNT   Set number of updates (default: 0 = infinite)\n"
+	"  -P, --processes=NUMBER   Set maximum number of processes to show (default: 20, max: 1000)\n"
+	"  -o, --once               Display once and exit\n"
+	"  -p, --pid=PID            Monitor only the specified PID\n"
+	"  -C, --container=PATH     Monitor the container at specified cgroup path\n"
+	"  -s, --sort=FIELD         Sort by delay field (default: cpu)\n");
 	exit(0);
 }

@@ -177,6 +243,7 @@ static void usage(void)
 static void parse_args(int argc, char **argv)
 {
 	int c;
+	const struct field_desc *field;
 	struct option long_options[] = {
 		{"help", no_argument, 0, 'h'},
 		{"delay", required_argument, 0, 'd'},
@@ -184,6 +251,7 @@ static void parse_args(int argc, char **argv)
 		{"pid", required_argument, 0, 'p'},
 		{"once", no_argument, 0, 'o'},
 		{"processes", required_argument, 0, 'P'},
+		{"sort", required_argument, 0, 's'},
 		{"container", required_argument, 0, 'C'},
 		{0, 0, 0, 0}
 	};
@@ -192,7 +260,7 @@ static void parse_args(int argc, char **argv)
 	cfg.delay = 2;
 	cfg.iterations = 0;
 	cfg.max_processes = 20;
-	cfg.sort_field = 'c';	/* Default sort by CPU delay */
+	cfg.sort_field = &sort_fields[0];	/* Default sorted by CPU delay */
 	cfg.output_one_time = 0;
 	cfg.monitor_pid = 0;	/* 0 means monitor all PIDs */
 	cfg.container_path = NULL;
@@ -200,7 +268,7 @@ static void parse_args(int argc, char **argv)
 	while (1) {
 		int option_index = 0;

-		c = getopt_long(argc, argv, "hd:n:p:oP:C:", long_options, &option_index);
+		c = getopt_long(argc, argv, "hd:n:p:oP:C:s:", long_options, &option_index);
 		if (c == -1)
 			break;

@@ -247,6 +315,22 @@ static void parse_args(int argc, char **argv)
 		case 'C':
 			cfg.container_path = strdup(optarg);
 			break;
+		case 's':
+			if (strlen(optarg) == 0) {
+				fprintf(stderr, "Error: empty sort field\n");
+				exit(1);
+			}
+
+			field = get_field_by_name(optarg);
+			/* Show available fields if invalid option provided */
+			if (!field) {
+				fprintf(stderr, "Error: invalid sort field '%s'\n", optarg);
+				display_available_fields();
+				exit(1);
+			}
+
+			cfg.sort_field = field;
+			break;
 		default:
 			fprintf(stderr, "Try 'delaytop --help' for more information.\n");
 			exit(1);
@@ -587,19 +671,23 @@ static int compare_tasks(const void *a, const void *b)
 {
 	const struct task_info *t1 = (const struct task_info *)a;
 	const struct task_info *t2 = (const struct task_info *)b;
+	unsigned long long total1;
+	unsigned long long total2;
+	unsigned long count1;
+	unsigned long count2;
 	double avg1, avg2;

-	switch (cfg.sort_field) {
-	case 'c': /* CPU */
-		avg1 = average_ms(t1->cpu_delay_total, t1->cpu_count);
-		avg2 = average_ms(t2->cpu_delay_total, t2->cpu_count);
-		if (avg1 != avg2)
-			return avg2 > avg1 ? 1 : -1;
-		return t2->cpu_delay_total > t1->cpu_delay_total ? 1 : -1;
+	total1 = *(unsigned long long *)((char *)t1 + cfg.sort_field->total_offset);
+	total2 = *(unsigned long long *)((char *)t2 + cfg.sort_field->total_offset);
+	count1 = *(unsigned long *)((char *)t1 + cfg.sort_field->count_offset);
+	count2 = *(unsigned long *)((char *)t2 + cfg.sort_field->count_offset);

-	default:
-		return t2->cpu_delay_total > t1->cpu_delay_total ? 1 : -1;
-	}
+	avg1 = average_ms(total1, count1);
+	avg2 = average_ms(total2, count2);
+	if (avg1 != avg2)
+		return avg2 > avg1 ? 1 : -1;
+
+	return 0;
 }

 /* Sort tasks by selected field */
@@ -738,8 +826,9 @@ static void display_results(void)
 			container_stats.nr_stopped, container_stats.nr_uninterruptible,
 			container_stats.nr_io_wait);
 	}
-	suc &= BOOL_FPRINT(out, "Top %d processes (sorted by CPU delay):\n",
-			cfg.max_processes);
+	/* Task delay output */
+	suc &= BOOL_FPRINT(out, "Top %d processes (sorted by %s delay):\n",
+			cfg.max_processes, get_name_by_field(cfg.sort_field));
 	suc &= BOOL_FPRINT(out, "%5s  %5s  %-17s", "PID", "TGID", "COMMAND");
 	suc &= BOOL_FPRINT(out, "%7s %7s %7s %7s %7s %7s %7s %7s\n",
 		"CPU(ms)", "IO(ms)", "SWAP(ms)", "RCL(ms)",
-- 
2.25.1

