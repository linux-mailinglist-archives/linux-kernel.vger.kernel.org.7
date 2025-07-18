Return-Path: <linux-kernel+bounces-736635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B61B09FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBE01C817EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB38822D792;
	Fri, 18 Jul 2025 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGWOK2O0"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B042223710
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831221; cv=none; b=FWCqtcCjCWsi0ubMRVPjaHAsuAzT2GXF+wPEwHbrvqLboVgF/loSHUcrSaggE7ituoTo6kFAue8NZwMGvYISQin1W4BqXGMAE7DOYdYUmjI5RL1JiEa5Xq/A95/lrYnoCJSG5+30ZExqbRsYRe26s924b6s+KNU71fwX/tMrS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831221; c=relaxed/simple;
	bh=65C0cULWq6n1kIBMVWReYCSkEHWLR3vPQpO6wxz9lfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N084PIPWxAZ6181a2iaDxrX3cb08ylbfL8JZ8d2HEwKHOX0vHCij/RLBiBXMpjf2pBddP+MI94/cMl5qhVI+qAc9lgme0xxS7qhFtNibR/XUbFjAKAh635PTgHno1Ahoz10BB4+mcoctpFqDNUyT6j/slTtJGyniKfHxn72heyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eGWOK2O0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4563a57f947so2752195e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752831217; x=1753436017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkSzFym5h6ECIpSmRLEDdJL88SxsBS8iIr1XUgerRNk=;
        b=eGWOK2O0qldpQts2fZAXqE7n2fUSAeM3DBU9hkBLq/4giESm9U7XZ087/e6fQqwaI3
         /lJMFCE4DmkkXckc/efYGSrSMqe9+Gy7tSNfAhiao/E0DZIILqJ7f79jcL6viEzX3F11
         +WnlkZmmK59eGv5kIxZMGNe/nZLY5eTE6VZ/c0gDpCciFKTyPDrZ+nBYULeRLDqrNuCZ
         pTxTqZOeQiNufgRRObdX9wHEs8ZB/aRuJilfZMcbX0gRI1vtgke3r9Rw6/qvAeMGvKg7
         WZNGsH4mPLk7XvD560dP8O+guKMslf4nelCdnjGujkRSA56mftWCZgK+Texl4PNejHzF
         pIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752831217; x=1753436017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkSzFym5h6ECIpSmRLEDdJL88SxsBS8iIr1XUgerRNk=;
        b=eQLcAfiI9jkN1T8QywRrRyQWhzOhxlXvHjEEoWhG4l2znSgcCrKPFaKC+6gwSe5Neq
         0MkGIX4284Ax5Zx7gGczOX6kLHtZ3n044duSCuqq/fdeeNRE7gRDH/ungSdYz2mjhM2R
         +xARExPbTtmgigjIY8qubeawVSDNF4Kd0kOb3Y6VJlgEvFneszPMaOdNU4wh3VsZaZAa
         tzRXzeGIok87YRAvvyBgVwSBhT+0F5gSY7pMtl3m0IiOAdumh5jQYdd9tfbiRlHW9c4a
         Ng8qzATXJD9IF5wcmNfuA+4QRsshpLgIq1bm0wYzyjrk3ljANzUIiN8U1CtSxEG1PDDh
         oWrw==
X-Forwarded-Encrypted: i=1; AJvYcCWz7UG8mStFsUgZ93x7QpQzCbLX9bEkAi2+klgOfPI4A6AEmN5xi2NoDmwPZlByJr7WrjMKU4sn1K2V3vU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3T/PQS996b1ZLLYju3RT5Pwmmtilc2jXyQn7jcDovWnU1wdKB
	4KIiMAUqn0V3Hb/f77gteHtSzayhrZG9Ktj5dciZVMYXQ2FFe0dE7OjEQzfSwJ9qG18=
X-Gm-Gg: ASbGncvbtr8kdmobAU9RMHrQ7T2oPTxfFyDocdzLUWjS3M6dXBuivIkWQHhsnIBqsvZ
	41eNuV+mCUVvGsnt+o6B7dMhTKRl+lfClgkdlUPdSJo9QbmQ3rbyhlSyFZA0CxA8RElBwivjZTc
	0qJqXEHjTNKX4s1ZvGY0+Y3IpPxY4qj13f6NR0IUplvO/IPtYYmsFe6GtnDIxpdtAGlWDQs+YQF
	yoO3mr68cbo8U8vP31lwt3NXAPelPipmFmYfjBuwFyBVwBDiTWRq46iGwgTb1obiDq6OGJoB9nP
	gN/SKGjbMXtg0pSRmp9PCLJwCydunNUaoBk5CAK+1EGRgmm7RZehI1h7x8qpXev0c4Zh661wZ+C
	9dI5fXEsBEkvH0xfhTRZbZm4E7m9GbUBetQ==
X-Google-Smtp-Source: AGHT+IFXlYFdlruDA4D2jZKW4fN0q1iRAh64fALjB6JacdJeK+SN/LG9ZRXlz5YqMJ7iU6uoea4sEg==
X-Received: by 2002:a05:6000:1ac5:b0:3a4:f7e7:3630 with SMTP id ffacd0b85a97d-3b613abeebfmr6799083f8f.15.1752831217212;
        Fri, 18 Jul 2025 02:33:37 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:db06:bc5a:2982:a0fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48bc0sm1313550f8f.55.2025.07.18.02.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 02:33:36 -0700 (PDT)
Date: Fri, 18 Jul 2025 11:33:32 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
Message-ID: <aHoU7MnweSHGPwxp@linaro.org>
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
 <20250716-hamoa_initial-v1-4-f6f5d0f9a163@oss.qualcomm.com>
 <aHkm4qjgSaklHGp0@linaro.org>
 <4363f117-cc25-4904-84cf-4b3779797223@oss.qualcomm.com>
 <ng7koaqz6s4cslugrujklsrprsl7v7wijtserr6edvsvbeqfkv@pldexeryni7h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ng7koaqz6s4cslugrujklsrprsl7v7wijtserr6edvsvbeqfkv@pldexeryni7h>

On Fri, Jul 18, 2025 at 12:27:34PM +0300, Dmitry Baryshkov wrote:
> On Fri, Jul 18, 2025 at 04:19:13PM +0800, Yijie Yang wrote:
> > On 2025-07-18 00:37, Stephan Gerhold wrote:
> > > On Wed, Jul 16, 2025 at 05:08:42PM +0800, Yijie Yang wrote:
> > > > The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
> > > > the Hamoa IoT SoM and a carrier board. Together, they form a complete
> > > > embedded system capable of booting to UART.
> > > > 
> > > > This change enables and overlays the following peripherals on the carrier
> > > > board:
> > > > - UART
> > > > - On-board regulators
> > > > - USB Type-C mux
> > > > - Pinctrl
> > > > - Embedded USB (EUSB) repeaters
> > > > - NVMe
> > > > - pmic-glink
> > > > 
> > > > Written with contributions from Shuai Zhang (added Bluetooth).
> > > > 
> > > > Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> > > > ---
> > > >   arch/arm64/boot/dts/qcom/Makefile          |   1 +
> > > >   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 835 +++++++++++++++++++++++++++++
> > > >   2 files changed, 836 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > > > index 4bfa926b6a0850c3c459bcba28129c559d50a7cf..c5994b75d3e56e74ffb64b2389ee1bcc086f3065 100644
> > > > --- a/arch/arm64/boot/dts/qcom/Makefile
> > > > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > > > @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
> > > >   dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
> > > >   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
> > > >   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> > > > +dtb-$(CONFIG_ARCH_QCOM)	+= hamoa-iot-evk.dtb
> > > >   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
> > > >   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-tplink-archer-ax55-v1.dtb
> > > >   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp441.dtb
> > > > diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..843f39c9d59286a9303a545411b2518d7649a059
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> > > > [...]
> > > > +	vreg_wcn_3p3: regulator-wcn-3p3 {
> > > > +		compatible = "regulator-fixed";
> > > > +
> > > > +		regulator-name = "VREG_WCN_3P3";
> > > > +		regulator-min-microvolt = <3300000>;
> > > > +		regulator-max-microvolt = <3300000>;
> > > > +
> > > > +		gpio = <&tlmm 214 GPIO_ACTIVE_HIGH>;
> > > > +		enable-active-high;
> > > > +
> > > > +		pinctrl-0 = <&wcn_sw_en>;
> > > > +		pinctrl-names = "default";
> > > > +
> > > > +		regulator-boot-on;
> > > > +	};
> > > > +
> > > > +	/*
> > > > +	 * TODO: These two regulators are actually part of the removable M.2
> > > > +	 * card and not the CRD mainboard. Need to describe this differently.
> > > > +	 * Functionally it works correctly, because all we need to do is to
> > > > +	 * turn on the actual 3.3V supply above.
> > > > +	 */
> > > > +	vreg_wcn_0p95: regulator-wcn-0p95 {
> > > > +		compatible = "regulator-fixed";
> > > > +
> > > > +		regulator-name = "VREG_WCN_0P95";
> > > > +		regulator-min-microvolt = <950000>;
> > > > +		regulator-max-microvolt = <950000>;
> > > > +
> > > > +		vin-supply = <&vreg_wcn_3p3>;
> > > > +	};
> > > > +
> > > > +	vreg_wcn_1p9: regulator-wcn-1p9 {
> > > > +		compatible = "regulator-fixed";
> > > > +
> > > > +		regulator-name = "VREG_WCN_1P9";
> > > > +		regulator-min-microvolt = <1900000>;
> > > > +		regulator-max-microvolt = <1900000>;
> > > > +
> > > > +		vin-supply = <&vreg_wcn_3p3>;
> > > > +	};
> > > 
> > > Like the TODO comment already says, regulators located on a M.2 card
> > > shouldn't be described as part of the device DT. We need a proper
> > > solution for modelling the M.2 slots together with the standard power
> > > supplies (3.3V and 1.8V) and hook this up to the pwrseq subsystem. This
> > > is also the reason why the CRD does not have Bluetooth enabled upstream
> > > yet, this needs to be solved first.
> > > 
> > > As far as I know, there is no one actively working on addressing this at
> > > the moment. Perhaps you can assign someone at QC to work on solving this
> > > upstream.
> > 
> > This power section is now managed by UEFI, rendering these regulator nodes
> > unnecessary. Therefore, I will remove them in the next version.
> 
> No. The regulators for the M.2 slot should be present here so that Linux
> doesn't disable them. Which triggers a question: how are they
> controlled? I don't see a GPIO line there.
> 

The 0.95V and 1.9V regulators are located on the inserted M.2 *card* and
get automatically enabled by the 3.3V supply of the M.2 *slot*. If you
remove the card or insert a different one, they won't be present. This
is why they shouldn't be part of the DT. The M.2 slot only has a 3.3V
supply and a 1.8V supply.

The only reason why they are here is that the current bindings for the
WCN7850 require describing the whole PMU and internal regulators of the
M.2 card. Ideally, we should have a generic description for the M.2
slot/connector instead.

Thanks,
Stephan

