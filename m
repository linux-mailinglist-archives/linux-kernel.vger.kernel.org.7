Return-Path: <linux-kernel+bounces-845269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEFEBC436D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC6B19E0EF2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624AF2F6174;
	Wed,  8 Oct 2025 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IPi56KS6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31532F5A3F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917176; cv=none; b=oNw5k9AT1BJF0YFQSxONTTTl87tgrFgF2K+sMfYCPtCdbNMP0mb7TQGgps8BEiMs7OhWD2BZ88PKXJE08lgmfJryU9HmffnqFeORqdNDCYtmbNP1QgeexAuZkw0mG9zj00Fqkfh1ZA2ZSrV0XLtdtyVw4vJ4b5ZSgrHIJtd1Uj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917176; c=relaxed/simple;
	bh=4crLsFonyut2wgW58S0vp/isNf2mmaPxvNyLhS/l0/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z8iMXg6U43HZf1sWndDjan6P1R+juTZAx+LYJcrtufUWsYTtiUarBs7LHUKJTrjk+TfZ/PZVRfvAnxjCKcQQYnBqx6YIjj0Cp0JsmrPJ47ijHCxSC0Qmd10xjA/zzudjlcusjnhSNv6F0O8m+SAA0xg56u36i8XDbF6/yIe5+y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IPi56KS6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890i0d014448
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 09:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	woeoJMe/1z7CNrO3GZzfk1Drc1RvJgCKVaPxjU5YsMQ=; b=IPi56KS6+DUcwj5P
	WkQHXDTN7xZHaccMvQlEjYka7hBBdoAmBqVozLlGLnD726FEBHl36iCFKha1fTey
	zfRis/Mk/7kVF2objj5SXAQ+AXYry7tB/BQSMPHI9QcuOe0xtLo+QqzM5476IPSN
	YbnPh6p1IZrOoeRoy3/TcSYvXWA+yh2G7Mn7c8fNteVrrmHsqjew61riY4L4VT2C
	YC0qhe4D/ElBKdDWW+mGMwFDTWHDpLFiX8epOxJnsKKpRw1izOeq3QS1NdVpe6K1
	g6QahwVDyImChKe01+LtrZTZCXXh3/qMcBS4bN6kINpEUhOf2yc4SvP7/n/YzZCR
	pSfPYw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mgd0nrbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:52:52 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-782063922ceso6643195b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759917171; x=1760521971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woeoJMe/1z7CNrO3GZzfk1Drc1RvJgCKVaPxjU5YsMQ=;
        b=WajXWTj4+BZiXKshZrA1KiYMvoF35pq6xN0GnaWgBHbHXwoMs4LkKIMH5LTamk5jRZ
         Ioevf53Ip67WrUH7Ps+TJxp3k/rCaEBRqun2t6dVa8eukabdk2SwwYrmLfk6LSAh+lo7
         teg6ZMQEM7Yj5dtq6H77jdNtrp8U95aeYIMnBK4rttqdHi2/NLoO75dFSiXNlmeXsovr
         /VL3CCSu66ROV8EAYP3OdInj085Zd0DjYD8UdJ3iSvTV0zBrn3fuLyovTxLsjyXlewNL
         Y1zIdZ0+9FUYI8g53PymQ3NaSdzV842yuG82n2latblSPIYF/u2URLChfyg5x15zDKmm
         CuZg==
X-Forwarded-Encrypted: i=1; AJvYcCXGHTnPxCh1WndbxigYfLKd0sjHOdyHFgSHo6cP67s/0I8vIUqLjbBaKc3YY5+A7+y9flGuCsOkvqrTI/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg0SLvBVGecOjS4MkuzASTYaA1s9VZMiIzGNGljDO8qfL1B12p
	2REGO51ezrWW3K7TQVZbVYG3o17zJpRNZEZrI+w+S4nxdo+eDR5prSVfiMYeAhTE2Vq6wMCCVTS
	c2mg4Pm+cE9C1udJtxrJJh15EwLdtz+5IFI/kOyfD9jw6GU03dVD8JeH0f0iUaGXTD8A=
X-Gm-Gg: ASbGncuUdwpYqIe0y3wjjZ3R1+RMFBHfbMvj4YjfBv/75U09BW0W6a0UBSQ0eHEYVSG
	mK4zb3YmANu8PeB6QFc8H57DxSNJNeTto45s/Hm9lGbNlyrFAhvtOVOiGurxEXk493lPmd0iIHt
	IVENplUQ7zCEc3ZJlniLAPNhttLAxA4GNN44psQqMNob84f/xVqxcjG8Tsqt5WZpLwDy0wqAJDE
	1bCk6KCV/pEWlH3nWEEyF7KZ8ZaWh/2dXAlNU/l4+o2t8ZjHgiHVic70gdXIo0LH5ac4hLdTskM
	KbL4U6bekznhbMvpYFfnyXvFSznjE5HPj/PNehfRbYqPucpI3a15oYXiafVV5ONJT+pnerIJ24a
	HG3afbEQ=
X-Received: by 2002:a05:6a20:7289:b0:262:4378:9ddb with SMTP id adf61e73a8af0-32da812f18bmr3578157637.23.1759917171286;
        Wed, 08 Oct 2025 02:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/44I0uT+26D6cLu1FzRBB50dFq/IUKTaufQJ6oI36O8X9mFJx3IoRILnyG6MgRiGlb8h13Q==
X-Received: by 2002:a05:6a20:7289:b0:262:4378:9ddb with SMTP id adf61e73a8af0-32da812f18bmr3578127637.23.1759917170773;
        Wed, 08 Oct 2025 02:52:50 -0700 (PDT)
Received: from hu-dikshita-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510e91d4sm2763833a91.1.2025.10.08.02.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 02:52:50 -0700 (PDT)
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Date: Wed, 08 Oct 2025 15:22:27 +0530
Subject: [PATCH v2 3/3] media: iris: Add support for QC08C format for
 encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-video-iris-ubwc-enable-v2-3-478ba2d96427@oss.qualcomm.com>
References: <20251008-video-iris-ubwc-enable-v2-0-478ba2d96427@oss.qualcomm.com>
In-Reply-To: <20251008-video-iris-ubwc-enable-v2-0-478ba2d96427@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759917158; l=7531;
 i=dikshita.agarwal@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=4crLsFonyut2wgW58S0vp/isNf2mmaPxvNyLhS/l0/U=;
 b=jO2EjRHwgDlsNHpsnTcMH5XP3ZSlQZu/YT7hqtV8JhjJxGt3knUKIG6eZ4jf9WwYZcE6v4XbG
 n7PQ5bjYpP/CrQwspfvUU+n0Ul+IKuZRNYjS+/a4GvArq/GXC0Xp0Xs
X-Developer-Key: i=dikshita.agarwal@oss.qualcomm.com; a=ed25519;
 pk=EEvKY6Ar1OI5SWf44FJ1Ebo1KuQEVbbf5UNPO+UHVhM=
X-Proofpoint-GUID: uTkaUEUxibvYr4W7WCWDqchInqG8fcj1
X-Authority-Analysis: v=2.4 cv=T8aBjvKQ c=1 sm=1 tr=0 ts=68e63474 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=nS3McV74YSJk3wcLVjgA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: uTkaUEUxibvYr4W7WCWDqchInqG8fcj1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMyBTYWx0ZWRfX7q4grDpZM076
 8dirBaYZrSYZj9VYcC79P0IX5v0K29/Cbp8l+jrRgjGwr7rsi/ULCyLar2eG/QsRe9dqO3lCguW
 a2IbFrvblR/BIVdabxGclXSPuLwDa+s7oyFHplIyHePMe+6/0Trth/QkpjP0pe3P0tB/k4im1rz
 jp28w+7DvScDY+aUAEjk7bme/eyPZNb+TBQPjVvV7AC1aAwZl/B/XAuOSbpRxyWMJSJw5iE86P5
 1Ia/D38HNRIQfroosFqMSQZHS4PboTH1KauLIVuJHHmXItZU3yAyncQhHJKQsNIigvWKKlSq5vE
 o39ihrvVH0H4pdtBggJPiHfkWnUXYGciBOfpSmVgT/pEij5fU7hadTEaZR3rpchUsIGsnXcuXCP
 1RXQ4HPBFKp6ZzLXocL5oo0brO1fmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060123

Introduce handling for the QC08C format in the encoder. QC08C
format is NV12 with UBWC compression. Update format checks and
configuration to enable encoding to QC08C streams.

Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_buffer.c     | 12 ++++-
 .../platform/qcom/iris/iris_hfi_gen1_command.c     |  3 +-
 .../platform/qcom/iris/iris_hfi_gen2_command.c     |  3 +-
 drivers/media/platform/qcom/iris/iris_venc.c       | 59 ++++++++++++++++++----
 4 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
index 83dcf49e57ec1473bc4edd26c48ab0b247d23818..b89b1ee06cce151e7c04a80956380d154643c116 100644
--- a/drivers/media/platform/qcom/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_buffer.c
@@ -171,9 +171,14 @@ static u32 iris_yuv_buffer_size_nv12(struct iris_inst *inst)
 static u32 iris_yuv_buffer_size_qc08c(struct iris_inst *inst)
 {
 	u32 y_plane, uv_plane, y_stride, uv_stride;
-	struct v4l2_format *f = inst->fmt_dst;
 	u32 uv_meta_stride, uv_meta_plane;
 	u32 y_meta_stride, y_meta_plane;
+	struct v4l2_format *f = NULL;
+
+	if (inst->domain == DECODER)
+		f = inst->fmt_dst;
+	else
+		f = inst->fmt_src;
 
 	y_meta_stride = ALIGN(DIV_ROUND_UP(f->fmt.pix_mp.width, META_STRIDE_ALIGNED >> 1),
 			      META_STRIDE_ALIGNED);
@@ -273,7 +278,10 @@ int iris_get_buffer_size(struct iris_inst *inst,
 	} else {
 		switch (buffer_type) {
 		case BUF_INPUT:
-			return iris_yuv_buffer_size_nv12(inst);
+			if (inst->fmt_src->fmt.pix_mp.pixelformat == V4L2_PIX_FMT_QC08C)
+				return iris_yuv_buffer_size_qc08c(inst);
+			else
+				return iris_yuv_buffer_size_nv12(inst);
 		case BUF_OUTPUT:
 			return iris_enc_bitstream_buffer_size(inst);
 		default:
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
index e458d3349ce09aadb75d056ae84e3aab95f03078..52da7ef7bab08fb1cb2ac804ccc6e3c7f9677890 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
@@ -795,7 +795,8 @@ static int iris_hfi_gen1_set_raw_format(struct iris_inst *inst, u32 plane)
 	} else {
 		pixelformat = inst->fmt_src->fmt.pix_mp.pixelformat;
 		fmt.buffer_type = HFI_BUFFER_INPUT;
-		fmt.format = pixelformat == V4L2_PIX_FMT_NV12 ? HFI_COLOR_FORMAT_NV12 : 0;
+		fmt.format = pixelformat == V4L2_PIX_FMT_NV12 ?
+			HFI_COLOR_FORMAT_NV12 : HFI_COLOR_FORMAT_NV12_UBWC;
 		ret = hfi_gen1_set_property(inst, ptype, &fmt, sizeof(fmt));
 	}
 
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 5ad202d3fcdc57a2b7b43de15763a686ce0f7bd7..6a772db2ec33fb002d8884753a41dc98b3a8439d 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -447,7 +447,8 @@ static int iris_hfi_gen2_set_colorformat(struct iris_inst *inst, u32 plane)
 			HFI_COLOR_FMT_NV12 : HFI_COLOR_FMT_NV12_UBWC;
 	} else {
 		pixelformat = inst->fmt_src->fmt.pix_mp.pixelformat;
-		hfi_colorformat = pixelformat == V4L2_PIX_FMT_NV12 ? HFI_COLOR_FMT_NV12 : 0;
+		hfi_colorformat = pixelformat == V4L2_PIX_FMT_NV12 ?
+			HFI_COLOR_FMT_NV12 : HFI_COLOR_FMT_NV12_UBWC;
 	}
 
 	return iris_hfi_gen2_session_set_property(inst,
diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
index 099bd5ed4ae0294725860305254c4cad1ec88d7e..95e3ceb22d8c3a46c1bf3eb87e7c1cc5ccf3039f 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.c
+++ b/drivers/media/platform/qcom/iris/iris_venc.c
@@ -80,7 +80,7 @@ void iris_venc_inst_deinit(struct iris_inst *inst)
 	kfree(inst->fmt_src);
 }
 
-static const struct iris_fmt iris_venc_formats[] = {
+static const struct iris_fmt iris_venc_formats_cap[] = {
 	[IRIS_FMT_H264] = {
 		.pixfmt = V4L2_PIX_FMT_H264,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
@@ -91,12 +91,35 @@ static const struct iris_fmt iris_venc_formats[] = {
 	},
 };
 
+static const struct iris_fmt iris_venc_formats_out[] = {
+	[IRIS_FMT_NV12] = {
+		.pixfmt = V4L2_PIX_FMT_NV12,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+	},
+	[IRIS_FMT_QC08C] = {
+		.pixfmt = V4L2_PIX_FMT_QC08C,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+	},
+};
+
 static const struct iris_fmt *
 find_format(struct iris_inst *inst, u32 pixfmt, u32 type)
 {
-	const struct iris_fmt *fmt = iris_venc_formats;
-	unsigned int size = ARRAY_SIZE(iris_venc_formats);
+	const struct iris_fmt *fmt = NULL;
+	unsigned int size = 0;
 	unsigned int i;
+	switch (type) {
+	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
+		fmt = iris_venc_formats_out;
+		size = ARRAY_SIZE(iris_venc_formats_out);
+		break;
+	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
+		fmt = iris_venc_formats_cap;
+		size = ARRAY_SIZE(iris_venc_formats_cap);
+		break;
+	default:
+		return NULL;
+	}
 
 	for (i = 0; i < size; i++) {
 		if (fmt[i].pixfmt == pixfmt)
@@ -112,8 +135,21 @@ find_format(struct iris_inst *inst, u32 pixfmt, u32 type)
 static const struct iris_fmt *
 find_format_by_index(struct iris_inst *inst, u32 index, u32 type)
 {
-	const struct iris_fmt *fmt = iris_venc_formats;
-	unsigned int size = ARRAY_SIZE(iris_venc_formats);
+	const struct iris_fmt *fmt = NULL;
+	unsigned int size = 0;
+
+	switch (type) {
+	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
+		fmt = iris_venc_formats_out;
+		size = ARRAY_SIZE(iris_venc_formats_out);
+		break;
+	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
+		fmt = iris_venc_formats_cap;
+		size = ARRAY_SIZE(iris_venc_formats_cap);
+		break;
+	default:
+		return NULL;
+	}
 
 	if (index >= size || fmt[index].type != type)
 		return NULL;
@@ -127,9 +163,11 @@ int iris_venc_enum_fmt(struct iris_inst *inst, struct v4l2_fmtdesc *f)
 
 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
-		if (f->index)
+		fmt = find_format_by_index(inst, f->index, f->type);
+		if (!fmt)
 			return -EINVAL;
-		f->pixelformat = V4L2_PIX_FMT_NV12;
+
+		f->pixelformat = fmt->pixfmt;
 		break;
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
 		fmt = find_format_by_index(inst, f->index, f->type);
@@ -156,7 +194,7 @@ int iris_venc_try_fmt(struct iris_inst *inst, struct v4l2_format *f)
 	fmt = find_format(inst, pixmp->pixelformat, f->type);
 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
-		if (f->fmt.pix_mp.pixelformat != V4L2_PIX_FMT_NV12) {
+		if (!fmt) {
 			f_inst = inst->fmt_src;
 			f->fmt.pix_mp.width = f_inst->fmt.pix_mp.width;
 			f->fmt.pix_mp.height = f_inst->fmt.pix_mp.height;
@@ -221,7 +259,7 @@ static int iris_venc_s_fmt_input(struct iris_inst *inst, struct v4l2_format *f)
 
 	iris_venc_try_fmt(inst, f);
 
-	if (f->fmt.pix_mp.pixelformat != V4L2_PIX_FMT_NV12)
+	if (!(find_format(inst, f->fmt.pix_mp.pixelformat, f->type)))
 		return -EINVAL;
 
 	fmt = inst->fmt_src;
@@ -289,7 +327,8 @@ int iris_venc_validate_format(struct iris_inst *inst, u32 pixelformat)
 {
 	const struct iris_fmt *fmt = NULL;
 
-	if (pixelformat != V4L2_PIX_FMT_NV12) {
+	fmt = find_format(inst, pixelformat, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
+	if (!fmt) {
 		fmt = find_format(inst, pixelformat, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
 		if (!fmt)
 			return -EINVAL;

-- 
2.34.1


