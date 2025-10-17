Return-Path: <linux-kernel+bounces-858592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25693BEB3D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EF919A7169
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E7F33506B;
	Fri, 17 Oct 2025 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BhWTPJuM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3601B257831
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726133; cv=none; b=CT6G8RRK9I0s3EngvK00VxxAbuwmYLEQXt47+DoZbF3tLo/wvds+zsGrxf/UGRBUJOEYxD6VZGLaw4yoFJ3YS7LDFwz8RJNAMxxXQEjvYpfX3uP7lvkuJoDfz+QlQzFGdEx/dGYrl/5qABIC+nD0IAj+imW94+if1baikPL9go8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726133; c=relaxed/simple;
	bh=VskuyVOBS7KHlqvDQrpKFvJ4AMjG+tM6ZV54/uqDOk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6ZLKIXsy9bupR59/yrL/NgpVqbuTFg9hOLyco+FotqPt/82F7XWM+eNeOTwy/d26ybEPQIzey0b7aX4FfKeVunRTT9vt2s+5mlPEzRmOTpk9of1SwxZioYmxi+VSDa5jcf3CHsg5NEDvZ4OnXn3pL2PNZMoaeKctjynGsfSoek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BhWTPJuM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HISBLi017891
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HrIpDsyH3yYUP12GtjfQTL4htgNJ0LU7jZDW8u53XPQ=; b=BhWTPJuMgY0eiOEv
	bbkpJ2R9/Ejl8pTVCR7HMmlzBpTUPf1M/d+/Fs+ucZvrU3d6tS38ZcueIG+mN4Wp
	uHTFVlrpDbWUhBXrsazg/ZGErW6kwPPteBBtK7IpDF07LTpLxARmM+0lVI7cCrHo
	AmqCZTtdjLJo1RobX+GJarBfbZbWyRukigWZNDW8wu5Uf7yWZPlfY2IZRsqaqumU
	4k9zLK4A2//BAsQ+k/PMv2GiE/kYZ58jrl3CI9YYiQbuGEWue/3lG43u4iKQBc2h
	1gQAyEo2AWYKsn4ZqSvfJe3P5uV/+PBfwGK+IVzZTrVdd1EKD8aopxjD7ScjK0eu
	KdRQaw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8v2vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:35:29 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3327e438680so394546a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760726129; x=1761330929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrIpDsyH3yYUP12GtjfQTL4htgNJ0LU7jZDW8u53XPQ=;
        b=Dnc34redeyKakE1BlGDxxjQ7UQ13YcC123nO153B4UDU3FrWPm3Yx1jNuyOJWM6Vrs
         WDpm4Fo2bhnWcTX3neqX88m6nmcG0PG92bYkG7n6ZQRFW0Ol4ZiWWmTL2kgioSLH/qYW
         JIU2Ae+mT+2Ue0e/zbhZKH9ITR+3K3RVH1yNJgNIOWi3O63g7xYoxHUxOFaM2thG12OG
         k96pqyFZqQ6EhW4lCsh787YNWTsi3hGwrwmvfPhEwKJLgacypIH55H0ZYwM8ZuvmGTbJ
         UNzLQZuPacXUd5mKAAfDgj8gwZN24t/UfZfpcksRRsyHMvlI21DP9K0LBcXsWYHxb66I
         ofHw==
X-Forwarded-Encrypted: i=1; AJvYcCULY7hLryXqvnkN8GhUoqoPI91tORwLbAoMmgwzkReJjJQnsWrgnvo/gUvmg9Wp5kz0QrR8JCskkStAOXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTiOPpGrVK410u3UiASOC0qHDvIhAJOTRD+EdCx+DQOpZ5hSsp
	r8YheMNxJThgfSijD/zNJRbWtb+pUSqq46sx4n8pjwZhQ0uz4vKvvYUikdoLt32QpC1lrnMtdHU
	hQRBbxODJ6D8sUCEmGKSgXugqDH7dG0uysIvlvYlrQOjZOAXj7rJYFGHKsNF/tjx2A6o=
X-Gm-Gg: ASbGncs81qHYbIpPrm8FD5jqR3dmVugq4dNT858C8lIYTyNYFLQKrRzfIfMe6QKgS1c
	1x+wkdUG2YWpTxOG5PtJUY6UDNS8o1GXK3hrWQNGdjWwMtPiXMTqZjbhWbsfCofXs88m3L33nno
	++a8IBeKwy+aP3nW/rL3za9T8RL//G5ezgmv5p02atNcNW7dNzlUuMBMYa64jIsPCKvDa/lzFsX
	6soysoD/YWPVyXNffL85nkAuWuIfRiORsnmXSE2IB0elu/xS0yd3nw5UEeh8iqLGzN8/CHONkFH
	z2xIakES2KWGMy2Yp46epdFrqQxODoObPUI86uh/nw1Y5NVeasKsWt3xnlRnq118PJwwPej4GEU
	p71SA/ZCKWl87QhcCIaC8z9tBrmmst0rCfF2Ne+6o8CRGtQEk9YOUcN5sFkE=
X-Received: by 2002:a05:6a21:164a:b0:262:77e0:819d with SMTP id adf61e73a8af0-334a8616f8fmr3509190637.3.1760726128589;
        Fri, 17 Oct 2025 11:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkEcbmjrj2mihGjJEJfxlADEKhTZnTFKqkqm9TWg1u52h/cBGzwlAA3FOATwYI5ir4jBnP5Q==
X-Received: by 2002:a05:6a21:164a:b0:262:77e0:819d with SMTP id adf61e73a8af0-334a8616f8fmr3509170637.3.1760726128085;
        Fri, 17 Oct 2025 11:35:28 -0700 (PDT)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f24fasm245487b3a.42.2025.10.17.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:35:27 -0700 (PDT)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 11:35:17 -0700
Subject: [PATCH v2 3/5] media: iris: Add support for AV1 format in iris
 decoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-av1_irisdecoder-v2-3-964a5478139e@oss.qualcomm.com>
References: <20251017-av1_irisdecoder-v2-0-964a5478139e@oss.qualcomm.com>
In-Reply-To: <20251017-av1_irisdecoder-v2-0-964a5478139e@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760726124; l=7503;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=VskuyVOBS7KHlqvDQrpKFvJ4AMjG+tM6ZV54/uqDOk8=;
 b=yxND7vtEhiA9/d00RWrvjrNk6qFglVsKHr+QJgF0n0RUr+UjqqonhSasqyZ6auDuSC57yYuZ9
 KqQ54qCupYNAfJEQHnZXmP72p05WpZtG3XY/XacNA9ZPCGXNL4nwU18
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-GUID: ToIg4K1Z1ynm7203KcP3IGVRIY9NAbFQ
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f28c72 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Z_4drlmlzYXD-T4lrkMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX5CI8odOT7yJ2
 oU2paAz3XsLPNkB4OZxK6fFgdG3kdd2aNiByaROp5YcveWUhdK3M4U3l+lwJJFwlPO729Dc0r7X
 8PLdVAEHlpNKC8tOYjjkwpYXVo4NkuRpqMxOuaOrYtdKf1LwG2P8Jknbwhqe/O7hgZI5yvj9Uba
 hqmE47g+Jf7XC7aBr9dfGhatnP57Ydrf2p/g0CsDRVFq+62rBmpYpA4EuFRY+os7XgTPILmaEW9
 TM7O/nRymiENLSClaGRRpn/810P9UuTiUwHw1jgAX5d8mjS+eb+sDtv/jJUTNL6YojAaMX2RfUv
 PL2Gm68KvY5x0SDbvMKl683/pBGksmIYY4/vEG3vPym/3cD6EEq7chntLBBkKdVrg36r7ZRLMmM
 xGoVCr4XRFt+qrigZgzyDrf3NwMb9w==
X-Proofpoint-ORIG-GUID: ToIg4K1Z1ynm7203KcP3IGVRIY9NAbFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134

Extend iris decoder driver to support format V4L2_PIX_FMT_AV1.
This change updates the format enumeration (VIDIOC_ENUM_FMT)
and allows setting AV1 format via VIDIOC_S_FMT for gen2 and beyond.
Gen1 iris hardware decoder does not support AV1 format.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
 drivers/media/platform/qcom/iris/iris_instance.h   |  1 +
 .../platform/qcom/iris/iris_platform_common.h      |  2 ++
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 23 ++++++++++++++++++++
 .../platform/qcom/iris/iris_platform_sm8250.c      | 17 +++++++++++++++
 drivers/media/platform/qcom/iris/iris_vdec.c       | 25 ++++++----------------
 6 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
index aa1f795f5626c1f76a32dd650302633877ce67be..bbfe7a0851ea94fb7041a868b4df8b2ec63bf427 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
@@ -138,6 +138,7 @@ enum hfi_codec_type {
 	HFI_CODEC_DECODE_HEVC			= 3,
 	HFI_CODEC_ENCODE_HEVC			= 4,
 	HFI_CODEC_DECODE_VP9			= 5,
+	HFI_CODEC_DECODE_AV1			= 7,
 };
 
 enum hfi_picture_type {
diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
index 5982d7adefeab80905478b32cddba7bd4651a691..f1883ffc138fd975fb76d4e45904ee04e196cd20 100644
--- a/drivers/media/platform/qcom/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/iris/iris_instance.h
@@ -19,6 +19,7 @@ enum iris_fmt_type {
 	IRIS_FMT_H264,
 	IRIS_FMT_HEVC,
 	IRIS_FMT_VP9,
+	IRIS_FMT_AV1,
 };
 
 struct iris_fmt {
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 58d05e0a112eed25faea027a34c719c89d6c3897..9aca70b4c0690f0d8d799e2a9976bd20d6bb8c94 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -214,6 +214,8 @@ struct iris_platform_data {
 	u64 dma_mask;
 	const char *fwname;
 	u32 pas_id;
+	struct iris_fmt *inst_iris_fmts;
+	u32 inst_iris_fmts_size;
 	struct platform_inst_caps *inst_caps;
 	struct platform_inst_fw_cap *inst_fw_caps_dec;
 	u32 inst_fw_caps_dec_size;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 36d69cc73986b74534a2912524c8553970fd862e..15a38b7122af6d978fac433e8c02b4da5c141e1a 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -19,6 +19,25 @@
 #define VIDEO_ARCH_LX 1
 #define BITRATE_MAX				245000000
 
+static struct iris_fmt platform_fmts_sm8550_dec[] = {
+	[IRIS_FMT_H264] = {
+		.pixfmt = V4L2_PIX_FMT_H264,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+	},
+	[IRIS_FMT_HEVC] = {
+		.pixfmt = V4L2_PIX_FMT_HEVC,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+	},
+	[IRIS_FMT_VP9] = {
+		.pixfmt = V4L2_PIX_FMT_VP9,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+	},
+	[IRIS_FMT_AV1] = {
+		.pixfmt = V4L2_PIX_FMT_AV1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+	},
+};
+
 static struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
 	{
 		.cap_id = PROFILE_H264,
@@ -760,6 +779,8 @@ struct iris_platform_data sm8550_data = {
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu/vpu30_p4.mbn",
 	.pas_id = IRIS_PAS_ID,
+	.inst_iris_fmts = platform_fmts_sm8550_dec,
+	.inst_iris_fmts_size = ARRAY_SIZE(platform_fmts_sm8550_dec),
 	.inst_caps = &platform_inst_cap_sm8550,
 	.inst_fw_caps_dec = inst_fw_cap_sm8550_dec,
 	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
@@ -852,6 +873,8 @@ struct iris_platform_data sm8650_data = {
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu/vpu33_p4.mbn",
 	.pas_id = IRIS_PAS_ID,
+	.inst_iris_fmts = platform_fmts_sm8550_dec,
+	.inst_iris_fmts_size = ARRAY_SIZE(platform_fmts_sm8550_dec),
 	.inst_caps = &platform_inst_cap_sm8550,
 	.inst_fw_caps_dec = inst_fw_cap_sm8550_dec,
 	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
index 16486284f8acccf6a95a27f6003e885226e28f4d..8342a0b6f825b385192baedfc67c50bba7661470 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
@@ -17,6 +17,21 @@
 #define BITRATE_PEAK_DEFAULT	(BITRATE_DEFAULT * 2)
 #define BITRATE_STEP		100
 
+static struct iris_fmt platform_fmts_sm8250_dec[] = {
+	[IRIS_FMT_H264] = {
+		.pixfmt = V4L2_PIX_FMT_H264,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+	},
+	[IRIS_FMT_HEVC] = {
+		.pixfmt = V4L2_PIX_FMT_HEVC,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+	},
+	[IRIS_FMT_VP9] = {
+		.pixfmt = V4L2_PIX_FMT_VP9,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+	},
+};
+
 static struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
 	{
 		.cap_id = PIPE,
@@ -337,6 +352,8 @@ struct iris_platform_data sm8250_data = {
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu-1.0/venus.mbn",
 	.pas_id = IRIS_PAS_ID,
+	.inst_iris_fmts = platform_fmts_sm8250_dec,
+	.inst_iris_fmts_size = ARRAY_SIZE(platform_fmts_sm8250_dec),
 	.inst_caps = &platform_inst_cap_sm8250,
 	.inst_fw_caps_dec = inst_fw_cap_sm8250_dec,
 	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8250_dec),
diff --git a/drivers/media/platform/qcom/iris/iris_vdec.c b/drivers/media/platform/qcom/iris/iris_vdec.c
index ae13c3e1b426bfd81a7b46dc6c3ff5eb5c4860cb..be8d2d48c82f385e4f46807f7e0dd52e469927cd 100644
--- a/drivers/media/platform/qcom/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/iris/iris_vdec.c
@@ -67,26 +67,12 @@ void iris_vdec_inst_deinit(struct iris_inst *inst)
 	kfree(inst->fmt_src);
 }
 
-static const struct iris_fmt iris_vdec_formats[] = {
-	[IRIS_FMT_H264] = {
-		.pixfmt = V4L2_PIX_FMT_H264,
-		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-	},
-	[IRIS_FMT_HEVC] = {
-		.pixfmt = V4L2_PIX_FMT_HEVC,
-		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-	},
-	[IRIS_FMT_VP9] = {
-		.pixfmt = V4L2_PIX_FMT_VP9,
-		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-	},
-};
-
 static const struct iris_fmt *
 find_format(struct iris_inst *inst, u32 pixfmt, u32 type)
 {
-	unsigned int size = ARRAY_SIZE(iris_vdec_formats);
-	const struct iris_fmt *fmt = iris_vdec_formats;
+	unsigned int size = inst->core->iris_platform_data->inst_iris_fmts_size;
+	const struct iris_fmt *fmt =
+			inst->core->iris_platform_data->inst_iris_fmts;
 	unsigned int i;
 
 	for (i = 0; i < size; i++) {
@@ -103,8 +89,9 @@ find_format(struct iris_inst *inst, u32 pixfmt, u32 type)
 static const struct iris_fmt *
 find_format_by_index(struct iris_inst *inst, u32 index, u32 type)
 {
-	const struct iris_fmt *fmt = iris_vdec_formats;
-	unsigned int size = ARRAY_SIZE(iris_vdec_formats);
+	unsigned int size = inst->core->iris_platform_data->inst_iris_fmts_size;
+	const struct iris_fmt *fmt =
+			inst->core->iris_platform_data->inst_iris_fmts;
 
 	if (index >= size || fmt[index].type != type)
 		return NULL;

-- 
2.34.1


