Return-Path: <linux-kernel+bounces-892826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF3BC45E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2FE21891AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CA930594A;
	Mon, 10 Nov 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KM98pA+P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZlQC/bLE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B730748C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770233; cv=none; b=mncKRbMI4FQHktul60PdBHpxSKdp7bxBMeAkIIvFMMHk0OaITUYgGDR5sR9XYXdOVXrE67aozZ0idlyNwQYX95+4lr+1QR4PfoNgm4vvO73dM+639M0kFtPkBAMjFS/0dCPyrM9fJpMC0PlAQ+Xd6fex9QEb+Ersq9M6d5DIPK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770233; c=relaxed/simple;
	bh=lVFv/OtNBLwqn6a5CD2oGnT7NWgB2FFWJBFEkJObsXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvcSxgh7BeDaqDTgkQHwmSPgNCIceKHKCr15btId7wHCyrgyuSrLKCU5ZPJd+GhAMJ85YDoquyJ6qEeU8bbiBZ8U+Okj7D1uFXtXmj3SUtOtnzqn+rEEc8ZGliKGTx/0RLJxqNS3zP5qhYfb+gdnCyfBOmaeO1v/UdO6y4GNSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KM98pA+P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZlQC/bLE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8Y63c1528423
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jWLaambQBmLPwSmzVJabmwHY9UHDsvgaLj8OV6ZYfoQ=; b=KM98pA+PKRCVtlxW
	YqgljXztOtTy9W7MsJwRL+PNmhnc7p/WlCf3eIMVxWD6B7yu6nq7mpB4bYsp2+Ab
	QrjX49uKv3RQgkWlhiRZdKJ+voVHgPUvcctsz2z5nyFFlUvfmlodX6e9JecQaOqr
	MnghuOniSlpmKukSa+02Z5LjOlR2ToNAc3qvgckRxMLSSF5a09lYpQ8HcntI2KGJ
	5J+Bzw/WQTkXMKAkzPFsvFMsDc6kly0aNMDnYxFZSYH33r1OuMCevq+7Am8H1F6D
	NQmTh3Fj5/bxTE/PMCgTXe8L4Q0pU4lD5c895as5wezfBs8FWkpfxp7bAckh/8LK
	1HqCrQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xvjcbuq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:23:48 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a153ba0009so6677598b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762770228; x=1763375028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWLaambQBmLPwSmzVJabmwHY9UHDsvgaLj8OV6ZYfoQ=;
        b=ZlQC/bLEdZI3aa6a23O4myywfDVl0xfoOuUhunUq3YH7R7Hn7eKjfvok9LP4RhsPfa
         95bnvwW5rkBDi8mH3DuIrDMctbEsyzU7pBGFZC/X3M5S5LtCUBRRrGvG98/HYSK0MB7S
         oAVtX5kis6yrDw+3ycbBqg9DPc0fhr9/j47pd8Ew52tvvjGXtdgPgwjj7jRzaXEO7cZq
         oAyqN77NiLvSe8eAmLeh6mLrz4q10kXCXYJtxaXExOuF537xWmYkQ5n+Wv+rLAGIdPeC
         HHOD+ny+XVg0K9oSxf2Y0aNJ07Om33geVVgZvsjmfBdmqUaAyGufxBLjonrTv/4scGZo
         EQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770228; x=1763375028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jWLaambQBmLPwSmzVJabmwHY9UHDsvgaLj8OV6ZYfoQ=;
        b=a7W1fTlxaejHKBC28bIFO5FIlQ/Z//p7f5V7PR9nxopSWmz/qT3Rg81HdyNzIx/C6a
         LC9PmaaGJaU16GMBGA7oVlCwTJHLoxHlgm6NssYImX+jffRvqh9hkH49SRD5zIceCO6z
         idWrKc5tm83qd9q6tTJlrn0Dn5sA8xVPI8U4oxbpHgy9QNj4LeJUbZs3D/qT0Htv12SZ
         LHX9ClhIrUFZ8RfnEWNTR9xki5bxceq/t7StPVVIA5fNJ9ZfeDDWMP/Bpz9B9XGMFzdt
         JQmymaTNPB1rfrdm4Jp9dsD5AhHTBSqbz5oWsuTctEpQj9FXOL9HLcgF8I8q6VC/MZkx
         B7rg==
X-Forwarded-Encrypted: i=1; AJvYcCUojbEe1lkQEK2qSlDi2XtHvPfPHLXB+BYu18Kg5K/XFB8+OBGBtVi0ZVIxpqGODe8HGSZ7HCzcO7o3ecE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzePm7vk257IRgf6MBHp0xSlL/E2FOk424lcBvDzV01WSo4OL9g
	l0u/7vrC4PWQ/ybdPUQsaxMPLRp731NNZRZzq03fqb0U3tE7yFqGB8m1CJDuI8cD23lRlbGlhRx
	2njtzGGijEkPVm8f/CbESYkKDgeT074kAtVJIveP2o/pnYgktmBFbM8S7hXJ44kJMkzg=
X-Gm-Gg: ASbGnct2hn5W3oyAuVN/jnT9Wzokv7TLOdxTQyNlVoW7EXrKC+emKx9mR1ooeJr6A85
	0GdWI4L7EadUKpAXtDIuPURPosed+alxnIZgsiRRwsSqT0AvoD8eU44abE0/CCGsocaTwabDXNd
	MC0pJFO2c7xOX2ZIwKxotv3nQyzJCcJB4DJ7mgbwcVLkbaj8/N5ksJGnXpRe/HDk8PJ69lIcC6E
	UhjR65d+CHGvUXgJJj4Qr/a+aNBECZKUepF6/7WGKGDiV4CTOvvM1etheS358tSF86BrmVkgUD2
	VFlEUYCv+D6H1pcGmTNECQxyhOS95ZrLY0bo64UxH5Tv9AIu4z7ndUNBC/FQ4fUH0W5xarJa9JE
	N5YmEX/u0eBUFrmu6sy/6Cta2JmdrroNztwQVSBiTc0iUq0U7EYfjaWyBG1uqv/TdEaZbs5xqlQ
	==
X-Received: by 2002:a05:6a00:3d56:b0:7a2:766f:5198 with SMTP id d2e1a72fcca58-7b227179fb2mr9687161b3a.29.1762770227539;
        Mon, 10 Nov 2025 02:23:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFg1KGtB32amIETPbo+8yBd/KfZW1HjuRU7uEornfBJH9Cd1fAwe6n4euUQq+fpurdNujjJFg==
X-Received: by 2002:a05:6a00:3d56:b0:7a2:766f:5198 with SMTP id d2e1a72fcca58-7b227179fb2mr9687132b3a.29.1762770227006;
        Mon, 10 Nov 2025 02:23:47 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm11153832b3a.34.2025.11.10.02.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:23:46 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 18:23:14 +0800
Subject: [PATCH v5 3/6] media: qcom: iris: Add scale support for encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-iris_encoder_enhancements-v5-3-1dbb19968bd5@oss.qualcomm.com>
References: <20251110-iris_encoder_enhancements-v5-0-1dbb19968bd5@oss.qualcomm.com>
In-Reply-To: <20251110-iris_encoder_enhancements-v5-0-1dbb19968bd5@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wangao Wang <wangao.wang@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762770213; l=9582;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=lVFv/OtNBLwqn6a5CD2oGnT7NWgB2FFWJBFEkJObsXU=;
 b=JtODA6JaKKYpnWQefYX+wcOiz2Fex3YNqU3ZeJD4gkbeJYH8q7ABqFjLHuWNB1dFEiGyQNMFw
 N4h3AV9YzPtDN8fD+nTVtwLRi940smAu1LZyXKNiAZiqM5QgJElxB98
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Authority-Analysis: v=2.4 cv=QuxTHFyd c=1 sm=1 tr=0 ts=6911bd34 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Z8iH8PakIHK9AZBxCNEA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: YE3_SKcS-JdKc8rpOSdjFuODUQxawrWA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MCBTYWx0ZWRfX6SO6cgbNG7Vt
 SzaYUJWr7F827iGkCM4tv3jLG76XyK5g0buzXROY2dZwjGoHSsipqxvGOeqyP7PwwAmRR+HGnFc
 oEDrLJC8XcD6GMR8s9CgO94dXAkiZ+/JbSkzXg1noyhXUbvlO7ThYNylzpuVOeQrx399gcs1Jsq
 Gp/O+xVJBUeuWxU7Ugp4oufp0dikQDjenP2fSfpm/Hdia3paD1c28qORso+Po0OLPVFa6zH04vW
 pmfcnGJrxELv5fCpKCHa3fPsGFPT484VQdRz0Qzu0JjFlxNFNeWgvoNMyZuzaozJvD5ojmK8EWr
 rPu6mj4ZxoF15+ieZRHtC3vLEYyYjd20IdcprDMfW/mCQguRlZ6ObeQFowsyYdDJMFui9YJv8L+
 Gayaft3yeBPrCub5FHxUj6mPiCOu4w==
X-Proofpoint-GUID: YE3_SKcS-JdKc8rpOSdjFuODUQxawrWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100090

Add members enc_scale_width, enc_scale_height to the struct iris_inst to
support scale requirements.

Add output width and height settings in iris_venc_s_fmt_output to
enable scaling functionality.

Add VPSS buffer to platform data, which the scale function requires.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_hfi_gen2_command.c     | 12 +++++------
 .../platform/qcom/iris/iris_hfi_gen2_response.c    |  2 ++
 drivers/media/platform/qcom/iris/iris_instance.h   |  4 ++++
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 12 +++++++++++
 drivers/media/platform/qcom/iris/iris_venc.c       | 23 +++++++++++++++++++++-
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c |  9 +++++----
 6 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 30c0cbe22d1d34b5bbbc6bdbd3881dd43a6ff647..8945e94ec9e87750fc87bebf63f4fbb634d8571a 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -194,8 +194,8 @@ static int iris_hfi_gen2_set_bitstream_resolution(struct iris_inst *inst, u32 pl
 		payload_type = HFI_PAYLOAD_U32;
 	} else {
 		codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
-		resolution = ALIGN(inst->fmt_dst->fmt.pix_mp.width, codec_align) << 16 |
-			ALIGN(inst->fmt_dst->fmt.pix_mp.height, codec_align);
+		resolution = ALIGN(inst->enc_scale_width, codec_align) << 16 |
+			ALIGN(inst->enc_scale_height, codec_align);
 		inst_hfi_gen2->dst_subcr_params.bitstream_resolution = resolution;
 		payload_type = HFI_PAYLOAD_32_PACKED;
 	}
@@ -237,10 +237,10 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
 			left_offset = inst->crop.left;
 			top_offset = inst->crop.top;
 		} else {
-			bottom_offset = (ALIGN(inst->fmt_dst->fmt.pix_mp.height, codec_align) -
-					inst->fmt_dst->fmt.pix_mp.height);
-			right_offset = (ALIGN(inst->fmt_dst->fmt.pix_mp.width, codec_align) -
-					inst->fmt_dst->fmt.pix_mp.width);
+			bottom_offset = (ALIGN(inst->enc_scale_height, codec_align) -
+					inst->enc_scale_height);
+			right_offset = (ALIGN(inst->enc_scale_width, codec_align) -
+				       inst->enc_scale_width);
 			left_offset = 0;
 			top_offset = 0;
 		}
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
index 2f1f118eae4f6462ab1aa1d16844b34e6e699f1e..dc3e606b6ab429a1d15536fa8316afb1e384d674 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
@@ -54,6 +54,8 @@ static u32 iris_hfi_gen2_buf_type_to_driver(struct iris_inst *inst,
 			return BUF_SCRATCH_2;
 	case HFI_BUFFER_PERSIST:
 		return BUF_PERSIST;
+	case HFI_BUFFER_VPSS:
+		return BUF_VPSS;
 	default:
 		return 0;
 	}
diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
index a9892988c10bc28e9b2d8c3b5482e99b5b9af623..0b36092fe4e7296da2f66aecf9083f7f1edc5459 100644
--- a/drivers/media/platform/qcom/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/iris/iris_instance.h
@@ -66,6 +66,8 @@ struct iris_fmt {
  * @hfi_rc_type: rate control type
  * @enc_raw_width: source image width for encoder instance
  * @enc_raw_height: source image height for encoder instance
+ * @enc_scale_width: scale width for encoder instance
+ * @enc_scale_height: scale height for encoder instance
  */
 
 struct iris_inst {
@@ -106,6 +108,8 @@ struct iris_inst {
 	u32				hfi_rc_type;
 	u32				enc_raw_width;
 	u32				enc_raw_height;
+	u32				enc_scale_width;
+	u32				enc_scale_height;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 36d69cc73986b74534a2912524c8553970fd862e..d3306189d902a1f42666010468c9e4e4316a66e1 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -729,6 +729,10 @@ static const u32 sm8550_dec_op_int_buf_tbl[] = {
 	BUF_DPB,
 };
 
+static const u32 sm8550_enc_ip_int_buf_tbl[] = {
+	BUF_VPSS,
+};
+
 static const u32 sm8550_enc_op_int_buf_tbl[] = {
 	BUF_BIN,
 	BUF_COMV,
@@ -816,6 +820,8 @@ struct iris_platform_data sm8550_data = {
 	.dec_op_int_buf_tbl = sm8550_dec_op_int_buf_tbl,
 	.dec_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_dec_op_int_buf_tbl),
 
+	.enc_ip_int_buf_tbl = sm8550_enc_ip_int_buf_tbl,
+	.enc_ip_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_ip_int_buf_tbl),
 	.enc_op_int_buf_tbl = sm8550_enc_op_int_buf_tbl,
 	.enc_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_op_int_buf_tbl),
 };
@@ -908,6 +914,8 @@ struct iris_platform_data sm8650_data = {
 	.dec_op_int_buf_tbl = sm8550_dec_op_int_buf_tbl,
 	.dec_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_dec_op_int_buf_tbl),
 
+	.enc_ip_int_buf_tbl = sm8550_enc_ip_int_buf_tbl,
+	.enc_ip_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_ip_int_buf_tbl),
 	.enc_op_int_buf_tbl = sm8550_enc_op_int_buf_tbl,
 	.enc_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_op_int_buf_tbl),
 };
@@ -989,6 +997,8 @@ struct iris_platform_data sm8750_data = {
 	.dec_op_int_buf_tbl = sm8550_dec_op_int_buf_tbl,
 	.dec_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_dec_op_int_buf_tbl),
 
+	.enc_ip_int_buf_tbl = sm8550_enc_ip_int_buf_tbl,
+	.enc_ip_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_ip_int_buf_tbl),
 	.enc_op_int_buf_tbl = sm8550_enc_op_int_buf_tbl,
 	.enc_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_op_int_buf_tbl),
 };
@@ -1077,6 +1087,8 @@ struct iris_platform_data qcs8300_data = {
 	.dec_op_int_buf_tbl = sm8550_dec_op_int_buf_tbl,
 	.dec_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_dec_op_int_buf_tbl),
 
+	.enc_ip_int_buf_tbl = sm8550_enc_ip_int_buf_tbl,
+	.enc_ip_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_ip_int_buf_tbl),
 	.enc_op_int_buf_tbl = sm8550_enc_op_int_buf_tbl,
 	.enc_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_op_int_buf_tbl),
 };
diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
index 7ad747d2272f029e69a56572a188a032f898a3fb..f573408a3fc66e1bbc7814a8fc7953158e043fce 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.c
+++ b/drivers/media/platform/qcom/iris/iris_venc.c
@@ -70,6 +70,8 @@ int iris_venc_inst_init(struct iris_inst *inst)
 
 	inst->enc_raw_width = DEFAULT_WIDTH;
 	inst->enc_raw_height = DEFAULT_HEIGHT;
+	inst->enc_scale_width = DEFAULT_WIDTH;
+	inst->enc_scale_height = DEFAULT_HEIGHT;
 
 	memcpy(&inst->fw_caps[0], &core->inst_fw_caps_enc[0],
 	       INST_FW_CAP_MAX * sizeof(struct platform_inst_fw_cap));
@@ -188,15 +190,32 @@ int iris_venc_try_fmt(struct iris_inst *inst, struct v4l2_format *f)
 
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
+	/*
+	 * If output format size != input format size,
+	 * it is considered a scaling case,
+	 * and the scaled size needs to be saved.
+	 */
+	if (f->fmt.pix_mp.width != inst->fmt_src->fmt.pix_mp.width ||
+	    f->fmt.pix_mp.height != inst->fmt_src->fmt.pix_mp.height) {
+		inst->enc_scale_width = f->fmt.pix_mp.width;
+		inst->enc_scale_height = f->fmt.pix_mp.height;
+		fmt->fmt.pix_mp.width = ALIGN(f->fmt.pix_mp.width, codec_align);
+		fmt->fmt.pix_mp.height = ALIGN(f->fmt.pix_mp.height, codec_align);
+	}
 	fmt->fmt.pix_mp.num_planes = 1;
 	fmt->fmt.pix_mp.plane_fmt[0].bytesperline = 0;
 	fmt->fmt.pix_mp.plane_fmt[0].sizeimage = iris_get_buffer_size(inst, BUF_OUTPUT);
@@ -254,6 +273,8 @@ static int iris_venc_s_fmt_input(struct iris_inst *inst, struct v4l2_format *f)
 
 	inst->enc_raw_width = f->fmt.pix_mp.width;
 	inst->enc_raw_height = f->fmt.pix_mp.height;
+	inst->enc_scale_width = f->fmt.pix_mp.width;
+	inst->enc_scale_height = f->fmt.pix_mp.height;
 
 	if (f->fmt.pix_mp.width != inst->crop.width ||
 	    f->fmt.pix_mp.height != inst->crop.height) {
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
index 4463be05ce165adef6b152eb0c155d2e6a7b3c36..db5adadd1b39c06bc41ae6f1b3d2f924b3ebf150 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
@@ -1131,10 +1131,11 @@ static u32 iris_vpu_enc_arp_size(struct iris_inst *inst)
 
 inline bool is_scaling_enabled(struct iris_inst *inst)
 {
-	return inst->crop.left != inst->compose.left ||
-		inst->crop.top != inst->compose.top ||
-		inst->crop.width != inst->compose.width ||
-		inst->crop.height != inst->compose.height;
+	struct v4l2_pix_format_mplane *dst_fmt = &inst->fmt_dst->fmt.pix_mp;
+	struct v4l2_pix_format_mplane *src_fmt = &inst->fmt_src->fmt.pix_mp;
+
+	return dst_fmt->width != src_fmt->width ||
+		dst_fmt->height != src_fmt->height;
 }
 
 static inline

-- 
2.43.0


