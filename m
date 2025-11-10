Return-Path: <linux-kernel+bounces-892825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE75C45E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5457018915F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE2F305E10;
	Mon, 10 Nov 2025 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ImsWChlx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dcgG1jPB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55864305E31
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770230; cv=none; b=Bf3hZWt+fyzeujQDGHq78bD5ckiaDbak9vi6ChX5mF+OcvZ3OC5MN/odJXeiwr+jy0zY4Ntn/ySAVRx7rlHW7pDk4A1JQtiZYdu9t07UBN0oi0rsTQxjiVkvtB3Qm6oLcNTAYJtfA6TxDQLGofTC1i1pRKeNJyC3aetr5F9RWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770230; c=relaxed/simple;
	bh=LveUk53QJ3dHRW9HSIyjWavI4gMoswfbMNluOzdNiO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8beJCbaJSjAjQjtDCJ+5uMxNpLgM7DlX67FL2jBriPHK7LS/es8cJMqJeAgA8fX+wOGEYvt4qw0Kq3kX95/4eqMo91ux20uIdazvPZ3MdKUs+w2xRCbLvCEiV9cgMH7l9z7Q0sH2B2GoQD1noCn0hFL8TVc0JGoLGRsUOQSWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ImsWChlx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dcgG1jPB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8IE231917837
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yoxIonDCXKCpc9bIHGc3/ojACiy01o5W3o8PYdNcEHk=; b=ImsWChlx+A6PS+10
	1fMsxc2OSokyrBd6NAFOEhTPE87caWMjnBBBfvRKnDI6oQCcJr3fSeuUxi9A9usJ
	8M9DEey5dYz1lrdeF684CaK+k5aEX5Hm1Hb8i8SuOL7luFMJm4SmevkxsdPXep83
	qbKW5hsaoLM1lU8UK8o7mT6fvI7/GC9Rt1CMUlShpomfew2smkGqruqVHiX8pQ92
	0LfRgloben+dltRLKrzMZKUUmGwRRQ0nacjTdbUCEMx1604JXNLhpgaTL93EwMAP
	ltV3gXIjlKTvgwuEihUiIcB0IIGpAX/XXJJAmmizBaJL1Lu23I5Xu2PjGALBPwZ9
	1Xv7OA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xvjcbuj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:23:45 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a675fbd6c7so4701419b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762770224; x=1763375024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoxIonDCXKCpc9bIHGc3/ojACiy01o5W3o8PYdNcEHk=;
        b=dcgG1jPBMyIHytfdiaWS6t7aa99o+bNCVS36CG1BxIXuiGPdOgxykIkczE2Fu5c10A
         6O1q4UP1qKW7g7OLeBk8Hx8PF+CpjwS48uFThKKzpNKioobmciadj8VGgfcPGxmUIMFG
         5HZVHZelJYmdn7f5EXhnOqzhqzoW/z7BAgLj6/V0BsLIA7tnkQXBp2xq/CkmiMkiBaIy
         ObTuWDv/0pIXW8hjkkXWf1ctkhrlFbW0N3+8rbYu/3dJPgRBPfok+rcnOu9vNRhkq3JW
         OcLFcsb4H2u14gIL7Y3Co0/KZlLHEM9r/vNJ8DinoBGomE7vo4pVl0oYi8gz4u7mXeny
         5fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770224; x=1763375024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yoxIonDCXKCpc9bIHGc3/ojACiy01o5W3o8PYdNcEHk=;
        b=nUg7wBTQ6JrVhDR1fuLJ1Zklt6QmZ9kdJTmSnbexHDD2rodUwxrQl8rXydhghC1rgO
         n9FeHGtat8lpb6YAiS5yjFqGwEsG+tTFnaONqERO/rP8NhrA5UyqST4Ej5asnyWy9Spx
         JpLpYNrkSwQIPhFRMu+AYdyjAcH/1rEUwJJRduPL6v1FhiQ3Hg6UZ4F1cihcpH69l9C2
         5Bu8ExtezF9n4DnfMZPwiEZjArlpzjYst6yH1aL++a09Vt0XWeJjcHW1TM0gYQ0ZN0if
         1zXUIOGRNF/WTb4/P+Y81W82wnKY7Oi2Lg+i/ZEQJfXkTWOE6fFbd5h3F5W/2sj6zA+H
         c2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEjMP5QF7pYTuHJoxY0rNwAlCbWnvIUClCIeaCDHBtVuamH8vDTjF3eGgJhLxWiB+kTBeYdgIXOypauXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx23VTeQBLyrq33E1m0zeRYDqXxH9vweAHp2NdhLHFfRRWFcsFi
	5YRsq/0e2IRc09Hxqiod/llbai3Go9CpvgbLekkDKP2dq1pvPvat8yCy1SzvpE/V4zezVwy7Qp0
	fX4vNlvrW22x+2I+QbeDy5Nmdwb7+WnJ4o7a5S9gQWiyY07L44VNlgDcJTgmHEelrvXw=
X-Gm-Gg: ASbGncuhNJzo8g11it5Xqpr2ysUpPVE8nVjkXK5dzriranqXTrnO+7lfM0ZibosrOkQ
	JZg/bsPjcSZ3t1fl/UDwLKElOcYoPD+BNLOUBUxk7ejDC9C+n6PJMs8KJVwoct+1f5JQKQlsXlV
	SC4EJrIJ47SMWocNOkkRbcfqY/L6n79mDzwicuAxvN/TXWZu/llXFvzyKaxNABtvV05vwEr2QTM
	lAtS68TSPx/Rd895xkP1cMR3tm4CrO1cUr6P45bsxsz40ixpc4u1359qgeh1aTng7FpzYJJkOHe
	SRXrb5dk5tFUeBDOcW1b1QTM0su13TtgsrZ+5CPFL+sp1UJK6W2IUH6UUxUxcHTG2MtTfOle5Hg
	stNE2KAWDtGlsvaGeQndnmvSRKZNrWeghU5xVU4gxTru2bsae5xGc4sfiSTGyQt18vkowJep4EA
	==
X-Received: by 2002:a05:6a00:2316:b0:7aa:eb09:db95 with SMTP id d2e1a72fcca58-7b227182441mr9113735b3a.30.1762770224042;
        Mon, 10 Nov 2025 02:23:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGszW/XIr4y9kZ9mt3TFYGMul1bX3EymstHOkQaDuJj6R/N4PfPUe3eeZuai+oVYfo4e6aD6Q==
X-Received: by 2002:a05:6a00:2316:b0:7aa:eb09:db95 with SMTP id d2e1a72fcca58-7b227182441mr9113714b3a.30.1762770223560;
        Mon, 10 Nov 2025 02:23:43 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm11153832b3a.34.2025.11.10.02.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:23:43 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 18:23:13 +0800
Subject: [PATCH v5 2/6] media: qcom: iris: Improve crop_offset handling for
 encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-iris_encoder_enhancements-v5-2-1dbb19968bd5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762770213; l=2882;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=LveUk53QJ3dHRW9HSIyjWavI4gMoswfbMNluOzdNiO4=;
 b=i0oUI4WW26G3SEcUaeUFVdvC4Ku3IAr9yDvnwrshQmO1sVIpxa7GbG7m5dQrSEaVMnZa50oed
 3sD1yZJnpm2D/VRRr4Cy4x32ynxQsB9QUNcpNj260EdqgPuUUx0m8VC
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Authority-Analysis: v=2.4 cv=QuxTHFyd c=1 sm=1 tr=0 ts=6911bd31 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=FFraBxrx14SkMf4OJSEA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: VLhr8x2x7Ni5ie8sDM68VP33kaMSs2DI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MCBTYWx0ZWRfX3lZZqwySsxNw
 NDIv1Nv86EXo+LZJr0i0++o000ZOmCKXCR5zC2u4fU1R8FDFB7QtuKHYYETd3LYa4Or3+UP8nYd
 eLpS0GeaoBayrspg+rHQ15ugldc8ViLofrpDXlO8h5cZO+xk2ngzcIoICS1IoWaJuC1KRg3fbhP
 aGvsx4nylUNZ9/v5iJFWMrZkHzBKJbadf7Aj5Vsg7uxGIEt2k4oAzecOQ8SqizjQGF/qJaxwbRa
 BTqkafC+BNB0QsAoBovfXoEQQK8xO+AZL+Lt8rfNw5vwoncEWS6ZTYdcy3eDhHDOtaPLficbfXa
 fYfY0DmEknvziQBoB7qZaEfBQ8PYbvYqZPSwgHxTPkC4Tii7mJXDoVZXsB2o1F42SPIhvESaDgJ
 5WvoQei9rG+/A9XqwS1hF8rP4q0lKA==
X-Proofpoint-GUID: VLhr8x2x7Ni5ie8sDM68VP33kaMSs2DI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100090

The setting of HFI_PROP_CROP_OFFSETS for the OUTPUT port is correct,
but on the CAPTURE port it is used to inform the firmware about the
ROI, so crop_offset needs to be handled accordingly.

Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 .../media/platform/qcom/iris/iris_hfi_gen2_command.c | 20 +++++++++++++++-----
 drivers/media/platform/qcom/iris/iris_venc.c         |  4 ++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 48962d2e4962935bbc24244edfbbdcd42dab151f..30c0cbe22d1d34b5bbbc6bdbd3881dd43a6ff647 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -215,7 +215,7 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
 	u32 port = iris_hfi_gen2_get_port(inst, plane);
 	u32 bottom_offset, right_offset;
 	u32 left_offset, top_offset;
-	u32 payload[2];
+	u32 payload[2], codec_align;
 
 	if (inst->domain == DECODER) {
 		if (V4L2_TYPE_IS_OUTPUT(plane)) {
@@ -230,10 +230,20 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
 			top_offset = inst->compose.top;
 		}
 	} else {
-		bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
-		right_offset = (inst->fmt_src->fmt.pix_mp.width - inst->crop.width);
-		left_offset = inst->crop.left;
-		top_offset = inst->crop.top;
+		codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
+		if (V4L2_TYPE_IS_OUTPUT(plane)) {
+			bottom_offset = (inst->enc_raw_height - inst->crop.height);
+			right_offset = (inst->enc_raw_width - inst->crop.width);
+			left_offset = inst->crop.left;
+			top_offset = inst->crop.top;
+		} else {
+			bottom_offset = (ALIGN(inst->fmt_dst->fmt.pix_mp.height, codec_align) -
+					inst->fmt_dst->fmt.pix_mp.height);
+			right_offset = (ALIGN(inst->fmt_dst->fmt.pix_mp.width, codec_align) -
+					inst->fmt_dst->fmt.pix_mp.width);
+			left_offset = 0;
+			top_offset = 0;
+		}
 	}
 
 	payload[0] = FIELD_PREP(GENMASK(31, 16), left_offset) | top_offset;
diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
index 50a3eb975a2523abf1c2df128a66a762a1ed35c6..7ad747d2272f029e69a56572a188a032f898a3fb 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.c
+++ b/drivers/media/platform/qcom/iris/iris_venc.c
@@ -62,8 +62,8 @@ int iris_venc_inst_init(struct iris_inst *inst)
 
 	inst->crop.left = 0;
 	inst->crop.top = 0;
-	inst->crop.width = f->fmt.pix_mp.width;
-	inst->crop.height = f->fmt.pix_mp.height;
+	inst->crop.width = DEFAULT_WIDTH;
+	inst->crop.height = DEFAULT_HEIGHT;
 
 	inst->operating_rate = DEFAULT_FPS;
 	inst->frame_rate = DEFAULT_FPS;

-- 
2.43.0


