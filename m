Return-Path: <linux-kernel+bounces-789732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D533EB399B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A905E2C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9197E30F926;
	Thu, 28 Aug 2025 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cu+JJnz+"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BA030F53C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376577; cv=none; b=IUeote9IJRk812Rd2SctoWiWhuQTzqV7FP53QqPoLGuwp9Ns+NP6aCSRa2WPh9NUZrRhJV6CoNGF1t44MMjjdpnMwtEv9WBTgIfyy2Ng/QnCuAstSVUa268SfUkmGecoWthUUKlyNW7nPd4KaWI1viLoGNuX4yvwVn65qYyY/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376577; c=relaxed/simple;
	bh=zIl8q9uQpI2X7EKwuJC5u9QPpt9qfEp5AIbRjG9/qOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a1fMXaBCW2CWfsZacfUgM99RCPgVcfdMNmNAr8m2dIkPnkUyknX3gHl4+y5f8ecgSUw4hgvnT17qXtq4FLlfb6hS1HGG1DEfprpUHvDpgdBt/LPNgKCoaWOKDIfpU54ZEq3Yxgb3cbRUv6rKk8TBc6375UwD/7IibhC8Ka3FdGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cu+JJnz+; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0b2b5cso5515835e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376575; x=1756981375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1G/yn9yOCSAcxp41rzAZ4aYvHvF8XH+4CBnHBHHA7Q8=;
        b=cu+JJnz+HAi+cme6x248intieiNVnGOrq87AS097OJBi7Sr1Y8w9RgSHvveIt4mHwS
         Oqnkr7fJE8WnymqcJXlrLEzDvNrXKXn05wNY+zTuX9luWmYLbn1mi363Xc5ApjuiCAEn
         3v5l/PCBpO1eCKxBLpDoo3Sgsv+1uGKKtBoyyo+GkLcaYlPfMSRutJaPxRjzcGMlQ+Xw
         gwf/fC7jDz9yeeyr9ljHGxBVgIH5NAghKqCFzh33JmP94Urgx4xDXTlDUx0XAVMghIAT
         jtEkxP3WnB6L/ijRmrQW3eJwKA4vvEM87PGJOqtwWDMxccr2jnlrbUnng81MIljoaOAk
         z/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376575; x=1756981375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1G/yn9yOCSAcxp41rzAZ4aYvHvF8XH+4CBnHBHHA7Q8=;
        b=cs/xpOKK4xRxjORSWhJFkYWW0l/11vDFaimXOczcV20fAk5JZBd+Q7CgS3X3q3zE8O
         fKZIGmkuH4/WBQt6c3hD7RwdmR7UapkmBvT2Q6yN3rFf+1KZAfAsW9cd9O55FKE/VHXT
         aIGVr5TB4F7nuROP9iVCu4gIeBxlNNXvkam1iUsSUdjoXjAPw1oRIAZypQVrFdmzBYAP
         vvdJSvbYGjay7kUKD8JS8cbORrMBulPbI4SqUDdPdoGkd6PoCXojCxwNNIRhal+mjCY4
         of1nGGpwucKlUNt34NgFrilJNvLvmCzMwv4XB0nwGlZ1X4zJLiOT9uCpsWRZVbnUPYgU
         A6cw==
X-Gm-Message-State: AOJu0YyuLFEZcDzTI8t9t+E0WAII//dej/qBrzfToYPXHmH4kl02f9wo
	zXIoK1i++vi+cSspZxe1mG9sYB10uhPZWbWV9dO6oSYoAH80IkDHObWSnJQszdI+2MDhVGTF6GE
	U0f8vOprZxHCN4ABZO+5dvtXgPh1lj0qFOzofsepqcC8G+iWtad2nwkqNf2L2yvgiP0E5aD2xhI
	AEqr1wwXO4wsRlOMhI8lxj6yazs77Quvripg==
X-Google-Smtp-Source: AGHT+IHp24pY4Owf8k/qm9JSaITBLoOezuxyBhsRCmmgmMuE5DWI4hEK3LC7LbHDVPgoEtvUXrOC5BTE
X-Received: from wmbay41.prod.google.com ([2002:a05:600c:1e29:b0:459:dfcf:15e4])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5d81:0:b0:3b8:893f:a185
 with SMTP id ffacd0b85a97d-3c5dce05cc8mr17269335f8f.53.1756376574534; Thu, 28
 Aug 2025 03:22:54 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:20 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=ardb@kernel.org;
 h=from:subject; bh=0iFUpR99/rJ4BsTpi1I0iwnKOpixfxzyxPQTBrstses=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7n07m10S50W+H65Xyc623rP9cNDm4Lf7X/b2Tdy2e
 oIxp/zzjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRiJeMDBs7fm/TqFJT6Cmu
 vGJx18dvzU29+Q6TH87RXXxu55O5Bk8YGW7bT1xSpfRq7ofcq6HHYgs+CC7ZsrSNo0SPU7eN+Wu DOBcA
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-41-ardb+git@google.com>
Subject: [PATCH v7 17/22] x86/boot: Revert "Reject absolute references in .head.text"
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This reverts commit

  faf0ed487415 ("x86/boot: Reject absolute references in .head.text")

The startup code is checked directly for the absence of absolute symbol
references, so checking the .head.text section in the relocs tool is no
longer needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/tools/relocs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 5778bc498415..e5a2b9a912d1 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -740,10 +740,10 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
 {
-	int headtext = !strcmp(sec_name(sec->shdr.sh_info), ".head.text");
 	unsigned r_type = ELF64_R_TYPE(rel->r_info);
 	ElfW(Addr) offset = rel->r_offset;
 	int shn_abs = (sym->st_shndx == SHN_ABS) && !is_reloc(S_REL, symname);
+
 	if (sym->st_shndx == SHN_UNDEF)
 		return 0;
 
@@ -783,12 +783,6 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			break;
 		}
 
-		if (headtext) {
-			die("Absolute reference to symbol '%s' not permitted in .head.text\n",
-			    symname);
-			break;
-		}
-
 		/*
 		 * Relocation offsets for 64 bit kernels are output
 		 * as 32 bits and sign extended back to 64 bits when
-- 
2.51.0.268.g9569e192d0-goog


