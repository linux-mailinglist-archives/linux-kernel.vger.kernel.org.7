Return-Path: <linux-kernel+bounces-661338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359AAAC29B8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 20:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1D117BD13
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220FF29ACE6;
	Fri, 23 May 2025 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HkI68qI/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B4299AAD;
	Fri, 23 May 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024869; cv=none; b=CSaKbn8h/K1UpHhfWeRKfcL0hu/4znsdk/FSzq7dTOhckP9kdu2El7zfmuJkLAn/mn15uneYXYm9Uhfz6BTakg9xafBrbmakFJdJlus+Qp5hbo+b846anstDFLoFyzmXGbWawTLVUgDfZAVa4ZiiJkgsAMnF4MXVUFo1+ywLKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024869; c=relaxed/simple;
	bh=lksW9JGjJLO8Ap1OkdkUDPz0idAvC0ypyNYllEWzxWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=UAJBQw4bkA4vKWyu3wzo/Y5TvFInFks5IvFkhnnvQABum2Oeu/Sx8opJyOflIx2qVPWpP4qDVM2GHDKFrFMFzDgxmUwFBqCaOPmL+c6e09ET4JW23baP/s3O71QEQ63fDKW8vHIHZbfQdXvXnIzXFx+5X8XYsq7Bj5+qWlDSFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HkI68qI/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NCgYL5028470;
	Fri, 23 May 2025 18:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O9P1fcXWwN5dzpYmB4XE2BSjGJZmEDu26oek+iv5lvM=; b=HkI68qI/V6c7oGnY
	sfiyDiNelzJW0ssNJC6rvEG0SXLANaJLA6o1uHjwPvDbmGLeBLYMZ3sI62agAEx+
	04M6eELWzPt0vND0frG0ZpZ4STbcjr6Kiyc37JX5Vf5OocLl0AZKrjHAxrErSyxb
	n+1U2nbt4lMGr5grcBYIZmmDmARFO45+Rc9Oc/nxP2RlTs9NOLQvEwk1UY87QwiW
	Ll1I+DLm7YifrkQwhuIyY/z2yfpQiHP4eUZtRIU6HBXHG1Wr5QLpkBxa0dv9ikU+
	2naUNP2ICFZfO60f7lp+H20HVxhAljRu1Uv6GVd8qhxf+QnqnPznkHRuglmqzKQe
	FF0CpA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s95ts7ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 18:27:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54NIRcEE030311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 18:27:38 GMT
Received: from abhinavk-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 23 May 2025 11:27:37 -0700
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
Date: Fri, 23 May 2025 11:27:27 -0700
Subject: [PATCH 2/2] MAINTAINERS: update my email address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250523-maintainers_update-v1-2-0396d439d6af@quicinc.com>
References: <20250523-maintainers_update-v1-0-0396d439d6af@quicinc.com>
In-Reply-To: <20250523-maintainers_update-v1-0-0396d439d6af@quicinc.com>
To: <linux-kernel@vger.kernel.org>, <jessica.zhang@oss.qualcomm.com>,
        <lumag@kernel.org>, <robdclark@gmail.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        "Abhinav
 Kumar" <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748024856; l=1235;
 i=quic_abhinavk@quicinc.com; s=20240509; h=from:subject:message-id;
 bh=lksW9JGjJLO8Ap1OkdkUDPz0idAvC0ypyNYllEWzxWM=;
 b=BCTEKxcyOiNUDWOplswykS14BkfEDOXw+PhPfmvAgWfxEGz/9+Mxm0jXRT/PtXfhIz3b+Sm+a
 HCqvrAU+aGgD2Op+//SRFab2DYj7WigmMGbDiznJzjKJjVQu1zD2MCd
X-Developer-Key: i=quic_abhinavk@quicinc.com; a=ed25519;
 pk=SD3D8dOKDDh6BoX3jEYjsHrTFwuIK8+o0cLPgQok9ys=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=QKBoRhLL c=1 sm=1 tr=0 ts=6830be1b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tVI0ZWmoAAAA:8
 a=KKAkSRfTAAAA:8 a=69LWc1rl86c1DZQ69rIA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=-BPWgnxRz2uhmvdm1NTO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: kC7ClJzMrU6QqdUi6JnU0-uIUa197GLM
X-Proofpoint-GUID: kC7ClJzMrU6QqdUi6JnU0-uIUa197GLM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE2NyBTYWx0ZWRfX+jDtkYI1arPS
 H6A59lp5mhszPQorv+kpOLl0TTZUOHkga2QgQYYll+s7oS+6nz7aAMGAugJzV8EmdS/SRVNOKYa
 /JD3Aop+TAbQ6e/MBPKYpeCVCwwdjgnEAJVN3aCUiZztsN0ZOJT5teWDbdY5Z5kCShLxCq+Cw30
 WGny35mpmWlxsaCzFcVYaj2YcBzUF4z0TNtkSl5ZA+Vl9MloPZ6q3i+PCb8itzDn/Wvrr8MqUiZ
 6E48SED/Sr/RSnjEuxlRNU9pzWc1esgXVmsZ9+UNfIfApFeLyIc4l04zjpKNqsM4daIWG+qjgq4
 fQk9ARO28X3hvCVZFdUWDsNdWpq9jJTe+M31/IiCBqWGE3QRJLbYlJt/nNCs8DYpPJgy1evjLa3
 lZlbFRhtOCzrX48SxjfVIBpad1+9JvlPdJ2IxrMBkcEimRh8oDNfwtuqmNg++nnp30uOZGlQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505230167

My current email address will stop working soon. Use
linux.dev email instead.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bc0da6f9033be0d5da35210a84ba189be4e5c0c..c2244004b966368fd4084d579df934f1cf6c1c3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7639,7 +7639,7 @@ F:	include/uapi/drm/msm_drm.h
 DRM DRIVER for Qualcomm display hardware
 M:	Rob Clark <robdclark@gmail.com>
 M:	Dmitry Baryshkov <lumag@kernel.org>
-R:	Abhinav Kumar <quic_abhinavk@quicinc.com>
+R:	Abhinav Kumar <abhinav.kumar@linux.dev>
 R:	Jessica Zhang <jessica.zhang@oss.qualcomm.com>
 R:	Sean Paul <sean@poorly.run>
 R:	Marijn Suijten <marijn.suijten@somainline.org>
@@ -20473,7 +20473,7 @@ F:	drivers/regulator/vqmmc-ipq4019-regulator.c
 QUALCOMM IRIS VIDEO ACCELERATOR DRIVER
 M:	Vikash Garodia <quic_vgarodia@quicinc.com>
 M:	Dikshita Agarwal <quic_dikshita@quicinc.com>
-R:	Abhinav Kumar <quic_abhinavk@quicinc.com>
+R:	Abhinav Kumar <abhinav.kumar@linux.dev>
 R:	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
 L:	linux-media@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org

-- 
2.34.1


