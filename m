Return-Path: <linux-kernel+bounces-879864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF738C2446A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38F304F1FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8064F3346B6;
	Fri, 31 Oct 2025 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l1yGHZWL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HV7jaweH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86A4333729
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904302; cv=none; b=TzkxWUMk4uUYZTGU+mBjxsNqoVnwGOHbF1iwLr7ieJ3AhAPoJkI5KwoorZIEvLk8IJ9oNSkzLbMiAKNWiMNduY38/4BxOA7Z/iFFjcyXIn1Oy4gRc/5Cf/0yjpM2KcBMBTbe9MYx86p6YPUGBnwvBRn2mnuOK9k+sq+HzgSKsH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904302; c=relaxed/simple;
	bh=tNK3w71T6e4PjaLm8LNoJvsCCYX65B4pzJT4mQrjvDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+nUWMbVGtYnP6VGapyeMirkMI5Iz1chfTUUD5Mztud7tMCOlnZZ1iQOTJ5r9AjQWFl7btVyfGlsYh0VlTVzYevWC2iQlIhbHn+g3EAlYNuWOnHI8PAnaJdp2up76+bvMgIskWdLViZ32bFjFJBLoApCz10Iil/6uwHcpzQ4LqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l1yGHZWL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HV7jaweH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9jZg32471663
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/JpM/Paae13Jto15iFYVyEhtvAI0lxD1SeWwHVnZ0fs=; b=l1yGHZWL5FHO1Vvi
	5790VGMjHeDsYlGRilqTSoA11tDP6dCzUtqeUvaOnRkYyI8obRXOw93XowpCW/EE
	6HxSASSFh/qCM9iEdq0kN9RPFuGmCz2cPMYLUGQy1xb/ra9QVU33D66A207AuFuq
	X53Y4Tz89fBE1I0q8Av+CXuwoix0YVnDgohkIhQQyhLqEVB+Vc4xU00nu+Cguk+N
	xy7J32FJy/gMuBFNyszzNdUSYMjTareBuJzIUGhb2+GfwM++eVpkpyR0kxyapcr5
	J4AGRVRu6CwqLWruOqMJWWJ2H63Z52i0tTTBUmLh5Q7L8/GrWkMJhs04Cq8HXByS
	9neqnA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4trv00mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:51:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29526a908c4so5602105ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761904299; x=1762509099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JpM/Paae13Jto15iFYVyEhtvAI0lxD1SeWwHVnZ0fs=;
        b=HV7jaweHWoA9XpFELRugLzruGJFZnDjkHxIxBhrrGK08/fyiJ068EXg/4xkeoTg0c5
         6rK4p8iX6RjMJi+X9zHutgz2uRJcz80MNMCC8zNVIoJsFzQG6jxaQoxYxFeG7bTOla9s
         HMZBWjO4m9zqdD/2Fs+7IBXhNPu99CIxw7SYITbhyzb3MhpS00MIvqNZXWRqBXzlXjDI
         +p1g+po1ud0c/H0QKSv6dV2t8Oea1tAYFfILabA0o7AT/hnLtAqY25DskIE4WSWOwihV
         USAAH0uarxJ71AE1cEO1Imv56WZYjhHJp3lFUck1FHp8T65HkBFaWjLLia34asgl2hFL
         wHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904299; x=1762509099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JpM/Paae13Jto15iFYVyEhtvAI0lxD1SeWwHVnZ0fs=;
        b=mMagirNqQ5pBLxdw5KCiXi3C+AWEhucozDN8cxp8n0n97OrIQFUn277HAoT5VjdiV0
         HeD7ieztprPZ1TZlG1SA/BZBzg74bPN/AjczUqWgpNhiZwxxNeAAujk9WGyxHfiMFsnX
         HJNK0KpPHVs83iyQe+Xd2IhmR9VlfmQdVQiOMcUl86rFdGZW3ljqVD9wj1KtHUXK9GOz
         4VAoECSsLgpGQEOAmNb3/XTRdFwAyRHu4HJBggFhafsqa61cDtBB7PY1r+cZ3VAOd2uF
         jtiCYw7qfyy6KlJxNQZg/DFCP1WV8QezmoF4YYmVWNdfpke6qZNsFmu30uDxn5CSe1aN
         ozRw==
X-Forwarded-Encrypted: i=1; AJvYcCUpctmP71qcj01P98o5bUGXVbqA8M8TlkHDJo8Lyo+12u+Wn3qO4q2S0BN7K+eGfjyaLQy3zxPPul5MNVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02qCMzr44Jh/gL7Wqrwg0KmWqxpYr9ySzlPlopld5f8pXCRdg
	yiGOaraNlkABB7Q6vqGxZrdStixeHn7+L+YzHnzFLLHAy5idzmRcmjmmNxjkD0qICr0G5tCKVF7
	iYKyQhqsodpTubCZmldr6gG/Y4lmU8puv8Mewh8tMPi3Z4RM5YI9Aq5azAIyf0UZllDw5rlutXC
	mp/w==
X-Gm-Gg: ASbGnctwKT5Qbm7HIoxtwwWZtAAVwXbFBioWS4Q8kpukKlAxMW5bWiJ/xthmJS81UaV
	aqI1mHjUKR5pWMAWWLIQXCYcUEsXvgWBlcmovPcf6nnA3oRcu6wURSTdR6q5/sxeYewJSGXox9J
	8o/XGXKNIgekd2ZcjYUa3WrqKuiejXDMdNnoaJ8YRLcgOauTrIXse4q945uRgdC1CcxLQzuEbe0
	Kl64BK+l0iZ4bUC9aXFQ4rPa8Z3G/zIxqYXDMpdVHXUvMG2+khxHeFb6ejpxcr4fFLaXl5ffWe7
	/oWNPXDDPmWgKvX82bJzQ2i+HErgBDQlR97pA1XOkSMT+WAa3KGGFu6Kmer4V37OoyWdK+lh9Yc
	pBD8pZghrRWnYvgpcY1qIomd002qxAGiyM//qJ5ufpXXTFdtugujnAPrH/KwT6geyVPLh6QOozg
	==
X-Received: by 2002:a17:903:2f10:b0:27e:ea82:5ce8 with SMTP id d9443c01a7336-2951a3d0d1fmr35683735ad.14.1761904299429;
        Fri, 31 Oct 2025 02:51:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExWdhj8g/jlNPdEPwEK4/kCn2ilRTx48miAgHuZAI43lKz3CQx0hdppvLjoYedmB04jEsTAg==
X-Received: by 2002:a17:903:2f10:b0:27e:ea82:5ce8 with SMTP id d9443c01a7336-2951a3d0d1fmr35683345ad.14.1761904298813;
        Fri, 31 Oct 2025 02:51:38 -0700 (PDT)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268716e4sm17913115ad.9.2025.10.31.02.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:51:38 -0700 (PDT)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 17:50:39 +0800
Subject: [PATCH v2 1/5] media: qcom: iris: Improve format alignment for
 encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-iris_encoder_enhancements-v2-1-319cd75cbb45@oss.qualcomm.com>
References: <20251031-iris_encoder_enhancements-v2-0-319cd75cbb45@oss.qualcomm.com>
In-Reply-To: <20251031-iris_encoder_enhancements-v2-0-319cd75cbb45@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wangao Wang <wangao.wang@oss.qualcomm.com>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761904292; l=5100;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=tNK3w71T6e4PjaLm8LNoJvsCCYX65B4pzJT4mQrjvDk=;
 b=Q4iIB9stru17MD9UZUYytGkrWrUBUyuuXSktuZYZYOqDim0VX168jtjnEXBefVLUYccPi1hM3
 7S6Ym5Adh9eDox4MDWXxS+H8rDvdS/4OhqMBZ4HTCLE6XwXI/BfDZkm
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-ORIG-GUID: CDQC2QOebX0iUnCchK6G8St2kh6ORgW1
X-Proofpoint-GUID: CDQC2QOebX0iUnCchK6G8St2kh6ORgW1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA4OCBTYWx0ZWRfX/jM5pTxWGUDv
 WvJ/Oq6iSPBdUbLLUM0h6D/ZqEteYaumZIG0sz5Sge6DROeReIWSsXbdLfKeDqnhUlP0SEcjUri
 xwHLEYd7XQqzZVzAu19AWeSYz/mqxAo5a2h/M4Kssd7VoDLxTszx9sVmyxInAi4oPeWGx1M4Zhe
 s0ATs4sjxixKFZDUe+nYNl86CWJKJ+NDd96eLlEpj54u09LZaKObwYUGJu/jd9N/KzIdq8HjuEv
 KcYOXk87WX0PeZeDlOvCY487fubJcl1vCWjVcm6Q0RnpsfIT40uZPxyOYem/vtfnmPAgUARIhQ9
 mbWKK9FsWfIJoQuTvGnWly2YMwwcF09htuO3hbOj1sRB07JXmQrjhNovbjhbQ3FQf//jr5eJgNI
 MrI/1BKFb6jfMSs5ksPpPCFCxm8lJw==
X-Authority-Analysis: v=2.4 cv=XoP3+FF9 c=1 sm=1 tr=0 ts=690486ac cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Ua5b2oKhh2CtpjQe1ZYA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310088

Add members enc_raw_width, enc_raw_height to the struct iris_inst to
support codec alignment requirements.

HFI_PROP_CROP_OFFSETS is used to inform the firmware of the region
of interest, rather than indicating that the codec supports crop.
Therefore, the crop handling has been corrected accordingly.

Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 .../media/platform/qcom/iris/iris_hfi_gen2_command.c   | 18 ++++++++++++------
 drivers/media/platform/qcom/iris/iris_instance.h       |  4 ++++
 drivers/media/platform/qcom/iris/iris_venc.c           | 10 +++++++---
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 4ce71a14250832440099e4cf3835b4aedfb749e8..ada9b4d298ef10ac47a573061369828a1e150f85 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -168,8 +168,7 @@ static int iris_hfi_gen2_session_set_property(struct iris_inst *inst, u32 packet
 
 static int iris_hfi_gen2_set_raw_resolution(struct iris_inst *inst, u32 plane)
 {
-	u32 resolution = inst->fmt_src->fmt.pix_mp.width << 16 |
-		inst->fmt_src->fmt.pix_mp.height;
+	u32 resolution = inst->enc_raw_width << 16 | inst->enc_raw_height;
 	u32 port = iris_hfi_gen2_get_port(inst, plane);
 
 	return iris_hfi_gen2_session_set_property(inst,
@@ -216,8 +215,11 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
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
@@ -231,10 +233,14 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
 			top_offset = inst->compose.top;
 		}
 	} else {
-		bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
-		right_offset = (inst->fmt_src->fmt.pix_mp.width - inst->crop.width);
-		left_offset = inst->crop.left;
-		top_offset = inst->crop.top;
+		if (V4L2_TYPE_IS_CAPTURE(plane)) {
+			bottom_offset = (ALIGN(inst->enc_raw_height, codec_align) -
+					inst->enc_raw_height);
+			right_offset = (ALIGN(inst->enc_raw_width, codec_align) -
+					inst->enc_raw_width);
+			left_offset = inst->crop.left;
+			top_offset = inst->crop.top;
+		}
 	}
 
 	payload[0] = FIELD_PREP(GENMASK(31, 16), left_offset) | top_offset;
diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
index 5982d7adefeab80905478b32cddba7bd4651a691..fbae1662947df73bb3d10b7892839fa1076b7e61 100644
--- a/drivers/media/platform/qcom/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/iris/iris_instance.h
@@ -64,6 +64,8 @@ struct iris_fmt {
  * @frame_rate: frame rate of current instance
  * @operating_rate: operating rate of current instance
  * @hfi_rc_type: rate control type
+ * @enc_raw_width: raw image width for encoder instance
+ * @enc_raw_height: raw image height for encoder instance
  */
 
 struct iris_inst {
@@ -102,6 +104,8 @@ struct iris_inst {
 	u32				frame_rate;
 	u32				operating_rate;
 	u32				hfi_rc_type;
+	u32				enc_raw_width;
+	u32				enc_raw_height;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
index 099bd5ed4ae0294725860305254c4cad1ec88d7e..6adadc89e360a6e4bebe1f839d38892990e10fa2 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.c
+++ b/drivers/media/platform/qcom/iris/iris_venc.c
@@ -68,6 +68,9 @@ int iris_venc_inst_init(struct iris_inst *inst)
 	inst->operating_rate = DEFAULT_FPS;
 	inst->frame_rate = DEFAULT_FPS;
 
+	inst->enc_raw_width = DEFAULT_WIDTH;
+	inst->enc_raw_height = DEFAULT_HEIGHT;
+
 	memcpy(&inst->fw_caps[0], &core->inst_fw_caps_enc[0],
 	       INST_FW_CAP_MAX * sizeof(struct platform_inst_fw_cap));
 
@@ -249,6 +252,9 @@ static int iris_venc_s_fmt_input(struct iris_inst *inst, struct v4l2_format *f)
 	inst->buffers[BUF_INPUT].min_count = iris_vpu_buf_count(inst, BUF_INPUT);
 	inst->buffers[BUF_INPUT].size = fmt->fmt.pix_mp.plane_fmt[0].sizeimage;
 
+	inst->enc_raw_width = f->fmt.pix_mp.width;
+	inst->enc_raw_height = f->fmt.pix_mp.height;
+
 	if (f->fmt.pix_mp.width != inst->crop.width ||
 	    f->fmt.pix_mp.height != inst->crop.height) {
 		inst->crop.top = 0;
@@ -329,9 +335,7 @@ int iris_venc_s_selection(struct iris_inst *inst, struct v4l2_selection *s)
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


