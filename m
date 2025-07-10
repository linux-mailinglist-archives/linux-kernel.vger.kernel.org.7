Return-Path: <linux-kernel+bounces-725467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A888FAFFF77
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BBF189A18F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0363B2DA743;
	Thu, 10 Jul 2025 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hmbZ1mpP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC82D978A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144199; cv=none; b=SYnp5F6euu3HaFWPZ96vSBBgTQwUU9WEp5GTolkVTRiSPK7JyAjLPJv5wrUEQGp4cIm1trEoCbVHH29ezZ7SlYUaxLzn3sIU3cFJLE4GMYfAlnD1TkJuE+796wokuSsqcoVW5ALtgKAOUp+KcxCgxfGk5j4rs1wRB9SrAYL2oTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144199; c=relaxed/simple;
	bh=KRxNxt43LuiVxMzN5lflrN9Dg7mvXG8/7Z77FdBz6uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUr6TLTpdqQ8k1FJEzhlbaWeleio5PDyqNxjZ/tQWIs2NuePi74Ii9N3Nrs5ziMkGJVo4KOr3rjKq8yBw6wi8E7CbQl53ZgNKsNvvWc1leqD3bEgYJM16UMegbCzGvgw7YMfKQN8CUvZ1H/2r3ZCLXkioxzIJ2KFfn2gzEc+pkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hmbZ1mpP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5427040E020E;
	Thu, 10 Jul 2025 10:43:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 86pUdHglGoSN; Thu, 10 Jul 2025 10:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752144188; bh=eNS2aLyPNtGzx0TxlKdT4IcPkSus21LSiJhqeLljKtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hmbZ1mpPJL8m2JJLh1co4Smm++eMMEGlVmSgGzHvODAtfUISwB44cUoVg9IKc9aVe
	 G4RusTAnmKNvFbGQ3KSKdh3Rsop6nakzls8MoV5ujKuXO3f7XyRgBnum+x4eUxG426
	 Nu/RQl2TQZYDsYiUQq1zF+fIk2LOTXXYfKXdQBBEhzh15z9hzubPGEy6CKAZD5xhy2
	 of+SDK9ZGlFa1/6xrj17d26zCUw87zUaxl+urkeH3yas/eG67e8Z4YgtsWjqH6swUk
	 R+Mmx3eWF5kr3CASMXX7dRX3fC4k/bre1aGIKQ4ZlyEk+eyniB0I20AXfZCCsqhigA
	 ROy5G1/3NwoezDsRVNWTm5bpa8OZs+oDlOUn9/3+9mpdw4Pr7LQWBRSB0jnIXueQam
	 TygpjA9isqmiH5T/ZUHMiDuifUhTKDciwL3daX2xME5L6gcV+34+4mXOYuVP7ugGkh
	 1MQu6fE5A+kaOZvefimKXP0Eyo81APn7tN/tAGUdr0TNZ9HHxutC4Bljzgv0j0oKXN
	 Lv0hJ4cThcdRM5ZRq0Yvt92ifzQGTOlmC1WPr5x/IShpIr2HCfyLBtTIwM2ZeNRGvS
	 cWyF5rnic5oMkTwCHtjXYho8/RzKwAoKpH4gKLtt498hFUt8iiTQUGZ4oIE68/YEvm
	 5EZP6VX4eDmcl2F453RzzcFw=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4244A40E00DE;
	Thu, 10 Jul 2025 10:42:58 +0000 (UTC)
Date: Thu, 10 Jul 2025 12:42:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/21] cpu: Define attack vectors
Message-ID: <20250710104252.GBaG-ZLG7p_LsNCjBm@fat_crate.local>
References: <20250707183316.1349127-1-david.kaplan@amd.com>
 <20250707183316.1349127-3-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250707183316.1349127-3-david.kaplan@amd.com>

On Mon, Jul 07, 2025 at 01:32:57PM -0500, David Kaplan wrote:
> +	/* Attack vector controls may come after a ';' */
> +	if (*p++ != ';' || !IS_ENABLED(CONFIG_ARCH_HAS_CPU_ATTACK_VECTORS)) {

Right, so the ; separator causes problems with grub and its shell-like
grub.cfg file. If I put there:

	... mitigations=auto;no_guest_host

it says

	error: can't find command `no_guest_host'.

because it thinks it is a bash command.

We could do

	... 'mitigations=auto;no_guest_host'

but that's non-intuitive and it'll cause problems left'n'right.

Using ':' as a separator instead seems to work so if people agree, I'd switch
to ':'...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

