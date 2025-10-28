Return-Path: <linux-kernel+bounces-873121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8C2C132A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F62250154C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E42BE7A6;
	Tue, 28 Oct 2025 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FUEJF8Zl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A32BE64A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632909; cv=none; b=O9WYSVLqsqxAcvPZxdluxpW5RnO363lbm0026e1ZnKKFy3aR6Bo5VyyX5buXBglm43uX1zOG0Cn3dicuS+aDGJlI4IwS2BeU+g9wMKAxivY/AgePRlR4d0J4Mr4PNEnbon1sdC8pZhFTaAZrxuFDGxo6SAKNqwke8qByk1k7bRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632909; c=relaxed/simple;
	bh=2oaRzZpkpBcaDL+LXhi7LqTRCwRt9ypQSujziItZ0/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEMSOVHjaMiXF9Nwze+sqPNsbbfKxtUuWUZsl6ciCAFS/xRBrEtozXY43HhDNucLKqUpSbpxpzdN7N8ZkKBYANR+62SFxfCqC0zALJTbntApE7kYiEeewqhpSo1yPq/1gQnW8Kskb2g0QQoILYj7GsvhT8vg/qCZyoPDmwyb0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FUEJF8Zl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RLUcBu2546697
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jF+INNhgLS0eIQd6UyyLDzCUNgzjGz+l2LgLPRrmPKI=; b=FUEJF8Zll/uH0uK6
	EmJCU2wHG4bKJwhSfRjdG3ZJcenfIbpzSOzat7aMAkKH8uvrdbfw8emXfHfqMIWc
	xii1wGoXh2gPpwRDOUHYGexmVdZSHBwiOC4T21SDYmNWvBaGEspUNc1iyh4o2MC7
	LzlLBQyU06jtNZGqwZdYDdp3ZTI4vaSinfolbDezaJRAIwhtfMDFxqCHFODvJqRz
	MO8n2/Qs+E8LHHveofY28FShItCYK4ZM7T19nRKLelJqPupfBGzdJjYEaBhLlrNJ
	7jfyc9eLYsB/JArL6dO/wBU+Ggm2DrGHX4wC44c9yUL0Hhkb+XDFf4mMPttR2PlV
	IxwvvA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a27s2k1w4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2930e2e8e7fso45909725ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632905; x=1762237705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jF+INNhgLS0eIQd6UyyLDzCUNgzjGz+l2LgLPRrmPKI=;
        b=p0ZLxqnR6oL2ZYeWFedkLx/V6Qp6FlEyqOx0WEgQ4fA58b5nyq/xVGl4t8JIw55JuA
         ReAdV5o2lu/QxabjzjprRqnktORZtvANqYYrvLLSbTGpYrNEoRVCAha+BmEVHutvhnHm
         ruu2zLnTRQKtP7PGKwssnU0lkQxH55pi5OJloK74NxeM7G/hYePwFvg2apcOf1zIwTwP
         +8kUegxjbsDp8WFyptR+YDYGgchdLIChNnkMpGrmJwcIZnmhlTFJ9rmHlKgAxDZsd9wq
         NOQiwb/wrCJ9jyCr7YKTQ+RhtH7FafPXvmQm4On7nQ9ZiCHJf+wzwwbwkMNIv7+mczs0
         yudw==
X-Forwarded-Encrypted: i=1; AJvYcCUMwLNqLdw+oXFfRfs2oqmF/x+oNwLxbvkxbl78YKMoTXhxCUHAUiuZ6CPeBvfw9Zx5gnhAzmCK/AtQ1Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi70ZM9A+32TdjUPzAs7tVWcCymR15WGG9ASJb2ITfiTzDfhJg
	i6qqD1hxRd1yv64ccMyuOodCnwpBGHyNOgZlWZs4dv1opWF76SVs/AX4QoG6mBVYt4wOWJay3HT
	rtFwp3y3C5LkR0+3j0KXUOenhe5MWfMOVANfq1MlniYfwBp1siNk/divoCl3v8uKXumA=
X-Gm-Gg: ASbGncuZuhaW1PZvncpKeGJh5TOipgY1uZ7+Yn3hgm7wnmVuN6VkZ3AiIZ01bSvHAoL
	riua+amWxj4RpbiG9WOu9HchIigiADjBiWzPc9cU/Xu3X0KJCcOxXyK0IQQAizAO/YuxlwCU9R+
	3xFp0b7NiAwxUvxMthr+Qs3WJLpr6eY8I+6zmkBqPQLx00gI0CjlPDtRWCDOKjoUjkYZko5fGI2
	CygMxRndNSPdZhBCRbm+5rR85akGJsJCou+TynEDLsYZ67cUbV0EG/R7vkHggfUHt9PvAGTXWfW
	l8+Jg2sJVkCRmE6Cc0DNrozkqRXivndTiia8gce08i7x1FO5wl17bnnIxtCZDmAWODEc6ufftsN
	7rWny6c9hq4n0Q0mZEZ0RfKRVBNiPqeUUgbh9J5NwBGSNoVmdH8iBz+Vk
X-Received: by 2002:a17:902:d4c9:b0:269:9a71:dc4a with SMTP id d9443c01a7336-294cb528b7cmr29036225ad.41.1761632904835;
        Mon, 27 Oct 2025 23:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0PQhb7nrOPw0owTHAb3UKocoVdUClhf+q6Z+WRWbHQ8BqO2EjJqP+VdWfwsWlpn2aNVCP9A==
X-Received: by 2002:a17:902:d4c9:b0:269:9a71:dc4a with SMTP id d9443c01a7336-294cb528b7cmr29035985ad.41.1761632904243;
        Mon, 27 Oct 2025 23:28:24 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm102503265ad.12.2025.10.27.23.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:28:23 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 23:28:09 -0700
Subject: [PATCH 07/12] coresight-tmc: Add support for CPU cluster ETF and
 refactor probe flow
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-cpu_cluster_component_pm-v1-7-31355ac588c2@oss.qualcomm.com>
References: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
In-Reply-To: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761632890; l=10579;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=2oaRzZpkpBcaDL+LXhi7LqTRCwRt9ypQSujziItZ0/o=;
 b=VbRLKaV4ZZf4K+mfX6223CCeK+C08cMMtg5ExiBoeA7d7WYQ+SrZBEsI6X/0m+K1BD90HjSrP
 YrqnvJpPDTjCu/4Ah1MCMgwVDHRCo6qdyWZXPDGgsCIUD3y2jzNnZv/
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-ORIG-GUID: ArB9J_VMjLjN82Pkk8L6Dng-d87D2LC1
X-Proofpoint-GUID: ArB9J_VMjLjN82Pkk8L6Dng-d87D2LC1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA1NCBTYWx0ZWRfXxGHj588ZF2BK
 mJyLh+mYL37IZ2Uk8dPJYkXIJyJ73D/mUJVeNTzKvaLOoRbuywodHFPfIjtmOffYgrQEtgbwmmw
 dPLpOGJHQ2PO+9/7j9zOC2r6/9vNeMcZN1grP9Yx1WKX14LJYTlP3GOpBUfePq3/frYNY8EWh4f
 E7ZTjqM6g9C9MbfgCc54bbVx8Jfo00IV8lrBfXvN32yWp78+l3rBWJ6lRZCUz1ggIkzX46JADQk
 giJ9nIfD1CM3vJobzfve3v9q1wIdeoa7GCxn5gcOUT2uVYwFfV9IltLnLmngebCD+S0Rg2ZX1w8
 m0L3FKjWgrMbvIRBjGkArAJsrCasGKkWybbDPfyVgeeAr8Q4y8cIHnq4yGPtljtOL8Gg0TSAuBI
 qwALC2GJoKYkSKMb2AzuGH+5jfUOsw==
X-Authority-Analysis: v=2.4 cv=R60O2NRX c=1 sm=1 tr=0 ts=6900628a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ko4GrPIkLBdci27uQwEA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280054

The CPU cluster ETF is a type of Coresight ETF that resides inside the
CPU cluster's power domain. Unlike system-level ETFs, these devices
share the CPU cluster's power management behavior: when the cluster
enters low-power mode, ETF registers become inaccessible. Runtime PM
alone cannot bring the cluster out of LPM, making standard register
access unreliable.

This patch adds support for CPU cluster ETF and restructures the probe
sequence to handle such cases safely:

- Wrap hardware access in tmc_init_hw_config(). For cluster TMCs, use
  smp_call_function_single() to ensure register visibility.
- Encapsulate CoreSight device registration and misc_register setup in
  tmc_add_coresight_dev().

This ensures TMC initialization and runtime operations remain safe even
when the CPU cluster is in low-power states, while maintaining
compatibility with existing system-level TMCs.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-core.c | 204 +++++++++++++++--------
 drivers/hwtracing/coresight/coresight-tmc.h      |   6 +
 2 files changed, 141 insertions(+), 69 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 36599c431be6203e871fdcb8de569cc6701c52bb..d00f23f9a479ee9d4bdb4e051ed895d266bcc116 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -769,56 +770,14 @@ static void register_crash_dev_interface(struct tmc_drvdata *drvdata,
 			"Valid crash tracedata found\n");
 }
 
-static int __tmc_probe(struct device *dev, struct resource *res)
+static int tmc_add_coresight_dev(struct device *dev)
 {
-	int ret = 0;
-	u32 devid;
-	void __iomem *base;
-	struct coresight_platform_data *pdata = NULL;
-	struct tmc_drvdata *drvdata;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
 	struct coresight_desc desc = { 0 };
 	struct coresight_dev_list *dev_list = NULL;
+	int ret = 0;
 
-	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, drvdata);
-
-	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, &drvdata->atclk);
-	if (ret)
-		return ret;
-
-	ret = -ENOMEM;
-
-	/* Validity for the resource is already checked by the AMBA core */
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base)) {
-		ret = PTR_ERR(base);
-		goto out;
-	}
-
-	drvdata->base = base;
-	desc.access = CSDEV_ACCESS_IOMEM(base);
-
-	raw_spin_lock_init(&drvdata->spinlock);
-
-	devid = readl_relaxed(drvdata->base + CORESIGHT_DEVID);
-	drvdata->config_type = BMVAL(devid, 6, 7);
-	drvdata->memwidth = tmc_get_memwidth(devid);
-	/* This device is not associated with a session */
-	drvdata->pid = -1;
-	drvdata->etr_mode = ETR_MODE_AUTO;
-
-	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
-		drvdata->size = tmc_etr_get_default_buffer_size(dev);
-		drvdata->max_burst_size = tmc_etr_get_max_burst_size(dev);
-	} else {
-		drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
-	}
-
-	tmc_get_reserved_region(dev);
-
+	desc.access = CSDEV_ACCESS_IOMEM(drvdata->base);
 	desc.dev = dev;
 
 	switch (drvdata->config_type) {
@@ -834,9 +793,9 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
 		desc.ops = &tmc_etr_cs_ops;
-		ret = tmc_etr_setup_caps(dev, devid, &desc.access);
+		ret = tmc_etr_setup_caps(dev, drvdata->devid, &desc.access);
 		if (ret)
-			goto out;
+			return ret;
 		idr_init(&drvdata->idr);
 		mutex_init(&drvdata->idr_mutex);
 		dev_list = &etr_devs;
@@ -851,44 +810,142 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		break;
 	default:
 		pr_err("%s: Unsupported TMC config\n", desc.name);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	desc.name = coresight_alloc_device_name(dev_list, dev);
-	if (!desc.name) {
-		ret = -ENOMEM;
+	if (!desc.name)
+		return -ENOMEM;
+
+	drvdata->desc_name = desc.name;
+
+	desc.pdata = dev->platform_data;
+
+	drvdata->csdev = coresight_register(&desc);
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
+
+	drvdata->miscdev.name = desc.name;
+	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
+	drvdata->miscdev.fops = &tmc_fops;
+	ret = misc_register(&drvdata->miscdev);
+	if (ret)
+		coresight_unregister(drvdata->csdev);
+
+	return ret;
+}
+
+static void tmc_clear_self_claim_tag(struct tmc_drvdata *drvdata)
+{
+	struct csdev_access access = CSDEV_ACCESS_IOMEM(drvdata->base);
+
+	coresight_clear_self_claim_tag(&access);
+}
+
+static void tmc_init_hw_config(struct tmc_drvdata *drvdata)
+{
+	u32 devid;
+
+	devid = readl_relaxed(drvdata->base + CORESIGHT_DEVID);
+	drvdata->config_type = BMVAL(devid, 6, 7);
+	drvdata->memwidth = tmc_get_memwidth(devid);
+	drvdata->devid = devid;
+	drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
+	tmc_clear_self_claim_tag(drvdata);
+}
+
+static void tmc_init_on_cpu(void *info)
+{
+	struct tmc_drvdata *drvdata = info;
+
+	tmc_init_hw_config(drvdata);
+}
+
+static struct cpumask *tmc_get_cpumask(struct device *dev)
+{
+	struct generic_pm_domain *pd;
+
+	pd = pd_to_genpd(dev->pm_domain);
+	if (pd)
+		return pd->cpus;
+
+	return NULL;
+}
+
+static int __tmc_probe(struct device *dev, struct resource *res)
+{
+	int cpu, ret = 0;
+	void __iomem *base;
+	struct coresight_platform_data *pdata = NULL;
+	struct tmc_drvdata *drvdata;
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, drvdata);
+
+	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, &drvdata->atclk);
+	if (ret)
+		return ret;
+
+	ret = -ENOMEM;
+
+	/* Validity for the resource is already checked by the AMBA core */
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
 		goto out;
 	}
 
+	drvdata->base = base;
+
+	raw_spin_lock_init(&drvdata->spinlock);
+	/* This device is not associated with a session */
+	drvdata->pid = -1;
+	drvdata->etr_mode = ETR_MODE_AUTO;
+	tmc_get_reserved_region(dev);
+
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata)) {
 		ret = PTR_ERR(pdata);
 		goto out;
 	}
 	dev->platform_data = pdata;
-	desc.pdata = pdata;
 
-	coresight_clear_self_claim_tag(&desc.access);
-	drvdata->csdev = coresight_register(&desc);
-	if (IS_ERR(drvdata->csdev)) {
-		ret = PTR_ERR(drvdata->csdev);
-		goto out;
+	if (is_of_node(dev_fwnode(dev)) &&
+	    of_device_is_compatible(dev->of_node, "arm,coresight-cpu-tmc")) {
+		drvdata->cpumask = tmc_get_cpumask(dev);
+		if (!drvdata->cpumask)
+			return -EINVAL;
+
+		cpus_read_lock();
+		for_each_cpu(cpu, drvdata->cpumask) {
+			ret = smp_call_function_single(cpu,
+						       tmc_init_on_cpu, drvdata, 1);
+			if (!ret)
+				break;
+		}
+		cpus_read_unlock();
+		if (ret) {
+			ret = 0;
+			goto out;
+		}
+	} else {
+		tmc_init_hw_config(drvdata);
 	}
 
-	drvdata->miscdev.name = desc.name;
-	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
-	drvdata->miscdev.fops = &tmc_fops;
-	ret = misc_register(&drvdata->miscdev);
-	if (ret) {
-		coresight_unregister(drvdata->csdev);
-		goto out;
+	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
+		drvdata->size = tmc_etr_get_default_buffer_size(dev);
+		drvdata->max_burst_size = tmc_etr_get_max_burst_size(dev);
 	}
 
+	ret = tmc_add_coresight_dev(dev);
+
 out:
 	if (is_tmc_crashdata_valid(drvdata) &&
 	    !tmc_prepare_crashdata(drvdata))
-		register_crash_dev_interface(drvdata, desc.name);
+		register_crash_dev_interface(drvdata, drvdata->desc_name);
 	return ret;
 }
 
@@ -934,10 +991,12 @@ static void __tmc_remove(struct device *dev)
 	 * etb fops in this case, device is there until last file
 	 * handler to this device is closed.
 	 */
-	misc_deregister(&drvdata->miscdev);
+	if (!drvdata->cpumask)
+		misc_deregister(&drvdata->miscdev);
 	if (drvdata->crashdev.fops)
 		misc_deregister(&drvdata->crashdev);
-	coresight_unregister(drvdata->csdev);
+	if (drvdata->csdev)
+		coresight_unregister(drvdata->csdev);
 }
 
 static void tmc_remove(struct amba_device *adev)
@@ -992,7 +1051,6 @@ static void tmc_platform_remove(struct platform_device *pdev)
 
 	if (WARN_ON(!drvdata))
 		return;
-
 	__tmc_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
@@ -1029,6 +1087,13 @@ static const struct dev_pm_ops tmc_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(tmc_runtime_suspend, tmc_runtime_resume, NULL)
 };
 
+static const struct of_device_id tmc_match[] = {
+	{.compatible = "arm,coresight-cpu-tmc"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, tmc_match);
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id tmc_acpi_ids[] = {
 	{"ARMHC501", 0, 0, 0}, /* ARM CoreSight ETR */
@@ -1043,6 +1108,7 @@ static struct platform_driver tmc_platform_driver = {
 	.remove = tmc_platform_remove,
 	.driver	= {
 		.name			= "coresight-tmc-platform",
+		.of_match_table		= tmc_match,
 		.acpi_match_table	= ACPI_PTR(tmc_acpi_ids),
 		.suppress_bind_attrs	= true,
 		.pm			= &tmc_dev_pm_ops,
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index cbb4ba43915855a8acbb9205167e87185c9a8c6c..f5c76ca2dc9733daa020b79b1dcfc495045a2618 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -243,6 +243,9 @@ struct tmc_resrv_buf {
  *		(after crash) by default.
  * @crash_mdata: Reserved memory for storing tmc crash metadata.
  *		 Used by ETR/ETF.
+ * @cpumask:	CPU mask representing the CPUs related to this TMC.
+ * @devid:	TMC variant ID inferred from the device configuration register.
+ * @desc_name:	Name to be used while creating crash interface.
  */
 struct tmc_drvdata {
 	struct clk		*atclk;
@@ -273,6 +276,9 @@ struct tmc_drvdata {
 	struct etr_buf		*perf_buf;
 	struct tmc_resrv_buf	resrv_buf;
 	struct tmc_resrv_buf	crash_mdata;
+	struct cpumask		*cpumask;
+	u32			devid;
+	const char		*desc_name;
 };
 
 struct etr_buf_operations {

-- 
2.34.1


