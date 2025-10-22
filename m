Return-Path: <linux-kernel+bounces-863910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A1BF97D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A423C1888654
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCAF1C4A24;
	Wed, 22 Oct 2025 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AE876gno"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792EE1A3154
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093680; cv=none; b=s6Cqaf/fGPxwuvTfUqqxp7McQn79piYmPdu+NTkMBqs7jkw8tyZR4jihMpwj4a/xgonu8zkXXwpQEmaDwTeQWIJ5Hnl+nzgD1UJ16eK0jE4m1nkYevOr7RnPwPWPalu052MmgF9Ik8uyv2nmYCaAA6igsQaIR0AFsnL7xqwXjjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093680; c=relaxed/simple;
	bh=TyGxxPZmvW7pzQW51SpvPF4+tI/TQ5YOSadbcuPIfDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qhkMBfR9Ibp6D76W919gSjCSTvRSjnX0+mF99xdqgwJwp/4GUGxP5rw3Tvw6KUaMtp9Qh7sm8UAaFZP+oYncRlB2EabSWNei3RZzNKp8L35dwPWhIoDfKyWNK369blEtevQufBHe+H9In6huMHuxvwsE5r7vq5sbR6VzhpVO71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AE876gno; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33067909400so4794296a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761093677; x=1761698477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6dfzjaiaVtqKR1q20BH9Mi7/4Fk6B7qT1IK5wGL940=;
        b=AE876gno77uV/wKEIIu3gLHaGI60Un2iv6M2GjHeCvmzvxJHF6X3mj2AkZZhKJzYqb
         e+jZKRAIXCoPZWFexno5z4iiOTOW4x6Faww9ngrFFWtAHdtw1L9xA6lwVFNEenZZASuu
         YFdCJ6+A6TBf6x1rCTUIAgV8akCTB1AYqSk5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761093677; x=1761698477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6dfzjaiaVtqKR1q20BH9Mi7/4Fk6B7qT1IK5wGL940=;
        b=s0wda0mEhhLEvBrwt0gddxcpPpbpXA51WBk4y2VVzCEVZb/5dQDemjmoIT7FX/aVfK
         zCdU+xYRR2LO48F5aUYKZ9tZt+QbbjhifjqA5/C/bC5tjg4pdP/ZTEzrK0c8KVqIrCiB
         t+HjZDUVqb9tFbpu7qKe6JUsfJZo41ZeqC9bbvtiOmpNT7KhGyUQkMSkvshN5DTRZmXt
         NplhHTL8BL1gm8i6jPvgzVQGHGlPtIzEt2AcBxbnJ/I98GEUMFEhWrzLojAblugnAp0L
         5VebniKd3D7zgF2kEuLjBHgKrr5XqAZ7bXj23UWXav+jS4n8S3OGu52cfpty+Zr73BN5
         Yi4Q==
X-Gm-Message-State: AOJu0YyQDfQqR7oonpxSrHKoSpGk7z2+UYMhjS5O1lKl1PoaHZ/cZatB
	Gb5ztPKLzNT+wE4KQi+gEVYLy0gLTyE+XvYWg/YG3FBu8qI3yE6bKx00nJTfRT1ScH9g6ew9Xjw
	UMTI=
X-Gm-Gg: ASbGnctAOhx2RYXuCpgCWt5ANNsIXJWlLKRkZn26Di6LM+P4de2Iq6+3sx4Z9l0xHkQ
	jphI5HBUjoVkD5cCg1pIRrlr1sqwr3QLR4W6qWES/UXxSNSQpY1twA15HI58ysPmFdESyT2YoNT
	xPF3VzjXsXIS4u05ot5joHZg42LeMO+EFWGXDX2XF6QJs13eLlXJoBsU/lgAsB7A+6++e11JW53
	FI/2pqFKR9CDP7SW4E4eTLxLXoEVO0xQOL7l2xu5VOsawHIdEHZ/NS8zsSTdZtdKNZLPoN7jVsW
	0MaZ+3I9D1pREFtMVnT++JMfXGgy2dGHn2B4uXbQcp4A2h80ajYmuVHuUj3R0lK072qEWIF7fbf
	u6SZdzGhObpXI21V4bSBw8cd7m/qD9A4gaVDF1MUSqKfGZOFUECKGZF6u0X5TvNb/JK2/17bWav
	fnH++NArmPJmOwj8dEinTRIXi4JZTlH1eJpz/eVMmyqwRRZlRQZdrInFbYg19QegLV/MEdVA==
X-Google-Smtp-Source: AGHT+IG7+QbrZey9RClgWh7UPMb8t6jNRdh/AFiPRfWiyRY8UfhUqIXJFg0hA4yGu9np4R40oShdYA==
X-Received: by 2002:a17:90b:2d8f:b0:32b:cafc:e339 with SMTP id 98e67ed59e1d1-33bcf9551e5mr20563152a91.36.1761093676997;
        Tue, 21 Oct 2025 17:41:16 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:3ee0:9b5f:66d7:dd23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b33c7asm11600168a12.21.2025.10.21.17.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:41:16 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	Andrew Chant <achant@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Francesco Valla <francesco@valla.it>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH v2] init/main.c: Wrap long kernel cmdline when printing to logs
Date: Tue, 21 Oct 2025 17:39:48 -0700
Message-ID: <20251021173939.v2.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
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

Specifically, grepping for COMMAND_LINE_SIZE shows that 2048 is common
and some architectures even define it as 4096. s390 allows a
CONFIG-based maximum up to 1MB (though it's not expected that anyone
will go over the default max of 4096 [1]).

The maximum message pr_notice() seems to be able to handle (based on
experiment) is 1021 characters. This appears to be based on the
current value of PRINTKRB_RECORD_MAX as 1024 and the fact that
pr_notice() spends 2 characters on the loglevel prefix and we have a
'\n' at the end.

While it would be possible to increase the limits of printk() (and
therefore pr_notice()) somewhat, it doesn't appear possible to
increase it enough to fully include a 2048-character cmdline without
breaking userspace. Specifically on at least two tested userspaces
(ChromeOS plus the Debian-based distro I'm typing this message on) the
`dmesg` tool reads lines from `/dev/kmsg` in 2047-byte chunks. As per
`Documentation/ABI/testing/dev-kmsg`:

  Every read() from the opened device node receives one record
  of the kernel's printk buffer.
  ...
  Messages in the record ring buffer get overwritten as whole,
  there are never partial messages received by read().

We simply can't fit a 2048-byte cmdline plus the "Kernel command
line:" prefix plus info about time/log_level/etc in a 2047-byte read.

The above means that if we want to avoid the truncation we need to do
some type of wrapping of the cmdline when printing.

Add wrapping to the printout of the kernel command line. By default,
the wrapping is set to 1021 characters to avoid breaking anyone, but
allow wrapping to be set lower by a Kconfig knob
"CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN". Any tools that are correctly
parsing the cmdline today (because it is less than 1021 characters)
will see no difference in their behavior. The format of wrapped output
is designed to be matched by anyone using "grep" to search for the
cmdline and also to be easy for tools to handle. Anyone who is sure
their tools (if any) handle the wrapped format can choose a lower
wrapping value and have prettier output.

Wrapping is based on spaces, ignoring quotes. All lines are prefixed
with "Kernel command line: " and lines that are not the last line have
a " \" suffix added to them. The prefix and suffix count towards the
line length for wrapping purposes. The ideal length will be exceeded
if no appropriate place to wrap is found.

The wrapping function added here is fairly generic and could be made a
library function (somewhat like print_hex_dump()) if it's needed
elsewhere in the kernel. However, having printk() directly incorporate
this wrapping would be unlikely to be a good idea since it would break
printouts into more than one record without any obvious common line
prefix to tie lines together. It would also be extra overhead when, in
general, kernel log message should simply be kept smaller than 1021
bytes. For some discussion on this topic, see responses to the v1
posting of this patch [2].

[1] https://lore.kernel.org/r/20251021131633.26700Dd6-hca@linux.ibm.com
[2] https://lore.kernel.org/r/CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
v1 link: https://lore.kernel.org/r/20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid

NOTE: I _didn't_ add any "max characters printed" in v2 to try to
handle someone on s390 having an absurdly long cmdline after the
discussoin in v1. If someone truly puts a giant cmdline then it will
all be printed out to dmesg. If this truly turns out to be a problem
for someone then it's easy to add a maximum at a later time.

Changes in v2:
- Much longer commit message after discussion in v1.

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
2.51.0.915.g61a8936c21-goog


