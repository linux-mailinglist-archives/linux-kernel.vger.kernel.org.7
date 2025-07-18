Return-Path: <linux-kernel+bounces-736962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56179B0A5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12017A46F06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C16B298CC9;
	Fri, 18 Jul 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fdR20Z8T"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52944156678
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847384; cv=none; b=urnYEfXLZCfrD52faljSd3KAjJY7bPMMenrxsdGV7XUwPbN6GAevcsTfydNMlL5lFLDHPx+BkjmfYCX/IbB7SOlM6EOhYWGEkf7smKdtwvLnvk0KqMox0cUsEi/3TpmZr87I9BKWY/4I86AiT+WCG7yOPZ8CckJyvpFO4H/B7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847384; c=relaxed/simple;
	bh=oxn3IwVTE7XSOYRmBd//e1DLeZb2q0A+/xIJwcd3XFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXX/rw25q9PSvWV4ZT7p61YskWgUEf1JadfXBc5CAApK7dP7DH8Lbhmrf2ZHAs/RaO+UVF1z4ttq7ew62idyQgb2W5jvdHxd8CR8mIPQlSYemDe84gd61uxroema4A3AhNDU+YJM7MC2bCXMYueY/uhvKl4mpcB8B+PMWVx2JwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fdR20Z8T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8hOAT028094
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sqth6q6knDV0c4169t8Y4KfYUSLGiSnvgG9U5KJWf+I=; b=fdR20Z8Tv2bfQ4RS
	ivUOSzvyP0AQHfycy2lFDqDXwSpa+5S0dmXjQWR4Uufqu/sW2guK3wPUKJSNvcs9
	kg5d2D8FgTZ4/dtZ3NeUzqEla0+ZT9NCGhREZx+RTRA3PuHEtB6FnGki+eXI64VG
	SK02lCALPeJXLR2wbAyPhUZKnlM0Dp0f2KWfK1e6aG0aSKePiWzS5aYqcoyqPTHO
	zGd8TLoee4LofmzpFKvV9fHmvcMZU+7uzVfkcUR6cXN9XyczFpW4hH+2ZWZhr9RF
	GtTiWziFm4UcHmxoxWpMg+rVX+mqSwogqnWjF1mdXyCNAE2g6RbEHehIWslkkJ27
	PqbCPA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh641fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:03:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31366819969so2096874a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752847381; x=1753452181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sqth6q6knDV0c4169t8Y4KfYUSLGiSnvgG9U5KJWf+I=;
        b=WSCupmF+jStGSN8yoH+iYUGRUwXKF4q8N91BZPSKA+3/8Zz56ktVt/VWh5DM7TgN1A
         +neYmMi0jqljGElaNb+oUVWvvXSMS+/8yzM26kndbY6qjZ74DU0e+OfsXXLqB9da8vJi
         D1YOD/kZclmII9tNznNEsIerAyqQZRtwyY4MjLAyjrTJ09tZ7bxOHCQfilmbmE91Yo6L
         oQgY529aP/WHcRDuQi6FYG6okIqhczBNzz72m5dYKDq/aeTnxC/A9+fOCKHsWJFpXwl5
         uhag95I6NimrduSI3oJZnfRkA12wyoR9A+Jx91ZQ7kM4jyGtkhLeigpDWUttglmCMBQ5
         HfMA==
X-Forwarded-Encrypted: i=1; AJvYcCVf3ZjYYcV0EeT0oI3FW0UWcO8pwl9W4uMGaaFaAjAhh3P8aIxnU9hgc8lVc1lfztepwTi+esvE3U6mMiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyevIgLEE9SMY8sh8/kiQKK9c40jVC9CcQYvVJ/9dwtePNbZKC
	/QNx8cR7J3cddCKCR1TUMwHbpyxpvGhcPgk/FwuWRvYya4IGMhrKit1gWv3k253G0GeAWDo5BRh
	u1kPLZQfwA9f1ZEw/cXrTAd06oG7Q6YY6KCOUkzqoA7E7e0egPECwXXd7l680e7Dge08=
X-Gm-Gg: ASbGncvjgRPeclaZNDXhIIQX4aPtiJGgrN3kpyZrLeeIss4aw0FMC3waxuU6qiiv16Y
	HNWqPc9Ue6dRTRe65A94yCbI9VeIiVCm/J2qYKc6qRTyqtRRYRgl9BeX/FI/GttoF51bNFsOPcy
	RhP1/GzRXDDQ+7gZdxfNzAX5uN2OLz9gMYld8cjKgF5LwtoU1XTfyPk+tdRgD6KhEhMcsf+LgWD
	QjpAcTDU5SpxNGtOoHudF7JaCMYw4DLQWUd9Pn88O9jNBBVQaX1roYJfBD5pef7qxS9SQB4/cAw
	E8kyvybzs7dh+B09ZlT/TonsQ1bt2X6N2PTqGY/JB1hIvrjP6TmLsTCZ58t5fSYoxko8lwiT9dD
	B14zmFEoExiDJFjOz94IqXmfhthkdemKAOr5YQrqoBwQZdnyWm9xS
X-Received: by 2002:a17:90a:fc46:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-31c9e7617d1mr18338315a91.17.1752847381214;
        Fri, 18 Jul 2025 07:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx/Y9pNMGr8gS5RpnPZrq5fjuBLOtCovUN4eitkJ53U2heLtj7mZN3nIf+YOVTn/RDfU4J8g==
X-Received: by 2002:a17:90a:fc46:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-31c9e7617d1mr18338214a91.17.1752847380598;
        Fri, 18 Jul 2025 07:03:00 -0700 (PDT)
Received: from [10.79.195.52] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e45e6csm1391851a91.3.2025.07.18.07.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 07:03:00 -0700 (PDT)
Message-ID: <a2be3ff9-d364-4a6e-a8e2-e0391e979b11@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:32:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add glymur pinctrl driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716150822.4039250-1-pankaj.patil@oss.qualcomm.com>
 <20250716150822.4039250-3-pankaj.patil@oss.qualcomm.com>
 <e69e6128-3f50-4bd3-89bb-09d7b237a568@oss.qualcomm.com>
 <19b62fb0-fb49-4a90-bff4-f5634547f2fe@kernel.org>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <19b62fb0-fb49-4a90-bff4-f5634547f2fe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=687a5416 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=ISValDjW7LgzQFoTVgsA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: txKbJlDqHzppUvQmA7oTMf2JY3U1qzNW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEwNyBTYWx0ZWRfX8++Llg2jHHPt
 rRs2QzMREV0RbUWemzjczIHDqtKUl0Re1wNixtFdDKJ40xYW+3oFBP9ChlsdPhhXd5xMh+FbG5A
 7mMS2140kzKuhIdEAU420xJmA95Nr6h5FNc7owBwt1DjgM29yV/wHdW6+3ZjUUplwhliD0tiZ+1
 8wt+8NvIc3bBeJV9LMjORQtf16dWqSqV09CS6jQkHWAtn6Jk46N1ja1r25qhIbSWF/HlSXQsFb4
 YrjtgdhfuL8wy3+RrDVDkaH0NcNXNYZxRSqJbZ0Ou/wnaWdHx5aDBoXTTMe8f0xOMAnhhB9oH79
 5jGTbCAp6g1XKnzHUApmV8cMwFF37/A8ygKd3loVwZRSy38bkfhOrqdyHAutB5SxgTmhPA9gGQZ
 IR8eWv0/G5xQ5Sujaf+zbrvFw3KZ1D8BgPjyuZbcKX9huudPPRvrAs2Ebj3LM7bkWaZCC12J
X-Proofpoint-ORIG-GUID: txKbJlDqHzppUvQmA7oTMf2JY3U1qzNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=974 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180107

On 7/17/2025 8:09 PM, Krzysztof Kozlowski wrote:
> On 17/07/2025 13:52, Konrad Dybcio wrote:
>>> +static const struct msm_pinctrl_soc_data glymur_tlmm = {
>>> +	.pins = glymur_pins,
>>> +	.npins = ARRAY_SIZE(glymur_pins),
>>> +	.functions = glymur_functions,
>>> +	.nfunctions = ARRAY_SIZE(glymur_functions),
>>> +	.groups = glymur_groups,
>>> +	.ngroups = ARRAY_SIZE(glymur_groups),
>>> +	.ngpios = 250,
>> 251 (0..=250, incl. ufs reset)
>
> The binding said 238 GPIOs...
>
>> Konrad
>
> Best regards,
> Krzysztof
Will correct the bindings along with the driver fixes in v2.

