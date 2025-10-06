Return-Path: <linux-kernel+bounces-843527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14371BBFA83
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E41A84E26EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF7917C220;
	Mon,  6 Oct 2025 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DYS9EGDO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA402B9A7
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789211; cv=none; b=J9H6LABvWK9zaShWxEn7R8ju4GItDysGQjXwxcYaW8Wstp6Ld8gcYAaUY8ZtORHZ2g6IFOE3qVAQllGsIkaPJfSl4ofa16+E8Zq7jnj2qrdPgs+UIv5bU1EnZ2C8eoRdeslHO+A8jXR7Ek3dB+cYmaPU8CBjLJejuJHFq/pRLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789211; c=relaxed/simple;
	bh=jYbMkukNfUrVsrOi8oI9ZoTQ53vpsVBeUKRkto04Vyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p1S79N3I+6qXlTjg/k7rRW2uJBdVCSlPhQxSU//fZx0IOHLmhXZ+t+gVO2wvirD09GOUIuubIWgWtWOmZewohi5NzVN08kONUU3oAfuEajzy6/+sKbHWaFUSLw6KAohpPOpz+bO0nx+8AX10dkuvaLcn926KHngU11FCeoqqNps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DYS9EGDO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FP2qC025804
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 22:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=RGKF86TVDvAKv1fL1H0rAgmHc9LmQpxf1z8
	wB1amINA=; b=DYS9EGDOyjSCwLQjSssmFxKbQIh9+ybfQfPcqOrjrwn+/jVzKgP
	3p50a0MWkA5UDhy+24Woqz9K49yby4sm1uJ8xkh0UC1LjKa5PqpoywU2R3i6HKM5
	HuDKOicvCkDj7M36DOuBfKnoUxYV6jf9a5Tfk1ysf3gO/cS89taA1sSiXLM1rurq
	Y1ZJKE/uGP5HgB2EAmlLtyevh+BLl7+DC7u3E6vr/kdOIO+Ul7szYvTDhd4O69UZ
	Y9Rm+JGIBABOS2enF3KIZUVY7n75koOkPC2YoaLyvCvPYOZHzohb5LFZ+MlN9IoM
	fMimOQI5iFsccSGnTZTVMQw6LooSQybtrcw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mgd0h27c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:20:08 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78106e63bc9so5264604b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759789207; x=1760394007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGKF86TVDvAKv1fL1H0rAgmHc9LmQpxf1z8wB1amINA=;
        b=e3Kk1mgYyzTqAK2C+1nRrMisiM14JAXKIR/HEBgZETXmq6viv5lZ9NzYe7UZZdLN7V
         cRHsWH7MZX5/XTC4Gf4p79RkN7pJBiS0VssMo5LA1gOC5vtqvhu0dl6dtiNI0dAlB6Yz
         os++wghr3Nn0T8TTEfmsTqm4iJ0u9/Oz1fo2Z4Qlq0unv+e4J2zOPABecf/cX3Ek5VwD
         onLBIU/3nq9PBm1JasQiISjdBvUCyE4Y6gzmLNYdglrpbn0RTwnA0MJ09U3k1Ru8B4KW
         ylTf+T14dRL/npKlEUzlOwGjAE3MC3Pc+RO6OxPLVamb4yfADcU59C/M4E9fnbuFP66M
         TscA==
X-Forwarded-Encrypted: i=1; AJvYcCX3SGpS5tAQpKsrj+H18km+C0avlyDAKynMxGIitCZKEGRsIxhKGwhsPoUwIakwsGpH1ZYtXTpTy9to2oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypWCZkv2PRtxveJvKJ5/jnKIguaHMkfmvpE7bLiPvj9Z8m/4C4
	+xZzTyuKaN/UpGNvc+obWSm47fRo2P7xGZOk2ZLnKp8lLtDFDrl55dL3Oo9GOsIgglqbci7SLIM
	yUssDjZbTdkf1GbWNM0+jf+ZmEzw+Tet6X26c67JCfZJ1dM8ltm1TRdYHLtFYc2EbkSA=
X-Gm-Gg: ASbGncvLI+R3432FjF43fIuxK4dg1opAE8/WDlYI0tBaZsRImJ7LLcEZEMGcPFBKqNT
	MsyrFxDCraBCaI9h8RhOsJ0LbHQvwzdYW0P2TocyTAJKdM5hEQieNFhh2mooiMROcsNYRbT7vad
	CtqV6m6PwOnDFvwHlo7oAEAONxIpGUDIpwvY01lh6piLmPScfatHbajDGEnVCbhv5M6Qzv4mljf
	Mm8vLuRUNi/YxpzgvFS1fc+U5D5styHoV0sFJzPa8yYrb3ib2g8+iE8xjWNdzn6fBqZdcQGW60Z
	/TNtFLA6s6X0QJoMx1ePI7ZXgSz2iFtCxz3TFDgYhxG3T8aTxPYgyPCzRm21R3sPnFw+kvYzmq3
	8pAotpNEooMxvyEnPbpV1Tw==
X-Received: by 2002:a05:6a00:84a:b0:781:d21e:136f with SMTP id d2e1a72fcca58-78c98deac4cmr16335597b3a.26.1759789206897;
        Mon, 06 Oct 2025 15:20:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKfPsN6sUhqkQtc17HeV3fxUqq2CQHTosBe9Ogh+oYvS7dvTA1+fvWCJRnPz3xcYUrQk7a/g==
X-Received: by 2002:a05:6a00:84a:b0:781:d21e:136f with SMTP id d2e1a72fcca58-78c98deac4cmr16335560b3a.26.1759789206391;
        Mon, 06 Oct 2025 15:20:06 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb281bsm13734968b3a.37.2025.10.06.15.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 15:20:05 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v5 00/10] Introduce Glymur USB support
Date: Mon,  6 Oct 2025 15:19:52 -0700
Message-Id: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -2ZKGMCF-ALhqGTdFPejuibvD3rTZgGQ
X-Authority-Analysis: v=2.4 cv=T8aBjvKQ c=1 sm=1 tr=0 ts=68e44098 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=K6vXddHitPicjvNs8NYA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: -2ZKGMCF-ALhqGTdFPejuibvD3rTZgGQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMyBTYWx0ZWRfXylIB6uRcDvrm
 1jitH2YsboIzD9Un/MHmLxMrvRZ1mY2J2YWp9QE6qTOBz9IqtXBubSTET9bfvjU/Efney9X4ohd
 ggj2dbGxJindMlJQYzThxrEo+QLvt3C2QowuQU3uQ+ALE6IE15sLXmtxnukZHVxr0k0Fd4PoBCI
 OpZXQTcQl5YqzWf1GImnTFXArKSczOZhQBbfhxNJEurI8Q6G71gcnzyhDqZiimAUDQYDIWSijRo
 SR1fWYS+gaCjpA73PnFHe20wDXpCdvEMixGkl0HXJMyc01xQbHbf3oU4neLUEwfYa5bRCQ/8NwJ
 rkRodUcVxNlYz1Z9HduAAsSxqyWepy205HAWf7x3H0ANjApTSEtgGQN+BxMMJLVRDeVcr4KqCDR
 HkcQCJAsZeuJZCH+p1lvT0uJPHkp/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060123

This series enables the PHY level changes that are required to support
the type C based controllers and the multiport controller.  The typeC
ports utilize a usb43dp based QMP PHY for the SSUSB path, while using
the M31 eUSB2 PHY for the HSUSB path.  For the multiport controller,
it will utilize two QMP UNI PHYs for the SSUSB path, and two M31 eUSB2
PHYs for the HSUSB path.

-----
Changes in v5:
- Moved phy-qcom-qmp-usb43-pcs-v8.h into USB specific QMP driver
- Fixed DT bindings for clock properties for QMP combo PHY

Changes in v4:
- Updated DT bindings change for QMP combo PHY to have IF/THEN blocks
to handle the newly added clkref, and fixed the commit message as well
- Added a new header with v8 offsets for the PCS MISC register set,
and refgen current load for the QMP combo PHY driver
- RE-added the headers for the QMP combo PHY

Changes in v3:
- Fixed some incorrect patch ordering.
- Alphabetized Glymur QMP settings for combo and UNI setting arrays

Changes in v2:
- Updated QMP combo PHY to properly handle the refgen-supply and to
remove the primary core reference/tag
- Updated QMP UNI PHY to properly handle the refgen-supply and added
a separate IF/THEN block to handle the new clkref
- Updated M31 eUSB2 to make clocks and clocks-name required for sm8750
and optional for Glymur
- Fixed missing PCS MISC table
- Added SMB2370 repeater changes

Wesley Cheng (10):
  dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Add Glymur compatible
  dt-bindings: phy: qcom,qmp-usb: Add Glymur USB UNI PHY compatible
  dt-bindings: phy: qcom-m31-eusb2: Add Glymur compatible
  dt-bindings: usb: qcom,snps-dwc3: Add Glymur compatible
  dt-bindings: phy: qcom,snps-eusb2-repeater: Add SMB2370 compatible
  phy: qualcomm: Update the QMP clamp register for V6
  phy: qualcomm: qmp-combo: Update QMP PHY with Glymur settings
  phy: qualcomm: qmp-usb: Add support for Glymur USB UNI PHY
  phy: qualcomm: m31-eusb2: Make clkref an optional resource
  phy: qualcomm: eusb2-repeater: Add SMB2370 eUSB2 repeater support

 .../bindings/phy/qcom,m31-eusb2-phy.yaml      |  21 +-
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |  35 +
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    |  72 +-
 .../phy/qcom,snps-eusb2-repeater.yaml         |   1 +
 .../bindings/usb/qcom,snps-dwc3.yaml          |  26 +
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    |  18 +
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c     |   2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 352 +++++++++-
 .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h    |  12 +
 .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h    |  17 +
 .../phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h   |  12 +
 .../phy/qualcomm/phy-qcom-qmp-pcs-misc-v8.h   |  12 +
 .../qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h   | 639 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 163 +++++
 .../phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h  |  33 +
 .../phy-qcom-qmp-usb43-qserdes-com-v8.h       | 224 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |   2 +
 17 files changed, 1622 insertions(+), 19 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v8.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-qserdes-com-v8.h


