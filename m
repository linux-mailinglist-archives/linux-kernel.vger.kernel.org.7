Return-Path: <linux-kernel+bounces-825453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7F4B8BD47
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5075456751E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7CB18DB0D;
	Sat, 20 Sep 2025 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f6bj0rs9"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD22581
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758334771; cv=none; b=MTGbITN1sYSURe9nQOUaQ6i7qYrVe7WC68IHheeQQstrwbHbdQkMMZyFiZQB70/vKtgu3w66UrdE1lDqlOXBW6er8lqSc6FobwJLVMfQCb3trcUwjHJugFQJUNjuF12mNEevMIiOVlJodY7nC8eOSPEmjaWgISQ9p6B3q/6mVbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758334771; c=relaxed/simple;
	bh=8gjjFALb5OqFsAHx2e8iBUY63EelPSdQloxqbDdhikI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BAcAHXMwgqRsITIQMjm5uUbt1kxtXQqQ2h17en0iB/5ZK9BVIaTW46mf0YsI7MFwqi/V2uyVilDtOhyabigSdCNUYCBqIDDqOsAXSw2e8Nyt4XDKwnDWqO6k3jXiC8tFqPB0hLkWD77CEdFh3iIPVc+BeIMHSDYBbAhr6DQMA5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f6bj0rs9; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4AAF8C01508B;
	Fri, 19 Sep 2025 19:10:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4AAF8C01508B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1758334240;
	bh=8gjjFALb5OqFsAHx2e8iBUY63EelPSdQloxqbDdhikI=;
	h=From:To:Cc:Subject:Date:From;
	b=f6bj0rs9EeNNXBE46HEXEc8x9YsYXSby7xRVQ45O5Jo/4x+QSFqPzWUoA/nKL17Gi
	 H6rRrzjI/ktzVR/UCSR//F4pYNbrg9avVGQGmxa2B+Uuw9RfjOXIg8NhX/iBMOtp7C
	 A8MFgofXHSVafKUoShU2xXEEasm+5TB/Xd3V9DAw=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 016BF18000847;
	Fri, 19 Sep 2025 19:10:39 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH] ARM: module: fix unwind section relocation out of range error
Date: Fri, 19 Sep 2025 19:09:57 -0700
Message-ID: <20250920021024.847323-1-william.zhang@broadcom.com>
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
they can be allocated within .text section and always meet range
requirement.

Co-developed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

 arch/arm/kernel/module-plts.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 354ce16d83cb..5f5bf5e63bd6 100644
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
+			 * executable so they will be allocated within .text section to meet
+			 * +/-1GB range requirement of the R_ARM_PREL31 relocation
+			 */
+			s->sh_flags |= SHF_EXECINSTR;
+		}
+#endif
 	}
 
 	if (!mod->arch.core.plt || !mod->arch.init.plt) {
-- 
2.43.7


