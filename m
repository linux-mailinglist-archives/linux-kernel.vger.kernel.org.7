Return-Path: <linux-kernel+bounces-694020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F14CAE06D6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 15:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071A34A2A75
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7447C246774;
	Thu, 19 Jun 2025 13:19:00 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234FE220F3B;
	Thu, 19 Jun 2025 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339139; cv=none; b=r8qnB+ECKR+3X5pXsisE6ikbgJ01ypVD6DNQPbEwnsEduKgjQSZRFI/psATf8bEYyEYGVqd8wFFP0dV6Vj7NSSoSQ4RnMVZsD7/t2jcFu2VbsAoE6489/HIHwPVCgGcE/QEYCVuvwzzuYTBnhzM/MBBC6n1anh60nbifgNsjeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339139; c=relaxed/simple;
	bh=qc2BBDlN/8A4orE1kQjzisyDNSB2eg07We5GtQPeb8w=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=XmLYHw0MgmmjvDf5iEYHG78of4J+GaO/YX0kpRVoxUQyR/HAZoa/YM2n13OGUEH9WJYw/cYq1Y0HSlyQmGMqRG2DPFZqTWSqyDTuyGBRP7bE+09kUBWE0gC2YEzUls/dBYZuRZDusKDsQ71t2znKDYuyv0+fHobbmy8tZyWquwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bNLlr3v00z4x6DR;
	Thu, 19 Jun 2025 21:18:48 +0800 (CST)
Received: from njy2app02.zte.com.cn ([10.40.13.116])
	by mse-fl1.zte.com.cn with SMTP id 55JDIdnp017959;
	Thu, 19 Jun 2025 21:18:39 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njb2app05[null])
	by mapi (Zmail) with MAPI id mid204;
	Thu, 19 Jun 2025 21:18:43 +0800 (CST)
Date: Thu, 19 Jun 2025 21:18:43 +0800 (CST)
X-Zmail-TransId: 2afd68540e33ffffffffbab-7b7bb
X-Mailer: Zmail v1.0
Message-ID: <20250619211843633h05gWrBDMFkEH6xAVm_5y@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <bsingharora@gmail.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
        <yang.yang29@zte.com.cn>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <wang.yong12@zte.com.cn>,
        <wang.yaxin@zte.com.cn>, <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <qiu.yutan@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>, <ye.xingchen@zte.com.cn>,
        <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4IG5leHRdIHRvb2xzL2FjY291bnRpbmcvZGVsYXl0b3A6IGFkZCBkZWxheXRvcAogdG8gcmVjb3JkIHRvcC1uIHRhc2sgZGVsYXk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 55JDIdnp017959
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68540E38.002/4bNLlr3v00z4x6DR

From: Yaxin Wang <wang.yaxin@zte.com.cn>

Problem
=======
The "getdelays" can only display the latency of a single task
by specifying a PID, but it has the following limitations:
1. single-task perspective: only supports querying the
latency (CPU, I/O, memory, etc.) of an individual task via
PID and cannot provide a global analysis of high-latency
processes across the system.
2. lack of High-Latency process awareness: when the overall
system latency is high (e.g., a spike in CPU latency), there
is no way to quickly identify the top N processes contributing
to the highest latency.
3. poor interactivity: It lacks dynamic sorting and refresh
capabilities (similar to top), making it difficult to monitor
latency changes in real time.

Solution
========
To address these limitations, we introduce the "delaytop" with
the following capabilities:
1. system view: monitors latency metrics (CPU, I/O, memory, IRQ,
etc.) for all system processes
2. supports field-based sorting (e.g., default sort by CPU latency
in descending order)
3. dynamic interactive interface:
focus on specific processes with --pid;
limit displayed entries with --processes 20;
control monitoring duration with --iterations;

Use case
========
bash# ./delaytop
Top 20 processes (sorted by CPU delay):

  PID   TGID  COMMAND            CPU(ms)  IO(ms)   SWAP(ms) RCL(ms) THR(ms)  CMP(ms)  WP(ms)  IRQ(ms)
---------------------------------------------------------------------------------------------
   26     26  kworker/1:0H       5.55     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   32     32  kworker/2:0H-kb    2.93     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   38     38  kworker/3:0H-ev    2.88     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   84     84  kworker/R-vfio-    1.62     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   24     24  ksoftirqd/1        1.43     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   19     19  idle_inject/0      0.99     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   16     16  rcu_exp_par_gp_    0.87     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   11     11  kworker/0:1        0.87     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   22     22  idle_inject/1      0.80     0.00     0.00     0.00    0.00     0.00     0.00     0.00
    3      3  pool_workqueue_    0.74     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   81     81  scsi_eh_1          0.59     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   30     30  ksoftirqd/2        0.42     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   36     36  ksoftirqd/3        0.37     0.00     0.00     0.00    0.00     0.00     0.00     0.00
    9      9  kworker/0:0-eve    0.36     0.00     0.00     0.00    0.00     0.00     0.00     0.00
    8      8  kworker/R-netns    0.34     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   76     76  kworker/1:1-pm     0.32     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   21     21  cpuhp/1            0.30     0.00     0.00     0.00    0.00     0.00     0.00     0.00
    4      4  kworker/R-rcu_g    0.21     0.00     0.00     0.00    0.00     0.00     0.00     0.00
   12     12  kworker/u16:0-i    0.20     0.00     0.00     0.00    0.00     0.00     0.00     0.00
    1      1  init               0.18     0.00     0.00     0.00    0.00     0.00     0.08     0.00

Co-developed-by: Fan Yu <fan.yu9@zte.com.cn>
Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>
---
 tools/accounting/Makefile   |   2 +-
 tools/accounting/delaytop.c | 673 ++++++++++++++++++++++++++++++++++++
 2 files changed, 674 insertions(+), 1 deletion(-)
 create mode 100644 tools/accounting/delaytop.c

diff --git a/tools/accounting/Makefile b/tools/accounting/Makefile
index 11def1ad046c..20bbd461515e 100644
--- a/tools/accounting/Makefile
+++ b/tools/accounting/Makefile
@@ -2,7 +2,7 @@
 CC := $(CROSS_COMPILE)gcc
 CFLAGS := -I../../usr/include

-PROGS := getdelays procacct
+PROGS := getdelays procacct delaytop

 all: $(PROGS)

diff --git a/tools/accounting/delaytop.c b/tools/accounting/delaytop.c
new file mode 100644
index 000000000000..23e38f39e97d
--- /dev/null
+++ b/tools/accounting/delaytop.c
@@ -0,0 +1,673 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * delaytop.c - task delay monitoring tool.
+ *
+ * This tool provides real-time monitoring and statistics of
+ * system, container, and task-level delays, including CPU,
+ * memory, IO, and IRQ and delay accounting. It supports both
+ * interactive (top-like), and can output delay information
+ * for the whole system, specific containers (cgroups), or
+ * individual tasks (PIDs).
+ *
+ * Key features:
+ *   - Collects per-task delay accounting statistics via taskstats.
+ *   - Supports sorting, filtering.
+ *   - Supports both interactive (screen refresh).
+ *
+ * Copyright (C) Fan Yu, ZTE Corp. 2025
+ * Copyright (C) Wang Yaxin, ZTE Corp. 2025
+ *
+ * Compile with
+ *	gcc -I/usr/src/linux/include delaytop.c -o delaytop
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <signal.h>
+#include <time.h>
+#include <dirent.h>
+#include <ctype.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/socket.h>
+#include <sys/select.h>
+#include <termios.h>
+#include <limits.h>
+#include <linux/genetlink.h>
+#include <linux/taskstats.h>
+#include <linux/cgroupstats.h>
+#include <ncurses.h>
+
+#define NLA_NEXT(na)			((struct nlattr *)((char *)(na) + NLA_ALIGN((na)->nla_len)))
+#define NLA_DATA(na)			((void *)((char *)(na) + NLA_HDRLEN))
+#define NLA_PAYLOAD(len)		(len - NLA_HDRLEN)
+
+#define GENLMSG_DATA(glh)		((void *)(NLMSG_DATA(glh) + GENL_HDRLEN))
+#define GENLMSG_PAYLOAD(glh)	(NLMSG_PAYLOAD(glh, 0) - GENL_HDRLEN)
+
+#define TASK_COMM_LEN	16
+#define MAX_MSG_SIZE	1024
+#define MAX_TASKS		1000
+#define SET_TASK_STAT(task_count, field) tasks[task_count].field = stats.field
+
+/* Program settings structure */
+struct config {
+	int delay;				/* Update interval in seconds */
+	int iterations;			/* Number of iterations, 0 == infinite */
+	int max_processes;		/* Maximum number of processes to show */
+	char sort_field;		/* Field to sort by */
+	int output_one_time;	/* Output once and exit */
+	int monitor_pid;		/* Monitor specific PID */
+	char *container_path;	/* Path to container cgroup */
+};
+
+/* Task delay information structure */
+struct task_info {
+	int pid;
+	int tgid;
+	char command[TASK_COMM_LEN];
+	unsigned long long cpu_count;
+	unsigned long long cpu_delay_total;
+	unsigned long long blkio_count;
+	unsigned long long blkio_delay_total;
+	unsigned long long swapin_count;
+	unsigned long long swapin_delay_total;
+	unsigned long long freepages_count;
+	unsigned long long freepages_delay_total;
+	unsigned long long thrashing_count;
+	unsigned long long thrashing_delay_total;
+	unsigned long long compact_count;
+	unsigned long long compact_delay_total;
+	unsigned long long wpcopy_count;
+	unsigned long long wpcopy_delay_total;
+	unsigned long long irq_count;
+	unsigned long long irq_delay_total;
+};
+
+/* Container statistics structure */
+struct container_stats {
+	int nr_sleeping;		/* Number of sleeping processes */
+	int nr_running;			/* Number of running processes */
+	int nr_stopped;			/* Number of stopped processes */
+	int nr_uninterruptible; /* Number of uninterruptible processes */
+	int nr_io_wait;			/* Number of processes in IO wait */
+};
+
+/* Global variables */
+static struct config cfg;
+static struct task_info tasks[MAX_TASKS];
+static int task_count;
+static int running = 1;
+static struct container_stats container_stats;
+
+/* Netlink socket variables */
+static int nl_sd = -1;
+static int family_id;
+
+/* Set terminal to non-canonical mode for q-to-quit */
+static struct termios orig_termios;
+static void enable_raw_mode(void)
+{
+	struct termios raw;
+
+	tcgetattr(STDIN_FILENO, &orig_termios);
+	raw = orig_termios;
+	raw.c_lflag &= ~(ICANON | ECHO);
+	tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw);
+}
+static void disable_raw_mode(void)
+{
+	tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_termios);
+}
+
+/* Display usage information and command line options */
+static void usage(void)
+{
+	printf("Usage: delaytop [Options]\n"
+	"Options:\n"
+	"  -h, --help               Show this help message and exit\n"
+	"  -d, --delay=SECONDS      Set refresh interval (default: 2 seconds, min: 1)\n"
+	"  -n, --iterations=COUNT   Set number of updates (default: 0 = infinite)\n"
+	"  -P, --processes=NUMBER   Set maximum number of processes to show (default: 20, max: 1000)\n"
+	"  -o, --once               Display once and exit\n"
+	"  -p, --pid=PID            Monitor only the specified PID\n"
+	"  -C, --container=PATH     Monitor the container at specified cgroup path\n");
+	exit(0);
+}
+
+/* Parse command line arguments and set configuration */
+static void parse_args(int argc, char **argv)
+{
+	int c;
+	struct option long_options[] = {
+		{"help", no_argument, 0, 'h'},
+		{"delay", required_argument, 0, 'd'},
+		{"iterations", required_argument, 0, 'n'},
+		{"pid", required_argument, 0, 'p'},
+		{"once", no_argument, 0, 'o'},
+		{"processes", required_argument, 0, 'P'},
+		{"container", required_argument, 0, 'C'},
+		{0, 0, 0, 0}
+	};
+
+	/* Set defaults */
+	cfg.delay = 2;
+	cfg.iterations = 0;
+	cfg.max_processes = 20;
+	cfg.sort_field = 'c';	/* Default sort by CPU delay */
+	cfg.output_one_time = 0;
+	cfg.monitor_pid = 0;	/* 0 means monitor all PIDs */
+	cfg.container_path = NULL;
+
+	while (1) {
+		int option_index = 0;
+
+		c = getopt_long(argc, argv, "hd:n:p:oP:C:", long_options, &option_index);
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'h':
+			usage();
+			break;
+		case 'd':
+			cfg.delay = atoi(optarg);
+			if (cfg.delay < 1) {
+				fprintf(stderr, "Error: delay must be >= 1.\n");
+				exit(1);
+			}
+			break;
+		case 'n':
+			cfg.iterations = atoi(optarg);
+			if (cfg.iterations < 0) {
+				fprintf(stderr, "Error: iterations must be >= 0.\n");
+				exit(1);
+			}
+			break;
+		case 'p':
+			cfg.monitor_pid = atoi(optarg);
+			if (cfg.monitor_pid < 1) {
+				fprintf(stderr, "Error: pid must be >= 1.\n");
+				exit(1);
+			}
+			break;
+		case 'o':
+			cfg.output_one_time = 1;
+			break;
+		case 'P':
+			cfg.max_processes = atoi(optarg);
+			if (cfg.max_processes < 1) {
+				fprintf(stderr, "Error: processes must be >= 1.\n");
+				exit(1);
+			}
+			if (cfg.max_processes > MAX_TASKS) {
+				fprintf(stderr, "Warning: processes capped to %d.\n",
+					MAX_TASKS);
+				cfg.max_processes = MAX_TASKS;
+			}
+			break;
+		case 'C':
+			cfg.container_path = strdup(optarg);
+			break;
+		default:
+			fprintf(stderr, "Try 'delaytop --help' for more information.\n");
+			exit(1);
+		}
+	}
+}
+
+/* Create a raw netlink socket and bind */
+static int create_nl_socket(void)
+{
+	int fd;
+	struct sockaddr_nl local;
+
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	if (fd < 0)
+		return -1;
+
+	memset(&local, 0, sizeof(local));
+	local.nl_family = AF_NETLINK;
+
+	if (bind(fd, (struct sockaddr *) &local, sizeof(local)) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+/* Send a command via netlink */
+static int send_cmd(int sd, __u16 nlmsg_type, __u32 nlmsg_pid,
+			 __u8 genl_cmd, __u16 nla_type,
+			 void *nla_data, int nla_len)
+{
+	struct sockaddr_nl nladdr;
+	struct nlattr *na;
+	int r, buflen;
+	char *buf;
+
+	struct {
+		struct nlmsghdr n;
+		struct genlmsghdr g;
+		char buf[MAX_MSG_SIZE];
+	} msg;
+
+	msg.n.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
+	msg.n.nlmsg_type = nlmsg_type;
+	msg.n.nlmsg_flags = NLM_F_REQUEST;
+	msg.n.nlmsg_seq = 0;
+	msg.n.nlmsg_pid = nlmsg_pid;
+	msg.g.cmd = genl_cmd;
+	msg.g.version = 0x1;
+	na = (struct nlattr *) GENLMSG_DATA(&msg);
+	na->nla_type = nla_type;
+	na->nla_len = nla_len + NLA_HDRLEN;
+	memcpy(NLA_DATA(na), nla_data, nla_len);
+	msg.n.nlmsg_len += NLMSG_ALIGN(na->nla_len);
+
+	buf = (char *) &msg;
+	buflen = msg.n.nlmsg_len;
+	memset(&nladdr, 0, sizeof(nladdr));
+	nladdr.nl_family = AF_NETLINK;
+	while ((r = sendto(sd, buf, buflen, 0, (struct sockaddr *) &nladdr,
+				   sizeof(nladdr))) < buflen) {
+		if (r > 0) {
+			buf += r;
+			buflen -= r;
+		} else if (errno != EAGAIN)
+			return -1;
+	}
+	return 0;
+}
+
+/* Get family ID for taskstats via netlink */
+static int get_family_id(int sd)
+{
+	struct {
+		struct nlmsghdr n;
+		struct genlmsghdr g;
+		char buf[256];
+	} ans;
+
+	int id = 0, rc;
+	struct nlattr *na;
+	int rep_len;
+	char name[100];
+
+	strncpy(name, TASKSTATS_GENL_NAME, sizeof(name) - 1);
+	name[sizeof(name) - 1] = '\0';
+	rc = send_cmd(sd, GENL_ID_CTRL, getpid(), CTRL_CMD_GETFAMILY,
+			CTRL_ATTR_FAMILY_NAME, (void *)name,
+			strlen(TASKSTATS_GENL_NAME)+1);
+	if (rc < 0)
+		return 0;
+
+	rep_len = recv(sd, &ans, sizeof(ans), 0);
+	if (ans.n.nlmsg_type == NLMSG_ERROR ||
+		(rep_len < 0) || !NLMSG_OK((&ans.n), rep_len))
+		return 0;
+
+	na = (struct nlattr *) GENLMSG_DATA(&ans);
+	na = (struct nlattr *) ((char *) na + NLA_ALIGN(na->nla_len));
+	if (na->nla_type == CTRL_ATTR_FAMILY_ID)
+		id = *(__u16 *) NLA_DATA(na);
+	return id;
+}
+
+static int read_comm(int pid, char *comm_buf, size_t buf_size)
+{
+	char path[64];
+	size_t len;
+	FILE *fp;
+
+	snprintf(path, sizeof(path), "/proc/%d/comm", pid);
+	fp = fopen(path, "r");
+	if (!fp)
+		return -1;
+	if (fgets(comm_buf, buf_size, fp)) {
+		len = strlen(comm_buf);
+		if (len > 0 && comm_buf[len - 1] == '\n')
+			comm_buf[len - 1] = '\0';
+	} else {
+		fclose(fp);
+		return -1;
+	}
+	fclose(fp);
+	return 0;
+}
+
+static int fetch_and_fill_task_info(int pid, const char *comm)
+{
+	struct {
+		struct nlmsghdr n;
+		struct genlmsghdr g;
+		char buf[MAX_MSG_SIZE];
+	} resp;
+	struct taskstats stats;
+	struct nlattr *nested;
+	struct nlattr *na;
+	int nested_len;
+	int nl_len;
+	int rc;
+
+	if (send_cmd(nl_sd, family_id, getpid(), TASKSTATS_CMD_GET,
+				 TASKSTATS_CMD_ATTR_PID, &pid, sizeof(pid)) < 0) {
+		return -1;
+	}
+	rc = recv(nl_sd, &resp, sizeof(resp), 0);
+	if (rc < 0 || resp.n.nlmsg_type == NLMSG_ERROR)
+		return -1;
+	nl_len = GENLMSG_PAYLOAD(&resp.n);
+	na = (struct nlattr *) GENLMSG_DATA(&resp);
+	while (nl_len > 0) {
+		if (na->nla_type == TASKSTATS_TYPE_AGGR_PID) {
+			nested = (struct nlattr *) NLA_DATA(na);
+			nested_len = NLA_PAYLOAD(na->nla_len);
+			while (nested_len > 0) {
+				if (nested->nla_type == TASKSTATS_TYPE_STATS) {
+					memcpy(&stats, NLA_DATA(nested), sizeof(stats));
+					if (task_count < MAX_TASKS) {
+						tasks[task_count].pid = pid;
+						tasks[task_count].tgid = pid;
+						strncpy(tasks[task_count].command, comm,
+							TASK_COMM_LEN - 1);
+						tasks[task_count].command[TASK_COMM_LEN - 1] = '\0';
+						SET_TASK_STAT(task_count, cpu_count);
+						SET_TASK_STAT(task_count, cpu_delay_total);
+						SET_TASK_STAT(task_count, blkio_count);
+						SET_TASK_STAT(task_count, blkio_delay_total);
+						SET_TASK_STAT(task_count, swapin_count);
+						SET_TASK_STAT(task_count, swapin_delay_total);
+						SET_TASK_STAT(task_count, freepages_count);
+						SET_TASK_STAT(task_count, freepages_delay_total);
+						SET_TASK_STAT(task_count, thrashing_count);
+						SET_TASK_STAT(task_count, thrashing_delay_total);
+						SET_TASK_STAT(task_count, compact_count);
+						SET_TASK_STAT(task_count, compact_delay_total);
+						SET_TASK_STAT(task_count, wpcopy_count);
+						SET_TASK_STAT(task_count, wpcopy_delay_total);
+						SET_TASK_STAT(task_count, irq_count);
+						SET_TASK_STAT(task_count, irq_delay_total);
+						task_count++;
+					}
+					break;
+				}
+				nested_len -= NLA_ALIGN(nested->nla_len);
+				nested = NLA_NEXT(nested);
+			}
+		}
+		nl_len -= NLA_ALIGN(na->nla_len);
+		na = NLA_NEXT(na);
+	}
+	return 0;
+}
+
+static void get_task_delays(void)
+{
+	char comm[TASK_COMM_LEN];
+	struct dirent *entry;
+	DIR *dir;
+	int pid;
+
+	task_count = 0;
+	if (cfg.monitor_pid > 0) {
+		if (read_comm(cfg.monitor_pid, comm, sizeof(comm)) == 0)
+			fetch_and_fill_task_info(cfg.monitor_pid, comm);
+		return;
+	}
+
+	dir = opendir("/proc");
+	if (!dir) {
+		fprintf(stderr, "Error opening /proc directory\n");
+		return;
+	}
+
+	while ((entry = readdir(dir)) != NULL && task_count < MAX_TASKS) {
+		if (!isdigit(entry->d_name[0]))
+			continue;
+		pid = atoi(entry->d_name);
+		if (pid == 0)
+			continue;
+		if (read_comm(pid, comm, sizeof(comm)) != 0)
+			continue;
+		fetch_and_fill_task_info(pid, comm);
+	}
+	closedir(dir);
+}
+
+/* Calculate average delay in milliseconds */
+static double average_ms(unsigned long long total, unsigned long long count)
+{
+	if (count == 0)
+		return 0;
+	return (double)total / 1000000.0 / count;
+}
+
+/* Comparison function for sorting tasks */
+static int compare_tasks(const void *a, const void *b)
+{
+	const struct task_info *t1 = (const struct task_info *)a;
+	const struct task_info *t2 = (const struct task_info *)b;
+	double avg1, avg2;
+
+	switch (cfg.sort_field) {
+	case 'c': /* CPU */
+		avg1 = average_ms(t1->cpu_delay_total, t1->cpu_count);
+		avg2 = average_ms(t2->cpu_delay_total, t2->cpu_count);
+		if (avg1 != avg2)
+			return avg2 > avg1 ? 1 : -1;
+		return t2->cpu_delay_total > t1->cpu_delay_total ? 1 : -1;
+
+	default:
+		return t2->cpu_delay_total > t1->cpu_delay_total ? 1 : -1;
+	}
+}
+
+/* Sort tasks by selected field */
+static void sort_tasks(void)
+{
+	if (task_count > 0)
+		qsort(tasks, task_count, sizeof(struct task_info), compare_tasks);
+}
+
+/* Get container statistics via cgroupstats */
+static void get_container_stats(void)
+{
+	int rc, cfd;
+	struct {
+		struct nlmsghdr n;
+		struct genlmsghdr g;
+		char buf[MAX_MSG_SIZE];
+	} req, resp;
+	struct nlattr *na;
+	int nl_len;
+	struct cgroupstats stats;
+
+	/* Check if container path is set */
+	if (!cfg.container_path)
+		return;
+
+	/* Open container cgroup */
+	cfd = open(cfg.container_path, O_RDONLY);
+	if (cfd < 0) {
+		fprintf(stderr, "Error opening container path: %s\n", cfg.container_path);
+		return;
+	}
+
+	/* Send request for container stats */
+	if (send_cmd(nl_sd, family_id, getpid(), CGROUPSTATS_CMD_GET,
+				CGROUPSTATS_CMD_ATTR_FD, &cfd, sizeof(__u32)) < 0) {
+		fprintf(stderr, "Failed to send request for container stats\n");
+		close(cfd);
+		return;
+	}
+
+	/* Receive response */
+	rc = recv(nl_sd, &resp, sizeof(resp), 0);
+	if (rc < 0 || resp.n.nlmsg_type == NLMSG_ERROR) {
+		fprintf(stderr, "Failed to receive response for container stats\n");
+		close(cfd);
+		return;
+	}
+
+	/* Parse response */
+	nl_len = GENLMSG_PAYLOAD(&resp.n);
+	na = (struct nlattr *) GENLMSG_DATA(&resp);
+	while (nl_len > 0) {
+		if (na->nla_type == CGROUPSTATS_TYPE_CGROUP_STATS) {
+			/* Get the cgroupstats structure */
+			memcpy(&stats, NLA_DATA(na), sizeof(stats));
+
+			/* Fill container stats */
+			container_stats.nr_sleeping = stats.nr_sleeping;
+			container_stats.nr_running = stats.nr_running;
+			container_stats.nr_stopped = stats.nr_stopped;
+			container_stats.nr_uninterruptible = stats.nr_uninterruptible;
+			container_stats.nr_io_wait = stats.nr_io_wait;
+			break;
+		}
+		nl_len -= NLA_ALIGN(na->nla_len);
+		na = (struct nlattr *) ((char *) na + NLA_ALIGN(na->nla_len));
+	}
+
+	close(cfd);
+}
+
+/* Display results to stdout or log file */
+static void display_results(void)
+{
+	time_t now = time(NULL);
+	struct tm *tm_now = localtime(&now);
+	char timestamp[32];
+	int i, count;
+	FILE *out = stdout;
+
+	fprintf(out, "\033[H\033[J");
+
+	if (cfg.container_path) {
+		fprintf(out, "Container Information (%s):\n", cfg.container_path);
+		fprintf(out, "Processes: running=%d, sleeping=%d, ",
+			container_stats.nr_running, container_stats.nr_sleeping);
+		fprintf(out, "stopped=%d, uninterruptible=%d, io_wait=%d\n\n",
+			container_stats.nr_stopped, container_stats.nr_uninterruptible,
+			container_stats.nr_io_wait);
+	}
+	fprintf(out, "Top %d processes (sorted by CPU delay):\n\n",
+		   cfg.max_processes);
+	fprintf(out, "  PID	TGID  COMMAND		 CPU(ms)  IO(ms)   ");
+	fprintf(out, "SWAP(ms) RCL(ms) THR(ms)  CMP(ms)  WP(ms)  IRQ(ms)\n");
+	fprintf(out, "-----------------------------------------------");
+	fprintf(out, "----------------------------------------------\n");
+	count = task_count < cfg.max_processes ? task_count : cfg.max_processes;
+
+	for (i = 0; i < count; i++) {
+		fprintf(out, "%5d  %5d  %-15s ",
+			tasks[i].pid, tasks[i].tgid, tasks[i].command);
+		fprintf(out, "%7.2f  %7.2f  %7.2f  %7.2f %7.2f  %7.2f  %7.2f  %7.2f\n",
+			average_ms(tasks[i].cpu_delay_total, tasks[i].cpu_count),
+			average_ms(tasks[i].blkio_delay_total, tasks[i].blkio_count),
+			average_ms(tasks[i].swapin_delay_total, tasks[i].swapin_count),
+			average_ms(tasks[i].freepages_delay_total, tasks[i].freepages_count),
+			average_ms(tasks[i].thrashing_delay_total, tasks[i].thrashing_count),
+			average_ms(tasks[i].compact_delay_total, tasks[i].compact_count),
+			average_ms(tasks[i].wpcopy_delay_total, tasks[i].wpcopy_count),
+			average_ms(tasks[i].irq_delay_total, tasks[i].irq_count));
+	}
+
+	fprintf(out, "\n");
+}
+
+/* Main function */
+int main(int argc, char **argv)
+{
+	int iterations = 0;
+	int use_q_quit = 0;
+
+	/* Parse command line arguments */
+	parse_args(argc, argv);
+
+	/* Setup netlink socket */
+	nl_sd = create_nl_socket();
+	if (nl_sd < 0) {
+		fprintf(stderr, "Error creating netlink socket\n");
+		exit(1);
+	}
+
+	/* Get family ID for taskstats via netlink */
+	family_id = get_family_id(nl_sd);
+	if (!family_id) {
+		fprintf(stderr, "Error getting taskstats family ID\n");
+		close(nl_sd);
+		exit(1);
+	}
+
+	if (!cfg.output_one_time) {
+		use_q_quit = 1;
+		enable_raw_mode();
+		printf("Press 'q' to quit.\n");
+		fflush(stdout);
+	}
+
+	/* Main loop */
+	while (running) {
+		/* Get container stats if container path provided */
+		if (cfg.container_path)
+			get_container_stats();
+
+		/* Get task delays */
+		get_task_delays();
+
+		/* Sort tasks */
+		sort_tasks();
+
+		/* Display results to stdout or log file */
+		display_results();
+
+		/* Check for iterations */
+		if (cfg.iterations > 0 && ++iterations >= cfg.iterations)
+			break;
+
+		/* Exit if output_one_time is set */
+		if (cfg.output_one_time)
+			break;
+
+		/* Check for 'q' key to quit */
+		if (use_q_quit) {
+			struct timeval tv = {cfg.delay, 0};
+			fd_set readfds;
+
+			FD_ZERO(&readfds);
+			FD_SET(STDIN_FILENO, &readfds);
+			int r = select(STDIN_FILENO+1, &readfds, NULL, NULL, &tv);
+
+			if (r > 0 && FD_ISSET(STDIN_FILENO, &readfds)) {
+				char ch = 0;
+
+				read(STDIN_FILENO, &ch, 1);
+				if (ch == 'q' || ch == 'Q') {
+					running = 0;
+					break;
+				}
+			}
+		} else {
+			sleep(cfg.delay);
+		}
+	}
+
+	/* Restore terminal mode */
+	if (use_q_quit)
+		disable_raw_mode();
+
+	/* Cleanup */
+	close(nl_sd);
+	if (cfg.container_path)
+		free(cfg.container_path);
+
+	return 0;
+}
-- 
2.25.1

