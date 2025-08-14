Return-Path: <linux-kernel+bounces-769165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4C5B26AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1369189ED48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B03A215062;
	Thu, 14 Aug 2025 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MRHyPsQu"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A85191F91
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185173; cv=none; b=m56r5gepyENj6kX5sh3Mc93923ghIhGOdUtXQjvPDyjAxiWKF8cEskI3H+hOmuZ7UMrIgXJmyQDiYQYw5CvPc8lwj0lNIZFZXYTSVNhi5MhIOlfrxtijg4pPLKSoxfHiWoSs5Em5Ku07el441zMNTbUjAhcFPpSbtNWXkkyKGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185173; c=relaxed/simple;
	bh=CwSoSBe+cn3v30dVZLiZarZJizto/erzOZ11w6iQusI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GD1JBJPZWET+1HH2YuYIXoYlXbOgR/2IMhLlgDyLiTshaG59BVDshnKUNBmmnX9yAhFppdbh74WPQcN5rFyhBI9Mmof+8q9Bh1Lr+f6pgIeCrPA2Sp4Gyhx9J9eiZPcs+Dpqe7Yppt7L78pDgfTNqnCHrU9nmiAU1/1IMr2pr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MRHyPsQu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3BDC740E0217;
	Thu, 14 Aug 2025 15:26:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LVyVHPsXXvWb; Thu, 14 Aug 2025 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755185164; bh=nw2ymgBzS1YqIhKd6bQn6hXxsLYlfrBPgNbJFqVjBH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MRHyPsQu8Sn6uyzxG5R1EzD3mSugQcQD7A7ce+cYmy0CAFTdDE/2KGL0IA7Fzclj0
	 ecmU3zwU10puXsRfVmqcXOdcaQpPq2H37N06r6REc2lMuHXTC+GVATTrfVruKiRYEY
	 E2k0yoDUtydEmqHJKt2NHvElwFXHjTwRiWv1zvR/ABRp+G82NWi5JuYrJwGFS0/GGq
	 GmgG9kKIksXSXDYvdlB1NbokKQHA2aDkLs85/Q3XO8FxB8JC7dg+zRKKzoF/OMkWe7
	 daxTR70rdk3bMSTlNHrGwuRG070CWdtjeCXFT7qzcITwhtM7omNNQNy6g0+y3ysfcn
	 4v11hMdizLFMvBI+R2QrZ+U5TvNrOpTkin9cSQ8Scq+Cmj1Za+SkPU56OyRfxTDJ/z
	 +eZAmXNmF3D0er8vJj7jvu1c95Ftho/CHHs4OTP3ErI4exMexdw3tdVIR76diD/2Ie
	 o/HGOE6mAZt7DUUNLTfKXRIJwlosZy4nlobHpVD+xNe8Qs+NEdPlgHQmEUpZ1KsELm
	 LHV/GWZSMOAcPzl8NHTmJaBbYyhO0QVIKE7VgfQtYEKoz4tm/+SqF7hY5baO3fBF6E
	 T3X6g9Y7S8QEzoSG80tMB6MR6nHEsMojCzKyt47CJ7Hj+Dk0FyovHSYzYuWL9Kdx1k
	 0jDpvED8MaKLMnGVTeoucWvU=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B3F540E00DE;
	Thu, 14 Aug 2025 15:25:57 +0000 (UTC)
Date: Thu, 14 Aug 2025 17:25:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: Stephen Horvath <s.horvath@outlook.com.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tsc: Read AMD CPU frequency from
 Core::X86::Msr::PStateDef
Message-ID: <20250814152550.GAaJ3__hIHnOBhKGWN@fat_crate.local>
References: <20250813112020.345622-1-s.horvath@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250813112020.345622-1-s.horvath@outlook.com.au>

On Wed, Aug 13, 2025 at 11:23:38AM +0000, Stephen Horvath wrote:
> +	/* The PPR defines the core multiplier as CpuFid * 25MHz */
> +	p0_freq = cpufid * 25;

As someone already pointed out:

PPR Vol 1 for AMD Family 1Ah Model 02h C1

...

MSRC001_006[4...B] [P-state [7:0]] (Core::X86::Msr::PStateDef)

...

CpuFid[11:0]: core frequency ID.

FFFh- <Value>*5
010h

So we need to do per-family checks here.

Not sure if that is worth it, frankly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

