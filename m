Return-Path: <linux-kernel+bounces-776655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAD9B2CFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D160C52089B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23407272E6E;
	Tue, 19 Aug 2025 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c+Xj5hQW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E0925A324
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646156; cv=none; b=fDTXQ5dQT0B12TSnd8gAlc8pGgSsGmD9d4S+JV71AtpkrVT9voJBgrDjr/DIjWsiQ3+6R2gVs2qomlKpxXdivzq8KYCwuVJvLGap2i6tPK7xWds9zsDlrmaBiughYnXXN0M6ndET7FAPEwsrFTAxp+WlCADcajO+BYWKoYeKTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646156; c=relaxed/simple;
	bh=m2DbnQlqqNwwlNIxvhEoRGGpqQjDYvvlU9SkRZl+16o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBLkPcZIz+39iOpJ6d7JGqHTGEvGKvq3eBCJi7AfDnwvCSMtJG7AYIiC4CD865ZSjhHL4fjEvh4oQh0CwwBp+1Hw6jfCFp9YEomSww3bpql0aYH5+MPNJKNf8onyfJ0PsRZYusURLif4oYiWtuzBcpGY61WwAcndDNz0rttF+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c+Xj5hQW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JL0xDc027478
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xOD0sf9vQpA
	36mr+XQVQk/HHckfya/iFMlPBFmcVO/4=; b=c+Xj5hQWU3OWNtFeY0EHlKy7/ml
	S5tMQOrEHcmUMpdv+G4YQ5XWvQhTgo3wTJrCQz0TERZCWS5l6cwsz9Pes32RY4mu
	4BVg1rBeIEYOHYEiA3N3TUUEkAb90GKegGLkICDjxMVENSQEmCtSiHuOq4R7InsT
	yNlzeqmnH16fGQ2kB9kLaGWDaCHiO9FeFbRxNy7RyBlKj2f37IgTuqfxdane2Oxv
	gXrtV/CuROTQJBmIgAbnk0BIP7Y+W3fpWu3+72+mSAsZHhOn39tbKZAuPvq6Q2lI
	WccOypGE5S0vUDt3l6gTG4944c8FflWWc+pcA3YVZfECyDjRkobPnIn5UHQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n0th08fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:29:12 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47630f9aa7so376390a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755646151; x=1756250951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOD0sf9vQpA36mr+XQVQk/HHckfya/iFMlPBFmcVO/4=;
        b=Acgbnn+CTXZWbV6RxvgGhWE3v5JX+6KoIVyfbKpBEfvbTaKaKTUx6xSCQZRvi/a0Dy
         4r6YiPXWw0XT43rlJcfg05vWQGnt8pvhSnq4srY1hZ1ZqGiyO5Wy6Fi8SEKw3BTn2itm
         PqoaALL1e7HCdwxqgZr6Yk3RHfeS9lwR1sRQemkhiVEpuusH4sjS4cIe0OWobm0FSNcT
         VGVSH5j8y2/RotPw9tbTDTIIiXu2xPvjXrg4ttTWi0Ru2+XYUcybdCChF/lTB50tW/Mo
         4CKPMmYbe3qrEy0GFMuOKML8mZfTw0EH15NGQSbt6kTKxG/82nFoQLEICFPwpXfXhYpr
         MGyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxaCQd4ts90pQOGQlbvWEbiIMF3NFLRMXT0qj4cOuYQgkyeaMDuatiR8KWRxn7Pyz/0OcfwXb4zHfXMTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeqIy6Qe+fR3d+ZM4WBLwsppXNy2qbyRcUQEAIzhEPjh3itKQ5
	vzZon74QgyqjFDTmlE1YM7XxnlJK1e2yCLPbShpzl5T1OdFMh/2Jr1g2cO50E3d60jRp+f74v0r
	ZPFyU2VXkIRvjktqX5Sa/bU88E9xTjPBUiJlAnAXbJngybdHwQhkqmFlg49vINyl80UU=
X-Gm-Gg: ASbGncvYyIIiUljSYa2D2lrlnGQ1hFHWdZGuP8M97DfncEUmSwdF7aFsTa/b0fhPNXI
	53nlVPgQhTkqJjrSNUUYX0ujUn1iWf6BhwhUIAcnKt0/0XMU+GYSPtoEXl6iC/r9uMLZqqgSldj
	rqhtynyZ62wbg58WNjhWV5D45Ib4GtG5WWKI054IkwNcbZvC32tsTMyjkrhH57uYyQ78yTdYU7e
	lQfJ8R3rihbTphTRYp/YySulbL0l/NzdgP9ZrISZWIFmk0aDW3LhcBBFy1F4iOYe1xallXlfEqa
	L+/asvqnp3uDlt1oeN1ipr26klNfVZy+cXejEuhrkqEeKZyrE70=
X-Received: by 2002:a17:903:1983:b0:242:3105:1787 with SMTP id d9443c01a7336-245ef278bd6mr8125155ad.50.1755646151400;
        Tue, 19 Aug 2025 16:29:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBNouQd1WNy02GNK10dJCaNN0bn7eGUl0jW23JNcTKuITpIN2aFC9d99JUYmsh8MwZPEEokA==
X-Received: by 2002:a17:903:1983:b0:242:3105:1787 with SMTP id d9443c01a7336-245ef278bd6mr8124815ad.50.1755646151013;
        Tue, 19 Aug 2025 16:29:11 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33df68sm8352945ad.21.2025.08.19.16.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 16:29:10 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm/msm: Fix obj leak in VM_BIND error path
Date: Tue, 19 Aug 2025 16:29:01 -0700
Message-ID: <20250819232905.207547-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819232905.207547-1-robin.clark@oss.qualcomm.com>
References: <20250819232905.207547-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NiBTYWx0ZWRfX10/6f1IBSuMe
 W1U09z5ByzPOyrOb0PMAY4dfdPTE58REpe8KM/2Tna4Wf18sBn46ZUb3hlpKWhnW2FW4c1+8pZh
 fQ9Gqh6ZM/6ffPJ+GJU2Ujg7q7Ykkwp8nuF2fSGAHZ1cFbMwwobHZpqCyftw2bPboM7bmwAmXQ3
 H09xjERHbiCDj9orwwAqu1sXQviILQ1j+AusBzzFJJzQVjZBV1Y+op0MFduNqCXowLxcpFxeYpX
 P8PKcTwwN+mv8CXosVbi0O5zoqAqjCAwDGtvBYyFntWAh2YVpzm4I9Kt+yLQ1m/LRNyweWAnaZz
 qWuKHMEUk247SkeIgycT4zaWd93vpi1XGTMpnTzRFkYqJYrqT4aK7U4Gkl2fThZoTl/kcyhOmAq
 oFUBlQefpzJ3qCID6VL4GrDheNGUYA==
X-Authority-Analysis: v=2.4 cv=dI7/WOZb c=1 sm=1 tr=0 ts=68a508c8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=hfQrMx_BsErUUvjcJTYA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: DKjC_gdinXYeTC97OLNW4KwXKBWsUlsC
X-Proofpoint-GUID: DKjC_gdinXYeTC97OLNW4KwXKBWsUlsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190196

If we fail a handle-lookup part way thru, we need to drop the already
obtained obj references.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 00d0f3b7ba32..209154be5efc 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1023,6 +1023,7 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 	struct drm_device *dev = job->vm->drm;
 	int ret = 0;
 	int cnt = 0;
+	int i = -1;
 
 	if (args->nr_ops == 1) {
 		/* Single op case, the op is inlined: */
@@ -1056,11 +1057,12 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 
 	spin_lock(&file->table_lock);
 
-	for (unsigned i = 0; i < args->nr_ops; i++) {
+	for (i = 0; i < args->nr_ops; i++) {
+		struct msm_vm_bind_op *op = &job->ops[i];
 		struct drm_gem_object *obj;
 
-		if (!job->ops[i].handle) {
-			job->ops[i].obj = NULL;
+		if (!op->handle) {
+			op->obj = NULL;
 			continue;
 		}
 
@@ -1068,15 +1070,15 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 		 * normally use drm_gem_object_lookup(), but for bulk lookup
 		 * all under single table_lock just hit object_idr directly:
 		 */
-		obj = idr_find(&file->object_idr, job->ops[i].handle);
+		obj = idr_find(&file->object_idr, op->handle);
 		if (!obj) {
-			ret = UERR(EINVAL, dev, "invalid handle %u at index %u\n", job->ops[i].handle, i);
+			ret = UERR(EINVAL, dev, "invalid handle %u at index %u\n", op->handle, i);
 			goto out_unlock;
 		}
 
 		drm_gem_object_get(obj);
 
-		job->ops[i].obj = obj;
+		op->obj = obj;
 		cnt++;
 	}
 
@@ -1085,6 +1087,17 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 out_unlock:
 	spin_unlock(&file->table_lock);
 
+	if (ret) {
+		for (; i >= 0; i--) {
+			struct msm_vm_bind_op *op = &job->ops[i];
+
+			if (!op->obj)
+				continue;
+
+			drm_gem_object_put(op->obj);
+			op->obj = NULL;
+		}
+	}
 out:
 	return ret;
 }
-- 
2.50.1


