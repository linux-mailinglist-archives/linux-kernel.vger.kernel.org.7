Return-Path: <linux-kernel+bounces-759513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8D5B1DE81
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841C91AA5342
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BFF238152;
	Thu,  7 Aug 2025 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUugfyB2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D023496F;
	Thu,  7 Aug 2025 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754600020; cv=none; b=lGzsVC6c0mpytBZDditTzX6ZzqO4rb02G4czQBZuWfXw+QhBy7jqooyb+qPXljmflu0klUovmmgl21GoNwq3tR6pA5uF95AsErLON1GvTdjwxx9fzrgrJR7XKGuf0z6bvjvlgTyQHsnpoO2S38Q3t/WfFqvxfjOUPSH8kC+ZF/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754600020; c=relaxed/simple;
	bh=kH4x0nQoHGXsfTEQ8cxUERLnGeheUD+EOH3nHe3Tqik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BHeRXab1PSIwAWDXRbbw3WaAteVLDEFQNtTU29SrSXrOZ0rblylO/00Mpjeo8c7Du/5Ys8S+4IPTEiZR7QkpLow2cKwwvMxJN5BViUS4MURVWddbGpGKnO4TLbQCDHp8ECU5R3natHk1YLnJgEmHv8C9429NRI6MjsOX4PKfL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUugfyB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACEAC4CEEB;
	Thu,  7 Aug 2025 20:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754600019;
	bh=kH4x0nQoHGXsfTEQ8cxUERLnGeheUD+EOH3nHe3Tqik=;
	h=From:To:Cc:Subject:Date:From;
	b=IUugfyB2m8tC+SLUvsNqA13Q+SVSQHfPYz61cTwNMOPAcg3XDy/sPnC6eXD1B3yd1
	 ATYg8XP3h1V+3paXgNAhoKdn4XEwthWb0Eego+C23gmjBb0LpeZ88qgKpp+iI5BtNL
	 1wX1oDxB+oCb8/I8/igN78CYG39OE8qJf03HRySdgtaXNf9ls+nEKXaNMPIpiJNpDY
	 mn4Omh8rWyIFd8qANu8k/ZWRdzt/wZo9AnKWw4CZaKmlOA9l7Knxb093vliPGo2lsn
	 n/MPZ07N4hm2daxAxKuWwi8t6RWp8oSR3qBnKEmFjHYIwgCw+XCz+TN+I53N6jNvk6
	 ecaavF4ycEJdA==
From: Arnd Bergmann <arnd@kernel.org>
To: Bill Metzenthen <billm@melbpc.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] x86: math-emu: fix div_Xsig prototype
Date: Thu,  7 Aug 2025 22:53:28 +0200
Message-Id: <20250807205334.123231-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The third argument of div_Xsig() is the output of the division, but is marked
'const', which means the compiler is not expecting it to be updated and may
generate bad code around the call. clang-21 now warns about the pattern since
an uninitialized variable is passed into two 'const' arguments by reference:

arch/x86/math-emu/poly_atan.c:93:28: error: variable 'argSignif' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
   93 |         div_Xsig(&Numer, &Denom, &argSignif);
      |                                   ^~~~~~~~~
arch/x86/math-emu/poly_l2.c:195:29: error: variable 'argSignif' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
  195 |                 div_Xsig(&Numer, &Denom, &argSignif);
      |                                           ^~~~~~~~~

The implementation is in assembly, so the problem has gone unnoticed since the
code was added in the linux-1.1 days. Remove the 'const' marker here.

Fixes: e19a1bdb835c ("Import 1.1.38")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/math-emu/poly.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/math-emu/poly.h b/arch/x86/math-emu/poly.h
index fc1c887ca073..654bfe4e29a0 100644
--- a/arch/x86/math-emu/poly.h
+++ b/arch/x86/math-emu/poly.h
@@ -39,7 +39,7 @@ asmlinkage void mul_Xsig_Xsig(Xsig *dest, const Xsig *mult);
 asmlinkage void shr_Xsig(Xsig *, const int n);
 asmlinkage int round_Xsig(Xsig *);
 asmlinkage int norm_Xsig(Xsig *);
-asmlinkage void div_Xsig(Xsig *x1, const Xsig *x2, const Xsig *dest);
+asmlinkage void div_Xsig(Xsig *x1, const Xsig *x2, Xsig *dest);
 
 /* Macro to extract the most significant 32 bits from a long long */
 #define LL_MSW(x)     (((unsigned long *)&x)[1])
-- 
2.39.5


