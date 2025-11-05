Return-Path: <linux-kernel+bounces-887230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1831FC379F3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB8A04E6987
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC7C325707;
	Wed,  5 Nov 2025 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="X37PonFU"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3325522B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373118; cv=none; b=G8iY4Ewx3Au4jXobeL3XkO/GVA648wpYtzz+8xkrR7Gjt2yHEYtgd46KYqmZ/naRAkgp5DOMiqV/CGST+4T5QXwBYy4czyMcDQwZ/Sz9TQlP8xBKLhKn28oB/eBq0VZYsvXJlRLkdRaiYxf1A2u2kviH6vmOpxgpp1MUD89nC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373118; c=relaxed/simple;
	bh=8HMzQGuxndB9dt/RPjaCJbkzRlRpF2cFYPqFtIS3c9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY2JMiIqRNMKetB0HVSTduwjaWR91aF3nF1NbCr7jiUn12t99c9+OuAeoZocV7RZblGpn44R0O8ABgc+ykUJO1ZJ3Nn6jgkdavji1jWn8C8aLqcwqkCHPNYKu4UAIqSUEmbfPpfs5uahkxSb2/QX93CoVb+Ff4JwXP7TpMoC+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=X37PonFU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0577340E015B;
	Wed,  5 Nov 2025 20:05:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i-AnOtrUsI_d; Wed,  5 Nov 2025 20:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762373106; bh=fYfYWQekpKMSwocEBAEzndoctUQRvHdirTXWANQiR6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X37PonFU+7CKwP5bXRcvEfrdQ4jn3n3ucT49c0S6toQ0hRvhHlN/WZLLsDnf4zeEp
	 X+YLtog/hNI7J8+pt4q8jK/yuMakTwJ2io1X0hdzRkbwLfc32vJEUq4SYjUhcy9JcD
	 eUYSM9hI0UQpRUm3K//rgJeffHk2x2/+hYHFOt3TQaspRLH3g1uUYwwZ+G/b16dVgj
	 9Su6oGg6zyoIei2g0sBNQrkhofpu7lIplDSgOyjH/lehgR7oo2fiJchHpVzjqxCIqZ
	 EyV1LnTOtd03xd7RaB4pL5n74Ano8noBbDEndpNBFl3b2SaDBh3LwtjpDylo1wi4pn
	 3vhDM4NBzHvMzfvyfmJ/RF61JxDlnNcJhQBFIxhbj/Mk99wgMzOoMPe0EXOXCXlREq
	 XianHepFrLbt0cNChc4DsSKD9y9xHQIoSQ4zU9SPsT0bIQGd03Axa5aOnE/a2fQIea
	 91HVSJtTw+Q9gL7ptiC2uG+EO8XVHW0cNlyE8ssZ19XVl5+reHxcIfFFQJt6I4tIS4
	 vNs2UZyC40pm4FrPVOp7H6pHyLhu7u++JUZOcuUjz8IFv9VNn/Al5PBOjCwtEdmG3A
	 QRK2Cbd9n7ZCQB71MkJac51OGcnrgbam4VYKC9YdNoRrmcmYDtNai9lFEGzMkJGqaz
	 GCoymYSKgHaZ/+KQ2I7v4pwQ=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 07FD440E00DA;
	Wed,  5 Nov 2025 20:04:53 +0000 (UTC)
Date: Wed, 5 Nov 2025 21:04:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 05/56] x86/bugs: Reset spectre_v2 mitigations
Message-ID: <20251105200447.GBaQut3w4dLilZrX-z@fat_crate.local>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-6-david.kaplan@amd.com>
 <20251103193130.GQaQkDEquEnEwb_cwC@fat_crate.local>
 <LV3PR12MB92655CEB1AF94875901E700C94C7A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251103202811.GMaQkQW54Gml6i1jQy@fat_crate.local>
 <j2mds5vdblnhpha6oyejqcj2fgmveylgaudzzljvfwwl3fgvnw@xgmsl4f7jzv4>
 <20251105110318.GAaQsu9vGkzSxGbzzx@fat_crate.local>
 <b7xcrqkx4ouye4ayqkkvmpoirpqydhf663uim63w7nt3xwbgyc@kytyca6dgztu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7xcrqkx4ouye4ayqkkvmpoirpqydhf663uim63w7nt3xwbgyc@kytyca6dgztu>

On Wed, Nov 05, 2025 at 09:06:36AM -0800, Josh Poimboeuf wrote:
> Nope, these patches don't add any forward declarations because they
> sanely put the caller below the callees.

Not happy about the added ifdeffery tho. I guess we can move it inside the
functions themselves or mark them __maybe_unused - whatever makes the
compilers not complain.

> We should put cpu_select_mitigations() at the bottom too, then all those
> existing forward declarations can go away.

That's a good idea. We should, if it doesn't get too hairy.

> I don't see how the solution to "too many functions" is to start
> squirreling away some arbitrary parts of (otherwise logically separated)
> code in a hidden uber-function away from the rest?

I aim for this file to "keep it as simple as possible and leave enough
breadcrumbs as possible for later."

But your argument about keeping all the mitigations and their functions
together has some merit too.

Maybe we should do

arch/x86/kernel/cpu/bugs/mtg_<bla>.c
arch/x86/kernel/cpu/bugs/mtg_<foo>.c

:-P
 
> If "functions bad" then why not make cpu_select_mitigations() one big
> happy function with a ton of comments?  Just think of all the function
> savings ;-)

If it makes it more readable, always. But I see your point.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

