Return-Path: <linux-kernel+bounces-889164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F60CC3CDDD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28B53BE249
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809ED2E11D7;
	Thu,  6 Nov 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yx9/ct3I"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05151221269
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450243; cv=none; b=ngHP+ib4y1Qt6RibSyuAZUttfGJsK9gi6mM9KJ/fcD272beE33ORTv51Pj2nApbCyUHSdOSRB1ikPNkz1aMYZpyLXpaX1+ZeInEUxbJAB4bm+f/DGuZptGlddKAYrT0pq/gYcBTT5ybLtqKnTbhTyikwusOnUnZq6OfT8rsPyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450243; c=relaxed/simple;
	bh=yT6QUJiKWzkz6yzzIgWLhIbgdPA0nhs7h8vP1Dc/pHU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RXIQ3sdzBZG0oUUZYUQqeQg2nQWYFtIaUmjmVzeGYDuuL+XMCzliVbct6t+1idqdLXdlz7wkaTJP9U9qNWSsXb9TaRkv5E6o5tVmpCUIz+LgqmbaIwUaIenD6mgOgEMwUdKZxMHwYrvL3WbIUgqMVZ6RBEs7stGB17T5CjXlYeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yx9/ct3I; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-475e032d81bso7836545e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762450240; x=1763055040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7n2oCkH68R0utcOgwtVQ6IXl5cSCkA6kggUCXIbwyXI=;
        b=yx9/ct3IaoZ0RMfjbbX3Sj3W5jBz/2HM4qX+bdi8Y87QKPvM30Np3pjlt/4cnEW4uC
         ZOWpvuGUIA0CebaDnTOJnf/lNKWObbZ/A4u0Om6ZQhQz4Vysy19TDM5pArPJnz1wMIsq
         6ZMLWoqJJSYQ50gkFXssEm1DoSim4YHFQesjn0mZyGzn6fBhFFWwtE1gXsXL3fyRk0DW
         JRZ2WpmcHFCjarnQSZk5bGbiO002jWsc2RbORrO986vkB+JSh6QE7Zrtu++zshhZhhyD
         a3zsJUShUbznInVN5TR2hCBLK+DgSk5TkSMdwNwu2jxo7yiSg6Tm6zy0MKUm2dwJtGbR
         M6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762450240; x=1763055040;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7n2oCkH68R0utcOgwtVQ6IXl5cSCkA6kggUCXIbwyXI=;
        b=LvOUFzxo8tZMg9L2uN0TtNcyfXGh+E2ad296iDgxSQG0tonODDvT9H2FAhm4mBZ3sb
         QaPokoG2or3/wh/k2T1E2P9a88HTKA6AmAOovFX7kAOBA9XJOPmNGJHiZc9idOhfUnBm
         7o7/PJxK+wnVFxvVShmT7hjP9mXuGMqSALOBaaCGqcHnKwQZzdyN2BdcWLLZzqflhy0O
         Zin5dC3DjqOP8Ieo2+h7aN98sBLCM9EN7v1SQrTQXRO2NxOiJI5Nj6aim6e2z30ByZtF
         28IaAZDjQvOlENi6VjW1bkS8Xm+QPy8sgn3EYi6EHbfF7ZBM/YL0/04pHZDnWLB03J/R
         qZIw==
X-Gm-Message-State: AOJu0Ywi3v4EYVAtW/J1B8c7tp5PzrfPYnIPG8i8cZfQ9LU/AFYE+SvZ
	CP3AZPCUf3PwC4wA11zIrONYzEI7mCNUF5nGtoLz0YCjj5mjuEF2p3D0mHkoYzq0gqZ+2gBFquv
	u16+/KvEXfEa8QBJbODLs/Hn96qVtAIXf7FomCoFSPkkbBs/SovDzEv+sy8jZF71FNL1Xmt3Qf/
	NP8glc4pfW1OcySELyTRMGu6duY0rIMYhjCQ==
X-Google-Smtp-Source: AGHT+IEANecjph2ACeT4krexGKyn8GI5syrXGwbez8p86E4JiKGATWN5cS6NQWAXdRgAddgoCfKlyEmX
X-Received: from wmco20.prod.google.com ([2002:a05:600c:a314:b0:477:d9d:9b35])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b1d:b0:475:dd7f:f6cd
 with SMTP id 5b1f17b1804b1-4776bcc70dcmr1292745e9.35.1762450240442; Thu, 06
 Nov 2025 09:30:40 -0800 (PST)
Date: Thu,  6 Nov 2025 18:30:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6479; i=ardb@kernel.org;
 h=from:subject; bh=y4QgoQY60VaFli63Bf1PpBvIyuiuI4Rw2Zhl6kAwmoI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZPntm7y0f9r21vNF/g3nTaIDg8qPLVqwaxzVk0bduzLa
 CkRvhXfUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbybgUjw8f7W2uWFXg2Kyzh
 bnrY+u2RTVx3zbHWk96XJBR/B/25ep6R4f3viZXVM2Xkn5Sum9aS3TqhT2uNheuTY/ed3j04cLk slwEA
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106173019.1224443-2-ardb+git@google.com>
Subject: [RFC PATCH] x86/boot/compressed: Disable physical KASLR when memmap= appears
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, kees@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Michal Clapinski <mclapinski@google.com>, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The decompressor physical KASLR randomization logic is rather intricate,
as it attempts to reconcile various kernel command line parameters such
as mem=, memmap= and hugepages=, in order to create a coherent picture
of which parts of physical RAM may be used to load the kernel.

The memmap= command line option is especially interesting, as it can
appear an unlimited number of times, and each occurrence can describe a
number of memory regions in a number of different ways (see below), with
no guarantees that those occurrences are mutually consistent.

Given that the current logic appears to be flawed, let's not bother and
just disable physical KASLR when memmap= appears at all.

  memmap=exactmap [KNL,X86,EARLY] Enable setting of an exact
  		E820 memory map, as specified by the user.
  		Such memmap=exactmap lines can be constructed based on
  		BIOS output or other requirements. See the memmap=nn@ss
  		option description.

  memmap=nn[KMG]@ss[KMG]
  		[KNL, X86,MIPS,XTENSA,EARLY] Force usage of a specific region of memory.
  		Region of memory to be used is from ss to ss+nn.
  		If @ss[KMG] is omitted, it is equivalent to mem=nn[KMG],
  		which limits max address to nn[KMG].
  		Multiple different regions can be specified,
  		comma delimited.
  		Example:
  			memmap=100M@2G,100M#3G,1G!1024G

  memmap=nn[KMG]#ss[KMG]
  		[KNL,ACPI,EARLY] Mark specific memory as ACPI data.
  		Region of memory to be marked is from ss to ss+nn.

  memmap=nn[KMG]$ss[KMG]
  		[KNL,ACPI,EARLY] Mark specific memory as reserved.
  		Region of memory to be reserved is from ss to ss+nn.
  		Example: Exclude memory from 0x18690000-0x1869ffff
  			 memmap=64K$0x18690000
  			 or
  			 memmap=0x10000$0x18690000
  		Some bootloaders may need an escape character before '$',
  		like Grub2, otherwise '$' and the following number
  		will be eaten.

  memmap=nn[KMG]!ss[KMG,EARLY]
  		[KNL,X86] Mark specific memory as protected.
  		Region of memory to be used, from ss to ss+nn.
  		The memory region may be marked as e820 type 12 (0xc)
  		and is NVDIMM or ADR memory.

  memmap=<size>%<offset>-<oldtype>+<newtype>
  		[KNL,ACPI,EARLY] Convert memory within the specified region
  		from <oldtype> to <newtype>. If "-<oldtype>" is left
  		out, the whole region will be marked as <newtype>,
  		even if previously unavailable. If "+<newtype>" is left
  		out, matching memory will be removed. Types are
  		specified as e820 types, e.g., 1 = RAM, 2 = reserved,
  		3 = ACPI, 12 = PRAM.

Reported-by: Michal Clapinski <mclapinski@google.com>
Reported-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/kaslr.c | 100 ++-----------------------------
 1 file changed, 6 insertions(+), 94 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 3b0948ad449f..96805d6c10a4 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -67,16 +67,11 @@ static unsigned long get_boot_seed(void)
 #define KASLR_COMPRESSED_BOOT
 #include "../../lib/kaslr.c"
 
-
-/* Only supporting at most 4 unusable memmap regions with kaslr */
-#define MAX_MEMMAP_REGIONS	4
-
-static bool memmap_too_large;
-
+static bool memmap_found;
 
 /*
  * Store memory limit: MAXMEM on 64-bit and KERNEL_IMAGE_SIZE on 32-bit.
- * It may be reduced by "mem=nn[KMG]" or "memmap=nn[KMG]" command line options.
+ * It may be reduced by "mem=nn[KMG]" command line options.
  */
 static u64 mem_limit;
 
@@ -88,8 +83,6 @@ enum mem_avoid_index {
 	MEM_AVOID_INITRD,
 	MEM_AVOID_CMDLINE,
 	MEM_AVOID_BOOTPARAMS,
-	MEM_AVOID_MEMMAP_BEGIN,
-	MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
 	MEM_AVOID_MAX,
 };
 
@@ -115,87 +108,6 @@ char *skip_spaces(const char *str)
 #include "../../../../lib/ctype.c"
 #include "../../../../lib/cmdline.c"
 
-static int
-parse_memmap(char *p, u64 *start, u64 *size)
-{
-	char *oldp;
-
-	if (!p)
-		return -EINVAL;
-
-	/* We don't care about this option here */
-	if (!strncmp(p, "exactmap", 8))
-		return -EINVAL;
-
-	oldp = p;
-	*size = memparse(p, &p);
-	if (p == oldp)
-		return -EINVAL;
-
-	switch (*p) {
-	case '#':
-	case '$':
-	case '!':
-		*start = memparse(p + 1, &p);
-		return 0;
-	case '@':
-		/*
-		 * memmap=nn@ss specifies usable region, should
-		 * be skipped
-		 */
-		*size = 0;
-		fallthrough;
-	default:
-		/*
-		 * If w/o offset, only size specified, memmap=nn[KMG] has the
-		 * same behaviour as mem=nn[KMG]. It limits the max address
-		 * system can use. Region above the limit should be avoided.
-		 */
-		*start = 0;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static void mem_avoid_memmap(char *str)
-{
-	static int i;
-
-	if (i >= MAX_MEMMAP_REGIONS)
-		return;
-
-	while (str && (i < MAX_MEMMAP_REGIONS)) {
-		int rc;
-		u64 start, size;
-		char *k = strchr(str, ',');
-
-		if (k)
-			*k++ = 0;
-
-		rc = parse_memmap(str, &start, &size);
-		if (rc < 0)
-			break;
-		str = k;
-
-		if (start == 0) {
-			/* Store the specified memory limit if size > 0 */
-			if (size > 0 && size < mem_limit)
-				mem_limit = size;
-
-			continue;
-		}
-
-		mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i].start = start;
-		mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i].size = size;
-		i++;
-	}
-
-	/* More than 4 memmaps, fail kaslr */
-	if ((i >= MAX_MEMMAP_REGIONS) && str)
-		memmap_too_large = true;
-}
-
 /* Store the number of 1GB huge pages which users specified: */
 static unsigned long max_gb_huge_pages;
 
@@ -254,7 +166,7 @@ static void handle_mem_options(void)
 			break;
 
 		if (!strcmp(param, "memmap")) {
-			mem_avoid_memmap(val);
+			memmap_found = true;
 		} else if (IS_ENABLED(CONFIG_X86_64) && strstr(param, "hugepages")) {
 			parse_gb_huge_pages(param, val);
 		} else if (!strcmp(param, "mem")) {
@@ -812,9 +724,9 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
 	if (minimum + image_size > mem_limit)
 		return 0;
 
-	/* Check if we had too many memmaps. */
-	if (memmap_too_large) {
-		debug_putstr("Aborted memory entries scan (more than 4 memmap= args)!\n");
+	/* Check if memmap= appears on the command line */
+	if (memmap_found) {
+		debug_putstr("memmap= found on the command line, disabling physical KASLR\n");
 		return 0;
 	}
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


