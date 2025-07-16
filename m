Return-Path: <linux-kernel+bounces-733853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733EB079D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735DB17CDEB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302228CF40;
	Wed, 16 Jul 2025 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FaQb4VGb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434EC2F3C34
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679702; cv=none; b=Et4JIIgXECGOjqN9M566nHx2nJsQQbTAtwbGgDNlCQjL8iMJl49d/MHROVksGlElT5L5qTJ1TsSwAkbQLyDfF2Ss4Q5RR8XA8HB7HPkoi7s7yh/Wa1uRheJIb/1k7bARGOSYahYTJt1YX8Z7oVCXXkunICq+ZnQIYOxEyvxv4Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679702; c=relaxed/simple;
	bh=d5TNHXJqe35TYW0XGOrPx+PAjPxH5xNWzgZ20VJX48A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AkVGgjOEuC41CA/VmqI125H6lC4hLNJ4XVte4UoX5I5+KVPUUfEGdQdtPHJJZMqEQS1Cv0UgMyncPI58xm9iMx0dtDyPTr4cvm0u1CDglPtGhHXtLHIery3ocAu6ug37UNClbDM5k39uvINgd/46gtjxhwhg/at8mZvxmQWflGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FaQb4VGb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G9Vu0W008481
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vVo7g4SuoBA
	YE2Kpf8pE4sBdUNQNHKc2NlVal4lHsUo=; b=FaQb4VGbYFWjx+AGOQxR42GdVD1
	BS/SNsaLf7hKd9FMQ+xLCCfKls8cu1IWD8fBWdYy10hcz3T4hz6y1CRdNaeEi7/b
	+3znubwO2Kl7yX8PoL7wj1KQmoS4YFLj9KqC2r1td53O990ozMiHOqc1/f892W7f
	KEEQzTUv4tVDfQc5WgG3Eh5uFflWOJF8CTuvqx/Z8ugGMAzz4RmjCZv3SsB8y6kD
	JVAzF8AYhGf3POU+6tC/asocjHJ/YrY70h9xLoh0DTD0goo3cF11Rh6G3HhY9dAY
	thfkKf1ueY3RmUR8RcCkWYvK9TYovtN/kJAiSOWHj57hOZiPORRq5R/Ak4w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpff61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:28:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso36762a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679700; x=1753284500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVo7g4SuoBAYE2Kpf8pE4sBdUNQNHKc2NlVal4lHsUo=;
        b=E1sXjgogo2kI9t2za4bbflHzDj8/niRCejPR/y7FdBJ6C7NhN3sU+RDwndSss89hzD
         xj8UjmiLVcJv6ndl1VOMS9L977TJzqYhplgvofEfR1NOcvYRQXCJZdW6QLWGKQ9jQ6pq
         jhwsTpM5M5IRaNe4Az6kSNK6yxCr9MntU1aT3F0cKvGt4jJAhmRMI8ixRQDhY4hKk215
         pBIpFoIpCX3Sw/YNZ9JA1T9VvHgWkylrd838YWgT0c7ZJQky1n977sKa9b2hu4sWJUVD
         A+aakAqhV630dSyFxZfDcWXj8uV6Qi4dqdT/MN8XiW/cC9nWiVyZIqsNaF59TzSvZwr7
         MLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiwBoigy8tb7TLLYWd6+5BG8UG23k1MHR/Xa0z7J7zHhxo5R0HSzbhC3AXltf4P7SP1VJX+bOYQ4QirN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWT16r6UP165NPDcCPaw9oQ/d/fRI33qV3LmRAAz7onzBYmDAS
	Mgec8/5AxQHbxkaEDIqJHk/VtaqaXkEREo3qDogbwX1Fcss0YDrk6jU8irxHgUJ9ygzt0wWVhLs
	h3J0ob89sTJoSf1wKrZuVcd6Y6YIRCLCpKUwxk6dmBGq2M+dnayEREcQ4DCnT+Oz5J6s=
X-Gm-Gg: ASbGncumDRiyvZTRHYolbVk2R/BVnEXZx7b+efHaplXedUqc4yV3XF2qfV3OUNhjtR3
	krreTFkH5iR/zUmBaWJnbs16YlJhzhNHtxKtclXoO9LNNceKLJumxjEa5BxGYk2c3A7ZYRJE+F0
	xduNn6NhlBvStsEOjg8SE1lOTUvmHMAQt2lh/t6XI1tjVb0yAylUPGVhWxeYptxkPfICg5AXWk4
	i1xdHgXi7QK4FHT5fFKrJtc8fXTtFD7pRA9QEYyQOD40ArX3Pb3FT+D8fP94pk7Uc2EOxu1mneg
	PiwOMMrhSTcDJWs3McKGCUwZwjKfSNNnU6vGA1HUB4Ows04PSs6p3QTecr+x+VKXz+h9slcPs17
	gHV+YejxW4KEKUA/tmrWjdtByV9YRBqQoonC4AX/S+AgfJhMD2zfPwPWqTi9b
X-Received: by 2002:a17:90b:2685:b0:311:df4b:4b7a with SMTP id 98e67ed59e1d1-31c9f4b50d3mr4106093a91.29.1752679699498;
        Wed, 16 Jul 2025 08:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeI5v7kP521ZDrKFwcG9h//NS6CzCzK54hgX/qI46bD76bO/lyp3vx7QSU98+WYi8yyBAb9A==
X-Received: by 2002:a17:90b:2685:b0:311:df4b:4b7a with SMTP id 98e67ed59e1d1-31c9f4b50d3mr4106027a91.29.1752679698969;
        Wed, 16 Jul 2025 08:28:18 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f20e87bsm1688563a91.35.2025.07.16.08.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:28:18 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: robh@kernel.org, lumag@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, konrad.dybcio@oss.qualcomm.com,
        quic_tingguoc@quicinc.com, quic_rjendra@quicinc.com,
        kamal.wadhwa@oss.qualcomm.com
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add Glymur RPMh Power Domains
Date: Wed, 16 Jul 2025 20:57:58 +0530
Message-Id: <20250716152758.4079467-3-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
References: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOSBTYWx0ZWRfX4xU635DbtHM3
 OUPDN0pnInD/wGlAbIrDsAo59/uVoJ+J2rBEvhXdQkOMDZEItPNnhVmhHQHrlDwPVpCXrBVwrkM
 g5u46/W++GPj1TVDHGwYPuthiSN3NeQKZgFPSxMdA0paLGoIuB359PgmdNPsfI2HL+GobmKM3TP
 TJT31FSmp4AJVJmN5DSRYdFjNvmjuwX9fejVtdqzdYjiYfnKH/xPRRBewId/SbQeo3I1bu8Ip5A
 Xv0ZFKbXIkIK8VzcLRi03KBZckzWc60mWa3h+gdmk/DU/MP73CiBzkwCuyER4YZsfEg+Lo8yzNS
 MJhj24bzUp3XHGHp6Okp9+UkhbG6WYL4JsM/dJjGDHclVTISmf1XLVVY404BZBVE7IymQmK+5e/
 gwu40PXvOuE6fU8jWtURzqQfUr9CRHS7cdBHFqLxzjP2wPkRZceuUBSmeMxMh4G0lXeh35kE
X-Proofpoint-GUID: 6fuaX85QEtQ5zgdzThBoHOqaSvL1rtPa
X-Proofpoint-ORIG-GUID: 6fuaX85QEtQ5zgdzThBoHOqaSvL1rtPa
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6877c514 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=o1i6smXM0GLUooxP6f0A:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160139

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Add RPMh Power Domains support for the Glymur platform.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 4a8e2047a50b..4faa8a256186 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -684,6 +684,31 @@ static const struct rpmhpd_desc sc8280xp_desc = {
 	.num_pds = ARRAY_SIZE(sc8280xp_rpmhpds),
 };
 
+/* Glymur RPMH powerdomains */
+static struct rpmhpd *glymur_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_NSP] = &nsp,
+	[RPMHPD_NSP2] = &nsp2,
+	[RPMHPD_GMXC] = &gmxc,
+};
+
+static const struct rpmhpd_desc glymur_desc = {
+	.rpmhpds = glymur_rpmhpds,
+	.num_pds = ARRAY_SIZE(glymur_rpmhpds),
+};
+
 /* X1E80100 RPMH powerdomains */
 static struct rpmhpd *x1e80100_rpmhpds[] = {
 	[RPMHPD_CX] = &cx,
@@ -741,6 +766,7 @@ static const struct rpmhpd_desc qcs615_desc = {
 };
 
 static const struct of_device_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,glymur-rpmhpd", .data = &glymur_desc },
 	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },
 	{ .compatible = "qcom,qcs615-rpmhpd", .data = &qcs615_desc },
 	{ .compatible = "qcom,qcs8300-rpmhpd", .data = &qcs8300_desc },
-- 
2.34.1


