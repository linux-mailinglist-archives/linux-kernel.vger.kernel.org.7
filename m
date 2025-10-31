Return-Path: <linux-kernel+bounces-879896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D5CC24533
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D537634EFDC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C2817D6;
	Fri, 31 Oct 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OIZNxdM1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CjvjroTV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B003277013
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904975; cv=none; b=H/FXyEYK/STceqMX8bMiEG0cYpf7J1zIuhBfn33K+fJj6ifqW/jQ5AE4DMRXLR68SXVhOVN7xjI7fZU/2Sgn+sDcAq8TNWfJec7W+0OeAh4Qk6+piX07HEMsa/ytpejB8r/094xB71cuKF4w/ryUgMVaz4qx8hG0aJcN7N+G4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904975; c=relaxed/simple;
	bh=qmyouG9wax8DI8Ep9VGJyGEQaHZsB+L08/7ldbX8DSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ry4fefcMa0+2Z5k8eh9BouWeZMtuz9DmUVfihjJXNSY9R+664SkY81JLHDjIuLHp0CSOOwc1xwxDepHAOEHaLpcWfu/TBUyLBiwIVwT2wWJrB5ml7GNLhx3K3IrJoB1WSk0d3BL1QzoL12RUXr5DC52AHc2P2AsEWt+OtHwF0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OIZNxdM1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CjvjroTV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V1mfY41571291
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9xq9j3KqWpWbSUPVXWGjxl
	Pd9QFvEU2YsH3D3qa4tOc=; b=OIZNxdM1pS6Oe3LIVslZWWboU4LzLOFQ+hwNAF
	GIah2e+gFTNdiVP9EpVQM6yIEjgVrdj7sxm7GzTb0gE0RU/NPp7rEga4//t83FTa
	++xpL0wWx8sdwUK77sHeKFdm2UuR0A8/alqb3LCEs9cis9SkPHAAbuMAprPcHKOR
	hB6s00EdCv/45NPACWx+YpCXCYt+hTSUWWe0fEeHdjd6q6A8EkByc4hpjq428it1
	ddEQZwb6z1fKW5AqegbIbO1UjGbCckZHr+xS93jqbaomKEHoKDUYe/9URfXcs3pF
	8+0BwrhvIUqgSQyox/B8u/DwE5c9DSuPEndhO2ieYznPF6UA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ksc171e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:02:52 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78117b8e49fso4294736b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761904971; x=1762509771; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9xq9j3KqWpWbSUPVXWGjxlPd9QFvEU2YsH3D3qa4tOc=;
        b=CjvjroTVmBI1cohF89OAeWTtRXFDhbcYCOtuxfc2HqB78ZunZABy1gmDPY1L+gwQMD
         3gIYxE9Ag1fjhTBorXvbiCzIu3gizGL2llY+WPiHEBQfPxm47lCGZmcRgLcPmyfaauG9
         YefJYnfxNUaWept4GB4ir+m7SsniYg6i5eb/coVhYDJT3tuWuAFs6o0iTKnMHXFbJDYY
         mUjmQvV6Ni2UkiSYBe+b4HAmASSfoZd3YUDCy/UKB75eeBHqlw8r5j7MxDGNyMfGsnXY
         NvD3tgW2AExZvBmWvTWxCQyFjZsucPCvw6uUZ4UP+py6scbtnLelspNOZ7uawtsedh+P
         Dfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904971; x=1762509771;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xq9j3KqWpWbSUPVXWGjxlPd9QFvEU2YsH3D3qa4tOc=;
        b=U7XDUQHwKG+fhmV1ga6ZzVublGJck+nEIYkRAtgS2QbNo4lkK2MWH3FT3udCc8oJuj
         163+fSt7IQsDjjipb39Wyo4DlkWfrHeVU42Yfii6mbFekn0bIEQFWKPqM99gv/PVepwI
         cRYAH5QJgATDp/s/onYbVdJ4IIVSw5Zm9cuYL/13xt4Hz/F4mJ0ZU3hK5+r5t9xhQL8l
         XthRG1pkrSYGEhG9MFy56krv4OL2uVBG0Vccm6sgfRe81F9GxsBQJ7KDhv0l4ho1xB42
         pPZH5WjK9YcB+HaeoDRZ7A/uyFqopeaP04Ys8rQuHlzWa/t0KQ8W3w4DRL0V8wLVYfP2
         cobA==
X-Forwarded-Encrypted: i=1; AJvYcCUw2P/RksfbyyJ5tUX5Vyk+y3bWVqVgX0KN58BhpXxWfrrCnD/1ETdsiQHYXKehBFsBWo9LosN4+X8ZbbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvEXnCguTAeX0YCOnn9jxfMPsL35SWs1IBaCxqDXPyn8hHi8g2
	jy7Ga9kXoYQonBl7sF8I62m+1Vd5S2JxZYADO7V/91IG+64lW1UAuzyezYWfPiKhwNVCrFnY8CZ
	IjgUQYjfR87eTLcE06jz6kH/AxyNFZ/sn1dNg8l1k/qri1LsY0dmlWaquVaLSpC3vKZ0=
X-Gm-Gg: ASbGncvsXttpwosDZ2DkjaqEWRkZ/YT+JseQjLZnjYypt1/2JVzOssPAFT0DKJ0Il/n
	0/++tXN7ZJ1Gh1LIuY7Fc6+b46cfTayMLbg0ny1cfgBXaD1LVRz2wkg/v3ucO7bZ1Dqm6AE/qLn
	tUlQL7QJiO1S3UYbk8yHSZDwtSJg+NEpsHukS5d97vAyEeK5tDj6G7sbA1XUiPM7tYYLgiphj3p
	MfaFeCCbEy2n8gd1BYsPyU54dqF2K/U2f2765Ty9vJLcTxbNXVphpFJgbzWnXIvhSbOZIPdsr1S
	FahtvMkZsA9RyRbp5vO28qCd2jYp+iWfIsgmXkDto+j/CXZuerwu8WeNILlHc1g13C916JTZgxr
	2q0DXguWYZSZrUxfxls0J1+o=
X-Received: by 2002:a05:6a00:1826:b0:771:ead8:dcdb with SMTP id d2e1a72fcca58-7a778ce3949mr3425274b3a.8.1761904971413;
        Fri, 31 Oct 2025 03:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3SJ8Jdf6h9E0ugoT8BDjUmuYGHslNJ9E6pWopLPmG7Z+0EZsbYMqrs20H5y7YA54/R7QhjA==
X-Received: by 2002:a05:6a00:1826:b0:771:ead8:dcdb with SMTP id d2e1a72fcca58-7a778ce3949mr3425196b3a.8.1761904970608;
        Fri, 31 Oct 2025 03:02:50 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db0a0219sm1609360b3a.37.2025.10.31.03.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:02:50 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 15:32:25 +0530
Subject: [PATCH] clk: qcom: tcsrcc-glymur: Update register offsets for
 clock refs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-tcsrcc_glymur-v1-1-0efb031f0ac5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADCJBGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2MD3ZLk4qLk5Pj0nMrc0iLdlBQDC0MLU/OUJBMzJaCegqLUtMwKsHn
 RsbW1AGXx2H9fAAAA
X-Change-ID: 20251030-tcsrcc_glymur-dd081857db46
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rajendra Nayak <quic_rjendra@quicinc.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA5MSBTYWx0ZWRfXzOwl+jx+bdMG
 ZpL3tua5tQTHXiB8N09Gj60T6Nt4fPchawyGapXSKHSMMOaqUiGa+Z5pgWvKdYo3Tyd7CMLmaK9
 rs3vpsSRi0rqCKiZQbkWnd/kE2Wj+fOzYjUDTVKmEm1+Gm5TrNSyt+Irq4ILB8RwNx8fhXIHDMp
 sm3SctNslwndl0jiC6NqqSongNmxZDDaMhaZPTUIW04QfOTz/ZHPlbB4XmdmNQZMLHeGwlbEnXU
 BjkLOPEQZENicvMp9EW1OxfwXttxhLF0K8jE5KL9ZNi9YthIlwnp4sR92dSGChvnbTcUMiLIuFe
 oZ7nEPBIjEjFDEB0CSKEGrFe1SC9Kuf4+QcRInpgaL6lcnvukCxgCfWY21RHDRU4Vjt7QC3NbB5
 Mp3safDdSNci7f4kmpJ8WHMnGyJs8Q==
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=6904894c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fnDjtfwCBqzf7SSwl4wA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: idmL8kY41-RH1B19xgVKbV4-4UbsJjus
X-Proofpoint-GUID: idmL8kY41-RH1B19xgVKbV4-4UbsJjus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310091

Update the register offsets for all the clock ref branches to match the
new address mapping in the TCSR subsystem.

Fixes: 2c1d6ce4f3da ("clk: qcom: Add TCSR clock driver for Glymur SoC")
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/tcsrcc-glymur.c | 54 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/qcom/tcsrcc-glymur.c b/drivers/clk/qcom/tcsrcc-glymur.c
index c1f8b6d10b7fd6eaef0149843594fc7eb6a620ec..215bc2ac548da83aec23921ef9a4bd59b6b307bc 100644
--- a/drivers/clk/qcom/tcsrcc-glymur.c
+++ b/drivers/clk/qcom/tcsrcc-glymur.c
@@ -28,10 +28,10 @@ enum {
 };
 
 static struct clk_branch tcsr_edp_clkref_en = {
-	.halt_reg = 0x1c,
+	.halt_reg = 0x60,
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
-		.enable_reg = 0x1c,
+		.enable_reg = 0x60,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_edp_clkref_en",
@@ -45,10 +45,10 @@ static struct clk_branch tcsr_edp_clkref_en = {
 };
 
 static struct clk_branch tcsr_pcie_1_clkref_en = {
-	.halt_reg = 0x4,
+	.halt_reg = 0x48,
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
-		.enable_reg = 0x4,
+		.enable_reg = 0x48,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_pcie_1_clkref_en",
@@ -62,10 +62,10 @@ static struct clk_branch tcsr_pcie_1_clkref_en = {
 };
 
 static struct clk_branch tcsr_pcie_2_clkref_en = {
-	.halt_reg = 0x8,
+	.halt_reg = 0x4c,
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
-		.enable_reg = 0x8,
+		.enable_reg = 0x4c,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_pcie_2_clkref_en",
@@ -79,10 +79,10 @@ static struct clk_branch tcsr_pcie_2_clkref_en = {
 };
 
 static struct clk_branch tcsr_pcie_3_clkref_en = {
-	.halt_reg = 0x10,
+	.halt_reg = 0x54,
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
-		.enable_reg = 0x10,
+		.enable_reg = 0x54,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_pcie_3_clkref_en",
@@ -96,10 +96,10 @@ static struct clk_branch tcsr_pcie_3_clkref_en = {
 };
 
 static struct clk_branch tcsr_pcie_4_clkref_en = {
-	.halt_reg = 0x14,
+	.halt_reg = 0x58,
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
-		.enable_reg = 0x14,
+		.enable_reg = 0x58,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_pcie_4_clkref_en",
@@ -113,10 +113,10 @@ static struct clk_branch tcsr_pcie_4_clkref_en = {
 };
 
 static struct clk_branch tcsr_usb2_1_clkref_en = {
-	.halt_reg = 0x28,
+	.halt_reg = 0x6c,
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
-		.enable_reg = 0x28,
+		.enable_reg = 0x6c,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_usb2_1_clkref_en",
@@ -130,10 +130,10 @@ static struct clk_branch tcsr_usb2_1_clkref_en = {
 };
 
 static struct clk_branch tcsr_usb2_2_clkref_en = {
-	.halt_reg = 0x2c,
+	.halt_reg = 0x70,
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
-		.enable_reg = 0x2c,
+		.enable_reg = 0x70,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_usb2_2_clkref_en",
@@ -147,10 +147,10 @@ static struct clk_branch tcsr_usb2_2_clkref_en = {
 };
 
 static struct clk_branch tcsr_usb2_3_clkref_en = {
-	.halt_reg = 0x30,
+	.halt_reg = 0x74,
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
-		.enable_reg = 0x30,
+		.enable_reg = 0x74,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_usb2_3_clkref_en",
@@ -164,10 +164,10 @@ static struct clk_branch tcsr_usb2_3_clkref_en = {
 };
 
 static struct clk_branch tcsr_usb2_4_clkref_en = {
-	.halt_reg = 0x44,
+	.halt_reg = 0x88,
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
-		.enable_reg = 0x44,
+		.enable_reg = 0x88,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_usb2_4_clkref_en",
@@ -181,10 +181,10 @@ static struct clk_branch tcsr_usb2_4_clkref_en = {
 };
 
 static struct clk_branch tcsr_usb3_0_clkref_en = {
-	.halt_reg = 0x20,
+	.halt_reg = 0x64,
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
-		.enable_reg = 0x20,
+		.enable_reg = 0x64,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_usb3_0_clkref_en",
@@ -198,10 +198,10 @@ static struct clk_branch tcsr_usb3_0_clkref_en = {
 };
 
 static struct clk_branch tcsr_usb3_1_clkref_en = {
-	.halt_reg = 0x24,
+	.halt_reg = 0x68,
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
-		.enable_reg = 0x24,
+		.enable_reg = 0x68,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_usb3_1_clkref_en",
@@ -215,10 +215,10 @@ static struct clk_branch tcsr_usb3_1_clkref_en = {
 };
 
 static struct clk_branch tcsr_usb4_1_clkref_en = {
-	.halt_reg = 0x0,
+	.halt_reg = 0x44,
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
-		.enable_reg = 0x0,
+		.enable_reg = 0x44,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_usb4_1_clkref_en",
@@ -232,10 +232,10 @@ static struct clk_branch tcsr_usb4_1_clkref_en = {
 };
 
 static struct clk_branch tcsr_usb4_2_clkref_en = {
-	.halt_reg = 0x18,
+	.halt_reg = 0x5c,
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
-		.enable_reg = 0x18,
+		.enable_reg = 0x5c,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_usb4_2_clkref_en",
@@ -268,7 +268,7 @@ static const struct regmap_config tcsr_cc_glymur_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = 0x44,
+	.max_register = 0x94,
 	.fast_io = true,
 };
 

---
base-commit: 131f3d9446a6075192cdd91f197989d98302faa6
change-id: 20251030-tcsrcc_glymur-dd081857db46

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>


