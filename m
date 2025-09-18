Return-Path: <linux-kernel+bounces-816799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE4DB5786A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157231A261D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5127B30101A;
	Mon, 15 Sep 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Epx5K6ck"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B82FE592
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935764; cv=none; b=sm2BcJXsabvLx59e1qDaCufIpCd77ilJH0Xjowf+STNHjUjxbBsy864+I34LsWzhoZsdwRCgF5FevTHYaB9yChXNPG8iF/ckFPGK9QbNeXOPO/cXF0b3sSt281IY7Dh/GBp4fNwdrnlCEQvyHSjltxKAnX2O7m1tI0sqLTRXups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935764; c=relaxed/simple;
	bh=BYWwgbqpt+Gqp42Nc2x6xHBh8l368hyhPVjl2DeA/oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeShF1tg8dcvDnfOHLL10yfbusGYI6xJC2sBnQssK8R4HtvhTI1EricdkWqACuTJ4P1e91hnrxCaEGMJRLUhI91yAjnz3xgZ7tWowdEebRODkJV6q/LBhSXSlQV258fkIIKR9dBYaDURiDaX52A0UtYgsJ7138pMj7QF9qVQcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Epx5K6ck; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8FgHX031649
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HHxgojtFv1+VDc4N+0/nnx1iVsNtu6JUX6nrgcelgHo=; b=Epx5K6ckqQ9UgvN3
	Glnxg1HqEATpx1cMRIE94upgZOEMk9FnRnPg6zg1VyQsqwOm0yJ4Wnfg/sdJ1H4+
	JCr2V9bD89KnaDzeEnRoKrvasfHlU0zQKDDAu/AsSgiko3Cc36GspNCn441RsEFA
	pAiuvlvJ/a9KS2N3mZHGdVuRFd6e9mK0kxzzrjylxd5PyJfagVn21I+h/jhw0Sdn
	pZrJaOk/CaL4kt7Y9WSrsd+XRMde8gBzOxZ59Gb08Hb/EBvxzXv0HEI5i0hbaxdZ
	nWV5IOcF64sryCEv5gDBRaT5gnjSi0JnjIdcq7jesxcz2CZXgts5+NlabNGWPe/T
	PB0XNw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma4s58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:29:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24c9e2b6533so9453615ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757935759; x=1758540559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HHxgojtFv1+VDc4N+0/nnx1iVsNtu6JUX6nrgcelgHo=;
        b=TOjPQL3VSKSyLGFQYA28difyef5f4YGqS5v0wJ7bod1l+DRBJ71agyIEKj8V7mu2Yi
         FPeZinOHE9RnltUBmj7i4IAWNrs0oRQfBjXSLzG9u3SLjRnbVhkPICOX6mGj8k7H4c/1
         SCpLtqmt5MpBMTKr9r8uCo7Mzs6UAhR4Rxxe7CbuqmeY2LMbmKkteViolzepyNmFOOtw
         IwnDJ+866tiPwoH1VvE0xi+OXBAX3zokJqWWTdaUpCPXZxiMezkhU8jOlZg79CQMcOUN
         1lGGsAW93xrqdIV4AvEcXyC9JznYXRc/ZeZhYPMS1YlceJVCQXYdPpmSOB6RGn4qCz9I
         RBMA==
X-Forwarded-Encrypted: i=1; AJvYcCXdNf5q89zZvOayzefpukxrjRVg2Ot0ShcQfim8kxnuT1WW0nX4Px2H/Gjj4wO3McWGCGuIU3e+NNyHQmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYG9ZXsZgM+Pdq55pt105NS28VrEU9bp193IbYzbIbsKces2eU
	yqY6L89xGHmKIDjNAw9eEOQvM6+7lkWuokMnyy9KUnCJVBwvOw7rs7g1FGl1UrXMYcY0QdIPgxh
	ez5rTNdLJXNtAZ7ua+5Z3jlId/ExaKbCO5/tAhTGn1IzmECrN7KsD23RqK0rdkKNEnZ4=
X-Gm-Gg: ASbGncvnjasfOc2Z8I3c2UGy5NRtnxggKYltK3hk5XUDXCWb2F/HXLDcDyEKxn7tvCX
	UGA9YrZHm+MwF/9yrxvYOOk5XdeiEB+YWYC1sBde0R7cJc8Atd5BafkWnEsIXikDT8k7S1jZSNm
	HqV4Bo13RL0Mwbu6PER0iePhq+aeij4MLMq29XcYkwzO21kXva7ivFf7yQMYW/n2pfaMBOOlG1O
	vMqYdDogLcL1D/7YWguOXq6rpgEkaiN3/r3TLAxnWElCwXGUJxoDWxjB4FBNuGD3yNg8kVJycy4
	8LAMNlLsuxagswRipZFhMQ51mxB+Hlyax/cjRA6w0SMaDWRA+jQy7q2TjL/YlEKuKmvyPpp3AGW
	sNDVVWBRmhxg4GbP2fBFTM2HqfD2GI9ncLsE=
X-Received: by 2002:a17:902:d2c2:b0:24c:ed69:cd9f with SMTP id d9443c01a7336-25d28705e84mr80983245ad.10.1757935759164;
        Mon, 15 Sep 2025 04:29:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZfbvF7yixrHYH6Xe9z6LqQsZbJxJovZNNLKP01FZkNvAV8X6qf20cxzSyJ690lEC84uKUKQ==
X-Received: by 2002:a17:902:d2c2:b0:24c:ed69:cd9f with SMTP id d9443c01a7336-25d28705e84mr80982965ad.10.1757935758615;
        Mon, 15 Sep 2025 04:29:18 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-264885eda79sm43962635ad.6.2025.09.15.04.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:29:18 -0700 (PDT)
Message-ID: <1741620e-1f92-4db9-8135-965a96f12590@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 19:29:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/13] phy: qcom: qmp-usbc: Add DP PHY configuration
 support for QCS615
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-7-2702bdda14ed@oss.qualcomm.com>
 <sy4kyh3kd6s4nr75unt5r6gxnyeqq6bfjj4tizwiw2fvbw4ala@i3theqmwiv3d>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <sy4kyh3kd6s4nr75unt5r6gxnyeqq6bfjj4tizwiw2fvbw4ala@i3theqmwiv3d>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX/pE5HCO6F413
 qgOTqwSQ3sGm1VoaBxHsTZcHpZCfIxssxwH+5Z0DtF27W4BYw4fZe2AB7S2vv82eX7F+KFuBC1I
 KrdtBLbpv+cGKjOFUCLvmJsGJUbLhv61+35Xa0Y4IWSVQuUC7XuGJ5adUqhe64vaVS1JhCdRgFF
 79/fa4Z6xWGdXY87P5Thh7WyqnoR5g4Shsx+X4St8+4hqWfsnRs3zkmutltY2qren9cijDmf4Rw
 IHqaxpShBsIwPAiOw5BcLJ3Zts14TCD0NwyfSzjH7s4W/Kg4ofJBEBrkcER4teR2rTDTc4IpQGZ
 UtAHnUxS+CZEFTdHjT5YMaCLR0BSzLNoENjcDehLyBt6QCjsAq5DKMm5ITvb6Nr4DQ7kksyycZ4
 8s7PAy9H
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c7f890 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Pve8rUOC8BGBfzdlk1UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: jKhdJOxYQxjkaVKdaX_lKuWT4BaNLPvL
X-Proofpoint-GUID: jKhdJOxYQxjkaVKdaX_lKuWT4BaNLPvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019


On 9/12/2025 6:12 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 11, 2025 at 10:55:04PM +0800, Xiangxu Yin wrote:
>> Introduce DisplayPort PHY configuration routines for QCS615, including
>> aux channel setup, lane control, voltage swing tuning, clock config and
>> calibration. These callbacks are registered via qmp_phy_cfg to enable DP
>> mode on USB/DP switchable Type-C PHYs.
>>
>> Add register define for QMP_DP_PHY_V2 series.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h |  21 +++
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c      | 251 ++++++++++++++++++++++++++
>>  2 files changed, 272 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..8b9572d3cdebb70a0f3811f129a40aa78e184638
>> --- /dev/null
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef QCOM_PHY_QMP_DP_PHY_V2_H_
>> +#define QCOM_PHY_QMP_DP_PHY_V2_H_
>> +
>> +// /* Only for QMP V2 PHY - DP PHY registers */
>> +#define QSERDES_V2_DP_PHY_AUX_INTERRUPT_MASK		0x048
>> +#define QSERDES_V2_DP_PHY_AUX_INTERRUPT_CLEAR		0x04c
>> +#define QSERDES_V2_DP_PHY_AUX_BIST_CFG			0x050
>> +
>> +#define QSERDES_V2_DP_PHY_VCO_DIV			0x068
>> +#define QSERDES_V2_DP_PHY_TX0_TX1_LANE_CTL		0x06c
>> +#define QSERDES_V2_DP_PHY_TX2_TX3_LANE_CTL		0x088
>> +
>> +#define QSERDES_V2_DP_PHY_SPARE0			0x0ac
>> +#define QSERDES_V2_DP_PHY_STATUS			0x0c0
>> +
>> +#endif
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> index 663024b8c09124f2991b8e0537a9feb60baaa686..7b2b47320cbb2d16e4f316b0f52fdc1bd09fe656 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> @@ -28,6 +28,9 @@
>>  #include "phy-qcom-qmp.h"
>>  #include "phy-qcom-qmp-pcs-misc-v3.h"
>>  
>> +#include "phy-qcom-qmp-dp-phy.h"
>> +#include "phy-qcom-qmp-dp-phy-v2.h"
>> +
>>  #define PHY_INIT_COMPLETE_TIMEOUT		10000
>>  
>>  /* set of registers with offsets different per-PHY */
>> @@ -619,6 +622,11 @@ static const struct qmp_phy_cfg sdm660_usb3phy_cfg = {
>>  	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
>>  };
>>  
>> +static void qcs615_qmp_dp_aux_init(struct qmp_usbc *qmp);
>> +static void qcs615_qmp_configure_dp_tx(struct qmp_usbc *qmp);
>> +static int qcs615_qmp_configure_dp_phy(struct qmp_usbc *qmp);
>> +static int qcs615_qmp_calibrate_dp_phy(struct qmp_usbc *qmp);
>> +
>>  static const struct qmp_phy_cfg qcs615_usb3phy_cfg = {
>>  	.offsets		= &qmp_usbc_offsets_v3_qcm2290,
>>  
>> @@ -666,6 +674,11 @@ static const struct qmp_phy_cfg qcs615_usb3dp_phy_cfg = {
>>  	.swing_tbl		= &qmp_dp_voltage_swing_hbr2_rbr,
>>  	.pre_emphasis_tbl	= &qmp_dp_pre_emphasis_hbr2_rbr,
>>  
>> +	.dp_aux_init		= qcs615_qmp_dp_aux_init,
>> +	.configure_dp_tx	= qcs615_qmp_configure_dp_tx,
>> +	.configure_dp_phy	= qcs615_qmp_configure_dp_phy,
>> +	.calibrate_dp_phy	= qcs615_qmp_calibrate_dp_phy,
>> +
>>  	.reset_list		= usb3dpphy_reset_l,
>>  	.num_resets		= ARRAY_SIZE(usb3dpphy_reset_l),
>>  	.vreg_list		= qmp_phy_qcs615_vreg_l,
>> @@ -736,6 +749,244 @@ static int qmp_usbc_com_exit(struct phy *phy)
>>  	return 0;
>>  }
>>  
>> +static void qcs615_qmp_dp_aux_init(struct qmp_usbc *qmp)
> Please rename the functions according to their intention. Are they
> common to all USBC PHYs, are they specific to v2 (or v3) PHYs or are
> they specific to QCS615? At least this is the approach that has been
> used inside combo and eDP PHY drivers.


For all USBC PHYS, DP PHY is using v2.

Will rename these functions with v2 in next patch.


>> +{
>> +	writel(DP_PHY_PD_CTL_AUX_PWRDN |
>> +	       DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN |
>> +	       DP_PHY_PD_CTL_PLL_PWRDN,
>> +	       qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
>> +
>> +	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
>> +	       DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN |
>> +	       DP_PHY_PD_CTL_PLL_PWRDN,
>> +	       qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
>> +
>> +	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG0);
>> +	writel(0x13, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG1);
>> +	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG2);
>> +	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG3);
>> +	writel(0x0a, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG4);
>> +	writel(0x26, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG5);
>> +	writel(0x0a, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG6);
>> +	writel(0x03, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG7);
>> +	writel(0xbb, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG8);
>> +	writel(0x03, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG9);
>> +	qmp->dp_aux_cfg = 0;
>> +
>> +	writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
>> +	       PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
>> +	       PHY_AUX_REQ_ERR_MASK,
>> +	       qmp->dp_dp_phy + QSERDES_V2_DP_PHY_AUX_INTERRUPT_MASK);
>> +}
>> +
>> +static int qcs615_qmp_configure_dp_swing(struct qmp_usbc *qmp)
>> +{
>> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
>> +	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
>> +	void __iomem *tx = qmp->dp_tx;
>> +	void __iomem *tx2 = qmp->dp_tx2;
>> +	unsigned int v_level = 0, p_level = 0;
>> +	u8 voltage_swing_cfg, pre_emphasis_cfg;
>> +	int i;
>> +
>> +	if (dp_opts->lanes > 4) {
>> +		dev_err(qmp->dev, "Invalid lane_num(%d)\n", dp_opts->lanes);
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i = 0; i < dp_opts->lanes; i++) {
>> +		v_level = max(v_level, dp_opts->voltage[i]);
>> +		p_level = max(p_level, dp_opts->pre[i]);
>> +	}
>> +
>> +	if (v_level > 4 || p_level > 4) {
>> +		dev_err(qmp->dev, "Invalid v(%d) | p(%d) level)\n",
>> +			v_level, p_level);
>> +		return -EINVAL;
>> +	}
>> +
>> +	voltage_swing_cfg = (*cfg->swing_tbl)[v_level][p_level];
>> +	pre_emphasis_cfg = (*cfg->pre_emphasis_tbl)[v_level][p_level];
>> +
>> +	voltage_swing_cfg |= DP_PHY_TXn_TX_DRV_LVL_MUX_EN;
>> +	pre_emphasis_cfg |= DP_PHY_TXn_TX_EMP_POST1_LVL_MUX_EN;
>> +
>> +	if (voltage_swing_cfg == 0xff && pre_emphasis_cfg == 0xff)
>> +		return -EINVAL;
>> +
>> +	writel(voltage_swing_cfg, tx + QSERDES_V3_TX_TX_DRV_LVL);
>> +	writel(pre_emphasis_cfg, tx + QSERDES_V3_TX_TX_EMP_POST1_LVL);
>> +	writel(voltage_swing_cfg, tx2 + QSERDES_V3_TX_TX_DRV_LVL);
>> +	writel(pre_emphasis_cfg, tx2 + QSERDES_V3_TX_TX_EMP_POST1_LVL);
> If QCS615 is a V2 PHY, why are you using V3 registers here?


V3 reg offsets are same and reused V3 regs define here.

Will also create new header for txrx & qserdes register table for V2 and 
replace in next verion.


>> +
>> +	return 0;
>> +}
>> +
>> +static void qmp_usbc_configure_dp_mode(struct qmp_usbc *qmp)
>> +{
>> +	bool reverse = (qmp->orientation == TYPEC_ORIENTATION_REVERSE);
>> +	u32 val;
>> +
>> +	val = DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
>> +	      DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN;
>> +
>> +	writel(val, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
>> +
>> +	if (reverse)
>> +		writel(0xc9, qmp->dp_dp_phy + QSERDES_DP_PHY_MODE);
>> +	else
>> +		writel(0xd9, qmp->dp_dp_phy + QSERDES_DP_PHY_MODE);
>> +}
>> +
>> +static int qmp_usbc_configure_dp_clocks(struct qmp_usbc *qmp)
>> +{
>> +	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
>> +	u32 phy_vco_div;
>> +	unsigned long pixel_freq;
>> +
>> +	switch (dp_opts->link_rate) {
>> +	case 1620:
>> +		phy_vco_div = 0x1;
>> +		pixel_freq = 1620000000UL / 2;
>> +		break;
>> +	case 2700:
>> +		phy_vco_div = 0x1;
>> +		pixel_freq = 2700000000UL / 2;
>> +		break;
>> +	case 5400:
>> +		phy_vco_div = 0x2;
>> +		pixel_freq = 5400000000UL / 4;
>> +		break;
>> +	default:
>> +		dev_err(qmp->dev, "link rate:%d not supported\n", dp_opts->link_rate);
>> +		return -EINVAL;
>> +	}
>> +	writel(phy_vco_div, qmp->dp_dp_phy + QSERDES_V2_DP_PHY_VCO_DIV);
>> +
>> +	clk_set_rate(qmp->dp_link_hw.clk, dp_opts->link_rate * 100000);
>> +	clk_set_rate(qmp->dp_pixel_hw.clk, pixel_freq);
>> +
>> +	return 0;
>> +}
>> +
>> +static void qcs615_qmp_configure_dp_tx(struct qmp_usbc *qmp)
>> +{
>> +	void __iomem *tx = qmp->dp_tx;
>> +	void __iomem *tx2 = qmp->dp_tx2;
>> +
>> +	/* program default setting first */
>> +	writel(0x2a, tx + QSERDES_V3_TX_TX_DRV_LVL);
>> +	writel(0x20, tx + QSERDES_V3_TX_TX_EMP_POST1_LVL);
>> +	writel(0x2a, tx2 + QSERDES_V3_TX_TX_DRV_LVL);
>> +	writel(0x20, tx2 + QSERDES_V3_TX_TX_EMP_POST1_LVL);
> Same question here.


Ack.


>> +
>> +	qcs615_qmp_configure_dp_swing(qmp);
>> +}
>> +
>> +static int qcs615_qmp_configure_dp_phy(struct qmp_usbc *qmp)
>> +{
>> +	u32 status;
>> +	int ret;
>> +
>> +	qmp_usbc_configure_dp_mode(qmp);
>> +
>> +	writel(0x05, qmp->dp_dp_phy + QSERDES_V2_DP_PHY_TX0_TX1_LANE_CTL);
>> +	writel(0x05, qmp->dp_dp_phy + QSERDES_V2_DP_PHY_TX2_TX3_LANE_CTL);
>> +
>> +	ret = qmp_usbc_configure_dp_clocks(qmp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	writel(0x01, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
>> +	writel(0x05, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
>> +	writel(0x01, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
>> +	writel(0x09, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
>> +
>> +	writel(0x20, qmp->dp_serdes + QSERDES_COM_RESETSM_CNTRL);
>> +
>> +	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_COM_C_READY_STATUS,
>> +			       status,
>> +			       ((status & BIT(0)) > 0),
>> +			       500,
>> +			       10000)) {
>> +		dev_err(qmp->dev, "C_READY not ready\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_COM_CMN_STATUS,
>> +			       status,
>> +			       ((status & BIT(0)) > 0),
>> +			       500,
>> +			       10000)){
>> +		dev_err(qmp->dev, "FREQ_DONE not ready\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_COM_CMN_STATUS,
>> +			       status,
>> +			       ((status & BIT(1)) > 0),
>> +			       500,
>> +			       10000)){
>> +		dev_err(qmp->dev, "PLL_LOCKED not ready\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
>> +
>> +	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V2_DP_PHY_STATUS,
>> +			       status,
>> +			       ((status & BIT(0)) > 0),
>> +			       500,
>> +			       10000)){
>> +		dev_err(qmp->dev, "TSYNC_DONE not ready\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V2_DP_PHY_STATUS,
>> +			       status,
>> +			       ((status & BIT(1)) > 0),
>> +			       500,
>> +			       10000)){
>> +		dev_err(qmp->dev, "PHY_READY not ready\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	writel(0x3f, qmp->dp_tx + QSERDES_V3_TX_TRANSCEIVER_BIAS_EN);
>> +	writel(0x10, qmp->dp_tx + QSERDES_V3_TX_HIGHZ_DRVR_EN);
>> +	writel(0x0a, qmp->dp_tx + QSERDES_V3_TX_TX_POL_INV);
>> +	writel(0x3f, qmp->dp_tx2 + QSERDES_V3_TX_TRANSCEIVER_BIAS_EN);
>> +	writel(0x10, qmp->dp_tx2 + QSERDES_V3_TX_HIGHZ_DRVR_EN);
>> +	writel(0x0a, qmp->dp_tx2 + QSERDES_V3_TX_TX_POL_INV);
> And here


Ack.


>> +
>> +	writel(0x18, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
>> +	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
>> +
>> +	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V2_DP_PHY_STATUS,
>> +			       status,
>> +			       ((status & BIT(1)) > 0),
>> +			       500,
>> +			       10000)){
>> +		dev_err(qmp->dev, "PHY_READY not ready\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcs615_qmp_calibrate_dp_phy(struct qmp_usbc *qmp)
>> +{
>> +	static const u8 cfg1_settings[] = {0x13, 0x23, 0x1d};
> Are these the actual values or is it a C&P from the combo PHY?


These configurations are the same as those in combo, and I have compared
that they match the downstream sm6150 project configuration.

From hardware programing guide, only defined AUX sequance with 
DP_PHY_PD_CTL set to 0x3d and DP_PHY_AUX_CFG1 set to 0x13.

Shall I update table to {0x13} only?


>> +	u8 val;
>> +
>> +	qmp->dp_aux_cfg++;
>> +	qmp->dp_aux_cfg %= ARRAY_SIZE(cfg1_settings);
>> +	val = cfg1_settings[qmp->dp_aux_cfg];
>> +
>> +	writel(val, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG1);
>> +
>> +	return 0;
>> +}
>> +
>>  static int qmp_usbc_usb_power_on(struct phy *phy)
>>  {
>>  	struct qmp_usbc *qmp = phy_get_drvdata(phy);
>>
>> -- 
>> 2.34.1
>>

