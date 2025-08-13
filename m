Return-Path: <linux-kernel+bounces-766620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 138BAB24921
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7501882D42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCE92FE57D;
	Wed, 13 Aug 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqWy8mou"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75672FE570
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086646; cv=none; b=cMq50WwOpZnShD3Yw/ggDp9++U6oHggpPpgsjwZeANBGahDyukhxSzL17UivHEn65NtCTO0HSHgMhgusRSogFBNjApprzzPXMZhBYkCpr9ZPs2OulA7Ay4n2HqxYqLlQSjIV3bBOz4P1IZmWjL/MyppBhg42W9PSOvWmsKc2nho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086646; c=relaxed/simple;
	bh=E1zf7JRhuUmQmJ5aAtAXCyObx6AGyK+Lp83DOnB+owY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouq/CJXy9sbMa178ym4OCfOP8GoM0o9h+x/CllT+O79YOSm4HKPaG18Bl2ksX860os7CrMFWSy9ckgTnaqoU0Nai4bdymUMTIuNNhMi7Hze540QMkJXEvlSOa7+1ObGD/noq6Z9PLvDpscqALUMeehH+nnwu7XffVwi4LJ6IgDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XqWy8mou; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so43865085e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755086643; x=1755691443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFJEM6gKLS8APrjgYw576J/ohlNo10MJL9Wdiy6gJXU=;
        b=XqWy8mouDVBL+yrWb3Zq4RBIgnc9ayiuCPvPJs//f3ApY47dfd3NlkeCc4cxq3rM8x
         9icBssjT7ZJr4e0o8MuZRQk+oznZYqiLNcG5Bwl5OOyjO1s670lDberEcoMLSlFDaxc/
         6dDQ893mACRjnC7k1Zwux+PHiwHOcFGIkrobvBnmRjPDc6MMyDOhbfopLaHXQ5WHI8ne
         W0XlWwfiWBl3snzne+oQZvfRg2+XaZ/kXP4Sn01Us6ZlaMFOz+k6KK5R9P577bwZq0j3
         uTjGBL3ti9zPMJtblmkXwAH5vPOj8uBu5HMm2Y9I/hjQkhPBR7p29Gt89BDQHOApZ/1Z
         JcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755086643; x=1755691443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFJEM6gKLS8APrjgYw576J/ohlNo10MJL9Wdiy6gJXU=;
        b=Ex3NAlxWEhmUt7/WYas6BJaysRt1xRBY5M8Gq3NG040bs5uHSnH8/6QVpVZrBLtySp
         nOjgn91/EqO8UyLZO61fEOG66nVZfVImhYq0xTQ7mo0/fhKs9gKs6+S/2EnaquR97hFs
         LWJV7L/wGBv5uM0neS5RNcaoRabsf1xSbIz97uOX12gvngWP263P52FmI/Z39gnwa8C+
         lEqfWDlGZT5EpiKqXFpKF6Ue6IYG5zb9m7coWuJeU/bN3leQRuTN+6xZAdfeDYU2B/Cd
         HHEgCRx1z2lz3NH8BFvlByGHWriej9cqfqc2LNjr9IxJbwsAJTTSAZosIHR9OuLpoHly
         E5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUmliUDg/Is/IgVDqsIwUMD19vbEY1M/05IEy/omMfHN4gr/BBd4hunu+A3vM6wslL+nRPOyStSNABK7yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGWFMD1oUQJdLo/gllrFSVVse+r0j4TAjLwKyy/jHqlCmKVj0h
	ZR8sNxxTvxZZLnluT1FCaqfNhPfqivljHNOXluGLKyFIzgMDruWWbUjRuWjPMNi0WnY=
X-Gm-Gg: ASbGnct5XPozDlkO7/fKmoG8RLn6EDuMvY0RXyfHuo9V9uDb0kBdMY8qph8xq6QI28h
	oTheSyhlEUVbpCQCr7km/INyD3dvc7m/SRA3C5LXiKvpZ3owTjKOyi+ey72mbnGV5+ZwexkRal8
	WqKfTN+87ddaplQLLFY3qrmRVI9xZ+z7gZ6JdiUZ/lGaS3DdbtlbVqbhqHGNKBhjjOI6SJZnECu
	0SM+wU/hG1kSwwgrtYenwOQEC9efifogPwA6MWcQycECpd/UtZ67Q+EElOgdHR0mPUH9Pwbq1n0
	EtR4xfrWCRmRtLyf03cEKU71hZvyX6IL8AHuEhACXJUe7pzHP3kcoQDviz2fwzuOOLGT8pMVAMp
	rMgimJUVvSMlqJYNDhcGtzPkf4pN/TW7LUanO78kWUsqP
X-Google-Smtp-Source: AGHT+IEbIIUvKX+tZSVHZLQC9aoX5f2381vIkWSxUdNWd/V49S21DiHBFi/zBkvX8b3n3gIVaPjB/Q==
X-Received: by 2002:a05:600c:4f12:b0:456:fc1:c286 with SMTP id 5b1f17b1804b1-45a17949c46mr12423815e9.1.1755086642808;
        Wed, 13 Aug 2025 05:04:02 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:eb1a:a80:21cb:47a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4beasm46169797f8f.30.2025.08.13.05.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 05:04:02 -0700 (PDT)
Date: Wed, 13 Aug 2025 14:04:00 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Wenbin Yao <quic_wenbyao@quicinc.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH] phy: qcom: qmp-pcie: Fix PHY initialization when powered
 down by firmware
Message-ID: <aJx_KjWFxeYE5U81@linaro.org>
References: <20250812-phy-qcom-qmp-pcie-nocsr-fix-v1-1-9a7d0a5d2b46@linaro.org>
 <f44beed6-72c3-4e86-834b-ac522c786bc7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f44beed6-72c3-4e86-834b-ac522c786bc7@oss.qualcomm.com>

On Wed, Aug 13, 2025 at 12:13:31PM +0200, Konrad Dybcio wrote:
> On 8/12/25 6:30 PM, Stephan Gerhold wrote:
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
> > Cc: stable@vger.kernel.org
> > Fixes: 0cc22f5a861c ("phy: qcom: qmp-pcie: Add PHY register retention support")
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index 95830dcfdec9b1f68fd55d1cc3c102985cfafcc1..6a469a8f5ae7eba6e4d1d702efaae1c658c4321e 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -4339,10 +4339,12 @@ static int qmp_pcie_init(struct phy *phy)
> >  	struct qmp_pcie *qmp = phy_get_drvdata(phy);
> >  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> >  	void __iomem *pcs = qmp->pcs;
> > -	bool phy_initialized = !!(readl(pcs + cfg->regs[QPHY_START_CTRL]));
> >  	int ret;
> >  
> > -	qmp->skip_init = qmp->nocsr_reset && phy_initialized;
> > +	qmp->skip_init = qmp->nocsr_reset &&
> > +		readl(pcs + cfg->regs[QPHY_START_CTRL]) &&
> > +		readl(pcs + cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL]);
> 
> I think it would be good to ensure the value matches platform config
> expectations, i.e. !(val & cfg->pwrdn_ctrl)
> 

I think ((val & cfg->pwrdn_ctrl) == cfg->pwrdn_ctrl) is what you want,
to check if all the bits we would set are actually set? That sounds
reasonable, I'll send a v2 with that soon.

I'll make the same change for QPHY_START_CTRL, to have it consistent
(checking for SERDES_START | PCS_START, which is what we would set).

Thanks,
Stephan

