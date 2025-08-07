Return-Path: <linux-kernel+bounces-758736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1287B1D349
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB881AA4731
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413A323B609;
	Thu,  7 Aug 2025 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p1n8lpg7"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8911221884A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551648; cv=none; b=tOvc/OL2u5jnsWhPkGhVzVpobZDOCMFFdTC8PxFqOAC18So6nsd0mPeDU0V2jdLVkQEcM9rB9yEPu7jtsm7BJ0Zyz0F1yhKIeDl9oF1HCUpDaaOprKwAzc2KuaT0ER3rVVxocf0LpSGKbgHpDoxw/rLck8Ztarnxtb1n2BbLqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551648; c=relaxed/simple;
	bh=K8vukmWjzm1VXIEaooQ4JW9QPT7Hde7LLgIFCZCjTiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H29rTyJEv1TlIpKmSkh3EPetfmSgs6TJD1ulzH9LpHFiuT6I3Rj9hp9eqIVtGzpz79GVWOEeZ2CgZri9o4FzwbgSxCsXK1Q1h0x9511QRM/6ZnI2yfqYiw+EHMKLO0pU4O/xYZcjbEKtgCFWrNdQYotj2FkUZfUYXTWR2qruL9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p1n8lpg7; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=K2
	tuHcrzTCjC6XtZmOmGV8ku7xQicRREc1BpWHeDuik=; b=p1n8lpg7453JSnznV9
	ZweXVC461jhN3EXL1EYmTYWR7AlJXCOwDGfvHZRm5Vba+E8clLzrBupRyhTX4Ms4
	mwx+mFtYoH4frMFyQpyxTNj8cbEUV31bdP9eRAlfIbtkIx3EI3KaIAlZiADfrPTx
	M+Q2w2Ix3DrHAmhafz+doUSlg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnOhxGVZRoUEhPDA--.562S2;
	Thu, 07 Aug 2025 15:27:03 +0800 (CST)
From: fanqincui@163.com
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	fanqincui@163.com,
	Fanqin Cui <cuifq1@chinatelecom.cn>
Subject: [PATCH] arm64/module: Support for patching modules during runtime
Date: Thu,  7 Aug 2025 03:27:00 -0400
Message-Id: <20250807072700.348514-1-fanqincui@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnOhxGVZRoUEhPDA--.562S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW7GF1kXryUKFWUAry7Wrg_yoW8trykpF
	n8Crn5GrZ5Xwn3Cay8twn8WF15C398Can8KFy8W3sFyw1Yqr98AF1DKry5CFyUGr45Z3y8
	WF18Gw1jq3WUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UD73PUUUUU=
X-CM-SenderInfo: 5idq1xpqfxxqqrwthudrp/1tbiOgqipWiUUrpNrgAAsA

From: Fanqin Cui <cuifq1@chinatelecom.cn>

If use the ALTERNATIVE_CB interface in a kernel module to
patch code, the kernel will crash. The relevant log is as follows:

 Mem abort info:
   ESR = 0x000000008600000f
   EC = 0x21: IABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x0f: level 3 permission fault
 swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000013cfbed000
 [ffff80007b0b0000] pgd=0000000000000000, p4d=10000013d0d03003,
pud=1000000103175403, pmd=1000000115804403, pte=0068000116b77703
 Internal error: Oops: 000000008600000f [#1]  SMP

 Call trace:
  0xffff80007b0b0000 (P)
  apply_alternatives_module+0x48/0x7c
  module_finalize+0xc0/0x134
  load_module+0x15c0/0x1c08
  init_module_from_file+0x8c/0xcc
  __arm64_sys_finit_module+0x1c0/0x2d4
  invoke_syscall+0x48/0x110
  el0_svc_common.constprop.0+0xc0/0xe0
  do_el0_svc+0x1c/0x28
  el0_svc+0x34/0xf0
  el0t_64_sync_handler+0xa0/0xe4
  el0t_64_sync+0x198/0x19c
 Code: 00000000 00000000 00000000 00000000 (d503233f)
 ---[ end trace 0000000000000000 ]---

To avoid this problem, this commit supports add a new section.
When the module is loading, this section will be found and the
page table attributes will be set to executable state in advance.

Signed-off-by: Fanqin Cui <cuifq1@chinatelecom.cn>
---
 arch/arm64/kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 40148d2725ce..2160b2877935 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -24,6 +24,7 @@
 #include <asm/scs.h>
 #include <asm/sections.h>
 #include <asm/text-patching.h>
+#include <asm-generic/set_memory.h>
 
 enum aarch64_reloc_op {
 	RELOC_OP_NONE,
@@ -477,6 +478,9 @@ int module_finalize(const Elf_Ehdr *hdr,
 	const Elf_Shdr *s;
 	int ret;
 
+	s = find_section(hdr, sechdrs, ".text.alternative_cb");
+	if (s && s->sh_size > PAGE_SIZE && PAGE_ALIGNED(s->sh_addr))
+		set_memory_x(s->sh_addr, s->sh_size >> PAGE_SHIFT);
 	s = find_section(hdr, sechdrs, ".altinstructions");
 	if (s)
 		apply_alternatives_module((void *)s->sh_addr, s->sh_size);
-- 
2.27.0


