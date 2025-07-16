Return-Path: <linux-kernel+bounces-732727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D96B06B49
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC193B4738
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B772673A5;
	Wed, 16 Jul 2025 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Nzn43Nkm"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1E158874
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752630335; cv=none; b=VZK2H4BFvn2drJClaapRamO+h7yVTirn1NsKmoNJUrCYr9tb2xIp9yuiSzlL9qnkjzWpyCVPx3ug3NaJ1o6+1+NHSz/tZs3gcY6A4+h44VzFz5KU0KtpqWcb65Sxp0v9unaENUY4oEgKCgEVtfbVVH7k6BM7gDvHLmfDaBj7eYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752630335; c=relaxed/simple;
	bh=MMY+IseoBhAhfyGrmzrMh5MIGl5i/XAucfvo+sjTyzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0So0z2cFvcJQQCpxIXIPPgBNbT0+NhZI2mi1ntZWIV/CchIv3dZoSxp4EiYVTcNEWYGCRFCD3zNy+/wF+XcBzgae5jSb5cmmsaDWjw/oChtHLlxnoRXlGEJjhwep0h9AKptaw+cHLLmd+qrl4F4LcDnKnZBAoOQFZN99/GRDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Nzn43Nkm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2098F40E0217;
	Wed, 16 Jul 2025 01:45:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jpj0VXIEMFJF; Wed, 16 Jul 2025 01:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752630324; bh=u6K7VacDI/pVtewPONnYY3NOCbN6k37s0H6GGUivJdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nzn43NkmIhWZ9Kq97w7suFVtcdbDKcsRj2l4VJZec+Fy5nVqlU66klZhGcR8cOXyf
	 5EnbCW+2j/OM1qDgoBZ8CxO67HTOTtzkwypgQ3Eog3v+YC+5kqs9yoFXsC9rKmUQUu
	 LD8ijTkOHUA7X4brpmik52wrRUpFPfEGw9lbWIpNsvy1QyfGeC2hMKlt8DqyXLPdXw
	 0rlHLW6EkCHmxkp3rTDhrmiY1ASVepv7WRVPg8KRmxEKWfpZQtB3nNLx/t8wx8AZTD
	 W/rNrMgA+mGBekEoDRml6iVzFS/d9xTu3E3SUnHC+3Wdjn4xdu/mXkCcXGAeHb8a8p
	 GD9SRgAjAfRT44xJ9Hs2oXHw5aXAO70MnCbQfMkG8AdxiINyYvgyMmlidcBXb5qIA4
	 H5RbgHOM9kw+moH3OVaVP1GUBH59Z/P4+cOd1VTwIGM2GtzQeKSmATEoDnA+VOEmuo
	 Ib0BBp9GSHRX4i7ZwmMq3ctZ34hFk31wAe0ltr6yI1geNL1FlKjVw/4zx8Q2nFlO+1
	 xB6XJ/HGWmn/dHhwu10mbjI+Whkf62K8N2TiTZcxSxgdj5izb96wgsFBQ2vhhnE2KS
	 /FpMKDG00FxKL2dT3KZtKCpXph5uZxpmJ0M4MOfZSSu5o8apwJl3IK1VZFGXh07Trm
	 reCmq75r+187sdg68MGIF0dM=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35D4040E021A;
	Wed, 16 Jul 2025 01:45:12 +0000 (UTC)
Date: Wed, 16 Jul 2025 03:45:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: khaliidcaliy@gmail.com, ardb@kernel.org, brgerst@gmail.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	ubizjak@gmail.com, x86@kernel.org
Subject: Re: [PATCH v3] x86/boot: Avoid writing to cr4 twice in startup_64()
Message-ID: <20250716014504.GAaHcEIIUgNOdu_n2s@fat_crate.local>
References: <20250715181709.1040-1-khaliidcaliy@gmail.com>
 <927f2b0a-7e64-40f2-9773-cba9b1d328a5@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <927f2b0a-7e64-40f2-9773-cba9b1d328a5@citrix.com>

On Tue, Jul 15, 2025 at 10:21:20PM +0100, Andrew Cooper wrote:
> > diff
> > <https://lore.kernel.org/lkml/20250715181709.1040-1-khaliidcaliy@gmail.com/#iZ31arch:x86:kernel:head_64.S>
> > --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S index
> > 4390a28f7dad..dfb5390e5c9a 100644 --- a/arch/x86/kernel/head_64.S +++
> > b/arch/x86/kernel/head_64.S @@ -222,12 +222,9 @@
> > SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)  
> >  	/* Even if ignored in long mode, set PSE uniformly on all logical CPUs. */
> >  	btsl	$X86_CR4_PSE_BIT, %ecx
> > - movq %rcx, %cr4 - - /* - * Set CR4.PGE to re-enable global
> > translations. - */ + /* Set CR4.PGE to re-enable global translations. */  	btsl	$X86_CR4_PGE_BIT, %ecx
> > +  	movq	%rcx, %cr4
> 
> The comments are at best misleading, but you've broken the TLB flush
> being performed which depends on the double write.
> 
> This logic is intentionally performing a write with CR4.PGE=0 followed
> by one with CR4.PGE=1 to flush all global mappings.

Thanks both of you for the catch - I didn't realize that fact. Zapped now.

So yeah, maybe there should be a comment explaining this subtlety.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

