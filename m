Return-Path: <linux-kernel+bounces-831440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0903B9CABA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68A51B208F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF8A2C1589;
	Wed, 24 Sep 2025 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hbhv7AT5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B332BE7A0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757191; cv=none; b=kHbp5MlHf6IGQHEnI9r8w/aGvEh2Zzklc34ug4olzG+knX6zb2qHinbotSqdfN4ImQxOwNIZP+mrhlK78+qNhhG9BUtLFHFw4uIN6wend3jtdm/DU+rfY+622QeWax1Y8p4Kq51Vmyz6WOnM/rsHUyLSwl6DOGhUv8hKBsiGono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757191; c=relaxed/simple;
	bh=w8ApOzB1Gr9aw+7jn1mSl8XSjjHxtf0wT1EwGWRkKGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bUTwtkJPautVb8X9OjnzALlhrbUhneWb5WVfmmt9wVnIFbxgFuJ3Bokih0rfg9eRoUuXnp2O/czzVvTk9EDMMFUNi6X+NEr/GnYk5GbQ88xNatwT0n6/YHtqiQfTO9T4Nd1zaeqGnLKwRjjG5BofDfEZdWWdQ8wiNnTKdOxxzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hbhv7AT5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODLLN4025133
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HaTaU6dnj9Z5K5hZ4O4XIOwohFdkjeE6Nh6GZtU8H1A=; b=Hbhv7AT5G07I3Q+c
	pQ0o0b6cNJrJNx2W+OBQN3gHPt3iwWQtPLM+8r15k5nhV6r32o/pwPWBeitwPgng
	D52MndLo6lRWYcfr/wJQ+nxYwbWBlTecv6tw5WwQ4ogzCR7uu0ggtrEL2p+tSbQc
	RKrd0NZBxWWJacVLCbD0hBVS2cdz4spZHxcw6G8SrsT6eNiFirCH/tazYwOKfk82
	kZRJL3j6ccSOahN1mDElC/DHH2njuIrso72FzFw4yFyIe0K1+n30S7D5+5yQ7uh9
	Jg+YlCmsLlAPYCz1wX1OS2PU0B1XifF4CZ64HYqqUBGwmEXWocJbR+IBkRP+W++X
	6XVyuw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv1633g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:39:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458274406so6983345ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757187; x=1759361987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaTaU6dnj9Z5K5hZ4O4XIOwohFdkjeE6Nh6GZtU8H1A=;
        b=tf0cPPZlfkm5gC1OSi4tmzh6/gL0tWacHbkBdIaOhbAkZGuNFKEIwrUOGDuglNsA4S
         FhmpFYt/xcUW5/DsOql/+KK+Tuc2w4iPu6D1yMLO/6NTMsXfR4XqijnaFhDIgxi7QC8s
         Y6MSiSvXL55uD65yD5cDuxAx9rJno0NNi87mKzF6/ikvGYtnzZ1QWBMgc4ZtDNDLLLNN
         A8KysGXg46/c28L2DJ6WhuLzdD3EzdxloiSB9W91tLys00Y9+bcd++EkB+pd40SxZon1
         lVCymcKiNlrnsiewVPc89uwIe7CGXIAQdCou90VQcGe4ny5CMfOjHR80KDmIMAYudK1a
         3fdg==
X-Forwarded-Encrypted: i=1; AJvYcCU7HRJNkTSUAWIRtVGA4BiZ/dlg7UIDUHDEPM6U2CnMSKjknu/nf0AkilR+eF8bGzsQ+YtdvUi8dbkaJw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwObB38DeR+Uzvr9qyHnLUL+7QX3P2EOS9sJqYD4pKj6LuQhYFZ
	MQG4QbzB0J5rGFHmMnUTsmbZzmvV11PyCfwgey+ocX0GqD/m5X59Slc0kVNTRYOZK28U0s7vgEn
	2DICOvUa0M6Sy426+Oiey7tfeL/8k6ySamBB38lZoi/ST1M9ZbItLeY9TnFZF9IziC18=
X-Gm-Gg: ASbGncuqEgceGJgKmVxSwDwl+9yEtvOYiSEgSNeviXSNOlX5roBbNAPVhi5+RMiF/TV
	aWh+vpcXLSCuGt+pjPKAhRaLaE0e3ObbrhnTv0MMVnzKoosrb5Vuvyh8if7hNYN8TWbTS+0Z15B
	mb9Un6bMPEBImBQvG0usDxQjvV4p3yVEheBT46cUgVSPb894M/zhPFsArVnHZH9egkKPC8Npq9h
	F4TQ4W5YSFIxLX77YWNkKWRnLZvZe2kV0vdLVG579Z8Uun+eKxoTzVJ892hW7eouww3OxYZxQAz
	YdCL1D9Zx7haB5/VeL9CdqG3jrkpvFy6LSbfOcIuYH09YmENGE541Z9ambVoCLLhGa7nHUu3fsj
	Is7rDzLPIUFrSzpM=
X-Received: by 2002:a17:902:d585:b0:24c:82ad:a503 with SMTP id d9443c01a7336-27ed4a56da8mr15801495ad.41.1758757187470;
        Wed, 24 Sep 2025 16:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvMHIzlLo2bXkmn1qg4WBil6XRgw2htBHHVbPkevjgBA+NeNjwX72HqENJe1CdZyKyTPR6gw==
X-Received: by 2002:a17:902:d585:b0:24c:82ad:a503 with SMTP id d9443c01a7336-27ed4a56da8mr15801305ad.41.1758757187062;
        Wed, 24 Sep 2025 16:39:47 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3acfsm4610045ad.20.2025.09.24.16.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:39:46 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:39:39 -0700
Subject: [PATCH 2/2] dmaengine: qcom: bam_dma: Add support for new crypto
 bam
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-bam-v1-2-c991273ddf63@oss.qualcomm.com>
References: <20250924-knp-bam-v1-0-c991273ddf63@oss.qualcomm.com>
In-Reply-To: <20250924-knp-bam-v1-0-c991273ddf63@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757183; l=2774;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=GEdBdzdIAX8fGpq8ae3liMKSkAOrGReyvTCj0gbYkOg=;
 b=oyIIuK/uFfpSrn7d7x80OB4pBmcdGVi0jIxpYQ7ogx1CKsFzI2pq55U9UGIcHSwzgRAH8Uswm
 y1gmg5OcCY2At/vfZ4JCau0HTq5u9uvmEwUBoh4MESEUd2hTP+sx/K4
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: 4rGKBOty0ghNl2wRoZoC7wK1-Kjqs5_L
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d48144 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=cFv7hCk4oO-93yei0aoA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX9RCNu8j0+XFe
 mSfArhN5pWnz2hOACdLXPzEbukABHJo9kZfnUHmJ6Sk3WxifCsEtfmIKH7vQKFSub07LiVHFCZ0
 xWImNSnyzeQbP7EO8aGM/yMxVYvo/w/Xz0wmRPyADYwPwsPNO4bopQ4zWW7pCV+nDCiEbr1KVHe
 hPl4LHGyfshvCFqft8S7pXwW3boOqJ3bRf3D2H4bFZA2bkAISyuJwwWlxJxyltXC8Dx09vNrlxP
 pdtq2n7uwaIsmAMuLlrBmy2886yXXYFzcUmZ/tw0EITl7axhWkq0eYdlN/mq6sP3gYZn4c2M+ak
 2T+sOoLQ7lIgzkLTpJHF6ApLBEi/eaPIkuNdZ8aS7pgenyZciAo0EgjXmli0+q8dvq+L5Rm2DTU
 QQ53+kKR
X-Proofpoint-ORIG-GUID: 4rGKBOty0ghNl2wRoZoC7wK1-Kjqs5_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

From: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>

A new revision of the crypto BAM called changes offsets
of the EE specific registers. Add support of this through
a new compatible string and register set.

Since a generic BAM module is deprecated and this new revision
is tied to crypto, naming it as such.

Signed-off-by: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 2cf060174795..06530e76ebc3 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -198,6 +198,35 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
 	[BAM_P_FIFO_SIZES]	= { 0x13820, 0x00, 0x1000, 0x00 },
 };
 
+static const struct reg_offset_data bam_crypto_v6_reg_info[] = {
+	[BAM_CTRL]		= { 0x00000, 0x00, 0x00, 0x00 },
+	[BAM_REVISION]		= { 0x01000, 0x00, 0x00, 0x00 },
+	[BAM_NUM_PIPES]		= { 0x01008, 0x00, 0x00, 0x00 },
+	[BAM_DESC_CNT_TRSHLD]	= { 0x00008, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_SRCS]		= { 0x03010, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_SRCS_MSK]	= { 0x03014, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_SRCS_UNMASKED]	= { 0x03018, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_STTS]		= { 0x00014, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_CLR]		= { 0x00018, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_EN]		= { 0x0001C, 0x00, 0x00, 0x00 },
+	[BAM_CNFG_BITS]		= { 0x0007C, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_SRCS_EE]	= { 0x03000, 0x00, 0x00, 0x1000 },
+	[BAM_IRQ_SRCS_MSK_EE]	= { 0x03004, 0x00, 0x00, 0x1000 },
+	[BAM_P_CTRL]		= { 0xC000, 0x1000, 0x00, 0x00 },
+	[BAM_P_RST]		= { 0xC004, 0x1000, 0x00, 0x00 },
+	[BAM_P_HALT]		= { 0xC008, 0x1000, 0x00, 0x00 },
+	[BAM_P_IRQ_STTS]	= { 0xC010, 0x1000, 0x00, 0x00 },
+	[BAM_P_IRQ_CLR]		= { 0xC014, 0x1000, 0x00, 0x00 },
+	[BAM_P_IRQ_EN]		= { 0xC018, 0x1000, 0x00, 0x00 },
+	[BAM_P_EVNT_DEST_ADDR]	= { 0xC82C, 0x00, 0x1000, 0x00 },
+	[BAM_P_EVNT_REG]	= { 0xC818, 0x00, 0x1000, 0x00 },
+	[BAM_P_SW_OFSTS]	= { 0xC800, 0x00, 0x1000, 0x00 },
+	[BAM_P_DATA_FIFO_ADDR]	= { 0xC824, 0x00, 0x1000, 0x00 },
+	[BAM_P_DESC_FIFO_ADDR]	= { 0xC81C, 0x00, 0x1000, 0x00 },
+	[BAM_P_EVNT_GEN_TRSHLD]	= { 0xC828, 0x00, 0x1000, 0x00 },
+	[BAM_P_FIFO_SIZES]	= { 0xC820, 0x00, 0x1000, 0x00 },
+};
+
 /* BAM CTRL */
 #define BAM_SW_RST			BIT(0)
 #define BAM_EN				BIT(1)
@@ -1228,6 +1257,7 @@ static const struct of_device_id bam_of_match[] = {
 	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_reg_info },
 	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_reg_info },
 	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_reg_info },
+	{ .compatible = "qcom,bam-crypto-v6", .data = &bam_crypto_v6_reg_info },
 	{}
 };
 

-- 
2.25.1


