Return-Path: <linux-kernel+bounces-844545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B4BBC22F4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B2BB4F8727
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D542EAB6A;
	Tue,  7 Oct 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ujd4Rfbq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154D2E8DF5
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855799; cv=none; b=NHmShDGRTNlXxh9KiDNxx1xkdhCwEqkNYStgqtTcoJZDtmVXIpJ+kS338z7nEMT5S0bkyV4seBlUVTRA0fYz9fdD8Q7Fixr/1fOK4r6CIqLcU93yEA9VPSHl+pZlR5SoeoeyuTFS98hm4gDQ08/zxi9SPzab0XPUPb03bvjjStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855799; c=relaxed/simple;
	bh=gJKqFUZHYzvx7skd+COKa+uj15iUdsIf5S3yo7akmn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ru+7eYEMPyuq5Kk/XwDbLjA7rTn4Q/DCRX6hLGrrOJeNJfpoclwY5ayqX5eTxWNKCRCRanpBvDAhbth75tiTc/xYwWmhjexuTLuCm2miIR/TX6SMiHNinbubsBSnhlPnPF4vI+/2nesz8fpCRnSqFKLqvB6hc7vtOMCQoj7I9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ujd4Rfbq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597EkbfL012294
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 16:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gp1xD1m/DskKjBQHramIDkOW0/yEypn06NYGkHNWYWk=; b=Ujd4RfbqSFsS+pbi
	0LXzE/gHaQ+1HxhPtUNCXu5SdO5BLHOWlz9p+XOjyaBa41JJHjvjM2IduJ6uNSza
	iWTsHz4mmslTpqynfDdTeSxy7vIb1dNGl9wr5VrGKrhOQ908wty8lUjgwt+MJ+Td
	EfxSJ0KtMIzXJZ8sibiQ52kd0E4Ix96aYXK8GD3nyY5vNVLOF+fJLMVI/+2Jch+M
	lbPSY1jW5+4KHtfDXgzLdS/4wL6II/3xtteob3ZyUixobJGlkD4PRUNd4t7Cc/xH
	4CBgj2dxNKA1o6iwaLI2dZC0coT68OmTc6SokhO4lHIafoCUG73/4IyaVdzoZDo6
	wjwMvA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n4wkrcu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:49:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27356178876so42443695ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855796; x=1760460596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gp1xD1m/DskKjBQHramIDkOW0/yEypn06NYGkHNWYWk=;
        b=SF1Tj/VjkeDB2WqnTdl4ZL/cb2rfrXGHblg1gJE/9M0G5nwKxxBtcc4i0CG4ZZlalJ
         Zranr5049cp3r/JCuiSAS2BXsqyvw/z7orzkjF0mvOWWsP2tapmkAgJU2NkrnQ8XFEtZ
         KDuRvrk9XmHjpJ1qv8U41CTWR3GnUuH/hOBB87sKaJftBd0c6vYnSlNH35Dww98EXaX1
         jXSrJxJrjlbduQpI/9pSI0Oh1+1QHBgnbwc1KgjdSJNzzWDg9NLPCbRFevTVGzmNzYqw
         9iP9Wd3O5awhHhkECnQP8LY4ioDJabQIIQDblYCcKtK3UFX4ae0ErR705IgrlaycPaiT
         D9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVAEUFcN9c/ozniVTXzGgceqybjqKxo4REm8IH2umvycuFbuVtdclq1cGF7r7vrJC1NhJw7bVJTuyV62/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsE0krcikL870mZWe+ys9G/nHUTCx6DbGMhYS5/NeAIwmX6Zik
	0xsoYuUblMNmX+6mhT9rDgvvReam9OEtxUM0q4Y4uJIgZ6b1BCDR+G/IoQeXvWJH5i5vieZeM82
	gBtQn2qG+Mr0LLd7V55F0cwbksU+So9YFYestpkAFyMpMtgcQrF8O42esLYJMa2KesM8=
X-Gm-Gg: ASbGnctcpF5azQJgfUyM4DQfkLz3ZOC642Vn/PxjIA+YJUzFKcTRI2rKnojkAt5cClV
	VPQXqypswXOvSHVlrzfAQo5SuuSje0Pd7XBPAvATHg/miG9a4ok/cY41RkDo1bCUdWqxDznnEdx
	M6Erokl27aTInzlGfK4PxEkdOBAYN1sX68keIsnSrkOkvzeDT6NruQU6pBVbiBzWCL1XeCwv1Ye
	prnnbhGNvdgrXaa2Uzzn5HIclweiwGkUUVlNkMNYYdrBSHaaQ3h/Be9Ytxz9NhHIMuGGZjjMxnz
	zEvFDSN9QXN02XBOBE0OWVh4ZwufXUe8ADYeXEuZqIeBSV4TrHP1gU2p/P8fXiMMEIY+fM1r
X-Received: by 2002:a17:902:ccc8:b0:28d:18d3:46ce with SMTP id d9443c01a7336-290273ed885mr4400855ad.31.1759855796141;
        Tue, 07 Oct 2025 09:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXmn9mJzR2s1aE87b6mgEAGEI6jvhRvRbkXkx/f7MApydYJUTAm6MtSAssMfKNQdrihGqjmg==
X-Received: by 2002:a17:902:ccc8:b0:28d:18d3:46ce with SMTP id d9443c01a7336-290273ed885mr4400415ad.31.1759855795396;
        Tue, 07 Oct 2025 09:49:55 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1261e2sm171990825ad.38.2025.10.07.09.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:49:55 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 07 Oct 2025 22:18:56 +0530
Subject: [PATCH v4 11/12] remoteproc: qcom: pas: Enable Secure PAS support
 with IOMMU managed by Linux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-kvm_rprocv4_next-20251007-v4-11-de841623af3c@oss.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
In-Reply-To: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759855751; l=5694;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=gJKqFUZHYzvx7skd+COKa+uj15iUdsIf5S3yo7akmn0=;
 b=99EcZ89WiQrXLaw076CmJ14XhkhyvRFWhtcGqy/Z12tcB2y1ipeoJc7PCkFkCJJNk+UDRg8AV
 ZxPn6EwyAt6Ahiga86E70U9X/CyCRkHDUOmL3okAdubHsbJ6qqR3J/z
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDExNyBTYWx0ZWRfX0osevK4FH/Ha
 wWukLn0eu86rhdv0/D5Fy7uYDWtNwpU2ne7QKRk9v2XeycjIPfyeaUNoZw5JqLpcALQ3RV0XkuE
 HpevBCeB7x6ptjdx6Ns6DufaBifBm4gNdzzXihgDaWmqYGFO2sXfCFZmh69FmyHXRByxuFG0wbr
 FzyRJQF1CC5FDRsERHS9rt/nxW7ODWAmuEzNqNs6CCHfbzZ9N4BSLSyxk4RuDeiLqdbMADctxfR
 SBuwkcLYpjSQqB1QHGDgDgNjO/FDc+602ZfPlk75ESJkTosKle7pW/javFp+4gzrPdqfvhSxmM9
 wboexqZ3Bo3IKsjcg4VfM+cYitY7qrGXVr+73OU0TODmURMRVstPxhcKUIBdYXywL+dkOTRJcqG
 PeL/VaMMgftPayUig9Q2et3e4nhSIw==
X-Authority-Analysis: v=2.4 cv=BP2+bVQG c=1 sm=1 tr=0 ts=68e544b5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=58pnfTnN0ARRJNaB1lkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 53yvF5VXwV9NWDiKvITtb2KYxBHrxsfM
X-Proofpoint-ORIG-GUID: 53yvF5VXwV9NWDiKvITtb2KYxBHrxsfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070117

Most Qualcomm platforms feature Gunyah hypervisor, which typically
handles IOMMU configuration. This includes mapping memory regions and
device memory resources for remote processors by intercepting
qcom_scm_pas_auth_and_reset() calls. These mappings are later removed
during teardown. Additionally, SHM bridge setup is required to enable
memory protection for both remoteproc metadata and its memory regions.
When the aforementioned hypervisor is absent, the operating system must
perform these configurations instead.

When Linux runs as the hypervisor (@ EL2) on a SoC, it will have its
own device tree overlay file that specifies the firmware stream ID now
managed by Linux for a particular remote processor. If the iommus
property is specified in the remoteproc device tree node, it indicates
that IOMMU configuration must be handled by Linux. In this case, the
has_iommu flag is set for the remote processor, which ensures that the
resource table, carveouts, and SHM bridge are properly configured before
memory is passed to TrustZone for authentication. Otherwise, the
has_iommu flag remains unset, which indicates default behavior.

Enables Secure PAS support for remote processors when IOMMU configuration
is managed by Linux.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 61 ++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index ed7bd931dfd5..940fd89d4fc4 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
+#include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -255,6 +256,22 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
+static void qcom_pas_unmap_carveout(struct rproc *rproc, phys_addr_t mem_phys, size_t size)
+{
+	if (rproc->has_iommu)
+		iommu_unmap(rproc->domain, mem_phys, size);
+}
+
+static int qcom_pas_map_carveout(struct rproc *rproc, phys_addr_t mem_phys, size_t size)
+{
+	int ret = 0;
+
+	if (rproc->has_iommu)
+		ret = iommu_map(rproc->domain, mem_phys, mem_phys, size,
+				IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
+	return ret;
+}
+
 static int qcom_pas_start(struct rproc *rproc)
 {
 	struct qcom_pas *pas = rproc->priv;
@@ -289,11 +306,15 @@ static int qcom_pas_start(struct rproc *rproc)
 	}
 
 	if (pas->dtb_pas_id) {
-		ret = qcom_scm_pas_auth_and_reset(pas->dtb_pas_id);
+		ret = qcom_pas_map_carveout(rproc, pas->dtb_mem_phys, pas->dtb_mem_size);
+		if (ret)
+			goto disable_px_supply;
+
+		ret = qcom_scm_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
 		if (ret) {
 			dev_err(pas->dev,
 				"failed to authenticate dtb image and release reset\n");
-			goto disable_px_supply;
+			goto unmap_dtb_carveout;
 		}
 	}
 
@@ -304,18 +325,22 @@ static int qcom_pas_start(struct rproc *rproc)
 
 	qcom_pil_info_store(pas->info_name, pas->mem_phys, pas->mem_size);
 
-	ret = qcom_scm_pas_auth_and_reset(pas->pas_id);
+	ret = qcom_pas_map_carveout(rproc, pas->mem_phys, pas->mem_size);
+	if (ret)
+		goto release_pas_metadata;
+
+	ret = qcom_scm_pas_prepare_and_auth_reset(pas->pas_ctx);
 	if (ret) {
 		dev_err(pas->dev,
 			"failed to authenticate image and release reset\n");
-		goto release_pas_metadata;
+		goto unmap_carveout;
 	}
 
 	ret = qcom_q6v5_wait_for_start(&pas->q6v5, msecs_to_jiffies(5000));
 	if (ret == -ETIMEDOUT) {
 		dev_err(pas->dev, "start timed out\n");
 		qcom_scm_pas_shutdown(pas->pas_id);
-		goto release_pas_metadata;
+		goto unmap_carveout;
 	}
 
 	qcom_scm_pas_metadata_release(pas->pas_ctx);
@@ -327,10 +352,16 @@ static int qcom_pas_start(struct rproc *rproc)
 
 	return 0;
 
+unmap_carveout:
+	qcom_pas_unmap_carveout(rproc, pas->mem_phys, pas->mem_size);
 release_pas_metadata:
 	qcom_scm_pas_metadata_release(pas->pas_ctx);
 	if (pas->dtb_pas_id)
 		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
+
+unmap_dtb_carveout:
+	if (pas->dtb_pas_id)
+		qcom_pas_unmap_carveout(rproc, pas->dtb_mem_phys, pas->dtb_mem_size);
 disable_px_supply:
 	if (pas->px_supply)
 		regulator_disable(pas->px_supply);
@@ -386,8 +417,12 @@ static int qcom_pas_stop(struct rproc *rproc)
 		ret = qcom_scm_pas_shutdown(pas->dtb_pas_id);
 		if (ret)
 			dev_err(pas->dev, "failed to shutdown dtb: %d\n", ret);
+
+		qcom_pas_unmap_carveout(rproc, pas->dtb_mem_phys, pas->dtb_mem_size);
 	}
 
+	qcom_pas_unmap_carveout(rproc, pas->mem_phys, pas->mem_size);
+
 	handover = qcom_q6v5_unprepare(&pas->q6v5);
 	if (handover)
 		qcom_pas_handover(&pas->q6v5);
@@ -757,6 +792,20 @@ static int qcom_pas_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	if (of_property_present(pdev->dev.of_node, "iommus")) {
+		struct of_phandle_args args;
+
+		ret = of_parse_phandle_with_args(pdev->dev.of_node, "iommus",
+						 "#iommu-cells", 0, &args);
+		if (ret < 0)
+			return ret;
+
+		rproc->has_iommu = true;
+		of_node_put(args.np);
+	} else {
+		rproc->has_iommu = false;
+	}
+
 	rproc->auto_boot = desc->auto_boot;
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
@@ -835,6 +884,8 @@ static int qcom_pas_probe(struct platform_device *pdev)
 		goto destroy_pas_ctx;
 	}
 
+	pas->pas_ctx->has_iommu = rproc->has_iommu;
+	pas->dtb_pas_ctx->has_iommu = rproc->has_iommu;
 	ret = rproc_add(rproc);
 	if (ret)
 		goto destroy_dtb_pas_ctx;

-- 
2.50.1


