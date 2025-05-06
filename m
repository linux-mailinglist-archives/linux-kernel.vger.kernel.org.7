Return-Path: <linux-kernel+bounces-635192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA7EAABA82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 09:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0E81C2776E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 07:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BDC242D79;
	Tue,  6 May 2025 05:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iVhmMyrU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KTuBq36C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE42405EC
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746507894; cv=none; b=WKImtiTa4UKkFnD/nrJW4tnmI59fQ4+Fei4zy2vXyL6+nm2PW/TXPeMX8Xa/uJQE9Y15NLTW5CtxcpCTZXN/I/J8fkJ81uuM6XwH3rlTnKsObvpL/KMCV74ysJLxbQOm4nOiALndmqvJq8fN8xCOe+oKjp1TpDDArx3OVmh67ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746507894; c=relaxed/simple;
	bh=sT+01rTImh6W65H21r3Wni1xG7hZo0quuWYOHzOhvgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNZAxw5+hGg/XrN2/szNpilW/djmUYHybcJINsT2sdpmSG4CyzvNmoMIMvO+kQA6fzdGBN0o7LTvoLXh78lYd65txYVm8DN2q8G9l6arcogbF2OG1BQhx9qnAbi5Csd6lFPc1Mco+T85jOoAZbc1lCCYqVdbc3DPlF8VNy2+zd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iVhmMyrU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KTuBq36C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746507891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=edxSiI7RSaE9t2XOF9SeoRfjB7WRcyrgE76o9Y8Dh9E=;
	b=iVhmMyrU1eZTlQNXgoVub6mLWnsaugkyvpIdOIbxaNYILcSOjq+4+AQ+gdKt8dYyzVRbLn
	qlX/zIGtKP6pvkcjhdcxPuR3pBGMt186txlJtU11pbmg5WfIKSYyatX8qpVrHpJ3jXdQk/
	2/KiXrw4A+8IeZlBUKRyr5L8HVAaYRxK/wYxlMl+TzlFpaffvV2ufmhgqntEDsPNukB/HH
	IJUqFn1VxQJXh5bwfwI15rS6O/n4G79mLgNTVbBQlaivJ8RdbVjbcbXIaHM/4vwC3We3gG
	zq0qDGUm/VzzCDaTjuAdEc5qDfwITxkUJ0t98ITK9/cNNKbpr2InYA/6oDFQsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746507891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=edxSiI7RSaE9t2XOF9SeoRfjB7WRcyrgE76o9Y8Dh9E=;
	b=KTuBq36CZVl3ZFXAs+MzpdAk0ZU0ja/50xJMjD2lNgjAdoJRt+t5c34E6nluy8XH7yvHFN
	kBWGU7s/V1ntdHDw==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 01/26] tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.4
Date: Tue,  6 May 2025 07:04:12 +0200
Message-ID: <20250506050437.10264-2-darwi@linutronix.de>
In-Reply-To: <20250506050437.10264-1-darwi@linutronix.de>
References: <20250506050437.10264-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update kcpuid's CSV file to version 2.4, as generated by x86-cpuid-db.

Summary of the v2.4 changes:

* Mark CPUID(0x80000001) EDX:23 bit, 'e_mmx', as not exclusive to
  Transmeta since it is supported by AMD as well.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/blob/v2.4/CHANGELOG.rst
---
 tools/arch/x86/kcpuid/cpuid.csv | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index 8d25b0b49f3b..8d925ce9750f 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: CC0-1.0
-# Generator: x86-cpuid-db v2.3
+# Generator: x86-cpuid-db v2.4
 
 #
 # Auto-generated file.
@@ -689,7 +689,7 @@
 0x80000001,         0,  edx,      19,    mp                     , Out-of-spec AMD Multiprocessing bit
 0x80000001,         0,  edx,      20,    nx                     , No-execute page protection
 0x80000001,         0,  edx,      22,    mmxext                 , AMD MMX extensions
-0x80000001,         0,  edx,      23,    e_mmx                  , MMX instructions (Transmeta)
+0x80000001,         0,  edx,      23,    e_mmx                  , MMX instructions
 0x80000001,         0,  edx,      24,    e_fxsr                 , FXSAVE and FXRSTOR instructions
 0x80000001,         0,  edx,      25,    fxsr_opt               , FXSAVE and FXRSTOR optimizations
 0x80000001,         0,  edx,      26,    pdpe1gb                , 1-GB large page support
-- 
2.49.0


