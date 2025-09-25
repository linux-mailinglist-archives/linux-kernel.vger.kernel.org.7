Return-Path: <linux-kernel+bounces-832387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D6B9F341
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272EC1C2263A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03FE2FBE1A;
	Thu, 25 Sep 2025 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ael7FWl/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DEC2629C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802813; cv=none; b=p0uVwNbJzDsMm67T6F/qK7omkUB9mAKBHr4dFPiL3CnXlqy8v3RqisTj40ACW6+nUvv0wUtDJg9j2ih6+K3vA6pHgzY57GYExlrT3QchDu3bYWyRlPhz8jihE0Cy7B3ENV9jLniFdr6Isu8UZmfyLj981xt/0fkCbU3qIz2HlNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802813; c=relaxed/simple;
	bh=nkjFcRUmQdVbBKA+yiCUYtFNLnfkF7akgO0G61kibjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fv5XrimoSK4pGqRf+6wk8TlJA/pOg3xjLG95RKiHO4Mpg5JkV7ZQNEze/etRIrlezQu0laTVHf/4zK391KOVulFc2KM32YUY+13Ugn8uhwv3Z7nhC69602lt0yIH/D9KvBlF3G/jd5JQ9ZV3Sn3tN8442/GDNo3LSCfvPT5uKFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ael7FWl/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P8FdAm018220
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y3WO2u8skIHyvmA2dL9l/HFQcv/2c0lN3eXWLNIsu0Q=; b=Ael7FWl/qOcVO9eU
	8AUUcSdvwGAdm40qGKQUtKI2caPDyFBF3vlV5hDfSwj1kCzd6i4IhSaLHojKzQfs
	Fetx19gAAEtFQ1/xxgVVRBAd4gddzP5d2TiiUq6y4laSm4U5dLKtjxyMsjtahlbD
	MEKynNy5mMG80y8J2O8iUKeryZtEwCcz37pp26ATuBnrCLfWtwuoGEJnQW7F4eL6
	A2m+GoVTNTzHvqTtTFA7tKvMRMKBIrLXoKB9donpmtIAttGpadg8wXLMp2cKAR7s
	r1NYALUM7i9XMLokWPYwbhljWvxMo5ZTnLpdAQmSBa8MhHtb4mhSg+ix9bOVT+mo
	CK/IgA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkc08p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:20:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-85696c12803so37848285a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758802810; x=1759407610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3WO2u8skIHyvmA2dL9l/HFQcv/2c0lN3eXWLNIsu0Q=;
        b=AM2kXEOnq3u164XsYH40vKjOk5rxdgVR5TMWEqvPfhTbV3vBNYl+R0Aczafz03QFKd
         R/PA+RuEg02eQlQZj4FUnrudCptgFyu6H3wYEKXdKPrt8CRvmZlGM8H4/pDwVQI+MwyX
         83qEmGEKYZsyppSayzMxIDxA8AkR/R1WcixvZTbzhJDjJi6gIuH36fPe1v9gd/H5BWG7
         a/B6HtG76W0GsRaW9IW59GH3BwqGAt1DAlwvmuA+Sdqi3lEQTPCnCS3BTqr269DgQKRr
         C/j9falyM7lMr73bK2hMiFqy3vaUhzMafgHh+toNaj9FeH0VvIJTYxXFpbYZvgA3mNy5
         Vwzg==
X-Forwarded-Encrypted: i=1; AJvYcCUvpzgFM5/fgVdxrYPqOYDFJT0hboie8OGHawOS1KT/NDY6bEFzYfsQfnMz1VDSixI9Iu1Rl69xxGUwFvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/usmMzfIfgmgN3otIYZ679PNhLxKwHx+mjqBP9qC8dlz6Xpeb
	tjNWlqvVm/kaxR6NAjYB4wigxduzOqOU6N2inW4J9aNL4KII+IkqpSym7jkJxnpQGTSNuDGwtjo
	6lhaXRZsIy8SR3RJWOLfZSZfv/+oCJHkclGW8JyW7J9JjfThLcDDyUX9N29sPrpdXzlw=
X-Gm-Gg: ASbGnctghlHYqNRZTThPDghrfaa4YI3BF63tqcti9Fl77lSIrIN+bNewi2BZBKCvnfV
	RCjXCk1C6Gi8wq/3ynIYb1gDiuf4jbaiUr/3xsDm2wiD3wtzLL3BMKTtU8MYrFzuVDINNnQtwzi
	Ffs8DL0IE33PDhQMw6iPvW3PgQvGa2EK0BLN9L/xNspHs+sPfdwNiizdzATq7cjhS6mJttk0ClW
	felTZKz/nByUoo3ED16rEZsvd1wXWYzsf7qdoCDOUKZfGwpoutP/8JexbUPNvqL56nK0WoflQNQ
	MhSnBvleKf9z0HOk2h44PUXn1uwI8q6p+UIUzS28WILEx/NBXM39AaMmOzrW3K0jWPmkzeas2eN
	xCu9EPxy7A6t4DJwwnIB6Gw==
X-Received: by 2002:a05:622a:1488:b0:4c8:39e0:95a9 with SMTP id d75a77b69052e-4da489a1c99mr24122341cf.6.1758802809430;
        Thu, 25 Sep 2025 05:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkPHMGj8Bq3JTeWfgKB8y3Vr5vymH2QWBEc2mX9WeO2YqWDeYeVJl2bthWSLafoqKlPFuqiQ==
X-Received: by 2002:a05:622a:1488:b0:4c8:39e0:95a9 with SMTP id d75a77b69052e-4da489a1c99mr24121901cf.6.1758802808809;
        Thu, 25 Sep 2025 05:20:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af4bd5sm1083908a12.36.2025.09.25.05.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:20:08 -0700 (PDT)
Message-ID: <b119c71d-e3f7-4af2-a39e-1602257109e7@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 14:20:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] arm64: dts: qcom: Add PMK8850 pmic dtsi
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-8-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-8-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Byib-LmnNxuulSiEYkivZe_3fAljpsiV
X-Proofpoint-ORIG-GUID: Byib-LmnNxuulSiEYkivZe_3fAljpsiV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfXwbe8vS8JD0nu
 zyWTQzyIaoVggGi32RU9BEcm6MeD27C723Z6jKNsbeC6ALEb0PZAIDIOYcQ7+YBvGb+twcDUBOW
 bL2AMKcanstUrl50pG6ZiA8EWLTRDt5vIklcR1ImHJqZG8uK39jE6yCir8xA5JBRK/pOO2HBQOU
 nDNY+mnMhkymyol7GGyEI87N20hdvGd+61jVJz5eH5Es/00jEETZFLEXBK2CVFZPIQT85abGerO
 bqG9Em/SvLGUegnP/0LiiFm/8Jsu9ZPW43prUWuveP+MsRp9i7vp4yKTyfHwe8kjNVU2eSi4m0Z
 dp39JorxHWA2ZdHPBCv+nl/nrV8P/UbZCvYmR2RPAm2l/4zhD+Sgzq1/pJxh0QboCigOXW+aM6l
 Ys9swNvu
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d5337a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=9Yd-ykmot7fVaAYUysIA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On 9/25/25 2:17 AM, Jingyi Wang wrote:
> From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> 
> Add base DTS file for PMK8850 including PON, GPIO, RTC and SDAM nodes.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/pmk8850.dtsi | 66 +++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmk8850.dtsi b/arch/arm64/boot/dts/qcom/pmk8850.dtsi
> new file mode 100644
> index 000000000000..c19a98ca984b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmk8850.dtsi
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus0 {
> +	pmic@0 {
> +		compatible = "qcom,pmk8850", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmk8850_pon: pon@1300 {
> +			compatible = "qcom,pmk8350-pon";
> +			reg = <0x1300>, <0x800>;
> +			reg-names = "hlos", "pbs";

1 reg and -name per line, please

[...]

> +		pmk8850_rtc: rtc@6100 {
> +			compatible = "qcom,pmk8350-rtc";
> +			reg = <0x6100>, <0x6200>;
> +			reg-names = "rtc", "alarm";

and here

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

