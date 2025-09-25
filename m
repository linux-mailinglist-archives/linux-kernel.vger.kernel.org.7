Return-Path: <linux-kernel+bounces-832192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4010AB9E9AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAE216C0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F42EA468;
	Thu, 25 Sep 2025 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bqOvFjP7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C82EA141
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795553; cv=none; b=lLhoavOn/6C167HXCZ8oZIisHrra+E3zoiVhPDqOYj4nTbOPufI9A7KiHbWsUef+ateI3VKahtuU6Dac0rYH57TKQrjFR0DSfkLdV4GLlh2WmHboYz5urI7liczmi1ynO+N7LVgLt+07cIoJqXgewQ4bfBRffpNf0C6/EXYZezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795553; c=relaxed/simple;
	bh=O7xdGQ7WlDQpVmMZ2EYcuz0b3qYDBPaVranAc9pG9tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hICKFfwhPvo3ftaPBE/d2a/VsFviiO4ps0Obv9r0eci2xFpU+APIWg3P5476PALKT1aJ63F/WXJhxBUdxUieti1jYdq+++55crcyINXzuSlV8GMB7Y5PvWfktFEv9JEfzBEAnqIZcq8JGJfpwQcg6NRNCOzdWtDU2edEWImmnQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bqOvFjP7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9APUf018449
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FZp0Vhz0526cJi0JWc5xdd
	yE5rIKzJkRtxo1vAAFWus=; b=bqOvFjP7UryimDYddVYJJ2MqSt7x1GyI/W3JZO
	q52xIgydOTFF0S5Q5QCE+iQzaCuyM3YySpjq6Gx50NpwSbhutZ9mdPCBTy96qxW6
	W+HBq5e7xGn+18bUyqf0U3+zDBDh0vmTySE8mfgSnTTV1KVExxds1xQS9ayn8l9q
	kEuRecjUGyGENvn2LdplXSLlC0hmJCDzETTEbbpdtpKXbtudL0FTh/n9BfeL5QRv
	YLOfwdt5UEnnU9N5BH+LWmlbefaQsug4z3yOQrEBG3EyHT7/xH25pINj56MDHpT9
	AiqTyKWxCbqKwOQIFAVODY3KtSoHPeKGWH4wEBZnMu+c967A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkbpf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:19:10 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b57c2371182so821744a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795548; x=1759400348;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZp0Vhz0526cJi0JWc5xddyE5rIKzJkRtxo1vAAFWus=;
        b=oFffozhtCnTHkRGO8eblakClY9QQ+fTZrUNQFkjvtGi6FNElUbhbWl9umSqqRFsTLq
         LjPnIavarxxiePUXAhYHMYs/anMKsDbyJvlzmOFIA+Rt4psJo6ig9ztiCtQABHyYqlVJ
         OkBMmVLa/gyF5K/O9ylkQc6s+d602c9fQfmlnj0HBauiSdY/qVJM2zzfVSnJsVcj6Xjk
         XADbGKRthPuEaAL12W8tO2SHpFqCY3D18U1JqVSVizcpb/FqFL5U0tYMJ/Ct6Gdx7v3n
         3SxuzoqmRNND30b3GqvDBGJNi34+1eTXUnplsbH6tdWnJOtnhsA24GNpO1qK6sJhmP8h
         0kWg==
X-Forwarded-Encrypted: i=1; AJvYcCW5PTvKWx5gIRSOA+lwiS6gS6cKElbkiH+qhjXeSD5B0hcw3NUBlG/cKeeCx+B91UQ9r2VMRqPUREjoeo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tz7+rwoeJ8cJNy5qhIuldZzOl+DbvqfFY57x6aKNPjET28XY
	bSbvYLta9xbNxtSe5xTOf5WJmf/WIeOulMRsC6kfQ/+A/RMn4rN44UYcRkMK7lzZgKSxSCOy8wA
	BF255azYnDwNelxwjT4EdCDjOKZ4xsTB3HAulLyIypy/qw2Bd2CDd2omjWLIG2WHJByU=
X-Gm-Gg: ASbGnct8njrplkB4R4X2y1GHcbe6AV1c+aJmi7dXcPy2UnQlvZwuk8MtbMdQoIpNVDd
	MvM1HCTfQwb8QHYOch69xpggQIBYsjfMvIDLvREr5FJiaWJGbSYk/xFffRRLpaYbYRchfIbthuI
	6Ue6Ml0tVGOzn5P27UiMy9F2F4NuK1Aawab6d8+4aX9pKpw4QuW0KZTIjJLS6OoQ+1bGchelHg9
	siMyhcg3WchOeAv6lvg/1Fh0jbDjhe+lTZj4A4E0yoGJmN43l26KOkIxcYk2IbdLeFPts86/2Tg
	hnOCKZg4VR5tasjmEmDF9OZciXBVNNHGB8rysU8dI/SqJl9VMsWy0F9ECHbQhLSc
X-Received: by 2002:a17:902:fc86:b0:269:8407:5ae3 with SMTP id d9443c01a7336-27ed4a60923mr36546055ad.54.1758795548348;
        Thu, 25 Sep 2025 03:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEFXfYAUFjjS+jeTaReul4kekMhkSmoFtUW/wQ+LM/4NiYF5ttSYxapSUrbKOFtJuOqwQwFA==
X-Received: by 2002:a17:902:fc86:b0:269:8407:5ae3 with SMTP id d9443c01a7336-27ed4a60923mr36545825ad.54.1758795547888;
        Thu, 25 Sep 2025 03:19:07 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821c8sm19366165ad.74.2025.09.25.03.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:19:07 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:49:00 +0530
Subject: [PATCH v2] clk: qcom: gcc-glymur: Update the halt check flags for
 pipe clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-glymur_gcc_usb_fixes-v2-1-ee4619571efe@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABMX1WgC/4WNXQ6CMBCEr0L22ZK28lefvIchDdYFmgDVrjQS0
 rtbuYAvk3wzmZkdCL1Fgku2g8dgybolgTxlYMZuGZDZR2KQXJZcyYIN0zavXg/G6JXuurcfJNa
 oppdC8V7xGlL16fEIUvPWJh4tvZ3fjpcgfu6fwSCYYJ3iZdXU8oxVcXVE+WvtJuPmOU8CbYzxC
 88Tdc2/AAAA
X-Change-ID: 20250924-glymur_gcc_usb_fixes-898f2190f907
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: 9Q9Zy1lNaYYfOsHBPALxMh14nt9NUcfR
X-Proofpoint-ORIG-GUID: 9Q9Zy1lNaYYfOsHBPALxMh14nt9NUcfR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX8FCf7zLestIt
 F23J2iO/lJQ3w8h45qqKEAZe8g9/ifD/UYGRvEqmGrK8tyD67gtql0844WD9f+pvOcPFuoZBIzw
 wCgRHjewJ3i+vMISfz7TmrryIek0hEQQe2bIrQUNfsm/eOUxL2eTnF1Wcc/T5NjFMzDyjfHD9jR
 vA0gH9quxlYjR/PcAkd56jmu/CF8DYwCX2vl91fdyGRE2AopTcDzzn6on/nzLQHaIqnZ9ZZuDhR
 q5UAsyrZ3ss80QZJ1oOzkVGajJj24zXUlwH+gXxoUU8IPLA78DYYPELDcFJpu4MXUR5f3I8kvjU
 XbSjLGoHdBDiXUKJ6n8tmjHEhQK7xPZhJYrr70FNf7d3rdeZHMEqtCMz8GvKSRg0Q3ZqpEYeZ+m
 8ejHZ/3X
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d5171e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=JYB-Luj0ZXNNozRcq10A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

The pipe clocks for PCIE and USB are externally sourced and they should
not be polled by the clock driver. Update the halt_check flags to 'SKIP'
to disable polling for these clocks.

This helps avoid the clock status stuck at 'off' warnings, which are
benign, since all consumers of the PHYs must initialize a given instance
before performing any operations.

Fixes: efe504300a17 ("clk: qcom: gcc: Add support for Global Clock Controller")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
Changes in v2:
- Update the commit text to add the SoC name "glymur" [Konrad]
- Update the commit subject to add more details [Konrad]
- Add RB [Konrad]
- Fix a typo [Markus Elfring]
- Link to v1: https://lore.kernel.org/r/20250924-glymur_gcc_usb_fixes-v1-1-a90568723e64@oss.qualcomm.com
---
 drivers/clk/qcom/gcc-glymur.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/qcom/gcc-glymur.c b/drivers/clk/qcom/gcc-glymur.c
index 62059120f9720bbac03852c0368f4de3038a559c..d938e7dc5b66ec539c3264a2e212b3d6878b1fde 100644
--- a/drivers/clk/qcom/gcc-glymur.c
+++ b/drivers/clk/qcom/gcc-glymur.c
@@ -6760,7 +6760,7 @@ static struct clk_branch gcc_usb3_prim_phy_com_aux_clk = {
 
 static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
 	.halt_reg = 0x3f088,
-	.halt_check = BRANCH_HALT_DELAY,
+	.halt_check = BRANCH_HALT_SKIP,
 	.hwcg_reg = 0x3f088,
 	.hwcg_bit = 1,
 	.clkr = {
@@ -6816,7 +6816,7 @@ static struct clk_branch gcc_usb3_sec_phy_com_aux_clk = {
 
 static struct clk_branch gcc_usb3_sec_phy_pipe_clk = {
 	.halt_reg = 0xe2078,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_SKIP,
 	.hwcg_reg = 0xe2078,
 	.hwcg_bit = 1,
 	.clkr = {
@@ -6872,7 +6872,7 @@ static struct clk_branch gcc_usb3_tert_phy_com_aux_clk = {
 
 static struct clk_branch gcc_usb3_tert_phy_pipe_clk = {
 	.halt_reg = 0xe1078,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_SKIP,
 	.hwcg_reg = 0xe1078,
 	.hwcg_bit = 1,
 	.clkr = {
@@ -6961,7 +6961,7 @@ static struct clk_branch gcc_usb4_0_master_clk = {
 
 static struct clk_branch gcc_usb4_0_phy_p2rr2p_pipe_clk = {
 	.halt_reg = 0x2b0f4,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x2b0f4,
 		.enable_mask = BIT(0),
@@ -6979,7 +6979,7 @@ static struct clk_branch gcc_usb4_0_phy_p2rr2p_pipe_clk = {
 
 static struct clk_branch gcc_usb4_0_phy_pcie_pipe_clk = {
 	.halt_reg = 0x2b04c,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x62010,
 		.enable_mask = BIT(11),
@@ -7033,7 +7033,7 @@ static struct clk_branch gcc_usb4_0_phy_rx1_clk = {
 
 static struct clk_branch gcc_usb4_0_phy_usb_pipe_clk = {
 	.halt_reg = 0x2b0bc,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_SKIP,
 	.hwcg_reg = 0x2b0bc,
 	.hwcg_bit = 1,
 	.clkr = {
@@ -7196,7 +7196,7 @@ static struct clk_branch gcc_usb4_1_master_clk = {
 
 static struct clk_branch gcc_usb4_1_phy_p2rr2p_pipe_clk = {
 	.halt_reg = 0x2d118,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x2d118,
 		.enable_mask = BIT(0),
@@ -7214,7 +7214,7 @@ static struct clk_branch gcc_usb4_1_phy_p2rr2p_pipe_clk = {
 
 static struct clk_branch gcc_usb4_1_phy_pcie_pipe_clk = {
 	.halt_reg = 0x2d04c,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x62010,
 		.enable_mask = BIT(12),
@@ -7268,7 +7268,7 @@ static struct clk_branch gcc_usb4_1_phy_rx1_clk = {
 
 static struct clk_branch gcc_usb4_1_phy_usb_pipe_clk = {
 	.halt_reg = 0x2d0e0,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_SKIP,
 	.hwcg_reg = 0x2d0e0,
 	.hwcg_bit = 1,
 	.clkr = {
@@ -7431,7 +7431,7 @@ static struct clk_branch gcc_usb4_2_master_clk = {
 
 static struct clk_branch gcc_usb4_2_phy_p2rr2p_pipe_clk = {
 	.halt_reg = 0xe00f8,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0xe00f8,
 		.enable_mask = BIT(0),
@@ -7449,7 +7449,7 @@ static struct clk_branch gcc_usb4_2_phy_p2rr2p_pipe_clk = {
 
 static struct clk_branch gcc_usb4_2_phy_pcie_pipe_clk = {
 	.halt_reg = 0xe004c,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x62010,
 		.enable_mask = BIT(13),
@@ -7503,7 +7503,7 @@ static struct clk_branch gcc_usb4_2_phy_rx1_clk = {
 
 static struct clk_branch gcc_usb4_2_phy_usb_pipe_clk = {
 	.halt_reg = 0xe00c0,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_SKIP,
 	.hwcg_reg = 0xe00c0,
 	.hwcg_bit = 1,
 	.clkr = {

---
base-commit: ce7f1a983b074f6cf8609068088ca3182c569ee4
change-id: 20250924-glymur_gcc_usb_fixes-898f2190f907

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>


