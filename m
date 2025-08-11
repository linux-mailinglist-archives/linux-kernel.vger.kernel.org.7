Return-Path: <linux-kernel+bounces-762307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A96B204A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA0684E2B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B871D8DFB;
	Mon, 11 Aug 2025 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o6+e0wPq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133E335C7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906249; cv=none; b=c3PpR5kduaTUeB1qH16lQn2a1ncEgPVfMr20XmtCNIHiIG41051zKIGfQ0ut9yrdumXFJ5brwfgVd4Vwb7DDKnRi0biIZ+w/M5m/viezIEQhjuDuVqkV4G2Q8vCaIxUUJt83jv28G+sROZ0ST/A3ry5Mcdbr86s5Q61Ot1Yng3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906249; c=relaxed/simple;
	bh=y6+JQicQ8veDn48MKkzx9YTqFfDxKzh1n4MUqXocFNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kc0HMMI1OCoRpdaWUfT9BhXATW35WNNDwEukrSaLNWq8+unL/9G/3sjQ+NQiNzkJz2w6UE8WfKSvQV6kWPWkBZ8HthTr0TF8ACfzHMC+k0D1fp26fT7eVeUHIGxNtdjcCWp34DxI1jXTSsn5Cmp9iPhDYFHplbD1TXytq3LB5L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o6+e0wPq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dBU0029228
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hvDa8O9hGACyFWVvO4cHOr
	7fhxyH5sRWAFv1BUJCgSY=; b=o6+e0wPqLH1ag2mF08TNpUTo9oqgfVn/vZFRxm
	8pO7d74cl/OSIfqcLD2tUDAoesLM2lPMcusPUzu3MWkZeuapM6FMOtHfFA9HiDou
	L/mEGu8rwgPFq5LPYMDqaL39cLx7g57JmXPFwE3o90N+7NLBkbpSWFkQPiyKsxZy
	SJHwavhIRvIAU7mRQvkeq2SU4lGMFoKNHwYXYzdzB1imMq5Kt1Z+rg/HXPhJUvp7
	eINrdC9Gqy9Ffd5Dp3atOLQc8gtOCowZ1rt6DLnAF6pfow9xI5asurtab+UT2KRH
	9efkaYo/21LEJO4o2QlgEUkFNWEgY0AZbQxm9HgW4VE55MvQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmbv93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:57:27 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76c19d1e510so3949903b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754906246; x=1755511046;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvDa8O9hGACyFWVvO4cHOr7fhxyH5sRWAFv1BUJCgSY=;
        b=C70MjY8aOiKT3ovVqO+KXWagem8Iz8p0VI5aCtn0HTcTpUYs3TCdDRT3tLtEV9iWjJ
         7+J2527T6G4NKpkL9vmf+GBY14SZ9oYMZ0dCyvb7SG8fSm0hdhVYdDdh9hBHWDrgr//G
         /SUfWN8i77mcPlL66vnjJMVo1BsWDSuHLNkYiBaaub+zqTNuwPrbkUFOWk46Ub4oHkSj
         NIoucrt1QskVfKvqqO8W8NPIaAuDOWe7UR8NKmiyro6y6wBF9xxfJuweW3MAs8f3vN6Q
         FhJxyKfIgj81IKZBJkKGc61kQ3NUfRcHEpbSQCZ/fC5h1K0QGRgUsMH35jRxCVzVN9On
         FifA==
X-Forwarded-Encrypted: i=1; AJvYcCUNflf8/2oRW9vch/HsHr/B/LHGpV0pZMMgOy7GpyiAi5FKwSB0KVBx2KBGLPF9cZVk1FRTWMoT4h1f6GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykXHN2f+SEjiD9px5L4GS6qmk5T32Gr9+esEPqSUGsWDLv4Ga1
	YpptinHewy8nPme21gYZWOZAdvFQ+Gp0SmE0GyCVbuAzgzsXSnxrfCoBG0nupEFHHEQttX0E1hi
	FF9BRTOGo70QqenKJp2IHCIMNIA7C5di11SSk2/9rKh2YjodNs0bBrsw9FqN+ewqiPz8=
X-Gm-Gg: ASbGncuAJ8roq0DudICiUkUFxja1NQAwAI0HCkk05rKW++UKtN7a8hyfTblPg4Em+9b
	rmOLjYeL00XsuthJ9NJes6a2t4aA4NvmjvYyP+/oZqru6vJiXVC0fm0MbyNhaeN9lFDqn1JT5q2
	l5w08uWH7qJ6+NiEWDa3dwVZipQlI0YPKAp7qtRBHHcOnop0Mm8ADdNEesZpERjO8Q+Ix04PzqT
	E1VvK9axnU+ar/KViesSfsup9t/7+YgKSXH4fGAnlwWx8egdVGpW9nGWQIA8YPw9KDmbzl6QeU2
	nBa0Yv8bxoHF+o9N6LOG+HONlMBnNvU3cbutnVi7FxXAz39vCPIJTR0jEcfYournPIlPBEdHmty
	B1XHPG6Qq7Me7neuoQACc0g==
X-Received: by 2002:a05:6a00:18a7:b0:76b:8b13:e06a with SMTP id d2e1a72fcca58-76c46177ffcmr18799314b3a.14.1754906246190;
        Mon, 11 Aug 2025 02:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdghApAGzGX3YDSAAQZKY23C1RLAPvbfQ/HBZ35o92nHPYZlaSgEACPUYsZejQeE6Kx3teWg==
X-Received: by 2002:a05:6a00:18a7:b0:76b:8b13:e06a with SMTP id d2e1a72fcca58-76c46177ffcmr18799285b3a.14.1754906245775;
        Mon, 11 Aug 2025 02:57:25 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c5f493178sm5787371b3a.49.2025.08.11.02.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:57:25 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 02:57:20 -0700
Subject: [PATCH] coresight-etm4x: Conditionally access register
 TRCEXTINSELR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-trcextinselr_issue-v1-1-ed78f3215502@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAH++mWgC/x3MQQqEMBAF0atIrw0kgajMVWSQoD/aIBnpdkQQ7
 25w+RZVFymEofSpLhIcrPzLBa6uaFxinmF4KiZvfbCdc2aXEefOWbHKwKp/mOSbNqZoETBRCTd
 B4vOd9t/7fgDbFTGfZAAAAA==
X-Change-ID: 20250811-trcextinselr_issue-f267afa0e5ed
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfXxPv88CylgSXm
 1DRxgcBRJmTeYORlblS+ANq/7wqYGGSMX+hlffrqO8LOIuOoPy9cuchH9CNSwA3fwJkqi/r7N5Z
 dIuXP5TeddkhbMmrVcf8hOs/BF63qUEgi83UVMGeqSCrBggyu3mIRtliid2DIFLTVrFA+A2RlbD
 F5qdP2W3s7HNjh1rUCzoSF81W2SKC+gQFmIKQ6ZSYkJqfN24FxfneSJnBdjACoUzFzOaF/+3aBL
 S1D085nCCvVwtPFOQs2IcVjXo9RKXaZBWFmhgnaaQTgFD/J5gPkNKdi/Pg+BjDlHGvz3clMAWTr
 n0py5HU7fXyJFqlHaHqyhoa6CPRaNMwb/pJxvXQQpQmz4gKJSeYcmUGRrX3+NCxf/INVrDxqclX
 zb+5o5Pe
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6899be87 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=HcK5dDk5inTH1P41ETwA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: cX73y8njNSIjKaw8QA3hk-SkeVQHZhrq
X-Proofpoint-ORIG-GUID: cX73y8njNSIjKaw8QA3hk-SkeVQHZhrq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1011 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

The TRCEXTINSELR is only implemented if TRCIDR5.NUMEXTINSEL > 0.
To avoid invalid accesses, introduce a check on numextinsel
(derived from TRCIDR5[11:9]) before reading or writing to this register.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 ++++++++---
 drivers/hwtracing/coresight/coresight-etm4x.h      |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 42e5d37403addc6ec81f2e3184522d67d1677c04..8a9c4caceff0165e4fce7ac4250f3e16ccc1d34e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -528,7 +528,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
 		etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
 	}
-	etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
+	if (drvdata->numextinsel)
+		etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
 		etm4x_relaxed_write32(csa, config->cntr_ctrl[i], TRCCNTCTLRn(i));
@@ -1423,6 +1424,7 @@ static void etm4_init_arch_data(void *info)
 	etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
 	/* NUMEXTIN, bits[8:0] number of external inputs implemented */
 	drvdata->nr_ext_inp = FIELD_GET(TRCIDR5_NUMEXTIN_MASK, etmidr5);
+	drvdata->numextinsel = FIELD_GET(TRCIDR5_NUMEXTINSEL_MASK, etmidr5);
 	/* TRACEIDSIZE, bits[21:16] indicates the trace ID width */
 	drvdata->trcid_size = FIELD_GET(TRCIDR5_TRACEIDSIZE_MASK, etmidr5);
 	/* ATBTRIG, bit[22] implementation can support ATB triggers? */
@@ -1852,7 +1854,9 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
 		state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
 	}
-	state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
+
+	if (drvdata->nrseqstate)
+		state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		state->trccntrldvr[i] = etm4x_read32(csa, TRCCNTRLDVRn(i));
@@ -1984,7 +1988,8 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
 		etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
 	}
-	etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
+	if (drvdata->numextinsel)
+		etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		etm4x_relaxed_write32(csa, state->trccntrldvr[i], TRCCNTRLDVRn(i));
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index ac649515054d905fa365203bd35f1d839b03292f..823914fefa90a36a328b652b0dc3828b9bddd990 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -162,6 +162,7 @@
 #define TRCIDR4_NUMVMIDC_MASK			GENMASK(31, 28)
 
 #define TRCIDR5_NUMEXTIN_MASK			GENMASK(8, 0)
+#define TRCIDR5_NUMEXTINSEL_MASK               GENMASK(11, 9)
 #define TRCIDR5_TRACEIDSIZE_MASK		GENMASK(21, 16)
 #define TRCIDR5_ATBTRIG				BIT(22)
 #define TRCIDR5_LPOVERRIDE			BIT(23)
@@ -999,6 +1000,7 @@ struct etmv4_drvdata {
 	u8				nr_cntr;
 	u8				nr_ext_inp;
 	u8				numcidc;
+	u8				numextinsel;
 	u8				numvmidc;
 	u8				nrseqstate;
 	u8				nr_event;

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-trcextinselr_issue-f267afa0e5ed

Best regards,
-- 
Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>


