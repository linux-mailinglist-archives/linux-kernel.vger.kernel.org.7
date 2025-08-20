Return-Path: <linux-kernel+bounces-777376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D269B2D884
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 084117BF8D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9C2251793;
	Wed, 20 Aug 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lS6/+gLg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6B235C1E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682534; cv=none; b=DnISBjUXZKBVGhOtkEKa/NbCmbP8fs92GUGjcLq9PNR2vMkTCu65ho/LpPM8qrrrGoFvG0CoCggs58xqiFd03MZY5X3W0Mq0hFpzQMx09V1jsZJxs3TviURXRsitKVnPF0wTsT3eCeAbNA1c7nbJOWSAdsStc+1CshzipeEQyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682534; c=relaxed/simple;
	bh=zUh1szy7KTdYK9/oS/fJJKLcM6Fi75L1xDm/pFLliWg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NQRWIJSAzJ4gHo9ehN+m2A2QOQ9pv18HiWJxr4T+njcdvF01V2MhI91gpl4th5JISLabNbAYdcBXDtCTnvC+WVZ4Y4dNIqVp3/lsA8caSHSO4nRh2bsUZxlD249n8RGtzE2LYQMZGrti7LsHY/U2POL/ljgdMWTmsQrYrnHjKj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lS6/+gLg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1od3Q010064
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=I4X0zxCuPGuD7zZ5V2a6EO
	SgLaDvK+Bop09VatFyBrA=; b=lS6/+gLgKeyBONPR4Zcli+rJT16dHjVlH93RQW
	NE449wKkmlPBpuvLhRsmQDFm9YulVqZiSkpQRSZqN8eivfTlrXIh9tXJbY6Uw20U
	0sy1devP6IWJTKm6Fkrb1bnpztWFNW7sBwhsDReWAkELMv/qanhTlVxZQNnYNU5d
	bLO4wbf0DUhgOkb5KXcr9hI4gvtv6dj8VVknzSd4KyXQ7E0I0vQFyzhZfvHnMBjC
	6ONksFoxNe32bPNawrRgj7EqZiRHH0vPQtnfu1hghKnDQTAjSwhNzPtdBqpIGyps
	hjLzDMwYf3KPEdblHBKT4UHrUofJxK+KlhoTrB2/5PogsqdQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52bh7ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:35:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-323266b2342so2322194a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682531; x=1756287331;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4X0zxCuPGuD7zZ5V2a6EOSgLaDvK+Bop09VatFyBrA=;
        b=csPtim9g7MvdXbrc9KIcSueqVyIqJY49neTOSvD+xxG52Wy9P9JTKXYZjkqgMNvOyc
         rGPKwCFo3kkWo8EVaWWhkhz+7dp+eHO9/RnjwFfxHpE4Lxq38UuTRiQfS654ZMEdjrr1
         VMQKsu6bp1Hs3K/HAwFY1vnyAUh8lTmcYOYj/I+0+cGD4uls6ghc3LyDka+sSl1axXUU
         Y5xd9c0pPcD0M+LdBIjG9Cu+OeYqS51EeU8lJOQk1zpJO72Id9COrCfaoiDUhItvSdyq
         rkPbJ7BlDb1mcxz/U/Jzd4hHCcq3Ao6djnHXoEiF/kcQ8YnOkZHqGrx1JYnV4A8fYzy3
         Uiuw==
X-Forwarded-Encrypted: i=1; AJvYcCUUvfSO03WsZU68XTKdWn2x5E8qnwxFGEirSyclU4By3054ElHpGIbILR9V/UCEfZGBvAov+TJw26yFx2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YysJYZONRJzYfVkFQ1G+mnkneONns57QELql5+kVG1pCIuhkF5W
	XUvU6tNSTQCD0Aq6Qk0f3AVGSJCaQHmhaHw+ipCRjaVV+3ZlF1DbvCThibPULF/lCOsWo4vuaJl
	2MzxtP4hZKxP5iM8MdRv7COW0VdShTfSw/GXPw0GeKIvPYaBXLiruYUzeLlVTrsvfT3A=
X-Gm-Gg: ASbGncsd4QyaS7+z4n0kzPVCwgL9p4i2oKKognkPnSEwnSEaKtPbL8B0cyMZtLKQWGb
	RlL4Gtd+RVfN5t7Krw0TmlBp0433LJcyWwLW1K9dIYO6uxq/JvHz2AkvoVWRzQsXUwRt1sldUbo
	7PpoLjD7c9h7gWSPx/UP1YcSqlBtBWoC3h/dmeH6eXsUvzGalwZYORaUlVcYXRe3geFsvhcXqMb
	JF3ENy4AqE4map3tG8hh5U8xXICRFy86NblR1mIegngtXO/xgSYBDQPDp1ApnfuvKS30R3ExZXp
	ITVr/No3haS4ZYTyqcSznYroer4YcY+OQw3nYwsKglxRi+hnYcp6KYEgrobqsTzoCIb+rfv55tR
	47dPpmIb7PSUCQlAZ33tSceznYVbPVx/ZEK7m3Impi+CcY/nC7naWgKJB
X-Received: by 2002:a17:902:d509:b0:240:58a7:892f with SMTP id d9443c01a7336-245ef16f680mr14993005ad.5.1755682530543;
        Wed, 20 Aug 2025 02:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr0NVkQfXcCIKCjD1fxDIFyfCk8rIWZqpRUI9U3M16bnnc9L9TWNuM7EAKKRr45/Jvuk5CLg==
X-Received: by 2002:a17:902:d509:b0:240:58a7:892f with SMTP id d9443c01a7336-245ef16f680mr14992845ad.5.1755682530073;
        Wed, 20 Aug 2025 02:35:30 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ec100sm20954305ad.116.2025.08.20.02.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:35:29 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Subject: [PATCH v3 00/14] Add DisplayPort support for QCS615 platform
Date: Wed, 20 Aug 2025 17:34:42 +0800
Message-Id: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALSWpWgC/5WNQW6DMBBFrxJ53YnGY1Mgq9yj6sK1h2akgMEG1
 Cji7jVUPUBWozdfeu+pMifhrC6np0q8SpY4FDBvJ+VvbvhmkFBYEVKFDSG4ECBIHu/uMcY0Q17
 G43YxweTzu66gbHPBHpq2YusY2WhUxTgm7uTnqH18Fr5JnmN6HPFV79+9Y7Wm9qXOqgEBW2eNa
 UJruLtOi3gZ/NnHXu2llf7tFdZEr9mp2C19WTS1rnXXXGPO52lx92Lv/xLbtv0CyWq1b0sBAAA
 =
X-Change-ID: 20250820-add-displayport-support-for-qcs615-platform-895e4ae0e310
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
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
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        quic_lliu6@quicinc.com, Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755682519; l=3563;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=zUh1szy7KTdYK9/oS/fJJKLcM6Fi75L1xDm/pFLliWg=;
 b=DBrrepe3Z1uwwfZQewXsSbAeEsU3FWGv8qkYIgvmhcN27WRoGUvuRKh5M1LpGMgpJVcNg4gR0
 IdMokpxlMG7DDeENu/ectt/wC6NDmrjE59IITa4sfdSnlcHUGo1+8Ck
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX7FBGmt1C/sRc
 r0GlSny9He5bgvvACuSrK3+VKfYFtQW1G0eZtAI1IVUsjh/7feA3cdxAXCk1aRx0nUDDcdBxG/e
 ucL2l5PpU0XRLxhYUqBuE4Fuq6o8FpFTZIPugm5i28/HckhFDMc2/YIKv69FLX76W9i2iKobNMF
 QEmK0h/RKoi1ozfnOCwc7sx37SzQDup7zapsr9TofctCIJ2A4IEEmGK87uKHXMsQ+XUR6TUb/xa
 LpB1pcLrGUEX2xa1F23xEApIso+0GG7fZ/yMluIJtZxOtD99KzvKUSieTVWg8TKdPy7XklyN8Mo
 68rnWf/slN1nsazSDC9IaCUmOdQmMlEQd7NKA8Aln4vU4rwuYPhORrVTf0rzeW7eQwEJbQ6ETDq
 iBQZsQMsX6UnI8bStVz+90LQO6Satg==
X-Authority-Analysis: v=2.4 cv=cr3CU14i c=1 sm=1 tr=0 ts=68a596e3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=ROZvIIAdAcjLDz1xLgoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: AOCEE_Bgp67x1ESPU7wBBZR8i0J3u819
X-Proofpoint-ORIG-GUID: AOCEE_Bgp67x1ESPU7wBBZR8i0J3u819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

This series aims to extend the USB-C PHY to support DP mode and enable
DisplayPort on the Qualcomm QCS615 platform.

The devicetree modification for DisplayPort on QCS615 will be provided
in a future patch.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
Changes in v3:

- Renamed qcom,qcs615-qmp-dp-phy.yaml in v2 to qcom,qcs615-qmp-dp-phy.yaml in v3 for QCS615 USB3+DP PHY.
- Updated patch [v3,02/14] to revise binding title, description, and property order. [Krzysztof]
- Updated commit messages in patch [v3,01/14] and [v3,13/14] to reflect the DTSI rename and clarify compatibility. [Krzysztof]
- Added USB3+DP mode implementation in patches [v3,003–012], organized in logical chunks. [Dmitry]
- Dropped patch [v2,03/13] to maintain full backward compatibility with USBC.
- Link to v2: https://lore.kernel.org/all/20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com/

Changes in v2:

- Add new binding qcom,qcs615-qmp-dp-phy.yaml for QCS615 standalone DP
- Split DP PHY driver into patches 4-11 by logical chunks [Dmitry]
- Update DP PHY configuration flow to align with QMP Combo PHY implementation [Dmitry]
- Update all hex values to lowercase [Dmitry]
- Remove redundant comments in DP PHY driver [Krzysztof]
- Remove invalid USBC type define [Dmitry]
- Move lane_map, max_dp_lanes, max_dp_link_rate parsing logic to dp_link [Dmitry]
- Add TCSR-based mutex logic for DP and USB PHY coexistence [Dmitry]
- Drop patches 6–8 and remove related binding properties as rejected upstream
- Link to v1: https://lore.kernel.org/all/20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com/

---
Xiangxu Yin (14):
      dt-bindings: display/msm: dp-controller: Add sm6150
      dt-bindings: phy: Add QMP USB3+DP PHY for QCS615
      phy: qcom: qmp-usbc: Rename USB-specific ops to prepare for DP support
      phy: qcom: qmp-usbc: Add USBC PHY type enum
      phy: qcom: qmp-usbc: Add DP-related fields for USB/DP switchable PHY
      phy: qcom: qmp-usbc: Add QCS615 DP PHY configuration and init data
      phy: qcom: qmp-usbc: Move reset and regulator config into PHY cfg
      phy: qcom: qmp-usbc: Add DP PHY configuration support for QCS615
      phy: qcom: qmp-usbc: Add DP PHY ops for USB/DP switchable Type-C PHYs
      phy: qcom: qmp-usbc: Add TCSR parsing and USB/DP mode mutex handling
      phy: qcom: qmp-usbc: Finalize USB/DP switchable PHY support
      phy: qcom: qmp-usbc: Add QCS615 DP PHY compatible
      drm/msm/dp: Add DisplayPort support for sm6150
      drm/msm/dp: Add support for lane mapping configuration

 .../bindings/display/msm/dp-controller.yaml        |    1 +
 .../bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml   |  108 ++
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |   10 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |    1 +
 drivers/gpu/drm/msm/dp/dp_link.c                   |   71 ++
 drivers/gpu/drm/msm/dp/dp_link.h                   |    5 +
 drivers/gpu/drm/msm/dp/dp_panel.c                  |   78 +-
 drivers/gpu/drm/msm/dp/dp_panel.h                  |    3 -
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h         |    1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c           | 1165 +++++++++++++++++---
 10 files changed, 1234 insertions(+), 209 deletions(-)
---
base-commit: 958469723b0df2a5efa229f9c4464c8962c35baf
change-id: 20250820-add-displayport-support-for-qcs615-platform-895e4ae0e310

Best regards,
-- 
Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>


