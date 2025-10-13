Return-Path: <linux-kernel+bounces-850362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D168DBD29EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5409D3485ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E486303CB6;
	Mon, 13 Oct 2025 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tbCze3m1"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CA2303A00
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352508; cv=none; b=EtoGrlLa3Jh0uyezafGluFT+UVn0r21SGof+uFaBWbKmXwC12ch09ohQG6AgEqsdrE1yVusA0QpMrLgpidP6sCAqrq9/Y9XK3YNYfK+63xpmvoqYlimUAmU/ywdBP2VDlSR5YN1g9kxV8W+fLNu4aRLA294/XIGhzGfOZQXwjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352508; c=relaxed/simple;
	bh=4oJNqNidl2yJO66qwAhbfNuPC9Nd39kyLTxqx4jOV1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqktGMFj3oaOjypl/a/G5M1qXwb5yhXCAWGV8FgBe1p0HQlSug1wSB29mMlEx88L4py7Eh8b4F2Yayk6KpWST81hlorVQVsISHQQjVuZsKxf32/vgMIwGXPvJwkaD+I4Z1FWw53/fFqWP/tZuLbIF/pwOC84wyeq5EBwWTFdzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tbCze3m1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760352024;
	bh=4oJNqNidl2yJO66qwAhbfNuPC9Nd39kyLTxqx4jOV1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tbCze3m1twkQ3CIGnwhOAKKcmhdyw5pGuR9ZeUhD6owE3TbxlRc4J5m9FmzyVTHMd
	 BPTOxSPYW8VR6ytTBdgZ3pEX091qKTCLrZ0kZv7zTKihkmPc4pby51srDK5ISKQnL3
	 oQi+Pm+GE6oKBtJ2BKk7Vxo5Y7CQhMz/Gu2PLghY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 12:40:20 +0200
Subject: [PATCH 3/4] x86/um/vdso: Panic when vDSO can not be allocated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-uml-vdso-cleanup-v1-3-a079c7adcc69@weissschuh.net>
References: <20251013-uml-vdso-cleanup-v1-0-a079c7adcc69@weissschuh.net>
In-Reply-To: <20251013-uml-vdso-cleanup-v1-0-a079c7adcc69@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352023; l=1313;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4oJNqNidl2yJO66qwAhbfNuPC9Nd39kyLTxqx4jOV1A=;
 b=dNsqX7tCXD0nmEmuX7XmNq+Gkr9NBaN5EnQIDs+gLqoWtgE1rNz+qLBSnei8UgVgKXGPto8Dy
 IYjFqpjkVZFBrU9VGjsBxaJJKuax2gYGiMBQNCPudJPVIYB2ThM3N2l
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The vDSO address is added to the userspace auxiliary vectors even if the
vDSO was not allocated. When accessing the page, userspace processes
will crash.

Enforce that the allocation works.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/um/vdso/vma.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index dc8dfb2abd80..51a2b9f2eca9 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -10,7 +10,6 @@
 #include <asm/elf.h>
 #include <linux/init.h>
 
-static unsigned int __read_mostly vdso_enabled = 1;
 unsigned long um_vdso_addr;
 static struct page *um_vdso;
 
@@ -25,17 +24,11 @@ static int __init init_vdso(void)
 
 	um_vdso = alloc_page(GFP_KERNEL);
 	if (!um_vdso)
-		goto oom;
+		panic("Cannot allocate vdso\n");
 
 	copy_page(page_address(um_vdso), vdso_start);
 
 	return 0;
-
-oom:
-	printk(KERN_ERR "Cannot allocate vdso\n");
-	vdso_enabled = 0;
-
-	return -ENOMEM;
 }
 subsys_initcall(init_vdso);
 
@@ -48,9 +41,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		.pages = &um_vdso,
 	};
 
-	if (!vdso_enabled)
-		return 0;
-
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 

-- 
2.51.0


