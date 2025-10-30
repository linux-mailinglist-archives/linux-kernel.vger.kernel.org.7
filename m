Return-Path: <linux-kernel+bounces-877428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830AC1E173
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2603A92F8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2D42D8398;
	Thu, 30 Oct 2025 02:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC57vMus"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0C042A96
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761790017; cv=none; b=E+a7V9wdj+suQKCxqtXcxKtcj38BXdKvFmYpG+OSrV3UdZW/VyYOAn/TXAbGEmw7Cz3O459lvsYKV6jWUYcj/399n/lhug+PGIFNIS5GfcGbYkPfY8Q6MXPPcrgsVI+EIGnFcBNfk0HpXjekgCw67nWH4jkLRBjaX+lWyqa1jkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761790017; c=relaxed/simple;
	bh=Rthz/4IIRmvVhdfDJd8kZo8uxHxwQpuo8eBON/C4eSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPBpM65Mgu6J+u6QcQzNpavAAlcqw2I/HukmHusxS3bct2Qo2BgAYinwDkvafie9+ISYinhTdPT1f3mco1ROM3GCwl/3PsjKU95vRLjt4LGctTmbJY6iLoGV6hoLV19gzGczsnpkGikO4L6tL+tHd2BjvdK54qQxDVZ/zLIgwiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC57vMus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BDAC4CEF7;
	Thu, 30 Oct 2025 02:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761790017;
	bh=Rthz/4IIRmvVhdfDJd8kZo8uxHxwQpuo8eBON/C4eSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TC57vMusi/aa3zEGk8ikQxQbM5lhu/4aKDrAguw13/YM74145hdH63XJD8xhU2lgv
	 Mm2o7ORJ5xmS7JLLTMvNhZD5mIMJNfFKjOJvYlMEax4l3aIWWSOmjZ01rKZgRCPnC/
	 PTaOA7hIBBLNghUT595paP7Glm6whnrlpOXoHfPP4iQeDPkGUrHu/YE+5QTTomWWzv
	 8DN5p5myDHyA4ME4/Rqr3gNwmEF3Ednhj0GJxFCst1cwroQwUUc0dBNe13gbjvdZtC
	 tL+YBe4/wDXeKRTCvoSpDmCqqILGj+vvgBpJ4gADkcPwkb0MOCq1OrzNEcXJ8eWgGE
	 GlqPheTTEyliw==
Date: Wed, 29 Oct 2025 19:06:54 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Petr Mladek <pmladek@suse.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, joe.lawrence@redhat.com, Naveen N Rao <naveen@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [next-20251022] Kernel Boot Warnings at
 arch/powerpc/kernel/trace/ftrace.c:234
Message-ID: <wxqithrj3vvgbefr7d7afv5vcnuu2ssuzrw6fqtmdjtq3ete3j@pfsgyacqjama>
References: <72469502-ca37-4287-90b9-a751cecc498c@linux.ibm.com>
 <cdf7c458-b28f-4657-8708-1f820369baa6@linux.ibm.com>
 <aPjW3P2AU7L71S-s@pathway.suse.cz>
 <ee9aaeec-23bf-42ac-8a8d-4ba899cfdd13@linux.ibm.com>
 <aPnxlEkV1rL0hWOm@pathway.suse.cz>
 <875b21ae-c30f-4dff-bef2-e41965013416@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875b21ae-c30f-4dff-bef2-e41965013416@linux.ibm.com>

On Wed, Oct 29, 2025 at 11:42:54PM +0530, Hari Bathini wrote:
> Hi Petr,
> On 23/10/25 2:42 pm, Petr Mladek wrote:
> > On Wed 2025-10-22 19:56:45, Venkat Rao Bagalkote wrote:
> > > 
> > > On 22/10/25 6:36 pm, Petr Mladek wrote:
> > > > On Wed 2025-10-22 17:36:18, Venkat Rao Bagalkote wrote:
> > > > > On 22/10/25 1:52 pm, Venkat Rao Bagalkote wrote:
> > > > > > Greetings!!!
> > > > > > 
> > > > > > 
> > > > > > IBM CI has reported kernel boot warnings with next-20251022 kernel. I
> > > > > > see there are couple of warnings hit and eventually system boots to
> > > > > > emergency mode.
> > > > > > 
> > > > > > 
> > > > > With the identified first bad commit, is casuing the kernel to boot to
> > > > > emergency mode. I reverted the bad commit and built the kernel, then kernel
> > > > > is booting fine, but with boot warnings.
> > > > I guess that it is the same problem which should get fixed by the patch
> > > > https://lore.kernel.org/r/e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org
> > > 
> > > 
> > > Thank you Petr, for pointing to the fix patch. It fixes the kernel booting
> > > to emergency mode.
> > 
> > Great.
> > 
> > > But boot warning still persists.
> > 
> > I looks like another problem. I would expect that it is in
> > the ftrace code, either in the generic or arch-specific part.
> Yeah. This is part of arch-specific code that does init of ftrace
> out line stubs. The problem seems to be since commit 1ba9f8979426
> ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros").
> Before this commit, .text.startup section was featured in INIT_TEXT
> but now it seems to feature in TEXT. Is this change right/intentional?
> If yes, I can post a fix patch in ftrace arch-specific code accordingly.

Ah, I wasn't aware of .text.startup.  Apparently it's used by KASAN,
KCSCAN and GCOV for a significant amount of constructor code, which is
only called during boot.  So we should try to keep it in .init.text.

Venkat, does this fix it?

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5facbc9946344..9de1d900fa154 100644
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

