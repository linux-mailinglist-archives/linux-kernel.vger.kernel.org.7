Return-Path: <linux-kernel+bounces-788453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AE7B384D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE4137B50E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4868635337D;
	Wed, 27 Aug 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cDUHMnKA"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B3D2116E7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304571; cv=none; b=Qy4orlQr3Vl2KuxvW+afbAit4i5jhfFcTjBiDHoct25IpjMp41NGf6h3k8il2lIR4dn6ktgxTfpHAm5kEfGbwSbPGNQYSiGv0GYqwScO+Nvw889jxb29b8vodbpmTD7Ys8ybSxl9nweG4Q8bHCxwx5bKcRDXT7oOMSin8Ndri6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304571; c=relaxed/simple;
	bh=9TV6nluzVyPCyJQkjetkzrbf9/fjmxk2HrNQh8i8syE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6e94w5A8pLT3uc0TPVu/g0KeShzGBPVz3cZCHz7VP8GddiMSOZMAc547xJsVdA1npz/Sc+h1yEJrAa6PoIXa0rsYwn24SjtPRqyD5oGnw7I+CXiwVoouaE2BzKf7HEQHKGp3n27Qq2iY3ygQMXQ37SAgeZVuSkmTmSibngMViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cDUHMnKA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E1D9640E00DD;
	Wed, 27 Aug 2025 14:22:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BDqRBbx3riuA; Wed, 27 Aug 2025 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756304556; bh=tvbtZ4LMR4rfcWmtdC4pGi2gOgcCmszpMydWRz6/v6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDUHMnKA4dADz/YJ0sZmFj1M5sdmNPPuQafxlcKCQDuNxr+EIv8SEVHAkMpeXaS0c
	 GdTc0iyKvXjlmEYPf1gYchK4Kr1xKwv9j/YLIbst1GGq8H8bmoDlpOvWa1yL4YXk5+
	 fEVfqwH/vCag+vfrQrbmVTFg5NIKQVaJJDjrEmqR4Lo7z0+D7EC82cvyp0CZVsmged
	 yU51oDC74zVw9hlwed8aRJiO4OkUNfk0JCaSx0y2v57Wp5QoxvZ4f0FRgwHYhUN2FN
	 TeiZWgWJhPMe91SXJjofId7FFklpb8Ss00Lp5YEcFCmbHTNtLXZS4KUDmRMGkGdj6d
	 agXW6AD6IJBL1zn7yo44/pdGZxLp8SqzqGRtTysogz07RzBV/B551DZ613Q/+ERzxW
	 Itk0KFgIkUMz6esGp1Uk7MWJZz7GecJ+U/fRKy12GqhFbsnCLegyWWb8/CwCc/GKgr
	 SpbVyewrc+k4IBM4OS7eItsRB0z6Sit4tmW2UzN7nODINXzCTEMdvUngbVPUlwPUt2
	 YDWgsxYih4CF8xDku2wQoX4L/Ml/PG8Y9ckx6OmC0gfikJaHkxEeHQG3wpcopddJzZ
	 NnhvUOwxNMPRrtTQecxp6V/3iclQECB4wgOr8C8AmBHA5yCcrKaMSbOHgechTts0vx
	 TtLxs/dwl0pGkhgLPeZlZ1VE=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 648BA40E00DA;
	Wed, 27 Aug 2025 14:22:26 +0000 (UTC)
Date: Wed, 27 Aug 2025 16:22:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] x86/bugs: Add attack vector controls for SSB
Message-ID: <20250827142225.GIaK8UoYo-rnR9T2OD@fat_crate.local>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-5-david.kaplan@amd.com>
 <7vo33zwvn2wz74fg7wuflrr2gnhlkn7hwaziuzkk7brrp2morh@ltbtredcwb5x>
 <20250827102754.GHaK7dqivnNnQsWGeS@fat_crate.local>
 <20250827110403.GFaK7mIxwsQ9IF7ML8@fat_crate.local>
 <LV3PR12MB92655023C50A92BE30D7A8049438A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB92655023C50A92BE30D7A8049438A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Wed, Aug 27, 2025 at 02:05:14PM +0000, Kaplan, David wrote:
> If you really want to not pick up patch #3 yet, then you could move the
> should_mitigate_vuln() check into the switch statement for
> SPEC_STORE_BYPASS_CMD_AUTO only.  Or just pick up the clean-up patch which
> also reduces the overall code size.

I need a minimal fix which goes into 6.17 now because we forgot SSB. This
patch was my attempt at doing something like that.

Cleanups can then go ontop.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

