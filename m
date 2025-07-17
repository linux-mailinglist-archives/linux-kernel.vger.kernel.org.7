Return-Path: <linux-kernel+bounces-735508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31519B0904B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276464A0D06
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B0B2F85F2;
	Thu, 17 Jul 2025 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G8AscNDs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7918FC86
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765136; cv=none; b=RclW8zMLe9FI8QuHZxPFyYgR0Krw9equHyOoGyNCZXduhZaun1YehHLALKB+iX70csxGWoZu0oNKO6tlEc2f5ImVDrSJhFF+FHZrL19z5PqcdY0dkq10RfHZ6Hinu8xMyiZMymIbEMT0WoIJd98nT6dSOH4um9s/D0qNzIfw4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765136; c=relaxed/simple;
	bh=wVby8hajvrOhcz8Tf/GkjQJio0K2seS+IRlprPJ/ui8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TY/z+72QP7PcCAw0zmF5S+bYgVw7h2SdXoUYpLV+YQlqKorOnDre3DKB/xQGxXpWN3IFNo5CIo/AfmQ0KpYxNl3QRpQzysDjmTYYgrLG+kY5Gqfw/EMrMazx82ZOR7GVNYltv9hykzAC9bu4t1/D93KqqcDN603wJM+ihlnkWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G8AscNDs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCoOIc007234
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9pJTFEenY3rWVgqlsRhih+or7W0MW5NJ012
	2DRYZs8s=; b=G8AscNDsDktygSubSOSuuClEkViZ1voMSYdMFDhtdunPUR0EhvL
	v6b7c56Wiz2NOApId5/ok6ytPHNU392+vJ2g1mK9liSAvtsGTWHRrE9KL7DzDb2t
	/y08LE+AWiaJ/4HgY6+EjIRlfoBOSoO32iT403u9egb807ythASsuylRFeX3XNRv
	AmYy8llaKMTWLMnFEMsmwyxRyykTbtdARDkcmryxwZfYnevrkYkhzSZOiUWDsAb5
	G9gCoi0VuZ+DFb5VSMi/I5cwvZlmN4POT9bdcIkuoubQhCyx+VV4J1EEhERhUojz
	G+Okan//1h0laG764Evx4GavBX4xhqIwFEw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca9b86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:12:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748e6457567so1416541b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765127; x=1753369927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pJTFEenY3rWVgqlsRhih+or7W0MW5NJ0122DRYZs8s=;
        b=Es/y6OOLmjMC+EXmxMcW/RhXrdJotaglkOpn2Wm4xUgIQIaXwYIxx/b6jR8pG31dTb
         iDa8dt0zGU0OJyGwKF9xWj5nr7ijPEFEurSidIPncVdI0aT+YUR+GvBbwbEJ3iJh1ULf
         lFmXMpaFuZagPtg6xQwzLWrV9ANnfkUVyNZNCZ4G4pd1E1ULO/BJb5Bj2W+nyqtW/CRv
         lT2kj9OWPst29RYSPHy1b/6mRRiyFqW9mLmz0xXPKN3dK8WkHhpCVmLhNdVkZY0Ry/Gz
         a/WNVKWo9DXUjeir4alHwRLPwf8M9Pa4hQO/CbseRbbdNheArXwat7NwT5nX44oQzmyZ
         Hpmg==
X-Forwarded-Encrypted: i=1; AJvYcCU8hlKMIWGDG0GZp11cuNdzrliqpbogpEKUK3860TFwoiV/n9p61BJDuSdgtEncD8+OnrE3bb37/8BtNkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3cfGmlqblfH6P46VdCxKZnBjT2+Dsg5MvC+q6rZIwfXcgRCSM
	VkgSL1oYVse6D7albQbsS/W2TV/2jWTRUenoZc/atcIrqPuwrWJP6DCqSp6QvQgQT5y5CSa+zN3
	7xW4BSVv5nW80Owyben0UdCQUCq2AKOxEOXMDTFYD88azYNj7gR0e1N7jif4kmCEcDA4=
X-Gm-Gg: ASbGnctGGKpTUVwgfOYKJbSudE4HxgwslmSRCcpifwsncjnm+ZgfzuaNbpwrjBk5Xj+
	F9AorRP3XLQxViJ7W+aE7/mi4uaN7cqkPiE98eU0JNs8Dvm4LvNFIh4jC588PRINA5PdITRrVmg
	nHu1tQcs6uRo/jxTlA/tK2ZyEYFr/o0eWQCS8vQmg602d0uj0R1PYiJnaFn+cwvdp20h2n+zfkX
	bzp5QA5Ki9AfZmIC4qNHN8n8y2XmEVnsOvQ5bvsUqh6KmC20WCfRhlzkpyzNNEOsGv6elhzVvR+
	+zd/7GghcflEsvDUe9zSXXFgXVWk2TuHyFnwySJAejDg6W548F4=
X-Received: by 2002:a05:6a21:329d:b0:234:21aa:b538 with SMTP id adf61e73a8af0-2390c744e99mr5905542637.1.1752765127001;
        Thu, 17 Jul 2025 08:12:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTO8+Xo0qyZNjecPdyEQ1E7S+g3tlFLsy6r4ztKGL0EU33rzpzcW1a1wjSpktmiADaNdA2KQ==
X-Received: by 2002:a05:6a21:329d:b0:234:21aa:b538 with SMTP id adf61e73a8af0-2390c744e99mr5905493637.1.1752765126508;
        Thu, 17 Jul 2025 08:12:06 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5d3esm16293073b3a.4.2025.07.17.08.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:12:06 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Drop unneeded NULL check
Date: Thu, 17 Jul 2025 08:12:01 -0700
Message-ID: <20250717151202.7987-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEzMyBTYWx0ZWRfXwqyAPVoRLBUO
 1cK3e1f8RFR5ltDX5lVWnyhz8ApjLeX+HXvYX/bhWyUcMnaOmLCTyRVrKLPzhl/o1N7w/mWNHuJ
 +aFgOAZtja7azDh8qH82LdJt9zuSHuVUOLEQ6JbOEubYy2FvGqDOd2WctHLFpS+GrH3WaPJYUQ6
 EPsqACZ/DJxPrD84nuPKiigFv61TFy/z2pNSAZvN2YKJBDdAFF38hWZNz7F3E0J0nAdKd5dzyUT
 ztcCcR+SL73+JiIQNTU2UfK+zznXpt1uVvc2K8l8HxYpnRhkoR9PkKb9ER2t5BJsRjfFk5G1/3l
 8D6LoRWJMYc3dXvlJ07sD1u9+cqlqVCl3/6tF8ultZFxVNb+mUOi4gmfJreKPBM8Kpoy4s3eIVz
 qXaOXTWe4x47r0Arjtx/MaNRIs5B2vetANc8vFFW2Lt2PV2MdRMsSXjt0rzegvPD8DYaQjRR
X-Proofpoint-GUID: QKbiQXP5P6_gCqRD5-zFIBT4r5ez3oDy
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=687912c8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=eWlSUfSnBrBg5eVjM6UA:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: QKbiQXP5P6_gCqRD5-zFIBT4r5ez3oDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170133

This is always set in msm_gpu_init(), and can never be NULL.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 55c29f49b788..cefa50192391 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -768,7 +768,7 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
 		return mmu;
 
 	iommu = to_msm_iommu(mmu);
-	if (adreno_smmu && adreno_smmu->cookie) {
+	if (adreno_smmu->cookie) {
 		const struct io_pgtable_cfg *cfg =
 			adreno_smmu->get_ttbr1_cfg(adreno_smmu->cookie);
 		size_t tblsz = get_tblsz(cfg);
-- 
2.50.1


