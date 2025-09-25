Return-Path: <linux-kernel+bounces-831623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3614B9D288
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D341BC1C14
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6782E763A;
	Thu, 25 Sep 2025 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gHaJ1xfV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CD1DF27D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767338; cv=none; b=qljG4dOHNx/rY9f8QANSEFUH3q51mLPDtYImgLPoIhIx8q6PN/+tZggZ/Iu8EClei4NPRFj0K8MiJt2AYPbEzyqpcTdyRiUg9/Fx7lwD7xjJ5t+41Jk5QjHFKJweFXckJVei//Ok3qFC19FT6GkYGfXjSBDz8SnhMcKbdO7jihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767338; c=relaxed/simple;
	bh=D3B612wqHIZ8dAE7hwWXIKwnog8Oa7HQK/30EwYk1kA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kg5hwjUjyMIsVcCiOmqk+TgWoPxtMYT1kViGNPwL+mdhD0ZfaTPABytEXIfQhKHJ+QSzBDixz4LGXWdssp85fGEQsU+hAEhF6XCMFbHS7a01cbmo7L8RvDW7fUZFwIF0iPdgceJL5xUgwhw/e/shYtFHvP4NECFd/FY9mQM1Bzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gHaJ1xfV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONwfXX018449
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=pozgUr4Pa5MFZ7maN78woqc3uxqicgDaK8J
	oc7Ogf0c=; b=gHaJ1xfV/vBnMerYgWszNYnjEUvMrv/BiGaG1j5cTGI1MBlAwx3
	koXSLXrNN1aFea4RcFLQX9cmVxlRqZ9KMZwjGDB9D/l1KYiM95b4PAFGobSLMNK7
	7FYgQL769AMGAoufbWYe8Wbg9gFLvYIwwlpxo/dKSNBcQ36i2++UlzTxq/XmOoOU
	G0gOyx/jJZx+xZfE91mk+ydSFissDmr2kgax/Kw9L70hvNqjblZHZNTPJnx24hZX
	zBGpuzNSc3M9CNyS+q4d9cZPGAQFsCavPkBqPf4pM6xHZoqIrEvJzvAmvIUvmOwK
	KNB+YLwl50pV60Ydq/J9zJ9wVwcvL/74zvA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkadm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:28:55 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b54b37ba2d9so1197756a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767334; x=1759372134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pozgUr4Pa5MFZ7maN78woqc3uxqicgDaK8Joc7Ogf0c=;
        b=esVLkGW1cpDGigyBk1mQ8BSlQq7MVo9shOWMwbzPFFhTJ9kfZPeXYgZo9xIle+87xn
         fqXBfLQjQO2epjxces2zqCRC1VuPLEUxepzSjvTt3vQMNIasylpF5AMgoC1Hnjj0B30C
         IZGnmCYLDvInVPtN173XnkxHZYXyAnHkTVIySUyiY5zMjldVMoVKzXrrwlxLv9c1qgps
         mI2bstNBukqAhwCf+QE57OI4twFDJx1D7ibCMhnVSkyUtmfO6NjX9MeIMnOJ9c7EiKe0
         7M/bsE8QSRsW3RROonBHDvBJjrPn/wcUeJFEA4LwbAxOMgaOKtbUp6cKvGjw3aNwHWin
         pcwg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9UVouJFnBLESeSb+ZzYAhmhgTcWey/j+yhn65X4L4lHxMZovIHzoEmqr7MY2L8q+73sK99BqdfugAdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJNjzlttCNe29ORVjunKLPOn4a6MmfGwCNkUjr4HpyFEJ8fEc
	0ZoWglQnuvVm699o4d78vrEK6VBMBrxruieB+Z0f9zQVO5U/trPakmZCBuVYLOwV4s7Jnf8Oii/
	5nrhKS4rjR7xR8PFPAuRlsyC5l6UmfFurfdiKW6l7IVYOnq8LI5EMbpalZoMGtU/cB4Q=
X-Gm-Gg: ASbGncu/Ym8rauzmLBsaunpcx3dcFpWKXiVLt8mbpu4cbFVJYI+//lORUxWMsM3y3oM
	Rqb9LBEbt9lT4bfEWyOH+eKjKTbDv701OBheeeT6q+7cAqQvkAVZGsxrEdqoBPzh0iDS6HJL5Qc
	Gm/nxt2MB209XLUyuB5/WeqSQsbbyDeiyHUpSLVWIRai61JZhgbgsR4fi67PcKbi1ZThat7pG8q
	vfGD0BnHetyNxcUiT21bjPw5cgRLsrN/Lr/4sLuI7o2X1Y26IChxPKN+NOOpirwBWuJSZHd7gs/
	Wh7x6UMA5bjh1/n7QKgSVw+L6LsxUXsiAr0h7J96Hc4tPb+35pJsvyFvH/CW9itnx65q1E+1VIq
	bwE9+hUgy8recd30H
X-Received: by 2002:a17:903:2403:b0:271:6af4:17c with SMTP id d9443c01a7336-27ed6abbab3mr7476205ad.1.1758767334037;
        Wed, 24 Sep 2025 19:28:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpDQAb9zhwAQk2cn3fm3Sj/BbBznzSAqjeAN+5V7NHD0Qqpd9x8hSwTL4ww8Ou3qnnfWG26Q==
X-Received: by 2002:a17:903:2403:b0:271:6af4:17c with SMTP id d9443c01a7336-27ed6abbab3mr7476005ad.1.1758767333526;
        Wed, 24 Sep 2025 19:28:53 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d711ecsm499881a91.4.2025.09.24.19.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:28:52 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v3 00/10] Introduce Glymur USB support
Date: Wed, 24 Sep 2025 19:28:40 -0700
Message-Id: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7rCp73exBdD2TgumF9V87JuuB9p-eNcY
X-Proofpoint-ORIG-GUID: 7rCp73exBdD2TgumF9V87JuuB9p-eNcY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfXzamFcKFV/XGF
 P+kC2JXppCNvdT280yboOF/4EIufwnwGsJspXM03br0KOMeeaiwoZUp5BCbHT+Z64oq2iRyB/8/
 ZRMwyRlF8G9+f3A/QpXjLj7uU+nNgWBcbfiUL8k6LlCo0uGPgT6bPbOh87jWysxNxU10yIy2dPb
 rohrDKCkMo5zt3b5DMqh59GKU3p6vvTbQNjSgln4i2IcsMkU794As2USqxY1JFQRInoIvNRId9Q
 kwYr6j6orJkgDTl2xXUJriVHCjsaVDzF9wrxEpoLAOOVmwIGqKOJ56RV/DqMnolsk8NU+5bhTcV
 hSu3iJ7hLCp4bJ9XlpMIzoPG8dDbSzwLzTSKhFS/K0VRlTmCW8W48M3e7tbqzVTCT78Qqb14ZO/
 20Ay0tjN
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d4a8e7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=uF0vjx2ZuONpqyvErPEA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

This series enables the PHY level changes that are required to support
the type C based controllers and the multiport controller.  The typeC
ports utilize a usb43dp based QMP PHY for the SSUSB path, while using
the M31 eUSB2 PHY for the HSUSB path.  For the multiport controller,
it will utilize two QMP UNI PHYs for the SSUSB path, and two M31 eUSB2
PHYs for the HSUSB path.

-----
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
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |  35 ++
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    |  19 +-
 .../phy/qcom,snps-eusb2-repeater.yaml         |   1 +
 .../bindings/usb/qcom,snps-dwc3.yaml          |  26 ++
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    |  18 +
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c     |   2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 349 +++++++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h    |  12 +
 .../phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h   |  12 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 163 ++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |   4 +
 12 files changed, 649 insertions(+), 13 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h


