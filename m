Return-Path: <linux-kernel+bounces-743177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD1B0FB7D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EE07B87D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334341FBE8C;
	Wed, 23 Jul 2025 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TOIBXAyu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393423315A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302515; cv=none; b=ClDZ899q3uEKgrynWhRUF4g9FkFoUyhXMUeLEVuJTYnNxQs8gqJrC23KPsxA9t7RdDA5+UJG+zsKan5nq9MfYbseEJcFRdvY8aR233VC2H69fr2gsnbb7IYP3AnZEixJXAhnnY1cEFI7eGq04mUA96THGpTnBtVwMldI/PQcADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302515; c=relaxed/simple;
	bh=ni68krQ1ZwrRugsj/OAoNsJ3wM0hzLC+Yz9N/TufK5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUeY9CANiNXXLgpgZIUJ/C0zYADQLyJ/FwGGo6XnNgORM6aSkn3lJWh+c+EYQ/SuOfVfIT98JM5J0aYXuvlBTPF6fJVPSXAI8vidq9qvkv6+fzce56CiWs1vW0LzOTnRHMxgJaiox/Ec8QBavUgZ3mEDsb1/9zL8GmBm+WFxsNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TOIBXAyu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH2bQp025711
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=go4w6pisezM
	+fmrLJT459t96/m/WbzFkmudzTaE8Fpo=; b=TOIBXAyunTGCoyU9O0+JrziAopK
	PRYLvkqmUc4pYsmtcy8e9DIZzT2sFMbuODU/dH6qrA8bArv2OaLkBwrp6CbT2s4O
	ZDF1kSUtaKWmpXXPANSLKjJ4aBWWuE+1z0y2ChxaawQa0D+Q8a+4o7Mfjz+j4oHo
	VGI7CJ2BFfEyMbhoecKf4EyFA2xx8yocvBB9H7GdUKNuT81cTfKkeqbeJd5G5lKA
	KSdGYL8eFSSbTX5Vua7p05Btr8nXas9/aoCseiWKxpY0IVCILrx/a4lMpQRiv3j7
	H6DFxFoKfCN193E8Istnf5Tun0tSFeKGc3P8HGFiVfRiKiI3ajsKjywRFVQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ud1x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:28:32 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31f112c90aso231453a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302512; x=1753907312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=go4w6pisezM+fmrLJT459t96/m/WbzFkmudzTaE8Fpo=;
        b=SYAxIbl3XODvKUMk6cEoBjcZdlqK/R5VZNv+WzXquwtGCvwbN7ySpzCc+c6kyEGLbW
         U/3MJvnYv8ZER4NCFqI6SnMN8z+F5rqc+ZGFu47txep6UiQn/OsMqBqWeFd/oBv9w0+G
         4H//jtwJRIsZ3XbPcPDa/j5yEFo4iBdKx+0VYOOEu+2umYo4n1ckQz+oPR7PwxXll3Fo
         hDnCIB3rrbRypgaoHCAmHgh51u8OGlTNp7eVokqnlBxtsg2Pekl8t40tMXnuKKbYPDJK
         pejoehc+1n3gmmpA1Dx3Hmbz4nniV43mtksn1Be3o6hyTrr76y15Yubc7fsth7oLSBDk
         296A==
X-Forwarded-Encrypted: i=1; AJvYcCU63StxCCH479m9TMrfw0i+9g+HKDx42htEQQDu8hARiJue68AEBHNMa/P0j8gugyZolLKGwoJlrAE/2dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzODHfdRQCGXfw6fgMq28EOCAmarwFRmq/Vx6Ll6Xwa11pOcPnl
	GJ4ifuzZCYREQWFtwErj2KJVQWAYNcVlQ9Zv4ZlPen8UGPMio2qkx+6A0QLGLwOFuPnExeyTzUN
	/9NyYHr05wHErPJObEwxFNkQW+mitN2pO3qF70HEVzTUv46Wq5x+4xGwVvQn71yLJwqA=
X-Gm-Gg: ASbGncuI5PfYqBRUNO4vUz9bCk3KUB0w3Iyl1nZn08KEFXIlgxaVx87wE+5GF7W1vpf
	IRFxrDlwYqtWjBnAIZWd8gSkAAeqE4pNtK1Qq0UnvmTRueW6GZ0i5j82NlB8V1Krks/xMcsBSkF
	EnLGxbNPE+Nv2tv0vbmuyuq9SXQ/HhAY1Wd8jMFhe2QmiU2v/2GwRQ+KKnb6Gz5KFYg/fbVqHhX
	Ad4+Wr+BODhZjU+z/NPIzC/zGsPoyM48TnggRWFlYXZuElRI0mIz5rLj+1HQjS0Bk/riosYHDtY
	7bXBLUQd1tXqdND5z1cB6bwx2qk7y2JCC0hOl/6rLbd7o0sOXyI=
X-Received: by 2002:a05:6a21:6d99:b0:23d:34f2:3a22 with SMTP id adf61e73a8af0-23d48db2762mr6286117637.7.1753302511937;
        Wed, 23 Jul 2025 13:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8VTSyv68wujrKZl+LBtm1rzipjAkQC2pZQlbR1Bf3Ipp3TNep0+rs/9z89WCJhtGvp+l5RQ==
X-Received: by 2002:a05:6a21:6d99:b0:23d:34f2:3a22 with SMTP id adf61e73a8af0-23d48db2762mr6286089637.7.1753302511486;
        Wed, 23 Jul 2025 13:28:31 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b05e4029sm21283b3a.97.2025.07.23.13.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:28:31 -0700 (PDT)
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
Subject: [PATCH 1/2] drm/msm: Defer fd_install in SUBMIT ioctl
Date: Wed, 23 Jul 2025 13:28:22 -0700
Message-ID: <20250723202825.18902-2-robin.clark@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=688145f0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=p_L9ESIXKxyW_a9_XK8A:9
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE3NCBTYWx0ZWRfX5B5tEGBpl8zr
 SJs+a+hiX6Cz+VLZ+klb/aMav8F036gCjktIfwXQmu3XWzAkzjB7j0PkyvDlk3ZceGk4Cc2VFwk
 OJWcL811YPo9NbqhK9LOWTd0/+7wFACERIudCa7E2ypSce0elxIgtMkh3zPKX/z6Z/B/Eq1/0jl
 OdToo2pt+TEIHHjL37ixCo1jcw8ha/ETQoLbEKAbzFfjDdZTo+oQMy/UxVwqfLCoxJ0b8iRvar6
 lC/uYH16DVR1OqFbGlckW5BUpnUOWu8IvQqO63A6zXg3RGpWZNEwA5rcdoMf2++BUI3sS1RCtxn
 YLHXz+vXjHLLntVXH7aCjLpwt0lr05CkiG3jwEGsMC1PkewVT4IoC4zIyQODfnDW36UowZN9Typ
 jqHRO9mxHEbIWNpBYA/2yaWf1DTQjcS20OBoGw/czbenOiCOtC4SJkYSsV/dve+/b5I6ZmZ3
X-Proofpoint-ORIG-GUID: 3_le9MR6la1ZsovHHxO8AlINj5s_QRMu
X-Proofpoint-GUID: 3_le9MR6la1ZsovHHxO8AlINj5s_QRMu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230174

Avoid fd_install() until there are no more potential error paths, to
avoid put_unused_fd() after the fd is made visible to userspace.

Fixes: 68dc6c2d5eec ("drm/msm: Fix submit error-path leaks")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 0ac4c199ec93..bfea19baf6d9 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -770,12 +770,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 
 	if (ret == 0 && args->flags & MSM_SUBMIT_FENCE_FD_OUT) {
 		sync_file = sync_file_create(submit->user_fence);
-		if (!sync_file) {
+		if (!sync_file)
 			ret = -ENOMEM;
-		} else {
-			fd_install(out_fence_fd, sync_file->file);
-			args->fence_fd = out_fence_fd;
-		}
 	}
 
 	if (ret)
@@ -813,10 +809,14 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
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
 
 	if (!IS_ERR_OR_NULL(submit)) {
-- 
2.50.1


