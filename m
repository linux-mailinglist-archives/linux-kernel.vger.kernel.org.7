Return-Path: <linux-kernel+bounces-816301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB29B571FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B6D189F7EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7BC2E041A;
	Mon, 15 Sep 2025 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nsQLO7UA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14002E2DFE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922596; cv=none; b=RzTw49SYLjHF4V6uhI/fu7cRxlzyovh8Jl834emGT9M8vxGdT6CsN3ecC//3o+ar8wj9eqHaGKzbh2WwA5p3NyQe6wNZGsaxFA0fbR+lSi0fy9jYcpcnlqpNtJYX1VMbl5EcBXyACqplSrV6eDJ760c+ze6DMIFKau1hXFMJuzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922596; c=relaxed/simple;
	bh=nJbvDWyIsUQWk9OzO7GLVb1p8RNpMPZw5O64MziGJsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXdYaiNxNEB1XStwjND8myDSj+k6G4LrjPhXRj49PvDkAW7CQZxDVdLLFVsqL3Ldg2321hyeo4bhoFxOm3GDmaMlUweIoKFqdUBbWcmoEZdPS0APU/JG5M7VP+uwKDtpAmzdncGHy4WWIEnSC3CfGV1JzxBPuB/vl5Ibd7DK23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nsQLO7UA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F7I1Nl004787
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tnkhKzB3cTjh1Jm0VWCLO2P2vkgaZAhGkakhCBvhtj8=; b=nsQLO7UAf5OE9/3n
	c7nyvYhh8Bj8HiXH5HVE4YK96wkYQ+N61SCYjfjxtfRml8MzxjcKPrc7UAVZNpc6
	MMMcg5n8OD0TtHjxiX1eP87k2nEXcW8URKl28diMLopdB/XrMTeMNnxjNDG9+xHz
	sxBeaVknR8zj7sVTLjLCEKGe+V4o9JAJN2Dhiky7JOyOzuNUCjiomgE1UBVKoiGC
	16jsNBmK8eZX9JSxh1NGZCiIf3uHUco5uMxxwcySRdDwVDWfM+2nhWGJ34V/LKN9
	n6odQ39uQiP6VESsKvaUvZeo4FSH/AjyF2Bq1GrPfEzEmpPgkpFFeMG4elqo2OWW
	2ytIzw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072kxdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:49:52 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-726ac3f253dso10682496d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757922592; x=1758527392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnkhKzB3cTjh1Jm0VWCLO2P2vkgaZAhGkakhCBvhtj8=;
        b=EltuXHCEVyaegFhFAl+YhPZb/fMdv+vLfxwmMFu4cPkG23QQ69mE7ZHFChztUi+52P
         csKrQZgtdugkE6F7Lf0tuTaBQdH14KVUy+FkCVbFmWRCQvnHcZ8boiE/FsqwUzjCPh3s
         2pom22m/drZQ6cd30V5GC0kS/AKjHMDDOkBsY3Xsn6SQR6WqL3/c2BDSStapHj5pVCtg
         aE9VAMiiIz02TxtPx9rYEu6AwGOuW1KlxZMuVgD/0biWrPVbs5XvZgWU3Voq9rLmiW7/
         stvzZ0pzE7C43xMZ6jFLJeHqth/WX+1TEwkSZ+H97s3R2N40BJcDU+tszlXS8i9jfXXd
         DGFA==
X-Gm-Message-State: AOJu0Ywn3BPMAL3BTYoSeod8i3exxb/G/T4tD2xHfx1TkTz0LwECjZnF
	9a3h8BRCDn4KpaLeBx3HX4uGYdBdisncvO4YthB9ahja7U6f94EBCFnRSsF8iC3vazdVFjaGSSj
	8ymZjqGwcxhyknj+aoQcy7MBMqIJ6+dptHRvRKicJ3x6IumO0eMHNx4DlL/QfbEHOFho=
X-Gm-Gg: ASbGncs3uuxbMOI8C9OhdweXUy2vdDcPCu7OSr/WOf9O7JTZ4QQOHpyAjMInBfy4Dsb
	Lvsj82lRL7thz7xKgb4DQ1k6Z4ZZ9zfR+iQljNxUfqXfT1BIL6cWsEtXTEPxBJyV9aloNosy1cQ
	z+4vWW/egaNUfXZ1DFslOt4N9EWZUHQs0rqOjMwc4OWCPX/ZF2hpVjECSt09M0Zln5L6G19ftJL
	exiVaE0+qjBQXPLtXC8/iMP0Tpd0yzsSMSuWiX8chHQMvQ5llw6M2vA0r1jY+kxYLzIBX+zu9gQ
	8ahFr7z1HiUDZ+2NNwAQoyNO4dxUvGvjSe7BK9PFFp+MSwPVNpNySmGzR7B14oTaDgvbELaWsPj
	0qBYuTNPwDIkMoKEsdkdFxg==
X-Received: by 2002:ad4:5fcf:0:b0:74b:7908:b037 with SMTP id 6a1803df08f44-767aeaebfd1mr101391806d6.0.1757922591732;
        Mon, 15 Sep 2025 00:49:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHJ2mWH2t4Qq8AtZmB7v2EaqSnwJW0KUMh0XXzRrfB5UlrVR1nKNYtdQ0ViWTInmxe61E+gg==
X-Received: by 2002:ad4:5fcf:0:b0:74b:7908:b037 with SMTP id 6a1803df08f44-767aeaebfd1mr101391596d6.0.1757922591270;
        Mon, 15 Sep 2025 00:49:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ee7b531d7sm6199740a12.51.2025.09.15.00.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 00:49:50 -0700 (PDT)
Message-ID: <a3ce0aa6-41d3-4ce8-adff-14c767d7f871@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 09:49:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: max77705: add interrupt-controller
 node
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250912-starqltechn-correct_max77705_nodes-v3-0-4ce9f694ecd9@gmail.com>
 <20250912-starqltechn-correct_max77705_nodes-v3-1-4ce9f694ecd9@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250912-starqltechn-correct_max77705_nodes-v3-1-4ce9f694ecd9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX9k6L/ceIhHzr
 dmi6q3Z3iRTmgq3XfMFjJwPqDn3QmIF3MVd69f2nhcYck7AwnZJPnzoQwew/bivvnk1G+wPQvLv
 OWg3L8bu6xbuxcn2UdJujXjl6AhQR//ZujT56lWtg2Do3x6HK9/fd+S1Sqs9nMiV+jnQutxpfrk
 gsZ49Y0T6XiR9tJPlVXLpujp1HgV9FTxUwYhxDJPbCmKvwLBA0idat9urzj+Lt8Is8qFEGoNOj/
 mTV8gBQx75zCZZVON1Fn2lfHDVUq5pvSnNLqe56ozIPS2v+LjSJxbVPJ8y5taG9VaOU8MU0tAyE
 5w22ALy1J//iP1LfdBbgqc+cisDzrlOP5nT7mlPaZCQt7GHatoZVFQ3voUO2KdoZAH27KihLO3B
 33lvKTLz
X-Proofpoint-GUID: JupDXibZcWaNg3pYR9JYG0fgSDYlVgXm
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c7c520 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=8NCsgvPOa7tqS022DyoA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: JupDXibZcWaNg3pYR9JYG0fgSDYlVgXm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

On 9/12/25 6:47 PM, Dzmitry Sankouski wrote:
> Add interrupt-controller node, because it has dedicated interrupt source
> register, to determine which sub device triggered an interrupt.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
> index 0ec89f0adc64..d265c8213a08 100644
> --- a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
> @@ -26,6 +26,18 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  interrupt-controller:
> +    description:
> +      The driver implements an interrupt controller for the sub devices.
> +      The interrupt number mapping is as follows
> +      0 - charger
> +      1 - topsys
> +      2 - fuelgauge
> +      3 - usb type-c management block.

The MFD driver registers one more interrupt, and these don't seem
to be what you say here:

static const struct regmap_irq max77705_topsys_irqs[] = {
        { .mask = MAX77705_SYSTEM_IRQ_BSTEN_INT, },
        { .mask = MAX77705_SYSTEM_IRQ_SYSUVLO_INT, },
        { .mask = MAX77705_SYSTEM_IRQ_SYSOVLO_INT, },
        { .mask = MAX77705_SYSTEM_IRQ_TSHDN_INT, },
        { .mask = MAX77705_SYSTEM_IRQ_TM_INT, },
};

Konrad

