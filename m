Return-Path: <linux-kernel+bounces-796305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E13AB3FEB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4971890819
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A212FB964;
	Tue,  2 Sep 2025 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l7gJ/s/F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C405D2FB63B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813845; cv=none; b=nVWC/AqtDhLGvbLK4WjMe7/xf0/pbgqYNEpVXzVqGocgwA+vYTjXoWQGhTkuOSIOyPP8J+eqy+QB1XUpbDpf9QYNvPBUnfYwCXE9w4LZYmbqLbfruEy1/VHZhCF6/fTo+fmxIPpA9/gRKb1zMWsUMSsy8sQzDpobHReA8e5RJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813845; c=relaxed/simple;
	bh=oRUzrfj+bFbJZIfg9yUPlnyYWmPonREj6xzhaQwtGK4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tRwWxbwh4ubZrK7JcHGK9EQnWUPLuI+0wFr4zeisJLk9TeZ5xi2hnz55IazWYTPM8+q8JFhzgx0EbWVBJ7HWsTBgF0YIxEC9xnfKp5iA1FRfU/Fc9Rh0BLhZxmHxrQe0yuwALTTO25n4qcBkA0ktfdL9HfCPYRkc4Pv2O+3+SD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l7gJ/s/F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582B3dp1029660
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 11:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eAziRhwZITCfoOpKyth9/b
	vxKnzQJ9GiVsebHG4acH0=; b=l7gJ/s/FrO9c7rOdBehQ3lDEsDcToCsA1jWapn
	88nbf7UWia8GInbSmzFkce7rS4ZVXTGcGSCMasazMiWbaozXIisgUo+XjclOUEVh
	tzpokthFISXxtv4ygsS3uJPIS3GqGZ9n64exYXw2ZEictZHS9kDpE+uYkydxuq9C
	RSW3d0OBvi4b4g4YfXulRRYDp9FhbWpipH6bZqkWkHzILKeo/EaZ+4VuYIfG8KAL
	X7kH96ZuxMBjPft0/LIwwvcLaU4DMZmFAyOrr2FWUDLHxFtwmdip00LU8/3tV17O
	GqWFEqkb1grGvGK35EBuWbZ/n9nZWcyX7q+gc17WQg9bA38g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8qm9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:50:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-327b5e7f2f6so7683020a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756813841; x=1757418641;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAziRhwZITCfoOpKyth9/bvxKnzQJ9GiVsebHG4acH0=;
        b=IWDj1uShA/gMrD8JxVRWjZxSVh33htRCQ5G8Z35U7yMPDdxsQ9eufTyKGjbeBJVJou
         X7WB4rYxnUYBD5kMHx3Ha+5rZ5zenE7PO7+Jvw2lt9HweU261bWG++TIVN8DibMN5VBi
         hyzo7iBhaeNk0j3dejPwSMpdL6WvRLYx4iZ3QHyUJHel3OLqQCQOz+BGrsHr/W+5ib6J
         uwD9pSEfaRUXy4uBcTwKFWb1MtjHLv3ftG5sr/ZgxcpYhXCFfsiTf1/UV0gVGDxePjoV
         /RTCSmzOFgqFiQo8G42uExcAPAvYfx75Y6rXRAieLV+Kv6AXgb5J6v0DKAXjcBQ2S+Tq
         gx+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVzULavoR4b1EIQfkFPtmwyvWocse7Q7E49jlw8bYeMAeu3I8iJJRy6p/TdyELEj968knMBTmuB1DDCSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5XrAilM0mOAc3tWyyz5A+yttx3TxOPsPvzvZYYqlZ1wxG35b
	8f0YCr679Pq0/j8uQnAOE4OD3ESTecgoBbmvJmdbAzxNrD1ZarTh3ZEAorSfiUQpt49q3sdUG2b
	GYnz2Ks25T7XfGCjgeynn4gPfe4qBpusXK2/7ishBaaQCcxdzwYEvBOvxdMNo6UGuEh8=
X-Gm-Gg: ASbGncvbqkhguMBawVv5NTiW5HA7V4E+ZGgOpSOJxsM8dDsOyybQwhOEqEosYH2iSNn
	oMhY34HS2ha49PL4PegyCT+jqYQbvXBrXSE6j1C0VL4b/tHANdpX+hI5AUEhUMxVtNMwrhY2Bp1
	PRCtCcXjk6RIfEVOi0k+8znLj6fcWE/2JmNSs9BoLfNq+GvLtsE90pqI5NsG9jvjAMi5hLtnMOw
	m3uSgYd7q9YjasSl+BGVPSZsRPby1uyVd+h6WEp37ZiPQi3c1BGfadHjr9+Cv5BlrWZdBlM0HuF
	/oOSGF23jvkLjvLD4zP5LNzRcBMRuuBu29dP5ULwXMjKZsFmW069ET9n0wMLJcF1
X-Received: by 2002:a17:90b:4b90:b0:328:116f:b124 with SMTP id 98e67ed59e1d1-3281543c7admr18577447a91.12.1756813841095;
        Tue, 02 Sep 2025 04:50:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+ZMH+Vzg0wlRp9EAopZVWtcIW8yWlVtbtcynxk3++LYhebYu1Ii2WgJTBzPGGOljv90GvhQ==
X-Received: by 2002:a17:90b:4b90:b0:328:116f:b124 with SMTP id 98e67ed59e1d1-3281543c7admr18577399a91.12.1756813840345;
        Tue, 02 Sep 2025 04:50:40 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d089395esm3175428a91.1.2025.09.02.04.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:50:40 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 0/4] drm/msm: Assorted fixes and changes
Date: Tue, 02 Sep 2025 17:19:59 +0530
Message-Id: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOfZtmgC/yXMQQ6CMBCF4as0s3ZMW21VrmJYlDJoF1CYqcSEc
 HcbWX4vef8GQpxIoFEbMK1JUp4qzElBfIfpRZj6arDaOv3QBoNI5kI9Cs0FDTrn/GCcvfjuDvU
 1Mw3p+y8+28NMy6eGyzFCF4Qw5nFMpVGrP5sbcrxCu+8/0LJHyo4AAAA=
X-Change-ID: 20250901-assorted-sept-1-5556f15236b8
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756813835; l=749;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=oRUzrfj+bFbJZIfg9yUPlnyYWmPonREj6xzhaQwtGK4=;
 b=pRDSyxIvQu+ZNc+l0Lj15nZLcXhUN3GxU8l2stlbBCWCl5j/py1iUWsNgeO9XH3jOXpi7EK9S
 8LyuQX/ThMbAwqDH5rW97j7IgK9O7FPneBCVzTIkV6Ia4Ulhw9t8LRG
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: PYsXJSoj6pLhBescL39KlKk-XAVWZYm_
X-Proofpoint-GUID: PYsXJSoj6pLhBescL39KlKk-XAVWZYm_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX3+DkjrMGJBgv
 YKEhY/Dd8eWBksQBRnQZ+zHanRP2rnMhCEJKF5Lde3Kgalyq2byQn2v8ZqbNdzdoVn/KAbhNluQ
 EAy2xL2eFayh7+pKemACammUaFcmu6yZZM5yFu9OEBpkUJhfH5NtxU8flxkIEhiDDk+I78SCznm
 wG1F1IwsFMD6Ex6TFRWreXEGJg2f23aOlXRrgSM7vVaEyFsQLWpPFMurtQCwXQIMYiFyVp0OObm
 U2zp29Hrq9hgsp3OtzgAvNA1YkiX8zhSX2o64694jT6qsKDOQVJTm4oGwibiiOIHAmVIgG2UFS2
 j/e0u55KaCgsiwAUdfsONODLvGWEhQUYEuanYxpH6QFuLNToFlf8uBPme8Od7tf5ZtIBsbCXhpx
 wKpPl/yq
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b6da12 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=dW-ANKit55rmDTnjG6YA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

A few changes and fixes that were lying in my stack.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Akhil P Oommen (4):
      drm/msm: Fix bootup splat with separate_gpu_drm modparam
      drm/msm/a6xx: Fix GMU firmware parser
      drm/msm/adreno: Add a modparam to skip GPU
      drm/msm/a6xx: Add a comment to acd_probe()

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      |  5 ++++-
 drivers/gpu/drm/msm/adreno/adreno_device.c | 13 +++++++++++++
 drivers/gpu/drm/msm/msm_drv.c              |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)
---
base-commit: 5cc61f86dff464a63b6a6e4758f26557fda4d494
change-id: 20250901-assorted-sept-1-5556f15236b8

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>


