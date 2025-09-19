Return-Path: <linux-kernel+bounces-824745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83630B8A106
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7CD5874A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3621924503C;
	Fri, 19 Sep 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Lo7IMgqs"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B2273F9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293236; cv=none; b=LnmlqQjI1xjfuRRhucHtyHA0c+FRlPtxHZSoFFp77uhnVf+D+cymolRkubAE22inHrc5wSB9ahB1MSQDBmJnvZ0bpnH0x6uv5yyTvhTbecczNQCvbkTEFeOqxmfkRzjwFugOGTqcUCGrA2knlnvakXue5lBdxoCVI3U6vVp1bZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293236; c=relaxed/simple;
	bh=3es7VilMbt7caBUBG0oE56IXISX60uMW3vw2sFIe7KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+vHC2iotJhW43D2zbhaeass/CvqIYEFQWP+YB/8EKnbGfWrwXpaoFY5OSdsjIvGs2SWDi18zfeL2WE6G1XwJJxIDc9j4fKU2d9Yx0FrTFInNzRv6CdW/6uHqDMYSBeIuHKKdGO6MX33uMshS8PBK/mfthOFQoHAFS4scarwMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Lo7IMgqs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B5AE040E01AC;
	Fri, 19 Sep 2025 14:47:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5qp47ba4Pu6N; Fri, 19 Sep 2025 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758293226; bh=XJkCEhW9XL1Vb5alDd+rFrnd8qVEBJWPMVwO2ZaFLC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lo7IMgqsFMSKoTmc7ne80FD0cH+1whQpfvF8RAbLmIRt0iAaRnacb60TfxaLs1Lgs
	 zZaRghd8oyc7Nx3asR3X+OWOHxc2Z+PZtKUKZyeFWA6n8YdHzUuetUa/nAp9Qk10rF
	 RqdY5RG9haHIefY7YX2lZYnHm0tZU+VS4GONUbWFcsOtvdDwRzObQTCP5sySy1SSNI
	 Se3oKyZbeW6bPOtmErwnaJP56g2Jantv9VIc6Kbqj6g95uxpqjHsKvovFIq27aGigL
	 QOnnyxyoCd9mFrnpyR13fY0zL8yEa31hYLBeYVZAGXPo5y8JXRgHhQlijUoIX/7fnC
	 pXixXlimfIS40R1mjBvaimAbms9we6v5m4dHILRel2+WSEj+nI4ASIzfUsd1UjPo++
	 a65dBlgO7Ddx8C+XOFJm/0+onIvCQlwphA+sHY5M9ZbCpBXK1QhnJITDtUw6fhdBmy
	 IOhgrlJ5+kxAZH+AELCebLmphm6to76kBivjg+6tyYDC9ftgmTeV8X0SIecvUVF8U0
	 Dx9Ur1QtbeBGE9dTzFHAkQuiMBV2kvlMdfiIxqSCBuSG2nCWHi+AEa68BrCOX9zqm2
	 hF6w3r/rqexG8rE24n3/OjRc3GXh++YTrWeHWlewEJxPHYw+lNyIs2BUCcjh4xUPCK
	 G4MsDIuJ9rPq+kQnuSRRypJ4=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 771BA40E019F;
	Fri, 19 Sep 2025 14:46:59 +0000 (UTC)
Date: Fri, 19 Sep 2025 16:46:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Dan Snyder <dansnyder@google.com>
Subject: Re: [PATCH 0/3] x86/umip: Fix UMIP insn decoder false positives
Message-ID: <20250919144652.GDaM1s3CVU5KMMFGkv@fat_crate.local>
References: <20250808172358.1938974-1-seanjc@google.com>
 <aM1pNN_ById_l6xR@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aM1pNN_ById_l6xR@google.com>

On Fri, Sep 19, 2025 at 07:31:16AM -0700, Sean Christopherson wrote:
> On Fri, Aug 08, 2025, Sean Christopherson wrote:
> > Fix two false positives scenarios where the UMIP #GP logic will incorrectly
> > trigger emulation, e.g. due to a partially decoded instruction, or on
> > instructions like VMLAUNCH that usurp the register form of '0f 01'.
> > 
> > Tested with the hack-a-test patch at the end, but I haven't done any testing
> > using a real userspace (neither positive nor negative testing).
> > 
> > Sean Christopherson (3):
> >   x86/umip: Check that the instruction opcode is at least two bytes
> >   x86/umip: Fix decoding of register forms of 0F 01 (SGDT and SIDT
> >     aliases)
> 
> Ping on these two, looks like they slipped through the cracks.  FWIW, I wouldn't
> consider these urgent enough to squeeze into 6.17, but it'd be nice to get them
> into 6.18.

Lemme take a look...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

