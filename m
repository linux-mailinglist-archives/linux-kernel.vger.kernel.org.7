Return-Path: <linux-kernel+bounces-802942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D91B458A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDFD58470C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D703B1D7995;
	Fri,  5 Sep 2025 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="McPcmgFW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7811713
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078373; cv=none; b=E8U8g16FD0+O1sn5lSNCBvSQYuAax3UAUSmvaZWb4LgUxF2aDSJTGNHp3u0Bmid9PPE+2yLjEAattXbkCrsO8hiJvUM2euHuMDeCBj0WPZUE5ZqWQsnwPxMkTR30gYokqwORPqVBshjA5EiCT9G6xNRW9i3Ji/wLuP6oW4B3y+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078373; c=relaxed/simple;
	bh=4+aBu1QYPkiVf6s77hX2MEWDjitw9I++XXnLuguNv6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3BPVI+Yk7noveQ1PPhsVSywZ15MQFWocW1Vo57xs64o1NRCSdyGpePnor/M7qnyJbS4SXwy/FzV4MFvn3Z2Kr+gKRL+ptlpyKgTdi+kDFDGZjlUzeX47uRVQjvenE3MMCiG69R4/0xR/hf7A1a5pL2ItCFnhf1D2FmBpJuZhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=McPcmgFW reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E95E140E01A5;
	Fri,  5 Sep 2025 13:19:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8G6JW74q3WKi; Fri,  5 Sep 2025 13:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757078362; bh=+75vthP3JRfPmr4G0ovrKndN5n6E7CyQChLfsO/D918=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=McPcmgFWWndOeR1OONO4boLM2w7NrPV2ABZuYAwmrobY4JXQwB2ff0/PfZZl5LAqh
	 dhpiyXXZ8t3IcRXr+y3n/Hi1DsM1baU9tIJ9zKMjBoAsC7Dc0JxHUm6oE/AH2gbeM6
	 JBiRcvICSd1xriF97NKxM4QSGm+vKl/MtoNm8GUB7Yoe92G5QZwrhdZNdxkKJbGA/S
	 +RC0ZoGf+X9nHTfzIbUv0Btxbl17GUn7JBpPz+mSqNOuA9nmKDwhhdpDmOLcAmX2ST
	 1q0hdcYZMj1Bn1ZWjys/+E7AEU47iruAl3a9mUwSklNz62XGAQISn5ByuPbqnYViLI
	 s2VljS32Y0u99SnYm4HKIoBxGqnLscpF39FvZikpOG0j+/xW17zw9Q7rye0D7xB3+s
	 ZBUXfQZ142QDhkUnQ6/nM8SuD3UWb88tIjTP3T8Tf/ckpdRvNs45ueeqlMQsnTsf/Q
	 R6JVJy0Vr2/fM5JSimvJvLZBr4MA0LqT3HivJYxhfXdtOKtvabZFpzMMB9pGjt64wB
	 6rL8OUgTCd0TNxNEaClRhL9wGZTptXvyUHg8YF+NGLOhUiiC6RAJ8w1G7StaEmWTgm
	 HiSu2v2QdOrowVUh4Rin+UNLaCumA6J6Dn7v8RAu7p81ET1KcLWQG820OASzx1czLJ
	 aC8jRWGgoD4m6mWHatUT4Cms=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 27C3B40E016D;
	Fri,  5 Sep 2025 13:19:15 +0000 (UTC)
Date: Fri, 5 Sep 2025 15:19:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip] x86: Remove code depending on
 __GCC_ASM_FLAG_OUTPUTS__
Message-ID: <20250905131909.GDaLrjTTw0PyFHeCHp@fat_crate.local>
References: <20250828072958.3922703-1-ubizjak@gmail.com>
 <20250905121723.GCaLrU04lP2A50PT-B@fat_crate.local>
 <CAFULd4auQGQ3Ro_3GHJAoGDTnHW1hNzrK+9W_0mVwTEQeWTDUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4auQGQ3Ro_3GHJAoGDTnHW1hNzrK+9W_0mVwTEQeWTDUg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 05, 2025 at 02:36:24PM +0200, Uros Bizjak wrote:
> There we are testing the value of a single flag bit, set by the CMPXCHG=
=C2=A0
> instruction. =3D@ccz is used here to distinguish the CC user from compa=
rison
> instructions, where ZERO flag indeed means that values are equal.

No, this is not what I mean. I mean SETE and SETZ are the same insn: 0F 9=
4 /0

What you mean is that CMPXCHG8B modifies the zero flag, thus you want to =
use
ccz which denotes the flag while "set equal" doesn't correspond to a flag=
 in
rFLAGS.

But then you need to say that in the commit message instead of me asking =
about
it.

> The same situation is with carry bit setting BT instructions, where we =
use
> =3D@ccc instead of =3D@ccb.

Ditto.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

