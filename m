Return-Path: <linux-kernel+bounces-749943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C518CB15543
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2446C18A2DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91BD28469A;
	Tue, 29 Jul 2025 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi33vuRE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2483B247288
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753828029; cv=none; b=ttO/QmGDQgPFpjxIJRuGBZD/CDLxzDTxQ9whBQIPKPci0TJdh4Ll2ZmKeUr72VPUnSRQJ7+2i+/oQp15zrZfXdgyACi/oNcFafXrNHDND+IskBVkdVcbf5ueYm8/bjmQCIuoYofpAq4oiTpqWGAxvr7WBTi8RoaFMKcTTi/kF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753828029; c=relaxed/simple;
	bh=C+FynPwMIQI8qtWQyP8PljG+aPRklSvv3uH+DVM1oSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGQLGnoCPLzun4/h3Mwmae/wwQC8WQCodk9GsuMLdntTsYbU1im8+mABXTykPTtjIQSAhXxqUAnQqIVbPULn3JHmVlbTDxftstqQ0wFsiavUdKJ+hYdqVMm4CJVOl98UABm83YSE6KeuHbZckilabJDwOgjcrQ1j02PeBJ34/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi33vuRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF2AC4CEEF;
	Tue, 29 Jul 2025 22:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753828028;
	bh=C+FynPwMIQI8qtWQyP8PljG+aPRklSvv3uH+DVM1oSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bi33vuRE3ut/6p9EKIHgvvwv2RuTklixv+ldizftjrbw8wys7ulIQImV1CebNjSzK
	 aSyfje4KE+mktJS7ttC8N09qD1QJts/lUUR0GlPqITSDRPNeMGofO5vpVNiLq1Si+G
	 d/HQD5iG4G15/Fo2t2zlcs0OoI5x7ehkUPyRXQjNrGB5B7dPkewMjSeBQF7ivdVOfY
	 dxAtP3HIWDcBTqAEaylnYS3xClKwCbMeBlzBPioUfpCtau+O/+SDEWJ8Fl6B5rQf6l
	 VYjI3vdBoARr1k7DcD0EDuVsm5ge71hSZq1foTSfVxCQ+06Rq016lSrmloHkLjs0N9
	 K0uf+RR6in1Ow==
Date: Tue, 29 Jul 2025 15:27:08 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	syzbot <syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com>,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: [syzbot] upstream build error (23)
Message-ID: <202507291524.BA4DC7E1B9@keescook>
References: <6888d004.a00a0220.26d0e1.0004.GAE@google.com>
 <87cy9ikcwh.ffs@tglx>
 <874iuuk87e.ffs@tglx>
 <CAHk-=wirbb_FxAMsb+LFimsMF+nLg4UYsrHvjF1F9tF1xOm2UA@mail.gmail.com>
 <20250729215228.GEaIlCnHzcYmGpiBrQ@fat_crate.local>
 <CAHk-=whfrTfVMDjgM2fzPjUJpP7y27OsBssZSSCSR7V-=cd1eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whfrTfVMDjgM2fzPjUJpP7y27OsBssZSSCSR7V-=cd1eA@mail.gmail.com>

On Tue, Jul 29, 2025 at 03:11:50PM -0700, Linus Torvalds wrote:
> Which is supposed to _lessen_ the sanitizer coverage by adding the
> __attribute__((no_sanitize("coverage"))), but it's clearly causing
> more problems and making gcc just do crazy things.

Since this change was only made for Clang's stack depth coverage
analysis, let's drop it from GCC builds? I'm testing this currently:

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 6bfdaeddbae8..5a68e9db6518 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -5,7 +5,7 @@
 #if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
 #define __head	__section(".head.text") __no_sanitize_undefined __no_stack_protector
 #else
-#define __head	__section(".head.text") __no_sanitize_undefined __no_sanitize_coverage
+#define __head	__section(".head.text") __no_sanitize_undefined __no_kstack_erase
 #endif
 
 struct x86_mapping_info {
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 2b77d12e07b2..89e2c01fc8b1 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -378,6 +378,13 @@ struct ftrace_likely_data {
 # define __signed_wrap
 #endif
 
+/* GCC does not like splitting sanitizer coverage across section inlines */
+#ifdef CC_IS_CLANG
+#define __no_kstack_erase	__no_sanitize_coverage
+#else
+#define __no_kstack_erase
+#endif
+
 /* Section for code which can't be instrumented at all */
 #define __noinstr_section(section)					\
 	noinline notrace __attribute((__section__(section)))		\
diff --git a/include/linux/init.h b/include/linux/init.h
index c65a050d52a7..a60d32d227ee 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -51,7 +51,7 @@
    discard it in modules) */
 #define __init		__section(".init.text") __cold __latent_entropy	\
 						__noinitretpoline	\
-						__no_sanitize_coverage
+						__no_kstack_erase
 #define __initdata	__section(".init.data")
 #define __initconst	__section(".init.rodata")
 #define __exitdata	__section(".exit.data")

-- 
Kees Cook

