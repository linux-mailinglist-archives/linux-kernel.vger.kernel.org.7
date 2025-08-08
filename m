Return-Path: <linux-kernel+bounces-759958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AFEB1E4F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E8016777D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA6926E165;
	Fri,  8 Aug 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZTNkVuJd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FFD25CC42
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643191; cv=none; b=dDEYwOMsFKjdsy1aOYYh5eCLD6OkXBhqCaOal2tQn7JkovcAFOOWWsX77Sh1KTdjk2D3um9P69cfzwDv2KPJrspd6ObldNgWlXszCfqV0o5IxHtkD+Zg9xjOUJSgfE+ay7CxmU5teSICJbAecmqn+csE0qvNwrYGudhFXj+3W6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643191; c=relaxed/simple;
	bh=86PLTqk8gjY11xMPb1ytqtbNlgq74lMq8dDdY25h1Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BvpH3pCUnl+CSESeeCjoQhDPKy8uQfvAqN4Do97YqfaT88zYPt0pQs4S0fx4U6+jbTDBmfVw0K6ToM38SagxSlF9kEBw4IYSpjN6nhcDNirYddvgtt1ZqoxoCqdYXfe5ZM0fPVtPiC050y8+nSd5WOvbWjfYT8ugYI6SKihDWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZTNkVuJd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5787DAbm024771
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 08:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LWjsBg1VVIO
	yEmDu+biLKzIOgFeO6f57DCN9nQYGCOQ=; b=ZTNkVuJdMiEGp6rwYKZxVOE6XL1
	onkGuEnM6BnUGNNpRuQX3LgFO6880dt+vFPrR6MPsoQYw7352YFx/wVIJdQMPb1E
	ipwY+e8gVdxbLde/2RIBRmLXIRYtPcqCdQejK8O3suLksYLaJ5ytt5LuTSuzD5mh
	Vhr8YsgUT4zIZOv8zYV3z2iTgRzxEY8Sri54klnmIBRnH88ueaaYOs8+/5W36QVc
	6V+spgWXwl42OlrnERjaak39Jdoyb298gwwg48SDG6PFGQFdWRrPOBnUUEP52CSo
	gZg8LtRCw2NzQ7Mko/ILBOhGn66tgCc5scQgJV98f2xUPR0ZR7u8FUe5YMQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw1h8y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:53:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b08898f776so45321961cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643187; x=1755247987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWjsBg1VVIOyEmDu+biLKzIOgFeO6f57DCN9nQYGCOQ=;
        b=bZ5PdYrueJQbUCAdmYRw27TXAYp46ptBlbadDnZiLm3Nnd+IKIMG5e6jWlXEMJhf5M
         zaYytKTEWmyIKcBFJY/93GN9/RsK28jcKJvtJNX2bYmPVBjeD7lY/somUcjM0o48l+QD
         ewUqJQZskSRQNbOQ4Wai6/cFzqRzgpJ0Z+opiRfL2BaJT8rE0dYm+QR7PmZ3/K/wf3Bb
         K42p1oD5qhvK+siddqOXeVo2+wCRkLWj6bW9i+qJFFjOjhKVPh+DKbAhObqE6tZquc5h
         lulbhLE7PlpEAieQk6zDjGlGQitE8t3LteJ1PBGderVUjujraC2qtQsLZjVXUq6eLfLC
         6t6A==
X-Forwarded-Encrypted: i=1; AJvYcCXUz4Hm604ugMy7FDLpp3RFxK3A4A+tncy1qrjl87WAES0xH/Zz0j4NNrKfuiB1u/a64hHqEf3s31eXpzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwByQO9y2h/MDaQk1zfzAjUEq7mSXYHbZvA3t1EZe5HObzuynNC
	b8raUgHAdRAA/dSbDbHe6G5dumwHXjAGA7Po/YcWeSs8bWpITpC0XCGAOBoqUO+d5HED0fix12F
	t2XPJWs6VHmjxozoikArLxbMboZT7jQ2u6Cma+4BmwiYRLEutV3wcLqmBbM8tAg093/c=
X-Gm-Gg: ASbGncsQj7rIDjqvNzHqm1RrrD/lllmOYJ2zNA3wXnC7S9TE6PztwAkh+XNL3nyOPHF
	P5ixMaulE5Vyucq/PAFnyvjsqGRmuBP5jlyd5lUoY+L+qVEGkjcgGsGuGXvj1Xg61L+3fsDZgXW
	3xmVMDIZ1pbzPYOP/mvKOHjXrNzj8Gv0BgLMu7rKQVFvfptU7TTaND9Z5+2tCRqzB8YaEGFkf1J
	ygnI3IEmBoaiQN6l6hTng1D4PmVga6OIRdVbI8JAjZYxBNpl3S4VhZzkDyg92Ex/Qky6IXOZvh9
	Q0YpczVizw0MIZQZGQr5BnIvtL3Xmz5deVeZ30Xi/5Y0sFcEvL/C0i3vuPd8ubwc8PJvGOAC8+x
	eby85wUSyNhqq
X-Received: by 2002:ac8:5850:0:b0:4b0:89c2:68e0 with SMTP id d75a77b69052e-4b0aed91060mr35026001cf.60.1754643187059;
        Fri, 08 Aug 2025 01:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7RUIdmBYMOD81+aV8OkeQukTLiNggwRfZEF32hr+tFx7s53NFRvLQG7yLJg4gzZVHD7hfqw==
X-Received: by 2002:ac8:5850:0:b0:4b0:89c2:68e0 with SMTP id d75a77b69052e-4b0aed91060mr35025721cf.60.1754643186578;
        Fri, 08 Aug 2025 01:53:06 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5e99e04sm123818745e9.11.2025.08.08.01.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:53:06 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, mchehab@kernel.org, robh@kernel.org,
        andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/8] media: venus: Define minimum valid firmware version
Date: Fri,  8 Aug 2025 10:52:54 +0200
Message-Id: <20250808085300.1403570-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808085300.1403570-1-jorge.ramirez@oss.qualcomm.com>
References: <20250808085300.1403570-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX+2tn2XuC1l2d
 GW8cSnpjcDzcT8sgNSqOCj1sLZ8JNFnzE+ykol4r+2xlxy6IAxvndqoZ/0sa9j+fJCkaVSc8R4S
 aDr0lnXT5b5Yk8HtEs5tuoUFz0afsHRqAY2AVVRkiJmQ2JRvCa3LYJZuTvk4r61d3DoCLj6sRPV
 vBcHf+p27GnzlFjcXL/wlOJrtJU8+Ss8i6O7153t3yuktj0Vi8S6uqWSYX0HqlhKxpgaybrJzKH
 2Id+CFuYJKbxHcM9WJ8JDsqtz0n10XOAVZORhy4A18evIouxwsl3S/VPw7rjgrtP8XFRwGSnu9B
 LR8osT6AicWo06Q42NXMV5XqwJBQjzWI+B86DFcGJKMqo47eSTpt6OgVCf7EPNvTYEkjKrekyqs
 2AFHzdWG
X-Authority-Analysis: v=2.4 cv=Ha4UTjE8 c=1 sm=1 tr=0 ts=6895baf4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=-5R0vqtSU2Fw_BP-RAMA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: VQVjkk1QX1fDx9og63yOAQ8oQkLQ_2Lw
X-Proofpoint-GUID: VQVjkk1QX1fDx9og63yOAQ8oQkLQ_2Lw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

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


