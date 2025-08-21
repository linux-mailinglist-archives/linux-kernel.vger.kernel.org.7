Return-Path: <linux-kernel+bounces-779545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6FDB2F57C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91FC5605DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF363074B5;
	Thu, 21 Aug 2025 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GVVeM7wW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CED306D49
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772570; cv=none; b=FMoTK996waC+Mij3HUuvyx26xEUvPcZQNUw1zEepQdB0FP4P6Zrz4Jsqlru/E1VjhZRTT+j95lGez1jhYL+N5mBlD/D8vdKdfoC312/4P4mbVZLhjm4Fhe50jh2R34cveA+NKKvfT2BbKfnu4CbIdvVciss38hojhUT2u9o5qkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772570; c=relaxed/simple;
	bh=RDuV1besyzzDAzdyFeQhw0JwJepUWtsZGZmkP0nNXDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxNwA0nWK3VrmMToImtvXYhYNEaZSs4I3hVCYSv2k+vJftZOVhQm/NnC0hjV5NNulc4zX974Fr7hmTU7wls1aBsHhusbEU9Bln4pyT1vW1cZy0KoITCBXo4IHPn2F7BAiz7hdgWYglKTPM+azl7pUr9bGzD4Ryf2S6B7a051CnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GVVeM7wW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b9k7030611
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7oo2zqFqG/uy2ujzQIvz8umA
	iinujNdzdiBtiiHUTrI=; b=GVVeM7wW3PQpz36KtSKHXA79R1SZCspJcF5r9uyi
	OKQkaeZtpNw+/A1Whiwkh+K3IyE4EWBS+h2HQuOd8kZFr1tmWExrArY5Tyzfbe+P
	f0IlHRHGbcxxzNkS4t2tqpmWywHvE6EtMoScQuNk95ZSz16Fd/kjHi9+8zh9U8Kg
	3vc2yYdqviPozvZgOcdookVZ2SqHRKF0eT6ms42zB5gxuJZeznWCFhgjK4xWnsTp
	X3feIci0VaQupEf+oVnV0HPIDycorZNffGd7rl6WNeoJfrMzE4OMzVogFIpmbiTB
	LWeN6YI+RUm95Egq4aMINaq8O/3heQUHuxrgLAt6DmaZMQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a5644-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:36:08 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a88de1e26so26556036d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755772567; x=1756377367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oo2zqFqG/uy2ujzQIvz8umAiinujNdzdiBtiiHUTrI=;
        b=eaE5DqryqD0BOr0bNpWTPvZtON/TReUrHIG9ZJmHmxsxEqBKIBy9QqMVRtpshqmfQB
         8Dgf1eHu+sOJSfdnjD/lKAdbgSqCFJuCCJNpjiPlb6S+u4ZpuzY2GYZWHchHAC9Rf+xm
         01GjXILYWl2jMf3ZGSA8mz4dhicugIctiNiyd7M9wjM74MidZiPhDXF1Cul7OHiLx3k9
         HfOZlVk3qbMPo8rANB+qbXXA1FXMLAx70USUIYhJLKrBRjVqcIIuxbXvZQWA5eWFMIf7
         s1w1yOZbop3zjKthwxaN6RDg9Fo1ss65cDfx7iIkRmxz/ymcg7aufw2PmiX3oftRYgGS
         FaEw==
X-Forwarded-Encrypted: i=1; AJvYcCUMRY0VYwOlZUXgtrwbrar4qfsqq/KlwHiH/PFAcSslnAtqH5Lsrrhwjgybi8awDgByHL12KVOOULyP0b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOdFuBtU5yegzplsIywff19F3vlztwzLAm97gxYrpMrZSE+/b
	UtX61IcR474/EqIqVWgYxcbdUJQOkg/n/CFE1DJjSCSWTF/LjB6RE7KNODxMQ8+axhkCrHgTRBK
	FbM9dQioWtA16FVGp3YCC1VzcJhhrdVAfqOkrnFWr6b6pTl/ma0VfWTNP7TRWiTdEExc=
X-Gm-Gg: ASbGnctK7HSYywvTGC0lhgnz0c2XseIeDEG/vf9sriDaAb34Gd19R0sL1JY+Xs51MfB
	AMBCSN/n8R80akh7u3RYUkbYkVIuV0YADu+4ebKiYHgATJWl5fYfvrGNuYVicY3j2Yoctd0CL4y
	RrffGUm7JTQmqIpXMcdV63ogdhwrUiCfElGwMG1to1nS4Z4zIv+SbW8p4FPN9hnCLackE7+cd1Y
	l6TFUTj4b3z93Ky+RLCrJyAwvqv8Z92AXOENlpwdRwYXV9GQz8xOu73r4B+co3HEv7kEHBpm4Zl
	JZ3g+GGO95lg++qG+pWjbbXk3u61GlT5/Lz8oDkJpWt4CcUNEUGn6WK/fW42HjGAPXkEJca06O+
	FJsLM6BWV4gakLR3XF12noU2CqkIvY8lsT0ubLrH4SbEOrykOrj/R
X-Received: by 2002:a05:6214:5184:b0:707:62c5:975b with SMTP id 6a1803df08f44-70d88e6e24amr16306276d6.15.1755772567147;
        Thu, 21 Aug 2025 03:36:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJD+FeF4dIo0pLY6T95BYJZrasalSuOqAYF2ufCE5H5qdImROfk2vmGTbiJggf0s0m/2xKdA==
X-Received: by 2002:a05:6214:5184:b0:707:62c5:975b with SMTP id 6a1803df08f44-70d88e6e24amr16305876d6.15.1755772566559;
        Thu, 21 Aug 2025 03:36:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef369bd7sm2985905e87.68.2025.08.21.03.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:36:05 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:36:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shashank Maurya <quic_ssmaurya@quicinc.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: lemans-evk: Enable Display Port
Message-ID: <e2ke65gru7b75rnlg5cqlxpk3e7322tewvt7gvugjgnoezgdfh@6pqiymj7nipu>
References: <20250820-enable-iq9-dp-v2-1-973c9ca22474@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-enable-iq9-dp-v2-1-973c9ca22474@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a6f698 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=MzpP2GudIQyLNU4cacwA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5NCgMHI2dvdDjRCscJ1MqXZPH4lPfj4Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX7QhYCbgZog1D
 fX4t2IApy8/EmVNJYW8/hB5izdl+MV9UCwcfEZUAaAQav5LsdHIestj06xfnZB8DDKHf6saC2ZO
 beFNcSakmWn8y41/ZhRoIuJgC1qaPHdCBb39qmFYxiPC5kLrlUAQZL23/w6EVPbwjq25p7rQXsz
 5aNMJmVfJztRdmiV0XqExqfMJWgSMNYcNACcDcmwJfHXCh9U6sGlB4rIqZS4AyIPudrVM9w9Vx3
 kNUKiZj6Q2Tag9qCEBcfhOPK+XY1JKYI7KyTQe64LAQZin+4c62IJlU5PikEQPNDtB/ulaDdClN
 zzbRY2lOVreWJmvRtlUq4dPNrqqTeMF4UNSZ42iNCYon/0t6T+rAp+v9Y41VUGPL/sW+CsdrTSN
 9Hf/iWxR5U5fPuMR5KTLCNYiiQ5WQw==
X-Proofpoint-GUID: 5NCgMHI2dvdDjRCscJ1MqXZPH4lPfj4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 07:58:35PM +0530, Prahlad Valluru wrote:
> From: Shashank Maurya <quic_ssmaurya@quicinc.com>
> 
> Lemans EVK board has two mini-DP connectors, connected to EDP0
> and EDP1 phys. Other EDP phys are available on expansion
> connectors for the mezzanine boards.
> Enable EDP0 and EDP1 along with their corresponding PHYs.
> 
> Signed-off-by: Shashank Maurya <quic_ssmaurya@quicinc.com>
> Signed-off-by: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
> ---
> Changes in v2:
> - added dp-connector nodes for edp0 and edp1.
> - Link to v1: https://lore.kernel.org/r/20250711-enable-iq9-dp-v1-1-6d381e105473@oss.qualcomm.com
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 84 +++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> @@ -261,6 +331,20 @@ &sleep_clk {
>  	clock-frequency = <32768>;
>  };
>  
> +&tlmm {
> +	dp0_hot_plug_det: dp0-hot-plug-det-state {
> +		pins = "gpio101";
> +		function = "edp0_hot";
> +		bias-disable;
> +	};
> +
> +	dp1_hot_plug_det: dp1-hot-plug-det-state {
> +		pins = "gpio102";
> +		function = "edp1_hot";
> +		bias-disable;
> +	};

Please move these to the SoC dtsi.

> +};
> +
>  &uart10 {
>  	compatible = "qcom,geni-debug-uart";
>  	pinctrl-0 = <&qup_uart10_default>;
> 
> ---
> base-commit: 1aa50d938e88fcad1312467bd09be4037bfe68ff
> change-id: 20250711-enable-iq9-dp-addc9c7195c9
> 
> Best regards,
> -- 
> Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

