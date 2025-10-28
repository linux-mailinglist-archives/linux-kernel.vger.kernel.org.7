Return-Path: <linux-kernel+bounces-873363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24764C13C38
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9091A6053B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6907E304982;
	Tue, 28 Oct 2025 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KWo7sg0H"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9EE3019DE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643046; cv=none; b=X00N9tNWvNr+vku61gNX4gVKL10ElrD43zwNM+CerOGgN9qamtFpxxjCghvClPvWjouLLxq1kzt30OgmbYDfLbwSuflrKPCHrMz+YGrZXXHeaRFmSkdA+WOdsl+dFy5Z4CgsE94fxJtrCmjuO1JPjBnlZ0xYVpHkrfFzZdlzugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643046; c=relaxed/simple;
	bh=CxIHi84E4Pt5K6l2BuyDuvOD5HSJpAj9jMAXhBrWhPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=duA4fxRNT6fvnzgNQZoGLlfL7IVQ2rvLQhdYpyt4AWoqqrISLRMMC5u7auwsIRsigje2WWVDHxe9s/mKgSImqYZ2g4umnXaIq7HUtQyjyVHoMYQoxzl+SEVmqJmqzZU9ZrHrVrly9SdDJkg/E1U9prbXMRlt940xwFwnnTTAUPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KWo7sg0H; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643039;
	bh=CxIHi84E4Pt5K6l2BuyDuvOD5HSJpAj9jMAXhBrWhPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KWo7sg0HDLVwuJxbMVa0QVJzurgJIyDK1zw+ebn5phBhr3C7MAG7cMyz7E3fh1y4e
	 avOz7YrsLk6fYH4IO4FdkTI/iNgikB3bVS59fqSLrIm96xlRBup9wuuqLoQcjwrxJc
	 lbH0wPaZH2bjA7cpHu677LiCQ4taEjaAg3HuaoXc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:43 +0100
Subject: [PATCH 08/10] um: Remove __access_ok_vsyscall()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-8-e930063eff5f@weissschuh.net>
References: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
In-Reply-To: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=1320;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CxIHi84E4Pt5K6l2BuyDuvOD5HSJpAj9jMAXhBrWhPI=;
 b=indsseQNY5fyzet23byGMfRz3iZPxGotar2HG8qPmnBRDzv8C40nHyUQRT0Da3oxy3nlZoEEs
 qs0pIYidKlJBq6P+Kh9ASIbrA6/scKN4tp4chTLKNoVkGLy5/Xl70ij
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

FIXADDR_USER_START and FIXADDR_USER_END are now always zero.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/include/asm/uaccess.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 3770bdeee100..0df9ea4abda8 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -15,10 +15,6 @@
 	(((unsigned long) (addr) < TASK_SIZE) && \
 	 (((unsigned long) (addr) + (size)) < TASK_SIZE))
 
-#define __access_ok_vsyscall(addr, size) \
-	  (((unsigned long) (addr) >= FIXADDR_USER_START) && \
-	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END))
-
 #define __addr_range_nowrap(addr, size) \
 	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
 
@@ -39,9 +35,7 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
 static inline int __access_ok(const void __user *ptr, unsigned long size)
 {
 	unsigned long addr = (unsigned long)ptr;
-	return __addr_range_nowrap(addr, size) &&
-		(__under_task_size(addr, size) ||
-		 __access_ok_vsyscall(addr, size));
+	return __addr_range_nowrap(addr, size) && __under_task_size(addr, size);
 }
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\

-- 
2.51.1.dirty


