Return-Path: <linux-kernel+bounces-873361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F1BC13C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFF3034201B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3014E3043C8;
	Tue, 28 Oct 2025 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EMVGtZMP"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCC13019DA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643046; cv=none; b=s6lpYqY6bBwXsOFGxC8ya3NDn+MawEoi653HPhf5+ibqxpgEeuwhbm3AdPbPcO9ewPY2rwXxrEKIbpTnSRpM6xU4N7wjf+QCj9BQPsGonRWdh2nExzr9Pq2iEMtf3rHDevBmor7RaBS1JJeuR6qYvDi/x2+jPokxcPakHmvSEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643046; c=relaxed/simple;
	bh=QvY+nAXDRHky/oaQZhIuoK3hf3WfhaB7cgzN/dQrG7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oPUujpqD5xoWpSe1FOvi2t8JhFMabG3nrE0Z6RYCv4DGIeitV1xfwbs15Ja0tbBHHRSijoLqnz12jF7aLCLEN/dF4bKtCpd865aQUYV66O0fWADVFufrgLX9anb1mUm8zWjrGeGM4Ex5MrzUNA6+Xrk75mfiJ+oakozP3mViG9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EMVGtZMP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643039;
	bh=QvY+nAXDRHky/oaQZhIuoK3hf3WfhaB7cgzN/dQrG7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EMVGtZMPhsecf5rpkJJ/jcc3uyvDjTFHD2vNe/tl526UmuYjZKm36042T/jZYyorp
	 fvLPcNE5mwYXs0SzI2Et9znl+dcWpVVVSfbmN7Bq3fMSrcw4jQr2MMgH6IjpcKI0z6
	 1x3jeHenNrFto9cZMgy3jsqz9/MfdcOnj4CBY3Mg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:44 +0100
Subject: [PATCH 09/10] x86/um: Remove FIXADDR_USER_START and
 FIXADDR_USE_END
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-9-e930063eff5f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=1070;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QvY+nAXDRHky/oaQZhIuoK3hf3WfhaB7cgzN/dQrG7M=;
 b=6eLwZ6/9TeBOy4ZjspiFcrQRDfICig8yzA6Y3xnYNYR2RoI6gjbrzGzbn6VKROBqqC7L1VjTm
 x5TBTjM7lAGDRSthAoXmnP69TGoARREVZ8AWHbT3bsy56gshRzuxU42
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

There are no users left.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/um/asm/elf.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 8d7df4684c38..fdd5a612f678 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -72,10 +72,6 @@ extern char * elf_aux_platform;
 #define ELF_PLATFORM_FALLBACK "i586"
 #define ELF_PLATFORM (elf_aux_platform ?: ELF_PLATFORM_FALLBACK)
 
-/* No user-accessible fixmap addresses, i.e. vsyscall */
-#define FIXADDR_USER_START      0
-#define FIXADDR_USER_END        0
-
 #else
 
 /* x86-64 relocation types, taken from asm-x86_64/elf.h */
@@ -157,10 +153,6 @@ extern char * elf_aux_platform;
 
 #define ELF_PLATFORM "x86_64"
 
-/* No user-accessible fixmap addresses, i.e. vsyscall */
-#define FIXADDR_USER_START      0
-#define FIXADDR_USER_END        0
-
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,

-- 
2.51.1.dirty


