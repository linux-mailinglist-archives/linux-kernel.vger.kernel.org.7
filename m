Return-Path: <linux-kernel+bounces-739098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A35B0C1B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBC718C1D54
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7823728C5BE;
	Mon, 21 Jul 2025 10:52:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B35F4F1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095146; cv=none; b=Ec5HzEFdqNGJyIDQiR/4OX47JrrpXe30oMH1aNk1tshdsnj5VBafBImV4An13QMyvzyQt7Hb4oFZ4ZT2GDfbdxtn8zAGxYcsBvpC9iyHK9Ik2PC5KBI65FrVS2ZNq0CtGOSnZt8zwW2Ys+2a8N4aN8uvjyC2JTKD2c6N/dM/8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095146; c=relaxed/simple;
	bh=tA+alFVpzutOzzui/v9OIbhNjy3kmj/gWBZWXWUzNBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQrlild3FdBE3mL5RSWny88Mzs/yoTNePptbmpkjwgMGh6rJd7Hh2PSO6hY1bQp7JOZ99xkSPnwrrX8+YWeNBaK5JWhxDDg0Rf6mxh2cpuMfhV3dBaw9XmMqqVexhgJ4YCEwjIUChrFMz8DTct0Qgi25I/+jrxVq4MA2jRPFdK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E000153B;
	Mon, 21 Jul 2025 03:52:17 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D72B3F59E;
	Mon, 21 Jul 2025 03:52:21 -0700 (PDT)
Date: Mon, 21 Jul 2025 11:52:16 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, ardb@kernel.org, frederic@kernel.org,
	james.morse@arm.com, joey.gouly@arm.com,
	scott@os.amperecomputing.com, maz@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] arm64/Kconfig: add LSUI Kconfig
Message-ID: <aH4b4G2DSxG5FnHb@J2N7QTR9R3>
References: <20250721083618.2743569-1-yeoreum.yun@arm.com>
 <20250721083618.2743569-4-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721083618.2743569-4-yeoreum.yun@arm.com>

On Mon, Jul 21, 2025 at 09:36:14AM +0100, Yeoreum Yun wrote:
> Since Armv9.6, FEAT_LSUI supplies the load/store instructions for
> previleged level to access to access user memory without clearing
> PSTATE.PAN bit.
> It's enough to add CONFIG_AS_HAS_LSUI only because the code for LUSI uses

Nit: s/LUSI/LSUI/

> indiviual `.arch_extension` entries.

Nit: s/indiviual/individual/

> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 393d71124f5d..c0beb44ed5b8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2238,6 +2238,15 @@ config ARM64_GCS
>  
>  endmenu # "v9.4 architectural features"
>  
> +config AS_HAS_LSUI
> +	def_bool $(as-instr,.arch_extension lsui)
> +	help
> +	 Unprivileged Load Store is an extension to introduce unprivileged
> +	 variants of load and store instructions so that clearing PSTATE.PAN
> +	 is never required in privileged mode.
> +	 This feature is available with clang version 20 and later and not yet
> +	 supported by gcc.

I don't think we need to describe the feature in detail for the AS_HAS_*
config symbol; I think all we need to say is:

	Supported by LLVM 20 and later, not yet supported by GNU AS.

Otherwise this looks fine.

Mark.

> +
>  config ARM64_SVE
>  	bool "ARM Scalable Vector Extension support"
>  	default y
> -- 
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 
> 

