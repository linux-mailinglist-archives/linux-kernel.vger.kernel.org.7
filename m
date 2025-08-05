Return-Path: <linux-kernel+bounces-756001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2B9B1AE90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07104175A35
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E172253E0;
	Tue,  5 Aug 2025 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hx7BlMNY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AABD21FF2D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376283; cv=none; b=pB94bNEVbilVLyPd2rJclo5RFYNquQhlrLA9T5aaYMKFgthAfGc6CBxVxIMItsMPoQK0D2pyhink0wWYhO22ouXHLYMbRjp9Uax0do+8An7ZHlCyYFgIGYCeNaqSQGOo9ruZu18ux8pRYw7ccoV7PTReXQ/RVDeFZCC5M787IdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376283; c=relaxed/simple;
	bh=6+303X4Ep8cmFcfNKnWfxGOcPTh1WCdwVwYp+MJvE20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=muRVjUb4lJDJ/hzkAIRumgwXWN/J7DeBiIc/s95mLsQSNmsYBt3AsIThVzlsT+BuZ10mJr7YxOS7Yu/oXGvioSMjibQsFKTH7egXR1yzphVd6hxqMKNLnhuwD7O2O/59FVggaiYvgYT9icda05+PdpWvr/n1Zx08rQ/UEjaDZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hx7BlMNY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5752XCiV016893
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 06:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZPY1WEYK4lS
	822krdN/O4tqWe64sfx1iUL5xvi/g4CQ=; b=hx7BlMNY5BI0hDokNS+bGMdSuec
	QWMAVulS7Rn1H/GFiPA47Zmv8Gf6MlLvT/bDkx/JyLb/VjVh+EnM48bs7ToZh2YB
	nrLd0J0YKezTivX0XT7Yar3XcKHJ+WxSyVzNWGFBURARJ8ImLyc/42tUxQ3HwdgN
	M5r+Lux4iLC4D7P+fwE9T+4hDS+y04SwBDWWa4dAJDuGzwxbQZxJY0lmtPzLx9br
	nP8bJeB/iyOvp8HFsCkGQVCHccDuy4/2qGLZ8R4ubCQ9V2K0OzHAf21Co4I11q/i
	4UTqtTNhay3zonShRdlDDL5BR9iyPkjURlGPvMiapGDz1hWvUe0GsU/AuSQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48aqyv3ptq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:44:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7073f12d826so112236146d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 23:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754376279; x=1754981079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPY1WEYK4lS822krdN/O4tqWe64sfx1iUL5xvi/g4CQ=;
        b=t8eGNFkIWf2wZhRuaGV9I1imSqL7O4CwnRIrVJgFE//0fu/CtnVC9YsRoPZXjHSCSZ
         04d0EAEDzRyFVODSMY15yQ0Q/uXS6/y5L67VkrBrSKRfIlscT9yRQjTjpMS3GsBe/+rH
         Jsamu8iN9BrxZOiBYxysD+X0xSd0LBk8SrS31yw3GBl1VWpxwQRd8xgpO3u4P3IEptoz
         hx2QMDFHMdKb5pKCJoMe/teijbZep99eIZ/MiBW65FHSJBqsvQSLKaNNERUHYQHVgmGF
         ZSJ0pX2bKdncfILheIEA3v1e1/VFzSSvMCML2EHDFdW9Wxf8/iPrh0FzMq6x6G6fpRdw
         YWnA==
X-Forwarded-Encrypted: i=1; AJvYcCUvi8UxM5KvGVNvfS/4G6Hb8ULrJVkG5GUGHGX/b8/4otD+geoTVMkdyDjrwGJckr+V6iJ1XeGg6WLMiAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy+TmiEvueVdASN+4OBeRj449XjghPpu2BvaIntVosuaCNvb97
	B+esVELVExgGBG150ydt6QCKJ6lqqY7Pbb/pCgqf5Jb9EZKIbW+QdJbCMzrFTAirolfHqkUtJ7n
	adbCZrX5V1Xytdz1JUub/BNjjurE+SGKa9doG5/arKRpxfsZh7XCP3BoX8EZb5Kg1c0s=
X-Gm-Gg: ASbGncteenRFv+rgVzlOQ39plH1wRkl3pJySMokA2liX2Ot/EuprnoapBmeY2aobs8O
	YhJGIeihzG6Iavm+tF+8KoST4pnBVLkXPMTCrar4Hr9txX1+hrumfaTQHB7vKT1jKMj/hMLRf9l
	M+3Uq/PzuuSFe1DGm/ZunsbJlXHdcAKb+bg/htLjQ11N/Qsub1uGO4wmLOOcntRUNefxMecW0OA
	BdNblCCgOIfrhtsqQSkKZ9lTwwRXGT4Cd55YM/AQIAHXXQE51NiDtlGFpZcdTW4LO0/tphhH4kW
	5dVCwQgAahyzWBVptgG+jzFt9sBqMvpaWIWVsqXyGcAddoAgrYw7B4kPJIpoRkO4JVZmsDPCdvT
	6F73H4WCOcvhD
X-Received: by 2002:ad4:5763:0:b0:707:5df5:c719 with SMTP id 6a1803df08f44-70936538f21mr180121496d6.17.1754376278814;
        Mon, 04 Aug 2025 23:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCvZdqCyVh/hOL+ZsjgDFfhbHOkr5CANvqsJ6Ik/kbRThuJULN7VgZPXE4ttb9N9Ity/Behg==
X-Received: by 2002:ad4:5763:0:b0:707:5df5:c719 with SMTP id 6a1803df08f44-70936538f21mr180121366d6.17.1754376278381;
        Mon, 04 Aug 2025 23:44:38 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57922sm194015815e9.22.2025.08.04.23.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 23:44:37 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, bryan.odonoghue@linaro.org,
        quic_dikshita@quicinc.com, quic_vgarodia@quicinc.com,
        konradybcio@kernel.org, krzk+dt@kernel.org
Cc: mchehab@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/7] media: venus: Define minimum valid firmware version
Date: Tue,  5 Aug 2025 08:44:25 +0200
Message-Id: <20250805064430.782201-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mqofxlLQoxRGD4xdxGcR9koM6x3FC64O
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6891a858 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=yael46xrl2bLLysLp-AA:9
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: mqofxlLQoxRGD4xdxGcR9koM6x3FC64O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA0NiBTYWx0ZWRfXz0XdQQ53xtus
 ys8YG+KpMgnu2CzJX8ST5ti4b1QtNWnUbu27gb9r9trVWXhKlzoWUpKJ+3yOycsxKDzO3iz19wZ
 9bCrlnPvVrY9VXC6Q3Mj0hrBP5lZWHqMesOKppoTMdLTl0GkH1n/5MZhqa/DyO2nN2wm9ICAJt2
 TiCcUJ3cWjiDLkPCtUneG/WHBmHgVX7e/kc+CEl0Jj3gPkXA801CwbQW+8wB2VS7ibtEtJWqo+f
 Jr6e1Nia3/kOlbV1eu6m/U38d/WfHx3GQgqxG6L1EqNmwy4r/529D8yhLBWFE9b584d9BMx1Jxe
 NJr5lsIFnyIQBREIGxGUoqBHhkciENZnXkAMRnMUGwxYZI/J5Mt+2ErHzlnMbqaZ2/mEX5Dh2xo
 H8HDk+aMSyDsWs9Clyhnbwl7JPumYLwve9nmMoT3MxDpqjz1saK3/wbTEvEjtVeJ4o97giok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050046

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
 drivers/media/platform/qcom/venus/core.h     |  7 ++++
 drivers/media/platform/qcom/venus/firmware.c | 13 +++++++
 drivers/media/platform/qcom/venus/firmware.h |  1 +
 4 files changed, 43 insertions(+), 18 deletions(-)

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
index 5b1ba1c69adb..2d3cf920198f 100644
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
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 66a18830e66d..503dd270a14a 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -280,6 +280,19 @@ int venus_shutdown(struct venus_core *core)
 	return ret;
 }
 
+int venus_firmware_check(struct venus_core *core)
+{
+	const struct firmware_version *ver = core->res->min_fw;
+
+	if (!ver)
+		return 0;
+
+	if (!is_fw_rev_or_newer(core, ver->major, ver->minor, ver->rev))
+		return -EINVAL;
+
+	return 0;
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


