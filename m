Return-Path: <linux-kernel+bounces-884220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 548E1C2FA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FF9A4F5F54
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EACC309EFE;
	Tue,  4 Nov 2025 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E8cR5q3D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBX5R/cF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AB430ACE0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241785; cv=none; b=ZvopFtAf9kcLFuh6T/tn2wstQI7Dh9e1gOsTQB5AeVANCtcSiw4YD2+izM1TJEJjz+iCnEiJRVXUA+mIZYoXoROTGMBGEXNpkROeb7aA7/25zXXBXksOXV/xuqHKtbaK9h00+qUpoU/z345WwO1bsIPBV/g408qBT7jGpdDKe6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241785; c=relaxed/simple;
	bh=VOuOqf5s/VXmQ4/n2mXrZS+xom6wjqVjpYUDEQ7bQ/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A6VOWGCuMwwudoob0nFR+fWTowcyulDHgpSyRfBT8Ab1LHs5MxKGXolCwIm7rk71fLHYfkvtuRouaX9+4KjSTbUu8WvaCARVTku0xkTIc/nT33R3y2z1GbM7xx0Jjz3NQ1qpZOK7M5lKS8uCwntzFMhra86NrKf175KYup6rOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E8cR5q3D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBX5R/cF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43JTvw3744533
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 07:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T6TjcEvFUXKY8cVK2RdiT+HmYg/PxQRxdMt6O3kLtQU=; b=E8cR5q3DPydOtoUd
	O7OkjUO9QtmRPDAyNVudq7YSftIT8HkecUzPNGXlp1NzLCn+tcl6bSujihw34xIy
	Obdo7Mb6qepJfg0JzMn2CK77kCItzegUvm8hsGd4rNjUk/2fOqIa/+7rHsMv8fIs
	WevLFaP198/iLDNI2ob/4AAJCw23Q/CuY8keL+TBiKFO/L00q21+yNUikBB5TDDr
	HfqDRpDs7GpD/YvT0q+rF9k4RaSz5D3UlEQhTxp97AVbl+QcoZmWWhSFlexlhXDq
	dYEXozMRn8QsTXdLRCNSYkKpTXLK0HU8nbyQ3hOn2xg35g77F+ZSZDdKR1vXk1sb
	JwZfpA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70kca3h6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:36:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso5048004b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762241781; x=1762846581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6TjcEvFUXKY8cVK2RdiT+HmYg/PxQRxdMt6O3kLtQU=;
        b=QBX5R/cFYaX41xiAJH1P2K4M75i+nZ90QdS06nc4g9HLF20AXOnMxCgLoECO5g+0qH
         hCfAdhcuyXqJnrTPDa3xrjs8GdEFrEvcR+zP1Oc6KI72OPwT9uQaF8g0d+6JrPa6dXHg
         n3rR2vqsX1uqx9FdhmFubVNpbXhek4b9soriF+YciR+pmRNCo1QITqQj1g1AUUX0TzB6
         /qezrE80gBHZ0HpU25EIjQB+H1r0O5gIp6HE63To3q++UbQ0MVM0HgjW7kpg4YQn+jrb
         04yNATjkwzaBOfdTolrID0bLakRpe8rd7+n7cSiswVk5z4tT4I0ttkdYJ/2Q8HsfSolP
         0CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762241781; x=1762846581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6TjcEvFUXKY8cVK2RdiT+HmYg/PxQRxdMt6O3kLtQU=;
        b=jpX8NH7DsfMfbXUlY10yv06FBgo+wd9KmP+JbGM7+vgUWDNQhscTI5NF9VBv4Vcu4p
         xoaEUEpVS+1IdCQDS2wrYWZxB3CsAjXdg4CDOlFIOSm8NlQk5NZ6oZVtAE3Fn2M86Rcn
         2crOHU3mbeY2I1YoM18e4KFDJbqm/FAywA55+KBLriTmD+FQ46gXb5g7kbgWnNVanJ1N
         b1A/Z1VtQb6OyPCKi8A3yGQQMhu02o7SHdETqufDOrD5T4mpOLbGlp/xslwiMZNGaJcT
         1fG14KXVtcVvYjggKdPN0dppIgrkLbZ9CLwbW0QtlzSv9prYl+p2CXtSjIHZ2WBouSZ9
         mzSw==
X-Forwarded-Encrypted: i=1; AJvYcCUkJOaIptf837lEJyH7w9dEQGk8Pi4K5/yymFbALETUOfYE0ePbums9BoSsPnrQDMyB4FxOgYk0/t4auRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/OfV7F2JjhNrx5T34v4NrcJzziLGKfZJM98gEEk6FTcTctGBl
	ZTXkuV1xaRvq8Wkky/W3ZQJymJHxag09dsN02c5WTCgnGfpIUhT7jCKrXU7RDve5lkcguPjDDK9
	r6pXv6UwqNbyh8mcwont5VXqecKSU6jW4Tkzwt5qx9igXPEvF2u1d5ktLm0VBIEVVIqI=
X-Gm-Gg: ASbGncsEXy3mGbsIONTN8Hi3FFIuL/I0pxrLBSmckidamwjoP5ax3KhjH8/0GtIQCnH
	jHMyAPubrUZy9FilP9yvKePFxSn6rxNlVjNEOseYd6+M7+PYblS92NnSpZ8qYbvrHhSAQEhVNsO
	n5eooQRWxEnexoqAHzubcuSGdvOL1k2go60u4p35V/MjYQeJFdWg4Ej34pFcxSI+Szy5E5dZaRR
	CGUpJQbNWp6LFeXRRKrLMY/ouL1NkFb+VWPEnIJTn6dcWmm9kKS9c5IGue9yffSlGZ5vHfrt/gg
	ewdS8AJLyq4hmvAzrlmBfN/54aW+QNEAPNYScvfjU0HOjBXmNlZjqmjVNZ3i8ZnLjPS7J1I5qNp
	eVeSFUCHNrDL0W8I1zlBusEyFwQ==
X-Received: by 2002:a05:6a20:3c90:b0:342:b36:57eb with SMTP id adf61e73a8af0-348c9d6a9c8mr19434246637.2.1762241781214;
        Mon, 03 Nov 2025 23:36:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCy004iXy7dW+VAzovaUFE9/SwtgH8PZExWgCCD3/vyHxwMWvbOIsX79sc9/froyhzP7qBww==
X-Received: by 2002:a05:6a20:3c90:b0:342:b36:57eb with SMTP id adf61e73a8af0-348c9d6a9c8mr19434202637.2.1762241780484;
        Mon, 03 Nov 2025 23:36:20 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cfcsm3484367a91.19.2025.11.03.23.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:36:20 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 13:05:43 +0530
Subject: [PATCH v6 03/14] firmware: qcom_scm: Rename peripheral as pas_id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kvm_rproc_v6-v6-3-7017b0adc24e@oss.qualcomm.com>
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
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762241765; l=6055;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=VOuOqf5s/VXmQ4/n2mXrZS+xom6wjqVjpYUDEQ7bQ/w=;
 b=zj+Xz78tc7/i1WynN+G9YdAyqI4Ax5yTqQFGw4wN75zvcnYV+I574Xf3omt7SNWN+LtVWpOI9
 HsuFopfBv0lACgxf4T0UXdUYG67GIe3yTNk0jDmjadIqRKm+6/TLY4y
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2MSBTYWx0ZWRfXwo0PiB1TIOwJ
 PxPpVoOs7gOr1vMpIxbl40nqxpbPFlJobPyomBisMGsq85S+Wqvg3ah8/OQ6rbwXuVksdlwDBBF
 oZ6/pYTDjQsQ/tjVF/qHUT5LPACnw1ocj8pIWN1ydFOA2DJ8OAck70NeBDkM5Nl7udcHxyFTXJF
 okOO0EuBfpHi2XY20gnE4H5GeMmaxk2HxwIreqBDWoU9rR/+unOf3uXSzmdTPEfJ0YL4mCwkt6d
 qWa8x3iy5OWWmJ8YiYa4AmgB6Lwz3HFlNHSI/b1sq3oWnA1iZvCsWqprXpezC154FYb+sP2K4Eu
 qWCowFgqWRn8WQp1+H7hc2a3m1TidiK2mWdK+RJtxmGYcN8CuYrta2JMEOxKHNEy63k7SusQCh4
 9uXOBUj8fRs/2BPeaVqsNKcW7U9UEg==
X-Proofpoint-GUID: D9lvs5_2WNFbqeBINrKBLySg6Jmj7zqi
X-Proofpoint-ORIG-GUID: D9lvs5_2WNFbqeBINrKBLySg6Jmj7zqi
X-Authority-Analysis: v=2.4 cv=TIJIilla c=1 sm=1 tr=0 ts=6909acf6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=bcWw3dkznkfw-y6_B5AA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040061

Peripheral and pas_id refers to unique id for a subsystem and used only
when peripheral authentication service from secure world is utilized.

Lets rename peripheral to pas_id to reflect closer to its meaning.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 30 +++++++++++++++---------------
 include/linux/firmware/qcom/qcom_scm.h | 10 +++++-----
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 26969bcd763c..0a0c48fca7cf 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -562,7 +562,7 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
  *			       metadata
- * @peripheral: peripheral id
+ * @pas_id:	peripheral authentication service id
  * @metadata:	pointer to memory containing ELF header, program header table
  *		and optional blob of data used for authenticating the metadata
  *		and the rest of the firmware
@@ -575,7 +575,7 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
  * track the metadata allocation, this needs to be released by invoking
  * qcom_scm_pas_metadata_release() by the caller.
  */
-int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
+int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 			    struct qcom_scm_pas_metadata *ctx)
 {
 	dma_addr_t mdata_phys;
@@ -585,7 +585,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 		.svc = QCOM_SCM_SVC_PIL,
 		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
 		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW),
-		.args[0] = peripheral,
+		.args[0] = pas_id,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 	struct qcom_scm_res res;
@@ -656,20 +656,20 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);
 /**
  * qcom_scm_pas_mem_setup() - Prepare the memory related to a given peripheral
  *			      for firmware loading
- * @peripheral:	peripheral id
+ * @pas_id:	peripheral authentication service id
  * @addr:	start address of memory area to prepare
  * @size:	size of the memory area to prepare
  *
  * Returns 0 on success.
  */
-int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
+int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_PIL,
 		.cmd = QCOM_SCM_PIL_PAS_MEM_SETUP,
 		.arginfo = QCOM_SCM_ARGS(3),
-		.args[0] = peripheral,
+		.args[0] = pas_id,
 		.args[1] = addr,
 		.args[2] = size,
 		.owner = ARM_SMCCC_OWNER_SIP,
@@ -697,18 +697,18 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_mem_setup);
 /**
  * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware
  *				   and reset the remote processor
- * @peripheral:	peripheral id
+ * @pas_id:	peripheral authentication service id
  *
  * Return 0 on success.
  */
-int qcom_scm_pas_auth_and_reset(u32 peripheral)
+int qcom_scm_pas_auth_and_reset(u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_PIL,
 		.cmd = QCOM_SCM_PIL_PAS_AUTH_AND_RESET,
 		.arginfo = QCOM_SCM_ARGS(1),
-		.args[0] = peripheral,
+		.args[0] = pas_id,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 	struct qcom_scm_res res;
@@ -733,18 +733,18 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
 
 /**
  * qcom_scm_pas_shutdown() - Shut down the remote processor
- * @peripheral: peripheral id
+ * @pas_id:	peripheral authentication service id
  *
  * Returns 0 on success.
  */
-int qcom_scm_pas_shutdown(u32 peripheral)
+int qcom_scm_pas_shutdown(u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_PIL,
 		.cmd = QCOM_SCM_PIL_PAS_SHUTDOWN,
 		.arginfo = QCOM_SCM_ARGS(1),
-		.args[0] = peripheral,
+		.args[0] = pas_id,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 	struct qcom_scm_res res;
@@ -770,18 +770,18 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_shutdown);
 /**
  * qcom_scm_pas_supported() - Check if the peripheral authentication service is
  *			      available for the given peripherial
- * @peripheral:	peripheral id
+ * @pas_id:	peripheral authentication service id
  *
  * Returns true if PAS is supported for this peripheral, otherwise false.
  */
-bool qcom_scm_pas_supported(u32 peripheral)
+bool qcom_scm_pas_supported(u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_PIL,
 		.cmd = QCOM_SCM_PIL_PAS_IS_SUPPORTED,
 		.arginfo = QCOM_SCM_ARGS(1),
-		.args[0] = peripheral,
+		.args[0] = pas_id,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 	struct qcom_scm_res res;
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index a55ca771286b..a13f703b16cd 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -72,13 +72,13 @@ struct qcom_scm_pas_metadata {
 	ssize_t size;
 };
 
-int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
+int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 			    struct qcom_scm_pas_metadata *ctx);
 void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);
-int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size);
-int qcom_scm_pas_auth_and_reset(u32 peripheral);
-int qcom_scm_pas_shutdown(u32 peripheral);
-bool qcom_scm_pas_supported(u32 peripheral);
+int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
+int qcom_scm_pas_auth_and_reset(u32 pas_id);
+int qcom_scm_pas_shutdown(u32 pas_id);
+bool qcom_scm_pas_supported(u32 pas_id);
 
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);

-- 
2.50.1


