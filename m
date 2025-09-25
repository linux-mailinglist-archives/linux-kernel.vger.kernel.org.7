Return-Path: <linux-kernel+bounces-831879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331D1B9DC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AB31B2679E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6525D2EAB84;
	Thu, 25 Sep 2025 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mFrevY6y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D782EAB83
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783971; cv=none; b=NeUvFpPN3jnB6evgII1WK+rgh3lCWLzju11tK0aHfsr3Xd1O+m5ry0p7roiRWJ0u3nHVdQR2GWv8vQAF7vDAnkyjLn9c8eoOGIZrbJnIuQNlc7BbVcG7zI8cGUIpUX+DbgPzj7dmQ9IoQInOPC0rW/TBRlwxgYPo4wdBW/SeKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783971; c=relaxed/simple;
	bh=2OW0hX9TF4LQlObLysgxoFrzLXkqUgu/cavYoT3SHP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlMut37q7RdmqjF3jgcfI68FG+A6KVd4Q0JEpVFXUXzwz+r8KAQ3rk/cFy10NROFk3EUEbj85HPj/60MPPjreLxzT4tR6080tdnEPQnteXUGPswseE+89w6PSsvbhRH1G0GUH2lTAJbUHCW//HXOaYhpnCU4uJ5axizl3wdUmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mFrevY6y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1GdWD002789
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IxgE0hKaY239kxGeqZ+8x/JCG89cRYkF0bkaQ2dVCzM=; b=mFrevY6ycobFm4F3
	AKnprbvloiBNdlfGAw6CJph+D1IOBgdWLan8NptDUin9rEm6/9B6rry8SwlTPCKw
	cpoBPbNO4ivPkKV2tvzoXs8n+reW8hA/FShtfkMTolDVB3K5xCOYbwOGu4YTDYxz
	brwxOn/d0Kk351N7oMMKevVB1rS0eNJ3bJpLhMEX52Ah2nRRg69TGN8cuD3499Zc
	kTcy3ybrwGLUMhLEVJlM/lG1ibDdYidh1jUeHLNs+kaBVZRhFmwz4CBfeahQf31V
	oco0IEJc9Pd9STaD1vbJLK2ks2QuLxK6YTrP2FO35hJyh+0ZYvXNZ6fkhnxrLpr9
	9gmjrA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf1nvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eddb7bad7so188740a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758783968; x=1759388768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxgE0hKaY239kxGeqZ+8x/JCG89cRYkF0bkaQ2dVCzM=;
        b=iqZRhikcBwdz5zVffPs1N4pwavGo1vWaOD120un5BdOyqBwqNMVv1xQYoM4uRzMOcR
         Yf4TfN21b48/3I52Vd15lxtCf+oHPs9lkgw6aDrxGynqh11PjwaW2ZI1DL3q5qt8nTH3
         dmRDfPb1HVJtDrj1zwLe146ClAx5tiI89+RmIKYz9qJ9OsEWB1EIZVK4LxMTeQSB9Zp3
         oCjCzs7pDOhFxAQ4uE12psIaqrYiPWuhC+yfLWIg6A5h0Jn2KjOPjfTRU8dt7BciB2r2
         V/QqJgPvfticskquSz3CH7sJJpepdHp/kUQ6n02IU6uEUGKlDrRBe6ZUSvkm08KgeqRW
         IBNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmM981ezy4VeEOc7EZ99wJRpJneT59zKNeBivaRm3oJfSX0cV9qp+A7ni0BPcNw+4EkhMiGnA2BmcSt1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXBCD6/XuZ1IH7zRbe4ZR4RxRDJXvwcleSgNLHbNYsE1vdDoxn
	mwN9ZsmzFZAJ24T/4GdzUm0y0Bx0aTmIxw90uHs8KqltN6YdRKJKN+hd1+9hm7eEY/i1yn/2AML
	CPnq14GKCkP2Cjt2/LO/a66SBfFS+Jo+tjCgv/dwoaXflOJrdUbdelLmML3jYOdRMus4=
X-Gm-Gg: ASbGncu+nLBV6eOR+3ZE6NUADOG5ODk7/Gu13lp1TAhOAApDMqksh3Zx9BnjgoawKJg
	T13wVhajeQnx5/UHN1CxaKRcz/GvRQDXSBGzJgpeM+6KnoEuX3hvELsS0ssr7goOgymk2ztJ6K5
	WJCzj5grwMkJAx2zBe3/wRQob0f+r4OdAQf/RvKDkDULlYmfzIE+hxFi+Fsp4v1awV6v94J2jVu
	0UR9XtF85E4VECHuxygQVdoorU64QSfdV6HERwVr66OGNNnImRWGiM0ZAKRW87aXE1X5/9AtL8Q
	1icvZKR7h9Kww9TCwN/TXCda3BICxpMeCTun6H2Xips9IlKyZuxCvFrTyTprsXIN4UaTeN8J8cs
	aOvJUek+Cz7Jz7HDSrgIw3gbiydOc/BM3gpuj3p8qNiwYmB44aDBRy001
X-Received: by 2002:a17:90b:1a81:b0:32e:1213:1ec1 with SMTP id 98e67ed59e1d1-3342a2c1012mr1392348a91.3.1758783968298;
        Thu, 25 Sep 2025 00:06:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqm4vqi9INx9yrFdrRGXI6EToe4coF15uJ9HBu3jvVIDzDTGN/9Crhz4syIBdRqrXfjzrKqg==
X-Received: by 2002:a17:90b:1a81:b0:32e:1213:1ec1 with SMTP id 98e67ed59e1d1-3342a2c1012mr1392327a91.3.1758783967897;
        Thu, 25 Sep 2025 00:06:07 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3342a2bd584sm914253a91.0.2025.09.25.00.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:06:07 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:04:53 +0800
Subject: [PATCH v6 07/14] phy: qcom: qmp-usbc: Move USB-only init to
 usb_power_on
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-add-displayport-support-for-qcs615-platform-v6-7-419fe5963819@oss.qualcomm.com>
References: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
In-Reply-To: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
        li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758783910; l=2424;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=2OW0hX9TF4LQlObLysgxoFrzLXkqUgu/cavYoT3SHP8=;
 b=Zt3LO6ayN2gVmBZz9fMbnffGNND2tPNJsWMfyvfI7ZhWbNlv4laRaW2taqVXBUAQuoOOJ358i
 WNh/BeOChdWDMyylnbxEoajRmPXHQasqALO3KOps5erPlBA080l0SFx
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-GUID: XnbQoL-hxCz-PyZgqXuj_7KpfafvWcd7
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d4e9e1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JIg05Gv9We-wtn8mShgA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX39Vj8q+8NZet
 2K/gR62dYobo2Plqzac3zHTcoY/ugrxEbjLkHmwpoAUDVd30Uijo7EldsUCU51zYGs4Y8JDIDil
 K2uzZ8xvlPPuOp1Ud7gaW/pgLGEPvx8OzEBN7N0GZoGvHitTgQ5TNbexUDPtbMrRLclvUggrJje
 7oO50YCrsjIo8l3ZxTwfmehE5tSFzWxwoqybnIXraxyGxwppg+OhDgJTwflajzBS3BqjmSX2hSh
 WyDKUeIK7E9+vtcUUDHf4ljTfo64dDLwQAYPumi5Ar7XDLpS3B57aL4A/r7ibQZYCF8s7Xt2ht7
 vfSLKbWN0bfRUvcrLuQRuWUCgErgagnWjNUotVOZjtSiINM+rSVqanYQEVlt76dMAiTgrD4phiW
 1ocnRbxd
X-Proofpoint-ORIG-GUID: XnbQoL-hxCz-PyZgqXuj_7KpfafvWcd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

The current implementation programs USB-specific registers in
qmp_usbc_com_init(), which is shared by both USB and DP modes. This
causes unnecessary configuration when the PHY is used for DP.

Move USB-only register setup from com_init to qmp_usbc_usb_power_on,
so it runs only for USB mode.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 7139f4dab82fd7b0d1362dddefba178465e76fa4..a971bdc3e767727e69ea07b14d9a036347d365f4 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -30,6 +30,8 @@
 #include "phy-qcom-qmp-pcs-misc-v3.h"
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
+#define SW_PORTSELECT_VAL			BIT(0)
+#define SW_PORTSELECT_MUX			BIT(1)
 
 /* set of registers with offsets different per-PHY */
 enum qphy_reg_layout {
@@ -531,8 +533,6 @@ static int qmp_usbc_com_init(struct phy *phy)
 {
 	struct qmp_usbc *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	void __iomem *pcs = qmp->pcs;
-	u32 val = 0;
 	int ret;
 
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
@@ -557,16 +557,6 @@ static int qmp_usbc_com_init(struct phy *phy)
 	if (ret)
 		goto err_assert_reset;
 
-	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
-
-#define SW_PORTSELECT_VAL			BIT(0)
-#define SW_PORTSELECT_MUX			BIT(1)
-	/* Use software based port select and switch on typec orientation */
-	val = SW_PORTSELECT_MUX;
-	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
-		val |= SW_PORTSELECT_VAL;
-	writel(val, qmp->pcs_misc);
-
 	return 0;
 
 err_assert_reset:
@@ -599,6 +589,14 @@ static int qmp_usbc_usb_power_on(struct phy *phy)
 	unsigned int val;
 	int ret;
 
+	qphy_setbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
+
+	/* Use software based port select and switch on typec orientation */
+	val = SW_PORTSELECT_MUX;
+	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
+		val |= SW_PORTSELECT_VAL;
+	writel(val, qmp->pcs_misc);
+
 	qmp_configure(qmp->dev, qmp->serdes, cfg->serdes_tbl,
 		      cfg->serdes_tbl_num);
 

-- 
2.34.1


