Return-Path: <linux-kernel+bounces-743249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8B9B0FC86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0C31C871E1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FABB272E63;
	Wed, 23 Jul 2025 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WH2Qal3p"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B31F1909
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753308746; cv=none; b=nRh2PDPQP+3tNxyVODGMAYDqs+6c5bu9uJFhGS2Zz0pbyrlSg1xeVI4Pd0PAQweHoNISMlBCo2Co05UTRvi+REIv3cMQLxH/Q23d4/Un9bu8eP2Rhsc58HYY6zmCSdBMRHG+3C8kOQMoGqYLHssq3lV/rkATb8TJwMHZhxzklH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753308746; c=relaxed/simple;
	bh=kU5tnUZsyEuyHklDhh5yeQn+qDm5dvdkXwyv73f959s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sq+sEPUCQpMLkED1t98yai6FS3LI+Ugn3x7uIbOQorECjiYs0lmznblvuP6+jj084yhnw56SLTFprmS3JXXICuh0M42YEYsrLuXt03LYWn39uAf6wuHUW36yjrdzVQnUqnQGZMVW2HjuDms4ZwCI0B8ZmZcICR/m1mD6C1sF/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WH2Qal3p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH69OC023489
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZELAXz6pi1p
	iurD84MhBWtClaTyOdSezyB1Jeim0QzA=; b=WH2Qal3p+RSmJGpTQU+BzLQTAhR
	xcroTPq2W4RSLcU9LWJ6C/zOlzRsFj1FyvukNxvSsU3I0Vr/syn8YWXUHsZiFrz5
	qN3S0IehHR60iwRZmiHZk6+FHE6phaygUMYvtaTbTw4R272AEBtlSCyLN4yXKutb
	z3o0Ods6XELRTtIV2KhB4dFk61xQMfnp2exYrruytEZIBE/y/fZOGZKWH3QFcsn9
	GXKePkOQ06I3WqQk5LgK0WOe1Lrh52QSHhS749CryYQbX7IqJ3es1JnzqBtWuk/v
	ZrMq6f7vX9yF/DgkXHLVkI08bMqeRgmwbHaDTv8lrLEI5+aR+4ibuiNqCug==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ud847-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:12:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2354ba59eb6so4006895ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753308743; x=1753913543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZELAXz6pi1piurD84MhBWtClaTyOdSezyB1Jeim0QzA=;
        b=aqhR8q5Rqhwbe/RH9qwejwmtaw+GYz22BZJtdZF9dgJ5qxZh9wFIQxmEK0CgSKq6a6
         1f7HD3uiQf4bWnx6+/O61vqvfLMGyIFB2ni+iI5wjeiq9JEeI9ERPL4lMimLvPlSVkee
         CzIV32W5v9m0+dElEStcbi9Z1CMZzSelpRmSclqNWdxqBUI65vaT5iHkFUwdR8Hmoo8i
         Y2UdOxM8c6eOvgTbqrk6CJoLOr+BhykauERDCLD47hvfbxZUTD5cooNnzkgq79Y07bkM
         wQ435pwm3vlEAxGrO2lQV91bIj/dPcYqB6x5IEZOdjDRZWFvkC3gzlFtmlg5NgxeiyTc
         SjSA==
X-Forwarded-Encrypted: i=1; AJvYcCXrEVMwDcFrarrQtfwjtvnX5zWrM6cyvMrXtHgiYSXxTLxPEwXCkjNveiSgHcjD95/SGA4IXwauSWEIGgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBkLg9CpvqJKPwaR9YVMTkdTtbn2+QA9ZvKMqlOu+Xf39DU3NC
	oMr0XPmxGU/MhjuBtcO24uVuvm+AyRJxHuk1g25uvV5UPqUdssBeGKoRABXAI0pm3HXEWUdTvAS
	/8LNDdq9HXMfRQ9Q8MiV70gowtX6cEYm8L25tGhUF2r2lJk16ISetqYhhzPZQ+GrICGE=
X-Gm-Gg: ASbGncuyJd6nZV3gl9/1MbCwPUTG0qMvuCc22qChPQ+fbhJhFDsoBjFgDPHRLNTTzKy
	h4Qccd9iN7VUAuGTyZYFkOvxBc0dK2lID0WJiYZA9bPND+O8ggktEoeYZN1/jUbyFNI2QA+W3Iz
	KPRDfO005DGDOxLohUhbg0t7Uq584XppgtZ3vI8qaBMmZ50HSEECqU2BfYCjkTCG2n8iQguBwT5
	fhV/vsEkBl7fcsuFYSZepLeQjYejlr/Vb2NpEzATMbYrJBHbwsWeFRoIBR/rdmF4Bmto+gt1pR9
	hrMoPHWzQDdIls5QzqjP7OpkMt8UtJlMXSe7Da3NMEvjb66N3ew=
X-Received: by 2002:a17:903:3d0d:b0:23d:ddf0:c93b with SMTP id d9443c01a7336-23f981b5ff3mr53931485ad.37.1753308743462;
        Wed, 23 Jul 2025 15:12:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPg+91DANEGZGB4JkXB+cUWEzypyPnxOCrFXbrqyTcN8cw8Ruqrae2h0FkcANM7PlMM5SM5A==
X-Received: by 2002:a17:903:3d0d:b0:23d:ddf0:c93b with SMTP id d9443c01a7336-23f981b5ff3mr53931225ad.37.1753308743040;
        Wed, 23 Jul 2025 15:12:23 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f3d3sm644605ad.40.2025.07.23.15.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:12:22 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Danilo Krummrich <dakr@redhat.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS)
Subject: [PATCH 1/2] drm/gpuvm: Send in-place re-maps to the driver as remap
Date: Wed, 23 Jul 2025 15:12:11 -0700
Message-ID: <20250723221213.36325-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723221213.36325-1-robin.clark@oss.qualcomm.com>
References: <20250723221213.36325-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=68815e48 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=kOSSLaVpcPouW256lEMA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MCBTYWx0ZWRfXyKLGg9WnJzY2
 nf/Q0JO5D4kn+Yn4gXwwuEz2UEHqtJMmElOnWfNk2ymB1jv5TLrzylI5oJyuFf5KAXhkIo4oQzn
 i818lIrq/e2nmpRtr098jiQUONdzFix+QeWCTIMevNNT74UxfvL6psnxoHcZWT63k+W72ya4ISK
 9nf5ODmMREbAVP4U9fwlblv3KMHTS+yRQMy0XZn60FiDtSEU3LhgelY8810UqRc5Zz3Z1lNLFxW
 p+33cJcPZLpRexbvKmGNThg+6sfd5pfK/pybe/5IM8Ha508PckFzT893/XLFFeN68kncYqnlT+P
 aMXLOqYcqVGZ/cRQ6tMIcJYJpCPyOnk43fG1U//qan3mmZyTf9px/e8NMMfoOMlYnMgCXdoD4q5
 GolcfXDnes+a9JwmkKwFYuEPPKVoIMEvPqROw85dnzFIJGT2KsKM3zXBVBbGCvPx3MmvyMIU
X-Proofpoint-ORIG-GUID: 93VrZOUKOhQ8znN2N24JSFNMaW3wzo1E
X-Proofpoint-GUID: 93VrZOUKOhQ8znN2N24JSFNMaW3wzo1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230190

The 'keep' hint on the unmap is only half useful, without being able to
link it to a map cb.  Instead combine the two ops into a remap op to
give the driver a chance to figure things out.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
In theory, drivers should treat an unmap+map combined in a remap step
the same as discreet unmap+map steps.

AFAICT nouveau is only driver using the keep hint, and this was missing
for the remap callback.  So I've added that.

But this is only tested on msm.

 drivers/gpu/drm/drm_gpuvm.c            | 21 +++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_uvmm.c |  3 ++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index bbc7fecb6f4a..e21782a97fbe 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2125,6 +2125,27 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 				 offset == req_offset;
 
 			if (end == req_end) {
+				if (merge) {
+					/*
+					 * This is an exact remap of the existing
+					 * VA (potentially flags change)?  Pass
+					 * this to the driver as a remap so it can
+					 * do an in-place update:
+					 */
+					struct drm_gpuva_op_map n = {
+						.va.addr = va->va.addr,
+						.va.range = va->va.range,
+						.gem.obj = va->gem.obj,
+						.gem.offset = va->gem.offset,
+					};
+					struct drm_gpuva_op_unmap u = {
+						.va = va,
+						.keep = true,
+					};
+
+					return op_remap_cb(ops, priv, NULL, &n, &u);
+				}
+
 				ret = op_unmap_cb(ops, priv, va, merge);
 				if (ret)
 					return ret;
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 48f105239f42..c3e3a15eb3c8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -820,7 +820,8 @@ op_remap(struct drm_gpuva_op_remap *r,
 	if (r->next)
 		end = r->next->va.addr;
 
-	op_unmap_range(u, addr, end - addr);
+	if (!u->keep)
+		op_unmap_range(u, addr, end - addr);
 }
 
 static int
-- 
2.50.1


