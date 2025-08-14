Return-Path: <linux-kernel+bounces-769337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB7B26D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A461CC5C20
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D970E2566D2;
	Thu, 14 Aug 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MWWY4r3o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jM+h9/xb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3842166F1A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190504; cv=none; b=OmDi7f5TKDdKrCS6F4Zm2BFFqX2O17295jNliCs5KHB8hFTw162lOIA2U0GmWFh+6ZSXFxqvyZ40nfewHrYqOR7Ynj+/ZUpnALnRvde+IFZoGYVUeitST9g3U7KF6avJCrUOu0xLW3ALUOKhnwjgxBwpkBlGii/MofjrwqSxAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190504; c=relaxed/simple;
	bh=Ug/NAMIEPR+4d5XkJUzNBBD/M3uQpciW2zrm0Bctn58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSrf2ajQmSYNedFc6s11IcMHsQmLa6i401aiKkMQ66tpbeeEVEOERNdkqFAMnLvLFMfFkvLToNiJlKDOpc5LCxvWF48Iri6e+t2zd8pdqhgcUv+MZGzxNG7jSi0JpikROlKvgkxi++FEd9VXULV/sygCvM/waEUrQ5cvEbpP9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MWWY4r3o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jM+h9/xb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Aug 2025 18:54:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755190500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/hCTsq0JICB/RLUkOocsBNXmheUQDgRN7dynQWk59s=;
	b=MWWY4r3oWIbO/hvTG07bHB2njMbQBCng6Av1bB0fWYieNzNm00FPluNw1JrLw9OND9jK+A
	dGucYuDWmulXPKjAiI+VVgbysgYtwgTMz+cPci4wfgkQzcGP7q9fzat7Dfzh74P0wHtEPl
	xzbGBiJVC6hIsFaR3AKKnC+HGapxGA4UcSZ2DlGCZPXbErp4GiYv9tPjCktCDbcuuY9LyS
	zTOLBb6a+LIVkL2ltiZqLiibklcDPBs3e+NcDj1Zfb/3B5oNvGKcuT0/OpDXExL5Y3XoLG
	31GJ3tgRWMqNEMdMVQvIay5wtd//a69mJS//Rzyhbd5HggXtuR/rKd1Hk6iOQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755190500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/hCTsq0JICB/RLUkOocsBNXmheUQDgRN7dynQWk59s=;
	b=jM+h9/xbb8Q6kX0mihTp19DYgnLyxGvEceVrrpagEGhPhEMM2uRTHxvcWu8gUDWWoXBHA0
	5GbxJuW3l3CUZdDA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>, linux-kernel@vger.kernel.org,
	Konstantin Belousov <kib@kib.kiev.ua>,
	John Baldwin <jhb@freebsd.org>,
	"<cperciva@tarsnap.com>" <cperciva@tarsnap.com>
Subject: Re: [PATCH v2] x86/bhyve: Detect FreeBSD Bhyve hypervisor
Message-ID: <aJ4U4uhARG_fTCw9@lx-t490>
References: <140183ef0ad52cf0f5f892409d362f1ed09129f3.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <140183ef0ad52cf0f5f892409d362f1ed09129f3.camel@infradead.org>

On Thu, 14 Aug 2025, David Woodhouse wrote:
> +
> +static uint32_t __init bhyve_detect(void)
> +{
> +	if (boot_cpu_data.cpuid_level < 0 ||
> +            !cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> +                return 0;
> +
> +	bhyve_cpuid_base = cpuid_base_hypervisor("bhyve bhyve ", 0);

KVM has KVM_SIGNATURE, and Xen has XEN_SIGNATURE.

So, can we please assign a BHYVE_SIGNATURE symbol to this?

It will just make my job easier when I'm converting all this later :)

Thanks,
Ahmed

