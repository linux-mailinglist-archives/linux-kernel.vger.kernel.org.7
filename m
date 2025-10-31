Return-Path: <linux-kernel+bounces-879322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 922DFC22D67
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EC37342FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521AD21D3EE;
	Fri, 31 Oct 2025 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5Fhrn5p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E520F067
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761872642; cv=none; b=C+RzeC4mWuUo/JD5f4TwBbGgEbIkucmNF8jtZvERO5XfQGkURHqgQMkRBmYZ4Pv9fvf02MjUpSrbRhYDzCKCPqilnN/DW28L24Z4+yJHtzG1A+Tld1FsGHeBNa3RIJewN/w0guUfp6Gx9Q8YV5KyvM4h0JtHwfoZthH4kNPJ4BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761872642; c=relaxed/simple;
	bh=oiaNxHqLsiUGi3fMQH1S26PrUGrpe0lpo+mJR1gGkVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvTfKhWWCe7eegeWIswyMV2CCwPcfmZU5m2jiZ/1Iax/vR7/nDF6tXtGaV3/gkaykZvk4JMBprwOvV8Zou/vPkSKiXShZ0hpmTHto+kilGrmlhStMRZ8JcIbfKaR/Z4Fx4I4PdDNjOJNThmLXCyGkGilzcedTyJn+s0XEjqYMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5Fhrn5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14108C4CEF1;
	Fri, 31 Oct 2025 01:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761872641;
	bh=oiaNxHqLsiUGi3fMQH1S26PrUGrpe0lpo+mJR1gGkVk=;
	h=From:To:Cc:Subject:Date:From;
	b=J5Fhrn5pyZuNBEGbHAarvD/nYoX2ZQDpAlrXSYeyOwgqminpY6FRan9S4s+oWlXwV
	 W12HbM/5rRyinYTrSyEKMz3TyT4rMAegNA3joqfTE3XThEHPyg2DDHEmfswpLCbNOm
	 nErqu5LDLHsKvBXu4zLSZvpe/GNba8iwdUfmuAeXeMbaHJOWeZrRM1pcML2NHqXwRU
	 hxncwOoiowlHojBpAZnJVKa6dE1/mEdFWlbyx61uemMyaOBGVMajkaxt1hAJG1No5l
	 89w8yahHF+eHtDCig4fL2wmtePMpAQc6I1YfSKizLvWu5NOhRai5ITLT0gRD/lCZuB
	 mQWgugSk51pTg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH] vmlinux.lds: Exclude .text.startup and .text.exit from TEXT_MAIN
Date: Thu, 30 Oct 2025 18:01:54 -0700
Message-ID: <07f74b4e5c43872572b7def30f2eac45f28675d9.1761872421.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An ftrace warning was reported in ftrace_init_ool_stub():

   WARNING: arch/powerpc/kernel/trace/ftrace.c:234 at ftrace_init_ool_stub+0x188/0x3f4, CPU#0: swapper/0

The problem is that the linker script is placing .text.startup in .text
rather than in .init.text, due to an inadvertent match of the TEXT_MAIN
'.text.[0-9a-zA-Z_]*' pattern.

This bug existed for some configurations before, but is only now coming
to light due to the TEXT_MAIN macro unification in commit 1ba9f8979426
("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros").

The .text.startup section consists of constructors which are used by
KASAN, KCSAN, and GCOV.  The constructors are only called during boot,
so .text.startup is supposed to match the INIT_TEXT pattern so it can be
placed in .init.text and freed after init.  But since INIT_TEXT comes
*after* TEXT_MAIN in the linker script, TEXT_MAIN needs to manually
exclude .text.startup.

Update TEXT_MAIN to exclude .text.startup (and its .text.startup.*
variant from -ffunction-sections), along with .text.exit and
.text.exit.* which should match EXIT_TEXT.

Specifically, use a series of more specific glob patterns to match
generic .text.* sections (for -ffunction-sections) while explicitly
excluding .text.startup[.*] and .text.exit[.*].

Also update INIT_TEXT and EXIT_TEXT to explicitly match their
-ffunction-sections variants (.text.startup.* and .text.exit.*).

Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros")
Closes: https://lore.kernel.org/72469502-ca37-4287-90b9-a751cecc498c@linux.ibm.com
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Debugged-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
For tip/objtool/core.

 include/asm-generic/vmlinux.lds.h | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5facbc994634..9de1d900fa15 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -88,13 +88,29 @@
 
 /*
  * Support -ffunction-sections by matching .text and .text.*,
- * but exclude '.text..*'.
+ * but exclude '.text..*', .text.startup[.*], and .text.exit[.*].
  *
- * Special .text.* sections that are typically grouped separately, such as
+ * .text.startup and .text.startup.* are matched later by INIT_TEXT.
+ * .text.exit and .text.exit.* are matched later by EXIT_TEXT.
+ *
+ * Other .text.* sections that are typically grouped separately, such as
  * .text.unlikely or .text.hot, must be matched explicitly before using
  * TEXT_MAIN.
  */
-#define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
+#define TEXT_MAIN							\
+	.text								\
+	.text.[_0-9A-Za-df-rt-z]*					\
+	.text.s[_0-9A-Za-su-z]*						\
+	.text.st[_0-9A-Zb-z]*						\
+	.text.sta[_0-9A-Za-qs-z]*					\
+	.text.star[_0-9A-Za-su-z]*					\
+	.text.start[_0-9A-Za-tv-z]*					\
+	.text.startu[_0-9A-Za-oq-z]*					\
+	.text.startup[_0-9A-Za-z]*					\
+	.text.e[_0-9A-Za-wy-z]*						\
+	.text.ex[_0-9A-Za-hj-z]*					\
+	.text.exi[_0-9A-Za-su-z]*					\
+	.text.exit[_0-9A-Za-z]*
 
 /*
  * Support -fdata-sections by matching .data, .data.*, and others,
@@ -713,16 +729,16 @@
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
-	*(.text.startup)
+	*(.text.startup .text.startup.*)
 
 #define EXIT_DATA							\
 	*(.exit.data .exit.data.*)					\
 	*(.fini_array .fini_array.*)					\
-	*(.dtors .dtors.*)						\
+	*(.dtors .dtors.*)
 
 #define EXIT_TEXT							\
 	*(.exit.text)							\
-	*(.text.exit)							\
+	*(.text.exit .text.exit.*)
 
 #define EXIT_CALL							\
 	*(.exitcall.exit)
-- 
2.51.0


