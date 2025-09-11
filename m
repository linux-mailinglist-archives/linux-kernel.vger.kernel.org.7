Return-Path: <linux-kernel+bounces-812325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE448B53650
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61BE1884B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94159343202;
	Thu, 11 Sep 2025 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vbwgb9Td"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1926733EB06
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602244; cv=none; b=EjDbOllXbsc61puBMaq8fmEETaXBGe9+uf7Nv/sKEwGf3PdhGb+nf1zmuZQZ+C2jLRrLR7vFEe9LG4O7Y61ppS1jB2onp/MbdM0TKZKItMmt8mBRmQR+sYPL1iAyRO8wcyWK7cQ6P0pvVN7jMAhsAARbbAYE2iN+XKT5P95Y3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602244; c=relaxed/simple;
	bh=PxQ+Nl+6gXCfV0SnVCZ6IaDcnEi2VND1S9/H0brbNM8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oQD8QFdCEcILubyZc6Z8glDF32OL/JIjQy8yi0/7lHNmr08abCHxZ2HRT2X7Ki0UX9qv/LnKUhxl5bLdxSsfkhrxBF4BbPg3vbrH90KbKbxURy5FVR7ESnfVSbAOplGO3DlGHntuGFpuZDlzwOndTaV9UfluLX2kCxcq2eXQDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vbwgb9Td; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BAxSZa008167
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/xEH5bhCDH+EambDfpLJYH
	Y3ZvSSk+a6Bg2AG4xJvXg=; b=Vbwgb9TdPNDtgBEwlILTgizCBFoyQZMLbK8YNT
	aZskG1U1ETHPXOu5q3lbmVNLrhyY1HhHUXLgzwzSUaLXz9ZnNEb58fJmxlEGKTau
	6ItEWpHsKyug6iIIofMBYq4oM9/2OV9o94Vuw5OwQ0O2olDLx8vYMbTZl/5uAmWN
	7Y+xA8zGXUAg0Lky8fnEbRyGA12WxEVjL6mmpd0EAKIIrBJrcU+A+qJPkN7zpuV2
	QQVQoFgk1EZbufMY66eoUb0e5549UliLC8+CYywpd0Cgc2mDvxZhGOqwSsiN7EEA
	yaxi4ZAEksYoqUrSiFC4eSjMUJWaSEko9YJMzVfDTDH7Iz6Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapre7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:50:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-329df266fe2so221235a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757602240; x=1758207040;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xEH5bhCDH+EambDfpLJYHY3ZvSSk+a6Bg2AG4xJvXg=;
        b=HR+ZZ17fZ1Hax57jtPHklv5rr5vvY3yok/HT/EJ5nX0IaXF44Qt7LRzKiWMFpB7r32
         he/tKbSj97gKAk3I7+bTVb5MDTlvimFsJgVRlOE2Dx8Vl2hD9RuWRYLzmvAXcJvfoKu1
         X2LsXD+3RxsqtV5jPkpJCa349mTsGqvU2O+9SqyAXNOwlQ1ffwhAjqLl0KF4tj/VwEA3
         dl8cgZYtH2s6AcjiUIVNlucORhuLK4dco0xsbMb5ioyiecX51MOjmi6gK2MfHbRBN2Pu
         Hp+55sH9vRpf/Ta4jBmZ+gcGvjKARomQRredreK9klk/737kbuqSv0Gud3hEfjLak828
         +j6g==
X-Forwarded-Encrypted: i=1; AJvYcCWoTx+tjoeU5/riZ5H0v79LmI1tbjMN9x00/UyzN1CD+vtaZBejRDuxEhs0lcYz3vSijsREhKGrnoZn/aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeE8cgyzAwes3AQ/Uf8AYJf/ts6o+DTKSooWRO3SVvTukLiUna
	B+2ir60pL7TMphLX5auqpaRY3ouJ7ydP/mRwHcWcU82/zq10cNAcVeZTSkjIUzC/wo8/B0UDeF7
	EKG2wqzDicrOUu93KEj1bGczVq5BXHf6Mm7f/oFb64/ZiynR71EpxTrvl1hSv5F7IWkw=
X-Gm-Gg: ASbGncu54TTTdZJM7jmIPV7+JxMU5XRTX9pESrFyjCnjXuN6by36ICswLi6jZv+6rxC
	L/0ebpu54xr0O4LoXylyh/Wyyxq9jmjg8lougApoTUmU7qp/ugcBXYq9v8EkrYGVD8bIsd2+BTK
	mBo2vcQ4lJIEmT8bacXY0u8BmHl0QQJZY3AWc5RbH4AmbjuVq+1CftqJDBOyNI1iUE/tYzQ/nC/
	d9t+DjsexXe6WaxoX1zN/2xBxDQJYpLtZliclZh/wCMEjtnll6SryrMSuWGO0vqDIaAFuQcpRoR
	h1gOWC4YG8L53kcuZ/TABdT1p3PmtQRgkuHluYS8yufFvx7b/UExh1VnYwVECKRqd2G0w8Fq210
	jimfbgSGUMceE57ArQyVCgPnSgArT7WM+0dMQJl5hUkyaUs0krLa/i3jS
X-Received: by 2002:a17:90b:33d0:b0:32a:8b55:5b82 with SMTP id 98e67ed59e1d1-32d43e11bcemr12961243a91.0.1757602240229;
        Thu, 11 Sep 2025 07:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiDHS8WTe48sZ+5y9L/B0ypbKllzVCvSYx+GkBixPPnAxR1xtVluwi00iOjWP7C4GYyo7pqA==
X-Received: by 2002:a17:90b:33d0:b0:32a:8b55:5b82 with SMTP id 98e67ed59e1d1-32d43e11bcemr12961197a91.0.1757602239708;
        Thu, 11 Sep 2025 07:50:39 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd6307590sm2934648a91.16.2025.09.11.07.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 07:50:39 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Subject: [PATCH v4 00/13] (no cover subject)
Date: Thu, 11 Sep 2025 22:46:07 +0800
Message-Id: <20250911-add-displayport-support-for-qcs615-platform-v4-0-177348170c2d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALHgwmgC/5XOTW6DMBAF4KtEXteRZ2wK7ir3qLIw/mksBQw2o
 EQRd++AVGXTDavRm5HeNy9WfI6+sK/Ti2W/xBJTT0F9nJi9mf7H8+goMxRYCQ3AjXPcxTLczXN
 IeeJlHvYZUuajLZ9QcbpNFDuOQdTosTUoNaPGIfsQH7v2faV8i2VK+bnjC2zbzVEAqA85C3DBh
 TZKysZp6cNlnKONvT3b1LFNWvCvvaKX8Fg7UrvCVglZQw2huaRSzuNs7tTevQn5JhoUxwhJBL3
 fOqy8ldr+Q6zr+gsijr6+rgEAAA==
X-Change-ID: 20250911-add-displayport-support-for-qcs615-platform-2f072e2ba239
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757602231; l=4013;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=PxQ+Nl+6gXCfV0SnVCZ6IaDcnEi2VND1S9/H0brbNM8=;
 b=ASVtpO3j3ss865EQa+slC1BIbpK4AuajgD50RsGYQ2UDxDcHtA5P/cICIkaBsEeXjJ2v15if3
 NeNejHOckv9DEB7lLy4re35wi+qcLTngu1WPzMW2V7v/JDgrFgx35Tf
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c2e1c1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=NhqbsNcZucgFEQMbMWwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5ywpCX6obcB3Bixqe_cdKUEuJmPSHkAo
X-Proofpoint-ORIG-GUID: 5ywpCX6obcB3Bixqe_cdKUEuJmPSHkAo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX5S2rSZ9HnojM
 VCnEiMeHqqc+KA9ynsfbgSDzCQHAH3RMQfeQlTzbm8H7madsjUNIDa/n5tWg8WBdIIK8VxKOdK1
 d//Xk/2wZnoKP/CI7GQR/rRXAR8TC0iFu+RGHl4HCl2VDRwPmyQauL6mfPup+zKwrI53JczKMkk
 uUUQ6JJv0VDh/dNeh+0R5oaeyQuaADbY9nlnSIZjLQczaWqPoKci067nEdN4UMKZs8x1bCpjSnU
 fhsBAhTIo/OIazIGDbz1wxX2DJrmvMrB35jU9LYQpTRkLzSmb++rV10WRc+XVkgWHkCMnvLIANy
 xt+4YiGDLdD/RYdU6hInQAA1rzYex8dj2LMw2QxVo+u9bugZKw3nZis2NbUj9mrjAtVdhLzOAZf
 9ESxPO75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

This series aims to extend the USB-C PHY to support DP mode and enable
DisplayPort on the Qualcomm QCS615 platform.

The devicetree modification for DisplayPort on QCS615 will be provided
in a future patch.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
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
Xiangxu Yin (13):
      dt-bindings: phy: Add QMP USB3+DP PHY for QCS615
      phy: qcom: qmp-usbc: Rename USB-specific ops to prepare for DP support
      phy: qcom: qmp-usbc: Add DP-related fields for USB/DP switchable PHY
      phy: qcom: qmp-usbc: Add QCS615 DP PHY configuration and init data
      phy: qcom: qmp-usbc: Add regulator init_load support
      phy: qcom: qmp-usbc: Move reset config into PHY cfg
      phy: qcom: qmp-usbc: Add DP PHY configuration support for QCS615
      phy: qcom: qmp-usbc: Add USB/DP switchable PHY clk register
      phy: qcom: qmp-usbc: Add TCSR parsing and PHY mode setting
      phy: qcom: qmp-usbc: Add DP PHY ops for USB/DP switchable Type-C PHYs
      phy: qcom: qmp-usbc: Add USB/DP mutex handling
      drm/msm/dp: move link-specific parsing from dp_panel to dp_link
      drm/msm/dp: Add support for lane mapping configuration

 .../bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml   |  111 ++
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |   10 +-
 drivers/gpu/drm/msm/dp/dp_link.c                   |   71 ++
 drivers/gpu/drm/msm/dp/dp_link.h                   |    5 +
 drivers/gpu/drm/msm/dp/dp_panel.c                  |   78 +-
 drivers/gpu/drm/msm/dp/dp_panel.h                  |    3 -
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h      |   21 +
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c           | 1089 +++++++++++++++++---
 8 files changed, 1192 insertions(+), 196 deletions(-)
---
base-commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
change-id: 20250911-add-displayport-support-for-qcs615-platform-2f072e2ba239

Best regards,
-- 
Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>


