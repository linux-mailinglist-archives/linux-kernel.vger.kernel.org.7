Return-Path: <linux-kernel+bounces-878474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E87C20B57
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D81BB34DE67
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BFE27B4EB;
	Thu, 30 Oct 2025 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX4LsIJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD127A907
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835813; cv=none; b=QlQizHgsCrbECNtNA/PzB9OO92RvO+lxJ+0XoVCVhKNBEDEtshwYXda/+OcL2xNiBdvS+W4XFg+VG2YKQkGq8XmP/Avz42mjamRdquEOvpwck98FTY/PuywsrykbBbkxBDB42+gVhqLuKXBp0O+mHAPVezrUmNHmfycvvq85iXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835813; c=relaxed/simple;
	bh=a2l+lxTcIFw5IJSa8u8l0dTzp3oi3Ag6lOoC7YA2XBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixAaH9GxmJW51i2PerPqUfiMbF4wXuN2Wo3fVmUuUbWOTD/9GdiUbn7Yd4bF9Eu2JeRvj+qPh4I/FTbLj3OFAESho8ayxoN4WKTt9cvjus9Er0tT8nPSY/3Wh/cuESPRIeyHJuXW82gasim0FhYTDJSFBUKG0onSiDXOf/m+mQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX4LsIJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260AEC4CEFF;
	Thu, 30 Oct 2025 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761835812;
	bh=a2l+lxTcIFw5IJSa8u8l0dTzp3oi3Ag6lOoC7YA2XBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iX4LsIJ2OGPvGBF2tKeDBl4+9u+fSdXswdeKVLd/Ip1jXBrzR4M37alug5EdMD4yf
	 u3oSQe0pZQD3+K7TekxfZlpV2i/ElVNGWjJLKx4dIFb0zvr4+bYZPP1Mbt8VV6hqgi
	 bgwCBO1TUwmMEhq+ycgH3a4R7XpaCAuP8xCuUBezQjMJ6yUAAEEdaQILKGoKyQ2ZCV
	 km0IYAQnlUAfnnR3DTOLbuSikojJrpynA20G33dZTz1NUISY34LlqrAmgPVoN3dZ7T
	 GEMpL2CTIB4Fyrs8b/TST7btUl9WkHxSQg20EbDp4AoIc6p4UtzPhYLKf3BgZ7lKmQ
	 oz5xzbbve1+qg==
Date: Thu, 30 Oct 2025 14:50:07 +0000
From: Will Deacon <will@kernel.org>
To: shechenglong <shechenglong@xfusion.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stone.xulei@xfusion.com, chenjialong@xfusion.com,
	yuxiating@xfusion.com
Subject: Re: [PATCH v2 2/2] cpu: fix hard lockup triggered by printk calls
 within scheduling context
Message-ID: <aQN7H7qfXbQSHEjA@willie-the-truck>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
 <20251029034554.1839-1-shechenglong@xfusion.com>
 <20251029034554.1839-3-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029034554.1839-3-shechenglong@xfusion.com>

On Wed, Oct 29, 2025 at 11:45:54AM +0800, shechenglong wrote:
> @@ -1197,3 +1185,15 @@ void unpriv_ebpf_notify(int new_state)
>                 pr_err("WARNING: %s", EBPF_WARN);
>  }
>  #endif
> +
> +void spectre_print_disabled_mitigations(void)
> +{
> +       if (spectre_v2_mitigations_off())
> +               pr_info("spectre-v2 mitigation disabled by command-line option\n");
> +
> +       if (spectre_v4_mitigations_off())
> +               pr_info("spectre-v4 mitigation disabled by command-line option\n");
> +
> +       if (__nospectre_bhb || cpu_mitigations_off())
> +               pr_info("spectre-bhb mitigation disabled by command-line option\n");

Is the compiler smart enough to store a single string for the "mitigation
disabled by command-line option\n" part? If not, you might want to use %s
to avoid wasting memory. (I was going to check with llvm but I'm unable
to apply your changes due to whitespace corruption).

Will

