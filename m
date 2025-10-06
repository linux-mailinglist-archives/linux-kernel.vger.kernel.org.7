Return-Path: <linux-kernel+bounces-842735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB2EBBD6C9
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C68124E87BE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B012A26657D;
	Mon,  6 Oct 2025 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q2BSDM3D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A75265623
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742432; cv=none; b=lK0K2upQv6f860TNGdwteQhUZFWHZvAnDv2RMS/28LanLeH6cVxxh4RmWZxDo7iXmiiOuC2DLPgYxpM7dRDV6IhooUT8tzaYSsIVtfPg61dOs16b7h4wTCZ6VTdaccXhCN8yb7S9bKaWFUgSuN1gvMmSUPMHMTtOXMK04JJIMdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742432; c=relaxed/simple;
	bh=+z5RsXcmsnLuH9oNH0dtACv/z+mVo02WavJT6h3Tmb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJu8Y9FE9J7SduYlzW4cGrxU3DThxocDphtvpMyqGqtNtmL8GmGEmRnby7koOaACbAPJ2uFa7dQ7B44cDFMA1Vw9gxdBPoz/ZhaAizfOvwmMrjQdB3lzyMetr94T7B9N4jFENVVUdNa46gKdZa/AhB4LJmb6snpKF8EWKBbTc2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q2BSDM3D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595L7OaL000811
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 09:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ch18kniChG2tsKGJYqAIJlfKxhd34mEMTSP7HHJxa+w=; b=Q2BSDM3DsTGF7/0K
	uXAY2/t3FEUaRZmjpySbCnpdoClHNsxo9phEPQ6gBWa19C/YOIaNEFwYEjybyJDu
	swB6LJ1bI4V6yo8lvbtKGJIeQxWL8WUXUQch5Fk1IepuUapm5G5/imxYXcACdk6E
	mSuFuzzVT76N1blW7kJkZ9EqTbRBMMr4KIj3fRPs68iW6TQDUWeZTw9zufK42vQn
	KSi/LN9l2hMzB9efTMhVu5VzDpbXgh56XGibyj07bqVsYb4TFOc+jxYtwbIdQjlA
	GYu2/pIdCagT89jUuA7GIvkOXnJ3TY0Zw1Kpk0BuFTxzujdrjMIEK8jEAC90+22I
	N27e8Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy6uc9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:20:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dc37a99897so12441541cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 02:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759742418; x=1760347218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ch18kniChG2tsKGJYqAIJlfKxhd34mEMTSP7HHJxa+w=;
        b=CEDU0sx6DMgZ7zuZ/sSVD6+CM9xMMdlm8k2NyHSCtzMZjgH+mBIG4xp6zv8MZCWbSH
         8UwGFsRUtCbdimqSxsEv1/p5eKaaK/pz9CsaYOz3OYWvs6qEAIL59x3EC5q6tcRAmVt1
         eig91yt4jGYSwfMAIVTcjz0aa5j/E5siRdg/Q0BNexezwCnC0RpKmtg76MSBMEEQ7brG
         1a1BeFa8u0kxod6b5Cb4pLUMy267LmPFdtJCaaiizYIFasco34fzWfQVFhuXqfGipvob
         RlKS5rwEh4d4SRSwOlSPNXuWekU1EzTxayLBF5/lHlBDbJ0ZrCZ/mwTkiigVi3PczNpV
         8BrA==
X-Forwarded-Encrypted: i=1; AJvYcCUU69s+kUl18/guvKwYBRh58s/8pEIxJVD9H1bKkyttV6FRGheetpOMB6Zyyny237Oo+9py9VOYV+2u0P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqstTdnb+5xstKQSMiEpPBt3IUI71/7Tn0pr0xx+5sf6EYRUM
	cXV5b4bg0G3U7VezCo75iQPOXkelslBPK54LvC4jimqb3iKCGP5YHZEM71HDPWS7mGd85OEuZxL
	tOh8XlYCWJEyAqUGyfjJiDjQxsT83WuXn7jewN1GlklwHPPwUi1XTVqEYAk0r3xS1qPY=
X-Gm-Gg: ASbGnct7aKSTD54QaA8wK4o58e1T1FwzJBBhLPcmeTt7J91DH9PdZ9JGoTstKH6O3U4
	krhUCNnzTijljM2J42crLPHxr4kyguQ3tw5ODsXHkYfj2IkserH0B95GRzVxUWK0ODRG5Hqto0F
	+0bYNLxKVMHwoeENwSwruJmW0qvzL4lDVZf10fLiFDSv6amRZOLUel3Y7QF0l3NruW89vM5Gapm
	FxZQXzFJxhn1Jc0LSu9K6kK1FqUo4UOUA1j5MTHfPDkUnTkSXEpvN+weKZx3g3JdnI/XCleQePD
	NFSalciHZBeHHWyg1EUsDc8mmCOfhv1g8BOfr6WdVLiBNKsHHCeRCR13BB54FSoJ5NhzU1D2qJb
	NCOsowxnMJlVOltuh/NZdSO/1cC8=
X-Received: by 2002:ac8:5fce:0:b0:4b5:e606:dc13 with SMTP id d75a77b69052e-4e576ae6a6bmr96762681cf.10.1759742417998;
        Mon, 06 Oct 2025 02:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBV9Zd/QB2x5+JdkTxQwqxdzWs0zfhbi9OLES7dJj3xqxLmh3J9kn0Sitv0LuTbN/cbiCltQ==
X-Received: by 2002:ac8:5fce:0:b0:4b5:e606:dc13 with SMTP id d75a77b69052e-4e576ae6a6bmr96762421cf.10.1759742417399;
        Mon, 06 Oct 2025 02:20:17 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4fd9esm1102808466b.76.2025.10.06.02.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 02:20:16 -0700 (PDT)
Message-ID: <dfc093a1-e13b-4342-9015-5a896bf18d5a@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 11:20:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add UW cam
 actuator
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Apitzsch?=
 <git@apitzsch.eu>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com>
 <20251002-dw9800-driver-v1-4-c305328e44f0@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251002-dw9800-driver-v1-4-c305328e44f0@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e389dd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=6H0WHjuAAAAA:8 a=gTkJHdstRq_Xg2VDakwA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: eHJ36ytkjGgtv4xsY7Gp4Kh2oFSSHnSM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfXyEDwx4JaBHQ6
 1pem2gbZUAgYkG/ASY0fbAr3uzvCMDCftlr69qfSboYl/xT/Zby25qiUzh/fQXxflVytYu6slp+
 HTi0YzOigH5GGjkwUq0gPo9KU9pbP1pl3Cnmo5E4VrofPfFPEFmha3z1brDsjOu4JgEEtpPuUMo
 fAzm7iV9hNMqX5kUtW6lN0qa++Q6L9hJ9ZvYS9tEhU3ymLKiuAR2g8hjZonPvCWrUA45+gx6Uh0
 YM5+Nz9G44bsn/AfByD8A2Yg51wUsl9eWa4JsnaJO0DO0HiySpRiJnBgsuTJHFnz2qKY+3RluAm
 03TovLE2Ozr/UHHai2AUndudn1nnFnGkLhqaF/BToURXtyFYaXq9wQTTOqxiuuVdZLJwqzdeZgP
 dP5Sdvaafmp+jftsuWZMCSzlmnlQ3g==
X-Proofpoint-ORIG-GUID: eHJ36ytkjGgtv4xsY7Gp4Kh2oFSSHnSM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029

On 10/2/25 12:15 PM, Griffin Kroah-Hartman wrote:
> Add a node for the Dongwoon DW9800K actuator, used for focus of the
> ultra-wide camera sensor.
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index 2dd2c452592aa6b0ac826f19eb9cb1a8b90cee47..0e86cd5ff527925c7dba15c4e0ee5fc409fe4ce6 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -627,6 +627,15 @@ eeprom@50 {
>  };
>  
>  &cci0_i2c1 {
> +	camera_imx858_dw9800k: actuator@e {
> +		compatible = "dongwoon,dw9800k";
> +		reg = <0x0e>;
> +		vdd-supply = <&vreg_afvdd_2p8>;
> +
> +		dongwoon,sac-mode = <1>;

This property exists, but isn't documented (you need to extend the bindings)

> +		dongwoon,vcm-prescale = <16>;

This property is neither documented, nor consumed by the driver (it may
or may not matter to you, check against what your presumably-BSP driver
does with it)

Konrad

