Return-Path: <linux-kernel+bounces-620466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB04A9CAFA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 16:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3DE1BC7AC7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1A8252914;
	Fri, 25 Apr 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DJV4SNRl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A50255E30
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589623; cv=none; b=HBwG9lwtfuYBxG2/Ppx4qu5o602OAW6zdii23KRqW4Sz9R9R6kaItbYZ0el/qYWqyXrr1IcUyKm2h51Mox/vaeD8bEB3ge8ljjD3kzcbAtMTtYd3H91AVuKeX0SWiAz+r8SBC4ehqFYao6GCLnmJia1Ori149ZMT0vtqHWM4wvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589623; c=relaxed/simple;
	bh=iwm9OooUWQdoBUOf5u2EIIhp9kjTk0ngHqyqQegt/0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bPPVDfETc3IyhVFFgbG8lD/lm69F9o8TsUMRNZzb4MM2v/HfG512MQWjJBZDxRT+715+IHy/smqZsdUiaa3DKvwkKbjTtM7H5DV3w9ZxZ6t4TgBPXpdWY2kQHMM3SIZENe+GYkB6xIJlNyIuAk2Cnm5/jOC2jzes74KX2SnQCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DJV4SNRl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8TcUI020012
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 14:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=L56NDXjZ8mA
	lJ6/qvpUv5Mw3+Om9ZpLMh5fPpNpp9xM=; b=DJV4SNRlHymLA/7JOtbodkw+sbh
	rfHN2poVg/ulTyjYpj3l5rNG0YEvNPmiP6ZGbMkPaY5uCOD+VhZvz5u4bOYSmgyR
	r7GfBQ0ZIqHpmOVTSiVVtiN39LTRjgLYMlH6nkDBJtUsSQtU39n7d4GuV3/LXiIo
	nYwPPLvXZAr3C9WBZyDMfqBs5Mv8T6p4+hEDqxjs1eduf1vx7SKg20Yp7AffY+tH
	5fEF3nPIVCwQvKf0ybqhtD3EQQOGFZbfHskXkXLRXL+IfCEopG/mgR48AeoyeDX7
	SEkHm3pc4B6YxSvdNtj7+LYd1ru/HxzYbFIDxX4iPCTVVSDLh/ShjaoYnVw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh2990p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 14:00:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b1a253182c5so608792a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 07:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745589620; x=1746194420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L56NDXjZ8mAlJ6/qvpUv5Mw3+Om9ZpLMh5fPpNpp9xM=;
        b=aT/VTpyeMse5ijWSCOkk7yMcsyn+kDNEhSESuZHbAxQrzHd78UGCoU0kzOvYBfiudN
         JeZKsr8/XU+9rHEg2I3qTh4js+A25He9N3zaUcPVFh47MYqZfL8/5paIwZW6jW5Ew81Y
         ej+Z8/nYF4oyrjep2f8YFujgMpLZFNF5eelgq7kNE0juNkmIeQ8985YS3xj4zRbT7j7p
         C/libzObqoFHCTJlSfQRzk5n8OhwM8Cbfdr4rlX1CCOq4ITdrLmyMt5HZ2qEgy2vu0m/
         H4wxvHEHKD5VM0+KEhHktFm80sLLj2r0sr6inPn1jDqsNJ6CBws4TqLmlf16obplYLvX
         NIww==
X-Forwarded-Encrypted: i=1; AJvYcCWFLvtfGhOocu7q3Eo9Xl0A94lLCrFKw0nB6cxTOu2qF9d/s8r1NaPynmYvxLFTHBUxfSjAlyqf9UXit7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/DVrsnYiL7Ld9pZJIBREMoAR0duc3Kzm7zyT0RaPKjS8uFWg
	ZI3qb047BhIdRtPAaeh6nxQqnEcWhac52Ba7RHg6Yf1qqu4uav1bMfb5P7xh6UJijQGPyVnLRcn
	66g72XxKFqOLsXkGpN7GjFux1pFpH2Ek2JeNQJdKksX1tPCLsfkhtrug4jMy/oVU=
X-Gm-Gg: ASbGncuy5I7IPS/zoT4Fv3Haj+IVT9Du8bKND8Pk9OHVAkIo8tUEfIYdTjfrqzf4YfO
	UjClt13Wy0GDMUxO7ICQVk3S+0ZvHeprkvXsnFoQzg9CLJJidb5rIhGCLnYcjLz63k8lb+2uExl
	2waGDNA4V8t5VmQ+Ug3Gx4nLDETZ7j9JTBIcrGZHYJYwXrk0pK7hPPlg9NIMTwrAmJ+2OoQG9hw
	j8vJDVa2pukJkBYJXuLN7gUPAanVKUgEB/ejEXnXkZmXxED9LamwM17AfY4Hzzn62OV9NiGZUq2
	Tt4mu+EiySjjYUt9GOp0zyBetjYeXsPJvRSFVUc=
X-Received: by 2002:a17:90b:2741:b0:2ee:c91a:acf7 with SMTP id 98e67ed59e1d1-309f7da6d24mr3888290a91.4.1745589619341;
        Fri, 25 Apr 2025 07:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFCSNNtmOBy+P5uUCdKDMn9Fo4idNZgKB+hc+w6SvdLeW3ph4TVq5Qbg8kdN818kgFjZdmfA==
X-Received: by 2002:a17:90b:2741:b0:2ee:c91a:acf7 with SMTP id 98e67ed59e1d1-309f7da6d24mr3888205a91.4.1745589618573;
        Fri, 25 Apr 2025 07:00:18 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03ca86sm3470432a91.3.2025.04.25.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 07:00:18 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 2/3] soc: qcom: socinfo: Add support for new fields in revision 21
Date: Fri, 25 Apr 2025 19:29:45 +0530
Message-Id: <20250425135946.1087065-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250425135946.1087065-1-mukesh.ojha@oss.qualcomm.com>
References: <20250425135946.1087065-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EtLSrTcA c=1 sm=1 tr=0 ts=680b9574 cx=c_pps a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KzwQcsJEF2YzTSYNgzkA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: f3CxVGQhVGe1KhTHZsyDM_LA0yXLlh12
X-Proofpoint-ORIG-GUID: f3CxVGQhVGe1KhTHZsyDM_LA0yXLlh12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA5OSBTYWx0ZWRfX9AFKwOgRG58w B+CVrVyoVCzYrd7TfVfksDUB+ReXZv8Fn9uKgPwUJw0swE5S717yV6CcsoTkijXhoAN/HMq8Wo+ ooIYwOm1YqbVWkE9iP0NV9dImldVVm+FGbs3+lKgNSRmVx2zm9SC3kssKCPRbfbufbSPdVvVOrv
 MSWs7TZ8Yi1JRvhU8YRR/KlB20HgupVySqJXsNAS/HhV9TSxkuD4+9fNuFhXK/9qd5VmGAAZkIF aHJdtJmp6HtnDqCmHFEN2JRaX+sSacveDAoV9T5MLcE6tfuWwdcbJWvAgwmDQBWwqy+3qdDCTB/ I9YF3/DKHZLD/eYSUAk7i4yud1M7SXUs5l7x/kkHizsCfa8Dp9YGXEDgHp3GxtmK7fQzjzI9zX9
 YvUpqkbeuqlYCczFekWncJj/cyx9m3iPgpb/z8hpCJblZY/zSlLwRHCra6bdARVCPsCRIHfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250099

Add the subpartfeature offset field to the socinfo structure
which came for version 21 of socinfo structure.

Subpart_feat_offset is subpart like camera, display, etc.,
and its internal feature available on a bin.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2:
 - Added debugfs entry and described more about the field in commit.

 drivers/soc/qcom/socinfo.c       | 6 ++++++
 include/linux/soc/qcom/socinfo.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 5800ebf9ceea..bac1485f1b27 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -154,6 +154,7 @@ struct socinfo_params {
 	u32 boot_cluster;
 	u32 boot_core;
 	u32 raw_package_type;
+	u32 nsubpart_feat_array_offset;
 };
 
 struct smem_image_version {
@@ -608,6 +609,11 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 			   &qcom_socinfo->info.fmt);
 
 	switch (qcom_socinfo->info.fmt) {
+	case SOCINFO_VERSION(0, 21):
+		qcom_socinfo->info.nsubpart_feat_array_offset =
+				   __le32_to_cpu(info->nsubpart_feat_array_offset);
+		debugfs_create_u32("nsubpart_feat_array_offset", 0444, qcom_socinfo->dbg_root,
+				   &qcom_socinfo->info.nsubpart_feat_array_offset);
 	case SOCINFO_VERSION(0, 20):
 		qcom_socinfo->info.raw_package_type = __le32_to_cpu(info->raw_package_type);
 		debugfs_create_u32("raw_package_type", 0444, qcom_socinfo->dbg_root,
diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
index c4dae173cc30..3666870b7988 100644
--- a/include/linux/soc/qcom/socinfo.h
+++ b/include/linux/soc/qcom/socinfo.h
@@ -84,6 +84,8 @@ struct socinfo {
 	__le32 boot_core;
 	/* Version 20 */
 	__le32 raw_package_type;
+	/* Version 21 */
+	__le32 nsubpart_feat_array_offset;
 };
 
 /* Internal feature codes */
-- 
2.34.1


