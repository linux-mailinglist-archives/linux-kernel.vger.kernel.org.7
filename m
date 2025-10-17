Return-Path: <linux-kernel+bounces-858155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8BDBE9284
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 410FD568A24
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2329393DF1;
	Fri, 17 Oct 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="co35y+nJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCBD36CE16
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710646; cv=none; b=kO5DVGeRPcJMXV/m3sEguVX/ZMGPBNWVzNrAyWDC1Q+DujNiSJZQyDmIXYFUbsVpYZG59UKgXt+10hmTVVZY6+rHfJVaZ4qoeTjaMkF07dl/2zBnFRZHUWdWjaQhRXl28mJfKBj24SSASg8XSLoYZUImd/acITEOrzjomJHF1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710646; c=relaxed/simple;
	bh=aQhwVL5OkKZpJNwoBgyA4DOV0LM9OQwDpkWUVApVJPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UsLQgDDftNdM2/m+CgGJUReGOUpOHO1iR4PFLCKIGvzmowGHK3aqEaq8U3cb51etXffTSUwnp2e0dPVXnwtROMsuXytxNCe+G/URIRqdDkJbXMna+p8NHhr35ihdY2y2Pg+V31AoFbpXJUExTZDEiO6fmcGsaGin5k2co0mf6Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=co35y+nJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8EFYA025257
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0hhcR/alBkgYZiip4OaGyRrX8Ez+m6UUaOpdYtIN+/w=; b=co35y+nJ6M+GAvQQ
	Awhc8RH7d4jOZ4QPNpYoGm1s9Z7e6RtdRsTZVqBJriShKwy8zM7ACLYH614sIuRE
	kDrNcWRKly7SW4LJp48ckZzFAkVvopWn/k0n8ahIjCxbbAOJlP9iSqVwGFi5ay+B
	gi2ZejHakBBLxENLq9mRZaXifcfD1jru2bsBTZyhHoe0F+JwM7hbzBPquFd7vVSy
	AFeYWljVQLLq9uSYDVTbn5/wGV4uPO29WfKDuQE3z5Ie6TMVdOa5z8PGjUOVLrFO
	DRte8TDg+9PPqVIh37RYmQ89cK3u9iJkfu5+Gx1tp5GPvUBGHZNTVNwFU8wvUjRG
	S3bldA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkmey4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:17:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b67c546a6e3so4179496a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760710642; x=1761315442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hhcR/alBkgYZiip4OaGyRrX8Ez+m6UUaOpdYtIN+/w=;
        b=dokkrczBKeuw2sgPUdLL15SA229QUOlq0q8rOq/D19XpjeItjRonUIFhWJh7bLtaMf
         GPr9KYOHXmoih7nkcq2dAsR4lCrYd5XX+y0cBYKM0ztXjT+M0sRKXwxcNSHztLllv+SP
         8/CuNWbvHIAUL7xdpmSDpcdutzWTPgitxGdXVu8XKuRKniMzdqCIeP+wv/x5mNWHMrXx
         Wdrjv1rqWDJZCWst2TjUymz7TGZJA7Sg02QBZWA9QpgcDpvFRHzcAZOgXG2US7kAhmMS
         jMdkeAHkTSfF5BCrjUFSecjPjHZFXpvv8gWWTdt1Tu14oFF/ATnyRtz0tsPnpefrahAv
         cA/w==
X-Forwarded-Encrypted: i=1; AJvYcCVSJSCkNFlFdOOPriuykGE/SQ8q1eQrQdhhHjZGAR1uKPqtpYRdRNhNjrv/we2cfEebQvGKp78DKj7vQgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/LwmANN6aKysBgQQ0AjQcRNenC9xAy0e1jm9g+lL58UONvNb+
	pgmPOYnHfUJPnz4jUlHjFPrjaSTbOtWcUOKBYdcY9hj/X4q4ettMbumrZLTphv7T+k4tw9DUWUF
	hVRB3X8RQlnvFBbec+Ch5AOl0xRte8/WDDV1ZOeWv3g8rV9GpjokLPxW90dsvrCTZpTI=
X-Gm-Gg: ASbGnctVRwxJnq4E05Pgzi7gDBBtw+PMI5UU0tPgRpyp9r05m+uvO8jXCygqBY4x/uF
	ARpLiZsYmcqgOla8D50TdfHco0fRkfPHVk22fS5TTfSYH2j7LQ1NW4rDlMbSXMsHMHk+//cJ1JF
	Eynqmk7jTRH6RrCQmKcWfmvlvYB/RRYfqL7r3sXBAd4Tldp+Tr3X0UZwX4K8oVOaJ2lc/zyWp4Z
	hw/+RPz8Rq9TCghv9C5mcYdbdkYOletH8kGAbfHALwKSaGebOgV8CcVUofbHO+w/dWJSZSl8VMw
	jlYQDZqtPob+AvP8QdinmtCrJy91eklCBMjzuAkbBS9nk+1OYUHPxinHQTmTwmHMQlLzoxk52nB
	6DTEY5Xmi1SI2g1qpfCvrICdAS34+HI9U/A==
X-Received: by 2002:a05:6a20:914b:b0:2be:81e3:1124 with SMTP id adf61e73a8af0-334a8534446mr5461838637.2.1760710642076;
        Fri, 17 Oct 2025 07:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxXc274Kq5egMI1bqkuLdN79CwK6f2yYhs31cKxtIElWJMGzwLejgYYnr/BS6HvoRiDPX2yg==
X-Received: by 2002:a05:6a20:914b:b0:2be:81e3:1124 with SMTP id adf61e73a8af0-334a8534446mr5461793637.2.1760710641536;
        Fri, 17 Oct 2025 07:17:21 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0966d7sm25895826b3a.40.2025.10.17.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:17:20 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 19:46:24 +0530
Subject: [PATCH v2 3/8] media: iris: Add support for multiple TZ content
 protection(CP) configs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-knp_video-v2-3-f568ce1a4be3@oss.qualcomm.com>
References: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
In-Reply-To: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760710621; l=7561;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=aQhwVL5OkKZpJNwoBgyA4DOV0LM9OQwDpkWUVApVJPo=;
 b=JXyQFNP4KcwlCETxfTyyCz2BppopYai97qQmcOvMwTeQOaifksZLbH1EGKjYpjxIxo7E37N5Q
 EHMThwhZ0KlAnnFsGJd8EaFumae2QDu5Y94D7xslt1Nyu+mwihClPWu
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: 0uuuTJgQShrsOhHOH6le1HJJhhl2nt0Y
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f24ff3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=Jj_6bxtXlEvj8rQV6ZgA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0uuuTJgQShrsOhHOH6le1HJJhhl2nt0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX/ZEyO3VwhGHs
 0PkSWEaPlN9zY48FeixtKI+QwOvUstvCqaUbAimgB/2HswbE1Q1RvMLPJNYSgiE9shbQgyPfFY8
 eGuK818drIHtOFQuCd5NXECILYfgRnY6h+X70AEi/O1VI2FA4yaDE+1VMqtysTq6L502rHQ7ToC
 luhrD4Lvm6nf4YgUQOLtDcnahu/MshKpaiaYdxW2Fk5Y8dSfjl+hMCNNx6OUwiOUQZmPWjzTm04
 J6GoFOU73hmRS9uRl2hGvCpmDzndRsY13aMgyMTAV5Bi1u6Sc0uSIfCo+bJGY2pC852wqJn0jdX
 h1wn9MRT88+V2z3TxNfwBCdnW1q6aTPvSMXLZqeGs1N/VMMAMtQAIcNXds8wpIVEaDn6+0UnaKP
 xt+HoEh7ZhyNWYP4eY01nlj7x5kP2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

vpu4 needs an additional configuration with respect to CP regions. Make
the CP configuration as array such that the multiple configuration can be
managed per platform.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_firmware.c   | 23 ++++++++++++---------
 .../platform/qcom/iris/iris_platform_common.h      |  3 ++-
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 24 ++++++++++++++--------
 .../platform/qcom/iris/iris_platform_sm8250.c      | 15 ++++++++------
 4 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index 9ab499fad946446a87036720f49c9c8d311f3060..9186e0144dc0df4045c9995adc5fc93993cc3fba 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -70,9 +70,9 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 
 int iris_fw_load(struct iris_core *core)
 {
-	struct tz_cp_config *cp_config = core->iris_platform_data->tz_cp_config_data;
+	const struct tz_cp_config *cp_config;
 	const char *fwpath = NULL;
-	int ret;
+	int i, ret;
 
 	ret = of_property_read_string_index(core->dev->of_node, "firmware-name", 0,
 					    &fwpath);
@@ -91,14 +91,17 @@ int iris_fw_load(struct iris_core *core)
 		return ret;
 	}
 
-	ret = qcom_scm_mem_protect_video_var(cp_config->cp_start,
-					     cp_config->cp_size,
-					     cp_config->cp_nonpixel_start,
-					     cp_config->cp_nonpixel_size);
-	if (ret) {
-		dev_err(core->dev, "protect memory failed\n");
-		qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
-		return ret;
+	for (i = 0; i < core->iris_platform_data->tz_cp_config_data_size; i++) {
+		cp_config = &core->iris_platform_data->tz_cp_config_data[i];
+		ret = qcom_scm_mem_protect_video_var(cp_config->cp_start,
+						     cp_config->cp_size,
+						     cp_config->cp_nonpixel_start,
+						     cp_config->cp_nonpixel_size);
+		if (ret) {
+			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
+			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
+			return ret;
+		}
 	}
 
 	return ret;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index df03de08c44839c1b6c137874eb7273c638d5f2c..ae49e95ba2252fc1442f7c81d8010dbfd86da0da 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -220,7 +220,8 @@ struct iris_platform_data {
 	u32 inst_fw_caps_dec_size;
 	struct platform_inst_fw_cap *inst_fw_caps_enc;
 	u32 inst_fw_caps_enc_size;
-	struct tz_cp_config *tz_cp_config_data;
+	const struct tz_cp_config *tz_cp_config_data;
+	u32 tz_cp_config_data_size;
 	u32 core_arch;
 	u32 hw_response_timeout;
 	struct ubwc_config_data *ubwc_config;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index fea800811a389a58388175c733ad31c4d9c636b0..00c6b9021b98aac80612b1bb9734c8dac8146bd9 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -648,11 +648,13 @@ static struct ubwc_config_data ubwc_config_sm8550 = {
 	.bank_spreading = 1,
 };
 
-static struct tz_cp_config tz_cp_config_sm8550 = {
-	.cp_start = 0,
-	.cp_size = 0x25800000,
-	.cp_nonpixel_start = 0x01000000,
-	.cp_nonpixel_size = 0x24800000,
+static const struct tz_cp_config tz_cp_config_sm8550[] = {
+	{
+		.cp_start = 0,
+		.cp_size = 0x25800000,
+		.cp_nonpixel_start = 0x01000000,
+		.cp_nonpixel_size = 0x24800000,
+	},
 };
 
 static const u32 sm8550_vdec_input_config_params_default[] = {
@@ -771,7 +773,8 @@ struct iris_platform_data sm8550_data = {
 	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
 	.inst_fw_caps_enc = inst_fw_cap_sm8550_enc,
 	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_sm8550_enc),
-	.tz_cp_config_data = &tz_cp_config_sm8550,
+	.tz_cp_config_data = tz_cp_config_sm8550,
+	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8550),
 	.core_arch = VIDEO_ARCH_LX,
 	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
 	.ubwc_config = &ubwc_config_sm8550,
@@ -864,7 +867,8 @@ struct iris_platform_data sm8650_data = {
 	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
 	.inst_fw_caps_enc = inst_fw_cap_sm8550_enc,
 	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_sm8550_enc),
-	.tz_cp_config_data = &tz_cp_config_sm8550,
+	.tz_cp_config_data = tz_cp_config_sm8550,
+	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8550),
 	.core_arch = VIDEO_ARCH_LX,
 	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
 	.ubwc_config = &ubwc_config_sm8550,
@@ -947,7 +951,8 @@ struct iris_platform_data sm8750_data = {
 	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
 	.inst_fw_caps_enc = inst_fw_cap_sm8550_enc,
 	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_sm8550_enc),
-	.tz_cp_config_data = &tz_cp_config_sm8550,
+	.tz_cp_config_data = tz_cp_config_sm8550,
+	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8550),
 	.core_arch = VIDEO_ARCH_LX,
 	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
 	.ubwc_config = &ubwc_config_sm8550,
@@ -1035,7 +1040,8 @@ struct iris_platform_data qcs8300_data = {
 	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_qcs8300_dec),
 	.inst_fw_caps_enc = inst_fw_cap_qcs8300_enc,
 	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_qcs8300_enc),
-	.tz_cp_config_data = &tz_cp_config_sm8550,
+	.tz_cp_config_data = tz_cp_config_sm8550,
+	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8550),
 	.core_arch = VIDEO_ARCH_LX,
 	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
 	.ubwc_config = &ubwc_config_sm8550,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
index 1b1b6aa751106ee0b0bc71bb0df2e78340190e66..8927c3ff59dab59c7d2cbcd92550f9ee3a2b5c1e 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
@@ -278,11 +278,13 @@ static const char * const sm8250_opp_clk_table[] = {
 	NULL,
 };
 
-static struct tz_cp_config tz_cp_config_sm8250 = {
-	.cp_start = 0,
-	.cp_size = 0x25800000,
-	.cp_nonpixel_start = 0x01000000,
-	.cp_nonpixel_size = 0x24800000,
+static const struct tz_cp_config tz_cp_config_sm8250[] = {
+	{
+		.cp_start = 0,
+		.cp_size = 0x25800000,
+		.cp_nonpixel_start = 0x01000000,
+		.cp_nonpixel_size = 0x24800000,
+	},
 };
 
 static const u32 sm8250_vdec_input_config_param_default[] = {
@@ -348,7 +350,8 @@ struct iris_platform_data sm8250_data = {
 	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8250_dec),
 	.inst_fw_caps_enc = inst_fw_cap_sm8250_enc,
 	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_sm8250_enc),
-	.tz_cp_config_data = &tz_cp_config_sm8250,
+	.tz_cp_config_data = tz_cp_config_sm8250,
+	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8250),
 	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
 	.num_vpp_pipe = 4,
 	.max_session_count = 16,

-- 
2.34.1


