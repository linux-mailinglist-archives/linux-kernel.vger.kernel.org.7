Return-Path: <linux-kernel+bounces-824693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29586B89E90
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E8A18953C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F3304BD7;
	Fri, 19 Sep 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="me6oXFWG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14D30DD33
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291915; cv=none; b=nohruZF5VIP80wgkQ9qdd84wjLMIN7xtgnI42FZ+no+Wm2CqEfUAyOJCWxULiEez8BanHccPd74eZboXJK1lvYWaVZtBPM9V7DJUQ+C8nnm5DB5taYiUO6usCUwYZtsK89cJ/7rw+BKD9MKhISbxG2aLRVrqjqeUR0HhvpAqKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291915; c=relaxed/simple;
	bh=S30Rr40MCfhpxcSOXP+kVSFgcA2a757QcO72sQKavRk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dd8WMsQm4JJR73E8acbGgqyo3fiuSx1GNJbE3Z+0df+cqzmpq10p1wWtHEg1qhot74ERS3hHH45YzFXKu+i+kHH0b8ok+qpW7xn1nKeD1lpiZ+zB5ALlCUO33w6oyivKMU2AS+nGBvF/8T24I+U/jAax5sllNANCOKEvf2nmJig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=me6oXFWG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J7FONI018269
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EB6v7KZSrWI/c+6Qaba39U
	ewy2fI4u99KGobQFxuaEU=; b=me6oXFWGBliTytVxG0Q4GsCAwyJGdN0oFrhEbU
	YZdelqfbCvAp3l9Hgzqq+v1IdfBXvD7AwumYdl9ArP6on0NQ/e7YWUrRvtf9CzLh
	isALTYAuTQhw51Hi8upnm23lQ2Mmp4woWm4KNEvB4pGlCQopjhBmkTj0/rMqdGKb
	N8JGwVay4nEq/0aXCcV83p74Dz9010tfR3G+97o5bsb2SXmkACbo0R+EP+mqXyCh
	8xh15ZsG/rBNHr9m8fhYMuz0pDM/xCKmov3BD6YMAPfb42FInx1qvH5X66lSiGjV
	f7IheVOMRgyBWFM+1BilcEZo+Vxo+lFCbLONlp4TW7L6NjAA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwjpff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-26b7fc4b7e3so1744135ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291904; x=1758896704;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EB6v7KZSrWI/c+6Qaba39Uewy2fI4u99KGobQFxuaEU=;
        b=DpFe0xoWblPOIJQOk6yAc7R4CHgK4o51Nxus5vBy6ZOUakUL7xviqTyg9mY/utC8cs
         4CyUkRZGkV4syBH176q+bDRADmKY1mwbMiF0qGH5QxnkHeN6F+9Y1S5je34OR1BIs7dW
         qUW1Ph1RMHqbQCeDGfkBswC4QAbJijuhpan8N/MMZQzzXNLyODyfbr7DnJBWjPfty+64
         Ha4rnNZJ2Fzif3WNyzp39mT8S+aJFRage3OCUdHC6stuaRd0CDia1GlB62VkAP/Yrl/u
         t1RFZoGuqalrOFrIvP2X/szWrswkee5ZSSf8D1T4vrDKaACLvyZle3dgqgS3kf5SUGmL
         JC2w==
X-Forwarded-Encrypted: i=1; AJvYcCWJFNGnM1c5HJKyroOJcPeTBPZECJlE0EEYh1a+1GGTACovDml3XdkxvMv+l4TJS/nqKUTlQBi0VEBQ2zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EL/DXbqXRAPemxDhfLH2r92I9YClO4j93zhRvrx3ByDg6QLF
	MfigXBe+kdOC1lk0Glt4BdXHrb10leFWBdXUMKG4XsT8Kghr0Cd/G7Uo3h6w7c8jq21btfdlfSr
	sMvnq0jHwTnVLKp8ldSmSKMO4RWjof9qYzR6q03OI+AZnVCnRuV2vn4R7Xnl5OAgSaGU=
X-Gm-Gg: ASbGncslGWgl8vFsoKsJcDLDzcd2QsEXCaq+v1Dl/hHaJVn07b/7XoASiD5wGpqJ1kP
	BPKN+1SzkcsIhWnO3ra3fzi3hcvbFDSRhiAurNlk5G+VHISoJXmvEfgT2cid9JGcGbhkyfLy/yi
	VDoyyN3Z0PnPit8h0MoZPsgsZOP7FVAuAipMPRIKAL0AWuRQ89cEOilPKQou7KEiO3fH9FLMZJv
	hrZujSnNPk9PHnS+jXU/q3Gk1JNB1bW5orPIbStY/J0yXGy/tfpWnPqaJHSej73q9rcIE5P2fo9
	WtNLqdzQ4tMl3QJOP8uutyBTPYtGfNl6rXB3z6DDCqF88lYTHpZbQSkzrF5jIzTd3D1wsFrKgSO
	5boA4r4FAxJh9wA==
X-Received: by 2002:a17:902:aa8d:b0:267:bd8d:1b6 with SMTP id d9443c01a7336-269ba501141mr19595785ad.6.1758291903667;
        Fri, 19 Sep 2025 07:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9e7VP28cdUwN8lzlWnixJ5Xu8UcAuFCb9OkPevjxScXEZSW3vj9TXeaqfK3V/6VPSATqm9w==
X-Received: by 2002:a17:902:aa8d:b0:267:bd8d:1b6 with SMTP id d9443c01a7336-269ba501141mr19595635ad.6.1758291902969;
        Fri, 19 Sep 2025 07:25:02 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e80409ee3sm2210035ad.80.2025.09.19.07.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:25:02 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Subject: [PATCH v5 00/14] Add DisplayPort support for QCS615 platform
Date: Fri, 19 Sep 2025 22:24:17 +0800
Message-Id: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJNnzWgC/5XOwY6DIBSF4VdpWA8N9wKDdNX3mMwCAackVRTUt
 Gl896LJxM3MwhU5kPwfL5J9Cj6Ty+lFkp9DDrErQ36ciL2Z7sfT4MomyFAyDZoa56gLub+bZx/
 TSPPUb2cTEx1s/gRJy9tYZkubqpJSq5pLxUkp9sk34bFpX99l30IeY3pu+Azr7eoIADzmzEAZZ
 doIziunuW+uwxRs6OzZxpas0oy/dckU4rE6lrrAWjCuQEFTXWPO52Ey91Jvd4LvRIXsGMELUb5
 fO5Tecm3/IcROaIBjhCgEKoa1cwaEd38Qy7K8AZPtxqERAgAA
X-Change-ID: 20250919-add-displayport-support-for-qcs615-platform-f885597b3573
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758291893; l=4929;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=S30Rr40MCfhpxcSOXP+kVSFgcA2a757QcO72sQKavRk=;
 b=TCHWCcb0lNmNKuXXj2ujNV6PVp4ZlA0gy/8bq7ojOvHtv5q7CDT9GARFHcr1iwWvPCLmOw55j
 MjlgRfy2gUBCZ0Xptlg2ECcA8eSfCRH90rUmALPX2i/QKTM1y3KPX6N
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cd67c9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=Y-Wlz9CHQrt7UwghuOUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+8aDyw8BXbV/
 l8Zzq4slHKWcpFk07ZUf0TdZiR9o9fhMaoM2n4JpMh10q4JbN86KDStWRamcbcaBicUw80Yt1M2
 KXu0kQjGVVJECRFVzPJrCm3ebLpdGdAmZ8+SfI3Z3u/N5LWfWArSUKd2LoecrA/cbiLl/jINFCv
 ItJP3gwrcrBaYYqOGn4qBA9IhDiF9ssQVAEBdeZIBz97CI9aTAHgPgamb7dOZKnWSW6/tQcjsbd
 ccPmX1UUyEg1QKhpeGMZ+hI7zuGMs+NxIJkhYBQlnv67T42dcDuy8Zix9nmwdnbFLr37OU5+2hl
 nDUxYJzqHrdMb89qM5Cv0KWT0qYvan71n1wxRfBQVNG6+BX2Esa08fT1STt0o0dRse/rqBGugJb
 +nFJ+agW
X-Proofpoint-GUID: WezNzgSv3smMX-uRQo8U9eNXQWKL0R4U
X-Proofpoint-ORIG-GUID: WezNzgSv3smMX-uRQo8U9eNXQWKL0R4U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

This series aims to extend the USB-C PHY to support DP mode and enable
DisplayPort on the Qualcomm QCS615 platform.

The devicetree modification for DisplayPort on QCS615 will be provided
in a future patch.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
Changes in v5:

- Add new patch to introduce QSERDES v2 COM/TXRX register headers.
- Restore legacy reset & clock register logic. [Dmitry]
- Update phy_xlate() to return ERR_PTR(-ENODEV) when dp_phy is NULL. [Dmitry]
- Rename helper from qmp_check_mutex_phy() to qmp_usbc_check_phy_status(). [Dmitry]
- Drop storing struct device *dev in dp_link as it is only used once. [Dmitry]
- Add robust lane mapping: default 1:1, complete partial configs. [Dmitry]
- Reorganize sub-patches v5[07/14， 08/14, 11/14， 12/14] as suggested.
- Link to v4: https://lore.kernel.org/all/20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com/

Changes in v4:

- Drop patch v3[01/14 & 13/14], will sutbmit new patchsets based mst dt binding series.
- Update maintainer of qcom,qcs615-qmp-usb3dp-phy.yaml to myself.
- Add missing aux and pipe clocks. [Dmitry]
- Drop second TCSR phandle; register offsets are described directly. [Dmitry]
- Add USBC PHY series related init_load_uA configs. [Dmitry]
- Drop v3[04/14] qmp_phy_usbc_type define and use dp_serdes offsets to confirm DP capability [Dmitry]
- Reorganize sub-patches as suggested.
- Link to v3: https://lore.kernel.org/all/20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com/

Changes in v3:

- Renamed qcom,qcs615-qmp-dp-phy.yaml in v2 to qcom,qcs615-qmp-dp-phy.yaml in v3 for QCS615 USB3+DP PHY.
- Updated patch v3[02/14] to revise binding title, description, and property order. [Krzysztof]
- Updated commit messages in patch v3[01/14] and [13/14] to reflect the DTSI rename and clarify compatibility. [Krzysztof]
- Added USB3+DP mode implementation in patches v3 [003–012], organized in logical chunks. [Dmitry]
- Dropped patch v2[03/13] to maintain full backward compatibility with USBC.
- Link to v2: https://lore.kernel.org/all/20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com/

Changes in v2:

- Add new binding qcom,qcs615-qmp-dp-phy.yaml for QCS615 standalone DP
- Split DP PHY driver into patches 4-11 by logical chunks [Dmitry]
- Update DP PHY configuration flow to align with QMP Combo PHY implementation [Dmitry]
- Update all hex values to lowercase [Dmitry]
- Remove redundant comments in DP PHY driver [Krzysztof]
- Remove invalid USBC type define [Dmitry]
- Move lane_map， max_dp_lanes， max_dp_link_rate parsing logic to dp_link [Dmitry]
- Add TCSR-based mutex logic for DP and USB PHY coexistence [Dmitry]
- Drop patches 6–8 and remove related binding properties as rejected upstream
- Link to v1: https://lore.kernel.org/all/20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com/

---
Xiangxu Yin (14):
      dt-bindings: phy: Add QMP USB3+DP PHY for QCS615
      phy: qcom: qmp-usbc: Rename USB-specific ops to prepare for DP support
      phy: qcom: qmp-usbc: Add DP-related fields for USB/DP switchable PHY
      phy: qcom: qmp-usbc: Add regulator init_load support
      phy: qcom: qmp-usbc: Move reset config into PHY cfg
      phy: qcom: qmp-usbc: Add USB/DP switchable PHY clk register
      phy: qcom: qmp-usbc: Move USB-only init to usb_power_on
      phy: qcom: qmp-usbc: Add TCSR parsing and PHY mode setting
      phy: qcom: qmp-usbc: Add DP PHY ops for USB/DP switchable Type-C PHYs
      phy: qcom: qmp-usbc: Add USB/DP exclude handling
      phy: qcom: qmp: Add DP v2 PHY register definitions
      phy: qcom: qmp-usbc: Add QCS615 USB/DP PHY config and DP mode support
      drm/msm/dp: move link-specific parsing from dp_panel to dp_link
      drm/msm/dp: Add support for lane mapping configuration

 .../bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml   |  111 ++
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |   10 +-
 drivers/gpu/drm/msm/dp/dp_link.c                   |  117 +++
 drivers/gpu/drm/msm/dp/dp_link.h                   |    5 +
 drivers/gpu/drm/msm/dp/dp_panel.c                  |   78 +-
 drivers/gpu/drm/msm/dp/dp_panel.h                  |    3 -
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h      |   21 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v2.h |  106 ++
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v2.h    |   68 ++
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c           | 1058 ++++++++++++++++++--
 drivers/phy/qualcomm/phy-qcom-qmp.h                |    3 +
 11 files changed, 1412 insertions(+), 168 deletions(-)
---
base-commit: 8f7f8b1b3f4c613dd886f53f768f82816b41eaa3
change-id: 20250919-add-displayport-support-for-qcs615-platform-f885597b3573

Best regards,
-- 
Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>


