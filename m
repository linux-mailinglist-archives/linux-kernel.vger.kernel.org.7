Return-Path: <linux-kernel+bounces-854284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AA3BDDFE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D34C6354B53
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928E931E0F4;
	Wed, 15 Oct 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R1F59vJ2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246531C588
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524074; cv=none; b=H2nitq1rZ0Qhtyj0muglkd+U28k/K98yst7TooP0tHV9eDtdzBAzEB3kUWkVpD35Ce5TPceU2gdiT2K4cZnM76npK55CKp1Ej82D7mCDFt557stFRQlYpJZepHQvD4hVpYNOE2xhVWxu0IAUcM17qoGyniPKJhBaxJRiT606Znc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524074; c=relaxed/simple;
	bh=UD0+HagPVLlzWUDwZRKdbmDniVS8JgRHk8wGYNgYMM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Li3J5G3kYh+n9dtMo7ebok/S5gsr7Cywc3AYX//9QhHFg7ziCFy0k0jHGJ32xWuhGeOugzI/DURDORpVjgEnlUQNR7sYMzFZf8mjB7kpO1Cgs6f9sSwzkHIgMfSKHU9iooVbREKqFStHGJRN0jFd7ZamLyQdYRpK+UTUmuia3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R1F59vJ2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s9nZ004012
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZvqRobnVL+EM1S4yYHAfLhWvmx/XDIy9zng/ovwtFeM=; b=R1F59vJ2adb6X1Td
	qPJazQeCPv7m81HQrBL+MTJ2jz/UxQ7uIk0giZMKCf5jzQT/pHRgANjhgcgNqTcO
	fj9je+60PzD0jg6jCPae30+IivpMHFCufyzzA7EPZ8s58ndjZM0jwcloqRlG0LYu
	lVBvQw2o9UPAAGGL87yFIAAjLylnN2Fi4+Z04PydO4U/a135gVsMO7OnUc0VA2Uh
	OBYIXIHhv/OXMjexd6ukada/ZN1abCYUHPbzL1ZIEC7VCDh+B59hJXfe1PjRqpag
	S653bNJCQXxk1XBYWAj4klcKemC3AmqJ44v8ItkEaLhlndmiyjNwhjzr00ZZsDdU
	XrUg+A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg3wwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:27:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so9127300a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524070; x=1761128870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvqRobnVL+EM1S4yYHAfLhWvmx/XDIy9zng/ovwtFeM=;
        b=FAQsVwW5Wd8lP30YxPj8bbUaaIUebmwM+ianIvs3tt8RX5asJu5r6+LQqSl0KcrAwQ
         tyl8Iho/0NGtehnaIGx+hP1On6YFLCw8rvq2kCsWCB9ZTeop4IiRr5KYYEkgiZfiIFn5
         dOUmuak/N2VleQiTcXb+pOJ5nU+++qGvDdicPgCdaa+Xo70YWwFfFfn0XrdRYlvCutpx
         TMGXcCGH3isQWkLE4MR1B5zafmZnDPQxFYpLRZphc74yH8b9capCspo7/3I3hmM5vGBU
         BYslup3tceiuB7X0EiQDALoRKDlaKSjW0lIN9hXbDt+pNCgm7fN7mOtbByJK8mS9E1aK
         eoAA==
X-Forwarded-Encrypted: i=1; AJvYcCX2meKgzbzvF8OQXFYLoqPnIFkdERIBn9+IfxPQeT9YCLuCPSRGabZZVIpoXPcHclj+has2Rh4f+bPn0MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGI7si0aoV/DZYZsPrRcMm7w0cMUaGETo/+e4ioUGAmb3QafS
	rqfJ5D/Iv6BWRSUtPakCxZzk5JmQEV0YIE1wYZ+rPnZzRD+uRzDtUIirHwnIf/jFOFUPF7HlDGV
	Ko0YgYNibLvoSHc2KWBxrlp+ipUVHgaRjAWYtITOcGoiTnUNOk6qLj0MRnno+KNqYKdw=
X-Gm-Gg: ASbGncub7+MVq+pZfM93oCF0cdF9yT8PN/iLTVXKRtOj6pSF51vGlK4nnZnYN8BiwbB
	3sE+tUxuxkF5+nGAbsl9nWTooyOlWlR/2t+4qa32yVa9SbhlmdsmlaK25L7LzNA9bD/MgxrEHFh
	TrfbcyfGOd3t/Z6GsIwtpWB5n5mdjDMKhwH7hBF/D2guyC71U2gX8pfSdmBBekgLAGdW5mFVctR
	lQH9CZybea0hr2bvS7ZS7R33yGwFSV0ZiAMDzFtAEnnZQp67wak6TgIuzrIIO6Ziiesu4aIIxbe
	zqlyhrNZAq/zU9eagjYNi/0WrBLZFAS/0hc5XwjFa3jY5h+3jqxEBG/uKEElcEBhUPKe9bYhIIj
	lPoQVTgsXA/M=
X-Received: by 2002:a17:90b:33d0:b0:338:3789:2e89 with SMTP id 98e67ed59e1d1-33b51117428mr35275105a91.10.1760524070479;
        Wed, 15 Oct 2025 03:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEIUwt8ry8GF/UZzYIWnFH7w4xxumx865zk/mV7pQ3v9s5tfY6ECzCVX6vaoGYmfnaMbNHNQ==
X-Received: by 2002:a17:90b:33d0:b0:338:3789:2e89 with SMTP id 98e67ed59e1d1-33b51117428mr35275076a91.10.1760524069888;
        Wed, 15 Oct 2025 03:27:49 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787a1a7sm1993574a91.18.2025.10.15.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:27:49 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 03:27:34 -0700
Subject: [PATCH v2 4/6] phy: qcom-qmp: pcs-pcie: Add v8 register offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-kaanapali-pcie-upstream-v2-4-84fa7ea638a1@oss.qualcomm.com>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
In-Reply-To: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760524063; l=2155;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=UD0+HagPVLlzWUDwZRKdbmDniVS8JgRHk8wGYNgYMM0=;
 b=zp9TyVP+mYZ8RnVJBIQUAjkqkL7P6Wvku8xYCpBilrwdujS6A+eY1whdjPrBE7kFCAVI2deRd
 j/7ASHrJSfDB0Q3Njyvu57A2Xlht6V3Ls2IWCvQaiM8wfavjZFfAY35
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX1PkiFxufaqMN
 cLcEPvS9xe9r5FuTmQ/jqM0m72aH2Y+QvPw1X2IE078DoNX3/svG1wOMWb0ZUPcYcLzOW98/qX7
 xhqDhjqolpLgw625wc+qMhr5zJ+3LW0UCv9MsBrKXWP4JnumXt5VolyaNFdFp6As/q1S+FxBERI
 uIOo2CypYFihtRUHmMWCaDuX3ng5uD6PCziSA3Ht+vWgkIkSnkaajv2+TGMmH7Y+6hoQIwmrHt+
 tpofDWbjmLVQVak8Vd8qFWxMoMzrpHixZbv7TylUkWmvbC4gN4bH4/8Unfx5Hi8x/3dDXHrBI9D
 RPTrUMzxXbVfWL5QhPplxa9b19Cn/sJHsVj+edAiLnudYPzu6DSr/3Zd3l5PzqxXW74V6S40BiI
 UVKTADcRdhwKfagjxvHPw/+1xw2Myg==
X-Proofpoint-GUID: tWniQ8ty-Co2cdLda2SGuAUbY_plze8I
X-Proofpoint-ORIG-GUID: tWniQ8ty-Co2cdLda2SGuAUbY_plze8I
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ef7727 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=GjIj-kmtzo1uPuhiLq4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

Kaanapali SoC uses QMP phy with version v8 for PCIe Gen3 x2. Add the new
PCS PCIE specific offsets in a dedicated header file.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h
new file mode 100644
index 0000000000000000000000000000000000000000..1e06aa9d73d588aacc86fc1b87fb17396de700b8
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_PCIE_V8_H_
+#define QCOM_PHY_QMP_PCS_PCIE_V8_H_
+
+/* Only for QMP V8 PHY - PCIE PCS registers */
+
+#define QPHY_PCIE_V8_PCS_POWER_STATE_CONFIG2		0x00c
+#define QPHY_PCIE_V8_PCS_TX_RX_CONFIG		0x018
+#define QPHY_PCIE_V8_PCS_ENDPOINT_REFCLK_DRIVE	0x01c
+#define QPHY_PCIE_V8_PCS_OSC_DTCT_ACTIONS		0x090
+#define QPHY_PCIE_V8_PCS_EQ_CONFIG1			0x0a0
+#define QPHY_PCIE_V8_PCS_G3_RXEQEVAL_TIME		0x0f0
+#define QPHY_PCIE_V8_PCS_G4_RXEQEVAL_TIME		0x0f4
+#define QPHY_PCIE_V8_PCS_G4_EQ_CONFIG5		0x108
+#define QPHY_PCIE_V8_PCS_G4_PRE_GAIN			0x15c
+#define QPHY_PCIE_V8_PCS_G12S1_TXDEEMPH_M6DB			0x170
+#define QPHY_PCIE_V8_PCS_G3S2_PRE_GAIN			0x178
+#define QPHY_PCIE_V8_PCS_RX_MARGINING_CONFIG1	0x17c
+#define QPHY_PCIE_V8_PCS_RX_MARGINING_CONFIG3	0x184
+#define QPHY_PCIE_V8_PCS_RX_MARGINING_CONFIG5	0x18c
+#define QPHY_PCIE_V8_PCS_RX_SIGDET_LVL			0x190
+#define QPHY_PCIE_V8_PCS_G3_FOM_EQ_CONFIG5		0x1ac
+#define QPHY_PCIE_V8_PCS_ELECIDLE_DLY_SEL			0x1b8
+#define QPHY_PCIE_V8_PCS_G4_FOM_EQ_CONFIG5		0x1c0
+#define QPHY_PCIE_V8_PCS_POWER_STATE_CONFIG6			0x1d0
+#define QPHY_PCIE_V8_PCS_PCS_TX_RX_CONFIG1			0x1dc
+#define QPHY_PCIE_V8_PCS_PCS_TX_RX_CONFIG2			0x1e0
+#define QPHY_PCIE_V8_PCS_EQ_CONFIG4			0x1f8
+#define QPHY_PCIE_V8_PCS_EQ_CONFIG5			0x1fc
+#endif

-- 
2.34.1


