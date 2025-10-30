Return-Path: <linux-kernel+bounces-877916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D221C1F574
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D5FE4EA4BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C976A347BCF;
	Thu, 30 Oct 2025 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KGhctNEc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bHlRe9Bo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34F342CA1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817081; cv=none; b=JPZ6yeZA3plMSqy0q5X7dWu09qrhC9jmIW+/OSae2HODMdMH81efsCEnnpmhOT27l8vlusjDJRJVukQ+GnbDbPCcWMpDaS3NMfVBUg0FzE3DEwK+6VItSK14ir7oOd3ENa6OHXCkF+tHtSGDM1gqNCDdbKCqg4NGv7BH34WuIX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817081; c=relaxed/simple;
	bh=ZtETLkhF2W0kLCTmB3UKAwjQbraewB+Xn4eBG5R7W9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LXbsFiO+08r3rzlkmknpSbWOhx654eWWI/paV/gVGaWgEb8x2z87FaYDq2ofI1jor5sFQPgnCOXFJxhNwyXQlVgwftLgnAUhNch5VBiyQctKSarFPYofI1K5hcYJV36IetEUEO/7AtBUV8IpkR88+EuZlBw9IByI3fv2s0ep1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KGhctNEc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bHlRe9Bo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9SQrd1994958
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gLsx4g5+L9XMMqHrNyhzAMuyIAr9cq3BTyp7uBdkvlE=; b=KGhctNEc/iiCVDT0
	tZ163+LevTNVYTnZ/3iyH9zq67YwbY19RXjznLS5Ma368BSDQIVTnZrv3JgqWg0O
	Qfmn6LlpFKe9ltFuHI1v4xXBTPPRmO+Ste3BX6b6eMJG3ycX9z2pBXOz3ktRn3ha
	IrQy8oU6lUa+FGhs0sRw8qXqvZsHNVbk5unJ4mTK6z/o/aSVgYapczE/bOK/bmxn
	Q8GhDZsgufdOzmKqc2/nloW+Bm3GnPi3e0mxxT+mme6aj6ZaQCDT8jaU9/1RVwvf
	9RYMAsxUo78m2uvopWGcDkv9jKKULTb1EeDh810LMs8R3HHPnEetzrVImllT+4sG
	j27rfQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3wr71bq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:37:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29085106b99so8122505ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761817078; x=1762421878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLsx4g5+L9XMMqHrNyhzAMuyIAr9cq3BTyp7uBdkvlE=;
        b=bHlRe9BocMu6CkJCjwxD7H3BSEaTpQeLBDSlN5XuAWrVbYzZxZElS9NMNgtkOFGqmh
         Peidntsxn4TLmdso9mvab/2JFyTz0HH5k9zRGTanXWQLqcHXV0n4WgEiyWZ7XvFnhTnf
         QlOfcNyBPSwL8PG3THcF2zj64AUS2pIZ0v/ZHQwtMpio7Vzw1zETdIcQBWrNLkySEhCQ
         0F0NtkQ6fxBLysqPxrU9uIYy+dhZXeu99jdN0SudxayUPv2wZC7qs4JtAM1XM5BcUT28
         icGhQkp6s/7lxByVeRWOsu0TlUGqB2SZLb8B1YQ8eawTWJ9EktIT79VF7mIo3D0eR2bS
         LL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761817078; x=1762421878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLsx4g5+L9XMMqHrNyhzAMuyIAr9cq3BTyp7uBdkvlE=;
        b=f6QZKvKuGBXBnN0D1crisl/TSUBVlEeAEAqn0j5EudEWJGtXa5I0xJfxAPIA4veUFU
         /Mw85tWXF4yNh3589vEjNsHTlbkYopBoMm4hmxeudjxhlC+hdKicm4+AT2hm2RKUFO8J
         XfwAsTEaX09sZKyYuC8JKXcQ4CF7eiPw9b5y3MPdwGv6lZ0gzG3UtrlJ5w2qoXkaNySC
         Nyw9uEBzKnMqLcGcrFkFB09eGF0HZjEkkElQICst6Q+W4tMH6Gpi3qe/pehl3RJydMkj
         Mucv2ccZC6YyO4ONLfd9o+0JZRqIvYQdyv2t4bmOx/gQMrlItkP8xSKbLlGjue6rAoeI
         kbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe6uS4wUALzko6ZIAOlik5Nug2OTsFGSYC+u6tyJWw6Dc+h4lrAkZKbFgdcQ6DMKtwabF4XReX4ZHVaQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVOjcbRoTjfmb8+qybXXgGOF4zISkbq/+NDKUH2dR9dKnu6qtE
	WRoDY27fysp0S/An+ZsddK82KKw3AjsQ9eDHMtmF4ljQ+tiYZbDGYRR+x5PSVF0l7YRgpBXbIda
	2bieBrUEDLhA6i7tDNS18JBrH2a+kI3kH/IiP9iPTBGlG+sb08IO/iUFdc//h56I3RKFaQYYgFl
	I=
X-Gm-Gg: ASbGnctBYmvsGvAopAl9aoWNqW6jbmewEicY+G6SyH6I+m2Hkxv9RxVx7d/gr3qpeFq
	6ZV6bZxBGxJ6XJj/SkD78RtF974ViDBsvY4TwNvWNpc77mP0RJ5MmsZh4wrSQ8klVhFN8oFhQGp
	LxoXt3Xt8nPQT04h2GdbV5KQ2GRdLLHFhki4mJiiQvMVf8ueVZb8Xbchm9JsRDuEWCHDNYcjMOI
	5KEuRbZ/SWJVhAdCP/U2V7S012Ylg8LxhFYVkgLzk9jIdx4gFhSuazitQ8vQplHmlCE31pDrJew
	PzGbsGXc2zflKiLYv4M5jX8ck/jxoOh7ysM7chPWxl3sxFYX69qPK3Dr+gDjkxMX7C6cZBpN3MS
	Lmo9D3FLM6ulrSyWeh/MAzgMpSvz+Ap6VvGnwNQZodzbO7AeN4DBiUjb6a9MS8lKFGq6qeJ6xAW
	9J+V3f3/zuw0iCyGazJDe0T7aL22m6GyhnoQ==
X-Received: by 2002:a17:902:dac1:b0:294:fd79:41cd with SMTP id d9443c01a7336-294fd7944c9mr14647295ad.47.1761817077725;
        Thu, 30 Oct 2025 02:37:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIajuAw2WZ9gRsHWUS3kPt2qU6xqoyVKZrtQhy/9wTM8cMh0vEuWk7kQPYj0keKk3KAl0MpQ==
X-Received: by 2002:a17:902:dac1:b0:294:fd79:41cd with SMTP id d9443c01a7336-294fd7944c9mr14646915ad.47.1761817077156;
        Thu, 30 Oct 2025 02:37:57 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-294e3ae4ba2sm49350335ad.40.2025.10.30.02.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:37:56 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 15:07:49 +0530
Subject: [PATCH 2/2] soc: qcom: socinfo: add support to extract more than
 32 image versions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-image-crm-part2-v1-2-676305a652c6@oss.qualcomm.com>
References: <20251030-image-crm-part2-v1-0-676305a652c6@oss.qualcomm.com>
In-Reply-To: <20251030-image-crm-part2-v1-0-676305a652c6@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761817070; l=4374;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=ZtETLkhF2W0kLCTmB3UKAwjQbraewB+Xn4eBG5R7W9s=;
 b=IPFK4HolnZejQwRQmrtCJxbGzqnocQUpEmECpwo9TTVnm120MdGaOZVgK6TsftJGZ5btQM5O9
 0ZFIO1GP8onAIgsvXsLOjXu0rD89fUdBoPIvjcplx/NoOlCRTFpOECS
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3OCBTYWx0ZWRfX8h00e7yRdU4E
 HQ09L3BHWhCZqK0xr95LBzbRE3hjr7i5/He3qm3R+kqOCu4FXOx0dC4xKb3uljVdx5Zz/yojS18
 dMhFUwarsMDnC38dwPGaQJ8y0eKiTft/tJkRvmvUjIbXseJTgDVqQJ1R8LrQDwSisjxtaHNY6M7
 O+iokGofhhnwzLjRYgg0CuhQ12z190fh1ul0Bn8FYF1hgQgcY9ejiHVXXhM8lyJGYxjI2Nt7S+e
 zn9eFUN5flhKSTnVNaEIGrhCzHdYGbg9pjcVIIlhsQU+4O0qyJX3U0OiYva4VYV97rQd3xHYpv7
 FTYoV+MZDi4gYKjb1twyoWiMlREdUlRHbd7p0IMK5EUAjDV2P0cJ0FDUanA2p4XRN2rWGwa9Upa
 Nz54UMA6xP2g4OOvkS2TXCPL7Yal4g==
X-Authority-Analysis: v=2.4 cv=P+Y3RyAu c=1 sm=1 tr=0 ts=690331f7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ZFAbIWG072RaKbRf4xEA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: pCAi9xsxw_SepBqd6FnkzNEkd2l2qa3d
X-Proofpoint-GUID: pCAi9xsxw_SepBqd6FnkzNEkd2l2qa3d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300078

SMEM_IMAGE_VERSION_TABLE contains the version of the first 32 images.
Add images beyond that and read these from SMEM_IMAGE_VERSION_TABLE_2.

Not all platforms define the SMEM item number 667, in that case
qcom_smem_get() will throw the invalid item warning. To avoid that,
validate the SMEM item before fetching the version details.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/soc/qcom/socinfo.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 4fd09e2bfd021424b9489cd29eec29dc7c7a16d3..f832ae36942b10f68f0c3304f98d946796e8d1bd 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -67,7 +67,17 @@
 #define SMEM_IMAGE_TABLE_GEARVM_INDEX	29
 #define SMEM_IMAGE_TABLE_UEFI_INDEX	30
 #define SMEM_IMAGE_TABLE_CDSP3_INDEX	31
+#define SMEM_IMAGE_TABLE_AUDIOPD_ADSP1_INDEX	32
+#define SMEM_IMAGE_TABLE_AUDIOPD_ADSP2_INDEX	33
+#define SMEM_IMAGE_TABLE_DCP_INDEX	34
+#define SMEM_IMAGE_TABLE_OOBS_INDEX	35
+#define SMEM_IMAGE_TABLE_OOBNS_INDEX	36
+#define SMEM_IMAGE_TABLE_DEVCFG_INDEX	37
+#define SMEM_IMAGE_TABLE_BTPD_INDEX	38
+#define SMEM_IMAGE_TABLE_QECP_INDEX	39
+
 #define SMEM_IMAGE_VERSION_TABLE       469
+#define SMEM_IMAGE_VERSION_TABLE_2	667
 
 /*
  * SMEM Image table names
@@ -79,13 +89,18 @@ static const char *const socinfo_image_names[] = {
 	[SMEM_IMAGE_TABLE_APPSBL_INDEX] = "appsbl",
 	[SMEM_IMAGE_TABLE_APPS_INDEX] = "apps",
 	[SMEM_IMAGE_TABLE_AUDIOPD_INDEX] = "audiopd",
+	[SMEM_IMAGE_TABLE_AUDIOPD_ADSP1_INDEX] = "audiopd_adsp1",
+	[SMEM_IMAGE_TABLE_AUDIOPD_ADSP2_INDEX] = "audiopd_adsp2",
 	[SMEM_IMAGE_TABLE_BOOT_INDEX] = "boot",
+	[SMEM_IMAGE_TABLE_BTPD_INDEX] = "btpd",
 	[SMEM_IMAGE_TABLE_CDSP1_INDEX] = "cdsp1",
 	[SMEM_IMAGE_TABLE_CDSP2_INDEX] = "cdsp2",
 	[SMEM_IMAGE_TABLE_CDSP3_INDEX] = "cdsp3",
 	[SMEM_IMAGE_TABLE_CDSP_INDEX] = "cdsp",
 	[SMEM_IMAGE_TABLE_CHARGERPD_INDEX] = "chargerpd",
 	[SMEM_IMAGE_TABLE_CNSS_INDEX] = "cnss",
+	[SMEM_IMAGE_TABLE_DCP_INDEX] = "dcp",
+	[SMEM_IMAGE_TABLE_DEVCFG_INDEX] = "devcfg",
 	[SMEM_IMAGE_TABLE_DSPS_INDEX] = "dsps",
 	[SMEM_IMAGE_TABLE_GEARVM_INDEX] = "gearvm",
 	[SMEM_IMAGE_TABLE_GPDSP1_INDEX] = "gpdsp1",
@@ -95,6 +110,9 @@ static const char *const socinfo_image_names[] = {
 	[SMEM_IMAGE_TABLE_NPU_INDEX] = "npu",
 	[SMEM_IMAGE_TABLE_OEMPD_INDEX] = "oempd",
 	[SMEM_IMAGE_TABLE_OISPD_INDEX] = "oispd",
+	[SMEM_IMAGE_TABLE_OOBNS_INDEX] = "oobns",
+	[SMEM_IMAGE_TABLE_OOBS_INDEX] = "oobs",
+	[SMEM_IMAGE_TABLE_QECP_INDEX] = "qecp",
 	[SMEM_IMAGE_TABLE_RPM_INDEX] = "rpm",
 	[SMEM_IMAGE_TABLE_SDI_INDEX] = "sdi",
 	[SMEM_IMAGE_TABLE_SENSORPD_INDEX] = "sensorpd",
@@ -644,7 +662,7 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 	struct smem_image_version *versions;
 	struct dentry *dentry;
 	size_t size;
-	int i;
+	int i, j;
 	unsigned int num_pmics;
 	unsigned int pmic_array_offset;
 
@@ -788,20 +806,32 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 		break;
 	}
 
-	versions = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_IMAGE_VERSION_TABLE,
-				 &size);
-
-	for (i = 0; i < ARRAY_SIZE(socinfo_image_names); i++) {
+	for (i = 0, j = 0; i < ARRAY_SIZE(socinfo_image_names); i++, j++) {
 		if (!socinfo_image_names[i])
 			continue;
 
+		if (i == 0) {
+			versions = qcom_smem_get(QCOM_SMEM_HOST_ANY,
+						 SMEM_IMAGE_VERSION_TABLE,
+						 &size);
+		}
+		if (i == 32) {
+			if (!qcom_smem_validate_item(SMEM_IMAGE_VERSION_TABLE_2))
+				break;
+
+			j = 0;
+			versions = qcom_smem_get(QCOM_SMEM_HOST_ANY,
+						 SMEM_IMAGE_VERSION_TABLE_2,
+						 &size);
+		}
+
 		dentry = debugfs_create_dir(socinfo_image_names[i],
 					    qcom_socinfo->dbg_root);
-		debugfs_create_file("name", 0444, dentry, &versions[i],
+		debugfs_create_file("name", 0444, dentry, &versions[j],
 				    &qcom_image_name_ops);
-		debugfs_create_file("variant", 0444, dentry, &versions[i],
+		debugfs_create_file("variant", 0444, dentry, &versions[j],
 				    &qcom_image_variant_ops);
-		debugfs_create_file("oem", 0444, dentry, &versions[i],
+		debugfs_create_file("oem", 0444, dentry, &versions[j],
 				    &qcom_image_oem_ops);
 	}
 }

-- 
2.34.1


