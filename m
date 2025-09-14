Return-Path: <linux-kernel+bounces-815702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3404B56A06
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6339C1893D15
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651172C376B;
	Sun, 14 Sep 2025 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n1faTB5N"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1628A1E6
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757862446; cv=none; b=tZoIzVL9KOFqZgcYdcWBVoKUXi0lKegb4+CYdBaFCRFWYrmyXP67KjEvSXSyGuI6qB90nrA90FJp2UU5RyyPvcQJwiU+6mxLFKEdHVCTqxZCmOqM/NkexRJMkU+RCqUySqCcNRS4tcAorhDM59XuYQ7UNwvv6lILViIll3VqlnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757862446; c=relaxed/simple;
	bh=Xm04sNqg6M8XDtv4CgRhGuHsDDCT4cUD0lbe9sIdlTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JWOJvFD5Ta2fomPjrwAAe+k0yHf2PQL/H1SaKkN6eqgPrfKKuKtp9E2pPdVaAh3jN7LrFnunSz1u2FpgAlgM4K4ulDWUXxBh7ReDPW4vxQrzbVXubBuEUeP1AnrHQdNfHi2CRK1DVq4UdKwsfSjY3IAS6zW6QFXxlcTBRhYl6XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n1faTB5N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58E9fZe1028356
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mpnZTgEP6/zsg99dZFw1ct
	tV1r11s4EWbty3YUt72oc=; b=n1faTB5NTnl6tRExu54P9tzy9KvFhYyMvlEfrF
	wnxZlqO9dAUICiL1731xglQpvu0vM41eTbQ90ifE1kzFxPMxKRFp7XbClvWaVYoa
	9HnI63WW4IvKMKZNmROy/chuEbaYv6OJDIh4J66A017hCexjDtbkBAmEjTuZCEPu
	1e2elaXGixg7S65lunzMmumzkmAExdK1hfTOB4HAggCpSyfp3RmpaOJoad80AUC2
	ykQ1DngyA8soEYp81sXbpszozrM0HAbWaj/PHkDliI7NyriMmy2DthidHaBeeL5j
	PvgtaxQnlq2GOBDimDoCkpCJjwUFjfJdoulY3WWDv/+FuLow==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072jbwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:07:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-265b1c650a0so3218005ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 08:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757862442; x=1758467242;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpnZTgEP6/zsg99dZFw1cttV1r11s4EWbty3YUt72oc=;
        b=h3pbTr+Ma2e++NO4XxXQa4jx7eVtEYqrGM4vLBon7igAY7Voer4NKLwU2a0R/98B9i
         RTP0Mj50Qnypt8xoWVhKuTeT7sbncLaQdk+rJ4E1FejCNHWV4nOolibZtqfS/qJBLuZr
         p4QMZyNp1mD/H2oDoEEyNuyUOV32gCBh8SnJhIbLsxmMEhDK5ZpG0LZglYQ3DEAGsNuD
         3o5dN+AgAwp8FZh6AwmYFuuS8iBlWO+DbJww4ijwQ87giOwV39Hxc7gHgF5naQ+BMhmv
         1qGTX3RLyAEK3gHqGhwPYclDk0sZ5c9Zi8S72wqwn/A6RHbBZ1jOBtO9tOdVEley/9+F
         GMag==
X-Forwarded-Encrypted: i=1; AJvYcCVG8dIPHHAr59Ac47qYgcs8wOLVl2TPGpL4spuBtum3p/6EpEBsV5NU3dRKas6vUyQ3cl6t9XIvUGiR1Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfbNCwCkvcWdcveBPO9Mq1+rDiybyykofaC73kU5mvd//Nnwp
	fIWcYbjd3PrIuUI2CfcaSur6zUptIlDxd3noFh68h7WO2QRYPKti29LQHN5qYtcN1Yvg3DxO7CQ
	to0EoEtenQnO2j1wcqq4J4Sub5tXhb61u1SlbAvEVy6ESYJ9/OPCCotav14DLn6ny8Js=
X-Gm-Gg: ASbGncvAwqz4Qtpn7lmJ7VcqubDOJX6rpOhTpwrW5YscMAT4NQe9+oliM0jOSwtm4DX
	nt8KMO/kej9IuSNtQGocT8DcvLWgv8WZ/8E+bwOgCldl3C/B58lDxLpRfhbUAVFrVhWU+qLj/Ib
	YwER0kVAb1i7xkMijXiRz6JUH874rA4IaPftV/iFRAKDq4UywszRp8hJuTISP5H9L2lM1f2qqiT
	//H30toyBM/X+rPotoEd8IP5c7xHSyoTAFjheW6jm+PcpBbePeb2qh+1toxqmnBGpK1rN8V4kRL
	CoYf1dieHqU9zg6V1cNWkEn7TIIFTB5yTxJHIjx501GdyWopc7Xz5S6UzObgq63+YPU23A==
X-Received: by 2002:a17:903:1acf:b0:25f:9682:74ae with SMTP id d9443c01a7336-25f9682760bmr74240905ad.29.1757862442271;
        Sun, 14 Sep 2025 08:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM2SEI/4RHZARg2DjwJIXHfkwPqpsE8n4zdcMsj54ea6iU2s7Mz+jWRjVuhZf130ZMHHhOOQ==
X-Received: by 2002:a17:903:1acf:b0:25f:9682:74ae with SMTP id d9443c01a7336-25f9682760bmr74240645ad.29.1757862441744;
        Sun, 14 Sep 2025 08:07:21 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-261d3dd029bsm41290835ad.25.2025.09.14.08.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 08:07:21 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Sun, 14 Sep 2025 20:36:48 +0530
Subject: [PATCH net-next] net: phy: qcom: qca808x: Add .get_rate_matching
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-qca808x_rate_match-v1-1-0f9e6a331c3b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAfaxmgC/x3MTQqAIBBA4avErBNGSfq5SkSYTTWLrFRCiO6et
 PwW7z0QyDMF6IoHPN0c+HAZsizAbsatJHjOBoVKYyuVuKxpsEmjN5HG3US7CV3jXFWLljgpyOH
 paeH0T3twFIWjFGF43w+AXFmxbgAAAA==
X-Change-ID: 20250912-qca808x_rate_match-570d44f510b2
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757862438; l=2388;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=Xm04sNqg6M8XDtv4CgRhGuHsDDCT4cUD0lbe9sIdlTY=;
 b=yxKm8rrtwIeIwjA72uec0u0qsefs0G7ye/yy0CscNZpqsuIxMj3rdWgjPilCqrX59l/JKDvQQ
 qvP/8f6UxZQCD/nSWnt5401kDVSBftS5L4uMGuX6zwt7uB7F2SIcqMr
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX59J+B9Jn+3yo
 7g8YT/HO2Co3/DssTuMn+YsuvUveMd26VDKWZKeZpCOauOl4ak4BZFR6Sg5UNEmD1jUXmIn+Uyo
 G4qXPx9WRcRpxTIi4WKV9XkIm5hcAQSo2ON1GAPq4JMWhjjP+MVFBoUPPd34EoT77uoEGrFdDJ1
 dNtJcITzyC+v4mC8aXXJVGv9l+JbYB3D4PdM0PqvxKdPUbpY5NX4HrSFiklHyWWVITZ0uMgurkl
 Is175QNtVeY3q2Yl/Jp+diqDfT1nXbCsya52rPEY3UZvM9KtJVv3yJtKmGVaPlOpnTHK76mYddu
 QpihzPpQ5Hi1LQwTWkygffXsHY/wt7G8xKgmQJGlWAnmV7DUFrD5jQkgMQ89InXVfhcZHwqONr8
 J1Jhsiw2
X-Proofpoint-GUID: enfR2BvRh7-x_MndmxW5-RFrimgJM0tx
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c6da2b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QNaXVSbgLMPUDDG8BmgA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: enfR2BvRh7-x_MndmxW5-RFrimgJM0tx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

Add support for rate matching to the QCA8081 PHY driver to correctly
report its capabilities. Some boards[0][1] with this PHY currently
report support only for 2.5G.

Implement the .get_rate_matching callback to allow phylink to determine
the actual PHY capabilities and report them accurately.

Before:
 # ethtool eth0
  Settings for eth0:
         Supported ports: [  ]
         Supported link modes:   2500baseT/Full
         Supported pause frame use: Symmetric Receive-only
         ...

After:
 # ethtool eth0
  Settings for eth0:
         Supported ports: [  ]
         Supported link modes:   10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
                                 1000baseT/Full
                                 2500baseT/Full
         Supported pause frame use: Symmetric Receive-only
         ...

[0] https://lore.kernel.org/all/20250905192350.1223812-3-umang.chheda@oss.qualcomm.com/
[1] https://lore.kernel.org/all/20250908-lemans-evk-bu-v4-12-5c319c696a7d@oss.qualcomm.com/

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 drivers/net/phy/qcom/qca808x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 8eb51b1a006c4c68ddce26c97d7d4f87a68158b0..9d9e93d2fa8f57b1535bc83e169eb011ae549040 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -643,6 +643,15 @@ static void qca808x_get_phy_stats(struct phy_device *phydev,
 	qcom_phy_get_stats(stats, priv->hw_stats);
 }
 
+static int qca808x_get_rate_matching(struct phy_device *phydev,
+				     phy_interface_t iface)
+{
+	if (iface == PHY_INTERFACE_MODE_2500BASEX)
+		return RATE_MATCH_PAUSE;
+
+	return RATE_MATCH_NONE;
+}
+
 static struct phy_driver qca808x_driver[] = {
 {
 	/* Qualcomm QCA8081 */
@@ -674,6 +683,7 @@ static struct phy_driver qca808x_driver[] = {
 	.led_polarity_set	= qca808x_led_polarity_set,
 	.update_stats		= qca808x_update_stats,
 	.get_phy_stats		= qca808x_get_phy_stats,
+	.get_rate_matching	= qca808x_get_rate_matching,
 }, };
 
 module_phy_driver(qca808x_driver);

---
base-commit: 5adf6f2b9972dbb69f4dd11bae52ba251c64ecb7
change-id: 20250912-qca808x_rate_match-570d44f510b2

Best regards,
-- 
Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>


