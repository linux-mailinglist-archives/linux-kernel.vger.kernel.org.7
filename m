Return-Path: <linux-kernel+bounces-892823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BBDC45E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B08518906A9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FBE306499;
	Mon, 10 Nov 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QHzegJ9J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FELaa7pm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF7305954
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770226; cv=none; b=SQBsJN8H0LK60nS7SAEjcEv/oOz6+mXKRED2hqXjBAFZUDr+J1vdsL47S3WoH7gLjX3NGnxVNoDoBpM49peGe336AJzmlR3Zo9PdS9YyIKW2RyJ84UQNnS+ovP7IQDUvS+EfPEEavakSiUJoFUKVhOo5CeEy2s1sv996EmArrzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770226; c=relaxed/simple;
	bh=shJK7ajsNqFBFJaWVzEwFsy7w8X7aKP/iwR8uqxxodQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a3SRccgxTQE2U/mP3Sq0QM7Z9fWmnkrE1cCwq4VreafSSJeVjsAxkkINzgQMsxjXHYSZBbqNAxSZnqwpTubbZBB5I9W6d4mvKsnqxNaODiz/0TwyzC+47OOznlt1bRyqi5u/Xxtj0TKWOxbDD11F5OAPBcB7i9p2zPI4GWDGzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QHzegJ9J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FELaa7pm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8Zmo71576829
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gQhz4uNxSVTydOe8ll/dSa1TV34W5JQ/86IcLO6jK2g=; b=QHzegJ9Jek8buRJr
	nK5qH0NsqLkvwnzXy0n5Q3SpjyCGEj6QJ0xXHxnMa9NpHMBbIYdBgywzY0/EBwi0
	1IDHXNytFlK3aSsAy9oEcVvF4heuTMylJ8QF7cxhQEgiAiWQnJC054MrX11p6Gmd
	3nGlaFP/+//1Vi813xDxtUCrnKjqPoXQihIvfeZ9BbLQkfxcgAC4R0gF3fEgcX2x
	D9+jdrzOEk0IAeFynqfFZdtL+WYuZAnW6fKYfIqOvJuAj76zm9hSyRxp2CbkOAGl
	ilNpb5M/vqFPwP91IhN0rwYyQrWH85mI0kLES/3F6CSgYj92iy/lGiE9vcGTjSx1
	gKu4oQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xuemaxq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:23:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7ae9be0d8d5so5699701b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762770221; x=1763375021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQhz4uNxSVTydOe8ll/dSa1TV34W5JQ/86IcLO6jK2g=;
        b=FELaa7pmZDRsUqDYTTtxB6+xN+MbkQvF5pR9aZ3lCOc2L77MYa45/n6eGpcBR8et4y
         AZRTocN9hPNK0CWkdxSsTJ0YK3Socj6zGsDqXJZAlIHkN3GhO9cDSrHoMFLU15vrckCM
         4fbXdyxN9ZY/5THrdlmo2YxS16JlZXiG/S6Iwui7psJDvBStjzMPb20WthIEbFtggLb+
         tIFGELTU/ZxTfGZ2CP9voLPIUedGZGgn3zAJaFTZXZvFW99QRgFizXCqNFrqsMhxSKWB
         djkiYa/M3fu6tQoFmg5PkW6yk+4/3p9vr4yBSevmpKWPc96WXBSWvI1Vr8ahaL7XKjwH
         IuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770221; x=1763375021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gQhz4uNxSVTydOe8ll/dSa1TV34W5JQ/86IcLO6jK2g=;
        b=cQjZR96zDm+cXSDEnC1B8iMr4duIxmXjsgwpkbpYIpX2A8gneMMcfIKkCxArKIiF0F
         ylGz/mH+bQLXIyN2UxIsz6NJjAUtkXyhKZ4n8RUEPD8qInJFvGebh2ZivcrE86Yc59wE
         6ENPsFiSKTGTd46SFZ3SWKlo4mWUL38imBdVWzlwqONgudfEH85pCGe+PZtTBzHJ2dUK
         0aJuyvNu3S1XGUaPECqtis1yTefIvuM3413BHB/Ad/sBavp9bL6l9wgIU/YANuJXIFXV
         ArwqeC45Vn4jU07+kJ8XVWzTbCvmZo3vHil8RjfhFc+HtamML4kaiRMvXhdbw72sfOHz
         jUYg==
X-Forwarded-Encrypted: i=1; AJvYcCVFie4V4gq8yfjtWBkDKqFqOi14tPgVzbKNgqkDCm6eahuJoZoAoigy/DsTAPg4sqjhoz1GFez4Cz04dJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJOpzkhtjMCS5BnR40GPE2i2VXCCGFIKzen3VI6QNdShT1g7SJ
	Ll9U6mHPSiuCFXt6GGcNIiLSfZxo5dNcJFsoIJG8MDbQ2EdSI5AqOwRI6m4MaUPL4TWGkqBF8Mh
	CZEOrDD5D7iwP5DPIejTkMKGr3rQBgqWyRvPiqkBxzGhpxhFMuNbPCMOYpGNMXQNnnCI=
X-Gm-Gg: ASbGncugPkHYNjxvAWK9Tfwj31ej12XxQI1wKbEoR+lJGcOke3zWuCGEQprsIto/MgJ
	gK1Iyq8HoWJH5paQ3Sm5YITqO/OsjamUloJbhohAPhxlJZoR8iHTgSzYl2/eocqnc99NrlIclfU
	SvVsLgyVlAEmG7xbHBS6cdkhNuX8dHNCeJtb/7HFPGqe+hAu7TBcelN4J0A9sXUGX4vz5WlIkHc
	O2XzalSflB8PVgM8fSkKlm/an1Fllju/9Smu5TNdd895I8GaM1G5T6oKnfymleGgk1g5BVJrNRP
	8ykzg5UjR1dbhEsKwvxDDuwY6Mb5z4QcJyetdYokIZfvnr1XjCAoxR8r2jVIeLE9PP4D0p0ZHhf
	Ylfpww4MOkg5DrQDFDAWxvRCloKkBUAeFlE9KIKAdRe2y5ypS4OHlnANEU23c+X9yi0Vpy6sCqA
	==
X-Received: by 2002:a05:6a00:138b:b0:7ab:a41:2874 with SMTP id d2e1a72fcca58-7b225b6e947mr9006547b3a.10.1762770220585;
        Mon, 10 Nov 2025 02:23:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP6BQkQxVi6bdkeW0sMfQKTtiLwy4raEK8y4cUl+jwF3eMZvwFgd3Qht6lBmHXH6c7KlL50g==
X-Received: by 2002:a05:6a00:138b:b0:7ab:a41:2874 with SMTP id d2e1a72fcca58-7b225b6e947mr9006510b3a.10.1762770220086;
        Mon, 10 Nov 2025 02:23:40 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm11153832b3a.34.2025.11.10.02.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:23:39 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 18:23:12 +0800
Subject: [PATCH v5 1/6] media: qcom: iris: Improve format alignment for
 encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-iris_encoder_enhancements-v5-1-1dbb19968bd5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762770213; l=3388;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=shJK7ajsNqFBFJaWVzEwFsy7w8X7aKP/iwR8uqxxodQ=;
 b=DyKumYDHQgn3k2u0AXKwR3U0ftWmRYVq2/1JxHMvkUBpPxb2sdxBN9n6dHFtTLkenewBclgNW
 9X55j/0p5aVDBqnoLHMRFe5323JRKCW/LvB+yLipT2fUwA0sIT4S5ho
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MCBTYWx0ZWRfX9P47OB45thJ2
 rbD4JlmiP0sOmpAqBEZBoFdV8lo0wM5qHrST63oZleelrVWTlG0CPU6dLugIQiE9hT6Tos+8+eQ
 s9Qq6X0M+HUgduJ4UQSSkWWRUCFfHFMF353Op5qujGUWnO+wusQEIXOj8uHGDv1E6rjNhDNDVvt
 bOCqgSJyhTJnM1zHG4eNmlP6++rWXh7QBrDtYH6pfpTE79tSgKiOwJ21I7Bk8nXu15Gk3phpoEV
 mZ5u4InsTRCUocxSpW6ikLk4sPE74CrtF+VIyZ6yNJKGDhVKialhUGGx2BHx+pExxAIFxsEMjGk
 ynzqTdWAcNA2BVaEJMq351l3usqXVzHx58T/Xkjl9dNwjDUCwJ2+NM8H1JZpRFJqwhaD+OPU9eE
 A/IrWls6Rz6xyLklQpiN8AIn4Yz4Hg==
X-Proofpoint-GUID: Ujpjiv5UiYvGX7M-Gcyv1BG8kDKyM5Xg
X-Proofpoint-ORIG-GUID: Ujpjiv5UiYvGX7M-Gcyv1BG8kDKyM5Xg
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=6911bd2d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Ydk8v881x4eQe87C_TwA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100090

Add members enc_raw_width, enc_raw_height to the struct iris_inst to
support codec alignment requirements.

HFI_PROP_RAW_RESOLUTION needs to be set to the actual YUV resolution.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c | 3 +--
 drivers/media/platform/qcom/iris/iris_instance.h         | 4 ++++
 drivers/media/platform/qcom/iris/iris_venc.c             | 6 ++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 4ce71a14250832440099e4cf3835b4aedfb749e8..48962d2e4962935bbc24244edfbbdcd42dab151f 100644
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
diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
index 5982d7adefeab80905478b32cddba7bd4651a691..a9892988c10bc28e9b2d8c3b5482e99b5b9af623 100644
--- a/drivers/media/platform/qcom/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/iris/iris_instance.h
@@ -64,6 +64,8 @@ struct iris_fmt {
  * @frame_rate: frame rate of current instance
  * @operating_rate: operating rate of current instance
  * @hfi_rc_type: rate control type
+ * @enc_raw_width: source image width for encoder instance
+ * @enc_raw_height: source image height for encoder instance
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
index 099bd5ed4ae0294725860305254c4cad1ec88d7e..50a3eb975a2523abf1c2df128a66a762a1ed35c6 100644
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

-- 
2.43.0


