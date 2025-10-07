Return-Path: <linux-kernel+bounces-844539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CC0BC228E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C601B19A5249
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0212E973A;
	Tue,  7 Oct 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cQSHA6br"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C22E8E0B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855775; cv=none; b=S7W5siffL5W55HISIgsjHVsfcn1bXKMEpFEpkAZ2X6tjPaH/Z8C4EzwnptCjakU2LayPS3V7uC/ikCjcR6YZotLp6/q/7X4dFi/5RSrC5D9YxFnbBgy1aFrO/7RgyrfBP+R92rASBEse6JGvtgOZob6/8MuBI0MA9SyNGAzAKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855775; c=relaxed/simple;
	bh=DuE7Kv7QoXg4yMkqF0Nqit8g8P9JPMJqyoG4dmGRg68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GK+NskBeuU1ckJOwRfKCsiDRdjFrB2sd6Q8Ulmwfz1/QF1O0XMfmoaRW2JNuPU0wxu6OKPAZ4MNI1BsjGICWcC3YwlhLtn2rktoQ8U6dZsrOziGS08BbDBfRdHDpfL3EovLDlj29nxf0mdiyOx/J0ZY8O+57CHg/rhb4CF8sun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cQSHA6br; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597ETJqI001046
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 16:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hV48b0/pnp1fgCAZQFL7AP47khxuiCtxTkt4ytFyHa0=; b=cQSHA6brtoqoH13s
	opEJ8zis8P++TwKgQDN4tQzHoFfUbtw82nITMEvuM22yERYuR0JzBWBe3Qrb0K6W
	nm1VFiunCjCSt1ROJ12ug8upLBdeNf5KsJCVTnTFr9FLSHiOQINM30C/ucjA4BtV
	JsuGtXEoNGutxRh2kZZahP+NJFeXHPSFxArpMaX3s0RMWmqtf9fjwON0LXNj+pNc
	N7B2ZAxQYdiYbxFBj3U44KfCd8bIdGP9EKjA6p7zLFa0+cQNvBibUB4SJ1J8EkQI
	A+r2mgVVaTu57BeOWsylEafW2KXjm9JwXcFg2FQqZji2P2HbPzs/DoljkrLV7Aag
	BlryCg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgr0jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:49:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-277f0ea6ee6so83180565ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855767; x=1760460567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hV48b0/pnp1fgCAZQFL7AP47khxuiCtxTkt4ytFyHa0=;
        b=s6LBsbX3SNobyFeV89PqKzYAE8Z+oSQV8kcsIz9EK3VX2rkwzlUOp7zcDoZhO3YE/o
         pAzDl8t5HkIP4LGhs3cl+6DdmHbRJRLy0tntl07FffOtiUTG4WtOY13L2VZ8uByI704Y
         HJXjHkND1ILK8Ak23rBVyzr3dGofdKI5sZDWgQlXtSksPpHQ7xhiRvx0RnACb3G5Lxmy
         VPTh4dtt1k2p/3PgiddEfN2jS85I7CHMnhgmxBiqp0mzdBqawmvtnW9lxD5hrMf4SRiX
         QFH5qqPT3OxRdGod3IN6wYgZRhKgcHugd1cdEmKgFTHR8tvWzpV7xhrn6UwZT1dsfhk5
         GFXw==
X-Forwarded-Encrypted: i=1; AJvYcCXPgwRweGrq+4EbVwqJZsbymfaQvSB5Eq1oFt0T5f/KeRhN3uAN9tecI+LyGHrntCuZ87lLEghUX27Iz/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPqzEKzXucYOJJ68kxDUBwEtJplNpgq+BN5lDfrT1r9irDXZiU
	5ThgkZAlcxcqXV1sLq+YeHnXG7h+aX7k8KbdUad4WUav1Z9YsrVgdZ6GetFFQTG9RBG2/OcRKTq
	4B/bXSX9T1P6axMfACVfhslTkEy1Dm6PhVJ6yXkCupon0FhaplOIsLjizE6FqceYMUpo=
X-Gm-Gg: ASbGncuEVpPXBtj2E3vEq1WOitzVKA+3YDhnWxB44kGdjJ4PjVVhSPKfsachCC9VzOs
	BJIxO1ijMEV6e9kJKkzYLxMBdnC1TAcsl6Ih8OhB+DfYuAwOjTjVYqxlyPUDdlSLX4C5tVSheT5
	lnjBXqPCDmP6bjBeeK8BraNl2qj9sjrM0xBdSYGhHX5ub1BKZTBHLOQhKxLZGBmTVAiBL23rFZi
	B6zYjGYWt4nLiVOHaaHn7MX5FSdZoYL/fNLyOvbFPaaX4GK0aosAF2jpyXLaN7yBa7rZTaJRY9h
	G+R5Vc+E3b5uykK+YhqGoy8SwYc0UHlNBp8Xbq4AflCTnSMBmGXmWIhGuzrq3hO/JamG/mb/
X-Received: by 2002:a17:903:2342:b0:28d:1815:6382 with SMTP id d9443c01a7336-290272e3ed2mr5243085ad.46.1759855766863;
        Tue, 07 Oct 2025 09:49:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl/MugAOwY2ka+h2YJg4YokR09ybssyIndqquRHy+ALHQJCKwsSPnKO3Ej1DDvZbmJc9AP2Q==
X-Received: by 2002:a17:903:2342:b0:28d:1815:6382 with SMTP id d9443c01a7336-290272e3ed2mr5242725ad.46.1759855766216;
        Tue, 07 Oct 2025 09:49:26 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1261e2sm171990825ad.38.2025.10.07.09.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:49:25 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 07 Oct 2025 22:18:48 +0530
Subject: [PATCH v4 03/12] firmware: qcom_scm: Introduce PAS context
 initialization and destroy helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-kvm_rprocv4_next-20251007-v4-3-de841623af3c@oss.qualcomm.com>
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
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759855751; l=4540;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=DuE7Kv7QoXg4yMkqF0Nqit8g8P9JPMJqyoG4dmGRg68=;
 b=OzYrVBTuRvqiviPCxW5zFBaao6FEOlOeHLWkwFqRizDeD8rkXfu78xUqflIUQZC+Lo5hHs3V5
 szZEhCJSUoiCkD3LhzW9XLHYFDXtfQKC0lStzvgb4SUMAt6Qv9u9Qz5
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX6/P4KrJwQH9S
 fYF6XV+ciJfgIRhjqPoqz0FG0OL60Rip2H24zOUx/mXxdApJ3J+x0nLmr80PHwIVXbAqf+deF4R
 lhlRMAuGqMujrdWwv4avsgE1zi55FipqGUebbD0pYzwat1Xygtm5Iug4urq/94CzzbVl0XLHu1/
 F/ikWhUbR2JTLnY4zQuneozor1TMEfFWWRx1+apG+wHMElpqNOdqiVgjx15/Vbg+iEsZmw/Iu76
 vi/gfVi7bTTwfbzbzKAlJE4jqe1JFovzE6TMHcAFvXFJjNcuqnJaOiq4yDqgQcvV3dFi2kAMhNS
 twyKoP00+MazJDpvXwfsHiw3C/i0Vy4nb2XEkD85QK0lPbb1w0vj1ZxXa+1gC8b8woxCC6VJgaM
 wonbZonqa5FDdOfoTxpjZcMo+V+i/g==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e54498 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=-i9yLzQnIfY35_RK680A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: t83osR5Ac7OJp4CStwHAWjjGGvq0wI_G
X-Proofpoint-ORIG-GUID: t83osR5Ac7OJp4CStwHAWjjGGvq0wI_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

When the Peripheral Authentication Service (PAS) method runs on a SoC
where Linux operates at EL2 (i.e., without the Gunyah hypervisor), the
reset sequences are handled by TrustZone. In such cases, Linux must
perform additional steps before invoking PAS SMC calls, such as creating
a SHM bridge. Therefore, PAS SMC calls require awareness and handling of
these additional steps when Linux runs at EL2.

To support this, there is a need for a data structure that can be
initialized prior to invoking any SMC or MDT functions. This structure
allows those functions to determine whether they are operating in the
presence or absence of the Gunyah hypervisor and behave accordingly.

Currently, remoteproc and non-remoteproc subsystems use different
variants of the MDT loader helper API, primarily due to differences in
metadata context handling. Remoteproc subsystems retain the metadata
context until authentication and reset are completed, while
non-remoteproc subsystems (e.g., video, graphics, IPA, etc.) do not
retain the metadata context and can free it within the
qcom_scm_pas_init() call by passing a NULL context parameter and due to
these differences, it is not possible to extend metadata context
handling to support remoteproc and non remoteproc subsystem use PAS
operations, when Linux operates at EL2.

Add PAS context data structure and helper functions to initialize and
destroy it.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 54 ++++++++++++++++++++++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h | 11 +++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 3379607eaf94..b8ce4fc34dbe 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -558,6 +558,60 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
 		dev_err(__scm->dev, "failed to set download mode: %d\n", ret);
 }
 
+/**
+ * qcom_scm_pas_context_init() - Initialize peripheral authentication service
+ *				 context for a given peripheral and it can be
+ *				 destroyed with qcom_scm_pas_context_destroy()
+ *				 to release the context
+ *
+ * @dev:	  PAS firmware device
+ * @pas_id:	  peripheral authentication service id
+ * @mem_phys:	  Subsystem reserve memory start address
+ * @mem_size:	  Subsystem reserve memory size
+ *
+ * Upon successful, returns the PAS context or ERR_PTR() of the error otherwise.
+ */
+void *qcom_scm_pas_context_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
+				size_t mem_size)
+{
+	struct qcom_scm_pas_context *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->dev = dev;
+	ctx->pas_id = pas_id;
+	ctx->mem_phys = mem_phys;
+	ctx->mem_size = mem_size;
+
+	ctx->metadata = kzalloc(sizeof(*ctx->metadata), GFP_KERNEL);
+	if (!ctx->metadata) {
+		kfree(ctx);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return ctx;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_pas_context_init);
+
+/**
+ * qcom_scm_pas_context_destroy() - release PAS context
+ *
+ * @ctx:	PAS context
+ */
+void qcom_scm_pas_context_destroy(struct qcom_scm_pas_context *ctx)
+{
+	kfree(ctx->metadata);
+	ctx->metadata = NULL;
+	ctx->dev = NULL;
+	ctx->pas_id = 0;
+	ctx->mem_phys = 0;
+	ctx->mem_size = 0;
+	kfree(ctx);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_pas_context_destroy);
+
 /**
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index a13f703b16cd..e82fdc200df7 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -72,6 +72,17 @@ struct qcom_scm_pas_metadata {
 	ssize_t size;
 };
 
+struct qcom_scm_pas_context {
+	struct device *dev;
+	u32 pas_id;
+	phys_addr_t mem_phys;
+	size_t mem_size;
+	struct qcom_scm_pas_metadata *metadata;
+};
+
+void *qcom_scm_pas_context_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
+				size_t mem_size);
+void qcom_scm_pas_context_destroy(struct qcom_scm_pas_context *ctx);
 int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 			    struct qcom_scm_pas_metadata *ctx);
 void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);

-- 
2.50.1


