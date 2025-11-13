Return-Path: <linux-kernel+bounces-899149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348EFC56F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFE23BB4FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074D33555C;
	Thu, 13 Nov 2025 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZXz614r3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BgO5mf5e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAFF33A02D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030213; cv=none; b=Q+Q4yZ1ow9AL+Hvyh+EtffGYu0SWg8Yy/2yXJXA4977iej7crzXs3odzNOQ44lDfT1JLasfN1vp0AvZHqIimlOQfUF3hEGWCBRw5YpNmsOLljOKlPFinertsAEWihISvts/K02NE68Yp0/w+n26DGp6MiJ18Z7hr0pz8RCNRNts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030213; c=relaxed/simple;
	bh=djomGe7rq3iTFxovMJE0vHDodzk7Kxb/jVnEstLyEoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sXM1HiyN8MTy3WpFVa0UJUnIxuc5xo4Io0S4Gs3Fe/CMte5AYCEJUkv5K8/UOGBlTIiXpxb0AezETRWvfiTsOCDveW1yKbdrfGXCgCWxO02gLenwBYkxPJtFmOMqJOxWzcSFeySsTicv1J85XhIHxAjQjUXJ+XXnCCjYHFLEJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZXz614r3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BgO5mf5e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD65gJ53563291
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C9WCKwTbuAdm6P15kNxE8kItfpAlknREEeI4Awhab2s=; b=ZXz614r3wYirWTep
	ZQHxBp3oiRzYryag2eKKx6KveAM+72J55+LtfKroonCDewedzYpis7FwCjyyuaXg
	AqVQS9j8SS/87PkEn4oDpSvAc/1Olft0U82F0gbgfm9nrJvheTTwlWp7Hs4A0eY3
	nCSveZndDZObM4bBjwOrTxBjLZR9v0ZTEuk93LKCWruS0Taqrbd1HeMF12Rg+kar
	S7Ld8HFlfs7R4fvbK+KY3CY5kVhh4ATIU3gGjnLBELJqtBWv+hZ6PMmeAW1Da8yv
	PyCvsIACv4F2Q/zf8iI1ZK6pwSDwxmkXXLYjFgY7R9YMH6FsazyM7bgf5HXnPLEN
	+NnAag==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad9rvgtuc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:51 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so568057a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763030210; x=1763635010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9WCKwTbuAdm6P15kNxE8kItfpAlknREEeI4Awhab2s=;
        b=BgO5mf5e5y9JIPbj15QVT+VTPUdzIhwHcp9rrgOTOvRTMpDg5adzeHO76PQ5D2VXUh
         MWQMaoERU9iBAV48HS4CHqRk1E0aG3DKuiEvhlLBrhR4qnUCRrfSyn2rFAp44Mo122PV
         RBwrA/eE8Swgko+1OZGSCCudahU2Izhr4I1pHAXzI0FEVdThkCc1YgKdpeLfbF0klq6l
         NymlwHfehsxMzCSJuEx1WxPkDtB6nccxGBOOr/gmyJp1IvGn6umOp9FsRblLFvhk0J5D
         gL7ejc1umhkyhfkZtIXM+WoFFGgvpYaD3swOwzFYRHCrfqLJF31c/8nfyGpLqq3UbO3W
         y12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030210; x=1763635010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C9WCKwTbuAdm6P15kNxE8kItfpAlknREEeI4Awhab2s=;
        b=AWEYwxl8JYBaVg/yCH33v98DW3b+YdNiHfUJlQ1TcGN9Zs/NPfWIHg9BFp62Tkb4cc
         BI3oNcNgHjp2Euh5gpkuJwWmn6fbe2itBzC2F8zfd49nW+H2Ojr9m/xtD4evb/QNa1NS
         S2g7ArZgP7zVG/v9PXvYHNSnNPDdwx7K/3kyAWD4RuulmuILyd8vUrhVbohCOwBAqqQn
         Te1pXYP2NIlZ0K0HMIIgB5Rwam/Ifq8+uT7yGIwupcO29JcEmbWV5v56YG9KqSG32Qc6
         SzSNKf8P4sQHW7Aaby24hnTOUofwtUFd6pepXntKg+kzUXc3xk3qt8Ek9zl09X8sAKhe
         EhAw==
X-Forwarded-Encrypted: i=1; AJvYcCU/2xZbrvyjNNg/JABm9lAir5n/lJMIVT/UFXOT17omFyxn0Ruh2vYexUCTEIpknMhDAvsJhC+LOZ7CwnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8lGJbGNHdwx2KDp18764jPb3vfFVv4P2GuH49wGW3m9KlBzOD
	2QQ6pbPXrhKKsHpsu1pNLVi1O1vyOiKE2zxobHJypgDpbNYEboBx8aePNB/EK9A6UT7NyhYvc7o
	keWVa7nXDpWYg8QHOkxI0PdGRJREsz+x+Lloh5tuFt4Jl03c7R11dYxgrkiTehNdwRzw=
X-Gm-Gg: ASbGncsm6US4aEHT53xT1NVTP+GUJdB/xZyx7ckpWd8GvhLSYgZ7mjCz8LNU0Yd8W7j
	+btJI9Afvw3T1pDjDNjrY4evyn47HDRghej+2ybojghvcHdbAr0tty2maNfLcwDKnBp3263etm2
	c25aFNQeFvrqIYdevo3toQMdmuM9cMSA4GGkBTFksLNVMx2MCpvvpqvhoXuxOOsD3LKFG4MUkRS
	QlLIg4m8C9VO8aynuOG1U/C6XwSgzKAQmtpNeInIlRYAllxc8MQfSVoQzY+RHk2A+BGxYtQCj4n
	7l7J4ynu2xJb4rP1xO6OP91utU76Ec0c51Up9InfEIsyPlsjkfLUPFO0F5p4eJgfonlg4+IlXDQ
	IlQV2JZ/WjOI4Jksj/HemBdAmug==
X-Received: by 2002:a05:6a20:3d07:b0:342:1265:158f with SMTP id adf61e73a8af0-3590b51e999mr8810049637.51.1763030210198;
        Thu, 13 Nov 2025 02:36:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOoEsGUkKs8KZ9AdnKukZ0rvPwRIAO6ZSx89TxXB2N4KAn2xfBBrzm+7GlMbpZpn4Ka2Bz2g==
X-Received: by 2002:a05:6a20:3d07:b0:342:1265:158f with SMTP id adf61e73a8af0-3590b51e999mr8810005637.51.1763030209465;
        Thu, 13 Nov 2025 02:36:49 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d2d16sm1886922b3a.22.2025.11.13.02.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:36:49 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 16:06:01 +0530
Subject: [PATCH v7 11/14] firmware: qcom_scm: Add
 qcom_scm_pas_get_rsc_table() to get resource table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-kvm-rproc-v7-v7-11-df4910b7c20a@oss.qualcomm.com>
References: <20251113-kvm-rproc-v7-v7-0-df4910b7c20a@oss.qualcomm.com>
In-Reply-To: <20251113-kvm-rproc-v7-v7-0-df4910b7c20a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763030164; l=9189;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=djomGe7rq3iTFxovMJE0vHDodzk7Kxb/jVnEstLyEoE=;
 b=2yNfcdo7Bk7m3xYLd89AOeiFfCnsDfEtVQXfhjNIunjbVpC76x+YU6eyPXHI28uTSb5Uo1WTi
 0HXXEh7BQsFD9KsJ0O5XpzO0VwuQddeCSoEZrFvd7nFtNI+1lZ1ZHbD
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=XrX3+FF9 c=1 sm=1 tr=0 ts=6915b4c3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KFEUUOXM5gBsW3BA6b4A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: odnXY9tbc493LVMVbS7pOXMTtrzVqFi0
X-Proofpoint-GUID: odnXY9tbc493LVMVbS7pOXMTtrzVqFi0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA3OCBTYWx0ZWRfXzFUHEN6aJoF1
 a3ONEARRgP2j6Ww5g01U9HO+D3Q+SoS+WU/sQF1rL4cWGaXyJjlH91IUGSb23knR5fGb6ai6k/e
 ZrLB8y4nj5MZWzDnaYyRYJ6GmF0bDb8UJWdTOIaH93/h/BR5VOxkxKoABdwY6AGu79TbKhtKkmA
 N6S3Ku9TIFXRFPQPS6TsatSsY05se8QJAVwl7Vx5bkY6Yy8qPHCSB4boCqtZWLCGWGm2PfeNxzs
 utDbldKzU2j/V9M1i4SE9/lXFhZEN8RyQAb+dZ23LtfHeqH679lc4PKFMts13GNzFwJK2iaqS7K
 TDeo9T8uhLXDeNZ5dy4eB3ygWT5WKG2LoX2HAJ3/DcvcWW90xXjkQfadptQWdf71ehKdW6+H8v/
 7mPl+M0pTnu90wv/MqJdqYCcweR+oQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130078

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
 drivers/firmware/qcom/qcom_scm.c       | 158 +++++++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |   1 +
 include/linux/firmware/qcom/qcom_scm.h |   4 +
 3 files changed, 163 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index cab4723eb33d..0b156709af38 100644
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
 
@@ -764,6 +769,159 @@ int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
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
+	unsigned int retry_num = 5;
+	int ret;
+
+	do {
+		*output_rt = kzalloc(*output_rt_size, GFP_KERNEL);
+		if (!*output_rt)
+			return -ENOMEM;
+
+		ret = __qcom_scm_pas_get_rsc_table(ctx->pas_id, input_rt,
+						   input_rt_size, output_rt,
+						   output_rt_size);
+		if (ret)
+			kfree(*output_rt);
+
+	} while (ret == -EAGAIN && --retry_num);
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
index 42621770edd2..5c87c7e431e8 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -86,6 +86,10 @@ int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
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


