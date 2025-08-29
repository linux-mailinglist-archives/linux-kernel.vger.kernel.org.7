Return-Path: <linux-kernel+bounces-791559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADFEB3B878
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DFB1CC0E19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C240630AD07;
	Fri, 29 Aug 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a5DMs3Wp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF0930ACE0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462533; cv=none; b=RG3+M7vIeTBL+p1Nyx8OLNH6H2QkGLK3Q2UvcOsd7ioPpPkSKIsMxXnlKtNRoWSZPk8P06EJIl1JgZ3nJ2WHn9pvie+dHPhntMHw/T+VpEoHC2pKNYRBsp/58Q6XK7hl68sD0MTE5wqXDtAFgUGEOXJ9i6vCURv1DSP+R6ZfqtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462533; c=relaxed/simple;
	bh=O6Mny0d3NcWye/pa17Z21QvQoVkQuVKY8Az2O2Pwlvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLix6c+nftjB6Ifnz+kUSE5teGfLqPkeVIxOyZK8KyuN4RGLsNMNOHNns+VApBjFsntX7LN7uOPM4XyZk+wJ3a7A0+WJ1AoQPOHhptKCth/jB4tiYLvImDJkuZktGhdtyE1ExCyDMh+qe0E0U2SBrlMP97l9Yi7jig0NRsSYfWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a5DMs3Wp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85jYh009254
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0FPq/lTS4AeYWLkTBpagiaokL1Hd/X/PEFyY1CbPsh0=; b=a5DMs3WpubgufhGF
	ZBQ16Oj28MjGnNdoI3GOwBDvQg5tytBf8Vh/N7m6a7rLFh9t+WfjLaFzPHXNdnGc
	J3tZnqkwiVjPdzNFRT4U9NEGIwVp16B6L6y+OKxI1nnSE2cDFXwnWTdiLEWp0TOA
	/W7UDwure3Fhg2nBCKGDoN1NcqK0x18puzOCSkTFucS6mF74BcBBXTdJTFJV1vvs
	gpXbN6WfwmAnWhAqbFvZsNH+fJ9KCf3recVEPddVBo44Npx3f5Qlkb4VeOtyewwd
	ba01Om9khDCgrckOs2euMsnlYhlCVRw1bMCu2pzyoTRL/zlB8fA6tiTujMw/aVLk
	Qs5s+g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5up3e04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:15:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-248d9301475so24945455ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756462529; x=1757067329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FPq/lTS4AeYWLkTBpagiaokL1Hd/X/PEFyY1CbPsh0=;
        b=dv7LGKgtZ0y18k8YlzZQTDRFUHWeezBxQ6+ba0pCy2Qx1VzmgxVtLaCLnVdxaMT747
         b8IXHmOuYv/rnJKdxTyDS4e70G5rZPsqQ1djdwwKYbiLzcZNgOjJUGwhJ5m6vs8c0pyc
         b1sbNO+dZXXzS7rVTUx2IeADpGgTYAaOWZmlo8FEVpKiJ3g2wjhuxbMJ8iedI/OZGGG4
         KZ7LHUcacuuB5MXSSZngPsnb0zeSoYBIMKvsKanMP1pBehotnu41iAG4x5Cq1aeaYoXq
         GE3JUh+PEfetQdZu9pYgxcQtpPP9r1F9XCVAEPgyo5kx3kTd2uv5a1EzdmuSjQrFPYsL
         p9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvHp16dH1ET5ncjCZXsVA0bWNbOQoictHU5t4VXy/dn/1kNta9F/6D2PEjGL2LRsDuG+j0mU/C0nnvLzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhjeeOaHf6KQqJiTJgFSn62U1Ycmx/slOledq5q5e863GiUkQ
	Vu6hUvW7/XJ2RHkbSMAwHPttXRnBJvg3ubX3dVBO2iueKekLiftiXWX9b0BP5JR4SjNEvnYucBW
	BnswOwSEKTPMLhQqwiTsI2q34dGrzaU8k+jtQuAqFWEyFCk0o8n33b1j2s7a0V9ktvx8=
X-Gm-Gg: ASbGncssmfoagX59FLqlUq0ADnMqcan6Vw26FKiEDiFyJyXMSkpoiLCwGrs9bcBdW5O
	KtFqEFWDLc69HUjh7Rs8IOhSLURvVPIHn0Ps/hG48+zqm8RX24HVuMpFG/rUd6SL+Q1wIINz7FW
	a8NYdsRTbUqNKQ3MtKNRY2u42AU4elrSOZEA1D51okQs8udK4RHn5apWUfzMCpt0VVrSx9zgVgq
	MBdoO3EZt15KHi8FpjMHsG4qJ79hlB8RLkmx8vYiA9CvijEygx5Am/kzgu1j0ZCtJdqx9LdriXV
	sM63WH6hqBegSPAQOWrGLCM4j1iqmgGDsN2fMsFPZrOS3cRXlIneWjatip85ltYc
X-Received: by 2002:a17:903:124c:b0:234:d292:be7a with SMTP id d9443c01a7336-2462ee0b991mr357448815ad.1.1756462528666;
        Fri, 29 Aug 2025 03:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEld9WAS7PefNHcO4cwh1kQXSdou68Xzfiyst5T+t0EqwcyyL4eKB2damNsES8FC82eDU/lYQ==
X-Received: by 2002:a17:903:124c:b0:234:d292:be7a with SMTP id d9443c01a7336-2462ee0b991mr357448305ad.1.1756462528115;
        Fri, 29 Aug 2025 03:15:28 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065d1b19sm20102775ad.131.2025.08.29.03.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 03:15:27 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Fri, 29 Aug 2025 15:45:17 +0530
Subject: [PATCH v2 1/3] clk: qcom: branch: Extend invert logic for branch2
 mem clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-sm8750-videocc-v2-v2-1-4517a5300e41@oss.qualcomm.com>
References: <20250829-sm8750-videocc-v2-v2-0-4517a5300e41@oss.qualcomm.com>
In-Reply-To: <20250829-sm8750-videocc-v2-v2-0-4517a5300e41@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: OxRnTIROYpcU3InEmqibdAAzfrLEkY0s
X-Proofpoint-ORIG-GUID: OxRnTIROYpcU3InEmqibdAAzfrLEkY0s
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b17dc2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=TPL9fEiPDwMg0gBHboQA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfXyJkbb52uMiMD
 d/xtWBbK8ug8pBEIqcGX4jnbHHbCI8RHclAb4r3TEzwGnz6Lg9e12Vh4ovEuQyLG7KMZveMmNFf
 a/PWEbJ4M3jMZJOsycOp1xFoRPvdoemGxhNo6AM5JxrIpmt5yI/MFFXWTzz9e+wrTTwlsesAGJ8
 kvRcePFgdt+A1Z320XktvPhnJ9TsXDgeBgW2+8DJzR5rxSrbf0vf5hXXmddbb019Oz51LcaXYrR
 GltLix7cKlBSkhJwG/rPf1egeatRwicpCRTTkBuUfej8ugRTgf3ePusNrDlje6tidH9Z63G0Pbf
 poBc//YH3XTjapw9nqSGUmBZV3j5CF5w43IiHtK+W82Xa6UuW3pdMlBnYhXzAih6x0rwM+sG/2v
 uzjz9/Hl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

Some clock branches require inverted logic for memory gating, where
disabling the memory involves setting a bit and enabling it involves
clearing the same bit. This behavior differs from the standard approach
memory branch clocks ops where enabling typically sets the bit.

Introducing the mem_enable_invert to allow conditional handling of
these sequences of the inverted control logic for memory operations
required on those memory clock branches.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-branch.c | 14 +++++++++++---
 drivers/clk/qcom/clk-branch.h |  4 ++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index 0f10090d4ae681babbdbbb1b6c68ffe77af7a784..90da1c94b4736f65c87aec92303d511c4aa9a173 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -142,8 +142,12 @@ static int clk_branch2_mem_enable(struct clk_hw *hw)
 	u32 val;
 	int ret;
 
-	regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
-			   mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
+	if (mem_br->mem_enable_invert)
+		regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
+				  mem_br->mem_enable_mask, 0);
+	else
+		regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
+				  mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
 
 	ret = regmap_read_poll_timeout(branch.clkr.regmap, mem_br->mem_ack_reg,
 				       val, val & mem_br->mem_enable_ack_mask, 0, 200);
@@ -159,7 +163,11 @@ static void clk_branch2_mem_disable(struct clk_hw *hw)
 {
 	struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
 
-	regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
+	if (mem_br->mem_enable_invert)
+		regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
+			   mem_br->mem_enable_mask, mem_br->mem_enable_mask);
+	else
+		regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
 			   mem_br->mem_enable_ack_mask, 0);
 
 	return clk_branch2_disable(hw);
diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 292756435f53648640717734af198442a315272e..6bc2ba2b5350554005b7f0c84f933580b7582fc7 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -44,6 +44,8 @@ struct clk_branch {
  * @mem_enable_reg: branch clock memory gating register
  * @mem_ack_reg: branch clock memory ack register
  * @mem_enable_ack_mask: branch clock memory enable and ack field in @mem_ack_reg
+ * @mem_enable_mask: branch clock memory enable mask
+ * @mem_enable_invert: branch clock memory enable and disable has invert logic
  * @branch: branch clock gating handle
  *
  * Clock which can gate its memories.
@@ -52,6 +54,8 @@ struct clk_mem_branch {
 	u32	mem_enable_reg;
 	u32	mem_ack_reg;
 	u32	mem_enable_ack_mask;
+	u32	mem_enable_mask;
+	bool	mem_enable_invert;
 	struct clk_branch branch;
 };
 

-- 
2.34.1


