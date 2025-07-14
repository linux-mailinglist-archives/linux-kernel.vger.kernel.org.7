Return-Path: <linux-kernel+bounces-730236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8DB041AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AAC1888098
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D06D23F26A;
	Mon, 14 Jul 2025 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="F13G9CCk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB801922F4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503420; cv=none; b=AbP4FrpWxKmQouczuNC17nzrGiY0HTi6fogIufuynuBFNjjedGLBPeEfbrPkFIKMetFc2X5vTN3J5LwDUh6fR15KgR8BOs7bzT+iiZ7tzKTKDyns5H049aaxx3Pd/f/g8uj2Xmg8dXUwTPCwViXXf6uPXD9SG9l4sTRVC6uRhp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503420; c=relaxed/simple;
	bh=1VPQhoLDMlVFg7pZpEo+CtAKsWfkwzBnZH36CE0ZCXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZMtGi+iSsoxMBiCdjiovJBV3qdSXg1I9QNFis7BkvKvh5ej9uv+7vEBVqbRjkHTwB3MriDpzUK1Tk80HmFM/QOVUO9Dw3ENEXV/9T/+XPg+6vYx/sPrdVtsD/eYmgeCTMSwwsNNzJii/xyLseSky198xYUV8tN0rRqbNXKeEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=F13G9CCk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B6F6540E0213;
	Mon, 14 Jul 2025 14:30:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vCTv2vemB3CA; Mon, 14 Jul 2025 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752503411; bh=/o6rJU1/XBKHMMjVQZ91sA78JP/uqP9BJWvRglGBqcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F13G9CCk7fqG/93C0L6g3TBTI+SrR7R0/T5cwC9Aum/9tQJPzIMJ7B4/Egi7xywvk
	 Mf+SciKm0JWUyOneOLlmcz2bNu2rRiLg7ZhOSwYQIusyqpN2KL0Wc7eUJNXfGg2Pp3
	 jp4gnI3Pf1lqnpOULMPDd6PLdK2phns5ZmHiq3q7E2Cexz5bonUvJQiuSioQ6xWRY9
	 kt/wwrV7q6O/fYtlPSbhn8cA4SKEbRikxUcBOCI1vEEIKuKvq4LG4us24dhupEWYQ/
	 SOHwFyr4/faiUdNcT8eKNqJuTt1eXq6fnEW2jYJ9vA3s9/D1d7ShR8Ulj4muf6BLmB
	 vNR+6JCCHqkT3kGHkwrYSFVTmLKcMwmVDHsYnQw05dNn6Xp34Td0Ggh+nHZKit934V
	 ZyCq2d8gkIIms4n1/h9MXFf9CI1X5MAYmY9DpxPEXAUignOVvLHEW31Jl9HZHOljYl
	 upYDUIaSmUtdd+hB7jzfajovx227aYWKtoIX4m4oJcsy/ZD11pm0ApPN+bAx3g0HXg
	 HZPoJSYqSh/A/SwKcgks6+5Fiih/5gcH90/I54Cx5A7GXQCxmXSj0AYycRP2+3iZ/N
	 549wRkpSfttWtvZRgUPrLAoTO/3rgO1tgmrnP1lqJHiatCW/O2KeLBUup9i4NLLY4k
	 G37fAv8C2FUtWYOdKIpwhQLQ=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5BF1C40E0208;
	Mon, 14 Jul 2025 14:30:03 +0000 (UTC)
Date: Mon, 14 Jul 2025 16:29:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/1] x86/defconfigs: Explicitly unset CONFIG_64BIT in
 i386_defconfig
Message-ID: <20250714142957.GIaHUUZTHu9zoGEaNg@fat_crate.local>
References: <20250626150118.318836-1-andriy.shevchenko@linux.intel.com>
 <aG_0K7Zx5WpQHGJE@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aG_0K7Zx5WpQHGJE@smile.fi.intel.com>

On Thu, Jul 10, 2025 at 08:11:07PM +0300, Andy Shevchenko wrote:
> Can it be applied now?

I've merged it into the commit in Fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/kconfig&id=6453e7cc32d1fd69344311224dbd00692eadc592

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

