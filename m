Return-Path: <linux-kernel+bounces-747672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42274B136B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376E017995B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E7F253356;
	Mon, 28 Jul 2025 08:28:58 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB62528FC;
	Mon, 28 Jul 2025 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691337; cv=none; b=IBH2alMk/jNor9aQU5fSJBs4IGegNxw9mb1vte4uV5QyvmnrBpNRAxP+oVLUvvRlSD3ifZ9C+hBosyy643YV7I7Ev6nTrmf6tha5CXmn95GoEXZbBi23eJxGYSJEHeIvBKa6KeTvEp5ZdwzqphKDZ8TrZQ3cCmL87FIJhfDH+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691337; c=relaxed/simple;
	bh=6oKLGNKIrcqlkqQGPwMkQB0wal9c5xuEzoh0atfTu3w=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=qeom5b8GhWGvq9/ezuGxNWpxUMMCfNK0C5wDXbpjS8BLEyMbfeoRz2SOnvA2AEAKBrcJS6ecu8Ci0OaSn76jukyrev64OJqTIPVgia8FqDtXkf4TDIsZziue7vPt4m/NB/U/j4o3zDkRXqIhnIHNXLhJBr/KkbtBxfROgCIJ+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4brBTG6vnPz6FyBy;
	Mon, 28 Jul 2025 16:28:50 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 56S8SVY5063787;
	Mon, 28 Jul 2025 16:28:31 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 28 Jul 2025 16:28:34 +0800 (CST)
Date: Mon, 28 Jul 2025 16:28:34 +0800 (CST)
X-Zmail-TransId: 2afc688734b2191-ba8de
X-Mailer: Zmail v1.0
Message-ID: <202507281628341752gMXCMN7S-Vz_LHYHum9r@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>, <corbet@lwn.net>,
        <yang.yang29@zte.com.cn>
Cc: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <fan.yu9@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRlbGF5dG9wOiBFbmhhbmNlIGVycm9yIGxvZ2dpbmcgYW5kIGFkZCBQU0kgZmVhdHVyZSBkZXNjcmlwdGlvbg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 56S8SVY5063787
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 28 Jul 2025 16:28:50 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 688734C2.003/4brBTG6vnPz6FyBy

This patch improves error diagnostics and documentation for delaytop:
1) Enhanced error logging:
   - Added explicit error messages in critical failure paths
   - Implemented BOOL_FPRINT macro for robust output handling

2) PSI feature documentation:
   - Updated header comment to reflect PSI monitoring capability
   - Improved output formatting for PSI information

System Pressure Information: (avg10/avg60/avg300/total)
CPU some:       0.0%/   0.0%/   0.0%/     345(ms)
CPU full:       0.0%/   0.0%/   0.0%/       0(ms)
Memory full:    0.0%/   0.0%/   0.0%/       0(ms)
Memory some:    0.0%/   0.0%/   0.0%/       0(ms)
IO full:        0.0%/   0.0%/   0.0%/      65(ms)
IO some:        0.0%/   0.0%/   0.0%/      79(ms)
IRQ full:       0.0%/   0.0%/   0.0%/       0(ms)

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
---
 Documentation/accounting/delay-accounting.rst |  61 ++++---
 tools/accounting/delaytop.c                   | 162 ++++++++++++------
 2 files changed, 143 insertions(+), 80 deletions(-)

diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
index 664950328fb7..8ccc5af5ea1e 100644
--- a/Documentation/accounting/delay-accounting.rst
+++ b/Documentation/accounting/delay-accounting.rst
@@ -132,38 +132,47 @@ Get IO accounting for pid 1, it works only with -p::

 The above command can be used with -v to get more debug information.

-After the system starts, use `delaytop` to get the Top-N high-latency tasks.
-this tool supports sorting by CPU latency in descending order by default,
+After the system starts, use `delaytop` to get the system-wide delay information,
+which includes system-wide PSI information and Top-N high-latency tasks.
+
+`delaytop` supports sorting by CPU latency in descending order by default,
 displays the top 20 high-latency tasks by default, and refreshes the latency
 data every 2 seconds by default.

-Get Top-N tasks delay, since system boot::
+Get PSI information and Top-N tasks delay, since system boot::

 	bash# ./delaytop
+	System Pressure Information: (avg10/avg60/avg300/total)
+	CPU some:       0.0%/   0.0%/   0.0%/     345(ms)
+	CPU full:       0.0%/   0.0%/   0.0%/       0(ms)
+	Memory full:    0.0%/   0.0%/   0.0%/       0(ms)
+	Memory some:    0.0%/   0.0%/   0.0%/       0(ms)
+	IO full:        0.0%/   0.0%/   0.0%/      65(ms)
+	IO some:        0.0%/   0.0%/   0.0%/      79(ms)
+	IRQ full:       0.0%/   0.0%/   0.0%/       0(ms)
 	Top 20 processes (sorted by CPU delay):
-
-	  PID   TGID  COMMAND            CPU(ms)  IO(ms)        SWAP(ms) RCL(ms) THR(ms)  CMP(ms)  WP(ms)  IRQ(ms)
-	---------------------------------------------------------------------------------------------
-	   32     32  kworker/2:0H-sy   23.65     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	  497    497  kworker/R-scsi_    1.20     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	  495    495  kworker/R-scsi_    1.13     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	  494    494  scsi_eh_0          1.12     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	  485    485  kworker/R-ata_s    0.90     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	  574    574  kworker/R-kdmfl    0.36     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	   34     34  idle_inject/3      0.33     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	 1123   1123  nde-netfilter      0.28     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	   60     60  ksoftirqd/7        0.25     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	  114    114  kworker/0:2-cgr    0.25     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	  496    496  scsi_eh_1          0.24     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	   51     51  cpuhp/6            0.24     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	 1667   1667  atd                0.24     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	   45     45  cpuhp/5            0.23     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	 1102   1102  nde-backupservi    0.22     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	 1098   1098  systemsettings     0.21     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	 1100   1100  audit-monitor      0.20     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	   53     53  migration/6        0.20     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	 1482   1482  sshd               0.19     0.00     0.00     0.00    0.00     0.00     0.00     0.00
-	   39     39  cpuhp/4            0.19     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	  PID   TGID  COMMAND          CPU(ms)  IO(ms) SWAP(ms) RCL(ms) THR(ms) CMP(ms)  WP(ms) IRQ(ms)
+	----------------------------------------------------------------------------------------------
+	  161    161  zombie_memcg_re   1.40    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	  130    130  blkcg_punt_bio    1.37    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	  444    444  scsi_tmf_0        0.73    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	 1280   1280  rsyslogd          0.53    0.04    0.00    0.00    0.00    0.00    0.00    0.00
+	   12     12  ksoftirqd/0       0.47    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	 1277   1277  nbd-server        0.44    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	  308    308  kworker/2:2-sys   0.41    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	   55     55  netns             0.36    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	 1187   1187  acpid             0.31    0.03    0.00    0.00    0.00    0.00    0.00    0.00
+	 6184   6184  kworker/1:2-sys   0.24    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	  186    186  kaluad            0.24    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	   18     18  ksoftirqd/1       0.24    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	  185    185  kmpath_rdacd      0.23    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	  190    190  kstrp             0.23    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	 2759   2759  agetty            0.20    0.03    0.00    0.00    0.00    0.00    0.00    0.00
+	 1190   1190  kworker/0:3-sys   0.19    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	 1272   1272  sshd              0.15    0.04    0.00    0.00    0.00    0.00    0.00    0.00
+	 1156   1156  license           0.15    0.11    0.00    0.00    0.00    0.00    0.00    0.00
+	  134    134  md                0.13    0.00    0.00    0.00    0.00    0.00    0.00    0.00
+	 6142   6142  kworker/3:2-xfs   0.13    0.00    0.00    0.00    0.00    0.00    0.00    0.00

 Dynamic interactive interface of delaytop::

diff --git a/tools/accounting/delaytop.c b/tools/accounting/delaytop.c
index cd848af9a856..9afb1ffc00ba 100644
--- a/tools/accounting/delaytop.c
+++ b/tools/accounting/delaytop.c
@@ -1,16 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * delaytop.c - task delay monitoring tool.
+ * delaytop.c - system-wide delay monitoring tool.
  *
  * This tool provides real-time monitoring and statistics of
  * system, container, and task-level delays, including CPU,
- * memory, IO, and IRQ and delay accounting. It supports both
- * interactive (top-like), and can output delay information
- * for the whole system, specific containers (cgroups), or
- * individual tasks (PIDs).
+ * memory, IO, and IRQ. It supports both interactive (top-like),
+ * and can output delay information for the whole system, specific
+ * containers (cgroups), or individual tasks (PIDs).
  *
  * Key features:
  *	- Collects per-task delay accounting statistics via taskstats.
+ *	- Collects system-wide PSI information.
  *	- Supports sorting, filtering.
  *	- Supports both interactive (screen refresh).
  *
@@ -32,6 +32,7 @@
 #include <time.h>
 #include <dirent.h>
 #include <ctype.h>
+#include <stdbool.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/socket.h>
@@ -41,7 +42,6 @@
 #include <linux/genetlink.h>
 #include <linux/taskstats.h>
 #include <linux/cgroupstats.h>
-#include <ncurses.h>

 #define PSI_CPU_SOME "/proc/pressure/cpu"
 #define PSI_CPU_FULL	"/proc/pressure/cpu"
@@ -62,6 +62,12 @@
 #define MAX_MSG_SIZE	1024
 #define MAX_TASKS		1000
 #define SET_TASK_STAT(task_count, field) tasks[task_count].field = stats.field
+#define BOOL_FPRINT(stream, fmt, ...) \
+({ \
+	int ret = fprintf(stream, fmt, ##__VA_ARGS__); \
+	ret >= 0; \
+})
+#define PSI_LINE_FORMAT "%-12s %6.1f%%/%6.1f%%/%6.1f%%/%8llu(ms)\n"

 /* Program settings structure */
 struct config {
@@ -262,6 +268,7 @@ static int create_nl_socket(void)
 	local.nl_family = AF_NETLINK;

 	if (bind(fd, (struct sockaddr *) &local, sizeof(local)) < 0) {
+		fprintf(stderr, "Failed to bind socket when create nl_socket\n");
 		close(fd);
 		return -1;
 	}
@@ -332,13 +339,17 @@ static int get_family_id(int sd)
 	rc = send_cmd(sd, GENL_ID_CTRL, getpid(), CTRL_CMD_GETFAMILY,
 			CTRL_ATTR_FAMILY_NAME, (void *)name,
 			strlen(TASKSTATS_GENL_NAME)+1);
-	if (rc < 0)
+	if (rc < 0) {
+		fprintf(stderr, "Failed to send cmd for family id\n");
 		return 0;
+	}

 	rep_len = recv(sd, &ans, sizeof(ans), 0);
 	if (ans.n.nlmsg_type == NLMSG_ERROR ||
-		(rep_len < 0) || !NLMSG_OK((&ans.n), rep_len))
+		(rep_len < 0) || !NLMSG_OK((&ans.n), rep_len)) {
+		fprintf(stderr, "Failed to receive response for family id\n");
 		return 0;
+	}

 	na = (struct nlattr *) GENLMSG_DATA(&ans);
 	na = (struct nlattr *) ((char *) na + NLA_ALIGN(na->nla_len));
@@ -433,26 +444,30 @@ static void read_psi_stats(void)
 static int read_comm(int pid, char *comm_buf, size_t buf_size)
 {
 	char path[64];
+	int ret = -1;
 	size_t len;
 	FILE *fp;

 	snprintf(path, sizeof(path), "/proc/%d/comm", pid);
 	fp = fopen(path, "r");
-	if (!fp)
-		return -1;
+	if (!fp) {
+		fprintf(stderr, "Failed to open comm file /proc/%d/comm\n", pid);
+		return ret;
+	}
+
 	if (fgets(comm_buf, buf_size, fp)) {
 		len = strlen(comm_buf);
 		if (len > 0 && comm_buf[len - 1] == '\n')
 			comm_buf[len - 1] = '\0';
-	} else {
-		fclose(fp);
-		return -1;
+		ret = 0;
 	}
+
 	fclose(fp);
-	return 0;
+
+	return ret;
 }

-static int fetch_and_fill_task_info(int pid, const char *comm)
+static void fetch_and_fill_task_info(int pid, const char *comm)
 {
 	struct {
 		struct nlmsghdr n;
@@ -466,13 +481,21 @@ static int fetch_and_fill_task_info(int pid, const char *comm)
 	int nl_len;
 	int rc;

+	/* Send request for task stats */
 	if (send_cmd(nl_sd, family_id, getpid(), TASKSTATS_CMD_GET,
 				 TASKSTATS_CMD_ATTR_PID, &pid, sizeof(pid)) < 0) {
-		return -1;
+		fprintf(stderr, "Failed to send request for task stats\n");
+		return;
 	}
+
+	/* Receive response */
 	rc = recv(nl_sd, &resp, sizeof(resp), 0);
-	if (rc < 0 || resp.n.nlmsg_type == NLMSG_ERROR)
-		return -1;
+	if (rc < 0 || resp.n.nlmsg_type == NLMSG_ERROR) {
+		fprintf(stderr, "Failed to receive response for task stats\n");
+		return;
+	}
+
+	/* Parse response */
 	nl_len = GENLMSG_PAYLOAD(&resp.n);
 	na = (struct nlattr *) GENLMSG_DATA(&resp);
 	while (nl_len > 0) {
@@ -515,7 +538,7 @@ static int fetch_and_fill_task_info(int pid, const char *comm)
 		nl_len -= NLA_ALIGN(na->nla_len);
 		na = NLA_NEXT(na);
 	}
-	return 0;
+	return;
 }

 static void get_task_delays(void)
@@ -654,54 +677,82 @@ static void display_results(void)
 {
 	time_t now = time(NULL);
 	struct tm *tm_now = localtime(&now);
+	FILE *out = stdout;
 	char timestamp[32];
+	bool suc = true;
 	int i, count;
-	FILE *out = stdout;

-	fprintf(out, "\033[H\033[J");
+	/* Clear terminal screen */
+	suc &= BOOL_FPRINT(out, "\033[H\033[J");
+
 	/* PSI output (one-line, no cat style) */
-	fprintf(out, "System Pressure Information: ");
-	fprintf(out, "(avg10/avg60/avg300/total)\n");
-	fprintf(out, "CPU:");
-	fprintf(out, "	full: %6.1f%%/%6.1f%%/%6.1f%%/%-10llu", psi.cpu_full_avg10,
-			psi.cpu_full_avg60, psi.cpu_full_avg300, psi.cpu_full_total);
-	fprintf(out, "  some: %6.1f%%/%6.1f%%/%6.1f%%/%-10llu\n", psi.cpu_some_avg10,
-			psi.cpu_some_avg60, psi.cpu_some_avg300, psi.cpu_some_total);
-
-	fprintf(out, "Memory:");
-	fprintf(out, " full: %6.1f%%/%6.1f%%/%6.1f%%/%-10llu", psi.memory_full_avg10,
-			psi.memory_full_avg60, psi.memory_full_avg300, psi.memory_full_total);
-	fprintf(out, "  some: %6.1f%%/%6.1f%%/%6.1f%%/%-10llu\n", psi.memory_some_avg10,
-			psi.memory_some_avg60, psi.memory_some_avg300, psi.memory_some_total);
-
-	fprintf(out, "IO:");
-	fprintf(out, "	full: %6.1f%%/%6.1f%%/%6.1f%%/%-10llu", psi.io_full_avg10,
-			psi.io_full_avg60, psi.io_full_avg300, psi.io_full_total);
-	fprintf(out, "  some: %6.1f%%/%6.1f%%/%6.1f%%/%-10llu\n", psi.io_some_avg10,
-			psi.io_some_avg60, psi.io_some_avg300, psi.io_some_total);
-	fprintf(out, "IRQ:");
-	fprintf(out, "	full: %6.1f%%/%6.1f%%/%6.1f%%/%-10llu\n\n", psi.irq_full_avg10,
-			psi.irq_full_avg60, psi.irq_full_avg300, psi.irq_full_total);
+	suc &= BOOL_FPRINT(out, "System Pressure Information: (avg10/avg60/avg300/total)\n");
+	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+		"CPU some:",
+		psi.cpu_some_avg10,
+		psi.cpu_some_avg60,
+		psi.cpu_some_avg300,
+		psi.cpu_some_total / 1000);
+	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+		"CPU full:",
+		psi.cpu_full_avg10,
+		psi.cpu_full_avg60,
+		psi.cpu_full_avg300,
+		psi.cpu_full_total / 1000);
+	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+		"Memory full:",
+		psi.memory_full_avg10,
+		psi.memory_full_avg60,
+		psi.memory_full_avg300,
+		psi.memory_full_total / 1000);
+	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+		"Memory some:",
+		psi.memory_some_avg10,
+		psi.memory_some_avg60,
+		psi.memory_some_avg300,
+		psi.memory_some_total / 1000);
+	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+		"IO full:",
+		psi.io_full_avg10,
+		psi.io_full_avg60,
+		psi.io_full_avg300,
+		psi.io_full_total / 1000);
+	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+		"IO some:",
+		psi.io_some_avg10,
+		psi.io_some_avg60,
+		psi.io_some_avg300,
+		psi.io_some_total / 1000);
+	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+		"IRQ full:",
+		psi.irq_full_avg10,
+		psi.irq_full_avg60,
+		psi.irq_full_avg300,
+		psi.irq_full_total / 1000);
+
 	if (cfg.container_path) {
-		fprintf(out, "Container Information (%s):\n", cfg.container_path);
-		fprintf(out, "Processes: running=%d, sleeping=%d, ",
+		suc &= BOOL_FPRINT(out, "Container Information (%s):\n", cfg.container_path);
+		suc &= BOOL_FPRINT(out, "Processes: running=%d, sleeping=%d, ",
 			container_stats.nr_running, container_stats.nr_sleeping);
-		fprintf(out, "stopped=%d, uninterruptible=%d, io_wait=%d\n\n",
+		suc &= BOOL_FPRINT(out, "stopped=%d, uninterruptible=%d, io_wait=%d\n\n",
 			container_stats.nr_stopped, container_stats.nr_uninterruptible,
 			container_stats.nr_io_wait);
 	}
-	fprintf(out, "Top %d processes (sorted by CPU delay):\n\n",
+	suc &= BOOL_FPRINT(out, "Top %d processes (sorted by CPU delay):\n",
 			cfg.max_processes);
-	fprintf(out, "  PID	TGID  COMMAND		 CPU(ms)  IO(ms)	");
-	fprintf(out, "SWAP(ms) RCL(ms) THR(ms)  CMP(ms)  WP(ms)  IRQ(ms)\n");
-	fprintf(out, "-----------------------------------------------");
-	fprintf(out, "----------------------------------------------\n");
+	suc &= BOOL_FPRINT(out, "%5s  %5s  %-17s", "PID", "TGID", "COMMAND");
+	suc &= BOOL_FPRINT(out, "%7s %7s %7s %7s %7s %7s %7s %7s\n",
+		"CPU(ms)", "IO(ms)", "SWAP(ms)", "RCL(ms)",
+		"THR(ms)", "CMP(ms)", "WP(ms)", "IRQ(ms)");
+
+	suc &= BOOL_FPRINT(out, "-----------------------------------------------");
+	suc &= BOOL_FPRINT(out, "----------------------------------------------\n");
 	count = task_count < cfg.max_processes ? task_count : cfg.max_processes;

 	for (i = 0; i < count; i++) {
-		fprintf(out, "%5d  %5d  %-15s ",
+		suc &= BOOL_FPRINT(out, "%5d  %5d  %-15s",
 			tasks[i].pid, tasks[i].tgid, tasks[i].command);
-		fprintf(out, "%7.2f  %7.2f  %7.2f  %7.2f %7.2f  %7.2f  %7.2f  %7.2f\n",
+		suc &= BOOL_FPRINT(out, "%7.2f %7.2f %7.2f %7.2f %7.2f %7.2f %7.2f %7.2f\n",
 			average_ms(tasks[i].cpu_delay_total, tasks[i].cpu_count),
 			average_ms(tasks[i].blkio_delay_total, tasks[i].blkio_count),
 			average_ms(tasks[i].swapin_delay_total, tasks[i].swapin_count),
@@ -712,7 +763,10 @@ static void display_results(void)
 			average_ms(tasks[i].irq_delay_total, tasks[i].irq_count));
 	}

-	fprintf(out, "\n");
+	suc &= BOOL_FPRINT(out, "\n");
+
+	if (!suc)
+		perror("Error writing to output");
 }

 /* Main function */
-- 
2.25.1

