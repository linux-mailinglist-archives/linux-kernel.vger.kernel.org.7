Return-Path: <linux-kernel+bounces-851396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C63BD659F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C57C4EFDC9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AAF2EBDE0;
	Mon, 13 Oct 2025 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8Yq9oSW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795A2EA17B;
	Mon, 13 Oct 2025 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390869; cv=none; b=k5ASFXY0wV2QGHm1ulFAd0B6BeDEOUzW45qp+ZEbQfYLgldCy64eJ9UicZ6YhkbUK3HCfUAmy6swhN0K5WuaenA/+45vOdYVyFYGWWILzjo3YJpXAJcb7p+tXakwMvG0q0IsUheJ4ua3qnkGTdgoF60PAHC6SZJbgj+ABVr7pao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390869; c=relaxed/simple;
	bh=P6Br4Sjeov9gRAY608C0I9bf7O6QwhsS9+wR0FuimDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xxwvuv8Gnwsmo/j+IAPbXBp77OG0ULkuHFoWxFMye6mxUaMi0pv+Pt24gx7++BAkt8BD3TxKk6zODCi3D4rMprPe24d8kKkmDCXAQ4KGJSaFKEk7N9vo4bc1UlYIduo1AOfwRzo8aowNDwp/BKtDpkcJxZtRXy6jKOP9EIeozR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8Yq9oSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F89C4CEE7;
	Mon, 13 Oct 2025 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760390869;
	bh=P6Br4Sjeov9gRAY608C0I9bf7O6QwhsS9+wR0FuimDc=;
	h=From:Date:Subject:To:Cc:From;
	b=t8Yq9oSWnfRJjh0Lb0x/JSbt1d8Zxw+3/AfWDrVuBkseMOSgkiucMg4qxQ3HuW7P/
	 BZw0vTD71eHvHchF8j2QkeaPJn09C6Qmc39fQyyiu4qn98GMYVkU5Jug3/BXM+PIne
	 LpSHPSlWLcVQsqPbR0O+IyreOksLtx4yrwWI1dE/IAmCgdnxZYGZIf8VAV/g6I+bbM
	 lt8emjPIxdtJRPg5yg742bMbJ8ax0HlRQgRM1BToOytYUMXl3bn8YvycqNtJtoC9XQ
	 yCkm/Igkfbi85Kgzah/7tfk7b5Qig66BzXphySJQUH+8mrPRsXkvOF0CRakwnItDcK
	 ZojPX0lnQnWyg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 13 Oct 2025 14:27:36 -0700
Subject: [PATCH] x86/mm: Ensure clear_page() variants always have
 __kcfi_typeid_ symbols
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-x86-fix-clear_page-cfi-full-lto-errors-v1-1-d69534c0be61@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMdu7WgC/x2N3QrCMAxGX2Xk2kC7uh/2KiISaqqBso50SmHs3
 Q1eHvjOdw6orMIVlu4A5a9UKauBv3QQ37S+GOVpDL3rB+98wDaPmKRhzEz62MgWMQmmT86Y94K
 sWrSin0IiGsI4Xx3Y2aZs1j90u5/nD4Xc0A54AAAA
X-Change-ID: 20251013-x86-fix-clear_page-cfi-full-lto-errors-173faa536840
To: Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2742; i=nathan@kernel.org;
 h=from:subject:message-id; bh=P6Br4Sjeov9gRAY608C0I9bf7O6QwhsS9+wR0FuimDc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBlv8y5FhGwT/+j81ODgCsl8r3tPFkr3T/3wPUxA2WGdy
 +W+vuzGjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRqzsYGZYnHPj99NfVUxcm
 Pj8wi+Hm68g5k1gcij7v2/m4oXlmQ9BVhv+FWocz5pRuEZU5fXYip/exD5GlueySJaGTPhu1swb
 JnuICAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with CONFIG_CFI=y and CONFIG_LTO_CLANG_FULL=y, there is a
series of errors from the various versions of clear_page() not having
__kcfi_typeid_ symbols.

  $ cat kernel/configs/repro.config
  CONFIG_CFI=y
  # CONFIG_LTO_NONE is not set
  CONFIG_LTO_CLANG_FULL=y

  $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 clean defconfig repro.config bzImage
  ld.lld: error: undefined symbol: __kcfi_typeid_clear_page_rep
  >>> referenced by ld-temp.o
  >>>               vmlinux.o:(__cfi_clear_page_rep)

  ld.lld: error: undefined symbol: __kcfi_typeid_clear_page_orig
  >>> referenced by ld-temp.o
  >>>               vmlinux.o:(__cfi_clear_page_orig)

  ld.lld: error: undefined symbol: __kcfi_typeid_clear_page_erms
  >>> referenced by ld-temp.o
  >>>               vmlinux.o:(__cfi_clear_page_erms)

With full LTO, it is possible for LLVM to realize that these functions
never have their address taken (as they are only used within an
alternative, which will make them a direct call) across the whole kernel
and either drop or skip generating their kCFI type identification
symbols.

clear_page_{rep,orig,erms}() are defined in clear_page_64.S with
SYM_TYPED_FUNC_START as a result of commit 2981557cb040 ("x86,kcfi: Fix
EXPORT_SYMBOL vs kCFI"), as exported functions are free to be called
indirectly thus need kCFI type identifiers.

Use KCFI_REFERENCE with these clear_page() functions to force LLVM to
see these functions as address-taken and generate then keep the kCFI
type identifiers.

Fixes: 2981557cb040 ("x86,kcfi: Fix EXPORT_SYMBOL vs kCFI")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2128
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Alternatively, these functions could move back to SYM_FUNC_START with a
comment that they need to be exported to be called via the alternative
in clear_page() but they are never expected to be called indirectly.
---
 arch/x86/include/asm/page_64.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 015d23f3e01f..53f4089333f2 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -43,6 +43,9 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 void clear_page_orig(void *page);
 void clear_page_rep(void *page);
 void clear_page_erms(void *page);
+KCFI_REFERENCE(clear_page_orig);
+KCFI_REFERENCE(clear_page_rep);
+KCFI_REFERENCE(clear_page_erms);
 
 static inline void clear_page(void *page)
 {

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251013-x86-fix-clear_page-cfi-full-lto-errors-173faa536840

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


