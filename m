Return-Path: <linux-kernel+bounces-639204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173D8AAF436
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 08:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734494A1ED3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 06:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A9B21B9FF;
	Thu,  8 May 2025 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfrO3N/f"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14621B18A
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746687504; cv=none; b=hkJbTUOpJVIDbOJleioG58Wsr0RsTn3qjEOpktNL7hBjAh6+3ypDVluobBRyb7nx3BmXDR9J7JooNXRMkye5ZOrY+5PeZdtPCQ9QFNmf9SLHdybUP/k/1Prc6ZBbxu6hSUQROyYmZ4Z14G5TbOsCQl3pei3dr4MPMf/529MiVyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746687504; c=relaxed/simple;
	bh=VJ9vgiLvL5luy03Rkp9YKMoIZEMdLMhkY8ReAZNbjsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AolZ22SaKLLnX+6EI43e9D7GwSaNT1HY+Ac62hJQszTj7HCRgcRIpB3tqu4buIwRv2hGd2l2SHYcXVp53ola416Hm5077JArMOn2Dq+HWt+DzUDCzvLKRIe3wMFEU6AJZFn6ai/ptVR4u4sKZCjzf6JdEZUXLgpDwkqy8Ww0xtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IfrO3N/f; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so397238f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 May 2025 23:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746687500; x=1747292300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RvmyVbIxiRkvAgoPeHcaveModR89raMJR6gODE+1nDM=;
        b=IfrO3N/fhE1DC0KrH29++DnQ+Ky2ChpaxFYWJS8h4Lb2uuGJb6734as/CucXqq34Qt
         oqvIOr9lQoqChMqCuInv+B3YPl1RxPvG1hNhYxtC65kT4ogkYwLbSy0BBSB6hNdmfsg9
         8Ga/hrdSLPCYj2u9Hg+GLyLd3H/+/z+DLjcxfP3prKeVEVTS9AocqsKsI7Vgvaqz9B9z
         zVJGb4w3WoEocYygMjBB6ncT63JTfeGo55puYxjBok0pk1wQw5mBvYnKlblcZG4zsCr+
         iwDVpsouQkp/Fs83G6io2r3OlCiKtxTfHLkMaqTSh9YNZM/u0Pf+6KL/Q4EbRQ/t+IvA
         hrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746687500; x=1747292300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvmyVbIxiRkvAgoPeHcaveModR89raMJR6gODE+1nDM=;
        b=r4Erug8T0tJMOJtyXWe3lA9at1LurImtpISpvWAjbQ8UV9UvlOgCkEXvWJVepobwy5
         OPT1ObLNKSxVxGdFBwgOl2LB83k6wJ3BGP8yaCQYblKM173i+ECpXHFbrZTfy76h+Mg9
         1YaxVZsLgxzHeCGThgVYmhhv0OIJzGXBdYTP9JsDSsgLOkfxiAOCSub73IwRMkJzy9+L
         NFdegbkDI3ZNIO6x39rGOxNV6oSryHl1Blsu800DvQJsKBhDPmo5zAtUciYiiBBQDWZ0
         btb71z7Or2Ai7X2xeOMomwpylzuV9fxkK7R55FDaRoY//dotYf/BAR/rabAgAW5dPbJd
         nU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgSWnMqpyvW5KpmjId51M8NDZVdnLeYQbZQApadjUFEuffvlbflKqhcNOmV3OVZJr/U5TMYz8utTGNQYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0AvM+V2y2I4jxZOFWLr1a+CPX0LwlXChIecEQFciN8L5A+pHe
	ubwUGQaX2v9H6a5IborG37RLmYmlpQmSyVJrNpeWl3sComvHQxC8RIOZOI/mGQ==
X-Gm-Gg: ASbGncthS/0u1gel0VbITe3bDU8Xrmdm/zJlxFBoWQFnTpctWUFVxA72elpceYWF1BJ
	UEcfSPLy1knU0Y+3ZhQUFSD3bGJ/yJvfrruBJ10hXG6K9eQ6bfOZFS31i4zhwS08piMVpyplY9w
	sNpkXoiaqOBjb8Dj8ed4uWSDA4p3JRIgG3oFg5Wcgg1v5VUCMTzeIxMo8ZuW4xTk+hmFIKHUrrM
	u2h8LpBbp/XiWNs0xqWxz7TbVFG8UbQIcNk34lfp4L4Qr1HXqYDBa+ZfAyAWqZ5zzlVAG0WmOAf
	YZfBDrUTLtaBYmSW/G7/J6SfWRyKe8uOZhRI5pKrnul1pJus+E2XHyh2DPur+xVrPKiDDJX47PF
	u4jeVx5mZJDqm8afuXHDE1cY=
X-Google-Smtp-Source: AGHT+IE6fY7G6i3QYGrY3X5Ul1LizOf1wK5bHxiH9swb38pg5rW4p838LgWBRNHE0H7wg8cPl2p63A==
X-Received: by 2002:a05:6000:1449:b0:3a0:bc28:e0e8 with SMTP id ffacd0b85a97d-3a0bc28e221mr781184f8f.23.1746687500552;
        Wed, 07 May 2025 23:58:20 -0700 (PDT)
Received: from thinkpad (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b300873dsm6123920f8f.78.2025.05.07.23.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 23:58:20 -0700 (PDT)
Date: Thu, 8 May 2025 12:28:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc Zyngier <maz@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 5/5] PCI: qcom: Add support for resetting the slot due
 to link down event
Message-ID: <fxgmyq7rqgxw2omtkfj4zvzqgbfjhafin3dt2yevs4siwol62w@5cz6pfxixd2h>
References: <20250417-pcie-reset-slot-v3-0-59a10811c962@linaro.org>
 <20250417-pcie-reset-slot-v3-5-59a10811c962@linaro.org>
 <f32b2ece-f7ed-45ab-2867-9d276b88cf62@oss.qualcomm.com>
 <hmyeha6ygi6mxzsdivo2z5ccpvl5l2xietr3axxpl4zwojiavo@wuli4qazg446>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hmyeha6ygi6mxzsdivo2z5ccpvl5l2xietr3axxpl4zwojiavo@wuli4qazg446>

On Thu, Apr 24, 2025 at 10:31:00AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Apr 18, 2025 at 08:11:47AM +0530, Krishna Chaitanya Chundru wrote:
> > 
> > 
> > On 4/17/2025 10:46 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > The PCIe link can go down under circumstances such as the device firmware
> > > crash, link instability, etc... When that happens, the PCIe slot needs to
> > > be reset to make it operational again. Currently, the driver is not
> > > handling the link down event, due to which the users have to restart the
> > > machine to make PCIe link operational again. So fix it by detecting the
> > > link down event and resetting the slot.
> > > 
> > > Since the Qcom PCIe controllers report the link down event through the
> > > 'global' IRQ, enable the link down event by setting PARF_INT_ALL_LINK_DOWN
> > > bit in PARF_INT_ALL_MASK register.
> > > 
> > > Then in the case of the event, call pci_host_handle_link_down() API
> > > in the handler to let the PCI core handle the link down condition.
> > > 
> > > The API will internally call, 'pci_host_bridge::reset_slot()' callback to
> > > reset the slot in a platform specific way. So implement the callback to
> > > reset the slot by first resetting the PCIe core, followed by reinitializing
> > > the resources and then finally starting the link again.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >   drivers/pci/controller/dwc/Kconfig     |  1 +
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 90 +++++++++++++++++++++++++++++++++-
> > >   2 files changed, 89 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > index d9f0386396edf66ad0e514a0f545ed24d89fcb6c..ce04ee6fbd99cbcce5d2f3a75ebd72a17070b7b7 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -296,6 +296,7 @@ config PCIE_QCOM
> > >   	select PCIE_DW_HOST
> > >   	select CRC8
> > >   	select PCIE_QCOM_COMMON
> > > +	select PCI_HOST_COMMON
> > >   	help
> > >   	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
> > >   	  PCIe controller uses the DesignWare core plus Qualcomm-specific
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index dc98ae63362db0422384b1879a2b9a7dc564d091..6b18a2775e7fcde1d634b3f58327ecc7d028e4ec 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -34,6 +34,7 @@
> > >   #include <linux/units.h>
> > >   #include "../../pci.h"
> > > +#include "../pci-host-common.h"
> > >   #include "pcie-designware.h"
> > >   #include "pcie-qcom-common.h"
> > > @@ -55,6 +56,7 @@
> > >   #define PARF_INT_ALL_STATUS			0x224
> > >   #define PARF_INT_ALL_CLEAR			0x228
> > >   #define PARF_INT_ALL_MASK			0x22c
> > > +#define PARF_STATUS				0x230
> > >   #define PARF_SID_OFFSET				0x234
> > >   #define PARF_BDF_TRANSLATE_CFG			0x24c
> > >   #define PARF_DBI_BASE_ADDR_V2			0x350
> > > @@ -130,8 +132,11 @@
> > >   /* PARF_LTSSM register fields */
> > >   #define LTSSM_EN				BIT(8)
> > > +#define SW_CLEAR_FLUSH_MODE			BIT(10)
> > > +#define FLUSH_MODE				BIT(11)
> > >   /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
> > > +#define PARF_INT_ALL_LINK_DOWN			BIT(1)
> > >   #define PARF_INT_ALL_LINK_UP			BIT(13)
> > >   #define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
> > > @@ -145,6 +150,9 @@
> > >   /* PARF_BDF_TO_SID_CFG fields */
> > >   #define BDF_TO_SID_BYPASS			BIT(0)
> > > +/* PARF_STATUS fields */
> > > +#define FLUSH_COMPLETED				BIT(8)
> > > +
> > >   /* ELBI_SYS_CTRL register fields */
> > >   #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
> > > @@ -169,6 +177,7 @@
> > >   						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
> > >   #define PERST_DELAY_US				1000
> > > +#define FLUSH_TIMEOUT_US			100
> > >   #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
> > > @@ -274,11 +283,14 @@ struct qcom_pcie {
> > >   	struct icc_path *icc_cpu;
> > >   	const struct qcom_pcie_cfg *cfg;
> > >   	struct dentry *debugfs;
> > > +	int global_irq;
> > >   	bool suspended;
> > >   	bool use_pm_opp;
> > >   };
> > >   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> > > +static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
> > > +				  struct pci_dev *pdev);
> > >   static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> > >   {
> > > @@ -1263,6 +1275,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > >   			goto err_assert_reset;
> > >   	}
> > > +	pp->bridge->reset_slot = qcom_pcie_reset_slot;
> > > +
> > >   	return 0;
> > >   err_assert_reset:
> > > @@ -1300,6 +1314,73 @@ static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
> > >   	.post_init	= qcom_pcie_host_post_init,
> > >   };
> > > +static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
> > > +				  struct pci_dev *pdev)
> > > +{
> > > +	struct pci_bus *bus = bridge->bus;
> > > +	struct dw_pcie_rp *pp = bus->sysdata;
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > > +	struct device *dev = pcie->pci->dev;
> > > +	u32 val;
> > > +	int ret;
> > > +
> > > +	/* Wait for the pending transactions to be completed */
> > > +	ret = readl_relaxed_poll_timeout(pcie->parf + PARF_STATUS, val,
> > > +					 val & FLUSH_COMPLETED, 10,
> > > +					 FLUSH_TIMEOUT_US);
> > > +	if (ret) {
> > > +		dev_err(dev, "Flush completion failed: %d\n", ret);
> > > +		goto err_host_deinit;
> > > +	}
> > > +
> > > +	/* Clear the FLUSH_MODE to allow the core to be reset */
> > > +	val = readl(pcie->parf + PARF_LTSSM);
> > > +	val |= SW_CLEAR_FLUSH_MODE;
> > > +	writel(val, pcie->parf + PARF_LTSSM);
> > > +
> > > +	/* Wait for the FLUSH_MODE to clear */
> > > +	ret = readl_relaxed_poll_timeout(pcie->parf + PARF_LTSSM, val,
> > > +					 !(val & FLUSH_MODE), 10,
> > > +					 FLUSH_TIMEOUT_US);
> > > +	if (ret) {
> > > +		dev_err(dev, "Flush mode clear failed: %d\n", ret);
> > > +		goto err_host_deinit;
> > > +	}
> > > +
> > > +	qcom_pcie_host_deinit(pp);
> > > +
> > > +	ret = qcom_pcie_host_init(pp);
> > > +	if (ret) {
> > > +		dev_err(dev, "Host init failed\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = dw_pcie_setup_rc(pp);
> > > +	if (ret)
> > > +		goto err_host_deinit;
> > > +
> > > +	/*
> > > +	 * Re-enable global IRQ events as the PARF_INT_ALL_MASK register is
> > > +	 * non-sticky.
> > > +	 */
> > > +	if (pcie->global_irq)
> > > +		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_ALL_LINK_DOWN |
> > > +			       PARF_INT_MSI_DEV_0_7, pcie->parf + PARF_INT_ALL_MASK);
> > do we need to enable linkup again here, since all the devices are
> > enumerated previously, the linkup irq will do a rescan again which is
> > not needed.
> 
> Right. I was trying to keep the irq enablement on par with probe(), but LINK_UP
> is strictly not needed. I will drop it.
> 

Hmm, I just realized that if the device gets removed and link down happens, we
would still need to have link up to enumerate it once attached.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

