Return-Path: <linux-kernel+bounces-740318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77ACB0D2CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22463B6462
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E21288C8F;
	Tue, 22 Jul 2025 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p2gTVgHJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CEC2882C6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168949; cv=none; b=n0hE7/jFKpiBOQdGSj6spp6zaI2PypLljHYvwcRdD+kpjOji2AAFct8wZgN6v9n82C0Cgfa2muoCZBqBdstuZohfn4nbaj4YuTW2sDtfO7n5roCjnp8RsXl2ylcik9xf45UjjvkjdOsFE6u/Rm8qGFzaWESO/ZxWULK0s3du9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168949; c=relaxed/simple;
	bh=j6byM6mQFWNoIMiAy5TxrSVRDC8viNz/BdGaO3ECzk0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mPn+fIsX0xO4bVoQx2nRNF9ScUgZdl3jlzQcS1Dk7IE0TYpR58TBksClvgv9VYrhKwgOvjtSbrCy3slE5x/Z8HZG/waKKolsq/G8u31FbOo0OhKJWUZDzFa/jJoZGyOfg12mn1EHmeSSZ+uufNgmE49ulE8Fumeli4dEePXTXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p2gTVgHJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M3jZsx000919
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gpJoZHcyQpYbDfacgmuG1Z
	OCeDG5rolbgOKq0QUy07I=; b=p2gTVgHJXRjDWGfJx3RwFXI6wF4ThOqD69ykb3
	me0obnJUeqo29BRQ4nWhkcBV4lbPuCq6MXqvsWdc2iWf5a3GYUi2YhS03gsf9sbw
	j0pp4i8tlB+EX2pzfsmPuV40ocy/fIO4dZ8rMktttwZE0nHnDBSqt3cUsyw3KQj4
	nMDr9RTgN0AB7zQYAwiGBWXzlAXQUzH0yjstEzNR3Cd5F+4mhD0lZanfqmZoguIt
	9HQJprslWeu0UNFCNsbB375icZMo4/xNW4ROdBQ5bhHf6C10iSCkw3rO1yRUuW9Y
	cm6QodoQFht2qPcXER2SqS120CYLG/VZpBtIqmVqBkNGc8+g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dgccv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:22:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c0c961cso1553262a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753168945; x=1753773745;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpJoZHcyQpYbDfacgmuG1ZOCeDG5rolbgOKq0QUy07I=;
        b=OWDJFT5uUXI9yprDvP56QphhhcXD/1V+Qq6fHxRPS1S6dqEru7NEyT2QsKXIPzxHtD
         PkbqPYwwniuZIE+Pga8gJoOLGQbqavaKGjIMBZPjebCNQ0elC+YpJNThisxfy0kadWIw
         07d75nNEdL8yBvftvVXYwAtMslQkXhSSxtQFG+SCuHIdtqZdOiunZuChnz7yqBy4tRRA
         +8iFvMUPpHEVx6cboyjE6gLIpOykN2wJGBUYKcOAtvzObYyS+DFmZ+hB87+KmIlKjMR8
         hdzguHNwIdD4kmSk7+QT2YL7oeMsbkdytSZPCkQixUJU51EbCZZ3qxJHkG8OK0DZrzcX
         ztbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTO+joXLb1q3FuxttIvw+OFRxehocUq/zzaZunlFSIX18tKAgJMyLr/gks4B22p4scBNtZmNYAmRm547k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4E7lYwhCp8n2qQf4Hor+Up9/FoTeshYF80ghAjlkmUXDZYTLB
	LN5DLOqYcJAsyJh2KB62sqb37/auRv/IwMU7cC0SG6O2SxwbKTi+HD4nf/Hgx0iGDo47TI0V3oQ
	TvY3GdS5eLVlQSCkRBDq/Pv9UvGM+O385V50niyHJrKJKdb++sI7pTL/3XWXlqVgE1bU=
X-Gm-Gg: ASbGnctlnZA0xAc4T9VSnWbWZVww/JypHeAuFbjEZUztSIg/0VefAZI6vwCNSQvC6Wf
	bXuilWRHZaXJEx+kOmQrD62HuKF3pYOTtUQt8eupvNz429CdhTvj+bgUi4Cu7RjE8MbVRjNen1Y
	ErOrEOsH1SXNVul8q2j6yVdvhU7zGJmpEDOqzaezve+uHu8E9LwaTC/eriIL573EpBjR3/sty4W
	EKcmwxju932RCLeVDO2MYnUEuoNQgMvYcJUBdenLSJCKbYMgny2OKOpTLzCwYY74g9LYW0Pulz/
	JK5rwqlQ14tZmoEmwgcuj4cTRF+v226nmDO1Bj+9NnBnqAvvkl4TKn1ggidGcK49ZDqXu/Ogy8D
	ZhkRLGhsajGrkhJr0JZiV/UQflqZ7H2Eysy2MQAqYdmhQllvfndLx/Sh7
X-Received: by 2002:a17:90b:3f8d:b0:311:c939:c842 with SMTP id 98e67ed59e1d1-31c9e7a4012mr13684952a91.7.1753168945515;
        Tue, 22 Jul 2025 00:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNu5XNjC9N7LggT70nJqL7zjLR3AcsqyEnguxqP02Q/pBp2syZy3iYCoyam6QqSrFIAmJ8aA==
X-Received: by 2002:a17:90b:3f8d:b0:311:c939:c842 with SMTP id 98e67ed59e1d1-31c9e7a4012mr13684928a91.7.1753168944987;
        Tue, 22 Jul 2025 00:22:24 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e45e6csm7490753a91.3.2025.07.22.00.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:22:24 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Subject: [PATCH v2 00/13] Add DisplayPort support for QCS615 platform
Date: Tue, 22 Jul 2025 15:22:01 +0800
Message-Id: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABo8f2gC/5WNQQ6CMBBFr0K6dkynUBFX3sOwIO0gkwgtLRAJ4
 e4WbuDq5/2f/LeJSIEpike2iUALR3ZDAnXJhOma4U3ANrFQUmlZKoTGWrAc/adZvQsTxNmf2bo
 Ao4k31JC2KWEP1mhDpJXCEkV69IFa/p62V5244zi5sJ7yBY/28BSIqvrLsyBIkFVT5PndVjm1z
 3Fmw4O5GteLet/3H8DNPcjoAAAA
X-Change-ID: 20250721-add-displayport-support-for-qcs615-platform-dc5cee522171
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
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        fange.zhang@oss.qualcomm.com, quic_lliu6@quicinc.com,
        quic_yongmou@quicinc.com, Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753168936; l=2923;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=j6byM6mQFWNoIMiAy5TxrSVRDC8viNz/BdGaO3ECzk0=;
 b=vnJictkXtk+9QtUeMBGykCyh1QwvmsfqkvGVQTYRgXCIilV2YYr+1MsDMAbpFqSfdeEXR6COw
 bhTEEt+S5EqBB/giQEMmWBmzrA0irPIoMjvRo+qICQxEQedfAsV+Squ
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687f3c32 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=KbB9N7STWnmORTLZSFQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 7-YtSUlB-_2a4PSOLNbRxDMuV3s8XNz0
X-Proofpoint-ORIG-GUID: 7-YtSUlB-_2a4PSOLNbRxDMuV3s8XNz0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA1OSBTYWx0ZWRfX9fm3W9P2EkhO
 ohz+pxb81yg8rupnzNZrOVfHgnqGNMcfuapdpKyZQ4vRepJco2q4lIGC3dJtFX1qqZgHFehl1Di
 1SbnXQwPtl1YgkwsCVLdxM7hI3mYQ5wTqdYAj+81QRQg6bomLSVMXkzqm83ZEv3ttoeSEZezD4X
 N/G3v+qak69ehqr03GaX9yGMhRnn7UhMo/BMvK/vp524ydkViZPiEM9QsUSdLw9e3brMV/dnTnb
 DAjJyHO3BPiz5oo6qqvMA4N1rNhblaGIm2mzvS/usXToZ7CW5EB8IbOetJa3lCxU6Z+U6bEgofP
 t4i5tsdITzc5c/iGDuhQrw9a8rhknVtHBm2/0bhvBaTaY34c0/+yXU+ULBsV9hvr12Pf2MTHZg1
 0dtrGSkkJn2e6FZoqA/JoJgQlWlvmfoXOgGv0/MCZm37gCEscInW07xEuTwVZN9bCs/3fdzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220059

This series aims to extend the USB-C PHY to support DP mode and enable
DisplayPort on the Qualcomm QCS615 platform.

The devicetree modification for DisplayPort on QCS615 will be provided
in a future patch.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
Changes in v2:

- Add new binding qcom,qcs615-qmp-dp-phy.yaml for QCS615 standalone DP [Krzysztof]
- Split DP PHY driver into patches 4-11 by logical chunks [Dmitry][Krzysztof]
- Update DP PHY configuration flow to align with QMP Combo PHY implementation [Dmitry]
- Update all hex values to lowercase [Dmitry]
- Remove redundant comments in DP PHY driver [Krzysztof]
- Remove invalid USBC type define [Dmitry]
- Move lane_map， max_dp_lanes， max_dp_link_rate parsing logic to dp_link [Dmitry]
- Add TCSR-based mutex logic for DP and USB PHY coexistence [Dmitry]
- Drop patches 6–8 and remove related binding properties as rejected upstream
- Link to v1:
  https://lore.kernel.org/all/20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com/
---

---
Xiangxu Yin (13):
      dt-bindings: display/msm: Document DP on QCS615
      dt-bindings: phy: Add binding for QCS615 standalone QMP DP PHY
      dt-bindings: phy: qcom,msm8998-qmp-usb3-phy: support dual TCSR registers
      phy: qcom: qmp-usbc: Rename USB structs and reorganize layout
      phy: qcom: qmp-usbc: Introduce PHY type enum for USB/DP support
      phy: qcom: qmp-usbc: Add DP PHY struct definitions
      phy: qcom: qmp-usbc: Add QCS615 DP PHY configuration and init data
      phy: qcom: qmp-usbc: Implement DP PHY bring-up flow for QCS615
      phy: qcom: qmp-usbc: Wire up DP PHY ops and flow for QCS615
      phy: qcom: qmp-usbc: Track PHYs for standalone DP/USB3.0 handling
      phy: qcom: qmp-usbc: Add QCS615 DP PHY compatible
      drm/msm/dp: Add DisplayPort support for QCS615
      drm/msm/dp: Add support for lane mapping configuration

 .../bindings/display/msm/dp-controller.yaml        |    1 +
 .../bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml    |   28 +-
 .../bindings/phy/qcom,qcs615-qmp-dp-phy.yaml       |  111 ++
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |   10 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |    1 +
 drivers/gpu/drm/msm/dp/dp_link.c                   |   71 +
 drivers/gpu/drm/msm/dp/dp_link.h                   |    5 +
 drivers/gpu/drm/msm/dp/dp_panel.c                  |   78 +-
 drivers/gpu/drm/msm/dp/dp_panel.h                  |    3 -
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h         |    1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c           | 1466 +++++++++++++++++---
 11 files changed, 1503 insertions(+), 272 deletions(-)
---
base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
change-id: 20250721-add-displayport-support-for-qcs615-platform-dc5cee522171

Best regards,
-- 
Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>


