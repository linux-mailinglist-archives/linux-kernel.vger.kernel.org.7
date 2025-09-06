Return-Path: <linux-kernel+bounces-804367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC16B473E2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B26A45216
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B095F24111D;
	Sat,  6 Sep 2025 16:14:41 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF041DDE9;
	Sat,  6 Sep 2025 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757175281; cv=none; b=Okt23ikyQyiBgcMZJm9nYf10lM9C9TzUGOE1Ziy+SVGdAjTEBpLXwr+m1dEiTOLV5Urd0v8JG5TMKwE8E3dKapFzfzhuCO0plO+06E/Q7a5ZrzJbj6yaO+rZGAini1SEKew36LU24UXyR5Te6jkceRAYj6lJlQKYqm/ag1u2ANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757175281; c=relaxed/simple;
	bh=gYjed6G+nWlzA/HwYJOGqC15hyaQB/MDxR31cpFhYg4=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=jFe8pXoB+Gg9+ZWLICiF8xTd3rwG4Y1ULOhBRrVUctwq/IUxWi9MOnoapMs71uh0wddh8cJ1q4Cl7vIfpEpAKgL5Ck9GEdruc/zi3X2dIg52RQTYV+OUaoQ/2q7Mw4qW2+7BOQAvJEtoY3ZHAhPsO2in8El2bZvmSy8CYM1VMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cJyw800xBz8Xs6w;
	Sun, 07 Sep 2025 00:14:32 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 586GEDBJ035044;
	Sun, 7 Sep 2025 00:14:13 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 7 Sep 2025 00:14:17 +0800 (CST)
Date: Sun, 7 Sep 2025 00:14:17 +0800 (CST)
X-Zmail-TransId: 2afc68bc5dd9d62-30d7d
X-Mailer: Zmail v1.0
Message-ID: <20250907001417537vSx6nUsb3ILqI0iQ-WnGp@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIdjIgbGludXgtbmV4dCA0LzVdIHRvb2xzL2RlbGF5dG9wOiBJbXByb3ZlIGVycm9yIGhhbmRsaW5nIGZvciBtaXNzaW5nIFBTSSBzdXBwb3J0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 586GEDBJ035044
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sun, 07 Sep 2025 00:14:32 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68BC5DE7.001/4cJyw800xBz8Xs6w

From: Fan Yu <fan.yu9@zte.com.cn>

Enhanced display logic to conditionally show PSI information only
when successfully read, with helpful guidance for users to enable
PSI support (psi=1 cmdline parameter).

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
 tools/accounting/delaytop.c | 182 +++++++++++++++++++++++-------------
 1 file changed, 116 insertions(+), 66 deletions(-)

diff --git a/tools/accounting/delaytop.c b/tools/accounting/delaytop.c
index 7bd1a1eeb354..72cc500b44b1 100644
--- a/tools/accounting/delaytop.c
+++ b/tools/accounting/delaytop.c
@@ -44,13 +44,11 @@
 #include <linux/cgroupstats.h>
 #include <stddef.h>

-#define PSI_CPU_SOME "/proc/pressure/cpu"
-#define PSI_CPU_FULL	"/proc/pressure/cpu"
-#define PSI_MEMORY_SOME "/proc/pressure/memory"
-#define PSI_MEMORY_FULL "/proc/pressure/memory"
-#define PSI_IO_SOME "/proc/pressure/io"
-#define PSI_IO_FULL "/proc/pressure/io"
-#define PSI_IRQ_FULL	"/proc/pressure/irq"
+#define PSI_PATH	"/proc/pressure"
+#define PSI_CPU_PATH	"/proc/pressure/cpu"
+#define PSI_MEMORY_PATH	"/proc/pressure/memory"
+#define PSI_IO_PATH	"/proc/pressure/io"
+#define PSI_IRQ_PATH	"/proc/pressure/irq"

 #define NLA_NEXT(na)			((struct nlattr *)((char *)(na) + NLA_ALIGN((na)->nla_len)))
 #define NLA_DATA(na)			((void *)((char *)(na) + NLA_HDRLEN))
@@ -499,87 +497,134 @@ static int get_family_id(int sd)
 	return id;
 }

-static void read_psi_stats(void)
+static int read_psi_stats(void)
 {
 	FILE *fp;
 	char line[256];
 	int ret = 0;
+	int error_count = 0;
+
+	/* Check if PSI path exists */
+	if (access(PSI_PATH, F_OK) != 0) {
+		fprintf(stderr, "Error: PSI interface not found at %s\n", PSI_PATH);
+		fprintf(stderr, "Please ensure your kernel supports PSI (Pressure Stall Information)\n");
+		return -1;
+	}
+
 	/* Zero all fields */
 	memset(&psi, 0, sizeof(psi));
+
 	/* CPU pressure */
-	fp = fopen(PSI_CPU_SOME, "r");
+	fp = fopen(PSI_CPU_PATH, "r");
 	if (fp) {
 		while (fgets(line, sizeof(line), fp)) {
 			if (strncmp(line, "some", 4) == 0) {
 				ret = sscanf(line, "some avg10=%lf avg60=%lf avg300=%lf total=%llu",
 							&psi.cpu_some_avg10, &psi.cpu_some_avg60,
 							&psi.cpu_some_avg300, &psi.cpu_some_total);
-				if (ret != 4)
+				if (ret != 4) {
 					fprintf(stderr, "Failed to parse CPU some PSI data\n");
+					error_count++;
+				}
 			} else if (strncmp(line, "full", 4) == 0) {
 				ret = sscanf(line, "full avg10=%lf avg60=%lf avg300=%lf total=%llu",
 						&psi.cpu_full_avg10, &psi.cpu_full_avg60,
 						&psi.cpu_full_avg300, &psi.cpu_full_total);
-				if (ret != 4)
+				if (ret != 4) {
 					fprintf(stderr, "Failed to parse CPU full PSI data\n");
+					error_count++;
+				}
 			}
 		}
 		fclose(fp);
+	} else {
+		fprintf(stderr, "Warning: Failed to open %s\n", PSI_CPU_PATH);
+		error_count++;
 	}
+
 	/* Memory pressure */
-	fp = fopen(PSI_MEMORY_SOME, "r");
+	fp = fopen(PSI_MEMORY_PATH, "r");
 	if (fp) {
 		while (fgets(line, sizeof(line), fp)) {
 			if (strncmp(line, "some", 4) == 0) {
 				ret = sscanf(line, "some avg10=%lf avg60=%lf avg300=%lf total=%llu",
 						&psi.memory_some_avg10, &psi.memory_some_avg60,
 						&psi.memory_some_avg300, &psi.memory_some_total);
-				if (ret != 4)
+				if (ret != 4) {
 					fprintf(stderr, "Failed to parse Memory some PSI data\n");
+					error_count++;
+				}
 			} else if (strncmp(line, "full", 4) == 0) {
 				ret = sscanf(line, "full avg10=%lf avg60=%lf avg300=%lf total=%llu",
 						&psi.memory_full_avg10, &psi.memory_full_avg60,
 						&psi.memory_full_avg300, &psi.memory_full_total);
-			}
-				if (ret != 4)
+				if (ret != 4) {
 					fprintf(stderr, "Failed to parse Memory full PSI data\n");
+					error_count++;
+				}
+			}
 		}
 		fclose(fp);
+	} else {
+		fprintf(stderr, "Warning: Failed to open %s\n", PSI_MEMORY_PATH);
+		error_count++;
 	}
+
 	/* IO pressure */
-	fp = fopen(PSI_IO_SOME, "r");
+	fp = fopen(PSI_IO_PATH, "r");
 	if (fp) {
 		while (fgets(line, sizeof(line), fp)) {
 			if (strncmp(line, "some", 4) == 0) {
 				ret = sscanf(line, "some avg10=%lf avg60=%lf avg300=%lf total=%llu",
 						&psi.io_some_avg10, &psi.io_some_avg60,
 						&psi.io_some_avg300, &psi.io_some_total);
-				if (ret != 4)
+				if (ret != 4) {
 					fprintf(stderr, "Failed to parse IO some PSI data\n");
+					error_count++;
+				}
 			} else if (strncmp(line, "full", 4) == 0) {
 				ret = sscanf(line, "full avg10=%lf avg60=%lf avg300=%lf total=%llu",
 						&psi.io_full_avg10, &psi.io_full_avg60,
 						&psi.io_full_avg300, &psi.io_full_total);
-				if (ret != 4)
+				if (ret != 4) {
 					fprintf(stderr, "Failed to parse IO full PSI data\n");
+					error_count++;
+				}
 			}
 		}
 		fclose(fp);
+	} else {
+		fprintf(stderr, "Warning: Failed to open %s\n", PSI_IO_PATH);
+		error_count++;
 	}
+
 	/* IRQ pressure (only full) */
-	fp = fopen(PSI_IRQ_FULL, "r");
+	fp = fopen(PSI_IRQ_PATH, "r");
 	if (fp) {
 		while (fgets(line, sizeof(line), fp)) {
 			if (strncmp(line, "full", 4) == 0) {
 				ret = sscanf(line, "full avg10=%lf avg60=%lf avg300=%lf total=%llu",
 						&psi.irq_full_avg10, &psi.irq_full_avg60,
 						&psi.irq_full_avg300, &psi.irq_full_total);
-				if (ret != 4)
+				if (ret != 4) {
 					fprintf(stderr, "Failed to parse IRQ full PSI data\n");
+					error_count++;
+				}
 			}
 		}
 		fclose(fp);
+	} else {
+		fprintf(stderr, "Warning: Failed to open %s\n", PSI_IRQ_PATH);
+		error_count++;
 	}
+
+	/* Return error count: 0 means success, >0 means warnings, -1 means fatal error */
+	if (error_count > 0) {
+		fprintf(stderr, "PSI stats reading completed with %d warnings\n", error_count);
+		return error_count;
+	}
+
+	return 0;
 }

 static int read_comm(int pid, char *comm_buf, size_t buf_size)
@@ -820,7 +865,7 @@ static void get_container_stats(void)
 }

 /* Display results to stdout or log file */
-static void display_results(void)
+static void display_results(int psi_ret)
 {
 	time_t now = time(NULL);
 	struct tm *tm_now = localtime(&now);
@@ -833,49 +878,53 @@ static void display_results(void)
 	suc &= BOOL_FPRINT(out, "\033[H\033[J");

 	/* PSI output (one-line, no cat style) */
-	suc &= BOOL_FPRINT(out, "System Pressure Information: (avg10/avg60/avg300/total)\n");
-	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
-		"CPU some:",
-		psi.cpu_some_avg10,
-		psi.cpu_some_avg60,
-		psi.cpu_some_avg300,
-		psi.cpu_some_total / 1000);
-	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
-		"CPU full:",
-		psi.cpu_full_avg10,
-		psi.cpu_full_avg60,
-		psi.cpu_full_avg300,
-		psi.cpu_full_total / 1000);
-	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
-		"Memory full:",
-		psi.memory_full_avg10,
-		psi.memory_full_avg60,
-		psi.memory_full_avg300,
-		psi.memory_full_total / 1000);
-	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
-		"Memory some:",
-		psi.memory_some_avg10,
-		psi.memory_some_avg60,
-		psi.memory_some_avg300,
-		psi.memory_some_total / 1000);
-	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
-		"IO full:",
-		psi.io_full_avg10,
-		psi.io_full_avg60,
-		psi.io_full_avg300,
-		psi.io_full_total / 1000);
-	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
-		"IO some:",
-		psi.io_some_avg10,
-		psi.io_some_avg60,
-		psi.io_some_avg300,
-		psi.io_some_total / 1000);
-	suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
-		"IRQ full:",
-		psi.irq_full_avg10,
-		psi.irq_full_avg60,
-		psi.irq_full_avg300,
-		psi.irq_full_total / 1000);
+	suc &= BOOL_FPRINT(out, "System Pressure Information: (avg10/avg60vg300/total)\n");
+	if (psi_ret) {
+		suc &= BOOL_FPRINT(out, "  PSI not found: check if psi=1 enabled in cmdline\n");
+	} else {
+		suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+			"CPU some:",
+			psi.cpu_some_avg10,
+			psi.cpu_some_avg60,
+			psi.cpu_some_avg300,
+			psi.cpu_some_total / 1000);
+		suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+			"CPU full:",
+			psi.cpu_full_avg10,
+			psi.cpu_full_avg60,
+			psi.cpu_full_avg300,
+			psi.cpu_full_total / 1000);
+		suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+			"Memory full:",
+			psi.memory_full_avg10,
+			psi.memory_full_avg60,
+			psi.memory_full_avg300,
+			psi.memory_full_total / 1000);
+		suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+			"Memory some:",
+			psi.memory_some_avg10,
+			psi.memory_some_avg60,
+			psi.memory_some_avg300,
+			psi.memory_some_total / 1000);
+		suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+			"IO full:",
+			psi.io_full_avg10,
+			psi.io_full_avg60,
+			psi.io_full_avg300,
+			psi.io_full_total / 1000);
+		suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+			"IO some:",
+			psi.io_some_avg10,
+			psi.io_some_avg60,
+			psi.io_some_avg300,
+			psi.io_some_total / 1000);
+		suc &= BOOL_FPRINT(out, PSI_LINE_FORMAT,
+			"IRQ full:",
+			psi.irq_full_avg10,
+			psi.irq_full_avg60,
+			psi.irq_full_avg300,
+			psi.irq_full_total / 1000);
+	}

 	if (cfg.container_path) {
 		suc &= BOOL_FPRINT(out, "Container Information (%s):\n", cfg.container_path);
@@ -1017,6 +1066,7 @@ int main(int argc, char **argv)
 {
 	const struct field_desc *field;
 	int iterations = 0;
+	int psi_ret = 0;
 	char keypress;

 	/* Parse command line arguments */
@@ -1054,7 +1104,7 @@ int main(int argc, char **argv)
 		}

 		/* Read PSI statistics */
-		read_psi_stats();
+		psi_ret = read_psi_stats();

 		/* Get container stats if container path provided */
 		if (cfg.container_path)
@@ -1067,7 +1117,7 @@ int main(int argc, char **argv)
 		sort_tasks();

 		/* Display results to stdout or log file */
-		display_results();
+		display_results(psi_ret);

 		/* Check for iterations */
 		if (cfg.iterations > 0 && ++iterations >= cfg.iterations)
-- 
2.25.1

