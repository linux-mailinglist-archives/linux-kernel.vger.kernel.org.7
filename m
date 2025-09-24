Return-Path: <linux-kernel+bounces-831365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E83FEB9C770
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30D91BC0734
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0DF2BE658;
	Wed, 24 Sep 2025 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lpzAjdlY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483B02BE65E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755764; cv=none; b=q/d08qnzWk8XLKJFAs/TEz3ruvNytUY4QkRJhCZ953H/FJxxUiFdh95v6pMtfDsT54Ef/gLyjufMtuXj55nJPL/afxp+RGxTvNe5yhWqFBrPo5uvAFiS7koO5ra1QW3v/TYhOz+WE9WA3tTSdKLxBcct9Oot/MxaAfCQXFicoAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755764; c=relaxed/simple;
	bh=Mra7DXJD9DkYYcVtGywkuBbeZhhjAHhFS5me21Qz8ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTXTGxNRCMckcEompInh1U/aWnd6Nk75GRHOORKl2msjk0+rNJkCxI0/CAOso2J6k5ZTAOOKzLMZCeAkFBLq6PxbFJ7petTnSok5g5EHrgxAtgqcVu3PcbzN9ovdLxEjJ89yic2zJqpgIel/Xa9ytnetC6249WWl8Vx+TiO0p7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lpzAjdlY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCu8iJ024516
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YtjY3K2eaBTce5LB+oYLRJ83XJWdcIYlFtiOOpshI44=; b=lpzAjdlYfpzywaEk
	S19WlasWfoN3o69Amh9eRbFHgVH+4ZnVloTtjHNhsjIMwh8wqs69p92CZYPTXVRX
	ywxkmRD+PRdDz3z1jNHHwCou+7wnJr/vIZo2qD/CqCG7MevkJX0t8BRZ5734G6q8
	oAJ6We0ZYdByCaPgjnCGZzTlUgujyyv165/fDkbeIWL6UeGoNGcT/1FRVVuuzp+k
	N2Or4tj19hVLsh1yB5QWKxUyJNUgMW2OwRvVQjFS8lEpg3dGaslHE7pMT8VyPqwt
	BZ6dwDEZWKOohMf0+TMrRMkgylW0iREXZa2jYRtHSS1wx1PaiaWq/Guh4AtVA2Sw
	ScBVhg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0d1e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-277f0ea6fbaso3778315ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755760; x=1759360560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtjY3K2eaBTce5LB+oYLRJ83XJWdcIYlFtiOOpshI44=;
        b=KsXoF3CyfuOusMShANpW+G8A8aUUPsynm6M8M1Q0BH+YjEQq3Xp1rWVPbg6JxFpZJa
         L5/T/SjSdwg5h6Wqj6kZZVswp4+WPl7dZhYZL6wxktUg0ZZFPJAQ1gXwWWjCxIkww5GR
         RRNH7iEJZk63BorJSbl/kGEW+gm5caeZRCs4O8H6ToITBvACNCl+24LBtvU2MUB9JJjL
         q2Rt2qtdyCAuaXh0Bgthmf9MLSlwptwg4KB2ZeOau3uEwsPEyppjRAy/Pi2egtQnnIiZ
         3DYNBlRhBEwFtjSPUakn3vBjbavao9wPzwHBGnDt2oWQNPkpq1GloYrAb2cHE8D1OWSg
         Ea7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCzJkq0LOPeHgRHxgqIXpgU7lwz6CM/arlb6y7U9jvG0KdUOAKn2YADAD204zj5LjXZQ0USkGqGQMMAfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3iSRdMDuQg1BBd4TwC7VVNpFjZpPohkpY7G3eiEmK2BEwCoRx
	PmGE+N46jrm2+//JJco0xOfdp30YALS6e5wxJul3WB/wIHXe+X5em59UbepOevR/7HsnKGWZDD7
	Q7HmnhnVdFz84Na1r2v3Z4+jMCK2JR23nhbWPztnwf/OLkoV/TkmTBU1YmQ6OAlW3z5k=
X-Gm-Gg: ASbGncvIWXSPHsdcQURLd1nbGCQusDfdCMwNoR64/Qusf8p7YB8glHMSTHhFkdqMQNW
	SjMb65Hstk95MTTBT/CWhvodvLyogwhR3ekzw3wMzxVadv4hpRftL/tnTt9giVN20QNyLCTp3Am
	HIKvww+AhEkxUNTVPTkyYx5qtLkvGYCezfrDpPAy4UhH+KAlgn/EiYhG39JYFA2c6zu5g3L5ycn
	V5qPED5qyCOZWPi3jCjSDiSKk4GJBJ/CKhHKguzON/Hg9NMNQLO804Z5KxeElejetQ+COgq+4sl
	CMnjOgQmRPug4KZFxhcFGAeG8gwxMYKQ708sU/0bXH2dqMYDOSi3pASdmX/sgsLxyoZ80hgpuxA
	=
X-Received: by 2002:a17:902:e0c3:b0:263:6d3f:1c48 with SMTP id d9443c01a7336-27ed4aab6afmr8874815ad.33.1758755759660;
        Wed, 24 Sep 2025 16:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5chh50JKYsXAaR97d3tloLzXfVctWxkr5pMQc2OrrdZrjR/dyXCg4VxFe7zvrvdbO7vV7iw==
X-Received: by 2002:a17:902:e0c3:b0:263:6d3f:1c48 with SMTP id d9443c01a7336-27ed4aab6afmr8874595ad.33.1758755759101;
        Wed, 24 Sep 2025 16:15:59 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671c156sm3964175ad.50.2025.09.24.16.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:15:58 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 04:44:40 +0530
Subject: [PATCH 2/8] media: iris: Add support for multiple clock sources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-knp_video-v1-2-e323c0b3c0cd@oss.qualcomm.com>
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
In-Reply-To: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755747; l=10087;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=Mra7DXJD9DkYYcVtGywkuBbeZhhjAHhFS5me21Qz8ts=;
 b=AiwIF3pBiPurakhqe0icDFXJBoOPoWEbCraZKdxRRgn8Lxf77tx4Nxz/sMuVygy0/YpUqcNAi
 Lit44MTncf4A/BOLNwmI5qqEsTL7M9zcWECW/BYc7CMEnFYE3HQKCoq
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d47bb1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=QYLyKyDTaZ1yl2LMbfsA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: I6ToM1uLSDIdzioxq-E0UwTRAPeVGlv2
X-Proofpoint-ORIG-GUID: I6ToM1uLSDIdzioxq-E0UwTRAPeVGlv2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX7x3C/P80BCxM
 gFdFJ94NviBPcCmFoqb1zt336Hw/ud/KyPMpjOeU38aa+YVdLG20hKR1n/gGYo9tybX18XUI0ts
 PGtbrRzU+KXO9syImwRZATGXBjQ3xqtbEPt/v6WeoYYqDdFDcgRnjxjuwXoOBu7wGkjCnt+uay4
 nsYK/W+ORs4AKBbNihaAW60W9kKfR2Jo3wx7Rujd/YhYjxPD8QapC4o90p2O23PG0Rkuv7Cff3o
 Jyb7iS5YRU+vLVoM/XjoXs60xcmtz5F+eo+DJPlZWoPoOjno+AhvpWHnuxbdtv2TQQt5LxDpcoB
 tNuK8zCiqpupakOGKmdTo3D/WglNu5FzGUIqvBjThjyML28+B9tEEUEH2XoTGUv2cxvg+zWmdof
 Lwmulde5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

vpu4 comes with more than one clock sources running the hardware, so far
it was clocked by single clock source in vpu3x and earlier. Configure
OPP table for video device with these different video clocks, such that
the OPP can be set to multiple clocks during dev_pm_opp_set_opp(). This
patch extends the support for multiple clocks in driver, which would be
used in subsequent patch for kaanapali, when the platform data is
prepared.

Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 .../media/platform/qcom/iris/iris_platform_common.h  |  1 +
 .../media/platform/qcom/iris/iris_platform_gen2.c    |  9 +++++++++
 .../media/platform/qcom/iris/iris_platform_sm8250.c  |  6 ++++++
 drivers/media/platform/qcom/iris/iris_power.c        |  2 +-
 drivers/media/platform/qcom/iris/iris_probe.c        | 20 ++++++++------------
 drivers/media/platform/qcom/iris/iris_resources.c    | 16 ++++++++++++++--
 drivers/media/platform/qcom/iris/iris_resources.h    |  1 +
 drivers/media/platform/qcom/iris/iris_vpu_common.c   |  4 ++--
 8 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 58d05e0a112eed25faea027a34c719c89d6c3897..df03de08c44839c1b6c137874eb7273c638d5f2c 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -206,6 +206,7 @@ struct iris_platform_data {
 	const char * const *opp_pd_tbl;
 	unsigned int opp_pd_tbl_size;
 	const struct platform_clk_data *clk_tbl;
+	const char * const *opp_clk_tbl;
 	unsigned int clk_tbl_size;
 	const char * const *clk_rst_tbl;
 	unsigned int clk_rst_tbl_size;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 36d69cc73986b74534a2912524c8553970fd862e..fea800811a389a58388175c733ad31c4d9c636b0 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -633,6 +633,11 @@ static const struct platform_clk_data sm8550_clk_table[] = {
 	{IRIS_HW_CLK,   "vcodec0_core" },
 };
 
+static const char * const sm8550_opp_clk_table[] = {
+	"vcodec0_core",
+	NULL,
+};
+
 static struct ubwc_config_data ubwc_config_sm8550 = {
 	.max_channels = 8,
 	.mal_length = 32,
@@ -756,6 +761,7 @@ struct iris_platform_data sm8550_data = {
 	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
 	.clk_tbl = sm8550_clk_table,
 	.clk_tbl_size = ARRAY_SIZE(sm8550_clk_table),
+	.opp_clk_tbl = sm8550_opp_clk_table,
 	/* Upper bound of DMA address range */
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu/vpu30_p4.mbn",
@@ -848,6 +854,7 @@ struct iris_platform_data sm8650_data = {
 	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
 	.clk_tbl = sm8550_clk_table,
 	.clk_tbl_size = ARRAY_SIZE(sm8550_clk_table),
+	.opp_clk_tbl = sm8550_opp_clk_table,
 	/* Upper bound of DMA address range */
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu/vpu33_p4.mbn",
@@ -930,6 +937,7 @@ struct iris_platform_data sm8750_data = {
 	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
 	.clk_tbl = sm8750_clk_table,
 	.clk_tbl_size = ARRAY_SIZE(sm8750_clk_table),
+	.opp_clk_tbl = sm8550_opp_clk_table,
 	/* Upper bound of DMA address range */
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu/vpu35_p4.mbn",
@@ -1017,6 +1025,7 @@ struct iris_platform_data qcs8300_data = {
 	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
 	.clk_tbl = sm8550_clk_table,
 	.clk_tbl_size = ARRAY_SIZE(sm8550_clk_table),
+	.opp_clk_tbl = sm8550_opp_clk_table,
 	/* Upper bound of DMA address range */
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu/vpu30_p4_s6.mbn",
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
index 16486284f8acccf6a95a27f6003e885226e28f4d..1b1b6aa751106ee0b0bc71bb0df2e78340190e66 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
@@ -273,6 +273,11 @@ static const struct platform_clk_data sm8250_clk_table[] = {
 	{IRIS_HW_CLK,   "vcodec0_core" },
 };
 
+static const char * const sm8250_opp_clk_table[] = {
+	"vcodec0_core",
+	NULL,
+};
+
 static struct tz_cp_config tz_cp_config_sm8250 = {
 	.cp_start = 0,
 	.cp_size = 0x25800000,
@@ -333,6 +338,7 @@ struct iris_platform_data sm8250_data = {
 	.opp_pd_tbl_size = ARRAY_SIZE(sm8250_opp_pd_table),
 	.clk_tbl = sm8250_clk_table,
 	.clk_tbl_size = ARRAY_SIZE(sm8250_clk_table),
+	.opp_clk_tbl = sm8250_opp_clk_table,
 	/* Upper bound of DMA address range */
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu-1.0/venus.mbn",
diff --git a/drivers/media/platform/qcom/iris/iris_power.c b/drivers/media/platform/qcom/iris/iris_power.c
index dbca42df0910fd3c0fb253dbfabf1afa2c3d32ad..91aa21d4070ebcebbe2ed127a03e5e49b9a2bd5c 100644
--- a/drivers/media/platform/qcom/iris/iris_power.c
+++ b/drivers/media/platform/qcom/iris/iris_power.c
@@ -91,7 +91,7 @@ static int iris_set_clocks(struct iris_inst *inst)
 	}
 
 	core->power.clk_freq = freq;
-	ret = dev_pm_opp_set_rate(core->dev, freq);
+	ret = iris_opp_set_rate(core->dev, freq);
 	mutex_unlock(&core->lock);
 
 	return ret;
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 00e99be16e087c4098f930151fd76cd381d721ce..ad82a62f8b923d818ffe77c131d7eb6da8c34002 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -40,8 +40,6 @@ static int iris_init_icc(struct iris_core *core)
 
 static int iris_init_power_domains(struct iris_core *core)
 {
-	const struct platform_clk_data *clk_tbl;
-	u32 clk_cnt, i;
 	int ret;
 
 	struct dev_pm_domain_attach_data iris_pd_data = {
@@ -56,6 +54,11 @@ static int iris_init_power_domains(struct iris_core *core)
 		.pd_flags = PD_FLAG_DEV_LINK_ON | PD_FLAG_REQUIRED_OPP,
 	};
 
+	struct dev_pm_opp_config iris_opp_clk_data = {
+		.clk_names = core->iris_platform_data->opp_clk_tbl,
+		.config_clks = dev_pm_opp_config_clks_simple,
+	};
+
 	ret = devm_pm_domain_attach_list(core->dev, &iris_pd_data, &core->pmdomain_tbl);
 	if (ret < 0)
 		return ret;
@@ -64,16 +67,9 @@ static int iris_init_power_domains(struct iris_core *core)
 	if (ret < 0)
 		return ret;
 
-	clk_tbl = core->iris_platform_data->clk_tbl;
-	clk_cnt = core->iris_platform_data->clk_tbl_size;
-
-	for (i = 0; i < clk_cnt; i++) {
-		if (clk_tbl[i].clk_type == IRIS_HW_CLK) {
-			ret = devm_pm_opp_set_clkname(core->dev, clk_tbl[i].clk_name);
-			if (ret)
-				return ret;
-		}
-	}
+	ret = devm_pm_opp_set_config(core->dev, &iris_opp_clk_data);
+	if (ret)
+		return ret;
 
 	return devm_pm_opp_of_add_table(core->dev);
 }
diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index cf32f268b703c1c042a9bcf146e444fff4f4990d..939f6617f2631503fa8cb3e874b9de6b2fbe7b76 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/devfreq.h>
 #include <linux/interconnect.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
@@ -58,11 +59,22 @@ int iris_unset_icc_bw(struct iris_core *core)
 	return icc_bulk_set_bw(core->icc_count, core->icc_tbl);
 }
 
+int iris_opp_set_rate(struct device *dev, unsigned long freq)
+{
+	struct dev_pm_opp *opp __free(put_opp);
+
+	opp = devfreq_recommended_opp(dev, &freq, 0);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	return dev_pm_opp_set_opp(dev, opp);
+}
+
 int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev)
 {
 	int ret;
 
-	ret = dev_pm_opp_set_rate(core->dev, ULONG_MAX);
+	ret = iris_opp_set_rate(core->dev, ULONG_MAX);
 	if (ret)
 		return ret;
 
@@ -77,7 +89,7 @@ int iris_disable_power_domains(struct iris_core *core, struct device *pd_dev)
 {
 	int ret;
 
-	ret = dev_pm_opp_set_rate(core->dev, 0);
+	ret = iris_opp_set_rate(core->dev, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
index f723dfe5bd81a9c9db22d53bde4e18743d771210..6bfbd2dc6db095ec05e53c894e048285f82446c6 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.h
+++ b/drivers/media/platform/qcom/iris/iris_resources.h
@@ -8,6 +8,7 @@
 
 struct iris_core;
 
+int iris_opp_set_rate(struct device *dev, unsigned long freq);
 int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev);
 int iris_disable_power_domains(struct iris_core *core, struct device *pd_dev);
 int iris_unset_icc_bw(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index bb98950e018fadf69ac4f41b3037f7fd6ac33c5b..bbd999a41236dca5cf5700e452a6fed69f4fc922 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -266,7 +266,7 @@ void iris_vpu_power_off_hw(struct iris_core *core)
 
 void iris_vpu_power_off(struct iris_core *core)
 {
-	dev_pm_opp_set_rate(core->dev, 0);
+	iris_opp_set_rate(core->dev, 0);
 	core->iris_platform_data->vpu_ops->power_off_hw(core);
 	core->iris_platform_data->vpu_ops->power_off_controller(core);
 	iris_unset_icc_bw(core);
@@ -352,7 +352,7 @@ int iris_vpu_power_on(struct iris_core *core)
 	freq = core->power.clk_freq ? core->power.clk_freq :
 				      (u32)ULONG_MAX;
 
-	dev_pm_opp_set_rate(core->dev, freq);
+	iris_opp_set_rate(core->dev, freq);
 
 	core->iris_platform_data->set_preset_registers(core);
 

-- 
2.34.1


