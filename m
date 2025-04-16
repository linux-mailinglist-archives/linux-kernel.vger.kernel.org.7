Return-Path: <linux-kernel+bounces-605702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E24FA8A4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 19:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D10B17F5DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BFC1F5619;
	Tue, 15 Apr 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t1kNm8gO"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163D21A945
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736837; cv=none; b=RNoOM5Lf2rhJddYCHdZfaEigHS41hZH+eAgBV8vbi9IZbyOweLjlJ2NLkwYzNHOK+1J++xK/VHFNM66tmTvPLW30Z1CpN6hqxS/GLUT4DqSguWUDBwegM+5lI2+87gCv2kMVh4D/qGl7KYImRSdy1h9S0hCWVKEh4nPZ/ZULKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736837; c=relaxed/simple;
	bh=SukwUDHYIRdmSk7/ML2jEOVgTI1uj6xl2M7cIlD5YiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkSvpevwhTSH1KWy5vghQ06i7Ai0uFTDphtm0N5VHpmNsH+kEOwH4LGSfZEyO6dm0Mr6YcaiwWDN30uVXLFAfQOAM1L7MCa/KUqae8GGtGCWcxOtjoRtglhH5HOZynfwlluYk5Ak4fHkrhijwd16tXD+KFkaK/Sb4U08dhIi2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t1kNm8gO; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 15 Apr 2025 10:06:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744736821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9c/jqs0ImTq23JWKqJ6pgYTsopt6CaO9c3noHLUB4W0=;
	b=t1kNm8gOBoKSdP89u+A7EqbQrPcqmy3FSsr20RSggxMlDMceadc1SOwc3wxueBIeHEFgQb
	1pUp4ktDIRycIBlsGuHyc8X+c29lVHjM5bUsiHKMcq4dLuWV4X6GDZqkFS1n7vHKBz90y7
	+HXBR0DmYT9IVl99GPClah6fjMSTe9c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: D Scott Phillips <scott@os.amperecomputing.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	James Clark <james.clark@linaro.org>,
	James Morse <james.morse@arm.com>, Joey Gouly <joey.gouly@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shiqi Liu <shiqiliu@hust.edu.cn>, Will Deacon <will@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: errata: Work around AmpereOne's erratum
 AC04_CPU_23
Message-ID: <Z_6SKjdvje1Lpeo3@linux.dev>
References: <20250415154711.1698544-1-scott@os.amperecomputing.com>
 <20250415154711.1698544-2-scott@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415154711.1698544-2-scott@os.amperecomputing.com>
X-Migadu-Flow: FLOW_OUT

Hi,

On Tue, Apr 15, 2025 at 08:47:11AM -0700, D Scott Phillips wrote:
> Updates to HCR_EL2 can rarely corrupt simultaneous translations from
> either earlier translations (back to the previous dsb) or later
> translations (up to the next isb). Put a dsb before and isb after writes
> to HCR_EL2.
> 
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> ---
>  arch/arm64/Kconfig              | 13 +++++++++++++
>  arch/arm64/include/asm/sysreg.h |  7 +++++++
>  arch/arm64/kernel/cpu_errata.c  | 14 ++++++++++++++
>  arch/arm64/tools/cpucaps        |  1 +
>  4 files changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e5fd87446a3b8..2a2e1c8de6a16 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -481,6 +481,19 @@ config AMPERE_ERRATUM_AC03_CPU_38
>  
>  	  If unsure, say Y.
>  
> +config AMPERE_ERRATUM_AC04_CPU_23
> +        bool "AmpereOne: AC04_CPU_23:  Failure to synchronize writes to HCR_EL2 may corrupt address translations."
> +	default y
> +	help
> +	  This option adds an alternative code sequence to work around Ampere
> +	  errata AC04_CPU_23 on AmpereOne.
> +
> +	  Updates to HCR_EL2 can rarely corrupt simultaneous translations from
> +	  either earlier translations (back to the previous dsb) or later
> +	  translations (up to the next isb).
> +
> +	  If unsure, say Y.
> +
>  config ARM64_WORKAROUND_CLEAN_CACHE
>  	bool
>  
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index e7781f7e7f7a7..253de5bc68834 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -1142,6 +1142,10 @@
>  	(IS_ENABLED(CONFIG_AMPERE_ERRATUM_AC03_CPU_36) &&	\
>  	 __sysreg_is_hcr_el2(r) &&				\
>  	 alternative_has_cap_unlikely(ARM64_WORKAROUND_AMPERE_AC03_CPU_36))
> +#define __hcr_el2_ac04_cpu_23(r)				\
> +	(IS_ENABLED(CONFIG_AMPERE_ERRATUM_AC04_CPU_23) &&	\
> +	 __sysreg_is_hcr_el2(r) &&				\
> +	 alternative_has_cap_unlikely(ARM64_WORKAROUND_AMPERE_AC04_CPU_23))
>  
>  /*
>   * The "Z" constraint normally means a zero immediate, but when combined with
> @@ -1154,6 +1158,9 @@
>  		asm volatile("mrs %0, daif; msr daifset, #0xf;"	\
>  			     "msr hcr_el2, %x1; msr daif, %0"	\
>  		: "=&r"(__daif) : "rZ" (__val));		\
> +	} else if (__hcr_el2_ac04_cpu_23(r)) {			\
> +		asm volatile("dsb nsh; msr hcr_el2, %x0; isb"	\
> +			     : : "rZ" (__val));			\

At least from your erratum description it isn't clear to me that this
eliminates the problem and only narrows the window of opportunity.
Couldn't the implementation speculatively fetch translations with an
unsynchronized HCR up to the ISB? Do we know what translation regimes
are affected by the erratum?

Thanks,
Oliver

