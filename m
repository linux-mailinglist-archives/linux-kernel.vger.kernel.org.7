Return-Path: <linux-kernel+bounces-807456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4189BB4A484
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 227DC4E2394
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD19246332;
	Tue,  9 Sep 2025 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhQUWHav"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC61DDC5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405209; cv=none; b=BbW25voW0j4O71T65XjeyovnJwDedSGsrjg9ALeTBQLn4f4Gg++Tq2V9zOFwEmiICtzZJYusWgql7NLccxZdNJZh3WrNoyGOFGLkgKBgLOdVNG/5FixB3neHk8j+dpofqJkslT2J2T6fGp8EDyhelyId14ez1Rnfuda6x4gG0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405209; c=relaxed/simple;
	bh=gEBrGLcTCYBTDaHRZjjQ4TRR7XwTHPOepnjLVMTZWN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ULh1/5jy80jAaUZPQUsmq52x1HxJ6Y0o45QarfQDl+8t0nGe/ECPpJBd1BuyNrRrhvvkJ4GXmdfxDGrMKFX+RD4j2B+hvx1eNlXWmTWtWXTKfW73MIUvJQRm1m8hbwuYgkdoJAxKoqy9X++NPtOJ0JEYVOokfZLUC30rODsHQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dhQUWHav; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45dcf5f1239so20384815e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757405206; x=1758010006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hT6lomWwcUBoMRdDm5sUU/9gcCtnYSc12sPEJ1Evnc=;
        b=dhQUWHav7mo9PV26Q8fThrxdSrkWRxPykZ4efcbu3nCQLHnso/g1CTwpU8T/o65gOA
         QTjU7i3c53cAEbNj9mUfxbUZSXMLcKBxnM1hCM9T9HI4u2+etL6Z60OmdzbR6UfUwT8m
         TTReiPVpV0MK88HHL8ldwjC5Q5wWc0NJhMnia2kRc9cMe6J5NCeGOEILbiNYdArlGlNT
         73ZPAIjgDBjX2/V1GM5KMEhsE/r5ThNyEbNpgQ2VC0P1CIeivgmgKLfSt2pC9nMEH1vC
         JRdbAwszwJ8IuzvHZ0gkTEhEUfTrU4vvll/fhm2Z2ko2nsIuOHEGNo6iOlMAem7jE1ev
         v2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405206; x=1758010006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hT6lomWwcUBoMRdDm5sUU/9gcCtnYSc12sPEJ1Evnc=;
        b=FOXuwkwPsRuOoXI0bre6hio+EgIN6aH4yA8yjOuiPRqkDuAgpi+t/iwQe9FpKpF7Vk
         j/FiuFYRfY+fbJ0D1WrsRD23uxylrbS/lT8dlbbCwtD9BRju+fAZ3QaIVVhAzLbl77gT
         RbIwL4GpDQYc3gCgGBbFIolt8dMzob+UWEI4jp/aVejEiHbzFVFOa4R4iJiHnZzckww3
         od3/qO3OOYDFxX2CLhJJS+ehWCcqitSJFWHUfV7P6fPlqJ2tdb53Id9qSoT7mbQkXMUe
         fBPOg+VALmJdaRT4W5trKH2G36CGQbJyKr23ufn+QsCcnp4NbBcMUGpFqKw8FaYWJrTw
         5njQ==
X-Gm-Message-State: AOJu0Yzh9jhU3SvMJHgv9572Bl4vBxw/9n0tXQJfYKvEAQ0DBY24QXej
	hqlxK8aB+tM1MpvJfPm9/SP6FfA+DjbP4OL45FMGFwNS+NkeDrnqxyLcnW7W6U2zUfjSldVM6A=
	=
X-Google-Smtp-Source: AGHT+IGDbBSmNC1anj5wI5P62aSYEw9lEhDejC5ho+kgu91YH3dHHDbcF7VOQa2eNgE3DiF6BBgNMyrr
X-Received: from wmbdv22.prod.google.com ([2002:a05:600c:6216:b0:45d:e232:8a3d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:468e:b0:45d:da4a:8dd0
 with SMTP id 5b1f17b1804b1-45de6b386abmr50683105e9.27.1757405206055; Tue, 09
 Sep 2025 01:06:46 -0700 (PDT)
Date: Tue,  9 Sep 2025 10:06:33 +0200
In-Reply-To: <20250909080631.2867579-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909080631.2867579-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=ardb@kernel.org;
 h=from:subject; bh=1n3hA3W+K2hArHGEcJW8o2NSc1WWSTWXp4Cn3bXHpYQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWP/A874y7sepAXOeCaRK1h4U7u/cOWEz4G282YrPe77o
 ie6fJVWRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIpcuMDBdqkk3Wv2F/F7Ps
 24PLE1cnRn3PtN3EFZXfHSj1dcLEqniGf3aL951qW9S657BBwsdtW859a5r0uzLk/YQ9z45aiV5 +oc8HAA==
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909080631.2867579-6-ardb+git@google.com>
Subject: [PATCH v4 1/3] x86/boot: Drop unused sev_enable() fallback
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The misc.h header is not included by the EFI stub, which is the only C
caller of sev_enable(). This means the fallback for cases where
CONFIG_AMD_MEM_ENCRYPT is not set is never used, so it can be dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index db1048621ea2..fd855e32c9b9 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -152,17 +152,6 @@ bool insn_has_rep_prefix(struct insn *insn);
 void sev_insn_decode_init(void);
 bool early_setup_ghcb(void);
 #else
-static inline void sev_enable(struct boot_params *bp)
-{
-	/*
-	 * bp->cc_blob_address should only be set by boot/compressed kernel.
-	 * Initialize it to 0 unconditionally (thus here in this stub too) to
-	 * ensure that uninitialized values from buggy bootloaders aren't
-	 * propagated.
-	 */
-	if (bp)
-		bp->cc_blob_address = 0;
-}
 static inline void snp_check_features(void) { }
 static inline void sev_es_shutdown_ghcb(void) { }
 static inline bool sev_es_check_ghcb_fault(unsigned long address)
-- 
2.51.0.384.g4c02a37b29-goog


