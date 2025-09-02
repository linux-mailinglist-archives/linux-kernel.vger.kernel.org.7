Return-Path: <linux-kernel+bounces-795439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E52B6B3F212
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CF91A85230
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 02:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887E818D636;
	Tue,  2 Sep 2025 02:01:22 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0316FC3;
	Tue,  2 Sep 2025 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756778482; cv=none; b=TEypCF/q5VoFNLKNf2CWdUyND/IenC80ip7xvj+re2OKzEE+fzLbY8tYpI+pbBkFmab6qUwfbpHTcfXIZmmZ5JnZbO/WVKeCzFAuJ/2gbvI7LY+Y0D9Y8B/LQS0bS/uRIKTOKwHAYZ3+IQfx62CgkX/Pokj+6yU1GNnwqopIUdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756778482; c=relaxed/simple;
	bh=euhcNSxCNUd3eB/FwSOi1w9wqoBfz3GgiBLMXntU10c=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=KIx/QuwO9MfmrmFUnocy9yGMyqER2Dau9PllPkayEPHxDXnaS0TUbUOF7+19ELRRp9sLfMPBV64ZJXfcAAdLgTdNQgFtAeh/h74c4RAhUFOlJ5gFjmyVjc5YK5F5m8+AZqez7ViFw7/zRqfWMA9IpCHNI2yZzE93uCUU8wB0buo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cG89R15cMz8Xs76;
	Tue, 02 Sep 2025 10:01:15 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 58220Udv031365;
	Tue, 2 Sep 2025 10:00:30 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 2 Sep 2025 10:00:30 +0800 (CST)
Date: Tue, 2 Sep 2025 10:00:30 +0800 (CST)
X-Zmail-TransId: 2afb68b64fbe9e0-685a9
X-Mailer: Zmail v1.0
Message-ID: <20250902100030967nPEcUoRRSnruExakQxAIm@zte.com.cn>
In-Reply-To: <202509020957458514CMgUiaqPjTURNET_d-w0@zte.com.cn>
References: 202509020957458514CMgUiaqPjTURNET_d-w0@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>
Cc: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>, <fan.yu9@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgMS8zXSB0b29scy9kZWxheXRvcDogYWRkIG1lbW9yeSB2ZXJib3NlIG1vZGUgc3VwcG9ydA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 58220Udv031365
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 02 Sep 2025 10:01:15 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B64FEB.000/4cG89R15cMz8Xs76

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
 tools/accounting/delaytop.c | 111 ++++++++++++++++++++++++++++--------
 1 file changed, 87 insertions(+), 24 deletions(-)

diff --git a/tools/accounting/delaytop.c b/tools/accounting/delaytop.c
index 9afb1ffc00ba..f1e2e1cca4b8 100644
--- a/tools/accounting/delaytop.c
+++ b/tools/accounting/delaytop.c
@@ -68,6 +68,8 @@
 	ret >= 0; \
 })
 #define PSI_LINE_FORMAT "%-12s %6.1f%%/%6.1f%%/%6.1f%%/%8llu(ms)\n"
+#define FMT_NORMAL "%8.2f %8.2f %8.2f %8.2f\n"
+#define FMT_MEMVERBOSE "%8.2f %8.2f %8.2f %8.2f %8.2f %8.2f %8.2f %8.2f %8.2f\n"

 /* Program settings structure */
 struct config {
@@ -78,6 +80,7 @@ struct config {
 	int output_one_time;	/* Output once and exit */
 	int monitor_pid;		/* Monitor specific PID */
 	char *container_path;	/* Path to container cgroup */
+	int mem_verbose_mode;	/* Memory detailed display mode */
 };

 /* PSI statistics structure */
@@ -163,13 +166,14 @@ static void usage(void)
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
+	"  -M, --memverbose         Display memory detailed information\n");
 	exit(0);
 }

@@ -185,6 +189,7 @@ static void parse_args(int argc, char **argv)
 		{"once", no_argument, 0, 'o'},
 		{"processes", required_argument, 0, 'P'},
 		{"container", required_argument, 0, 'C'},
+		{"memverbose", no_argument, 0, 'M'},
 		{0, 0, 0, 0}
 	};

@@ -196,11 +201,12 @@ static void parse_args(int argc, char **argv)
 	cfg.output_one_time = 0;
 	cfg.monitor_pid = 0;	/* 0 means monitor all PIDs */
 	cfg.container_path = NULL;
+	cfg.mem_verbose_mode = 0;

 	while (1) {
 		int option_index = 0;

-		c = getopt_long(argc, argv, "hd:n:p:oP:C:", long_options, &option_index);
+		c = getopt_long(argc, argv, "hd:n:p:oP:C:M", long_options, &option_index);
 		if (c == -1)
 			break;

@@ -247,6 +253,9 @@ static void parse_args(int argc, char **argv)
 		case 'C':
 			cfg.container_path = strdup(optarg);
 			break;
+		case 'M':
+			cfg.mem_verbose_mode = 1;
+			break;
 		default:
 			fprintf(stderr, "Try 'delaytop --help' for more information.\n");
 			exit(1);
@@ -582,6 +591,25 @@ static double average_ms(unsigned long long total, unsigned long long count)
 	return (double)total / 1000000.0 / count;
 }

+/* Calculate average delay in milliseconds for memory */
+static unsigned long long task_total_mem_delay(const struct task_info *t)
+{
+	return t->swapin_delay_total +
+		t->freepages_delay_total +
+		t->thrashing_delay_total +
+		t->compact_delay_total +
+		t->wpcopy_delay_total;
+}
+
+static unsigned long long task_total_mem_count(const struct task_info *t)
+{
+	return t->swapin_count +
+		t->freepages_count +
+		t->thrashing_count +
+		t->compact_count +
+		t->wpcopy_count;
+}
+
 /* Comparison function for sorting tasks */
 static int compare_tasks(const void *a, const void *b)
 {
@@ -740,27 +768,62 @@ static void display_results(void)
 	}
 	suc &= BOOL_FPRINT(out, "Top %d processes (sorted by CPU delay):\n",
 			cfg.max_processes);
-	suc &= BOOL_FPRINT(out, "%5s  %5s  %-17s", "PID", "TGID", "COMMAND");
-	suc &= BOOL_FPRINT(out, "%7s %7s %7s %7s %7s %7s %7s %7s\n",
-		"CPU(ms)", "IO(ms)", "SWAP(ms)", "RCL(ms)",
-		"THR(ms)", "CMP(ms)", "WP(ms)", "IRQ(ms)");
+	suc &= BOOL_FPRINT(out, "%8s  %8s  %-17s", "PID", "TGID", "COMMAND");
+
+	if (!cfg.mem_verbose_mode) {
+		suc &= BOOL_FPRINT(out, "%8s %8s %8s %8s\n",
+			"CPU(ms)", "IO(ms)", "IRQ(ms)", "MEM(ms)");
+		suc &= BOOL_FPRINT(out, "-----------------------");
+		suc &= BOOL_FPRINT(out, "-----------------------");
+		suc &= BOOL_FPRINT(out, "--------------------------\n");
+	} else {
+		suc &= BOOL_FPRINT(out, "%8s %8s %8s %8s %8s %8s %8s %8s %8s\n",
+			"CPU(ms)", "IO(ms)", "IRQ(ms)", "MEM(ms)",
+			"SWAP(ms)", "RCL(ms)", "THR(ms)", "CMP(ms)", "WP(ms)");
+		suc &= BOOL_FPRINT(out, "-----------------------");
+		suc &= BOOL_FPRINT(out, "-----------------------");
+		suc &= BOOL_FPRINT(out, "-----------------------");
+		suc &= BOOL_FPRINT(out, "-----------------------");
+		suc &= BOOL_FPRINT(out, "-------------------------\n");
+	}
+

-	suc &= BOOL_FPRINT(out, "-----------------------------------------------");
-	suc &= BOOL_FPRINT(out, "----------------------------------------------\n");
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
+		if (!cfg.mem_verbose_mode) {
+			suc &= BOOL_FPRINT(out, FMT_NORMAL,
+				average_ms(tasks[i].cpu_delay_total,
+						   tasks[i].cpu_count),
+				average_ms(tasks[i].blkio_delay_total,
+						   tasks[i].blkio_count),
+				average_ms(tasks[i].irq_delay_total,
+						   tasks[i].irq_count),
+				average_ms(task_total_mem_delay(&tasks[i]),
+						   task_total_mem_count(&tasks[i])));
+		} else {
+			suc &= BOOL_FPRINT(out, FMT_MEMVERBOSE,
+				average_ms(tasks[i].cpu_delay_total,
+						   tasks[i].cpu_count),
+				average_ms(tasks[i].blkio_delay_total,
+						   tasks[i].blkio_count),
+				average_ms(tasks[i].irq_delay_total,
+						   tasks[i].irq_count),
+				average_ms(task_total_mem_delay(&tasks[i]),
+						   task_total_mem_count(&tasks[i])),
+				average_ms(tasks[i].swapin_delay_total,
+						   tasks[i].swapin_count),
+				average_ms(tasks[i].freepages_delay_total,
+						   tasks[i].freepages_count),
+				average_ms(tasks[i].thrashing_delay_total,
+						   tasks[i].thrashing_count),
+				average_ms(tasks[i].compact_delay_total,
+						   tasks[i].compact_count),
+				average_ms(tasks[i].wpcopy_delay_total,
+						   tasks[i].wpcopy_count));
+		}
 	}

 	suc &= BOOL_FPRINT(out, "\n");
-- 
2.25.1

