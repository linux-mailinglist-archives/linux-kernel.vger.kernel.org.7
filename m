Return-Path: <linux-kernel+bounces-850306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AC5BD2761
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 411D44F1416
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40802FFFAA;
	Mon, 13 Oct 2025 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ye8wI1K0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7262FFF85
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349866; cv=none; b=Y3Hpp5/F0GXXXdpHqMpG8OtQrkv/jfVe0Xn7x7WZ7c826+Ap8gXIFQBzUUxspjf7PZuTSyDsHdyAzbWYLcazryd+r22oH2NIuYgwt2gt1Z+xL7/TAhjxhMuuuClBJZWpOTft3a68ugwYRYvRPX9F0H/rwyddbgkc1H1JCj9uGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349866; c=relaxed/simple;
	bh=kjVtxPzOLRGso0vU4B54+Y59E8Vnf+0HG+doVeMZVso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKGWiqbW2isYwENJ2H4Ay//puSOV+QE7Gvoo2whtKlGuqsQXiqygufwYK8Mvurj03rIUG2VOnuFJFRnLs6ywhKaP/M2UEsfAgnGMi4kwdnTRlIs6/9vL3RviF05ZpoId4Dl+O1Pp6xxSAO9Hw+2MVJUaYSz0v/1iOdm43fmWllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ye8wI1K0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nDos017649
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4vXzbLO78rcO3xwVrwxMmm/zZa8//7g8fOD3hfG1jyQ=; b=Ye8wI1K0LbtlQMSJ
	JYJjQMgwrQFXRMu3gjUiqXBhP8FKbIQmtTd6xV/5TpmeqvSEpRHLj0tSr2yZP4AR
	XgWnMOkm9Fxl5Ru6yu5UR5qFYrK2iJg/58GLB4LmhF3OzTfGyM9137EAFqWfw1x9
	lM5CgFYhK34j2QsV/4eoKJv54WqPGSoBiR0KpVPNVFEm/3WMjElKFk+e6QVn/+MX
	uNF97QyeMRcTjIepxE5NSl9WgjCJhkSmWVddXmqKu8z46rX7Db5Ko1v5cRKQgPDV
	QSid46gdKAKZMq7son783JPHUbIRaIe+KNudUqdTvff0bHcMKw6I7ZLVfdHPnA16
	AVJtlw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdk45g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:23 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c72281674so6033900a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349862; x=1760954662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vXzbLO78rcO3xwVrwxMmm/zZa8//7g8fOD3hfG1jyQ=;
        b=VJuBRpt0KwA+ioSEj5njIhB4rKu3i6Cii8GUTUWEsCFG62QGFZ+vWN85qHXxi2XoMf
         EGn5AQRQJhfi7l24lmi7BVhQsoIuK+HtRUL9NmLAH27nIvd+kak4VYu0d1X/7QnPhfgj
         c4+gRfP5w1q1qVIrPNW31N4k3MDYX6lM1nXSq1aa8z1/CSK3XwnnGXlMDiChlIRQD56Q
         FuG7uqfvjXWp6vo5hfY4NPomGxaEtc4TLKBo20RIQ0D2s/rbfHXppwTzVM0yyi25G53J
         tJk8Lt4Xr31Pb3eC4a6GdmeK0XttfSpFCNNaMIWmtJl2vbUcl7No6SagWIHLgj8IBNse
         JKzw==
X-Forwarded-Encrypted: i=1; AJvYcCWqFASXkYMJyHKPJRXfU3GUOtZlYzkkyQrdMW2dfN3x/wYMP1gB2t1vnTLjIb2zGyNizUXh3Drksi1aywI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzicmJ6WKsO55FVSv3M4/npfduWKlMHEaOSOcGccXj6AdBK7gLB
	+uLLJKWdvrAWhFVSWnzWm26xoXu0nLRSs3rFhLbu+NfNoYwCIzq25sVgXEaaJFmCdRxvZLwSwZd
	TLHEAPP2KyI1DI0KJmuVmKSVXykegt1m+lRgV8OhHgyT/4XCmFRCkd8Z/0G6koppIdX4=
X-Gm-Gg: ASbGncs9AYFdaWbnIeijaRsVP00nga2QVSXBOYpCesm8LwwFknvtZRghlUCdVA9g7Ld
	Hb0ZCtwBmT1pkDEIL/rxfmHmdSFoZagZo/CZ5TH9rjqKU4IWelTrEz0zAUVujLhLBF1CgY16wtx
	zwM7TOyunLeP2IZ4Fx7drQeSLT7V9fxmNxJqisyLGfadNGws5StOPGDi0TrFx5YKqQJsVZUNODr
	helxXz9ctsRue0Sd+ts52Jt0Ht3kkU6KEXq27fyOB85I0Fu3w2aPnZwNNpYMim1KWcVTX0Z0UOw
	30iaTswB/YmrquH0PvkVbYI5cqiVGGNohaveE7+I5Wu76lkByihVB0W5qMEe9kjNDgs=
X-Received: by 2002:a05:6a20:728a:b0:2b5:9c2:c579 with SMTP id adf61e73a8af0-32da84ea53amr27494423637.54.1760349862086;
        Mon, 13 Oct 2025 03:04:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHjKF39GTVChZps/+nFfoBBBYbtFiqNHuQe7t5jZYmEFE9ZSrhGho/Fw/lVhgCuP4Uk1rn0g==
X-Received: by 2002:a05:6a20:728a:b0:2b5:9c2:c579 with SMTP id adf61e73a8af0-32da84ea53amr27494380637.54.1760349861449;
        Mon, 13 Oct 2025 03:04:21 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm10981657b3a.69.2025.10.13.03.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:04:21 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 15:33:14 +0530
Subject: [PATCH v5 10/13] firmware: qcom_scm: Add
 qcom_scm_pas_get_rsc_table() to get resource table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kvm_rprocv5-v5-10-d609ed766061@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760349819; l=9173;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=kjVtxPzOLRGso0vU4B54+Y59E8Vnf+0HG+doVeMZVso=;
 b=G8rTMN9ab6p0tHEKyArmHAsG/LwzwO3BPVqDgiBygQBu/g8lpf/wXbPUBbiJKe4eu11FfHsgQ
 kEPdGMSHjDnDuiwEkarFQ48xWHCafBuUI9CfS6jKvB/rqDeNHC0jdpZ
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-ORIG-GUID: 6nQFjyQVomjiK9sg8Zyic8NUJKuhT0Uq
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68eccea7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=KFEUUOXM5gBsW3BA6b4A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 6nQFjyQVomjiK9sg8Zyic8NUJKuhT0Uq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX9UE27qBhnaF/
 lrm4+T3P2kpyg8NXi8Iu8kKQrmeRvh0meSfHq1bYXnFUfoIASOQykwj5Sm7Y16/B5pxGCVc2lkk
 ZN/JHobmC8GMQKimuqc5jdAt6r8CGUayPHOrEZ8s+QubUAfNnWaCY/Bf8rRhWq14VW+30U6uNpc
 EeDh9taF7pAHskIfV+ETzNLepY8htvJ1mX9qJeALvmp1pBxdZYf6AjFrMmUjk1jBNaHR0aykRBO
 4KdA16IDSWqTaHdc/g9q/5BaXaxztdrP3zzJ8G5K17drF/GU4Rw0AomEswfd50AJ+IvH1fvggqp
 +8L9QwHeJx08soNHL60FSrBSndnbEbBLFcRZ23gdxpuVYrR+vSwfFdgYuETBPgE2x3wpiq7ylCn
 06j0fRpHHq5Opc5QGkf2sSb893P0/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Qualcomm remote processor may rely on Static and Dynamic resources for
it to be functional. Static resources are fixed like for example,
memory-mapped addresses required by the subsystem and dynamic
resources, such as shared memory in DDR etc., are determined at
runtime during the boot process.

For most of the Qualcomm SoCs, when run with Gunyah or older QHEE
hypervisor, all the resources whether it is static or dynamic, is
managed by the hypervisor. Dynamic resources if it is present for a
remote processor will always be coming from secure world via SMC call
while static resources may be present in remote processor firmware
binary or it may be coming qcom_scm_pas_get_rsc_table() SMC call along
with dynamic resources.

Some of the remote processor drivers, such as video, GPU, IPA, etc., do
not check whether resources are present in their remote processor
firmware binary. In such cases, the caller of this function should set
input_rt and input_rt_size as NULL and zero respectively. Remoteproc
framework has method to check whether firmware binary contain resources
or not and they should be pass resource table pointer to input_rt and
resource table size to input_rt_size and this will be forwarded to
TrustZone for authentication. TrustZone will then append the dynamic
resources and return the complete resource table in output_rt

More about documentation on resource table format can be found in
include/linux/remoteproc.h

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 157 +++++++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |   1 +
 include/linux/firmware/qcom/qcom_scm.h |   4 +
 3 files changed, 162 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index c545f7114237..3c554f3e8536 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -27,6 +27,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
+#include <linux/remoteproc.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
 
@@ -111,6 +112,10 @@ enum qcom_scm_qseecom_tz_cmd_info {
 	QSEECOM_TZ_CMD_INFO_VERSION		= 3,
 };
 
+enum qcom_scm_rsctable_resp_type {
+	RSCTABLE_BUFFER_NOT_SUFFICIENT		= 20,
+};
+
 #define QSEECOM_MAX_APP_NAME_SIZE		64
 #define SHMBRIDGE_RESULT_NOTSUPP		4
 
@@ -779,6 +784,158 @@ int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_pas_mem_setup);
 
+static int __qcom_scm_pas_get_rsc_table(u32 pas_id, void *input_rt, size_t input_rt_size,
+					void **output_rt, size_t *output_rt_size)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_GET_RSCTABLE,
+		.arginfo = QCOM_SCM_ARGS(5, QCOM_SCM_VAL, QCOM_SCM_RO, QCOM_SCM_VAL,
+					 QCOM_SCM_RW, QCOM_SCM_VAL),
+		.args[0] = pas_id,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	void *input_rt_buf, *output_rt_buf;
+	struct resource_table *rsc;
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_clk_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_bw_enable();
+	if (ret)
+		goto disable_clk;
+
+	/*
+	 * TrustZone can not accept buffer as NULL value as argument Hence,
+	 * we need to pass a input buffer indicating that subsystem firmware
+	 * does not have resource table by filling resource table structure.
+	 */
+	if (!input_rt)
+		input_rt_size = sizeof(*rsc);
+
+	input_rt_buf = qcom_tzmem_alloc(__scm->mempool, input_rt_size, GFP_KERNEL);
+	if (!input_rt_buf) {
+		ret = -ENOMEM;
+		goto disable_scm_bw;
+	}
+
+	if (!input_rt) {
+		rsc = input_rt_buf;
+		rsc->num = 0;
+	} else {
+		memcpy(input_rt_buf, input_rt, input_rt_size);
+	}
+
+	output_rt_buf = qcom_tzmem_alloc(__scm->mempool, *output_rt_size, GFP_KERNEL);
+	if (!output_rt_buf) {
+		ret = -ENOMEM;
+		goto free_input_rt_buf;
+	}
+
+	desc.args[1] = qcom_tzmem_to_phys(input_rt_buf);
+	desc.args[2] = input_rt_size;
+	desc.args[3] = qcom_tzmem_to_phys(output_rt_buf);
+	desc.args[4] = *output_rt_size;
+
+	/*
+	 * Whether SMC fail or pass, res.result[2] will hold actual resource table
+	 * size.
+	 *
+	 * if passed 'output_rt_size' buffer size is not sufficient to hold the
+	 * resource table TrustZone sends, response code in res.result[1] as
+	 * RSCTABLE_BUFFER_NOT_SUFFICIENT so that caller can retry this SMC call with
+	 * output_rt buffer with res.result[2] size.
+	 */
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	*output_rt_size = res.result[2];
+	if (!ret)
+		memcpy(*output_rt, output_rt_buf, *output_rt_size);
+
+	if (ret && res.result[1] == RSCTABLE_BUFFER_NOT_SUFFICIENT)
+		ret = -EAGAIN;
+
+	qcom_tzmem_free(output_rt_buf);
+
+free_input_rt_buf:
+	qcom_tzmem_free(input_rt_buf);
+
+disable_scm_bw:
+	qcom_scm_bw_disable();
+
+disable_clk:
+	qcom_scm_clk_disable();
+
+	return ret ? : res.result[0];
+}
+
+/**
+ * qcom_scm_pas_get_rsc_table() - Retrieve the resource table in passed output buffer
+ *				  for a given peripheral.
+ *
+ * Qualcomm remote processor may rely on both static and dynamic resources for
+ * its functionality. Static resources typically refer to memory-mapped addresses
+ * required by the subsystem and are often embedded within the firmware binary
+ * and dynamic resources, such as shared memory in DDR etc., are determined at
+ * runtime during the boot process.
+ *
+ * On Qualcomm Technologies devices, it's possible that static resources are not
+ * embedded in the firmware binary and instead are provided by TrustZone However,
+ * dynamic resources are always expected to come from TrustZone. This indicates
+ * that for Qualcomm devices, all resources (static and dynamic) will be provided
+ * by TrustZone via the SMC call.
+ *
+ * If the remote processor firmware binary does contain static resources, they
+ * should be passed in input_rt. These will be forwarded to TrustZone for
+ * authentication. TrustZone will then append the dynamic resources and return
+ * the complete resource table in output_rt.
+ *
+ * If the remote processor firmware binary does not include a resource table,
+ * the caller of this function should set input_rt as NULL and input_rt_size
+ * as zero respectively.
+ *
+ * More about documentation on resource table data structures can be found in
+ * include/linux/rsc_table.h
+ *
+ * @ctx:	    PAS context
+ * @pas_id:	    peripheral authentication service id
+ * @input_rt:       resource table buffer which is present in firmware binary
+ * @input_rt_size:  size of the resource table present in firmware binary
+ * @output_rt:	    buffer to which the both static and dynamic resources will
+ *		    be returned.
+ * @output_rt_size: TrustZone expects caller should pass worst case size for
+ *		    the output_rt.
+ *
+ * Return: 0 on success and nonzero on failure.
+ *
+ * Upon successful return, output_rt will have the resource table and output_rt_size
+ * will have actual resource table size,
+ */
+int qcom_scm_pas_get_rsc_table(struct qcom_scm_pas_context *ctx, void *input_rt,
+			       size_t input_rt_size, void **output_rt,
+			       size_t *output_rt_size)
+{
+	int ret;
+
+	do {
+		*output_rt = devm_kzalloc(ctx->dev, *output_rt_size, GFP_KERNEL);
+		if (!*output_rt)
+			return -ENOMEM;
+
+		ret = __qcom_scm_pas_get_rsc_table(ctx->pas_id, input_rt,
+						   input_rt_size, output_rt,
+						   output_rt_size);
+		if (ret)
+			devm_kfree(ctx->dev, *output_rt);
+
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_pas_get_rsc_table);
+
 /**
  * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware
  *				   and reset the remote processor
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index a56c8212cc0c..50d87c628d78 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -105,6 +105,7 @@ int qcom_scm_shm_bridge_enable(struct device *scm_dev);
 #define QCOM_SCM_PIL_PAS_SHUTDOWN	0x06
 #define QCOM_SCM_PIL_PAS_IS_SUPPORTED	0x07
 #define QCOM_SCM_PIL_PAS_MSS_RESET	0x0a
+#define QCOM_SCM_PIL_PAS_GET_RSCTABLE	0x21
 
 #define QCOM_SCM_SVC_IO			0x05
 #define QCOM_SCM_IO_READ		0x01
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 583490bcd38b..5cd9b2553cad 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -93,6 +93,10 @@ int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
 int qcom_scm_pas_auth_and_reset(u32 pas_id);
 int qcom_scm_pas_shutdown(u32 pas_id);
 bool qcom_scm_pas_supported(u32 pas_id);
+int qcom_scm_pas_get_rsc_table(struct qcom_scm_pas_context *ctx, void *input_rt,
+			       size_t input_rt_size, void **output_rt,
+			       size_t *output_rt_size);
+
 int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx);
 
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);

-- 
2.50.1


