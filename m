Return-Path: <linux-kernel+bounces-825482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5928FB8BE61
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F921BC835F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1378E22836C;
	Sat, 20 Sep 2025 03:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5t3ABKb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED8022A7E6
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758338526; cv=none; b=tPd+jnC3NKyW7niwDkFjt2ViDZSSCYBpi6eOr7dm957K9Wm7Cm/GkHkyYWiBA8qtA9Wp00qmCElQxzzOKRlbAJRYT/TW/37I3j1/K5qGjlBuU5N3e1675caeGcGIUubsQ4NasVihPlvnADPvCQABZnAZEqIrjHtoZz5v04jy1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758338526; c=relaxed/simple;
	bh=0xFRrxPf1HgCf/uIpvSwdyWaSlw0SJxq9j5r8OfcLSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TOJIu+TgST9rBNHwINMo1y2+5bjB1aWJMydUjYcn21OmsUdNLDn4h8qAydoOXjBuLluIOAe9MhwHx3bezlYIoKmqQ1O1oAS+xe//FwMS5UpoCnOMMRzeZYIaGhkl1gOPFXJhrxOPJP26CNn3igLGEZYqG8D5ZVC5aw1SEHBO6WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k5t3ABKb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3KNob006719
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vuZU5U4R9Rryr7IdAfkxs753zdgqirIJxPG
	858BKWwE=; b=k5t3ABKb2GvmSXeB4L3qyWcAYWv5GOpbrwGW+IExQE1comiVw9E
	ufPeF4cJJ7qL+T4YI2BBhXvKmXrX68hUmV/WZaehLJ/YiOIbqZFcBF1oCjbIPwM6
	lzLPk5OTNYfyltG8g4gxAzEYzii1sIrdstgY/9nnyxxS/68jD72JN1L14PwkJbVJ
	2XJXH8KI3+c2owvmLYP57zqvFY6+E7wIyWy2UuL+XNko0BgJ56aA/LkK/+p7IYqC
	RUI5Hwitgf1h12SB6TXEy5uASbJL8QU/VX6Aovv9yoip7N8ftZzg3JCKkMNcorWn
	42GzpCK37ZzvaYhVs+BIb6eysOaEto+PC1w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k988391-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:22:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2445805d386so29839305ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758338522; x=1758943322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuZU5U4R9Rryr7IdAfkxs753zdgqirIJxPG858BKWwE=;
        b=KQnZ9CwU/0gnZDA5GmSGoizqFDSmColcn6kK2D43uRbywetmUti6mxqJoAf/bBlOy6
         rm3XVElQ/zLmPRBSBqs2ZQFAH7WFuzU/w6se77+5gxtJeFlJtAZV101c8FOV0+l7fVkf
         rInIlX1XsC33EZo+JL7Iutc4zKmSa8Qj/tNIvbx+CFk9u3WUN6i0louBCXHjMTW5YjSI
         V9onAGvDVOgaefvie0dRcKUMYLV52k3PMZuE8AUOXved4pzuiU/iTI06rjXvf25RAeDp
         5qNXAytMe7qb9oDoUYrVspvrMXRcnXZDS6nJEbRBY8PtJapfLVRojkEXh5cmGpPDO69u
         sSAw==
X-Forwarded-Encrypted: i=1; AJvYcCWh/7cht+l0zO3ug0FCY+cRNr595lXaSRWIqJbIFjIAH4hfjBwS0PjTXpbc0EsN0UryEVfwxWnqLGxLFEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWNoK87nE7LeKrlZlU9wn+GJPjSgU6FHUchmnHfyB/o/GM1MCM
	6ty95lgVFm/RIDiH8dc4Bgn+JcP0v1MGiH9rTczhi2oeEaMiUpizg6jrK7EorCXG8lB4Vw2EUNm
	m7ANKXNxyuZmMD0hlRz7OP1xvSadcIuj4kZY5CfU8avvdJGPgXvc237SR3zO7ne4b9sg=
X-Gm-Gg: ASbGncssrr6Ahsbftb7HGlUgCqZAMOafiLBiY4Fppfua43/tFGExwBnH0Eng6vkb2uo
	6w+hASVhAt3+lK/zzsElhrEerJODygn2aiZfK/cba66YM4hp/KZDNqqW/nSneG0jOT/Um1HTXd2
	9rgOmpkrXl7DrVkDSx01lIQMzkeRNZJTblTPNR2V2BpMVIOhkIpWaRucUxd7ZnDdVa6muogoy3O
	qK8KrwPPFDBXlurfqV5UP9gabjjLLRIDTb3E1aKsd/zRdjlOB0XGKJWbagEiqBq0AP5cnDLfxJp
	78s7yhfBu6C62aIKycS/88NntwAc+vcmZfkigJ3sd/Iu8flV6wf2zF1i4JTYhp88kMjmBkcm85f
	VcCs5rXOi550lFxjS
X-Received: by 2002:a17:90a:ec83:b0:32e:9da9:3e60 with SMTP id 98e67ed59e1d1-3309838e41emr6060608a91.36.1758338522087;
        Fri, 19 Sep 2025 20:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnfgc9WbLWRAMVvDv9SHJUx3qQPyX7uwJoFjB6p+plahvgBOQhzvbXnu4sxjxYoajBAIfINg==
X-Received: by 2002:a17:90a:ec83:b0:32e:9da9:3e60 with SMTP id 98e67ed59e1d1-3309838e41emr6060577a91.36.1758338521632;
        Fri, 19 Sep 2025 20:22:01 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306082eff4sm6660409a91.25.2025.09.19.20.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 20:22:01 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: kishon@kernel.org, vkoul@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH] phy: qcom: m31-eusb2: Update init sequence to set PHY_ENABLE
Date: Fri, 19 Sep 2025 20:21:58 -0700
Message-Id: <20250920032158.242725-1-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TvaBUEEw7L7UeB4qwLgazdXmabhQDIvx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfXxvp6tfr11gMx
 v6nb1++EvRUvAa+g9srNBTwekqWVcJgvz4OgY6+1ytLWH9HiGbABpL0wfFXd7H8vuX2TVYufOhx
 XJWscGMahsxrCRW0szbGW0TPmV9z9lmiC0Cxuq/MLw0ey+5QmBDnBuyW/HPpY2thvOH55iWLCmW
 rnr3C9luNXsBYvSyPY9XYIOKuw+43N8iXorc25JUaDQ+FYmmv7IhqeaCnV0xu0k1K/Pa5MRr3Lm
 9bNfNHXUzIqi+J4xtw1N+C3AluAd7RMjN+vZ0OJD9H0i+5ANRohSq0NEysE+s61mWo3MCKdjE+m
 WXulr5u01xXvh9Ft5Ek4vUgI6kX8lScW8ScTv3nWkdgtX2oSCJVLIgfElYxDvFe0kCze95CQrBO
 8DpM73Ec
X-Proofpoint-ORIG-GUID: TvaBUEEw7L7UeB4qwLgazdXmabhQDIvx
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68ce1ddb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=y6qI-x7cYgrOQfqpg38A:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>

Certain platforms may not have the PHY_ENABLE bit set on power on reset.
Update the current sequence to explicitly write to enable the PHY_ENABLE
bit.  This ensures that regardless of the platform, the PHY is properly
enabled.

Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
index bf32572566c4..fbf5e999ca7a 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
@@ -25,6 +25,7 @@
 #define POR				BIT(1)
 
 #define USB_PHY_HS_PHY_CTRL_COMMON0	(0x54)
+#define PHY_ENABLE			BIT(0)
 #define SIDDQ_SEL			BIT(1)
 #define SIDDQ				BIT(2)
 #define FSEL				GENMASK(6, 4)
@@ -81,6 +82,7 @@ struct m31_eusb2_priv_data {
 static const struct m31_phy_tbl_entry m31_eusb2_setup_tbl[] = {
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG0, UTMI_PHY_CMN_CTRL_OVERRIDE_EN, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_UTMI_CTRL5, POR, 1),
+	M31_EUSB_PHY_INIT_CFG(USB_PHY_HS_PHY_CTRL_COMMON0, PHY_ENABLE, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG1, PLL_EN, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_FSEL_SEL, FSEL_SEL, 1),
 };

