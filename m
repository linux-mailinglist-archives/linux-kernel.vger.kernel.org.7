Return-Path: <linux-kernel+bounces-803564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CA9B46266
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084D0A48056
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD7F2741C0;
	Fri,  5 Sep 2025 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FjnEWZYH"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD0BA42
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097590; cv=none; b=AodnDXYZcusXmluExD8MXt419t/t64DQZlh31R52t5cpYL9A8gAWeYjVsabzEG9z2JVw3sSTCTIoQKyIFGFqvCi856ZJwub18htXG16D3oi5ciSKntfL+gbR3O2/zFXSPEaHYhEeszBYADoWAUJAnNDIgYEGdotKdCa9JsaR6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097590; c=relaxed/simple;
	bh=2KwKtbRIH8vD51Nqf29T9yUXOgwOh7TvroM6Sb5oshs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qijtjVMUvCCfS1zfAu0tCUXm9LVVbeYoouTZGD9P/1RyJvEi1/82T3nguDSSmdfVXxRnazxpwgPOqX+EONH1RxwXomFGWAHrATvdukmOz495KuHYC3NMqsM3cLRzCCSF0M3pBIHJVv7HSCu+uecwoOfYWLH6EeWNtLGNq9oOQfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FjnEWZYH; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 585IdY5W3313075;
	Fri, 5 Sep 2025 13:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757097574;
	bh=mGJBj/GRvOfBT0wlhpAWudAskhOegbCz3cK9dilliCM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FjnEWZYH72JSSKQx+/ZbbVotXU7wwK2hOeViOvs1yKx3vbfZetF59W4meWTMm6iPb
	 WbtIBMat+5WuwxxpKx6n/uxlKASEDvhUKlQZSSQQZ9zHQQnl2Mh9m/aHM763JLAnla
	 UkiKDwTP1Ku62PfmtfQPFI+GIQWvLrlfHVcpZKsI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 585IdXaA1103704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 13:39:33 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 13:39:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 13:39:33 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 585IdWrv862745;
	Fri, 5 Sep 2025 13:39:32 -0500
Date: Sat, 6 Sep 2025 00:09:31 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kendall Willis <k-willis@ti.com>
CC: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
        <ulf.hansson@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <vishalm@ti.com>,
        <sebin.francis@ti.com>, <msp@baylibre.com>, <khilman@baylibre.com>,
        <a-kaur@ti.com>
Subject: Re: [PATCH] pmdomain: ti_sci: Handle wakeup constraint if device has
 pinctrl wakeup state
Message-ID: <20250905183931.qfqnnvmwqqvo3emy@lcpd911>
References: <20250904211607.3725897-1-k-willis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250904211607.3725897-1-k-willis@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 04, 2025 at 16:16:07 -0500, Kendall Willis wrote:
> In TI K3 SoCs the PM co-processor (device manager or DM) will decide
> which low power state to suspend into based off of constraints given by
> Linux. If a device is marked as a wakeup source in Linux, Linux will add
> a constraint that the wakeup source has to be on. The DM will enter the
> deepest low power state based off of the constraint.
> 
> In cases like UARTs, IO daisy-chaining can be used to wakeup the system,
> however if the UART is marked as a wakeup source, the system is not able
> to enter any low power mode.
> 
> IO daisy-chain wakeup can use the pinctrl wakeup state instead of using
> wake IRQs. For example, the serial driver on K3 platforms uses a wakeup

I think this statement will only make sense to someone who's worked on
io daisychain and wake IRQs on our SoCs.
I don't think it's coming out very clearly why wake IRQs are needed for
IO Daisychain in the first place.

You could probably just reference commit b06bc47279919 ("pmdomain:
ti_sci: handle wake IRQs for IO daisy chain wakeups") from Kevin where
we explain whats io daisychain and need for wake IRQ. Talk in this patch
with relation to that patch - what you're doing that the other one
missed.

> pinctrl state to be able to resume from suspend.

Perhaps I am missing the order in which the patches are being applied.
But if it's like the 1 -> 2 -> 3 order you mentioned below then this
reference to serial drv won't really make sense right?

If we're going in the order of applying the series that you
specified, there's no guarantee that the UART patch makes it in
along with this patch, so I'd say let's skip mentioning the serial
driver to avoid sending people in search for how the serial driver is
doing this atall.

In Kevin's earlier commit it made sense, because he was talking about
daisychaining, here we're not. So the 8250 driver doesn't actually have
the changes we're talking about in this patch.

> 
> Devices that are marked as a wakeup source and use pinctrl wakeup state
> should not set wakeup constraints since these can happen even from deepest
> low power state, so the DM should not be prevented from picking deep power
> states.
> 
> Detect the pinctrl wakeup state in the suspend path, and if it exists,
> skip sending the constraint.
> 
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
> This series is intended to be implemented along with the following
> series:
> 
> 1. "pmdomain: ti_sci: Handle wakeup constraint if device has pinctrl
>    wakeup state": (this patch) skips setting constraints for wakeup
>    sources that use pinctrl state 'wakeup'.
> 
> 2. "serial: 8250: omap: Add wakeup support": Implements wakeup from
>    the UARTs for TI K3 SoCs
> 
> 3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
>    functionality to wakeup the system from the Main UART
> 
> Testing
> -------
> Tested on a SK-AM62B-P1 board with all series and dependencies
> implemented. Suspend/resume verified with the Main UART wakeup source
> by entering a keypress on the console.
> 
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 82df7e44250bb..884905fd0686c 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -10,6 +10,7 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_qos.h>
> @@ -84,9 +85,24 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
>  	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>  	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
>  	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +	struct pinctrl *pinctrl = devm_pinctrl_get(dev);
> +	struct pinctrl_state *pinctrl_state_wakeup;
>  	int ret;
>  
>  	if (device_may_wakeup(dev)) {
> +		/*
> +		 * If device can wakeup using pinctrl wakeup state,
> +		 * we do not want to set a constraint
> +		 */
> +		if (!IS_ERR_OR_NULL(pinctrl)) {
> +			pinctrl_state_wakeup = pinctrl_lookup_state(pinctrl, "wakeup");
> +			if (!IS_ERR_OR_NULL(pinctrl_state_wakeup)) {
> +				dev_dbg(dev, "%s: has wake pinctrl wakeup state, not setting " \
> +						"constraints\n", __func__);
> +				return;
> +			}
> +		}
> +

Not much objections to the code itself, as it makes sense that we want
to ignore the constraint for wakeup pinctrl similar to how we did for the
wake IRQ one.

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

