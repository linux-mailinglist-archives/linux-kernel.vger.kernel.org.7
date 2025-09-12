Return-Path: <linux-kernel+bounces-814619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA57B55686
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8A83B0F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DD4334389;
	Fri, 12 Sep 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lT0SONck"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CDC2874E0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702718; cv=none; b=gmwF5bMxyV4jygD8Nr18WPyVBJjBMNQYa0L7f/3INOXSgWPPYCN0j9YdxSMhSOel8l1jwuGRp0uzN99olHnbCXIYwYr/7RrKklxWKQ3GW+jeIQX60Dy3ANMyLFDs9+6RyB0SBKClTNKcWFpSzxGkwtcZZRLuYbIYTiYgq/SOWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702718; c=relaxed/simple;
	bh=73MSrdvbsMzhkB0ACXW91EqShcMq9367gKNsVRulJTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMUdennuzkon0N5jQl/YIsn1lf1M6V0NnbwPJ6y5t0Wz8G5NZ3M8Zw4qhEmbw+UQE3J9vpMtaR2jC0BvEbsjIUXQlF2fbxMIAxZNW/bFuzk+j8crDiPrAXTzz+PDkPwYkg+gG+sEuKA0ZvSSQwiyDIBAZyWXtsWRaGKmMka8IcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lT0SONck; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F16E740E015C;
	Fri, 12 Sep 2025 18:45:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uBCRG-EIZWRn; Fri, 12 Sep 2025 18:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757702711; bh=ftjamjFSuKn/Dct4ttVTRYCzeh1BNCYjd56zZqr+/jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lT0SONcksteO/hkTEPOCDkX6wiKDq313BLxXgpyRTWVmio7pM5IEYEK+La8cymOKo
	 preWQgOm7LHJTbBJHwONzv/vmc6yVmCqHOyIzqYT7XuXOsklrZcQQYs2AN1Lsjf2vh
	 Xr2cRoJE4CtvPB7KFkVQkBXpv/oKXIwWqrL+ssRcomTamGJH4luaNK+6PtugVWdsCR
	 KIBucnr7fslxvnOfBpzmz9EVFViK2Thjv4g2OFNqgOQEu9r6tfHD15gcYolHbEbin+
	 Wwdr7hEZvbxlVW4MCqZzZesABnoqgoKNWkHOQMvWgsr/3dGxuoynBzVxMzrW6k+399
	 9aie9dV70KrNqClDaFk52ferOUpEHffA/TzHa1zg/oQaU8rH3JKEzynZixtPegNZFE
	 +Ta7FI4zIh0kKeZGQ+35lwEotmKELNSgbSH0z3VxW8TLW1Bq2LmJtQNDESJ8Vfqtwi
	 ZSDACbqBQ5QBigYop5a0sjrk2AGszc876Gjl2kA1gSyFQonhQ9AOxSccbzhuidFj+3
	 unzDR/kx9xIWWmQoB3soSkrd/ZMUHV00UsHokRX+s0g0nTOxO4V8viKm4qnOYf300h
	 CCDqW1OzUF+umjP5I0aF7rgoV2l1OGJrghpPAauHP5PYH6qFCBJdqdysGbCsW4v75K
	 atyX3ls9K6EaUbgDiLi044cM=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id ADC2140E0140;
	Fri, 12 Sep 2025 18:45:02 +0000 (UTC)
Date: Fri, 12 Sep 2025 20:44:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:x86/boot 10/10]
 arch/x86/boot/compressed/sev-handle-vc.c:104 do_boot_stage2_vc() error: we
 previously assumed 'boot_ghcb' could be null (see line 101)
Message-ID: <20250912184457.GDaMRqKWHDtmhq_o2C@fat_crate.local>
References: <202505100719.9pE7wDfB-lkp@intel.com>
 <CAMj1kXHyVh7KwNyekd8ZAATufnMHyzyMismVf2xW8F=LfBJviQ@mail.gmail.com>
 <20250912182642.GCaMRl4nu7R9C8uP6R@fat_crate.local>
 <77049b07-9e13-4c6a-a7bb-70e9e74a662f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77049b07-9e13-4c6a-a7bb-70e9e74a662f@amd.com>

On Fri, Sep 12, 2025 at 01:34:09PM -0500, Tom Lendacky wrote:
> Shouldn't this routine then delete the line that assigns boot_ghcb and
> instead return &boot_ghcb_page?

Yeah.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

