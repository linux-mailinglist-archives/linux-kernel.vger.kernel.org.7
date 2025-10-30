Return-Path: <linux-kernel+bounces-878420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0F7C208DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F260401638
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DB3257821;
	Thu, 30 Oct 2025 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXbR+HMK"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A99255F3F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833970; cv=none; b=TngBo4RORNIb/uYvoSoi0+9cPhUFxKS9FwS9fb7EknCSxcUilPTVLfAZvc1rDPVlZqRP+znbKHC4pISnGigHbfZGwXHjtPjgnR5FQ1witfXExsB2pAePRdnX3/8QBuPEM7JUsTemb0hzdeOTz8pg8Z+eKbxOD3NPokVsoYctyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833970; c=relaxed/simple;
	bh=nWjEWW14xA6wvhmaKlUmBYkwCi9XznMqECjmZVOuvc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlOwcsw0/vyOisUfmDTG1Rj5jKrZ6YShaBGnI4sxDCCI7xMzFcECCRTR+o4eIj5y6VuRmXXgE2N78eOxJLRHk6+ed1g5pa1QDrSvy3iLQMitoSF+s6KgiZcvuUNvrmaOliMG9qGEA9prGFR8BuWY8K8tTNXAqVuSHZAtwwoePYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXbR+HMK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so6567915e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761833967; x=1762438767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a20YeKsMFc9Z6sbLd4e+xL3fMV6LgnJCfC9IDTqyQpU=;
        b=QXbR+HMKmSNQXcqAKd9nVhvOLgYoA3rcN2ykBLdnIklYia71Fdn0We1FCH+vIkrfvR
         NMCAtdu8sqGqhOWohL02QXSgIS8Qnlp67l80/kXdT3zjs2XsTxVAx3IQD1GXfsAQZfsu
         TKf2nhsmtzDbYQluAnN7anuKSvc54c+jikZV0fIlMwQX4efSAYet5Orjja59SRY8mFPi
         o4Raut4qKnh35i/hwOIfYmVpwFE1/+UnYGBgrhY4f2zNxaSZUnJU6B4ssqF5U8OB7Hl3
         Le6+cxgkq5HuejZp7RaSkFPuh8tFbI7SNLoDpiTnupnGmidaKHxGIzVFRR7WSJJEmJzA
         dhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761833967; x=1762438767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a20YeKsMFc9Z6sbLd4e+xL3fMV6LgnJCfC9IDTqyQpU=;
        b=A8lQXgsDsIcs3ZD3EIeuS2edMJ32USJFE4mvXJrv7Gp7WnrYVp0o+6avaxMLiwA152
         y8RNhE1QzxwmM+gkpEG+MyLG0qaXiZ1zh39/F3VDZuRuEUl9WligaL96mt54vF2O4O2J
         fD8WNepi7RDLLKYoEbWJqrmUxObJ2TRx2EJAvKufKWzn1L2cN1xOcmTj3GJaAXOcOccz
         m1CkZcZvEzaXTQ2GCkzCgZgJ8Gn7UogPAlhdEybrntpEzXas3ewy3cQXa9UZCKK+i1WG
         fDON46XHKmxmV7MBegyspRuMTVM8ycZjvbMYdFfgPD0gzN0jJdbppqScZkpBeh0rzJza
         magA==
X-Forwarded-Encrypted: i=1; AJvYcCWOxUgoO1j7UP4mmV1UeAePrczdzHiXddMvk3WQyT8l6r8w5HiZvokVKjSqBQAPuzGc9fLrzxk44k9ZrcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/6lZ97CRE+ZZjgCSeN5WgdfqV6vtZMyrFUa1BiJRrciRmfHp
	XabMcFA0mAx/uTDcv+X4En6TSkcf8mWGDcDK3iOeBkyuov/J0bmO01Z67ZfLbasLrWg=
X-Gm-Gg: ASbGncsSV7dNd+mLWKLuG9EJa6JxgULPA74y1AbeIhVD7XlQPesdyM/z02uQa5FXGeo
	vBQdcuBo6Gl6l24wQc4PHhJbhNpoh5AA+QjLMnTNjsSbeGjXQow1/IZhPRrwgqjh4/q/MbMghcq
	uadas58G5rgcZl6fC6GdggY0ed85fksb9M3DT3HmeJTY4h4XZv3e3q7v52S56KMfrGFP5dNdgxZ
	C5pfqFpjyI8XGTAQ65e/r8N3slrwynCJSS0ZbBEyD6JIh0ppmvcWR9zNLHcJblhKSRLVTo0CKvI
	06yDSgEXVPNNqi/NWSIzPRzIwHD2tfqn1N94wjndVt8ldOX/NNkAdER7uB5g/nJra5HX3KwZQfr
	SMpi+B90/JLhfhHd73C/NpQekCekqB2z0mhck03i7DOyspCQD+J1dkwwVWkvMJUk2uWlZMphXMb
	DoX8wc/MM=
X-Google-Smtp-Source: AGHT+IEBlja5JbNdrJw1QkNw2N7bwbcqpMzF5dSAbI4fK9ZOC8Mvm/unLC/mvyeKuAms9L9CjudSAg==
X-Received: by 2002:a05:600c:b85:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-4771e16e83emr67296335e9.8.1761833966643;
        Thu, 30 Oct 2025 07:19:26 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc524ddsm909265e9.7.2025.10.30.07.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:19:25 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:19:23 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/3] phy: qcom: edp: Make the number of clocks flexible
Message-ID: <sxk3zeqaul32upo2gnmvgembvx2d7eq6qyylmwuxsdahgw4ngu@4zcjcqlooyqa>
References: <20251029-phy-qcom-edp-add-missing-refclk-v4-0-adb7f5c54fe4@linaro.org>
 <20251029-phy-qcom-edp-add-missing-refclk-v4-2-adb7f5c54fe4@linaro.org>
 <wjvec7fiqjzlyo6y5kpzsd5u7rz47anaytu25w2j4yqgtdntx6@zuapdsayoio2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wjvec7fiqjzlyo6y5kpzsd5u7rz47anaytu25w2j4yqgtdntx6@zuapdsayoio2>

On 25-10-29 11:42:26, Bjorn Andersson wrote:
> On Wed, Oct 29, 2025 at 03:31:31PM +0200, Abel Vesa wrote:
> > On X Elite, the DP PHY needs another clock called ref, while all other
> > platforms do not.
> > 
> > The current X Elite devices supported upstream work fine without this
> > clock, because the boot firmware leaves this clock enabled. But we should
> > not rely on that. Also, even though this change breaks the ABI, it is
> > needed in order to make the driver disables this clock along with the
> > other ones, for a proper bring-down of the entire PHY.
> > 
> > So in order to handle these clocks on different platforms, make the driver
> > get all the clocks regardless of how many there are provided.
> > 
> > Cc: stable@vger.kernel.org # v6.10
> > Fixes: db83c107dc29 ("phy: qcom: edp: Add v6 specific ops and X1E80100 platform support")
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-edp.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> > index f1b51018683d51df064f60440864c6031638670c..ca9bb9d70e29e1a132bd499fb9f74b5837acf45b 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> > @@ -103,7 +103,9 @@ struct qcom_edp {
> >  
> >  	struct phy_configure_opts_dp dp_opts;
> >  
> > -	struct clk_bulk_data clks[2];
> > +	struct clk_bulk_data *clks;
> > +	int num_clks;
> > +
> >  	struct regulator_bulk_data supplies[2];
> >  
> >  	bool is_edp;
> > @@ -218,7 +220,7 @@ static int qcom_edp_phy_init(struct phy *phy)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = clk_bulk_prepare_enable(ARRAY_SIZE(edp->clks), edp->clks);
> > +	ret = clk_bulk_prepare_enable(edp->num_clks, edp->clks);
> >  	if (ret)
> >  		goto out_disable_supplies;
> >  
> > @@ -885,7 +887,7 @@ static int qcom_edp_phy_exit(struct phy *phy)
> >  {
> >  	struct qcom_edp *edp = phy_get_drvdata(phy);
> >  
> > -	clk_bulk_disable_unprepare(ARRAY_SIZE(edp->clks), edp->clks);
> > +	clk_bulk_disable_unprepare(edp->num_clks, edp->clks);
> >  	regulator_bulk_disable(ARRAY_SIZE(edp->supplies), edp->supplies);
> >  
> >  	return 0;
> > @@ -1092,11 +1094,9 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
> >  	if (IS_ERR(edp->pll))
> >  		return PTR_ERR(edp->pll);
> >  
> > -	edp->clks[0].id = "aux";
> > -	edp->clks[1].id = "cfg_ahb";
> > -	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(edp->clks), edp->clks);
> > -	if (ret)
> > -		return ret;
> > +	edp->num_clks = devm_clk_bulk_get_all(dev, &edp->clks);
> > +	if (edp->num_clks < 0)
> > +		return dev_err_probe(dev, edp->num_clks, "failed to parse clocks\n");
> 
> Nit...We're not really failing to "parse" clocks...
> 

Will respin with s/parse/get/

> Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Thanks.

