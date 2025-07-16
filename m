Return-Path: <linux-kernel+bounces-732788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB11B06C20
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7104A62C1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D5D2853F8;
	Wed, 16 Jul 2025 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3jkSRlII"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415C9279DD3
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636155; cv=none; b=A2YQQ6LkJWoRuZQC0Soy3YzSicoYMN6Q/zUX8s17MHqh+1QjyBFeP0K2+JFpPHAWczphnt3yfKLgb1vWZNLg3QJvRHgJfqQxO8Vrq3ee4XqmFGI3Lf3ka2cAzidSw1dzeeM3RXYmwUyMpxKnGR+udJ3KSANVBWInfh3eTz4JHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636155; c=relaxed/simple;
	bh=dwWCVYWLxvz5MeaLqdk6rU+JPa17U0A/FyYg+rIEEKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dtcfE83+ylnfjG829VNAboqGptqhNpHnFQ/A/nN3PEuG3N+8kfsqvABHry0OkaHVfguVCYmmQ2+QKXzXNTm/4O3vZyKwBo6jUnXimHEgoDd3Fflfti7tK8e48JC9bG3iF8q5F4Bebg+EwxLFSU8RRzEyfK7NI5BOn5H0gv6+N4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3jkSRlII; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a50816cc58so2116645f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636151; x=1753240951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/jHar7LpfB+CDDd+fbj3NyAJt7qq3hvz0nbJoCsOjz0=;
        b=3jkSRlIIIEjeccQ7+2f8VkIpyVTLuFr7Wof1AoczY8rPZUiDn06w8qyPpXnO8Levkp
         izybGnGL+n47HpQl05Px8ZSf3vcqzLuvaNM2SXCGLaIl6ochR3kMVLMBqcxOwuGstDq9
         mC0202lvEcTqYVtBYKuHy6q1bpjgBdvZMYTgpjVNe74tjauj53uRuLQp+pen2XszYEiQ
         2tBGboxWCYF35aYajxNuLVwouDkurTJkIB7AON7PCnxUJTvhQPUnPbxIv2zy1s2M1jT2
         xMs07XXZ6rB+DVBnLrvyce5Ul0b1LKN0/1b9Om/i3zELiDsws2P5MXCOyh28u5Ecq3RL
         kfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636151; x=1753240951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jHar7LpfB+CDDd+fbj3NyAJt7qq3hvz0nbJoCsOjz0=;
        b=mVJZspJ696sB5+g0G1tRCcGWmkOcpqyYpJ3XinM+hCrSM0+8XY94CUe2wsLArCTo6C
         mFFjHDSn8Narn0dnaMYiDKcmJ/8cj06Dq1hy2hqtkvTpswoI/hst300fnKtEHELQrKFJ
         nFei7lhypLxwpSgosDY6DVKaTObPu+j5y6YcokeYUeEO8QzyaO0CpIOQTY15ulUCvgR2
         Z7DFJbrpg4zFZ7Avs7c/2PoHIhrY8Oc2qB1jj0aqGfNXPA+XrxJYQA6ySVNPMgJEeH70
         ZjJEwWC6HwKEmEX2hZSe64YTlarB3PT//txhu1Htubll87+vV/6FCD5q6+X9d6FDcHmF
         iH3g==
X-Gm-Message-State: AOJu0Yz8zhXRUhEY13mSGdiUsrS+PzCSqbFzIr4h2ms1HAoGVSNtLHAM
	Hj3rKxnfwWXpXbgwsUSZPWijzNNIBicYsA020KPx+zilud7A7rWxFK31w0zwr5YEmLvbNCiOuC4
	997vOrcDW0F1nEGT1LpoeXn37uETMRpZNMYGQmXJamNn/EqhkNmEu/78Zlow9D0Y6oa3sjh9SqM
	BZQYgZLzsDfB1nIOa52dWbYiDxK/02oUvCXg==
X-Google-Smtp-Source: AGHT+IFEuJ4DENIJrP3qoayaohC8oM7ZFjNQPr9UUJ7+oEl5naP+4gZNWHLaAp+vi1pyt3SJfKEIVuCG
X-Received: from wroy15.prod.google.com ([2002:adf:f14f:0:b0:3b2:14c1:2180])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4412:b0:3a4:dd8e:e16b
 with SMTP id ffacd0b85a97d-3b60dd5520cmr677901f8f.20.1752636151576; Tue, 15
 Jul 2025 20:22:31 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:19 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885; i=ardb@kernel.org;
 h=from:subject; bh=Ooeu1U7xEvLSy0dm4Twfp3IBY3u7/SJY928wtFYKXhs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcSmg9T0VvQUvpihn79b/dE/D8erhkl12zu9idkn0n2
 qcFOTl3lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImcb2Bk2CPVwHhwod1reaFH
 vWyxl09x+cyv/bcp/Nm3K2VPzzHdO8fwv8jQ/ldvSuv2iSedGUqUF0yKVhbl57suHOE7YYrxMQ8 ZBgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-28-ardb+git@google.com>
Subject: [PATCH v5 04/22] x86/sev: Run RMPADJUST on SVSM calling area page to
 test VMPL
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Determining the VMPL at which the kernel runs involves performing a
RMPADJUST operation on an arbitrary page of memory, and observing whether
it succeeds.

The use of boot_ghcb_page in the core kernel in this case is completely
arbitrary, but results in the need to provide a PIC alias for it. So use
boot_svsm_ca_page instead, which already needs this alias for other
reasons.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c      | 2 +-
 arch/x86/boot/startup/sev-shared.c  | 5 +++--
 arch/x86/boot/startup/sev-startup.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index b71c1ab6a282..3628e9bddc6a 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -327,7 +327,7 @@ static bool early_snp_init(struct boot_params *bp)
 	 * running at VMPL0. The CA will be used to communicate with the
 	 * SVSM and request its services.
 	 */
-	svsm_setup_ca(cc_info);
+	svsm_setup_ca(cc_info, rip_rel_ptr(&boot_ghcb_page));
 
 	/*
 	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index d9c0c64d80fe..cbf26466e0da 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -792,7 +792,8 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
  * services needed when not running in VMPL0.
  */
-static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
+static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
+				 void *page)
 {
 	struct snp_secrets_page *secrets_page;
 	struct snp_cpuid_table *cpuid_table;
@@ -815,7 +816,7 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	 * routine is running identity mapped when called, both by the decompressor
 	 * code and the early kernel code.
 	 */
-	if (!rmpadjust((unsigned long)rip_rel_ptr(&boot_ghcb_page), RMP_PG_SIZE_4K, 1))
+	if (!rmpadjust((unsigned long)page, RMP_PG_SIZE_4K, 1))
 		return false;
 
 	/*
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index c30e0eed0131..4b9e8ccc0e91 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -302,7 +302,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	 * running at VMPL0. The CA will be used to communicate with the
 	 * SVSM to perform the SVSM services.
 	 */
-	if (!svsm_setup_ca(cc_info))
+	if (!svsm_setup_ca(cc_info, rip_rel_ptr(&boot_svsm_ca_page)))
 		return;
 
 	/*
-- 
2.50.0.727.gbf7dc18ff4-goog


