Return-Path: <linux-kernel+bounces-797493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3EAB41116
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945F37B2A61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911817BD6;
	Wed,  3 Sep 2025 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gv8ybeZJ"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2C10E9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857751; cv=none; b=iceZt0uSc/Lsk4rJgBu/5HxmRu3ylP10AEJc8B0wEntvSgBaCPPw9MLCaYNXrniVJet+kfAE+zRiPLtOch/rA1vJDJDcMBocQ2oLnhRlYyZ6wDkQuBHVrn3ZCn83n7DvaI7rut5ApYBsi9gekPa1TuLxkJ0p6TDlhPBFJZNKUOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857751; c=relaxed/simple;
	bh=h6SHX9NUKMtv9AQsCVV+EbLHDv3AOoFiLIxUBEgDy4k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nJAUcTo7YVVBDbKkNl7SbysQd1VWBPDwbNmSJDzd2frvTTE4uTTTNfSzbJpOf/y9d99pORy5FLKJkNiqHtNJ++fH25Cg9Mb46DpNJ6yd0zLRWXCGnrKfdl5hzOutBlNFIPvJLVtbyqQPtKfGaTF+72nULlMbVOq2A6FYgWugjug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=gv8ybeZJ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 58301TFY1033061
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 2 Sep 2025 17:01:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 58301TFY1033061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025082201; t=1756857691;
	bh=zwn3/lFhCh8Ukdp0VyW6N4XTD8c3e8gIPp7RWQzBdxI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gv8ybeZJCPI8r3flgfNvJfRQ2fqfb5/ew09oqSC4AAWlCsBQpytAvDZlO7+BpKpfA
	 oCauI1rYX2umeNBFI7cc7O9Y+Ok8a0JAG/5HJstsCO5oxF0FxMrVaJvOSiHJOiSR+n
	 W8Xqw4QqwbQ2LWcMyUArgXdDKL5bBP/QtFmDNdpvvW5pB4rzu+IMcQdv+2sQ94L8JQ
	 0wu5Xd7giYQarOCd8eA69iv6vkNkFFvErm+3T9wS0NvkV2Eob2MXnaDs84C1sVGx9C
	 rPHWLoLf2MLRa8bYrTb9gP1b1QavUTZJopujP2fOsryNjRxrOlWjdSaDJKmO28gl9d
	 KjyfDwhyUxZkA==
Date: Tue, 02 Sep 2025 17:01:30 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
CC: Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v2] x86/fred: Fix 64bit identifier in fred_ss
User-Agent: K-9 Mail for Android
In-Reply-To: <20250902230117.1475414-1-andrew.cooper3@citrix.com>
References: <20250814190436.2555438-1-andrew.cooper3@citrix.com> <20250902230117.1475414-1-andrew.cooper3@citrix.com>
Message-ID: <489572CC-89F3-4546-AE42-736B6D6F1657@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 2, 2025 4:01:17 PM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=
=2Ecom> wrote:
>FRED can only be enabled in Long Mode=2E  This is the 64bit mode (as oppo=
sed to
>compatibility mode) identifier, rather than being something hard-wired at=
 1=2E
>
>No functional change=2E
>
>Reviewed-by: Xin Li (Intel) <xin@zytor=2Ecom>
>Reviewed-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>Signed-off-by: Andrew Cooper <andrew=2Ecooper3@citrix=2Ecom>
>---
>CC: Xin Li <xin@zytor=2Ecom>
>CC: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>CC: Andy Lutomirski <luto@kernel=2Eorg>
>CC: Thomas Gleixner <tglx@linutronix=2Ede>
>CC: Ingo Molnar <mingo@redhat=2Ecom>
>CC: Borislav Petkov <bp@alien8=2Ede>
>CC: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>CC: x86@kernel=2Eorg
>CC: linux-kernel@vger=2Ekernel=2Eorg
>
>v2:
> * State no functional change=2E
>
>IIRC, this was wrong in an older version of the FRED spec=2E  I made the =
same
>mistake in Xen, and I didn't copy Linux's structure=2E
>
>I don't thinks this warrants backporting, but the fixes tag is:
>
>Fixes: 3c77bf02d0c0 ("x86/ptrace: Add FRED additional information to the =
pt_regs structure")
>---
> arch/x86/entry/entry_fred=2Ec   | 4 ++--
> arch/x86/include/asm/fred=2Eh   | 2 +-
> arch/x86/include/asm/ptrace=2Eh | 4 ++--
> 3 files changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/arch/x86/entry/entry_fred=2Ec b/arch/x86/entry/entry_fred=2E=
c
>index f004a4dc74c2=2E=2E94e626cc6a07 100644
>--- a/arch/x86/entry/entry_fred=2Ec
>+++ b/arch/x86/entry/entry_fred=2Ec
>@@ -78,13 +78,13 @@ static noinstr void fred_intx(struct pt_regs *regs)
> static __always_inline void fred_other(struct pt_regs *regs)
> {
> 	/* The compiler can fold these conditions into a single test */
>-	if (likely(regs->fred_ss=2Evector =3D=3D FRED_SYSCALL && regs->fred_ss=
=2Elm)) {
>+	if (likely(regs->fred_ss=2Evector =3D=3D FRED_SYSCALL && regs->fred_ss=
=2El)) {
> 		regs->orig_ax =3D regs->ax;
> 		regs->ax =3D -ENOSYS;
> 		do_syscall_64(regs, regs->orig_ax);
> 		return;
> 	} else if (ia32_enabled() &&
>-		   likely(regs->fred_ss=2Evector =3D=3D FRED_SYSENTER && !regs->fred_s=
s=2Elm)) {
>+		   likely(regs->fred_ss=2Evector =3D=3D FRED_SYSENTER && !regs->fred_s=
s=2El)) {
> 		regs->orig_ax =3D regs->ax;
> 		regs->ax =3D -ENOSYS;
> 		do_fast_syscall_32(regs);
>diff --git a/arch/x86/include/asm/fred=2Eh b/arch/x86/include/asm/fred=2E=
h
>index 12b34d5b2953=2E=2E2bb65677c079 100644
>--- a/arch/x86/include/asm/fred=2Eh
>+++ b/arch/x86/include/asm/fred=2Eh
>@@ -79,7 +79,7 @@ static __always_inline void fred_entry_from_kvm(unsigne=
d int type, unsigned int
> 		=2Etype   =3D type,
> 		=2Evector =3D vector,
> 		=2Enmi    =3D type =3D=3D EVENT_TYPE_NMI,
>-		=2Elm     =3D 1,
>+		=2El      =3D 1,
> 	};
>=20
> 	asm_fred_entry_from_kvm(ss);
>diff --git a/arch/x86/include/asm/ptrace=2Eh b/arch/x86/include/asm/ptrac=
e=2Eh
>index 50f75467f73d=2E=2E37370c3b1ffd 100644
>--- a/arch/x86/include/asm/ptrace=2Eh
>+++ b/arch/x86/include/asm/ptrace=2Eh
>@@ -84,8 +84,8 @@ struct fred_ss {
> 			:  4,
> 		/* Event was incident to enclave execution */
> 		enclave	:  1,
>-		/* CPU was in long mode */
>-		lm	:  1,
>+		/* CPU was in 64-bit mode */
>+		l	:  1,
> 		/*
> 		 * Nested exception during FRED delivery, not set
> 		 * for #DF=2E
>
>base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182

Acked-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>

