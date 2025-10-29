Return-Path: <linux-kernel+bounces-875615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094A9C196A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0979F46408E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F73322A04;
	Wed, 29 Oct 2025 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wk+CjrNV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NRT590Hv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255D2F619D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730683; cv=none; b=b6RoRifva4EcuTPCOA7sY4JhJ2QGiQ+mSx7KYkWrPYJ880TG4MgE47EoD3rkQFGIJxaqnmpmnj2bFt7jF8Yaf6VqBtkokM+ZSpFotmkvf50QgN7jxf3aXNrLdoQCHds6E+6lnMlpdlP8ROs5tfdDv8DnTAHd6UasVFxVCSbiOmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730683; c=relaxed/simple;
	bh=JC6+w4UGAYirolruYvWIOp4qN/wza/Ui3WiUhC+0WE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Kyd7A6eYlahSuVgMm8qmv4sdfhkvo0O2XYxTgq7qWFq6PCLaB8cbZMUeEFHIIVQR0EOh8VeJJFnSIfVzlNcAVtFsdLO5/h+mXlFbs5Y+uwVqFHi9Z/sq+BJQP0xWUAHZ21Rg+JTg+IiI6lfHhU/6zgSZ/Wi83OtDDt456iuRVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wk+CjrNV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NRT590Hv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4vFbf3755299
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jXxVeddQ75KBTjT8urxprG
	/yANbxXDxuHHoHCkUPtho=; b=Wk+CjrNV1aAcP6YZ81jZKS9XHxsPWAZORVEWe6
	YXEKQr0FlOq+ZD5zbaKmOt+15D+0kkX3rneRMODRwQBiYwvYxPLPy/7gVUsBm2nz
	07ksIHLOU1o1Di6BcIGCwwrSNa2ZgD2nmcO3iFOeH3FvGtPXGpHPgDtYnMqR25ub
	QnpGrttd2MdxrXVfFSBTq+ZU5y+bnHTC5Btf1BxfoUcilsdN1bNiQoWKdFTQ70gJ
	lAPIEY5T/jKnt0GQDx+t4DncgjiD+grMunqgWGjFM+C/aPCUgdF/ViqUgr9SF1kh
	Kprs1S1BUNZmgBaedV2nhCrUYORjRo/AjlUJFTPkhE9loQPw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a021g4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:38:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290c9724deeso63547285ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761730680; x=1762335480; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXxVeddQ75KBTjT8urxprG/yANbxXDxuHHoHCkUPtho=;
        b=NRT590HvhsN9s8P90e/cjGpYMonRLWMeaGW5RtimC0eje4NrU8bs1A7LcHLfA+C8W0
         vxNYbYbvmS5Id3CUazohGvick7v3Ye49k63skzx3gGJ0Lr1ggmhbvo1QrUAEN3CrHmin
         guzvjuK/xTTCGlYLHjcf57Sy6n8zIRlBBvwscNAXH8hkvg1uXbBLjoQqjxkCeR64hADs
         cQnW9M5ZDbeB61SZ11xDamDAoxsU+cAwKtkaJIf7VHKJXwIiJfMIfkAJMOPvG2SFTeQo
         gHV4V2Y3JVkyWBCxgZA9Su7uitSACU1+LbxqN+vsGyCieQdcVosyCW8WAYWHB7mQOF6D
         FZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761730680; x=1762335480;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXxVeddQ75KBTjT8urxprG/yANbxXDxuHHoHCkUPtho=;
        b=i5jLfQa+aM/ZILZ68LyM2YNKgL4JIBwmQizPoSz1BorBXfVpP0l/Ui4XZQsvliA0N3
         UjbxilopynNyLlZjmQXwsD78bNXbMDYNLdGxajtCEGPhUptHWHPe4h07yuhMbimyK8ZL
         wR1dBefbMf5o/vDS5sd3AMNQD/4VXblv9zvTgjI4f7crzFhWGPIgwOk4hLrIHxfH/esw
         GA0PWHUjI0TB6FB3shuguOFYAvwFWJ1Qc7XCd4ONOSsCf9xLlFhBhsIRFRMSYzSbIwq+
         fg0SMfohdLoRr9VzSrAx/wAq//WVzq4LNxilF5YSaqTXSfk0BWE4q0wvBcTQFZxIdH5j
         Uauw==
X-Forwarded-Encrypted: i=1; AJvYcCW5KVzrKErFiA3LrFpbXata0wZw2iYlCYyet25sBTSiqfeXsXVXmKEhyc00Wwk+a5N4Okj4qV1bojJsc78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx85Ij8Bx+idCnvtSHAW4NF13btUUvb+/ngArn64P48z2zPtfLm
	MLsU7r9ImzkEj9riK5SD/SdBgrfQRVqCe0t1m7cwlH8QNnmlM171XNYVHqu9e4kyNsTlRghTX1Z
	Vp0RmHrP8j4nsDmiP8AC+xHrbwSub3/l+EJqxkunVpzmCIr2qsEo1cCRzBWHuCOey0ck=
X-Gm-Gg: ASbGncvwGt/DNiONiL3qr8eZPVCyzuIunoCd2wWGLIVHskJ+JNhqX6usZOq3vLoJs+J
	qp1GNFiVlFS0IUqC+Iydjsri+oFjCDG0CKys1AIRhzxWeb87jCNg/mjb2QT3Zo14jM4QLae1336
	5bKNg+A5f2XvSGXQ8U1kOXl2lX8u0OZpUtHMsZo9JDsjKgNTp9+NWOi2nP3zI/k1GoUxBt1VlKs
	io3n2BMGCQyTXrc7JUl546d2V9wOUMiAbLPZSXHyDK3qiFrJmf0HBJ5Jwds4F2utQ/tAtA9Gywv
	eYjQYFKiUTKUewNH5dSSS5iOdZyMY7wfXlJVIG2zU61r2/QhVQ6526A0b96m1/7zvNsKoECu23V
	IMmz2v1WcIVXdFXngDIl3bxc=
X-Received: by 2002:a17:903:1206:b0:28e:7fd3:57f2 with SMTP id d9443c01a7336-294def4764cmr24680015ad.49.1761730680472;
        Wed, 29 Oct 2025 02:38:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxdopI7TtLXoPbY3Gmaat4ZKTHDubtgAAQT6Szf0K6jOfcW8jjiLeCTo3u9Ouz0RtJlD5xIg==
X-Received: by 2002:a17:903:1206:b0:28e:7fd3:57f2 with SMTP id d9443c01a7336-294def4764cmr24679705ad.49.1761730679956;
        Wed, 29 Oct 2025 02:37:59 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm147588895ad.6.2025.10.29.02.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 02:37:59 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 15:07:54 +0530
Subject: [PATCH v3] clk: qcom: gcc-qcs615: Update the SDCC clock to use
 shared_floor_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-sdcc_rcg2_shared_ops-v3-1-ecf47d9601d1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHHgAWkC/4XNwQ6CMAyA4VchOzuyVSDDk+9hDBlbgSXicNVFQ
 3h3BwdPGi9N/ib9OjPC4JDYIZtZwOjI+WuK/S5jZtDXHrmzqRkIKIUSBSdrTBNMDw0NOqBt/EQ
 cdYVQSVV2WLF0OgXs3HNjT+fUg6O7D6/tS5Tr9g8YJZe8kF2talSmbeXRE+W3h74YP455Gmx1I
 3wsKeCXBclSnS2tNro2Fr5Yy7K8AV2l+v4LAQAA
X-Change-ID: 20250804-sdcc_rcg2_shared_ops-ea6e26185fe6
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3MiBTYWx0ZWRfX/7bvfgQE5bJl
 Z5DmWSBHmE4JuO+O4xwjT9sSUzCT6WzAgnMCr7EHJ2r2hNLw0fvkFnPe9oCMfLSWy3/bz55BGN1
 ZBd3FVD4kQNlmUFIqC8140cOhF9QWwqvFEn3zXpqgqdTAHqxU+lhsTjhFpcrZNvVSsWMgP8kDCV
 +pC/XrADZMSOg+lS3IlerarIbQRTQIdGqsB7gTPYYpyEl7JSIHNIj4KDSLxy6JtAygWtsIAqNp/
 FCYmTUpZH/Sy0+QY70ixvYmMB9++211KbAcyHum3s+17CBidoT01eHxyamnubi1wL2t1He8eJNX
 qnu8Z1Jgj78ilJhgsN0xqcySsLq73rJ6++jOBPEtZYl27n4xNQTEHnN1VDPn+36nDJbFIOt9dkL
 CNPyXXnKdaye3BenQdtViRVZNp5gtg==
X-Proofpoint-GUID: 367f7uR4P-VEK8urFcP303U_RN0zpaqY
X-Proofpoint-ORIG-GUID: 367f7uR4P-VEK8urFcP303U_RN0zpaqY
X-Authority-Analysis: v=2.4 cv=epXSD4pX c=1 sm=1 tr=0 ts=6901e079 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=DT-4WzK0eFhaf3B0yf8A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290072

Fix "gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
boot. This happens due to the floor_ops tries to update the rcg
configuration even if the clock is not enabled.
The shared_floor_ops ensures that the RCG is safely parked and the new
parent configuration is cached in the parked_cfg when the clock is off.

Ensure to use the ops for the other SDCC clock instances as well.

Fixes: 39d6dcf67fe9 ("clk: qcom: gcc: Add support for QCS615 GCC clocks")
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
Changes in v3:
- Update commit subject gcc->gcc-qcs615 [Konrad]
- Add RB-by from [Abel]
- Link to v2: https://lore.kernel.org/r/20251024-sdcc_rcg2_shared_ops-v2-1-8fd5daca9cd2@oss.qualcomm.com

Changes in v2:
- Update the commit message as per comment [Dmitry, Konrad]
- Link to v1: https://lore.kernel.org/r/20250804-sdcc_rcg2_shared_ops-v1-1-41f989e8cbb1@oss.qualcomm.com
---
 drivers/clk/qcom/gcc-qcs615.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-qcs615.c b/drivers/clk/qcom/gcc-qcs615.c
index 9695446bc2a3c81f63f6fc0c98d298270f3494cc..5b3b8dd4f114bdcb8911a9ce612c39a1c6e05b23 100644
--- a/drivers/clk/qcom/gcc-qcs615.c
+++ b/drivers/clk/qcom/gcc-qcs615.c
@@ -784,7 +784,7 @@ static struct clk_rcg2 gcc_sdcc1_apps_clk_src = {
 		.name = "gcc_sdcc1_apps_clk_src",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 
@@ -806,7 +806,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
 		.name = "gcc_sdcc1_ice_core_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 
@@ -830,7 +830,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_8,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 

---
base-commit: 5c5a10f0be967a8950a2309ea965bae54251b50e
change-id: 20250804-sdcc_rcg2_shared_ops-ea6e26185fe6

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>


