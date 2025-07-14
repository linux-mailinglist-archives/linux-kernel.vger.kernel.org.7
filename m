Return-Path: <linux-kernel+bounces-729771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A933B03B59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D423717ADA5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661B0242D87;
	Mon, 14 Jul 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XqSuegzd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D223E350
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486679; cv=none; b=X6/v8audPh/8puFeoYVSQYUfpYQesBWcT1mDeheWDFuDqAcs5uEW3sNcakm5RA+5fmkkwhi0RyE0fgb+bQ3tb8NdEDOYLKyldaSuxkKZcjuBoDau1Urx1jPlqIN+Wtz+MJ/5v8FPGxqkWfZyfiJw8gesUHgjUdqcL4AA7BaHzpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486679; c=relaxed/simple;
	bh=8Ixlobjrip1nqcFjIFVor5ZHH7s3I2YBGrk5vIYejjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZUQm4Fq/t9Mm88Hn8rVqxfpLYRBpOrZwnd2+lea9vCHYKcokuAo2sbfQXN1IqVctDLi5U4RViH9m33MYQ6RH9c4vCz2YVwF1iZBLlGEerNvsuUWpHYbyGiQgQZWsSyIFJHf5sA1pGZ5f5aIqeJMJ0GxA/NhIFgiBXFjRJLp2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XqSuegzd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9MBgU011638
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SE2IeTtrk0ayPpQnvY7BshNOEiVEINT52Om3cziuSro=; b=XqSuegzdbdlYtAIB
	+fPKtELUSajz1GVkl/bAvoZi6s3Vi3j6V+xZqaEgUyhY/FAlXMcey+ADW514r/Jh
	qgABRdwPMqpsaz7tA1ai16n2L46rRbNYI8qy4Nd6FSzCmfV4w33rw/APz7CLIHLQ
	mGJeH7u7noCbGGs6P7h53e/DclH1ngkdh0FJumRZIq9fVj4ebDbIwOnTj7brFeU+
	ZMw9OM4QEEIqsij6VUTzhUI3Vd+qxE1dykwyxCAaKY38S7KHfDVPEpsdPEttzatv
	u+VesQ65/QoB7KwU1j09tmta6HjrL45GKj2kFDzmL1lcqD6KaaOumTO1GKlaR3aB
	LKtPDQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47v56a2mxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:51:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e1d3bc3bd9so14005385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486676; x=1753091476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SE2IeTtrk0ayPpQnvY7BshNOEiVEINT52Om3cziuSro=;
        b=DYgGyeA2ghypIk4A/8xoJ1s6+r8LlubUMtJhoctjwy+kSpyK/aDHt+NcSWGP8X5wWj
         jCnAIcjODGiu0RI88M351birkqHeebrWaBc8FuNA0lFaeRbg478gl381T42AhbLn29hT
         iMk/oY2Ji04Umpr1M6QuOSKn6q1bhU4a4MQQjMleyiq073guJ31gEYYW4cI66WmpBRQG
         egjxwYs8ufQQz690c986gP5NzU2ecjETDMtOj54kaTYb7EFp80AnhH3Fv+WVqZ6CDnUT
         FrMVq7JZjTpqj5tmKVtU3rT2Tcfp2YJqbXIsFDsH9MSYxBBkuAI8zvnmTROYgv7gcX3B
         d/Bw==
X-Gm-Message-State: AOJu0YwANsTM1MhGkZkbAd2FfxTM4Mu7KTpH4EOI5On+SRlgJrQx7Ssk
	dIfWN2NOR8kicLDpIEggGMC7hqUgcfGSOqOx8Q9bhCw9eV2JwrhDTpvitxVKmJ2/rIwD9frv9R4
	lpOLGwIHfg5XF8Pg+8dJ/9hOjnpdT7nApGWjWtOEtyvjvbz9Pu9Ay+fatxccDvJLoyrI=
X-Gm-Gg: ASbGncsr8vNWtDeezrs1NY2X6zXISTs4a5/im42k9iaHNDookrXGi4k6vBBILn3hZBy
	dCGxyvDFHLhHYfVNevEf9BU8lpMDQjOBlOr8tK7ZM3ObK1HfZJ4fAM8RIHsZCUKcgOeAuOnejvo
	gxjuC+VjvukfgZPDf/ftTK91KTOFLOfFLunz/vfiZzD7+5/eJJVQN4gpSjl0VydVqBH3viNttca
	BByLR8/QuqXovdFVdF1gn6M6H7Ai1sWKaHOavVyIXTT8ufEzjiPVrzdiYfzGtHpuMYa4+0XfyCH
	f6M+W9tp9+G/L3zFQaYjnqXtmSCNEjeypdA7c2WhgctIyyG4AQqT9TXKyIHo5XBSiNt9jtmQXVC
	4w5gCoWmap360f0dWPQx9
X-Received: by 2002:a05:620a:3194:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7dea52c0555mr549788985a.11.1752486675811;
        Mon, 14 Jul 2025 02:51:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKaqv78TXsNVN0OlnoiB6VdcywFZex0vYLYPu8U36H8V1H9RGZypSEPq/6bJXicQzO2ZqZpA==
X-Received: by 2002:a05:620a:3194:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7dea52c0555mr549787385a.11.1752486675216;
        Mon, 14 Jul 2025 02:51:15 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9733d71sm5932247a12.43.2025.07.14.02.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 02:51:14 -0700 (PDT)
Message-ID: <c67dc09a-12e1-4764-b0f2-6c18bc341b7b@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 11:51:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sm8450: Flatten usb controller
 node
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, neil.armstrong@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250714045310.2092385-1-krishna.kurapati@oss.qualcomm.com>
 <20250714045310.2092385-3-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250714045310.2092385-3-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pQygvGQijPOP4op5UaJ9rOq_iBMzU23w
X-Authority-Analysis: v=2.4 cv=X7BSKHTe c=1 sm=1 tr=0 ts=6874d315 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=DX9r8lL5g7En1aC3f4oA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: pQygvGQijPOP4op5UaJ9rOq_iBMzU23w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA1NyBTYWx0ZWRfX+w0zDT4iz8cS
 gRehP5Fp9wGex2mKlZsjZtRMTZfdJU0HgDcN9JtwnmSuCmTb7I16lNfUhxDimae+9M+ZG1pySla
 im1qjduN90VKv/FrR74F71qttKzVtanxCtttu2Lim0qaDx7dsgh+nXSDOGiIENz7cXSuuRQqAO5
 usdWw/PqHTJzztfl0teNcT1VWTVr43rMNVt9TiTpzY6T9FcyPHWSj5Pq25d0h+IHu11jA4QCDSx
 cqgMZcy6xnNtQtCcIFXzS8Ak5528uHpmzuUqS9lputiwgNoT6PajmuCJ49Jm5KOZA23rbJlfZxX
 /X5SpJwUx7WV8PphgEB1zgJvYWd1hQWgLc9dYRn1mPBQ9MIfID00gVEHXuM1ccqi+6k717v48W5
 w1AdCsI7+BWPSWir97eMkdJfP5uRebcbaG3gGtYcAFOTI3jczUeeiJQjplPF25B7a/NvnR62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxlogscore=830 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140057

On 7/14/25 6:53 AM, Krishna Kurapati wrote:
> Flatten usb controller node and update to using latest bindings
> and flattened driver approach.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |  5 --
>  .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   |  5 +-
>  arch/arm64/boot/dts/qcom/sm8450.dtsi          | 57 +++++++++----------
>  3 files changed, 27 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index 2ff40a120aad..0c6aa7ddf432 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -1199,11 +1199,6 @@ &usb_1 {
>  	status = "okay";
>  };
>  
> -&usb_1_dwc3 {
> -	dr_mode = "otg";
> -	usb-role-switch;
> -};
> -
>  &usb_1_dwc3_hs {
>  	remote-endpoint = <&pmic_glink_hs_in>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
> index cc1335a07a35..6bd315e10992 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
> @@ -781,11 +781,8 @@ &uart7 {
>  };
>  
>  &usb_1 {
> -	status = "okay";
> -};
> -
> -&usb_1_dwc3 {
>  	dr_mode = "peripheral";
> +	status = "okay";
>  };
>  
>  &usb_1_hsphy {
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 54c6d0fdb2af..77104def5ced 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -5417,12 +5417,9 @@ opp-202000000 {
>  		};
>  
>  		usb_1: usb@a6f8800 {
> -			compatible = "qcom,sm8450-dwc3", "qcom,dwc3";
> -			reg = <0 0x0a6f8800 0 0x400>;
> +			compatible = "qcom,sm8450-dwc3", "qcom,snps-dwc3";
> +			reg = <0 0x0a600000 0 0x10000>;

I think we want size = 0xfc100 to include qscratch and DBM (but
specificallynot BAM)

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

