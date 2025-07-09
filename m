Return-Path: <linux-kernel+bounces-723044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AF2AFE217
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F381C27FE8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1D923B61E;
	Wed,  9 Jul 2025 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VPLb7UuJ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6C2797AB
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048687; cv=none; b=DuLGi7YX1ah1oUmaQrbvFfxkzQl6J5D7hqHtqNVgeCmtO9Oh/jM5/fd0z1csD3aLQ8HlhaNe0VxgWfq79/XSVywt/2/ur6W4IhLIFBe4HsrlQ8hZECKB82dyVc7Sv+ygiugLtVoEs7cqGRWYS9+GosnvFn+fZdl+NDdKae8AHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048687; c=relaxed/simple;
	bh=fJcYtM8/fGIml+gUrbA3B9+0tJv6sto5kDQD5ecvJe0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DbTJl4WGVuwA05qbzUdNjYxk9lsORvBr5eveiE06Nvx0TlvJBEiG/e1yvelM8W38WL9Yszo0mkeAHI8XQxlR90hDIZEBknkcWxkADuSHhpNxPREfT91oOPGD0RNjsM5KiLarhNT0ItKxwHrbKMjqm1QIU2aHxb+grvSRXyKtwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VPLb7UuJ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so30898365e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048684; x=1752653484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8S6FutNEGZVTbNW/QSpeSjkaYrVTk312wjGqKvvjtA=;
        b=VPLb7UuJW2U0Znht67/nqUKBT5V5jajgLgSsjiJbKnk/R4KEagP6dfD/XcndrxSyKK
         xhjFhB/78PFmWYOXZMpTJfHXWO/ZtlDGjOb07DU34g4jrXHGv3doI09zkSH+m++7tlfv
         3zc90yng2d7v1ROo7FcrEAhMaVgIJrUzJGVLL9FPa10BivV9h7qMwCpmStW9R8KOleu/
         t3OKySvNOsUM4aM41DldRxVh2BRhwKEQwlFSZEZszG6pe+g/1Gv0jQkRZzcBcVZbkTo4
         uw4UdZrgYgZDYwfprlU8DNEd5gjQANAwj/MUVTDWiaAFvU0JIvnNmwSsEHGOoWFJtMdO
         pdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048684; x=1752653484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8S6FutNEGZVTbNW/QSpeSjkaYrVTk312wjGqKvvjtA=;
        b=jy7ZDmzj8EtEEUgV9kim1x2FE6tEU/sXcnVqnMqD2N4EgV758qYnpBW6Vr8KkK0FVT
         7UllF3gLlRU2bM8tWkqaYl6q71fwwN4QoX32/RmGw3YYXeLay/PnIVphZkOtWsnqKCgF
         iJ6hMQGPqcYwdffsu0TmG0njbzgWSjsGy54d9lk7JMIAAQ3JV6HfClmHVSsLr5IxJo2e
         GgNeL2UESG0/AYx+ksr+YyR9aG0t+pN2QKpOVtT+NKzcsTPZaZK0DCXedj6dBZKReKgu
         y4EPorW2/MAtJqsC7gXZXbLeeXFoq10YAR2Kb961zirGnbkbymaJxd8aNcLotO2r2K9E
         aWwQ==
X-Gm-Message-State: AOJu0YxqCL8D5XqY8RUMoYUp5jb2Nra7DVlS7nO+Bw/tnCTsFJsfd0Ys
	34BBjsNN0n+kfr+Ka/HULDds6kj/CUWaB/kIXnWq1e4k3l90u+qWt18WyXROjyapJju08JEexaI
	X6golTsya3gyEsn35tCcmDXxCc0XTm8GIbr9T9y6PMKSbGB1HrLQdZ208y8u9kIpj22eN2eEz3R
	3N4tTW/es0YWLGMqk/YPuLKKcv7PVXX10rSw==
X-Google-Smtp-Source: AGHT+IF/2oywNPmCVy8OoEg72uth/Vh3PkO8Uqu0n7ROrVBRePm5C9JPNG28JMAa/5gdGZSO3vYKXFfj
X-Received: from wmco28.prod.google.com ([2002:a05:600c:a31c:b0:453:f66:5f37])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d1a:b0:453:9bf:6f79
 with SMTP id 5b1f17b1804b1-454d53d6b7dmr10896575e9.26.1752048684215; Wed, 09
 Jul 2025 01:11:24 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:52 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=ardb@kernel.org;
 h=from:subject; bh=Ei8Zz3GyIokIv9Nrhza17wU0/expoVh33nG8ypvaKpk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+bCKulUPl3zGhVtJjnV7hGbJ2Arv+tp4pLY2clfHF
 AMtE72OUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJFaXYb/7ocsstkVNT02Nt32
 4u/fLH5UxlbvndHkkG2NzboV9zNjGRn2BVluT+tYpL5c/Ftm9vwJl59ln1WftNbjsovyk4eFv7e yAQA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-37-ardb+git@google.com>
Subject: [PATCH v4 11/24] x86/boot: Drop redundant RMPADJUST in SEV SVSM
 presence check
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

snp_vmpl will be assigned a non-zero value when executing at a VMPL
other than 0, and this is inferred from a call to RMPADJUST, which only
works when running at VMPL0.

This means that testing snp_vmpl is sufficient, and there is no need to
perform the same check again.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index e67413bc78fd..5fd51f51e55c 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -403,30 +403,16 @@ void sev_enable(struct boot_params *bp)
 	 */
 	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
 		u64 hv_features;
-		int ret;
 
 		hv_features = get_hv_features();
 		if (!(hv_features & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
 		/*
-		 * Enforce running at VMPL0 or with an SVSM.
-		 *
-		 * Use RMPADJUST (see the rmpadjust() function for a description of
-		 * what the instruction does) to update the VMPL1 permissions of a
-		 * page. If the guest is running at VMPL0, this will succeed. If the
-		 * guest is running at any other VMPL, this will fail. Linux SNP guests
-		 * only ever run at a single VMPL level so permission mask changes of a
-		 * lesser-privileged VMPL are a don't-care.
+		 * Running at VMPL0 is required unless an SVSM is present and
+		 * the hypervisor supports the required SVSM GHCB events.
 		 */
-		ret = rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1);
-
-		/*
-		 * Running at VMPL0 is not required if an SVSM is present and the hypervisor
-		 * supports the required SVSM GHCB events.
-		 */
-		if (ret &&
-		    !(snp_vmpl && (hv_features & GHCB_HV_FT_SNP_MULTI_VMPL)))
+		if (snp_vmpl > 0 && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
 
-- 
2.50.0.727.gbf7dc18ff4-goog


