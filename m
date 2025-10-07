Return-Path: <linux-kernel+bounces-844546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69543BC230C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D122B3B263D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD42EAB7D;
	Tue,  7 Oct 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MvGrNIO4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A092EA737
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855800; cv=none; b=WJGK8a1On3z+SCuty5biSNfNlz1hM43VGqYay9EpKOVYlKGgTcxFtvv8vydG7uQJYZXE64YY1lk0SPzyK10aygLt8qpvARYCgNT/Np+8pSnLmk9rjmi1r7WPzVgz1+JYrcEq2MWA2+P4UdcfRr56r5jZo6vmwros2DyGVr4Pu1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855800; c=relaxed/simple;
	bh=z1QANoF5R7XjUfSd6H1T6pJE0Sh7B2+LMNkBRlo24CU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPcoLanAn7VPCp/1vYUh4Km/97bOo2TyQJiY2SJqa58av+lyZYQTkUUI+Xnynky3ae6LyKdzISwSyH288z72qVr41Muck9TkwVdmCzOGp1Ehcrw0wOiuvWSLKkjXo8FQ7qIMkt5w5D0kX8mXR/RVrpFQgLprnw7fc+c9ODPLYzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MvGrNIO4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597ET8pb007392
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 16:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TaLai26LIfDvmmGlyEsDFdePOfnLzruH3EdS7qMRxcg=; b=MvGrNIO447XQc8ee
	5xU2eigkt/BO4IwmbYNijb0O/NWzJJPl80l0S8KpNP0+ShI/eq4U/FXhtDl4zMS/
	6e9meMrjQ8+7TrQqZGUZK+8Tbh7m6SWFBDbPbfjT9jBwF6NBTKwZubGFuai7cyqb
	bQ7lj6sq7CeGIG37m6exyLem9BJexxo7ceuJdvsqXcEEP/p39GzMEf86jVlsHyNQ
	MR9B6Q0rC7cqtxgcCIRi3VbE+54Ry/ZtKR4DqcWDdN7RZT5wo+CpQd27YR+LOCIA
	UBmxwe73SydPVE9RQ+IOVFyT5eCHSp53CCfKM9+/qpbNunkWHbmJb9aE67JxbFoW
	T1cCvw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvv7qtv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:49:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28d1747f23bso61803895ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855793; x=1760460593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaLai26LIfDvmmGlyEsDFdePOfnLzruH3EdS7qMRxcg=;
        b=Pr5ZZKYS4V1KW8p7VhUkymJdiYt9wo73uUHOzr1hjHid5ZafsPpdumqKEP66/VKJeF
         FfiLjdO+Q/Z1V8nzr1UqNCKAV9w9DhxLAPjKkLlhyAddsb0W1S1O5F9OzDTZmA0gE6bK
         aD6G1G76yP0vt77Vj0b0w7NzJmHgS/IUP4ku0I2UqhcGpNmcCn6nSw3NrrN0nKWXCFBs
         GMifM8+BYnRDwlrDk9OlEE9Wxxgo0GmFy60iFOxgyBlDRo+kjpuQA9mUBXJc2vX6V9no
         /Kpc/hR2KjD94WlTHcqAeThlTxTVPoz0fDJtojwHKe1239g6Ucdp1/HiIZe14ax+bQjO
         cTOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5jd1CPFx5GYPJH9QtWQo9Sevr0u7ea/9zI9VzR6Ziq9C7WjEPwT4w3+fwj9jkGJO+VxywcbuuWZtpinM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVGvSTSK7U2WlObKzfFppLV4itBP3NmuYoOhXnsmXq8TUU5t5D
	sMXorEtFsdstiAwLeV32O+U54k9rduI1OifnHuJuPMLNfJ5OkUshmRzMEdmjmkEBulKBdrZN5V7
	XFzDyiILQbOlvA0ewZ1+DVIOVolUOvxReAyPtYIy9e8SXNZPuIqLdbJPwBn9uuwl3dzs=
X-Gm-Gg: ASbGncvOkcwZuGC2vuOiUOawdnZya3PK/TeLIhAyVyORSB3Ru06/iQ51rxoREwfi6Zb
	9mkAZ/8LYDT89GRzGc6+TS+8c8DEfurCPlNMoAX1HydUL+AVXqkzefzeH8OSVBoqhtaPj/MtDbu
	Net0gAnFTQkHeENQpgtXo8f3cPlUVevy2vaWUz/bxLoJpsClLLOJFVn6wOSCiDk9szW0Mj73cbQ
	ITShuY+BryLDEqhtk5CX+RLSpr37wHHSrpnW+N9Rd8PKpeHXuLSxKXYfVImIAGK+YA209Ci2Msx
	aNutwFUYB7llp8dZ1OPiGPqe0t3FaJ0XyVtv+zIB2nu41recH35rGVFBwyyhvDKNReHWJU7n
X-Received: by 2002:a17:903:fa6:b0:27e:ea82:5ce8 with SMTP id d9443c01a7336-290273748e4mr5773215ad.14.1759855792495;
        Tue, 07 Oct 2025 09:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8TDfVd+6wKCu0QMGvlQmp8DxYDliBXJBLtj0ipRiCfpZtBbh1EWFROLGdmlDrkThvRevybg==
X-Received: by 2002:a17:903:fa6:b0:27e:ea82:5ce8 with SMTP id d9443c01a7336-290273748e4mr5772775ad.14.1759855791791;
        Tue, 07 Oct 2025 09:49:51 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1261e2sm171990825ad.38.2025.10.07.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:49:51 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 07 Oct 2025 22:18:55 +0530
Subject: [PATCH v4 10/12] remoteproc: pas: Extend parse_fw callback to
 fetch resources via SMC call
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-kvm_rprocv4_next-20251007-v4-10-de841623af3c@oss.qualcomm.com>
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
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759855751; l=4661;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=z1QANoF5R7XjUfSd6H1T6pJE0Sh7B2+LMNkBRlo24CU=;
 b=1gI4rCJyvUWYmOCWI4RG2FEdbbUbSzgmpvJ3M26s9x4RPeuELNYZscH/BwFu7TPAM80/lxxZU
 k/88Q3DY3RECzrs7mqi66xAlVCx7+2icbpB0qpHb4Rc1Xo54un2KO5O
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNyBTYWx0ZWRfXydLfFgBily/2
 ky86PQ8M/dpNjaKEZ5oqW4iQ3w0eoo1yHVABjFeQGC+eduDapSxGb38YmTuFzZQ8ZDDaZmw4l3d
 p+67cOFkBq+1pwHO7/RQekIxAub9JKZfVIEHRoofwqk0mNUioUPc+O6UKEXSFYl7A9l4QM8ys7C
 zomvyRsmdF3Y4IMg8kqePIb/6kV9Vg4dUHcnGkaIaP5S7MMU52lh1KyJ0ZwXH/eV2hVfPa3vHPJ
 DhdaUVnrPgMeQ9D0mB1NM6sdBzo47xNexbuhFTSr5zAGPvMEOaxSB8I7JLNMfsjquzS1xuoJQL2
 YC65JatFhz7YmvdrClPajkV4NqKwNqPBgoaYijEXj6yrBeUi6rND3lNtY+p1KqRg61Jjyp5GQtf
 1wVC9uL5OGIvEpWWmwJWlpLk3PLRuQ==
X-Proofpoint-ORIG-GUID: dvi_i9NJaThrcmWKae1J4yUA-xRvql5d
X-Authority-Analysis: v=2.4 cv=WIdyn3sR c=1 sm=1 tr=0 ts=68e544b1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=KMz1R6K7GWUeRkMKapkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: dvi_i9NJaThrcmWKae1J4yUA-xRvql5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040037

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
index 46a23fdefd48..ed7bd931dfd5 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -34,6 +34,7 @@
 #define QCOM_PAS_DECRYPT_SHUTDOWN_DELAY_MS	100
 
 #define MAX_ASSIGN_COUNT 3
+#define MAX_RSCTABLE_SIZE	SZ_16K
 
 struct qcom_pas_data {
 	int crash_reason_smem;
@@ -412,6 +413,61 @@ static void *qcom_pas_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is
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
+		dev_err(pas->dev, "error %d getting resource_table\n", ret);
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
@@ -424,7 +480,7 @@ static const struct rproc_ops qcom_pas_ops = {
 	.start = qcom_pas_start,
 	.stop = qcom_pas_stop,
 	.da_to_va = qcom_pas_da_to_va,
-	.parse_fw = qcom_register_dump_segments,
+	.parse_fw = qcom_pas_parse_firmware,
 	.load = qcom_pas_load,
 	.panic = qcom_pas_panic,
 };
@@ -434,7 +490,7 @@ static const struct rproc_ops qcom_pas_minidump_ops = {
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


