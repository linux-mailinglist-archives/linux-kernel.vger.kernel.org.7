Return-Path: <linux-kernel+bounces-745785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 569F6B11ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B60178D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE73F2EBBB2;
	Fri, 25 Jul 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fApr17mn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E02E7173
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447076; cv=none; b=bE7V1NMwUdhbam+81NzxwiSfETGzJYAw82/iSvzkTpg8urAfvCOz7qgZrp37XHSsitpqwGN7Zg68Ug5qMP12EjrJfE636WGShluq3z64vC+CJ8TUFn9I5E5qt6anP9s+OSKLgBf+x9I1p3MQIo6/dnXq2OSgasl6AVYVLDAfk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447076; c=relaxed/simple;
	bh=ruGHJA2MBI/bHqx9IT2Fhc0C3ebab59kHOS3t3z7JeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aORzDLH6soCk+OO+Z1VFeG4rjY8ObOgrPvApSPEGIiePt/rbwcdszfVsbTjDsfxjliF17V+Pc9gRKJlXGjmyvXvtqhs0n1VZQRnwIIED4BjkQ4PA5TDPwYveN5KMEhKXTAOv3vgmqIOR5Q6bEXuBDZClPGzyhoRzSXrf9AT5miY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fApr17mn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P89GQI009747
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PxbPT/h2NgyuaBFUgccrrjF3eSaUnQoYtVnInKJnygI=; b=fApr17mnhmEypAJo
	7+G8ssy8OfhI55zgoslwiVH5gbwgUWCxYhGjzWI5Y668QlQSktLFJ7bdkEIiq0C5
	QzYOJZMzv0ypNWAan7Un2FwGQ2WkMJzexXDLpvsMe1BDSZMxQC+MYwnm9oCUZgkC
	vrV65qsUw6NTcTUoSkBqPWLMQv8Nz90+mqJuDgwGeYV3TWQpJ3XZyR8gIbb7sDV/
	RyKwVNue0t/oGIm4QVTBImy+TrDLgIjgp3zIeTdmPZ1gzCNAj/iq4Jott0OVvR8A
	mjxDqoMvlZDB9OTpbXY8+5mPV3J8c6zbD+8jiRnZQtIxe45OW2VuPqVhqkk0IE5D
	E5HXQA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4846590qj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:37:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab7406bfa1so2340731cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753447071; x=1754051871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxbPT/h2NgyuaBFUgccrrjF3eSaUnQoYtVnInKJnygI=;
        b=Mmqr6IGtetL7D/bNGBmlrmj7T8kG2aO/hdr9QGM5vp1MmTUwLvnQHj8h6YppYDNOKf
         oW5xmB6km2N4r7YH6n7j+BCJCSEYqFEV7yIYL6hqtXkTZxlaZ7PmYX3xGCVbAhFpnwP3
         T1fkmlqjdbKJablM/15ZpYadxAel0Wcgol2lWIcMhLPzdN05RhiTDwSPjXLE5Z4s3XRW
         8VnQCIUTuGWIh49QuUw6hhimUugX51lFoYGsj1zKhWYTknCzFH3NABquw9NQfrHErB/p
         Wok9RQJHoLOC6ufdnYk1s8NzzgIKTKlSsgqMmy6IBEuTP+BVQHPajYxotAxdcF4AKSk4
         VMOA==
X-Forwarded-Encrypted: i=1; AJvYcCUzc6BeKvIjpaCTCYJ7j+gyDBYSwgwfTE1WZ3qHOm4zlh2Wzi4W9JcltMHntRDbYXavsc/ft2EGoDgbd9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI1u0xhoYR002BN319hgidTWVQ0IF3hLuvFvYiAHIEXhC+8qcV
	lkQ/2VP8taDuH5dVBAkZ5j4xJ3b275ZyBMiVQF4wb1Y4mByVn4nxsriXHk+2WCd7/AM9QCRJkfb
	puFJRh08xk5pCJwpM1jcgocbv4+YsmH/VDMMxyc5VxGx6AZCJHy580lxUVI8yVOEodrk=
X-Gm-Gg: ASbGncv4eShC3ysbXS9thiFNjC6o1yJIeYt+RCNKTNxDksGdkXRFkjtYshJY5c0Y8Cw
	KSz49SdFoMEQd8DOTEwvCjlHde314qemeKNS38Sp8zwfhpaxboiWe6BYHfiI8XoTvI6hIfjzAFa
	OJJ8mvTmTJ+CLL+XP4Yl7vJRWWHYBatyZjHoGQt++JKmqHo6c2CqAtAozsv6suEI/2x64Z+sXix
	Gkmaly7rJkGvGep2aNnWHTQ/BZ1BedbuEzNAO1b+YKix6m5Wis2d/PB9hYLFD4QXivJaQf7HcuR
	KmR0k9JwoRV08r7pxd6gtJowLX54uqC264jBGMzTzK1CouCslSNwZhzZl63Cg1w0CgPBxx7cF8T
	xARipPcA+PDNFyqrXcw==
X-Received: by 2002:a05:620a:25d0:b0:7c0:c024:d5 with SMTP id af79cd13be357-7e63bf8512bmr85403585a.8.1753447071384;
        Fri, 25 Jul 2025 05:37:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERt509FE/R/HDar4fcGLlfGtbq3oPf6L67zs4yLAAJi3QwodiT0ssuUrXCi77Ez0DmWv3qSw==
X-Received: by 2002:a05:620a:25d0:b0:7c0:c024:d5 with SMTP id af79cd13be357-7e63bf8512bmr85400985a.8.1753447070910;
        Fri, 25 Jul 2025 05:37:50 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47ff42a34sm259167866b.136.2025.07.25.05.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:37:50 -0700 (PDT)
Message-ID: <fb79df7b-1c7b-4085-9f12-35b7cd56bb87@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 14:37:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] leds: flash: leds-qcom-flash: update torch current
 clamp setting
To: fenglin.wu@oss.qualcomm.com, kernel@oss.qualcomm.com,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250725-fix-torch-clamp-issue-v1-0-4cf3ebaa4c67@oss.qualcomm.com>
 <20250725-fix-torch-clamp-issue-v1-1-4cf3ebaa4c67@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250725-fix-torch-clamp-issue-v1-1-4cf3ebaa4c67@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vrjZz87Kot4bVPhj2_iKNRDSJD_AmXsJ
X-Proofpoint-GUID: vrjZz87Kot4bVPhj2_iKNRDSJD_AmXsJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEwNyBTYWx0ZWRfX54gzZGdGvpD/
 yNczOudcbi5RU1tWUYjTcEH7hT4gYtWg3gZEyEWzMqEzrGHaCss14Cqgpbi2kuzJzmtJXUExDFi
 Hggc88PogO7tUO9R/nVn5qosKMoWK0H0TLSQ/1ryZcBBvnwNu2jiW+owji0V1OMVnK99TU1KHaI
 RTgVIWqHzlmoSJk6yCzzD9/8XeAE3W3s2X1F6pacQ555F7mAzWOH+9Iay7lRmvqaRLd7SAn/loq
 EbMyCOS7d4MbzE7flrebS+XqcgTENUNJtDJvq7vdH6W+ZOk8mTnV80/8PQF9PV9XkHdUY0YumFf
 OYr0XiCzcrX52ckCqJ29axX47fEgUkSt9Mi4dojPK8UvBmTI1ayK9XEicJINZAmeaisrOQqKeMj
 FRg5GmZy78Bwd+Xd58nGOk0t+RJnjuCYH6Emz/oBJeRNNNOUP023NNef9dZYI1yIIVjuemfa
X-Authority-Analysis: v=2.4 cv=Vo8jA/2n c=1 sm=1 tr=0 ts=68837aa1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Y_oDrEvWIW03XMJpiboA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250107

On 7/25/25 12:04 PM, 'Fenglin Wu via B4 Relay' via kernel wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> There is a register to clamp the flash current per LED channel when
> safety timer is disabled. It needs to be updated according to the
> maximum torch LED current setting to ensure the torch current won't
> be clamped unexpectedly.
> 
> Fixes: 96a2e242a5dc ("leds: flash: Add driver to support flash LED module in QCOM PMICs")
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  drivers/leds/flash/leds-qcom-flash.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
> index 89cf5120f5d55bbb7e24faa8c3a946416f8fed46..9c2e41cfddcf2d50d5a633cb157084371a631d74 100644
> --- a/drivers/leds/flash/leds-qcom-flash.c
> +++ b/drivers/leds/flash/leds-qcom-flash.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #include <linux/bitfield.h>
> @@ -111,6 +111,7 @@ enum {
>  	REG_IRESOLUTION,
>  	REG_CHAN_STROBE,
>  	REG_CHAN_EN,
> +	REG_TORCH_CLAMP,

This is not the name of this register on at least PM8150L

>  	REG_THERM_THRSH1,
>  	REG_THERM_THRSH2,
>  	REG_THERM_THRSH3,
> @@ -127,6 +128,7 @@ static const struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
>  	REG_FIELD(0x47, 0, 5),                  /* iresolution	*/
>  	REG_FIELD_ID(0x49, 0, 2, 3, 1),         /* chan_strobe	*/
>  	REG_FIELD(0x4c, 0, 2),                  /* chan_en	*/
> +	REG_FIELD(0xec, 0, 6),			/* torch_clamp	*/

Please keep it sorted by address


>  	REG_FIELD(0x56, 0, 2),			/* therm_thrsh1 */
>  	REG_FIELD(0x57, 0, 2),			/* therm_thrsh2 */
>  	REG_FIELD(0x58, 0, 2),			/* therm_thrsh3 */
> @@ -142,6 +144,7 @@ static const struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
>  	REG_FIELD(0x49, 0, 3),			/* iresolution	*/
>  	REG_FIELD_ID(0x4a, 0, 6, 4, 1),		/* chan_strobe	*/
>  	REG_FIELD(0x4e, 0, 3),			/* chan_en	*/
> +	REG_FIELD(0xed, 0, 6),			/* torch_clamp	*/
>  	REG_FIELD(0x7a, 0, 2),			/* therm_thrsh1 */
>  	REG_FIELD(0x78, 0, 2),			/* therm_thrsh2 */
>  };
> @@ -156,6 +159,7 @@ struct qcom_flash_data {
>  	u8			max_channels;
>  	u8			chan_en_bits;
>  	u8			revision;
> +	u8			torch_clamp;
>  };
>  
>  struct qcom_flash_led {
> @@ -702,6 +706,7 @@ static int qcom_flash_register_led_device(struct device *dev,
>  	u32 current_ua, timeout_us;
>  	u32 channels[4];
>  	int i, rc, count;
> +	u8 torch_clamp;
>  
>  	count = fwnode_property_count_u32(node, "led-sources");
>  	if (count <= 0) {
> @@ -751,6 +756,12 @@ static int qcom_flash_register_led_device(struct device *dev,
>  	current_ua = min_t(u32, current_ua, TORCH_CURRENT_MAX_UA * led->chan_count);
>  	led->max_torch_current_ma = current_ua / UA_PER_MA;
>  
> +	torch_clamp = (current_ua / led->chan_count) / TORCH_IRES_UA;
> +	if (torch_clamp != 0)
> +		torch_clamp--;

In case anyone's wondering, ((1<<6) + 1) 4 * 5000 == 1280000 which we set
on some (all?) devices

Konrad

