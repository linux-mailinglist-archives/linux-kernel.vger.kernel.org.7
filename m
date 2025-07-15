Return-Path: <linux-kernel+bounces-732514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8F5B067F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B924E4A50
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68D72C08CD;
	Tue, 15 Jul 2025 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o+zgH/7f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55422BEC21
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612483; cv=none; b=g3t+KG14418/LdFH/VnfUA4jHFOr3l7tKdNf9UlmaHpAB3clo4xIijAaPDBXtTXXZ4SgM6s4ss9c56E8EUhsEMSD5yqVsHT6ybyBgOWDUZ7d5l2RuvxFKyLxMdY3VaiQxfO0buzXOnb0Ho8+DwhX15Iknro5cjhQ8ZeccYsHArI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612483; c=relaxed/simple;
	bh=JLxRVXQhon6gxubKoqqTIwexA1gN3xO3FmETcqxOKgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ely2EMkVRTZdEjYb4C4W8xrHGrghzE8YEMCI2f9Zb3rjAh3vMfU3B2RaeKBkBV+4rUHJLiJwvXhhrH4/1tJauUBScs7WxBFALIXONp9hJOY2jGmWFQpVYI6jvvAaVhx98KPRCVtQgEgVjClnJST5mxEYSxExRY6NnPeW7F1kOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o+zgH/7f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDNTJ029579
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xqIJdlz4cKk
	IgtCaMYekqr5WxjgSE1e16/qhi8p04Sw=; b=o+zgH/7fycK1TVAMJXWmkfNwBy0
	h69KVQRJBljc18REs+OJPqGYzcODG36GRBHWehfc5v/BNsFFaO89i0BC1IReJPhF
	QzojPvXA3jrJnuYs+PP783ieM+Q9XO+/FXzGg4sotcJvScajfMBH548KuLt1zXGb
	B7rOQsBgdMEmD0uosc57JziQK5KO7a63ouuazVe6DxFG0dy8EUtQhZb1KuUiU4zY
	V3zp48386+zU9VeU+GdzsdY9llxUKBOqAqphbDW5XEDc9e0FeS197PzrTjzyYSdb
	Vo5UIRLytzGHfTxpM5k9nFeOXACisBj/qZe4+c1NmgB/FUwGjNMSydOrv0g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb1mkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e207330a45so449550785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612479; x=1753217279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqIJdlz4cKkIgtCaMYekqr5WxjgSE1e16/qhi8p04Sw=;
        b=PWnmsvsDVDV0DPc773T0VBrsWAGByAj28EChg364OB9Uk6+g4ugcJ0x+8xxE4lemqG
         8JYYvhPqf8145pAElNtv4H+XzwxW4NLlKpMun9bqf/6lLF//5GZzYPb5JM+5ryBjLANR
         W2szGosak1vqniTuK566oUf1XnZebWzGpb8jcb8D7+d2phSo7HBmbRZ3i17kX8QA/yY9
         AqVU2V34+Dt7yuEWJ2HskpKlhOvKnW0ddlmunjo4usgHg9mNi+/YaZRpD94NVbMjx7sv
         eFUWzRmeNgEnzCRfsQ4qDVf4dJbV+owGYBitpjibphgIXrm5ikeMi27bNlEAmBPFGpxR
         wHcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0k343xlv45AgKkA8Mvz1H+GhPvNheR88Um/oJzWu1ACtaP2vroghoPnxup1uHrMf2HJDSAJJPMjX56fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxreDPDnlJlXkiwZnGiPNfzXUDnHLKe1ukAQfGmDompjWpgedQb
	MHzHqMMNBvw8RBVtjMxLkyXUk5K3UEeV5SUhwp1DhLoLgZiT3XoT8xhL8IH9CWRjQo1czMOi4+X
	m7xSv0eIzdDFxsy3XpmuXHYqz4XjSiA7KaFsTxzc7hgqUEV97MxyX5JadbTjGeAjLrLk=
X-Gm-Gg: ASbGncvAxp+TO6hQCuDhelEQZLFZIuDJIgdO9DiOldQMPebvY2oevy85CO0VhC2rpvl
	pd4+Bij/6tQESHU7z3VI4HLGEVP/x3DjM9yE9mPUNPTSPuMvYAlqT4qOY38p8CWgKSspM/Dxv2S
	TgBiOLD+3lVlczHKJSknMb0c6N4MrxS9fAkCzbxUbjxSVyYta++MnKLO9JzN7i2fULF5eKr1d90
	Blei171P3ZqD1dRwfjPdYIgzCMKGqfoa2hUawDB9+2a18ZTUYV4C8l5kmVXxtVdPIHUcD5MvFcH
	PMljjZguV/0XEqIk5wJmi2QqHFp9XPnap7pDckDyoZOdI4hPG02n2zHk92r+aIRAaPGD4ldBXJR
	ktWXs70Izbmr0kwFjIw==
X-Received: by 2002:a05:620a:1b9b:b0:7e0:cb93:6fb1 with SMTP id af79cd13be357-7e3433511a5mr45662285a.9.1752612479344;
        Tue, 15 Jul 2025 13:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3uztf4eAZmDM24bnWWjsOEqyZP7OJqBLki+Bu0uvZ5eYMZGFNWgaXX9r3S8S4GW0aowWycQ==
X-Received: by 2002:a05:620a:1b9b:b0:7e0:cb93:6fb1 with SMTP id af79cd13be357-7e3433511a5mr45658385a.9.1752612478892;
        Tue, 15 Jul 2025 13:47:58 -0700 (PDT)
Received: from trex.. (153.red-79-144-197.dynamicip.rima-tde.net. [79.144.197.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2464sm16331877f8f.38.2025.07.15.13.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:47:58 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/7] media: venus: Conditionally register codec nodes based on firmware version
Date: Tue, 15 Jul 2025 22:47:44 +0200
Message-Id: <20250715204749.2189875-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
References: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zU_dNEkKkpd9TLd3BE5-0XNpOzMYJe6j
X-Proofpoint-ORIG-GUID: zU_dNEkKkpd9TLd3BE5-0XNpOzMYJe6j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE5MSBTYWx0ZWRfX+TqOebPtE7PI
 wk6SvG3jNTnG8pIOS1Ja2U0PdP3ZSpOx3TmQICm4GPzhiXBin202TJF97HVcJFtwy7yk2tw8KqG
 B90VJ66z6rT0uz99/4HOav0vJxUVIfwQUJyrlso049SD5WMMUvvW7PDdYMxj1wXLT4iaVQ+Mu6J
 EYrpTdyAiykRukxiTu0YU4WPVwthFq31CuMVaMc0fFN0R9S/SvmV0mWtWuezj9C/9ynJfwJ2tJ/
 45+1FHxGHXhcnxBM65ocXusZY8cKeCCi+D42a7Wxm9IVhzZWYxdVSjAeM9CT+I+UnYMk2YZ572C
 1QQ6vH9Mjl0B8m6eXzeltQ3U1rfaub6HkFbhYo8c6I5A/E7aQqjr3MhwmBNOchH3fqf2jSPkH3h
 Bf6fxnu9qgBiiyC78IF0ZT6Y/2gc6gH7thAlDVM9H2oLCAVrIV8AwBQ2TmsoulkgWSScwm1g
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6876be80 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Ki5fnJvzvo7yLsyA0quaxQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=b6RcsaAH2Bz4aJime2YA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150191

The encoding and decoding capabilities of a VPU can vary depending on the
firmware version in use.

This commit adds support for platforms with OF_DYNAMIC enabled to
conditionally skip the creation of codec device nodes at runtime if the
loaded firmware does not support the corresponding functionality.

Note that the driver becomes aware of the firmware version only after the
HFI layer has been initialized.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/media/platform/qcom/venus/core.c | 76 +++++++++++++++---------
 drivers/media/platform/qcom/venus/core.h |  8 +++
 2 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 4c049c694d9c..b7d6745b6124 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -28,6 +28,15 @@
 #include "pm_helpers.h"
 #include "hfi_venus_io.h"
 
+static inline bool venus_fw_supports_codec(struct venus_core *core,
+					   const struct venus_min_fw *ver)
+{
+	if (!ver)
+		return true;
+
+	return is_fw_rev_or_newer(core, ver->major, ver->minor, ver->rev);
+}
+
 static void venus_coredump(struct venus_core *core)
 {
 	struct device *dev;
@@ -103,7 +112,9 @@ static void venus_sys_error_handler(struct work_struct *work)
 	core->state = CORE_UNINIT;
 
 	for (i = 0; i < max_attempts; i++) {
-		if (!pm_runtime_active(core->dev_dec) && !pm_runtime_active(core->dev_enc))
+		/* Not both nodes might be available */
+		if ((!core->dev_dec || !pm_runtime_active(core->dev_dec)) &&
+		    (!core->dev_enc || !pm_runtime_active(core->dev_enc)))
 			break;
 		msleep(10);
 	}
@@ -202,7 +213,8 @@ static u32 to_v4l2_codec_type(u32 codec)
 	}
 }
 
-static int venus_enumerate_codecs(struct venus_core *core, u32 type)
+static int venus_enumerate_codecs(struct venus_core *core, u32 type,
+				  const struct venus_min_fw *ver)
 {
 	const struct hfi_inst_ops dummy_ops = {};
 	struct venus_inst *inst;
@@ -213,6 +225,9 @@ static int venus_enumerate_codecs(struct venus_core *core, u32 type)
 	if (core->res->hfi_version != HFI_VERSION_1XX)
 		return 0;
 
+	if (!venus_fw_supports_codec(core, ver))
+		return 0;
+
 	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
 	if (!inst)
 		return -ENOMEM;
@@ -288,14 +303,14 @@ static irqreturn_t venus_isr_thread(int irq, void *dev_id)
 
 #if defined(CONFIG_OF_DYNAMIC)
 static int venus_add_video_core(struct venus_core *core, const char *node_name,
-				const char *compat)
+				const char *compat, const struct venus_min_fw *ver)
 {
 	struct of_changeset *ocs = core->ocs;
 	struct device *dev = core->dev;
 	struct device_node *np, *enp;
 	int ret;
 
-	if (!node_name)
+	if (!node_name || !venus_fw_supports_codec(core, ver))
 		return 0;
 
 	enp = of_find_node_by_name(dev->of_node, node_name);
@@ -330,11 +345,13 @@ static int venus_add_dynamic_nodes(struct venus_core *core)
 
 	of_changeset_init(core->ocs);
 
-	ret = venus_add_video_core(core, core->res->dec_nodename, "venus-decoder");
+	ret = venus_add_video_core(core, core->res->dec_nodename, "venus-decoder",
+				   core->res->dec_minfw);
 	if (ret)
 		goto err;
 
-	ret = venus_add_video_core(core, core->res->enc_nodename, "venus-encoder");
+	ret = venus_add_video_core(core, core->res->enc_nodename, "venus-encoder",
+				   core->res->enc_minfw);
 	if (ret)
 		goto err;
 
@@ -363,6 +380,9 @@ static void venus_remove_dynamic_nodes(struct venus_core *core)
 #else
 static int venus_add_dynamic_nodes(struct venus_core *core)
 {
+	WARN_ONCE(core->res->enc_minfw || core->res->dec_minfw,
+		  "Feature not supported");
+
 	return 0;
 }
 
@@ -432,7 +452,7 @@ static int venus_probe(struct platform_device *pdev)
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					"venus", core);
 	if (ret)
-		goto err_core_put;
+		goto err_hfi_destroy;
 
 	venus_assign_register_offsets(core);
 
@@ -448,19 +468,9 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_runtime_disable;
 
-	if (core->res->dec_nodename || core->res->enc_nodename) {
-		ret = venus_add_dynamic_nodes(core);
-		if (ret)
-			goto err_runtime_disable;
-	}
-
-	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
-	if (ret)
-		goto err_remove_dynamic_nodes;
-
 	ret = venus_firmware_init(core);
 	if (ret)
-		goto err_of_depopulate;
+		goto err_runtime_disable;
 
 	ret = venus_boot(core);
 	if (ret)
@@ -474,34 +484,46 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_venus_shutdown;
 
-	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_DEC);
+	if (core->res->dec_nodename || core->res->enc_nodename) {
+		ret = venus_add_dynamic_nodes(core);
+		if (ret)
+			goto err_core_deinit;
+	}
+
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
 	if (ret)
-		goto err_core_deinit;
+		goto err_remove_dynamic_nodes;
+
+	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_DEC,
+				     core->res->dec_minfw);
+	if (ret)
+		goto err_of_depopulate;
 
-	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_ENC);
+	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_ENC,
+				     core->res->enc_minfw);
 	if (ret)
-		goto err_core_deinit;
+		goto err_of_depopulate;
 
 	ret = pm_runtime_put_sync(dev);
 	if (ret) {
 		pm_runtime_get_noresume(dev);
-		goto err_core_deinit;
+		goto err_of_depopulate;
 	}
 
 	venus_dbgfs_init(core);
 
 	return 0;
 
+err_of_depopulate:
+	of_platform_depopulate(dev);
+err_remove_dynamic_nodes:
+	venus_remove_dynamic_nodes(core);
 err_core_deinit:
 	hfi_core_deinit(core, false);
 err_venus_shutdown:
 	venus_shutdown(core);
 err_firmware_deinit:
 	venus_firmware_deinit(core);
-err_of_depopulate:
-	of_platform_depopulate(dev);
-err_remove_dynamic_nodes:
-	venus_remove_dynamic_nodes(core);
 err_runtime_disable:
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 5b1ba1c69adb..3af8386b78be 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -50,6 +50,12 @@ struct bw_tbl {
 	u32 peak_10bit;
 };
 
+struct venus_min_fw {
+	u32 major;
+	u32 minor;
+	u32 rev;
+};
+
 enum vpu_version {
 	VPU_VERSION_AR50,
 	VPU_VERSION_AR50_LITE,
@@ -92,6 +98,8 @@ struct venus_resources {
 	u32 cp_nonpixel_start;
 	u32 cp_nonpixel_size;
 	const char *fwname;
+	const struct venus_min_fw *enc_minfw;
+	const struct venus_min_fw *dec_minfw;
 	const char *enc_nodename;
 	const char *dec_nodename;
 };
-- 
2.34.1


