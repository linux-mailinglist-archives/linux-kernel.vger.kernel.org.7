Return-Path: <linux-kernel+bounces-742235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 338EDB0EEF0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0871C85281
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2833728A1D7;
	Wed, 23 Jul 2025 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uinICt7p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5CE2877E0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264611; cv=none; b=NXw8UXGSd+Z6Aw+RcQaShN5wemzjPKoHw7o2YKNrvFfW32UHKM+h0lSn67zo8iweh8tSIetEiV8Y+HkCR/snxDZM2bJDmfCUGml7Irfsf3i2s8RcXLUm5xGr+mg1CCfO/FKsIgW2Cr7Ji/K+szINNKOo/wUUXCMG7osvdQhD9FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264611; c=relaxed/simple;
	bh=Wxi1092ude1C1z2lJGe0QqyUCPfoDs0y+ewrw1NPNxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAeJ+7WwM/TZoSOjPEm1DdbgCNPjU4VPiKZgyWARPFh4QJjqUjNXWy+TgdRMTeynhwpTOEcYdp0w2OvkJaPGbA/IYywifJRWah4iaKntXoHsf2JmQDlu3czJz8aHFDLSEp7opHZUHoEzxB/gjHU4yWs/allxlP6DDQXDSMQyEgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uinICt7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18FFC4CEE7;
	Wed, 23 Jul 2025 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753264611;
	bh=Wxi1092ude1C1z2lJGe0QqyUCPfoDs0y+ewrw1NPNxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uinICt7poPVpJL/mNRxlpdFi6lPuNzGv2rRk/lChYU0QXvdZSP4wXw9PktE4cgG0W
	 wCX80jl4q5ozoXAySjHFknm0VlTmIdMyvvMIVYJdW3JR+O/1kq2bmLUgdfFJpR1W8U
	 lHU9ZF3t5nxBc9sPn7QoyALSIrbBOQu2usneY+yUI1IuA3QRAQ7sgVbWkhrl8LqCXG
	 rlKKjmdGeG5C2SQXWM+h+C44XVQG+8fAELMv9y/7+sSp+pk0iQr3X016yU0mOtfgAR
	 +IcUFulsdFaMO4W+BidlQwe/PN/bdhm+TcJiYiSMXeKTlvHEmmA0hu7FnsXawnSZE8
	 Xf06jl6ZeT/9g==
Date: Wed, 23 Jul 2025 10:56:47 +0100
From: Lee Jones <lee@kernel.org>
To: "Heijligen, Thomas" <thomas.heijligen@secunet.com>,
	andriy.shevchenko@linux.intel.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Huber, Nico" <Nico.Huber@secunet.com>,
	"michael.brunner@kontron.com" <michael.brunner@kontron.com>,
	"Schumann, Peter" <Peter.Schumann@secunet.com>
Subject: Re: [PATCH] mfd: kempld: Switch back to earlier ->init() behavior
Message-ID: <20250723095647.GS11056@google.com>
References: <71883d70d1b99f58c96ba1b0016751f41519025b.camel@secunet.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71883d70d1b99f58c96ba1b0016751f41519025b.camel@secunet.com>


> Commit 9e36775c22c7 ("mfd: kempld: Remove custom DMI matching code")
> removes the ability to load the driver if no matching system DMI data
> is found. Before this commit the driver could be loaded using
> alternative methods such as ACPI or `force_device_id` in the absence
> of a matching system DMI entry.

You need to Cc the author of this change to give them a say.

> Restore this ability while keeping the refactored
> `platform_device_info` table.
> 
> Signed-off-by: Thomas Heijligen <thomas.heijligen@secunet.com>
> ---
>  drivers/mfd/kempld-core.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
> index c5bfb6440a93..b0ddceae3864 100644
> --- a/drivers/mfd/kempld-core.c
> +++ b/drivers/mfd/kempld-core.c
> @@ -779,22 +779,19 @@ MODULE_DEVICE_TABLE(dmi, kempld_dmi_table);
>  static int __init kempld_init(void)
>  {
>  	const struct dmi_system_id *id;
> -	int ret = -ENODEV;
>  
> -	for (id = dmi_first_match(kempld_dmi_table); id; id = dmi_first_match(id + 1)) {
> -		/* Check, if user asked for the exact device ID match */
> -		if (force_device_id[0] && !strstr(id->ident, force_device_id))
> -			continue;
> -
> -		ret = kempld_create_platform_device(&kempld_platform_data_generic);
> -		if (ret)
> -			continue;
> -
> -		break;
> +	if (force_device_id[0]) {
> +		for (id = kempld_dmi_table; id->matches[0].slot != DMI_NONE; id++)
> +			if (strstr(id->ident, force_device_id))
> +				if (!kempld_create_platform_device(&kempld_platform_data_generic))
> +					break;
> +		if (id->matches[0].slot == DMI_NONE)
> +			return -ENODEV;
> +	} else {
> +		for (id = dmi_first_match(kempld_dmi_table); id; id = dmi_first_match(id+1))
> +			if (kempld_create_platform_device(&kempld_platform_data_generic))
> +				break;
>  	}
> -	if (ret)
> -		return ret;
> -
>  	return platform_driver_register(&kempld_driver);
>  }
>  
> -- 
> 2.49.0
> 

-- 
Lee Jones [李琼斯]

