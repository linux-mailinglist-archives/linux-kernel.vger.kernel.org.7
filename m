Return-Path: <linux-kernel+bounces-817208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6C1B57F41
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91ACC7A93AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2EA329F36;
	Mon, 15 Sep 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DY6NJfYy"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622726B97E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947172; cv=none; b=KCB5gHCCEvoTgiMFzc2phLsxdB3vtc7zWX/EAOoH7Kh/cevtHXHNgU+V5wmakj3Xh/ML/3WiBG8jl4nrG9S6Kmrsruo8aSc21ufmtcIRi4plEjz7PartRPJpAXrCLA4oF1WobaIvNQG10BbbYYShKuO3EeX6RjJBoml7RY05S58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947172; c=relaxed/simple;
	bh=/UzLQJAqsQ20oZpcrvVtig07k+dbEdhwy0rxuKQNspc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0iMtgiDm6ptsG47y6MOBRV0Ar1/i3b3G3bc9R0nxq0Ktq53uHXlldRhfusvEPhwK4QAaWHP6ip3GFbG48hReRFqbHj/sfAwXC+Uia+aNxSuRyz8d5yukyDEd7mZlEY+1xUOEc8NIQr0n/HRcM5A36GXj9BZOO9VPxMJY1V1Z1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DY6NJfYy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6FF6A40E019E;
	Mon, 15 Sep 2025 14:39:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ovMTX1tMk3Lz; Mon, 15 Sep 2025 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757947164; bh=uz2esuv3kCBRjR335a/wuf/S3sBiFeFoPIAa2U7UJnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DY6NJfYykqnONBYf28N/ZwsHm1MvRACJQnraawir0VyCzeXDGMtLUUTiLelKDSVE4
	 Vsw2bYtu+YH/6geblph93SoYrWaFLZft2GGbP8qXTDj6AlgwFJQ4VcCBwOBEV1EW/F
	 MQ+U+9tmoEC7f/4MlCFdXZ1ZgXe22m0TacvDBLtaYGl0Q/gqMh6k+1m0Ha3l6GuZ3P
	 NFFTNtE01KYl1WwTAyTUzU8iV9f/zUe1l1i0xSnWNXNs6zQMlRoVbUrsEk5PM4cfYT
	 SvU3NzIPNyklpiuB9HgHGNuSVYD/h0pNloFdsnLqwHyJX0JirA9zoE0kZtvw9mxCk7
	 cMMzBjDAirvggPKz+/MbAObr+djr4Il9XPmBh8IsVm4lCjh2XlYWnzBV4zN4myVbjk
	 HEA0JdS3qfF4RD58Q9P6fF4lUTj0sTULBMOqu8Vemg7Hl2BlK2RvZwTrdMGVEWdv48
	 RNof0boxYpdD6udwEpCDGmjOpudGuICBl4DOBuaqYEfwh28uAIRfXblGa2YCUN3Kqe
	 JlwBiuCrR46TpPjKI5Zr9a1Xq6ecmJSIAmRCSalMOnyd7+NVXmrxXQ4jIvYyRPtb4C
	 65dI/zv5H4+GMq9Tm86qFdZq8DHV7O9t6wbAPmWrIr37+iNYqfu2D7Xnl3qTH8GJXo
	 2L2nF1sil+CdQcpsbG9VIrLc=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 84C8740E0176;
	Mon, 15 Sep 2025 14:39:16 +0000 (UTC)
Date: Mon, 15 Sep 2025 16:39:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Petr Tesarik <ptesarik@suse.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tsx: Get the tsx= command line parameter with
 core_param()
Message-ID: <20250915143909.GAaMglDd5oRSPDDuqu@fat_crate.local>
References: <20250731083433.3173437-1-ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250731083433.3173437-1-ptesarik@suse.com>

On Thu, Jul 31, 2025 at 10:34:33AM +0200, Petr Tesarik wrote:
> Use core_param() to get the value of the tsx= command line parameter.

Use early_param() pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

