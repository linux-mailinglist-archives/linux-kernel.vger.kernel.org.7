Return-Path: <linux-kernel+bounces-778709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4150B2E930
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEBA560097
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C733D987;
	Thu, 21 Aug 2025 00:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bnO3TDYv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C07139D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734678; cv=none; b=SlFl8qN/yVCf/8JigxBam+43L/zjxy4mXZWCueOqUHbzMxLIOfMD8MBPJ/69uXwCC+TB/FeVLohVX7r4hqk6ySJZ/EHhA0pshHLtFRVGvSzkp3TiPW4rY13iMBaxo6mFJV6JZGADAJLk/mUN7xEVSyM7VvVlVk/Db2YrutYxehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734678; c=relaxed/simple;
	bh=aJAOWN0ijFMS0Vkkf/yh1HfO36czNE64NzzeczFKSWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1OMBFxBMvVVERfjw2kfHORcTrfIU0NS68Q26WMnQOHEFYKsrTQcN0dXh7W2HTnxVX/nwXpmlw94lrDAzqwnKXfe1vRDu+KB64Ufrk1YrljcMBBg3qOZtg4Jj/cwyqfs1y5IDLRTpWVf4htvnK3z9rkRNUNqw5wjnjSQ922kIdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bnO3TDYv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KKkslg031528
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UUeZ954T0o+
	UR5vuNiqg0BBHjNOT7Hd/arRfZ79Ap5Y=; b=bnO3TDYveWTOLQkrfm5KcRB8buo
	9/wxJEHtJNuR4gVm924oFrvDt4dqX8QBrtQ4wfPF3ZkFOIbppnEeavSg0/NR5KcB
	nJeyjRuQRB7DplRV9XFwpxFA9rNRv0R1ajpcvmihLg2KNTZO6rintJ6vtBJe9m4w
	vxHlDVsFcV55q52w5k+wiY1jHQ4ZUlJQ/kwhPl6yssTnNL/iFqVFfTK+KiiMfreG
	Z70qJTUF0LRPC5Arcq4cUgww6QFylMX1L8yLKH5qppU5Hg0e8eh60SJMnVJK2PeG
	7maKAnXNkVHXES43FarV9w0IYni2Ys9b0wUmkGQJ3naZpHGyx774r56lZJQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dkb35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:04:36 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47173bb3daso274551a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755734675; x=1756339475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUeZ954T0o+UR5vuNiqg0BBHjNOT7Hd/arRfZ79Ap5Y=;
        b=KO1l+jsOO9CQlC6X8pb9C3SHWkuo+D9p85nnHuXNxHB+8gTO9dEMV3kwYxffo96Tsn
         4sVCQGA6XAe+gsQGnH9FeYQo8I89XLcgddr1Mi85aU8x4WCMNUfstEofbN524sYSJu1e
         VVwSqU1CSUb4mWppDSNd0jxyKeECT4uaOg+XI341Xf2DANWoiB41+gfivUL1MULfW5UY
         ozOJ5kc/Yz5CPa75neE2gSQVY83otRreIlVSiW9wAjiik+bw35wrDNVHKSSC0o6GhmvJ
         t98tS8yRGMSE8yqL0L3QNggSGdSnCSyrnl6w6G6rEDbxygFy7OO8q3TjcyS0iBKZUrSK
         lYbg==
X-Forwarded-Encrypted: i=1; AJvYcCVtDxqQlcEo6Xj5VaNnoQXesut/sxplcvHc+yVcaEsvK67Nw8C6uEkJUeYuHVsoLeK/fylQ4XAkPGs9nm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4Xuxqp330ylCJQ6cBC3I3I7xdNGB2CHBfifJ5gRfwQRogBpJ
	yPAxGtYVGJBvlY7YqxeM1crv3SIvVEE4UlEXWjPaZoYcyB2m6xAdyIhK7n81XwMbu7zyEzrmt/n
	xFSoUlkwnhzSSEDEnpHf/8fxBmAx/nVp5Bg8KulpCqAbqxGqaSJkBt1b7Gn7y1zlU/yulGM8NG/
	Y=
X-Gm-Gg: ASbGncvy5O9cFeXlk38R3jp99NAwrsrLkuJTx+ux96WcqePhO1oEssS6c21mddLSUn0
	86MkvBgp+lDz72gfFck54C92VYFdC2k70mVRqEA78ZoNlBD8tDMaaJRkDMfl9JfezVeGxv3hawf
	+Ah8nugTT0KvU1n4e73zK6j7ritN8gemHfK77tnLRnodaLSYFtRf0ot52LefocIHgE7FxfIzOnt
	jU9qHst52DOVM+ID/jTVpdJbJEOx/raqYD8j0tbAR60mUx0PSFzvGeR+2YYklDahiEmQykndA8n
	rV32LRGMj32l2h6yeM7TjOiLJxyyEoEylhy0xvX2NxTSQJblLG4=
X-Received: by 2002:a05:6a20:2589:b0:240:750:58f with SMTP id adf61e73a8af0-24330a38b92mr513549637.30.1755734674626;
        Wed, 20 Aug 2025 17:04:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlUnW8lxbe7CPRYj4ZEmunFvuRSStPlf00u91BAFQGx6Z5Mg65P2yj1AhS1x6n8d3UR7v6+g==
X-Received: by 2002:a05:6a20:2589:b0:240:750:58f with SMTP id adf61e73a8af0-24330a38b92mr513507637.30.1755734674129;
        Wed, 20 Aug 2025 17:04:34 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e8f20c7dbsm3229516b3a.68.2025.08.20.17.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 17:04:33 -0700 (PDT)
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
Subject: [PATCH v2 1/3] drm/msm: Fix obj leak in VM_BIND error path
Date: Wed, 20 Aug 2025 17:04:25 -0700
Message-ID: <20250821000429.303628-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821000429.303628-1-robin.clark@oss.qualcomm.com>
References: <20250821000429.303628-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX5nz7Y8ckcNzD
 s7FaK/UmQko4zl2eIJepM63Qjdb6QawGRqcWhMu0e6b63pqqL53lEtHkKKbZLgfK9yhTkXh1T+r
 tMaSyVvGlH/Nk3thl1eaABU/2isWtWB3BjVcOTjxKtxBoeXPnvu51HxS2bKcr+0fhMBPEj88A2o
 AWDehRfY8dY3UK0YpuNf+2nADrJZTNLiKb2HhQVPYLdNjBWmr7IlgzH0Yo4gejVKNy9O+MySFuQ
 TIK3KZt3xwhGo042DGe6KJL5nrL8qv2HPJJy99gBPFtXRiBB3tLSJdiPNy8T1gaHS0OLHnr9Pgl
 Fnmo/nyAoATMA85he3YvpgE7KJjOcLo2j4AhY+DOIfY6Fh20iQqBjbqW9Y4z/du99a3F5IHPLWV
 95VNlf/vvfhKgSEdcvoJsB3ggqkrDg==
X-Proofpoint-ORIG-GUID: jXyoWFH_esUve0nFNkvfDN0j6gJdrK8S
X-Proofpoint-GUID: jXyoWFH_esUve0nFNkvfDN0j6gJdrK8S
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a66294 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=hfQrMx_BsErUUvjcJTYA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

If we fail a handle-lookup part way thru, we need to drop the already
obtained obj references.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Tested-by: Connor Abbott <cwabbott0@gmail.com>
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


