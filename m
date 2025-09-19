Return-Path: <linux-kernel+bounces-824701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5DCB89F14
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A1C189847B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C2C3161BE;
	Fri, 19 Sep 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KG30EoIj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39743164A7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291957; cv=none; b=C+a++p5G3kGRYtQuqmdiar6hBcBHjalOyj8HiidFdH2pW6COs+h0DiWblSd0o/kmuMgPuTwD+2h+Z//KbLtgQYRfSpheP0Q0QrBFp/G67lcx8TZxBFiwKPfMnX+e5KTU2476BD55N7Ij/ca8o4Cp5P/4qjIi/3jR8XSRPns19HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291957; c=relaxed/simple;
	bh=X6747pX/z+HXPUbzpVscGZ+y7P+DLT2Ka1aFOv7nPv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gnujeuqQOY8sz8aJteX8cjg8V/fYA7UqfPCU93Pp02QA3IqyIsaBUSEJfAnDXDxJLQfojGoAqfsF2RR+SKvpI2ITKIXI2LTOWkRUSJQPumnIdvLRNcsN4QZ6byTt2zjxd5Vl659sM80u/b3ab6m96bBjf7/Y9IVOBvyNTJweoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KG30EoIj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JE8fbm029493
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4NPGHZZG6XJ298+gcQuKbhaG+vQUCP3RgV4uBh+3CL8=; b=KG30EoIjYXW9CY4B
	BF2pcR4slxppGfefFAtOnTz7qERmPJqIqcrn4TaUD4NfU0XU6g5LTGBzoXgqDjG8
	vJBId/NsBgTDvU5Q/u/pPArppULMDrq9YSrmHMpF5V4+IGJ25uoBIdFt2JqZJbvT
	Te6zI6rQejM6P3HlTmoI0miXRLU6OwR6u6vIA2LlO94XGBdSmR2d6y8W30iMhumC
	QZOIivBZ3KWzpT6CCWWxdIUdItPJVpLj1GoPzfX2uLe4f9SBmf6rmeFhG33lHEQ3
	bqQSgp+1jHACHY40yUFHmbCLCD1h6XBF73k1yfGKRzuRITk++O/BSktYqsdoL49x
	NXyvQg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy12pjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2680b3acdf0so4570445ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291954; x=1758896754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NPGHZZG6XJ298+gcQuKbhaG+vQUCP3RgV4uBh+3CL8=;
        b=pgmAKfQZ1f31JUSZDpXfsRaFmaFqAIDdaWKPROkzux0SZTibnPcUjrxVwOROWn6gK8
         diSLbpMloYt76OztrJ1QBYfYAjcrxptYu7h9G9OMuFQyLQByy9ZBnnasCq2WZ9SnRN0s
         klyQb8uywHdqKyBeecRq0ZyGhcyAa9ngUZbgjEPyKXpUqZKeDfHaG+jLEvOaQ3AZ/Vu8
         9u8EzGRaNpD6PQm2bHfRMaC4XWDfWe/TK+DAWSLdMfrXCsGPvF4wAebduQy6qp5xX47M
         NtMyVj2t3QLdIPv/Yy92D3L5SiHeHE5LBM6f2ECpwIy+K3it9lAQEzdo6jxswk7FW02t
         MNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo4Bci7oXRBtFip2POGynrPJl2cxngbrw0LPu7VmgHHo2FPIC1GA8JRPzor/WBhILgTXxPUB44qKCfb3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy78Niug5KBB+SdJ489Bugd+C+wgvOKseKNXxOh5v787P1PHHnb
	gcnQhQSPUhAfjFRJOVIxAwu1Mcaf4OlPIKeYPdxmP+VCZ+e1SDDs7r54WXorpYBEbZHruW1FI/9
	yX0jxev227nWLwlxHkiBho5fYFqm4PqMYMpImIHORzJ4Ojc4IUF9W1otJhM0TGXuyp8Q=
X-Gm-Gg: ASbGncuJov/KrIkf0AJ+mBKaB3VBbXWF4lTj0gyQQz2Md/BVQ7Q/Sh6qGuaoZnT5arV
	Mq1klpNWAY337JwHfykZG3J9424nL8qaOMOSPweJRgdU/WcR1vl62sV7033qSNgBy0yWi2veo8e
	ASvvKCrSCMSvx7UQC0fLTwc6ivxgndPzdSTQyBuhguujrKEacrMwbV+weEFr0RnbQOdayKohspZ
	ZN4vP+62400CrLlEiz8dONeqKz9ELCIPvEs8bHBT64ITcoFdDzF2FslXkX6nUKSJjIzFFWxMCvN
	TIxn61MPbtqdWCzdKdk94Y/H2GlRnbdp5d6DMg3MPEMQNgvi1ETARLRm5RDg7pn6NR0HSWMdqHS
	/spBYfv7MP94kbg==
X-Received: by 2002:a17:902:e805:b0:267:b312:9cd8 with SMTP id d9443c01a7336-269ba5477ffmr23548365ad.8.1758291953908;
        Fri, 19 Sep 2025 07:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhWf2RyPDPG5JNlEIwfeKF5HBQZnjfl4KQdteIogUTd9k5aZvCF48gGr20YVSz2GhdBqTvZA==
X-Received: by 2002:a17:902:e805:b0:267:b312:9cd8 with SMTP id d9443c01a7336-269ba5477ffmr23548105ad.8.1758291953373;
        Fri, 19 Sep 2025 07:25:53 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e80409ee3sm2210035ad.80.2025.09.19.07.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:25:52 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 22:24:24 +0800
Subject: [PATCH v5 07/14] phy: qcom: qmp-usbc: Move USB-only init to
 usb_power_on
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-add-displayport-support-for-qcs615-platform-v5-7-eae6681f4002@oss.qualcomm.com>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
In-Reply-To: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758291894; l=2160;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=X6747pX/z+HXPUbzpVscGZ+y7P+DLT2Ka1aFOv7nPv4=;
 b=SSWMxTP2f7OASGPCipXSWGNWwHj7K6Mc91TPyvdWPxTeS5cOPpYMfWRQHbNxnmcxvYFsI1FKL
 cF4Y8nqexATB6dv66j+Lt7F8NuZOncIpFaP8S1YPyoHfwOMj7NrfW4w
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: 0NU8vW3x7N4aU2aNj8Er9GNYzLy5QcXE
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cd67f3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lTgBPn2m1EfcVYAV3zkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 0NU8vW3x7N4aU2aNj8Er9GNYzLy5QcXE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX4FJulg2YFPBO
 U4bZmFtle3lQl1ay5t/mJFoevj8GPwZDwEUWASDJp2Y1jc3Im4oVP07gzRLsA3yZ9nuGeZ1TRDB
 IN4wzftV2mCkqeF08z+DKrbE15qP8imsKvpTXWHBUFqmaugFpHc5kwKEO0P8a/7sOjSpDz2r78R
 aZ9P0J2EvPJ6kKXUqU9VMCX6VIvkii+UQaqpiPxopC/F3nEownXi3nTorybbOhSQquX/ZFV+rMj
 0nliJgu3+8DPyB85tm9d1kY3ejvo+i5ojI+4wBQMNVU+uVDNFy2N2mMv4iLxyfJStkpFvxOdXdF
 me3FqILxJD8LlombjBlCtmsPgUf8PEnPTqGs2KOHm7a6bJoWtuGFeF1hRgMnvUnxc62qG7O0VkM
 o2xfTgF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Move USB-only register setup from com_init to qmp_usbc_usb_power_on,
so it runs only for USB mode.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index bfb94fa1a86cc52e1c67f954376d5fd8d321f4f3..d570ce486aee8e8a3cf3f7bb312a00bc1cd03d82 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -30,6 +30,8 @@
 #include "phy-qcom-qmp-pcs-misc-v3.h"
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
+#define SW_PORTSELECT_VAL			BIT(0)
+#define SW_PORTSELECT_MUX			BIT(1)
 
 /* set of registers with offsets different per-PHY */
 enum qphy_reg_layout {
@@ -535,8 +537,6 @@ static int qmp_usbc_com_init(struct phy *phy)
 {
 	struct qmp_usbc *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	void __iomem *pcs = qmp->pcs;
-	u32 val = 0;
 	int ret;
 
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
@@ -561,16 +561,6 @@ static int qmp_usbc_com_init(struct phy *phy)
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
@@ -603,6 +593,14 @@ static int qmp_usbc_usb_power_on(struct phy *phy)
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


