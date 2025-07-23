Return-Path: <linux-kernel+bounces-743178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F0AB0FB7E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 175F77ACCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBD823506E;
	Wed, 23 Jul 2025 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4pcGcy2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A879235047
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302517; cv=none; b=QBmfBcqR54ozTl+BPOY8E/dEjQY0v/FD7mRX+2/JYUWfNcBcuj1FK5rV6Cz5AXCCtD3coq+60uTWEwcgLTVrxQdCj7pFKXGoWqTZBd2R4K2RYzVbANSwDGdKqCI5NRLZAQwwODB6/qNZzd5lc9EQP6YEBMkMYDGxb41p9tneWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302517; c=relaxed/simple;
	bh=FX/3ZHFv7wjTbrH58bvhZjQXOS7g8qWalhEsIqd3tM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nabd83qgexFBkOKRbO632HcpY6ETCzMUuHz6gJaDa9aTetnLSTMeGQ/kHhlZmb57MgEJq7RY2Q9lYOIOeIouo0BEB4sYdOHDZnMT4HCuI9o/yu59lfKJI4bteIOzbCWY/Rh/BnmTDK2f60UnRd4wT9MMISiJytW6evfHWIc/sBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b4pcGcy2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGNeX4019543
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Jg8G8kDUfiO
	0QN87d8Nmg8E9KepNpwzJOvRP22Q1Yow=; b=b4pcGcy2lrUKAQy2I10T3RvGn2b
	t+63HpxKZk9yhrSZUeuy2/3TlSqrKg2F+1OnALf1oGJQITkXVbZqIHDxbPCwySwv
	UmDVq7/oRsg08WoBQe80b18z2Jr/jVYvcgFVPnQeAGhljqhUK/B1eIsO/FKAfWvA
	0mYzny++ay/+Npx4rD0mGYKnlXoBJym3CYwlRgzXuhcWmxSU+pqlggkzM+k5bd3U
	AVxtjyZ4eyzypCIivqoymC51gqJc98wv0UZrnV2EekeDlRxA1nNdxIysNB6yf7RD
	JypbIqfiJajwQRnbQ4DnRP9ZekRrrm8Cvgha9DdMKH6REYNVOhH10ZjZ6yg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483379rkr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:28:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-313d6d671ffso227970a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302514; x=1753907314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jg8G8kDUfiO0QN87d8Nmg8E9KepNpwzJOvRP22Q1Yow=;
        b=i3xUPgnGYYibrDTSkbs25GGA0BbfkbVf+WZLRTVpVv25FEGaEdLf6UCfIfHzKBX+zH
         OhG7wGqMb56iw6z9j5sggyskY/zd+5l2gCpStyWK8A3YcYDuQh95Xxq/+LskhZGYeZtg
         EAp+yx34mfe7pHuLElJ4TaEVNIVLqlqLY9uC6xkeheX1ZscTPSfNbPL2XIS78RAUAoQ/
         aW+lfa+3dubM7qgMAK3oINJt946IKUvwDWVxwrNzepqiI7nhv5/7QAWuekRmi0EA4ZfO
         d1hoVmWNwKg0xVPPAqmWFjZNSdEHDPWI2OJOkkIpj1lDxLIKw7xsKVLtK8VFNVJxV7YZ
         Dkdg==
X-Forwarded-Encrypted: i=1; AJvYcCUt5ole29Z8HnfKtfkw/BAGVe3gzS7YgiDeWj80sfbeAFszjGgkpOXABycQjSMta7CQBx1VjTNMldpK9ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf3QjkI0mRcxLOLaqkcnwR96OocyIz2FRj8IHraon/StYB/zZj
	AgCejxlZpPfx6KSXci7e7Oampc8nHTZB51GSCq0yilb7V3nN/jyl93DOxpP9Yhlq14TJZy7q9b7
	iw5EYFdk+6kAUH1GnTuygJj4qqnD2a3gBo9g6IqX04+I4Ffp6k4V6OcLILAftSZMtb+M=
X-Gm-Gg: ASbGnctcc0P0U6k6IWCPRi20ytnOPuZOVY96FWP632/cpjRALpwGj3CXYlPoBlJPI6K
	HcAQbaVxIewUKUZYtzgQZXsb/1hAR84tgts+btwG43FHD/jN2hYai7BGp75eRk4sH6SFHioVHqz
	DGfVpb9mnXO8ukYj8xo6pUnZQAzWByRY1mkzAS0h7PiMaojHCitj2GNUpnGcdKZ+14S4rV+QUTT
	WDlufkk5r/jafSSKqXB64H0Xn2o/v6Qd9wcYKR+7TiNIZJG5B3JVcQeI0pKQs/A37hLxQD/awPO
	+lso4RlbM6O2Trmps/b7I7VAGghNBhCgqmIxHc//0LENVeHzCUE=
X-Received: by 2002:a17:90b:35c7:b0:312:e6f1:c05d with SMTP id 98e67ed59e1d1-31e5073f550mr6078154a91.2.1753302513786;
        Wed, 23 Jul 2025 13:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK5Ovk21o1hIxl/7WYP8zrKYd43nYxItlCMNkL0IAMZTWY2Xcbzi2QZeu1m8gPG607xMRIxg==
X-Received: by 2002:a17:90b:35c7:b0:312:e6f1:c05d with SMTP id 98e67ed59e1d1-31e5073f550mr6078124a91.2.1753302513335;
        Wed, 23 Jul 2025 13:28:33 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6249fe9esm80462a91.23.2025.07.23.13.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:28:32 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm: Defer fd_install in VM_BIND ioctl
Date: Wed, 23 Jul 2025 13:28:23 -0700
Message-ID: <20250723202825.18902-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723202825.18902-1-robin.clark@oss.qualcomm.com>
References: <20250723202825.18902-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KTT_v_naZuD-vE8Fy_AI3wOE46B6c5Ou
X-Authority-Analysis: v=2.4 cv=btxMBFai c=1 sm=1 tr=0 ts=688145f2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=p_L9ESIXKxyW_a9_XK8A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE3NCBTYWx0ZWRfX1UQn5mmC5s9a
 Kzx6GTz4s5BGq7Uwu+jLl4JETrU9v7Tovg5PpzglSgHHip2THlOO5e4Ck6QTx1ykpxojYY5YYNN
 ba74sQlq5Aie9cZRjKhASsabMCTShBZkuQGtvvEziyiOU2RO+6p7lDQ5gzFswq1dKNG2XHnsDK/
 PtX4dG4nD9KlYlWeekvQGacKIjtyGMwlpMQYjSz0fkijfuMSuxPgNp43qxwblzpAlNgl5jtc4IK
 lxlqzqJKvDmAH6SWGJhDDOd7Qmh2YakyHSz4LgHpmHIhV04RdLdQjmz9AOzz7wP0AtrU0sAO5iB
 n2sHuaFIKmIkJZGFs8A1k61iD8BeEdIxDu/RNb66K/RjmnrG52ks76AMCPo2AjVMr6klq6gQyRH
 oU9hTWDmO57JfpMXznQCvbD2W5O3QCp0fUWCeTWpB1X31Sg814XRRUOurSXKNj04OrRCq9fy
X-Proofpoint-ORIG-GUID: KTT_v_naZuD-vE8Fy_AI3wOE46B6c5Ou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230174

Avoid fd_install() until there are no more potential error paths, to
avoid put_unused_fd() after the fd is made visible to userspace.

Fixes: 03b6becb03c8 ("Merge tag 'drm-msm-next-2025-07-05' into HEAD")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index e5162db436a6..d4b1cfb3aa03 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1473,12 +1473,8 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 
 	if (args->flags & MSM_VM_BIND_FENCE_FD_OUT) {
 		sync_file = sync_file_create(job->fence);
-		if (!sync_file) {
+		if (!sync_file)
 			ret = -ENOMEM;
-		} else {
-			fd_install(out_fence_fd, sync_file->file);
-			args->fence_fd = out_fence_fd;
-		}
 	}
 
 	if (ret)
@@ -1507,10 +1503,14 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 out_unlock:
 	mutex_unlock(&queue->lock);
 out_post_unlock:
-	if (ret && (out_fence_fd >= 0)) {
-		put_unused_fd(out_fence_fd);
+	if (ret) {
+		if (out_fence_fd >= 0)
+			put_unused_fd(out_fence_fd);
 		if (sync_file)
 			fput(sync_file->file);
+	} else if (sync_file) {
+		fd_install(out_fence_fd, sync_file->file);
+		args->fence_fd = out_fence_fd;
 	}
 
 	if (!IS_ERR_OR_NULL(job)) {
-- 
2.50.1


