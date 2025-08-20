Return-Path: <linux-kernel+bounces-777841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B393B2DE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC0616AB58
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D41DDC33;
	Wed, 20 Aug 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fq3Q/ZdX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FC1DF963
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697849; cv=none; b=V2Ry2lCFfa89Cdt5MgJwQJEgRus+eBJrLzetY+eOdS8fht7AOOQ2T7DpNfde3eph9OZqWLG8kx3AW7pDD5+faAhPRHE9FO13qI7StOaZTLgq/3c9AqzeHbcTNcr9jXiSXpmHLxkUnZ3wmL68y7xhIpj95t8DGWm1NIoVDt8n2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697849; c=relaxed/simple;
	bh=O06MDoA57o/q/eanTCXjPPIvfm751KiDMOvmyDopReQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRaft7GBPL/mAL3Qw5Jaab6/gaNljUfpnAoQpPymw+LCT1jw6Xx6D2F73woICXfHixqAMT/pe8akzILojqNfOC1X90e/ImopVXUMG7A3xDLghsGEO1Cl0RMXqZuhbGFz5k29lbrwhnh+X3Gx98skdCe5+a3DIccTTS21YaNUHQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fq3Q/ZdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE148C116B1;
	Wed, 20 Aug 2025 13:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755697849;
	bh=O06MDoA57o/q/eanTCXjPPIvfm751KiDMOvmyDopReQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fq3Q/ZdXo6th/lZifeLYw/izyI4VO5wZzE6dk8bcQKzRMsbgNT3xr4CZ9T4/8GdPL
	 52eyKFSfAAhKw44Z0havOyqdkuSKKfjpq/GtX8c66iVjbA47zSt1NaCgEn2bh0HSMs
	 +nyZzSR03GN2JHTASt18vQfeCngO03XzN0W6wki6g3U8KSV6hrLgUDpAsgbHXZ3ExX
	 IIiFJOVo3oAhs4elRyyDOaetwQa8tgUo4CU6o4aimBk0xOPnxtk1ruib2Bg2KJheQ0
	 iI6wyAuzD4+Pk1IzMF3LdGcw40HA99Q/XX61OLjPCzct9X6Xkbv/91rgm1+x7JCFta
	 83xVAtafHdLUw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH -v1 1/2] x86/microcode: Add microcode= cmdline parsing
Date: Wed, 20 Aug 2025 15:50:42 +0200
Message-ID: <20250820135043.19048-2-bp@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250820135043.19048-1-bp@kernel.org>
References: <20250820135043.19048-1-bp@kernel.org>
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
 .../admin-guide/kernel-parameters.txt         |  8 ++++--
 arch/x86/Kconfig                              |  4 +--
 arch/x86/kernel/cpu/microcode/core.c          | 26 ++++++++++++++++---
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..9e3bbce6583f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3767,8 +3767,12 @@
 
 	mga=		[HW,DRM]
 
-	microcode.force_minrev=	[X86]
-			Format: <bool>
+	microcode=      [X86] Control the behavior of the microcode loader.
+	                Available options, comma separated:
+
+			dis_ucode_ldr: disable the microcode loader
+
+			force_minrev:
 			Enable or disable the microcode minimal revision
 			enforcement for the runtime microcode loader.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..aa250d90f927 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1340,7 +1340,7 @@ config MICROCODE_LATE_LOADING
 	  use this at your own risk. Late loading taints the kernel unless the
 	  microcode header indicates that it is safe for late loading via the
 	  minimal revision check. This minimal revision check can be enforced on
-	  the kernel command line with "microcode.minrev=Y".
+	  the kernel command line with "microcode=force_minrev".
 
 config MICROCODE_LATE_FORCE_MINREV
 	bool "Enforce late microcode loading minimal revision check"
@@ -1356,7 +1356,7 @@ config MICROCODE_LATE_FORCE_MINREV
 	  revision check fails.
 
 	  This minimal revision check can also be controlled via the
-	  "microcode.minrev" parameter on the kernel command line.
+	  "microcode=force_minrev" parameter on the kernel command line.
 
 	  If unsure say Y.
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b92e09a87c69..7d590630673b 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -43,10 +43,9 @@
 #include "internal.h"
 
 static struct microcode_ops *microcode_ops;
-static bool dis_ucode_ldr = false;
+static bool dis_ucode_ldr;
 
 bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
-module_param(force_minrev, bool, S_IRUSR | S_IWUSR);
 
 /*
  * Synchronization.
@@ -126,13 +125,32 @@ bool __init microcode_loader_disabled(void)
 	return dis_ucode_ldr;
 }
 
+static void early_parse_cmdline(void)
+{
+	char cmd_buf[64] = {};
+	char *s, *p = cmd_buf;
+
+	if (cmdline_find_option(boot_command_line, "microcode", cmd_buf, sizeof(cmd_buf)) > 0) {
+		while ((s = strsep(&p, ","))) {
+			if (!strcmp("force_minrev", s))
+				force_minrev = true;
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
2.51.0


