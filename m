Return-Path: <linux-kernel+bounces-604747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4465EA89826
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 11:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670FC3B0094
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 09:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6FB28936D;
	Tue, 15 Apr 2025 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SmW0bNr4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E8627F723
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709981; cv=none; b=oXHejRdXzWkGvArysOElzX633dVgNBKcc1lgjYCDEL6+9TGZbTcIqI8tO6gxx9XT+mca3ed7zV3OGFF7dUxbZ+OmsWeTxtbQ00zGC0IvVbXcMWIKCg9Spa9MXoT1cUTo4la1IoqvdZvwLEbIr+lnHrAXpisckDd4fCqK7Lf8fY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709981; c=relaxed/simple;
	bh=8+FdRKBRcQNHe/n056K1ZGMprSxiSZfCl3rDyLla6E8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fIPwJKQYhYFxPBuOAO/O3RBqsCPOPU+urBCMEWFXqjG9OZqBjAhu+hqydIJ76iezCM2tm1StB2k3WR+ZfVIVURNEX+P6BRSMpl9fXTKnhrwWTvjKzWpWKRu+ZkIrp8xwJdQdJLQem9+UrP1RDZAzbroH2xligNp+WeY59P/oHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SmW0bNr4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tDDK025092
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 09:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=V8/InWf/oEp6mC1XkXIEKa
	Vat3glgwm35TmdtOEWZG8=; b=SmW0bNr4aipfz2iUbnS7akLkYvwi4n+q1kzQAb
	Z4ggY3zeY1GRWHOrwGJC8yFh6czu3l44zUUQemIy6uXNASeFAF7FVVQ7R+2fYlcT
	uO8GwSWvIZK7+LwGAQFQTYKho3vYoZ7NHR+Ie1dJmgoxW4eUPgdpGNNHiYn2jz+X
	ZXYr6VVYdt3NnrAkM1lI6K1TsW8O5eY0U1Rft223nDcub1knNIpstQ3Y/8i6KYNK
	dbcTpGUfFTKEH/zZc494PeLaCvuvoc+7OKO1BkGPg7v/zvoysCHFuAchmBbsI38/
	z7wFdygB+q+S7ZQVl38xYUxecpm7OcCCrPwnqMtqvzqRD+BQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wfh5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 09:39:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5bb68b386so1522358485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 02:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744709978; x=1745314778;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8/InWf/oEp6mC1XkXIEKaVat3glgwm35TmdtOEWZG8=;
        b=PzQ9aagTpxBo38cBIXowppT223iteaeVBJtd2nAgO3hPr18ZJ0OK6ZtL1xnbN4DDyP
         T91LtfKy07E3KXl662Z9quwPtc5/4D/7v/xKOh+xWQH8NI3UJwoHa0qUR9gb8FvoNKqK
         0isdKlR6RR6OhLPU/dt3MafSiYu6U1c0nUvs5Ln8yRB1dKHZrTE0VpNMDp19v6ApSkA4
         Oze1hWaTkuqKzxRsD2mPlN5vor9Ohwx4HnvJmlk1SKmwIAo1/eEFsmmKnARNacTgweOK
         RlQDIqWxJdNM8pb+hpDipFIhjVMpPRfMcEScWEb/0mx3nbqEBP7mOVkycx9AsytXY02o
         2rLw==
X-Forwarded-Encrypted: i=1; AJvYcCVSjReSMVkz2cAb78DBtDoLeDhiqnNq0BkLJFh7HRFWCOpJFxFAn3BLQC/8m1ueVEL513IIGDZczMNbZd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38L9IUW/rZxESAYb75Qq4R9hb2S709RLzzJ1Q1WsZ8E9oSheI
	Mq4YnCPjPSYwcEinYNgnPR2cEzbk0d17YZ68PuRWFqp16Wz/ZrjQ7cnaweiIR+0Ves+40DiIvXg
	HindC7JzbSvLKgUhUoyZi5VYdbTu6OvP188dfaPNayHaz44XstJRbLbJ/jcQMTMA=
X-Gm-Gg: ASbGncuUkeES3zhRJA+KIO53sgy4quEkjPfS0/RZ3/PPe6Dm3yofg9vMadCfHZa/T9w
	GYwi1IYO2ujE/GFKpSyWCYV/OL2MCFKBDgsKWxWpshKnvLn5NHKakX1Lhwdvt+tDLZ58v9C60u/
	D/63qesWhN4QSsI7DUaSVrGYjn7qXqn5djZgReeVD/rgn6uExN1pf02PTwcrZORRCQwy+81l1RW
	sVsytVLp/2p/wUFqKqHkNvVCazkEY56Wjs8gUPTZmQhB954jW1qzXf0tHKC0d4lgyumNyGpc9Up
	+UbN6HdK8ci7Aw0DywanwRgh33nhbOc85qucUeM0MvxJsOEA2T2XxheJ7/msSooo+JNCt/pmO5V
	zfOOar1Yu9NC+0FKrD6I4lfvK
X-Received: by 2002:a05:620a:2941:b0:7c5:57b2:2cb7 with SMTP id af79cd13be357-7c7af13effdmr2310020685a.56.1744709977780;
        Tue, 15 Apr 2025 02:39:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4rACzgVsYI3BzPQGoMw4ZxLMn+GpdVuPdRl/4ZF9EcAu0Pa9lLDPfkwsny6yqR1/CgDYg7g==
X-Received: by 2002:a05:620a:2941:b0:7c5:57b2:2cb7 with SMTP id af79cd13be357-7c7af13effdmr2310016085a.56.1744709977374;
        Tue, 15 Apr 2025 02:39:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464cbc60sm20141901fa.24.2025.04.15.02.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 02:39:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 00/10] drm/msm: add support for SAR2130P
Date: Tue, 15 Apr 2025 12:39:28 +0300
Message-Id: <20250415-sar2130p-display-v3-0-62314b1c9023@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFAp/mcC/3WOQY7CMAxFr1J5TYqTtKOKFfcYsUhbByy1TYlDB
 UK9+4SyYcFsLD3r+/k/QSgyCRyKJ0RaWDhMGeyugO7ipjMp7jODQVOjxUaJi0ZbnFXPMg/uoVr
 8Qe07T61FyGdzJM/3Tfl7enOk6y2b03sJrRNSXRhHTodionvaj04SRXjFLywpxMdWaNFb/v/fi
 1aodF91Fn1lG2OOA08uhjLE82ZbzIdBV18MJhus9q6q0bimxmMQKa83N7wKlnnAaV3XP7wHV6w
 oAQAA
X-Change-ID: 20250308-sar2130p-display-b0601fcfeb30
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2735;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8+FdRKBRcQNHe/n056K1ZGMprSxiSZfCl3rDyLla6E8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn/ilVQblGdMJpbMs8bFSCq/qV9blClDIrPNXU6
 68xeWaH1FuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ/4pVQAKCRCLPIo+Aiko
 1YZ2B/9ihoSC4zR3Eh0ZFAbhucp8PMMkr8PUnF6yxorCyMNhIOUeGw59NXQ2agjKOhmZKNGyVeq
 2PIodoZBADp4xLaOIJvTAl8kTIpiTzAGCM4NENMGP71c45NOsrqdS2LwYdLWb/D3ousXN2mvLTG
 No5siL7covudh6eimBrUt1Z3meFpoIzAW8u626EL43LRw5PYxttaZDPvdfEtpm1Mhs68j3IdpWO
 FwogpnPBKKUKAnj1pLbzXxNZN7vV+p7BKHSCDPWjZfuVByr+oxX9D68q/ePAJK2xNaSKDiQa6HH
 LguDGt1yqk7R2lhJDP+UtaMyk2i6z0OAO/GNQ3NVXiZxgZav
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=67fe295a cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=qnNoV65vq9fCYBTq3NIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vPnYlJfVjskJKMKZRKmGLM5yPAbLCxDY
X-Proofpoint-GUID: vPnYlJfVjskJKMKZRKmGLM5yPAbLCxDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=913 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150067

Add support for the Mobile Display SubSystem (MDSS) device present on
the Qualcomm SAR2130P platform. The MDSS device is similar to SM8550, it
features two MIPI DSI controllers, two MIPI DSI PHYs and one DisplayPort
controller.

Note, due to the technical limitations DP controller wasn't completely
evaluated.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v3:
- Use defines for DSI PHY clock indices (Konrad)
- Increas VBIF region size of 0x3000 (Konrad)
- Link to v2: https://lore.kernel.org/r/20250314-sar2130p-display-v2-0-31fa4502a850@oss.qualcomm.com

Changes in v2:
- In MDSS schema switched from list items to contains: (Krzyztof)
- In MDSS schema dropped extra empty lines (Krzysztof)
- Fixed .ubwc_bank_spread in msm_mdss. (LKP)
- Link to v1: https://lore.kernel.org/r/20250308-sar2130p-display-v1-0-1d4c30f43822@linaro.org

---
Dmitry Baryshkov (10):
      dt-bindings: display/msm: dp-controller: describe SAR2130P
      dt-bindings: display/msm: dsi-controller-main: describe SAR2130P
      dt-bindings: display/msm: dsi-phy-7nm: describe SAR2130P
      dt-bindings: display/msm: qcom,sc7280-dpu: describe SAR2130P
      dt-bindings: display/msm: Add Qualcomm SAR2130P
      drm/msm/mdss: add SAR2130P device configuration
      drm/msm/dsi/phy: add configuration for SAR2130P
      drm/msm/dpu: add catalog entry for SAR2130P
      iommu/arm-smmu-qcom: Add SAR2130P MDSS compatible
      arm64: dts: qcom: sar2130p: add display nodes

 .../bindings/display/msm/dp-controller.yaml        |   1 +
 .../bindings/display/msm/dsi-controller-main.yaml  |   2 +
 .../bindings/display/msm/dsi-phy-7nm.yaml          |   1 +
 .../bindings/display/msm/qcom,sar2130p-mdss.yaml   | 439 +++++++++++++++++++++
 .../bindings/display/msm/qcom,sc7280-dpu.yaml      |   1 +
 arch/arm64/boot/dts/qcom/sar2130p.dtsi             | 395 ++++++++++++++++++
 .../drm/msm/disp/dpu1/catalog/dpu_9_1_sar2130p.h   | 434 ++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   2 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |  23 ++
 drivers/gpu/drm/msm/msm_mdss.c                     |  11 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   1 +
 15 files changed, 1314 insertions(+), 1 deletion(-)
---
base-commit: 2bdde620f7f2bff2ff1cb7dc166859eaa0c78a7c
change-id: 20250308-sar2130p-display-b0601fcfeb30

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


