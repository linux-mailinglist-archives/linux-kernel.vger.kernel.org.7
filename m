Return-Path: <linux-kernel+bounces-850308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CF9BD2779
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C03B84F17A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D52FFFAD;
	Mon, 13 Oct 2025 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MU/T3Qoq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879362FF143
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349874; cv=none; b=S05E4aaTLgPCvAvuc1JRlivlYeP9snWuoTXAymYgJ5U3RXzi/kDk5crJc+UzXGilMIAf6psinYlVc+JRbdWhFeG+t5ZQO7Fwdakx75pST29n6SuAr4GUYJQBLUtfOvvWIz7LcJc1rdptC5zy9oJBYNDnY+THFMeky1MJPRE57yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349874; c=relaxed/simple;
	bh=PcSsVEiFPVw9Hj0r3Zaw0afL6D0XfXjGyZQnPsqQL+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYnLI9hy4ACi71IFEXW2jLZEExBwhRl1HZ0dRNBK26GsISeFeu7Q0pLgNCzlL9XfIZiqBJzgIowEc0aPXBErxMz1lsVsIA/+4BoF6u3xz3ou0KnVTHeK/QU8TfbPShtzW9pXQEbe6YmyvQJxuVF76b38zXUTbF3x5dywSU4zBOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MU/T3Qoq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D4pndc020626
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VW72Hhita1RvX2RpytT+dE+cfJmy3OUWo7tWQGrF+hw=; b=MU/T3QoqrCGdSodV
	PvHV3qzpsyviDxmMjAIXYkiK6KSDjc9FRZWcCruJyo76cQO1WR5XU5GnOWOOKhQG
	7nYdoMK8NVVCJhspYe43D8FGGE+gfammT1iknpH06Ts9uStBFTlLEGhFv0q9+1f+
	kHkxratoqFQVSD/4zMvdcGxFHTAT0jSlV+uWPatGV3xs2rSeZLSdWqvafvcn9Huk
	QsoLHy63xPduUD2b73F8umIxHjBffNRzRASmYAebvYWAgqoAcwE47xfVXBQ7G7AH
	TEOS9NvN7WvZypzcbSq1s8vPqEycJU+Coc7BIz9NeNOQMxvf6B732RC02lgMvYHc
	VD1iag==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt0x0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:31 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-780f9cc532bso6364897b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349870; x=1760954670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW72Hhita1RvX2RpytT+dE+cfJmy3OUWo7tWQGrF+hw=;
        b=wLkGRW1YoVuvGnbCeuVikFm7YOELnD/4GJMblVz2mwjU8eyj4wLFfu8ktoho7pFoQU
         wBmDohFj4lLvv2JR/vMFqB9vDJGeyZl+EztaZC9CZ64c3FbiEDCjfeTzRKzo0PloKkhF
         QRFiGAC3vZKndzrD6j5GWP607TqRlIbVsisy66DpejgoGnrhilOZsPDJ9na+7ECT3Y8+
         OmY2KcBagYL8Im82gPPakg6GQMukiqcSUJM9C3iXjzMWMGfuaX8q84YTVexLmFcr/XgZ
         B9jYBcp7md6QFyzv3csaWeER3jiuJBeUgnuTVYm4FsI0Obai1oJ6+uG0yTzdEpO6pnLx
         hifw==
X-Forwarded-Encrypted: i=1; AJvYcCWps/DJ/7FOHWBSDtmlAJj7TeOHRmiMdv5VzuLYicyUHSC/15JpXQXS6vvyyiWmSyEccDeXMF/EYe2WJ8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6BaMt/m4aKtAZvZhi8xuCtas65etuLsDoP+bdlh62Llifsn/A
	BWnRFR6dMhFcZmfIXQ1kOOKgZl8cByPCD5kspjsEM2sMt97qWgm+DfSg9LnSAlsD/12lIOSJg1o
	09syUuQxXvW0swJIyT1xGcr/HDskrQ+WMVl18wJtY7APp/B4Ni8Cs/39Eowj6o4DRZ/o=
X-Gm-Gg: ASbGncv1bj04daI8UGRnQnpjOgl9R16I2KFvRpBg6XvMLqLj0UOMLotUqb+CntP3V/T
	89X/c4dIkqkueqMJDalHOtwrUgt95woHxvOlyo3YFkIAxy+3GOwS6f9dTIN/X4974NUqjOuAFPq
	ahZnCPIGghR5KZpCKe0pTP05To0HXuhn4+xSa3cOITKj1WIE/4pN1b9G/ZSGcPoHTD8t4DInUiQ
	1KI+QkOsbbSsO9tT402GfaoryDJcsg1F/YZQk4P8/wMGkjIOqebI5D3pjVOHWx3sHQTczZgViYZ
	U7mYfRJeAHqQrZQn9lKzlmYEKsVPRKA0seEzoSYa9lrafd8bn3lU65Ggg1utUOl3Ldc=
X-Received: by 2002:a05:6a00:458e:b0:78a:f4e6:847f with SMTP id d2e1a72fcca58-79230180c61mr21203944b3a.6.1760349869874;
        Mon, 13 Oct 2025 03:04:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFad1TB12F2PhcVC27jV4wol0NLtuixAaJ/ctrcIrrqVLhF7KOFRVgYitTfFUThAa29ObwLcQ==
X-Received: by 2002:a05:6a00:458e:b0:78a:f4e6:847f with SMTP id d2e1a72fcca58-79230180c61mr21203908b3a.6.1760349869201;
        Mon, 13 Oct 2025 03:04:29 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm10981657b3a.69.2025.10.13.03.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:04:28 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 15:33:16 +0530
Subject: [PATCH v5 12/13] remoteproc: qcom: pas: Enable Secure PAS support
 with IOMMU managed by Linux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kvm_rprocv5-v5-12-d609ed766061@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760349819; l=5426;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=PcSsVEiFPVw9Hj0r3Zaw0afL6D0XfXjGyZQnPsqQL+Y=;
 b=VEE2BYLcu8TbQxvGq4rWG6hMg3/oKG9lDgZ6MHss0sFuIf3J2sQb1DU4f6YFimwo3QaNKc80S
 GbSXZxNuaT/CVZ4N8daulAepHLLeokIgThxWbFfP+I2kGIBfVeyPwwN
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-ORIG-GUID: gnm-5zsNj5hRaQkW1HIF3l9z6FX3hGYR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX921SRW9W6mU/
 cFfz7JVeZDkwrxVG9pB4hLVbjlAXEZsYMfG7otxZ0rqO4j6j6Hs2JojNZpQt5fp2b/iqzhXyaMn
 WB6KAXNlcfA8uPOYn1nFHg1Sd7CojkLLD3QHIunHTYEEeJVI1pSuNAk9Xg9HZ1gghmQWMln0Y5E
 SJsPs07G8eGlVMfWuSagkdEvgz5I051VIN8TtJSiL5J0lLjVxPwEbKVyR0NqlnAVYv9Ej56zIS/
 TqbMDI6YRXb3o88vSjPkRO1QVAB8iQGv9HPFNmODYQNAvzns3k22uDdw9N6JwBHUifu9Rp+G/sp
 9GAKWpe28cuzM0jFxfuv6X+VdmXPPG+FXkhgTP906LEUjBNLMM4PrbBZmjaXv98q+PbDnj1qTDr
 xOyD3BhtN1CCc0xibwjD+3TrLmHewQ==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ecceaf cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=58pnfTnN0ARRJNaB1lkA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: gnm-5zsNj5hRaQkW1HIF3l9z6FX3hGYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

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
 drivers/remoteproc/qcom_q6v5_pas.c | 48 ++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 1944df49893f..8c44987733ca 100644
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
@@ -256,6 +257,22 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
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
@@ -290,11 +307,15 @@ static int qcom_pas_start(struct rproc *rproc)
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
 
@@ -305,18 +326,22 @@ static int qcom_pas_start(struct rproc *rproc)
 
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
@@ -328,10 +353,16 @@ static int qcom_pas_start(struct rproc *rproc)
 
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
@@ -387,8 +418,12 @@ static int qcom_pas_stop(struct rproc *rproc)
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
@@ -758,6 +793,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	rproc->has_iommu = of_property_present(pdev->dev.of_node, "iommus");
 	rproc->auto_boot = desc->auto_boot;
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
@@ -836,6 +872,8 @@ static int qcom_pas_probe(struct platform_device *pdev)
 		goto remove_ssr_sysmon;
 	}
 
+	pas->pas_ctx->has_iommu = rproc->has_iommu;
+	pas->dtb_pas_ctx->has_iommu = rproc->has_iommu;
 	ret = rproc_add(rproc);
 	if (ret)
 		goto remove_ssr_sysmon;

-- 
2.50.1


