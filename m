Return-Path: <linux-kernel+bounces-768310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636A7B25F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A88288587E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC382EAB90;
	Thu, 14 Aug 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fOGm+/yn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07AA2E11BF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161580; cv=none; b=YLBim9Dr2OCT3oj6riayiOJczDi1lJgOYcNylotzhv482GZ7PIOc+q1+uM6517M9E2WvxuGgiMnMW6X1StJfecNk0rTJSZaoDVs1TSp87ah27VnGk5Y4Nbtq46n5xb7GnFQDv/PJSjIreAkKV81tGG6A/AW7MMjVOoIvqLliZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161580; c=relaxed/simple;
	bh=NMYbLeTxNf/eAT2qg03Bga6vjZf9LKqLlko86qdheJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZs1imnI7XpgV7wintUxcRe5/Vg+e0R5vry7ZETep1fevSj/E78CGBoEIjYrMX1SJT9wyM0NXShEYQ8RuBDmDcbqBu5jnsNXIEty5+Es3kHLMWTBc06rd5RwfePN/MrUMwgdZnb+1S7wlWzAxRs8c6ibVI/YnJR+hDLzFCxFYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fOGm+/yn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLGIER012985
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jCLZjdpJ5XJ
	8S8QQvw3d8wMyNSpqwMisHAf/LgDvfmU=; b=fOGm+/ynQFifkgAPw1EvnXn2LQ5
	zg4ozJ3mjUJYMx6zAFPbp6sVdqiukKeDOzPGM2ZaqhX2ZkmBzhdRzBDjiB7f8rxx
	vAaEPI+ZOvFMtZ3L1o2lSGvf7Paflrju2dVvgr9FEbK5e/Yr7bXDYYJHopSIuExV
	cRunb4DbHG4fi4RdbAulpxxuIhuZ9jKo3ISAm7FxRZRukcomUt4vTJCfUjt1EsmA
	1nUxbz6tytBoE93lRBN2mLn5wBegmwgkJNi/jkROvIbOwbLtuX+wUfIpv0dRymRm
	Hr2kKiVoy1gO/gH7NMSFINQbKpLkeCf8RSvWPVUZsF57Rr45wrKmUusoNEw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6tve0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:52:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e870324e8dso262594285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161576; x=1755766376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCLZjdpJ5XJ8S8QQvw3d8wMyNSpqwMisHAf/LgDvfmU=;
        b=XPIt93UPqeBnQ11IXcYprgY6PtSme2vcCUtBVoQyKimEMVbFwGAsy2o3AGCWAVPZfy
         UWpNbcpICsnKCUHQwZl/iTXdoey8xvsoKoC13Hz9QbtwCnLNWJw6rmZxEsL+xAEEH+Br
         aRXi9Khi0jILblqahQdu5kcM5Nrn9oLokqS58Ub2kRUdzTmAg4GnVHeWBSQPnaKSfLrp
         Pg4hjCuShadpy/9zMOz8Pl4r3tBBJObNP1TS2pPTL7kqG/cd6U3K+EWDgtjEAoMiqZIf
         KILHGwNBNtUQJWkRmQMipLYMKWSYH4IMTPXm/tIZ3raY3ZMFqfSoTUtsxy9JHrdy32Kq
         YqkA==
X-Forwarded-Encrypted: i=1; AJvYcCXrN0A4Bm7IKAPEsFU8I2hgqhj+sRtfne2i29k8eyVM4eAeZeXb+5cjH0cpgVbv3lVwwopJ3Tv6md1m7KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyquD10AOhUyZYjMquWMk3YNRqO07MXNy3TZ21eBPBGcEILfPjH
	4I9ChD6nTJl7P+750RLENO6wVpyzUwWxR1vyjGft/X/DlhkufEXaQ/uudUR3JImOqgYjoSSWD/c
	NJVDcA88gzZU/sJo0jJxBtmYnqu3AgxFRmIQmEOzkSLVpFW3JVBSSnYEAL9AvPQ+vH4U=
X-Gm-Gg: ASbGncsyFSp80pzmXrfY0cpB+DkKsr1ceWUUPt1DmGDhKwqi5mHeg1RcJODnGu5ASOQ
	FxR1QL5wcLQsA9B6crTyX8rl1mULHlLHCnPiT2yfOP4K/2mv66C1KEWz6r9gfVEr2+T1h9fBGK0
	iQMgK1gDfTX83gBZAKtENdgdGzgESuCnJFksYh7L9mZh1tPYWKW6IzN4wVuznNT6X33m6GAB36S
	ix74A5s9HDlTxHsN5c2MRRHHqSuEyamH6FXTbX+9BWQalcBkb4wl9wTohdkFcuM/3Jf1P6n0eXn
	bBQqDhmKqcPIRcXQVH46YjRzrz46uEYqcJBV9+24KV1PREQZwgUEq9LcuAdRZyPuYUl5Z6Q7Vt4
	+CiMheZUQ+NF8
X-Received: by 2002:a05:620a:1901:b0:7e8:2a39:7649 with SMTP id af79cd13be357-7e8702c06d9mr335796285a.16.1755161576315;
        Thu, 14 Aug 2025 01:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZqZzz3uDaiwnXAxdJ1jz2zQh7Lvkgr6axfjgeHgmhbDcI+NrDl+NgUwS4ZMa1fdxr72cgzQ==
X-Received: by 2002:a05:620a:1901:b0:7e8:2a39:7649 with SMTP id af79cd13be357-7e8702c06d9mr335793485a.16.1755161575826;
        Thu, 14 Aug 2025 01:52:55 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc93fsm13155895e9.2.2025.08.14.01.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:52:55 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        mchehab@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/8] media: venus: Define minimum valid firmware version
Date: Thu, 14 Aug 2025 10:52:42 +0200
Message-Id: <20250814085248.2371130-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814085248.2371130-1-jorge.ramirez@oss.qualcomm.com>
References: <20250814085248.2371130-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfXwN+z7obVbku1
 oFb0i1h2kBNkuv+c0ooG/q5NbORgweChqyHNRMpiT1p+xVgaFatEFAYWb0il11yrB1whxrrm0oJ
 y+yEMje6+yzcraFPxZrQHqe8xB67ge1tATBg8lItMZd/PQ4IaWZgH6MoFOy/yZ4rqf8YhH8iX/U
 vHduJfuDI7tK4EEDUFLNZ3EUrp0nCGuYB6RphzlLTCuGX4GFZCU3W1bF04MfyG3d2f8UxEj5srX
 i8ok9rQ51D4oYrinMkwrZtaRhfw39khSap0/B7s+BDjz/hwKPWTgPn/1y24MeZRAmJ4MWgwxIFD
 J4Tjl8W4b4HjkDd8mFNpYDc67pUtE5gA9wrgmcliMnUA9Urzdmgq/o08J+Rv07VGSA7m28FD3VO
 SxaTkgx8
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689da3e9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Ke7IK1sYoyxw6fKcqmkA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: syLXJERkJMm3KOktlvG4Qw4dRDrYJvJa
X-Proofpoint-ORIG-GUID: syLXJERkJMm3KOktlvG4Qw4dRDrYJvJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

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
 drivers/media/platform/qcom/venus/hfi_msgs.c | 11 +++++-
 5 files changed, 61 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 90de29f166ad..5d76e50234f6 100644
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
index db7b69b91db5..58da4752569a 100644
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
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index cf0d97cbc463..47b99d5b5af7 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -277,7 +277,12 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
 
 done:
 	core->error = error;
-	complete(&core->done);
+	/*
+	 * Since core_init could ask for the firmware version to be validated,
+	 * completion might have to wait until the version is retrieved.
+	 */
+	if (!core->res->min_fw)
+		complete(&core->done);
 }
 
 static void
@@ -328,6 +333,10 @@ sys_get_prop_image_version(struct venus_core *core,
 	if (!IS_ERR(smem_tbl_ptr) && smem_blk_sz >= SMEM_IMG_OFFSET_VENUS + VER_STR_SZ)
 		memcpy(smem_tbl_ptr + SMEM_IMG_OFFSET_VENUS,
 		       img_ver, VER_STR_SZ);
+
+	/* core_init could have had to wait for a version check */
+	if (core->res->min_fw)
+		complete(&core->done);
 }
 
 static void hfi_sys_property_info(struct venus_core *core,
-- 
2.34.1


