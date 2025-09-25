Return-Path: <linux-kernel+bounces-831569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DD6B9D0A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832001B255DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB212DE71D;
	Thu, 25 Sep 2025 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsIGJwfX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5853E78F3A;
	Thu, 25 Sep 2025 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764287; cv=none; b=bg2v9OeR8imDMqwMnAuN1k9D3SifM0Fdm1XzSUsC1pz13JpADnP1A5EjOJNqjpIKVZZjzVxR3W6RcVq68mDq0V+aLfRl5t2Bs/eqV9BjWUWYqzCS1YV/msh9d8tlqtD2w/0i6RtYwVJm9c/hUjMFh2wUrAkVBf3WRNnhhbhNXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764287; c=relaxed/simple;
	bh=R56JQo7sMGCvl44O1tarkNLRb1ITcNAK6pzLL40GZZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV+KUGBt7YEXr3kYq9PxB0nRRJIOZkCeGL9bCFYBlALJ7I1unZIvqM4DUIPX/WeDTcdZyyE/acMoWW7gdQg8JuH3JP6ij3WQW5B3OgaadCaINpI7hdcKHygsHyq/qph6gcpsuYizw8gyK77Skxncw5L8kstlxjynSbKJAy7BfWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsIGJwfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED217C4CEE7;
	Thu, 25 Sep 2025 01:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758764287;
	bh=R56JQo7sMGCvl44O1tarkNLRb1ITcNAK6pzLL40GZZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsIGJwfXVGGILnvr3bZSJVeaPojWCRzGfd0hPeRv/MJD568JGvSE0713/ssJUQiiC
	 mHwNJzzsv92kQOdsGzjRjvI/yZWUxvEoyh6pgp8szk1Dd77UIGv+JehwtsdXuIA0HN
	 ZKNtJaVTfm8bSIDeCY0theuEY5UbK53ypzuDvOK549niBPj8EoF3f+wjvzRTDfn1ob
	 7IS2tbLwKaQXK9iKp2gXgj7b49NZm5O6cYzpcPc+6XDGqQw4ed6lELIu04QMQWOBGC
	 Ky0OV8IunuQOU/f8YIfcw+MdgkUnSpiBUKRh43yPE9J28y2xx74buqybdkxzJo1FqK
	 Vt5hBzx3jfsqA==
Date: Thu, 25 Sep 2025 09:38:02 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, peng.fan@nxp.com,
	jun.li@nxp.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] usb: chipidea: imx: add USB support for i.MX94
Message-ID: <20250925013802.GA3106023@nchen-desktop>
References: <20250919071111.2558628-1-xu.yang_2@nxp.com>
 <20250919071111.2558628-2-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919071111.2558628-2-xu.yang_2@nxp.com>

On 25-09-19 15:11:11, Xu Yang wrote:
> Add new imx94_usbmisc_ops for i.MX94 due to it has same wakeup logic
> as i.MX95, but it doesn't need workaround for ERR051725, so pullup
> is not needed.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/chipidea/usbmisc_imx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index b1418885707c..bb027d2bd700 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -1224,6 +1224,14 @@ static const struct usbmisc_ops imx7ulp_usbmisc_ops = {
>  	.power_lost_check = usbmisc_imx7d_power_lost_check,
>  };
>  
> +static const struct usbmisc_ops imx94_usbmisc_ops = {
> +	.init = usbmisc_imx7d_init,
> +	.set_wakeup = usbmisc_imx95_set_wakeup,
> +	.charger_detection = imx7d_charger_detection,
> +	.power_lost_check = usbmisc_imx7d_power_lost_check,
> +	.vbus_comparator_on = usbmisc_imx7d_vbus_comparator_on,
> +};
> +
>  static const struct usbmisc_ops imx95_usbmisc_ops = {
>  	.init = usbmisc_imx7d_init,
>  	.set_wakeup = usbmisc_imx95_set_wakeup,
> @@ -1481,6 +1489,10 @@ static const struct of_device_id usbmisc_imx_dt_ids[] = {
>  		.compatible = "fsl,imx8ulp-usbmisc",
>  		.data = &imx7ulp_usbmisc_ops,
>  	},
> +	{
> +		.compatible = "fsl,imx94-usbmisc",
> +		.data = &imx94_usbmisc_ops,
> +	},
>  	{
>  		.compatible = "fsl,imx95-usbmisc",
>  		.data = &imx95_usbmisc_ops,
> -- 
> 2.34.1
> 

-- 

Best regards,
Peter

