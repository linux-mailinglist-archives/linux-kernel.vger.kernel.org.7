Return-Path: <linux-kernel+bounces-795442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770D4B3F21A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA653B6291
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 02:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912CB1EE7C6;
	Tue,  2 Sep 2025 02:05:41 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279616FC3;
	Tue,  2 Sep 2025 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756778741; cv=none; b=rtJqMXsAELpjd10tg2XW2+0EozarzuChBvPgc1J9AU2YqL6Dt3yT41Uduw7gQofS446RMse0Um90Auh8UbxgO2tCXII+Zgc50poJ9tOctQm+gZ49/HpocsAIQ8DqLzJXyCZ3w33Dh0U0ABWqX5+vbkCA4hGlqZdW7a0WtyYQpiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756778741; c=relaxed/simple;
	bh=/wa/E2zW11MLhVaS2g/6my3y8dJxlfissL2isUxk2Uk=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=blQjKtdcQA7dTniNhVgNK1exaYCCXET0ieKj5k/IWgxgCtLEQA+mVjz4F8wqD5dSqstk77dOTq9IYWtZ50jn71kY9sfZYmZb244DRKOOOMi1vxlKYDRQXayQdqyBVPgArMBAjK5xu3MqsA2QASMpg9syZ2LexwEKO/T70NwdibM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cG8GR2dypz8Xs70;
	Tue, 02 Sep 2025 10:05:35 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 582259Pk052719;
	Tue, 2 Sep 2025 10:05:09 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 2 Sep 2025 10:05:10 +0800 (CST)
Date: Tue, 2 Sep 2025 10:05:10 +0800 (CST)
X-Zmail-TransId: 2afb68b650d6b72-70733
X-Mailer: Zmail v1.0
Message-ID: <20250902100510629gbt-dwxQ09_35jcv_YO3U@zte.com.cn>
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
Cc: <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <fan.yu9@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgMy8zXSB0b29scy9kZWxheXRvcDogYWRkIGludGVyYWN0aXZlIG1vZGUgd2l0aCBrZXlib2FyZCBjb250cm9scw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 582259Pk052719
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 02 Sep 2025 10:05:35 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B650EF.002/4cG8GR2dypz8Xs70

From: Fan Yu <fan.yu9@zte.com.cn>

The original delaytop only supported static output with limited
interaction. Users had to restart the tool with different command-line
options to change sorting or display modes, which disrupted continuous
monitoring and reduced productivity during performance investigations.

Adds real-time interactive controls through keyboard input:
1) Add interactive menu system with visual prompts
2) Support dynamic sorting changes without restarting
3) Enable toggle of memory verbose mode with 'M' key

The interactive mode transforms delaytop from a static monitoring tool
into a dynamic investigation platform, allowing users to adapt the
view in real-time based on observed performance patterns.

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
 tools/accounting/delaytop.c | 112 ++++++++++++++++++++++++++----------
 1 file changed, 82 insertions(+), 30 deletions(-)

diff --git a/tools/accounting/delaytop.c b/tools/accounting/delaytop.c
index 39852cd70bdf..21fb215d2928 100644
--- a/tools/accounting/delaytop.c
+++ b/tools/accounting/delaytop.c
@@ -140,6 +140,7 @@ static struct task_info tasks[MAX_TASKS];
 static int task_count;
 static int running = 1;
 static struct container_stats container_stats;
+static int sort_selected;

 /* Netlink socket variables */
 static int nl_sd = -1;
@@ -878,6 +879,17 @@ static void display_results(void)
 			container_stats.nr_io_wait);
 	}

+	/* Interacive command */
+	suc &= BOOL_FPRINT(out, "[o]sort [M]memverbose [q]quit\n");
+	if (sort_selected) {
+		if (cfg.mem_verbose_mode)
+			suc &= BOOL_FPRINT(out,
+			"sort selection: [c]CPU [i]IO [s]SWAP [r]RCL [t]THR [p]CMP [w]WP [q]IRQ\n");
+		else
+			suc &= BOOL_FPRINT(out,
+			"sort selection: [c]CPU [i]IO [m]MEM [q]IRQ\n");
+	}
+
 	/* Task delay output */
 	suc &= BOOL_FPRINT(out, "Top %d processes (sorted by %s delay):\n",
 			cfg.max_processes, get_sort_field(cfg.sort_field));
@@ -944,11 +956,73 @@ static void display_results(void)
 		perror("Error writing to output");
 }

+/* Check for keyboard input with timeout based on cfg.delay */
+static char check_for_keypress(void)
+{
+	struct timeval tv = {cfg.delay, 0};
+	fd_set readfds;
+	char ch = 0;
+
+	FD_ZERO(&readfds);
+	FD_SET(STDIN_FILENO, &readfds);
+	int r = select(STDIN_FILENO + 1, &readfds, NULL, NULL, &tv);
+
+	if (r > 0 && FD_ISSET(STDIN_FILENO, &readfds)) {
+		read(STDIN_FILENO, &ch, 1);
+		return ch;
+	}
+
+	return 0;
+}
+
+/* Handle keyboard input: sorting selection, mode toggle, or quit */
+static void handle_keypress(char ch, int *running)
+{
+	if (sort_selected) {
+		switch (ch) {
+		case 'c':
+		case 'i':
+		case 'q':
+		case 'm':
+			cfg.sort_field = ch;
+			break;
+		/* Only for memory verbose mode */
+		case 's':
+		case 'r':
+		case 't':
+		case 'p':
+		case 'w':
+			if (cfg.mem_verbose_mode)
+				cfg.sort_field = ch;
+			break;
+		default:
+			break;
+		}
+		sort_selected = 0;
+	} else {
+		switch (ch) {
+		case 'o':
+			sort_selected = 1;
+			break;
+		case 'M':
+			cfg.mem_verbose_mode = !cfg.mem_verbose_mode;
+			cfg.sort_field = 'c'; /* Change to default sort mode */
+			break;
+		case 'q':
+		case 'Q':
+			*running = 0;
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 /* Main function */
 int main(int argc, char **argv)
 {
 	int iterations = 0;
-	int use_q_quit = 0;
+	char keypress;

 	/* Parse command line arguments */
 	parse_args(argc, argv);
@@ -968,12 +1042,8 @@ int main(int argc, char **argv)
 		exit(1);
 	}

-	if (!cfg.output_one_time) {
-		use_q_quit = 1;
-		enable_raw_mode();
-		printf("Press 'q' to quit.\n");
-		fflush(stdout);
-	}
+	/* Set terminal to non-canonical mode for interaction */
+	enable_raw_mode();

 	/* Main loop */
 	while (running) {
@@ -1001,32 +1071,14 @@ int main(int argc, char **argv)
 		if (cfg.output_one_time)
 			break;

-		/* Check for 'q' key to quit */
-		if (use_q_quit) {
-			struct timeval tv = {cfg.delay, 0};
-			fd_set readfds;
-
-			FD_ZERO(&readfds);
-			FD_SET(STDIN_FILENO, &readfds);
-			int r = select(STDIN_FILENO+1, &readfds, NULL, NULL, &tv);
-
-			if (r > 0 && FD_ISSET(STDIN_FILENO, &readfds)) {
-				char ch = 0;
-
-				read(STDIN_FILENO, &ch, 1);
-				if (ch == 'q' || ch == 'Q') {
-					running = 0;
-					break;
-				}
-			}
-		} else {
-			sleep(cfg.delay);
-		}
+		/* Keypress for interactive usage */
+		keypress = check_for_keypress();
+		if (keypress)
+			handle_keypress(keypress, &running);
 	}

 	/* Restore terminal mode */
-	if (use_q_quit)
-		disable_raw_mode();
+	disable_raw_mode();

 	/* Cleanup */
 	close(nl_sd);
-- 
2.25.1

