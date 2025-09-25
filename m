Return-Path: <linux-kernel+bounces-831871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1090EB9DC0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289031B24BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941952E92B3;
	Thu, 25 Sep 2025 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VwrchYiQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390812E8DFF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783923; cv=none; b=T/MXqJBaNDu8JYox56qvFd3bHy2UELeEXVK3FBJ4n0H/7Lh/Vh50gOW2rRoGRdNC5nWddaaTObtYxRy3dlnBQE8oAn1gcBmRlvXMJffRbxbGcWTtugeQwCRWS3UKyDmF/kp+OtvQZVnU/mQriDWkghKPc8P/5viP1Mimi5dN4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783923; c=relaxed/simple;
	bh=BriQ9CGzQPqKZfWizw8gSbddYqDWtC7/j8W0uWp5qUM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Iczwud0FiJeOtZEBNd8RYsAr6Ctd5au1BJ8j+Zu6RWhoHpX02PUitqe/wgthMqj+SDUWaM8rlSBiwnaB+3O/Yf5r8TsXgrtXsSAjUqrbx+IlZkSorY7RJ5vYYxj/BgtYXQPQCn0m/ni78MXHZQPy7mQXau72hAZ95f3e6qJywXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VwrchYiQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1GdW3002789
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yZ+xuQsK8TPZF/qA5Y0n2S
	yswG9xNhbXSlZdrQ5xB8w=; b=VwrchYiQ2Zg1sNSe93WIcnYH+sM91lNdzFPPdp
	kVJxG7VeAfbzOmpWwaBRfJJMCwVJQnkUDPwDrdcOVIyw+dH7nC+Xh9BWQgrOPLr8
	YaxmzGJPqaQarDjClmIHCpR39JQT3y2+LnXBN6ZlCVy6t8LGPaoejdca/oeFeT7Z
	o+b4h5JTiflrMoFyb3ekJCCRQJX+YKJwEHs0HCMoaDD1UAhNsHMRPkEc24gsOCUw
	RQFZ9EMA2TUOfTzh+j+RlLJajTgqRUwOxFObJEKf6vwFE3rkbjXRA2ndPdbaotHl
	bYF1z71I9jNcT7jPrJ0TSyng3cre7Jl/nwzrs/IEksKKE/Zg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf1ns4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:05:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eadc2b473so198707a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758783919; x=1759388719;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZ+xuQsK8TPZF/qA5Y0n2SyswG9xNhbXSlZdrQ5xB8w=;
        b=cLawDbsoH/1dBLL0nBkd3jr5D6KwFJrR0QEAYIClv5/WQKM2punZqpoZ9JTnEiEXRA
         vHbNMPe2ZPUNkFEQ8PDgiAQ+KkuS7lvNGwV4mcAVA42Xd4WIo/aGB6PJTgDKICqEShEe
         YiwzSVGBW0ckGldg1rXxhSLJ8IKiHdjscqo3C9iQCR6796lCGMV+HyYXlitUBGlVlvk3
         0r5UO7cxKyRJFcRghvxrmLF8O8JAS3F/AkNSDRw9GkSV64HEzxe1iDqTL3f/srOzgBCU
         BsE4ymuHRgVIO4KKESnAsskg6CcpfDiakfzJBdpucaazoLyk4AsE62QnlmOxF1LirO/K
         D94Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX3FuxZeGcOvfunjgsOIO/2t4qvCHHyi4I/nUSD8oUpRDLrJ+OfdErNjOxMPg/ayLBU34hIjqoXDbCNQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSoG1Xtx2mt+fMTwKsza7eVWnjnDR0ZO/ibj/NlIxGtO1QpTS
	lekm1DO1sC6VPguDCbw6SiObmAUIh/jO6CqTalm815/DCI/lL/L5mCbexOMbwn93888Q9+XMhMq
	ibvz0qdPW9biYrp9AsRRW5Zrpa9nO1ZauPasxC57a2p+KjV/0nzKtbPKvKOx4p3Rx9BRhtumJcA
	4=
X-Gm-Gg: ASbGncvkWQ7bL7dwlGsAyeWlkZYngh6DlS4cRSUf1f/NH76RNUpR0otKzT8z9fFMn4P
	su0tkIczF+eGKeMQkJAfyn/MlRx3c7DEirrCeXRGlWeXDi05S5fl1NNfPHicrPrIe8DqKVamnju
	EqgJe0LxxEBsE682/kUFFCMlLNSEt/h4wF0ngYdV2JDsnW0DTAoa57YufaweLbIpZO4Xe3/yD58
	uA0Aw/QhaURnDRbx3iiqSEBbJHgSrk3vu/SLZusdjlJZ3i+GkCVOZjE5gOtwxM5XMwgHI09wBrb
	4XD3RDXoJbCao8koU55hOomtzBVdhbuRnwYwK0ZbeJ0+2nAuxl8p82vVu6purswfdw/xjg7PuDP
	c/8rExvmU5yosqd6PhdJpqd0wexU6rJTO/tF5SvVgGBfdKYPZqtJisak2
X-Received: by 2002:a17:90b:38c7:b0:32e:e18a:368d with SMTP id 98e67ed59e1d1-3342a332253mr1367427a91.8.1758783918959;
        Thu, 25 Sep 2025 00:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUbujVjnPE51nMK7rlaHLU2fKEdCZgVZSnTJAA3gW7yMsssg3WWsRWMJZqIVrdYskdNrhg0Q==
X-Received: by 2002:a17:90b:38c7:b0:32e:e18a:368d with SMTP id 98e67ed59e1d1-3342a332253mr1367391a91.8.1758783918444;
        Thu, 25 Sep 2025 00:05:18 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3342a2bd584sm914253a91.0.2025.09.25.00.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:05:18 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Subject: [PATCH v6 00/14] Add DisplayPort support for QCS615 platform
Date: Thu, 25 Sep 2025 15:04:46 +0800
Message-Id: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJDp1GgC/5XRTW7DIBAF4KtErEsEAxjoKveousD8NEhxsMG2G
 kW+e7Glyl00C6/QY6T3jTRPVHyOvqD30xNlP8cS072G5u2E7NXcvzyOrmYEBATRVGPjHHax9Df
 z6FMecZn67Q0p48GWhgpcZ2ONHQ5KCaFly4RkqDb22Yf4vWkfnzVfYxlTfmz4TNff1eGUwjFnp
 phgog1nTDnNfLgMU7Txbs82dWiVZvhtF0QCHGuH2s6h5YRJKmlQl1TKeZjMrbZ3O8F2QgE5RrB
 K1PVbB8Jbpu0Lgu+EpvQYwSsBkkDrnKHcuxeE+EscPIOohDe+aRQNnBD4h1iW5QcZmX2OdAIAA
 A==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758783908; l=5389;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=BriQ9CGzQPqKZfWizw8gSbddYqDWtC7/j8W0uWp5qUM=;
 b=/+juXQNfDmiteVOMuuSFk8BU/ejjFAKfyZOY1rODm2qSmgMfUlT38RitbEUoDhXbe9Ps5SJLU
 OYw0Oe6PmpoB7t0FStYiiPmDd6G9osrC8ci0mRdv00fXYvytnIJH4Q/
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-GUID: hpczEzNDuQPJr6x3W6_MM8ppymncDWpz
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d4e9b0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=-mfqEiHr7Cy1ujZptoQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX93tokzFGR7k9
 t9l9hPK5Z2EEa0cTxL73YRskjJFm4R3nFUx8tt1uWRulVy+HHs8DnKZBRp5GrDySykMUwFs4ZxP
 MhM5Bz02UZw6doXxpzYhldr5rQQxdUN9ikeSicQXBoop+v9JHK5PPhU1/gorXmLXxdqICeXr+jh
 LuzK6I2BfMkJLYrkK/HSqv90U5NijoDYFusBVoeIpvrEokMWZrOmE01llQdN8QmTwDpeTpS74jC
 Rksu7P0/SWn0bf8/pbZ4tnAvWw2sXtNN6G4dxv/mfCv/++c7zKmq9ilz8PFWEckEw7AjW8+CfG0
 8uGS52WO8lc9u301pjTSbJcceqJBHlX+7Ke3ual763Czjr+nqhJFXs0C8buARC93D9im9LTjNbg
 z8n8J4FM
X-Proofpoint-ORIG-GUID: hpczEzNDuQPJr6x3W6_MM8ppymncDWpz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

This series aims to extend the USB-C PHY to support DP mode and enable
DisplayPort on the Qualcomm QCS615 platform.

The devicetree modification for DisplayPort on QCS615 will be provided
in a future patch.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
Changes in v6:
- Move usb3dpphy_reset_l definition to the patch adding compatible and related config data. [Dmitry]
- Add NOTE about SW_PORTSELECT/orientation handling. [Dmitry]
- Use C99-style loop variable declaration in msm_dp_link_lane_map. [Rob]
- Update commit msg with issue description for [05/14, 06/14, 07/14，12/14].
- Link to v5: https://lore.kernel.org/r/20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com

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
      phy: qcom: qmp-usbc: add DP link and vco_div clocks for DP PHY
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
 drivers/gpu/drm/msm/dp/dp_link.c                   |  118 +++
 drivers/gpu/drm/msm/dp/dp_link.h                   |    5 +
 drivers/gpu/drm/msm/dp/dp_panel.c                  |   78 +-
 drivers/gpu/drm/msm/dp/dp_panel.h                  |    3 -
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h      |   21 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v2.h |  106 ++
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v2.h    |   68 ++
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c           | 1066 ++++++++++++++++++--
 drivers/phy/qualcomm/phy-qcom-qmp.h                |    3 +
 11 files changed, 1421 insertions(+), 168 deletions(-)
---
base-commit: b5a4da2c459f79a2c87c867398f1c0c315779781
change-id: 20250919-add-displayport-support-for-qcs615-platform-f885597b3573

Best regards,
-- 
Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>


