Return-Path: <linux-kernel+bounces-781777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E61B316A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24202B61A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0ED2F5339;
	Fri, 22 Aug 2025 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0CPMuUD"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D781C2324
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863146; cv=none; b=GTSJnSxTwT9FPb/+iH1FdHRxXfn1//vyRfPuDeeNDDKO8/vuMYS5Dzl2Bwd48MFqdGO80zYxz3N52no7h9PmCXoWry7B9h9AjI7SGy/6Z8JLPTbl08CNKCHc9d6VIkt028owT1fepcLV3nhRLCeC2zrfflzpnAdcwbqRQCJ4wvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863146; c=relaxed/simple;
	bh=xgTcVv1+T6O/ZT0Qdiz0Je+GkcjQdQoA+CbqSo/EOtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhyuGGDHfqLAR7D3g4rqG7m0sUHfQqEA644jw3cxXNxnuKSDEjYxaRMbbGIsUisEfsB8oc+CsK/jWNNDvGBSPiWOSuD/XrNXkCSKCbEhvWjtb8n4uxyQBROLfEY4137joi474u5w8Hnm0C4cPuo5JOUsYDYuW7UL/yIMavpVew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V0CPMuUD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61868d83059so5059780a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755863144; x=1756467944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z4OUvE+/qeMt3Ot3GYxNSoy/OyQHU/DgOy4nkkkxS3g=;
        b=V0CPMuUDgp5v9MIx8aOe+jHztES54FM3r5g7tS1CT1Zg6oKaLbaqPyjmBIDCjODOWj
         oRhX0xQnMI+zZnpVtuuATMttbUwcrWWXGFnzAMM3T7KvCtgIm/QfSsyBbE+p8vtLOoDw
         ONGrdkeb8doqxJ3xhUu8Sd1loTNob7qNB9XXt5VZs8WZmuF7nZuISasZCZm2Ta+IOSY+
         VkUPxc0geZDOgpasstsepTRnkVKeKuZQnYWkbnJr2MjjiXEkYpXy7P4RJYQvDdugzBkR
         dpG5fQhSig8SA1C1nyX4io9jQVePRLLTdx1MT4fUzYPXrqTQ2aiHxckAZNaxgaAzNtvn
         UeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755863144; x=1756467944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4OUvE+/qeMt3Ot3GYxNSoy/OyQHU/DgOy4nkkkxS3g=;
        b=iE4JfbBVePgKAUgakMOEG3h0XJaxyUVvM1cNPUw60CNANrUx9fMD4vCEMulP5Wm5wT
         SCjJffCN5u2+DGWQf7tjPmquOY37ZUKkwG+qmuiDgJrtqxpo4yxQb+Oayw7Mv1mw+wPg
         EyENIx4C0UcB1ayW0qsNefiwjcuuUKYDxLNtWJ9RmY5m2L0mpChNt/Yuk9A2ozmcZB6o
         JzUA8mbIYWvdwfqU4EQBeSXv2LwtgrlAxgnkP2Eyl/C+dld33KzlZl06GmHvTwYeUHx/
         CFmPAn//tCb9Swk9c2MvSSIwnpcDv6Q+7u0q49LEt7OKhxRbwwVc1kqMl3RTMixWCvRZ
         zUYA==
X-Forwarded-Encrypted: i=1; AJvYcCX+GeaARShV51DKtotVOBpwHE/wzMB3WYEpE+ct5Pbij0DJqVV9G2rdHvU9PAoSHUeaeVoPzZfnXOEz6oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXAqnkKlE9IDXpqsfHyeYZjmxKWVYWSSjZBUSZtB3sEXQgohq
	EdbTMhr08jmPI8O6axfc6jkdicBfrtk0uZlEffTK8WZeJq4g3OXrKMqZvo7IMDj7alc=
X-Gm-Gg: ASbGncubtY3BH+DXhICdjz2fz54/Ouxbs7/LvMd//7KmSKJPIow9xniijbrWJh7/Y1+
	mwwmjSiSywPp+efeJY5d3bFD2vxFUhv0qtwPkjg9nmiGKbXg4Lrq1c+mVEoQlR7FUfuGgAHbOTV
	h7MPv0K5h0XxoNncP1XoYDFjq6mTBvO55Kj9nxXr1D+GGxbzG38xix6GrP5jy6yrjpHeOReF0gj
	Aoe1Dr1qmB+gOy5DS+WzmpimIQIeJgMu78w/wxLsyfZlg4FUx6xf6BLMjNvsx6TdL2+G91C0mA7
	XeSEK5ThlUyQbGr/rjhXDmd6s+9kONQDeWeb8dNsyBU9d3iK4h7RZeOXZt56K5rYZTbd+Uwhuh9
	7irMibq3B3PakfgN20gbfXr/Nfp8Lry4t3zjehxuO7Kjm
X-Google-Smtp-Source: AGHT+IGP1JS6P3jPLucWErJ+X2vbBJZkNfA72X488Al6ZrxHQ3otij/kMnekLD+6J4EjuK4lppcisA==
X-Received: by 2002:a17:906:4794:b0:afc:aac3:6d2 with SMTP id a640c23a62f3a-afe28fcd53fmr252056366b.2.1755863143536;
        Fri, 22 Aug 2025 04:45:43 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:63f:a353:7a5a:5beb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm590844266b.45.2025.08.22.04.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:45:43 -0700 (PDT)
Date: Fri, 22 Aug 2025 13:45:38 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 add HDMI nodes
Message-ID: <aKhYYjUuOQ7H1aPm@linaro.org>
References: <20250821-topic-x1e80100-hdmi-v1-0-f14ad9430e88@linaro.org>
 <20250821-topic-x1e80100-hdmi-v1-3-f14ad9430e88@linaro.org>
 <as7pbmhfgsg3ht3s5lu25pfjjamaxyonuohkuohono3kr2mxii@posspuko4vwa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as7pbmhfgsg3ht3s5lu25pfjjamaxyonuohkuohono3kr2mxii@posspuko4vwa>

On Fri, Aug 22, 2025 at 02:01:30PM +0300, Dmitry Baryshkov wrote:
> On Thu, Aug 21, 2025 at 03:53:28PM +0200, Neil Armstrong wrote:
> > The Thinkpad T14s embeds a transparent 4lanes DP->HDMI transceiver
> > connected to the third QMP Combo PHY 4 lanes.
> > 
> > Add all the data routing, disable mode switching and specify the
> > QMP Combo PHY should be in DP-Only mode to route the 4 lanes to
> > the underlying DP phy.
> > 
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >  .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 44 ++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> > index 4cf61c2a34e31233b1adc93332bcabef22de3f86..5b62b8c3123633360f249e3ecdc8ea23f44e8e09 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> > @@ -62,6 +62,20 @@ switch-lid {
> >  		};
> >  	};
> >  
> > +
> > +	hdmi-connector {
> > +		compatible = "hdmi-connector";
> > +		type = "a";
> > +		pinctrl-0 = <&hdmi_hpd_default>;
> > +		pinctrl-names = "default";
> [...]
> > +
> > +		port {
> > +			hdmi_con: endpoint {
> > +				remote-endpoint = <&usb_1_ss2_qmpphy_out>;
> 
> Please describe the transparent bridge too. It can be covered by the
> simple-bridge.yaml / simple-bridge.c
> 

I think this isn't the case here(?), but how are we going to handle
devices where we don't know which bridge chip is used? I've seen at
least 3 or 4 different chips already across all X1E laptops and we don't
have schematics for most of them.

Thanks,
Stephan

