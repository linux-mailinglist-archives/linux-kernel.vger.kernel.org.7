Return-Path: <linux-kernel+bounces-843039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FF8BBE46B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B966E4ED1AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889892D29D6;
	Mon,  6 Oct 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y5BUz/Cu"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33AA3770B
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759507; cv=none; b=I2/FVHdpNwtFBnU96rzxze4ApYhobrWk6t4fG8EbXasQuDnA15Hlmjsv0ZIGO2kIwytKAu17/UB/g+JM3nHT4LcF+XLas6x2B/SspQYMeplXjsp6dgOWXHxtRNd9mKIDwmVvyXRRXrB4ZEnglXPqhHkfaeKEyi1lJtXNMt6eDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759507; c=relaxed/simple;
	bh=i716bZB2jFOR9HAlMh2NO5FwyUYT/QsD8Kmp6pPTzig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aan+zlC5aeeM8P21MesLJc/DlwcMbNhG9MVYKYImftYqpp+/bbbusmrL6UT4/s51Fy1G7Ed05+XynY85Z5nRlxtWLKdmI6thB/N7Qq3ksWTPPP5twwUYGVk36KeSwZ2hv5PeDwnydQ0hV95hU5aKOiKxy9mrjL/tyPLeKz5aeyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Y5BUz/Cu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6CF8B40E0196;
	Mon,  6 Oct 2025 14:05:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mxoPHDFv_C_G; Mon,  6 Oct 2025 14:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1759759500; bh=7XTZZ2lgqEkjBqbmTJ9XvScwjjMvvl0+kRTdGHql5xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5BUz/CukPxXVlQmq+p/mMa9PSjjspM2fpSkiGVy0r+8qTOG6bp/VrqeC2hj0X42j
	 BQaZaHlC4uynZ7wgEEnOOPCo9kWP7Zdvf2aFaobFAQwM4SVyeHOBjvFNqZR1x3CCs6
	 Qm1pxSXFEMLuYYuL7JpAFiwd1pvfKJZ5awN4LmUpQzZdZt2qErdL5tM3k9xYCQxa1t
	 iDRNoUBtJWfZv2n9Jnx+JeibxpgdJVHZ6MkQyd3WPPms9DYIZQGdJs4aAKjarrAtlO
	 8cyh27OXJFFD5RSMCc7xmXtbl/Q2gBLyCMQJith6+lfaCirGYkMWY6lbdHrfL772ZL
	 93M/z+JOfLzAtkYwiSmpVWvpMLYMG4J4/xroroCy+i3Ec8/2bSyAYCn4RNDHrTWXbo
	 jQpxKowPoYBVCXxZe0Gf67MFxCnZf4herzex827Gr51jWK1pK2adYUlBNzGzITna5N
	 H/I5VcMZfZvpbNDLLaiBxF/eNdv9r5rIzHE4md9o4mdc6W0D+Vi57zaAJR2Z1eglJo
	 v4Um0g623+D3hGJBi1D4qvp7qKJBx2VUZRydai6ERykIftNjnjSFW+86R74v2aXKX0
	 jSvBDZVzy5oe50ai+FoU8+17Mqc3BtBfFzNZq9ND+0fMwHDZdyQ0au1TAhTYPzf3Pb
	 dnczJocSSnGoGrlOaZ4KzOUI=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E1CC740E00DE;
	Mon,  6 Oct 2025 14:04:48 +0000 (UTC)
Date: Mon, 6 Oct 2025 16:04:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Klaus Kusche <klaus.kusche@computerix.info>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Mon, Oct 06, 2025 at 01:58:55PM +0000, Kaplan, David wrote:
> Sounds rather yucky. 

I'll give it a try at some point and see how ugly it becomes...

> What about just not calling cpu_select_mitigations() if
> CONFIG_CPU_MITIGATIONS=n?  Then you won't get any print messages either I'd
> think.

I want to not compile in that code at all if CPU_MITIGATIONS=off, actually.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

