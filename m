Return-Path: <linux-kernel+bounces-788296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBACB38282
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A7097ADC39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C2E321440;
	Wed, 27 Aug 2025 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HP6Pd2lg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1693176E8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298163; cv=none; b=YiF19Cshur5nZqLZYZXvowkBqp4OxsrAclu0b5dwYs5b/R6ZJZXVGU1Z+8Bag5UFzQZGjUW6AAztf1nai1auAchspuSakpC0RWOCzToS/LlGCsUp0uCqHnHEDCsdscl2gkLdPFUYmeNFe+ZOs7/0fS3k7wZQVX2LvfncoMSqenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298163; c=relaxed/simple;
	bh=OtfwXx5I64xIHGxuZSb4288v4TGZmcJgnGcUoChVAhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lH42662T+VPh14GX7IHg0veMp4d1X+sCYkerBsLLqF9YdFZPOiHVZclqE6ECapoIrCo1CtUPeb1KPTvXgVvEGHI9sd1P157MQ5yckjYx1kOfOMaeUWM6QINwtxN1SRrQTxONN8x+DYmviXvbmWikspJrHZ/NQEFFzPw3cR7+Fog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HP6Pd2lg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6kUhC027598
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aE8zBC2r3Q0RIEhAPiMKgJEgO09ak2j9Srq2WGlHICA=; b=HP6Pd2lgIf3+Ff91
	zdA15rB7L979ZlVWxyvt9V+gX7l8lhk/YtxeUULsYWP+dZWXurOIURgs04oH4KNS
	Z/bgwUxV6lP20vVPOCcyPix+DqDw1Ox8eNXjp8japbIeEbJAqF1m5yaEtb6t0pFq
	fLCElBTU0sSvJTulxTPPQFvFPl1AHiiJ+FntF7mfCQ19RAeDtrdAaTniSVlS9Cnq
	66JB+bFkO4VQmM28jkAjxofCz6ha4w3eI1nXmdkrVPrxpjZw/Kv/scqkwPqZ1n2W
	gSild69dNrPSBcFjVEieZb6WT0hQ7IyrUWWLvmtqWNTMcfjWjZ/W8Ynk3LGGEApY
	ehvgsg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48se16und4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:36:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244582e9d17so18813315ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756298160; x=1756902960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aE8zBC2r3Q0RIEhAPiMKgJEgO09ak2j9Srq2WGlHICA=;
        b=DJ1jQRNyoeOKraxaKAQjP7nh1lh3ZAcKLfzPW67y9KMRAadIOonsLnfFPohrmCe/1b
         2D+HBgpYghtOtkaJp/IKmByIRx5riKz5iuTYAAPCs6wim8cGshQ9Dm7lg/2+3hrxXyuw
         sSpK4zBTplicQHeRpLa5EcOTeWw7sFoZn94XCgusW8mP0QkEjOKbL4BeaVxYH4HvBdR2
         +YLVA6dqgh9/lEiXCW2xub19hrdO2I7hVWxP8c/vzb/7FyV33d86SQuBUPVIQWUblGAP
         ttIIa394EOMbKgLw9/UMo0HAOS1Dus2oFQI4zhg7nmoLd+qPJxcy+0sHhINSUcub/7DT
         L/vw==
X-Forwarded-Encrypted: i=1; AJvYcCW7d6brrlK8vjPyoRqbWqGCRDwZpAoeDsF8ozNREENm0+Lx7tPfpzeTaS2/nogDjL5GyCfy6Kl3XACy49Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLA/EQUE2YPws+P1qHDGN9CL5dllxKk1fKYdiaurz6DiC4XNRT
	viv/xgL42tBxtmlQn3WNKlFtSbuapsORr4Hc/yOrS21w6bWBuh6Won/qgJJ1tgbEDnPDdAVd0UJ
	BOy8BRUXkyCWp25kA2V9U85kAuxoHQWjw+/20GpnAa56/Sjd0xyczypYwp3CZCR1rl8I=
X-Gm-Gg: ASbGncvIaGXR7Xh0/rLISHPrW1MhSLheag5oGuaXkaBTnIcBPN+xo0Eb90j8yAdc4lE
	fz9G7AuOZfjl5Ap0VJzSqlYaXdIcPlyImnYKOEl7usqg8mvEUXJcGkKnNvbVTWncrZIvyiJFtcH
	KbEOSncbiwEhIawFIKMaD9RmxJiiar7qFU1x1rk1nOv/5ed15rUVYucIfw2HDWALcDkSLxzydIe
	/3jHFahpTNtG/Ld8+V/x5jx0kUfWOvEF/29VlGgRtLolLuH7gxCbvQkReqmsvSw748we4H17gwr
	ds+P2vvlDHb7M+VKsitUOD3MVVVGmHS/ixslA3D5mBWcTJSuaKw/iADyYG6SRky/jjY5yuon7n0
	kq2VTwpwLeyNrHDLOExjJpipnwy4rMg==
X-Received: by 2002:a17:902:c951:b0:248:9afa:7bc3 with SMTP id d9443c01a7336-2489b09c5damr16498765ad.8.1756298160296;
        Wed, 27 Aug 2025 05:36:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYZ+xD3z7w+wdaYRdOi1NqLqGkN8knb7naudF58SoA0hWReYupg5b3LgtyFq8V+9Sa/QcFuQ==
X-Received: by 2002:a17:902:c951:b0:248:9afa:7bc3 with SMTP id d9443c01a7336-2489b09c5damr16498445ad.8.1756298159732;
        Wed, 27 Aug 2025 05:35:59 -0700 (PDT)
Received: from [10.133.33.166] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248787e1bb2sm37647865ad.96.2025.08.27.05.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 05:35:59 -0700 (PDT)
Message-ID: <521fc2c7-d58f-4051-89b4-4c5a5a29d798@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 20:35:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] drm/msm/dp: Add support for lane mapping
 configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-14-a43bd25ec39c@oss.qualcomm.com>
 <wwn24kjpwexl66hd3wufa53lkqojb2bkpdogtxwr3uqotjpf3u@hclfgsv64ajn>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <wwn24kjpwexl66hd3wufa53lkqojb2bkpdogtxwr3uqotjpf3u@hclfgsv64ajn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QblzvIMSwQTSvk_oE-GegPI2rgt9eTnI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDEyMCBTYWx0ZWRfXyfYzxaqyTuCS
 p+bb3jMb36/T8trXpJa9nNmmLVW3nn9vME5oMVA1XgeYmtwSleUjBQA/Vg3sZKrynxEIpfYQwEo
 CeYtpSLT7PUJ7R1qNQu0V10EQD/LoEqfC2SIlT1R1DRafTc8xDo9PEI/kN0CFMf+OrOWfR9Qyr5
 7nVT/9mS4QA467avT2uSiB2Huq1cLv6V8tB1zT/86SSyxzbY6Hc7OLrs3zKrBgxDjVgZV1JV5Xf
 pfx0MU2qcxaV/1GhmrN3fS9r//hcKfU2Qqa4WVbYWw5S3qUkM3FmE2TO3prdKg6bAaRPCQ+Owg0
 dB22/6/hEHLZr9Imy3bRR1sskXYkkjVriegtb8RamrQKTXUF182TCGJDWrshX38Ic7xzzk3i4V9
 cZYZ2wIN
X-Proofpoint-ORIG-GUID: QblzvIMSwQTSvk_oE-GegPI2rgt9eTnI
X-Authority-Analysis: v=2.4 cv=CNYqXQrD c=1 sm=1 tr=0 ts=68aefbb1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=o8qHn1sYNikkEtO5ub0A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260120


On 8/20/2025 7:49 PM, Dmitry Baryshkov wrote:
> On Wed, Aug 20, 2025 at 05:34:56PM +0800, Xiangxu Yin wrote:
>> Since max_dp_lanes and max_dp_link_rate are link-specific parameters,
>> move their parsing from dp_panel to dp_link for better separation
>> of concerns.
>>
>> Add lane mapping configuration for the DisplayPort (DP) controller on
>> the QCS615 platform.
> Separate patch


Ok. will separate in next patch.


>> QCS615 platform requires non-default logical-to-physical lane mapping
>> due to its unique hardware routing. Unlike the standard mapping sequence
>> <0 1 2 3>, QCS615 uses <3 2 0 1>, which necessitates explicit
>> configuration via the data-lanes property in the device tree. This
>> ensures correct signal routing between the DP controller and PHY.
>>
>> The DP PHY supports polarity inversion (PN swap) but does not support
>> lane swapping. Therefore, lane mapping should be handled in the DP
>> controller domain using REG_DP_LOGICAL2PHYSICAL_LANE_MAPPING.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/dp/dp_ctrl.c  | 10 ++---
>>  drivers/gpu/drm/msm/dp/dp_link.c  | 71 +++++++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/msm/dp/dp_link.h  |  5 +++
>>  drivers/gpu/drm/msm/dp/dp_panel.c | 78 +++++----------------------------------
>>  drivers/gpu/drm/msm/dp/dp_panel.h |  3 --
>>  5 files changed, 90 insertions(+), 77 deletions(-)
>>

