Return-Path: <linux-kernel+bounces-584518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ABEA7882D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 08:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09193AD8A3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 06:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215BB232386;
	Wed,  2 Apr 2025 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upFT+f07"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD6367
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743575798; cv=none; b=Ie22tHOhUHjl37GeG6OVRG1P+hrdhxhjMu8daYSxGjHZWxDHl0l2yHVrmsMbL+U90k6sLYyrdi3oDXmllKtJ0IJfbvR6k7kQ7EBPpNwA+TG9xDL3byh3Mme5urACd//8GUrtJBspR91X0fH9QHrEFrlrkIU2X0HpKDRlih9r6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743575798; c=relaxed/simple;
	bh=9KYkwa9YJk15TN8slptE6dFITwCH+aL/RFH8C4B55u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzAVFBtsZjDiV0pXPDDnOFp8vuZJ8n9IWqMQ3OUnc3Sx05tvLwBuD+eOMVwbbuBEFSiIBxJfqPSD3tcKLm//UhB9bhvVIt9XqK/dS+cYmpQlzk5AMsAb8EhYwzozI9lUb/LGijnWtBbNjke5Gi16J/MXqRtQDcqWDvuiXieHZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=upFT+f07; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2255003f4c6so115298345ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 23:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743575796; x=1744180596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QBpFdjJKRK2wPZJQzSRTw4eJ4hUT7j61gGfvcZ13EGg=;
        b=upFT+f077M/6VA80GMK93JOTwJoR4oCz1TM9UU/XMFSHpjRM/RAUzg176gX0/OxDXi
         5ZQ5LL+K0mnV9w1s83JlV+whXwxq6Mf2kW0ke/dfqswd1+ZmdZuEiLQ3CxgkrrnOL3if
         7G1YzAiWRdfrtAXJlP1jmiU1PZzmPsdUA+taNmJi38FnF6c4KC6qiB6JS26LJY/sPCIz
         DXzx7C2RN7UbAYNelSyLg2AloDGVFsDio9htVw7IEBRWVvI7Z2D4xxXNy/pvFVyaqcvy
         aGYKGsOwbS0NIdR4giiQdNRrk1vXgz2eikEmwwNx++NpY8yh4y6wQY4+gHwACJfYmaE3
         jDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743575796; x=1744180596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBpFdjJKRK2wPZJQzSRTw4eJ4hUT7j61gGfvcZ13EGg=;
        b=rD+U0HUpVOH5RtYTnlu6AHHPtBVSTs/BzclSfwln/ZfBUqKk4UKHdTrcwQIG2FJizY
         rwTWvcS1vR/1tltr6C5q4bPs1NDkw8hIp9hIck5pHItWdksKaPsTiMlJACuHKrNWyysi
         RFFVoV4P1WCqeQzJInxAhIuheggb9ZVZUalcHR1Xz5lrZ9U84G5v9zLmcvUgncplsOED
         WGH7AHW3dsvune6PG/jM5DbNlG4FCZrStXXd6kKpLdAJuuUCtY88rgnk8KjET+aFGubF
         LuQFI3DVb/ecShfJ5r2IKw9mvJsXSIWieaOY6hHCkaGBkM5ZT+CMyVCRzAT+ppWhnLSE
         fPRA==
X-Forwarded-Encrypted: i=1; AJvYcCVavdZ7NZAnaDxg+kdM/qrKWomzItrbmxMY2VmgmXdNHOtFbP717UZ6UfIcU1fxhGgq/vaMHw3gNxujeEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNYXH3thGjcyFHOke4RV7JvnQG4GvbIoel8LgKau9pva1IF9CT
	VGUFzSUdrW/HPvCE2yDW+i0KBP1uGfj4BckAPUrb3f/mNmfRMCZ2RtbeNq9OPQ==
X-Gm-Gg: ASbGnctLVipilUICJFJ+20XVKO/OC07tl1obWAeeTKXB+KLOiAq2P5bv6eUY5e1A9JN
	E+rDMCma+Menl8QoSlYiW83HF30VEsiAIPQgKEZHkidytPAD4jSF0t7gfW0fNBMfK6BkPkiczPO
	VXUzUY8lgBDAPNWvDquMoQPrC/D9I6Exxs5yvD4AfBbLr+TMPww6BYnR6uVx9cHJChiYGdVRcEr
	eCYT3BekcaBYJOEG24D65gwXlh2lCs6qA0oRwAGDVHzO59aDXWD2wKSGX5TCtAqfQhUHb46Hw2N
	o9VLnDM2ZaoRZykqpSRjRer7/BDcL3dLkG5oApcpe6tit3nXxAKmBPdr
X-Google-Smtp-Source: AGHT+IE6fEQRPpZTuVLgYtn/kGTPJXOscRmOwPKgic6LUNeFQjJDmRybRlM29Dg7FxrNgKq/c8uH3g==
X-Received: by 2002:a05:6a00:1704:b0:736:51ab:7ae1 with SMTP id d2e1a72fcca58-739b60fb6a5mr7052602b3a.16.1743575796230;
        Tue, 01 Apr 2025 23:36:36 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e22356sm10115837b3a.39.2025.04.01.23.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:36:35 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:06:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Message-ID: <fatfobrf53l3ngps3rl67gayhnlsqncgd2tabgcspac3n3o4xt@a4yrmtvaitai>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250328030213.1650990-3-hongxing.zhu@nxp.com>

On Fri, Mar 28, 2025 at 11:02:09AM +0800, Richard Zhu wrote:
> Add the cold reset toggle for i.MX95 PCIe to align PHY's power up sequency.

What do you mean by 'cold' reset? Is it 'core' reset? I see both terminologies
used in the code.

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 42 +++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 57aa777231ae..6051b3b5928f 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -71,6 +71,9 @@
>  #define IMX95_SID_MASK				GENMASK(5, 0)
>  #define IMX95_MAX_LUT				32
>  
> +#define IMX95_PCIE_RST_CTRL			0x3010
> +#define IMX95_PCIE_COLD_RST			BIT(0)
> +
>  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  enum imx_pcie_variants {
> @@ -773,6 +776,43 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  	return 0;
>  }
>  
> +static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +{
> +	u32 val;
> +
> +	if (assert) {
> +		/*
> +		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
> +		 * should be complete after power-up by the following sequence.
> +		 *                 > 10us(at power-up)
> +		 *                 > 10ns(warm reset)
> +		 *               |<------------>|
> +		 *                ______________
> +		 * phy_reset ____/              \________________
> +		 *                                   ____________
> +		 * ref_clk_en_______________________/
> +		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
> +		 */
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				IMX95_PCIE_COLD_RST);

Is this really COLD reset? Or CORE reset?

> +		/*
> +		 * To make sure delay enough time, do regmap_read_bypassed
> +		 * before udelay(). Since udelay() might not use MMIO, and cause
> +		 * delay time less than setting value.
> +		 */

This comment could be rephrased:

		/*
		 * Make sure the write to IMX95_PCIE_RST_CTRL is flushed to the
		 * hardware by doing a read. Otherwise, there is no guarantee
		 * that the write has reached the hardware before udelay().
		 */

- Mani

-- 
மணிவண்ணன் சதாசிவம்

