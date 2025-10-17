Return-Path: <linux-kernel+bounces-858743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1977BEBB27
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A01ED4E3542
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F60259CB6;
	Fri, 17 Oct 2025 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YE0P+VuH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0B264A76
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760733295; cv=none; b=PvZqw6Nlorl3CR//7Zb8jWzeg+sAoG3V1VBj1EzkO5SuS2TRb7LWsbxaO6QCDJzJlw2PXW0AgKSR4u0eMD4UvNUJtSSYYqUhEbp2q9PWOvGEk9gzKX4oB4ZLIvU3lB0qp6AAYNExNEyDTAlor+aureRy226wgkf3vrYgjWOZ2+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760733295; c=relaxed/simple;
	bh=42h9WSzMxsMUKDKrWXddy7f79A2qL8IcQSDKGHUFEPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T+xhEc7YsEklsRyzWUf/3fXe/zEfQ0sBsaoJQ+Ewur7YMxnz2uQMUpxZNC9HXM/mQ8Fi7aQDRzNK+P/bdv0cym6S7FmM9IZ7rDVqde2VID3+zSwKwlcZLLZHFsbl3O8siQUg6QdsVKxQQF84sOpPwbdZtEx4RCr4bFmjQwbMAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YE0P+VuH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJGmmT005388
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oEl0y/mrPeKiP6ZEhHI8gxlLx/zzQxxwPZk
	FL4UCulg=; b=YE0P+VuHAAntcQPIu2XocWH6w7YDJMBwSwQ9FxrOSkyTvJGBAkj
	S0EGsr93+tWrkjXOyJ2H117yW9hS1Pkw5hsn+meKiA66/SVBr4i1YPEVibM5YTZ7
	cYMaABFuXOFbZOhdTUFkroNa7WBRcEOCkRJO13w5vWthUm/xcgqsnge7QjF24zyx
	Aa6yziQ9K73GZmHkW0qrCzAFrhiU/e5/vF310rOIWkOWTdwIv+GhYNHuRbbLh66C
	fuqYCoOWFnd0Ao6knx20Mp+C0ngXFyoqk9wsOcXjkAUXZtrioC2vesFBSHtQuIVX
	+oCITS47+sqdIATiJNndv5PjzCn5pSMRI3g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5wt3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:34:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-272b7bdf41fso30952805ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760733291; x=1761338091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEl0y/mrPeKiP6ZEhHI8gxlLx/zzQxxwPZkFL4UCulg=;
        b=HSYx0aNmZE8/Os8ETteH32qOfaeSudjG6LWUaD3dCZ3Y96CREPU2O3QZqOQYCahWf/
         iMjzTr52PX7Sfl8pjyuom1+dk0S835h4Utd1OzyreYbezKMbSCcApKuwTpJ6IOxWpqFl
         OBdHSNmdiuVxn9Pupv4/G54WcOQS0/Hq+6frSW13/AMavlrdY6CDBcwg6DwZli1ktuQf
         EkW1F6jORruIepHHxU0Ypvy9gSm01QzcjAiQr5fDVAQjPcV0Oq7RbtgJXro7619qYePv
         sETu3qCZHlBC0leVaan0CKDciUW+IN9fULmAjGVyz4ePS+L9DKWQQQ0S47hMJuAvRNk4
         M2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl6EEf9sVrKf7wWuZi6GaDiFRfrgyU/yEt3Je0bKu8uezJuQklodqKgeFPN8l5H4D1BrOUQWW6sAiFPLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2KvCSOgVNYbU+QDWVR6VaYbjhtOQJQcKUkUSdMGnL5p4bodi
	ehNxL00jULGumITrY12lrdDVLcmX0HLgr1F49bmQQft4a9G+tKvrQ9khMIP/4t4p5RMfibOA5qi
	uGHSY015n18EIErV8sZYzeOJJK/ZkBfUgMsieIS78SL2sMFNvxCCCp9bPKvAMtuamJo8=
X-Gm-Gg: ASbGncsDjbUooTZdy48401zoC8bTZFr6fxLGrqbMwfLUQ87Fsqa4NZe1zZIwqaCxPa+
	zEBJGprEykSqN8MFxzV/xkv9AwpExFYYcLrlcvd7KhMqvXHy182aR79UpX3jhzgcnX1zo1l52Z7
	0Nb9FbAqkPj6aM83drUt8eQXmy66qzRKrCIHlbZtIpVKQEn9xPb3IsB60ox1AwKtpcVj7idwtNl
	wg87+FPAnoM6SjdnF/M9/oJoBcv4dhsM+Cr5wGS9mKapWJq43A1RgO0WHQQ7q3Qlgg0ghSMwdqL
	muiOEi2H0L7la0DGf9Kq7dnHFupTbGcEfb1akq8SFLQYHs97e/ATOxKUfH975oX5Ww7zslByBYX
	CYuChKfCrGY+Ov4ZsMxTX9ZbQBSDAoJurDlPY
X-Received: by 2002:a17:902:f70f:b0:290:c3ad:8432 with SMTP id d9443c01a7336-290cb65b628mr57435355ad.46.1760733291376;
        Fri, 17 Oct 2025 13:34:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyX8Pk5DWSmJTsM6HLUZcbzX8C/j29RAvl1Yd/dyx9V0AATvuYl8gaM8mWgVvFK0PQX18sbg==
X-Received: by 2002:a17:902:f70f:b0:290:c3ad:8432 with SMTP id d9443c01a7336-290cb65b628mr57435115ad.46.1760733290959;
        Fri, 17 Oct 2025 13:34:50 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b33505sm627897a12.22.2025.10.17.13.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:34:50 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH] phy: qcom: qmp-combo: Add polarity inversion support for SAR2130P
Date: Sat, 18 Oct 2025 02:04:38 +0530
Message-Id: <20251017203438.744197-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NAfwnMPVAoHrN1u0dZ_dYUh1Jmg0SV65
X-Proofpoint-ORIG-GUID: NAfwnMPVAoHrN1u0dZ_dYUh1Jmg0SV65
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX+sVnaPh2EAnK
 nXCPYPK9Tp8OPLL9VsbOzFJsIZD+Gq9tiYFEH3PpO0nLhG+QZkqhuGvnNAfe9nT41cLRrPKzNH7
 TTh/NouTVD/r8IzbIfzL9064QsBJmRsoVBer+sQCnxHD8q/AtYCTgq9BgbCjq3UXbRzlvWCvSC8
 QxEIHaW8OrrDWjKGtXMuYrqqODMk1FYpkFQaQgPyVE9UqHWRDwy83HmzX9ZB5BGJhrBwjgbX26r
 sPpVxMzi4r4Fwj3Ku46cNMpK+S3jSMq1G/RiY1GfY3OgbbNKxM05A/CX56x0xQTfuCPBVBA+4JH
 Cvhy+7RKOjHcNTZyiBVz4E6JQQr4YoB3jKetbmUOW0/aO5RUGDk0PZS8i48/MOCj/I8yOTs7NAG
 eRqmkybsGfri7mPS1KzXryNOkWRjdg==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68f2a86c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=LWLmvgxapxzxGbpwlLUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

On SAR2130P QXR Platform, the CC Lines are inverted and the lane
programming is to be done reverse compared to other targets.

As per the HW specifics, Bit-2 of TYPEC_CTRL register indicates
port select polarity. This bit is to be set for SAR2130P.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 7b5af30f1d02..813c88f0a16f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -60,6 +60,7 @@
 /* QPHY_V3_DP_COM_TYPEC_CTRL register bits */
 #define SW_PORTSELECT_VAL			BIT(0)
 #define SW_PORTSELECT_MUX			BIT(1)
+#define INVERT_CC_POLARITY			BIT(2)
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
 
@@ -1820,6 +1821,7 @@ struct qmp_phy_cfg {
 	/* Offset from PCS to PCS_USB region */
 	unsigned int pcs_usb_offset;
 
+	bool invert_cc_polarity;
 };
 
 struct qmp_combo {
@@ -2010,6 +2012,7 @@ static const struct qmp_phy_cfg sar2130p_usb3dpphy_cfg = {
 	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.invert_cc_polarity     = true,
 };
 
 static const struct qmp_phy_cfg sc7180_usb3dpphy_cfg = {
@@ -3046,6 +3049,10 @@ static int qmp_combo_com_init(struct qmp_combo *qmp, bool force)
 	val = SW_PORTSELECT_MUX;
 	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
 		val |= SW_PORTSELECT_VAL;
+
+	if (cfg->invert_cc_polarity)
+		val |= INVERT_CC_POLARITY;
+
 	writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
 
 	switch (qmp->qmpphy_mode) {
-- 
2.34.1


