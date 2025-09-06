Return-Path: <linux-kernel+bounces-804370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05836B47402
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7215189A887
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36A424729D;
	Sat,  6 Sep 2025 16:19:54 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1924728E;
	Sat,  6 Sep 2025 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757175594; cv=none; b=mfyDrnuFzYJsJigaBsSBy+6h9mO+v6MUja6By6m7aJ159dwH8ylfBUXMFJnSIaQ/mX/MYQhHdTTjl+tFe9tK6q3X4uOaQpS7TzQbDnIAa2zqC7YIPjycv2VBBA4FrUgoSdzYm7CyhzwCWWmthqjOZmNv+VQNp+TW3tik/7xYSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757175594; c=relaxed/simple;
	bh=eaB9N8EWHxHf2EroKxZ/EgJX0a80wrpJveqhMT3h9a8=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=BrZsvK8yHcU3VDL04/ZM/AqZAFLpRnVk5Gfy7/+n2iGfI5v7hduYooLsGdkEO8p0L/tJExr2uOFtmb8xwv3kt6uoQIqI3yVMis4BwvSz6eoNW+q+8lpo4j7kzJl39HwQGSAEcQNELJV+3+z3QXnORZadsaBqT5ClgpQNADmxp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cJytc6CBPz7PJx;
	Sun, 07 Sep 2025 00:13:12 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4cJytW38yzzBQkJn;
	Sun, 07 Sep 2025 00:13:07 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cJytF3c8Fz8Xs6w;
	Sun, 07 Sep 2025 00:12:53 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 586GCmEV034748;
	Sun, 7 Sep 2025 00:12:49 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 7 Sep 2025 00:12:52 +0800 (CST)
Date: Sun, 7 Sep 2025 00:12:52 +0800 (CST)
X-Zmail-TransId: 2afb68bc5d84ead-35ec3
X-Mailer: Zmail v1.0
Message-ID: <202509070012527934u0ySb3teQ4gOYKnocyNO@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIdjIgbGludXgtbmV4dCAyLzVdIHRvb2xzL2RlbGF5dG9wOiBhZGQgbWVtb3J5IHZlcmJvc2UgbW9kZSBzdXBwb3J0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 586GCmEV034748
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.35.20.121 unknown Sun, 07 Sep 2025 00:13:13 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68BC5D97.000/4cJytc6CBPz7PJx

From: Fan Yu <fan.yu9@zte.com.cn>

The original delaytop tool always displayed detailed memory
subsystem breakdown, which could be overwhelming for users
who only need high-level overview.

Add flexible display control allowing users to choose their
preferred information granularity.

The new flexibility provides:
1) For quick monitoring: use normal mode to reduce visual clutter
2) For deep analysis: use verbose mode to see all memory subsystem details

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
 tools/accounting/delaytop.c | 128 +++++++++++++++++++++++++++---------
 1 file changed, 98 insertions(+), 30 deletions(-)

diff --git a/tools/accounting/delaytop.c b/tools/accounting/delaytop.c
index 52718714496b..30dc95fb531a 100644
--- a/tools/accounting/delaytop.c
+++ b/tools/accounting/delaytop.c
@@ -69,13 +69,22 @@
 	int ret = fprintf(stream, fmt, ##__VA_ARGS__); \
 	ret >= 0; \
 })
+#define TASK_AVG(task, field) average_ms((task).field##_delay_total, (task).field##_count)
 #define PSI_LINE_FORMAT "%-12s %6.1f%%/%6.1f%%/%6.1f%%/%8llu(ms)\n"
-#define SORT_FIELD(name) \
+#define DELAY_FMT_DEFAULT "%8.2f %8.2f %8.2f %8.2f\n"
+#define DELAY_FMT_MEMVERBOSE "%8.2f %8.2f %8.2f %8.2f %8.2f %8.2f\n"
+#define SORT_FIELD(name, modes) \
 	{#name, \
 	offsetof(struct task_info, name##_delay_total), \
-	offsetof(struct task_info, name##_count)}
+	offsetof(struct task_info, name##_count), \
+	modes}
 #define END_FIELD {NULL, 0, 0}

+/* Display mode types */
+#define MODE_TYPE_ALL	(0xFFFFFFFF)
+#define MODE_DEFAULT	(1 << 0)
+#define MODE_MEMVERBOSE	(1 << 1)
+
 /* PSI statistics structure */
 struct psi_stats {
 	double cpu_some_avg10, cpu_some_avg60, cpu_some_avg300;
@@ -115,6 +124,8 @@ struct task_info {
 	unsigned long long wpcopy_delay_total;
 	unsigned long long irq_count;
 	unsigned long long irq_delay_total;
+	unsigned long long mem_count;
+	unsigned long long mem_delay_total;
 };

 /* Container statistics structure */
@@ -131,6 +142,7 @@ struct field_desc {
 	const char *name;	/* Field name for cmdline argument */
 	unsigned long total_offset; /* Offset of total delay in task_info */
 	unsigned long count_offset; /* Offset of count in task_info */
+	size_t supported_modes; /* Supported display modes */
 };

 /* Program settings structure */
@@ -142,6 +154,7 @@ struct config {
 	int monitor_pid;		/* Monitor specific PID */
 	char *container_path;	/* Path to container cgroup */
 	const struct field_desc *sort_field;	/* Current sort field */
+	size_t display_mode;	/* Current display mode */
 };

 /* Global variables */
@@ -152,14 +165,15 @@ static int task_count;
 static int running = 1;
 static struct container_stats container_stats;
 static const struct field_desc sort_fields[] = {
-	SORT_FIELD(cpu),
-	SORT_FIELD(blkio),
-	SORT_FIELD(irq),
-	SORT_FIELD(swapin),
-	SORT_FIELD(freepages),
-	SORT_FIELD(thrashing),
-	SORT_FIELD(compact),
-	SORT_FIELD(wpcopy),
+	SORT_FIELD(cpu,		MODE_DEFAULT),
+	SORT_FIELD(blkio,	MODE_DEFAULT),
+	SORT_FIELD(irq,		MODE_DEFAULT),
+	SORT_FIELD(mem,		MODE_DEFAULT | MODE_MEMVERBOSE),
+	SORT_FIELD(swapin,	MODE_MEMVERBOSE),
+	SORT_FIELD(freepages,	MODE_MEMVERBOSE),
+	SORT_FIELD(thrashing,	MODE_MEMVERBOSE),
+	SORT_FIELD(compact,	MODE_MEMVERBOSE),
+	SORT_FIELD(wpcopy,	MODE_MEMVERBOSE),
 	END_FIELD
 };

@@ -207,7 +221,7 @@ static const char *get_name_by_field(const struct field_desc *field)
 }

 /* Generate string of available field names */
-static void display_available_fields(void)
+static void display_available_fields(size_t mode)
 {
 	const struct field_desc *field;
 	char buf[MAX_BUF_LEN];
@@ -215,6 +229,8 @@ static void display_available_fields(void)
 	buf[0] = '\0';

 	for (field = sort_fields; field->name != NULL; field++) {
+		if (!(field->supported_modes & mode))
+			continue;
 		strncat(buf, "|", MAX_BUF_LEN - strlen(buf) - 1);
 		strncat(buf, field->name, MAX_BUF_LEN - strlen(buf) - 1);
 		buf[MAX_BUF_LEN - 1] = '\0';
@@ -235,7 +251,8 @@ static void usage(void)
 	"  -o, --once               Display once and exit\n"
 	"  -p, --pid=PID            Monitor only the specified PID\n"
 	"  -C, --container=PATH     Monitor the container at specified cgroup path\n"
-	"  -s, --sort=FIELD         Sort by delay field (default: cpu)\n");
+	"  -s, --sort=FIELD         Sort by delay field (default: cpu)\n"
+	"  -M, --memverbose         Display memory detailed information\n");
 	exit(0);
 }

@@ -253,6 +270,7 @@ static void parse_args(int argc, char **argv)
 		{"processes", required_argument, 0, 'P'},
 		{"sort", required_argument, 0, 's'},
 		{"container", required_argument, 0, 'C'},
+		{"memverbose", no_argument, 0, 'M'},
 		{0, 0, 0, 0}
 	};

@@ -264,11 +282,12 @@ static void parse_args(int argc, char **argv)
 	cfg.output_one_time = 0;
 	cfg.monitor_pid = 0;	/* 0 means monitor all PIDs */
 	cfg.container_path = NULL;
+	cfg.display_mode = MODE_DEFAULT;

 	while (1) {
 		int option_index = 0;

-		c = getopt_long(argc, argv, "hd:n:p:oP:C:s:", long_options, &option_index);
+		c = getopt_long(argc, argv, "hd:n:p:oP:C:s:M", long_options, &option_index);
 		if (c == -1)
 			break;

@@ -325,12 +344,16 @@ static void parse_args(int argc, char **argv)
 			/* Show available fields if invalid option provided */
 			if (!field) {
 				fprintf(stderr, "Error: invalid sort field '%s'\n", optarg);
-				display_available_fields();
+				display_available_fields(MODE_TYPE_ALL);
 				exit(1);
 			}

 			cfg.sort_field = field;
 			break;
+		case 'M':
+			cfg.display_mode = MODE_MEMVERBOSE;
+			cfg.sort_field = get_field_by_name("mem");
+			break;
 		default:
 			fprintf(stderr, "Try 'delaytop --help' for more information.\n");
 			exit(1);
@@ -338,6 +361,25 @@ static void parse_args(int argc, char **argv)
 	}
 }

+/* Calculate average delay in milliseconds for overall memory */
+static void set_mem_delay_total(struct task_info *t)
+{
+	t->mem_delay_total = t->swapin_delay_total +
+		t->freepages_delay_total +
+		t->thrashing_delay_total +
+		t->compact_delay_total +
+		t->wpcopy_delay_total;
+}
+
+static void set_mem_count(struct task_info *t)
+{
+	t->mem_count = t->swapin_count +
+		t->freepages_count +
+		t->thrashing_count +
+		t->compact_count +
+		t->wpcopy_count;
+}
+
 /* Create a raw netlink socket and bind */
 static int create_nl_socket(void)
 {
@@ -611,6 +653,8 @@ static void fetch_and_fill_task_info(int pid, const char *comm)
 						SET_TASK_STAT(task_count, wpcopy_delay_total);
 						SET_TASK_STAT(task_count, irq_count);
 						SET_TASK_STAT(task_count, irq_delay_total);
+						set_mem_count(&tasks[task_count]);
+						set_mem_delay_total(&tasks[task_count]);
 						task_count++;
 					}
 					break;
@@ -829,27 +873,44 @@ static void display_results(void)
 	/* Task delay output */
 	suc &= BOOL_FPRINT(out, "Top %d processes (sorted by %s delay):\n",
 			cfg.max_processes, get_name_by_field(cfg.sort_field));
-	suc &= BOOL_FPRINT(out, "%5s  %5s  %-17s", "PID", "TGID", "COMMAND");
-	suc &= BOOL_FPRINT(out, "%7s %7s %7s %7s %7s %7s %7s %7s\n",
-		"CPU(ms)", "IO(ms)", "SWAP(ms)", "RCL(ms)",
-		"THR(ms)", "CMP(ms)", "WP(ms)", "IRQ(ms)");

-	suc &= BOOL_FPRINT(out, "-----------------------------------------------");
-	suc &= BOOL_FPRINT(out, "----------------------------------------------\n");
+	suc &= BOOL_FPRINT(out, "%8s  %8s  %-17s", "PID", "TGID", "COMMAND");
+	if (cfg.display_mode == MODE_MEMVERBOSE) {
+		suc &= BOOL_FPRINT(out, "%8s %8s %8s %8s %8s %8s\n",
+			"MEM(ms)", "SWAP(ms)", "RCL(ms)",
+			"THR(ms)", "CMP(ms)", "WP(ms)");
+		suc &= BOOL_FPRINT(out, "-----------------------");
+		suc &= BOOL_FPRINT(out, "-----------------------");
+		suc &= BOOL_FPRINT(out, "-----------------------");
+		suc &= BOOL_FPRINT(out, "---------------------\n");
+	} else {
+		suc &= BOOL_FPRINT(out, "%8s %8s %8s %8s\n",
+			"CPU(ms)", "IO(ms)", "IRQ(ms)", "MEM(ms)");
+		suc &= BOOL_FPRINT(out, "-----------------------");
+		suc &= BOOL_FPRINT(out, "-----------------------");
+		suc &= BOOL_FPRINT(out, "--------------------------\n");
+	}
+
 	count = task_count < cfg.max_processes ? task_count : cfg.max_processes;

 	for (i = 0; i < count; i++) {
-		suc &= BOOL_FPRINT(out, "%5d  %5d  %-15s",
+		suc &= BOOL_FPRINT(out, "%8d  %8d  %-15s",
 			tasks[i].pid, tasks[i].tgid, tasks[i].command);
-		suc &= BOOL_FPRINT(out, "%7.2f %7.2f %7.2f %7.2f %7.2f %7.2f %7.2f %7.2f\n",
-			average_ms(tasks[i].cpu_delay_total, tasks[i].cpu_count),
-			average_ms(tasks[i].blkio_delay_total, tasks[i].blkio_count),
-			average_ms(tasks[i].swapin_delay_total, tasks[i].swapin_count),
-			average_ms(tasks[i].freepages_delay_total, tasks[i].freepages_count),
-			average_ms(tasks[i].thrashing_delay_total, tasks[i].thrashing_count),
-			average_ms(tasks[i].compact_delay_total, tasks[i].compact_count),
-			average_ms(tasks[i].wpcopy_delay_total, tasks[i].wpcopy_count),
-			average_ms(tasks[i].irq_delay_total, tasks[i].irq_count));
+		if (cfg.display_mode == MODE_MEMVERBOSE) {
+			suc &= BOOL_FPRINT(out, DELAY_FMT_MEMVERBOSE,
+				TASK_AVG(tasks[i], mem),
+				TASK_AVG(tasks[i], swapin),
+				TASK_AVG(tasks[i], freepages),
+				TASK_AVG(tasks[i], thrashing),
+				TASK_AVG(tasks[i], compact),
+				TASK_AVG(tasks[i], wpcopy));
+		} else {
+			suc &= BOOL_FPRINT(out, DELAY_FMT_DEFAULT,
+				TASK_AVG(tasks[i], cpu),
+				TASK_AVG(tasks[i], blkio),
+				TASK_AVG(tasks[i], irq),
+				TASK_AVG(tasks[i], mem));
+		}
 	}

 	suc &= BOOL_FPRINT(out, "\n");
@@ -891,6 +952,13 @@ int main(int argc, char **argv)

 	/* Main loop */
 	while (running) {
+		/* Exit when sort field do not match display mode */
+		if (!(cfg.sort_field->supported_modes & cfg.display_mode)) {
+			fprintf(stderr, "Sort field not supported in this mode\n");
+			display_available_fields(cfg.display_mode);
+			break;
+		}
+
 		/* Read PSI statistics */
 		read_psi_stats();

-- 
2.25.1

