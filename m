Return-Path: <linux-kernel+bounces-773901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA2B2ABD0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 736807A73FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC08A2264B0;
	Mon, 18 Aug 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KJEvzW/q"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E9C23505E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529030; cv=none; b=NIO9GYkA0JzZNowBl7ZXZoRqFIZQHvs4cu+4jLpDBKtLYEM99RFhHpJpzqFleK2wEJqxVGTzDT1BJIy8S21Jf2alz+vK4wIU/TiNi5Rp8DSrvWvwtnZkZHoq8hj0a2sn9cDWkXDDHrGpaDhPd6oRDyt2k8bkLMpj9Wb+wT2Fehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529030; c=relaxed/simple;
	bh=LNvE4zpWNqd2iGNmZXznuKyVTpKjjxWo3c8go/svefI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMw20ihvKR+hxq+PI3i0oz8GrGoGYBbighqiD2ejg0WlID2N//B3K5KH0UoIVs/+Np+YqtKd02bV9R2C57cnsHV397GaJiWuzO953iSS10Ib1vsmPq9+DYWfhG0iglRKZ10OmwGrVDLazal5+wLtmtkNvY0k6ehaNFv0oMqrb6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KJEvzW/q; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F253D40E0286;
	Mon, 18 Aug 2025 14:57:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id b5rO5ZouPHPD; Mon, 18 Aug 2025 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755529021; bh=AIAf2EokjAc/oXHY1uqaLGKogcjDtiV+JksDO1o757s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJEvzW/qSKzkgQ06SAf6VOQkD8BC6OPhWKA7+VlnGSCtrJVObZT9IK1ziRRqg/Acr
	 r9cYDeDelKY6LpUqpHh4QQ9t5s4yx/J3OBMHjXGew2iF3Z02WJcDOORvjwlQ8cLTS4
	 nOpNgeY4I3dIQozWTVb9UBlJob5qLjXGfelkamq57KUAx+JOiBno9wlbwwyJU3dpSO
	 ShCOiircmYGZkySmJiwEg3HWr/RHw5WSlbV97ffCNbyBigp4XuVuZjkiwFvn1ZoSVG
	 /BflgYOvIw8R+kEgLXTjKGmCK92ZkD4blxX+TLSweleYPDeoaMGSM6l7A6e4aQk/i/
	 4p6hK+RhZUak+H/EMtlbV8CaI4fnVFT/QSPy08GhrHjyWvueNk9jx2E4u/Wxsc7OIP
	 9MtTDt8cBRiyYdujttG8YrT1hKn5TWLLkGbjspbsBW3kgabEgkpvyuVtjhLA/dvAS7
	 3hHcFkOFSGJtDjDo9jz9XoDsY2BbkhySb3KqsE/y6RJO2/wJomtzb77bjACDV1kalR
	 crn4rgp5/lhj798HbVXNRnzL/mEqFB9cTtXMO/yg7ikajKYocINSXGeCqksXgK1Lz2
	 miriAtQlIbZJsG7GP4fYFZrdXpC9/IIUXo1Bp8baF6xI5qu3zQoD14qz7Ye+rVEEJ+
	 Yt8mbx834XeJR6YiUUW4p00c=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3642940E023B;
	Mon, 18 Aug 2025 14:56:47 +0000 (UTC)
Date: Mon, 18 Aug 2025 16:56:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/34] ASoC: Intel: avs: Include CPUID header at file
 scope
Message-ID: <20250818145646.GGaKM_Ltrggbwkj2TB@fat_crate.local>
References: <20250815070227.19981-1-darwi@linutronix.de>
 <20250815070227.19981-3-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815070227.19981-3-darwi@linutronix.de>

On Fri, Aug 15, 2025 at 09:01:55AM +0200, Ahmed S. Darwish wrote:
> Commit
> 
>     cbe37a4d2b3c ("ASoC: Intel: avs: Configure basefw on TGL-based platforms")
> 
> includes the main CPUID header from within a C function.  This works by
> luck and forbids valid refactorings inside the CPUID header.
> 
> Include the CPUID header at file scope instead.
> 
> Note, for the CPUID(0x15) leaf number, use CPUID_LEAF_TSC instead of
> defining a custom local macro for it.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  sound/soc/intel/avs/tgl.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)

I'm guessing that:

https://lore.kernel.org/r/aGv8AWwHbi5seDxi@lx-t490

still needs to happen yet?

Because I don't see it in this set...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

