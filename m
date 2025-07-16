Return-Path: <linux-kernel+bounces-732776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733CFB06C03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2D2172F27
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB3128033C;
	Wed, 16 Jul 2025 03:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZEpJU/d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C7277C8E;
	Wed, 16 Jul 2025 03:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635232; cv=none; b=J7QQ6s5zz787oZTE9q0CDEoBL3Yt+0DtM8zp2/TpoaSyTvMFaUKg1mJNTyNC9+1kcOmNbjhQel8oLOFyya2zqgRbwEdZC5ShgB51hXTA7vf9p9EZGVEPuk/EtpJEOqCMkUryL0bG8ouPtI5oVbs0FBPKkUJAAJ7xDjp3PYtLsqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635232; c=relaxed/simple;
	bh=XdgH/MWOd67x59+/ndV40VH40+ZO9umQlQ/4xBpYJro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aluK0Q9CBz/qku79nhdnRyL6xNHYrqV+qTHrZFpqEF17KtLJ+83TsSV1rhyhMVhTzOXm4MuAus/ZZSoBeTAXef1WlRJCdWPG/BefwawI7DAVrmZSigL4D2V13kZ2nF3iMEnzZaN7lCccZjngRF57HhSc60LnprpVwEdNDruUcL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZEpJU/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEE0C4CEE3;
	Wed, 16 Jul 2025 03:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752635232;
	bh=XdgH/MWOd67x59+/ndV40VH40+ZO9umQlQ/4xBpYJro=;
	h=From:Date:Subject:To:Cc:From;
	b=dZEpJU/d6Sx/HlOZ2zO03bRdrr59rA3l/A/Ss0YEZ8Zzx0ffXoCODVMuQ8BA3mBHc
	 lL8UN5CNui9N5U7INGC6I8/nN8x0baq5rL02AcNEnHDv+TtkXVNJdSzPOFjtOSbBcD
	 OSjy+LSB/bTPnJzmUiTq1XyDhO4R8iwCTjk51UqdJJkNSK7WCc1XIM9MMnzoh80NiX
	 ARA/HIXewK6gulvueWHmrV0zfckpbdxF0uxNA1AcZjZXJO11A86Iky4NVoYJp2MWGG
	 +OreNN+GnnBp22e8G5d18WurZejvTvKgIc26R9PUV7V+rmrvPrChkcbIqYdorabFfk
	 785GvU4MIgGMQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 15 Jul 2025 20:07:01 -0700
Subject: [PATCH fixes] riscv: uaccess: Fix -Wuninitialized and -Wshadow in
 __put_user_nocheck
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-riscv-uaccess-fix-self-init-val-v1-1-82b8e911f120@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFQXd2gC/yWN0QqDMBAEf0Xu2YNoE5T+SvEhJKseSFpyGgriv
 zfUtxkYdk9SZIHSszkpo4jKO1Xp2obC6tMCllidetM7M3SOs2gofPgQoMqzfFmxzSxJdi5+Y0R
 r3WDjYzSguvLJqNH/4UU3Tdf1A1XCPVZ4AAAA
X-Change-ID: 20250715-riscv-uaccess-fix-self-init-val-ed44574d380e
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3278; i=nathan@kernel.org;
 h=from:subject:message-id; bh=XdgH/MWOd67x59+/ndV40VH40+ZO9umQlQ/4xBpYJro=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBnl4nGic1b8Pa581S4ksUPu/lHnvNVznmmXGqz5dNL2t
 u/pieKMHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiv80Z/hfvNzxu+jjlEmtb
 s/+e/w2Oq4NCntfv/No3u3nfVpnI33MY/vvde7oreeXKr284bhbKf1lX8WbjjyBhS+NOh8QXFUw
 6p/gB
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent change in clang to strengthen uninitialized warnings [1],
there is a warning from val being uninitialized in __put_user_nocheck
when called from futex_put_value():

  kernel/futex/futex.h:326:18: warning: variable 'val' is uninitialized when used within its own initialization [-Wuninitialized]
    326 |         unsafe_put_user(val, to, Efault);
        |         ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
  arch/riscv/include/asm/uaccess.h:464:21: note: expanded from macro 'unsafe_put_user'
    464 |         __put_user_nocheck(x, (ptr), label)
        |         ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
  arch/riscv/include/asm/uaccess.h:314:36: note: expanded from macro '__put_user_nocheck'
    314 |                 __inttype(x) val = (__inttype(x))x;                     \
        |                              ~~~                 ^

While not on by default, -Wshadow flags the same mistake:

  kernel/futex/futex.h:326:2: warning: declaration shadows a local variable [-Wshadow]
    326 |         unsafe_put_user(val, to, Efault);
        |         ^
  arch/riscv/include/asm/uaccess.h:464:2: note: expanded from macro 'unsafe_put_user'
    464 |         __put_user_nocheck(x, (ptr), label)
        |         ^
  arch/riscv/include/asm/uaccess.h:314:16: note: expanded from macro '__put_user_nocheck'
    314 |                 __inttype(x) val = (__inttype(x))x;                     \
        |                              ^
  kernel/futex/futex.h:320:48: note: previous declaration is here
    320 | static __always_inline int futex_put_value(u32 val, u32 __user *to)
        |                                                ^

Use a three underscore prefix for the val variable in __put_user_nocheck
to avoid clashing with either val or __val, which are both used within
the put_user macros, clearing up all warnings.

Closes: https://github.com/ClangBuiltLinux/linux/issues/2109
Fixes: ca1a66cdd685 ("riscv: uaccess: do not do misaligned accesses in get/put_user()")
Link: https://github.com/llvm/llvm-project/commit/2464313eef01c5b1edf0eccf57a32cdee01472c7 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
It would be good if this could make 6.16 final. Otherwise, consider
adding a 'Cc: stable@vger.kernel.org' during application.
---
 arch/riscv/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 525e50db24f7..b88a6218b7f2 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -311,8 +311,8 @@ do {								\
 do {								\
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&	\
 	    !IS_ALIGNED((uintptr_t)__gu_ptr, sizeof(*__gu_ptr))) {	\
-		__inttype(x) val = (__inttype(x))x;			\
-		if (__asm_copy_to_user_sum_enabled(__gu_ptr, &(val), sizeof(*__gu_ptr))) \
+		__inttype(x) ___val = (__inttype(x))x;			\
+		if (__asm_copy_to_user_sum_enabled(__gu_ptr, &(___val), sizeof(*__gu_ptr))) \
 			goto label;				\
 		break;						\
 	}							\

---
base-commit: 5903a7452e642f1475f274373633522db168b60b
change-id: 20250715-riscv-uaccess-fix-self-init-val-ed44574d380e

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


