Return-Path: <linux-kernel+bounces-892374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E18C44F41
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDDE634652F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832CE2E9EC3;
	Mon, 10 Nov 2025 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j0gFEc4I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XyEW7Bz/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D857278E47
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762751136; cv=none; b=MeL+h3tfJt7dU9NvELH625eHlWYi876wtUxVK3cZTkQC5VpJqcy5PRl4D/XaDDxboKrSudxdBOGfEady/yQ+TMmOtJDo8oSPdTWyiNqIOfwYJCXTxL3C2DWJdD82Zp0aIdZmxdOr/wCIuzSsssb1mnB14ktjne0Grxi1KDqhELw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762751136; c=relaxed/simple;
	bh=MTKetGDUq1hSPczV9Qy+a8LoeThZE8micx/Gu1Kgh0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phwfF81OJe8xH4NaSb8fClHcUfq5fXsoIp1LWRtVZRxC0amHmbwS/cQMySaY5kVXnvqnkTpnIKA/rCMP5seIyNJLJ82B+VucUBi5iFxwE496vmTd6J8p7kSxFRhSUkxRcurJf09EEd50199DPT2rfEq3IqshXZSnxvrBw0lPIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j0gFEc4I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XyEW7Bz/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9MRJhc1799077
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0mNABpArBU95Q1JsMouDjK7QLqD19zV1Nh48KrC1tb4=; b=j0gFEc4IiqFwEJAN
	MRKzBfLXiwtl804EGkQ8oy7Z2YNJjri2r7Trb1FQxugvGYE6rn7AOOzTrTMA5our
	Usg+b1e1vGEsVEad76lxu/A2rsPTW7HXPAbSrfcjJvNr9C19YAbRJ+FTPcltZW1e
	BpuIYMMuqirYuhnk8xlk3w0lLLi8T2upFJNjt/Bjz+uCh5IkRpkSCtrZGJ3CWkhK
	hP7hb2B42vIHe9mNmlx96gZu62zNH4mrFzH0d/G12saLeI8hGeEspMFf1MCstFsc
	FLm++qi/ns/niF4+U1gkfReptUcNqr/n3Jn9QJw3AAxJ6F162+h+8oqo5aORFKIe
	eTQMtA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xuekdhn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:05:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340ec9b90faso937819a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 21:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762751132; x=1763355932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mNABpArBU95Q1JsMouDjK7QLqD19zV1Nh48KrC1tb4=;
        b=XyEW7Bz/7KBd+7QW9E5CDCh3zgyzMBOjffRYiGUEeuvLVAofu8DXCX/LRggGPbY+gW
         +OVjXyeFRDEXxIl0++lm7MM4o0opKKPjaBB6LaLMGhHGD3pQIZyMygOMYWfiVQOXj7it
         8xXGtu5MSJ5hZBLbogBrTRfbsPlMfroUctPt9zRBMT8i4sNndGxV+mxV9vUIQdXqAysg
         z+9DRaNlzbsInJlabxPVgci6Gdm47lGBm6HR0ZWUZSwLCYAqD9KieP6kgMvFAHR0xTB3
         dU/r8eWSx/z8jQwPgPfNaI5/ecRGlzzbL+5WUUCdcmjmEI7JlbNk0UJoacvH7CDOo1Cb
         YjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762751132; x=1763355932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0mNABpArBU95Q1JsMouDjK7QLqD19zV1Nh48KrC1tb4=;
        b=ervJfryJkgZL4zrFRnLSSWLa2uOIRy/VCPdkb/Tm6QztkzZvo/ERrFCVMY0x8Age5+
         vT2CbhnlPz4d+ste2EyVdP13YLx+TlIrnJM6bG25idPPhvHPfAEswqQRKLssEAKHey7P
         XRNL1KrFsg5Fnt0gVVLMh7adCbmOFG10nFezLDzGvWja/zEk7Cup6QGGP7Pdx3ekkD+U
         xNXz4bqyWlXtwQPHmVtD7XAH14X57QVwMF9BSTdzlCyrJMgHeZnvx44NpbMrkAiz9Rq6
         y5xl6Ap0c0PMmr15hvbtcB2cctOTReJ+eXEMQmbfOS9Z65Xy11t0qGd6amPfxUSMsiaF
         7RPw==
X-Forwarded-Encrypted: i=1; AJvYcCWg0V7lUj2EvCELQG0SMqSunfoEh5EU1bydmGQ4DBiwfJ069p21l0DfshfC4bUBrZogtsCiobj1rM0lB+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4QaVSK54h2zzYw6bPyePM46lIITOLU4gECEwFCNLsP6ypkmV
	IucXYRD7Q2kEl0goPOrzIQsmy1sxznESSYmnkJRImaJxavScU7t1Yu/uZm2BhpjmBrsZl5t7OLJ
	VJ6XUU1QcbjiC3kNMaE+ygJdaVoDAoAayy93TMcf8YrItvssn2frOXRDZVEPzhtswdtk=
X-Gm-Gg: ASbGnctwqXrPUM4Itt6fhdFt+n8HAs7cIQVC5lQ+YFPhph8z113xnNBvMqtJDn92/MT
	vY66xX4EgUDW2EpQdU/9+Y1cRJREzdS8uvQpkYOlyYyPUoG+1ARe6hcb/aEIcOXRYjnzj1wZIvK
	2WJTsCwNY5+rI8e7Ogl94Xjijz42XgrTTNOmjg7ifUs3xjn+on7jFBIUfMtUNA94yRxBqxR4nID
	YZtcSK9DiJKUfr+KShktbCm1rjbzeQGvPxenL8Ch9LU/qtaJJjdYgTfjCBO2EQMdZ/eVoLgitbr
	dt2Z7h+ErG/0pqpbBf94DNkpfl7BR6F4tLfXzycTLrNiOkLXsCVnFqyMliXm3O2mHdg1+KW4BTO
	eay5WwghEMQel2nJmrR2urN/SA00J2ftSHIrWsPfKak7RKEeiwMiJKjNnaJU=
X-Received: by 2002:a17:90b:4a51:b0:338:3156:fc3f with SMTP id 98e67ed59e1d1-3436cbdb47fmr5137795a91.4.1762751131880;
        Sun, 09 Nov 2025 21:05:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5gC0B90Z5BNAfnYo1/wX7tkdjrMYt6DqcmorXIOLqeMwlvAZprV83hhtfOUGQi6rFoNywgQ==
X-Received: by 2002:a17:90b:4a51:b0:338:3156:fc3f with SMTP id 98e67ed59e1d1-3436cbdb47fmr5137783a91.4.1762751131406;
        Sun, 09 Nov 2025 21:05:31 -0800 (PST)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343705c1354sm5913748a91.18.2025.11.09.21.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 21:05:31 -0800 (PST)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 21:05:17 -0800
Subject: [PATCH v6 3/5] media: iris: Add support for AV1 format in iris
 decoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-av1d_stateful_v3-v6-3-4a9bde86025a@oss.qualcomm.com>
References: <20251109-av1d_stateful_v3-v6-0-4a9bde86025a@oss.qualcomm.com>
In-Reply-To: <20251109-av1d_stateful_v3-v6-0-4a9bde86025a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762751127; l=7851;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=MTKetGDUq1hSPczV9Qy+a8LoeThZE8micx/Gu1Kgh0U=;
 b=Zxav/k5fMjUthxz6Zefc36Dy82EwTZdtkOecvJkiSgkgPZL1MfvRF8EweTf4Zcch/hGo7rsmi
 sOk4iod+EyJDpX69k7Xhj8rFvGbIBEEnYRmY9040jjMxxAM/JDJU9bX
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA0MSBTYWx0ZWRfXzXN1XwjavprJ
 SPmKWD80jgQrFh82A+Ov2wjJvRECD9sZWbrprNT8HdgJ9gZ708f4zaKpSDFjKsOhuDqZHAmDDkD
 xKgfIw2zNj6inhQLRawfwWr68bi0z4TLn2Asqi66wct4ZdNKEEOThk4pEYFTgnmNT4bIcwh4jWp
 YBDzDyQbAzb5b/g1vnNL0MuXvz/iA9fLdqGthEE2C8TCxwzrUUXseicPEp+Ubnps4AwkgIiArYG
 jPdEumw8UVbHXTPyC/JWuKb9rljLBlJJiwL8qMmMT7ij05xTMTFk4V7hR6jh9A5YnqC5z6DBJrj
 FVI5VhTHl7Q1Uj/Z9JAv2skbDEl5mw84J1oTw1D/kpRA5SyxW+CCDZc1XNgK8uIe34L7n7nkZ8r
 X/A0MQkupxrb0u8wMwboeHs0ahtjZQ==
X-Proofpoint-GUID: sSQ_T78W2Y02dthI7xheykhl901T001G
X-Proofpoint-ORIG-GUID: sSQ_T78W2Y02dthI7xheykhl901T001G
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=6911729d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Dfn2-qcXI_AzomQv4o8A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100041

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


