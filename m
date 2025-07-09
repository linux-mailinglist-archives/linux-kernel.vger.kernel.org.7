Return-Path: <linux-kernel+bounces-723040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2423FAFE20E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4442D7A2C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF059274FCA;
	Wed,  9 Jul 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+Qv85OX"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD0274668
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048679; cv=none; b=g0rrUqEcXF41UkJcpcGOEmP8ZR/o1GQnJtcdbxXn4hH/sTIZ4apAIj/lovznATl2cadQmM+K1SqrcIxEenj0+YMdrDlAAK1EULHIZCY2rjCzmygJtahiTm80ET32qI3UQ1cITp44RPEVjyL5pKTpuVVrMdBEs0Z6aj8i7ukYtoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048679; c=relaxed/simple;
	bh=hWBN21MKm0IPBp3lB67br/CdndA3piBjkjD19asoZTg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nz+j6apw6Fd9bSdUrMSRiS/Zn8Tzf7AvFxMInpBYwJPNBU8HVZd4uKb9ugbbRGMxDbZoy07PAhETqTzR0c6zOiOjMS0pvdA0QCUK1jhGTBBmcjq5Iu9VgCLFp0xoUstz2yG2w3pBoMx/kZ5Add4afyZiIGussTvMwyn0KjpD9Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+Qv85OX; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-450db029f2aso25508175e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048676; x=1752653476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SE6ka4hfIkzkzecWjCIdvhn4wRad4vDOCNoAajoetIs=;
        b=D+Qv85OXDRGQ8oVkjF50tt2UDaG8Gn//FKkbJmXmQPiQQdXVN/odDLyHmkCMFKLVLx
         eTDqPp3KRVSb5qJDaXswhKjLsJtJimam3X+e8RLhnQAsquSiQap+U705baZH8avBZ5PM
         7pm5/VMbyGm0QDZJ3sKgnDq68582E7E5gJFBz+lKO/Cz7HVDlIQ2mrGQBCe3eVsQP/BA
         t7qHALBh6Lc6I9+veemBdJOChYFsmLJ5RpZHL3OmQBjsrhkntYTpEsnljEN9YVK+FwOc
         cflheGH/HReTSjIH9/bfW6MWbjafbfd61OpLrYxvSx1P+lBqM2UF8swZb0spNUtEDu1b
         O4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048676; x=1752653476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SE6ka4hfIkzkzecWjCIdvhn4wRad4vDOCNoAajoetIs=;
        b=IymU0+7tpfoi9QfjbpnbXK1pWp/VPJS1w8Epy39QoeKwK2RBFt1SuYEZjNJR9/kkaS
         4pia/XzdpWefBVm2rRybDc/9IrdhjyOzUD2rsHcjqJUSqXz8WTKTsnpfy6qTUv3/+sMv
         J3XOE67CGThW+DwoUj23ShUQsy0uzltSnfvdNfa+F5cXdqc54Z/O/UDazWGZYe13gnlx
         fHCFJINZLtHULrkgVsXFzxI3MUIxvm8lGegZ6cR2dA4AaRYqnJkCec4D+l/pFajRh3GC
         1zhFfJ5s/jTB6otI+WxkWAzcopSy55yYGumY81JumG5tMf+laELdxvSY7CcxhgGI0JCa
         8Jdw==
X-Gm-Message-State: AOJu0Yw8IQBy4VP7BQ2MtNtH0kPJUGBfZYmSOphJJUp/8aTJJ+ENtwFp
	LXe60zZpdvgqqDSkCvOSqW34/IhprRFwISpQvH8lWZt9cM4GPrRRwZhiao3kJbW2TmX6VDkT9Ky
	Rlg9po7L6NQ79kIGCSH67EXCchDYUF55ShjzZF1qjb0T/I269GaMrycr4ByHSf8Dzq53LmNuaAL
	aS9eNCr+/qTa2xILzX9fQzqyQrfbL4KEi4ng==
X-Google-Smtp-Source: AGHT+IGJXDWMcNvqrB7O9d7CiaGZGGqbY3yFFMTpPjUWz/slPV6Ys9FifTx6bNG83+1JrQQ3gZTiiSJW
X-Received: from wmco28.prod.google.com ([2002:a05:600c:a31c:b0:453:f66:5f37])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e09:b0:44a:b793:9e4f
 with SMTP id 5b1f17b1804b1-454d53a799emr11312535e9.19.1752048676251; Wed, 09
 Jul 2025 01:11:16 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:48 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2568; i=ardb@kernel.org;
 h=from:subject; bh=MfTuguQkKRk7zPgVN6OJ7MlTRDEEvX8Q+P+1ZFmIP8Y=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNPef3SyAvfkifl+T25/461Z4quEPvZ9/VBZ2M/2/cfr
 orKdm3uKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABN5UMTI0FN28a9cwYFTjqFP
 s4Rur/dQD896kae+pvceb8LPM19V/jH8rwiVkHpz/O6NA5pXnpndspzBUX2pc4tya15k8YHV6ou 38AAA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-33-ardb+git@google.com>
Subject: [PATCH v4 07/24] x86/sev: Move MSR save/restore out of early page
 state change helper
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The function __page_state_change() in the decompressor is very similar
to the loop in early_set_pages_state(), and they can share this code
once the MSR save/restore is moved out.

This also avoids doing the preserve/restore for each page in a longer
sequence unnecessarily.

This simplifies subsequent changes, where the APIs used by
__page_state_change() are modified for better separation between startup
code and ordinary code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 6c0f91d38595..f00f68175f14 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -71,9 +71,6 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if (op == SNP_PAGE_STATE_SHARED)
 		pvalidate_4k_page(paddr, paddr, false);
 
-	/* Save the current GHCB MSR value */
-	msr = sev_es_rd_ghcb_msr();
-
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
 	VMGEXIT();
@@ -83,9 +80,6 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 
-	/* Restore the GHCB MSR value */
-	sev_es_wr_ghcb_msr(msr);
-
 	/*
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
@@ -96,18 +90,26 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 
 void snp_set_page_private(unsigned long paddr)
 {
+	u64 msr;
+
 	if (!sev_snp_enabled())
 		return;
 
+	msr = sev_es_rd_ghcb_msr();
 	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
+	sev_es_wr_ghcb_msr(msr);
 }
 
 void snp_set_page_shared(unsigned long paddr)
 {
+	u64 msr;
+
 	if (!sev_snp_enabled())
 		return;
 
+	msr = sev_es_rd_ghcb_msr();
 	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
+	sev_es_wr_ghcb_msr(msr);
 }
 
 bool early_setup_ghcb(void)
@@ -132,8 +134,11 @@ bool early_setup_ghcb(void)
 
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
+	u64 msr = sev_es_rd_ghcb_msr();
+
 	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
 		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
+	sev_es_wr_ghcb_msr(msr);
 }
 
 void sev_es_shutdown_ghcb(void)
-- 
2.50.0.727.gbf7dc18ff4-goog


