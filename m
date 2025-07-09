Return-Path: <linux-kernel+bounces-723052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF85EAFE22C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2E5545E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2C2280CF6;
	Wed,  9 Jul 2025 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyvTHlzn"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09927FD72
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048705; cv=none; b=u2hMFseqoOLSxV3CMz1iqw+wLY3gfzOjIiM0bLM5OEldKWnGqwAUnhig7tLYvTH0Ji4gtYh0CEPJBLSSRDMDx+AZMoJZ2WZedPMzXugTBJqS/JmE+rXjb9z2XiusJ2t82RNB5Ch21dACfQI5a2/+33PVAMgWVtM0DinaTMJ2QrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048705; c=relaxed/simple;
	bh=AmlKbu8zJYacssviYCi6dbWYnFwBdiRVNUViWOcbTcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QozXsoD20szr4p2aOTbPJgDFkJGKNrBTRTNVE2vWZQsXpWdbXLVXNw1bWma+z4XjdCtSv3bIpdqrHDMbtdyX3Khh/dQJrQoTcVDIkUyXOhc2I+G0QYDpb6pA8SZqdfrsNyXCZJTrnsPYJ/CdOZcUtLKweahz2ykkjz+ZTWJlUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyvTHlzn; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45320bfc18dso3447995e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048702; x=1752653502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hVGKhMjRai/1mEd80T8Cu2AXSEmjXsghMoyzlOM7Mo=;
        b=OyvTHlznYRwb3FcLgB+Y8dAP+sppZj1EoH15js029H4FHR6LBysnb+WW7h2VAHCB2t
         m6YbS6f2U0Ml2QzE0Q8NEZKG/5gcHR8WeAQeLvNajtuThOcvhSylMYBQ2S3FlD+tTGjA
         Srmy8ScidVCtMkqS1Y73j+1S2N01It2+DdjL7O9qrPWIjeW43pRPHyM8Q7r8pTXFR5JR
         lBkWLzuzLwaobFOJhc886Yh9yIwK0LCxTVihV9ZJHp2w7UKjjsr6itpdOmmtqYJQNhXc
         o2PGiwDzUqqxLIjf2En6ci+sy2Tf9UhaUgkuBSzTvaXSQsld7sijrx2Ion9+al2F4cS6
         79lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048702; x=1752653502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hVGKhMjRai/1mEd80T8Cu2AXSEmjXsghMoyzlOM7Mo=;
        b=VHOyfBMMt9u3l7QJXWhWNaMHZVdvHfW4dcncwBty5Igg2ngOtS/LMpP6mhrB8S0Du2
         1ZRKb+QioNwWas5coKk1+pB3v5RF7avBbGpXF+j6oZ0VNNdL3rXVTFAwIDkpyTfbetGv
         htB8FpamidNGz98J6gIfqc122gZM1aOspJxAPY9OT5rQ7gNypCr/NrDPx+dpUxIo3and
         Xb8bsYAdGn8tLdxYTJ0h5tZH2pmnSd6D+H9ycooiLSayIWahW5kia++z9eZGa07Hm/rn
         NZLRdR2NpzpRzFcvIxksFfFoTDyoHhtg9gaXkKAye15xdhdwmhdwDgTq5r6A9D2xPnIW
         pl8Q==
X-Gm-Message-State: AOJu0Yz/zU3tL5G3RsyNwhaH7fCdy0VyVq/P/cYNHjLKrqAk+mViuduQ
	CbyBUL34kshUV2Cps8yeYBpezi0KARUEgMAjJ7I859bdaBEjmzdncKiWipJQEAD+cYsdlXE+VRr
	uIQc3m7tbl5VUB1HxiHv18EQb2A1RCg2mWWgEE/QSup2iYjpkO51k8uI9iWVW3ls8yB3oRduNpz
	Bv/I+ZcPjF5Dy9bvS5M8nO1X5UAoW59rDGuw==
X-Google-Smtp-Source: AGHT+IEyIquEbQEH2XQgM9Am5j5CZttft0M/G9q4PjYLZ2kIJId4RLfw2srVlXtXccp038ubTmGePia6
X-Received: from wmsn39.prod.google.com ([2002:a05:600c:3ba7:b0:447:e492:6959])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b0f:b0:453:aca:4d08
 with SMTP id 5b1f17b1804b1-454d545fc59mr12700495e9.1.1752048701933; Wed, 09
 Jul 2025 01:11:41 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:09:00 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=ardb@kernel.org;
 h=from:subject; bh=KDAfcfWDoK0sbR/OM+7rDP0GR1LPKwd+fvJZ7QocPEE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+fWkQgan7xqbSkIF0hdzz6n3zFXxXK64M+1k127F+
 AqLpwc6SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESunGRkeBHxgD1SbWKvmJTS
 g7wb4sWWzrZ1SltiynIL/Df6dM9fw8hw/hD/VsVwre6C1Pfrxa5nal3/tWL1QZeW9znB+78qLnr CBAA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-45-ardb+git@google.com>
Subject: [PATCH v4 19/24] x86/boot: Revert "Reject absolute references in .head.text"
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
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


