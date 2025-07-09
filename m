Return-Path: <linux-kernel+bounces-723848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F80AFEB9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A571899B52
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1591F2DCBEB;
	Wed,  9 Jul 2025 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ibxh073e"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBFA26B763
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070150; cv=none; b=d8cZa+tuOmEANggujBZ49FbdiDNH+AsWT6BBmqvPNklLHwzM+iDwiBq6QKUtjxViuL0z0uTIHG1ApaaNXmfLBcBv/On8O91pZA7Xh2Uljkr8W8x3PI6mxu0HopFSiQuNbBi7UYkF9Y1z0dB7ha/kNsguTT9zsBP307AftKyLfQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070150; c=relaxed/simple;
	bh=/i+QrjsH0aywQwogwYh8FyRdW4rPjWnA8SqoqnQl3sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/I1JDezxsyS1Tkuf6Ow8TJOw5pibKjyq43OynRYOUeuaL8JA5AGDkn5DvTw1PCynnE4J+SzUKdDKvRJkbp8kD31fioSuDlfnIPLbauGcFKMxQEueg3oPYV6UIwvgGADcUUwTRnT+131drmbyd8+ZbongvixSmzEV/j3edl/E70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ibxh073e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569CouS5016649
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 14:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/d3R6mnm1I4BAdLDWhYywDzK+yEimTdQcJV
	Hid63KMc=; b=Ibxh073epcP9IdnE8N2pbRLR1mXt0xUZ+k93DUYGd7b347B/rCg
	fU5ccPD5xgjTmGZz4Zt4n5qNbi5SGS7n/uaqahry7eJ1RpUKASWtE4RYIWi3AZ5U
	V8wD0hbTnRs8XfcHEh3PgWFcLzW+06eCXrw1W4FHMC2Nr1Ese//OwKKXBfIFaBro
	cmjACq9x0lPUjE+MRUni7ZiTGqfIPl7hV4ogSmIBNOFf6zDYGeifKYfojpPkYlh0
	WqQcbj8qCHThegKpMZTD13I49WTE68ucClh8byMil5ljb6BEtQZs6ocvDNzUTQ80
	nAbnlA6neCFC8CJHo6Vivq1fKhViInDmdYQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap1acj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:09:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so7828147a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070146; x=1752674946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/d3R6mnm1I4BAdLDWhYywDzK+yEimTdQcJVHid63KMc=;
        b=VllR4TyYCR2Ak7aG69csbyM4KQ7YJEj/VvLZudYuAXyc07rqC3OzSAoNZsXNSCwpOl
         xqwLN//biUkqH5/+FHHXm/CYIhtWyv5uiVVYDs7XfHTz0nm4CiR4p9tcz7m+oKz+26FP
         AKpmuPrh1VHn9EMQlE7Kc8Hzec0NFjPdoLTFdruZ/oonQ8k8DuKCi0qsVedLmsQqjOw9
         JCFfbzMyY6thCBDo/JjbfgDDImI8M/Mv1eCP1Xv+EwY9XGQZfyDhETj0B4QU9ujLgFSG
         iS+lGXA6I9QJzAQw7ibHq+NBu7dzb35S5nCsRYAgA830FMiCh/6gfXpEK4U2DCrRSBef
         rPsw==
X-Forwarded-Encrypted: i=1; AJvYcCUcB+x3PDEsoee8gwW1avAKxRi9Rr3cB7VuIHRu5NB2hX5I5bQ3s8zw8Vvh7YpsL2Vjn17knKalPJbzn6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDtYrez454OE/8pZw1PSmHRQw9hZRWynwdD9rX8z33y6oS3Fwa
	sikfQnh5pHbGv3cz7mSa9DhuXbF+ana8wEhCPWTZCNHjp/p4WUd14qJK97YxqmkHw2/Qsr6j4J6
	QCRtKq/e+USbmjgDQ3+xlzuaSUPDsaStUC2VclDoAz36lZyzN6riVOL6GRdGnELOPVS8=
X-Gm-Gg: ASbGncv14n+UpKCuBoGVKWbJEOQxp0OBeOUOo+YSBwZYc+BPB1GOs+Wf3Etjt5MC5lb
	GJutMcF/Aj1C77cERGNENcO/mikeI+2jV11J7llwSf2JrN9UAQh4aSXsbTUWRKIbPFYPee1cRcO
	DQZxG2GRUmDMfMlypVFjgikX7GuW0YmQX8jNtXh3Kab8FNvUm8lCJ8gdUAMQLS1gTK1sWdamVFF
	LNKA4nCLBDwMie4Az4qcuyfEW0yD3MrNhKOEMYphFZovm5iyHdug9rG+s636HLuFJFpYhexA4ky
	fxy4Xt2G/96ka1jT5JF+mSKq9H2hqu6T8w==
X-Received: by 2002:a17:90a:e7d0:b0:311:f2f6:44ff with SMTP id 98e67ed59e1d1-31c2fdaefbcmr4683206a91.17.1752070146349;
        Wed, 09 Jul 2025 07:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMafukcX25WYJC16FEhi5PetBHsygYdFgLzh1SAK8KFse3W5EKQBerKIx1xEL84lugAaP6Ww==
X-Received: by 2002:a17:90a:e7d0:b0:311:f2f6:44ff with SMTP id 98e67ed59e1d1-31c2fdaefbcmr4683150a91.17.1752070145827;
        Wed, 09 Jul 2025 07:09:05 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017ca4csm2200198a91.31.2025.07.09.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:09:05 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>, Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Fix build with KMS disabled
Date: Wed,  9 Jul 2025 07:08:38 -0700
Message-ID: <20250709140838.144599-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=686e7803 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=isCY8TonHXl0-fnU9HAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 2xCCAYh-QGsvQhW8eqYzKux_RqqekkVO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEyNyBTYWx0ZWRfXz3jybqaO572e
 tt5m3j+HQjGOdMcslEmLqrCXPoag/Z1DeTqMVW5n6Rt1ynhfW7H6x++a4eF2G/twAK+jc2F3ohV
 UfyrS+PkE8nDOHLtoYc6lQ2bmOChbgCAQe/dIsEaNedwYBI3Bi7mukFHqdvrosUHmPdExv+8osk
 Ai0QhXvAsqnmhHT+VQ7kIEg4dL6pQiXl1Kr66QkhdoGYesuUeilYRSZEF5PnEUDVYRjpxUbnynX
 RU5ZNDRusZvEmEGCFhR2ri76/LPAFATM6/G00dj88AtaYyGD0/uvYtDA+x0nwfQ2L7DfmBvO8QA
 GIZzR3NosutBYWQT8V+vnpRKaumPenlkcc2Ztneu1QFLygvnquH0GF8hq4qyRC5M6gpSGx8D+7P
 F7/92Ze2qSmQ2y4L50O1iRb9nAkjVLD3nPUJxwex4+ufGpV8Xk0Lr3yNWk1mC55odryAUTby
X-Proofpoint-GUID: 2xCCAYh-QGsvQhW8eqYzKux_RqqekkVO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_03,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090127

When commit 98290b0a7d60 ("drm/msm: make it possible to disable
KMS-related code.") was rebased on top of commit 3bebfd53af0f ("drm/msm:
Defer VMA unmap for fb unpins"), the additional use of msm_kms was
overlooked, resulting in a build break when KMS is disabled.  Add some
additional ifdef to fix that.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 98290b0a7d60 ("drm/msm: make it possible to disable KMS-related code.")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 33d3354c6102..c853ab3a2cda 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -96,7 +96,6 @@ void msm_gem_vma_get(struct drm_gem_object *obj)
 void msm_gem_vma_put(struct drm_gem_object *obj)
 {
 	struct msm_drm_private *priv = obj->dev->dev_private;
-	struct drm_exec exec;
 
 	if (atomic_dec_return(&to_msm_bo(obj)->vma_ref))
 		return;
@@ -104,9 +103,13 @@ void msm_gem_vma_put(struct drm_gem_object *obj)
 	if (!priv->kms)
 		return;
 
+#ifdef CONFIG_DRM_MSM_KMS
+	struct drm_exec exec;
+
 	msm_gem_lock_vm_and_obj(&exec, obj, priv->kms->vm);
 	put_iova_spaces(obj, priv->kms->vm, true, "vma_put");
 	drm_exec_fini(&exec);     /* drop locks */
+#endif
 }
 
 /*
@@ -664,9 +667,13 @@ int msm_gem_set_iova(struct drm_gem_object *obj,
 
 static bool is_kms_vm(struct drm_gpuvm *vm)
 {
+#ifdef CONFIG_DRM_MSM_KMS
 	struct msm_drm_private *priv = vm->drm->dev_private;
 
 	return priv->kms && (priv->kms->vm == vm);
+#else
+	return false;
+#endif
 }
 
 /*
-- 
2.50.0


