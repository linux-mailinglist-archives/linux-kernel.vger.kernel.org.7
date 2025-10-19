Return-Path: <linux-kernel+bounces-859811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A38BEEA84
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 19:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68F394E2682
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB721FDE31;
	Sun, 19 Oct 2025 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dZVAU+N/"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C718D658
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760893811; cv=none; b=Mnixh3N2eAB0s0EJgFLX7Z5ERtyyym6YlhoNiebm5hUdJ33C5r9ny8Wo79jSBRbyOn04YiI0LCUZsrP+1dfz7LnnCFo9RxnpZWcfyMCJEm/q59atInok1fOe0G40MNKQkeFqKHSMSwT+LOquJlIwKgTufUNTkgoYr5yjl3ksTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760893811; c=relaxed/simple;
	bh=axv3IynF8jD/qtMrGTIUiuxEKdXGiWyUXpW8zuyjiTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YSJ0E6AAMwTHYjfTFa2NFdQRV+tJMrsimxTfAa/QsyorP/B3r3FiEz42gjjH5YffpYVkWut8iIZIutdfZDCEC+5KBmgMPaG4yMLJLqkNLS2i8HqMjB3nXUGCQCiEdkUXj4m5QFYgFnXc63PpDWLoHzKI2QiauifPil0h+3svqZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dZVAU+N/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290a3a4c7ecso38469565ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760893806; x=1761498606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kw8cZwIOPrVIgejN5sHE4Bw2UxALtEM7IC+3mySrS9A=;
        b=dZVAU+N/y2139Mo6xgei5j+/BrRC0oenaI3PdmMRalt5sPx1SoOZ73muAgjP2TvmK9
         523ZDIsFArar9O/9G1Qr1HNFhAmKh2SsTuUaCh/AG75G9ajRfOTVCgwcylnrXf4+CBDN
         qpF9OdZHmKezSFuQgqmDRyikpyHiAO3zdfor4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760893806; x=1761498606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kw8cZwIOPrVIgejN5sHE4Bw2UxALtEM7IC+3mySrS9A=;
        b=wa8qsEDlara3GBjtXf2b44R88E4aP92E7NUPk3+1y/kkD5nyKnFsBiZUd2HJz45nha
         RQ/YbGNi6PJm1KN3LX1wFauDXk5AADuPoADPYjng72wX37m53OtLOhiH7lTfIkzohWJA
         /UCm9JO+zwMU2qKXk9oD8xjHov4KLIbzjak1b8Z8INyFoVhqI7BO9YcvSFn9Nabk/iNF
         wWQ6bsIzmE1b2Rnw5XpN6pbS0VoYs93Xs8ahdJ7TbOhtkVprK16aOjnzizhuA1C2s1XO
         A6gtp5AgSLSLfLg1DNLCBOMB5TaAr6QakyH1aGAmEBstG5Pi+FO1xAOznIMXyByMBJpZ
         F4HA==
X-Gm-Message-State: AOJu0YweGSwCX8hygCjn9NPdfX9VLCKeHFh4wqaFpxfgSHvANV7/wmHG
	B0fMn7CXC4YNmLqhw92TOh3mkaurU8KAEp+bewb2vrwVafIL1lYBRKj0eyU0Re8XqfpEcisfiE0
	VyXQ=
X-Gm-Gg: ASbGncuml5qkO2Hx/GlmGV6LelhtXRZzXhbmTXoLTvnoIE98+q3+qN5JkfeC3H0hqXb
	oCFRPxQNVQT/r9ufGYducJSxGq8K3/fwWQ/b+wUS0KO8/GpoUGN39qwFVBZxv+T/ZfsL+2X6FyN
	oRMrvEos65XzGyZqth4ZyPtoju3mGJZpclfp5BuVLeKIrYLycTqsgL3vrzg16+sLOKgdi8JRtBb
	qwU0EbDKz1+Dp0dcQOtp5daliSNzHtyAMFnolav9t5de9odJ4d+YhKFbocvUesKqV14DgPMuBFY
	11LEPJGGK9KNwj2eTfzEkivn6GNMaGYs+gkPqz3cLx3d59pGtw9kfwTdkpRZ9/OE6IHnMBdjTK7
	ABzybEk+Dx2ApYxB75p/Ax+Cl+zjV0a3uTdr+qrBzGcAyp06ueJ8gjjBQJHOB/pflpc2LxStiej
	GmlhfJrIqgNil0D9rxKwS+06TuvVVdhPWuokH06p7qm0NROtRwqNDSU3Z2Y7/PRyfs4Mc8b+6vA
	V6sDzCN
X-Google-Smtp-Source: AGHT+IGKb+CPS36m7qbjY80HNVBuhh0qqpwxjQVrHeJkI77/8o6qntbEGsx2SiZgeZCIKkbmEUms+w==
X-Received: by 2002:a17:902:f706:b0:269:6e73:b90a with SMTP id d9443c01a7336-290c9ca6b11mr119133815ad.15.1760893805940;
        Sun, 19 Oct 2025 10:10:05 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:28c6:96de:a138:88c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924721980bsm57079245ad.110.2025.10.19.10.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 10:10:04 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Chant <achant@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Francesco Valla <francesco@valla.it>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH] init/main.c: Wrap long kernel cmdline when printing to logs
Date: Sun, 19 Oct 2025 10:06:14 -0700
Message-ID: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel cmdline length is allowed to be longer than what printk can
handle. When this happens the cmdline that's printed to the kernel
ring buffer at bootup is cutoff and some kernel cmdline options are
"hidden" from the logs. This undercuts the usefulness of the log
message.

Add wrapping to the printout. Allow wrapping to be set lower by a
Kconfig knob "CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN". By default, the
wrapping is set to 1021 characters, which is measured to be the
current maximum that pr_notice() can handle. Anyone whose cmdline
isn't being cut off today should see no difference in log output.

Wrapping is based on spaces, ignoring quotes. All lines are prefixed
with "Kernel command line: " and lines that are not the last line have
a " \" suffix added to them. The prefix and suffix count towards the
line length for wrapping purposes. The ideal length will be exceeded
if no appropriate place to wrap is found.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 init/Kconfig | 10 +++++++
 init/main.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49..905b2ece4127 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1512,6 +1512,16 @@ config BOOT_CONFIG_EMBED_FILE
 	  This bootconfig will be used if there is no initrd or no other
 	  bootconfig in the initrd.
 
+config CMDLINE_LOG_WRAP_IDEAL_LEN
+	int "Length to try to wrap the cmdline when logged at boot"
+	default 1021
+	range 40 1021
+	help
+	  At boot time, the kernel command line is logged to the console.
+	  It will attempt to be wrapped at this many characters. If there
+	  are more than this many non-space characters in a row, log lines
+	  may exceed this ideal maximum length.
+
 config INITRAMFS_PRESERVE_MTIME
 	bool "Preserve cpio archive mtimes in initramfs"
 	depends on BLK_DEV_INITRD
diff --git a/init/main.c b/init/main.c
index 07a3116811c5..0adc1575a2cb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -906,6 +906,87 @@ static void __init early_numa_node_init(void)
 #endif
 }
 
+#define KERNEL_CMDLINE_PREFIX		"Kernel command line: "
+#define KERNEL_CMDLINE_PREFIX_LEN	(sizeof(KERNEL_CMDLINE_PREFIX) - 1)
+#define KERNEL_CMDLINE_CONTINUATION	" \\"
+#define KERNEL_CMDLINE_CONTINUATION_LEN	(sizeof(KERNEL_CMDLINE_CONTINUATION) - 1)
+
+#define IDEAL_CMDLINE_LEN		(CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN - \
+					 KERNEL_CMDLINE_PREFIX_LEN)
+#define IDEAL_CMDLINE_SPLIT_LEN		(IDEAL_CMDLINE_LEN - KERNEL_CMDLINE_CONTINUATION_LEN)
+
+/**
+ * print_kernel_cmdline() - Print the kernel cmdline with wrapping.
+ * @cmdline: The cmdline to print.
+ *
+ * Print the kernel command line, trying to wrap based on the Kconfig knob
+ * CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN.
+ *
+ * Wrapping is based on spaces, ignoring quotes. All lines are prefixed
+ * with "Kernel command line: " and lines that are not the last line have
+ * a " \" suffix added to them. The prefix and suffix count towards the
+ * line length for wrapping purposes. The ideal length will be exceeded
+ * if no appropriate place to wrap is found.
+ *
+ * Example output if CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN is 40:
+ *   Kernel command line: loglevel=7 \
+ *   Kernel command line: init=/sbin/init \
+ *   Kernel command line: root=PARTUUID=8c3efc1a-768b-6642-8d0c-89eb782f19f0/PARTNROFF=1 \
+ *   Kernel command line: rootwait ro \
+ *   Kernel command line: my_quoted_arg="The \
+ *   Kernel command line: quick brown fox \
+ *   Kernel command line: jumps over the \
+ *   Kernel command line: lazy dog."
+ */
+static void print_kernel_cmdline(const char *cmdline)
+{
+	size_t len = strlen(cmdline);
+
+	while (len > IDEAL_CMDLINE_LEN) {
+		const char *first_space;
+		const char *prev_cutoff;
+		const char *cutoff;
+		int to_print;
+		size_t used;
+
+		/* Find the last ' ' that wouldn't make the line too long */
+		prev_cutoff = NULL;
+		cutoff = cmdline;
+		while (true) {
+			cutoff = strchr(cutoff + 1, ' ');
+			if (!cutoff || cutoff - cmdline > IDEAL_CMDLINE_SPLIT_LEN)
+				break;
+			prev_cutoff = cutoff;
+		}
+		if (prev_cutoff)
+			cutoff = prev_cutoff;
+		else if (!cutoff)
+			break;
+
+		/* Find the beginning and end of the string of spaces */
+		first_space = cutoff;
+		while (first_space > cmdline && first_space[-1] == ' ')
+			first_space--;
+		to_print = first_space - cmdline;
+		while (*cutoff == ' ')
+			cutoff++;
+		used = cutoff - cmdline;
+
+		/* If the whole string is used, break and do the final printout */
+		if (len == used)
+			break;
+
+		if (to_print)
+			pr_notice("%s%.*s%s\n", KERNEL_CMDLINE_PREFIX,
+				  to_print, cmdline, KERNEL_CMDLINE_CONTINUATION);
+
+		len -= used;
+		cmdline += used;
+	}
+	if (len)
+		pr_notice("%s%s\n", KERNEL_CMDLINE_PREFIX, cmdline);
+}
+
 asmlinkage __visible __init __no_sanitize_address __noreturn __no_stack_protector
 void start_kernel(void)
 {
@@ -942,7 +1023,7 @@ void start_kernel(void)
 	early_numa_node_init();
 	boot_cpu_hotplug_init();
 
-	pr_notice("Kernel command line: %s\n", saved_command_line);
+	print_kernel_cmdline(saved_command_line);
 	/* parameters may set static keys */
 	parse_early_param();
 	after_dashes = parse_args("Booting kernel",
-- 
2.51.0.858.gf9c4a03a3a-goog


