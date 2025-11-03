Return-Path: <linux-kernel+bounces-883667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C08FC2E053
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 068574E552C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05DA2BDC05;
	Mon,  3 Nov 2025 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BcAcYKdg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E590C299959
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762201727; cv=none; b=NzoNkyB/paeC59Eltqe5wfpkLP/NDs1DYxdhm/qUowIVP44EUqDi5OkyOs3YA0wcRWbg4ajnBKyWbphkVAAufPhff9Wfw5wH2flPye7PTeQ6D+2g57WWfA3e6LhBF1+QxyP1AsTjOPIdcnqVgisSO8RuV6X8mKDyCTqDLhRLyzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762201727; c=relaxed/simple;
	bh=qd727atB1OpL2x0ZSlhXtPpfLsrLSB86BFw15sStMvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzX/jHHx4lFzSrFQEhSflyNBI1zGR+I6pDJbe/GT5Q7jp6o9lqtxpIUNBtmq3mlUknr0ZulseBCPNa5ENuGKo6VibKNpg6y/kDmiQZVVU/PWNR3LVBuxMVatCabhA0t7fg3C4MOOAkbR0KCZsT5DARA93qpET62NgmroFQOtl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BcAcYKdg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5CEC740E01CD;
	Mon,  3 Nov 2025 20:28:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ycG4P1Q52Phg; Mon,  3 Nov 2025 20:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762201709; bh=hQIvUYw0gP0pec/uFnXuorLvh/LCyF6QamCU1L5HM3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcAcYKdgSLiIiEAfvpW92pdoD2yuywPgDyaHES+bnCa51zicORGdNoxKuVL8YAcu5
	 7g8xJZ2xMt0oxusSY4r7Szk/BEh0X2MwdXDnGbIk8NbOBnqxPfwvDy5y/MBd7gQ/Zm
	 bL0Yxv1jzTpiXWYXcCJun0a5vKBIZ4TBOCjNw/A1Rv5mdmYXrGquSLKS0/w7cUpa/Q
	 x2JCUt1gyAEVmuMXMzEoMlKm1osopoiuEi4O2aRYjt4zumr0qBP+mJkGL4+6RndwD2
	 NdoG7rO2liHKnQI2c7FC/jMS0RFlrdjfJZx5Ar6N++qxwO3IgmCqqI0xJVMpV6ggF7
	 zVP1W8S3BFcbIHAFGGj8qA13rnxhmk+kIawUysg5fTuAwhK2mjEa+5nQrFQ9bCx9OS
	 LkmhacvMLtVMMpt5YoI3KC7JeZqTO1kDXs+I5n+kWnToz/j5UTpfZKoodiLJnH0VIK
	 PjC9SfOu0J6JvbJwnL7dryiiyvLJkTYzPQxig2/DUQXXA2raVpFZ+XAtN97df8Y73M
	 C1CERod5xe4X76INTFYib1Ckge7DnRtJL3x0m/e2z/GGmlpjcNAMiQ5WNHtYudZxYm
	 k+BnbfexbbHV8mBwXOoY0AaT79sKKGDFAg1JqWfpZxJz6SrQTOXftSBSH3TV0eHbd2
	 t81o10ypMnsHgGdrV2XC7EdI=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5D86440E019D;
	Mon,  3 Nov 2025 20:28:17 +0000 (UTC)
Date: Mon, 3 Nov 2025 21:28:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 05/56] x86/bugs: Reset spectre_v2 mitigations
Message-ID: <20251103202811.GMaQkQW54Gml6i1jQy@fat_crate.local>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-6-david.kaplan@amd.com>
 <20251103193130.GQaQkDEquEnEwb_cwC@fat_crate.local>
 <LV3PR12MB92655CEB1AF94875901E700C94C7A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB92655CEB1AF94875901E700C94C7A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Mon, Nov 03, 2025 at 08:10:39PM +0000, Kaplan, David wrote:
> Do you really want it all in one big function?  Or just to relocate all the
> *_reset_mitigation() functions to a single place so they can all go under
> one ifdef?
> 
> I can do it in one big function, but it'd probably look something like:
> 
> /* Reset spectre_v1 */
> setup_clear_cpu_cap(X86_FEATURE_FENCE_SWAPGS_USER);
> setup_clear_cpu_cap(X86_FEATURE_FENCE_SWAPGS_KERNEL);
> spectre_v1_mitigation = SPECTRE_V1_MITIGATION_AUTO;
> /* Reset mds */
> setup_clear_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
> static_branch_disable(&cpu_buf_idle_clear);
> mds_mitigation = IS_ENABLED(CONFIG_MITIGATION_MDS) ?
>                 MDS_MITIGATION_AUTO : MDS_MITIGATION_OFF;
> /* Reset spectre_v2 */
> Etc.

Yap, that's what I thought too.

Since there's no point to have separate functions, the comment separation is
perfectly sufficient, I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

