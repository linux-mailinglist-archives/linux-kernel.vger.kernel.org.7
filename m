Return-Path: <linux-kernel+bounces-584563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4A9A788A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 09:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049B63AD113
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 07:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A798C2356C0;
	Wed,  2 Apr 2025 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDV2F7Kv"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA3F231CB0
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577725; cv=none; b=g7aqi9qQxKCQkLsko4gd2HRjdGMAs3mfPq252H2cHcy7/j2jztyDNJ8DkUjCUQ06Hba+zYSjJ+1SyxuJAuq7LdDSik8N2ejlXvBLwZ4tyOv5D9Mkc390IH9T+PqUryyVteRbDcEmrdpI3JeIEDDC9ySazop1fE8ZMpNtpLIS7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577725; c=relaxed/simple;
	bh=iwptS4Fiz/t1wRBCwp0WrKM5yTxXoSw3nTT35Pn5ibU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7YyYMEnjsmLnZgxi7LeEYvBSTGML/eCFceNc0ckbObI0EJ/UAiLkp4qXIFYnIvw+cG765kbSzfdmGhuZZWXt3xCyuFQ3sDkJVl/t1ZRCiaPndJxfp9b6EdvzG2F1jMixANQNi5EnSexmcUQ+mzle6XBK0AY9gydTp+z5CUpzRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lDV2F7Kv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224341bbc1dso108010755ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743577722; x=1744182522; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sBLznZWhA5X82bZqkVVLBxnwT0YwdGpBuJ1F1bT4V+o=;
        b=lDV2F7KvOjPTIAPkSRw3NlL+bnl7U+8AQ9E13SxhTTpdKm1KpislvuPwyodPKNib56
         Y1VZ94wmte80fIOzwO3I16QeKZnk0B442GDTViFm9ulMJl9KlXzS09yMyFk51z7t03Ct
         6MgC18denusbKkiRLV/hhVCQD1jqukTBOmTf3dz0ZUWBm4TUjEBWJQsRjzGEKUSkU/lZ
         TqruB3ReVOcr4aVhLaYyCNjFuTTt7vUydTEBj0yTimJkuYkB3Cw0BUle7Pb0AFrUgUVR
         dSXhAoF51d8YEUfY1Mz+2VGQvp8oqSgq1fqqZQoaACUfhDO7twg5YYa8B0WamWO8bg4i
         /k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743577722; x=1744182522;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBLznZWhA5X82bZqkVVLBxnwT0YwdGpBuJ1F1bT4V+o=;
        b=bkXiZXTllLLw1TkHzezqkY38baS4ddBob+POTCGA1ZQP7eDzEL0dMxMdOq0zFJ5Bjt
         qnSJ8Q3vXAABePJO31iINfHRMc3CE62usVEKDuOjmCG4MUtmI6r/QmxMQJyRIy5nQivA
         ekQ7hd317LQZB+Jne1YSa4WUEARZ98UqeCJxMK1tYjscbapOAKd1AGFzdAnaRhImHoTT
         ZHtLf5aldMY5aCnOUUpv4tJHgpsEGLh1vomCSbne6vQJif7/V9LFhKNseeMlVrNlsa1d
         zEl2lEWqFNxO2vgulhOSQv2KUgkFiRfHaF0eo8MoTTHM0yHRkZb12fwsvscZGQrK+zoC
         J5yw==
X-Forwarded-Encrypted: i=1; AJvYcCVo58hoTXXRFzZP7PvRwimhxj07uH6vLTiRSnJ+6aM9YRxey8I5H4lpAdpx0rcr99mmnaqvn8wi3OVmjxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WZ5x/0gbEm6Rmf6zbJXJtOLoY4DDSbrAOSUDZgI2Tpl2eZbv
	R/RBUe+B1tymLGLc3LdFQaCXFOr7MHRJ53gNjfR0Wp0qY+CqjJ8qplNMxyLhqA==
X-Gm-Gg: ASbGncu+hhnUmnh5ez4hQ4mz1spm4f0mrNC6roCDIFz77P0IN4nt+GAhKtchV7UGzRk
	yhwdu6T79SFwIQ3ZNXJbRBHgJ5ThM7YcR+t8fxwy3H5i6o9oAKrEERLjlgf4T7Hq411oTIvSQ2A
	MwYw1CMwWWLHyrLL+1vbk/IKDCl5XYBgcIQVjqZrg5s0rRIwwLNy6S0tAfKwdtCA/Q/Q+a0ejWr
	1hHzMPQueOzJMeg9Os/E88xlMXSV7t8MI+ka7IBzhidDcl9KP9KU6PktgXCn7IINTOtrDDQg399
	xKY3BJHLqcaEX7oDa6xkkrvLomzzcbs+cWTR/zEByX2ROrKGrl/cZwX3
X-Google-Smtp-Source: AGHT+IESAdavvdZhZEPYi8YmhJREn3GzNckInuKrjE2kz7qwPxEfQH3XTifLJZjh/3yYARxtAKubSg==
X-Received: by 2002:a05:6a00:398f:b0:736:ab48:5b0 with SMTP id d2e1a72fcca58-739c78430demr1761550b3a.2.1743577722481;
        Wed, 02 Apr 2025 00:08:42 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970def428sm10236829b3a.32.2025.04.02.00.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:08:42 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:38:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s
 Receiver Impedance ECN
Message-ID: <u2doi5nksovsxf75ahwdr3c3uixjk555mbwouvtblf5rruoicv@uvsdytcwoish>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-5-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250328030213.1650990-5-hongxing.zhu@nxp.com>

On Fri, Mar 28, 2025 at 11:02:11AM +0800, Richard Zhu wrote:
> ERR051586: Compliance with 8GT/s Receiver Impedance ECN.
> 
> The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is 1 which
> makes receiver non-compliant with the ZRX-DC parameter for 2.5 GT/s when
> operating at 8 GT/s or higher. It causes unnecessary timeout in L1.
> 
> Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 31 +++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 82402e52eff2..35194b543551 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -110,6 +110,7 @@ enum imx_pcie_variants {
>   */
>  #define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
>  #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
> +#define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
>  
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
> @@ -1263,6 +1264,32 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		regulator_disable(imx_pcie->vpcie);
>  }
>  
> +static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> +	u32 val;
> +
> +	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
> +		/*
> +		 * ERR051586: Compliance with 8GT/s Receiver Impedance ECN
> +		 *
> +		 * The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
> +		 * is 1 which makes receiver non-compliant with the ZRX-DC
> +		 * parameter for 2.5 GT/s when operating at 8 GT/s or higher.
> +		 * It causes unnecessary timeout in L1.
> +		 *
> +		 * Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
> +		 * to 0.
> +		 */
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
> +}
> +
>  static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
>  {
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> @@ -1304,6 +1331,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
>  	.init = imx_pcie_host_init,
>  	.deinit = imx_pcie_host_exit,
> +	.post_init = imx_pcie_host_post_init,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> @@ -1403,6 +1431,7 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  	struct device *dev = pci->dev;
>  
>  	imx_pcie_host_init(pp);
> +	imx_pcie_host_post_init(pp);
>  	ep = &pci->ep;
>  	ep->ops = &pcie_ep_ops;
>  
> @@ -1812,6 +1841,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.variant = IMX95,
>  		.flags = IMX_PCIE_FLAG_HAS_SERDES |
>  			 IMX_PCIE_FLAG_HAS_LUT |
> +			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> @@ -1865,6 +1895,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX95_EP] = {
>  		.variant = IMX95_EP,
>  		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> +			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
>  			 IMX_PCIE_FLAG_SUPPORT_64BIT,
>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

