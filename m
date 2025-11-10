Return-Path: <linux-kernel+bounces-893764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7667BC484C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F315B3AF08A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE2929C33D;
	Mon, 10 Nov 2025 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kITpmPYR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iSi6hr+C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65D2BE05A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795276; cv=none; b=DDT9SjrQCJAY9qOWz52D2mT9ou9F1Eo1THWvtqbwSFQG9+jCcXKoN4KmcUeaCdYTqMqtveoHXZZaaDmK4YpBinmno7vy5pGMzLF6IEcq8gLO06NsosR/j3qbPHXl7HSp1EOOzpAWuozTKScqsO9IyRqFk/86nrmB85L+XCh5zo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795276; c=relaxed/simple;
	bh=MTKetGDUq1hSPczV9Qy+a8LoeThZE8micx/Gu1Kgh0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5zlKsIf8Dk6dOcXmG0UesyArCV2RtjH0VNWO55Ig470YSDg070B4f3C1K3qFblnOBow3TzqV9wyctLXhEAietnlgKYzDDDGu3OifDvTQbmXVacpwKxURXsZDfTZW8k26GWutETDxli9UmIKtkf8MAchKpJP7VM7tFvreVNsQvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kITpmPYR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iSi6hr+C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAH3fQE4166636
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0mNABpArBU95Q1JsMouDjK7QLqD19zV1Nh48KrC1tb4=; b=kITpmPYRCBAhOJGp
	SMD6//0wPDFbHXJ/9AVmQRWGS341gWqPw8o4OPWHcaD57Ij4gn46qQFcj+hf3wB6
	V3Suhz0qOCwL7FjEatvgwq5ItX3w4wmS6/mYTbshNg7duzWMLhJBjVhXQKRFe7Uw
	bS4AMmRkmNqJ5WhdxA+lVz64d+QGr713L22ph0vK90yamy1ZF+DDGpMYkeC/zeOV
	F8rboFtzyz6wTdU2vL1Xo53lHvnK02m89rqqqXiJkoKg/H0ssnY+YMtkgIRi87n2
	oaBcAk4fDL5GDsIYysH+ZNf6W3DNXoqGn+CrUfJzI6FwLKo14zCoiCMaTtFA7Hd4
	6OYkHg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abm4a01tx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:21:13 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b0007167e5so621368b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762795272; x=1763400072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mNABpArBU95Q1JsMouDjK7QLqD19zV1Nh48KrC1tb4=;
        b=iSi6hr+CI5Krznh7rDZL49BLxrzM/qNaUj681QW+CIxymDk292YhySbJP9IXV5S6fH
         Kr6unyd48Mmp5sotf6sSxM1EU5dnVQlapgSHNlASwxzYmPX4b/Vuq5vQXVXzSO5ccLyE
         k7ti3ON084poXPGBMnOQ9i3m1AgfAwOna0bCzOInB+ipKmOzRYioNJgy3Q2JXBEKAN9j
         bXJYrM1mG+4p2ZlNqB1rNm/aALIIau+hI28fLVNvv7It5ofMW7gCUixp3tW9VGh3ARbn
         S1b9n2xWgE5oJOO7QRNQlNGsb9ycdBbHRPkONb4ok4UVkL5Dpmy2gRakg7EdBa1WrU/S
         Z/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762795272; x=1763400072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0mNABpArBU95Q1JsMouDjK7QLqD19zV1Nh48KrC1tb4=;
        b=rzZdu7dIyznqX/9cOgFKLJkb0cSJ/rlVGemh749OYVHGB3Pn8/mvvkPl4bOmUl9b/s
         D1MWq5JyzioTyuvObXspok8rJjGvmkXaFP/Q6udUfwkRioPBIEntDaLenTYIrI/xXqQm
         2VFzWUoiBo7TvaYZxTIaTjjlztEL1wBznNMLszpziiT9T8JopirSOx1uZ9lDsZWbGchI
         QxdwA1Eudf3miOX5KjrcPVNa6Snqvmetoconoenly7HQNHNjj8GbN37g6XLf5rDHD0V8
         kMzfkLHnLv+LNuN2wifpu132a6DnB3F8H7SBAY6u9Tn3tl/opLQVGlev75PyL5kQcIp2
         690w==
X-Forwarded-Encrypted: i=1; AJvYcCUSoUFtRVzTHbMS/C2LQ2rN6+kypqf58hQq3leYf5bkxrVpxZTwtO9NbA5nqdJAwFipvFw+vyLUn+nUw4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmUwFHAsytuTwcZj71KS2spHj9mvTkrWctxvphtVWDpQgltTO
	e8yAd9vOP2g6xrgr9ncB6baK9RCTFirBfTRzfJaAed2TqCGOSEZ4seqW67SUwCRCwq2uHAB09xP
	WFAhSYPgZmEgl4A7bGTRdJJUBOg6UtXu5iRTmspLEr/3cVkRY2srgsbcH3Lix6qmCuuY=
X-Gm-Gg: ASbGncskzqM3vl5OLeWd8oedMWuPLYf35VULWN9qR34QwvLEd/niakBapbGtc0km/SF
	TPDndFFmSJu1H8zJE1BMJrbWVA6+JakSYWQkPajP8IDmgE43kAo7THaEpW821iR/wQorTYN2Nl5
	XFXmgnNJBC0xbgOQ4JV5UnW57VS2y6TmrZEHL7gn6nJkcmuDyVQxfMt/BLQzuhO10qKhquDiHFG
	uocCenGdtc3gwdQZk2PYoO0LaCJ0VHOC6kKkLKJD/EOYqJRklwrXx7WWLVRiZ/jamc5bxhd7Z51
	MdQkTveDY24pl6jsRNYuWz6tYa4tg+Q7GvBXdFKnsJo/PGq7MfdHJcQ3f7zmi4jYwbe0S70gP1t
	bc56DUbYd9xlRUB0bQZyn/2YXdY7V116Dst0qMfrgvkXdv0inJ/9t70Ic+sE=
X-Received: by 2002:a05:6a00:9286:b0:7ab:3883:3e with SMTP id d2e1a72fcca58-7b225ae81e4mr5824664b3a.1.1762795272117;
        Mon, 10 Nov 2025 09:21:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU4/KLDRt6W8+RGO9E2y0+YlIqw4DlSOGmu2CNuSkBiW2Hz0BGQp+ALShyAhMkbIPyqBhIcw==
X-Received: by 2002:a05:6a00:9286:b0:7ab:3883:3e with SMTP id d2e1a72fcca58-7b225ae81e4mr5824651b3a.1.1762795271465;
        Mon, 10 Nov 2025 09:21:11 -0800 (PST)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17784bsm12643064b3a.47.2025.11.10.09.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:21:09 -0800 (PST)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 09:20:59 -0800
Subject: [PATCH v7 3/5] media: iris: Add support for AV1 format in iris
 decoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-av1d_stateful_v3-v7-3-9913a15339ce@oss.qualcomm.com>
References: <20251110-av1d_stateful_v3-v7-0-9913a15339ce@oss.qualcomm.com>
In-Reply-To: <20251110-av1d_stateful_v3-v7-0-9913a15339ce@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762795262; l=7851;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=MTKetGDUq1hSPczV9Qy+a8LoeThZE8micx/Gu1Kgh0U=;
 b=cYN92BEgk9+KVHBNcsYl/98MizL+6KATIBrm1Mz8aqhNLEZUGlWo4Y07P85jDsXcrzT7piXmX
 WVSx4kQZJkvCAGqwLBov/96KhwBuwIdHJoGLg7fj7vA2fiVTFHYwILw
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-GUID: GDqkGGnNdIikFHlQG7gYlrZM2BzydZW7
X-Authority-Analysis: v=2.4 cv=G6kR0tk5 c=1 sm=1 tr=0 ts=69121f09 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Dfn2-qcXI_AzomQv4o8A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GDqkGGnNdIikFHlQG7gYlrZM2BzydZW7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0NyBTYWx0ZWRfX10w8+38NCvbW
 w+ev7ft+vAV77L1sUUz2SjoxORgmz+u7zXpeS/OUYOM9Oscf6T5IBCPTEF/WhFxhDGeysMzeBez
 slSWlVLd4NHcdrk1W3bAQzFBtkwhwx30MjisH2uwdlnF0KSYY77Zq04fkaUXNn8xjvJ5WdRzCFx
 Z01oItQjcj5cQbtdPuBRO5Zm9C4VMqc+est4P/0NYFDeBa+gQY3V50/LDjFTW8bNX11qeVcHt7o
 FIUXr3eqbu4iOAZIvYkIqllPNrFyPPAsMrdjr6Nk7B/XxU1C1eMh/kfjtwdXdoWqzrenBuTnu/p
 JV1c5uTlSYGN8khw5UmPpkHod3MbBZvY6yiGrLqJBGtaSHLe56zG9KechYNgcKOCGNIxhb3tMTh
 GP8ZZJFKScYZNiPdjo2/V3xw5eVGHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100147

Extend iris decoder driver to support format V4L2_PIX_FMT_AV1.
This change updates the format enumeration (VIDIOC_ENUM_FMT)
and allows setting AV1 format via VIDIOC_S_FMT for gen2 and beyond.
Gen1 iris hardware decoder does not support AV1 format.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
 drivers/media/platform/qcom/iris/iris_instance.h   |  1 +
 .../platform/qcom/iris/iris_platform_common.h      |  2 ++
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 23 ++++++++++++++++++++++
 .../platform/qcom/iris/iris_platform_sm8250.c      | 18 +++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vdec.c       | 23 ++++------------------
 6 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
index 1b6a4dbac828ffea53c1be0d3624a033c283c972..3d56f257bc5620aacec2bb7e11253dc7c83b7db9 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
@@ -139,6 +139,7 @@ enum hfi_codec_type {
 	HFI_CODEC_DECODE_HEVC			= 3,
 	HFI_CODEC_ENCODE_HEVC			= 4,
 	HFI_CODEC_DECODE_VP9			= 5,
+	HFI_CODEC_DECODE_AV1			= 7,
 };
 
 enum hfi_picture_type {
diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
index 62fbb30691ff967212022308fa53ff221fa24ce9..7e4f5f1dd8921c57db039fbd4bc2f321891348db 100644
--- a/drivers/media/platform/qcom/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/iris/iris_instance.h
@@ -19,6 +19,7 @@ enum iris_fmt_type_out {
 	IRIS_FMT_H264,
 	IRIS_FMT_HEVC,
 	IRIS_FMT_VP9,
+	IRIS_FMT_AV1,
 };
 
 enum iris_fmt_type_cap {
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
index 69c952c68e939f305f25511e2e4763487ec8e0de..3b61723dbf27e9ba8d427686e44cf048a0ab7c5b 100644
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
@@ -761,6 +780,8 @@ struct iris_platform_data sm8550_data = {
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu/vpu30_p4.mbn",
 	.pas_id = IRIS_PAS_ID,
+	.inst_iris_fmts = platform_fmts_sm8550_dec,
+	.inst_iris_fmts_size = ARRAY_SIZE(platform_fmts_sm8550_dec),
 	.inst_caps = &platform_inst_cap_sm8550,
 	.inst_fw_caps_dec = inst_fw_cap_sm8550_dec,
 	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
@@ -853,6 +874,8 @@ struct iris_platform_data sm8650_data = {
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu/vpu33_p4.mbn",
 	.pas_id = IRIS_PAS_ID,
+	.inst_iris_fmts = platform_fmts_sm8550_dec,
+	.inst_iris_fmts_size = ARRAY_SIZE(platform_fmts_sm8550_dec),
 	.inst_caps = &platform_inst_cap_sm8550,
 	.inst_fw_caps_dec = inst_fw_cap_sm8550_dec,
 	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
index 16486284f8acccf6a95a27f6003e885226e28f4d..0297756a3724181498ed8e5776dd5b872f1d4304 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
@@ -11,12 +11,28 @@
 #include "iris_hfi_gen1_defines.h"
 #include "iris_vpu_buffer.h"
 #include "iris_vpu_common.h"
+#include "iris_instance.h"
 
 #define BITRATE_MIN		32000
 #define BITRATE_MAX		160000000
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
@@ -337,6 +353,8 @@ struct iris_platform_data sm8250_data = {
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu-1.0/venus.mbn",
 	.pas_id = IRIS_PAS_ID,
+	.inst_iris_fmts = platform_fmts_sm8250_dec,
+	.inst_iris_fmts_size = ARRAY_SIZE(platform_fmts_sm8250_dec),
 	.inst_caps = &platform_inst_cap_sm8250,
 	.inst_fw_caps_dec = inst_fw_cap_sm8250_dec,
 	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8250_dec),
diff --git a/drivers/media/platform/qcom/iris/iris_vdec.c b/drivers/media/platform/qcom/iris/iris_vdec.c
index 69ffe52590d3acf8d595f856fb1dbd81f3073721..bf7b9c621cb7255367c06f144c03c3faa69372e0 100644
--- a/drivers/media/platform/qcom/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/iris/iris_vdec.c
@@ -67,21 +67,6 @@ void iris_vdec_inst_deinit(struct iris_inst *inst)
 	kfree(inst->fmt_src);
 }
 
-static const struct iris_fmt iris_vdec_formats_out[] = {
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
 static const struct iris_fmt iris_vdec_formats_cap[] = {
 	[IRIS_FMT_NV12] = {
 		.pixfmt = V4L2_PIX_FMT_NV12,
@@ -101,8 +86,8 @@ find_format(struct iris_inst *inst, u32 pixfmt, u32 type)
 	unsigned int i;
 	switch (type) {
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
-		fmt = iris_vdec_formats_out;
-		size = ARRAY_SIZE(iris_vdec_formats_out);
+		fmt = inst->core->iris_platform_data->inst_iris_fmts;
+		size = inst->core->iris_platform_data->inst_iris_fmts_size;
 		break;
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
 		fmt = iris_vdec_formats_cap;
@@ -131,8 +116,8 @@ find_format_by_index(struct iris_inst *inst, u32 index, u32 type)
 
 	switch (type) {
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
-		fmt = iris_vdec_formats_out;
-		size = ARRAY_SIZE(iris_vdec_formats_out);
+		fmt = inst->core->iris_platform_data->inst_iris_fmts;
+		size = inst->core->iris_platform_data->inst_iris_fmts_size;
 		break;
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
 		fmt = iris_vdec_formats_cap;

-- 
2.34.1


