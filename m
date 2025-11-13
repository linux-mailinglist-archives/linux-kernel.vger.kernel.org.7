Return-Path: <linux-kernel+bounces-899150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED037C56F33
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0000B3BB996
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC83333458;
	Thu, 13 Nov 2025 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TFAR2ck9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DXFnXgGo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E233554C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030217; cv=none; b=jLMZmYNaQdT47y1VSi00UFWOk85mewx9k+JUsHvSKUj9Est1Pu75KW2fp7AQLwTNXYYhRvKnui5NB1R52EC3Q3x99XP/+M3+NaR36+GPgGjK+fO5xHe3c9DURDMjAd3sCPvIHMQu5MD3maKx844Xk7HFJE79jFK0DCCL0+HM/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030217; c=relaxed/simple;
	bh=gNFGaJcn5TMSmEg3QDtGPUJyOv4mdDqVk1oZU1qyXro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sfnn/xOHdOsoeGQ01ovma498goaIm3dI9vp3PgWikEb4Gq1paq1qb3KgZIpm77ojBxv4ENS8Q5IufwewvVCC6ySRl5snHzvQQ5ynfItmOmE7e1TceZEszeP+UCXE6DL51etTijzicKKaR5kXyxG01yb6SsX0hoxaQvvPJaveR/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TFAR2ck9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DXFnXgGo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD6r7Lu3874466
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DVcACkzc6UFDGxyaiXY4/RxZa0iDaHOdQK63tga8N7s=; b=TFAR2ck9RjNLdlGZ
	d//YkyT/PIV4s0UDsBJaAGcctJTf2Nb/V6ueaB7jdSB5o2z4HhBdY7qiLqkCeEf1
	KLYdxOipidWESImje0IskBe12OWAo2gFWkHWUhRniyzybmw8jAJGMzr8vjEV2ngr
	I/jfMdDsRsw75Bhp7axmVscRYH+dKycWY8GIRRt3zoWqM8w5GkTlkddBh3I6OY+j
	GdA1bHv3IjXd6JbrImGdMTY7K7CjJLSgkc33wQissqjKXxzNDEg5TRXO5je0HTwc
	m5uG2/xJl4E/U5jwqwIZnuGhukkqMGfROP9nHsQ/Jl45dImfQ7xiHAf1xY6MA5LG
	J7s4WA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adaeurpns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:54 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b89c1ce9cfso637248b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763030214; x=1763635014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVcACkzc6UFDGxyaiXY4/RxZa0iDaHOdQK63tga8N7s=;
        b=DXFnXgGo3rtmo5qDaaMAjsX72RWScqceD/KhYWe6bfb17Ell8adwlWw4INh4eZx5pI
         z3RTNBeeAufwkr96u2vXnZ9XQtW102epjGKwHx7wNG4xHN3SJst/tZ6M6EHDf5QPWURz
         X/QBlGN474gDZhwmJIG9rC4bX+16h7P9uQdgOomUfVRWmMVdZDVGEfNrrCfp+UViZcS6
         tq/vfaIn2hohV03NChNFVLSoeUffWbhJlTb0W0j4S9eXyzPxlYw0DmfoVmSSoW8u2ozs
         22HUsU0C02F02e/ZJTtF7hnDXZuFuzkmlnMcTXK0z00ZO/1d4Riy1U17GBBpTsll1YT4
         BulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030214; x=1763635014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DVcACkzc6UFDGxyaiXY4/RxZa0iDaHOdQK63tga8N7s=;
        b=KZgrzfV3hJd+PrbSXnPu+EzBs//ZS9q8fyANp58neEu/FFhhZWB/69k42bO6nsDZKu
         Ak732LjaFA8+Jnv35toU+HFrht3w8homFcMO4OI5JvRLFebg0+oDuN0aT2ibDZr/RrRN
         QCN/aSKWR/Au00jxJW3WAAxwaIkb+TKA61pS50FQszUG9m3s8iSwjDMEOdYkbNYue+SU
         WiwOPOC4wxYMiFM1gE1rgXh867vU7bE7cR06qngxoU473lyZZAF9fxf5/BZH8GoCNL0k
         w/fW6LtJKPNWhI9pKTMMDfz4trkccSaTXVFYNq1Pwqabl43bTMwMCm0rpI8gf/lQBvxf
         4C2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAaCFLghTv+v2KmpF8/YSnsBtHDBpPw2rBU3XkCS62w25eaex4EVNfLv5tEI9PB02oNlk/3Qesjyg/OHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+zlc3X//FTkWOYYzfvfwDb4TruABwJdYl8tyb+50FVRcbd3uB
	ZNyvVkvoth/PmBIey49eN7/IoNBpwgU/DSKsu0v2HV9iaDb2ZK8+ocZm1OREHxyVP3jmUdAIf9e
	cW2Fr0ibDFrB8Ps/4JK9fB4fyL1gIohwSI0XK+RPHSqbcI+Hw4yvYnVOG7L3gO3aDQQs=
X-Gm-Gg: ASbGncvzILFuZwE3yn+9qTl/8duFIDX/bsXO/OJMlmCDLTaeA6B9I7NbYGf/TiSDSBm
	uPKbirybtrQQ6DZDjopcnuOw5ttCkSqkGqcuOMaxnRhcZby7RedaPrkvXRX5rEJHgC3em1u+VlS
	c+ExOXGww1liThf6I0NsOBRSZOgmhiznVA2tTBkjYNP/f+w4M6fWniWj0vATJ3LSIJSCb/e9gkV
	rTUHF+M1mtFkD3ZIKvk1lWWB6AK/UD8DgLzLTYI+CbSAy3mwQWGps7ohihPNuFF8VjqxmETVcrm
	E/vPCXmUH46aZoCSahNtCiHg2HYG+E+awA226PpGql1Lmm2mS9XrlKrbaufGbeIoQm7QjmQMTL2
	CFzlF3mF0ahf+jR0WU8QAZ2NQSA==
X-Received: by 2002:a05:6a00:3a0b:b0:77f:4a83:8f9 with SMTP id d2e1a72fcca58-7b7a27a4772mr7658228b3a.2.1763030213819;
        Thu, 13 Nov 2025 02:36:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxq35Ja6M8j8qXL1e87FxDKjwn3Su1a5HLcrnebGrba+IQOfNtC+hxBzMwmCGecf2dHAMDuw==
X-Received: by 2002:a05:6a00:3a0b:b0:77f:4a83:8f9 with SMTP id d2e1a72fcca58-7b7a27a4772mr7658181b3a.2.1763030213102;
        Thu, 13 Nov 2025 02:36:53 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d2d16sm1886922b3a.22.2025.11.13.02.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:36:52 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 16:06:02 +0530
Subject: [PATCH v7 12/14] remoteproc: pas: Extend parse_fw callback to
 fetch resources via SMC call
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-kvm-rproc-v7-v7-12-df4910b7c20a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763030164; l=4670;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=gNFGaJcn5TMSmEg3QDtGPUJyOv4mdDqVk1oZU1qyXro=;
 b=xfzgF18zN7nU476EbvNyJhq7AnffdauLgIFlutQ9BTRvvepkjkz1/qLq0P+59JJM/eNG4CkAk
 3INPb6QNtEVCMp7o3PuC6wLRaFL6qfTyMA/TeyAftgjLsXkaIfURQnK
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-ORIG-GUID: p6tp4D139fbb9o_Zd7RppqBBgPMoyPG7
X-Proofpoint-GUID: p6tp4D139fbb9o_Zd7RppqBBgPMoyPG7
X-Authority-Analysis: v=2.4 cv=JPI2csKb c=1 sm=1 tr=0 ts=6915b4c6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KMz1R6K7GWUeRkMKapkA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA3OCBTYWx0ZWRfXysOsthdP/+us
 dVdXpOmxLoWgeYuleUlL2QqDpYs66s4M43mWuoRMvJFWNFc7zGEETlHUJX4jBk9Wec2B7yOVYF9
 rwUYSLDsht/aLOCdmwKitV54ZIDkyvT1MIq9HBclXMpd9beHtTk/MA3GFpiimDF+Y6NqHDaFJ33
 cbaX6zJISmua34NbMnSQne2UUhU74tpkrJa9DKVrF6iYh8PqL1v24xFdajtRYXDwXQ+ovygK72B
 /yjEU5Sgu+4HuQg5/l0TsiPj7TSJziHkBjDo/IfDE0enprcNZlzPkSEXf1mwm7jyeiCynbC0VNN
 AMqWwDsRAb+neX8O0G1qgeRN62CO0yq4EPPj+MzjeLsMZJpnZ2fESBEZD1IbF8y4/DLspON4mS5
 BxRVsdgbOYXpywEnh+YQdsMIp0Gjrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130078

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
index 9feee2cb1883..4d00837db58d 100644
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
+	 * The resources consumed by Qualcomm remote processors fall into two categories:
+	 * static (such as the memory carveouts for the rproc firmware) and dynamic (like
+	 * shared memory pools). Both are managed by a Qualcomm hypervisor (such as QHEE
+	 * or Gunyah), if one is present. Otherwise, a resource table must be retrieved
+	 * via an SCM call. That table will list all dynamic resources (if any) and possibly
+	 * the static ones. The static resources may also come from a resource table embedded
+	 * in the rproc firmware instead.
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


