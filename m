Return-Path: <linux-kernel+bounces-832480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE380B9F6D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5B31C20E01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59327218592;
	Thu, 25 Sep 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QhnVLMEj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B381A5B9E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805724; cv=none; b=Gktfx4oCEpJlCJPa2Fp5Ybw8nna6ECpqktxEp/8izp6yeF6lcusykNjnuFLUJ6jiR/g1/V4qcHAwbwijUDTo+TDWR4Yy1gINj0MyCj2txPCRczX16B5bIghL+HmxtySodqL+IMQb3fYM5zDOi+pngeVVhs0bwH3r+HsGwBn3t6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805724; c=relaxed/simple;
	bh=KDeJ7UReWAmRldjQ7plvlREwzkrTIgyqUflJhG+8TPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wr+Lg+kkwO/HCTYaraW/8t/+3VOUJFeMpq2qVgiyJgCyJYkQwG58mE3CfHJo3aPEYhE4MBCciMc3z724irmKtbYAOeI22XTBoKfTZkvbKn41dJt3maCDaCvWrD8jNVRZOTcPc1b71SUk7F97uRwcQD/PaP9zBvhzQNpqQbN1etY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QhnVLMEj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9k8Xj025084
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rlt4FP4WTHK5aPecfPHBUxCireAQ8qfIAYNt4n6uaXI=; b=QhnVLMEj730YXNNU
	QD0BGBv9Jd4ClZSKyqUAE0GE/PSTYT6o8udfIDjefq2Ir5GrvPOpgbYx/fe+0Cbm
	3tn9twmCGoVz0KddvaGC4l12D/yYPFe5wKY6jz/1l8e0Y/Os7h3EgopizRttheSj
	rcLpkaD6ac3byY/Mexa8DSTkghzm4PSGdU3cFHzQZ4NRs1l5S7WF4V805dHpOL3I
	T1gItqM9TI3qMoNeEuZyB7Rs1HaUC2oOQRl21ktNlmD2TzoLwv5XeCYIukdtuB36
	LOkLK91yAHyr3VODHkRgk03/x2452cdzcH4mbVppXZpO7fth6fR+/Mt7ku2MHDXe
	lXCgbw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyf0g5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:08:42 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78df9ea0c9fso2079076d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758805721; x=1759410521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rlt4FP4WTHK5aPecfPHBUxCireAQ8qfIAYNt4n6uaXI=;
        b=VLsCl8F1ewrcy7MpkouWTzEceBZW/GU2sJ3fzbzHLTkZZbOf4UE3jDdYT5O3DNugyc
         W2EbA47WIDV7562SMgUspEKap5pz1Zcj17LgFR5/dGOAfPJQS5behU+ePna0PaDdZnn1
         tifkCChwyCUsIVxlXBK+3Tm9b/9HQjYxm2uEzb7h/qnyM4+9jzvikrlq+2uK3wHM3Zyw
         if4U61NsrrYHZrSg3N+Mm8GVIDBi1OMy5mAWqXoHYBQMCP7Te+gufApzrmLGqcKldipk
         ucb3oyfyTvZl6HY3S/qZWzC/+FqqczTn1tRPoZWTlwzY2pOFMTXG326nXVUJWY2MdPia
         g+9A==
X-Forwarded-Encrypted: i=1; AJvYcCU1RPMNTklDnnoakAmoNstrgwtedad63wHXhR3A86GnJgoaj3Ur+0/GDAjWog8AynmfOMB8eWy8BiYk2Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/fmr6OJVqQ9sWCjPMtPU8NQN1UB3CY0CUOmBPJYRKJvnZyZFd
	wEf8zDuKznvXF4QtEYTWhifhCEZG+ZbaI7pxva+HLqoqcZHdtQGL/r/cPSsne8urQIurSP72/Vd
	7fjBdD8nTCGzvLQZI8bIBbj8E/TxfNJV1W2TI0AK7JMqMKdYB5aU9kdgQN2IWl0p/qF4=
X-Gm-Gg: ASbGncs0f/IBie4HG6tTJvW0vSgCP2KiXLMDFtc1rc8hiao7wl8hFxoE67vasU7Breo
	mrnMPXQemWmavG82/o8OJjTygU046IAs4V9fIFPHJYKdhxvwMQDbhbLoPWkN92rouuxusRwd7MK
	aFlNLiIx8NL/80Fd7ifAiz1gmI85Rhz9Vc6m9ZhLHjfk65KpLdLPAQcrwXEnNn2yutzWrFvSTeX
	2N8t4CR2sRToHuSOs1W0p45RiiWidX5vp2vKz304hBG0WveA7PUZtwXuy3hdGU2kZmsFGc4dSel
	SNcYIOgTRav49/z9j8UwjOfRlAxXD7wJoev2PDXTJfzYlOpVHUFWcw6KokPygcCv0t/H1CADuRG
	o8Cf9RC2bt1/K7ih3P0QBkQ==
X-Received: by 2002:ad4:5aab:0:b0:736:261c:d636 with SMTP id 6a1803df08f44-7fc0fc0a022mr34203736d6.0.1758805721086;
        Thu, 25 Sep 2025 06:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF23rJvQekA7RTfXmajprdeBmZk81rKj69AFP64AtV7O4pUbDPGh0bvBL5rIK4McKied+UPXQ==
X-Received: by 2002:ad4:5aab:0:b0:736:261c:d636 with SMTP id 6a1803df08f44-7fc0fc0a022mr34203356d6.0.1758805720632;
        Thu, 25 Sep 2025 06:08:40 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b05779sm1211642a12.49.2025.09.25.06.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 06:08:39 -0700 (PDT)
Message-ID: <b3151086-206e-4520-9a52-04591478de0a@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:08:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: r0q: add touchscreen support
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250920014637.38175-1-ghatto404@gmail.com>
 <20250920014637.38175-3-ghatto404@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250920014637.38175-3-ghatto404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nR9KcvXWbI6PEuqnDI1PFDhT2pQ1Qdkx
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d53eda cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=4mJ_hZI3aotk7FlZVO4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX6uy8jnV0rHdS
 9EXEkmqhqTcV0fGo/3MYzl5jFMdkYGmnuz14E0f7dWfjLjG70LoSRlT+XvFveuRig7/rofzstot
 W+Iih3lMX3sMjB3W/ml5vMwm7VWCnFwgACFFt+Gi9RQUcY90IERGlq6KUp9kB2FYF52SrplUajz
 k/Zh6pmMtG2ITDpb/7UDCGZPNIvtQ/AUFqdyBzo49EXnA0yk+WeQAPBYEsmlz9nFulaJ/bEgbTb
 nmNIYGd1Ao9NKerBrqirZ4VSH1NaTtzZZix8okPVDXNofiDen0+50UrwlSZmwXGYMi1Wk4SB2hD
 ck1Td8cb8esyHQFNnzrl4MnJRKugNHfvo/o8mjWO3WIZC7fgv+82LBMuKJaesRPnTbIuGhWy6S8
 V+bk234X
X-Proofpoint-ORIG-GUID: nR9KcvXWbI6PEuqnDI1PFDhT2pQ1Qdkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On 9/20/25 3:46 AM, Eric Gonçalves wrote:
> Enable the ST-Microelectronics FTS2BA61Y touchscreen. This patch
> depends on "Input: add support for the STM FTS2BA61Y touchscreen".
> 
> The device has an issue where SPI 8 (the bus which the touchscreen is
> connected to) is not working properly right now, so
> spi-gpio is used instead.
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---

[...]

>  &tlmm {
>  	gpio-reserved-ranges = <36 4>; /* SPI (Unused) */
> +
> +	spi_clk_tsp_active: spi_clk_tsp_active {
> +		mux {
> +			pins = "gpio30";
> +			function = "gpio";
> +		};
> +		config {
> +			pins = "gpio30";
> +			drive-strength = <6>;
> +			bias-disable;
> +		};
> +	};

Drop mux/config, put all the properties right under the pin definition

> +
> +	spi_clk_tsp_sleep: spi_clk_tsp_sleep {

Underscores are forbidden in node names, use dashes instead

Konrad

