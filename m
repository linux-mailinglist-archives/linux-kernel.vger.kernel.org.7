Return-Path: <linux-kernel+bounces-749926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1DB154DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E84540071
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3776B275AE4;
	Tue, 29 Jul 2025 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YcgdlMCf"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C879D2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753825982; cv=none; b=rBFxrPTRFCCPhrhSpRg/v8+OQLFTnHqkiQGhJ3HvlWtiTxZNYkjpwlhO1D5ZMmOI5+CUdHFHYfQ38JCI+qH6Guv5m7wn0z186R2RAsfijcljU6hAS/h9M8pyrmZn7qQyOiz+pPOosRJVJsEay7rPTzMSWvgfN+3H8F7G2xme+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753825982; c=relaxed/simple;
	bh=Nc42F50HjGbrnJayXoBi+WuR+wxVv73J88VEU3MyWDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fy03Vj1uUOyQ+oRnMSrHv2u2Tr/+6vmK9TNb7Mato3fibatCKg0E2lkB2kJGdhTFD2FfdxqmKyQH1IBxr1QIXJ3zP/5Z074F31m89ppUhswTge3ZV1IbKu3n66yOs9s9FJkLNRkgCuIZrT/WWDLl85wfsE+AwG0U6KppJLNMDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YcgdlMCf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 611E840E0254;
	Tue, 29 Jul 2025 21:52:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JYRrIgDaRcg8; Tue, 29 Jul 2025 21:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753825966; bh=2TJsLvlOle/oj88flx1JsHus1JpT1wHhWgHvngUlz98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcgdlMCfoXDs4wbdktWluXfPNiMTpmuWy1T2oPsb9UQOL99QIXrWMt4iASh2bUa8z
	 6N84akZ83lol/7gB2XRN6l7FPj8InOBRy2fWHPSNRYQJ2l7Sk7tsCyMJqSXEHjWnd0
	 wxlZvmsw/vnBHbxw1E/fn4i2xmRYxFxp7ADGa4KqOvsHvnlczb5+6tY6ZtTbXV1psB
	 XMNf7mxmMEts4fODw98admOf2kXAxxnbkooiqOu5YoRTOQBlRShn5RFuEjly2Hs+cw
	 nITxLiRMr1Ygry4q8s4z5UaHEaJeGiePxX45zG+smABbWEfz5191uZJ2aAUWKR4pPk
	 kyRp2iJZkX46v1ZcJ481pWfMWIf8FSktUId9VAqypm29+qk18lPXbp/saazrMQHmuy
	 wcZ5AMRhAX4UBlR2HROUfdZpbcspvhw8ycVVi1sekcD0J2IoAxxNEU3f23gnRHaWTD
	 Jt1Hnsl9SMr0gdlcCyeAFgjy3E+UPrwn/Q9qUrggFUCrC2UfsbCArKMDjhqSkJXy5Y
	 LjjFaTRNFj8hft7kYq+Hm7JveEN1kpqiDfzIz7EbdGJo0x1ubOoAUk7Jx+pW6+DV01
	 nFfGHIlqqtLyidUIiEbAszVQ7g3xg3GfRRLSgZDR7SprF7llpAIf7VVICmQHXpN+jt
	 AgtDq3MohMRY6DX3kLZMnmtE=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BBEF40E0198;
	Tue, 29 Jul 2025 21:52:36 +0000 (UTC)
Date: Tue, 29 Jul 2025 23:52:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	syzbot <syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com>,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	syzkaller-bugs@googlegroups.com, x86@kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [syzbot] upstream build error (23)
Message-ID: <20250729215228.GEaIlCnHzcYmGpiBrQ@fat_crate.local>
References: <6888d004.a00a0220.26d0e1.0004.GAE@google.com>
 <87cy9ikcwh.ffs@tglx>
 <874iuuk87e.ffs@tglx>
 <CAHk-=wirbb_FxAMsb+LFimsMF+nLg4UYsrHvjF1F9tF1xOm2UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wirbb_FxAMsb+LFimsMF+nLg4UYsrHvjF1F9tF1xOm2UA@mail.gmail.com>

On Tue, Jul 29, 2025 at 02:38:50PM -0700, Linus Torvalds wrote:
> I'd personally be perfectly happy just saying "gcc-13 is required" and
> presumably that allows just removing the NOINSTR_HACK thing too.
> 
> But I would want somebody to test that and verify that gcc-13 really does do ok.

I was just typing a reply to tglx and saw your mail snow in...

So:

I triggered the same thing today with:

$ gcc-13 --version
gcc-13 (Debian 13.2.0-25) 13.2.0

And with

gcc (Debian 13.3.0-15) 13.3.0

on the other machine.

I'm thinking if this has worked before, then it must be something coming in
during the merge window...

Because 6.16 with the same compiler and kernel builds fine!

So it is something during the merge window *plus* gcc-13!

Your current master which fails with gcc-13 here builds fine with:

gcc (Debian 14.2.0-16) 14.2.0
Copyright (C) 2024 Free Software Foundation, Inc.

I'll run those again tomorrow on a clear head to confirm but it sure sounds
more nasty than just gcc-13 is fine.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

