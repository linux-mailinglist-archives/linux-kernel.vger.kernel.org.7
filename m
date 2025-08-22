Return-Path: <linux-kernel+bounces-781266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A5FB3102B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E53A28C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA792E7653;
	Fri, 22 Aug 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KvgaS3E/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6B2E7BA5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847271; cv=none; b=bHoEapRGnf5qQnLHb315SYmpX9Vc29zSasPMSwAD9wpKm61reMZMFx5Xu83BbY/O/x6EY86gVEfb9SjzFvSZ0VO3JwRcG9zHoSVNAvVYv82PGLZUL/QIpeT0UGifB1XFZ4BEZWdIr4lf2BUT036wXFIK7XGkZai1qJAD00mq6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847271; c=relaxed/simple;
	bh=Z0+SwSQNEOMbZHJy5OhSbEyuKZGHmonxKEQSsM2fhpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMx4N7Oii6AWqNxEwNJAsm0n9VZivPsRX5XEWbWAupJpdc/MDr6AwAfYIm+6EvTyHp7DjlK8hAe04EG83HZ+e9TCazTCwn0Hzn9eeOyTsYFdL/u14TIzbFr89uYQUl7bIWcMivXdLnVAdKo0HQ0v30DUmWH5eiIvaM0pJsrf8No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KvgaS3E/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6uRXT011425
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ImGhpDuxFOdCpj6FL5zsXgN4VeAkZyyrarFsrBei76o=; b=KvgaS3E/Lt9MS3O6
	7hWVXSobYXDo6BGn3yNaVXBPV9vzEUghgSp9HItmLap8Ntt43iPvglHC/5Q1kCXt
	7DCZfk7aIGfR14asnQzHXZWj94DQ3wIyIAKd1DfQq/KitAy+RjY3QYQLZoUOCGtT
	l3Uueb5hRaBmapCAD82Tpk/2S8+VFQhD2NI0yFGGa5kyCCi0dRf4sFNe/lT1icAn
	oCbiEOcqiQXCMQUG76HzjXGiqicHkQ0Z1/8qiNfdflzsRFXnlacqt4G+bskQ9H1m
	iSAycp3cXTysWszTi8vYjB0wKb27Vfk4de0oDc+356d2ilV1aHYwAcKrZgybUAbG
	EgwhzQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngt8e151-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:21:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2462ea2ed58so1768835ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755847267; x=1756452067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ImGhpDuxFOdCpj6FL5zsXgN4VeAkZyyrarFsrBei76o=;
        b=AeJsLZrQk25V23Zu1HNWbS7m446SKc37YBBc8wdNX++CWaumrXfKRRUbYeIMDjjAVj
         dz1rLk+tFtst5VeLPKsFEo3DaJhmj3CmesDEQ5X9lGxnAh/65o2CJx5+jzHFYXu00iEs
         zPd92xCi0s7Vr516EBapAUC17VRCdaVhztHjN715vvzUJe2MDA/Vx7hCuXdgw455+rwC
         KCcnr5SCMyHeICx8MT7736bqxZyz3tbGyb64t3l+fiI0vg9x21J1nJ4n029XFFCLEkMz
         hpre+3i9BQjeFOZcsOVqhViwv0SSo+hoHi4Xrxu98yOilNdzRlP8IPOJBXa7IqCZtJCU
         qGlw==
X-Forwarded-Encrypted: i=1; AJvYcCVsX7sOWWrdlFYxlAS/YIYPiyoyo2/GXjZ9Ck7uGxcS66VNj1T3NggtzYGWEqvn4sZWLF6+p1X72a9K+PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCPgt1STh4UWuGil4mMoY2N9XFgFlZQTPEsMvudRxAKsRrFesT
	1nKJsKY+0xJBhQ73xpxO3ubK9LR53/+jVr/icGHe2h4Oy0HjJJGeN0k7gK5JDQ8xxjY69yMMTgJ
	P6NuA8hBLzuyRpdH37QqcMe8XzElt652A8fM23o058eK9ttbmBmsfvLkq6Z3avG/vfWE=
X-Gm-Gg: ASbGncuceJdVxc178HemY3JnTwpKr2U9hSE8qmlVwpMZGPve2/UclOzddBNN54uxZW6
	cCU65UNkr02ri9OCmeagprQXULtkCnR4BjWOzm/WhDz82eb9AcSav29dSC28Ane1YCq5tAHBdKM
	phEJETArX+dHFZQuIHfMhyzwD+K7ct7wG3BevucZB9tMwtf2fqQ7q+sl7ApARYeHKhMIf3suThM
	K5zPlb/EvgGvFSzI3LhMf/ReSt7AQtt0E17KDexg/v5W1jhOW3mhRa6W89P4K3CGW2tPunFxQ7t
	NvxLt2zZW1n0VJcXTeq2GwjM1m6F38CiQiUUNBaYSvtT3/aTPBw43yrsER63uM2wLyrqjvsVRE5
	wnAOORvfJROyX+SEIM7o1Gzrs5zblxA==
X-Received: by 2002:a17:902:cec3:b0:246:4df9:f63b with SMTP id d9443c01a7336-2464dfa1134mr2105725ad.8.1755847267000;
        Fri, 22 Aug 2025 00:21:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSWdZW0zZ6t/zVxusBsVUXuEAw3kOdKb6PHoaWrR1AfwMdSJKy4A+BerChkkW0gKyQEhOJRA==
X-Received: by 2002:a17:902:cec3:b0:246:4df9:f63b with SMTP id d9443c01a7336-2464dfa1134mr2105365ad.8.1755847266468;
        Fri, 22 Aug 2025 00:21:06 -0700 (PDT)
Received: from [10.133.33.119] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e94esm74784355ad.162.2025.08.22.00.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 00:21:06 -0700 (PDT)
Message-ID: <1a2c38c6-0d49-4c47-9cc2-014b71e1e81e@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 15:20:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] phy: qcom: qmp-usbc: Add QCS615 DP PHY
 configuration and init data
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
 <20250820-add-displayport-support-for-qcs615-platform-v3-6-a43bd25ec39c@oss.qualcomm.com>
 <bx3cumx7ej7taour6zhqufrzjdxuhvlx23ga3vmvokrlekayem@e5rfjbcwle2r>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <bx3cumx7ej7taour6zhqufrzjdxuhvlx23ga3vmvokrlekayem@e5rfjbcwle2r>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNCBTYWx0ZWRfX2YDEOvjzv/9b
 HHccaqdvpkeeJo0RVEyi8XWJFrTXmpljjuiXguGRoWGfHsJiQ6+iW3vG/XQjF3Ffi+d5DL+IwMq
 DNk467QmTDZC0P1i4y5Xb/5Cp/Ig9HGxM3oWjP5COXSIF3n79xO45CvuFzv/CZRuKaTBehhrbKu
 uhAveeK6HycChXolMPfHCdIeOD3XJ8iFEWXfpFihSG41iEvGyp3Btvf8M1HO7RYswG2aMfgiYuM
 tgl616Fw/7rGt1yRJCE/QHxYrfcVEMB2iC8hmZBtVBpGgezs0f75kqf1ibSdwLEjelvfFeI5EyV
 JxZ9DOwC2vttvZr8U6g8U6Z3ECvEIKdyXhMgRGRFZLotnUqeHGkLVq0N0ZkJ9ntekJGOW5jLzXS
 9PCqxvgZMKsvzrIF+SAcvyoQmBsGrA==
X-Authority-Analysis: v=2.4 cv=c/fygR9l c=1 sm=1 tr=0 ts=68a81a64 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=sVqeHFWDZcW2eLg-V-AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: TBkEGcYoeTB9iPZ_dvVLc9klNyr_AYsZ
X-Proofpoint-ORIG-GUID: TBkEGcYoeTB9iPZ_dvVLc9klNyr_AYsZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200134


On 8/20/2025 7:25 PM, Dmitry Baryshkov wrote:
> On Wed, Aug 20, 2025 at 05:34:48PM +0800, Xiangxu Yin wrote:
>> Introduce QCS615 hardware-specific configuration for DP PHY mode,
>> including register offsets, initialization tables, voltage swing
>> and pre-emphasis settings.
> This will trigger unused warnings. Please squash this into the patch
> adding compat string to the driver.


Ok,

Will squash the compatible string addition into this patch, 

as the following callback functions would also trigger similar unused warnings.


>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 139 +++++++++++++++++++++++++++++++
>>  1 file changed, 139 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> index 6b0e86ec43ded3d850f68f248a74c39f74ecb5bb..61128d606238321d1b573655b3b987226aa2d594 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> @@ -284,6 +284,86 @@ static const struct qmp_phy_init_tbl qcm2290_usb3_pcs_tbl[] = {
>>  	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
>>  };
>>  
>> +static const struct qmp_phy_init_tbl qcs615_qmp_dp_serdes_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x37),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x3f),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_ENABLE1, 0x0e),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_CTRL, 0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_BUF_ENABLE, 0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x0b),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x08),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV, 0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_CTRL, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE1_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE2_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_CTRL, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x02),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl qcs615_qmp_dp_serdes_tbl_rbr[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x2c),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x69),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x80),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0xbf),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x21),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0xc6),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl qcs615_qmp_dp_serdes_tbl_hbr[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x24),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x69),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x80),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0x3f),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x38),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0xc4),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl qcs615_qmp_dp_serdes_tbl_hbr2[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x20),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x8c),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0x7f),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x70),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0xc4),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl qcs615_qmp_dp_tx_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_TRANSCEIVER_BIAS_EN, 0x1a),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_VMODE_CTRL1, 0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_PRE_STALL_LDO_BOOST_EN, 0x30),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_INTERFACE_SELECT, 0x3d),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_CLKBUF_ENABLE, 0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RESET_TSYNC_EN, 0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_TRAN_DRVR_EMP_EN, 0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_PARRATE_REC_DETECT_IDLE_EN, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_TX_INTERFACE_MODE, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_TX_EMP_POST1_LVL, 0x2b),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_TX_DRV_LVL, 0x2f),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_TX_BAND, 0x4),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x12),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x12),
>> +};
>> +
>>  enum qmp_phy_usbc_type {
>>  	QMP_PHY_USBC_USB3_ONLY,
>>  	QMP_PHY_USBC_USB3_DP,
>> @@ -449,6 +529,34 @@ static const struct qmp_usbc_offsets qmp_usbc_offsets_v3_qcm2290 = {
>>  	.rx2		= 0x800,
>>  };
>>  
>> +static const struct qmp_usbc_offsets qmp_usbc_usb3dp_offsets_qcs615 = {
>> +	.serdes		= 0x0,
>> +	.pcs		= 0xc00,
>> +	.pcs_misc	= 0xa00,
>> +	.tx		= 0x200,
>> +	.rx		= 0x400,
>> +	.tx2		= 0x600,
>> +	.rx2		= 0x800,
>> +	.dp_serdes	= 0x1c00,
>> +	.dp_txa		= 0x1400,
>> +	.dp_txb		= 0x1800,
>> +	.dp_dp_phy	= 0x1000,
>> +};
>> +
>> +static const u8 qmp_dp_pre_emphasis_hbr2_rbr[4][4] = {
>> +	{0x00, 0x0b, 0x12, 0xff},
>> +	{0x00, 0x0a, 0x12, 0xff},
>> +	{0x00, 0x0c, 0xff, 0xff},
>> +	{0xff, 0xff, 0xff, 0xff}
>> +};
>> +
>> +static const u8 qmp_dp_voltage_swing_hbr2_rbr[4][4] = {
>> +	{0x07, 0x0f, 0x14, 0xff},
>> +	{0x11, 0x1d, 0x1f, 0xff},
>> +	{0x18, 0x1f, 0xff, 0xff},
>> +	{0xff, 0xff, 0xff, 0xff}
>> +};
>> +
>>  static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
>>  	.offsets		= &qmp_usbc_offsets_v3_qcm2290,
>>  	.type			= QMP_PHY_USBC_USB3_ONLY,
>> @@ -500,6 +608,37 @@ static const struct qmp_phy_cfg sdm660_usb3phy_cfg = {
>>  	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
>>  };
>>  
>> +static const struct qmp_phy_cfg qcs615_usb3dp_phy_cfg = {
>> +	.offsets		= &qmp_usbc_usb3dp_offsets_qcs615,
>> +	.type			= QMP_PHY_USBC_USB3_DP,
>> +
>> +	.serdes_tbl		= qcm2290_usb3_serdes_tbl,
>> +	.serdes_tbl_num		= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
>> +	.tx_tbl			= qcm2290_usb3_tx_tbl,
>> +	.tx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_tx_tbl),
>> +	.rx_tbl			= qcm2290_usb3_rx_tbl,
>> +	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
>> +	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
>> +	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
>> +
>> +	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
>> +
>> +	.dp_serdes_tbl		= qcs615_qmp_dp_serdes_tbl,
>> +	.dp_serdes_tbl_num	= ARRAY_SIZE(qcs615_qmp_dp_serdes_tbl),
>> +	.dp_tx_tbl		= qcs615_qmp_dp_tx_tbl,
>> +	.dp_tx_tbl_num		= ARRAY_SIZE(qcs615_qmp_dp_tx_tbl),
>> +
>> +	.serdes_tbl_rbr		= qcs615_qmp_dp_serdes_tbl_rbr,
>> +	.serdes_tbl_rbr_num	= ARRAY_SIZE(qcs615_qmp_dp_serdes_tbl_rbr),
>> +	.serdes_tbl_hbr		= qcs615_qmp_dp_serdes_tbl_hbr,
>> +	.serdes_tbl_hbr_num	= ARRAY_SIZE(qcs615_qmp_dp_serdes_tbl_hbr),
>> +	.serdes_tbl_hbr2	= qcs615_qmp_dp_serdes_tbl_hbr2,
>> +	.serdes_tbl_hbr2_num	= ARRAY_SIZE(qcs615_qmp_dp_serdes_tbl_hbr2),
>> +
>> +	.swing_tbl		= &qmp_dp_voltage_swing_hbr2_rbr,
>> +	.pre_emphasis_tbl	= &qmp_dp_pre_emphasis_hbr2_rbr,
>> +};
>> +
>>  static int qmp_usbc_com_init(struct phy *phy)
>>  {
>>  	struct qmp_usbc *qmp = phy_get_drvdata(phy);
>>
>> -- 
>> 2.34.1
>>

