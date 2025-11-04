Return-Path: <linux-kernel+bounces-884225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598B0C2FACA
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1311C3B2EA0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B8B30BB8F;
	Tue,  4 Nov 2025 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mH8u2Deb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QSOwch4W"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7F3016E4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241803; cv=none; b=m8K6N1XCMt8umXhh++N8N9HAQWsw6hDy5RGKP0rpDMT3s9Ru4Q09YxpGasOTH9sqiTLskkcjxLyNdG5l9OqCINA6OGocbigpb6XguqPaHcsOQJWHvuf3A4FKYC8yZYHzqzgoU5zO0+jHlzNKRXIVBAvhGxSH6ZznE0yIgtQjmsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241803; c=relaxed/simple;
	bh=f7VXfKs4se9v8TY2Jj18kfT0kRZEWFOC/ZbGamMdPyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WXfspmlOf+K7Vsy2w3Cw2an6LoMlvOkKKnbV9wywH7BhF7IhDJBj/KHsAWF36nkM5wccbK7T/3l9oUPiC6PUy8CEiwYCMMU8MYRwDQQrSGeBzfqWGQyQj+m0aPUFLM5MsRr6+IyZ/YbPay88UsJhsAuC7H4fBrINXQWhD+heErk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mH8u2Deb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QSOwch4W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43aefg3846633
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 07:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u8fTGgl6J89LxhsYpqGgdlY6OnIJwv4clHy1l+1tA0c=; b=mH8u2Deb5UvvFkEK
	jK1hvA2jxW67WCsQ5HbUhzfEzLMr/kK6bZ/kT9QJ5DEIH6L0PnOiiYxYbeon3iuU
	k9ikqF5STHn2EKxZe5bnFulqtZeY+EDKvUbT4PBhVymKrJCCfAW0k/LttM8WJrIm
	scZDHb2b+xztO55aUBsDfUv6rzeNbnCQkSf9HlJk52Uh8n2MWbzz5XB5wQerIigl
	1BOFfycZnlvmK+yy870BXjWmTbUufgqokcrzMyCvHn4Z4ZSzvVKZVvM7XvzThxJR
	yqychzZ5PaZ4PZKpoidnS43U0kuaQDqjfz8yNxev1T4PkAB7Efec3Nkc7vBKEkzf
	MqBzZA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70f1j3af-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:36:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34029b3dbfeso6498723a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762241800; x=1762846600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8fTGgl6J89LxhsYpqGgdlY6OnIJwv4clHy1l+1tA0c=;
        b=QSOwch4Wc7jNY9/D0Qm5PqRT5BYm2sql1u5vZlbCK5LshksP+eY8PSfPozBodI/k2E
         ntlulBBASvXdi9PtUzoezwM495m0DONz52W5lGVCx7g4FaRE/LNea8+7ToSg7EQgGOU1
         7IWM3dgxSAX9TriKcm6VKyhoiaW6iU4FbpDBcGGtkgP0aJPIA7j4tixqYfoFdH4EHeGB
         eaFY1ObqyDMpsnFYB8OOeo/KLgmFRYeNp9NxHoi2jIc/Q9UyuASSWmLaHey817MZ0rY5
         EkVcCEvMLukSLKKR03YOCL6BqHZGNzPnREU8FMpdVOXLo8h524/1vvwDYuiwKxkkntFG
         4rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762241800; x=1762846600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8fTGgl6J89LxhsYpqGgdlY6OnIJwv4clHy1l+1tA0c=;
        b=JF96Do3YKj/I4qlxWwIyjdmlxFZ7MimE0bOirn0oXl4VGTR//KvwCh8OnFww/PIpyh
         cNqjNJPy5DToQUL2HIJ+YwxvgTnVvUC5916Ac2ab766/mfQJ8CjOPgSz0+mj8kspYALc
         ZmsksyolKQrkwElKyGqyWvQE1/6Khah2dnNQ7+a4uEIjVh4sXwDNnAGaOjakTR0Y2c4p
         MDoPeQJ8kaNs9b3UwuFpb/CVy5sU5jcl8zw24xcz88jgF5Lz6aTYkLP5RoQf9jdDHd2p
         D0yVabo42TRJgfaMZuLf1HALSwJDFGQ4EOSAwhkp1LVGi1hpKp8CBXt30678yKI5ggtQ
         fySA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Nq2OrEWjmWz8aZAowPcpSO+pgy07grCB1NghsLKUn8KZplJVC3wrz+3TWOZK5EINb3B0sN6Ex+Aw2os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2WnV6PF768JeHLDvI3Ub5709WkZW5JhTUE/A4kp23eMKx/yVL
	kR0SySI9MB6uCvttll16I4jz/jOacT3ZeAoatbmTZ6ZNfFMnAeWNUUQES6mQL7IV5t64Y3PjhgU
	C3cJUV3T7w/jw6XyikGdE84vwetsD8/+fGNdzcaQMZNiSvyBzlTZifaFq03GjazB3iA8=
X-Gm-Gg: ASbGncsPCWNpKaemaJAGwqDP+oaeVaWIlnMBgRrE5jxD/GhpxdAMOYNslCfbMGgIisv
	TKgiyAPB2OVsERHKrB0WM6FzVP4nFso71+5ynw4QzL1CDdFHjAekK07yFbQqYZqumyoiTww6pbl
	3/441ZZXw5CJ6+NOty8TazmVaSHfDqwo+IdkSWA7w/9uRx6HA0hUMRtq70TSo2ajC/rIMrqNGC4
	nyUJRzPBi/fPvVfox8imQUvJJ4kPhxs+puHigPJpEnUrH0y34OJ4Wzudtr/mPNf+pr+7kXV/XTu
	BVf4I/P4lh6Sn3iG0yPZnJ76+EAEB1RNyRyOFpDGbt0Mccit7i3P2Ty0sGgPF02Ym3EqIgqllac
	AzVCQgpY8q8+GNODUZwu4dSj6UA==
X-Received: by 2002:a17:90b:2789:b0:341:88ba:bdda with SMTP id 98e67ed59e1d1-34188babf0emr578034a91.31.1762241799762;
        Mon, 03 Nov 2025 23:36:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyebbjIzDryaQRpDZJO+LTJ16iG+lKvxXXGziZyVCKMfstPlAHg2easMtTJQXVyofBYcO2LQ==
X-Received: by 2002:a17:90b:2789:b0:341:88ba:bdda with SMTP id 98e67ed59e1d1-34188babf0emr577987a91.31.1762241799006;
        Mon, 03 Nov 2025 23:36:39 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cfcsm3484367a91.19.2025.11.03.23.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:36:38 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 13:05:48 +0530
Subject: [PATCH v6 08/14] firmware: qcom_scm: Add a prep version of
 auth_and_reset function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kvm_rproc_v6-v6-8-7017b0adc24e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762241765; l=4512;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=f7VXfKs4se9v8TY2Jj18kfT0kRZEWFOC/ZbGamMdPyQ=;
 b=XBh4X15hxAfOK2LhgsfA//Vzq1ZgSEXmYNkLwsE4R2bb3G3eByKdNddJDYQKp/zYnZKuE0GN3
 GiSdvHEXbnTAJovzlBeBVkBeo85kBtdFfYBtgZw2iJTbzLVmaXuARzG
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=JLQ2csKb c=1 sm=1 tr=0 ts=6909ad09 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XGel9bHSJmg9pP0w-tEA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2MSBTYWx0ZWRfXyC5Ugcqil3Ev
 zRqtSDuWoJwXyR/yhCoMfSQ4S9fLLwIiBDEAT885SBPuac8hrRYHafhy4QqXt8qwDW0sGlaeGAy
 drNGAeaRFdzSQV9u+mDy7+zzdIvpBtawmo2rwRUCK5QX5Vx3d/1A5yzYbjvYSWSIjbWgdvP6evJ
 Cmc5Tm1YVZeVe2Tjgra3pLc3Tfzo7IlTo1P3SOvmQp4mw8Jx53DtxhTtFd+y31Eh7QdjhPBwl+f
 nla8416Dgg/jfGrGCzbS7dSsCRVi08ehF4JIxxCDD1l815Dg9YvNdamUTRx3B4+V/gWeEYd1+F2
 aug7M51Ibh2syC9+JXFSf8gdGw1aJgGSmfuxTpuCP0XcsuQpLX6sMiUwBF6KpMj9ObYIjswaomf
 sBoWDakWYnah7qrcf5AT4ZfYsshqAQ==
X-Proofpoint-ORIG-GUID: YgrObQdHObMzCTXz7xFQGlcoysHHTC6O
X-Proofpoint-GUID: YgrObQdHObMzCTXz7xFQGlcoysHHTC6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040061

For memory passed to TrustZone (TZ), it must either be part of a pool
registered with TZ or explicitly registered via SHMbridge SMC calls.
When Gunyah hypervisor is present, PAS SMC calls from Linux running at
EL1 are trapped by Gunyah running @ EL2, which handles SHMbridge
creation for both metadata and remoteproc carveout memory before
invoking the calls to TZ.

On SoCs running with a non-Gunyah-based hypervisor, Linux must take
responsibility for creating the SHM bridge before invoking PAS SMC
calls. For the auth_and_reset() call, the remoteproc carveout memory
must first be registered with TZ via a SHMbridge SMC call and once
authentication and reset are complete, the SHMbridge memory can be
deregistered.

Introduce qcom_scm_pas_prepare_and_auth_reset(), which sets up the SHM
bridge over the remoteproc carveout memory when Linux operates at EL2.
This behavior is indicated by a new field added to the PAS context data
structure. The function then invokes the auth_and_reset SMC call.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 48 ++++++++++++++++++++++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 9cdd152da592..283e6cff550b 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -772,6 +772,54 @@ int qcom_scm_pas_auth_and_reset(u32 pas_id)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
 
+/**
+ * qcom_scm_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
+ *					   remote processor
+ *
+ * @ctx:	Context saved during call to qcom_scm_pas_context_init()
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
+int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx)
+{
+	u64 handle;
+	int ret;
+
+	if (!ctx->has_iommu)
+		return qcom_scm_pas_auth_and_reset(ctx->pas_id);
+
+	/*
+	 * When Linux running @ EL1, Gunyah hypervisor running @ EL2 traps the
+	 * auth_and_reset call and create an shmbridge on the remote subsystem
+	 * memory region and then invokes a call to TrustZone to authenticate.
+	 * When Linux runs @ EL2 Linux must create the shmbridge itself and then
+	 * subsequently call TrustZone for authenticate and reset.
+	 */
+	ret = qcom_tzmem_shm_bridge_create(ctx->mem_phys, ctx->mem_size, &handle);
+	if (ret) {
+		dev_err(__scm->dev, "Failed to create shmbridge for PAS ID (%u): %d\n",
+			ctx->pas_id, ret);
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
index 2905587dcd17..345ddcd53b42 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -78,6 +78,7 @@ struct qcom_scm_pas_context {
 	phys_addr_t mem_phys;
 	size_t mem_size;
 	struct qcom_scm_pas_metadata *metadata;
+	bool has_iommu;
 };
 
 void *devm_qcom_scm_pas_context_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
@@ -89,6 +90,7 @@ int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
 int qcom_scm_pas_auth_and_reset(u32 pas_id);
 int qcom_scm_pas_shutdown(u32 pas_id);
 bool qcom_scm_pas_supported(u32 pas_id);
+int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx);
 
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);

-- 
2.50.1


