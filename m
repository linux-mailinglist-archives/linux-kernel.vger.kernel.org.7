Return-Path: <linux-kernel+bounces-890117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB99C3F410
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C48B14E86BF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E992D9EED;
	Fri,  7 Nov 2025 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nKMLx4mB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WXfe2uhG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007BB302758
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509010; cv=none; b=LDofL1EwX8Z9ryQQsBvAv73n+ciqH6npfpYtM8HDJzLEkxqPgGCKxk2WsgK4SJ2/vyo7CwwdXlki9XIT32FKqa1d0NIVvNil9Nuwg7MS3Gf4WiNJmrwg991u5RW7viyjLsd5ntZn1hL+4YfaZwIrtIBUjLboqDibtYUh3Ijl4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509010; c=relaxed/simple;
	bh=SWt+hwwNe9PsHYcemvNKv0BC8yiebaVK1kJWCfMgI1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n1NBgRkqErQVU5rBCsRQ+YOtdwm0rTlRQOSIbVWuN22ZJRcnHINhl4RAB5qqyqRx9DCcOaAEdLhqE0bcO4LhQ2cu3mY0nUlWIqE0/ZrTfAKqtC54F6MdjwPdzh5XqSMlVQihc81gyRsWN5FwwqFHHW5I26uLdp2yhHMNZsWU9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nKMLx4mB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WXfe2uhG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A779wkr3748809
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 09:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FftA7wD5WcLIKyBHSrsSa+81tJSqladI38d/XqLnx0Q=; b=nKMLx4mBJylbl7O6
	ugoYPTw8Dr2VPQd8UfW2ElCx/fhdZJmYt0AQuTXxe8ch6yJpz9/JSHI7b/hb4xqV
	tBh8e5UhfDEs6lH7B07uAHFspfFBWI7+mLkBiH83GicrwY5F7tjWS0FUtCSkOc0t
	dY2MtNhaQpzFskTe7dueWRSF8y/dd9rGIYdgO7Q9DNpFZZeEhSCg3tqdcZ3c0Se4
	AZCU3Osk2zVxQCz2R11iGG6YjK4UyLtX3vGAtePe2dutTaL0WhaYltGoX/CNKtf9
	6jAUPePwDXcG057CnbVFCQBmdobLcnBsH2BPkrKujWFIA7tnLB13g88SHu0k45dm
	/SbfEg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8sy6ksvg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:50:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2954d676f9dso5761505ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762509007; x=1763113807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FftA7wD5WcLIKyBHSrsSa+81tJSqladI38d/XqLnx0Q=;
        b=WXfe2uhGWKxpIwrOiM5tPFYlMtecymD6fdskIndqEU3KsJb+kFwg0OM7B7enNfWlj8
         lBZzs5f+cw4jCUgvo2407wQRLQsViZ2BUtpDGStRZeeorHxG0myOrF7DyI2CDaWA/5LG
         n4XstxtpEufYQSYufJPrkEInzMxeOrSAfhA8DQtKP0uxKj46LMyWaaWOqIZHNQWZ/pPC
         tMwUnTdRXTWJyTTZ4DXfDf85GH14SjdH8NK331osSaQMVkDKXmoL9uv6hSmL+YgeTao+
         bjPCGLK/3ZqMZJBbsiLMgiBDCh9bQNtxxWAxJrDahrsj0hyHqHdeVqiKmF5VdhU/wKF2
         +naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509007; x=1763113807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FftA7wD5WcLIKyBHSrsSa+81tJSqladI38d/XqLnx0Q=;
        b=G5Q7JhLxWVDOs99O3vQor4I4EaL7ZVyl1Cf7/OaZnYviodGGjoBK9PgPndu3gR9gxm
         1Yr0eoP9daY8zLlr+S3UextQUGH+hnwaPhW2Noejqgg+s+iDkc4ZVUFFnZRx4JJt3tCM
         vf3j30pPWHcTsSrWxynfFMfOhq+9T0sDI0AU4kYz2WjFs9PwSChevQlYEUTTPFQUuu6q
         Wh5JF1bSsPFRzwx5PCHq5tKvAOX0cDMWkY62CoXjc8fZ0MoiVWlUEvICMnsSTKDT5huL
         SFF1UDyWMateHO+MamhlNbIGCcNq5EKqpCc3ajOXGkIun5j7mxP03LToqCorCsy6e8PV
         SDEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIFsA5c1XT+mHEBsxtpgqPpvBhHFuwC1uercWHLm4ZgxfrTpLHgkg/lfJsCM8ZOw+4Bu9HkeGSyPlLCs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXIfQUQRLaDh5vLPsuNCEG2DMifs2Kd0GmPCmoDOuxDl2Me59
	l+qqLIGgzwfO/sp4ogwkBI2Oe6gkeTQLlaZkh3KO7oS3AqCk0BeSBMsOHWo2jvAe7oCSvEWpd8c
	6N5iKxaemT+4gqFMikRtfhxCvhg0xOmEgFll8oosOYjQnkUynaVccGgpJLZkptK4QBkw=
X-Gm-Gg: ASbGncueay7SclRQ7pk/pZDkvwKHDRWmNA6Mv/nGOBsB5/680q488ZUzN/eNUqu25Ui
	6HVDa5ogNMIE4T+pBhQdawsxHAhOTaqZ2soPinasOyDHkpgUhPnLbFa0c76ZR+hgensrpCdG6HM
	nCyArgMOd3P5ILyhEQYnOm/0GiREHFRd4C7rkuGXsTZ3srfEFDwaSIJLUCvu5rFa5+i7R8bgrB2
	5RUFs096iGxAJIBtNzAD2R3v3iYiyeL5rljFui65OrrkZeYS2M7KpKTF7IcRi9t77Cm/8Fk+dPz
	EtA/LOiBc48TbGM62k/Cne/ZajBQMSnVhM36a7O+uZF3rGRvEjFLaJvibxI0nvE9/uQIx7okwwE
	JiIsuJjanaNQmWFmt+BRG8Q8YPFRE3vTyAw==
X-Received: by 2002:a17:903:32ce:b0:295:6427:87d4 with SMTP id d9443c01a7336-297c0492f8cmr35286485ad.50.1762509006657;
        Fri, 07 Nov 2025 01:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+OhC0kQKeF3lJKFeh8PrGewuybdud4syNwZDglqOOeCSHYsix1JhEzofjLGLKdKTgNeH1MA==
X-Received: by 2002:a17:903:32ce:b0:295:6427:87d4 with SMTP id d9443c01a7336-297c0492f8cmr35286065ad.50.1762509006043;
        Fri, 07 Nov 2025 01:50:06 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5f011sm54975895ad.25.2025.11.07.01.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:50:05 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 07 Nov 2025 15:19:37 +0530
Subject: [PATCH v3 2/6] media: iris: Add support for multiple TZ content
 protection(CP) configs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-knp_video-v3-2-50c86cbb0eb8@oss.qualcomm.com>
References: <20251107-knp_video-v3-0-50c86cbb0eb8@oss.qualcomm.com>
In-Reply-To: <20251107-knp_video-v3-0-50c86cbb0eb8@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762508991; l=7571;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=SWt+hwwNe9PsHYcemvNKv0BC8yiebaVK1kJWCfMgI1o=;
 b=ytqnH069b0RH0alLGzZQWkUay5hIu1VdnwrpqJ82snWmN8auwothoDwFn3wv1A6AME1d2AgVe
 Um49iSq2wQDAy8ahGr6GnnaDMiElK+OgRbomw5A5Ch9MYNlowj9MvXL
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=AYu83nXG c=1 sm=1 tr=0 ts=690dc0cf cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=Jj_6bxtXlEvj8rQV6ZgA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA3OCBTYWx0ZWRfX3Hrs6fi3VIj9
 Dt7wh/j4xzMPk+KG75uvAA1185MKbDDhxwL5WlZf2H52ocCf1VsqaWl48m3fcuO+ZcRIeIGGGvx
 pcdM1vuJHRezTpCpJmSJ3VtaszNRVWPF3jDqDXWpFIaLkdDDEA6/PDxx7IRnKwRa2uwvN8g3qCD
 KA6jizRldq+oLw1xepyL3qTdAZA9C+I4fjtfGrt8azzY0f77/IYYVKOQ0dnHo8G75AIJdxryD3I
 YaDN4KHh9HACXKCKo2u19/vjBHtCGZpgv3D6zN631Bq03K4I3uuLz7lHmuZ1SAMftWVq6gtjmE6
 j67B+a7Vr6s+fMbqnjaK0QDXHYLI0j+xQo3iMFAbQHgQXODMxwMnGXp3W5AbBt4KrFCYfzlFzna
 iQb0a9HXM7K6CRV22gUTYmxpDPDzWw==
X-Proofpoint-ORIG-GUID: ocxEv_QTXkmVei7eq-yrHR9XVy52vJba
X-Proofpoint-GUID: ocxEv_QTXkmVei7eq-yrHR9XVy52vJba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070078

vpu4 needs an additional configuration with respect to CP regions. Make
the CP configuration as array such that the multiple configuration can be
managed per platform.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
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


