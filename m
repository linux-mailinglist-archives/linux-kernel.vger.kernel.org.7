Return-Path: <linux-kernel+bounces-884223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC5BC2FAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 087F84F7CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A5030DD1E;
	Tue,  4 Nov 2025 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h/9eeHeH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IL9hp2fo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C330B50F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241796; cv=none; b=PLAzYVjAZb1Ap9cwmXy76TxVFglmjmauKPmDeDy3SZ7wlADcxS4IZSgRrVYZHdka/0LB5Wkeb+EIk1vY+FYQmPs8gH/ayaqayOxGTqiRjLhtWHTm7uUdn1661n/TEJTLrZTXPyrYIa/69T+75Gt2h/FUmwT0oACUCo6l46Ia6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241796; c=relaxed/simple;
	bh=iSmU3/X+HtLXbDnGxOipwzxim2WZlEsSp7frdNDuVEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T24V4JkBwFJnFP8wkJYFHUQqBTjNYOkEkciAFpQROyUvmxhSO9z5K+7e5cXXOIuHtzw8+KbE8sp3UCK3O9wKDkCO+6U7NVbEWtQSPPN4hZkddPOAc0e0Rcwq7sOedqNmhNdufHHoPGmcleYJv2N18zbO6wyEqZQB1qRWj6DC0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h/9eeHeH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IL9hp2fo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A42ChpW3682841
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 07:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vavCqxPgT/mS8RNiu7Esfm9e/ZvRfzrt7fzsRF3r3Yw=; b=h/9eeHeH0pIDPKsq
	NtH5FhwFo6+FLQ42zDSmZGZHq+TX+bWRmfSeVCwWa0ANJ8uB3xIvJ8eA5RLgsZgc
	XIT2/MVC0Wme81JcLW3dBsWIgzyoqgvGMgEBvgpQS/W9MToszKoHt40cjzFZy4yR
	bX29qtSfFDcphkc6AWIZnItz/rxpkfnRAWlFpkCM9XDOX3iVmACWRsCteyhx/dEV
	KbVYHKkN4B0lvuKBmXktUmuF/59ej1z5SAKkZZBl+r8f94zITmLlaBUKCgLLhH6e
	J3ODQvNq0oMykwcFUhbMQZh16ufjZanirpHklUn5DHqplI5i45EMi5zhksgEWrtu
	5ds4Mg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6xjqthqs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:36:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-332560b7171so5213098a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762241793; x=1762846593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vavCqxPgT/mS8RNiu7Esfm9e/ZvRfzrt7fzsRF3r3Yw=;
        b=IL9hp2foemRLQhzoC/j8+CmtkSVnKZ/NOA5sRA5KRfIyxSChpn9RDVSr3thMDSsUpx
         HQWybm2u6tsRx6cZKtjMObgFWATHAfzulm8rNWqo+kGLNviecipVTpInc+AGiJJbggF5
         RpykoyrmLR0XlydJ0WIiMFuTLjEE5Bxa5+hKkYDLZRbZmynXbLPSiMf4Z93dHyVm0/NV
         8ssCRTloVM7y3xk1eH8GiNXMbywfSvijbxHvo5+ZoTmV/izl040/M3sdDa6KyxQYGR/D
         0sVh1SHExsc9bh4clmIHSfx0yQpS0ty/AnUXllw4EUXKszEl5ISetumwB3mu9OJo57JF
         nAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762241793; x=1762846593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vavCqxPgT/mS8RNiu7Esfm9e/ZvRfzrt7fzsRF3r3Yw=;
        b=QR+akft4u0Kzf6h3UuMJGlsWCMHNnLzxI6e40E9qevUNEqHp+XLIa+W1UykLnDbo0U
         DvaOwuaR8CdzDvH9B5RxGWuggIX7Rg64BlgmSoUHNgaECTOkJM44H/RZPOZ1nQjNYcv0
         PhKx2uiYh+zMMQebncvnCknKkYsNY5IZ47WJaXZl0tUU2Ik40uJOoFU3gbudfxoq6CAI
         qmrst/lwFbeTN+FH3RV+A6RM+IilR6D8D6lvsiha4wrr3h5zGoKej7IO1m/0474NDtXi
         0GdeupJIAStk9u+uZWkSxAAXoWZyIohPn3aiU8/HtTqxNtXEWVhg1oNhE3lVnRH63vI4
         1aEw==
X-Forwarded-Encrypted: i=1; AJvYcCU1dwEyA0BVahzD1a27yjgEULlPlz6av1XIdWSiO6HNH/+HyvT5EKDvI6S4D6T70CNXg7qaODQulFOpnqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3sUqD9aq0szZDmnQOn/8D06+EaXYEOdQBcviNz1JEO9Qbe/7R
	RyAbjSHmf5Zp9XuH5sqoHWzMQCl2kKWUfv/ENYNJunOVtlzYYX3ClwjUfkScT8xIX/uxLbi2aIm
	9Rh66riJupeD9ifZTdC0bryr9/CQFHTTzDpaQzvRp57Dy5bc+asPH4ln5FSIxhVNPtJ8=
X-Gm-Gg: ASbGncv6VdUmVmNwevZjjFx6nKebee3Z9eKW3OeELD3RWt3sdsn56tatcJ7/07Hdc3Q
	HUPNCQ5pYLCqjOHD2jFd28FC4la3Nh/ihEcLa6r0nVQnWqY/mqZZo2DOiAjf+QXkflwanpjhLOd
	oYOm3bx+8ezRAG+0NKcku4NYPlXVISeR/CX0QVSRKNoFpZ8tjUYBd0y0ejoiGf+lG47YyvvyRaY
	Pq5pSQVAvU3GICqjxeok0qkLjagSl2j3sRH5VwgsMRKAFYCaNekPmM+l6i9m+RL+9T5DYsZsHVI
	pHFryQz72UpuRH+Ha38MKMsI4ZCjmvikKhtW4sa+WesCCdwXkrQ6pONv36pvOw4IUKxHQp7o7rj
	M/FQymBYPdWgpuwwyRo3oRMOmHw==
X-Received: by 2002:a17:90b:2dc7:b0:341:1a50:2ea9 with SMTP id 98e67ed59e1d1-341718e877bmr2898564a91.16.1762241792343;
        Mon, 03 Nov 2025 23:36:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSrcZj/TqeJdj2ge+mKKhSSdgLaFqWApr9mX6pP2aNG32jQlezJFb7S9/tn3ZslxIM2v+pXA==
X-Received: by 2002:a17:90b:2dc7:b0:341:1a50:2ea9 with SMTP id 98e67ed59e1d1-341718e877bmr2898517a91.16.1762241791643;
        Mon, 03 Nov 2025 23:36:31 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cfcsm3484367a91.19.2025.11.03.23.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:36:31 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 13:05:46 +0530
Subject: [PATCH v6 06/14] soc: qcom: mdtloader: Add PAS context aware
 qcom_mdt_pas_load() function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kvm_rproc_v6-v6-6-7017b0adc24e@oss.qualcomm.com>
References: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
In-Reply-To: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762241765; l=5648;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=iSmU3/X+HtLXbDnGxOipwzxim2WZlEsSp7frdNDuVEY=;
 b=YYX+Wk5P+6lFrCsY16XiKCwsUw4ZE6TUdYXhtsBNt15hmlv5BkHHB7zjnS1a1YD8vDJxTH7eS
 +pWP910klePA62fPYP4BrlEIUrP+Wmh9zb85z5x7JY2WqP9QwT/c336
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: nOFMabVq0aomGHrZrf9HEg6PmgqE27sX
X-Proofpoint-ORIG-GUID: nOFMabVq0aomGHrZrf9HEg6PmgqE27sX
X-Authority-Analysis: v=2.4 cv=criWUl4i c=1 sm=1 tr=0 ts=6909ad01 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=tZ3jCLSBV7jl1JjQXpgA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2MSBTYWx0ZWRfXx+PcIEOYQvXa
 KxblAbfuGVLPtJts1Mo5LasaA/Ubv2pSTt1V4QguUn+jrjDjk9Y247auQGDi/5C7SpNKSmK7wa7
 CmoucNPOID6qzltTpocCb/oHh2TpPUFzTiS8IZ1GiYFjjwu8OEqEyHnbp3lyMUYobn15wUoK+B7
 GqwDKJ+d+ZK9fOl+v6ic8NoTaifYKFHDpIB0OLYoGL3uly3Ck7mO5R7SayhYCgZqJ1fESsdwOnq
 XUo+HfvNh/sGg0A62nfQ3HCyzpq0q3EXt4E9aHpN3gkmpXcM8VJy2P5UbsyH5KpfNyq5fgNM4Bp
 oOKqgJ/vmBuigXZ+ytmDrV2Cp3v1U8Vaq2VO+nldmWrQS087JGclpbbSMHmUtaI/HX+jNHQ6Ad1
 F8wAz3xOnKnxC3bQ66AtlkBwRycMnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040061

Introduce a new PAS context-aware function, qcom_mdt_pas_load(), for
remote processor drivers. This function utilizes the PAS context
pointer returned from qcom_scm_pas_ctx_init() to perform firmware
metadata verification and memory setup via SMC calls.

The qcom_mdt_pas_load() and qcom_mdt_load() functions are largely
similar, but the former is designed for clients using the PAS
context-based data structure. Over time, all users of qcom_mdt_load()
can be migrated to use qcom_mdt_pas_load() for consistency and
improved abstraction.

As the remoteproc PAS driver (qcom_q6v5_pas) has already adopted the
PAS context-based approach, update it to use qcom_mdt_pas_load().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c  | 24 +++++-------------------
 drivers/soc/qcom/mdt_loader.c       | 32 ++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/mdt_loader.h | 10 ++++++++++
 3 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 729e7b9bc183..9feee2cb1883 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -239,15 +239,9 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 			return ret;
 		}
 
-		ret = qcom_mdt_pas_init(pas->dev, pas->dtb_firmware, pas->dtb_firmware_name,
-					pas->dtb_pas_id, pas->dtb_mem_phys,
-					pas->dtb_pas_ctx);
-		if (ret)
-			goto release_dtb_firmware;
-
-		ret = qcom_mdt_load_no_init(pas->dev, pas->dtb_firmware, pas->dtb_firmware_name,
-					    pas->dtb_mem_region, pas->dtb_mem_phys,
-					    pas->dtb_mem_size, &pas->dtb_mem_reloc);
+		ret = qcom_mdt_pas_load(pas->dtb_pas_ctx, pas->dtb_firmware,
+					pas->dtb_firmware_name, pas->dtb_mem_region,
+					&pas->dtb_mem_reloc);
 		if (ret)
 			goto release_dtb_metadata;
 	}
@@ -256,8 +250,6 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 
 release_dtb_metadata:
 	qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
-
-release_dtb_firmware:
 	release_firmware(pas->dtb_firmware);
 
 	return ret;
@@ -305,14 +297,8 @@ static int qcom_pas_start(struct rproc *rproc)
 		}
 	}
 
-	ret = qcom_mdt_pas_init(pas->dev, pas->firmware, rproc->firmware, pas->pas_id,
-				pas->mem_phys, pas->pas_ctx);
-	if (ret)
-		goto disable_px_supply;
-
-	ret = qcom_mdt_load_no_init(pas->dev, pas->firmware, rproc->firmware,
-				    pas->mem_region, pas->mem_phys, pas->mem_size,
-				    &pas->mem_reloc);
+	ret = qcom_mdt_pas_load(pas->pas_ctx, pas->firmware, rproc->firmware,
+				pas->mem_region, &pas->mem_reloc);
 	if (ret)
 		goto release_pas_metadata;
 
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index fe35038c5342..c868b9c416e6 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -486,5 +486,37 @@ int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_load_no_init);
 
+/**
+ * qcom_mdt_pas_load - Loads and authenticates the metadata of the firmware
+ * (typically contained in the .mdt file), followed by loading the actual
+ * firmware segments (e.g., .bXX files). Authentication of the segments done
+ * by a separate call.
+ *
+ * The PAS context must be initialized using qcom_scm_pas_context_init()
+ * prior to invoking this function.
+ *
+ * @ctx:        Pointer to the PAS (Peripheral Authentication Service) context
+ * @fw:         Firmware object representing the .mdt file
+ * @firmware:   Name of the firmware used to construct segment file names
+ * @mem_region: Memory region allocated for loading the firmware
+ * @reloc_base: Physical address adjusted after relocation
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
+		      const char *firmware, void *mem_region, phys_addr_t *reloc_base)
+{
+	int ret;
+
+	ret = qcom_mdt_pas_init(ctx->dev, fw, firmware, ctx->pas_id, ctx->mem_phys,
+				ctx);
+	if (ret)
+		return ret;
+
+	return __qcom_mdt_load(ctx->dev, fw, firmware, mem_region, ctx->mem_phys,
+			       ctx->mem_size, reloc_base);
+}
+EXPORT_SYMBOL_GPL(qcom_mdt_pas_load);
+
 MODULE_DESCRIPTION("Firmware parser for Qualcomm MDT format");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
index 07c278841816..7d57746fbbfa 100644
--- a/include/linux/soc/qcom/mdt_loader.h
+++ b/include/linux/soc/qcom/mdt_loader.h
@@ -23,6 +23,9 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		  phys_addr_t mem_phys, size_t mem_size,
 		  phys_addr_t *reloc_base);
 
+int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
+		      const char *firmware, void *mem_region, phys_addr_t *reloc_base);
+
 int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
 			  const char *fw_name, void *mem_region,
 			  phys_addr_t mem_phys, size_t mem_size,
@@ -52,6 +55,13 @@ static inline int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	return -ENODEV;
 }
 
+static inline int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx,
+				    const struct firmware *fw, const char *firmware,
+				    void *mem_region, phys_addr_t *reloc_base)
+{
+	return -ENODEV;
+}
+
 static inline int qcom_mdt_load_no_init(struct device *dev,
 					const struct firmware *fw,
 					const char *fw_name, void *mem_region,

-- 
2.50.1


