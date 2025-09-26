Return-Path: <linux-kernel+bounces-833657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F2BA2926
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB84F3B6A39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E6027E1B1;
	Fri, 26 Sep 2025 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rW+ruKNK"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957E27B35D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869429; cv=none; b=pvTB+/FxrmQOzLfF1CFgfhNdanWFDOdI7TRD6mQ8zjkPX9qmFgFLqRHo3QvrqszOWYj/MFlL+W3ix0OgKe79UAuYymA5UC0WFhZ/1rbrmwl31UqSxKg42j7DN2zTCmm8h8pwhSwzquYpx5is1iMdOkxqYOquNlYnvcbTIlsYXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869429; c=relaxed/simple;
	bh=JeiZMAdBfoDaJdELXLbBBT1DLTAze95bhqjWibF8b5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0YZftwogJXK3C53zqWIEJAxA2b+yBTxRBycyXEfNdn8DrNZEPgcwi7K4iWRHPiR28ohZnXZJmtLE+gSU97mqmJOSBxj9B8SIGDeQnEaiumw7/49kl43fLj32/h3PC1xpCwKGArCopDzRNcygZWMK7DqXAT5o3+VAzvzcb0xYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rW+ruKNK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so16777635e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758869425; x=1759474225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFTsrA5/XpN/aDPrsWUi64EUIAXE1gernUECI4xL01o=;
        b=rW+ruKNKll5EhnG2oOhKIvMEad+3krImExig4LkwcQG7DBj0kcn2NryFioX3fSmJH7
         HklP74ToNbfZITW6vXgRm1RjZwHVfvJkh3EJHE9ci2GDxTi9Z/DzvF74cw0n234YhrPI
         RhpMH2SkrY6ls6ZvbfBzGbbOU0I43O1vWXC7pFV358LP+O6T3mLHCnxeMjYhZ4PaWFBv
         /CPPYIlByCPyXJ3hhK4yJL4tOvNkuBl1JI2fJbl6li7FfnUNZp+7IM3zje/wxKrewIxA
         agwutEIni/EBxf4BZZW4Xtrkpjy1YT+61bjSSxSm54ECR2IbpyhyflEHX0rrcyis8fNh
         doRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869425; x=1759474225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFTsrA5/XpN/aDPrsWUi64EUIAXE1gernUECI4xL01o=;
        b=hlH87WcmljmJGR0G12HCULjYN85WBU2ug1/yYor5jxXMDzYlBP8fFFs5O9+Y+9XFCn
         yDmCrHOjKjRj0ud5Z2JoV10r2hisxstU9dCY6pf0Go6cga9XSjiIGjp16wyQG4P+zd52
         gPg6jQZSWoTXf2XmscPQ65/Bi5E4uYjDrnbgpwYhKMBXril12fp9/X1o+pDSsy4A/c6R
         Aj9QTummuwPo73QDjeMQFCTIY5Si9xAH3BbT/DqoWzMkxOwn0awLz8xlXpYcaY2ZOc2a
         WRdOHPMB7xZ989LeLseTnuusaNuZLS+lbaL3KBzTU8SHMEfVBip3bvhp9D2bURDfr8Js
         gXJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/n0wDu9aghX3LiI3VV+YYzmZZucoyW/2ewEfESU27h7Z8wHHMLtegbi67Idm/w9QEy4QLvjkfTCcJnTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpEi0dHSYVtzgk1lCLHm9n4SdOULyeYTLZh23MWBD/gExT8fnR
	4/HopemFQUTTf92pXtsipv0DleXyLCUwZiyeDzJ4hhBGVk4aCYGqOjE29n9bIr3vIgs=
X-Gm-Gg: ASbGncvqqh/vOOdtXpDlheOLyAAemzccJKcZpbHVvy216YZBOByN0u/FpwlcYQ7d/j+
	PKL2lfMJkvdvUlfj32UCFSv7Z35IKVScSj5+rJ12HTPjVh6uG/3NYWm7Qgyc7bik1W6rlAHs6Gk
	eI2YcJly4DZSn0yddFfEwv27jpm+qieFyFzrobCCDlSts+1TGs/yGNDRwgEIigS528oHa/VPOvY
	vQTCCzWVUoC9EPAw8hdDzlURud50pljO/wDRqZ3pRlzg0NfEKo11WuhlzvfqRSabV2kO7d/Jge2
	roCPkBwTEHSqbF3myWMzi/FYraU2tDX2LaMs0Kkq3C61CCsorzuTvylYvuDQuiNj98ylFVYKCar
	ekheZX7eBeA44AoytuU7GyA==
X-Google-Smtp-Source: AGHT+IFyx6DPnlr6W6V0+TXiAp7mU5XDK4wWvIBL9OAv7zYNMXQhdyyL5XhqSCjFW7RXKqfYCBtV6w==
X-Received: by 2002:a05:600c:8484:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-46e329f653emr46236185e9.27.1758869424835;
        Thu, 25 Sep 2025 23:50:24 -0700 (PDT)
Received: from linaro.org ([86.121.170.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31ea3sm103257195e9.12.2025.09.25.23.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:50:24 -0700 (PDT)
Date: Fri, 26 Sep 2025 09:50:22 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: glymur: Describe display related
 nodes
Message-ID: <r7f4zzugs3io4ho7qdjudh2ebyphtsjdnchnj7hnt7msoiylfz@dhfgzjg3sh46>
References: <20250925-dts-qcom-glymur-crd-add-edp-v1-0-20233de3c1e2@linaro.org>
 <20250925-dts-qcom-glymur-crd-add-edp-v1-1-20233de3c1e2@linaro.org>
 <43jgqfcw2nnasdnskfdri5swddr6kunvvp6oxzqibnlvyc4jd2@4y6x7fy5shq2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43jgqfcw2nnasdnskfdri5swddr6kunvvp6oxzqibnlvyc4jd2@4y6x7fy5shq2>

On 25-09-25 20:11:11, Dmitry Baryshkov wrote:
> On Thu, Sep 25, 2025 at 06:02:48PM +0300, Abel Vesa wrote:
> > The MDSS (Mobile Display SubSystem) on Glymur comes with 4 DisplayPort
> > controllers. Describe them along with display controller and the eDP
> > PHY. Then, attach the combo PHYs link and vco_div clocks to the Display
> > clock controller and link up the PHYs and DP endpoints in the graph.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/glymur.dtsi | 492 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 484 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> > index a131cd6c3d9e7f14ed1c4aef4b68e1860cc3bca5..41d89998b1fe14a24cd528e73afc37cf2a840bab 100644
> > --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi

[...]

> > +			mdss_dp0: displayport-controller@af54000 {
> > +				compatible = "qcom,glymur-dp";
> > +				reg = <0x0 0xaf54000 0x0 0x104>,
> > +				      <0x0 0xaf54200 0x0 0xc0>,
> > +				      <0x0 0xaf55000 0x0 0x770>,
> > +				      <0x0 0xaf56000 0x0 0x9c>,
> > +				      <0x0 0xaf57000 0x0 0x9c>;
> > +
> > +				interrupts-extended = <&mdss 12>;
> > +
> > +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> 
> No pixel1 clock?

Will add it in next version. Everywhere.

> > +
> > +			mdss_dp1: displayport-controller@af5c000 {
> > +				compatible = "qcom,glymur-dp", "qcom,sm8650-dp";
> 
> This doesn't match your own bindings. WT?

Urgh. Yep, this is wrong. sm8650 compatible needs to be dropped. Will do
in the next version.

> > +
> > +				mdss_dp1_opp_table: opp-table {
> > +					compatible = "operating-points-v2";
> 
> Is it differnt from dp0 table?

Nope, they are the same. Will use the dp0 table for all controllers.

Thanks for reviewing.

Abel

