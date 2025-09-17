Return-Path: <linux-kernel+bounces-820967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78539B7FE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFE5188B2D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994FC32E752;
	Wed, 17 Sep 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zuAxRmFn"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521632BC06
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117758; cv=none; b=IHGHrTYl6pKqU6KTivCQeNFxE7AKXhL1tGu/6HZTdtiQB6LcBAE5lXqgZcbzN+NSLSbzav8zx8wFpQ6VWfIbB5f0pzlaf1MNkQxFSSZwXYGfV6UO5XxKKRFYMI5rh66Ee1qys3x2oGxJD2QZu72Vl9Ay3MV0bzJG1pBV3NYh13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117758; c=relaxed/simple;
	bh=RefTj2LFec46dsJYSPZ8tEBm1+3mD1JsxhEJXrBH8b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgaVL9QNghetbOn6Visi9FsnWF9uIelp/zRonXa977UC1sxVYDhQTAVgfvnZAbVOvmOXMkj9zhH9ZyUy68Dnb+20FV0LuyC4h15+eaNfcDt79Y/+qomQVf+30kes1pOtdTv7mmT4lMU1IMQE2cm26+B0B2e9zUC3/4LW+mhLaSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zuAxRmFn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso1153376666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758117755; x=1758722555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+aI0KZC1S6i6KZFgi+7mCnlg3sWeGuC+L+mdTKqHXWA=;
        b=zuAxRmFn61FFiZI5S+OudwNsTVs3FWCSZzd7GYDcHq4rw0pXeq/pWniM7DF04RzrHL
         KFNabexibQBszYz/5fl9+Opg4KmDaQ6Yz14SSA6VVob8pmhu/I11fZZKeymCx75icdzu
         f+f/vcRIrUcaqgc7brT/s4SYUhKv5o20saVGq0ryA6vJh/AgPJu1hJfgUHuRTKNYmehE
         sxoC0bwitpeIw80XXtLesexTy2GqpOPeurGlue20g0qQjYhHhTZDsueRzP7scduCTnT7
         zz+uSiXZLwi17t9XBKHyNgUSmD3p7RpWA7cRVbh4Td1lXpsGgIHJro5FGDl173STk9lj
         e3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117755; x=1758722555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aI0KZC1S6i6KZFgi+7mCnlg3sWeGuC+L+mdTKqHXWA=;
        b=blH0kNg/NQ92kDXioWU/P5vGxwlmthbW8CyWHqKdGIFsIbxwLWVuCyRBUdUhSF3iQQ
         VnF0p4sQMu0+rM9JKjDQLaHx1OdcXm3Q3y8X0PpPwTS4nBG5YAPmarfOgf3xznUznWcB
         9JRhVZuBr0ZrTNloCLLdzB3rou+fnKzj0b0eP2zQbdngRCpuU/USi6rDpafuu3jfKFGK
         VRmezU4183ey+KQBwcXxYiCphnZK6vy3LcNcdrCV+f8C51ekryFzgBU1rpwMzrDmuRaJ
         iSx3Q/PxVa1M7sl6B3owktNtpqqKq4R1VSf6EkO/sIDVuVfsypU8KOsZcmYrzJr9aQmG
         3b0w==
X-Forwarded-Encrypted: i=1; AJvYcCXfE3kl2exM0iAmzjia7Nvyi7vxUMJ+6vgX8l1vmQQ53Fx8Qwv/jvAfZyXAcz3ujse0bAcxmpMIayoLD1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ngIWvOgYUYhNuRs1J1pd7iAo1965alXwsW2lGjuL5B4TAf1f
	Ec8/Ecqtxtir6ge++VgiDEWnHD7IqUGzDPQcpzZExiliHtCqvPvHyyVzMVdMp3Qq59k=
X-Gm-Gg: ASbGncvp5TMbvmm7BPSipFCvFt8PlIMI0yHLvx0Yiw58lFlW0hnidxWIhQTioOfF+SY
	XINhCDeK3pR/h5tol9zc3VqYeIKUI1WWunRtmJ2fS3AFOWyYB2rDPlki/7UIoyQv/aEqCNN5nxf
	h9YNSXm5uVkjs17ep7+TdW7uDOwgVQeBLjE0po/bTHpQ3B+wpq8WjvXo+4PexQBJ9wCF/9JKsrZ
	2vHCk76d15GfpSSf39XenViIXBE0oYmKMaAJGBazynuVz3PTXgCq7CdpW1MrXfVuHRdsFER1fEP
	kRX9WILlR1JbgZZ9/AgcqU/oM/JV2UzsF0tYdV1VlDbzS2YZCnagYQu1XNEphk9F7ku/MSIcF2w
	pGbdgfHeYKjaBzMwbKdSfMi25BsK9gQ==
X-Google-Smtp-Source: AGHT+IG4Gian2+1eYXK+LJPiJ/IOk7YXX7BNAP8tJbijpr4j+Tg2SNRKcI5T/sLwoI+EVC41Iboriw==
X-Received: by 2002:a17:907:9691:b0:b04:3b97:f965 with SMTP id a640c23a62f3a-b1bc1168641mr281451566b.49.1758117754340;
        Wed, 17 Sep 2025 07:02:34 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:96c4:427:30f:64da])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3347a4fsm1352382866b.103.2025.09.17.07.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:02:33 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:02:29 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Paul Sajna <sajattack@postmarketos.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org,
	Amir Dahan <system64fumo@protonmail.com>,
	Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH v2 11/13] arm64: dts: qcom: sdm845-lg-common: Add
 bootloader-compatible board and MSM IDs
Message-ID: <aMq_dbLRShTVLlc8@linaro.org>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
 <20250916-judyln-dts-v2-11-5e16e60263af@postmarketos.org>
 <acb4f8a2-ff08-4a90-a7ad-7b25a7f4b6b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acb4f8a2-ff08-4a90-a7ad-7b25a7f4b6b0@oss.qualcomm.com>

On Wed, Sep 17, 2025 at 03:55:47PM +0200, Konrad Dybcio wrote:
> On 9/17/25 3:09 AM, Paul Sajna wrote:
> > The original bootloader (fastboot) requires board and MSM IDs in order
> > to boot the kernel, so these have been added. When re-using the same
> > files to chainload U-Boot, these compatibles are also needed to ensure
> > proper booting.
> > 
> > Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 2 ++
> >  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts  | 1 +
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> > index 1baec758c7d881026bf6001a0a305687d7a14b40..a513cd931b3a984443183ee4e8df7b0e45732630 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> > @@ -5,6 +5,7 @@
> >   * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> >   */
> >  
> > +#include <dt-bindings/arm/qcom,ids.h>
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/leds/common.h>
> >  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> > @@ -29,6 +30,7 @@
> >  
> >  / {
> >  	chassis-type = "handset";
> > +	qcom,msm-id = <QCOM_ID_SDM845 0x20001>;
> >  
> >  	aliases {
> >  		serial0 = &uart9;
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> > index 8c1692f86e6ceea7b718361965e78f95d39373bb..beb1372dc6c17f5f06c2044412ee1c8165858cd1 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> > @@ -12,6 +12,7 @@
> >  / {
> >  	model = "LG G7 ThinQ";
> >  	compatible = "lg,judyln", "qcom,sdm845";
> > +	qcom,board-id = <0x020C0008 0>;
> 
> This is almost QCOM_BOARD_ID(MTP, 12, 0), except for the odd BIT(25)
> which the dt-binding promises should be left unused..
> 
> +Stephan maybe you know more?
> 

I'm not sure what BIT(25) is exactly, but I think you can generally give
up any hope of trying to make sense of the board IDs of large vendors
like LG, Samsung, Motorola etc. It's a pity that Qualcomm has never
created a board ID scheme with enough room for customization for
vendors. The qcom,board-id scheme seems to be entirely focused just
around Qualcomm's own boards (MTP, QRD, SBC etc). That is why we ended
up with every vendor using their own incompatible approach. :-(

Sorry, I wish I had a better explanation. :-)

Stephan

