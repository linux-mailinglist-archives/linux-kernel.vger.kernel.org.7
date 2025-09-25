Return-Path: <linux-kernel+bounces-832280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473FFB9ECF2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DFD175085
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB12E2F90E6;
	Thu, 25 Sep 2025 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cvQAuu9q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632052F90D6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797234; cv=none; b=NXAmK8n+hp8T19zfQgy8a/Rl54pLbb8ipRm/vPolCqPf8ELBnpqbq3q45iN68AHzBOlKx2i8fFYjjxSH4SFtl5uTlvKpb4cQNMkpBiVVMS5Q4r3Ipz0+Ub1jX7oIj+uWu52O9wd37VCiKMYF+eMG3P0VeyLjF6TKa5vC6nibg5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797234; c=relaxed/simple;
	bh=kA/W8j57qUwRf6Pe0hZo/Qn/kO9UwhDxztWC+vH3KNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ma9LpkSzSF2FXNjROX+XqwVVUlWYDqTAl4H5cUZyk6TYWLSZP9M/mPyjtzhkyTn62wK222uWTx3nVIr7HpIv/9hIaNkcoXAKQzr2Ftr11LkhfAGYbRdIM5JlN00fz0GIbWTRyJ/SW57swwCbDUs4esAE9Qvm2YND8nLf62jRF8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cvQAuu9q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PA7mxJ029604
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ap9zsKuKlu5pNRSUb04qd8s5OqnjzWt1Q5GsG3WWIsw=; b=cvQAuu9q6gCUC959
	JgjrF6Rk20T8plh1fWaGVlr/rrKulvhtw091dT1T+gRp137bXcwFuFMl3NDg25G3
	t7gAj3sFXSF+WNSVxbrfdIJ/JXXIBLi8+WDNBIE++Qzaaslm9iWIXm+HOF1m6AuH
	8MOS4OMxb4ICMcOoSwjvHPLlAwA7DR+DuQXbt3oCmx5oh9QaBrnFWd+oy+KFVXNY
	yElK1bXJSOwyZc/JRzGMK4xwcggiIHoF/04Vm8qOkOydGrndpK0I8MNxgLscBIQK
	XIEvOFDfL6D5vRpDe+eweKjc3CKe/rt5JohhEzwdnjA58LJibx5iq5AQgmCeRTqM
	fDUqCw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fqp2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:47:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-850dfe24644so35027185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758797230; x=1759402030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ap9zsKuKlu5pNRSUb04qd8s5OqnjzWt1Q5GsG3WWIsw=;
        b=DSrQbnFa5vAEe0hE3uiIAX09V03uOGnc8CU03Yerod10dPGJxjdIsQx8shLFXban9t
         fwlYZIqzx/n2sUt0LmLTjXJ27C1c7EuezFmBmtBHbaA4qIDMVPE1fQ2wmD1jjO6zWwN6
         R3E4n0ogM2M0FFBe7Jwk17Tv92toqzbZW2OBrZ8dO7KbvrbTxTX9nH7Fg/1ydQhEToL0
         w0TCFrwaoA2mTPu58dJd4zT1ZrRmD8USww9rm9szSzd6t1R6+6rf3tWKgfg/E/0FEx6O
         F2DXPB85gINSprYwnFlqicdo/Hhnv5m4t2ynnlFHoTmI1WlRFhz+Xt1C5TOU6IyOVzRV
         OBtw==
X-Forwarded-Encrypted: i=1; AJvYcCU5S/Kq2t5hPctCOUWUEVpe7jyjVoJARMe+Ao9sAbD74+VQiTYO1TSfh1a4Tm7Rpz3EnTMaM8CrcQZBuXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7uCYzLVZC7WT7cTpHUyqkTZoEgaCQJ8nzpwkjOQSBLjGJU++9
	Q8JqOJP0BTGI7meuL0eIbnh103Yt0S3Yojk9TgQbFEvHxSvcWwDPoUEByjiBDLXPiSdDSmPu3un
	jlUwwMrP0Ve6k4idhDJiGGm1EkpTjGCgC+XDur8vthlmaIGg/FGjkZt6s+Cs8sPSe9UE=
X-Gm-Gg: ASbGnctUXNgKdRdQBM41kAvqklG7Z951BWjqt/QXBAQGzqvslHueNvwc2rOnppntYI2
	ZAJCx+5Z0i9umaLaaS7E+G6nmW89Rxup2h204ZZLYtt2dPbZdjF3/GOkFKWXpV+cMOenUWCibRA
	UmYKjtWrCQHLkCtynt4GqZ2dPOiBtOSI8p6POS29H14bhKxixte6paR0vfBHLezBvAsQ4QNsLNc
	/43ftRKCyVbNuchSsra6bKN4btRC3WtKBQ6ieZKgHG6J9HbuKTdRqwvMosVjfaWHIq2br7ogP4D
	5FTgk7Al1Xf6+oyw2TXWqy/sU0Lr4vBHG0K4sO3u2RsuC+WjldD0FE80LitbKdkcugV8pHCr3xB
	Z4meJ3+1mcIDuwi0nVpqoZg==
X-Received: by 2002:ac8:5d56:0:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4da482d67b4mr26593211cf.4.1758797230223;
        Thu, 25 Sep 2025 03:47:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPlsCdSBp4lVFO9DqRFAK2J6u8/Y0Vcz4TcgQGFKzP4hjuFZPhw5/Mpkap+CC2vkrjuvanDw==
X-Received: by 2002:ac8:5d56:0:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4da482d67b4mr26592921cf.4.1758797229601;
        Thu, 25 Sep 2025 03:47:09 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa4696sm141562866b.27.2025.09.25.03.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:47:08 -0700 (PDT)
Message-ID: <2eff7705-8d85-4c48-820b-bb9d2095995a@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:47:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: qcs6490: Introduce Radxa Dragon
 Q6A
To: Xilin Wu <sophon@radxa.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250924-radxa-dragon-q6a-v4-0-10d584f2c806@radxa.com>
 <20250924-radxa-dragon-q6a-v4-2-10d584f2c806@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-radxa-dragon-q6a-v4-2-10d584f2c806@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: K1_4BDsTA1WDbqRuDzNNeG8KCJyNuCr6
X-Proofpoint-GUID: K1_4BDsTA1WDbqRuDzNNeG8KCJyNuCr6
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d51daf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=ksxQWNrZAAAA:8 a=EUspDBNiAAAA:8
 a=JC7H1UVUsGpFjcbbhlEA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX3QLpy2Su+HOB
 5sGijvFpzkxQSW8/yt0J+DX+Usl2S4gsUj636yw9nMYgQH47fpT4McgOWIfsa9NTHDzeKN3nLo5
 Ra/KZYUhUejaBYhOzR81TSQWJvVVEgxZlA9PBgHZKUbMHyINX4Iu1mcpJpYTTYb/efeUJgBpUx2
 GTDRcIuKjW+X61G28T8QzjeEV3wsuM3LzqTNCPTTSQ2W5qonv+3/Ulw3B4ql474RRZSnZ03dXZR
 ubLz1hiVPz7KzsF4/efFbBBjp8rJZonuYRg4eWoL7xjuosMRjH+Xeo5egKUD0KTPdwQgx9Y4VR/
 BcFF80Q5ZO8PbTIk31FLyuYAwU+OtzkS4tOnuQcFS4wkTNApKx5y46bs4TSBHbHrAMFlz/EAYuS
 5bHhZqF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On 9/24/25 5:07 PM, Xilin Wu wrote:
> Radxa Dragon Q6A is a single board computer, based on the Qualcomm
> QCS6490 platform.
> 
> Features enabled and working:
> 
> - Configurable I2C/SPI/UART from 40-Pin GPIO
> - Three USB-A 2.0 ports
> - RTL8111K Ethernet connected to PCIe0
> - eMMC module
> - SD card
> - M.2 M-Key 2230 PCIe 3.0 x2
> - Headphone jack
> - Onboard thermal sensors
> - QSPI controller for updating boot firmware
> - ADSP remoteproc (Type-C and charging features disabled in firmware)
> - CDSP remoteproc (for AI applications using QNN)
> - Venus video encode and decode accelerator
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---

[...]

> +	leds {
> +		compatible = "gpio-leds";
> +
> +		pinctrl-0 = <&user_led>;
> +		pinctrl-names = "default";
> +
> +		user-led {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_HEARTBEAT;
> +			gpios = <&tlmm 42 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";

"panic-indicator"?

[...]

> +&qspi {
> +	/* It's not possible to use QSPI with iommu */
> +	/* due to an error in qcom_smmu_write_s2cr */
> +	/delete-property/ iommus;

I would assume this is going to apply to all non-Chrome kodiak devices

[...]

> +&sound {
> +	compatible = "qcom,qcs6490-rb3gen2-sndcard";
> +	model = "QCS6490-Radxa-Dragon-Q6A";
> +
> +	audio-routing =
> +		"IN1_HPHL", "HPHL_OUT",
> +		"IN2_HPHR", "HPHR_OUT",
> +		"AMIC2", "MIC BIAS2",
> +		"TX SWR_ADC1", "ADC2_OUTPUT";

odd line break

[...]

> +&usb_2_hsphy {
> +	status = "okay";

odd status-not-last

lgtm otherwise, thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

