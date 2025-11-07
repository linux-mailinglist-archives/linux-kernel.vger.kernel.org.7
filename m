Return-Path: <linux-kernel+bounces-891022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC46C41A19
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A906189A437
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D781530DEA0;
	Fri,  7 Nov 2025 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DWECBhzx"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C724DD1F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548642; cv=none; b=WFlIGXrYOOR4oe1drjpG6XSvgV5JZC5DoZopSd5++we3xwqsfledCHUlZxWIgRogQUBiypl9PVuGU3Du0vpCANdtme5niiBuKlmIjb694aUYXN/TIhe1cJpgulLxxe1EKjdy5wxV7FvkA0gD/nViagnius2d1qJnw39TBO+c808=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548642; c=relaxed/simple;
	bh=2fwvs167OXuGLVsGYTQo4nZAYZv8Pd4u3wt7sX18fHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHg+sO4wc3IqFbgaVLGf3siE6DZ+hs3S6DcOFAGImsMScOuCDxNfKGLXPKiSA4dIaq0K4EI/6qxca/4yVuIIGhvPnYHui+OeGzz8TBTchZ0h/PJEH0qLjrvq93ELzk2Qmkag6RcFQRGnHFTPUdCbu1VgBHFC5pyO+iX76oYkyKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DWECBhzx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9B16740E019D;
	Fri,  7 Nov 2025 20:50:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MtdQSRxOVpeQ; Fri,  7 Nov 2025 20:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762548633; bh=SqGxAoAzyh3kVfuxZYTk3OufxmF53STmqnxmjBxmrf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWECBhzxsTuo7lqzTk+tSFQ4vbXrGwJCdDw51hkMhnq/mNamAXLWow4gT7HMTYnKd
	 a5qU/P9E1g2b8VZwgF7EjKKUT/mvqkW7tOfp/TFyb+zrxhs4+RiJjgO5j3lO9UYNWQ
	 b0B/65C2mRNA2QnHm7HsbORcL8jHeM7NbU5MLXCKasMi4L3/P4Dhuj1GJoaxPoVwIb
	 nPEG8Oim6FyQZ2gFTcIFNiGYbC2Xe3UDjXTsFOaW8x+s89d4N8qBAQfZ4dDnSZLI5D
	 ZbHEGa5wL04ZQ9ykmzJgj6A965snIeaAoCkQZNx9xDGZGuug3nxevHFOJDDRfQaEHM
	 g2YogaCjr+bIbyvcN0T0NAeFqi1f5PNtpCdJCB0BnzjzSw0KYwBnrAdWbt4GBovKIF
	 HTl2RLPAGeaH3IMKmqxHrd4abzsdJHcbmVVDo/LnSJo/AXcPuskDgPfx/z6A71Zhgi
	 hoiv7yfsu7EtFGaYxjM90pGjkHUmYgF2arJc6ec7pVZYKIV/iuIqkV80jwYbv7qVdC
	 eOi5aeoB+KjVFm1ATzC6sge+1DAsWDVAtaiBzek90p+sX1QIqxUZP/8sZqlc2FGsHj
	 FvgMPRNFXoGjR969lbsmHJMelQLqIwzL6K22eb610VXPdynkN5DEvxVHWIjapkePp+
	 2D4RowmL1aeq6c3Cn5BBnM5U=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8708C40E015B;
	Fri,  7 Nov 2025 20:50:26 +0000 (UTC)
Date: Fri, 7 Nov 2025 21:50:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kees@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Michal Clapinski <mclapinski@google.com>,
	Chris Li <chrisl@kernel.org>
Subject: Re: [RFC PATCH] x86/boot/compressed: Disable physical KASLR when
 memmap= appears
Message-ID: <20251107205020.GEaQ5bjLIU1Y7ePsJY@fat_crate.local>
References: <20251106173019.1224443-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106173019.1224443-2-ardb+git@google.com>

On Thu, Nov 06, 2025 at 06:30:20PM +0100, Ard Biesheuvel wrote:
> Reported-by: Michal Clapinski <mclapinski@google.com>
> Reported-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/kaslr.c | 100 ++-----------------------------
>  1 file changed, 6 insertions(+), 94 deletions(-)

I love diffstats like that.

How about this simplification ontop of yours:

---

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 96805d6c10a4..7875ae2d514e 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -67,8 +67,6 @@ static unsigned long get_boot_seed(void)
 #define KASLR_COMPRESSED_BOOT
 #include "../../lib/kaslr.c"
 
-static bool memmap_found;
-
 /*
  * Store memory limit: MAXMEM on 64-bit and KERNEL_IMAGE_SIZE on 32-bit.
  * It may be reduced by "mem=nn[KMG]" command line options.
@@ -165,9 +163,7 @@ static void handle_mem_options(void)
 		if (!val && strcmp(param, "--") == 0)
 			break;
 
-		if (!strcmp(param, "memmap")) {
-			memmap_found = true;
-		} else if (IS_ENABLED(CONFIG_X86_64) && strstr(param, "hugepages")) {
+		if (IS_ENABLED(CONFIG_X86_64) && strstr(param, "hugepages")) {
 			parse_gb_huge_pages(param, val);
 		} else if (!strcmp(param, "mem")) {
 			char *p = val;
@@ -724,12 +720,6 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
 	if (minimum + image_size > mem_limit)
 		return 0;
 
-	/* Check if memmap= appears on the command line */
-	if (memmap_found) {
-		debug_putstr("memmap= found on the command line, disabling physical KASLR\n");
-		return 0;
-	}
-
 	/*
 	 * During kexec handover only process KHO scratch areas that are known
 	 * not to contain any data that must be preserved.
@@ -783,6 +773,11 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
+	if (cmdline_find_option_bool("memmap")) {
+		warn("KASLR disabled: 'memmap' on cmdline.");
+		return;
+	}
+
 	boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
 
 	if (IS_ENABLED(CONFIG_X86_32))


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

