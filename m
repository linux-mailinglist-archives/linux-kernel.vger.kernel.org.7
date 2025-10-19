Return-Path: <linux-kernel+bounces-859577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 736A5BEDFF4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7D5B4E1918
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C1A235045;
	Sun, 19 Oct 2025 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TSHWvnFy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843622F74D
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760860622; cv=none; b=W56jWeVd5rnjP0ulgUQdfGkaokLPIwH5qOuNXfPL/dQZMdbuRTWYQWFhiMd/7GKapVx0MfX8AB6sDDWzqE87DheK9piaM0PAY+fJRorkf8tdAbn3u44daTB7QnVFhSoJVnwXrgQM1nVvwkSelIwenEY60Y/lwz3UAbrgmLlpu74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760860622; c=relaxed/simple;
	bh=ldL9oE1EfZtAElQ9+XdqptYGe8dQAepD7NU7eZWefTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OaB2Lhe6rLDyGLgNWKIJDs0xyKUj9vKqAxuc9kuWfXGYoHLZUmHjqDZ637QxI1CR90Xe2a/N0yDbUrTEoI+jUbvHppVt62Q+TCy9lv/Zldoev2C/PyObHZ+IsCO1j8y/ETp2JDe1jHoKdd7gpWgH67nqFhWDoRqFV/CQHCrQuaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TSHWvnFy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J6gN2f002342
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9sFi95zbIL6V8R4aDxrgHCEKkWfw05sk4v9zJGzSxic=; b=TSHWvnFy6bucr1QB
	hv73IVe1GeodSDe7CwOBz7zhb8R2pq6fDsLaPb65l83rApoGsZg+temsxMr/YNO4
	5KeyXWSBr6eV2B+zbUf7EyyzStWrmUtpm15gEcF9+l+D8ETisqEAwPvx1lyOElZk
	Rk5kd5MWv1xzqPO3ltkoeNoz1r6M6hRXMTlI/0t31kUBbSjiXWoNDRDsmly9ORmJ
	dlIJCIaWc8SQvcbDff1tDWmjrxA4Rg/G8zVrUMkEkyHRTvx+CMWtQasgJPGvMJxh
	oDbhUlMv6I3e8jo8P9TXl0ZL2BDJrH0EbxZGCXWDDObbjofDj2HnzC15VBp3Y/hh
	j7Jtsw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42k1vu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:56:59 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c247591ddso83697856d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760860618; x=1761465418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sFi95zbIL6V8R4aDxrgHCEKkWfw05sk4v9zJGzSxic=;
        b=a6AEUjlbS5QirQ+wZUE452xxgY6fKSVgXOFSt56N1Zs2H9CAaUW/lMGr211ZjYlfbN
         R1TjXvQLkZrpIuvgWgvzu8LOnqtq9gkPdtuFJsDKmfLOdXEtGr+1YRka+JIlP2+iFX2C
         xdAQMoXTMFTIt2a1IipOI/G0m189yecZOma3tgq16eVAXN0MvoE3eesvabJa5g4DNgvp
         /gnYEYEOSyyxEclMnuJtcvM5N5Vst74Bm+ClypB9yTPt+L3VLG39Mjmj1nr4pNpWDcmB
         flaoNt4hLhBnSMMVUcsM3TyIFNFAwmTunyqyfM1NOhPoEwDfpEDMm+L1U/5+/12fSKYS
         tsUw==
X-Forwarded-Encrypted: i=1; AJvYcCXaPDa7EoT9tF9bKlzm65jDD5z8wg5r1QGuMvr9yAxFkngULADWTRAEpROZjtC1O05nJZPKjvYJ2g2PrVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQKWM90DbIsgbnAMDMTE9VqDCgGY4zFEs3UzmL+mNO80VBD+LI
	jNOxfbegdNKxt1kqfsVP0KaXVNhKQeydOBwfzWktUltfVuJ9NSr9OVB/fnvCZSE3484u3ICgK/o
	TZkrw/nWJ4Df9rGP84NsYFp721G6fXZRWrOY8JcNB2EP3qngyMZ4PkcEI7d8cvfTiTlQ=
X-Gm-Gg: ASbGncu5XeGE8g7esUVtzgKgunYO/7eGf2ulhw7FGy3m4kcslzONEBBwOVUSUM5GJ2U
	hLuQq7rvEHkHYhimS9oVTJlgyWe2heegknZrgx3nL+xIPEaHAV3jHg6hTJUd1kU+qOEanSH8VW2
	VDdgv0bC0aL+nV9nDWUNyHElczzbQMiU7sjKO9FYnU49IyRrEnvN60aOkK/o5C3hZlcRMqTYDle
	EP2iOFleGCvinQhz4dW0VWXrLD98g7Cx2/2m998k1v/yO6XNNDz9hFtlpvmgvbIubQjCNI3m1lB
	/wBLu9M0vV4FKEA80dLJLOhBXgaBnor/kHDzgeKMwFld0jFDp1GVzF4Rku7Df9ajT7hxI9quVCt
	X5U0+Rvqm8ZTG88yupitMGoQzFhXQblwTLlu427ucEQqQ+c7s+fCZFEnZDhjmSL73TB5Kml2AGG
	ZnDoSSRd9y2sY=
X-Received: by 2002:a05:622a:1492:b0:4e8:9704:7c83 with SMTP id d75a77b69052e-4e89d1fb9eemr122031021cf.14.1760860618378;
        Sun, 19 Oct 2025 00:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoUwsBVTbVSq1ZnvMoPl2qAM7/2X/maYXG5jy1Td8s9rFPfC/tSWqOtBZjW+m2yGB/AZOm5Q==
X-Received: by 2002:a05:622a:1492:b0:4e8:9704:7c83 with SMTP id d75a77b69052e-4e89d1fb9eemr122030851cf.14.1760860617914;
        Sun, 19 Oct 2025 00:56:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deeaf4cesm1357027e87.30.2025.10.19.00.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 00:56:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 19 Oct 2025 10:56:48 +0300
Subject: [PATCH v4 1/6] media: iris: turn platform caps into constants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-iris-sc7280-v4-1-ee6dcee6e741@oss.qualcomm.com>
References: <20251019-iris-sc7280-v4-0-ee6dcee6e741@oss.qualcomm.com>
In-Reply-To: <20251019-iris-sc7280-v4-0-ee6dcee6e741@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo9JnDV5rfPEOB0okpTrdiYR93+p6wO1DWKasqW
 GNAHOYCHh+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaPSZwwAKCRCLPIo+Aiko
 1XqJB/9W//9yBpFWe/ZIXG8wk2DcbmLXxa0NJyrEJgNgABKUgBI5lf26RUARp7o/p+1MSHy203A
 +dXdANWjHQahHq2FGsdzvX3e/TPN6RzJmP6tIfpfVtKRtp0181MXvaHtLi43yLMeVBKhfDMK6FK
 vJshOiGUPNHt0z+QnOhlMvLSp02dzS29VWKwZsTVAp0RGN5bxTezxHVnRVARrDZ62b3af5984/B
 h1M315dTdKbl+o4XaooJZ/zQdMtPlhI2ZgtXbJxWXVz45HNFSwc8JXKNLV4iygkklKtxNORrX+T
 hufpbB9E13yV07xEfi3sgajB8fwXQcvjAh8yVsRQZ2fV7P3N
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: wFmae6ifWRaD-QtXY1jBBH08Ccs0_mlz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX4oYFHXGz+di3
 VQFTW/BpFE2zV9PPNRLQVFbtMz9sr7s1Am9JSnrPnFnNj6D+9IISKcZ04tc9RJ4MXkUHKRAYmPF
 ci8TDFHa6xm5ha8tmpFeW6kv6uN6spr/qKkTuhWHSTl0W+Gp6+S3BYn4I20pHTl1THpefrzIhUe
 N3S643rjbSQMANpMn+SCUd9V+izmN2rIUZgABrGQlp3vXhqoOG/IYZMy48lFOhTP2HThIPyyBqO
 1m3vnHC3T+paeDOPkKGXyy7VjJsSEBQFsWObiqK/e3nBKIoFrl7qh5wnC7s59+kSdrxygeACucX
 bq8nivhYOpKhdDPepJfUp5cThDVvwEBqfRK//AeKovxy4u7ep163C5T9o2eGF3hSPktVLjxQfQI
 cIX0Jc+ox7B//93Ply4hLi1Bp802gA==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f499cb cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=4lT8O_Qwe5KXetiC_XUA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: wFmae6ifWRaD-QtXY1jBBH08Ccs0_mlz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

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


