Return-Path: <linux-kernel+bounces-721467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1132AFC997
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879B8188C346
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2016D2D374B;
	Tue,  8 Jul 2025 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGHS+AXF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE619E97B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974223; cv=none; b=WCsL4xQeQjQ2LVQB8sKIsUgPfNkKH9mZr/Hj3w/hhx69nyFJDGW2GaSNWk1UJhM9iE6+5AVyWUi9e4TnVEQIbIEMZ4rcIRpQjvDVQRXolI1c3nCmw2Z43+URTb9n/TufL7+NAfeZgGDt/MlVaC25FH7xyytIap0VcT6h/sqe4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974223; c=relaxed/simple;
	bh=klGJi5IRMEy+zJ/wOTbkEcbW04rsRXiKayvKLjZ5JwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erfKpvNxm/e6IoasYBfX24wNhdzg4k/GQI8ip3mpYMdfGGmvSgq5q1XHD+JGcUoO1dfpj0YcY9rfGl4qDK2dud/F4L3R1/BKBow9uTLJTVU6ItaqYvNs+1MxYtDPhJJ/75SISKvab7dY8RPBKB4tOwqz/xfxb1VMFsBbkhtQCCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGHS+AXF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAOAX001157
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 11:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gtrnTCa72vdba6TcO72tSZeB/6DLMVbveL6Baz70m+4=; b=ZGHS+AXFU5y2JRxX
	vWjW1aWgVvntUtRgBBOMutrFJO4ENV2inHm147PVqUIvp3FmU4evvEyw/L9TmXSM
	Vngx9fdfYtGAY0/PfH5vCF3x1yrEjYWbuKBzvbdMRN8BuwzkVM1xnoQo+IVyCQp5
	/TaYB5NIYbsa0KdHAcARvWO150opKHmTg/pW0Fihu/WCbbvE8w2Bw47Ugjim8Za1
	d7Dn5D2lMOCSPFNTP1XPZK+4G5yyArqU2RUjEkVA1tWqwqY0Y2Yy0GkukAX+iyW6
	pFF+KTabdUGk7aGr7X+Ve7sLSGZZPeC6t4YRT9PM0yQiXbkijJrkD50k/mqohZWW
	w0iZYQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psdqwbhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:30:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fd1dcf1c5bso11968786d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 04:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751974220; x=1752579020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtrnTCa72vdba6TcO72tSZeB/6DLMVbveL6Baz70m+4=;
        b=qKGGi77wWNx7TkmRSIZKaIT8BsfEBVMx5As+zWSQJNWAOHvwJZDFfOBQW0sdmIMj3h
         H+9iR79Sfx3Om8cxdRaFXXTn4hFjhndZOejDax5ZR2ZJpq9oMzUoabYhwYDNmOTskJ9F
         VCylahi9dnef89pS9ewdwcp4gbP3hSDEgeNZh2DNlEINdvXoTt0dzORPbSYqcUV0qAAc
         VmlocQ4+VmCL2KgPDxKEY1OmNgaRb9yBM6kXj6QMuvO8G3Pc+0Pcjy0GcsA3qOa+tw82
         nrbgqcl24i8isCZ220Kwc6Ae289I1VTns1/vCpEPC+rnKcbJGVi1XvjfLXysHFP/GWxs
         6Xjw==
X-Forwarded-Encrypted: i=1; AJvYcCXldRmJco+SSz560xZvduyjl6sXKNdagkIARKchtVd/3YIRcRfB13GG7hLLyvkt9uTf6PYRCsX8ejnaGkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnn7U4f25vtw6U2cw5kaeuT3cMTYSBBVaYIacLWLNgbKDABOtz
	dqEzGgjVXoDm81abSSLvus36eRjyVOlNAKm5swGFaSGqcnnG+7XTy/xW/PEmuNyzkgwAjzPvtHj
	Nw7GyrdXWHvmYu1XpdJeDbU6czyTBg36uDPWqVp/z4Sf3SX6xfXtKMFqHf4KT+tmSFts=
X-Gm-Gg: ASbGncvo7bqVEwvfSb7pBfoDcp0O/d1kuYqzlX85T3/O8fcJDPzQX9CSaJlS/FCxy/2
	0yIW1EOaRZ6ojBFcDRdrpMEuEFtL0RqoFVCadAJInNLbcgsSA/RDR6uvfDuAPa1IPT0x57BBq7U
	wAAs41qhwduzB2iG5V3PksEUwptmSCKP28eHNm1sQ/8biyCAGCRn4LJn/DqesnTOefEsE/wbn/C
	WgxM+MK+PMAc7BEz13eg5xYz9Tku0iSdT4zhfNevrACrtBopYa3Rr6Ty0sXCHv/LfuErI6Qba4k
	gwtE62aDsIotYW9J4ab9MkqUOaJ9iteyEIghCVKb4R9BJvJFG3/hLqgefuryfibgWJ1EumO22FL
	2U3k=
X-Received: by 2002:a05:622a:4acd:b0:47a:ecd7:6714 with SMTP id d75a77b69052e-4a9975d0949mr94377721cf.9.1751974219849;
        Tue, 08 Jul 2025 04:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1F23966ZtLAdemkWX6cjqDae6AFYWaUPA2/p/PB3EepYmlXUPOU0//eXUxa+wOGcNN/hbKA==
X-Received: by 2002:a05:622a:4acd:b0:47a:ecd7:6714 with SMTP id d75a77b69052e-4a9975d0949mr94377161cf.9.1751974219165;
        Tue, 08 Jul 2025 04:30:19 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac67bbsm884840166b.96.2025.07.08.04.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 04:30:18 -0700 (PDT)
Message-ID: <0a09fbc8-8835-4e94-862b-0baaea5ee251@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 13:30:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add Milos interconnect
 provider driver
To: Luca Weiss <luca.weiss@fairphone.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708-sm7635-icc-v2-0-e158dbadb29c@fairphone.com>
 <20250708-sm7635-icc-v2-2-e158dbadb29c@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250708-sm7635-icc-v2-2-e158dbadb29c@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ffSty1QF c=1 sm=1 tr=0 ts=686d014c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=0e8QCNbYJG8j8A-s5v0A:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: MotFZbYm8QkHqEmfNuoNAR9n8LSUbOhz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA5NSBTYWx0ZWRfX7ePPcPvMLW9V
 veab3rJuexgFnN7hSKtXuzgtcgb+AOp4cDV693a4I2xgoGNVwFE0IvSfLCYAHXDwAKXpgW0uXga
 SdJlZdkSYTmIfCDfGW2PNsDAEKBJRzcVGhv6bn0EkUmP8v+DjcmbiO5pGzLeeJIKSfzN4brN3IP
 IG1b+vbbciBQIDMEp+NwbZS/+wK+x5TIeqBjFJQAUuxKZhuV9QwTp5hU5NYjH4zu7mYGTCj212g
 qj5/n90zhGJhOVFG21STiXB8Qxz2/OSTLpV5gL/ujegUFY+QTXmELOzrSWsZCVxCx7cJ5eaydav
 Hbi2pjG3VivmBxF93wt6+ghxjgOlW8KgENNMwPvN2VjQNoiaGMEsw9NsT5DhppLYtGXIKidyk8o
 ZQh1emhlxI7AbXeMGpFU8zDgDQXBX2eHpCj3sZQfZYwqulpzCgSRoCzFdnj97xjiMykN1sg4
X-Proofpoint-GUID: MotFZbYm8QkHqEmfNuoNAR9n8LSUbOhz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080095

On 7/8/25 12:20 PM, Luca Weiss wrote:
> Add driver for the Qualcomm interconnect buses found in Milos based
> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

[...]

> +static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
> +};

You can remove the empty bcm arrays and .(num_)bcms assignments
for them

[...]

> +static const struct of_device_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,milos-aggre1-noc", .data = &milos_aggre1_noc},
> +	{ .compatible = "qcom,milos-aggre2-noc", .data = &milos_aggre2_noc},
> +	{ .compatible = "qcom,milos-clk-virt", .data = &milos_clk_virt},
> +	{ .compatible = "qcom,milos-cnoc-cfg", .data = &milos_cnoc_cfg},
> +	{ .compatible = "qcom,milos-cnoc-main", .data = &milos_cnoc_main},
> +	{ .compatible = "qcom,milos-gem-noc", .data = &milos_gem_noc},
> +	{ .compatible = "qcom,milos-lpass-ag-noc", .data = &milos_lpass_ag_noc},
> +	{ .compatible = "qcom,milos-mc-virt", .data = &milos_mc_virt},
> +	{ .compatible = "qcom,milos-mmss-noc", .data = &milos_mmss_noc},
> +	{ .compatible = "qcom,milos-nsp-noc", .data = &milos_nsp_noc},
> +	{ .compatible = "qcom,milos-pcie-anoc", .data = &milos_pcie_anoc},
> +	{ .compatible = "qcom,milos-system-noc", .data = &milos_system_noc},
> +	{ }

a space before '}' would be neat

Konrad

> +};
> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
> +
> +static struct platform_driver qnoc_driver = {
> +	.probe = qcom_icc_rpmh_probe,
> +	.remove = qcom_icc_rpmh_remove,
> +	.driver = {
> +		.name = "qnoc-milos",
> +		.of_match_table = qnoc_of_match,
> +		.sync_state = icc_sync_state,

Are there any issues with sync_state? (hopefully not)

Konrad

