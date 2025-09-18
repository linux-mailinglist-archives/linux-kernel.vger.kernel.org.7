Return-Path: <linux-kernel+bounces-770640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DB7B27D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E490188EB47
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6A0270572;
	Fri, 15 Aug 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZctfxco"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F29F227B9F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251008; cv=none; b=Xq51IcpjMHsccb+NvksSeVdXORng1C1H66hfa3btWMnrwFsCH+2dBtRTLL0pRcs0j4rzYWCV/uEJpOjtX9BFMons+WDQXCatnCGe+UW6GNqgZbAojPFl/iD1bm4VcYV7hmVj0UMjRTbLQTCtuc+Kg0KGmcGEOmTmhMMYsNQODLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251008; c=relaxed/simple;
	bh=2pTS2cWoGM5QBMr8+Ze0ofqW86cOR5J1fqEoI1at9Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZ424mQZpFlQ2SQvzF3cb3LFKRZcyT3Fs64wFpPaDBqH1q4eqySxw8regaipgD4uziGthBkYvZxaXgNpvBb7nVwAXWvq63gmPQw0q/0w+C7S/0UsjbzTZHMJDypV1Aiuv3p0nZsr6I+IC7PZTo2IJginTCHajpRAEjk7dmNE01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tZctfxco; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61868d83059so4856066a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755251004; x=1755855804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jIr+uIGhy3/hPvKk8/B9PmGr5pRUF0q2I5T786hltSY=;
        b=tZctfxcoKti3pVZAEpLp5Qjk2No0LW4tB/brpVXnb7zZhKwng+9cY9ksGi3h/SBjfo
         zYPHKkqRBhp644rMqEXLILBoxvK37FFYuzh1pRP82wmZ/8r/Fclvh8BosHS5zGnc0VVL
         tSN00U3sAxX6V+H2o3qFCOqDkje+BbN/6m+YaUEZT6wtWEyvqpDy+DynrMBjpkHbNobM
         IdgLlD4DnsbpbitH9uJ7HJjmtMYLwpDGwTwTyXjRb/PXSGnrApoyQykyH+5/VQvegNfa
         OEqeoJjtsdKBVJl6SV02EJ0PC65tWtw4KaJBRkHZeEjo89BtvUwurmYg1F6lQY5MyNpx
         VYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755251004; x=1755855804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIr+uIGhy3/hPvKk8/B9PmGr5pRUF0q2I5T786hltSY=;
        b=sKuwv0TqbJXku2mafYlf5N+Ux3rZJ92XY6ZHghi4M0oZhmHFGM4GQBWynh6ZcsKd5d
         j9xse3VnhI9G0lnEvIXsvZOJ0qd//TA/4d7gIQF7o81tdycxpZr/GuclobRGRgDHhabv
         wbY0Q/Awj8L8akoeLK9Fpl8mP7JgfRMeF6PrEGqkg/CEgIOr++ciiouCeYECZ2T7O/fP
         gFPkjtxjjEMdUbPgZPUfJ+yq+Immv1mbKeN8R/xGOpMvx+Zht0PeC7fVDt0qZMq+t2yM
         O2nSbOrVEQkASXd3Ne2C9/1+x1Ct9az4Q6PYDs3E5rdKw0Ds3kbB23etFmgoyzSMBx7v
         emhA==
X-Forwarded-Encrypted: i=1; AJvYcCXl8JevyQJUzgTb3P+z+XRZJnKdI/8WZFJxC6BRvdFnOa/kg+UJy+ZyH9Fb4UowR8WaOm/dkxylYa3GPh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8EopK/cH9YIpERD1rLSQDoULNCkdPpbEhJy3Dyi6qPu3j182w
	eypbvQlQFj/rdBcX5z9hllwG+V/+dWz8mEhB/WLoU8VgJKf35O7LX0eqH+rgh9Z+Z+0=
X-Gm-Gg: ASbGnct4iFcCLflHG+uH55JasFpV/HfeHZb9e+coIfPH9vqGXdQnTZw4uVrrHONy3Y0
	Eh+K7peqU9JbJqawxawz5CPrRotaNKQe+Ek7bEL+fRNyzavLJt59DRouluzgnWhUfID8MPOpIFL
	jQLrko2Z8sylcC9zyno5EWfYKwzx4zUj3ZqVvOWLCqFkK499awHU7/azxKRc3PpkbkXrLXtWL6P
	qkkvGI/wJ5hgw9swLCxlG1N6tQLj/KWRlLuW2Y5xLicH8aLC/X557sImnvpJSDLR72tnpE6NVpa
	ngahNcuwRhGjYfIbXlJ3DYODL7FStyS4mNaeQDKofYrN8KLX/kOa+PWUIvWxFBGFcz1DIpVtcgl
	1l6NzARHCREmc8dV/8D0Bo414GljZTrnOyg==
X-Google-Smtp-Source: AGHT+IG3FtBw8Sw50EV/ShR8IgGNVLCbfdP5Y/YJBpfd6Jr9H+5a0yrsFxM506Jl/2wK+oZGIgZH4Q==
X-Received: by 2002:a17:906:7310:b0:af8:fded:6b7a with SMTP id a640c23a62f3a-afcbd80b8bemr620525866b.17.1755251004118;
        Fri, 15 Aug 2025 02:43:24 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:68bb:56a:7ad6:2647])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53f37sm105301066b.21.2025.08.15.02.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:43:23 -0700 (PDT)
Date: Fri, 15 Aug 2025 11:43:18 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Wenbin Yao <quic_wenbyao@quicinc.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2] phy: qcom: qmp-pcie: Fix PHY initialization when
 powered down by firmware
Message-ID: <aJ8BNq7NLgYzzOMA@linaro.org>
References: <20250814-phy-qcom-qmp-pcie-nocsr-fix-v2-1-fe562b5d02a1@linaro.org>
 <e5hn42qxz2eqgjanyoxb2456wvuw6zy55ibbg6fh33jma7utvq@mlq2a57owz4g>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5hn42qxz2eqgjanyoxb2456wvuw6zy55ibbg6fh33jma7utvq@mlq2a57owz4g>

On Thu, Aug 14, 2025 at 05:26:05PM -0500, Bjorn Andersson wrote:
> On Thu, Aug 14, 2025 at 11:27:10AM +0200, Stephan Gerhold wrote:
> > Commit 0cc22f5a861c ("phy: qcom: qmp-pcie: Add PHY register retention
> > support") added support for using the "no_csr" reset to skip configuration
> > of the PHY if the init sequence was already applied by the boot firmware.
> > The expectation is that the PHY is only turned on/off by using the "no_csr"
> > reset, instead of powering it down and re-programming it after a full
> > reset.
> > 
> > The boot firmware on X1E does not fully conform to this expectation: If the
> > PCIe3 link fails to come up (e.g. because no PCIe card is inserted), the
> > firmware powers down the PHY using the QPHY_PCS_POWER_DOWN_CONTROL
> > register. The QPHY_START_CTRL register is kept as-is, so the driver assumes
> > the PHY is already initialized and skips the configuration/power up
> > sequence. The PHY won't come up again without clearing the
> > QPHY_PCS_POWER_DOWN_CONTROL, so eventually initialization fails:
> > 
> >   qcom-qmp-pcie-phy 1be0000.phy: phy initialization timed-out
> >   phy phy-1be0000.phy.0: phy poweron failed --> -110
> >   qcom-pcie 1bd0000.pcie: cannot initialize host
> >   qcom-pcie 1bd0000.pcie: probe with driver qcom-pcie failed with error -110
> > 
> > This can be reliably reproduced on the X1E CRD, QCP and Devkit when no card
> > is inserted for PCIe3.
> > 
> > Fix this by checking the QPHY_PCS_POWER_DOWN_CONTROL register in addition
> > to QPHY_START_CTRL. If the PHY is powered down with the register, it
> > doesn't conform to the expectations for using the "no_csr" reset, so we
> > fully re-initialize with the normal reset sequence.
> > 
> > Also check the register more carefully to ensure all of the bits we expect
> > are actually set. A simple !!(readl()) is not enough, because the PHY might
> > be only partially set up with some of the expected bits set.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 0cc22f5a861c ("phy: qcom: qmp-pcie: Add PHY register retention support")
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > ---
> > Changes in v2:
> > - Ensure that all expected bits are set (Konrad)
> > - Link to v1: https://lore.kernel.org/r/20250812-phy-qcom-qmp-pcie-nocsr-fix-v1-1-9a7d0a5d2b46@linaro.org
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index 95830dcfdec9b1f68fd55d1cc3c102985cfafcc1..80973527fafcb294273dff1864828532dab738db 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -3067,6 +3067,14 @@ struct qmp_pcie {
> >  	struct clk_fixed_rate aux_clk_fixed;
> >  };
> >  
> > +static bool qphy_checkbits(const void __iomem *base, u32 offset, u32 val)
> > +{
> > +	u32 reg;
> > +
> > +	reg = readl(base + offset);
> > +	return (reg & val) == val;
> > +}
> > +
> >  static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
> >  {
> >  	u32 reg;
> > @@ -4339,10 +4347,12 @@ static int qmp_pcie_init(struct phy *phy)
> >  	struct qmp_pcie *qmp = phy_get_drvdata(phy);
> >  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> >  	void __iomem *pcs = qmp->pcs;
> > -	bool phy_initialized = !!(readl(pcs + cfg->regs[QPHY_START_CTRL]));
> >  	int ret;
> >  
> > -	qmp->skip_init = qmp->nocsr_reset && phy_initialized;
> > +	qmp->skip_init = qmp->nocsr_reset &&
> > +		qphy_checkbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START) &&
> > +		qphy_checkbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], cfg->pwrdn_ctrl);
> 
> IMHO the "phy_initialized" variable does provide valuable context to
> what those (now) two lines represents. That is particularly relevant as
> the second one is active low...so at least I need to think a bit extra
> to understand what's going on.
> 

I dropped the "phy_initialized" variable mainly because it didn't "look
good" together with the line wrapping of the two new longer lines. :-)

Perhaps it would already help to reuse and clarify the comment block
below, like this?

Thanks,
Stephan

@@ -4339,16 +4347,21 @@ static int qmp_pcie_init(struct phy *phy)
 	struct qmp_pcie *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *pcs = qmp->pcs;
-	bool phy_initialized = !!(readl(pcs + cfg->regs[QPHY_START_CTRL]));
 	int ret;
 
-	qmp->skip_init = qmp->nocsr_reset && phy_initialized;
 	/*
-	 * We need to check the existence of init sequences in two cases:
-	 * 1. The PHY doesn't support no_csr reset.
-	 * 2. The PHY supports no_csr reset but isn't initialized by bootloader.
-	 * As we can't skip init in these two cases.
+	 * We can skip PHY initialization if all of the following conditions
+	 * are met:
+	 *  1. The PHY supports the nocsr_reset that preserves the PHY config.
+	 *  2. The PHY was started (and not powered down again) by the
+	 *     bootloader, with all of the expected bits set correctly.
+	 * In this case, we can continue without having the init sequence
+	 * defined in the driver.
 	 */
+	qmp->skip_init = qmp->nocsr_reset &&
+		qphy_checkbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START) &&
+		qphy_checkbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], cfg->pwrdn_ctrl);
+
 	if (!qmp->skip_init && !cfg->tbls.serdes_num) {
 		dev_err(qmp->dev, "Init sequence not available\n");
 		return -ENODATA;

