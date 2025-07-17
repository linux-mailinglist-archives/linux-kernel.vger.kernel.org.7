Return-Path: <linux-kernel+bounces-735953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C390B095C7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A46B1AA562E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CABC22541C;
	Thu, 17 Jul 2025 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cqYJL4ES"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005C21ABAE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784480; cv=none; b=bfBY/BnXOowjQoAuCZwOe5NaNAmqMtfAKwu0HQyhJjeALYuDiGDTLZfdRI9+RTs/TLy3clVjnwQbxfalUzlgDFnfYlxO4har5nyC0L96SQcVXYWFbCLrLgn+dB7OKsSBKGtMw/1vgTsG9A5/ixyPbWhhKddQ4HXKdkdaaZ92KP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784480; c=relaxed/simple;
	bh=hGJR3V/1tcHMB31VvpC4R8Zsvg2CwbMItsyk5iZAxy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJUM/0i7T6zr+iz6EiPV/gFR0OV3rsIrFRvOu4gvUsx3M35p4ezoBKziRtg8JNJH0rI26MQbawBC+Ly/x+ToTaL4tHqR9fAgXDYOPvd3YEWGCnZRiGhZLhCs3ORfPxpfQ4GCsVR/w4RCGgn4iaq2xqPXrR1BuFe6Hoittzaz/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cqYJL4ES; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCSrdd032365
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6kgP0d9tIR6NHctzVbidbhSLAjPMVFzktI4gkLXeKhY=; b=cqYJL4ESt1MD9auM
	Nrg42kIguegh6DhejQY0DnvxiAmqQzzhVtWUht+pNUGbe0C6SQcwPwf1ZzVM4rbE
	VlEIHpHPsYPwaAuPKBQ1QDjfAza5LT9R/pPT9TFRB4W3784Cq/qCuFlxbHTUVVIc
	kmrMI/ry8lDEyK4pOKBMI1ofO+fWqNKAaJPH0EOsZzPPdjMdNm7404nvC3duQ7nN
	fkG2Om5sqq3YOieAWk5LDh8xrw24vgVbHZpPsb9t8TIrH7aSaTbmgTwtZFD6QVuK
	7wsWZSARXvYXbwsEQXYTi7dmozJBtZ3dkLFY1OtVrVDQt2Dg8S9M1GRN7WqdE5TO
	T53f6A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug3898k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:34:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fd1dcf1c5bso3739436d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784477; x=1753389277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kgP0d9tIR6NHctzVbidbhSLAjPMVFzktI4gkLXeKhY=;
        b=lLsNNs0YhVXR2mRuCLqe5/xUKQ7nmoLLlhgUOZVkBCzSh7vOq0ToC79+7z4opqezr+
         skGTOJmM7X4UHH4odhOMjIAHWD3rlUO20i2AljpQr8xhzqqvabuYWfnRKQJ2OcRoebte
         PS9sBYrzTeslhR+zHcwXxQCpidRmaqSscxu4/ZGiz3EOJCWC3tP55lKFuKK+zvc2rTvr
         ICReE2Er9HcV5mRqQ6LroOy+YiH4f0fLBQnXbQXA1TkZHMqFvqYZjEI5V7XmWzYL9hei
         /hHaFw6OrpvuRarN9JYrGCMamfZpLzTZ6B4hC8+s7VkyBL6QQs0juhf3sw1yK1OybNRm
         ciFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdphGzJuAMeXT/IlsBYQlEWuIZhr6ZXHoMygCpRsjbN1rYfNuHIMZxKokyBCxxTZT1eBv8Bc7uRGfoZNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRDRYDRanPBCj5cSFzpxpwKpKX3u49lfRPmoo1P/womRiZFXEt
	RlmeeYgledrMffnqGS6s+lZ/sz0h+h9Uw+t75sBHaY66lVYjRNzDtVJT0/2o9FLF4mdogkxw+wN
	XqNaE0/z0pltUAtJvAlANRU5DWjYS9bQn2EHz79LXVmzhp3A2ZQa+VKu2tm4DXseXnTQ=
X-Gm-Gg: ASbGncs8lwsR+q1RDZdKj65Z3VnrB+yvkYkDE+lYDSt1ELawzM2SjCm4OG7hJafiuMg
	JGOwYBiAxsm9/FBlCcpxAZVM1VQoxnjCe4tAoKF4m23Dk8eXP8WjIhZ9DkBnBQeYXoDfSWrlenX
	ep8kxLcgecclcttdfxRg0jd2EkkItjmvl0/QTu9N8ZP7ZAdjvXl0aC9Jx5GPlcdgxqpBr4TvOaN
	/WTJ0+43j+FwYghqYii4ex50ZlltP+P7m6Uw6OnrH7Jkq6Iv4mbyC635KMD9ICGvDcPuQzsE4/S
	SBdU8tJ3wSmgfcdkjWD55jOK4jOleg4lX00gu3QabavM2eRoYfFh8ziALe1K/UsSZY4oNwu7rVb
	esy4fLkWqENY8TQnF8i6Z
X-Received: by 2002:a05:620a:2b49:b0:7e3:3419:90d with SMTP id af79cd13be357-7e342adfc02mr465487185a.7.1752784477316;
        Thu, 17 Jul 2025 13:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEupMN70iJ4oocSBV5jSP32Z5K9i0re731zgAYdP0kVX56HgTG8n+/PmtNQbmI3Nu0wihezSw==
X-Received: by 2002:a05:620a:2b49:b0:7e3:3419:90d with SMTP id af79cd13be357-7e342adfc02mr465484885a.7.1752784476917;
        Thu, 17 Jul 2025 13:34:36 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264fbcsm1437115666b.75.2025.07.17.13.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:34:36 -0700 (PDT)
Message-ID: <27e4a27d-6e91-4e91-b55f-d6aa4a5be800@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:34:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/15] arm64: dts: qcom: x1e80100: Add MIPI CSI PHY
 nodes
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
 <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-8-0bc5da82f526@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-8-0bc5da82f526@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4MSBTYWx0ZWRfXy6QhK2mFL/7a
 NwWre8iJ0OYzl8G5OYDeA7DUc304U0GOYpEe3SevmXEd6FashSSljqYY8eB18LdSQbxVMC+TE4v
 kWf6O/xDN/VmkAsdtvVGB6e/ndocYGJ4xv7NUUMc3Yn/lE5Q8NDnhibpXlG27REtIhXN7BD4KZ9
 5/akDMymlkmB4pQAuW460DK4fcrt2jM0YJynI60Dcs7mAswCB7wRUMkYWqaxbSSOaENkeOzMkMq
 CfAkaCqhzVW+q7Wh4vKw6tpLfKsfVhWCl/cB9iZp9KGTslqT0bonjS10hDiHbJ8evkI3jfZrngl
 5TRSQ6oGnwBKKghsxVYG+aAfdt+IA1+qTx9zdbuLZINVk2pUWSZDZ31PGeaG+M7FkLQKOYjsKJC
 Ve5MKlUaiolc92EN0beb13J73bcqDguVoWn5LTbXKryfZ364R54QxHwv+zEyzEeg9fROa6wX
X-Proofpoint-GUID: ATCjCjayEcId9w6sfMXHwt6jN5TGDdzh
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=68795e5e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=jM4f9QFlUBkeW2BXBzcA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ATCjCjayEcId9w6sfMXHwt6jN5TGDdzh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170181

On 7/11/25 2:58 PM, Bryan O'Donoghue wrote:
> Add csiphy nodes for
> 
> - csiphy0
> - csiphy1
> - csiphy2
> - csiphy4
> 
> The irregular naming of the PHYs comes directly from the hardware which for
> whatever reason skipped csiphy3.
> 
> Separating the nodes from CAMSS as we have done with the sensor I2C bus aka
> the CCI interface is justified since the CSIPHYs have their own pinouts and
> voltage rails.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 88 ++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 41245e8592f78edf141141f2f5b7c5b841318f46..e385d6f329616360e089ba352be450c9eca6aab6 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -5244,6 +5244,94 @@ cci1_i2c1: i2c-bus@1 {
>  			};
>  		};
>  
> +		csiphy0: csiphy@ace4000 {
> +			compatible = "qcom,x1e80100-mipi-csi2-combo-phy";
> +			reg = <0 0x0ace4000 0 0x2000>;
> +
> +			clocks = <&camcc CAM_CC_CAMNOC_AXI_RT_CLK>,
> +				 <&camcc CAM_CC_CPAS_AHB_CLK>,
> +				 <&camcc CAM_CC_CSIPHY0_CLK>,
> +				 <&camcc CAM_CC_CSI0PHYTIMER_CLK>;
> +			clock-names = "camnoc_axi",
> +				      "cpas_ahb",
> +				      "csiphy",
> +				      "csiphy_timer";
> +
> +			interrupts = <GIC_SPI 477 IRQ_TYPE_EDGE_RISING>;
> +
> +			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>;

I realize it may not be easy to test their functionality without the
rest of CAMSS being enabled, but are the CSIPHY's registers accessible
without the TOP GDSC being enabled?

Konrad

