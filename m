Return-Path: <linux-kernel+bounces-855764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E1BE23BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E40D19A6D62
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FFA30C617;
	Thu, 16 Oct 2025 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1QxQ0f9"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22892E426A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604890; cv=none; b=LDkH2An04Wriq+pWsA9GgSxqrb5j30AMHjVy2gxf2lBfwLAOwLTQTqTD7RmPKAzq9UrpeFMqIT6AaxwLM49+x72m31d+EHWUw4y/muwpTC1lJsmbBcYBz4sssXhOUnwT5ZWMKw1IwFeF1Gt101l7Wgo3+3DsP8jaaqdCnLIHiz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604890; c=relaxed/simple;
	bh=2rafzbMdaFeNafw0cDwUzS/gvaRAPFh8RUG59mmAZ9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et/cyRGCDP0dSmTVY82C8n2wI0hq8chn6DR5IWQ3FVr5boaIRdDOXYZnW/mDCNFCYyqC9/yJ5BmIJu12Kz5LT2FVAdd09hIRoMVWbJYoNSEA0zhPfJvdCNDML3EXmuJtY8bk7aBfnE4f1+NqLuGr9HQXdt7dRN6iNlTjVby/SIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1QxQ0f9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2909448641eso4458915ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760604887; x=1761209687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4MgLhWrjcTr2cAQ96NvgwB/k2TVFLBgEuk088GaLCgY=;
        b=U1QxQ0f9SMhcZLFc+jR1xLB7zZbSxZR4OwlrqaB5TJU7As0P5O3rasRdvPT3jos4C/
         0ZnHx0N68ma6orHXjpGfibuvq8OXoSqaZC+dtJNFwqbAgXExR54BBAKYHQjrmxRx3mrc
         QSRGTNYbVPzqaX4g7mFG7kM9mMaP/RQxRoFtbhVRvDQ8llIUrOJjOciwUWz23OZVYTp1
         7ebzLq33w9EWpTWivd/IKXTxyiW9b3umx3Hr7gx1ycQdNv/nKGTY+usV3vodcpxwmGpn
         maq3MZIFjd1BMp/f8JCTaDQ6VcaMA7wCcXbVvjbA8JY8kQ3f+sGYlNLyUcR3lbQp54tk
         QPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760604887; x=1761209687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4MgLhWrjcTr2cAQ96NvgwB/k2TVFLBgEuk088GaLCgY=;
        b=auuvQQLESBau5ivLdusd2MyqKOOhRUAawYjxVnbLbBrzeczJtBty3FDlU3PBvMem+d
         oYljFqJ42ymzoRHtFU6dieb4fUIrN7DwTMmNPwwvfXQa+t9kip1Wi0QSDhA/2d5cPrHF
         oZr+ntyUYcyymvyYe0FIFKrXzOfpSXuiyCURvyOuZHLZqDiUHD/pAgnX/CIXxv7s7gn6
         g8pbfhLqcEn0q6jC16HgkoqGZ5kxwSxB1b/pR8DAp7UaHOMpvGPHq6Hkl3tz9tUgeyxL
         6jRs3BifXn2NLUsZeOGl2rLni6UWtFpEeTZQl2tl28tWAsrk+bMMtf2F8CQ1oJfYV3hO
         +MCw==
X-Forwarded-Encrypted: i=1; AJvYcCVblIXamU7PYkPAEiGLxSDGYEGhM69VSzxSfV/d9AfUfZs4PxojuRx1lDKX/G0BUF0LptYGzvRsrxFcYVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYuwzKDulUkLu8k32bJLRa7yaWyk9uqsEvH0jRGZ4aFUBCpso+
	noOoe3PDoDmpyCobIXpPrcEig6AmwxjBvLNsBwzajx8DX6Y/1r1ixLj73BPlRg==
X-Gm-Gg: ASbGncvhIdNVtLWAUr2NjBvVQHbeGNG98AAorUQFLEZwUux3Qi5vXmr1Qe+reVcHEDz
	VaTG36WEVdFZ411PidHfKeyWSeu1Z317dfHg57BbMs1D9qlz7CkmeN9tJ9/mGsqBoj4lmVBRjBa
	zFKbcfXgSWwS9q1VAVPDKh3QjfnO3XOUwmzEESMGpw2ZvvYOkxeND8VaDu54WhBZnWZiod8TjeE
	rebuZt8DvAMsp6EO7MqRGpMhJpfoQPclOhE2HfUpiLrKr9jGjHEexlh0KJcyzioVb8mSjNTPRfS
	KNBsqShfuOemo44SGODX6DgQQ0Lo9iQ2m/j/W8f9MtXu/wJuRxzuLo5zWz2O/tfDOC/IoJ7qrp1
	K1GE0ZYIRicIpIttDPM2AcPipzbdKAkagJA5bOyPCd9IDAvTcrX7fhYAJ/fe0YLwlaebkPEwub1
	b+3Dh4qp3e95yV
X-Google-Smtp-Source: AGHT+IGxQpJfY65arfEGOquKzS1b9C8R+GcQ0oDHqQfexd6OPIIVXxr+NOuDLtw1djCFkYpeS7J+QQ==
X-Received: by 2002:a17:902:d4c2:b0:274:506d:7fcc with SMTP id d9443c01a7336-290918cbc9bmr44520025ad.6.1760604886790;
        Thu, 16 Oct 2025 01:54:46 -0700 (PDT)
Received: from [172.17.49.162] ([103.218.174.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb66a22a6sm1043470a91.15.2025.10.16.01.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 01:54:46 -0700 (PDT)
Message-ID: <b3390184-a3ef-49f6-8b68-dbf94564ab43@gmail.com>
Date: Thu, 16 Oct 2025 14:24:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: talos-evk: Add ADV7535 DSI-to-HDMI
 bridge
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251015122808.1986627-1-tessolveupstream@gmail.com>
 <53ef53b423uespn7xspqfxnnvqvhzb5b22a4oaimf6g2qy7ruo@273oegazxbaz>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <53ef53b423uespn7xspqfxnnvqvhzb5b22a4oaimf6g2qy7ruo@273oegazxbaz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/10/25 18:34, Dmitry Baryshkov wrote:
> On Wed, Oct 15, 2025 at 05:58:08PM +0530, Sudarshan Shetty wrote:
>> Hook up the ADV7535 DSI-to-HDMI bridge on the QCS615 Talos EVK board.
>> This provides HDMI output through the external DSI-to-HDMI converter.
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>> ---
>>  arch/arm64/boot/dts/qcom/talos-evk-som.dtsi | 21 ++++++
>>  arch/arm64/boot/dts/qcom/talos-evk.dts      | 76 +++++++++++++++++++++
>>  2 files changed, 97 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi b/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
>> index 55ec8034103d..b58cae02c9cb 100644
>> --- a/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
>> @@ -244,6 +244,27 @@ eeprom@5f {
>>  	};
>>  };
>>  
>> +&mdss {
>> +	status = "okay";
>> +};
>> +
>> +&mdss_dsi0 {
>> +	vdda-supply = <&vreg_l11a>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&mdss_dsi0_out {
>> +	remote-endpoint = <&adv7535_in>;
>> +	data-lanes = <0 1 2 3>;
>> +};
>> +
>> +&mdss_dsi0_phy {
>> +	vdds-supply = <&vreg_l5a>;
>> +
>> +	status = "okay";
>> +};
>> +
>>  &pcie {
>>  	perst-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
>>  	wake-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
>> diff --git a/arch/arm64/boot/dts/qcom/talos-evk.dts b/arch/arm64/boot/dts/qcom/talos-evk.dts
>> index 25057f4f6a91..f7e8be3667d1 100644
>> --- a/arch/arm64/boot/dts/qcom/talos-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/talos-evk.dts
>> @@ -14,6 +14,82 @@ / {
>>  	aliases {
>>  		mmc1 = &sdhc_2;
>>  	};
>> +
>> +	hdmi-out {
>> +		compatible = "hdmi-connector";
>> +		type = "d";
>> +
>> +		port {
>> +			hdmi_con_out: endpoint {
>> +				remote-endpoint = <&adv7535_out>;
>> +			};
>> +		};
>> +	};
>> +
>> +	vreg_v1p2_out: regulator-v1p2-out {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vreg-v1p2-out";
>> +		regulator-min-microvolt = <1200000>;
>> +		regulator-max-microvolt = <1200000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
>> +
>> +	vreg_v1p8_out: regulator-v1p8-out {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vreg-v1p8-out";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
>> +
>> +	vreg_v3p3_out: regulator-v3p3-out {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vreg-v3p3-out";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
> 
> Please describe the power grid. Are these regulators being fed by
> nothing and generating energy from the thin air?

Thanks for the feedback.
You are right — in the previous patch, the regulators appeared
to have no source, which was incorrect.

To clarify the hardware design:
The 3.3 V and 1.8 V supplies to the HDMI controller are not coming 
from the PMIC. They are generated on the carrier board as follows:

20 V (USBC_VBUS_IN) → 5 V rail (V5P0_OUT)
→ 3.3 V buck regulator (RAA211250) and 1.8 V LDO (TPS7A9101).

The 5 V rail (V5P0_OUT) acts as the input supply for both regulators.
Both regulators are always on.

example:
v5p0_out: regulator-v5p0-out {
    compatible = "regulator-fixed";
    regulator-name = "v5p0_out";
    regulator-min-microvolt = <5000000>;
    regulator-max-microvolt = <5000000>;
    regulator-always-on;
    regulator-boot-on;
};

v3p3_out: regulator-v3p3-out {
    compatible = "regulator-fixed";
    regulator-name = "v3p3_out";
    regulator-min-microvolt = <3300000>;
    regulator-max-microvolt = <3300000>;
    vin-supply = <&v5p0_out>;
    regulator-always-on;
    regulator-boot-on;
};

v1p8_out: regulator-v1p8-out {
    compatible = "regulator-fixed";
    regulator-name = "v1p8_out";
    regulator-min-microvolt = <1800000>;
    regulator-max-microvolt = <1800000>;
    vin-supply = <&v5p0_out>;
    regulator-always-on;
    regulator-boot-on;
};

These reflect the actual power grid of the board.
The 20 V input is not modeled since it’s a raw external
supply and not managed by Linux.

Please let me know if this structure looks acceptable,
Thanks again for the review and guidance!
> 
>> +};
>> +
>> +&i2c1 {
>> +	clock-frequency = <400000>;
>> +
>> +	status = "okay";
>> +
>> +	adv7535: adv7535@3d {
>> +		compatible = "adi,adv7535";
>> +		reg = <0x3d>;
>> +		avdd-supply = <&vreg_v1p8_out>;
>> +		dvdd-supply = <&vreg_v1p8_out>;
>> +		pvdd-supply = <&vreg_v1p8_out>;
>> +		a2vdd-supply = <&vreg_v1p8_out>;
>> +		v3p3-supply = <&vreg_v3p3_out>;
>> +		v1p2-supply = <&vreg_v1p2_out>;
> 
> I think this is not correct. Please consult your schematics isntead of
> adding dummy regulators.

Will take care in v2 patch.
> 
> 


