Return-Path: <linux-kernel+bounces-850307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF57FBD2763
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BF73B297D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26432FFFBE;
	Mon, 13 Oct 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SnNLzU+i"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054202FF17D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349870; cv=none; b=nUQMdKhsNVBdjeTJZ0jHEnJ3jmYX1skZnY2yVjsfOETwwKNISWB3ECrxy0dCgzkBSPSYaq/cfOIMTyyTFsCoMqUg7vosh++Uln3O02VI1FuMaf/2b0uJ5YmTTfpu1pMC4JsBE780hd/YK6HPD+cZknXussbgh7G1/i6q4KNn47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349870; c=relaxed/simple;
	bh=VNLUfg0VTMrMLAfssDOHBS/ywOaH/J6hWRjnKH7tG0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QU/ELjTWfLFFgL2sarEW/GQMGTJ+9RxDwdnxUjFNpBEk6G40opYovz74pqR3QKOPSe60hYlpSmjA+C55xbY8OUszpZMDJCiDyWpeOZXbMVZtiWOf5rlhSNW7/Xg5XuR9iPzHssDqRHdFGFOmUpBCsZEeEb4Pf+c5mh7ClmP+bZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SnNLzU+i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nDot017649
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KCuKX9XLPL59gzeynIkI5vcGYQyfxzjGKslvVQaoJJY=; b=SnNLzU+iaMBubhe/
	dYgtEERFpo886G9lN+oHgvfDaCgWqQxx9xNdyu7RrlfXG0iqOhhcpMW1qx5EifAm
	sq+qAHTOlYhQF9JUSMcZ06DP3zquYqhXwfNJ0x2/w1ZKytBjoDpBe6NNLl7fUkIL
	s7/yzvtHgfZiIU/o4FwVRETUOvrAc33bmNq2K9usJbzXT5kudfKovfBUNNQSnXCJ
	NPBK9q8rd01lMk88WUbtaMOOob6cSTQAqizsMrDhSZPUJbY2/rBFrv00h6m2zc91
	qTkRWpmJwkuErLH9jDik5L3cv1OENGzZWp0dBbmCm5COb0pGxMfoOTJad4eGiiC8
	GUUTqw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdk45gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:27 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-781171fe1c5so7239268b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349866; x=1760954666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCuKX9XLPL59gzeynIkI5vcGYQyfxzjGKslvVQaoJJY=;
        b=XcWjQaDkFB/JwWWq/bXkaUAhCc8YW5FqugQwA6HTKt5cTDMcH+75h0vikOoy0MnHCE
         hh0L7/seUtcM2n8CeVuXW6IzntgGfouTaUbDARaFUwuDh6hqbkNzr9fWPLMIesIWvbFk
         Sm9UlOq1FtOaeAHxwcLrtPV1PATNdFLBs7Gxg+u9zU7EJxYtA5OvBQ5sC6CzVjJ2UhQu
         DE4GheWKtiO0mi0TegZO9ROZYIxlNG6AT15KSJ8M48SJLRpDhyVHsoVqUrTgJYrmKAsz
         Q41KbarZDdd/P1rtFJo4X1OvLJig5klSYEXMixDvvtgXiwmetmrhlyUQNwj3ilz1hESL
         m2jg==
X-Forwarded-Encrypted: i=1; AJvYcCWGgl9ufG5TS8PQSond9PM/jB0+kShA2E77Z/6pvwVRiR4CQRlhYoNUYLd6O+Ke9Z8j3qU8BMpDxwrAiXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUGfD9GPIqf55fRTTx0PFhARGmIQObsNDaC6e6nzVHTeHObi+/
	i1EwHi/3TzHAVOd2/Zlr6K4201aypUNNNkhIb9eTskmJDjmmAleKCTcCT0SmKTg0Sk+hc30eFzH
	YC4p/Zmfy2gdC0cjGox+828WRA/nr+uoYmRBzsLSDq5coMXyq6/CkHm7AGkbkLhI2GKA=
X-Gm-Gg: ASbGnctRtUA0B+U6Ot1O/9V360LEQMBYr3S7zDNB/uKwqAGc7OQ7XvXP01hiRioMj4V
	YJGss0Qz0KsavwV/Q3nZDTAdjH2Ca+6mWI/At9FtAs6HP6ArC8U9kN20uSNMMcbGUT07fj/+XPT
	acdhhq5sI0tetxwOnIcdKuTS7Mar2xg9H55JTu5dxGRuY23SPyPWxAe6I74wOrH0kfjt9gSbQTK
	9/aTch8IbXC/B0NCAhIo4bfusupbQ/bgVCa7PeYlTTCwFz2htUsU4yiylBx5Dw7niCJWsn9g0dw
	29q6rRuhD8f+TgQEr5Er1z9OWJszmk7E2kPB7xLmpB914f1cQCo6XW2XUFt5p3eAFfU=
X-Received: by 2002:a05:6a00:cd3:b0:781:27f8:d2e7 with SMTP id d2e1a72fcca58-79385ce1171mr22405050b3a.10.1760349865992;
        Mon, 13 Oct 2025 03:04:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwKFN5Yiqp2cQ01LwFms3qJjhy7wGHDj+GAyroqt4GpVGhRA0gNrqB6LOzar1OB3V2kYCqPA==
X-Received: by 2002:a05:6a00:cd3:b0:781:27f8:d2e7 with SMTP id d2e1a72fcca58-79385ce1171mr22405006b3a.10.1760349865301;
        Mon, 13 Oct 2025 03:04:25 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm10981657b3a.69.2025.10.13.03.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:04:25 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 15:33:15 +0530
Subject: [PATCH v5 11/13] remoteproc: pas: Extend parse_fw callback to
 fetch resources via SMC call
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kvm_rprocv5-v5-11-d609ed766061@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760349819; l=4665;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=VNLUfg0VTMrMLAfssDOHBS/ywOaH/J6hWRjnKH7tG0A=;
 b=Hs0YWDva1dXdF1lXvU2TISdQhUfia8JQNTUeedOomuY7gru/DCU/Maw5FuqqO3Pt1lvS6bhxN
 hfHDTbHvu+ECLirErqtB9TiZKUyLcMkI1blaL5YCCjzckeOxPEDm6kJ
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-ORIG-GUID: dVN7A20Zbt2H1wppzo-9G_wlAeIDSfIe
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68ecceab cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=KMz1R6K7GWUeRkMKapkA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: dVN7A20Zbt2H1wppzo-9G_wlAeIDSfIe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXx6hFfx89KPiD
 NmKV44xb03GEO6ZEAXjo2GQU3cxCqDXEAohg/bn+Ln9/yDHxXA50os6BQgdqqVdxUKarHYmr0Jt
 qaaNo5iy1DpNXkYCmyMKTJWcBvpzm81yfuOyid9H6DNm5F+1M/FduM42v8WQcIx5q7eeBI2Bw4l
 4Ks5GEhgC5miUETquGCxKDkc3RuTN/SXyYhi5YVrgMOmshvWN5v811AsFsKqTBc1ANi+HUpJsra
 ELB7KkeayrHvFMkmNNgi2r/QCkpRwl+vFAg6LHdJvbS/SHYcycnbM3p5l06wPDvatQ4nx4Eni1b
 7Ir5ZD0vegvTC+iI4lj7GanoFhsW0tYKPcwitL6+WZrs1NnW+6EA6kEwt5rhF3kkDxy8xoWBNHu
 V2AXDFgkawRO5QlfU4SEOPXZQx5Pnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Qualcomm remote processor may rely on static and dynamic resources for
it to be functional. For most of the Qualcomm SoCs, when run with Gunyah
or older QHEE hypervisor, all the resources whether it is static or
dynamic, is managed by the hypervisor. Dynamic resources if it is
present for a remote processor will always be coming from secure world
via SMC call while static resources may be present in remote processor
firmware binary or it may be coming from SMC call along with dynamic
resources.

Remoteproc already has method like rproc_elf_load_rsc_table() to check
firmware binary has resources or not and if it is not having then we
pass NULL and zero as input resource table and its size argument
respectively to qcom_scm_pas_get_rsc_table() and while it has resource
present then it should pass the present resources to Trustzone(TZ) so that
it could authenticate the present resources and append dynamic resource
to return in output_rt argument along with authenticated resources.

Extend parse_fw callback to include SMC call to get resources from
Trustzone and to leverage resource table parsing and mapping and
unmapping code from the remoteproc framework.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 60 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index ee0ea35803c6..1944df49893f 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -34,6 +34,7 @@
 #define QCOM_PAS_DECRYPT_SHUTDOWN_DELAY_MS	100
 
 #define MAX_ASSIGN_COUNT 3
+#define MAX_RSCTABLE_SIZE	SZ_16K
 
 struct qcom_pas_data {
 	int crash_reason_smem;
@@ -413,6 +414,61 @@ static void *qcom_pas_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is
 	return pas->mem_region + offset;
 }
 
+static int qcom_pas_parse_firmware(struct rproc *rproc, const struct firmware *fw)
+{
+	size_t output_rt_size = MAX_RSCTABLE_SIZE;
+	struct qcom_pas *pas = rproc->priv;
+	struct resource_table *table = NULL;
+	void *output_rt;
+	size_t table_sz;
+	int ret;
+
+	ret = qcom_register_dump_segments(rproc, fw);
+	if (ret) {
+		dev_err(pas->dev, "Error in registering dump segments\n");
+		return ret;
+	}
+
+	if (!rproc->has_iommu)
+		return ret;
+
+	ret = rproc_elf_load_rsc_table(rproc, fw);
+	if (ret)
+		dev_info(&rproc->dev, "Error in loading resource table from firmware\n");
+
+	table = rproc->table_ptr;
+	table_sz = rproc->table_sz;
+
+	/*
+	 * Qualcomm remote processor may rely on static and dynamic resources for
+	 * it to be functional. For most of the Qualcomm SoCs, when run with Gunyah
+	 * or older QHEE hypervisor, all the resources whether it is static or dynamic,
+	 * is managed by present hypervisor. Dynamic resources if it is present for
+	 * a remote processor will always be coming from secure world via SMC call
+	 * while static resources may be present in remote processor firmware binary
+	 * or it may be coming from SMC call along with dynamic resources.
+	 *
+	 * Here, we call rproc_elf_load_rsc_table() to check firmware binary has resources
+	 * or not and if it is not having then we pass NULL and zero as input resource
+	 * table pointer and size respectively to the argument of qcom_scm_pas_get_rsc_table()
+	 * and this is even true for Qualcomm remote processor who does follow remoteproc
+	 * framework.
+	 */
+	ret = qcom_scm_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt,
+					 &output_rt_size);
+	if (ret) {
+		dev_err(pas->dev, "Error in getting resource table: %d\n", ret);
+		return ret;
+	}
+
+	kfree(rproc->cached_table);
+	rproc->cached_table = output_rt;
+	rproc->table_ptr = rproc->cached_table;
+	rproc->table_sz = output_rt_size;
+
+	return ret;
+}
+
 static unsigned long qcom_pas_panic(struct rproc *rproc)
 {
 	struct qcom_pas *pas = rproc->priv;
@@ -425,7 +481,7 @@ static const struct rproc_ops qcom_pas_ops = {
 	.start = qcom_pas_start,
 	.stop = qcom_pas_stop,
 	.da_to_va = qcom_pas_da_to_va,
-	.parse_fw = qcom_register_dump_segments,
+	.parse_fw = qcom_pas_parse_firmware,
 	.load = qcom_pas_load,
 	.panic = qcom_pas_panic,
 };
@@ -435,7 +491,7 @@ static const struct rproc_ops qcom_pas_minidump_ops = {
 	.start = qcom_pas_start,
 	.stop = qcom_pas_stop,
 	.da_to_va = qcom_pas_da_to_va,
-	.parse_fw = qcom_register_dump_segments,
+	.parse_fw = qcom_pas_parse_firmware,
 	.load = qcom_pas_load,
 	.panic = qcom_pas_panic,
 	.coredump = qcom_pas_minidump,

-- 
2.50.1


