Return-Path: <linux-kernel+bounces-864521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A94ABFAF64
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C5A56420D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9852530DEA9;
	Wed, 22 Oct 2025 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CEYPPFcY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC2305076
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122699; cv=none; b=Ap5C8TslcqoTnMT/LbJaBrwa3fIYlDwOjXbEQSaJj8HqIywV1UPP8j63FPlaeHJtMDkSlQ7KejhIL7RgYvs+U09yiTofrwU2mQ6M+PhPIrK23bEVeb31/lO9QyGhQ7GuzXAWJIEcaIVjSksFwclhUosPXBwItWrVUSz6eyt2gEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122699; c=relaxed/simple;
	bh=IJoyUmfW/Iq/I7TDBxnbdg5/OO2KKWRIyzb6EPKEmqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ11Y+tCsCSO+4/aKOl4/Ano/GV2HjchiYjrZIa7gLPcnq365Gy5KT8LhNMfOkYZ6Sd6MyytXcPPaYjwZ72ylppQyAENz1cXaQDl35r8fWlGCovIyHvC7oNjM6SeJzNlLlDwPcP3SQSB+zJAOcvo+Wu0/1x3Dy5ty8yhS6vJkOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CEYPPFcY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7r91a012237
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8Fqs3VCh8yc+MC9pZJHM6nKy
	Xi4+WkuALoZolH7c+Qw=; b=CEYPPFcYf6vr9360F+UE9BbL3krnCBe+oQrsRahK
	5EYyEFg4ArF3XHrGQrg4XSUUsoniAOp82kR7djTQzIo7wJP+SDDHqIpLpTp6KhaX
	+2N2MkZPoSlawMWcvlnEhJehVbxr8cdZewmGa8hLcCKledU0tdHPW6hfG2OTxKps
	FGlf9SfBfkK256az+XBPaD4Aa17AUT1s29ouNxqsuMR8yTCjXqLExf1exYID7eLc
	x9rl26C395DPNAgGu9sRPZgvCBSjKKhVUnpR1JqncmpNy24exz5OcvWCtzf19VPG
	9KHs1u2mLndn/H+q9eLZakswy1S8FyX1yr5DwUH8GRDXnw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0hs5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:44:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eb7853480dso6224801cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122696; x=1761727496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Fqs3VCh8yc+MC9pZJHM6nKyXi4+WkuALoZolH7c+Qw=;
        b=gPsA/Drg8ytH7pJIxv2ryEnqEOLNFKYNCUARP89pZLMfzOzOLYlGwHWHO1BlDZViji
         cd4EgJo0g5YQMVB/5EuYPp0W2xvgvKs3sZe988fHNg0gk7Se8PXuU0jMJbWYF/NXQkBL
         cKHwZQaYZbryZBYmo3bd8Q3FyNHlX6Qbph4NAGLvLP122510asbTOHwE96GBe1IQUSYf
         T5JqmIv8TrdrQF08Zlh505UDYJU9FvwKWudrU1zbslSZGuCxTOfLCVe9ytoiiYXLL7TD
         Y5fT38LCPb0TNIkl549ck6oY+km/n4EgfG8pWl+oBnCRe6SwsZiB9lc4BLk+g+Ww48W/
         C81w==
X-Forwarded-Encrypted: i=1; AJvYcCVnKPmofJgB4q6Um2EleBTOLYmikrujuOv7ip4O9+P2QRKfEAQUtMTJ9zkFUA8RBZnzntEH69FqLuSazaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZG+KIr12yeD845WindrZi7AjEdTQ5QS1bv8WHSXOTqG+lZ+Ua
	PC+8f+hKqTz1zjf/WDMBnLzwMdwqJjoEMeGLn4656OtzgY3tlA4NhduOTr6VJeca2yAV8ZsSZlv
	ZAafMRvHHVdXQpMLjW8smxgX28aWoiIqmaQBdBv4q58sNonGto0vQ1Mjzcxed/DOkQl0=
X-Gm-Gg: ASbGncug0gKAlRGcTVHsb7pf9MhE+ng1jh6vIjRf5lIidStkUSETY2cKItMsZb07jvg
	syG47cnMLvEA8mLJKphBY+z/NEm2i5drZhQhtlmtvPnM7cph4S7xpoDENuZBFKZNDcOSisMuHYU
	WcqMXpr4lWtk10+6Pn7Y18fRqUlkgHhYLLuBtPIj4QbNji6Yt7psW+91sOZLp6kB+D/6cSMldTi
	cipTW0KBJ6at8UjERD5xsi3zf7hAn/PhybI55LMd8Pxtf9nEe0MLoKOmeIGmJooL57hyr7A9bBA
	ZP99G+LYkgAJvqjIcatFi7cn1+nS/NYXkAVN4wcTxmX7dFdxK+cpf58j+JWkyvZxxUNLf562YIs
	VSb09Ldp7TBbSqDx1oYsoOt+Z0rUwc8kbcj/1mGwbVSxqj32hL1wDwZuRdS4ngeqdOievcsZ5Yx
	x2CtK/90UXlms=
X-Received: by 2002:ac8:5fd6:0:b0:4e8:a376:4345 with SMTP id d75a77b69052e-4e8a3764648mr206381011cf.43.1761122696490;
        Wed, 22 Oct 2025 01:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtfeLvPBUYx/OMKTojfmm6wZmeHWO7eZ456Avbu6mhNcWgXFGtSexxWbZLyk+APWBqPsIjjQ==
X-Received: by 2002:ac8:5fd6:0:b0:4e8:a376:4345 with SMTP id d75a77b69052e-4e8a3764648mr206380801cf.43.1761122696021;
        Wed, 22 Oct 2025 01:44:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f1d2d0d6sm159633e87.49.2025.10.22.01.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:44:55 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:44:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] regulators: qcom-rpmh-regulator: Fix coding style
 issues
Message-ID: <pldvmkjm7muflwti25rc24so3jbkxgyg3uhk2btuzpimjv5emc@62wz5dyksjr4>
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-4-5c7a8e4df601@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-add-rpmh-read-support-v2-4-5c7a8e4df601@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX635cedDur8/h
 h+vl1aj1eaWvRRUsi3LFgR+M5F7eXJXb/7+OmoZNPAZqduVIuyciUcL2qHaqiXoZB0UAjCFLr0r
 WS3oC8jNrWjxQZB4PovcMcS3ppkPXcDqbC70a1ttFAPJwzdfbqfF/MOT2C5hskLQRnA9YO5Xbqx
 Z9RX+NdMYLj7pvq7UNro9umc3KJzdazLLEHzdOQoXpmDHCWHNHxzuVmhWtm6pwAUni8EmSbAXYS
 Uh0cNVCP6j2nfTu3Zn8mBSml3ZWPran29egZF8kri+8lVY2YEawfH9g8i5pjEeLELTqza930bID
 nbzLB3KHMkqcttW08LVirjKEXiZGqe+FraTI9R+lY6kU5mS/qKgo61bxuAfZeVxHHQ+XYN51Ocg
 XRcQosDYpAh9ab/xX8NbxVICwLWW0w==
X-Proofpoint-ORIG-GUID: 9ApGMkHQUi6qM5obAlUou2R98ULmU-VV
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f89989 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=gAYjBv6TkpC_2adqZ5sA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 9ApGMkHQUi6qM5obAlUou2R98ULmU-VV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

On Wed, Oct 22, 2025 at 02:38:56AM +0530, Kamal Wadhwa wrote:
> Fix the code style/format issues reported by checkpatch.pl
> script.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Why are you fixing a patch that was a part of this series?

> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index 9f693043cb87aa77a7a529b5b973323450db80be..6a36ef967d5d9e32c005e79a12099ebef824842f 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -109,7 +109,7 @@ static const struct resource_name_formats vreg_rsc_name_lookup[NUM_REGULATOR_TYP
>   *				regulator
>   * @ops:			Pointer to regulator ops callback structure
>   * @voltage_ranges:		The possible ranges of voltages supported by this
> - * 				PMIC regulator type
> + *				PMIC regulator type
>   * @n_linear_ranges:		Number of entries in voltage_ranges
>   * @n_voltages:			The number of unique voltage set points defined
>   *				by voltage_ranges
> @@ -387,7 +387,7 @@ static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
>  		return pmic_mode;
>  
>  	if (bypassed) {
> -		if(!vreg->hw_data->bypass_supported)
> +		if (!vreg->hw_data->bypass_supported)
>  			return -EINVAL;
>  		cmd.data = vreg->hw_data->pmic_bypass_mode;
>  	} else {
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

