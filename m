Return-Path: <linux-kernel+bounces-896845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E882C515FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 007494F8270
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C965B2DE1E0;
	Wed, 12 Nov 2025 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SOmRUw7K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z59uda3n"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25632DC76C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939688; cv=none; b=CTHl8o+xgF5IfBRIPfxPm/TNUPAKABG2uxsEP2BcNeXRi4aY2sAUtm+bgaKXEmdWuYfe1jBxgOVTQgF2D6kLcjG8h73BzwbGZo5K9uXYmIZDpaNu7NPfjsqk1/q2oXurih1tGknGwhXo9rgGz75mIVU0DZpu35agb+cI3bsHkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939688; c=relaxed/simple;
	bh=kpajzfk3rDAEjSNP9zfr7jMwHp4VKhF/KzKQTb7TXKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWd5SgvIYTbtY4M3nil1eKbISpNRnEbItub8E+puWQcrBIZHSnNxSnpC4hwRjVwXzIhuTSNXOfp0CDHFxUAtXBU0LGuludUJghfHqvOizEVChjTXv3jzN6GZ3011DgFaDqPKyLlyfSASfDEj7dhr4yvb9VFUnF5k65iqcDrAY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SOmRUw7K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z59uda3n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC3HCch4052883
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UQyIyIHzX6mvdwDeO6aUWHKb0Z58Y9WeZ+jXu9rEMRI=; b=SOmRUw7KG6qiNAQQ
	gDGji5E7TWZ0PrFhQwdF9QHP/DOV4FuQtJ9wOSbtvTTkPTKDeRxGg9LrehXaezdr
	JpwdCCyzNBDNxspenIr26zPiYzLoyJzXOfwSnYDo70ay3bUyczjQrPY/Q4kG8VxS
	zVbY9qxapd08nxn4ADc9ULlismg5GRxsYspnhMw9QG3ykfvL8wHKg+VWLflG5kni
	ejEL+rmCZdXRc3Nfxj4okfXRJ28M9d5Em0pmZ8IaJzVldVdT2oRFPHS8S3orVP3R
	miU6iUe5nO+zWkdOkEMNCe4FifC1VT8kdDWXDw570unF9+ydUi3hSl6QKPfj+Ew+
	7kfvVg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acj6v91bs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:28:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed861df509so1757971cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762939685; x=1763544485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQyIyIHzX6mvdwDeO6aUWHKb0Z58Y9WeZ+jXu9rEMRI=;
        b=Z59uda3nOJ8CaTJ+2hGPt0cN5OiHXZYwLoM6zKoMcoOHFDeE8A7DwzK/CDPdRGA++g
         FC/Ad6peypvePZkPC5NJJeMR40trR2h2m25NNgvd12zVqse+c7k60fFIGqvLxs4CGjCv
         HLbMpjnU0IAzM2I6YtX1XWZcHMf3JL8fjmesLh6WJZ5MnfrW/T3uJkytzfaRhwrgiOqw
         Ah143SBIRbwI8vZstgOpXjZ6T0Lx6EcKGk8ApJ93O5rbZSkkkht78mpAYPGJWyAPPx1X
         CKOJgTuuWFfkwR7q/SMe2EoSLvyDd3AzK+miLIE9m8imOMstXaqWVz3+QjsUH8t6jIrg
         /3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939685; x=1763544485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQyIyIHzX6mvdwDeO6aUWHKb0Z58Y9WeZ+jXu9rEMRI=;
        b=XuJWhGBPKF5JzSou+4gKWMwjtcGkdORgErHoGcsIH592IKHMCWU5o7o18CIoEoJC6U
         OipedJsQB4SWKzbanOlqhPvAkDCpIr8x2Jg8akcUpRDCIEIP4XvePr0CMoHIgfNutSjs
         zdmLld5l98APMMaveelJhackq6PgRhwAwkTOtXm973V9cWeTB8R+Znp+adnNAWHPJrg6
         D5KehgV/Kki7jujS4vtm6G66sJNlxflQP74BpY1UyQUHpOMlk+pss8XkAF0pZ17550Nd
         JOQaGZKxk1c5TcqDt8WT+Mm3g5zhFo2t7tCW6c6q29G2cQNWNrEDstgO7HnfVdEJrXvX
         Iglg==
X-Forwarded-Encrypted: i=1; AJvYcCV01kXevrhYMYE54sncwD4xaoLg/5jSWTL+pgwfKRRAYxQGJWHRnkPnS4LmqDjoloN8uxVV4HN3LfGO40E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFlNm4nPrRUmHKVCuqpMD+H1k/ctG3V3ShYeA80pf4tYf/K8l7
	PLKuD2p3zl90sJ7Ob1EnJvvN2HShRa5j9W5RY5Ej0SCesRVdfk7SG70tBFceKHxw8q7gsvjgVFB
	USrD+PD8wbmWZnXuPJ43ou7IYprORkCnkQFuEq87IxnHqpl1wQ8P65B8xC4Ba6Vzedr4=
X-Gm-Gg: ASbGncuppURAsf+63P0zjKgOji6cgKCqYsy2Wa3PiumS7wv0YaWOZ0Vss8D0kqAVKD4
	tryIoNzrR5xAdvsiguqfPKEkPFVw0Jnk2IdZwbhBQEtxUGyis83C+Mm7FiFk/F6PkVEdwME3a+t
	kDnWSvXPXmDr6ypwoLyUwse15YeaM8y+dBSmUazdwK4eAJckqcLk09QhxOyekabwl3rIKc3aA/1
	Fp3MVEcGcJSiMNxrabetwDlGzeYJkLgpPQCfE2WouIDUB+uhhjvuKHxwGXhM2ah/pdGDKc1pd8w
	UJ6HjsqWa/u5LNPagaz7bDcy4Z4zvy5mFG4nrnL7DspaO8IZeVwXZhqJ2vz6w9nD1h1AdwRbUM+
	cHSYJ4c5rxcpNnsUM39AO5o0170OQAGOTNZsdrbJ2jOYFqYtgPH5Dxbwm
X-Received: by 2002:a05:622a:180e:b0:4ed:b9ee:3cdc with SMTP id d75a77b69052e-4eddbc3b54emr17962451cf.1.1762939684923;
        Wed, 12 Nov 2025 01:28:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR4/W3vDk4YLbccmyiv4XaXdLztuoz1oWe+zLmX65bWXg3EkzpMp4c51bebuFk9GFGSmrF3w==
X-Received: by 2002:a05:622a:180e:b0:4ed:b9ee:3cdc with SMTP id d75a77b69052e-4eddbc3b54emr17962291cf.1.1762939684402;
        Wed, 12 Nov 2025 01:28:04 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72dbe7c783sm1295611366b.50.2025.11.12.01.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:28:03 -0800 (PST)
Message-ID: <55eb7543-7b88-42e2-bb11-7c54c4e59801@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:28:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: hamoa-iot-evk: Enable TPM (ST33) on
 SPI11
To: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251112-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-v3-1-39b19eb55cc3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251112-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-v3-1-39b19eb55cc3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Vu-bhWoERH_D5_pl9Xnl-JBT09vjEYou
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3NSBTYWx0ZWRfX1V2pMpTp1sFq
 eCVRWfrvsVyGMsHRGs7qG7GJeT/azmm7FNtQl7ApDhj4aFC6cGNKJE8xXSGGb0Tn9VANogKHzTK
 +KstsuPGKRFbzmGp/TW1QCc8Odn4FZUKzEJwaKXY7twaG/kNDEbX08qd5enMcEKLBKd0sWc5PB1
 pCOtfUiXKEG/AHLZIDCU1jNwfNdGvDdhG4CNdQyM8qRFonKrmkdIFvHHdgQtTlSjoYTGAcH5vfX
 FKn7L6wVGfgK3b+4CQeakI8LyRX91xCfkSGgcNT71cx3E3x9D66ozW8l2EwQ6vTeBBMuc0qYK0F
 xRE+C9P237UZe5R1ImfYlSx/YyQ0p7/KFGoF1SsV9p+xhm89IwX5rjJG24M6qgNPv5mrnouXDK7
 mWyMuqEC56DT3tjiLerrwZwMJwJktA==
X-Authority-Analysis: v=2.4 cv=f8dFxeyM c=1 sm=1 tr=0 ts=69145325 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=7d4G-bKz9gYrzHuYZ2UA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Vu-bhWoERH_D5_pl9Xnl-JBT09vjEYou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120075

On 11/12/25 8:42 AM, Khalid Faisal Ansari wrote:
> Enable ST33HTPM TPM over SPI11 on the Hamoa IoT EVK by adding the
> required SPI and TPM nodes.
> 
> Signed-off-by: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
> ---
> Testing:
> - TPM detected via tpm_tis_spi
> - Verified functionality using tpm2-tools (e.g. tpm2_getrandom, tpm2_rsadecrypt)
> 
> Depends on:
> - <20251106102448.3585332-1-xueyao.an@oss.qualcomm.com>
>   Link: https://lore.kernel.org/linux-arm-msm/20251106102448.3585332-1-xueyao.an@oss.qualcomm.com/
> ---
> Changes in v3:
> - Squashed patches touching the same file into one.

Doesn't seem to be the case

Konrad

> - Link to v2: https://lore.kernel.org/r/20251111-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-v2-0-101a801974b6@oss.qualcomm.com
> 
> Changes in v2:
> - Use "tcg,tpm_tis-spi" compatible to satisfy dtbs_check (was vendor-only).
> - Add dependency change in cover letter.
> - Link to v1: https://lore.kernel.org/r/20251107-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-v1-1-8ba83b58fca7@oss.qualcomm.com
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> index 36dd6599402b..aecaebebcef5 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -917,6 +917,16 @@ &smb2360_2_eusb2_repeater {
>  	vdd3-supply = <&vreg_l8b_3p0>;
>  };
>  
> +&spi11 {
> +	status = "okay";
> +
> +	tpm@0 {
> +		compatible = "st,st33htpm-spi", "tcg,tpm_tis-spi";
> +		reg = <0>;
> +		spi-max-frequency = <20000000>;
> +	};
> +};
> +
>  &swr0 {
>  	status = "okay";
>  
> 
> ---
> base-commit: 9c0826a5d9aa4d52206dd89976858457a2a8a7ed
> change-id: 20251107-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-c8353d7fe82e
> 
> Best regards,

