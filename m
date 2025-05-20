Return-Path: <linux-kernel+bounces-656378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D142ABE50B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 22:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7A67A278F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 20:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A9F2571A1;
	Tue, 20 May 2025 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SOAPUelp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB325392A
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773907; cv=none; b=j6gutIYWmHZkJtCnbD1iEj1PQeFqpzyCHOv6uTkNG8+SXZQn2Dg1du/DEuhUPEMuKTCRzn7IpuSgYv2YdCUsyUTcvMhE1CVuCGq9Om9/e6CaaXfguFSKlvV2SSoX9h7SkpsCmuqbLPkdGPd6503f8uE54nIeYe/8e5DbetVIAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773907; c=relaxed/simple;
	bh=2rkm+Wp7Nl4ACvy6m/jS4aFH9nSpfuEADUOy2QXan5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gV99m8mzaLL7Akv8FoDmU1X+Akfc4ROXGTMpIILCJ25Lwag40JhOpf4WgVvnBdfjaCBDKHpciNeimThW/8oVao8LDN1EpGnwxA0PNhoICEMukEFAt1eYS+hCwOgW9U/0xzohD1Fw4VmP7BCeSXPss3s53q4S1a9IMnO0ebgFbLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SOAPUelp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGe0s4000729
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 20:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y/rh0R9tpWXVkxE39YDI+lWvwLBDn4zQLtiVh5brNaE=; b=SOAPUelpGbGtypJB
	hPxO58k2OGOH+FEK4nk/NuyXQZySNnMMptQyMHZQRQSutNp/Az8yqf8cKCSxTCfl
	Nw7C0sjhRLYswNc5K4wLpknUUwWCMwNYjexmqYuPi8GaWYQYrk1ERsQ4QQqUiJmN
	+6Q1wEKc3OZ+0jso5a8cpwpJgTbW5gDjo64qEVffQyD3RnHIL7+50xR52CO8OIel
	8TUyyX0ibxFcB6bT5q8EqXHe9woyW/cDceVTQEdz3qArQypIU3v4/rUm8Oi7LG/l
	NkxCRbuQqu8MvZe1q9jcVkKKuRol2oHiCQjkXG6AAwh/8uIkKWgXd1aw6lOvJrby
	oC4TZQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4rjgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 20:45:03 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6f8dbab898cso53399926d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 13:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747773902; x=1748378702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/rh0R9tpWXVkxE39YDI+lWvwLBDn4zQLtiVh5brNaE=;
        b=UmzW2Uu8oQfZB1BJoGjQdv+cYLC4vfKIeVa8Gw2hiCTRXa6LpWhyhfZyivAFbiKhBm
         SD+sbfXpmxxJRgfq+cRgQGNKcsJitM/6QaVoE7e1WdfeLiz8iOTHeFwmRV8G76HHKQN8
         Nutp9qnchWXUNabFeTob03F+Klmfoo5DuQYk1ovVD8YLCqK9hqytU9SpFTQYoLTdR4f+
         rD4jOorwLM+jAsGPzYQcUctM6aebY2kuGoXv8PLoNMUk9dohsNHPW71y9c5Ed283Z3sv
         7COLvbSpl7Ysx93Eg2cO5RokvX4x21VhCyenBBCl7KoZPuBiBtWv3XQ61nxuKII6nEH6
         4voQ==
X-Gm-Message-State: AOJu0YyGV7Wvc+W022K6rttdX7TKh+77hL+YGBv1E5lIFueE4fllPzEs
	kEIBWBRIrgdrhv2h+cwjmrGvomUiTLY/8GHRSbgISNUPdjtGfCPABYNviJWReNjP5ShuzLr3NkM
	AbpKAWGK1L6Y74sYESFxZMU4lq10ZnKx72cAMYhJaVM+GqrcMHV0+K/N6htas7wVSxVCGXMjcYu
	huPA==
X-Gm-Gg: ASbGncu0gxzKL8YmpPTtRnDPyDFwjarJiI+FqmIZC0dOnLnooQcLGoIeon9ZMx2THXT
	qI/VkihR+P8363mCIky+XqNaPgVp2sw90vqQcjRiXLTyJaKwWUe2cB44+UIyyGGN7YiBJConbku
	rMRYZ0hqPG1E8mNIQQfOMOVNtyvPvmlqbymk1yPxdfxNGO/tPmpkj4X4+9Pkc0GIKwY+YX1guhh
	7d5+X5kSsT65UwuaXD9kDk0Ua0n7t6OGoR7I7WGTrV1LOkGZK3RPh680VgQ+/bTikoiZCYB6iSS
	8Dm14K0PLiyu7hRsBor95dtB/OxeZne/Mkg2XZ5sL/BGambM2YoOpvdoU7z9PMPXMHIoF4WHxHR
	4p3u9SuRLahdiQZ2OCJoe3Lbm
X-Received: by 2002:ad4:5aa3:0:b0:6f5:108b:d857 with SMTP id 6a1803df08f44-6f8b2d15707mr299977796d6.36.1747773902115;
        Tue, 20 May 2025 13:45:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkMvApU27Xi4DNOxe5crEMOlpgPH/pnPyGO4WWWAxbN7fBy9SXWfkDLDONqPA4GCt5J3jrnQ==
X-Received: by 2002:ad4:5aa3:0:b0:6f5:108b:d857 with SMTP id 6a1803df08f44-6f8b2d15707mr299977326d6.36.1747773901654;
        Tue, 20 May 2025 13:45:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f163ccsm2497950e87.39.2025.05.20.13.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 13:45:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 20 May 2025 23:44:47 +0300
Subject: [PATCH v4 5/5] drm/msm/registers: drop HDMI PHY register
 definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-fd-hdmi-phy-v4-5-fcbaa652ad75@oss.qualcomm.com>
References: <20250520-fd-hdmi-phy-v4-0-fcbaa652ad75@oss.qualcomm.com>
In-Reply-To: <20250520-fd-hdmi-phy-v4-0-fcbaa652ad75@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-phy@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=26257;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=y0P+Hi9CyYTcC6PcuG/EtvjloSg7WanVzhX7D03Rjfg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoLOnAQ7no4d2pdpxIEt/nWMMfhRF+26sn5U0kY
 son5RY97zuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaCzpwAAKCRCLPIo+Aiko
 1Y4YB/sEc+uBNhgUOOp+kWd4YLVj4tVbFb0zxXYOctedArsaUxwgqAjXDSsWbekceFYhLAZUR8l
 Ttp5El861o3iEIJg5Pfm3QEQ/8BvI/nZarP8qASI2rYEF2EsZiReiOIooatgL62GR5GTCceAqsV
 WySI0vtQEdDob3vN/ph+T889W0qH4Mz7v+7Yze/RxSp9lF27uMytauA6XoNSVxCmgpGD3hZEx/j
 mHysIV0jSgQ34P6iwl62rWdWBWFNQmbRiFuzf14DtCQrM2CFsIE+WdB8n4M/CQ5pUm7j8FAnMK3
 5nqE/4V8y1MXizBp/7WYd7CBNMMxWWJiTMnZvAb2KakW6kEi
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 20F2dWtUAJTtwgyOU-P5LsaZ3C578CRv
X-Proofpoint-ORIG-GUID: 20F2dWtUAJTtwgyOU-P5LsaZ3C578CRv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE2NyBTYWx0ZWRfX0Th3O/9Fongi
 mFPTHptUm7hCCJX4rwMBw1gOKkX4MEM78b3nzeYhT4Myi/wRKnzJgpIjk25W1KEPkVrv6Z39YYL
 0fsAaSdclxsZrsX/YpfDKSHTe1yfaQoz57qt2EB19xx0Dc5hvr2J/FMM721pHqgzqVlZ5DQGjLM
 DzVw8YGRe5bgDyx4QRAALtj5ArVzP2b26oVxLHkKFpvs3yNYun4rM/BYJ4zUnnOBoHYuUk5pnUl
 mUFX0CG4BHkghmx9cLD8bL+JH+IRxEZRSbUTrnTrUUPpKmq8uYLfeSBoz8DCtEqxn6IWhtx4VP5
 JGAhx9lJrPpLyhEW8tCoEZD8N1p42iZGjoJ6syS3a3a5is5w/a0MohZDG0WLLCxefMblFVkmJIi
 +pGtpE5XeBTsE73FGZBiaajycEZg9XFSIGloBmlW1kiw5dIykMO+X4DYTRAaBJJ+ueIvNAgX
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682ce9cf cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=BGUQ00EFi6mp_B5OqyUA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_09,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505200167

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

With the HDMI PHYs migrated to the generic PHY subsystem and to a
separate drivers there is no point in keeping HDMI PHY registers in the
drm/msm database, drop them.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/registers/display/hdmi.xml | 537 -------------------------
 1 file changed, 537 deletions(-)

diff --git a/drivers/gpu/drm/msm/registers/display/hdmi.xml b/drivers/gpu/drm/msm/registers/display/hdmi.xml
index 0ebb96297dae80940dc8a918d26cd58ff2e6f81a..1d44aa26c833708ee910e3bf4c29fd52ec5f6d0c 100644
--- a/drivers/gpu/drm/msm/registers/display/hdmi.xml
+++ b/drivers/gpu/drm/msm/registers/display/hdmi.xml
@@ -564,541 +564,4 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 
 </domain>
 
-<domain name="HDMI_8x60" width="32">
-	<reg32 offset="0x00000" name="PHY_REG0">
-		<bitfield name="DESER_DEL_CTRL" low="2" high="4" type="uint"/>
-	</reg32>
-	<reg32 offset="0x00004" name="PHY_REG1">
-		<bitfield name="DTEST_MUX_SEL" low="4" high="7" type="uint"/>
-		<bitfield name="OUTVOL_SWING_CTRL" low="0" high="3" type="uint"/>
-	</reg32>
-	<reg32 offset="0x00008" name="PHY_REG2">
-		<bitfield name="PD_DESER" pos="0" type="boolean"/>
-		<bitfield name="PD_DRIVE_1" pos="1" type="boolean"/>
-		<bitfield name="PD_DRIVE_2" pos="2" type="boolean"/>
-		<bitfield name="PD_DRIVE_3" pos="3" type="boolean"/>
-		<bitfield name="PD_DRIVE_4" pos="4" type="boolean"/>
-		<bitfield name="PD_PLL" pos="5" type="boolean"/>
-		<bitfield name="PD_PWRGEN" pos="6" type="boolean"/>
-		<bitfield name="RCV_SENSE_EN" pos="7" type="boolean"/>
-	</reg32>
-	<reg32 offset="0x0000c" name="PHY_REG3">
-		<bitfield name="PLL_ENABLE" pos="0" type="boolean"/>
-	</reg32>
-	<reg32 offset="0x00010" name="PHY_REG4"/>
-	<reg32 offset="0x00014" name="PHY_REG5"/>
-	<reg32 offset="0x00018" name="PHY_REG6"/>
-	<reg32 offset="0x0001c" name="PHY_REG7"/>
-	<reg32 offset="0x00020" name="PHY_REG8"/>
-	<reg32 offset="0x00024" name="PHY_REG9"/>
-	<reg32 offset="0x00028" name="PHY_REG10"/>
-	<reg32 offset="0x0002c" name="PHY_REG11"/>
-	<reg32 offset="0x00030" name="PHY_REG12">
-		<bitfield name="RETIMING_EN" pos="0" type="boolean"/>
-		<bitfield name="PLL_LOCK_DETECT_EN" pos="1" type="boolean"/>
-		<bitfield name="FORCE_LOCK" pos="4" type="boolean"/>
-	</reg32>
-</domain>
-
-<domain name="HDMI_8960" width="32">
-	<!--
-		some of the bitfields may be same as 8x60.. but no helpful comments
-		in msm_dss_io_8960.c
-	 -->
-	<reg32 offset="0x00000" name="PHY_REG0"/>
-	<reg32 offset="0x00004" name="PHY_REG1"/>
-	<reg32 offset="0x00008" name="PHY_REG2"/>
-	<reg32 offset="0x0000c" name="PHY_REG3"/>
-	<reg32 offset="0x00010" name="PHY_REG4"/>
-	<reg32 offset="0x00014" name="PHY_REG5"/>
-	<reg32 offset="0x00018" name="PHY_REG6"/>
-	<reg32 offset="0x0001c" name="PHY_REG7"/>
-	<reg32 offset="0x00020" name="PHY_REG8"/>
-	<reg32 offset="0x00024" name="PHY_REG9"/>
-	<reg32 offset="0x00028" name="PHY_REG10"/>
-	<reg32 offset="0x0002c" name="PHY_REG11"/>
-	<reg32 offset="0x00030" name="PHY_REG12">
-		<bitfield name="SW_RESET" pos="5" type="boolean"/>
-		<bitfield name="PWRDN_B" pos="7" type="boolean"/>
-	</reg32>
-	<reg32 offset="0x00034" name="PHY_REG_BIST_CFG"/>
-	<reg32 offset="0x00038" name="PHY_DEBUG_BUS_SEL"/>
-	<reg32 offset="0x0003c" name="PHY_REG_MISC0"/>
-	<reg32 offset="0x00040" name="PHY_REG13"/>
-	<reg32 offset="0x00044" name="PHY_REG14"/>
-	<reg32 offset="0x00048" name="PHY_REG15"/>
-</domain>
-
-<domain name="HDMI_8960_PHY_PLL" width="32">
-	<reg32 offset="0x00000" name="REFCLK_CFG"/>
-	<reg32 offset="0x00004" name="CHRG_PUMP_CFG"/>
-	<reg32 offset="0x00008" name="LOOP_FLT_CFG0"/>
-	<reg32 offset="0x0000c" name="LOOP_FLT_CFG1"/>
-	<reg32 offset="0x00010" name="IDAC_ADJ_CFG"/>
-	<reg32 offset="0x00014" name="I_VI_KVCO_CFG"/>
-	<reg32 offset="0x00018" name="PWRDN_B">
-		<bitfield name="PD_PLL" pos="1" type="boolean"/>
-		<bitfield name="PLL_PWRDN_B" pos="3" type="boolean"/>
-	</reg32>
-	<reg32 offset="0x0001c" name="SDM_CFG0"/>
-	<reg32 offset="0x00020" name="SDM_CFG1"/>
-	<reg32 offset="0x00024" name="SDM_CFG2"/>
-	<reg32 offset="0x00028" name="SDM_CFG3"/>
-	<reg32 offset="0x0002c" name="SDM_CFG4"/>
-	<reg32 offset="0x00030" name="SSC_CFG0"/>
-	<reg32 offset="0x00034" name="SSC_CFG1"/>
-	<reg32 offset="0x00038" name="SSC_CFG2"/>
-	<reg32 offset="0x0003c" name="SSC_CFG3"/>
-	<reg32 offset="0x00040" name="LOCKDET_CFG0"/>
-	<reg32 offset="0x00044" name="LOCKDET_CFG1"/>
-	<reg32 offset="0x00048" name="LOCKDET_CFG2"/>
-	<reg32 offset="0x0004c" name="VCOCAL_CFG0"/>
-	<reg32 offset="0x00050" name="VCOCAL_CFG1"/>
-	<reg32 offset="0x00054" name="VCOCAL_CFG2"/>
-	<reg32 offset="0x00058" name="VCOCAL_CFG3"/>
-	<reg32 offset="0x0005c" name="VCOCAL_CFG4"/>
-	<reg32 offset="0x00060" name="VCOCAL_CFG5"/>
-	<reg32 offset="0x00064" name="VCOCAL_CFG6"/>
-	<reg32 offset="0x00068" name="VCOCAL_CFG7"/>
-	<reg32 offset="0x0006c" name="DEBUG_SEL"/>
-	<reg32 offset="0x00070" name="MISC0"/>
-	<reg32 offset="0x00074" name="MISC1"/>
-	<reg32 offset="0x00078" name="MISC2"/>
-	<reg32 offset="0x0007c" name="MISC3"/>
-	<reg32 offset="0x00080" name="MISC4"/>
-	<reg32 offset="0x00084" name="MISC5"/>
-	<reg32 offset="0x00088" name="MISC6"/>
-	<reg32 offset="0x0008c" name="DEBUG_BUS0"/>
-	<reg32 offset="0x00090" name="DEBUG_BUS1"/>
-	<reg32 offset="0x00094" name="DEBUG_BUS2"/>
-	<reg32 offset="0x00098" name="STATUS0">
-		<bitfield name="PLL_LOCK" pos="0" type="boolean"/>
-	</reg32>
-	<reg32 offset="0x0009c" name="STATUS1"/>
-</domain>
-
-<domain name="HDMI_8x74" width="32">
-	<!--
-		seems to be all mdp5+ have same?
-	 -->
-	<reg32 offset="0x00000" name="ANA_CFG0"/>
-	<reg32 offset="0x00004" name="ANA_CFG1"/>
-	<reg32 offset="0x00008" name="ANA_CFG2"/>
-	<reg32 offset="0x0000c" name="ANA_CFG3"/>
-	<reg32 offset="0x00010" name="PD_CTRL0"/>
-	<reg32 offset="0x00014" name="PD_CTRL1"/>
-	<reg32 offset="0x00018" name="GLB_CFG"/>
-	<reg32 offset="0x0001c" name="DCC_CFG0"/>
-	<reg32 offset="0x00020" name="DCC_CFG1"/>
-	<reg32 offset="0x00024" name="TXCAL_CFG0"/>
-	<reg32 offset="0x00028" name="TXCAL_CFG1"/>
-	<reg32 offset="0x0002c" name="TXCAL_CFG2"/>
-	<reg32 offset="0x00030" name="TXCAL_CFG3"/>
-	<reg32 offset="0x00034" name="BIST_CFG0"/>
-	<reg32 offset="0x0003c" name="BIST_PATN0"/>
-	<reg32 offset="0x00040" name="BIST_PATN1"/>
-	<reg32 offset="0x00044" name="BIST_PATN2"/>
-	<reg32 offset="0x00048" name="BIST_PATN3"/>
-	<reg32 offset="0x0005c" name="STATUS"/>
-</domain>
-
-<domain name="HDMI_28nm_PHY_PLL" width="32">
-	<reg32 offset="0x00000" name="REFCLK_CFG"/>
-	<reg32 offset="0x00004" name="POSTDIV1_CFG"/>
-	<reg32 offset="0x00008" name="CHGPUMP_CFG"/>
-	<reg32 offset="0x0000C" name="VCOLPF_CFG"/>
-	<reg32 offset="0x00010" name="VREG_CFG"/>
-	<reg32 offset="0x00014" name="PWRGEN_CFG"/>
-	<reg32 offset="0x00018" name="DMUX_CFG"/>
-	<reg32 offset="0x0001C" name="AMUX_CFG"/>
-	<reg32 offset="0x00020" name="GLB_CFG">
-		<bitfield name="PLL_PWRDN_B" pos="0" type="boolean"/>
-		<bitfield name="PLL_LDO_PWRDN_B" pos="1" type="boolean"/>
-		<bitfield name="PLL_PWRGEN_PWRDN_B" pos="2" type="boolean"/>
-		<bitfield name="PLL_ENABLE" pos="3" type="boolean"/>
-	</reg32>
-	<reg32 offset="0x00024" name="POSTDIV2_CFG"/>
-	<reg32 offset="0x00028" name="POSTDIV3_CFG"/>
-	<reg32 offset="0x0002C" name="LPFR_CFG"/>
-	<reg32 offset="0x00030" name="LPFC1_CFG"/>
-	<reg32 offset="0x00034" name="LPFC2_CFG"/>
-	<reg32 offset="0x00038" name="SDM_CFG0"/>
-	<reg32 offset="0x0003C" name="SDM_CFG1"/>
-	<reg32 offset="0x00040" name="SDM_CFG2"/>
-	<reg32 offset="0x00044" name="SDM_CFG3"/>
-	<reg32 offset="0x00048" name="SDM_CFG4"/>
-	<reg32 offset="0x0004C" name="SSC_CFG0"/>
-	<reg32 offset="0x00050" name="SSC_CFG1"/>
-	<reg32 offset="0x00054" name="SSC_CFG2"/>
-	<reg32 offset="0x00058" name="SSC_CFG3"/>
-	<reg32 offset="0x0005C" name="LKDET_CFG0"/>
-	<reg32 offset="0x00060" name="LKDET_CFG1"/>
-	<reg32 offset="0x00064" name="LKDET_CFG2"/>
-	<reg32 offset="0x00068" name="TEST_CFG">
-		<bitfield name="PLL_SW_RESET" pos="0" type="boolean"/>
-	</reg32>
-	<reg32 offset="0x0006C" name="CAL_CFG0"/>
-	<reg32 offset="0x00070" name="CAL_CFG1"/>
-	<reg32 offset="0x00074" name="CAL_CFG2"/>
-	<reg32 offset="0x00078" name="CAL_CFG3"/>
-	<reg32 offset="0x0007C" name="CAL_CFG4"/>
-	<reg32 offset="0x00080" name="CAL_CFG5"/>
-	<reg32 offset="0x00084" name="CAL_CFG6"/>
-	<reg32 offset="0x00088" name="CAL_CFG7"/>
-	<reg32 offset="0x0008C" name="CAL_CFG8"/>
-	<reg32 offset="0x00090" name="CAL_CFG9"/>
-	<reg32 offset="0x00094" name="CAL_CFG10"/>
-	<reg32 offset="0x00098" name="CAL_CFG11"/>
-	<reg32 offset="0x0009C" name="EFUSE_CFG"/>
-	<reg32 offset="0x000A0" name="DEBUG_BUS_SEL"/>
-	<reg32 offset="0x000C0" name="STATUS"/>
-</domain>
-
-<domain name="HDMI_8996_PHY" width="32">
-	<reg32 offset="0x00000" name="CFG"/>
-	<reg32 offset="0x00004" name="PD_CTL"/>
-	<reg32 offset="0x00008" name="MODE"/>
-	<reg32 offset="0x0000C" name="MISR_CLEAR"/>
-	<reg32 offset="0x00010" name="TX0_TX1_BIST_CFG0"/>
-	<reg32 offset="0x00014" name="TX0_TX1_BIST_CFG1"/>
-	<reg32 offset="0x00018" name="TX0_TX1_PRBS_SEED_BYTE0"/>
-	<reg32 offset="0x0001C" name="TX0_TX1_PRBS_SEED_BYTE1"/>
-	<reg32 offset="0x00020" name="TX0_TX1_BIST_PATTERN0"/>
-	<reg32 offset="0x00024" name="TX0_TX1_BIST_PATTERN1"/>
-	<reg32 offset="0x00028" name="TX2_TX3_BIST_CFG0"/>
-	<reg32 offset="0x0002C" name="TX2_TX3_BIST_CFG1"/>
-	<reg32 offset="0x00030" name="TX2_TX3_PRBS_SEED_BYTE0"/>
-	<reg32 offset="0x00034" name="TX2_TX3_PRBS_SEED_BYTE1"/>
-	<reg32 offset="0x00038" name="TX2_TX3_BIST_PATTERN0"/>
-	<reg32 offset="0x0003C" name="TX2_TX3_BIST_PATTERN1"/>
-	<reg32 offset="0x00040" name="DEBUG_BUS_SEL"/>
-	<reg32 offset="0x00044" name="TXCAL_CFG0"/>
-	<reg32 offset="0x00048" name="TXCAL_CFG1"/>
-	<reg32 offset="0x0004C" name="TX0_TX1_LANE_CTL"/>
-	<reg32 offset="0x00050" name="TX2_TX3_LANE_CTL"/>
-	<reg32 offset="0x00054" name="LANE_BIST_CONFIG"/>
-	<reg32 offset="0x00058" name="CLOCK"/>
-	<reg32 offset="0x0005C" name="MISC1"/>
-	<reg32 offset="0x00060" name="MISC2"/>
-	<reg32 offset="0x00064" name="TX0_TX1_BIST_STATUS0"/>
-	<reg32 offset="0x00068" name="TX0_TX1_BIST_STATUS1"/>
-	<reg32 offset="0x0006C" name="TX0_TX1_BIST_STATUS2"/>
-	<reg32 offset="0x00070" name="TX2_TX3_BIST_STATUS0"/>
-	<reg32 offset="0x00074" name="TX2_TX3_BIST_STATUS1"/>
-	<reg32 offset="0x00078" name="TX2_TX3_BIST_STATUS2"/>
-	<reg32 offset="0x0007C" name="PRE_MISR_STATUS0"/>
-	<reg32 offset="0x00080" name="PRE_MISR_STATUS1"/>
-	<reg32 offset="0x00084" name="PRE_MISR_STATUS2"/>
-	<reg32 offset="0x00088" name="PRE_MISR_STATUS3"/>
-	<reg32 offset="0x0008C" name="POST_MISR_STATUS0"/>
-	<reg32 offset="0x00090" name="POST_MISR_STATUS1"/>
-	<reg32 offset="0x00094" name="POST_MISR_STATUS2"/>
-	<reg32 offset="0x00098" name="POST_MISR_STATUS3"/>
-	<reg32 offset="0x0009C" name="STATUS"/>
-	<reg32 offset="0x000A0" name="MISC3_STATUS"/>
-	<reg32 offset="0x000A4" name="MISC4_STATUS"/>
-	<reg32 offset="0x000A8" name="DEBUG_BUS0"/>
-	<reg32 offset="0x000AC" name="DEBUG_BUS1"/>
-	<reg32 offset="0x000B0" name="DEBUG_BUS2"/>
-	<reg32 offset="0x000B4" name="DEBUG_BUS3"/>
-	<reg32 offset="0x000B8" name="PHY_REVISION_ID0"/>
-	<reg32 offset="0x000BC" name="PHY_REVISION_ID1"/>
-	<reg32 offset="0x000C0" name="PHY_REVISION_ID2"/>
-	<reg32 offset="0x000C4" name="PHY_REVISION_ID3"/>
-</domain>
-
-<domain name="HDMI_PHY_QSERDES_COM" width="32">
-	<reg32 offset="0x00000" name="ATB_SEL1"/>
-	<reg32 offset="0x00004" name="ATB_SEL2"/>
-	<reg32 offset="0x00008" name="FREQ_UPDATE"/>
-	<reg32 offset="0x0000C" name="BG_TIMER"/>
-	<reg32 offset="0x00010" name="SSC_EN_CENTER"/>
-	<reg32 offset="0x00014" name="SSC_ADJ_PER1"/>
-	<reg32 offset="0x00018" name="SSC_ADJ_PER2"/>
-	<reg32 offset="0x0001C" name="SSC_PER1"/>
-	<reg32 offset="0x00020" name="SSC_PER2"/>
-	<reg32 offset="0x00024" name="SSC_STEP_SIZE1"/>
-	<reg32 offset="0x00028" name="SSC_STEP_SIZE2"/>
-	<reg32 offset="0x0002C" name="POST_DIV"/>
-	<reg32 offset="0x00030" name="POST_DIV_MUX"/>
-	<reg32 offset="0x00034" name="BIAS_EN_CLKBUFLR_EN"/>
-	<reg32 offset="0x00038" name="CLK_ENABLE1"/>
-	<reg32 offset="0x0003C" name="SYS_CLK_CTRL"/>
-	<reg32 offset="0x00040" name="SYSCLK_BUF_ENABLE"/>
-	<reg32 offset="0x00044" name="PLL_EN"/>
-	<reg32 offset="0x00048" name="PLL_IVCO"/>
-	<reg32 offset="0x0004C" name="LOCK_CMP1_MODE0"/>
-	<reg32 offset="0x00050" name="LOCK_CMP2_MODE0"/>
-	<reg32 offset="0x00054" name="LOCK_CMP3_MODE0"/>
-	<reg32 offset="0x00058" name="LOCK_CMP1_MODE1"/>
-	<reg32 offset="0x0005C" name="LOCK_CMP2_MODE1"/>
-	<reg32 offset="0x00060" name="LOCK_CMP3_MODE1"/>
-	<reg32 offset="0x00064" name="LOCK_CMP1_MODE2"/>
-	<reg32 offset="0x00064" name="CMN_RSVD0"/>
-	<reg32 offset="0x00068" name="LOCK_CMP2_MODE2"/>
-	<reg32 offset="0x00068" name="EP_CLOCK_DETECT_CTRL"/>
-	<reg32 offset="0x0006C" name="LOCK_CMP3_MODE2"/>
-	<reg32 offset="0x0006C" name="SYSCLK_DET_COMP_STATUS"/>
-	<reg32 offset="0x00070" name="BG_TRIM"/>
-	<reg32 offset="0x00074" name="CLK_EP_DIV"/>
-	<reg32 offset="0x00078" name="CP_CTRL_MODE0"/>
-	<reg32 offset="0x0007C" name="CP_CTRL_MODE1"/>
-	<reg32 offset="0x00080" name="CP_CTRL_MODE2"/>
-	<reg32 offset="0x00080" name="CMN_RSVD1"/>
-	<reg32 offset="0x00084" name="PLL_RCTRL_MODE0"/>
-	<reg32 offset="0x00088" name="PLL_RCTRL_MODE1"/>
-	<reg32 offset="0x0008C" name="PLL_RCTRL_MODE2"/>
-	<reg32 offset="0x0008C" name="CMN_RSVD2"/>
-	<reg32 offset="0x00090" name="PLL_CCTRL_MODE0"/>
-	<reg32 offset="0x00094" name="PLL_CCTRL_MODE1"/>
-	<reg32 offset="0x00098" name="PLL_CCTRL_MODE2"/>
-	<reg32 offset="0x00098" name="CMN_RSVD3"/>
-	<reg32 offset="0x0009C" name="PLL_CNTRL"/>
-	<reg32 offset="0x000A0" name="PHASE_SEL_CTRL"/>
-	<reg32 offset="0x000A4" name="PHASE_SEL_DC"/>
-	<reg32 offset="0x000A8" name="CORE_CLK_IN_SYNC_SEL"/>
-	<reg32 offset="0x000A8" name="BIAS_EN_CTRL_BY_PSM"/>
-	<reg32 offset="0x000AC" name="SYSCLK_EN_SEL"/>
-	<reg32 offset="0x000B0" name="CML_SYSCLK_SEL"/>
-	<reg32 offset="0x000B4" name="RESETSM_CNTRL"/>
-	<reg32 offset="0x000B8" name="RESETSM_CNTRL2"/>
-	<reg32 offset="0x000BC" name="RESTRIM_CTRL"/>
-	<reg32 offset="0x000C0" name="RESTRIM_CTRL2"/>
-	<reg32 offset="0x000C4" name="RESCODE_DIV_NUM"/>
-	<reg32 offset="0x000C8" name="LOCK_CMP_EN"/>
-	<reg32 offset="0x000CC" name="LOCK_CMP_CFG"/>
-	<reg32 offset="0x000D0" name="DEC_START_MODE0"/>
-	<reg32 offset="0x000D4" name="DEC_START_MODE1"/>
-	<reg32 offset="0x000D8" name="DEC_START_MODE2"/>
-	<reg32 offset="0x000D8" name="VCOCAL_DEADMAN_CTRL"/>
-	<reg32 offset="0x000DC" name="DIV_FRAC_START1_MODE0"/>
-	<reg32 offset="0x000E0" name="DIV_FRAC_START2_MODE0"/>
-	<reg32 offset="0x000E4" name="DIV_FRAC_START3_MODE0"/>
-	<reg32 offset="0x000E8" name="DIV_FRAC_START1_MODE1"/>
-	<reg32 offset="0x000EC" name="DIV_FRAC_START2_MODE1"/>
-	<reg32 offset="0x000F0" name="DIV_FRAC_START3_MODE1"/>
-	<reg32 offset="0x000F4" name="DIV_FRAC_START1_MODE2"/>
-	<reg32 offset="0x000F4" name="VCO_TUNE_MINVAL1"/>
-	<reg32 offset="0x000F8" name="DIV_FRAC_START2_MODE2"/>
-	<reg32 offset="0x000F8" name="VCO_TUNE_MINVAL2"/>
-	<reg32 offset="0x000FC" name="DIV_FRAC_START3_MODE2"/>
-	<reg32 offset="0x000FC" name="CMN_RSVD4"/>
-	<reg32 offset="0x00100" name="INTEGLOOP_INITVAL"/>
-	<reg32 offset="0x00104" name="INTEGLOOP_EN"/>
-	<reg32 offset="0x00108" name="INTEGLOOP_GAIN0_MODE0"/>
-	<reg32 offset="0x0010C" name="INTEGLOOP_GAIN1_MODE0"/>
-	<reg32 offset="0x00110" name="INTEGLOOP_GAIN0_MODE1"/>
-	<reg32 offset="0x00114" name="INTEGLOOP_GAIN1_MODE1"/>
-	<reg32 offset="0x00118" name="INTEGLOOP_GAIN0_MODE2"/>
-	<reg32 offset="0x00118" name="VCO_TUNE_MAXVAL1"/>
-	<reg32 offset="0x0011C" name="INTEGLOOP_GAIN1_MODE2"/>
-	<reg32 offset="0x0011C" name="VCO_TUNE_MAXVAL2"/>
-	<reg32 offset="0x00120" name="RES_TRIM_CONTROL2"/>
-	<reg32 offset="0x00124" name="VCO_TUNE_CTRL"/>
-	<reg32 offset="0x00128" name="VCO_TUNE_MAP"/>
-	<reg32 offset="0x0012C" name="VCO_TUNE1_MODE0"/>
-	<reg32 offset="0x00130" name="VCO_TUNE2_MODE0"/>
-	<reg32 offset="0x00134" name="VCO_TUNE1_MODE1"/>
-	<reg32 offset="0x00138" name="VCO_TUNE2_MODE1"/>
-	<reg32 offset="0x0013C" name="VCO_TUNE1_MODE2"/>
-	<reg32 offset="0x0013C" name="VCO_TUNE_INITVAL1"/>
-	<reg32 offset="0x00140" name="VCO_TUNE2_MODE2"/>
-	<reg32 offset="0x00140" name="VCO_TUNE_INITVAL2"/>
-	<reg32 offset="0x00144" name="VCO_TUNE_TIMER1"/>
-	<reg32 offset="0x00148" name="VCO_TUNE_TIMER2"/>
-	<reg32 offset="0x0014C" name="SAR"/>
-	<reg32 offset="0x00150" name="SAR_CLK"/>
-	<reg32 offset="0x00154" name="SAR_CODE_OUT_STATUS"/>
-	<reg32 offset="0x00158" name="SAR_CODE_READY_STATUS"/>
-	<reg32 offset="0x0015C" name="CMN_STATUS"/>
-	<reg32 offset="0x00160" name="RESET_SM_STATUS"/>
-	<reg32 offset="0x00164" name="RESTRIM_CODE_STATUS"/>
-	<reg32 offset="0x00168" name="PLLCAL_CODE1_STATUS"/>
-	<reg32 offset="0x0016C" name="PLLCAL_CODE2_STATUS"/>
-	<reg32 offset="0x00170" name="BG_CTRL"/>
-	<reg32 offset="0x00174" name="CLK_SELECT"/>
-	<reg32 offset="0x00178" name="HSCLK_SEL"/>
-	<reg32 offset="0x0017C" name="INTEGLOOP_BINCODE_STATUS"/>
-	<reg32 offset="0x00180" name="PLL_ANALOG"/>
-	<reg32 offset="0x00184" name="CORECLK_DIV"/>
-	<reg32 offset="0x00188" name="SW_RESET"/>
-	<reg32 offset="0x0018C" name="CORE_CLK_EN"/>
-	<reg32 offset="0x00190" name="C_READY_STATUS"/>
-	<reg32 offset="0x00194" name="CMN_CONFIG"/>
-	<reg32 offset="0x00198" name="CMN_RATE_OVERRIDE"/>
-	<reg32 offset="0x0019C" name="SVS_MODE_CLK_SEL"/>
-	<reg32 offset="0x001A0" name="DEBUG_BUS0"/>
-	<reg32 offset="0x001A4" name="DEBUG_BUS1"/>
-	<reg32 offset="0x001A8" name="DEBUG_BUS2"/>
-	<reg32 offset="0x001AC" name="DEBUG_BUS3"/>
-	<reg32 offset="0x001B0" name="DEBUG_BUS_SEL"/>
-	<reg32 offset="0x001B4" name="CMN_MISC1"/>
-	<reg32 offset="0x001B8" name="CMN_MISC2"/>
-	<reg32 offset="0x001BC" name="CORECLK_DIV_MODE1"/>
-	<reg32 offset="0x001C0" name="CORECLK_DIV_MODE2"/>
-	<reg32 offset="0x001C4" name="CMN_RSVD5"/>
-</domain>
-
-
-<domain name="HDMI_PHY_QSERDES_TX_LX" width="32">
-		<reg32 offset="0x00000" name="BIST_MODE_LANENO"/>
-		<reg32 offset="0x00004" name="BIST_INVERT"/>
-		<reg32 offset="0x00008" name="CLKBUF_ENABLE"/>
-		<reg32 offset="0x0000C" name="CMN_CONTROL_ONE"/>
-		<reg32 offset="0x00010" name="CMN_CONTROL_TWO"/>
-		<reg32 offset="0x00014" name="CMN_CONTROL_THREE"/>
-		<reg32 offset="0x00018" name="TX_EMP_POST1_LVL"/>
-		<reg32 offset="0x0001C" name="TX_POST2_EMPH"/>
-		<reg32 offset="0x00020" name="TX_BOOST_LVL_UP_DN"/>
-		<reg32 offset="0x00024" name="HP_PD_ENABLES"/>
-		<reg32 offset="0x00028" name="TX_IDLE_LVL_LARGE_AMP"/>
-		<reg32 offset="0x0002C" name="TX_DRV_LVL"/>
-		<reg32 offset="0x00030" name="TX_DRV_LVL_OFFSET"/>
-		<reg32 offset="0x00034" name="RESET_TSYNC_EN"/>
-		<reg32 offset="0x00038" name="PRE_STALL_LDO_BOOST_EN"/>
-		<reg32 offset="0x0003C" name="TX_BAND"/>
-		<reg32 offset="0x00040" name="SLEW_CNTL"/>
-		<reg32 offset="0x00044" name="INTERFACE_SELECT"/>
-		<reg32 offset="0x00048" name="LPB_EN"/>
-		<reg32 offset="0x0004C" name="RES_CODE_LANE_TX"/>
-		<reg32 offset="0x00050" name="RES_CODE_LANE_RX"/>
-		<reg32 offset="0x00054" name="RES_CODE_LANE_OFFSET"/>
-		<reg32 offset="0x00058" name="PERL_LENGTH1"/>
-		<reg32 offset="0x0005C" name="PERL_LENGTH2"/>
-		<reg32 offset="0x00060" name="SERDES_BYP_EN_OUT"/>
-		<reg32 offset="0x00064" name="DEBUG_BUS_SEL"/>
-		<reg32 offset="0x00068" name="HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN"/>
-		<reg32 offset="0x0006C" name="TX_POL_INV"/>
-		<reg32 offset="0x00070" name="PARRATE_REC_DETECT_IDLE_EN"/>
-		<reg32 offset="0x00074" name="BIST_PATTERN1"/>
-		<reg32 offset="0x00078" name="BIST_PATTERN2"/>
-		<reg32 offset="0x0007C" name="BIST_PATTERN3"/>
-		<reg32 offset="0x00080" name="BIST_PATTERN4"/>
-		<reg32 offset="0x00084" name="BIST_PATTERN5"/>
-		<reg32 offset="0x00088" name="BIST_PATTERN6"/>
-		<reg32 offset="0x0008C" name="BIST_PATTERN7"/>
-		<reg32 offset="0x00090" name="BIST_PATTERN8"/>
-		<reg32 offset="0x00094" name="LANE_MODE"/>
-		<reg32 offset="0x00098" name="IDAC_CAL_LANE_MODE"/>
-		<reg32 offset="0x0009C" name="IDAC_CAL_LANE_MODE_CONFIGURATION"/>
-		<reg32 offset="0x000A0" name="ATB_SEL1"/>
-		<reg32 offset="0x000A4" name="ATB_SEL2"/>
-		<reg32 offset="0x000A8" name="RCV_DETECT_LVL"/>
-		<reg32 offset="0x000AC" name="RCV_DETECT_LVL_2"/>
-		<reg32 offset="0x000B0" name="PRBS_SEED1"/>
-		<reg32 offset="0x000B4" name="PRBS_SEED2"/>
-		<reg32 offset="0x000B8" name="PRBS_SEED3"/>
-		<reg32 offset="0x000BC" name="PRBS_SEED4"/>
-		<reg32 offset="0x000C0" name="RESET_GEN"/>
-		<reg32 offset="0x000C4" name="RESET_GEN_MUXES"/>
-		<reg32 offset="0x000C8" name="TRAN_DRVR_EMP_EN"/>
-		<reg32 offset="0x000CC" name="TX_INTERFACE_MODE"/>
-		<reg32 offset="0x000D0" name="PWM_CTRL"/>
-		<reg32 offset="0x000D4" name="PWM_ENCODED_OR_DATA"/>
-		<reg32 offset="0x000D8" name="PWM_GEAR_1_DIVIDER_BAND2"/>
-		<reg32 offset="0x000DC" name="PWM_GEAR_2_DIVIDER_BAND2"/>
-		<reg32 offset="0x000E0" name="PWM_GEAR_3_DIVIDER_BAND2"/>
-		<reg32 offset="0x000E4" name="PWM_GEAR_4_DIVIDER_BAND2"/>
-		<reg32 offset="0x000E8" name="PWM_GEAR_1_DIVIDER_BAND0_1"/>
-		<reg32 offset="0x000EC" name="PWM_GEAR_2_DIVIDER_BAND0_1"/>
-		<reg32 offset="0x000F0" name="PWM_GEAR_3_DIVIDER_BAND0_1"/>
-		<reg32 offset="0x000F4" name="PWM_GEAR_4_DIVIDER_BAND0_1"/>
-		<reg32 offset="0x000F8" name="VMODE_CTRL1"/>
-		<reg32 offset="0x000FC" name="VMODE_CTRL2"/>
-		<reg32 offset="0x00100" name="TX_ALOG_INTF_OBSV_CNTL"/>
-		<reg32 offset="0x00104" name="BIST_STATUS"/>
-		<reg32 offset="0x00108" name="BIST_ERROR_COUNT1"/>
-		<reg32 offset="0x0010C" name="BIST_ERROR_COUNT2"/>
-		<reg32 offset="0x00110" name="TX_ALOG_INTF_OBSV"/>
-</domain>
-
-<domain name="HDMI_8998_PHY" width="32">
-	<reg32 offset="0x00000" name="CFG"/>
-	<reg32 offset="0x00004" name="PD_CTL"/>
-	<reg32 offset="0x00010" name="MODE"/>
-	<reg32 offset="0x0005C" name="CLOCK"/>
-	<reg32 offset="0x00068" name="CMN_CTRL"/>
-	<reg32 offset="0x000B4" name="STATUS"/>
-</domain>
-
-<domain name="HDMI_8998_PHY_QSERDES_COM" width="32">
-	<reg32 offset="0x0000" name="ATB_SEL1"/>
-	<reg32 offset="0x0004" name="ATB_SEL2"/>
-	<reg32 offset="0x0008" name="FREQ_UPDATE"/>
-	<reg32 offset="0x000C" name="BG_TIMER"/>
-	<reg32 offset="0x0010" name="SSC_EN_CENTER"/>
-	<reg32 offset="0x0014" name="SSC_ADJ_PER1"/>
-	<reg32 offset="0x0018" name="SSC_ADJ_PER2"/>
-	<reg32 offset="0x001C" name="SSC_PER1"/>
-	<reg32 offset="0x0020" name="SSC_PER2"/>
-	<reg32 offset="0x0024" name="SSC_STEP_SIZE1"/>
-	<reg32 offset="0x0028" name="SSC_STEP_SIZE2"/>
-	<reg32 offset="0x002C" name="POST_DIV"/>
-	<reg32 offset="0x0030" name="POST_DIV_MUX"/>
-	<reg32 offset="0x0034" name="BIAS_EN_CLKBUFLR_EN"/>
-	<reg32 offset="0x0038" name="CLK_ENABLE1"/>
-	<reg32 offset="0x003C" name="SYS_CLK_CTRL"/>
-	<reg32 offset="0x0040" name="SYSCLK_BUF_ENABLE"/>
-	<reg32 offset="0x0044" name="PLL_EN"/>
-	<reg32 offset="0x0048" name="PLL_IVCO"/>
-	<reg32 offset="0x004C" name="CMN_IETRIM"/>
-	<reg32 offset="0x0050" name="CMN_IPTRIM"/>
-	<reg32 offset="0x0060" name="CP_CTRL_MODE0"/>
-	<reg32 offset="0x0064" name="CP_CTRL_MODE1"/>
-	<reg32 offset="0x0068" name="PLL_RCTRL_MODE0"/>
-	<reg32 offset="0x006C" name="PLL_RCTRL_MODE1"/>
-	<reg32 offset="0x0070" name="PLL_CCTRL_MODE0"/>
-	<reg32 offset="0x0074" name="PLL_CCTRL_MODE1"/>
-	<reg32 offset="0x0078" name="PLL_CNTRL"/>
-	<reg32 offset="0x007C" name="BIAS_EN_CTRL_BY_PSM"/>
-	<reg32 offset="0x0080" name="SYSCLK_EN_SEL"/>
-	<reg32 offset="0x0084" name="CML_SYSCLK_SEL"/>
-	<reg32 offset="0x0088" name="RESETSM_CNTRL"/>
-	<reg32 offset="0x008C" name="RESETSM_CNTRL2"/>
-	<reg32 offset="0x0090" name="LOCK_CMP_EN"/>
-	<reg32 offset="0x0094" name="LOCK_CMP_CFG"/>
-	<reg32 offset="0x0098" name="LOCK_CMP1_MODE0"/>
-	<reg32 offset="0x009C" name="LOCK_CMP2_MODE0"/>
-	<reg32 offset="0x00A0" name="LOCK_CMP3_MODE0"/>
-	<reg32 offset="0x00B0" name="DEC_START_MODE0"/>
-	<reg32 offset="0x00B4" name="DEC_START_MODE1"/>
-	<reg32 offset="0x00B8" name="DIV_FRAC_START1_MODE0"/>
-	<reg32 offset="0x00BC" name="DIV_FRAC_START2_MODE0"/>
-	<reg32 offset="0x00C0" name="DIV_FRAC_START3_MODE0"/>
-	<reg32 offset="0x00C4" name="DIV_FRAC_START1_MODE1"/>
-	<reg32 offset="0x00C8" name="DIV_FRAC_START2_MODE1"/>
-	<reg32 offset="0x00CC" name="DIV_FRAC_START3_MODE1"/>
-	<reg32 offset="0x00D0" name="INTEGLOOP_INITVAL"/>
-	<reg32 offset="0x00D4" name="INTEGLOOP_EN"/>
-	<reg32 offset="0x00D8" name="INTEGLOOP_GAIN0_MODE0"/>
-	<reg32 offset="0x00DC" name="INTEGLOOP_GAIN1_MODE0"/>
-	<reg32 offset="0x00E0" name="INTEGLOOP_GAIN0_MODE1"/>
-	<reg32 offset="0x00E4" name="INTEGLOOP_GAIN1_MODE1"/>
-	<reg32 offset="0x00E8" name="VCOCAL_DEADMAN_CTRL"/>
-	<reg32 offset="0x00EC" name="VCO_TUNE_CTRL"/>
-	<reg32 offset="0x00F0" name="VCO_TUNE_MAP"/>
-	<reg32 offset="0x0124" name="CMN_STATUS"/>
-	<reg32 offset="0x0128" name="RESET_SM_STATUS"/>
-	<reg32 offset="0x0138" name="CLK_SEL"/>
-	<reg32 offset="0x013C" name="HSCLK_SEL"/>
-	<reg32 offset="0x0148" name="CORECLK_DIV_MODE0"/>
-	<reg32 offset="0x0150" name="SW_RESET"/>
-	<reg32 offset="0x0154" name="CORE_CLK_EN"/>
-	<reg32 offset="0x0158" name="C_READY_STATUS"/>
-	<reg32 offset="0x015C" name="CMN_CONFIG"/>
-	<reg32 offset="0x0164" name="SVS_MODE_CLK_SEL"/>
-</domain>
-
-<domain name="HDMI_8998_PHY_TXn" width="32">
-	<reg32 offset="0x0000" name="EMP_POST1_LVL"/>
-	<reg32 offset="0x0008" name="INTERFACE_SELECT_TX_BAND"/>
-	<reg32 offset="0x000C" name="CLKBUF_TERM_ENABLE"/>
-	<reg32 offset="0x0014" name="DRV_LVL_RES_CODE_OFFSET"/>
-	<reg32 offset="0x0018" name="DRV_LVL"/>
-	<reg32 offset="0x001C" name="LANE_CONFIG"/>
-	<reg32 offset="0x0024" name="PRE_DRIVER_1"/>
-	<reg32 offset="0x0028" name="PRE_DRIVER_2"/>
-	<reg32 offset="0x002C" name="LANE_MODE"/>
-</domain>
-
 </database>

-- 
2.39.5


