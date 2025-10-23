Return-Path: <linux-kernel+bounces-866569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B0C001AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AD33A3AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218A32FD7A4;
	Thu, 23 Oct 2025 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B1EL2lBW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988562F6933
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210394; cv=none; b=MMT7+l50QbXslClP91eFgvt4G5ScG/RlCPFcBuuL+/DfLmsjenV6l52mUpVdQCpJ4+BQqWL09MNGniQxQPar0l8QkewcZxSTAuJ5GNM4XZognnRCvC+ahILxyTm8yDe3KQAPln2/2HrmOZHdp/7uW+8ilytDujbrQtHg3QhfwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210394; c=relaxed/simple;
	bh=xwACydKQvgDKuB0v3VRVNVKaf/7fL95Co83H8L4/8V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WjkLpnkx24vKb7pfBJzXejVwdYKfTew8D/qgWtEVQ0M4qu1bcoOApPrPqlbejb7tVHh9iqLw6s1C3zean1LnddwQN2KFjP3/h9jI2diQf09COOJioKG50kQ7+2tP8pMYttWDOkJXjMMzq5oq7hAiGy5pbr2jwdsekYK8TdgkByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B1EL2lBW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6NGY5016465
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Tbyvd4eRGssa6Ha0ecVbsY
	tSBYVsX1t2xVyxXt94ET0=; b=B1EL2lBWBnN34927WafsHwonB2UGuLi6pZlOPk
	OmgCYq64xuesQ06vVKEV8RP0vsd4sSzRxd0gTT0R4Eyudf45C5sy4YP3gkPSY9UT
	fJaLnL7Fs1C3+YIISCWROoisShsWMo2XmUJJUkX5ygH2TxPpi+nWhgLteODJW8bA
	K2O+tvRHwr4ZT7BTjsSISqqhRpo61PrimoiemBqMBq7IOfjlYfiM8JsOqeFwyAug
	+jgfJgEAut9gOLibsCJoPHo5a3VSq2dnDQH5Wv9boiBgPfTg6RUURWkWfmthRRrW
	CpTCeRSotwd8MUIMId8ojRylX4dMNYWYhFA8tPbMy1+3PClQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsdc5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:06:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2698b5fbe5bso9284435ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210391; x=1761815191;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tbyvd4eRGssa6Ha0ecVbsYtSBYVsX1t2xVyxXt94ET0=;
        b=sP/RPZwKfJz+3FrJHZO1vLWvVn2MUh4W7ZOpjlthm0Scu8Em6H1ltsHgUU3sl8rBfI
         MqvFl8qUZysUPm3QmAlCocirP1ogAAGqqPi7NURD4GjaiYdrIx0X/a2f8HK5CsUSY4ik
         y8WaKvlkXCuc2+YJkar99LjM7qB1wsp9WbGe4PGbKAe7nZXPXy4EWh/HYfC1nvaKOI0J
         Oit4KFl8HxVkixAGDjLUhyj0l69DU+yYU1DpeHRsfstTkcfTB0jgWkRJFF19LNNZTRz1
         361CV5+xbeMN/Dv/Ur9gm3+B3HxLwmSZww6bmQ/O3cY6VwwKuWXi5y9fh22Zh8U8Kcdl
         fn/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnkOs0hS44APK66b6Vy3pPoUGoQtQjyfB2iDIR0NjIPr85rVUH1HK40zZ6OOqRJupGy94vkCNDPYB59XE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkyf4NtB4UqBdP7Lr2pcFaVwdSwBcz/hVXHcPSf8VNtK7MR8to
	Umusg8exXzwaV6saWlzHQy31SGKek+AlaqGOg6MS/YVshtpZlDVT54wItoih9pRDWstfG6Q8t4/
	pWoP2Eel2xqk8B40K8tClM5ycv6wCVAMth2yye9RSi+Scxp29o013XaUlL22GxZdBpCQ=
X-Gm-Gg: ASbGncuITYmO/ra3i+BLNJaClIQPkIHA52DE9LMDmp1aKY9reWnGMfJKpoAibP/QCXM
	vwg1cYXw6SZrksR5qoSrBCrfSToSeT/db8P9WPcJibtGi+3KozPRDEsElyhGBbUjZP29FKXui0e
	np8fktqSSCmXc1GrK3eCB2ojq0O/SUIsgfktdkoT/zng6PMyUfk/etykd7Iy+5f9pB9k0DNsDyW
	mewJci/fOwO+Qbrdmrjh4zxQY57jLp5mbpguNmb/EnLC53hKtLGjDRWYvQEgNwfaujimunlcCeQ
	RjGJozsY4o0k4j++0AlgaShLEEOqS67Nd5RNTrjID3LvdBAC+l5gVOEugbQ3NEOcuxvh0TeTW1e
	VmAqsINAHPlPbM1tynrWYY8Edn1xGJbmKtF7u7mWzOQ7kl9T83sAzYw==
X-Received: by 2002:a17:902:ec87:b0:269:82a5:fa19 with SMTP id d9443c01a7336-290cb07cbbbmr274605415ad.45.1761210390987;
        Thu, 23 Oct 2025 02:06:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXtnMJKSahTr3YrUSbYlgQcd+PhongCRbCPX3M+/vpJqbpLoH+wusz0Lz81kTeDHbmGQz8pA==
X-Received: by 2002:a17:902:ec87:b0:269:82a5:fa19 with SMTP id d9443c01a7336-290cb07cbbbmr274605095ad.45.1761210390516;
        Thu, 23 Oct 2025 02:06:30 -0700 (PDT)
Received: from hu-hangxian-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfc1c8asm16698685ad.71.2025.10.23.02.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 02:06:30 -0700 (PDT)
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 02:06:26 -0700
Subject: [PATCH] media: camss: csiphy: Make CSIPHY status macro
 cross-platform
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-make-csiphy-status-macro-cross-platform-v1-1-5746446dfdc6@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABHw+WgC/x2NQQrCQAxFr1KyNjAzpaBeRVyEaWqDtjMkoyild
 29w8RbvLf7fwFiFDa7dBsofMSmrSzx1kGdaH4wyukMKaYghRVzoyZhN6vxDa9Te5ilrQccM64v
 aVHTBob+EMcd0Jmbwtao8yff/dLvv+wHpHkPYeQAAAA==
X-Change-ID: 20251021-make-csiphy-status-macro-cross-platform-5390dc128aee
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX/yBNSXGN8cA3
 OhAou4GntyzS+sLJcdQ02Fc1A3eRVxllsBY7Xuyrptpspk3CAdeEUblKuI3X9LZwmNuZ6cRMiH7
 /uHaDq6J/82f8yrtiG82bT+1Osa/38RU+7xB/OviG5bgtu5E2N/Q/HHz4YuFgehUJFdNhFYS9A5
 FjjS04DrssgpLPH/i6K1j3zLb/+vP1EBk8SMXmeCi1/o1hSfdprgODrm/ffzHYU2N0x0O2y/ZMO
 mShiwxUY/TIRY58lBMgx+fiZ1E4e7JGiWBBbXtmHgtK/fZ5HpmYgAiPEaGJ0LqZZ89X0NhTlnnB
 LgmI+a+uY8mmmgRGZgvKdGPZJyY4zsBCn2QGPRHJpubkLGXdtby+/YXIDvqXucKruhyL09Lc+su
 xXdK1hrbnBNjIiEzRaymJi0ahjhX/w==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68f9f017 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=edmtyYkapI0WV9tsjtgA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: PPJhKEZpsQrgACOk2Majlh3Q-8Hhlf-v
X-Proofpoint-ORIG-GUID: PPJhKEZpsQrgACOk2Majlh3Q-8Hhlf-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

The current value of '0xb0' that represents the offset to the status
registers within the common registers of the CSIPHY has been changed on
the newer SOCs and it requires generalizing the macro using a new
variable 'common_status_offset'. This variable is initialized in the
csiphy_init() function.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
---
This change introduces common_status_offset to replace the hardcoded
offset in CSIPHY_3PH_CMN_CSI_COMMON_STATUSn.
---
 .../media/platform/qcom/camss/camss-csiphy-3ph-1-0.c  | 19 +++++++++++++------
 drivers/media/platform/qcom/camss/camss-csiphy.h      |  1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index a229ba04b158..9b6a0535cdf8 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -46,7 +46,8 @@
 #define CSIPHY_3PH_CMN_CSI_COMMON_CTRL5_CLK_ENABLE	BIT(7)
 #define CSIPHY_3PH_CMN_CSI_COMMON_CTRL6_COMMON_PWRDN_B	BIT(0)
 #define CSIPHY_3PH_CMN_CSI_COMMON_CTRL6_SHOW_REV_ID	BIT(1)
-#define CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(offset, n)	((offset) + 0xb0 + 0x4 * (n))
+#define CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(offset, common_status_offset, n) \
+	((offset) + (common_status_offset) + 0x4 * (n))
 
 #define CSIPHY_DEFAULT_PARAMS		0
 #define CSIPHY_LANE_ENABLE		1
@@ -714,13 +715,17 @@ static void csiphy_hw_version_read(struct csiphy_device *csiphy,
 	       CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(regs->offset, 6));
 
 	hw_version = readl_relaxed(csiphy->base +
-				   CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(regs->offset, 12));
+		CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(regs->offset,
+						  regs->common_status_offset, 12));
 	hw_version |= readl_relaxed(csiphy->base +
-				   CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(regs->offset, 13)) << 8;
+		CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(regs->offset,
+						  regs->common_status_offset, 13)) << 8;
 	hw_version |= readl_relaxed(csiphy->base +
-				   CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(regs->offset, 14)) << 16;
+		CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(regs->offset,
+						  regs->common_status_offset, 14)) << 16;
 	hw_version |= readl_relaxed(csiphy->base +
-				   CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(regs->offset, 15)) << 24;
+		CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(regs->offset,
+						  regs->common_status_offset, 15)) << 24;
 
 	dev_dbg(dev, "CSIPHY 3PH HW Version = 0x%08x\n", hw_version);
 }
@@ -749,7 +754,8 @@ static irqreturn_t csiphy_isr(int irq, void *dev)
 	for (i = 0; i < 11; i++) {
 		int c = i + 22;
 		u8 val = readl_relaxed(csiphy->base +
-				       CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(regs->offset, i));
+			CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(regs->offset,
+							  regs->common_status_offset, i));
 
 		writel_relaxed(val, csiphy->base +
 			       CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(regs->offset, c));
@@ -989,6 +995,7 @@ static int csiphy_init(struct csiphy_device *csiphy)
 
 	csiphy->regs = regs;
 	regs->offset = 0x800;
+	regs->common_status_offset = 0xb0;
 
 	switch (csiphy->camss->res->version) {
 	case CAMSS_845:
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.h b/drivers/media/platform/qcom/camss/camss-csiphy.h
index 895f80003c44..2d5054819df7 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.h
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.h
@@ -90,6 +90,7 @@ struct csiphy_device_regs {
 	const struct csiphy_lane_regs *lane_regs;
 	int lane_array_size;
 	u32 offset;
+	u32 common_status_offset;
 };
 
 struct csiphy_device {

---
base-commit: 076fb8624c282c10aa8add9a4ae2d9354d2594cb
change-id: 20251021-make-csiphy-status-macro-cross-platform-5390dc128aee

Best regards,
-- 
Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>


