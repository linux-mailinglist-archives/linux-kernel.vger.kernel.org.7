Return-Path: <linux-kernel+bounces-871520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 735D2C0D85C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B178189705C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BF430E0F4;
	Mon, 27 Oct 2025 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSDLxgRI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A309B302CD1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568030; cv=none; b=kc3MPTphSWHf0FzWXTh64MU+zWvW4oiC9R4lzRX4coEFNcyjTYsMRlar/04cbozLBPZdnL5v91oPJb+odt8x7Yp2+o7lWIFDktbQo6MA/VTQtIb170nvcB5diRa7W1dMor57HLiHwDcRgjh4K4GOy27fRGq3sv3wNG30NVu03Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568030; c=relaxed/simple;
	bh=ldL9oE1EfZtAElQ9+XdqptYGe8dQAepD7NU7eZWefTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tri5d+392mKkDFx2JHIuuJ7sRtru+W2sxKXEaPvkUMDq3/cF9of8I0s5acHEM9Qnusdb8WPZAwlCt5CJAiaIrcjVSZYahAwJBWmwbNfp0ahpxgMIqSR7hr0wBlwOePbW7GWQYso1bYpe6mffqUlvLtaeyey7NB5i/tTb2iVotmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NSDLxgRI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RBJjQC2546726
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9sFi95zbIL6V8R4aDxrgHCEKkWfw05sk4v9zJGzSxic=; b=NSDLxgRIO7oVdKY3
	bw3pXd1J1pkwGSAIV03Xm8hO2cjBMYtQaiAQ6JQT5qQu2z6heznf6pBfp7e4Z7GQ
	YI3MYcyTGi6NGefIADHTqxtKMbWCqxXUxbOejRedtCKY+DjXbxKg1Mmt+wyYdiQQ
	KsNLOBETrowWd3TMImnyjqOrB0ynJAeMOpxoko+ndtqB5E4gXakmpnSORrwi1PHD
	PXtEglHDo/QiqZY4dTZLjsaO78iteJmSfgpKM6UZWL1Oq7AawtMFZGdlnp2PqPb5
	MhP3H45r/+6e284o3Ed89W/4M98IG8aaEWS7y54GXPNehrZEP7H1mg6t/V61ErKz
	xfIEnQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a27s2g5c3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:27:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eceefa36d0so48448341cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568026; x=1762172826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sFi95zbIL6V8R4aDxrgHCEKkWfw05sk4v9zJGzSxic=;
        b=KByrgUzs2WEqW+ShvpLAKoVq7Nsv3L5Wa6Luz6ZPtHjr3iVDc8CWXM7GA4YdEwnmYN
         /bMjYArFA33UjEcjh4WERQY35Bf1KtHBXFTZHRvd4x6h5g61HaWK6616VZ6SkhlPI/+x
         maQGx4PddQOxMszMeggu0Pp19AlPP1f04TFhsR4i43o+5GhZbOIIuGVho2Hug/3sPWFN
         4y1by6TBuepM2ZMSWoUTu8zwW4itDhCu5ez1F2lVJu14sNJmjMKSEBZ9cbqU8/xhZ1bR
         +yybHfGFLRZeO9t0DIDe9eEL8LaoqlT9KmUv69icUvuRIkJjam3eXHDFwmX30P796oz1
         C75Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnKv5JppCZrA8bx61g5aIFrd/jOzRhCBYVcJigtVwYRSTukkyThpA5Ki5FVHchS5GgWg9OejvfnpieoCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMI4FLFOoJPv0upJVLFnQ1RkzpyuMQ7sD8KoaTdPic8Kfuu8eJ
	BkZcVjBkWkS24huR2rLBwkuOw8tMAUL5ZzCTBqjqxak8Z2BBmJjfJBVOYKjK6IyE0E5xR+EVcAt
	bonE8mOV8SuRjlDHeHkBOBzWFU50Di2TAM69KvTXGRw5e+BsxVYONPKjJNjtcdjWS4L8=
X-Gm-Gg: ASbGncvWyPHZkXkRtoNxLbPY4j8gNo4Mdr7EzCfUDc3DsCCrhdaojqKCuvuHtM6iHrA
	84zFmBSjD395Ol4Glr1wYAnDHlclqlEEl5oTkZ8uOGo1c3TMPalxl/FCXr5sBaSQGQII9UgvGkv
	vRnHswcXut/L1FQnF/eORxdTr0FYsSpxgZIyNnU31p+x/srPJe7zurj6b08cbkKCSuTUTh2E+4Y
	7NzhQ7jCUvBCwyynHOr2B3ul+aGXKqbbPWQYPTbzNLUY1VSVJsVuh5o6rn7oPhppLL+SoqExBxw
	LMsLF+TpKmhbOMEUJW0rgb2b4scvYYo9PKiG43oDBFcUOsnpZquq6h2z8qrNVVGdAkis59hmX34
	zrL5GOLArCWeLG8ykQuN0+fOpAI8CKsxy0dwMQNvaJL/tSNOkzmnqIZHSWkaqsfGTZKkCP27oLM
	lKuAcJBDJFUwyU
X-Received: by 2002:a05:622a:8c03:b0:4e8:9e8a:294e with SMTP id d75a77b69052e-4e89e8a2d7cmr420613211cf.6.1761568026141;
        Mon, 27 Oct 2025 05:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA1VQi2AqzCgMmnFVsnc9Klx/oWqFgMMvGA2NeD7Ke3xKd1zXHX3q6b0zno2C+ky7UPVKaUg==
X-Received: by 2002:a05:622a:8c03:b0:4e8:9e8a:294e with SMTP id d75a77b69052e-4e89e8a2d7cmr420612111cf.6.1761568024171;
        Mon, 27 Oct 2025 05:27:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f83cb5sm2253474e87.102.2025.10.27.05.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:27:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 14:26:59 +0200
Subject: [PATCH v5 1/6] media: iris: turn platform caps into constants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-iris-sc7280-v5-1-5eeab5670e4b@oss.qualcomm.com>
References: <20251027-iris-sc7280-v5-0-5eeab5670e4b@oss.qualcomm.com>
In-Reply-To: <20251027-iris-sc7280-v5-0-5eeab5670e4b@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5023;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ldL9oE1EfZtAElQ9+XdqptYGe8dQAepD7NU7eZWefTg=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ8b/VBEWvxWb4suvTi+02PKHK9kjyNuk975OXzBjZd/Zk
 8t63z7pZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEcq6z/5XUOevaZHNYxfHl
 6esd0+9WflnYe7acJy9hocfjpf+sy+Mcpe/sV1n9cF6o0HfjVzd3+DAlPeTwkMr/tkNDMj3/rYv
 qN9ZzW6UV/A3sMi7fWv5+0TSG2qq1WSLmGQmKRTVmN/fG13N3prX7NOVZMZwsnBXfOUe90GHi/L
 WzBA8b7JZZy3566gHRO2v6V184E2bvL5kYrSwo+UT9yj6WwsR1H/hMYhctDCr0bDpbqG5vPOsDx
 0qFijX9mzov6XxKXRYtWDtjB+8dl3N11RxHYl+HPpi7P6LvmEg4U65258efxwRWVb/xZPua/vE3
 2/U6y+i/V90e+q6/GrDe/XRENAdLqnGjTkGPbFeyi+ktAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: I6-t_kOgmQ6MSyKAOStC-3qrZ4WZFyId
X-Proofpoint-GUID: I6-t_kOgmQ6MSyKAOStC-3qrZ4WZFyId
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExNiBTYWx0ZWRfX2unPycCw5boo
 Ecy3UOoJprx37tgS9knOqhFKTlrKdAJHHRsCqoc9XW5lfOpvhqOd+9WpZP+FY0Wr4/D3hj0PRz3
 2PvYrDloUgHaCFN2qWevwvVuPz2g4IWGcCP5reocryYJLMEjgEGVAB61bFcGpAoT+bWi7Yg6ca7
 7lhxbUPplR1F3qAHCKm+/Hp26OypG4fZYTwTLKEV2/AX5jGZW79l+N2Ya5KlxZUMVf+D81vmDrj
 UNCTYCPyhOC+S3dh54sfoz8wW8nNi7/dq4W6Qa6lzOVWC81zQ6vAMv9UVY2kTG5njyuQJu6gQrF
 CHHielB0dFYVQ/rCOIEPMXvq/EquIIqUMcwAymXdzK4uyXvliDDOF9fjmB/5dmibTJrEQr1Qm9f
 PKFYKF4R57kXwAy11EJBrpzMvMO3pw==
X-Authority-Analysis: v=2.4 cv=R60O2NRX c=1 sm=1 tr=0 ts=68ff651b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=4lT8O_Qwe5KXetiC_XUA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270116

Make all struct platform_inst_fw_cap instances constant, they are not
modified at runtime.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_ctrls.c            | 2 +-
 drivers/media/platform/qcom/iris/iris_platform_common.h  | 4 ++--
 drivers/media/platform/qcom/iris/iris_platform_gen2.c    | 4 ++--
 drivers/media/platform/qcom/iris/iris_platform_qcs8300.h | 4 ++--
 drivers/media/platform/qcom/iris/iris_platform_sm8250.c  | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
index 754a5ad718bc37630bb861012301df7a2e7342a1..9da050aa1f7ce8152dfa46a706e2c27adfb5d6ce 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
@@ -301,7 +301,7 @@ int iris_ctrls_init(struct iris_inst *inst)
 
 void iris_session_init_caps(struct iris_core *core)
 {
-	struct platform_inst_fw_cap *caps;
+	const struct platform_inst_fw_cap *caps;
 	u32 i, num_cap, cap_id;
 
 	caps = core->iris_platform_data->inst_fw_caps_dec;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 58d05e0a112eed25faea027a34c719c89d6c3897..17ed86bf78bb3b0bc3f0862253fba6505ac3d164 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -215,9 +215,9 @@ struct iris_platform_data {
 	const char *fwname;
 	u32 pas_id;
 	struct platform_inst_caps *inst_caps;
-	struct platform_inst_fw_cap *inst_fw_caps_dec;
+	const struct platform_inst_fw_cap *inst_fw_caps_dec;
 	u32 inst_fw_caps_dec_size;
-	struct platform_inst_fw_cap *inst_fw_caps_enc;
+	const struct platform_inst_fw_cap *inst_fw_caps_enc;
 	u32 inst_fw_caps_enc_size;
 	struct tz_cp_config *tz_cp_config_data;
 	u32 core_arch;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 36d69cc73986b74534a2912524c8553970fd862e..cbf38e13f89e5c4c46e759fbb86777854d751552 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -19,7 +19,7 @@
 #define VIDEO_ARCH_LX 1
 #define BITRATE_MAX				245000000
 
-static struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
 	{
 		.cap_id = PROFILE_H264,
 		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
@@ -203,7 +203,7 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
 	},
 };
 
-static struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
 	{
 		.cap_id = PROFILE_H264,
 		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
index 35ea0efade73caa687d300779c5b1dc3b17a0128..87517361a1cf4b6fe53b8a1483188670df52c7e7 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
@@ -5,7 +5,7 @@
 
 #define BITRATE_MAX				245000000
 
-static struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
 	{
 		.cap_id = PROFILE_H264,
 		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
@@ -189,7 +189,7 @@ static struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
 	},
 };
 
-static struct platform_inst_fw_cap inst_fw_cap_qcs8300_enc[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_enc[] = {
 	{
 		.cap_id = PROFILE_H264,
 		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
index 16486284f8acccf6a95a27f6003e885226e28f4d..e29cba993fde922b579eb7e5a59ae34bb46f9f0f 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
@@ -17,7 +17,7 @@
 #define BITRATE_PEAK_DEFAULT	(BITRATE_DEFAULT * 2)
 #define BITRATE_STEP		100
 
-static struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
 	{
 		.cap_id = PIPE,
 		.min = PIPE_1,
@@ -38,7 +38,7 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
 	},
 };
 
-static struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
 	{
 		.cap_id = STAGE,
 		.min = STAGE_1,

-- 
2.47.3


