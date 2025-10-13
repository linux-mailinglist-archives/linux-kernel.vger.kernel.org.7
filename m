Return-Path: <linux-kernel+bounces-850301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0FFBD2734
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E07E84F014F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359FB2FE06E;
	Mon, 13 Oct 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OyCPyBRf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DF2FF65D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349847; cv=none; b=K4LtgEGEvmARPx+9PhdC0KWLI7+wuO6alb0qS/eIwBSAtm7vqR05O/w5FaDBeOSg8unks+bWBREG8UEjvSdBYQ48R8XRUA3Cr6/v0snqhvslxJvPoknypSOrmZV9xtT3NYs50qahyaoHf9mfTe+4Sn14CMbgITucrOdeaFyjtK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349847; c=relaxed/simple;
	bh=Icpkan34cU9+IqUCWwoIEvjWttbgIEHHCj+zspriR4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gj9LEkd7VEi/iYA6tc1OVQbOppwxKB5EDpovOWOkEqG4DOmE46hNi80emMeGRmGFUUR9X++/StAErWpdbMxZX3Ry/qCGd35Siafffq/vjmbTHRmEm2WLAXSqXFaKCfdt4yAv4dQj7FOGRGSWs8BpjxQdzK8V1zBGct3Bf34QKJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OyCPyBRf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2n603016551
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D+eo4qyKVLGcgAWX38pSnEzJgrOcwP93t2BBwbeh4iI=; b=OyCPyBRf3F4TLU+C
	N2J9E7p7v9OnfG0oaAOkjvq9exyL+Uk97CTRk7/ph3fL8Jy7SlOmK4FaMcQJ2Tr/
	wV9VlR0PYL+PsowC6nseLoEFaIr7iNZRdyWswAQqWVdiTHtNoWD3Wq4qeYaTeCxL
	jS4H9LtEf/He6lj36mtfGAXjyX6LGZ20wnckXrXAwt2y5+LMxTRolNGbNKB26ZHz
	MSRcJJNNM2tFyfRSrb02KmYFuwDI9c61JmXBx9bVqQfR7yH1NCq1c3Z5/VQ3L3VH
	RY3R8sERuspdXzZIdnOViB4MUOMTMsPMFHN/bomRE9d+pr/aSxpfJ7Lo6yhfgphm
	tnKN6w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbhv66v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:04 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78105c10afdso6957950b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349843; x=1760954643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+eo4qyKVLGcgAWX38pSnEzJgrOcwP93t2BBwbeh4iI=;
        b=tM3wgK8SAkJqib5X9H2eDakkhW/VTm62CUAQFXPLtqQ70gOG1Oq74LXjuk2f1qh1b0
         Zi5fGbgP/yxJ8OZwdreqymtptuOXPc03rhvya77l7rlxpiFIJLI7HzLk80R7+oVxX0JX
         WxgvuG5XW4RL9fRq1UQk0Ri5iIZTxrkkaJMafrTRCgusfZX4AmzN8i0R8Uder/7gbNfC
         gZ9id6aJ7bj+OidCix8fQOxSoUWA8XXXU6TcEiy1Kzy84U54VmIraAHW8lZYeh6UCprx
         Wtppf0onVrpyvN8rMC6w5PD0fg81HIsUdUOZ9GHL6H9AGQ8BnKMfAakksUwyfWpkxbet
         1IgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOWjIeXI4cbmbVOMCPNdfoh9SX5fcMAT8bPB/zHfLRM2pn1axL9jZ0q1CyQie9tNrMpXM411rfhA6IWsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdBu2UfbE7qmbVvQPcL8bJ6JMb+ocVv8NtKId/iDrk2R8ISmcj
	ly/yum5PZIY/1/5b7WbZT6wAZmhWVW4meyJH3iAtjcD7WvuB28DwC+OZqUKJVo1By/Ti8s6CFml
	c+nESLMDbkiQLcd3aP3of/Rf5pN7X3tZbsf/qIaUSXDrlNS22bIKbCAhozYJx2fUEUNE=
X-Gm-Gg: ASbGnctxvBoPWnjuAjxaUWh+4gXpngLS/P5BNvraEIszqW5pbpYJ8jVQjdBxwrOYwxj
	nCl/J4zQvR03xrYQnm5z6JOQetDmfeNks6uFl344nBjFNBWiPupPNl3+uoqMVHJMh6ha00/V+w0
	V4SYRSHXJAVcUwm83UgvyiYuVoJyx3TSS2lwUGVdHc+mult6j3BSGxZVzTUSevZIFg4UaBTpZeC
	UaSK/ndcwwSzN7HO69XZMi2H3kdazfAMNmCE1d3RF9YBJrtlQzhK6aSonL1btuMtoIMbZEqqt/9
	MV5j3G6vM+FiEiE/9LLSS8YrXjTjpBDBbimt664ZNnjLtaNwSmwgV9DoiL2TjO/s7bk=
X-Received: by 2002:a05:6a00:2ea1:b0:781:2272:b704 with SMTP id d2e1a72fcca58-793853260damr25668158b3a.5.1760349842774;
        Mon, 13 Oct 2025 03:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6i6nuGn+P1BIm9lbVj7yDxa2McgSYNKD7vdGfdIn/WKRA32N3oYYdTDrYQP/v1UbanNveRQ==
X-Received: by 2002:a05:6a00:2ea1:b0:781:2272:b704 with SMTP id d2e1a72fcca58-793853260damr25668110b3a.5.1760349842149;
        Mon, 13 Oct 2025 03:04:02 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm10981657b3a.69.2025.10.13.03.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:04:01 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 15:33:09 +0530
Subject: [PATCH v5 05/13] soc: qcom: mdtloader: Add PAS context aware
 qcom_mdt_pas_load() function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kvm_rprocv5-v5-5-d609ed766061@oss.qualcomm.com>
References: <20251013-kvm_rprocv5-v5-0-d609ed766061@oss.qualcomm.com>
In-Reply-To: <20251013-kvm_rprocv5-v5-0-d609ed766061@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760349819; l=5658;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=Icpkan34cU9+IqUCWwoIEvjWttbgIEHHCj+zspriR4Q=;
 b=ZtKuOgxV5LquwO4E4dWmMzbw3ZqqnB4suE2tk30MOgMLrAucjqhXcqN4uQ7N+12+ZpOAkDRhv
 xXyFebE4QvVD85a0bQPdltgLlDGEM29ANWqNzN+iHdeNMwZQyXe8DiL
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX9VlK87D/FqON
 ZF2uegKAIaObTA3EsyKH2uiN5u/5dBh+eBbVOdCMZLHEvBjH5NncoyOK0FvYcU4oi4bDKMjXaJF
 by8nxXYPVAbe4SRpo5c4ulOf3wAkBMbN9dmHcEgESyI7KEznKZAsfp+vUiejKfUcE45UzwLUlKZ
 Doyfi05Q+i4mM6qmBNZgRKerf0c7TWbqofXMzBl54eUgAczJoN7U5Jo88OWtL0yjEm732M27Y5w
 ZgExZTzH8sS3sSRyuq52D0SG+Qv9um4rKpb3SkY5KM20dsVbSjfJUrFe0wZoz+RJL5Gx1/qG/p6
 AY/RMtpsEr6+JgF4vGhgoqm927rqxzoXCfSyZJ7wL4rLPiHuH7vzN0H7g8FtfGTDwaOi1C4jaNk
 8CWFF1zKuz1jHljcPg67M8TuJ5jhyw==
X-Proofpoint-ORIG-GUID: 8mfAsDDxP8TPtxlShH6Kx4j_2L9kDflA
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ecce94 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=tZ3jCLSBV7jl1JjQXpgA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 8mfAsDDxP8TPtxlShH6Kx4j_2L9kDflA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

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
index e9dcab94ea0c..ee0ea35803c6 100644
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
index fe35038c5342..52de8adcc4f2 100644
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
+				ctx->metadata);
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


