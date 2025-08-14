Return-Path: <linux-kernel+bounces-768557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09420B26294
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D117BA25B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C237305E3E;
	Thu, 14 Aug 2025 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IjmExy3Z"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DC2F83CC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166592; cv=none; b=vDPHadC5MdDsDY+HkXS+HvGgDkYASOL0VPPstlkm29kg1BAqPTddFgfj/s0nF5HsjlQafNc2ujkbYOxph6JvD31+mYlDGlBsb/JWR6/oPFfu1F+P/dii4hdf/A5kL9y5l4fshQTFFB3l8b8NbnfN59AYiO2oB2SkHcwXFZBvnp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166592; c=relaxed/simple;
	bh=iInUvMAJOYR1AUVLhhuNnrvvDCUD2rIY8rCRRNrTUAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8omKMYmaXmkf/jJqxoz8jl+gpaw3MFjZu3d0SdDu7NGny2wQrU8pJsJeEIBQbNjDyVuut3Thi3OOOrpuZAHhX15RZEw7LXeukYVZj9bEeZOu1nr7mEXeKX93Eci5ZTozgLuVsPxP5yt4+N6penb/tW/XJ/NcxLxmhc6yZE8yJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IjmExy3Z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1175C40E023D;
	Thu, 14 Aug 2025 10:16:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1sDE8-7FaJPw; Thu, 14 Aug 2025 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755166569; bh=TqmTjeKrv7GZkk+j1MftZTbCnq1fh7YF7w0HfuQaoNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjmExy3ZduAzlYsF/AGkp3dSSncm6MHArzwmpM6+ds+826Ax8ugSkcSvaKFf/Ec8e
	 GV+1RJBMTeTJutE9U2oQveMV8fL/c23y2AsmbiIXsgto/vf+m6XkjBGzqA3w/XMggu
	 gOGlZmuEArkZVOnx9OhoKrDM2TiLs6pIuXEmQ6CDzKB50hFZgaqMnH4twIxonwGwoE
	 c8XUcEfyCSGO6WQqxO55wSLe6yiwlqN0YDS+6y3z1BLWSBhe901/MjQ5cCr6ZO+Qjq
	 cfOMVutzuq0JGAk+KzgkEw3MWkk23PtNKT6KTtkU1wrBDSgQpb0X0ZRCoo1nQ1f/MS
	 CkJdFFHKBNXq/94U0CvEMrPTyoGhWPtdIDe2EIqHqQOq7o3SJjKoYpf3c4CuK/kDx2
	 wQNe+DlQI8YI2ZERxdfUUhIxilnYd7DvIaygBDl8aZliBE8vk4IZ31RAcbpjCPTR2Q
	 OtZjrtnXm0ZiNV5qpz8SC4Cu9f6nmkR6S9xz0uIXiATZ7pHLqjSoAZu7tv7LnqM/jN
	 Fd4TIRYKWFGyZbInFml13bQLCgQA8iuQgK8nyJjrhDRzPh7SUbw9gSZ0Vtv53HaIbI
	 pcib8zNxC0iroayD3L+vXtE4Gl5MiGnac9q854sBj8jSCmYVi5BhxcP64+O6xRbJld
	 gMWRSUHiOjOOIXxk75akFaYQ=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3524840E028B;
	Thu, 14 Aug 2025 10:15:58 +0000 (UTC)
Date: Thu, 14 Aug 2025 12:15:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	linux-kernel@vger.kernel.org, Konstantin Belousov <kib@kib.kiev.ua>,
	John Baldwin <jhb@freebsd.org>
Subject: Re: [RFC PATCH] x86/bhyve: Detect FreeBSD Bhyve hypervisor
Message-ID: <20250814101552.GAaJ23WBZ-O3Yuu64t@fat_crate.local>
References: <98dd43553b2d63edd3d994816f378985d1a19d72.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98dd43553b2d63edd3d994816f378985d1a19d72.camel@infradead.org>

On Mon, Aug 11, 2025 at 01:16:42PM +0200, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> This detects the Bhyve hypervisor

Users of this are?

Wikipedia says it already supports Linux :-P

> and enables 15-bit MSI support if
> available.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> RFC because the CPUID_BHYVE_FEATURES leaf is submitted to FreeBSD in

Which makes it, what, 0x4000_0001?

I presume there's an agreement among all the hypervisors...?

> https://github.com/freebsd/freebsd-src/pull/1797 and not yet merged.
> And because I haven't tested this patch at all other than building it.
> 
> It's tiny so I didn't put it behind a separate CONFIG_BHYVE_GUEST.
> Should I?

Yeah, please do.

> +/* Features advertised in CPUID_BHYVE_FEATURES %eax */
> +#define CPUID_BHYVE_FEAT_EXT_DEST_ID	(1UL << 0) /* MSI Extended Dest ID */
> +
> +static uint32_t __init bhyve_detect(void)
> +{
> +	if (boot_cpu_data.cpuid_level < 0 ||
> +            !boot_cpu_has(X86_FEATURE_HYPERVISOR))

cpu_feature_enabled()

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

