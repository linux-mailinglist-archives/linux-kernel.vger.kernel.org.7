Return-Path: <linux-kernel+bounces-854189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 466B4BDDCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C382188971C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2292131B118;
	Wed, 15 Oct 2025 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RH2ZkpRc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60831AF2A
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520648; cv=none; b=lCWxa27XVXEsfH1w4uUh88iFsUNvRk+4b+jogSTIdxz7zV74ep+tOBefZIwcMGom/asQhs5wPVyXf94YrmVp/XrCr53Uo7KjD7Pxf1sWYvxu9sLyoV1qJ/GA0JpiZpLhajImER7PQTE1NB+Vf9b6/7oaizzYMfMyM15LmoYvf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520648; c=relaxed/simple;
	bh=DmlEsMR+J+RT2iFY57uF5sBAhQjAJl1Bqyi5WbIUOrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpS5ayBmFCxvcHJu6N8F+hEHLibvPKOSNv++xdTNCUqndg8EwNOpgTyrNlewbkaLAP/dF7AEDYI2FWKBF1Tz6+N1ltQfLepW5VtgO03Rt7BcDDhHuRFzPP+FCuzcehf4eO+QTcvKH7YGTMY0VfZ9EwoepyaAqPJSYbgbXend8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RH2ZkpRc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sJae024921
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7TIca1e9JsU
	0YqiknSuI6bsGJcWrXGuG38I3wRPWQjY=; b=RH2ZkpRcFAPxRLmk5pXjvBeotmF
	6OnyVXO/Y30vwdSQsRU4BQ0OiySMYgzCgL6pLus7Wlpty7z4sOAZYNtZO9u6Nx3p
	+CfnvJAEiJfsfya0459TrKtF+uuaDyGbnl5j0EA7A/qkDJf8mFK77cQA7B/qF8Dr
	FT+GBXlsvbmiaWDqXvYDa7SygjPTLQcEOW/dyLdn7FLm3ssckBL1/tJ6CvNhJQYo
	WF22r9PARbm6AyBps7dHWuVkAPgMVW6sy/DdMkUi9/1192xAX954abCADNWhSK/s
	2RxxaVVdCdcorTMdi4bqjKH91Bb4xhO35VrH0uTqi336OAh3y0wbemWdDCg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0uuug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:30:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b557abaad02so14542551a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760520645; x=1761125445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TIca1e9JsU0YqiknSuI6bsGJcWrXGuG38I3wRPWQjY=;
        b=H/jFjAg/L/8hE+M0HI43mpm93eX6lH55KwQrmLcQch5VT4i6hL6pDnYy5T1ha7c4hw
         CEigebHgcAQDedMdnziBydvea2ieuKEbED4dcRIsmByvtAgkYzAVRkZtoL5b/QxROx9M
         7dqoaEIQ4zzfj/1yX/pmVm5dcMFw/BQcMCFw8LLv/Si/OGjrmCOwG5E/xpnXgPzGCp1r
         OQyIgBl3KU3s2HFXYtDQhEwTXtL2T3Hp6xM9x+RcGmT0ZT1ZeaaciFlJY+hymZTNDsWh
         PF8Sd+qmG1CMaHfx3K1BPOmCdReJRrq3xisGPBUdG+dDqJG5wYyqIP7WZSFDfga0qXG0
         7pyg==
X-Forwarded-Encrypted: i=1; AJvYcCWXRqbD6lBPN0umbDIBySJ89FOpv3SFIX38jVHnxGu51fAIFY5iIlR5Q2jbdkgoUiSI7Wrl4l+Uap4gdtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAFb1UgCR3zp+ryFhZ7H6HWERwDtOm+r8UtRIE9OFtnEOxd4GO
	041ojonJEC0i5Nrq3wJCkIsHMQzIzgeNqiEtabYZliuodMDcajyyC4g12Cim+uWXzxyURubkB7v
	bpT4jDcPp3Wu7SJufs4DhYxB42PXzistEVpNzDnfXgNgfUGnk0toSDRpL43Kjxl5QnkQ=
X-Gm-Gg: ASbGnctgK4p4XibKuMDzSVtkWCvVoxASKsgtH3cKvbRecwsndKEwKAsWAb4xtsZcVz9
	zzvMiyB2qlXV4TEJMUoFvvg99vSds6ey8Dwu6FXW7h9TpyGTGwD3xMOI/hIchGBo5nmaJvOTuGC
	9ePZ7pbg2K0j32pFhqqyDQhXrN6gjqCw3UYPF1VFyImf2DyG2go8ICjfeIRtlfGWcd+LJ6FvlZp
	NJsyC5PwZ9w8ZfScVvpEBYDL2+NVNCXLK5Q7wvrfLkEIXcQnw5v83TCsWPJlAEdw2KX2Jj8JDhT
	ZoZJ0//7ox27KbmFEoOGa53ywZzw7CMp60Uu7haOokg4sXBpPLO4ZzbCtgvzkG2xZBASctskknT
	iTSi62DTBrsEirWjbQ9TvnWKCWxG5bELmoXQ=
X-Received: by 2002:a05:6a21:99a6:b0:29e:8da0:bf8b with SMTP id adf61e73a8af0-32da8171cf6mr40047998637.26.1760520644784;
        Wed, 15 Oct 2025 02:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnu0B9tkpiFuiMl2f3c84BVST18PQEOkGPG+hA3GMt8X9omvFiSZekM8mgPRNyYlTlDpkWXg==
X-Received: by 2002:a05:6a21:99a6:b0:29e:8da0:bf8b with SMTP id adf61e73a8af0-32da8171cf6mr40047953637.26.1760520644284;
        Wed, 15 Oct 2025 02:30:44 -0700 (PDT)
Received: from WANGAOW-LAB01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09aa20sm17946745b3a.39.2025.10.15.02.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:30:43 -0700 (PDT)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
To: vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        abhinav.kumar@linux.dev, bod@kernel.org, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com, Wangao Wang <wangao.wang@oss.qualcomm.com>
Subject: [PATCH v1 1/4] media: qcom: iris: Add support for scale and improve format alignment
Date: Wed, 15 Oct 2025 17:27:05 +0800
Message-ID: <20251015092708.3703-2-wangao.wang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015092708.3703-1-wangao.wang@oss.qualcomm.com>
References: <20251015092708.3703-1-wangao.wang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8YcDHvaSHQxZ
 CxnLkf7+HvqRNh6cBDT+tZnZpV40QkwpzkzgIy5qUWuP4NAxNjsRk4A8PqFu1KwGyEo8YI4Jh5U
 l1SKiR+wXzl4QXYRH7/oo5NtGJzig7vQVab7kD+grBZO4Q+RqVpayu6bnODYoGOWYAatN+e16wX
 NJyYteCj6INFN/71PDfXMRDwfJ/Zrpr1W3gHlaevyhFS+xb+02IU5rY43T64WW99qX2oeFoN7Wq
 HBK8qnYdlD1xLIwq/avYbBzMIyq/KMDeihIC//RLqHLKm92/EryU3ZiVNi3MgSk+k6kqwHuckZh
 prSpnCMN4GoMpIUXQvqGrkvmcZEe8Koo5Wgreg7rg==
X-Proofpoint-GUID: MLkZ_h1JvCBRLVR1up-3qgqaXbpXuEoE
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ef69c5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=t9PYRtjW5FeJurcX_tkA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: MLkZ_h1JvCBRLVR1up-3qgqaXbpXuEoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Add output width and height settings in iris_venc_s_fmt_output to
enable scaling functionality.

Add members enc_raw_width, enc_raw_height, enc_bitstream_width and
enc_bitstream_height to the struct iris_inst to support codec
alignment requirements.

HFI_PROP_CROP_OFFSETS is used to inform the firmware of the region
of interest, rather than indicating that the codec supports crop.
Therefore, the crop handling has been corrected accordingly.

Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 .../qcom/iris/iris_hfi_gen2_command.c         | 18 ++++++++----
 .../media/platform/qcom/iris/iris_instance.h  |  8 ++++++
 drivers/media/platform/qcom/iris/iris_venc.c  | 28 ++++++++++++++++---
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 4ce71a142508..c2258dfb2a8a 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -168,9 +168,12 @@ static int iris_hfi_gen2_session_set_property(struct iris_inst *inst, u32 packet
 
 static int iris_hfi_gen2_set_raw_resolution(struct iris_inst *inst, u32 plane)
 {
-	u32 resolution = inst->fmt_src->fmt.pix_mp.width << 16 |
-		inst->fmt_src->fmt.pix_mp.height;
 	u32 port = iris_hfi_gen2_get_port(inst, plane);
+	u32 resolution, codec_align;
+
+	codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
+	resolution = ALIGN(inst->enc_raw_width, codec_align) << 16 |
+		ALIGN(inst->enc_raw_height, codec_align);
 
 	return iris_hfi_gen2_session_set_property(inst,
 						  HFI_PROP_RAW_RESOLUTION,
@@ -195,8 +198,8 @@ static int iris_hfi_gen2_set_bitstream_resolution(struct iris_inst *inst, u32 pl
 		payload_type = HFI_PAYLOAD_U32;
 	} else {
 		codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
-		resolution = ALIGN(inst->fmt_dst->fmt.pix_mp.width, codec_align) << 16 |
-			ALIGN(inst->fmt_dst->fmt.pix_mp.height, codec_align);
+		resolution = ALIGN(inst->enc_bitstream_width, codec_align) << 16 |
+			ALIGN(inst->enc_bitstream_height, codec_align);
 		inst_hfi_gen2->dst_subcr_params.bitstream_resolution = resolution;
 		payload_type = HFI_PAYLOAD_32_PACKED;
 	}
@@ -216,8 +219,11 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
 	u32 port = iris_hfi_gen2_get_port(inst, plane);
 	u32 bottom_offset, right_offset;
 	u32 left_offset, top_offset;
+	u32 codec_align;
 	u32 payload[2];
 
+	codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
+
 	if (inst->domain == DECODER) {
 		if (V4L2_TYPE_IS_OUTPUT(plane)) {
 			bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
@@ -231,8 +237,8 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
 			top_offset = inst->compose.top;
 		}
 	} else {
-		bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
-		right_offset = (inst->fmt_src->fmt.pix_mp.width - inst->crop.width);
+		bottom_offset = (ALIGN(inst->enc_raw_height, codec_align) - inst->enc_raw_height);
+		right_offset = (ALIGN(inst->enc_raw_width, codec_align) - inst->enc_raw_width);
 		left_offset = inst->crop.left;
 		top_offset = inst->crop.top;
 	}
diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
index 5982d7adefea..f371b1cbef47 100644
--- a/drivers/media/platform/qcom/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/iris/iris_instance.h
@@ -64,6 +64,10 @@ struct iris_fmt {
  * @frame_rate: frame rate of current instance
  * @operating_rate: operating rate of current instance
  * @hfi_rc_type: rate control type
+ * @enc_raw_width: raw image width for encoder instance
+ * @enc_raw_height: raw image height for encoder instance
+ * @enc_bitstream_width: bitstream width for encoder instance
+ * @enc_bitstream_height: bitstream height for encoder instance
  */
 
 struct iris_inst {
@@ -102,6 +106,10 @@ struct iris_inst {
 	u32				frame_rate;
 	u32				operating_rate;
 	u32				hfi_rc_type;
+	u32				enc_raw_width;
+	u32				enc_raw_height;
+	u32				enc_bitstream_width;
+	u32				enc_bitstream_height;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
index 099bd5ed4ae0..25c05123dee4 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.c
+++ b/drivers/media/platform/qcom/iris/iris_venc.c
@@ -68,6 +68,11 @@ int iris_venc_inst_init(struct iris_inst *inst)
 	inst->operating_rate = DEFAULT_FPS;
 	inst->frame_rate = DEFAULT_FPS;
 
+	inst->enc_raw_width = DEFAULT_WIDTH;
+	inst->enc_raw_height = DEFAULT_HEIGHT;
+	inst->enc_bitstream_width = DEFAULT_WIDTH;
+	inst->enc_bitstream_height = DEFAULT_HEIGHT;
+
 	memcpy(&inst->fw_caps[0], &core->inst_fw_caps_enc[0],
 	       INST_FW_CAP_MAX * sizeof(struct platform_inst_fw_cap));
 
@@ -185,15 +190,27 @@ int iris_venc_try_fmt(struct iris_inst *inst, struct v4l2_format *f)
 
 static int iris_venc_s_fmt_output(struct iris_inst *inst, struct v4l2_format *f)
 {
+	const struct iris_fmt *venc_fmt;
 	struct v4l2_format *fmt;
+	u32 codec_align;
 
 	iris_venc_try_fmt(inst, f);
 
-	if (!(find_format(inst, f->fmt.pix_mp.pixelformat, f->type)))
+	venc_fmt = find_format(inst, f->fmt.pix_mp.pixelformat, f->type);
+	if (!venc_fmt)
 		return -EINVAL;
 
+	codec_align = venc_fmt->pixfmt == V4L2_PIX_FMT_HEVC ? 32 : 16;
+
 	fmt = inst->fmt_dst;
 	fmt->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	if (f->fmt.pix_mp.width != fmt->fmt.pix_mp.width ||
+	    f->fmt.pix_mp.height != fmt->fmt.pix_mp.height) {
+		fmt->fmt.pix_mp.width = ALIGN(f->fmt.pix_mp.width, codec_align);
+		fmt->fmt.pix_mp.height = ALIGN(f->fmt.pix_mp.height, codec_align);
+		inst->enc_bitstream_width = f->fmt.pix_mp.width;
+		inst->enc_bitstream_height = f->fmt.pix_mp.height;
+	}
 	fmt->fmt.pix_mp.num_planes = 1;
 	fmt->fmt.pix_mp.plane_fmt[0].bytesperline = 0;
 	fmt->fmt.pix_mp.plane_fmt[0].sizeimage = iris_get_buffer_size(inst, BUF_OUTPUT);
@@ -249,6 +266,11 @@ static int iris_venc_s_fmt_input(struct iris_inst *inst, struct v4l2_format *f)
 	inst->buffers[BUF_INPUT].min_count = iris_vpu_buf_count(inst, BUF_INPUT);
 	inst->buffers[BUF_INPUT].size = fmt->fmt.pix_mp.plane_fmt[0].sizeimage;
 
+	inst->enc_raw_width = f->fmt.pix_mp.width;
+	inst->enc_raw_height = f->fmt.pix_mp.height;
+	inst->enc_bitstream_width = f->fmt.pix_mp.width;
+	inst->enc_bitstream_height = f->fmt.pix_mp.height;
+
 	if (f->fmt.pix_mp.width != inst->crop.width ||
 	    f->fmt.pix_mp.height != inst->crop.height) {
 		inst->crop.top = 0;
@@ -329,9 +351,7 @@ int iris_venc_s_selection(struct iris_inst *inst, struct v4l2_selection *s)
 		inst->crop.top = s->r.top;
 		inst->crop.width = s->r.width;
 		inst->crop.height = s->r.height;
-		inst->fmt_dst->fmt.pix_mp.width = inst->crop.width;
-		inst->fmt_dst->fmt.pix_mp.height = inst->crop.height;
-		return iris_venc_s_fmt_output(inst, inst->fmt_dst);
+		return 0;
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0


