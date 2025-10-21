Return-Path: <linux-kernel+bounces-862648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 430B2BF5D68
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3556F4E7CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C64303A0B;
	Tue, 21 Oct 2025 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="humALt/d"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F582EC55E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043084; cv=none; b=LmM2+J/k6YmjbnNROLcRMBckUgK+CNDnhsxqs022FSyprqnHNirSCYx03GoonIt7r9AnWnGo9csEyunp2uD4tj9w1lQWUedc2qyBJbohgCMi3BEjSJ5Ub5N0C9WoWtDyhdoqtabindFlbZmQPOrLf3iQv1l4KHQJsWIQjpq8Upg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043084; c=relaxed/simple;
	bh=YozL1yuui2ZFLBKlN3rUM17uNCImsDwY07x6lcrRP2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lrldz14cvMVwTdGxkCxUZq/F2f2xT5j6NhzACiBb1+4wxpO1Tfevf9pX/HgzZ8RcvRobMQ7iKNTSz51x8zSTRhyxVGpnQykgM+wiJib96zcEtMRRzZm79qxtKRdbqYvNAMDIQWAbNx1W2kcytT5W7FAaujqla1HxAoGjpTh6u4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=humALt/d; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0BE8340E0200;
	Tue, 21 Oct 2025 10:37:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id e_PJ_AkA1ZS9; Tue, 21 Oct 2025 10:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761043073; bh=1MK3o86LJlLe9PuKDl0p9VdpDRU6sKV/uVIIEPz4Gd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=humALt/ddM9w1KWSpbABujd4dkw0zR7zZmuuD1MJRCOktqzqcvBDMlcSh54V/QNaS
	 4u69jXQmJMrPcUCeW+hYgSK4TMa3F0pVJc7rjSPU8VKpwTogiTbQEAxmUv7Uwi/uM1
	 C2RgEv4fHdB8dzCG1545TI5XA4RJGp1mmwASMgGAtlSB1fRRqRvdwTrsp+pTFCC81B
	 oj2j/UQzueHKxPki6O7A5KtqZXiXBit5O/q3LJ4/otPQg86mla5IOrSuaJmFBR1/wu
	 Tcn03FQ45wJV3MgUiPWR/ur1Md6NxTCcJFPC7uxhhxjwSmIvxntzjfzkR+0BAS9NcX
	 H6aPeHktQE7vTKKChG4xTW932vGJU8R0QqlYD3ndXStDR3JuiBUY3efHo/cljoQ5l9
	 6RiJ0yhYoZ7Whg1oKSYRLlZeRymPcvTPvouFtqf40cG0r7h3eWpckhlmP/54M83rZC
	 gofuNh3diqUvhVMUT9Y6agqhZfDQZjcmHBBTeHjKryHBiZmgUjb0Kf8oivsrUBg9sz
	 p6GMFv6FyhSb4WhRMvgoF5I+on5nT2h2L+4URSr9QuEFZOJuOejtVsOzhBoLzQt/32
	 /G449eCNHLIEJUscfzjmTkEmiIGQ+SQ0Q+U7IKGRzev+55C2vpCB2GlqL+eFv6/MkJ
	 FrrKo8cfigENRnvZNTK5rAvE=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 90E5240E019B;
	Tue, 21 Oct 2025 10:37:46 +0000 (UTC)
Date: Tue, 21 Oct 2025 12:37:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Kael D'Alcamo <dev@kael-k.io>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/cpu: Fix kernel-doc for 'centaur_get_free_region'
Message-ID: <20251021103739.GBaPdic1JTakX2bA9i@fat_crate.local>
References: <20251005204200.191346-1-dev@kael-k.io>
 <20251005204200.191346-3-dev@kael-k.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251005204200.191346-3-dev@kael-k.io>

On Sun, Oct 05, 2025 at 10:41:21PM +0200, Kael D'Alcamo wrote:
> Signed-off-by: Kael D'Alcamo <dev@kael-k.io>
> ---
>  arch/x86/kernel/cpu/mtrr/centaur.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/mtrr/centaur.c b/arch/x86/kernel/cpu/mtrr/centaur.c
> index 6f6c3ae92943..f4c72402c284 100644
> --- a/arch/x86/kernel/cpu/mtrr/centaur.c
> +++ b/arch/x86/kernel/cpu/mtrr/centaur.c
> @@ -20,6 +20,7 @@ static u8 centaur_mcr_type;	/* 0 for winchip, 1 for winchip2 */
>   *
>   * @base: The starting (base) address of the region.
>   * @size: The size (in bytes) of the region.
> + * @replace_reg: mtrr index to be replaced; set to invalid value if none.

I'm afraid I can't follow here what invalid value you mean...

In any case, pls merge those two into a single patch and make sure it has
a commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

