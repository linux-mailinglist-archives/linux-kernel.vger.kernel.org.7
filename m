Return-Path: <linux-kernel+bounces-860323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7B4BEFDB9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4C0189A663
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787352E339B;
	Mon, 20 Oct 2025 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gf2VOWhK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805F2D061C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948070; cv=none; b=noxAL8oOH5q8i4zUotunVWUR84S3JtsKmviemMERcNa+MUuiTij6bkIQm7Zmd1mxJHGiMccfoL03xaa9FXSfvCnwp+cjtNXXkxLkfnG2itu/GzpY+AEvOiVNCMV8g8l9Yc7/B4TwQ46yQGDbAb/rAJz6ilmPfiAEr5Wyoc0RZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948070; c=relaxed/simple;
	bh=cs/xwuUJ3xSLb60nDjVj/RGExK63dRcpfrrA3rrfMX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQjz26rYQuO8F7pBdM2Ntl34lS8e9loqbh67QxOVQNYaw3CVjn0qHDYM+mchsGh85da/1h9yQfWzqKRA2wH5RvA3ZIH0TjoTsI8UApbGqZxJO/Vqm8H0DtcWA2awfxpMWVq6ueos8xocziTctCNArXx7YtPaFjEyxTnmQCazsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gf2VOWhK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JIPjRk009409
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cqErHmEw+q0Gb9LguQ9gJqRnV0oxz5k7O/UGJB1RlIQ=; b=Gf2VOWhKCdH1LMKb
	9l0Yyn6xFMW3W1lHdWbQ3AeeIsfo5zo199DqRLl+stxPOmwCJOYnrwV9L6z6Mqhq
	E+mB652cyDj/s5VjEzsHalsEwqQYEs7bJtwnWDsHkHDAJDKEgHBheuBOYuR7zkVN
	ZbyVSSb6/3LR2Y/mD+g0PULsaXtS8i0WIXA4oi1rV3PwKwsKpnV+6kuiuIj/9eiI
	Ll8+EwhEbUShIBW+ViBfAYsNYl468aRKFH02eyUVb2bFFIKbo7IYAnRg4t0iJK3u
	Rg9MV6ZHGek0UzbxkGR8d78d7en4ymOJs2Zv2M1KVpyw49/tujlnGFCpZbLDuteu
	xNgpmA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfc1gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:14:27 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7811aa16c6bso655435b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948067; x=1761552867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cqErHmEw+q0Gb9LguQ9gJqRnV0oxz5k7O/UGJB1RlIQ=;
        b=o1EjBeHd72ACRxz5EKKS3cDVEGT/8pwHHB90/QNdUM9mhJfPEghMerC3qES+x9smDM
         fzIBcRiHhg8wrat2DjmgSN47qvewIzt3KHiaOl9M1vkjWKvucKgghGVI6STn91M9N6gT
         BTC0MuDjmwBeXMZEjRND/TdkAUZfRVl5P8x9lMe3Zu6x9HrER0qDyxtFQsdlVDfCEW5Y
         H6DaZR9iykO6aExWPiChhARSTspAqpelXiTQ50ga1Ab3A9cd/vKCKeAH/GFQp3FOvo8R
         E/lkOFWrgYNJFbu9SufZbdZwvyr7HWIAsMsB46xhYXxlq+a3iaz2LRxDoh9wS+uasoPu
         BOeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm6AZKRQIkoyzDX3Tfw4YCdy/WKV2TmlrMz9AyZbRSyItWQJXDV8oYflczk0cIMLafDL9PnNf7jQiw4Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmTuS4bmo2Teg3hiLRIcpjjmhqwi3vaJkV8Z1vA7CANxCdk9N
	eB7JNZXxtFBd4Alo6NrnE3hb33+m+oFcRdYCzp7G2vNFiKF9ZsVcUDyuSnGCsKARK+pSMAwUlD7
	nykmy32MkqRHqAj2vH2cqKhZevwIxlFVytKJDxnfULkVAqkCP8/5hXGOlRRH13VruS5A=
X-Gm-Gg: ASbGnctPzrlE9JbvUZ35d+MPwoth0R8H+LrZ9kcHnq0tAujx3EKA3vEzFOb8HeuHlHa
	ZHPhx/iVKRhU+kwaTXqPxAiPjvgH4oU1r2Z4XffkIYka9bvhcNUhoSNovDd4CKA2sDHbfbqO39R
	lrFi8zKijTIwY9E51odhZiE5VSt3fYzawnkXxStsn0u6mWIq0iidAewBlfdVa9v3KC0vAceEUtS
	jHBd4bOHyMhdbddfjh+sRomMtBNLjt5os4cmdmc9C2OfqnflNqW85IM8aKrasafDPzCYUn1N9xR
	fM7Z6boSMNAaIwUbT2+Ez/iLgsTg3wo2tpeNvOTcCuwBUG797+IBpvRQgFPYrMB3QD5bopf16WH
	+WAEmyNk4ae8Jf+plSQaCGIu/UhBOL/kta+Nf/dZLR5VcvBLIp+HmgUiHVkftk24Z2OcbLQ==
X-Received: by 2002:a05:6a00:3e17:b0:781:21db:4e06 with SMTP id d2e1a72fcca58-7a21fe23a9cmr7338915b3a.0.1760948066787;
        Mon, 20 Oct 2025 01:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYG7VcpOs9/sXd8l28vPILUQQOWXIHteA2HclIXYOQtqaNMgzV91sC6BjxWGVMix8BHepUSw==
X-Received: by 2002:a05:6a00:3e17:b0:781:21db:4e06 with SMTP id d2e1a72fcca58-7a21fe23a9cmr7338892b3a.0.1760948066367;
        Mon, 20 Oct 2025 01:14:26 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34b8bsm7573235b3a.22.2025.10.20.01.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 01:14:26 -0700 (PDT)
Message-ID: <eaca20a6-5aed-4870-b45f-e341d119db3a@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 16:14:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: Add DisplayPort and QMP USB3DP
 PHY for SM6150
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, li.liu@oss.qualcomm.com
References: <20251015-add-displayport-support-to-qcs615-devicetree-v4-0-aa2cb8470e9d@oss.qualcomm.com>
 <20251015-add-displayport-support-to-qcs615-devicetree-v4-2-aa2cb8470e9d@oss.qualcomm.com>
 <13d1491a-2c5a-467d-bd55-01c0603a4b81@kernel.org>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <13d1491a-2c5a-467d-bd55-01c0603a4b81@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QFZVRKW_coSCk78__Jicr29TQVSPhC2S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfXyzBSNZFaXgFx
 e5YvS4FgisWAqF+Bs1sDIT0wNgtxTV9k4FOr0LGruRD0We+zcnllCojPcl7+icscPwgLpQr862o
 9VwXcu2wbHRTXpYirgXZ6lpQclJN9pfQY7Bf6yo109xkAdi43OXwlRfWAgRAVG+Pcek7SgC7BvQ
 rqQJplEBztoyeLyMYPVscbhQfZF5YnRJEmv+ABkHP2kIJYyvTS0w8O3o+UyQ+omJN2V6zEGyTVG
 jr2NvR8gBMcm9t6KwjC09wZIJfJzUIWBDMiWgC0/9PIMjakqn3OnDab+GjD4cZDO6sURI7j0zYU
 cpbjxiZ9oziCrca3R716b8bSqTTKH6aWGu2hIWR1eaMqVBnGng408zTEhebNdZWAKJkw2aSabq3
 kiOYrb2B0BKC8rOvFKLwwsb3uQT1QQ==
X-Proofpoint-GUID: QFZVRKW_coSCk78__Jicr29TQVSPhC2S
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f5ef63 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=teJiM7Ac5wN5jP0k6lIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027


On 10/20/2025 1:11 AM, Krzysztof Kozlowski wrote:
> On 15/10/2025 03:53, Xiangxu Yin via B4 Relay wrote:
>> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>
>> Introduce DisplayPort controller node and associated QMP USB3-DP PHY
>> for SM6150 SoC. Add data-lanes property to the DP endpoint and update
>> clock assignments for proper DP integration.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 113 ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 111 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
>> index 6128d8c48f9c0807ac488ddac3b2377678e8f8c3..36a536cef99a095938f3e18a9b5e7825308ca426 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
>> @@ -17,6 +17,7 @@
>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>  #include <dt-bindings/power/qcom,rpmhpd.h>
>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>
> This is ordered, don't break it.


Ok, will update.


>
> Best regards,
> Krzysztof

