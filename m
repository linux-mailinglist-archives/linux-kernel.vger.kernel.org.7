Return-Path: <linux-kernel+bounces-899023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9EFC569A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B3904E5014
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612B52D0C99;
	Thu, 13 Nov 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kGxaz+t6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N6tQZuB/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59027E04C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025916; cv=none; b=hoqfRGNXzxQ0t95WUc/8/gp1Xdc/SXDcPZw7Oe2XOqd9PdQOOL0CpvSO0rLOMNn1M4sP/wh1bJbPg6dIHRS1hoDHoRZGtFo1u4PXXdRI/e4mrrFGZAd8hD1kbeuvOPTnmx7zmMy4h/CPAuCCCshVVls8IW649gvcnfuwmJFilCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025916; c=relaxed/simple;
	bh=OoScr/lvJFthXvfT1CXbfWhIiXmyfNZugSh4SiCJAKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwExiaKJGnHhF+dhZpb5BIIwjCIeF59O1usrsIlbDrE7TwyBSWgDi3QV/E55FFbT4qGZm1jk6n9GXkhMEu5gYKuYusDeL0/i6c4AsapYOR+oqh3yv9LD9Tnwwr7B2QL2sFQltIJF4nmR4pqSI48csvCi9qNvza9BpRdFU3LPMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kGxaz+t6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N6tQZuB/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8xFei2993483
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vDDFEBq90ZrP1T+dhrcOC42sUU7oXSQNn7pBqr9sAgU=; b=kGxaz+t6XTlVqj1Q
	cpp7vqdDEj0ZTNXz8YMfu7hSXI65/qzHSbr5nRE6AKQKVQYrV5AT2wYgJzV15pfC
	AWFf4V3Dw+4jXBpghBTkS9AdxrXPlhYDy+lzmCHUB7XxI0Z51jgnoCMloEngoQXX
	hQ8I069ESzIs2YtA7cU69+/xghK3FmELpWsjPt+LObVMKkqkr449phORhQgfzko9
	NW0Gy0FwRG/gh/5UqEGNCP8nZvGj3Ylxw8i0ExPUJeU4LY791/U1C+3UaqCghOg8
	E7MF97MWA/11o0Qxu/vBUsxM6lGe608VYONG7RLHuZ7uQkWbk9eHOuHdrQKM5Ree
	2cmXHQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad47jhn79-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:25:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e887bef16aso1041431cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763025913; x=1763630713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDDFEBq90ZrP1T+dhrcOC42sUU7oXSQNn7pBqr9sAgU=;
        b=N6tQZuB/NlQD6bMYyRBG5zk9bQRImrFRbJVUKSA7B4WjesD+ZX/zzveQZlkX5g/sCv
         iGYhH1g7xVjK1c2vh/BgBC5RAoOvmPj5/oc43jEoNU5IifRM5zYm6cd4OcCV+oOiTCAb
         rwDjgvVMBcXa25DEWtCY+niciLIFWe/Lc7/pVVg2FNrIV/pzK2ICI1S06N3u4SaXPGk4
         1RZbyxke/6C5NzTrtJZbCbbN/qPP5n5C4C/nz6xVn8KgirtvKeYmybZVdwQP8asaLEv9
         XHfmVOHzY+SPSspjY3eMyS+Hyvmo0nc8FMLAqqBiIyOaiq5HhtDL+GVeI60IT4Xw81W1
         46DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763025913; x=1763630713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDDFEBq90ZrP1T+dhrcOC42sUU7oXSQNn7pBqr9sAgU=;
        b=FIjfmfE/CJM/KGs3oandYl/hJXlCDhw3vUsSBTrQd7u/+X14HBGApdRaCkUm9zKGBS
         6zBmxkyXp8L/CQhnpgLemBGKB9oUTjwOwgoBMWVSggzSkmuEngk2yOY+Xnuxmg16Wdq7
         MEGxHV89OZK4GDPBCh3vyNu8xEq1onoXeQrVHr+YwtwbWBJX6SDGEjHvT4UKtX2UQ5oP
         LwLdVle4TVY8Q5DtqaYbC3+lFd1CIVCExuAzRQB0VUcVyHkHazRKgH29ccEtpHbWjxzg
         VZ20/1MGHKr3pajTStyoSJZ0IWrKtux+Oo8EEiez30dlqF7nRVVwyNHuZfiE9q4zv34Z
         +1bA==
X-Forwarded-Encrypted: i=1; AJvYcCWMXhENjw39DVu5dAFC1/5QowE17x8KCWHuX+dQDtNdXPom4f+nXSa9R97bOKI7rNMsB/6ZbJmGw8EZpac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqzbI5QUqwvc6vS9+NPKEsqWAcYGQtEjOl8sCkjh1g5o+OtiT6
	mdttVHh+0n+z2r3/+E7EZIoMlEDJCSoaG1ZF8i1DgXnghxy4FP7V7WkCgzj4/3vDYXFIwUKwiKe
	UlSEMEq2GHxqsuI1x2/xzuwyQGKLxwGgg5YmxZonJqk/khA3+6TY4eiQ9vMi4pnr8CJs=
X-Gm-Gg: ASbGnctqgmgL28UN8iKGBEz6SqQ9wzhPzVLdR7Bu2CwXbSu1LoUbIzJ+XxKZq44cObe
	BySpZKo4+QSemzPRErct0DPGpzQ7Si26IBiHZE3pB66G9JIkt6tySQUYhJSNtooxcyrCpQk/CEI
	Ho7oYd4+tqch0733ougOB0AnFmgoDNl0wlPPdqSKuvXyzt8uf8Tgf4lqiuaO9Ix275uXn1I9DbN
	Eql0WVPGjRZjjxVdXKBkDSOgpLGEO/AinRP9jBMijOjCeiOcMnKMePXEFU7voKBbDGmnwDkKnYJ
	D1NPpV/nQktO6VFGOpZ5m11AXK+aqQ/MLOVIOqy8HqnYGnqlEoZ3KlR15iWWVE18EIHoRVFs4lZ
	5cJua5hlHgsquZMurqYGoaTZIzO5MHPWmP/fE5fc+YD2fU9pzrv3sPmdP
X-Received: by 2002:a05:622a:82:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4eddbc80e92mr63505371cf.3.1763025913184;
        Thu, 13 Nov 2025 01:25:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiS6ClbvwDxaM59r7EvhMvEL75Aioc8hfQ0S7gbLkt5XCfLUoRC68WRgTYAfl76ADBEXhpaA==
X-Received: by 2002:a05:622a:82:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4eddbc80e92mr63505241cf.3.1763025912750;
        Thu, 13 Nov 2025 01:25:12 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3d87e3sm1020882a12.7.2025.11.13.01.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 01:25:12 -0800 (PST)
Message-ID: <c8584278-f771-4976-bdae-03379e1f2d03@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 10:25:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm8750-mtp: Enable DisplayPort
 over USB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Jessica Zhang <jesszhan@quicinc.com>,
        Abhinav Kumar
 <abhinavk@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20251112-sm8750-display-dts-v2-0-d1567c583821@linaro.org>
 <20251112-sm8750-display-dts-v2-4-d1567c583821@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251112-sm8750-display-dts-v2-4-d1567c583821@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA2OCBTYWx0ZWRfX6fx60xgL90cT
 K+us4K7CGEUNgqHP+7ZRvxzF0Nh3PPvFer7RhB7WFdxOzRnoAQWixPbqODqvoBGuafoisthSJDS
 NDHahI2AivZ7TfdaIDcvo0iYt9Wa0gzjc15ijL2p/NV50qYc06yCh+o5pHzUwwM5C691y9OBIcg
 aYL/FQ0ARunxnobLojxQAyVV7x/Am84n5AldTL7rDQArkgUT3UNs0SjhGbcaXb0KEfGJGSv88v2
 6QZxumXAwkUpMI9c0yW0lgpKakycS8fPXVjyKDr1qnbdbSacFmjbcWqdiadIE9yhTknUzuNKNWr
 WZPDUHKoTPSQLxJfdQXqnp4pb72HAhKBBN4JHDVljTPjiAuK9QKOm8OA639g4I+f3s9Rg6dUqDw
 VgqR3GBJ9rLIYL+ljf7OL2Rm/S8yPQ==
X-Proofpoint-GUID: HH8obiXf5ilMyKcXYDpVQjs2vDhtf4Ij
X-Authority-Analysis: v=2.4 cv=A5Fh/qWG c=1 sm=1 tr=0 ts=6915a3f9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=31XZ2xrWJyNqOSQKvoQA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HH8obiXf5ilMyKcXYDpVQjs2vDhtf4Ij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130068

On 11/12/25 4:02 PM, Krzysztof Kozlowski wrote:
> Hook up DisplayPort parts over Type-C USB on MTP8750.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 4 ++++
>  arch/arm64/boot/dts/qcom/sm8750.dtsi    | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> index a08bedd2987e..8d5a5d89a2ad 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> @@ -983,6 +983,10 @@ &mdss {
>  	status = "okay";
>  };
>  
> +&mdss_dp0 {
> +	status = "okay";
> +};

If you add:

&mdss_dp0_out {
        link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
};

you'll unlock HBR3 too

Konrad

