Return-Path: <linux-kernel+bounces-813502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B0B54659
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8967D1C219CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A16627AC28;
	Fri, 12 Sep 2025 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4JntkdN"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFFE27A929
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667621; cv=none; b=lVs/4JZNfATj3QY61KOMfa5Q+zpvpU5bwsaGPeepJZ5SPk6+rmmoraQ3AYxqFM6JBUcpDqrEYQY+F2cCsb5Wgx9lVezNVsarrexnDX8wfFD0L5Eq3RIBItIUOmgKkU+wM5HElK3GTLyRTvZlwUKB+X5UQkJAO6gYuqt2wofIfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667621; c=relaxed/simple;
	bh=KkxRQUegu9Ld7QxiircNfbxfnOwVwrbn4bnFeCPC280=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwmCpeV8TfN8XB8JnG7eCmqGRzdoT9KqW3TwXHMA+lVaCK9gSEMJSDo/b5sC3UKzguSTo9wheieOAUjMK7H1W0T6NJc8kIs6NX7zsqf/Hfo8x5aOBK8bJNN6kgrZ9qwMOjMUGToB+viFNlBOtF5kKTfFbXPgFiHjA83ZtWJP0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w4JntkdN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso2864083a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757667617; x=1758272417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kqH/ZuUT/Wy0euj5Cau8Rdbvh6wWj1ajWc17fov4n94=;
        b=w4JntkdNSN2t7pKnaViHvAFVNxomUT6rsF0zPREN3/Ey7Xu8I5prQtkrrZNvD5rbVq
         E0oeEgQG0Bp85yaS6L8qeTUklfC+6UQo6SeDQ2wXRYcOW0XlypxvbAwRL+zWa++4OFtv
         Ri+l6K7WSN8fOlULqB/1+c0WufyF4sdqJ2OPUtCxodXVi0reocfm9P6T5Hy2NDv1ZJfg
         EUxMusqke0cq0UBUdBeh6YsP2/s1CZK06DPBIjKzTFD7OLG7rwY1Nu+SIU6XEq/fnqHS
         lW3Oafaq4+oREb/ciPhN+HgNnwjcOFidbfuroai1iMUMfB8dIDsryrSAZlPmk36q+jjb
         3Ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667617; x=1758272417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqH/ZuUT/Wy0euj5Cau8Rdbvh6wWj1ajWc17fov4n94=;
        b=RUPXWKzt86qUhYkt/4Jvuw2fosWJrqmn3rn9W6XrrZwkn303Tq4uwPPjlpdk3QXkuR
         qOdN+eujYvwVWjRHVAuxpkSeN6G6n4QKB0EWs4RM4I4PM2KZJT1WWxhm3wfX2rgs9lxG
         /FgC2TbuaKROeRJ5ey5va4zqM0A9A4PAVqLT+z2c59asXMP2c9HuoFAR6a0S8qfI5ngc
         8Bu3aQfUahN090gjNaDCHbF8F/RtaoSmfxpnXV64JKuljNxNw6UsDNZotXYfPwokJT8n
         6vzvUX4oucmA576ZPf+TqTcZzrHrxdDHdDbE/4KA8gzRzmIw+fIJ9luWfWRCKd1yaghC
         BlFw==
X-Forwarded-Encrypted: i=1; AJvYcCX0YZW3VKj2sf9l6wm7wdxmNHdJnsGt1aWXMAMiqY9m4e1b1QzQgw9vuld/l9d8l9L9XFKHJBpoc+TG4Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwksXBSKXeALVjo8Si6/Sg78EsFGGzq0jG2+vaKL9N6xI1AcdTF
	nT0ZabUUYOGP2ehSfu/YW+npIOtGZBSvLdRPJ/VC3zFE/XKqs+DJq9vdrtDIPUVb0M4=
X-Gm-Gg: ASbGncsyo1WxIWyMSvLkVR6bgsUyV+BBgCBYL7AiSHzKLVU4qWUR98e7vcBEfv/cTaQ
	q79WA+qD81oh/3JaiIegSMQ+SWJxB5rVLRWnsERtz1joitlf1yoLw6ow4J/c4IvMhnXIrKeODxO
	vGChATTOHynxzLOHOU7FJKIOxQVaM+pTR5APQLCYSwbyOnWrme3RmFLDWCF5l7EzL9yjvJG35Q9
	17qY0iRESF7Y4a6yRenMiF/nzhc2vmPqa5DHcyWx/ThM0iSZyB+BOLm8GiVrFEAe3t21mHMwOvn
	EcxdIVyyzbL6cp9rNy3nTLZZFqKg3xNIzAhjyRkJYgcxHHIUGYJYBGkdS2TabKbSUafgRdQn5bD
	EqlLKFV0R0PBXu7Xe4dt42KS+nsxXOYC7Uhr5PvV0/BL65vu2XiAG9w==
X-Google-Smtp-Source: AGHT+IG6ahhooDRjCLAr+j2YJkIYsc7o/D83Omh5S2ijH7u28U1AnCkxcq7mMhp9y7AnOYU5iezA5w==
X-Received: by 2002:a17:906:d542:b0:aff:9906:e452 with SMTP id a640c23a62f3a-b07c381fdc9mr216146766b.31.1757667616760;
        Fri, 12 Sep 2025 02:00:16 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:5fc2:ee41:2050:2d49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f20ffsm328900866b.79.2025.09.12.02.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:00:16 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:00:11 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
Message-ID: <aMPhEm8PuhEofHP7@linaro.org>
References: <20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com>
 <20250910-hamoa_initial-v11-4-38ed7f2015f7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-hamoa_initial-v11-4-38ed7f2015f7@oss.qualcomm.com>

On Wed, Sep 10, 2025 at 05:02:12PM +0800, Yijie Yang wrote:
> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
> the Hamoa IoT SoM and a carrier board. Together, they form a complete
> embedded system capable of booting to UART.
> 
> Make the following peripherals on the carrier board enabled:
> - UART
> - On-board regulators
> - USB Type-C mux
> - Pinctrl
> - Embedded USB (EUSB) repeaters
> - NVMe
> - pmic-glink
> - USB DisplayPorts
> - Bluetooth
> - WLAN
> - Audio
> 
> Written in collaboration with Quill Qi (Audio) <le.qi@oss.qualcomm.com>,
> Jie Zhang (Graphics) <quic_jiezh@quicinc.com>, Shuai Zhang (Bluetooth)
> <quic_shuaz@quicinc.com>, Yingying Tang (WLAN) <quic_yintang@quicinc.com>,
> and Yongxing Mou (USB DisplayPorts) <quic_yongmou@quicinc.com>.

This looks like you should have Co-developed-by: tags together with
their Signed-off-by: tags.

> 
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile          |    1 +
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 1221 ++++++++++++++++++++++++++++
>  2 files changed, 1222 insertions(+)
> 
> [...]
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> new file mode 100644
> index 000000000000..6eedad7e858a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -0,0 +1,1221 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/dts-v1/;
> +
> +#include "hamoa-iot-som.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. Hamoa IoT EVK";
> +	compatible = "qcom,hamoa-iot-evk", "qcom,hamoa-iot-som", "qcom,x1e80100";
> +	chassis-type = "embedded";
> +
> [...]
> +	/*
> +	 * TODO: These two regulators are actually part of the removable M.2
> +	 * card and not the CRD mainboard. Need to describe this differently.

This is not a CRD, I think?

> +	 * Functionally it works correctly, because all we need to do is to
> +	 * turn on the actual 3.3V supply above.
> +	 */
> +	vreg_wcn_0p95: regulator-wcn-0p95 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_WCN_0P95";
> +		regulator-min-microvolt = <950000>;
> +		regulator-max-microvolt = <950000>;
> +
> +		vin-supply = <&vreg_wcn_3p3>;
> +	};
> +
> +	vreg_wcn_1p9: regulator-wcn-1p9 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_WCN_1P9";
> +		regulator-min-microvolt = <1900000>;
> +		regulator-max-microvolt = <1900000>;
> +
> +		vin-supply = <&vreg_wcn_3p3>;
> +	};
> +
> +	vreg_wcn_3p3: regulator-wcn-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_WCN_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 214 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&wcn_sw_en>;
> +		pinctrl-names = "default";
> +

regulator-boot-on?

> +		regulator-always-on;
> +	};
> +
> [...]
> +};
> +
> [...]
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dp0 {
> +	status = "okay";
> +};
> +
> +&mdss_dp0_out {
> +	data-lanes = <0 1>;

This is unneeded unless you really want to limit this to just 2 lanes.
x1e80100.dtsi specifies 4 lanes by default.

> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +};
> +
> +&mdss_dp1 {
> +	status = "okay";
> +};
> +
> +&mdss_dp1_out {
> +	data-lanes = <0 1>;

Same here.

> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +};
> +
> +&mdss_dp2 {
> +	status = "okay";
> +};
> +
> +&mdss_dp2_out {
> +	data-lanes = <0 1>;

And here.

> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +};
> +
> +&mdss_dp3 {
> +	/delete-property/ #sound-dai-cells;

You need to define pinctrl for the HPD pin here.

Thanks,
Stephan

