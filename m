Return-Path: <linux-kernel+bounces-853820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B86BDCAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C2019A6214
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D638302767;
	Wed, 15 Oct 2025 06:17:39 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FBA23AB95
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509059; cv=none; b=fLYe5vJCoeRChyYgOlUgme8F18SUTPjYbyYYCOm1ngZzalaN0oD3GiFBf/oDusAT8sZz4qy0ZZstN4fP5knEZIoM2YeXEn4uSjgh6LCt5P5C5Wi42mhj0t1jP01lTMAIn1Zam1uidHX4cRFu9wXnAXkAEXRHJhk9pejeQxl+6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509059; c=relaxed/simple;
	bh=qHIAcV7644KkxRItnhTf8hr6+x1EXJ8W3AYi5AH6LnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT3ikYRCqjcM0bdb9OCleaGBftisFBBCoGeozdS28Oup837aDnRIQBc/SJXMQSQhRJtov1IQiMqi+L4KILRW51w3Wu8q6w2atojOAyYKbgDeSfhVg8sAXs25B8Zr6NUE9ul+YEuK/BaRchOj5FYmxJSGKeOg8552k9H2TQQLlSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: esmtpsz19t1760509050tc3cbbd60
X-QQ-Originating-IP: OMyBGcrdGYXGNiCpjXkWErWKjJoDpPvFbLpMaIvQg3w=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:17:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8967269725279754813
EX-QQ-RecipientCnt: 14
From: Yuan Tan <tanyuan@tinylab.org>
To: arnd@arndb.de,
	masahiroy@kernel.org,
	nathan@kernel.org,
	palmer@dabbelt.com,
	linux-kbuild@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i@maskray.me,
	tanyuan@tinylab.org,
	falcon@tinylab.org,
	ronbogo@outlook.com,
	z1652074432@gmail.com,
	lx24@stu.ynu.edu.cn
Subject: [PATCH v2 1/8] init/Kconfig: add CONFIG_TRIM_UNUSED_SYSCALLS and related options
Date: Wed, 15 Oct 2025 14:17:17 +0800
Message-ID: <553D6FEA67820FC7+34b9da95a06acd3ee5ce0e9cc16cb60aa1aaad2f.1760463245.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760463245.git.tanyuan@tinylab.org>
References: <cover.1760463245.git.tanyuan@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NG7xP+P+sy64HbqNJz07Bsfko3eQTeDaPXVOapBJ3KpQoGRXAinnOSHl
	kwpGP9G7fIMfG1CEkCyQb+gFMIzrH4MZEMzYRZh0AdjaK54zG4gXcYqcKFRjFxSfNuMJtUJ
	9HBdZ3tz8JJns2x023RvkCR0V1yasTVNGUysPyenlcY0sCgP8XJ+4Mk1aJd56M8ZH5Qwj5U
	P9hlLUS1PKhNmu9tQsFjM9Cd04KXfkGcQWfTZ0lz5JFmLf6V9aniXR9H2nz8rwrepOftLGM
	MdCw7f6N/TjAZINJfh8xZtZRSvaahXocWg3EIOX25k5VUsjGFer90cacpHIbQJ0JlQe41H7
	JFCyRA1RPhPX8j7E6ZLALgAf7k7vuEU8FzieuGJN0SOC+zVAk9HoaT0BkWROC1JjOtrkjS2
	tvU1NEaCfk2WvZbMcD5CePL9UJNRzoYOc/QOv7FsSdbM/WvwQ26kMm8oycq0l/8b44hR9+j
	suIJfp51IQLuK8Xx1dRvMzzo0zeyb6StIekT715SLauPjmhqAMvAcT6UnsrG6sH58tu+9HZ
	bNGrGQL6ubJ+QV4KnaPNrbFR62n6Ob2gSKd+peQAwCFJE8ohgNB0wKbwAeeN8gEksmTGPD/
	3e62iFl+GbcaNllujQKFl4LCQe6s1vBsy9pI/iqAe3XwPguKSvqwj3/XQI03tKecwx1nt0y
	PzZXkxwMZNQcWnNlDp8L+fV/6Fbu3BIBojRR7aJKltataPno2orLOtMKzilHNs8mXzLc2V6
	R6+F6Yh+bP5EUmrpRlXxxxT4PBVmHiTg+y9Z0tqZjvKsV7YAkA1bsgQw4uZzXlbyAAr7EJp
	p5yFqDRWu+Jk4hAzsD01CDXwkj7r3qAjm30MrcNp6N5RDl1ZAaveyyCpASaBaCYF/eaEhz0
	I25CU/68U5WygAOW2LUQqhASSSEK7FaHyI02Sda/K6r/gsyLJZSH8FalTMqPfMNQR0zCHhE
	IZs2TnWjs5R200dt3WUmjma3sgtm8KICDZFwnWMaOLjVxD8axvH9TVXL0jJlV9ODk2VVcrw
	M4y322Nas0qEzqhI2xwFBNNClMa8mTS9CD/m0LG+vpLDv948Ag
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

From: Yuhang Zheng <z1652074432@gmail.com>

Introduce configuration options to enable dead code/data elimination for
unused system calls.

This change adds the following Kconfig symbols:
 - TRIM_UNUSED_SYSCALLS: user option to enable trimming of unused system
   calls
 - HAVE_TRIM_UNUSED_SYSCALLS: architecture capability symbol
 - USED_SYSCALLS: string list of system calls to keep(separated by spaces)

These options integrate with scripts/Makefile.asm-headers and syscalltbl.sh
to generate syscall tables only for selected entries. The feature depends
on LD_DEAD_CODE_DATA_ELIMINATION and on architectures that use
syscalltbl.sh to generate their syscall tables.

Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 init/Kconfig | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49..2c6f86c44d96 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1628,6 +1628,9 @@ config SYSFS_SYSCALL
 config HAVE_PCSPKR_PLATFORM
 	bool
 
+config HAVE_TRIM_UNUSED_SYSCALLS
+	bool
+
 menuconfig EXPERT
 	bool "Configure standard kernel features (expert users)"
 	# Unhide debug options, to make the on-by-default options visible
@@ -1932,6 +1935,36 @@ config CACHESTAT_SYSCALL
 
 	  If unsure say Y here.
 
+config TRIM_UNUSED_SYSCALLS
+	bool "Trim unused syscalls" if EXPERT
+	default n
+	depends on HAVE_TRIM_UNUSED_SYSCALLS
+	depends on LD_DEAD_CODE_DATA_ELIMINATION
+	help
+	  Enable this option to trim unused system calls from the final kernel
+	  image. Only the syscalls explicitly listed in CONFIG_USED_SYSCALLS
+	  will be kept.
+
+	  Note that some unused syscalls may still be retained if their sections
+	  are forcibly kept by other sections created with .pushsection and
+	  preserved via KEEP() in the linker script.
+
+	  If unsure, say N.
+
+config USED_SYSCALLS
+	string "Configure used syscalls" if EXPERT
+	depends on TRIM_UNUSED_SYSCALLS
+	default ""
+	help
+	  Specify a list of system calls that should be kept when
+	  TRIM_UNUSED_SYSCALLS is enabled.
+
+	  The system calls should be listed one by one, separated by spaces.
+	  For example, set CONFIG_USED_SYSCALLS="write exit reboot". If left
+	  empty, all syscalls will be trimmed.
+
+	  If unsure, please disable TRIM_UNUSED_SYSCALLS.
+
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y
-- 
2.43.0


