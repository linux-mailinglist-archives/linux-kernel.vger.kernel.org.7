Return-Path: <linux-kernel+bounces-831533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216B9B9CEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C564632800A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64F62DA742;
	Thu, 25 Sep 2025 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mw1Y/hgf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AF72D7DD1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761557; cv=none; b=Ppm0Agq3b7dwqMcUXxWBcKa7LaDgLbfOGTvcqrqCIilpkS+FwaUTUP+roEpW+5/1ILo1RxKN/SX/tZziWwgKpsmED3giMoRbjhBO4iAkS19deN5V3GUmnWzWTdHNl+AwGeveXazrSJd7uw9D/1w2XeIFJHTPI3YzECB/FAWSXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761557; c=relaxed/simple;
	bh=JO369MGgGMk171xFRwjVqeRFJxDWky0ek+7VCvbF/so=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qIMHhfmCvmm30fBm8o3tmDRx7UCx9tbFDEChPFnbbjGoBMXhQVRCHht/42FyoXO7tfuU5l1rJpqO9iezWMhoZm/sMEZ6G2iadDhtIEaSraNhaYOBDUjCX5tWimuEWJYtCEInLxwouLuOCwK3bjI3L+9ooLHZ+ZRQvbiQe38X3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mw1Y/hgf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0XFnr025105
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=nzXyVD9qAsVJZyPhyB0idDDfhpNBSjuyVh5
	MWcnszg0=; b=Mw1Y/hgfaRAUkNXuOLfG7N7fIOCYu0rN60W2g9HeVeH5DOjqemO
	vIVohzMTSOktedDH3VYOOiyYQ+Kx1CSK4aa1BFd4DCXfj7Qn4n0gMyQrep73EYmm
	+faT+2rAFgABGGk97TaWprDY4217dPvwAvYIR/qAnlV4dNd3Oec4ZU6PmhGYXa3e
	sMDGE2AabTpWyb1P3L3MS2le6rg9Q0CaIa31V+kc2rQOD0APEGJuBZW9iFusTzXF
	IacOhwmncFpauac6FoCCvnD4xApAc4LNaiSK4mcyt91DdJPEYj5U6Fx59zVQDeCN
	wrOAjeBqsyf122XE1hPWCo0OIPcmFk2NZng==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv1683f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-277f0ea6fc6so6336145ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758761553; x=1759366353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzXyVD9qAsVJZyPhyB0idDDfhpNBSjuyVh5MWcnszg0=;
        b=dYyx7qLSmBkfN1a5tTElELOzUm/kJflviYJKPYN4N6UY6LTVJyRh7pkDLwmhihu8Ix
         pY1TaKNrtLFB7euY5l05dYZmTaHm45zHSobCTyBua6v3/ncb6WT2f3qiKa9xba2eCY8t
         eEbnviOQY7Am2EHop8ASkNeAUC1lYsXBHIV4g4rce4Cn/HHU4HW2cyV7YInecIGjdId6
         8I55Fuo81UdBEVbw0CtC5sP6vjYZf2izAHto3VOoJ6sYfzKar+RWY6rvMAvGAgKav9PG
         se0FL7FMM6ucMelO4tIbZ4pAW/JmBN2V987EyIGSvEnXrlSHidya+gV5okhUssroog83
         BHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJHtk+WXMih4v466S85yAoCkTtjWdcByj8lJXoFJ8grudqLiNocRK8KfNijv7l0Z86rKFW+NmOFGcQnxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIDgcPfkgH2WKNFSjhTxzdpEp3shXsFJxzoIWUSog9gc+iSMx0
	addV21Mf2XaOHFxj6RMkFIYVO/d8f+OsVNyz1IpRo2x51BYfVFbZLcKdfVMamN/5v7mFJ+Xownz
	837uB62wkI0qohYrRQuJXVqKCZ0v3SteU4i2lK1auPChh/Iqdg08MOHUSM22u6ljWnK8=
X-Gm-Gg: ASbGncsmjUHV6J9tbJD/kXq6Wxi2YPHjoJVxhNUJ3KBy7bAItnbxjn3qX8A9HzR7bTo
	7We8Fse4Yq8JEnMMX6Zhr6LJaxAbCU0crzOzNi5NbUYF2NimHlAeqG1ntenzL8+g3l7cIs5wFYx
	WeHuAkzuNCn6POuO2poab30ZDJz9Cj6BVPaHqdvAsjrStW4FSf39SsrXXioO+gn72RlDe2I8Ix1
	7Z56wPHKATElhBuHqBeIvW6lFsKHmb7XPbw+Sy+FTtoyScHJVT0PsH8Gq5/HcAb34EufSfDu64H
	dqNGGw1GCgbTMU9V6lCwLPoyQ/QDA4nWD+um895geekQMBamTF6hQ7Z5zECBuA8ld+9SB0QfFZb
	eU4IfV2g+AMQX28YZ
X-Received: by 2002:a17:902:d60f:b0:267:cdc8:b30b with SMTP id d9443c01a7336-27ed4a873c8mr14727365ad.53.1758761552788;
        Wed, 24 Sep 2025 17:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZb/eqow/4MDtfwG0wirrD5pVGj+rZTu8owWBw6yjQmbqpouZLqrvcXW52IQPKF2b9fRjZOw==
X-Received: by 2002:a17:902:d60f:b0:267:cdc8:b30b with SMTP id d9443c01a7336-27ed4a873c8mr14727135ad.53.1758761552307;
        Wed, 24 Sep 2025 17:52:32 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac27d4sm5238105ad.135.2025.09.24.17.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:52:31 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v2 00/10] Introduce Glymur USB support
Date: Wed, 24 Sep 2025 17:52:18 -0700
Message-Id: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bAiWBuTHpjdntehOSZMix2bsPGRK9A1k
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d49252 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=uF0vjx2ZuONpqyvErPEA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfXxBOdzBqkXoL7
 I3kknrSwGLqWONn5/DDyE8zk2kUo48ZyHCEz5RUSJh3+G75vQ1YevDw3TO7bufPss3dlHmv14TO
 JumXDsIg5BoR9HYq8F1cFwvHZ79ZcsaxdjawMRbANdtiDk1dBs922BO5Qfl67ykQL4dQBlsemG7
 gQOEsPa6Vs5p9wOAfIQ1JGrSGdP0re5pr2rdhALuW2j25r34MJq647iGNHfGHaZoHGaV0SsumWT
 7TVWQmJ5+hGNZFAXV/cF1wTuLxaKTxNMhUPLLScfms4UYrr8vz8j4pBgQyaasRoiuYLUg7Xhdxm
 lTmAU4BkvXssgiz+qks3MabECtxF/D+BSMU7udg4EymzEp9RGMBBZNiEUAw4ToltDOdutYlj5lA
 +cty+p83
X-Proofpoint-ORIG-GUID: bAiWBuTHpjdntehOSZMix2bsPGRK9A1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

This series enables the PHY level changes that are required to support
the type C based controllers and the multiport controller.  The typeC
ports utilize a usb43dp based QMP PHY for the SSUSB path, while using
the M31 eUSB2 PHY for the HSUSB path.  For the multiport controller,
it will utilize two QMP UNI PHYs for the SSUSB path, and two M31 eUSB2
PHYs for the HSUSB path.

-----
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
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    |  19 +-
 .../phy/qcom,snps-eusb2-repeater.yaml         |   1 +
 .../bindings/usb/qcom,snps-dwc3.yaml          |  26 +
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    |  18 +
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c     |   2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 349 +++++++++-
 .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h    |  12 +
 .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h    |  17 +
 .../phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h   |  12 +
 .../qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h   | 639 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 163 +++++
 .../phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h  |  33 +
 .../phy-qcom-qmp-usb43-qserdes-com-v8.h       | 224 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |   4 +
 16 files changed, 1562 insertions(+), 13 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-qserdes-com-v8.h


