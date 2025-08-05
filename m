Return-Path: <linux-kernel+bounces-756741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C45B1B8AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDDA3B0034
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CF2292B3E;
	Tue,  5 Aug 2025 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fDHe3jex"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4427933E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412196; cv=none; b=fpA96LxhkbDHP6Uo+YPUfbe9tP6hb5uo1v7aCeW40DQu8gi7Cb0b7Y/m38DXYgtZBjMhksEZUrAAVrQTzOp8nvD+PW35ZDMg7PQc+PZDqic0D75uVz1Z6Nsp/rHS/BQlqdOtjmudxXKdrxBraRANjsUGyoxtmouY37Dqs3fw/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412196; c=relaxed/simple;
	bh=nBWEXQsygmIvIk8jgPIUAX212MjBTxOnfQSQBQYqzPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqT0t9a0YhXRDbl5H97n4g/peC8BOE2BmHAn20HIq0HQR7WeR1F41K2b1q9/T5ENnrYCd9FRoHJorLaChKR8aYvI8JEnqOKrCapKhMhOGXsbyHmKDPUtUKdBWqeRh640ZjhG7YF90WuHtdJEWqy5rDxKrBpuPRgAfwYgkIVkYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fDHe3jex; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575Ft8Yk010359
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 16:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hv30jdihqjoTZ5O1+BHgicFjeP5thjFR90f
	+0mrcaKc=; b=fDHe3jexkYZwPPGKJy7F2swAdK4gcYfVaZ2ysGacXOy+4tdFXPX
	UWGqAluR34H6so0S3k1StKae49FO0PgTZ0lBdtJ5ST5pvar71nQ1plGOGjZ7zrm1
	Dj1SyALsRk3iiHPlzHthrzAOqlnHDD8LAOsZsZAW2ZNYkrYUdLpPV87JBp4ewleY
	GpnL6AFbZ1pPtaWjf9TKAor+IJLaneI0uhjT62LXdzSSYkKrNo49+GZBIyTuCqG4
	0ytLr5TYRg3cJ0oXO8LL64VDY40AhqU55OmfJ1oG9Iig85nvYASXoBJmIjRKg+9Q
	K+ql863nrxDU1Z7ECEzlC70WtINCktNPlaA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489bek97pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 16:43:13 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4253124e77so2285426a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754412193; x=1755016993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hv30jdihqjoTZ5O1+BHgicFjeP5thjFR90f+0mrcaKc=;
        b=XP+ZkXXvGZA0DoDUelQ9vvlRKBcbVPIGMMqHji2+pLCNx07u3pIs/d25PdGok5Y2cR
         UGkwRUgwMScCTX1xj7uFh+XLCqtMoV4TIqG3VVwGnOtT1vh2nfx/tTPRcioms4x3a8vi
         smQII4xiUSSCnl8iFRGaQy3b6ibUm9xFVEQetKwaB9phEbIQDs33j2Fszh7yXgYIISXm
         U5cq2s95CUA09F5Op3na7hdi0PVs24ypoLue08WOQFlcj2gEsGjk6ru+uZo9fhTKKxsB
         KWMUhiEuqxlNTTet/xfR94d99YBM0aOcBfxgJzBrdoCXeVQCKQlSpJNSRmltQfVCpIPG
         UsGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkYie1sayDupe2eGkG8MKTw29/7vmYEIRejP8xLaIXF7fBxz3I63rau4HEw3PE7BVw1IQH26ZVSP5keNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5a7q9LxVYAUBMRIu4zY441RMbX0hUPhOZbs4WZ4uYfS7FjSD
	Jtjpz5pbKCPSaMVb14/zNj8Sf7Y4qnxTlz4jYkynF9owj8hYgmdnEKkqWga4IFpuAf7wg929BY0
	spUdCKrGW8qPSYJf3clho/OHG8qw3j3xwAshDDT7Ou4erB7U3fKP6LFb/hlMNc9IPr0Q=
X-Gm-Gg: ASbGncvhmAyTXh9PVQQvvbw/BigMmHgk6c96qrswAFEshdw/gj9zr3vytu2DdyDZhpr
	IbLqaXoLAtminaypHXTfq4jAHDV1fxMgjJbK20bhchdurmD98/t3w2UqvmJV5WMT+pG0QoUoS4t
	1iYY2B6+FiqsY7r+JMg0jNGV/Pou53vTwal/c12RlcvokJ9TMtbLBqA32wZYmvj7Q01ljcNePXl
	s/3/LBvmusThEBTxKlJ7KZCof1i9eTai89W0O9OGA1nwp/+bSXF0b2XvzZHa5E/EbbwME5afLuF
	hOwtKI9LIi9PhQWbiL7KoUgtAzZdZRC7HjsMboBEyctlgQsKPLQ=
X-Received: by 2002:a17:902:e889:b0:23d:fa76:5c3b with SMTP id d9443c01a7336-24246f721fbmr218343805ad.22.1754412192657;
        Tue, 05 Aug 2025 09:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG19NECaSamtKmV1ToEgyAxx1m7KHOpQTVdLiTHMDu1lnYZHtJCITz8j/23vDlW8kqUI1HB9w==
X-Received: by 2002:a17:902:e889:b0:23d:fa76:5c3b with SMTP id d9443c01a7336-24246f721fbmr218343185ad.22.1754412192122;
        Tue, 05 Aug 2025 09:43:12 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e81dsm137414025ad.46.2025.08.05.09.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:43:11 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Fix a few comments
Date: Tue,  5 Aug 2025 09:43:08 -0700
Message-ID: <20250805164308.23894-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=689234a1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=q6EcQpUjypoMYbJrLQEA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDExNiBTYWx0ZWRfX/ts4OJM7ygNt
 +kJXf6SvFqZcdCjbZ1JagdQ9eczBNSYfF3hgxRxUpiTvoheLzYI7TpPWfEmjKkpJ85D6OCbItUx
 BEV4xHrL0+Qpe5qEnnFmBaNaPTqSHLyuyna8qOeaa3H3hq1U8kwYVvHTdQNEnJ3Ptr0HSiTAceg
 vqwEmGOaeWiFXQFXWkCY0OShAmBMg/pGWJ649Rdwtxk9THA9m2/QDHzmjI5UElCEBI/nudgWuqE
 au0NcvENavFguSt1bZzb3J9uO8n8forKsDBupul+vj+HDteAi2RcilyazmzJP9awfiGU35+ZVHu
 Up0TvkETO9AbUIL9Jbq147j9wIEY0It0+O9EUD9EbSy4SJk987g8Zebl4VlA7WQn2aLEcc8MBY7
 ygBNRCYEPoZEQlV+JM5zRVvB9qtyKkJcU2XVJwN1hQcvPuHb02hbCy6ew1c1ScHXrxlMRx92
X-Proofpoint-ORIG-GUID: xvEhSDqoXqZ8mW__yexjYDRLDo5XJMjJ
X-Proofpoint-GUID: xvEhSDqoXqZ8mW__yexjYDRLDo5XJMjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050116

Fix a couple comments which had become (partially) obsolete or incorrect
with the gpuvm conversion.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.h     | 2 +-
 drivers/gpu/drm/msm/msm_gem_vma.c | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 88239da1cd72..751c3b4965bc 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -100,7 +100,7 @@ struct msm_gem_vm {
 	 *
 	 * Only used for kernel managed VMs, unused for user managed VMs.
 	 *
-	 * Protected by @mm_lock.
+	 * Protected by vm lock.  See msm_gem_lock_vm_and_obj(), for ex.
 	 */
 	struct drm_mm mm;
 
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index dc54c693b28d..d1f5bb2e0a16 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -319,13 +319,10 @@ msm_gem_vma_map(struct drm_gpuva *vma, int prot, struct sg_table *sgt)
 		mutex_lock(&vm->mmu_lock);
 
 	/*
-	 * NOTE: iommu/io-pgtable can allocate pages, so we cannot hold
+	 * NOTE: if not using pgtable preallocation, we cannot hold
 	 * a lock across map/unmap which is also used in the job_run()
 	 * path, as this can cause deadlock in job_run() vs shrinker/
 	 * reclaim.
-	 *
-	 * Revisit this if we can come up with a scheme to pre-alloc pages
-	 * for the pgtable in map/unmap ops.
 	 */
 	ret = vm_map_op(vm, &(struct msm_vm_map_op){
 		.iova = vma->va.addr,
-- 
2.50.1


