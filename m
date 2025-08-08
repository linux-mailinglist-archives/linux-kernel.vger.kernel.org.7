Return-Path: <linux-kernel+bounces-759940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB9CB1E4B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E94C74E3C3A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8754826560A;
	Fri,  8 Aug 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bE6qbnvH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E351623A9AC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642975; cv=none; b=hGDAq9Dx7zX+zIrXsPmu6lddyRUHAoxPdPpeORExpGrZjmP3aibsqnjuq8bCA556+yFZMV5uOW0CbENwENoRa4Wq+UMjIJPIDICD/C8Af3Zogzdbc/h13HR1OdljdMyLjmxZQVEGgMZHEQji0Jy7LosZK4uFqSm/rqy9Dr8tW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642975; c=relaxed/simple;
	bh=86PLTqk8gjY11xMPb1ytqtbNlgq74lMq8dDdY25h1Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uo1+O8ww0Dp3Bxf9Y0rHMLjHyHGsiEEHszukmI1v6CnjKBe4F1L4wo4DPjCCl06zi9Wh7o+xx2GjbJFaI/KWaWw6CXDTMNTl2YuZFyRFiufrjVnErPqTjk9M4HJWUGduoWPCK+jqSIP82C4iVFQIU6prtsx9EOjFTB+4JrKbSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bE6qbnvH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5787INa5001872
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 08:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LWjsBg1VVIO
	yEmDu+biLKzIOgFeO6f57DCN9nQYGCOQ=; b=bE6qbnvHgIiv3MDD6g/4XexqKuw
	6UqnD2fKMngjehHx8Yh60kgEVCB2gAKuICAd2rpMxEFDrhQJ/pANNJjRWs1kzZFA
	mpX05wfGjcr39vHGcFeNgxnuGCs9/qsAPwM1d3U6lw8ybi5b8Zf2rHhwMShT/lWh
	hbvCkmYy8PVZStK5htde1UBE129eKsKOhFuFHAYc4CrvsvH1Tjpvh2r/EpbNM6dp
	HlD4GzQdYzUvfrm+olpD3uednFnq+Ama0tfoWKxdcq0hKYFxTPJ/F9NYsjtllv9p
	4ZHgbQpiqkaKmbaE/gnJcIDUziSiMpvixli07PJVLsKFvL4xJpGV5m0sngQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw399uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:49:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b08b271095so51636641cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754642972; x=1755247772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWjsBg1VVIOyEmDu+biLKzIOgFeO6f57DCN9nQYGCOQ=;
        b=j7DPv20u3kDQlRezeUjLGWOKX+qS/1BWuxUygTa1PYVywof7ypbKQsKVUOTK1nd6IE
         zPPrk2+5+nQ92SbdLCsoI0GQw9OEcgOL0w4hR2IuGTzICkXR6WV09wBGUOX09B3b2Z91
         DzHrgs5idK2X/G69w8YSRYLnSMOENYhmIfZ368EfLRL3mMw1kt8lsPeKH03GUnR+kzLs
         c9SZ2451pXUiIqok+IngmOvwA4v2wGnVbNycGTVHpuUfgDy+Su77e6RkbyK+neTOgoHW
         v1Zduyo6N1G8ri/M3GxvMH6qNpyMW7NsGI3nWWb8cFHdJ/VT5tBMoSsdGK6NP+BSaEWX
         8zvA==
X-Forwarded-Encrypted: i=1; AJvYcCV97OEivWrVw1dv5TVzFrHlVBjB+CNM2oYFujDjTqu5CN1FQLvQ4bfTwmVdDKsaK2qCiZQeH4D2prSTOno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+RERR4qAzUt7b9nATnNaSwhqihEQJhmYmJIawcpxkLtzqtm5
	rGeYqKtNM21K8U38slRvgf5XCu9O5oUifQUh0Q1A+qrXmQ2o35J5kunRRNi3ZDmhZQKjWANZpUT
	/F8Q8SX3oPZ7z9guGjDP6UYDxDH8llo/o28kU0Hhg9mtg8RWt47FYl5d52cOtyDHOdUE=
X-Gm-Gg: ASbGncuDKNdqpVIz/Ifjb5EbQpARY6gAK8cgwlBqVvPvBbnvpo0g/+5g0NTuzfNRDLx
	Sz3i/pVHEVmwS4l3VFhDuYslaJCKVrgV3fyXxNt4wxw3j8Lm+LuG41McC2lUF6qgXluR9xTt6xH
	Hnz0weZP4uozz8GqFdg+51rPNCSnoQarev5MH28wTkI0WjxC+fXuACC7s3KR8gRQPFJexJicU3B
	eSjQZMsLRhSZpwLEL2vSSdXkH/68iLA/2bbGpHp6yOKAlHrIZjZGZ2tU00t3s1PAO6TgqGS1LaX
	9By82ai/yO0vK1EonMzxS932mEl330x2+AcjrqEThznfwF4BpTmCD5nvakuPdK0bi/UReCeeCt8
	oSLEJJJhAhSzm
X-Received: by 2002:ac8:58c5:0:b0:4b0:8773:9b0f with SMTP id d75a77b69052e-4b0aed0f079mr31522181cf.10.1754642971762;
        Fri, 08 Aug 2025 01:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEleTrWlsG0anHArp6k+mQlnVM4K5gb1a/fa4NSmTcJysP5EfMDPCkm8nMA1E9waB8F2IsMYQ==
X-Received: by 2002:ac8:58c5:0:b0:4b0:8773:9b0f with SMTP id d75a77b69052e-4b0aed0f079mr31521901cf.10.1754642971257;
        Fri, 08 Aug 2025 01:49:31 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm122904295e9.2.2025.08.08.01.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:49:30 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, mchehab@kernel.org, robh@kernel.org,
        andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/8] media: venus: Define minimum valid firmware version
Date: Fri,  8 Aug 2025 10:49:17 +0200
Message-Id: <20250808084923.1402617-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808084923.1402617-1-jorge.ramirez@oss.qualcomm.com>
References: <20250808084923.1402617-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX2VX5oOfI4cYH
 hhQb1Zbt5cW1N5O+QWbWlfzTmL0acejSkcRoMPevUtHMn72Xm2ZXchBMrVegeApqP13A1Md79Pv
 VbYrWVBDEiKl2uA2YoQL/Lk0z7NRRw/cGJCg4LhbmB0AN03PA+A+lAPYNTJTgwl3CWqd4UUDtvr
 T7jngbcQkomsX6y03qxyiZaNwQ9ZWClQLxi+2SdJeMC8sfg16YEFDN/yTzTaW7+Gzb1/AZpl4vP
 aLoO4NeVokZyi/jk9AwVt2NVjTNrYpd9NYRj1hhXL7R654Sl5/34fwL6Ui1b71PyRBYjPTfPN/z
 PRaaXdTlhv+8oLMY3qA7MVjWA8utBoLdJ9qkJHJSIo4BK9oW3bg4MQc3l0tNv8hejKN5CLC+sPA
 Bl0MS9Qh
X-Authority-Analysis: v=2.4 cv=J8Cq7BnS c=1 sm=1 tr=0 ts=6895ba1c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=-5R0vqtSU2Fw_BP-RAMA:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: LvZCof6y2M6VcyaPK2AgneFJC62fKVqr
X-Proofpoint-ORIG-GUID: LvZCof6y2M6VcyaPK2AgneFJC62fKVqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

Add support for specifying the minimum firmware version required for
correct operation.

When set, the driver compares this value against the version reported by
the firmware: if the firmware is older than required, driver
initialization will fail.

The version check is performed before creating dynamic device tree
nodes, to avoid the need for reverting nodes on failure.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/media/platform/qcom/venus/core.c     | 40 +++++++++++---------
 drivers/media/platform/qcom/venus/core.h     | 13 ++++---
 drivers/media/platform/qcom/venus/firmware.c | 20 ++++++++++
 drivers/media/platform/qcom/venus/firmware.h |  1 +
 4 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 4c049c694d9c..f45715c9b222 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -448,19 +448,9 @@ static int venus_probe(struct platform_device *pdev)
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
@@ -474,34 +464,48 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_venus_shutdown;
 
-	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_DEC);
+	ret = venus_firmware_check(core);
 	if (ret)
 		goto err_core_deinit;
 
+	if (core->res->dec_nodename || core->res->enc_nodename) {
+		ret = venus_add_dynamic_nodes(core);
+		if (ret)
+			goto err_core_deinit;
+	}
+
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret)
+		goto err_remove_dynamic_nodes;
+
+	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_DEC);
+	if (ret)
+		goto err_of_depopulate;
+
 	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_ENC);
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
index 5b1ba1c69adb..d1f0e9979ba4 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -58,6 +58,12 @@ enum vpu_version {
 	VPU_VERSION_IRIS2_1,
 };
 
+struct firmware_version {
+	u32 major;
+	u32 minor;
+	u32 rev;
+};
+
 struct venus_resources {
 	u64 dma_mask;
 	const struct freq_tbl *freq_tbl;
@@ -94,6 +100,7 @@ struct venus_resources {
 	const char *fwname;
 	const char *enc_nodename;
 	const char *dec_nodename;
+	const struct firmware_version *min_fw;
 };
 
 enum venus_fmt {
@@ -231,11 +238,7 @@ struct venus_core {
 	unsigned int core0_usage_count;
 	unsigned int core1_usage_count;
 	struct dentry *root;
-	struct venus_img_version {
-		u32 major;
-		u32 minor;
-		u32 rev;
-	} venus_ver;
+	struct firmware_version venus_ver;
 	unsigned long dump_core;
 	struct of_changeset *ocs;
 	bool hwmode_dev;
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 66a18830e66d..3666675ae298 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -280,6 +280,26 @@ int venus_shutdown(struct venus_core *core)
 	return ret;
 }
 
+int venus_firmware_check(struct venus_core *core)
+{
+	const struct firmware_version *req = core->res->min_fw;
+	const struct firmware_version *run = &core->venus_ver;
+
+	if (!req)
+		return 0;
+
+	if (!is_fw_rev_or_newer(core, req->major, req->minor, req->rev))
+		goto error;
+
+	return 0;
+error:
+	dev_err(core->dev, "Firmware v%d.%d.%d < v%d.%d.%d\n",
+		run->major, run->minor, run->rev,
+		req->major, req->minor, req->rev);
+
+	return -EINVAL;
+}
+
 int venus_firmware_init(struct venus_core *core)
 {
 	struct platform_device_info info;
diff --git a/drivers/media/platform/qcom/venus/firmware.h b/drivers/media/platform/qcom/venus/firmware.h
index aaccd847fa30..ead39e3797f0 100644
--- a/drivers/media/platform/qcom/venus/firmware.h
+++ b/drivers/media/platform/qcom/venus/firmware.h
@@ -9,6 +9,7 @@ struct device;
 
 int venus_firmware_init(struct venus_core *core);
 void venus_firmware_deinit(struct venus_core *core);
+int venus_firmware_check(struct venus_core *core);
 int venus_boot(struct venus_core *core);
 int venus_shutdown(struct venus_core *core);
 int venus_set_hw_state(struct venus_core *core, bool suspend);
-- 
2.34.1


