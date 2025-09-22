Return-Path: <linux-kernel+bounces-827840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB1CB933D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FCF7AF439
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF9B25B662;
	Mon, 22 Sep 2025 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R+Rxe33A"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53025259CBC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573191; cv=none; b=LLxPERodyKBF5c+aegQnxq58WDAz0cmaKw/Nd46Uick1PJn2vasKbrvd4lQNI97k6v/SRQbdABh7NohNaw9pIaOVpOLJdQSEVZKzgChDwAfAQKdeRdDZ2E09xNDTIm3x0l6OBmI1oVM26HG6D3IX4JC6azkjUpr+LF3xubDX3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573191; c=relaxed/simple;
	bh=5fmrmxyXo8+QGRwZYQZhtwwyA8SDyVYpuRqt3H8E9PU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhJaAQe21FFk1ddLoMgwsaLso3Bl/9kE8P1BKO83t/q/5JlK7aZF11ZsAq9Uqxt7ucQ/leC0hjTyttDl6QS1tRzB9RdsmSF9KcZHb13ows0v+v8QRr08MeA9odvKxsypOgqZT24Y2SBvPoIkLQuWfHvms8hDElnNLcaQ23CYOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R+Rxe33A; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1AF62C0000DE;
	Mon, 22 Sep 2025 13:24:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1AF62C0000DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1758572691;
	bh=5fmrmxyXo8+QGRwZYQZhtwwyA8SDyVYpuRqt3H8E9PU=;
	h=From:To:Cc:Subject:Date:From;
	b=R+Rxe33AVgjsV428MnlL8JMDJK6KEDR7DixzOdl6hjiQLiJ/g7ZGxdxe8teWmOpYT
	 YZET+696rFDHHxTwTgm3GH2Yet/C6CfH5X65YVS88ZTsbzHgAPADYf29psP2UBM5Xn
	 oIXu+dOSG0lF6oXfnK89UQMSOBS7MWQM99JXomRs=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 03B8F18000530;
	Mon, 22 Sep 2025 13:24:50 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: song@kernel.org,
	linus.walleij@linaro.org,
	florian.fainelli@broadcom.com,
	ardb@kernel.org,
	anand.gore@broadcom.com,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
	kursad.oney@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2] ARM: module: fix unwind section relocation out of range error
Date: Mon, 22 Sep 2025 13:23:22 -0700
Message-ID: <20250922202438.496433-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In an armv7 system that uses non-3G/1G split and with more than 512MB
physical memory, driver load may fail with following error:
   section 29 reloc 0 sym '': relocation 42 out of range (0xc2ab9be8 ->
0x7fad5998)

This happens when relocation R_ARM_PREL31 from the unwind section
.ARM.extab and .ARM.exidx are allocated from the VMALLOC space while
.text section is from MODULES_VADDR space. It exceeds the +/-1GB
relocation requirement of R_ARM_PREL31 hence triggers the error.

The fix is to mark .ARM.extab and .ARM.exidx sections as executable so
they can be allocated along with .text section and always meet range
requirement.

Fixes: ac3b43283923 ("module: replace module_layout with module_memory")

Co-developed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v2:
- Fix the comment in code and commit message regarding the unwind
section location
- Add fix tag for more visibility

 arch/arm/kernel/module-plts.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 354ce16d83cb..b5338fe59706 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -225,6 +225,18 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			mod->arch.init.plt = s;
 		else if (s->sh_type == SHT_SYMTAB)
 			syms = (Elf32_Sym *)s->sh_addr;
+#if defined(CONFIG_ARM_UNWIND) && !defined(CONFIG_VMSPLIT_3G)
+		else if (s->sh_type == ELF_SECTION_UNWIND ||
+			 (strncmp(".ARM.extab", secstrings + s->sh_name, 10) == 0)) {
+			/*
+			 * To avoid the possible relocation out of range issue for
+			 * R_ARM_PREL31, mark unwind section .ARM.extab and .ARM.exidx as
+			 * executable so they will be allocated along with .text section to
+			 * meet +/-1GB range requirement of the R_ARM_PREL31 relocation
+			 */
+			s->sh_flags |= SHF_EXECINSTR;
+		}
+#endif
 	}
 
 	if (!mod->arch.core.plt || !mod->arch.init.plt) {
-- 
2.43.7


