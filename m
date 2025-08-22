Return-Path: <linux-kernel+bounces-781684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D503B31579
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD63D5846E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE858224882;
	Fri, 22 Aug 2025 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RBI+2qhE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B22F49F8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858629; cv=none; b=DE8yvqp5NqexqhXHQzxJaAoDY9sj5AyhXYxHl+ChZ5Ftbw3Nu8VSROI6hD3KZpZBGvpJNhFJZfVAqyKZYxLwlFSyvGHbeCJJMTvFqbFAsupFaGeDhgvXOR0FFVZ8KeSvDvZyo9rNYeHWuS7+rWf1SnfOAwvcHAJKSBNlbouSXpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858629; c=relaxed/simple;
	bh=wKxjmIL7A64pPvCzT9AuXr40zSWaHUtIPBmduY/2LJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=loCBteF6zaqobdkZV0pQ7q6CmFZo7dOGAxQrqur01lYlAMn5wYnvlhRH9JM43G0ZYivafcNWYe6lctkm/SeOw4/iMyWEpq/jGEEmAbtVf4mOTUQiy9R0d68Ymcmc4qIjweGC2YaKJNEqlbLe+IFOMVEwyBkybhMYAHmqM3k/jSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RBI+2qhE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8URKi020955
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i6ar52aS7pa
	AX9RHyuOfRDfJ9wQKcoEYJ/divHjrSY0=; b=RBI+2qhEXUEMiXgq70B/t0a8bWe
	aaI/beco7U0AproNlSduJs4TtxTnJZn1wHNvrkGksle9akdVCj1oA1HtkeiHIlSp
	Xi3Duy5wXnEY42YQEec1oXYvrtt2CKZXEwyVSZ8mTgR9jVCKzQs0J4H+2jXs/rgQ
	tdkitScxMnmXocGMzvJVa+E7Mb8ib7dK0DbnRiKt6CE39B3gr/u+TN6eYAdd3J9a
	wFya8zTGi7DMsjKnVwO6vOdIqfPecNOVDtbFPNzq08bLK3MU+6Kt4ZsVoUloe2FZ
	5ZctaCxWnzrgS4EgC8QGyl7syFTNrEs3K6JUkJKup9QdKYuKmUu7i3RKGuw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290w8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:30:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4716fa1e59so1673512a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858626; x=1756463426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6ar52aS7paAX9RHyuOfRDfJ9wQKcoEYJ/divHjrSY0=;
        b=jPmTjUCWprJtbPYM8Ng1ZZ+ZhbyJH8WIdfqoyOgfo6Ts0ymtowZ+Gb1hUGjVZI/qoI
         gXAOmbz7cOsJKKxHs6frluyjQBwiPnJeTI/VSKT1++Wl59C/t+8863Tq0hy7xpqAm6WL
         mJNTVHi3FO52yIebDTd/TXwSiBixoeD/eWUKw/TpbaxBNmGak8uzJvgFv/iqkwmTsKRn
         JFsTVByogspmjNCENKTdWJAz35+lCFbeciKtUcUTiwja+/wI8Bo/tBCWJbMK9hmBBXBa
         rTzIrMoo3R6SUO33pu5c8zat3hMdT+Cv+OzywLYmk6jexJvbt0HhPP/l/OMkbEEYymbM
         r8/g==
X-Forwarded-Encrypted: i=1; AJvYcCXnekgJyz6RGlH5K+be4BXc1EFEt13zkGztkRcI9cSdRFt3ltg40O2sHhWaDOxiGEZJBp/C5+BzDOicZNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPSoC5FtZI9FjZznd4ghBtBpWs/c1FRt40OyufSeIDEUYm2nnx
	zo2/GYb9jkwHQsD1dLLCSWn7metw2AXGCxYDYD0nWlRFUFVgh9FFZmUEjjv040TDucKdKoxSaIR
	G3LDJO/pDWfAuvnP1t14EQQqp4Kvq+4eY/lBnPGA+YvaFugPZpwSRuWXvVpmEMJQHWjc=
X-Gm-Gg: ASbGncsfqEb35aZyS/qIk/Xz4ecG+4NoqgR3B3RksH//mhZWWqoBv4hiOrIo8+J56Fc
	JigipdzBbeu+yvYJcc2DF+Qj/WX4Cah3wZW1w1XodpMJcqFCY+pDJM0pHAh1ZUdUY0IjvCD8Gbo
	XQAutPye0cuhZzzDSRLcBLi0sm+dSafYm7tdgnoLIAqGg2ZWXMDlOP0nipUEz4efj4/cQ/xHG3E
	TTGEsbAIRxclodEZALMcILaS9hZRUj3NWS/KnWXxm/2zyr8tOm+RFCOrb/SVGNKMPN39vBGQ5uz
	e80JQqqXfjdfEvk2JTpTND9ohd6xmdrOd4/HGaRj+0YxY6V7yk3256J5HO2J0J1sK5z6hKtZz6o
	SBTwircXlDEHLKTgBdFsA
X-Received: by 2002:a05:6a21:99a7:b0:240:1327:ab3e with SMTP id adf61e73a8af0-24340bca37dmr3028736637.9.1755858625526;
        Fri, 22 Aug 2025 03:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVfMGah7FeeGrlu9Z4lkk3HAocWg5kHZCQFp5j8zHi+OtP3DxGxozVGgBLiJIwQJ2a6LQSQw==
X-Received: by 2002:a05:6a21:99a7:b0:240:1327:ab3e with SMTP id adf61e73a8af0-24340bca37dmr3028681637.9.1755858624997;
        Fri, 22 Aug 2025 03:30:24 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fec0e9sm6825196a12.24.2025.08.22.03.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:30:24 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlmao.mao@oss.qualcomm.com>,
        Tao Zhang <quic_taozha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] coresight: tpdm: add static tpdm support
Date: Fri, 22 Aug 2025 18:30:07 +0800
Message-Id: <20250822103008.1029-3-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822103008.1029-1-jie.gan@oss.qualcomm.com>
References: <20250822103008.1029-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I4c8hNgg c=1 sm=1 tr=0 ts=68a846c2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=_wMi7B_O7ukW3LTXVV0A:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: rPPNwjo-z2I4Ml1z2tmZ4DwcddUHVboO
X-Proofpoint-ORIG-GUID: rPPNwjo-z2I4Ml1z2tmZ4DwcddUHVboO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX/aiD/h9NdidG
 1B2o44q1ruFGqY+p2esYvtY1Sw/Bd3mp5xxuLDd74rrvylWOZIhGd8dvz65L2xOyrMvOfH8zLg6
 ZdDrRsoOiNgAEX7QMRv5ioVDeAQE0z2W8sSZ6AziVwfoU/hSezBMY2dO6/vAXozT1btlh0QsxAK
 F32EsOnyUfdbl4CFL7TNhDrpjYJEgn5grdQ9M2MDaNlA8P9vh/FwLbdkON7fkc9JiLFFk2tfcEU
 IgcqvbluBJN0Vdi0DmtUHtEKi2ZOGNp2p4SQrefl7+8WWge34cL1W3DzA9StM+QVH4vq1XVxquq
 7uEA3au8VAZax2EX3x+ObqkKZ42957U1Dfjl8NoXbkCO6N0uEh1CqdyzKlDb8lXtZRrT4kjaWS/
 6pTX97OppKJdVvU93fsJqBY7OlLVIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

The static TPDM function as a dummy source, however, it is essential
to enable the port connected to the TPDA and configure the element size.
Without this, the TPDA cannot correctly receive trace data from the
static TPDM. Since the static TPDM does not require MMIO mapping to
access its registers, a clock controller is not mandatory for its
operation.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c |   9 ++
 drivers/hwtracing/coresight/coresight-tpdm.c | 148 ++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tpdm.h |   8 +
 3 files changed, 131 insertions(+), 34 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 333b3cb23685..4e93fa5bace4 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -68,6 +68,15 @@ static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
 	int rc = -EINVAL;
 	struct tpdm_drvdata *tpdm_data = dev_get_drvdata(csdev->dev.parent);
 
+	if (coresight_is_static_tpdm(csdev)) {
+		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
+					      "qcom,dsb-element-bits", &drvdata->dsb_esize);
+		rc &= fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
+					       "qcom,cmb-element-bits", &drvdata->cmb_esize);
+
+		goto out;
+	}
+
 	if (tpdm_data->dsb) {
 		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
 				"qcom,dsb-element-bits", &drvdata->dsb_esize);
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 7214e65097ec..1766b0182819 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -495,7 +495,9 @@ static int tpdm_enable(struct coresight_device *csdev, struct perf_event *event,
 		return -EBUSY;
 	}
 
-	__tpdm_enable(drvdata);
+	if (!coresight_is_static_tpdm(csdev))
+		__tpdm_enable(drvdata);
+
 	drvdata->enable = true;
 	spin_unlock(&drvdata->spinlock);
 
@@ -551,7 +553,9 @@ static void tpdm_disable(struct coresight_device *csdev,
 		return;
 	}
 
-	__tpdm_disable(drvdata);
+	if (!coresight_is_static_tpdm(csdev))
+		__tpdm_disable(drvdata);
+
 	coresight_set_mode(csdev, CS_MODE_DISABLED);
 	drvdata->enable = false;
 	spin_unlock(&drvdata->spinlock);
@@ -1342,10 +1346,9 @@ static const struct attribute_group *tpdm_attr_grps[] = {
 	NULL,
 };
 
-static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
+static int tpdm_probe(struct device *dev, struct resource *res)
 {
 	void __iomem *base;
-	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata;
 	struct tpdm_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
@@ -1354,32 +1357,33 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
-	adev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 
 	/* driver data*/
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
-	drvdata->dev = &adev->dev;
+	drvdata->dev = dev;
 	dev_set_drvdata(dev, drvdata);
 
-	base = devm_ioremap_resource(dev, &adev->res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (res) {
+		base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
 
-	drvdata->base = base;
+		drvdata->base = base;
+		ret = tpdm_datasets_setup(drvdata);
+		if (ret)
+			return ret;
 
-	ret = tpdm_datasets_setup(drvdata);
-	if (ret)
-		return ret;
+		if (drvdata && tpdm_has_dsb_dataset(drvdata))
+			of_property_read_u32(drvdata->dev->of_node,
+					     "qcom,dsb-msrs-num", &drvdata->dsb_msr_num);
 
-	if (drvdata && tpdm_has_dsb_dataset(drvdata))
-		of_property_read_u32(drvdata->dev->of_node,
-			   "qcom,dsb-msrs-num", &drvdata->dsb_msr_num);
-
-	if (drvdata && tpdm_has_cmb_dataset(drvdata))
-		of_property_read_u32(drvdata->dev->of_node,
-			   "qcom,cmb-msrs-num", &drvdata->cmb_msr_num);
+		if (drvdata && tpdm_has_cmb_dataset(drvdata))
+			of_property_read_u32(drvdata->dev->of_node,
+					     "qcom,cmb-msrs-num", &drvdata->cmb_msr_num);
+	}
 
 	/* Set up coresight component description */
 	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
@@ -1388,34 +1392,51 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM;
 	desc.ops = &tpdm_cs_ops;
-	desc.pdata = adev->dev.platform_data;
-	desc.dev = &adev->dev;
+	desc.pdata = dev->platform_data;
+	desc.dev = dev;
 	desc.access = CSDEV_ACCESS_IOMEM(base);
-	desc.groups = tpdm_attr_grps;
+	if (res)
+		desc.groups = tpdm_attr_grps;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
 
 	spin_lock_init(&drvdata->spinlock);
 
-	/* Decrease pm refcount when probe is done.*/
-	pm_runtime_put(&adev->dev);
-
 	return 0;
 }
 
-static void tpdm_remove(struct amba_device *adev)
+static int tpdm_remove(struct device *dev)
 {
-	struct tpdm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev);
 
 	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
+static int dynamic_tpdm_probe(struct amba_device *adev,
+			      const struct amba_id *id)
+{
+	int ret;
+
+	ret = tpdm_probe(&adev->dev, &adev->res);
+	if (!ret)
+		pm_runtime_put(&adev->dev);
+
+	return ret;
+}
+
+static void dynamic_tpdm_remove(struct amba_device *adev)
+{
+	tpdm_remove(&adev->dev);
 }
 
 /*
  * Different TPDM has different periph id.
  * The difference is 0-7 bits' value. So ignore 0-7 bits.
  */
-static const struct amba_id tpdm_ids[] = {
+static const struct amba_id dynamic_tpdm_ids[] = {
 	{
 		.id	= 0x001f0e00,
 		.mask	= 0x00ffff00,
@@ -1423,17 +1444,76 @@ static const struct amba_id tpdm_ids[] = {
 	{ 0, 0, NULL },
 };
 
-static struct amba_driver tpdm_driver = {
+MODULE_DEVICE_TABLE(amba, dynamic_tpdm_ids);
+
+static struct amba_driver dynamic_tpdm_driver = {
 	.drv = {
 		.name   = "coresight-tpdm",
 		.suppress_bind_attrs = true,
 	},
-	.probe          = tpdm_probe,
-	.id_table	= tpdm_ids,
-	.remove		= tpdm_remove,
+	.probe          = dynamic_tpdm_probe,
+	.id_table	= dynamic_tpdm_ids,
+	.remove		= dynamic_tpdm_remove,
 };
 
-module_amba_driver(tpdm_driver);
+static int tpdm_platform_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int ret;
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = tpdm_probe(&pdev->dev, res);
+	pm_runtime_put(&pdev->dev);
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static void tpdm_platform_remove(struct platform_device *pdev)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	if (WARN_ON(!drvdata))
+		return;
+
+	tpdm_remove(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+}
+
+static const struct of_device_id static_tpdm_match[] = {
+	{.compatible = "qcom,coresight-static-tpdm"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, static_tpdm_match);
+
+static struct platform_driver static_tpdm_driver = {
+	.probe		= tpdm_platform_probe,
+	.remove		= tpdm_platform_remove,
+	.driver		= {
+		.name	= "coresight-static-tpdm",
+		.of_match_table = static_tpdm_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init tpdm_init(void)
+{
+	return coresight_init_driver("tpdm", &dynamic_tpdm_driver, &static_tpdm_driver,
+				     THIS_MODULE);
+}
+
+static void __exit tpdm_exit(void)
+{
+	coresight_remove_driver(&dynamic_tpdm_driver, &static_tpdm_driver);
+}
+
+module_init(tpdm_init);
+module_exit(tpdm_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Monitor driver");
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index b11754389734..9f52c88ce5c1 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -343,4 +343,12 @@ struct tpdm_dataset_attribute {
 	enum dataset_mem mem;
 	u32 idx;
 };
+
+static inline bool coresight_is_static_tpdm(struct coresight_device *csdev)
+{
+	struct device_node *node = csdev->dev.parent->of_node;
+
+	return (csdev &&
+		of_device_is_compatible(node, "qcom,coresight-static-tpdm"));
+}
 #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
-- 
2.34.1


