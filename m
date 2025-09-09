Return-Path: <linux-kernel+bounces-807458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E5EB4A489
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA417AAFD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2489E24A046;
	Tue,  9 Sep 2025 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8vNg4sL"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85AE246335
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405211; cv=none; b=CbCh4NXrXiaRoRGr2bD1FPHArYCwy9Cy/TH2N0md7O6vbliBpiQmx2h46FbDMMO/xDVY/OwZbVmOno/VqHQju8Ppg14PJB6kUSaJU/3CMJWD07VJaAdel3Belv9hKNaazuoTiNwDwcjEe79Nbev/sbHtn9hGm/UrNw8KEvowOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405211; c=relaxed/simple;
	bh=bxfkr1bwaVAXs5FaMEW8ZNuMu4e1wkIbDjqHc1Wwjv0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uO87LPVdUmN7GNTh418uSs13WKfFy4m4tE4JKXJ9PmQrAeaTHu7S9PVrM3KgtDkuBF0nxBbGMOuKv+Bp3qwhpbo676Axus4VdU+PVExMsko8BrDT0/0CgoqEKFAa5pdDXIXTzgVo+KYbGAXJw7VCfNwTtki0zraX9GssHshIFvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8vNg4sL; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45ddbdb92dfso19898375e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757405207; x=1758010007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKR8SFZ5tUbZvXiuQCaIge44w6NbXb6+pFcC4LViGfc=;
        b=A8vNg4sLs11FCE8jvgxRFdSLNc3MvQ1PYb4QMPlIJWmyLZ907nkQ6YCgX4BYIrVysc
         C9/CTU3HDthSeBy6UUkUCgxKlBWxnOZgVVvqj7w7DNOySwBciuDp9ummBrus0ZYxZid+
         4uxEp7BESIpPwSo8pupJOG4LnoRtcSFjJFyyuVBCRvw5PcgTvKbKFVJTwwyD5Ea01L5D
         KRmXu7SMo6yG6FyJjuuzahBNA4yMv9e+aymb3s0NFv5GrThTE4k7T9eKJu+sDFC9HU78
         t2Na3zqsfgxcmvUGjXc3e92uXSDRQmrowf70+gcyN8x+uMZ3t67s1uWGxYfytHc9qDo9
         XiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405207; x=1758010007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKR8SFZ5tUbZvXiuQCaIge44w6NbXb6+pFcC4LViGfc=;
        b=mFQ4HllO00gZLWb4dhvkLfmASdknyzyUOMOZkQMmgbiIhSbI6bpiwnUi3Cb/NxUelX
         /KKlWQfm5jZRYGySDba0b4VwzuG241MZwP9P+2nu2hxEcQnG6jHqAvnxGAxtbQEehhcL
         AlfqWojbcG7d8UW+jel+vksG3KfuTbr7frKc9pEsW/95p/+ymyj8eFD7gk1KDWUSK5AE
         +AFh53iGrnd0/sM1yZ87k68inhHpUue1nHiwp7GC/iWfFI6kphHq9izgky1CPnGVMdX6
         IXy44MIPB4fEB2CGC0vTTDVkx7NfVeT/AjDgbuTF1JH1tkmPwwKzdgoarDRGGzPjEj/I
         PJKg==
X-Gm-Message-State: AOJu0YwhspWtnVn6jkusu/EmZMrfoVBMjZstM8QVAh0i+Z38gRMzAYEX
	0fK7P3rhviXV1bbBearwqvjbvQ23LUrM4saYyJACXZ1frquchCrk2JEWe1oVaAzD1aUwaXkTPA=
	=
X-Google-Smtp-Source: AGHT+IG8pvazFoVc9FUnEXTt0W0SX40O2+ahnkSegmQainOj/4AlLriLRxQbk9LaYEnwMR7tdZ/ZDodS
X-Received: from wmer2.prod.google.com ([2002:a05:600c:4342:b0:45d:d1f2:48ba])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a05:b0:45d:d5c6:97b4
 with SMTP id 5b1f17b1804b1-45ded2fb475mr14469155e9.9.1757405207202; Tue, 09
 Sep 2025 01:06:47 -0700 (PDT)
Date: Tue,  9 Sep 2025 10:06:34 +0200
In-Reply-To: <20250909080631.2867579-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909080631.2867579-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2156; i=ardb@kernel.org;
 h=from:subject; bh=0MPXvKn0M/hs2ODjQAAa+m+Dmix12uoqz11yvPlS3nI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWP/Ay7WRJ6dQQ42Js2iheG21ad5Bd6KLPLzy98fK2KxY
 YbzOqmOUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJFnBxkZdjakHb90j/PDb2ap
 mzlrz72aF29ntnhzz2aOKQbx8YrFtxn+aX7fM0evrDru4a6j37yD/Qs9dh3NcL/vVXn468rdcv6 +fAA=
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909080631.2867579-7-ardb+git@google.com>
Subject: [PATCH v4 2/3] x86/efistub: Obtain SEV CC blob address from the stub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The x86 EFI stub no longer boots the core kernel via the traditional
decompressor but jumps straight to it, avoiding all the page fault
handling and other complexity that is entirely unnecessary when booting
via EFI, which guarantees that all system memory is mapped 1:1.

The SEV startup code in the core kernel expects the address of the CC
blob configuration table in boot_params, so store it there when booting
from EFI with SEV-SNP enabled. This removes the need to call
sev_enable() from the EFI stub.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 21 +++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 0d05eac7c72b..c4ef645762ec 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -681,17 +681,28 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	return EFI_SUCCESS;
 }
 
-static bool have_unsupported_snp_features(void)
+static bool check_snp_features(struct boot_params *bp)
 {
+	u64 status = sev_get_status();
 	u64 unsupported;
 
-	unsupported = snp_get_unsupported_features(sev_get_status());
+	unsupported = snp_get_unsupported_features(status);
 	if (unsupported) {
 		efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
 			unsupported);
-		return true;
+		return false;
 	}
-	return false;
+
+	if (status & MSR_AMD64_SEV_SNP_ENABLED) {
+		void *tbl = get_efi_config_table(EFI_CC_BLOB_GUID);
+
+		if (!tbl) {
+			efi_err("SEV-SNP is enabled but CC blob not found\n");
+			return false;
+		}
+		bp->cc_blob_address = (u32)(unsigned long)tbl;
+	}
+	return true;
 }
 
 static void efi_get_seed(void *seed, int size)
@@ -831,7 +842,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	hdr = &boot_params->hdr;
 
-	if (have_unsupported_snp_features())
+	if (!check_snp_features(boot_params))
 		efi_exit(handle, EFI_UNSUPPORTED);
 
 	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
-- 
2.51.0.384.g4c02a37b29-goog


