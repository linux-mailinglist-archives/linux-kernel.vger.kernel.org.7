Return-Path: <linux-kernel+bounces-781783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55424B316B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4250A5A6CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457282F656A;
	Fri, 22 Aug 2025 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kR1Ty6qR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE50C2DCF47
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863386; cv=none; b=XbpifkKQYkLFUewwiv4YMaSL3KKaRks3XtkkRm1DBgpn4MqKZec/V+pDB2RSTSeRy+Xw/2UrJVBnSw8JNbserpX+Yx+ppPMT9/GIOeepIqIYKw4I635UZTd5yesrjcgnF1NmHcZ2aJLQWUclmmt4lH0MTnWma6BLTt67C7B4+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863386; c=relaxed/simple;
	bh=dHH9YPLn4wVeWFb1FvHgDp6/7RNVg60CahvbkhmFxYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFkBOblPM246xydbLhy2vsyNV3ogD6Lu1AMSyUSuMJtj7rF74XzZhSC1wikJqFfkXjftM1KDWBBDbtUp2JiwB836djzfDzcdy1QDgu/uFgkkP5B1j0pzE5mk02B+iPGwhzbqeTAD0zSC+tWjBI1LzQPtpnYOGnn+H78JMamuzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kR1Ty6qR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BAB7140E00DD;
	Fri, 22 Aug 2025 11:49:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CgYhBf2FJT3Q; Fri, 22 Aug 2025 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755863376; bh=sw3urXir574JHPoRBsF3idrTap821okJ/B/kZCWAxmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kR1Ty6qR5nOEKaCkSQiHdUnArEY2H60elG+yyyf8rzi5XAw80I2Zx/QJxg8ugShMU
	 2qtwlX91t/hn+o1pAAZnyYHg7S4orCNVj6iHYrq5hTu9mr45GEG7Qn3bc41zzWfypP
	 dfybF4oo0WpBX6ti/5AehGTucRxkMDZaz6ILUoLHHvcDp1jqlM5nSipSXJ5LfAwuRz
	 ENWRM3AJEp8vecO/dKNhMa9wfsPzlCK4XLOnbH1H1M/3bIecMBDTChXKcBRMe3pzFy
	 bBroHGYa1ULjGxXsqsFHc1vNFOCA5a4rZQDRAnQrPPpR1DZNWqgIu3z8D6nRwl6biq
	 m0W1eEnD4GC+NJiK+v9B2s7GNHX4sk5iB00s1jYVB8RHvD5I1Yww7OKuaaYDhFk8BI
	 vZVT69BuDSan+vkvitfMAOZGDHnEC8rIUYDU5WVVCk8MyT8HgcPTNjHuEMWxvSM2mN
	 z5pv3LsSbtf3yjXKURFjHd6DiZ98v+Ou/kSCAUEroZwpsx5cxneG4av5uSFxDjnGLI
	 QoyBSVxaQsWr2ULF1RxY6olYOJRMYBD/xgVPy0kQQWIVd21t1JN5cHwQziJH28DT7f
	 YEkvbwpJ1VhLqULulwls8OegXJrez3OARl7Qtp9liBKZqOxT8IsbrnIOBYIytF6UGg
	 1nIkm9vVOa76xxDCOsZSBdAY=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C02940E025A;
	Fri, 22 Aug 2025 11:49:26 +0000 (UTC)
Date: Fri, 22 Aug 2025 13:49:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] x86/bugs: Use early_param for spectre_v2
Message-ID: <20250822114918.GQaKhZPrvA7zP33TX4@fat_crate.local>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-3-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819192200.2003074-3-david.kaplan@amd.com>

On Tue, Aug 19, 2025 at 02:21:57PM -0500, David Kaplan wrote:
> +static void __init spectre_v2_check_cmd(void)

Why the separate function?

This can simply go in spectre_v2_select_mitigation() before the switch-case
like with all the others *_select_mitigation() functions...

> +{
> +	if ((spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
> +	    !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
> +		pr_err("RETPOLINE selected but not compiled in. Switching to AUTO select\n");
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
> +	}
> +
> +	if ((spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
> +	    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
> +		pr_err("EIBRS selected but CPU doesn't have Enhanced or Automatic IBRS. Switching to AUTO select\n");
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
> +	}
> +
> +	if ((spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE) &&
> +	    !boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
> +		pr_err("LFENCE selected, but CPU doesn't have a serializing LFENCE. Switching to AUTO select\n");
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
> +	}
> +
> +	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && !IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY)) {
> +		pr_err("IBRS selected but not compiled in. Switching to AUTO select\n");
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
> +	}
> +
> +	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
> +		pr_err("IBRS selected but not Intel CPU. Switching to AUTO select\n");
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
> +	}
> +
> +	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && !boot_cpu_has(X86_FEATURE_IBRS)) {
> +		pr_err("IBRS selected but CPU doesn't have IBRS. Switching to AUTO select\n");
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
> +	}
> +
> +	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && cpu_feature_enabled(X86_FEATURE_XENPV)) {
> +		pr_err("IBRS selected but running as XenPV guest. Switching to AUTO select\n");
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
> +	}
> +}
> +
>  static void __init spectre_v2_select_mitigation(void)
>  {
> -	spectre_v2_cmd = spectre_v2_parse_cmdline();
> +	spectre_v2_check_cmd();
>  
>  	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
>  	    (spectre_v2_cmd == SPECTRE_V2_CMD_NONE || spectre_v2_cmd == SPECTRE_V2_CMD_AUTO))
> -- 
> 2.34.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

