Return-Path: <linux-kernel+bounces-727440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 878ECB01A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777201CA673E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E602283CB0;
	Fri, 11 Jul 2025 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pkscwszf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E71DE8A8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231794; cv=none; b=EudO9D4tQl3BXDvTC7zlTe4Qs4wNTL3p6HB/LzFza9+7ELJUeYeSdQsEEXzXdK1/bDYpcxrE8lSA1Z556yddpaHHGKD1ayS3RGFE7H7zz3X+XXU4ay0swzWI95V+QOjhYcHlkABXwfoPNpWeOSFjYyDzMrb03Y8TGt5KnNI0y6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231794; c=relaxed/simple;
	bh=BHQtfj7pgtyPHgq1LJMellEr8B+k05wx+dKEVu5VrUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sPmUSuvJJqrs3xBUyYp52CpftQQDerwJ0W/7t5ThjIzeKIixtCl3bOKO4mBEQ7+EaC4BcxpJs8wdKt5DuJ3mEmsjKdc6HnxeyokW68u2LLmegy8zMY8n0CO8P88Dx+raq+2cqkP/4gXfZLEo2Ym6QNdtQeA+eKvZL0TgnS9LKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pkscwszf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAZK1j003869
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=069tja+lXC6HN/MWKBoEA5
	Mvyzs8gI54C/BfhuxYQAQ=; b=pkscwszfqadDTE1UegMLq6DHfsU08rSDoBl7B/
	T0jGvvawLrd3NqyCfFek6IJgVNLbJbrEg8x5PXnLTTFEMQBk5IkXJpFNrh7/PxN9
	+/tWaa4jh7hUA3VAh19x+4naY1AC9zRSAkW3KlZFobI0MwNTxMx7mf4tMEebIn3L
	gAkJnGK3DeS31kWpxbunwhQtftN08PalrRIJ785XO3kCfR3j7fHIc47+9A8VVmGk
	1w9L8LgJbI2JEALWCuGMoJLSTkEM+n0A6KBafoZNm0uFErYgGyCUxXndVA8r2quG
	JlCYKPoSsFjnodaRMIobn4s1UaEUy0a3ie37VOH9LHgq+cig==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbp0db0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:03:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3138f5e8ff5so2237738a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752231791; x=1752836591;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=069tja+lXC6HN/MWKBoEA5Mvyzs8gI54C/BfhuxYQAQ=;
        b=HLKZh912MEolIJGokQdpv+krmtkFu1BYp2uHqv80OwjXTlPWBx6BcnvTsig3UGCJ/8
         M91y/T2czy5qYm+HOEnbrVzd1AoyfqmaKr3jxVIMXMvWg7+CyVIpvvfjwRa0VNTS++Me
         GMy5+V+m3YSUZW+wLkfoKM00OBMsZD+YR3PUyJWdZVOAo8yys170FlknAx8vdQxyNgDM
         rItxsXOWIlXvz+3D0XBXWmwYPQ8gs1shPlh6oX1g85XuEnfjWKFiGvO+cvx02atmIUOF
         d8+N/txjT+LRDzVinXp/NkXLR8/Waz9vOYNULAAwV3qatyoju5oJBj1Bf9Q3rMTMeiNX
         6G3g==
X-Forwarded-Encrypted: i=1; AJvYcCW9EyEFG5eGjAEo3YVuP1y9Dsc9MR6vJhLig5GS7gFkNBPvpUt5hopWXIelFbDWawzDIqMpoQKz0m0MuXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWcbTdT5zmaWAmTVxAh405STtuWpTZVSGKRI4r8qNVjgRVtGKu
	1dU5RWMpdQ+QqLsSwWrF4DLruoyX1Mu99aCleJJSe6jCJLdSU7LT24od6mxCv2OiFsUD4JEnr2G
	yV+lNdeQmUSNq1k2aCvjzFIY0/AJL0HkrYWMIcurQpz6nyL0l/yPN/ZrTTH5ykEQNrB51desk/4
	A=
X-Gm-Gg: ASbGnctFH5nbbzKeqNugmVAl7EDZxkT0wP+UW02p8ANY67XkYyb4G/jxf6r0EpZBRD6
	IYG7NWdPIOXWrX+6vGipD22kS2PVFSGCKs0NYAqBOrpcK/F77s0c1qsoZNO39/UDc1k1SL4z/1j
	2ocGyW2jGNxQPACqJPDTd4ZCy5KoKcZNJTfUX1JacB3qk0bTkuLDiM2BPk9fiDmOcmxDWi0ek3o
	uZ21UbiFAEYROe9YBu3VkWRGv2I2U4I+JXioDECLHUN+zF8r1McZR0NWO1sUidvIR5CxA1KupJE
	kiSWVFvBWPVPMfSZEfuUsEey+533WwdZYZIs80nhTydWHufwZsZjkAysKUf7UbakRm0gerqPvL8
	AS5JKj59ExYiB2jU8jLMkX5Ex8yMP+FCM4a+Mvhy3nZltASp2qeW8e2yKSpn6koiFggCxWt06gv
	E=
X-Received: by 2002:a17:90a:fc44:b0:311:fde5:c4be with SMTP id 98e67ed59e1d1-31c4cd158bamr3859059a91.35.1752231791362;
        Fri, 11 Jul 2025 04:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYr7N8GJzEJcBkBd1R3pb1hOZYzeTwsHOoGn3TJWcYZbpgdQRuBgBqdo3m9J7JgwKDnw8EjQ==
X-Received: by 2002:a17:90a:fc44:b0:311:fde5:c4be with SMTP id 98e67ed59e1d1-31c4cd158bamr3859024a91.35.1752231790926;
        Fri, 11 Jul 2025 04:03:10 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c301eb975sm7942160a91.46.2025.07.11.04.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 04:03:10 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 16:33:06 +0530
Subject: [PATCH] soc: qcom: socinfo: Add support to retrieve APPSBL build
 details
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-appsbl_crm_version-v1-1-48b49b1dfdcf@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGnvcGgC/x2MWwqAIBAArxL7naCVFV0lQsy2WughK0Qg3T3rc
 2BmIgRkwgBdFoHxokDnkUDlGbjVHgsKmhJDIQstG6WE9T6Mm3G8mwv500U9lbJyrVa2nSGFnnG
 m+5/2w/O8FVGgmmQAAAA=
X-Change-ID: 20250711-appsbl_crm_version-6d304c851a8f
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752231788; l=1328;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=BHQtfj7pgtyPHgq1LJMellEr8B+k05wx+dKEVu5VrUQ=;
 b=hOFxXFWRcLckklQbrYaheVxcsr3B88bXGTS5/aHoeoCVEKm4urcAs+lzy/GI9AA0JTxY5r0d4
 u7eAgKj5HcvDiHI6mudO3ibm/5N3+8xEmj//na7Mln6/chl4ongCpRq
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3OCBTYWx0ZWRfX2OE4UqYpj2vQ
 IMLQeJCBfJN4mk4yGhT0P9E7zseVlCaF11Urw0+/MRQodqdGk+Qy/Y7yOiyEXtG5npzdT+ly1vV
 mE1eDRszgQ9RT3jeQuwLbx/qhJI2Jmewung+xmTGt5MGGEjadBkbkZ6KozgckEyPIyzR2RTBnco
 SQhIi87QOV/cot6T3Jrktg7UpjI8tXNG/BepqULB5RdRq1pF1lfIny38DD8jVnFL2y7E3bt1pp+
 3t+1feq7/UhemCG5/oYbChvlHKZHXY5SPvCg1P8A92Cwve1Cngv7NauIX9901x8VrFK8rAl4Bqg
 JS0GnCHhV0D4oDFoyheGS5npbDbLqsHZMGO3rg2hlvQmnw6zid4ZFJzMET0ojot0N56UIgHZEss
 JR66OOu3vwl0uAqe6vxZGLET64CqyZTCf5Guy25O8aYEAf0QFNrvVfkDN+jX4FkkTlxD88oC
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=6870ef70 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=0tr5gUXQH48V7W0Z41EA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: fIqYjHeygRsYG22v4uoxkSiaSOzN_rZY
X-Proofpoint-GUID: fIqYjHeygRsYG22v4uoxkSiaSOzN_rZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=815 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110078

Add support to retrieve APPS (Application Processor Subsystem) Bootloader
image details from SMEM.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/soc/qcom/socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 391380820f082d8daa5c764d5f3c44e6240e18a2..dc8796ce5fe252cd03e98cd420c72760bb707197 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -38,6 +38,7 @@
 #define SMEM_IMAGE_TABLE_BOOT_INDEX     0
 #define SMEM_IMAGE_TABLE_TZ_INDEX       1
 #define SMEM_IMAGE_TABLE_RPM_INDEX      3
+#define SMEM_IMAGE_TABLE_APPSBL_INDEX	9
 #define SMEM_IMAGE_TABLE_APPS_INDEX     10
 #define SMEM_IMAGE_TABLE_MPSS_INDEX     11
 #define SMEM_IMAGE_TABLE_ADSP_INDEX     12
@@ -56,6 +57,7 @@
  */
 static const char *const socinfo_image_names[] = {
 	[SMEM_IMAGE_TABLE_ADSP_INDEX] = "adsp",
+	[SMEM_IMAGE_TABLE_APPSBL_INDEX] = "appsbl",
 	[SMEM_IMAGE_TABLE_APPS_INDEX] = "apps",
 	[SMEM_IMAGE_TABLE_BOOT_INDEX] = "boot",
 	[SMEM_IMAGE_TABLE_CNSS_INDEX] = "cnss",

---
base-commit: a62b7a37e6fcf4a675b1548e7c168b96ec836442
change-id: 20250711-appsbl_crm_version-6d304c851a8f

Best regards,
-- 
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>


