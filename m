Return-Path: <linux-kernel+bounces-669189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FC3AC9C1D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 19:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21641768A6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD219924D;
	Sat, 31 May 2025 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3t1Y6k/"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA878F4A
	for <linux-kernel@vger.kernel.org>; Sat, 31 May 2025 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748713645; cv=none; b=JxeeIKYnom1FrUlLLoi3Pc+neUinOGskLRUn2w3RIJcl2noNXycSh83pZcqOuMtucZivB5dzC7G7d095oALfhVklcFnlgBVwnwmRAtGVbwrmCEzz+/PcDcVWDE4+tFzTpsveCcovOPwtLHVX8RKiFHqq+FbBNzXZPC1G1kl72Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748713645; c=relaxed/simple;
	bh=rTj2AIRIccwVu0KtTjttNFvLcxNqqZA9tQ/jwxhFYzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKB17CZopISdFE4Fct63Sxo+CYmsetxSkAOleuRp/QRUtK7ah6dsM3SOW0QgK4Feb+t1578yZ67tW1z2o56MQhtIhDxjb6admx8SCZio0PR8tzzpfNirSx6an5h6qACiRaxCgl+zRIz65CayMqNGjuBUOh1jFHxjZzzQpHX106M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h3t1Y6k/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74264d1832eso3318040b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 May 2025 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748713643; x=1749318443; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YBHGQdqSeWvGB9mY6qlXaI9AwWyEpcoU+ydjWvyeZw8=;
        b=h3t1Y6k/qUeH3/OyheL2Qc5U9XXq767CYrkUJh2/0GRhwZ5MIb6iRmmT8Ib1ZDl1Jq
         sYi0cxWlipa/QjkmEjH2YlTwsU1oGeN1PEfFBVpwc7bjDZ2J7Y2qRNm4gzA4TcKPqRtG
         lWhyPlYFI9TCJ30T16vP/JF61LSSWH8ey0NTSCbkJCd3jgUiyj35dB/zH69b7YHG3NXG
         FWIkA9Sct15kcXlEQWpvGrILtN8eVkyElwhmT73Jo3cUeUdr3ELig5uc9j5EZjxHsdGc
         crtZMDITwmggJYgyDa9BgXKZs0ANlCODLu1698n9ybCV6q8lmeMzNt7fulB5Pt6jeokE
         QFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748713643; x=1749318443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBHGQdqSeWvGB9mY6qlXaI9AwWyEpcoU+ydjWvyeZw8=;
        b=vLjEDa+Gv+CPMYeN7jnmd2abbUsRfmvQH4OGhjDVLbW6gtgu4zEfVX3qzf6zx2wUhu
         I1It9qPRCHcq7S/z01ttXGmEOgm/cIBEdHVg6So6jr7xfqoSb2jaansJULrmCUEnyCtf
         kofyEgHaDvkDFoyWHRR1mbISMNstAAz3fvgBklMc1WNmvHQg/yrkT9C1xxC4go2MKO9A
         aeBuTAuwDbIkyCmT239/jNiuxaExFR/Yx/nMeJkrALOY/vgl8X4MEDnZVe75gz+qTAGQ
         q2Bao2R4dID69TD8GK6y5aKR13P18i08c3DqNtT/ljg7tRsozloOzsvpaPWHnnDb2yiW
         zv6w==
X-Forwarded-Encrypted: i=1; AJvYcCWKHfkdX+1v+tl+UgM3Ugq1RkHAkYUZNohjO1BscrdMI/VTJFLOpz3eJnc7vmYE3jWDno7henPi6gx9Onw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUBkVrgb5Lb/Y8HGsKW5XdvZ2CQDgZ/FP4/FmgpURz/gKcAOf6
	50/2NviZ0/ZDP5dYhih6u5zxJAQsEpRbUj4ISQpO9HQc1Z1eBcs+L5uFofyNromacg==
X-Gm-Gg: ASbGncuxRCXLQFAAFtyw+FHE3Eo/Gbb5C4HLM7LtEzRhtInUpt2pi2rMxLAtCgEqyxf
	m9pZHCMvqflxE/Y4oxxxGzde9mLQ4bHW3l8bKY7JWoNzswOsdZhONMB0PbwCJkp2ZWUpuYOGm3Q
	E8B+IYj84I2BG/72ZTI4RJwTdeu/ZUzfPv56WfK3B7ZOg1x6FU5km779Tt8MJrMvFXnO1rDKKnn
	0Ye/eHvPc9Yk5zGD5w3kH5bKYtl4MUScVtVYn2dUxOm9TP9vMFQEhUEWp5r4VfVvPhhPQLmYeZx
	UlpEbJbdYjqyw6qqZPb2KYfrc2sJTM5MK9PJrMRJ4O1bBM5eit4XiuzJU94uldDnXiyBJnwByTP
	emPia5yk=
X-Google-Smtp-Source: AGHT+IEQudPQU3BshE97L4wC1n51Mdqw3QLAzjvyvN2bu8Bm77uJvbC7suQxxrFON6iwO1js+sJc9Q==
X-Received: by 2002:a05:6a00:8d0:b0:73e:970:731 with SMTP id d2e1a72fcca58-747d1ab6968mr3580149b3a.16.1748713642662;
        Sat, 31 May 2025 10:47:22 -0700 (PDT)
Received: from thinkpad ([120.56.204.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affcf6ebsm5018495b3a.141.2025.05.31.10.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 10:47:19 -0700 (PDT)
Date: Sat, 31 May 2025 23:17:13 +0530
From: 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, 
	Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] PCI: dwc: Add quirk to fix hang issue in L2 poll
 of suspend
Message-ID: <tv67nul5owjqywhqmekb2cf5q2acyb3jpcfvz6k62jd6sxd5gv@izy7uomaakei>
References: <20250408065221.1941928-2-hongxing.zhu@nxp.com>
 <20250408145840.GA231894@bhelgaas>
 <AS8PR04MB86766063C3A9E969234779EB8CB42@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB86766063C3A9E969234779EB8CB42@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Wed, Apr 09, 2025 at 02:31:22AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2025年4月8日 22:59
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: jingoohan1@gmail.com; Frank Li <frank.li@nxp.com>;
> > l.stach@pengutronix.de; lpieralisi@kernel.org; kw@linux.com;
> > manivannan.sadhasivam@linaro.org; robh@kernel.org;
> > bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1 1/4] PCI: dwc: Add quirk to fix hang issue in L2 poll of
> > suspend
> > 
> > On Tue, Apr 08, 2025 at 02:52:18PM +0800, Richard Zhu wrote:
> > > i.MX6QP PCIe is hang in L2 poll during suspend when one endpoint
> > > device is connected, for example the Intel e1000e network card.
> > >
> > > Refer to Figure5-1 Link Power Management State Flow Diagram of PCI
> > > Express Base Spec Rev6.0. L0 can be transferred to LDn directly.
> > 
> > Please include the section number.  Section numbers are easy to find
> > because they're in the spec PDF contents, but figures are not.  E.g., "PCIe
> > r6.0, sec 5.2, fig 5-1"
> > 
> Okay, would add them later.
> 
> > > It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
> > > PME_Turn_Off is sent out, whatever the ltssm state is in L2 or L3 on
> > > some PME_Turn_Off handshake broken platforms.
> > 
> > Maybe we don't need to poll for these LTSSM states on *any* platform, and
> > we could just remove the poll and timeout completely?
> > 
> Yes, I used to suggest remove the L2 poll and timeout in the following
>  discussion.
> https://lkml.org/lkml/2024/11/18/200
> Hi Krishna:
> Is it feasible to eliminate the L2 poll and timeout in this context?
> 

Spec r6.0, sec 5.2 mandates L2/L3 Ready state:

"L2/L3 Ready transition protocol support is required."

Also in many places, it suggests waiting for L2/L3 Ready state before powering
down the device. So I don't think we should just remove the poll for all
platforms.

> > If not, we need to explain why it is safe to skip the poll on some platforms.
> > "Skipping the poll avoids a hang" is not a sufficient explanation.
> > 

So the issue is that the device doesn't transition to L2/L3 Ready state and the
host platform just 'hangs'? Do we know why the hang happens?

> > s/ltssm/LTSSM/
> Okay.
> > 
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -947,7 +947,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)  {
> > >  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > >  	u32 val;
> > > -	int ret;
> > > +	int ret = 0;
> > >
> > >  	/*
> > >  	 * If L1SS is supported, then do not put the link into L2 as some @@
> > > -964,15 +964,17 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > >  			return ret;
> > >  	}
> > >
> > > -	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> > > -				val == DW_PCIE_LTSSM_L2_IDLE ||
> > > -				val <= DW_PCIE_LTSSM_DETECT_WAIT,
> > > -				PCIE_PME_TO_L2_TIMEOUT_US/10,
> > > -				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> > > -	if (ret) {
> > > -		/* Only log message when LTSSM isn't in DETECT or POLL */
> > > -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n",
> > val);
> > > -		return ret;
> > > +	if (!dwc_check_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
> > > +		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> > > +					val == DW_PCIE_LTSSM_L2_IDLE ||
> > > +					val <= DW_PCIE_LTSSM_DETECT_WAIT,
> > > +					PCIE_PME_TO_L2_TIMEOUT_US/10,
> > > +					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> > > +		if (ret) {
> > > +			/* Only log message when LTSSM isn't in DETECT or POLL */
> > > +			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM:
> > 0x%x\n", val);
> > > +			return ret;
> > > +		}
> > >  	}
> > >
> > >  	/*
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > > b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 56aafdbcdaca..05fe654d7761 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -282,6 +282,9 @@
> > >  /* Default eDMA LLP memory size */
> > >  #define DMA_LLP_MEM_SIZE		PAGE_SIZE
> > >
> > > +#define QUIRK_NOL2POLL_IN_PM		BIT(0)
> > > +#define dwc_check_quirk(pci, val)	(pci->quirk_flag & val)
> > 
> > Maybe just my personal preference, but I don't like things named "check"
> > because that just means "look at"; it doesn't give any hint about how to
> > interpret the result of looking at it.
> > 
> How about dwc_match_quirk(pci, val) (pci->quirk_flag & val)?
> 

Maybe just dwc_quirk()?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

