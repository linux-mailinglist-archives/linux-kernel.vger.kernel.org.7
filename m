Return-Path: <linux-kernel+bounces-884787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94190C31256
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7826F423FFF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955CC2F3609;
	Tue,  4 Nov 2025 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="asFRzB4l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FeyZzZbe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E232EFD92
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261770; cv=none; b=NWpe/Ba6uO1OpHODkuyBkGkdz6MdOCxbWFog1pMuCOU3ciGwN/nnOrB7PpEaZDr+WGGqZaQqPEhid5H3hq6FQt+W8oYCQqnn4bmKmfyghdZktsRxCAp6VfZewu3gsixgQO7vvmJy/otbx3OIx/dyhcpUuaDa2CM4OI5Yu96FP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261770; c=relaxed/simple;
	bh=hBXdul3tZxW+UflTZF7a9/uEf7GXrBBqnjbNYy4v6ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k20oL6RZ7svhlP9+WQn4XbgPwmAApoo5tATbIRc1MTZFfGQjLKzuQ1nn6WEe15Lz8DAjrTJuo7/Hf4EIHpv3Psrg3sqv55f8DZIrQ+0zm+C+n41TofFnihqO90STGLRR2sxBDeWimuVCmMp5jTFc0XkUmPbhT5JkOvz40eq2CJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=asFRzB4l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FeyZzZbe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4CgI8X1912539
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 13:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kS50UD6Sue9
	tYO27zvEv2Eatvnw8kndPVKBjjqjKB6A=; b=asFRzB4lqBCczjjerNma5etna4p
	nT/jwVcPqjWcASQ5+qEU/PF4tkVh1m7yNcovCsqUzcozbfULAWhgXR3Eu+w/oFs8
	VwzS3pVyphSv1vVkC8vDwfphV4jQM/EnbmBtt29PP7L3bXenOLGCtgdHpsLh1K7A
	1fD1gF2W0P88Yofxet0mtgeWL4pAfzttPtDUuUbV1CqpfD+CAxw+/8QQo+Vjylag
	ropRyyPqHMn+BJ24RwwQF6nzW5y8NhuyniPv69bDDw/GFIqHN8P3xgd95YGtKPkY
	4R4bDsjM2Ehcl5ux+mniYMoKZLkklsw+I0jG0ybhxe/FXQBLdEB+eY38qwg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70exjymv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 13:09:28 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b471737e673so9033366a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762261768; x=1762866568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS50UD6Sue9tYO27zvEv2Eatvnw8kndPVKBjjqjKB6A=;
        b=FeyZzZbeX075KiUW0Ca8fMW3u7jcm+MW6UvlQsfb8jbi5kZG5vrG7SnM3zvFyIMIct
         sHV0KQRNcUu76N8RkdWLc/LDB0D6Z8Rvv7SZYLh+5PH9I23ZLGLQSZgjDR/wToUFvIkO
         f0GHT0QsExjqh7r1/9mrHcPOTOZFH+LqfP9kAsIOF57eUGaCVzV1g71NqXpWAVU+r5sh
         4RYo9aznx/rSYcMqCZp7Fkv77j3nyGJ2GiMCYNhD9l8JYjKk4AxgdJI06Tmus2IFwBJo
         XgO+QIyTJPTPDKttO4gyFkoSFsmVZLQXAh7S5MkruDcl02nxxINSm5txrnrypYWThxlq
         ZMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762261768; x=1762866568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kS50UD6Sue9tYO27zvEv2Eatvnw8kndPVKBjjqjKB6A=;
        b=BSXdh7UO4LiPKjhgp+ZvGcUFtuqQ+iR1G4uGvdNiizzLWb41xjO2I6fIUCuiY3lCNE
         l5+pzeKCFucyG9TMPCGKZQN0bqrHbdipivUTUNXYEUPe5WtfQJn7udltWz/bm7L2D4TY
         AW8IoZJnoV/rqOQQRtMiSbXMmeOJsnydMIzalh/m+26PA9dtG8/U4+LtZkKS8TxVPJG+
         j/lfJr4RlTDDIfgX2flLJc7wttAsd/75NyU+pRxNimD0b64pk57sKaun48owHBsU7syD
         sqNovBza4DQn0a5ZUwxCsIUoMop9rMTKVBTJN9z7pVpwU5e6Rw92iyl6e3h0FHQpmsSD
         7Q1A==
X-Forwarded-Encrypted: i=1; AJvYcCUvJCY7E+Lwagspc5OzIZVa8S/PWIOT3vdN+WtCtcH/KLq6UIjRDbV0t7b3IxRcgDNxqs5M9zT//F+QqhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0Q5G8DTC4jx+dN+mdPjeHxAeIoTZ0io6yijPB6HsOLFjKuGU
	TJcrkPCoSiLoLx+vgzs1e43YEkpAd/wNDKKcOfFvpodSZCRJAcnRaGwmQS3YmR9fc0AjA/Bu6BB
	mo1IWpoFbOFvF/NLdBfDUJOMmfJunIbANndW9pCtmQs/dxOZELD2Srejfpq8hm0CMleo=
X-Gm-Gg: ASbGncuXLcfhynbY5iqZUvKJLNq3OhuDzArEfa6nNXDLsb+NPy5hHAOCQ7xuZi+gPRd
	vy+7HOsn2hNiwladyyhFQgb1OGIy9iMKYAz+5V6DBsSJS4xhhmshqqJ3dZRVXMX+nTGGc3vC4O8
	hxFZJiWBhoVIaQgkbz4uiqyNvBGCiqY4HGEdV7GVBYMoqiV+Fbvu3S1JHwz+WAm89CnLLyPSU7t
	rXmIcnaGN2+UZzLZT0xZeChprs/wDrly9K8Nw5M1/1u2DPoc9AHXFAS6eGGQ88NYN4KQBsz/S0W
	EWBs9HzFEK7JNMFfvaqYhR/BOWXOr2w9ZyfXZMvVbueeySdRDZGxi0E2j34Vg1rNVDZ0Age9bsw
	Ch0FxhTIaXKGZsT5GRYz84Kv6WA==
X-Received: by 2002:a17:902:ce01:b0:295:6c9d:1905 with SMTP id d9443c01a7336-2956c9d1b4dmr136218775ad.18.1762261767301;
        Tue, 04 Nov 2025 05:09:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExhsgU9nC+Hq4bQOucw237rkyN7rqKgYdPY0GVx/nL6Ylr2tteGOJuuk8u74ulHg02MbKKzQ==
X-Received: by 2002:a17:902:ce01:b0:295:6c9d:1905 with SMTP id d9443c01a7336-2956c9d1b4dmr136218165ad.18.1762261766473;
        Tue, 04 Nov 2025 05:09:26 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998c3esm27105855ad.41.2025.11.04.05.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:09:26 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v4 2/2] soc: qcom: socinfo: Add reserve field to support future extension
Date: Tue,  4 Nov 2025 18:39:06 +0530
Message-ID: <20251104130906.167666-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251104130906.167666-1-mukesh.ojha@oss.qualcomm.com>
References: <20251104130906.167666-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=APHuRV3Y c=1 sm=1 tr=0 ts=6909fb08 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-2KMb3mI12hdAPWKM-cA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: w6KB0qI63InHLJcah1X5GL_6lgQ8BgFQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEwOSBTYWx0ZWRfX42tAcP9tnvrK
 5AAqRZWF4G/aZSltpxwwE0evP6mqOLFrJk8NrFG2YVGcmRCx2OZohqgXimNZZDGP7HuY2EwS54/
 yNlQo8AO9+VQQ0OEoaVdiYNWVhHqAjY/ewro2vHHgxADzLhE/ZHBiBBhnWRDaVjBJvHhi0XyN6i
 Br2tCnhJzelVDjFhP3cehbTDE4DRrzkk10RHm3gZ6VY94yVB2U1oY3mbzcUw37bDdFfCm/YxLek
 nSuTSsCssBVP0MhUpwEPrTEevDSDQpg2gzc3nUbIDGAz+TCK/vAbX4tsaiF5I2+BQc9yXzQy0qK
 p7hdXCyxQimmIhcZ+ja89NOKciTvvnwRNhcJnEwHqQBbF//OIfFvjRz9dZU0PU9M4L1UpnDouzC
 SSWd7hwhDuSXvwWoWMoS49X0IzQcxg==
X-Proofpoint-ORIG-GUID: w6KB0qI63InHLJcah1X5GL_6lgQ8BgFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040109

Some of the new field added to socinfo structure with version 21, 22
and 23 which is only used by boot firmware and it is of no use for
Linux.Add reserve field in socinfo so that the structure remain
updated and prepared if we get any new field in future which could
be used by Linux. While at it, also updates switch case for backward
compatibility if the SoC runs with boot firmware which has these
new version added.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v4:
- This is new change combining multiple soc-info field
  update with reserve field introduction.


 drivers/soc/qcom/socinfo.c       | 3 +++
 include/linux/soc/qcom/socinfo.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 77d0b8062208..c5352e1fead2 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -657,6 +657,9 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 			   &qcom_socinfo->info.fmt);
 
 	switch (qcom_socinfo->info.fmt) {
+	case SOCINFO_VERSION(0, 23):
+	case SOCINFO_VERSION(0, 22):
+	case SOCINFO_VERSION(0, 21):
 	case SOCINFO_VERSION(0, 20):
 		qcom_socinfo->info.raw_package_type = __le32_to_cpu(info->raw_package_type);
 		debugfs_create_u32("raw_package_type", 0444, qcom_socinfo->dbg_root,
diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
index c4dae173cc30..ba823a0013c5 100644
--- a/include/linux/soc/qcom/socinfo.h
+++ b/include/linux/soc/qcom/socinfo.h
@@ -84,6 +84,8 @@ struct socinfo {
 	__le32 boot_core;
 	/* Version 20 */
 	__le32 raw_package_type;
+	/* Version 21, 22, 23 */
+	__le32 reserve1[4];
 };
 
 /* Internal feature codes */
-- 
2.50.1


