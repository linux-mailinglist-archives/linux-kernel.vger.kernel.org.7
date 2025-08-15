Return-Path: <linux-kernel+bounces-770308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2A6B27990
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4CBA2101F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF4C259CA1;
	Fri, 15 Aug 2025 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kIpU3FqV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NH0bE7lT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4E2BE7AC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241509; cv=none; b=FscoFEtXk0fyqC79mpeRZHOS5cKsHbhYXfs5NS93u7zn/lCOYQgt2DQ4i4af4wFGsVwEaTIBTTzoHfEEiB1YSDenGh5Y5ekr7mBGkBPXKDPDStUnfSjUx0pk/S6A9I+QMKtsKPNT03K2k28AQ+2eXH6oCxkMaoOlIxMjuvk6i3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241509; c=relaxed/simple;
	bh=SYRZmFM3Ioa0y0H9EeRaz2/V19DLQSJh6KQlg7ks8hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnogOn1ShBRKygdAp8+8ieY5AsHsQxUBZJteTTvjyLCzBrQaNIvmr628MeFjYdQbrzKyg3RcWjNI4i3Fh3tWgbXz6lg1cHtZwO5XWl3oVsMz0qptejKfGLGBjYeylpY4Txf4Fz1d9Hfo+1IPwGUrBe0E597HCdPuVbvpSsKml/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kIpU3FqV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NH0bE7lT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8Xp1mFPuuaOTq+ytYDakiRoJMAib8ShAL5vVh6jiIQ=;
	b=kIpU3FqViZ2EFUjb8sLgNDY4119QhW/tcxlOG9Eww4JplVrD6Y61gB2bOICrAG0tybakFw
	ngdVTF2ckYGai0cjyhJph+UVWfTxuMg+cG6WpYKtxv9nQa2tbmxO149aoiIqnXV7Nj2DU5
	MK/cN+poYU/Iotaj17nG5mMVNgHCht6ScCtpNWDrCaRzo5yADTiGIlrslyBAGxnYPLNTuR
	d4oW+L3I3Vcg7C9XLXpapL+jDc8Qrvz8vj9H+SHrpYgpuv2g+NyEy4eMG1yzPRdXvod23x
	vQ3EMv3CEXbEqFEMi/wss36F4wKDA2eNHceqFibr6UCCTe261T+vwt60oqEAsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8Xp1mFPuuaOTq+ytYDakiRoJMAib8ShAL5vVh6jiIQ=;
	b=NH0bE7lTDlbdzxT/+tBnMBAaoqkcNu1P72dNL845emBw+0KOiQQ/qmz5mCMXC3dK0hQtwN
	NdEF2vm99DWrdQBg==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v4 01/34] x86/cpuid: Remove transitional <asm/cpuid.h> header
Date: Fri, 15 Aug 2025 09:01:54 +0200
Message-ID: <20250815070227.19981-2-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All CPUID call sites were updated at commit:

    968e30006807 ("x86/cpuid: Set <asm/cpuid/api.h> as the main CPUID header")

to include <asm/cpuid/api.h> instead of <asm/cpuid.h>.

The <asm/cpuid.h> header was still retained as a wrapper, just in case
some new code in -next started using it.  Now that everything is merged
to Linus' tree, remove the header.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid.h | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 arch/x86/include/asm/cpuid.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
deleted file mode 100644
index d5749b25fa10..000000000000
--- a/arch/x86/include/asm/cpuid.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _ASM_X86_CPUID_H
-#define _ASM_X86_CPUID_H
-
-#include <asm/cpuid/api.h>
-
-#endif /* _ASM_X86_CPUID_H */
-- 
2.50.1


