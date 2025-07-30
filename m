Return-Path: <linux-kernel+bounces-750326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C93B15A16
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6485437A6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3119E292B31;
	Wed, 30 Jul 2025 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P2OvjWKo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33659201276
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753862272; cv=none; b=IKCHd0cvX2+erPc+R6lBmKr1fdLMoU/ehNnBKYDaSHtUwcfk2Z76W3RVR1kxapmDf+ZrOKBOvgMRFE8dMu+VgwWXQuklOQzv/J8E+VyVZK045ndTgWlktdO3kICd8ASd2TuxwHpQgJzpG0SN3zQnjr7HIBQkLd/GX9EfEye9Hvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753862272; c=relaxed/simple;
	bh=XZ2PvbCqPh4TDubyP5ZkSEFWcWBI13qEuuuSTP3h0AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W738lP6yNpC773P0pvjw8X6T0aG4FJQJwKZK+AOuQnvbWaHEHLWn3QmsSBjjFRdhKj2OhH4/upMTPE6PEEy9ruyrq1Ld9M2bvVjeoYEqTUW35EHk86FCi6MQyF15MfGn6EcGDjYHvaqdJutBvhMcd6q1pTab2C4iJKovLwNuNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P2OvjWKo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U61E1m031267
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bep9w9BnXdrMmlin8Bi4VGFbGPSSxR11L24CVQ4ky8o=; b=P2OvjWKoPkLJEqWV
	HVfKaydYguKXVsjrq0QaF+thRZQuyqit/G7Rvo8n23YBBhnVDHvvi6azm6nvfXt/
	SlEb/KHudejGJY6TkQzxOLXuPPeo2m8SAZnsub1koynuaWiekzHnf3OkV9rAKoya
	9q9JCgxz1xJd4+bsCtjiibQLh3XB2L8ECsnuSd9vG+/D/WMAuh2WhykVbQFqLDo8
	OTZIhpeKPEhBPX8i0tpSmeCwgcJF61SzIxSqhqz6HwZfvJXZ2tR8eArfMhRM3JAx
	/g+F76rl7CVK15CkRyLFDi8tS7oiCzMxe6MnACzpa5cpu/JMNeA0aZUp3JjE7aL1
	utbmRQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 485v1xgb19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:57:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab3bd0f8d5so17313421cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753862269; x=1754467069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bep9w9BnXdrMmlin8Bi4VGFbGPSSxR11L24CVQ4ky8o=;
        b=sbvUx0hDTtHMhlU/VWGizTUbzrnEdKbmtlks024svOgIRCAdHPnLj8mfRD6YGQWzMD
         hRFQsuZ9ylJ6EhNknibutm6qLF/xzZmOKHRO7xAp8+p1dOzrgUSkjdwNIO6LDhBa6aUy
         i3B7e+VzDfH5ZaJ/XKESxY0cCoRDW7vx5fLN/5kgdVZ/RphqRq6lZ3LoLY7CwGynXkpB
         rN6w3KZFd9GVc2fkqFpnI+kBBMX5kXGqo9aJMy9GOX0uuLHXd07xcdlSOaxQOpsAfwK+
         +5RxyIQ8l6eP4ut4TBZUBqx/oUIHwbpDStejVnf4tavDvOE42vkS8X8s5E9VNW9fHFBL
         xa7g==
X-Forwarded-Encrypted: i=1; AJvYcCXpyqltvDWz+5I3AKlMfn2ZddrtNIzCe51DO0ouP2QjZc2g3Yrl76NvKduj6U4mc2lJvRycRPjqhASAC9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWD9cM1BTB5ePw9scmCiTfSgtpNCtFBW+sKaVObAHgWql71bH
	YG84gfCEnKRLN7c0CdjBIJQ9zLdnaja/m4ToZ8NDsMQkzPKjSecgqSXL1Kr+P7QCBe2vn+hm55s
	vz30Bn4lbS3x4/MHsvi6arN5wkQ/3tuA3wM7tmGQW3tjrhcC42cnOkP1LNIzLfYE2TbU=
X-Gm-Gg: ASbGncujF1byZqbnjXlbcrUvvTFhSVAVRvQdeNhYYnZxmWgNPl/ihSFfj/2O9gDWW37
	5NJqccIO2slpP8bRM9TyntnqQ8Wx5N0mUUChSmdisQtu/Djgam4CFjNjGfdmHoxD3St7k8J1BzO
	vmirxalyN0ISbUhWH7rmu3e/5AFxyIURKQuGeI0ZhqrA05XYoDnCGKbmR/VKxWWoL/zht1esXfM
	4oAhq4kom8d8XWEOjVAqbtnQagwhzLxWjEixFt22xpYCgBNuUkxWTFnSg5bUwLy/H2EwOlI0Mn8
	t0R1gaiFOCnqyGd2cbfmPrdny3LamdJlFD6f4WIB+vg7ABQ63AeOGD9v09lfHWHgE/PyFSFXqNL
	W6MC+mdlJAlODnmR6ng==
X-Received: by 2002:ac8:7fc4:0:b0:4ab:6d02:c061 with SMTP id d75a77b69052e-4aedb96a9a1mr7229961cf.6.1753862268905;
        Wed, 30 Jul 2025 00:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/sjv/KirXnu+zAbo+zcVKQUFU7/xftsd5QFNM57kgr4gJGSFZUGgA+3QYMDJuoSGOBbDkLg==
X-Received: by 2002:ac8:7fc4:0:b0:4ab:6d02:c061 with SMTP id d75a77b69052e-4aedb96a9a1mr7229781cf.6.1753862268489;
        Wed, 30 Jul 2025 00:57:48 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a65fffsm697780266b.76.2025.07.30.00.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 00:57:48 -0700 (PDT)
Message-ID: <0d267f8e-ab1a-4239-8966-5ac2d5d40787@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 09:57:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8650: Flatten the USB nodes
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250729-topic-sm8x50-usb-flatten-v1-0-4be74a629136@linaro.org>
 <20250729-topic-sm8x50-usb-flatten-v1-2-4be74a629136@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250729-topic-sm8x50-usb-flatten-v1-2-4be74a629136@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA1NCBTYWx0ZWRfX0bbZrZWv9CJk
 EuqXy6MoZA1Qi+OKMhjVIshk9DE0Jt2Cl+V0VylUNh3uaepHO/QYQnLgYAdLQVzYRTZZFEnXVD+
 t4vQQF2aGsN+AXXKxs75YTPSjfBPeTQxjlJc0OW2nDBm0gNNcfHZ+BCvlKWaxYICQhY4iLbLspl
 QkCrHhYvwFIA6WVcjkEJDCsNeb+FCU8SvOV3mGtV1wieyBxfVi+LTa/w7WvFdUziwg4Rk71HiWM
 wutUvOPlLqjEQHNPQFgxEPku4Y1a0qMzuY2OX2juDLmFpNeK/CNcIJG4sDg8X0ziWexB7JuGoIB
 so47+mBOermjNBfO5cTf927Llq4wFkj9SvFQ2L8FFAtQGS/bxos8nBg5LAWZNt6DjCIWsYlxRjv
 qJvq1qj0oJ1tox2/3ojdfOMhwszPwvvYX3sFkmg9/04R0X6xeM47CLtSSoD2Bv6dC6RqvNvL
X-Authority-Analysis: v=2.4 cv=JKw7s9Kb c=1 sm=1 tr=0 ts=6889d07e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=cHqI4RTSPJW5vXGIaXYA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: acseJ5qormKZEVsPFblAYm6RUmvPUe2H
X-Proofpoint-GUID: acseJ5qormKZEVsPFblAYm6RUmvPUe2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=873 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300054

On 7/29/25 4:58 PM, Neil Armstrong wrote:
> Transition the USB controllers found in the SM8650 SoC to the newly
> introduced, flattened representation of the Qualcomm USB block, i.e.
> qcom,snps-dwc3, to show the end result.
> 
> The reg and interrupts properties from the usb child node are merged
> with their counterpart in the outer node, remaining properties and child
> nodes are simply moved.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

[...]

> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index e14d3d778b71bbbd0c8fcc851eebc9df9ac09c31..0120b9c7432a945a204ed76a461a6d0f13875537 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -5651,16 +5651,18 @@ usb_dp_qmpphy_dp_in: endpoint {
>  			};
>  		};
>  
> -		usb_1: usb@a6f8800 {
> -			compatible = "qcom,sm8650-dwc3", "qcom,dwc3";
> -			reg = <0 0x0a6f8800 0 0x400>;
> +		usb_1: usb@a600000 {
> +			compatible = "qcom,sm8650-dwc3", "qcom,snps-dwc3";
> +			reg = <0 0x0a600000 0 0x10000>;

sz = 0xfc_100 as well

Konrad

