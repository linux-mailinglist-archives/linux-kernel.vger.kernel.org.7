Return-Path: <linux-kernel+bounces-631266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24DFAA85CC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 May 2025 11:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351E73A74BA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 May 2025 09:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245EF1F3BBE;
	Sun,  4 May 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4Pt2ZI0"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9721F3BB5
	for <linux-kernel@vger.kernel.org>; Sun,  4 May 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352433; cv=none; b=CS5brSCLL6tM3AyS0teAhDDAmSwgCp02xX/WcK5ChcYA346gzHLX4QfdTpo2JZIAVhr3a3VlWUW/ZIIB1UhnwfiJyEi4vNKgJRM1eO7I7d/6YOhfPayiaoFt6CcH0Q4NV+3tzssC/6f9j1Le2drD1w/RxsSWfkGt9nkwsA6zSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352433; c=relaxed/simple;
	bh=wuHAfmatSUs0eQGLjdRIUylP9w5pVwSp6jih2u1d2Nc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=boyN8sKZcksAdS3vYbAssoWg1OGaobXNCyvoPArX5NibHjH2j8pRztJfcwyJhyjzYtuT0sR6DvX5IME1tBd+1lJejTRaAXhRPa8SyrUAhnHbYmoOmIWg2ekmP/EOrRX3vKy8hfHeQ+i0fZYA5KEslda/GtseJTk+oboKF00jRNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4Pt2ZI0; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so14046695e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 May 2025 02:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352430; x=1746957230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BngAQLfFrYEWXhjcTmuThO4xgzttYUC9luJvEjHMWdQ=;
        b=q4Pt2ZI0VWKKVj3cSxoegX4K7yR1vgrwHtcGEnIEOZ3W24aa/rrGjZXyDBYJjeQZnz
         XjHDGoT7n+yR398RT5ib/aKuEWglOcqE2U0eYqOi7pjLbOERGrPD1b8nVt5/pb6T4e42
         fGrttmcy9OVDVXJmkGFLeVdnq50Fr78IHUyM7REfEyzN7MNrfzCQLCbXZUv6HJvXpQhP
         XDqKtoelu4GqqryQqwPq9ES70zfIz6Vkuxo58BbNGv/qa+rdeP6psNrOw5jAhgl7Lt4J
         CrGXsy59vO+AVxoqpi2ZzJ7dKcNNPnXh3htn9KCfSmAGr2YpXWSkypilVfmIyKwrZb+7
         ZDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352430; x=1746957230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BngAQLfFrYEWXhjcTmuThO4xgzttYUC9luJvEjHMWdQ=;
        b=I71dEpEH0kOh074rkrip9UTI6amkprrOU/OiJ9/rBEkrPaAatPuFNFTcdnbKZSSq1/
         909jNhmmXO7UGE1ErcezvUsn+YTZYToaKZejtsvJdMKaGl+wjJI/WhbHoG+VWpIpmIXe
         /CEZZqs+0y65MGB9duCYmVbayGA84r20G7AXPru2p6ICbRqzUCK1Nd01bAq9mWhd5HHZ
         T2G6vj31t99y+sTJLushG+zmKV7kbbD7ehVaBFwjNhlQQZc3MEpT1evT7vxKyqMsLzh4
         NL0wrbOlqYRttdPx4fWEMZRUCyV74/VpKpvTM5cFhRpKq/oMefFIh6vSNFwoSpE3cSPV
         MALQ==
X-Gm-Message-State: AOJu0YzmUHWtapYIPcIv3O4YjJ+biBPFlqSra1cU1x+ATqMo3i1RYF15
	FDPoN4R2fFaVR3dgpnT8YwrJHuf9Kzz19uHv43WQy36b6lQ69jCRc9l90BSUf0kyzBDTTbMiF1L
	NheQTGb5P+/qVeQudBEd6DmIt/ufeGktBs7vBfuafeGRmCI8MuMHyfG+wwoHSQxCeATOd0jHf4r
	J3Bo1QC2BFyQUn2wkW3w4k8rjBuSYZCw==
X-Google-Smtp-Source: AGHT+IHMOiV5Mdn5v77/gifWvnDjJAZiAxp/513QM5JcQVs+myLHjDeNQH95LNNEsbP9E0pI95c69lwy
X-Received: from wmbbi15.prod.google.com ([2002:a05:600c:3d8f:b0:43b:bf16:d6be])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5246:b0:43c:ec4c:25b4
 with SMTP id 5b1f17b1804b1-441bbec23e8mr88386825e9.10.1746352430181; Sun, 04
 May 2025 02:53:50 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:52 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=ardb@kernel.org;
 h=from:subject; bh=SfyGJVp/cmZ3yoM/3fyJKQWjWHpwNBvXWOMO7V8FZ4I=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4vfX/MYf5f1zwwzKZ2wNCdpqLG86K/P1QdbQNdfVj
 j6zefy3o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyk3JXhv3/GviO9DDaO89Yc
 za93yHo0S/d7aVCOr1rJasXgqWKrpzIyPJh+5g3Tl11p3FZGRQkctopygW+aDr0Uf3ok7kSB66E qNgA=
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-47-ardb+git@google.com>
Subject: [RFT PATCH v2 22/23] x86/boot: Revert "Reject absolute references in .head.text"
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This reverts commit faf0ed487415f76fe4acf7980ce360901f5e1698.

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
2.49.0.906.g1f30a19c02-goog


