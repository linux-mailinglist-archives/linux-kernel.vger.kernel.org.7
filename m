Return-Path: <linux-kernel+bounces-838478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F079BAF462
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2671940AF9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98DB26FA52;
	Wed,  1 Oct 2025 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DNCN4V0Y"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2547DFC0A;
	Wed,  1 Oct 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759301035; cv=none; b=QsY7VTnD8MwnhUqIVcAAIfS/TbbEeND26dK0EQKiyi2SKVO9c2x1+wcXtVhnYfnkLptwoJfBz3+nJ+7gBezXhA+BysFko+1MNDB84uQ/e1EnOZjqB9MeZyrbu/FYjkgeHS2zJaNWaFtMqx+xqukL0IkZm0m6LN8dPCiOtsQk2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759301035; c=relaxed/simple;
	bh=aE2IwkCDGfJKc0dqkfLvflLQLYdkorq1zbsAzo33h6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxCpLPFqu5In/clB1b/p1g3Todi8REgqLD6nKvhqj0x3LH/i5bgdMf7Ryj1f74n1EmJ1GlDBIfXrS0BJuup9hXrflVsXmWZoPBgO9oEp2imnHRe9qJ/8L5QREL5bkosJoLIrK3cP6eKD7f9ZrXZFamx9Gw1qys79Ok9ERZ14hmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DNCN4V0Y; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oOeU9UiXK2Zx3G5SBVoP3s/H7EZ2RJM3fi4CMgcePCA=; b=DNCN4V0YNHkBLO0PQnmadOiUVm
	EeiGjJx7o2rcmzuncnC6zIgpxU9yM7X1t7Cv74t9vn++pM5UY2nfQYaYtWv/O9iSI+uMwvL1zZjX8
	RE21diRHOQ+mMyRAj6WIs9XHbxgtywoOFFD1yVyTJSG67AS62oMgZYzfYjIEgnsP8KD3B5g0E9XBH
	tWEWU1HDxkKasIJ53CjLSLmsfgy/2ocd19V6ItDHkNRUMfgNA5Zrh0Pwh1umg3MRPgELOi7LfaXES
	wayzKhZM/GLE6bzD1YARoSsxXFNdNuTsguqyatyG2FwFA+kG5OugXCucxb3Z+cjssJkDyX1k3lbx7
	M5v94LmA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3qYu-0000000DNN7-3QUD;
	Wed, 01 Oct 2025 06:43:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5A2ED300212; Wed, 01 Oct 2025 08:43:39 +0200 (CEST)
Date: Wed, 1 Oct 2025 08:43:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
	xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
Message-ID: <20251001064339.GL4067720@noisy.programming.kicks-ass.net>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com>
 <20250930083137.GH3245006@noisy.programming.kicks-ass.net>
 <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>
 <20250930085044.GK3245006@noisy.programming.kicks-ass.net>
 <20250930125156.GK1386988@noisy.programming.kicks-ass.net>
 <2ad137cb-ed38-42f6-ac0a-a81569051779@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2ad137cb-ed38-42f6-ac0a-a81569051779@suse.com>

On Tue, Sep 30, 2025 at 05:42:13PM +0200, J=FCrgen Gro=DF wrote:

> Could it be that the labels should be local ones?

I already tried 's/#pfx/".L" #pfx/g' and that made no difference.

> What does the failure look like?

Its complaining about label re-definitions.

$ make O=3Ddefconfig-build/ arch/x86/kernel/alternative.o
=2E./arch/x86/include/asm/cpufeature.h: Assembler messages:
=2E./arch/x86/include/asm/cpufeature.h:102: Error: symbol `.L__UNIQUE_ID_al=
tinstr_67_begin' is already defined
=2E./arch/x86/include/asm/cpufeature.h:104: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_begin' is already defined
=2E./arch/x86/include/asm/cpufeature.h:106: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_pad' is already defined
=2E./arch/x86/include/asm/cpufeature.h:109: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_end' is already defined
=2E./arch/x86/include/asm/cpufeature.h:119: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_alt_begin' is already defined
=2E./arch/x86/include/asm/cpufeature.h:121: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_alt_end' is already defined
=2E./arch/x86/include/asm/cpufeature.h:124: Error: symbol `.L__UNIQUE_ID_al=
tinstr_67_pad' is already defined
=2E./arch/x86/include/asm/cpufeature.h:127: Error: symbol `.L__UNIQUE_ID_al=
tinstr_67_end' is already defined
=2E./arch/x86/include/asm/cpufeature.h:137: Error: symbol `.L__UNIQUE_ID_al=
tinstr_67_alt_begin' is already defined
=2E./arch/x86/include/asm/cpufeature.h:139: Error: symbol `.L__UNIQUE_ID_al=
tinstr_67_alt_end' is already defined
=2E./arch/x86/include/asm/cpufeature.h:102: Error: symbol `.L__UNIQUE_ID_al=
tinstr_67_begin' is already defined
=2E./arch/x86/include/asm/cpufeature.h:104: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_begin' is already defined
=2E./arch/x86/include/asm/cpufeature.h:106: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_pad' is already defined
=2E./arch/x86/include/asm/cpufeature.h:109: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_end' is already defined
=2E./arch/x86/include/asm/cpufeature.h:119: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_alt_begin' is already defined
=2E./arch/x86/include/asm/cpufeature.h:121: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_alt_end' is already defined
=2E./arch/x86/include/asm/cpufeature.h:124: Error: symbol `.L__UNIQUE_ID_al=
tinstr_67_pad' is already defined
=2E./arch/x86/include/asm/cpufeature.h:127: Error: symbol `.L__UNIQUE_ID_al=
tinstr_67_end' is already defined
=2E./arch/x86/include/asm/cpufeature.h:137: Error: symbol `.L__UNIQUE_ID_al=
tinstr_67_alt_begin' is already defined
=2E./arch/x86/include/asm/cpufeature.h:139: Error: symbol `.L__UNIQUE_ID_al=
tinstr_67_alt_end' is already defined
=2E./arch/x86/include/asm/cpufeature.h:102: Error: symbol `.L__UNIQUE_ID_al=
tinstr_67_begin' is already defined
=2E./arch/x86/include/asm/cpufeature.h:104: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_begin' is already defined
=2E./arch/x86/include/asm/cpufeature.h:106: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_pad' is already defined
=2E./arch/x86/include/asm/cpufeature.h:109: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_end' is already defined
=2E./arch/x86/include/asm/cpufeature.h:119: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_alt_begin' is already defined
=2E./arch/x86/include/asm/cpufeature.h:121: Error: symbol `.L__UNIQUE_ID_al=
tinstr_66_alt_end' is already defined
=2E./arch/x86/include/asm/cpufeature.h:124: Error: symbol `.L__UNIQUE_ID_al=
tinstr_67_pad' is already defined
=2E./arch/x86/include/asm/cpufeature.h:127: Error: symbol `.L__UNIQUE_ID_al=
tinstr_67_end' is already defined
=2E..

That specific one is this:

  static inline __attribute__((__gnu_inline__)) __attribute__((__unused__))=
 __attribute__((no_instrument_function)) __attribute__((__always_inline__))=
 bool _static_cpu_has(u16 bit)
  {
   asm goto("# ALT: oldinstr\n" ".L" "__UNIQUE_ID_altinstr_67" "_begin:\n\t=
" "# ALT: oldinstr\n" ".L" "__UNIQUE_ID_altinstr_66" "_begin:\n\t" "jmp 6f"=
 "\n" ".L" "__UNIQUE_ID_altinstr_66" "_pad:\n" "# ALT: padding\n" ".skip -(=
((" ".L" "_   _UNIQUE_ID_altinstr_66" "_alt_end - " ".L" "__UNIQUE_ID_altin=
str_66" "_alt_begin" ")-(" ".L" "__UNIQUE_ID_altinstr_66" "_pad - " ".L" "_=
_UNIQUE_ID_altinstr_66" "_begin" ")) > 0) * " "((" ".L" "__UNIQUE_ID_altins=
tr_66" "_alt_end - " "   .L" "__UNIQUE_ID_altinstr_66" "_alt_begin" ")-(" "=
=2EL" "__UNIQUE_ID_altinstr_66" "_pad - " ".L" "__UNIQUE_ID_altinstr_66" "_=
begin" ")),0x90\n" ".L" "__UNIQUE_ID_altinstr_66" "_end:\n" ".pushsection .=
altinstructions,\"a\"\n" " .long "    ".L" "__UNIQUE_ID_altinstr_66" "_begi=
n - .\n" " .long " ".L" "__UNIQUE_ID_altinstr_66" "_alt_begin - .\n" " .4by=
te " "( 3*32+21)" "\n" " .byte " ".L" "__UNIQUE_ID_altinstr_66" "_end - " "=
=2EL" "__UNIQUE_ID_altinstr_66" "_begin" "\n" "    .byte " ".L" "__UNIQUE_I=
D_altinstr_66" "_alt_end - " ".L" "__UNIQUE_ID_altinstr_66" "_alt_begin" "\=
n" ".popsection\n" ".pushsection .altinstr_replacement, \"ax\"\n" "# ALT: r=
eplacement\n" ".L" "__UNIQUE_ID_altinstr_66" "_alt_begin:\n   \t" "jmp %l[t=
_no]" "\n" ".L" "__UNIQUE_ID_altinstr_66" "_alt_end:\n" ".popsection\n" "\n=
" ".L" "__UNIQUE_ID_altinstr_67" "_pad:\n" "# ALT: padding\n" ".skip -(((" =
".L" "__UNIQUE_ID_altinstr_67" "_alt_end - " ".L" "__UNIQUE_ID_altinst   r_=
67" "_alt_begin" ")-(" ".L" "__UNIQUE_ID_altinstr_67" "_pad - " ".L" "__UNI=
QUE_ID_altinstr_67" "_begin" ")) > 0) * " "((" ".L" "__UNIQUE_ID_altinstr_6=
7" "_alt_end - " ".L" "__UNIQUE_ID_altinstr_67" "_alt_begin" ")-(" ".L" "__=
UNIQUE   _ID_altinstr_67" "_pad - " ".L" "__UNIQUE_ID_altinstr_67" "_begin"=
 ")),0x90\n" ".L" "__UNIQUE_ID_altinstr_67" "_end:\n" ".pushsection .altins=
tructions,\"a\"\n" " .long " ".L" "__UNIQUE_ID_altinstr_67" "_begin - .\n" =
" .long " ".L" "_   _UNIQUE_ID_altinstr_67" "_alt_begin - .\n" " .4byte " "=
%c[feature]" "\n" " .byte " ".L" "__UNIQUE_ID_altinstr_67" "_end - " ".L" "=
__UNIQUE_ID_altinstr_67" "_begin" "\n" " .byte " ".L" "__UNIQUE_ID_altinstr=
_67" "_alt_end - " ".L" "__U   NIQUE_ID_altinstr_67" "_alt_begin" "\n" ".po=
psection\n" ".pushsection .altinstr_replacement, \"ax\"\n" "# ALT: replacem=
ent\n" ".L" "__UNIQUE_ID_altinstr_67" "_alt_begin:\n\t" "" "\n" ".L" "__UNI=
QUE_ID_altinstr_67" "_alt_end:\n" ".pop   section\n"
    ".pushsection .altinstr_aux,\"ax\"\n"
    "6:\n"
    " testb %[bitnum], %a[cap_byte]\n"
    " jnz %l[t_yes]\n"
    " jmp %l[t_no]\n"
    ".popsection\n"
     : : [feature] "i" (bit),
         [bitnum] "i" (1 << (bit & 7)),
         [cap_byte] "i" (&((const char *)boot_cpu_data.x86_capability)[bit =
>> 3])
     : : t_yes, t_no);
  t_yes:
   return true;
  t_no:
   return false;
  }

What I'm thinking is happening is that the __always_inline__ is causing
multiple exact copies of the thing.

Let me see how terrible it all ends up when using as macros

