Return-Path: <linux-kernel+bounces-804707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6CAB47BDB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 16:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654A23C29EC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 14:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3F627CCC7;
	Sun,  7 Sep 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LV/byqxI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C1D1EC006
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757256742; cv=none; b=GdgLsQxyyb8RW6txMmZqlKqX68Dywm2z9zL71wEYz34CWH/YKXq8cUx8wmt/a8ON+PYcbvtc3U9XlJcP+Dq8WpLN2WEnT/xDwvdD6BZvJfksCs7YH1W82GZGy+fL+ml5CHW4ET6DNe91BkTzUWpbgf7QSy6Y2RWY5Pny+EafOJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757256742; c=relaxed/simple;
	bh=q8/D+ukM0Z8xbt2NzOinEuwjlyUq60k42C13C/W8iPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RN/0Ty7AJ6IZwtWOz+FC8KRbiOPLeJwzgMG7FFtiIzdnUbtfyhWjw+k0P6qGrz0+BR2SV7OcDHBOa1o1nmTkq7eZ+JDtnO6+aEFchkWyEaHfiuOrEOcjEaw2jXKpp7iQRi73ljjW+yhQXWMgtGNUCkzJtSyQu8cfQkM68mRyBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LV/byqxI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587AUq1O024433
	for <linux-kernel@vger.kernel.org>; Sun, 7 Sep 2025 14:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZNffsrN8dmCEs7HAgfangQEaiQquRtqWha57sIIZbzU=; b=LV/byqxIELLLV8Wt
	PIucgDdkvSiw+ADNd6dsCnOoVXjpSsd3e7y0+uzzz7P8BHWCiXbS3WHHfTghrreK
	NH8UOqkGVjTWkETnEXWmC1pddlecVzrD1ZHrsFRpZHXNueCAw5jZAIGjWJ+lXero
	98j+98G2+ziy7fExLuVU+WKhovILxBuXmlF1FFf0cDT1iqWRpN+KUYp3SrU7c2S4
	6wO/GETmZkuwBuhUMNgud83yfvCD3H8Ov7nvTtRA4iagVDisIxhzL1z/PJmUWNDP
	hd73S9Fx7XNRLvZztPUhUDfjc9c6I6Q17BcD5Aru4BbjoA/yq4F7y6q6RwKz0aDH
	iP0KoA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d63a6ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 14:52:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b49666c8b8so79863761cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 07:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757256739; x=1757861539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNffsrN8dmCEs7HAgfangQEaiQquRtqWha57sIIZbzU=;
        b=kBWC5LqNmhzpjg1mJP3aTPfah64gax3DU/E1JODhtPfNd8MHkSu5DJfLdoQ+jb7BYJ
         WW0k1ob1eS0Npj9+klzJ+fbxwnoJn4RIRYa2mJx/Uc+3Hzfj3ze9FxYokSqzEeAldB/A
         w9tFmoIFQPfOsCUAfsAI+I8TZFFM8P4D9I9tRC/6nWEf+7pUVCgj2kKTEkVxXf0aRYmW
         FTz9KNKvJlF3jGdRMIn56U9sEbiYraODwqUPdZRY046yChm8qaIM3+v7l/lrtsmfWWjm
         iXUpKFTvSdfeyqikU7M87xgRjrsAUB2xFxM4/5SCoOf6uJtS4gFi3/KG50EDMAiBXIdM
         f6Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUVgOYvtiSyfhBFeR4rmyp/DpkKAnvdBDKDpF64GElZRoxn2tmDiyvkCEZyC0E3x2Lq4xFim3t/is+K2f8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb4fQEd/IQY8cW6Mq+AQZqOjLtmPn5DIFcFg2mmBRn9EN8rdG2
	lz2DDRZS9Ci6ITJIHElcTKVjoze8C5HXOdedeG1iJclFp4akrplaATVC0J9Z0YxfzeMX9dnlO8A
	H2e/UJhcIclwRxZ3bTuxz1bozZ2fqMGDcC5YkRcx/4pqrF4UNHIW4odoDXKjqgGD30D8=
X-Gm-Gg: ASbGncunCjil/6HihG+xGBiIMAINU43BYIMVDpcLKrNGJTX6/7A5MaLTHFJE+p5MdRf
	1uyXrv6dag/xxpwcLNuEW07JVi1ZDsnIHhrqeyDXMjiIGhv/IKdIZ7v9lCPJC2d6DydOvke/0T4
	NdTrlBN8c21uQyel3NCx7eP7qWS47eAt4W/d0M8svS4spJETqQccg/kr1FPveRq0O7++/1w+E9H
	IgRaPzmZi8UrwY1+d0ZaQJJnS8rMTnfsb/W7Sp15aD/3eHCS7kR3Ih0kYcll/tgLdQJpmgY7OqS
	wdeuKWtUFuZToJu4i84OCThFEwLpbI6ea4qYGOfVnKJzA2zYZ0ETFnNi9mR+DgdQE+/WLUgeYmD
	uYyiPLdhVTdUcjbzGk+mr/aQBU7qyBFwnH+orkRh1/XvyoCYCbONi
X-Received: by 2002:a05:622a:1823:b0:4b4:9084:d003 with SMTP id d75a77b69052e-4b5f844d4d8mr46652051cf.40.1757256738927;
        Sun, 07 Sep 2025 07:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7WElD3JmL2LHfSpTpNmNOEL8oEqj3NvSXEnxSgRINrKywiinX54RHXhg9TR6yFPcmw+sgyQ==
X-Received: by 2002:a05:622a:1823:b0:4b4:9084:d003 with SMTP id d75a77b69052e-4b5f844d4d8mr46651891cf.40.1757256738457;
        Sun, 07 Sep 2025 07:52:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab939d5sm2936738e87.46.2025.09.07.07.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 07:52:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 07 Sep 2025 17:52:10 +0300
Subject: [PATCH 1/4] phy: qcom: qmp-usb-legacy: switch to common helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-qcom-dp-phy-v1-1-46634a6a980b@oss.qualcomm.com>
References: <20250907-qcom-dp-phy-v1-0-46634a6a980b@oss.qualcomm.com>
In-Reply-To: <20250907-qcom-dp-phy-v1-0-46634a6a980b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3537;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=q8/D+ukM0Z8xbt2NzOinEuwjlyUq60k42C13C/W8iPg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBovZwftYjKqkW+00RmQtqC0KhBlt2jfoXYBgS3A
 /rpxiFSJfuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaL2cHwAKCRCLPIo+Aiko
 1dSoB/9jtszJionNXNnZ+AaJemPRe2skJQAhLH9BcZxp34aGVp32MUdJfEUkHw3JSKEe/XlKSwP
 kEW/aO/Qc2lrvpZhgceKuvz2a9jw9jPjsR76Fzr0TmhHo3/XGmSsaqhQ6LBjH2OwE/UBZqzKGnF
 Id89N2qu+GVmJ+6hu8FX3Pw3bD7kkwcbT9M5Y7mkwBlUviVUg1LRYSJCMPWhW5KR/bf+wYXwjqd
 kR5UCSG2UNO7OByDakClnQleBg1nUHk/DrlcUo94soHRd5K6FMMnNL5iP360bgU/qOwfwKqqkep
 u5wKXh0hUpXEHZP9ijpFIcf99GIamcmG7tDToI+cfdaypTNu
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyOSBTYWx0ZWRfXw6j3BkQvIsb6
 M12dKecEAOzY95j7hJmqR+0MJhLgjCvg+fI4JmBYKP5sy4H92lpXymrcjliKu47tT96Ft2kp9LO
 rhi5CbvXT6qi7urS0KFlPpIqDPMz//90DjNViKIZT9QgsP3BE/MnFqn/aQ4oZEKHBvMmZcP3Uiw
 IIUIbQ1Bx+gEa4CRdXwvnkpHLdmrbMNYslp/1onFUcNwG5p/HlRpOxEhwVuBA1pmj11hiryGG+G
 G4XcskbHB51wBw0On8cInTGoJKKIBDnsVEMtQxPz6I6qLllVZ4xORlYIxx+EIenb4sDzfpXay1d
 E/hoBFbTm3UFct2PBYhA6+q+4gkZk40tO0TRpil0XVyv40gmWQb3czVKjOIEjvOBzXWuo5zTrhp
 FyNdWGM3
X-Proofpoint-GUID: 2Yo6QAjIw_HEHXVSyZ8cmrWi08_qY8bS
X-Proofpoint-ORIG-GUID: 2Yo6QAjIw_HEHXVSyZ8cmrWi08_qY8bS
X-Authority-Analysis: v=2.4 cv=DYgXqutW c=1 sm=1 tr=0 ts=68bd9c24 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=AjFrHIIk6tpMehmkB6kA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060029

Instead of having a copy of the common definitions and functions inside
the usb-legacy PHY driver, use the phy-qcom-qmp-common.h header.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c | 64 ++++----------------------
 1 file changed, 8 insertions(+), 56 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
index 8bf951b0490cfd811635df8940de1b789e21b46c..ddb52c1812dd02e15a840deee934c849405c2a98 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
@@ -20,6 +20,8 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
+#include "phy-qcom-qmp-common.h"
+
 #include "phy-qcom-qmp.h"
 #include "phy-qcom-qmp-pcs-misc-v3.h"
 #include "phy-qcom-qmp-pcs-usb-v4.h"
@@ -43,30 +45,6 @@
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
 
-struct qmp_phy_init_tbl {
-	unsigned int offset;
-	unsigned int val;
-	/*
-	 * mask of lanes for which this register is written
-	 * for cases when second lane needs different values
-	 */
-	u8 lane_mask;
-};
-
-#define QMP_PHY_INIT_CFG(o, v)		\
-	{				\
-		.offset = o,		\
-		.val = v,		\
-		.lane_mask = 0xff,	\
-	}
-
-#define QMP_PHY_INIT_CFG_LANE(o, v, l)	\
-	{				\
-		.offset = o,		\
-		.val = v,		\
-		.lane_mask = l,		\
-	}
-
 /* set of registers with offsets different per-PHY */
 enum qphy_reg_layout {
 	/* PCS registers */
@@ -698,32 +676,6 @@ static const struct qmp_phy_cfg sm8350_usb3phy_cfg = {
 	.pcs_usb_offset		= 0x300,
 };
 
-static void qmp_usb_legacy_configure_lane(void __iomem *base,
-					const struct qmp_phy_init_tbl tbl[],
-					int num,
-					u8 lane_mask)
-{
-	int i;
-	const struct qmp_phy_init_tbl *t = tbl;
-
-	if (!t)
-		return;
-
-	for (i = 0; i < num; i++, t++) {
-		if (!(t->lane_mask & lane_mask))
-			continue;
-
-		writel(t->val, base + t->offset);
-	}
-}
-
-static void qmp_usb_legacy_configure(void __iomem *base,
-				   const struct qmp_phy_init_tbl tbl[],
-				   int num)
-{
-	qmp_usb_legacy_configure_lane(base, tbl, num, 0xff);
-}
-
 static int qmp_usb_legacy_serdes_init(struct qmp_usb *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -731,7 +683,7 @@ static int qmp_usb_legacy_serdes_init(struct qmp_usb *qmp)
 	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
 	int serdes_tbl_num = cfg->serdes_tbl_num;
 
-	qmp_usb_legacy_configure(serdes, serdes_tbl, serdes_tbl_num);
+	qmp_configure(qmp->dev, serdes, serdes_tbl, serdes_tbl_num);
 
 	return 0;
 }
@@ -840,13 +792,13 @@ static int qmp_usb_legacy_power_on(struct phy *phy)
 	}
 
 	/* Tx, Rx, and PCS configurations */
-	qmp_usb_legacy_configure_lane(tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
-	qmp_usb_legacy_configure_lane(rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
+	qmp_configure_lane(qmp->dev, tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
+	qmp_configure_lane(qmp->dev, rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
 
-	qmp_usb_legacy_configure_lane(qmp->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
-	qmp_usb_legacy_configure_lane(qmp->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
+	qmp_configure_lane(qmp->dev, qmp->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
+	qmp_configure_lane(qmp->dev, qmp->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
 
-	qmp_usb_legacy_configure(pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
+	qmp_configure(qmp->dev, pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
 	usleep_range(10, 20);
 

-- 
2.47.3


