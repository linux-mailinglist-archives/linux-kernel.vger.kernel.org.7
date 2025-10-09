Return-Path: <linux-kernel+bounces-846800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2925FBC9126
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926183C85B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156F2E5B05;
	Thu,  9 Oct 2025 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="abuXGtr4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478FE2E370C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013474; cv=none; b=uDIm2zlVQJzI+vH3ejkjLV6yg14zfzyWHETGq61ouYTAWgdqwzASbpGYrrYRjhvRvV4AEd48Q6nmXRkQ9MKJmx1xO8bxUUi4vMgw46ta1sdHa3MQoyCRKbbGnem8Tws1T0EAdWQe2cp6giVBB6BL977OyVRf+rcLrrSgmqk/B3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013474; c=relaxed/simple;
	bh=extWvGEBxrY3ETxBN/CqvhubWG0rD3e1PdiYCRNJwW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXdq+t3JIPatmhvzb+b01MdNElUt2u0kgk+e/W4mLPFeS7ial2+0f7/jmnnplgfiUw3Y72O4sWwEZxO86bl4wDv1N/z2Snwt8jqqzbc+nJsNUp/QUv9FNMAQnou/tqWgdohM4eKPncoHAkGgyOwETlzzg83g3oCHfpkmVVoCFy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=abuXGtr4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EILp004368
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 12:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vt3cDHWikNa21LQEjco3qqYXJZL0zCP7HIhZv/yAhcQ=; b=abuXGtr40tJ/LEyX
	T4LQemW84W7rh/tqT9TeZk2JdMoV3GsTkel/FnLrMiRwXob/OBkZ7/k6VNt45/ow
	K6UnepOFS11V/N24CDj6Yzgeej/4imHqk8bGlkV2Q8iWzyftSp8WvIaBk3pxxu87
	E6WbuLSUSNqSfKDqnYm9CIdJnTXEFLsuEBFJD0UVNGcK/dbrNrCZ8M+Qk9i1926e
	xzdzAOTITSGgLr/DRoKLSi76R2y2nvU3ric1w70N4R5ipvmcrsh8OO59xuAHagm1
	0PYgSWbH9BMufm1eK9MTBc5/ZX/nnVyd7eoIaJRFjp+U/Mnv9JMXfvmM4TpsEJLo
	i+vF+A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j2s27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:37:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-85696c12803so47390085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760013470; x=1760618270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vt3cDHWikNa21LQEjco3qqYXJZL0zCP7HIhZv/yAhcQ=;
        b=JnTRlCxmPAKnK2b7kCLrB8GB33wEuJvnxF21sAjd9AZpM+tdp4Wv/+BgzkR3azGHhn
         b0gOkp6aYBcEoNXmNGFlcdfUfS87ZrDFrg+E+oeYbqkoLwQn0r9y0aKHITAFfZcd1+B7
         ynbl+2dUso1+m0R5y4Ibgm7zbLbRqJkEiHYDwFTXvO8AbImp9CuqlFd+CdIWKIumdVvA
         XV/BSEccfdPDeYGcs37QsLx4bWpf2QBOXkQOiehsyAlhK2LqOHVUXE+Z2yJRaz2ZycIB
         f/qN5q3vYtdcWVEXGbSFlXo8e2qcknqRZ+VgYKGqcJXtgGywqEfZIy5Tr2QsvfSLKme8
         8bZA==
X-Forwarded-Encrypted: i=1; AJvYcCWWHWwPfE8UsHZ/rJ68jshtNtIN99JzNPGGxJ8MaKVxssttie5Psv09kqXK7mjTsyVr6mdVKUsDwZEC1Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+FK6fdU1/ieOe6S1a6EHHf1axrQmQKmfdbnjDeq91oanOZoZV
	dM9bh3etFp1Iw20RQsSQdooaqwsKL70Nvy4YIEa9V6fvU2pv4WVFFteERWlXYp07NGUCUdqddlr
	AV7tXTxVGPk2ZuLQC0YZooH3g1DwTnwNpS5b8Yb1AhqktmzF4A1O+rV2syk3UELT/R/E=
X-Gm-Gg: ASbGncu0ddXpqC0yjy6SlVDtA6BhUs211rKvJFhPSrdk578Kch3KY1hk2kxWPqkdtQs
	cU2Bv6cnYTbnYnLMuUV5r39/CfWu+fcXIFrsld7xIND8bPqfSbK1hepmbRYOvkOWn8faIX80my9
	GyGrG9WNC7jO116gJX2RuRILdu1uLWtQKWlywo6rF3+yhFh5j3pdy0akh7FpoT5gjM5eMw5xxSO
	FCjtf5e6ef3HBtdslkbbdyTKNP5S4Att5H1rAVDlurbRTrICtplaM3NFdJmb0/HKeuZ4bKV/G0q
	6AvLqxiOQXqyDm0a1JhwkQNJdX1lKLBdAOsJuj39L06Bc1HCQl20JpSmzMcyRgLoP4+mq6vYm7L
	4UHlUSdBQTOKgamS55krLqcVsIy8=
X-Received: by 2002:a05:620a:17a7:b0:812:81c6:266c with SMTP id af79cd13be357-8835420965cmr638941785a.9.1760013470037;
        Thu, 09 Oct 2025 05:37:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCPlbTf9kz9wyqlteOqkK6kI8LCXLa/DHZ3rb8BsF1nhSSwC936OYw2CJ8McbVnr+gjPtCUQ==
X-Received: by 2002:a05:620a:17a7:b0:812:81c6:266c with SMTP id af79cd13be357-8835420965cmr638933485a.9.1760013468748;
        Thu, 09 Oct 2025 05:37:48 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4e49esm1888759866b.72.2025.10.09.05.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 05:37:48 -0700 (PDT)
Message-ID: <488d9182-175e-47a9-9dc1-f43753d6fdbc@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 14:37:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/6] arm64: dts: qcom: sm8450-hdk: Enable I2S for
 HDMI
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251008-topic-sm8x50-next-hdk-i2s-v2-0-6b7d38d4ad5e@linaro.org>
 <20251008-topic-sm8x50-next-hdk-i2s-v2-4-6b7d38d4ad5e@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008-topic-sm8x50-next-hdk-i2s-v2-4-6b7d38d4ad5e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uE63fM7qywW62i5ucqxa6y05J46wqV3j
X-Proofpoint-ORIG-GUID: uE63fM7qywW62i5ucqxa6y05J46wqV3j
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e7ac9f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=m35xbnh7LrWQ_H9zj4oA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX/cnzqoxRu9Iv
 GyWA7/L++os04xl+QKq/4XW7IHn2C0efsBlv0uKCVJxfmH0tQrS6OxDncwKcmnIyRG/Zj+gXUaJ
 dYEC35nnrSvG+wB2p++zj/dH3mbqRF9p9NHkAVBrc3QVPQxFC8LJLn/lifiFP0Lusb8xADAG1a+
 kygBbmDWNd8KfFM3wLHs/q3R3V5/fTBiHELUzoCC6sTnQSXaCBxBrV0GVouK/DLANHfX38MKUdb
 uDLz5v6bZ+6/uKgLQkLyQ1lta8QFpBhZnMqaxrhoYAX02NEMNYW8rT+6htCIHeQWqY+qRmDwFVr
 XP+6FMQLJbDwmAW78NwvivhgQR9Uj9JtK9Ct00H1X4X39RCOJDpZXo2G4QDm4VE4SO6AtuAup2H
 wF6Z97JrRR0+bVRfeENPtkOo3ksvlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/8/25 8:56 PM, Neil Armstrong wrote:
> Add the necessary nodes to configure the right I2S interface
> to output audio via the DSI HDMI bridge.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 26 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8450.dtsi    | 40 +++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index 0c6aa7ddf43263f30595b3f0733ec3e126e38608..7b822086a57c600ae9b5668d6d7a375d0ec55fa7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -667,6 +667,8 @@ lt9611_codec: hdmi-bridge@2b {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&lt9611_irq_pin &lt9611_rst_pin>;
>  
> +		#sound-dai-cells = <1>;
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -1016,6 +1018,14 @@ &sound {
>  			"TX SWR_INPUT0", "ADC3_OUTPUT",
>  			"TX SWR_INPUT1", "ADC4_OUTPUT";
>  
> +	pinctrl-0 = <&i2s0_default_state>, <&audio_mclk0_default_state>;
> +	pinctrl-names = "default";
> +
> +	clocks = <&q6prmcc LPASS_CLK_ID_PRI_MI2S_IBIT LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +		 <&q6prmcc LPASS_CLK_ID_MCLK_1 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +	clock-names = "primart-mi2s",

"primary-mi2s"

[...]

> +			audio_mclk0_default_state: audio-mclk0-default-state {
> +				pins = "gpio125";
> +				function = "pri_mi2s";
> +				drive-strength = <8>;
> +				bias-disable;
> +				output-high;
> +			};
> +
> +			i2s0_default_state: i2s0-default-state {
> +				sck-pins {
> +					pins = "gpio126";
> +					function = "mi2s0_sck";
> +					drive-strength = <8>;
> +					bias-disable;
> +					output-high;

I doubt output-high for a clock pin is what you want..

> +				};
> +
> +				data0-pins {
> +					pins = "gpio127";
> +					function = "mi2s0_data0";
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +
> +				data1-pins {
> +					pins = "gpio128";
> +					function = "mi2s0_data1";
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +
> +				ws-pins {
> +					pins = "gpio129";
> +					function = "mi2s0_ws";
> +					drive-strength = <8>;
> +					bias-disable;
> +					output-high;

here too

Konrad

