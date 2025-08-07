Return-Path: <linux-kernel+bounces-758761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E424CB1D391
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A627B3BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D243523F42A;
	Thu,  7 Aug 2025 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nBdaCbm5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0361799F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552607; cv=none; b=d11AikUCSNlES43pzQBGkXo3yWzEYwmT9Mo6cOwcHwhuYqKeY6O5NB0YiuFEtka7PnbW3Tuk50HmBiLytmp16YmQNQc2V0xc1QDTnnc1gfxKMZNxU7KrlEcTck63L5VVtOy+iscAYE6lvtVtNKCVX/2Lro/pMVSnnzQI8p3yfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552607; c=relaxed/simple;
	bh=aJf8dgH4dYz4FeXdIaB9wlD7Vgy/o7rrXh0zl/XsgWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qrgOgBcjLxECPs0cBM/JsUM7zYdMQAZ5Awb+VwIFknietgRxd8vV1ChFseAblJIX7DKeyz7bdCRunbdTth7R2EXnuSyUmWqcW+iHf7HtTnNw4TsmLfKDmZkUJ3ujUzNlQPGplm60Mk3s3f8B4tWjLp6slGbkJ+vLKfc+knBG7lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nBdaCbm5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577248FF020326
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 07:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SdrbuuxHkEeQigeY7KFKAwRwQZ1v06KXS3A
	qG305+AI=; b=nBdaCbm5x8LI4sQsiTXL6sdEItOKhtIwIR4NWJd9vFS8SIpVBAM
	N+RzVIvi2W0ZmCoak2/+cJO/0KH4qzIviQZcXra7qc69fbVc0UvuiCCKqItUzlJQ
	lvH2/THLqc1P9DInQse5YBUs7Mwn/9M+ee90lRJf0VOkfeP+F5mY47BPHZNsR1u0
	m11Eu2vVsTZN8DvVRq4qAkIz7AP3hjqbalATTEHHqiQJnU98uVpT8pTkaR359kTF
	bKnwshfhDwMFwaFbPMHaraW6/UMZYEpWB2g9JXAqKgvnJqp2UTW+JQqVG4C/HkD4
	KzwjHLWvZkAqXuwWUzb0VxGNfJcqkgaqWGQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvvwf12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 07:43:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24004ac2ecdso11591025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552604; x=1755157404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdrbuuxHkEeQigeY7KFKAwRwQZ1v06KXS3AqG305+AI=;
        b=dH3719EwLDdUy18WJAXraQ+AGGQl2KFf6Iyg4DfKChpAVQMxQ841aj7lxfobEufst6
         5NIFK5hhkGW/QAYaa9DQaPaW2yUxcT1ttM5uk5lfljinANnVmLhRe6ap1mG2Prc3Fn2V
         5FSn2vqePgbc6pkMBRXVP7sOiMi5zYWAyFmfd9P1zv2z8m4S5gFa7PbeDLBzw/I/9c5j
         5NxBZqcO3BXXnI0ZUDbL/mTaMRjDuswBFUtYe5POSwOPGXh86lUTheFi7oozxw+Hjhpt
         bxcFECZ8SVK1UJm4QxtJkl1J4qOb8068lC8swm7o+OUaT0pdWOF4arptt9ROcwla7CEt
         dNsg==
X-Forwarded-Encrypted: i=1; AJvYcCULyxBkAfvwGMrUJwPznQtztqk8py9QbOlOsh5JLG1aI/ULfTgykhK8uE4tk6aj1CVjZSr9hvVECQUyT4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOqxOUVqDbRz1X3PwBdTPR+oAv9QRj8rFAJX67c1TPHGawAv/s
	9fD3T8bLUimwrUViCPOwf92I1veABdVOhmcMv6cTKs5cuVD4CMMG8Zxp6BdAvkxqZRgqn1og2i6
	sh0Vc4UGIqO8SX4zdscfAup6IeRh3UXoE58rv4VFcTqP6//2vq6T8lcXCHVOQpZvdN3I=
X-Gm-Gg: ASbGncvESDUec+rkXUnv/BsO51yNFhdfw34PJ4+WocDE5Dhze9WV7ZDR3V7Vtt5Nw0E
	+YB/Ym0JEsUmTSEQWQaYdVMb86pIyfBsq2YHYJXq9yHeXaPjfoNeCzR8wWv2pF/VBpmsJ7Bk5qk
	+CZAIaLNp6Wa2c3gzzTYsoZiPDVPkPICZZ5+geL51ATTJZP4RCRy6djvxS6Og1115ATYdRyNpBU
	ZYycYgGLSgfpZa+77/oULNupNoRa8wRNqh7rAe3iowssXId1kAXXREXV0mYWHLiDEEGyyyoF03O
	G8/QrD4x9osQQ8ls/BQXjr9koLnlr8IohrO3/U1oqMsFwRiDyEbV3+t4PeuHdiMbOhk=
X-Received: by 2002:a17:902:d2c2:b0:242:9bca:863f with SMTP id d9443c01a7336-2429f5bbc5fmr72030695ad.57.1754552604155;
        Thu, 07 Aug 2025 00:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHANSCJfj5IWevcX9I21BsXg/+4n+zB41jVKkCMdFHRNuqkAEqf/i9yKeqzmpgMCnYVJaYulg==
X-Received: by 2002:a17:902:d2c2:b0:242:9bca:863f with SMTP id d9443c01a7336-2429f5bbc5fmr72030435ad.57.1754552603705;
        Thu, 07 Aug 2025 00:43:23 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm178166395ad.39.2025.08.07.00.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:43:23 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [Patch v3 1/3] soc: qcom: mdt_loader: Remove unused parameter
Date: Thu,  7 Aug 2025 13:13:09 +0530
Message-ID: <20250807074311.2381713-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Lfns7A7mBUJp9_rSUEueWRKYglD7bBn-
X-Authority-Analysis: v=2.4 cv=GttC+l1C c=1 sm=1 tr=0 ts=6894591d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qLU0tmo_xPokh9XVZMUA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Lfns7A7mBUJp9_rSUEueWRKYglD7bBn-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX93CbF8ptRKgd
 +PVnyYqVhm1jI61zig9y2oJ6R1Gf+GRhFlHyZ27L8aPrw7/yr5C3Mi8+UNT1jXEDoQaUHmYrt69
 XTDdmBhtHi9q716Fc6ZDc9RDrBMK+FjZVDaABTSs3uibt2VaxQ52+9Njl5Lk+i0rOMYSTWfirbF
 5bfX9kv6lE/67G43j01cBIjHJ+VOsraz6yw9LRvnTeBLV1sDhGnCe58NxPtWvMkacE7NYsOR6Ph
 5nuKdjK6eiHUmF9CcP2AwWxEt495ssqy995VDAvhIglRiH6fZjbK198wqjVH+3auQwv7okhKXyy
 e2PtV28o0eibyYlvr/9d8BKPwOCf8t6kNoD/N0jw0frwkK/B3SnNEP6JNi+saHK4YVZxquadguk
 Zie8uZGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

commit f4e526ff7e38e ("soc: qcom: mdt_loader: Extract PAS
 operations") move pas specific code from __qcom_mdt_load()
to a separate function qcom_mdt_pas_init() after which the
pas_init variable became unused in __qcom_mdt_load().

Remove pas_init argument from __qcom_mdt_load().

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v3: https://lore.kernel.org/lkml/20250806172531.1865088-2-mukesh.ojha@oss.qualcomm.com/
 - Because of the drop of 1/4 in earlier version this becomes first
   patch.

- Changes in v2:
 - Added R-b tag and its order in the series.

 drivers/soc/qcom/mdt_loader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 0ca268bdf1f8..dfd15d189087 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -333,7 +333,7 @@ static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_na
 static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 			   const char *fw_name, int pas_id, void *mem_region,
 			   phys_addr_t mem_phys, size_t mem_size,
-			   phys_addr_t *reloc_base, bool pas_init)
+			   phys_addr_t *reloc_base)
 {
 	const struct elf32_phdr *phdrs;
 	const struct elf32_phdr *phdr;
@@ -459,7 +459,7 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		return ret;
 
 	return __qcom_mdt_load(dev, fw, firmware, pas_id, mem_region, mem_phys,
-			       mem_size, reloc_base, true);
+			       mem_size, reloc_base);
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_load);
 
@@ -482,7 +482,7 @@ int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
 			  size_t mem_size, phys_addr_t *reloc_base)
 {
 	return __qcom_mdt_load(dev, fw, firmware, pas_id, mem_region, mem_phys,
-			       mem_size, reloc_base, false);
+			       mem_size, reloc_base);
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_load_no_init);
 
-- 
2.50.1


