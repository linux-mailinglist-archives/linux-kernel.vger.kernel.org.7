Return-Path: <linux-kernel+bounces-825859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3704B8CF85
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7220B460A02
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F2257829;
	Sat, 20 Sep 2025 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZQgfrjHd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D492459DC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397332; cv=none; b=COxYZSQ3Ow/pN7RtjcD66pWPFfcqYqWyzxI9mutP5B1HtA2ls+7SFxQRahM8wkggLZHOnofsr92Xs1NMFTaKuQLWt5SF1WMoigdiKn+AV33oZUE44/H+G381fFewxHWAqso6F/IdfLyh60ov4t96VYadHz7GdzcrcsPB71C7g2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397332; c=relaxed/simple;
	bh=3Gsa1ygLvfww6X1LDJZ5+cyiNGAfoG3HUC9QPJkbdQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PAdyQjVKPlibIFEAev+gsnCCprp3j5IahFcQoQTIU23QU7Szdy8gOJ/s5gRSG16SHbT2dftORAU72qhR1c3Vc5Lgq4DcAELtXT9CjdJEk946qioBPOW+hmuGVQojULCX+D5fs2Ax/bZX1Eqb7SvRzq0Wblr10HlQaIDe+reNvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZQgfrjHd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3QJnD019167
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bskQ4OXKVoPNLr7GyCp9XNvtiQakpOp32/gupE0+8EU=; b=ZQgfrjHdTv4ePWdm
	HvVYJWAjSYfvR3kKB4Dg4LEn5wtnX2O1irSXhx6r3u9SjZKD9e8goXbmKnEoVhVO
	W41PDx1n5k5Z1g942lecJTZIrM8ygayCwEVEzG0T2KWTdjKkZbltK5Q2KPNdGCQF
	kaBUYIb/Yrtuj7O5Mhj1FeNped9KxzcjMA5VYCfbIGB2ZQHGeDu5fTuM2UyOKAqv
	mNzMppLf4xZeUazvP11pLJ8xp8ASxkssYAtQoXt7fqB+bR4qQrVr3Ce0XOcqE+GX
	3vzSK2J+jfzFlAmWqbdtss6PUWoZF7Tr54pz20rvPx4/bOYdpTuwQOqH7cj+FFV7
	xrWS0w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mbv172g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:42:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77d19ec75bcso2818650b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758397327; x=1759002127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bskQ4OXKVoPNLr7GyCp9XNvtiQakpOp32/gupE0+8EU=;
        b=SHo4wRUbhvF1yzJtga9ElOwGYWELoAws1uJAdXFA1FDrbByF1B6UqCYF2r21bps5l3
         oMLAY3ns9jxGsBUP4EeFTh3KAUFzQ9KP4eouOqYU5MPAIYooY7aN1lqXsm75fHz5i9/B
         lJ5ww9SmmlfQgLReUo5qWtt5HVI8nrzqQZxl4UbR2itkfJf+6DNISpjCgImW6D61vo/E
         ETt7tKXsGLU1sxmmBpswbVjrTeh24tMxVLVg76gFLUoxPRNZYEPrBhBSkjDkpIJieek3
         xf8pbv2tv2b+KJ6QzEye8ARMkgwGRJjUBkTUrwVE5dlIjQ2PITQp3cY+tqbgBo11Hqp3
         m5QA==
X-Forwarded-Encrypted: i=1; AJvYcCVOmzAqwZaF24gwsvUeYBH+4i0zKEyrk5eiGDHh3Eo7z1JhrVOh41qFT6IkKo6S4/VxZREcsEGq72fSFIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAkcRVQw66CX+/Dxmv7OiVuHI0rzObqe1yHdA/AoNdiSk3wa00
	ANwrqR/Ob1Z2LHFnU6a+g5LuiRU5qRw4GVGRCX9NZySpdBPmaXxlD61E2Kq0ZdrlTDD/kuKTXxn
	Sp+RvAN80Bl+B8AAFwTzYWhal6ln/tV513q3jmoe7Z7T6xNjxwdzOw6J50iOXOwLxaLg=
X-Gm-Gg: ASbGncsdvaVewo5I6Nl6ALwupGlwRenoQc38jaFHy0q38Q0XWSxngcu5J7VGHk2M+8Q
	5yonwgdWkHFZyUA0c4n253dF/SvlNHwGJmwj4Wo4yhk863aLoUb8KWYWAO2qmDRxnFQLQlPSG3C
	jkZlB+3j2ZgIcbyzlTgKnRsoT7sJwNWVVK/Iia3HKuvPkmYQ7eHrTRhuqYPhV07/QykbILp7/TQ
	Dd1yLHnfQWVMzNBDli/9DDTK31W1VOmUvYhSX635d4D0ueoJXyH1ZvrLhzOEMUes+qmqhb4k0g8
	BzfJ4ZDXMPOSg5vYB1v79gA1UsFuGfTL5r7Oed352KUnO/l73doSTXl8NG1sLMoCwvk=
X-Received: by 2002:a05:6a00:4c9c:b0:77e:f6a5:aeac with SMTP id d2e1a72fcca58-77ef6a5af0emr5868363b3a.20.1758397327311;
        Sat, 20 Sep 2025 12:42:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa1tWWdHEt3dXgK2dUyS1TDb58uyb8uRpjBv4fiZKR/hkx55ViaZnbeL/P7TkY4ouuDeBoRg==
X-Received: by 2002:a05:6a00:4c9c:b0:77e:f6a5:aeac with SMTP id d2e1a72fcca58-77ef6a5af0emr5868342b3a.20.1758397326841;
        Sat, 20 Sep 2025 12:42:06 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2c8aa554sm143767b3a.34.2025.09.20.12.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 12:42:06 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 01:11:04 +0530
Subject: [PATCH v3 06/12] firmware: qcom_scm: Add a prep version of
 auth_and_reset function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250921-kvm_rproc_pas-v3-6-458f09647920@oss.qualcomm.com>
References: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
In-Reply-To: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758397299; l=4811;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=3Gsa1ygLvfww6X1LDJZ5+cyiNGAfoG3HUC9QPJkbdQk=;
 b=2s5fYo+BSjHmtETnuObTh0Ex2K8m0KsNEMHhUVzQGULNNH8NRRRpYsHacSRvb2ac/K/njPOra
 nUo/2LAuZ64B4FPEJ16+DBY4Qk7nBiOyAuAZxfrQcAAe2Rf7AiXYOLD
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=ZcAdNtVA c=1 sm=1 tr=0 ts=68cf0390 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=xhUff6YxzY9YBBblk4UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: T7zwuDjFCYjjp7ZwEQ1M9T9Op4hL1qEL
X-Proofpoint-GUID: T7zwuDjFCYjjp7ZwEQ1M9T9Op4hL1qEL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMSBTYWx0ZWRfX2n8PM1tp8BG6
 QXvtHLL0IvjxQIS+LrYWbB3NkmSBQmpjtnxzelzJ5JwN6WEgfp11M55HoDnTvP6m8IaqDIzERfA
 lADXQYmWcYtIvnk45WUFHACf8D3EWehetf7xeRqyRT0EztKb0My3/zgaxCUuyTmdtPKJKpJbq1l
 4HeVYQmyKfDEZGBx9vVsm+PUf6OkKkSF9ZwYDpytyFpcxQ56x+IiMXq8FgZYD5Ju9JMSLn77uZu
 9w5PPMv0X5FhxueowUoWCSRUsBOa1IG776peRX/7zCQQ0Ibs1DNe+iADWdxFxlBgZBl62vmoDiP
 juFSYQRRgwTTqnkpgJZ0cQt+4n2u6xQnNyyZYK7BQWDQlELMV1PgRUHMbkGDNaAjkzJoo98xJ2o
 OE1KiqUx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_07,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200031

Qualcomm SoCs running with QHEE (Qualcomm Hypervisor Execution
Environment—a library present in the Gunyah hypervisor) utilize the
Peripheral Authentication Service (PAS) from TrustZone (TZ) firmware to
securely authenticate and reset remote processors via a sequence of SMC
calls such as qcom_scm_pas_init_image(), qcom_scm_pas_mem_setup(), and
qcom_scm_pas_auth_and_reset().

For memory passed to Qualcomm TrustZone, it must either be part of a
pool registered with TZ or be directly registered via SHMbridge SMC
calls. When QHEE is present, PAS SMC calls from Linux running at EL1 are
trapped by QHEE (running at EL2), which then creates or retrieves memory
from the SHMbridge for both metadata and remoteproc carveout memory
before passing them to TZ. However, when the SoC runs with a
non-QHEE-based hypervisor, Linux must create the SHM bridge for both
metadata (before it is passed to TZ in qcom_scm_pas_init_image()) and
for remoteproc memory (before the call is made to TZ in
qcom_scm_pas_auth_and_reset()).

For auth_and_reset() call, first it need to register remoteproc carveout
memory with TZ via SHMbridge SMC call and then it can trigger
auth_and_reset SMC call and once the call returns, remoteproc carveout
memory can be deregisterd with TZ.

Add qcom_scm_pas_prepare_and_auth_reset() function which does prepare
the SHMbridge over carveout memory and call auth_and_reset SMC call.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 46 ++++++++++++++++++++++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h |  2 ++
 2 files changed, 48 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 917341308873..7a86b27ea666 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -790,6 +790,52 @@ int qcom_scm_pas_auth_and_reset(u32 pas_id)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
 
+/**
+ * qcom_scm_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the remote processor
+ *
+ * @ctx:	Context saved during call to qcom_scm_pas_ctx_init()
+ *
+ * This function performs the necessary steps to prepare a PAS subsystem,
+ * authenticate it using the provided metadata, and initiate a reset sequence.
+ *
+ * It should be used when Linux is in control setting up the IOMMU hardware
+ * for remote subsystem during secure firmware loading processes. The preparation
+ * step sets up a shmbridge over the firmware memory before TrustZone accesses the
+ * firmware memory region for authentication. The authentication step verifies
+ * the integrity and authenticity of the firmware or configuration using secure
+ * metadata. Finally, the reset step ensures the subsystem starts in a clean and
+ * sane state.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_ctx *ctx)
+{
+	u64 handle;
+	int ret;
+
+	if (!ctx->has_iommu)
+		return qcom_scm_pas_auth_and_reset(ctx->pas_id);
+
+	/*
+	 * When Linux running at EL1, Gunyah(EL2) traps auth_and_reset call and creates
+	 * shmbridge on remote subsystem memory region before it passes the call to
+	 * TrustZone to authenticate it while when Linux runs at EL2, it needs to create
+	 * shmbridge before this call goes to TrustZone.
+	 */
+	ret = qcom_tzmem_shm_bridge_create(ctx->mem_phys, ctx->mem_size, &handle);
+	if (ret) {
+		dev_err(__scm->dev, "Failed to create shmbridge ret=%d %u\n",
+			ret, ctx->pas_id);
+		return ret;
+	}
+
+	ret = qcom_scm_pas_auth_and_reset(ctx->pas_id);
+	qcom_tzmem_shm_bridge_delete(handle);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_pas_prepare_and_auth_reset);
+
 /**
  * qcom_scm_pas_shutdown() - Shut down the remote processor
  * @pas_id:	peripheral authentication service id
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 9ca3218f0948..1774584ff5e3 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -78,6 +78,7 @@ struct qcom_scm_pas_ctx {
 	phys_addr_t mem_phys;
 	size_t mem_size;
 	struct qcom_scm_pas_metadata *metadata;
+	bool has_iommu;
 };
 
 void *qcom_scm_pas_ctx_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
@@ -90,6 +91,7 @@ int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
 int qcom_scm_pas_auth_and_reset(u32 pas_id);
 int qcom_scm_pas_shutdown(u32 pas_id);
 bool qcom_scm_pas_supported(u32 pas_id);
+int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_ctx *ctx);
 
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);

-- 
2.50.1


