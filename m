Return-Path: <linux-kernel+bounces-831418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CC0B9C9BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9631BC44E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B782D24B4;
	Wed, 24 Sep 2025 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KAiQGfPw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85C2D0C95
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756816; cv=none; b=X3L+qV4BevB2IWS/bogIw/ogTGGz+QuVXz3eRssvys6+ahQGNu3J2jrCZXUrnd7L38ijak28nbesiMwRw02UVJI3DIt1c9PvSidgpjcllBSo1PHQsNGHSlOqBVsq0oG5OZKPReyvjN8U/7sZiLHjww8u/LVbI1HH70LzxRYecoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756816; c=relaxed/simple;
	bh=Uqo/eWaHoY9e6eKkym31R/DYAb+1//KhDD3k5V6qyAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxIHZT9UkK5EL+eOO1doy3uqCyADXISkB9A7U78ErEhkxJlRM+KQ+QpLsTAsaBLXTtm4h4nxWIaBZLFy8rWJtmikcvzpAIZcDdhlEkN12EqdcwdcGjPrtwVhQdl9QMeP9EHdNf5Cqe8gguhCH1lvia5UGiRqPkwv4dxDuUukPas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KAiQGfPw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD5hpS029706
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yz/BvssFHt5GhPJ5jIjNsN4INCEzi9FzXidgbvB+9GI=; b=KAiQGfPw/t+HifoN
	MZ6flCEr6VgcIAyZ4zzRySm6LGZFuZR2/3YV6Qjtc/LipexoudI4cVtsDakI+v6g
	wk+u+TyYHrSfKRfaoGxpm7KiMLkQ4CKbSd39kFhMkRemlwYOlNnOb5xYAw94WzzX
	8IB21/7jjcZQnpB0UhmNIzYFSghWnz8qoC8K35epl02ZlgBfVXt+0+5BH/jX0gVN
	xyUc7xXBaumFXPkbFiDb+fHnbYe3xL5ZQENLUwhEWnlNKcTz69qnHfpJ84WX/mz6
	zbV5zGAmvnuVlC8zBxKxOYtKl5xQMzOdjROFxN11IFxlkQtpgbWIiEkw+vJwMICh
	Z3DCqg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fnwx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so308832a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756812; x=1759361612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yz/BvssFHt5GhPJ5jIjNsN4INCEzi9FzXidgbvB+9GI=;
        b=ZRwVroe9f0YrbcXCIxRAJ/W94tL1xq2frKNgaoYGWeaMLkRqIgNDUNwkQJ3zm04QAL
         g51GgH4GPf8H51F2CTLfYRRTh4UI0NgIKEKzJxw+GlQOs2l1w1+J+GcreDQKuCoiKveo
         q4wiecP4jD63xtZAMJkhsDCW6XMwP1FmMh4Zu6xJx+5pEFthUPvKhhC30l+MKje4YULD
         6SfgrzsAYyrzpN+1hXt3DAS6cndpmYT7ZDtJrsmMmJuOmj/VxK0vlVbmOVIxWSuByhgp
         sfmssxzgyzjgCubw4XjR0tLSFhZVJElmFN5GP+nHMWLD6CAwpnd7sFnRMpCHKBfo5iM5
         erkA==
X-Forwarded-Encrypted: i=1; AJvYcCUywoSHslrY/b7Fjcb3bK/m+LxORVcCThpfgpI9pd0WXv0Ni9gIeomKOYOhoOFFs+87fJwO23mO19UnThM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6KhvNZBwAmt+mmTwuKQ6FDE2NwYrPEqdFLVk4p2dngxZDyC5
	p73CsfBDe1CtDSvoHjOY+mE4TP3c10rkdtrQ7JFBYngxbbVa9UbMYbPhBXJ541BVRKMXCH+Qe2L
	GaLgWuK8HxcbR17jV1ifbhytHh9f0jKXPceay2+JOWz5r3x3pkQCn59yyXFHAf1JnIMw=
X-Gm-Gg: ASbGnctOyINd7txrC5cFXTOMuAbJcBGXaKLtlDjk8GGaAX+Vdemlms3HouPVrYgU5sZ
	feUxSys274c/e7Nihu95VmUFdl7rGd90ifphmgjPq12avNbphKK7iFlhW//6uGh2byAB8yVWg1+
	Z00PnILGJBF7qRsoYuDZ8DRS3vHYLQs2o/Mo2MYNR3fyURfIrpna+KeDQV3rrWPR8AUKpwCJ5j1
	Fa1JJmWkXSeAon2xGElvA3Y18Vvo2KX70LTTPZXLiQjoVrk19hZbgsIQ794Tv/wwWJEi1Z72L0H
	vur3RWvX5tUf7EZ1BCJ0wZZDvDkXvbQK61ehVQYn17Eo5EpBLRCv4DJKq9ki90m/Rwq1TiNUUX6
	dnOgn+nHk9raY2LA=
X-Received: by 2002:a17:90b:388e:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-3342a2fcb6dmr1359944a91.34.1758756811655;
        Wed, 24 Sep 2025 16:33:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTfKG2tsHZ4zSugIWU3V+vBCw8l21C480uIFTEstEMlixyzql/xGMH9Xar4EPxE10NqdcNlw==
X-Received: by 2002:a17:90b:388e:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-3342a2fcb6dmr1359928a91.34.1758756811209;
        Wed, 24 Sep 2025 16:33:31 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53ca107sm392911a12.13.2025.09.24.16.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:33:30 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:33:21 -0700
Subject: [PATCH 5/6] phy: qcom-qmp: qserdes-com: Add some more v8 register
 offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pcie-v1-5-5fb59e398b83@oss.qualcomm.com>
References: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
In-Reply-To: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756801; l=2550;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=JZ5u2/SROv4n6Gk1LJjBIMQTCgNrKo2Vgd3gC5oPGX4=;
 b=GiTKsHEnCOQjMI+jkg3cArhzUYlQry589aNPGywP1MS922MzmpyS88NV4Qx8kqX5sFigiYz+l
 H+IA3OyQrFAD8LzVHq3fmfxyHxESyffUApcvAmRwPR5Y1dcAjVvhpJh
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: GLm677Gw826K3_cF283WArsRReJLnpjI
X-Proofpoint-GUID: GLm677Gw826K3_cF283WArsRReJLnpjI
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d47fcc cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=bnRLXWmTsoN8XshGuM4A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfXzW0uVUcMeZC/
 HYKH9G6g5MO0wjtJ14mreapLVi+jrZUVDt3nyLU8+DA/b/a40vkeRe6hqXaX0Q34qt8ISVxVFP7
 B6+Mi1sP2lNNfFfHkrVOovk15fER+QVKq4DBlHHZfmV9d6fyew4xoJMoUJQDNcW+DECsUuEB8Cd
 zv81gNFGwr0ap08uPfQl9LCvWRV5nDjYPh2OU/NvCFyINtqiBbqCcO7vQrXz7/TmQP5wHUJdEyC
 Nsn9cWiBLd7k5Z3XHaTNk7eRB9yib+C8vOruzVxVPvrIc3fkt8WBmf7JeUDOb0eNvjFx7BuU/Qs
 D5kUPWiTe+BAOys8MkfjU3agyPQ2xqRTCVC63Vd236m5EurpGfGFTiZo41aQjfSd7LzUZ3nad2C
 k5eadYN+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

From: Qiang Yu <qiang.yu@oss.qualcomm.com>

Some qserdes-com register offsets for the v8 PHY were previously omitted,
as they were not needed by earlier v8 PHY initialization sequences. Add
these missing v8 register offsets now required to support PCIe QMP PHY on
Kaanapali platform.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h
index d3b2292257bc..d8ac4c4a2c31 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h
@@ -33,6 +33,7 @@
 #define QSERDES_V8_COM_CP_CTRL_MODE0			0x070
 #define QSERDES_V8_COM_PLL_RCTRL_MODE0			0x074
 #define QSERDES_V8_COM_PLL_CCTRL_MODE0			0x078
+#define QSERDES_V8_COM_CORECLK_DIV_MODE0			0x07c
 #define QSERDES_V8_COM_LOCK_CMP1_MODE0			0x080
 #define QSERDES_V8_COM_LOCK_CMP2_MODE0			0x084
 #define QSERDES_V8_COM_DEC_START_MODE0			0x088
@@ -40,6 +41,7 @@
 #define QSERDES_V8_COM_DIV_FRAC_START1_MODE0		0x090
 #define QSERDES_V8_COM_DIV_FRAC_START2_MODE0		0x094
 #define QSERDES_V8_COM_DIV_FRAC_START3_MODE0		0x098
+#define QSERDES_V8_COM_HSCLK_HS_SWITCH_SEL_1		0x09c
 #define QSERDES_V8_COM_VCO_TUNE1_MODE0			0x0a8
 #define QSERDES_V8_COM_VCO_TUNE2_MODE0			0x0ac
 #define QSERDES_V8_COM_BG_TIMER				0x0bc
@@ -47,13 +49,22 @@
 #define QSERDES_V8_COM_SSC_PER1				0x0cc
 #define QSERDES_V8_COM_SSC_PER2				0x0d0
 #define QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN		0x0dc
+#define QSERDES_V8_COM_CLK_ENABLE1		0x0e0
+#define QSERDES_V8_COM_SYS_CLK_CTRL		0x0e4
+#define QSERDES_V8_COM_PLL_IVCO		0x0f4
 #define QSERDES_V8_COM_SYSCLK_BUF_ENABLE		0x0e8
 #define QSERDES_V8_COM_SYSCLK_EN_SEL			0x110
 #define QSERDES_V8_COM_RESETSM_CNTRL			0x118
+#define QSERDES_V8_COM_LOCK_CMP_EN			0x120
 #define QSERDES_V8_COM_LOCK_CMP_CFG			0x124
 #define QSERDES_V8_COM_VCO_TUNE_MAP			0x140
+#define QSERDES_V8_COM_CLK_SELECT			0x164
 #define QSERDES_V8_COM_CORE_CLK_EN			0x170
 #define QSERDES_V8_COM_CMN_CONFIG_1			0x174
+#define QSERDES_V8_COM_CMN_MISC_1			0x184
+#define QSERDES_V8_COM_CMN_MODE			0x188
+#define QSERDES_V8_COM_VCO_DC_LEVEL_CTRL			0x198
+#define QSERDES_V8_COM_PLL_SPARE_FOR_ECO			0x2b4
 #define QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_1		0x1a4
 #define QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_2		0x1a8
 #define QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_3		0x1ac

-- 
2.25.1


