Return-Path: <linux-kernel+bounces-820206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D44B800EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C20D164505
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9490306B13;
	Wed, 17 Sep 2025 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MIaj6d43"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAE3054FB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096420; cv=none; b=Fkh8MDOE0GBwY9qcFdQPgn4abfH3bZowZO4Wlo08FUe7v/Huww9Rwb4A62xA+yy8vT0CdMQs83rTNclJ0TSlW9vCYrNKjKilItThtnIgOA6D8tbHuwOfstK0v5YNXhiD4+Va2R4eh9eNH3VzGNsEeSQrudhJXcmm6ATG1r0kxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096420; c=relaxed/simple;
	bh=99E/Q8dl1z6a1fSwTsa33XnQl0e7pN1bDPF/vKPOGmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRyE+gSVZEiaHtIjo5FZq/ED88lu34DFM8PxvlNeFSx6foh2oHX7OgEUzGAe8CV4Ng+fbg7ED48LaLj3vnCHlB8imwDjw9RPvj8e8NC4UAhqqZi2toNchTOLJilTEtZysPdWnMmT18shUwNV34+S7Dvs3zr/bEmYFTS0laFWXYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MIaj6d43; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H5QXMk001462
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c4+1T7hrQrCbgIKXWS+wJqveQlpBa3wYZt9yOaHwkvU=; b=MIaj6d43UK9ZQSx8
	agM81e5wqoSWBC63D43WjsF1gm5IB6k/xb2BpVZo02QhE//HDj4YZ0HW4pKmu6K4
	aBDGT3bH/DZIWE5OLCyG7elAqlIIaR9pO5kL+zq2+Uaq/raR82fc0MvpWJOAC/A6
	I6qnI2kA6wvFxm+Iz42kP1C15JzKsqH5jKlFIvI7h7hhWtNLPcMcTdpZbXLQADtS
	y/3kf/z0catX7heqa8vF7T0miUEZknxZ99Sc7Jhry8IApYEKsozHOqTGI8vkraD3
	hrseruWwNV7XY02zlHATrDUAUvvXqkTdl/8tkjyZMWyc6W4rbvXFNx9vEo/cA8yH
	w/bkWQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxw9hag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:06:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2681623f927so4243565ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096417; x=1758701217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4+1T7hrQrCbgIKXWS+wJqveQlpBa3wYZt9yOaHwkvU=;
        b=CyiTmAir5Upy9xvjNxV1krQbimsbQ1WC+/SUpJ6ixH9bjOcpc4mq6+/qxFe8vE3xmN
         XGvi91rUVXeLBiSfKxad96LZZlSnBHP1nEVKWDUafVaSms7eSiwOpn3QK2H08Ee9ZhkO
         rtI0dgtxmUWQ/l4cIin9kvYzMRsUJyKktw5npXjBQLMV2p7Oz9WFe48rYeNsHkEy2nr1
         lM5b7vcp/22j9shwIUJMpEpGyrocmXfKZPcfyxOghoW0JlOoc0AUICWAhBDcKVUKXQ2U
         /gSzdAEWjcRMOTZmE7oKUZHV3JBs1p4oNHpuLzXKSIqHq+ddWOch3/7gn3mOxFhhIhe0
         hgbA==
X-Forwarded-Encrypted: i=1; AJvYcCVKmmORT0a65jDrqPaqEC5l9q4Zxt6VHtqjUl7RdME8jHUzJKeARVEUSSwh3j9ecwosZ9sEEJoX6AQ0oNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLHUQi5wyTPz2OkJSPvbxO3mtwCwcTdQNnowbHs9SNQ/4yoRV
	nHSDu3kTCLTe3W50ANFVzvuHZUQZO5iSEbkitkNigHqvCCLHyRWv6sFJWoME9qeCeV8Q/CW5iWN
	0T8/yT67OZBhhjOcrKCP4QnNCYnWcNTgZfW/BVmcKU73qms9U0bFwU7X366bt0aI64G0=
X-Gm-Gg: ASbGncs7t2xbUSgzDs30EA8x9k4tly41pzIV31PEF2vE4EyHwMV+R3YXaYWOOxNTMDT
	ilwJJVs2pFXeHo9o+VuPPIMweoV2GDVGAVgIgP92SM+gHAVP4Il22ceU0ciC49YgY8PVeIEA7uK
	OZNKSXQxfrRZP3Lmgs/ImC8dxnIrdrk7pbKSYOQpWByJGk07bOy7okMIcMgRf/3dvhTBr24zaG3
	9JkGpCqychBzBeHgtbYNdbbA0nBAJAYJpj5FNy9ietPMqvKUATl/QNyRecZpk7e5iSQHpQe48jB
	k4CreAGLbgIQnp2TdAwQRlrtToN6oGeDwmueJaZoSspRsLCjj0cffjA=
X-Received: by 2002:a17:903:8ce:b0:24b:1609:5e2b with SMTP id d9443c01a7336-268119b3b6emr16788415ad.5.1758096417023;
        Wed, 17 Sep 2025 01:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5UMbMaWJIzZ57Vql1tJjVuAN5j2QcuMqGy0y+1atO6oPbE3RHp/4BjwtArBerLWUYCCdoJg==
X-Received: by 2002:a17:903:8ce:b0:24b:1609:5e2b with SMTP id d9443c01a7336-268119b3b6emr16788085ad.5.1758096416585;
        Wed, 17 Sep 2025 01:06:56 -0700 (PDT)
Received: from work ([120.60.54.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ee223f2ecsm1177088a91.18.2025.09.17.01.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:06:56 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:36:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Subject: Re: [PATCH v5 05/10] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
Message-ID: <h2t7ajhtyq3vivbw67tifrn73i4zisicoktsgab76zptxre6at@vl2q4d6i3lms>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-5-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916-lemans-evk-bu-v5-5-53d7d206669d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68ca6c22 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=zfGe9qrPU0lfmTaoSSnydg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=qGp1FZVzPMbQ2NxWyGYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzgC6YTIJiQPO
 JUMFt1suJKwNaXk18curGufrMHNTDhLD5h4PPs+OGtlbaV9K/0OerlIOEAZQPyliP0lgN0VNoiB
 Fryw85q9NqdcfyQ/gshlX9+80ANqRU5BtFtUuZV/h4qq/o44E5MVqgSxo/je8XJ/r9LMjaGCYYB
 PD4wyc/0Bb5PLnUjMbhGU0LCZgPnPd9OYBZoqqLQ9oXkSJdzvwOp4Ned3rubWmclSvOHD25TDTg
 JGRaC8lT/7qVHnJHnlYVBpo8rV91zjcXj6dlZrEiDkwaR2krIpsuTQGZRRs+YyE7SSHQMgnn/Dt
 SK5r9zIklypfu2y9W9cJWgBQdUAvQ1AUs3Ml8fw3N1izt9iGpTYwClttfCTVRrRBgt7VhLUdlPY
 btdP0zeM
X-Proofpoint-GUID: Rvttzo4C7nUUCwVtKhqPd1rev8jYqgRj
X-Proofpoint-ORIG-GUID: Rvttzo4C7nUUCwVtKhqPd1rev8jYqgRj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On Tue, Sep 16, 2025 at 04:16:53PM GMT, Wasim Nazir wrote:
> From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> 
> Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> 
> PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> 

Where did you define the supply for M.2 connector? We don't have a proper
binding for M.2 today, but atleast the supply should be modeled as a fixed
regulator with EN GPIOs as like other boards.

- Mani

> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 82 +++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index 97428d9e3e41..99400ff12cfd 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -431,6 +431,40 @@ &mdss0_dp1_phy {
>  	status = "okay";
>  };
>  
> +&pcie0 {
> +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-0 = <&pcie0_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	vdda-phy-supply = <&vreg_l5a>;
> +	vdda-pll-supply = <&vreg_l1c>;
> +
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	perst-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-0 = <&pcie1_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie1_phy {
> +	vdda-phy-supply = <&vreg_l5a>;
> +	vdda-pll-supply = <&vreg_l1c>;
> +
> +	status = "okay";
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> @@ -447,6 +481,54 @@ &sleep_clk {
>  	clock-frequency = <32768>;
>  };
>  
> +&tlmm {
> +	pcie0_default_state: pcie0-default-state {
> +		clkreq-pins {
> +			pins = "gpio1";
> +			function = "pcie0_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-pins {
> +			pins = "gpio2";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		wake-pins {
> +			pins = "gpio0";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie1_default_state: pcie1-default-state {
> +		clkreq-pins {
> +			pins = "gpio3";
> +			function = "pcie1_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-pins {
> +			pins = "gpio4";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		wake-pins {
> +			pins = "gpio5";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +};
> +
>  &uart10 {
>  	compatible = "qcom,geni-debug-uart";
>  	pinctrl-0 = <&qup_uart10_default>;
> 
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்

