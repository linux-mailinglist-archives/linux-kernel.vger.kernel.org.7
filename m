Return-Path: <linux-kernel+bounces-773329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC35B29E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19AA016366A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACA730F7E5;
	Mon, 18 Aug 2025 09:50:38 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C128D30E831
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510638; cv=none; b=CUZjnpy60ru88gN/xcouLlBX27QZHxExWGz1MRvnjrORlET5XfrR9fxD4gibrST27SxOqRdTs48+BoklddWVNvDN284f9jWjZYK+0evM3RGxBammV1EzIeiXbu4iXj1w8uoQZ9uXSTOSO8LXsYkw+lWn6rMJtcyQrcQU7tvOdVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510638; c=relaxed/simple;
	bh=B2xTrP7XxJf/asaLGXkExB+P+o9oXtCOkG+Rjzjch4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYLACQxJUbyJCfIr13ynuFOHi9oygjTj3R707hZLAA/8ogMsD8W+GsyDbc7llBA+0lGf4Gw66UTDw8dKvf8u05iQP/e6fWjVQoeWstc7HPUC63iwRxSLCxBuHF++mvSHvb/RHvim7U2DXfo4f/vWuGK5k1H7aQez5GWEXFhKfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c56mP4m2Cz9sSZ;
	Mon, 18 Aug 2025 11:26:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pttFIAfyVu3D; Mon, 18 Aug 2025 11:26:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c56mP46KLz9sSW;
	Mon, 18 Aug 2025 11:26:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7AE718B764;
	Mon, 18 Aug 2025 11:26:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id QY7z9oBXpkqJ; Mon, 18 Aug 2025 11:26:45 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 59E808B763;
	Mon, 18 Aug 2025 11:26:45 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/vdso: Include asm/syscalls.h for sys_ni_syscall()
Date: Mon, 18 Aug 2025 11:26:44 +0200
Message-ID: <e2215a515ae0e21393c50e2f38791a6567cf1dec.1755509195.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755509204; l=927; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=B2xTrP7XxJf/asaLGXkExB+P+o9oXtCOkG+Rjzjch4A=; b=MvOvpHDcpNakY3/k5gLa2Rt9NmmNBu672nMmufYfyFzV59YgUiDD33CN91oldIVO0FS3PLiVj BM2t8VdogtaBN6ye6dAmEYhhtq0tvY3kWyoax2ILakqlI6kpnEwE4un
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Include asm/syscalls.h to get the correct prototype for sys_ni_syscall()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 219d67bcf747..ab7c4cc80943 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -21,6 +21,7 @@
 #include <vdso/datapage.h>
 
 #include <asm/syscall.h>
+#include <asm/syscalls.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
@@ -40,8 +41,6 @@ static_assert(__VDSO_PAGES == VDSO_NR_PAGES);
 extern char vdso32_start, vdso32_end;
 extern char vdso64_start, vdso64_end;
 
-long sys_ni_syscall(void);
-
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma,
 		       unsigned long text_size)
 {
-- 
2.49.0


