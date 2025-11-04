Return-Path: <linux-kernel+bounces-884012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A45C2F157
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 04:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AE2F345536
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 03:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615ED280A3B;
	Tue,  4 Nov 2025 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o+AoTgC0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d1UutRFk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A827B4F7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225707; cv=none; b=A6KiGnQuInK3a7UA0iVWbkQSsuYaWFjsH7/RPMiT9F5oINV0OgiHbngMcmP56zzWee90oPkSCyVor4caS8QZRu1rRULoaFQCdL3inPOkrRmzXHomaZbFAlJKBvM1Ifa2l7mj6HOEp9AiXs7t+v/TcSG7xLJ4Q6Y6NMKI3F43YNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225707; c=relaxed/simple;
	bh=T9q1inJlwTfg/gPd7Q+2RMAg+x2qnIVhHI3ir28H+W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQuAf8gjzlXAvDfcT88gnArmO6/5ICBJxld85Oi0WGUc2bpKjxk9G9eQ8X6hI8j3P3Ltot1OgwOgxI3map87V81Pyhn8WUcHZQyW76+kVsiyPS/TFnmwzj05ajXmuNgolhSzjkT9FHCN0jICLvpvZSy6iNtCHglXmXvPwSqaqS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o+AoTgC0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d1UutRFk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A42iZ0N3693375
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 03:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yjl88K7Ikw8V3LFOUdPS89IWYvnp87gV7OPjhtKIs8w=; b=o+AoTgC0Em7pBt85
	TqASbFS5eHz3KOtOsoVsaJoJuclthU7btFkHixs3LHTGLGYrFG6A0+9duaSQ6vw5
	BXALAoLNonW+PzxwjBBf5XFhlh/yldBKtNIB6v9fz0vwfh8UpR1NuMB7Y/HMrjRl
	ot0qJ+DcG0xs/ljguML1lxrJBB85yhBBG1Vee84+SrzGYMyGhMv+LGC0i5oGO6fS
	P0swqz4SFKLMooHCP8RMLZe/6XhZjE/ievaBZtLOtVXYqmCvqsAyftb72J07ooe+
	3Ba+KR5DtsRCXUCAmDDrKVWJ04uIcKQax+ScS6VcVW4soUgwv7ER8L3qv5QanXwT
	UPL4SA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b2d7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:08:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-277f0ea6ee6so54913845ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 19:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762225703; x=1762830503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjl88K7Ikw8V3LFOUdPS89IWYvnp87gV7OPjhtKIs8w=;
        b=d1UutRFkbnduyhnnRwPBGuMoR8ZV3g/k0CQLwI85Nb4WzupuVaC5Syebf59P9oLQ2A
         oyHZsX3ER/5fZbCgLuygBn3DHrAkNoV6QHtddU8JMgK2GFHiEpb39mKGvN/zlhISh8bR
         EYQPy1f4qsYkuTHf/JVbd1EstvivXftwTBCLRbAqFnA7SNRWI/ynz6cejvZlcEHO+Z4h
         N/BVpS2DIE9En0Yjv06YwIbDdK1aBci+reaAmSmcO+cmxgEXGSDWVcjb5KYlxDbxM86d
         dfUCwb/J0Icsm9T3hBOenJDza61cM1/oYO9/ks2QpkZENgBRD1P5zttx3DcyHlLA/OTG
         /0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762225703; x=1762830503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjl88K7Ikw8V3LFOUdPS89IWYvnp87gV7OPjhtKIs8w=;
        b=Lu8piuIhv4e23SJJ9xMeSVgZVp3Qr0v5Hc+0aaHyquovGLad8tD6vT6L3k58UfQfdS
         NryqZWrxwZpzCLe0SjWr+vyiOiR/r2HzLlfaEXSHXY4sse37En5/DIBveBWlc6Hs90+G
         uLlKNJoIfGhHpwGtASr2IW5lDCW/8oiQbV/X2va6CqkyUrmTLbchxFuRmNwaC2YD9Amo
         JmzH6O6mIacI/ZJ5W4gKvlpxX7tjZxeGKZOG75n/vpcV6TWDkSLM5hzOyRzQyPQtyWcL
         moLFyn5YAEbKYLspKi/MjY/qh3zj7f82O5028lMpKNZgNuiv+v4i2rSqC+moOy9EMCWv
         MpyA==
X-Forwarded-Encrypted: i=1; AJvYcCWoT2YFMZ/N1hfpoyOo+Gb7EvNN0XsRP2d3Zuj+p2EYvp0f2TZ94IQYYyBRKytTbmnqMmKyxDvzfAIXTJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+qYDau0+RbSUQo1xokUZHmj4Lnbu+vuI9GpAASF5RuqBTyraJ
	Xmy19KiqvZ1kE4RMqdUdeWGzyw3u29YgCmAZCv7E5/GFeYvxkrvt2m7oBspwT6dLy2tXbrC8fNE
	s8DWaV9rKVGjdT/F8sesc+1lbB9a6B7ucptYku43RVgp79K20z7J+0n75YGcZtyODH3M=
X-Gm-Gg: ASbGncsouleSKS089sPgbqYwqNzc5OytLqVQ3ew9tfs19/vBLNOu70ilu2JCH0+1E9G
	FxMYrEQy20sY5YtQXXfdvNmQ+qQAEsUrax6GHLdm2GYGmpfmjgBVG4lf0zfYX8aunBLL5DIGt7j
	ij5ZoefWYeJ/rbw9X5gdP4AM5edvFaiJ1lAx6p8Vuhuw8GXN4X571JZhf6RqJq63BXuAOqM4Tne
	Z1PJNUtBb/ALT4jGMvQMKfDMxdqL5kQ+gumktHrFEtCkx6AgWyT1JSeMP0mY5ShXLDBYQ601GnH
	1dpTaB/qaJQ7aJFzmgtd3aPBkAoKNEgTyg6wyi/K4CdjYDFuYBTWg3kUTL6ao77hei/zHZ6GQAK
	HvS9XWGPYTL9FcHQQqUHHX5l1MrAW+4TtZA8RSRZTihaa+A==
X-Received: by 2002:a17:903:2f8f:b0:249:3efa:3c99 with SMTP id d9443c01a7336-2951a600e39mr210169645ad.61.1762225703449;
        Mon, 03 Nov 2025 19:08:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnkUDpGTd4QUiumCjswd33SMHOlxSzlev0yXQnnPpUu0uiZwOjQMLokv3J1leiSGBWgY0gAQ==
X-Received: by 2002:a17:903:2f8f:b0:249:3efa:3c99 with SMTP id d9443c01a7336-2951a600e39mr210169285ad.61.1762225702739;
        Mon, 03 Nov 2025 19:08:22 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998da3sm7357365ad.27.2025.11.03.19.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 19:08:22 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Mon, 03 Nov 2025 19:08:16 -0800
Subject: [PATCH v3 4/5] phy: qcom-qmp: qserdes-com: Add some more v8
 register offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-kaanapali-pcie-phy-v3-4-18b0f27c7e96@oss.qualcomm.com>
References: <20251103-kaanapali-pcie-phy-v3-0-18b0f27c7e96@oss.qualcomm.com>
In-Reply-To: <20251103-kaanapali-pcie-phy-v3-0-18b0f27c7e96@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762225695; l=2673;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=T9q1inJlwTfg/gPd7Q+2RMAg+x2qnIVhHI3ir28H+W8=;
 b=UTstli92U/T/Fgz9RrJoWXssPeux14rrF3Dtzo9nuQqzrXsJDRkqTA1xxfy6aRip4SnkTSksy
 ChnRVjicU1LCdegugCAXjzFYi4UNwNrqTwQmFLR1UG45IfV3cpL2UCr
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDAyNCBTYWx0ZWRfX5wHH+AdZCPlA
 WwLpau0xrk7v12eYUSbq0W5WxrPrHTR5A6FbxAp4kCMK1AVS8UnYFW92NqeAADbqw4F2+vxSfA/
 WHS6iAK11BwO/qTb67Hw2xOG/2eqerlLfD7RCf5mAxdPoa9UE6qK3lly7S5Uo9d7tK4A6ZBqas/
 KA2wAEfEWZg3J+wZrtI2wt6M3D3ce01cw7LjGki7kvC7j2U+40RN6YVhMEZFpzsjfW0yakaTGtZ
 3t5gw4XUKaqL5QTGi59dBZVaT/EGfQcJ/iGb0+cuJBjkIHnz4oMnA2xe3ULWWYSeC3wZNYbKXG2
 E/QXTQx9ZGSuifuB9smiV+QwVTqgwRCfpR2/BZO3oI5BxO4ny1XU/sqaaw0IUQaWwv6UK3C75ID
 T4NUWZpiquRfKcc6rcpGJtkD09S4sA==
X-Proofpoint-GUID: xVyK5m-5ioYdNl2dxly9M4T3u0BVniP3
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=69096e28 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=GjIj-kmtzo1uPuhiLq4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: xVyK5m-5ioYdNl2dxly9M4T3u0BVniP3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040024

Some qserdes-com register offsets for the v8 PHY were previously omitted,
as they were not needed by earlier v8 PHY initialization sequences. Add
these missing v8 register offsets now required to support PCIe QMP PHY on
Kaanapali platform.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h
index d3b2292257bc521cb66562a5b6bfae8dc8c92cc1..d8ac4c4a2c31615fa7edff2cd4aca86f4f77de66 100644
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
2.34.1


