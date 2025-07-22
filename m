Return-Path: <linux-kernel+bounces-740362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB8B0D34E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32B916A9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1932E2E1723;
	Tue, 22 Jul 2025 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1McUssu"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92482DFF17
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169410; cv=none; b=penupVDizjFtsKknGSgPQ2U9GGw+DbGRZxuSf1Juh1p/SZAALqFbnebELu4yoVVSqZbN9HSssqaBJ6Lx6Nb/mqHLOpFUNlRGbRh/ARk8Q/QRaVh0iBeH4k8IDoPPxOdvWuIxj7W4NJgYPIG9Qi5lQNbsf3cNn/F+/CmTnrL3k4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169410; c=relaxed/simple;
	bh=AmlKbu8zJYacssviYCi6dbWYnFwBdiRVNUViWOcbTcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=REUsNhqkDTa8pirLFExfg+AH0tlEGGuos3b9kfkiVautp4SFplBonyHj3lzV/dzGpwpLaEmVg1H2SFaOGznovjE3mU2jp2OfMMegujCwdtKxvgx2LDGoOwrdmFBGri7PyY+kVYH15ESXq2+VFAIP+YIbNrFMbP/B+TpDDUDccD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1McUssu; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-455ea9cb0beso39397635e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169407; x=1753774207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hVGKhMjRai/1mEd80T8Cu2AXSEmjXsghMoyzlOM7Mo=;
        b=h1McUssuqcyorn+NuOBkhLpkIY0vxGShWGq0jSVOVtMlyvAJzcftFfPNP33qdGTJGJ
         xbb0+ti2oyvad2DXSmqmNaGyIii1sUgIH13zZ48y6XoHJ1E2+Wlgvqmzphq4x42u8Tap
         N+9jLYO9OZ+BdwRGj4A9vNcsxoR9J7nQnNrB1+nNIzgQFwlWojSzDD6LoGsdTX5JjlSO
         sbh9/i5Fy4NMAM9P+R3bxoVF7/LUdhzapb9EmnFz8pRCHbyiL1EEO/xmk2sERUAujxM/
         HXez9svkqHKZr2XWdS/6bVwL+AoisBDJeE/I4f4aJvC0dHnkPunCsIY1wb0EX0Tat5aE
         c2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169407; x=1753774207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hVGKhMjRai/1mEd80T8Cu2AXSEmjXsghMoyzlOM7Mo=;
        b=oNbC7zbfSWO4kVcnMcjGXtoCXTrAsA1YSlrOMBTDaHiPZMm/wlinZsWqJOSfyyFL/P
         sdTAbbXW+xq5TmywwJw7Po5cILP5pSTzA951ymIF4zyGTldu5xDuj65RbNCB965ZoC1R
         NXh3+mlf5uAyd3chOr4jsvLYk3GGelXqUChKwEY3Ql5gZHFVlWkPcQF4+X3Y3fy0MBhs
         J/u5dYG4I8oCZPnwuY4OqGbxQdHQ9TJ9weEJroIwNsekri90yn51YvVa+p3njK78jJNQ
         bq31izRfuBqKXY/fP2YNbiyHQhwkP8d+GmGGE+ySrOQdtzR3c2ZCQbzvX1UxTgGnuEF+
         YY4g==
X-Gm-Message-State: AOJu0Yz1E0JSERQLwaTnvzQb91yhV4Dne7bGl9F0a+FZqO1vaSHNNICt
	q7uACH9iGpWBPHiDlBdnIewDy+ndJAnj4qXxSGenLk3cyCQnSf4vOQt0sQ1z3/0wOQkSi8Z//u8
	P44GjZTiFK2NHmzzC95heHVlLtvg/yxG3bOqflz+IMN1Bm/LZsbomaVLPn4Qp6qxzWF0Gm/9ODu
	wkqyWJRx/KvUEekwjzte6/8Z9iF3vKJyKrfg==
X-Google-Smtp-Source: AGHT+IFQw1Gt8sUpFzMar6liYIqnbqdSLilgtBw3ziaxa7IURJrbu9o4g8gA0aKs7L4TBcN3/wJxdWqh
X-Received: from wmbeq10.prod.google.com ([2002:a05:600c:848a:b0:455:e7b2:5b41])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d1e:b0:455:f59e:fd9b
 with SMTP id 5b1f17b1804b1-45636aedcddmr160591825e9.24.1753169407156; Tue, 22
 Jul 2025 00:30:07 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:26 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=ardb@kernel.org;
 h=from:subject; bh=KDAfcfWDoK0sbR/OM+7rDP0GR1LPKwd+fvJZ7QocPEE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPedsGkQgan7xqbSkIF0hdzz6n3zFXxXK64M+1k127F+
 AqLpwc6SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQsTBj+WQdt+HQuNuDJ595N
 Jr1pAavkmi1eFgadlZ76xjYk+uSXCwz/657JBqc/OLl6jUrt2h/pH3///CN+2PODX9eG4J0BXBK fGAA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-41-ardb+git@google.com>
Subject: [PATCH v6 17/22] x86/boot: Revert "Reject absolute references in .head.text"
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
2.50.0.727.gbf7dc18ff4-goog


