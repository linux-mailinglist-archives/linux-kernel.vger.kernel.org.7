Return-Path: <linux-kernel+bounces-732786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFB8B06C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788785029B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CBA279DCE;
	Wed, 16 Jul 2025 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxijrMbv"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93F27586A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636152; cv=none; b=PSo9SQi21b+/PSavfG8tfzSSaPzoztRaR8Dy0Ns2Ad2ieKST3M+/hQVWmF9gyhtBTgLNLh1n9EesV3HsMrc9LqafjJ7L7WxqSFhssxzZtvc56bLHZGey83WZD63/AQLuipRPrNhDNa/CRc9xv1hHa+FYkkIa5cgRSCo4ijc4sq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636152; c=relaxed/simple;
	bh=ksqWJ3zxF7ccoNVNsSR6rr7unDZsJqUNnB8JaSiF94I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V1IbbhvtOxCmtQNQ1NKVSWAwwqqkGi3RrAPtQ6g0cR7C+/GywBznBhwvPmZqi5+QOfa581/tWwR7GUYNSJdvU1DcnefkzYqo6XDTzNpScUty1IKy6peAeUry2Y+8+G7hQz1j4NLRVaSwMsZBsnpk1Dm9dxxs+skrHB263ZMpAeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxijrMbv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so34417245e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636149; x=1753240949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XTk1fL+3FlyyPzsp+eM/RsxBcL9vy8XaYmuNj1GdoaE=;
        b=bxijrMbvIyPsEypqb3PJnnPZ3PUJSzzbVBqoXuZwbIC096HuNNxzLfnH/giavg/L8j
         x6tIZ/j/DGVWlkpPAeUOwZnYV5Uph9Js74K8x0Krgrfzze5Qo8eYt9nyZqum0DsTpg8+
         DbQWnkrRpDOLfM3u8Y5qdwekA2uwkepLnI6/AdUJGkakLxkECvfCB9hg3CTniRYhSvPO
         /OjsrUkU2ENpSoVbfdmFAX4X0k91xeK8X2IcWEvG1SSvPOU901SOEfRlkI1wLGRxvbdT
         EV9TJNlOPJMKq/W7SMEA6exwDxMZohPsy3rYnXvN8iMXr31ax7wvUZyIaWFI3GkIeJ3X
         FyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636149; x=1753240949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTk1fL+3FlyyPzsp+eM/RsxBcL9vy8XaYmuNj1GdoaE=;
        b=sf6mtKDYrqDUBPRC/I0JaH4lQv1hTgY9mber65NZ3eu5ZTE4y1ovdBImipgyHzykne
         xrYdIrigA4I1MJq3+x0ST/lnMJtgZNv/tWJsZO34v5ERycDOp4Igns2VaKZLNC0gVyu4
         J/sIe+tWVKewBBF6DfbziZ6oJC6jAt7fvUjbAQTWzqAzMeYIs/y+/s5H5Cbb3Z9Ghtmm
         Lv1TIvSjnwN4fIpbGW3UUkY8MiM6YMUGVsjWDkn2TrkO7w0Y4ycQQ7eigA3R4w/EFHSW
         GA/z8I6fqxWBAHyilf9X2XE6S7bygU3OiYy7hFHEU7vEOIyJmazCH5ETKgY+FyCAKXve
         LbRQ==
X-Gm-Message-State: AOJu0YwlWGQ8fOayJSNQVZz8lwTnwEwImewsfJKqGEDCOEaWw4eYhpSJ
	ZQ9rmOt5K0ALtEJOvXPW4xvuwQHeOjnr8SDVp4lvnKuRFz7ma3hqKynAR3myrCvNcaQAdLG2iR9
	gcKighy2OLugxZmmjxSCFb+um4xn/j8eAEAMjdJQehvE9jPHu4gq4tiwBcUnkwa8IdEaWfquxQO
	GrStIzJ8VMdeUSDdq1JVeQkEO7+dhLpB6S5g==
X-Google-Smtp-Source: AGHT+IFp+4uK6QUco7HVxh+/dkaikaA7IPLW4LLCd2U9UQFsz5HQ4F8+CtS88XHIISeuYdyCOJ0T39EC
X-Received: from wmtf7.prod.google.com ([2002:a05:600c:8b47:b0:454:d702:f3c2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c0f:b0:43d:42b:e186
 with SMTP id 5b1f17b1804b1-4562f9c0876mr1263275e9.8.1752636149110; Tue, 15
 Jul 2025 20:22:29 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:17 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2218; i=ardb@kernel.org;
 h=from:subject; bh=R+TJW1Povli2/3VdKghDcG09D4Rob9ApANRJpivezCs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcisMwU9ndWZrxDVv6OvO/l+pub405wv5g7wT9fOFT2
 6a2P+boKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABN5JMbIMGG23d/LOVdNTFjv
 uV5cE3a2bq/EvOO+Zg4LFjjIX/XwjGX4pxb7jCm3o/nWIqPV32ruHfef6jN1cc0r/zqVx7uafAo 4eAA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-26-ardb+git@google.com>
Subject: [PATCH v5 02/22] x86/sev: Use MSR protocol for remapping SVSM calling area
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

As the preceding code comment already indicates, remapping the SVSM
calling area occurs long before the GHCB page is configured, and so
calling svsm_perform_call_protocol() is guaranteed to result in a call
to svsm_perform_msr_protocol().

So just call the latter directly. This allows most of the GHCB based API
infrastructure to be moved out of the startup code in a subsequent
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/startup/sev-shared.c  | 11 +++++++++++
 arch/x86/boot/startup/sev-startup.c |  5 ++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index c401d0391537..60ab09b3149d 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -723,6 +723,17 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 	}
 }
 
+static int __head svsm_call_msr_protocol(struct svsm_call *call)
+{
+	int ret;
+
+	do {
+		ret = svsm_perform_msr_protocol(call);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
 static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 {
 	struct svsm_pvalidate_call *pc;
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 0b7e3b950183..c30e0eed0131 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -295,7 +295,6 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 {
 	struct svsm_call call = {};
-	int ret;
 	u64 pa;
 
 	/*
@@ -325,8 +324,8 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	call.caa = svsm_get_caa();
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx = pa;
-	ret = svsm_perform_call_protocol(&call);
-	if (ret)
+
+	if (svsm_perform_msr_protocol(&call))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
 
 	boot_svsm_caa = (struct svsm_ca *)pa;
-- 
2.50.0.727.gbf7dc18ff4-goog


