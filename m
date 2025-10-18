Return-Path: <linux-kernel+bounces-858918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB11ABEC3DA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9BE74E6128
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FB1223710;
	Sat, 18 Oct 2025 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b5n/i9yd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0321FF23
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751236; cv=none; b=nZxRZY4gyoeNsa/wBmQIiwrh89VgGXgrgnC2Fjps5R5CV9SBMKVySaYIGuN85KepVHKmRbzrEFx1bFLD+CsIPRgrQ0dkuDewg6JP3p3z5ciDRIoEM5iPoAeElogRmtUZzIg1jmKuJDkb1RJ7whDWgkdgt27l9E+JDlJlNtjonAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751236; c=relaxed/simple;
	bh=FpDxHLlqUZ+XGHyViui56XmvYboqFqBaLMsyLmHrEjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaeDUMnISm7G+D9/b+fwweOCVKN6jyR6wp1Hur1kka4YT2k4oXGgTGaj9ZmxeeLu2nNcodGbJYzcVGkFg/v8yFt028NlTuI6h4bGpsqaM+Z4sqs5Vdtae6qh/Rfz07HS+X6qQOVX9MpOrN06Je+OgloZuTlv/PjKwWoWLyKE5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b5n/i9yd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I0eL10009895
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ul01yB/PmIF5rsEoiQYYpJP41+BqBJ4MU+FjnMDvYVQ=; b=b5n/i9ydwyPNRF4C
	mNwPiE/afJxNHr9XdkDxHnofotjPRlipfBXq30EbfqHwJ09tz3WMhUYDSn62HFLA
	sCSziuYYsXqdjFp55VSyb9yka5e1hPTsX5O2onngANc9DS6HHtQOluJHFUPvnBlx
	Dn3uY3cSl/TY7VjJyOphQPGfFXnJ/I/joYP5nY/k7GFcphWNGrWvQD0cGJMHIRlG
	HICjWA6cFIZY0v1S9ltoBmlgh4oHolmPbnLrGtHA7aidNU94BtqjhTv5g6V7HlT1
	gQhB+xjR7xct1E9FV5lmlcOwONY27TWOoLRP3xT51RGhV1Yf2jG/dyjUgCR0e1ON
	W6YyTQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff164a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33bcb7796d4so1898914a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760751233; x=1761356033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ul01yB/PmIF5rsEoiQYYpJP41+BqBJ4MU+FjnMDvYVQ=;
        b=wEEJhIz17Tgq+I+Q2d00huUsXG+1v4+sCVmxmwLMDPNStJQVRF0vBNImI25Zf0IT1i
         4v+ZLUq8myF2Cf2RHz5sTNW0cMENTUHQtSdXhAmMgpU2f0+8LWmkXEEpQVfo86feWgse
         n9mnYHaB88ysBinZS3sUoAbH1UTPy/CqSH3U9/ctfiXyIGY010pgVM+cMRwDCj09Fywu
         Mgn8TlvGXAmfvGMYJynseQUCNu8D2JrjevZAzMpUS/cNzBg0zofJhV0yHNZnebWxmIiY
         W0byOFCL4L0VJtX8UqbRO5QKVn7VhRHeF/OKZiZaT6VVvf22G11QmaBfPnWxv1MM5cJV
         eXXA==
X-Forwarded-Encrypted: i=1; AJvYcCWHTJH4T99b4WYDGL8UrSxtg1rJoQZ8+zOXjSKnPH0yA/ukrn7Arso0fGLvYzauVpY02xzJIJ3CVYNphgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZ9wqx63yC2JH/2ZmBxRuKzZgC3i7Sc29ThIbCH65Q2wexfXE
	xYLFF4zdAjOMssepzznxoGl1rMn9VkYJoTXFx0HDVgjhxn07LTUSyVMQiQF/i1KqNMC2ybdMlrS
	AXdL8VqZqv5t8o78+w57iMe66GN+Y+c0DQMVmvQqzvdB98MHj9a0wVwCWejX23lmyxr8=
X-Gm-Gg: ASbGncvZgOcoVjGsXlnbmyZOuOwZsrqN4z0zGprpNpe69q35h0ocen/ktD0ZVNIt28F
	MJwByI8T6lBK1o17B0JvkjTd3FMJxiJ91+wgC80retXCyTzdq9732+4Gxaqh8GxurlH2w2PPce4
	LYrbq8ALGC65XIuxqDNS33S6w/dbfBFy2m5qRfSEiqQ0sh/52OURO5lJZkyPo7Vh4NU1VxrOYKr
	wAWQpe/XwQU3An6uRGjyNCtKUIhloK863O3054o9G23TAsUmV6j5LcdnE3S+y8Kmgaoz/v0z1Nd
	liPKrx/fQP2/j9PHb4/sTYPyDjpb5WuK6Fbijl+H1LQkS6LJPIMpe33I8qfSoOtO7UPSelyEGYk
	nwRY3d9anYfVL0mMO6/lxtmqMDF5b40mfYDlW+l06g5qE4w==
X-Received: by 2002:a17:90b:4fc6:b0:330:6d5e:f17e with SMTP id 98e67ed59e1d1-33bcf8faaeamr7027706a91.24.1760751233324;
        Fri, 17 Oct 2025 18:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhgd8h+gjYCRAgJsNizEhdpEKTIJOJyi7ZEUs7pkgwCNS/nw/yoWOt3jimgW+A8TBDaTv9cQ==
X-Received: by 2002:a17:90b:4fc6:b0:330:6d5e:f17e with SMTP id 98e67ed59e1d1-33bcf8faaeamr7027679a91.24.1760751232945;
        Fri, 17 Oct 2025 18:33:52 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf16bcsm791695a91.4.2025.10.17.18.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 18:33:52 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 18:33:43 -0700
Subject: [PATCH v5 6/6] phy: qcom: qmp-pcie: Add support for glymur PCIe
 Gen4 x2 PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-glymur_pcie-v5-6-82d0c4bd402b@oss.qualcomm.com>
References: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
In-Reply-To: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Qiang Yu <quic_qianyu@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760751221; l=2061;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=iLPr+Du4SVVY2HNyB1uA8pllKkcuQDXDVG2QxHgn67Y=;
 b=Efk0/KbSfZj/WjkKqRhvcxliPbFO58kqb9rWUzQCQX8ah7wkDvdoRXAx9aYAlPBHZxJEcO4eq
 PxKIJ6L3AIeCJUKTVCeC6B3F3Bfbvt0rn+CAF9ToLzzCsQA8i1HqlDa
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX/NQ8KWS2EwKF
 hfpqgBB7ePT55EQbANl/Sfo3JPirpx5eg1+mEPoWH4JUaW7g1bT6MXdTJlMVY8M+PLbLh/TRafz
 FqJn1GC1gHfqzk0K57UbIn9dBjwLIXe91oaxth6iT2TGET8lyjcz7d2QvutTXkRPdDNHo0+0UEs
 92Ihmzbie3w1qZ3ijmWXMV+hu0+sCLPdRPKBN0kXekJTbtGz2jDOR8MNMbOEvqMt5VOyCM976X7
 PjgY3A+oNxITuqRa9BEpgr+QMGXW7Vf9beRqHgASSCqLnM/zN+obhzqJmq992ybIYm+NzKxHJQ5
 ZQKI4qj0DoNR/h796qm/QXVr6J5o811Ty1X/bZ3YA==
X-Proofpoint-GUID: Zj71nYZtIOBY1kZz_mL8xUC1msznCxKV
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68f2ee82 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=hii3Kp118aGdntTlwUgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Zj71nYZtIOBY1kZz_mL8xUC1msznCxKV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

From: Qiang Yu <quic_qianyu@quicinc.com>

Add support for Gen4 x2 PCIe QMP PHY found on Glymur platform.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 86b1b7e2da86a8675e3e48e90b782afb21cafd77..2747e71bf865907f139422a9ed33709c4a7ae7ea 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -3363,6 +3363,16 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
 	.ln_shrd	= 0x8000,
 };
 
+static const struct qmp_pcie_offsets qmp_pcie_offsets_v8 = {
+	.serdes     = 0x1000,
+	.pcs        = 0x1400,
+	.pcs_misc	= 0x1800,
+	.tx		= 0x0000,
+	.rx		= 0x0200,
+	.tx2		= 0x0800,
+	.rx2		= 0x0a00,
+};
+
 static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
 	.serdes     = 0x8000,
 	.pcs        = 0x9000,
@@ -4441,6 +4451,21 @@ static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
 	.phy_status		= PHYSTATUS_4_20,
 };
 
+static const struct qmp_phy_cfg glymur_qmp_gen4x2_pciephy_cfg = {
+	.lanes = 2,
+
+	.offsets		= &qmp_pcie_offsets_v8,
+
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= pciephy_v6_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS_4_20,
+};
+
 static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -5192,6 +5217,9 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 
 static const struct of_device_id qmp_pcie_of_match_table[] = {
 	{
+		.compatible = "qcom,glymur-qmp-gen4x2-pcie-phy",
+		.data = &glymur_qmp_gen4x2_pciephy_cfg,
+	}, {
 		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
 		.data = &glymur_qmp_gen5x4_pciephy_cfg,
 	}, {

-- 
2.34.1


