Return-Path: <linux-kernel+bounces-761054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528D2B1F3CB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08F43B3789
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61BD24BBE4;
	Sat,  9 Aug 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuWGza8y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D123D287
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754732533; cv=none; b=KNJWvYES0sllJfdr2HPwY7rEEbUCrecKsaRSsx2nsRZF2RfdFylgGi9LbWwdvlEUf5if5DLuGJbHzKiIwKNUwCj4QN6Fl5hPLo1Kpwl9lq7Ef8bixefAOE6XDd5qoT1cdq9UWWvdTOgTNsiuuRzLN4FvnYvP8Xlh80Cabl4r1X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754732533; c=relaxed/simple;
	bh=0+cTrLYGr14tJTy6mkahmdCjTBiuKiDWPh7CEnVxl1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpWjbiiCIUlSY9OqBeV1r8SNf9aOwzpIKufwwyrIBgx3PCIN+vf+1iDQAIjvI/p92whgqNCoOL6rz7OzDl9xAXWmfmBUIedrfl9ptuutSi5LF3p0s4Rve+wF7ukSxOtx62HusQZOkNNYsX7NiUcXfv3k/JtG1XzWeHAGOSXYgOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuWGza8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309CBC4CEF6;
	Sat,  9 Aug 2025 09:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754732533;
	bh=0+cTrLYGr14tJTy6mkahmdCjTBiuKiDWPh7CEnVxl1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LuWGza8ygyt+VSaeH9hKQbFJ3FBVM+yct6T0MUOl6SAme/pyc3GSPZZMso1M2r0De
	 z0ybhf0FWQofS2uQ31TjDKd2Cb//MIMxl3oqYd2pfBaDcdbIkBH9Pfhmj651q22dEU
	 +U02XepZF6tJFs5T5v+M4yAXTKfDruJ/5rmXdHxxTQvbjzZ7eKOJSm8UqusJk6ojZj
	 08VvHqPmujtda9Yuwv4nQDSqvVXDONGF8jbJEnIrvKGM9SXAYWNJdwXXX6NYWdjEbb
	 rAEcAdPe4tBu9miKoWNIKrJHgsHOYpvDUX5hthzuQlW79BdQN1JaD6Qvns++iK4JiA
	 eZdmZ94QfTj4g==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 1/2] x86/microcode: Add microcode= cmdline parsing
Date: Sat,  9 Aug 2025 11:42:05 +0200
Message-ID: <20250809094206.28028-2-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250809094206.28028-1-bp@kernel.org>
References: <20250809094206.28028-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Add a "microcode=" command line argument after which all options can be
passed in a comma-separated list.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 .../admin-guide/kernel-parameters.txt         |  8 +++--
 arch/x86/kernel/cpu/microcode/core.c          | 30 +++++++++++++++----
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..7c095177da85 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3767,10 +3767,12 @@
 
 	mga=		[HW,DRM]
 
-	microcode.force_minrev=	[X86]
-			Format: <bool>
+	microcode=      [X86] Control the behavior of the microcode loader.
+	                Available options, comma separated:
+
+			force_minrev
 			Enable or disable the microcode minimal revision
-			enforcement for the runtime microcode loader.
+ 			enforcement for the runtime microcode loader.
 
 	mini2440=	[ARM,HW,KNL]
 			Format:[0..2][b][c][t]
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b92e09a87c69..351a51861f00 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -43,10 +43,9 @@
 #include "internal.h"
 
 static struct microcode_ops *microcode_ops;
-static bool dis_ucode_ldr = false;
+static bool dis_ucode_ldr;
 
-bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
-module_param(force_minrev, bool, S_IRUSR | S_IWUSR);
+bool force_minrev = false;
 
 /*
  * Synchronization.
@@ -126,13 +125,34 @@ bool __init microcode_loader_disabled(void)
 	return dis_ucode_ldr;
 }
 
+static void early_parse_cmdline(void)
+{
+	char cmd_buf[64] = {};
+	char *s, *p = cmd_buf;
+
+	if (cmdline_find_option(boot_command_line, "microcode", cmd_buf, 64) > 0) {
+		while ((s = strsep(&p, ","))) {
+			if (IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV)) {
+				if (!strcmp("force_minrev", s))
+					force_minrev = true;
+			}
+
+			if (!strcmp(s, "dis_ucode_ldr"))
+				dis_ucode_ldr = true;
+		}
+	}
+
+	/* old, compat option */
+	if (cmdline_find_option_bool(boot_command_line, "dis_ucode_ldr") > 0)
+		dis_ucode_ldr = true;
+}
+
 void __init load_ucode_bsp(void)
 {
 	unsigned int cpuid_1_eax;
 	bool intel = true;
 
-	if (cmdline_find_option_bool(boot_command_line, "dis_ucode_ldr") > 0)
-		dis_ucode_ldr = true;
+	early_parse_cmdline();
 
 	if (microcode_loader_disabled())
 		return;
-- 
2.43.0


