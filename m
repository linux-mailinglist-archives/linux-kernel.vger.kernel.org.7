Return-Path: <linux-kernel+bounces-732801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC0DB06C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5171F5610D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B6E28CF41;
	Wed, 16 Jul 2025 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABm3Krow"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA128BAA5
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636170; cv=none; b=p9BAeqhK4rKQXZsm4vDS9Di+GCGI6RXNpHjFR3vDb+0PTLOBZn8r0rf4B4SgncCIjtHDgzV0CzUfzqdAiSn9yfoyF38qlmCaccMAi6VNHooHZ4HdIIASl7n7onqXZM+YHxwkxETnnD/NK8JD9YK1jW9RF/MEZrs+HOlj8aJlOc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636170; c=relaxed/simple;
	bh=AmlKbu8zJYacssviYCi6dbWYnFwBdiRVNUViWOcbTcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VXtzmcDU50vGqU0aZml7/8Ok/vkSJKBMYeYpuYjEEMBzufDXpJnkbgW5Iv8ZTtzcQ6+zs+Qc0gMilqpOq2zJwU+k0x1hfQPORlTqPT84AclTezugbyQ38d63rmKSMT1E8g3AAcYRHAbuYAhFyVad1c1m4Mu+Cu2wgfVVjf6rqXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ABm3Krow; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b20f50da27so190614f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636167; x=1753240967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hVGKhMjRai/1mEd80T8Cu2AXSEmjXsghMoyzlOM7Mo=;
        b=ABm3KrowQzFPJNDKEqHgEwTXI/u0uvxLNjETDAYG8uXZLRmD6hggHvDta/TsmchpIN
         Op11Gx9VFzpTBSaL5PZiw95fyeUarKGmv0uoEPG+gmKkCnE9WJbqZsj5eUlfTHUN60D1
         /NOE5vKHl894EDRtvStEyfJm3YBehLT1gSi9L6kPZr+AwMCXXoeLhVSZwDbdOBz8OnwD
         nQ1XUPuqbzKHdRMi1q+cKddxFoJTK8P7PK9uxHpVANfNj3WJytEELRM3iiOZ4PvlK6QD
         dFgp/X5XmVwsu4DNdinzecfhx7buf9/XJK63SsOI+8oKbMTa6S2YinBJsOxnLHtYu1om
         rqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636167; x=1753240967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hVGKhMjRai/1mEd80T8Cu2AXSEmjXsghMoyzlOM7Mo=;
        b=mypUMN5hSbUbFw31ikZKwFloiymFBSVQTavhQkQ1AdFoEVpe+AAgx4WjqWHqmziiOR
         QXXYW5psbXWo36tlh6CIujwwgWkSdSjSSXT/Rc7uMyZjFa6ntd9ijnNJzH6qWzZH4Dqo
         b/OY8zPF1GZi4e9nVeNCJTcYrEaoNtDWJjuqoLBFMQpVyx5EuPHKV+v23RX/DoCOjrmM
         qpmHIsBmURa9t3Yj4KOMTQBXjDfcElhi5GsHuK3qen5/ab92RArYtfzpcKrbIZA3vodh
         HC6ye9N1mmjdw4BEei2Gs/hLx7FInC4PxrbL0d/Pc8itqfZgjsPLZ0rxVQUTvRRyR7He
         a4Tg==
X-Gm-Message-State: AOJu0YyXrnwPRURTUEGIw4ehkuE50XR7aGqSUQpkS7vUSdtPQVIxdaql
	/uhggHKhzWFkxw3vPp4lFbEgjWpVFrORr9XKi+9c2j3R/es/lvuZryycadWr8D/8WiYv+kePpVR
	0RafaL6cvafLJjsx33kUVWfbFsqq9phr34INhPOHSbYGFDEEjhrH1uSqXHgXVdW5Acw0eISPMuz
	vrDhqC+tryUpznZo3zF9dfjxinuwxS9hzaNA==
X-Google-Smtp-Source: AGHT+IGqvSqRzkkXesMMPjPU91yAcp6rfeQuJTBvlb6S4I5TP7MHP10HqWBTpkxfXOGkBeuuu7B8vXft
X-Received: from wmbbi16.prod.google.com ([2002:a05:600c:3d90:b0:456:217f:2625])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4287:b0:3b3:9c56:b825
 with SMTP id ffacd0b85a97d-3b60953f526mr4626818f8f.22.1752636166476; Tue, 15
 Jul 2025 20:22:46 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:32 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=ardb@kernel.org;
 h=from:subject; bh=KDAfcfWDoK0sbR/OM+7rDP0GR1LPKwd+fvJZ7QocPEE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcKnhSIYPTd41NJaEC6Yu559R75qp4LlfcmXaya7dif
 IXF0wMdpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKcExgZ1thWnm68wDU5jjFX
 gIln4X9O20WB20r8tTs/adqdC7/awvBXLmuegVvHNx2Ld9xqtitl0ys0RDcxiH4K23Osaf1RKy9 2AA==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-41-ardb+git@google.com>
Subject: [PATCH v5 17/22] x86/boot: Revert "Reject absolute references in .head.text"
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


