Return-Path: <linux-kernel+bounces-873357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D5FC13C23
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B9E1A60DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058653016FB;
	Tue, 28 Oct 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CE5XHoGR"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C192F616B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643043; cv=none; b=DlsI5s4mownEZUCFi43PxNnxLJZpaWCGWPBhfUkARHP0Eunsmm06Eyq+20KyF04QAfCaUOMtbeVcRsDDrpmEBEAMzqnenVn2sPpLxExRq60iARnvFSvVMSZNUZ43hhh6kgbZm4/PycqT8gegJfCB7S60VU9Xg0Q0lh48VBblBig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643043; c=relaxed/simple;
	bh=YqbPywoFtgBAhJ6lpmIQMDms46YwcEmQamcwJS8MPbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m7ExysZoLNxY/vHAXXPtSKVYZGH6T7LmjmeXnkN3z6iTK6wEfNrSrQcQxMY/Krj2prTlBwHWbOfiG9/azW6KTzcrz7739DKz22kZUgseWb9dGWdxdyGQqr9oSJ6FNElRiuK5zHFupqD9Id/nBwdYRisGx/33l/GEQh5MJzfBY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CE5XHoGR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643038;
	bh=YqbPywoFtgBAhJ6lpmIQMDms46YwcEmQamcwJS8MPbA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CE5XHoGRDOoEaApc47qhv03YYfsONq7VVJBZYwGRaTvmwBAKafmHL//ik2DKXPkzf
	 gmwMlPdlLoBW9Pslfdm3bV3rdqFBhSGicrpArS95CHSqRb+3j7c2ofH6sBIUnJNaYX
	 IC6g6scpP8vwjDCqa6dH6izhO9s5oDYMgFcnwOeA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:37 +0100
Subject: [PATCH 02/10] x86/um: Move ELF_PLATFORM fallback to x86-specific
 code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-2-e930063eff5f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=1152;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YqbPywoFtgBAhJ6lpmIQMDms46YwcEmQamcwJS8MPbA=;
 b=E3/22t0NPJGkRhdvBg2Xoo5C1xY8YBwldw9w21HcwS212L3vjfQkTyETGfgzLIK9fKxWFFmwW
 ah2FjRnmpmfB6dME8TsAbEtIgVmUPZDKctooDkcmJY7upgfRJ4JUimC
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The generic UM code should not have references to x86-specific value.

Move the fallback into the x86-specific header.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/os-Linux/elf_aux.c | 3 ---
 arch/x86/um/asm/elf.h      | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/elf_aux.c b/arch/um/os-Linux/elf_aux.c
index a62fe39e85c9..4aadb9ea5ae3 100644
--- a/arch/um/os-Linux/elf_aux.c
+++ b/arch/um/os-Linux/elf_aux.c
@@ -71,7 +71,4 @@ __init void scan_elf_aux( char **envp)
 	else {
 		vsyscall_end = vsyscall_ehdr + page_size;
 	}
-
-	if (!elf_aux_platform)
-		elf_aux_platform = "i586";
 }
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 62ed5d68a978..e7a045e01471 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -69,7 +69,8 @@
 } while (0);
 
 extern char * elf_aux_platform;
-#define ELF_PLATFORM (elf_aux_platform)
+#define ELF_PLATFORM_FALLBACK "i586"
+#define ELF_PLATFORM (elf_aux_platform ?: ELF_PLATFORM_FALLBACK)
 
 extern unsigned long vsyscall_ehdr;
 extern unsigned long vsyscall_end;

-- 
2.51.1.dirty


