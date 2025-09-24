Return-Path: <linux-kernel+bounces-831346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A99B9C6B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04497B6550
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465C52C236F;
	Wed, 24 Sep 2025 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QOZID/tC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77C52C0F91
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754755; cv=none; b=EP5ad0ebBLGWBCNxsIhfPQWwRMDahyW49+orcwtsF/14ix3n1aI4ear/sFC0wzWlffki336Z3Vu4/qoFb/jWUc/hrbTqb65SktTMIe8+kJBzmfuwhROaYwBhkq6gPU8OU3FHdEp/robNbosaRuxx+XUaddf3Nc5b6b/r6J4oHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754755; c=relaxed/simple;
	bh=+c/O0m1x3edzUIFa+04pkOmgDXQIUrfeFCvIyQf9n54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T1mxoMp2vI03kArZyj1GllLX9W3daPhnDe2QC/+kESsm/0MUmNId7FV5vrKRNStaeQXRyQq5Ub7hLE2QoNz7XvQc1WpyCM+CJ1EJoUwUGW8kDF4urKW1hABYnm/upn2p5H9VhoxF96s8FN+OaYnBauXBaJ9EeBd+hrpEuMVuKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QOZID/tC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCl55m016458
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ilihenFi2/I8yXXbcTtIdczEo4jrckamvqpegFyURUM=; b=QOZID/tCngXRv41W
	oxDXegY9YOiCSrY0IjjPTySzxWWXheZ4KHWKz2WbdaQ9fKaTn1n+dxTlY0URKsgz
	s5SCdDKuJ/kYxfGXDFkGjbTSZS5VGSk0UqeGPZiv5MDUMgpJ3DOS7fzfOtO6+3Xw
	aGLACWqFAka6cRwXoOKg+GonJX3gOLl/n6KIfzlz5Z/WKOjrBbBj+aBJz+vP7XbY
	ovZx3ivrILR4ZpUr5LC1o52qBSgx/sROWDRJzb51h3rV83Gs/FTChZhO4oYKV/kJ
	XEpWCLklLZThEubW3RNKl/CDlpC6XD6hiSEUnZ8zTdGF5KHi7mk+4eTMtHxjTgu4
	eTcFbg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhsnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f5e6a324fso651816b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754752; x=1759359552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilihenFi2/I8yXXbcTtIdczEo4jrckamvqpegFyURUM=;
        b=Dcu0JfpZVtUYo7mmxh9upEME7M/l/4JZSLKOhP9dJlRSV0wNpi8L/E9b1vSeKNv3DD
         nocg4XGxVkd5c0OkZzmPeK8kr5G3bpmHUNdffyp1KFdED6fQBND0/eHsoZ/aCGCWfuz9
         yeMFFkJJfbgcOzn3FdZ2T+pppdUtydrFcnm9XJ+h+lqcxc97T+N26IanXWvEA44Woawo
         u0TpLIUxJ8O2vw0uTltDci3l8yFAQqPZXB5VOXaNz3Y4kPAIE+etMjy54NbB7LkrWPhn
         2ILy+Go4eRh36fzTz81Mhme55GwZ2MAARp5Xv7zBHsfjKw3gdEsJAO5/HCT7s66DdzS0
         rTew==
X-Forwarded-Encrypted: i=1; AJvYcCXHEwygAqTGWqu7Anqw0bJ8ZOR0cp1KVPyOs6qJnjppT8C82p6tsHXuc3kVokitp3cton3ZVBM0uYKxZHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxag7qxZTlUwrkyoxi5vQUtbzSAlPAWmq09dxRNDJP0HJ90tBiG
	ibeKVbadcp+8vDk9jRgXA6+Ubutody43y6uGgSBzIi5cmIfLbQliVr9dd1AxfKckLt2q9MQM39P
	gEqyJP4lv0x77MdeYRFOI94wP1izFKIWJZXCHHxVKjPmtO82IPShgjJAZ2bLUjSaUa0M=
X-Gm-Gg: ASbGncv2vkQlEQ/oiPOF9zR6MbyW3Fe6BAXrnZ3dZjSx47F+zU+9Y0LMcitmMFoI3I2
	Loew4JOiB211bQeQ7UvDQr3V78uPJZ1r3UWoFm4ejbDgIGCV1A47r11n/C9BtRUsTEM68+KVbp/
	l+MKSri91be8G+OXeKdQosudxIY1JvZxdJqPf39bD/dhi4Dgteb/DACAeLVFAyA2qvI7NzyQ2u8
	7a0XqJmQ/Dh51Vsiz7V2Luxu1OBxsOQZYsuyfbU6W3uVxB9Et0OsmELeGAZsfGLDJW1jVx4CRl5
	MBgatpjrqdaObF1B684th60FSzfKx13EPGY86x95ZX4mGepEiFvce5SYna4+sYG+aLSO61BHZfi
	j+bT7wQciDkQVWcM=
X-Received: by 2002:a05:6a00:180e:b0:780:fcae:de6d with SMTP id d2e1a72fcca58-780fce9ffb1mr1665196b3a.18.1758754752234;
        Wed, 24 Sep 2025 15:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj14HxxZ3uzbiCi78rxXYfPoMzU2YTSNowqWs2CPk3vaeSHv2I6TKn2g4BeyUdIWrIcWkvkA==
X-Received: by 2002:a05:6a00:180e:b0:780:fcae:de6d with SMTP id d2e1a72fcca58-780fce9ffb1mr1665164b3a.18.1758754751687;
        Wed, 24 Sep 2025 15:59:11 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c2b70esm111166b3a.101.2025.09.24.15.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:59:11 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 15:58:59 -0700
Subject: [PATCH 7/9] clk: qcom: clk-alpha-pll: Update the PLL support for
 cal_l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-clk-v1-7-29b02b818782@oss.qualcomm.com>
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
In-Reply-To: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758754740; l=1911;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=TftNAWn7+tFc/FivZsdhBulxwhyQfojqz0h3+kX/lVg=;
 b=+7YP53ADOyVjQbtECZrmeUC37vzZf4qyLNQsaSmA7xfg5pTZoy/AlzFMISPBhFUUkYn1lFRUJ
 0Lf3xL9758eAsF9ln0zWDOJv0FMWx2fybG/FLvB3yDBOACHyNWIQ1xF
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d477c1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=oquIAzZO8Z25OepLYD0A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 9bdzEMWCbt_ow4eDR0hCOCbI_C1w9GSC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfX9afWQZ3xFWQ0
 wkaKYU41kC6DT5Y5sFXxtV51fpe/inzIsVpN7+gMgjpZRvCEgs1rstrf9VoSWQdJwFamw4pwoDq
 SkGKYLVYZkp4VqW7QGBzB8qVxLLxw20/fgHAlVa8HaN6+SaY4Ec1x8iv81SKIEYQojbTU2LaOuQ
 Fd9OqjkZ2XNmz5oxeg2T9B8SZMcgFbuo7ufEh1t5SvmtLCk37QHhTrA7/kdNFLidbJlnR7So3nh
 hGfB4lgGfVm/WL+eBQuQdpbalwIT0q551NGL3cCgX2yfOLdbBsdzdcPzvTfF1fQcQCn08T3mTpK
 RMP4s5lJc4doSSSd2DNtQsygY0k2ueRJFywl0ogTYNI+vtHaxRGmeRA5zqWLnHhkFyDOLFQ1VZe
 oBOSbUQk
X-Proofpoint-ORIG-GUID: 9bdzEMWCbt_ow4eDR0hCOCbI_C1w9GSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

From: Taniya Das <taniya.das@oss.qualcomm.com>

Recent QCOM PLLs require the CAL_L field to be programmed according to
specific hardware recommendations, rather than using the legacy default
value of 0x44. Hardcoding this value can lead to suboptimal or incorrect
behavior on newer platforms.

To address this, introduce a `cal_l` field in the PLL configuration
structure, allowing CAL_L to be set explicitly based on platform
requirements. This improves flexibility and ensures correct PLL
initialization across different hardware variants.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 6 +++++-
 drivers/clk/qcom/clk-alpha-pll.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 6aeba40358c1..6f50f0c4b984 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -2338,7 +2338,11 @@ void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regma
 		return;
 	}
 
-	lval |= TRION_PLL_CAL_VAL << LUCID_EVO_PLL_CAL_L_VAL_SHIFT;
+	if (config->cal_l)
+		lval |= config->cal_l << LUCID_EVO_PLL_CAL_L_VAL_SHIFT;
+	else
+		lval |= TRION_PLL_CAL_VAL << LUCID_EVO_PLL_CAL_L_VAL_SHIFT;
+
 	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), lval);
 	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
 	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 0903a05b18cc..ec5b4e481030 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -128,6 +128,7 @@ struct clk_alpha_pll_postdiv {
 
 struct alpha_pll_config {
 	u32 l;
+	u32 cal_l;
 	u32 alpha;
 	u32 alpha_hi;
 	u32 config_ctl_val;

-- 
2.25.1


