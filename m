Return-Path: <linux-kernel+bounces-804366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C66CB473DA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D6C04E057A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45E724111D;
	Sat,  6 Sep 2025 16:13:49 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F321C863B;
	Sat,  6 Sep 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757175229; cv=none; b=lPGyWnIR+nEKPwfbFqtxMfDAevHi6k5YUYepPpThhCNcZPhCQ3Tw9gAv2+mSSXUj1zNaN3B8dw8jzY6N1kDBW5LiVNSxY7Qlx+rOnfPF5TxUeh5gDNJJoADlqUvYaHs81JedCVNVbxzBUKB0Jol5a2M8oKgNYiflTzmaJwlTW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757175229; c=relaxed/simple;
	bh=qjIAY2ocBBeJktL3RCCX7Wqjw7fa4i517ZZ8/TPxJJ0=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=ql4RdRGjL47kHjME8GgXe1OHo//uNqOtCpBAwXR5nJCd4INPepdVPpBXERuBeX+rxKot69vAHJSiu0UuJF2wwUnMiZ5aIQnADWlxXH26Q6CgnFmr35LPUuod1UCAvZGo9cBkx06g/1xj0S6Pv9ucXGpyNul8UHAcVa5hfd3QGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cJyvD1w0qz5BNRd;
	Sun, 07 Sep 2025 00:13:44 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 586GDaGH010892;
	Sun, 7 Sep 2025 00:13:37 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 7 Sep 2025 00:13:38 +0800 (CST)
Date: Sun, 7 Sep 2025 00:13:38 +0800 (CST)
X-Zmail-TransId: 2afb68bc5db267c-36691
X-Mailer: Zmail v1.0
Message-ID: <20250907001338580EURha20BxWFmBSrUpS8D1@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIdjIgbGludXgtbmV4dCAzLzVdIHRvb2xzL2RlbGF5dG9wOiBhZGQgaW50ZXJhY3RpdmUgbW9kZSB3aXRoIGtleWJvYXJkIGNvbnRyb2xz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 586GDaGH010892
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Sun, 07 Sep 2025 00:13:44 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68BC5DB8.000/4cJyvD1w0qz5BNRd

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
 tools/accounting/delaytop.c | 166 ++++++++++++++++++++++++++----------
 1 file changed, 121 insertions(+), 45 deletions(-)

diff --git a/tools/accounting/delaytop.c b/tools/accounting/delaytop.c
index 30dc95fb531a..7bd1a1eeb354 100644
--- a/tools/accounting/delaytop.c
+++ b/tools/accounting/delaytop.c
@@ -73,8 +73,8 @@
 #define PSI_LINE_FORMAT "%-12s %6.1f%%/%6.1f%%/%6.1f%%/%8llu(ms)\n"
 #define DELAY_FMT_DEFAULT "%8.2f %8.2f %8.2f %8.2f\n"
 #define DELAY_FMT_MEMVERBOSE "%8.2f %8.2f %8.2f %8.2f %8.2f %8.2f\n"
-#define SORT_FIELD(name, modes) \
-	{#name, \
+#define SORT_FIELD(name, cmd, modes) \
+	{#name, #cmd, \
 	offsetof(struct task_info, name##_delay_total), \
 	offsetof(struct task_info, name##_count), \
 	modes}
@@ -140,6 +140,7 @@ struct container_stats {
 /* Delay field structure */
 struct field_desc {
 	const char *name;	/* Field name for cmdline argument */
+	const char *cmd_char;	/* Interactive command */
 	unsigned long total_offset; /* Offset of total delay in task_info */
 	unsigned long count_offset; /* Offset of count in task_info */
 	size_t supported_modes; /* Supported display modes */
@@ -165,17 +166,18 @@ static int task_count;
 static int running = 1;
 static struct container_stats container_stats;
 static const struct field_desc sort_fields[] = {
-	SORT_FIELD(cpu,		MODE_DEFAULT),
-	SORT_FIELD(blkio,	MODE_DEFAULT),
-	SORT_FIELD(irq,		MODE_DEFAULT),
-	SORT_FIELD(mem,		MODE_DEFAULT | MODE_MEMVERBOSE),
-	SORT_FIELD(swapin,	MODE_MEMVERBOSE),
-	SORT_FIELD(freepages,	MODE_MEMVERBOSE),
-	SORT_FIELD(thrashing,	MODE_MEMVERBOSE),
-	SORT_FIELD(compact,	MODE_MEMVERBOSE),
-	SORT_FIELD(wpcopy,	MODE_MEMVERBOSE),
+	SORT_FIELD(cpu,		c,	MODE_DEFAULT),
+	SORT_FIELD(blkio,	i,	MODE_DEFAULT),
+	SORT_FIELD(irq,		q,	MODE_DEFAULT),
+	SORT_FIELD(mem,		m,	MODE_DEFAULT | MODE_MEMVERBOSE),
+	SORT_FIELD(swapin,	s,	MODE_MEMVERBOSE),
+	SORT_FIELD(freepages,	r,	MODE_MEMVERBOSE),
+	SORT_FIELD(thrashing,	t,	MODE_MEMVERBOSE),
+	SORT_FIELD(compact,	p,	MODE_MEMVERBOSE),
+	SORT_FIELD(wpcopy,	w,	MODE_MEMVERBOSE),
 	END_FIELD
 };
+static int sort_selected;

 /* Netlink socket variables */
 static int nl_sd = -1;
@@ -197,6 +199,19 @@ static void disable_raw_mode(void)
 	tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_termios);
 }

+/* Find field descriptor by command line */
+static const struct field_desc *get_field_by_cmd_char(char ch)
+{
+	const struct field_desc *field;
+
+	for (field = sort_fields; field->name != NULL; field++) {
+		if (field->cmd_char[0] == ch)
+			return field;
+	}
+
+	return NULL;
+}
+
 /* Find field descriptor by name with string comparison */
 static const struct field_desc *get_field_by_name(const char *name)
 {
@@ -870,6 +885,18 @@ static void display_results(void)
 			container_stats.nr_stopped, container_stats.nr_uninterruptible,
 			container_stats.nr_io_wait);
 	}
+
+	/* Interacive command */
+	suc &= BOOL_FPRINT(out, "[o]sort [M]memverbose [q]quit\n");
+	if (sort_selected) {
+		if (cfg.display_mode == MODE_MEMVERBOSE)
+			suc &= BOOL_FPRINT(out,
+				"sort selection: [m]MEM [r]RCL [t]THR [p]CMP [w]WP\n");
+		else
+			suc &= BOOL_FPRINT(out,
+				"sort selection: [c]CPU [i]IO [m]MEM [q]IRQ\n");
+	}
+
 	/* Task delay output */
 	suc &= BOOL_FPRINT(out, "Top %d processes (sorted by %s delay):\n",
 			cfg.max_processes, get_name_by_field(cfg.sort_field));
@@ -919,11 +946,78 @@ static void display_results(void)
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
+#define MAX_MODE_SIZE 2
+static void toggle_display_mode(void)
+{
+	static const size_t modes[MAX_MODE_SIZE] = {MODE_DEFAULT, MODE_MEMVERBOSE};
+	static size_t cur_index;
+
+	cur_index = (cur_index + 1) % MAX_MODE_SIZE;
+	cfg.display_mode = modes[cur_index];
+}
+
+/* Handle keyboard input: sorting selection, mode toggle, or quit */
+static void handle_keypress(char ch, int *running)
+{
+	const struct field_desc *field;
+
+	/* Change sort field */
+	if (sort_selected) {
+		field = get_field_by_cmd_char(ch);
+		if (field && (field->supported_modes & cfg.display_mode))
+			cfg.sort_field = field;
+
+		sort_selected = 0;
+	/* Handle mode changes or quit */
+	} else {
+		switch (ch) {
+		case 'o':
+			sort_selected = 1;
+			break;
+		case 'M':
+			toggle_display_mode();
+			for (field = sort_fields; field->name != NULL; field++) {
+				if (field->supported_modes & cfg.display_mode) {
+					cfg.sort_field = field;
+					break;
+				}
+			}
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
+	const struct field_desc *field;
 	int iterations = 0;
-	int use_q_quit = 0;
+	char keypress;

 	/* Parse command line arguments */
 	parse_args(argc, argv);
@@ -943,20 +1037,20 @@ int main(int argc, char **argv)
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
-		/* Exit when sort field do not match display mode */
+		/* Auto-switch sort field when not matching display mode */
 		if (!(cfg.sort_field->supported_modes & cfg.display_mode)) {
-			fprintf(stderr, "Sort field not supported in this mode\n");
-			display_available_fields(cfg.display_mode);
-			break;
+			for (field = sort_fields; field->name != NULL; field++) {
+				if (field->supported_modes & cfg.display_mode) {
+					cfg.sort_field = field;
+					printf("Auto-switched sort field to: %s\n", field->name);
+					break;
+				}
+			}
 		}

 		/* Read PSI statistics */
@@ -983,32 +1077,14 @@ int main(int argc, char **argv)
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

