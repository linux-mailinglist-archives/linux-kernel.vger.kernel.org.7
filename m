Return-Path: <linux-kernel+bounces-769405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B301B26E25
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D546A239E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CE33112A1;
	Thu, 14 Aug 2025 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="azuQEWTM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iKiOxMh4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A724DCF9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194058; cv=none; b=a3U3aaDNOwH18H+A6OtkzUAbNNdYcvoqKCUlLNXLc1Ju2lGtbOljTkUPmklj2NFX0KBoZsUl4EngTxeROuKGMZk6UeA6XfAxkWQnWRXsZJ31aCB6iJwb1eR2c+3wIMC000qpt2RUrrWn+CkhgmfxRZAoKfeGcniAnTXOZVoSAuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194058; c=relaxed/simple;
	bh=nvBpJaJUAQZhRpVLUhmruWz45cVSlE8WvfWyN0heqns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDYb2HuPGzth5zRoy6riS9WfwqV581T1zu1f24ujJ9T7kqtmvTqq0hOgLIlM3djImLrwrswa37BMe20UQ3NEpd6DCE7qaKK7QXuMXpIA7MUtoA5GMpS//vrfmutAOIihHZ+cnpcMM8agngaQA5TNSfafSXS97kSITne8TxGvPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=azuQEWTM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iKiOxMh4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Aug 2025 19:54:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755194054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2dpNfGPXVEnf8RnmmBYr7Vm5AjLGr6/HRcX0++L/Wag=;
	b=azuQEWTMvfSf4Co/2PS5nmMC1cbzFGzk3w4wmG5ka6B4sTtjvlIr3pVGu/j4WLBnymNFG7
	tOHei1foSBUTd3Ft4X3jnW0A3wVq1/TPdycFQ212+OsZQi5nOJi5ISP1r93w/r69Tp/739
	0cn3q4dkASuNl+hXdO5dXgkoEZsFdmgdr6whpwiJ7vtrMHAFZalDSRA+Xzgl6bZsuf0886
	ld5kvb5cnXQrki40fXF6Up6QR9jD896D4kucPDy0yqhkLxKEEReXn9uKhrD50zCnpHDv5J
	8Fa4Af3KxgoNN94I8pe5Xjz1FCBoyje8iRgDKVcFshZXDl8P2DU6Q2Yn+PpDAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755194054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2dpNfGPXVEnf8RnmmBYr7Vm5AjLGr6/HRcX0++L/Wag=;
	b=iKiOxMh4CQj9tejzEmcw6IguLYQnca8oIzhAG1d0sL5KvKr/nlNPKPF0CS+C1gpWm/dc/z
	xinkpF7IKNM8dpBA==
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
Message-ID: <aJ4iwpQOnrc_iN8Y@lx-t490>
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
> +static uint32_t bhyve_cpuid_base;
> +static uint32_t bhyve_cpuid_max;
> +
...
> +static uint32_t __init bhyve_detect(void)
> +{
> +	if (boot_cpu_data.cpuid_level < 0 ||
> +            !cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> +                return 0;
> +
> +	bhyve_cpuid_base = cpuid_base_hypervisor("bhyve bhyve ", 0);
> +	if (!bhyve_cpuid_base)
> +		return 0;
> +
> +	bhyve_cpuid_max = cpuid_eax(bhyve_cpuid_max);
> +
                                                ^^^

You're using CPUID(0x0) by mistake here ;)

I guess you just meant:

	bhyve_cpuid_max = cpuid_eax(bhyve_cpuid_base);

Thanks!
Ahmed

