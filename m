Return-Path: <linux-kernel+bounces-830024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E836B987B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DB21747E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08D02BCF5;
	Wed, 24 Sep 2025 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KeptMmlZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF4C26F445
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698244; cv=none; b=OKcoxPX7x7Xmh+xeoqtI6GfBthk02fsJMRbrGF1Y3N93a5RCe+3Ys0pvvZ4zjAUy5lm+IW57Z/LrigTjJSfd86QjiAUeawmqZbzpt1iGdtnvJIPgXH0DZeOW8C+W9oC9AF29DBQ+AZ3domGnwSC/Ti9g26hJo0n3q/Ef22Zv7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698244; c=relaxed/simple;
	bh=F2Cs9l23rLUaJsZ0gN4TAq/w4FxXrrg0yBY2WbgaIhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cpQzNcH892EYxTxLC3uba4Y8vwNp6KQHFUpMoRFmoTP2qqH4VC/Z6yE/NCRBwYEDvFHUrOav2tr6h6D89kdwAklwaU4rBZyY8HozlLgKgtDOD1IyO2eUhNbYEwFbp1VEo06i5sDQrJud3G4a8pEpST7OcJTwIkbrNnRnPGd5oGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KeptMmlZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iG1H021646
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ls5rHwUZzWoTdxASMbUR/S
	efW8vGQPtUzSD9l0c8hi0=; b=KeptMmlZRVsaoF/vE0vORdfo7xj1UYD9qoHcG0
	jfzBPKwKguwsdaascEBDyocLIDGrbUJ1ZDvscMW2A7BUmAiYRkB6kKJthZZvRbmF
	gy/OAPC3X54vDjq4R3I4nucMVKw67X665FyjO5RqfhuMLqt/nwF4mFj9QzpwuuDb
	8vzuct+2iCwHjLeGT39/fBS+lHrFLmNTXq+XGAzk9RQPwh4UvIeRXTXzoa36Ku+4
	Jo5jB6ji5E/nB1J8tpKWfthGLvQN0RRXmtwXmQgPiOhKbNcqkNgR01h/8KRblRUY
	Ql5nOaO2O4an/8Ff1Rov6ax3qaPf5Ua6LrheJRmKG5qkL/bw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budaaxvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:17:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2681642efd9so53984305ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758698238; x=1759303038;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ls5rHwUZzWoTdxASMbUR/SefW8vGQPtUzSD9l0c8hi0=;
        b=mM6uioZEZXAHaTZNkxCvJ+sq0QxrH0QhyBSDoVf6yRcxKbGGV3tG0bKfH0I5pJ/guP
         RwKOi4VafF0vxAcaGxuT7s17tsnXi2zfAcEKQ53xp/3hqmsEf5Js3i5FeM6nMEBQFqIc
         p9IfkQqhEhR+RtRFpy/9PiZo9ozDxPgGa0rWA9ThDMrnkvXddhb0Y92J/TzgPy69CvrZ
         oWaONhyfKSO42LY7JO+cbx4+51zEvp/sBppRkfpYRpuIcej3+/HKcD3otdaLbb6iBHUR
         GUlL63r30dAbKd4aDiI0AdHAlej+NqHJYwwnW/TzZQBhbGPbBPSNiDwD8aaEfEg1wjXg
         ygJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI6cL/c5ZhbBOhywBpbQbU3Ep7LrjI5WiXL++Wy6yiUsy7t8F5rv+55Y471+qjs3RSDuWSmKuGjJHojK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72sIh0jvUh7MbgjjKs7GgydPfGJNW4Y0cbP/soamPmd9tsqBq
	+PkvRB2jcQ+qp6eQOVyoSx6SWGyd5KuJktzHvew117J+3gUdCieIgV57fvLgvf3Q79MBEn4xRZ7
	PFQzUWgGo9BEqP1XvXRm7i/rET6vgIcBWh40UUs3pqRAylsa7u9WUMvVzyS09KKA3uGM=
X-Gm-Gg: ASbGncsn2p95QMtxV0wFR1pGVQYn76yrnYaM0rux1yQjJWVxSx/G6bnGf3aWSMBR5o0
	GLlAzjsEO3wOsAT2eRQfG2ckzXS0aLjJDdSA7UgKyLPS/VDNxbzBpoBUU0s4gdC6Idk9oDiRsxR
	cmUvoQnIVzKG8RuBSBoBB49SfHVArIG1LsxxU7t8ThqpXVO/e0aU0i/2WEeyk9lQ5qnu0gH+RM2
	ypWal4Bo5x8QqO8R0WLKhFSfCI1khNsKsOgtk/MbMk/htawSV5y87Uwgnju1zjfsRe0NxqvJgSF
	6TeJ9i1JAWecuMiCzmnw2MiEIE3Imq8NGX4fZGFux5ibX9SEXWAnm6in6xq+YsCj
X-Received: by 2002:a17:902:d2c1:b0:271:b6b3:71ef with SMTP id d9443c01a7336-27cc5de0f46mr76039075ad.43.1758698238129;
        Wed, 24 Sep 2025 00:17:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5XUsYYjc6Q3W5JjV2krvu6VsFrIBob/PbMRkyJHcUOVnrQacVEDwqlpsh6hVyvLfCUoMYfA==
X-Received: by 2002:a17:902:d2c1:b0:271:b6b3:71ef with SMTP id d9443c01a7336-27cc5de0f46mr76038845ad.43.1758698237693;
        Wed, 24 Sep 2025 00:17:17 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980310e41sm182846855ad.108.2025.09.24.00.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:17:17 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 12:47:08 +0530
Subject: [PATCH] clk: qcom: gcc: Update the halt check flags for pipe
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-glymur_gcc_usb_fixes-v1-1-a90568723e64@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPOa02gC/x3LWwqAIBBA0a3EfCeYFGVbiZCy0QZ64WAU0d6TP
 g+X+wBjIGRoswcCnsS0bwlFnoGdh82joCkZlFSV1KoUfrnXGIy31kQejaMLWTS6carQ0mlZQ1q
 PgH9IZ9e/7we6riZ/ZgAAAA==
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
X-Proofpoint-GUID: Ix3SNT-OG1HA5WvaLeX6PP_JfP0vXMhT
X-Proofpoint-ORIG-GUID: Ix3SNT-OG1HA5WvaLeX6PP_JfP0vXMhT
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d39b00 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ZkscxO_R4YqFwkMorTkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfXxSz7d4qLA2am
 a5uEmKms0dt3EZKfrwdOMhhM0O1Yvlxs/9gajDlWKUnqtYXXyNvRCt5xq3n11/g22Py+TjcS+v7
 v9uw+NKfmgiKFmXrq6dohDLmLONjqOyf2StxMIrz21bHS03SGd1/ypgKPcPzvBKsZ/Cz3tcNg4d
 lTgWW0EluWYpImQVQCFrFVpYNNPrhMJDoM0/TONpSYoNbQRkJPRGcv8hf8LLceuOJOrlmjAjBXJ
 Ftn8yMdoYeLC3RNAbGNNTEfqCA7WD4nImadaEaMzt311joO0WUybe1+fNcazVSeDFrKEuxo6FkY
 vCNbsjVEADG8erkOtPWysiwZU1/VF0wrtS+BBph2xSHK4Gbq+cON7OxY6YyUS/8pdKtBiEpydSd
 asfGaoE8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

The pipe clocks for PCIE and USB are externally sourced and the should
not be polled by the clock driver. Update the halt_check flags to 'SKIP'
to disable polling for these clocks.

Fixes: efe504300a17 ("clk: qcom: gcc: Add support for Global Clock Controller")
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
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


