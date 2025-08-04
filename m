Return-Path: <linux-kernel+bounces-755692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B5B1AA7C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C027ABEE1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EAA23C505;
	Mon,  4 Aug 2025 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIvPB8cF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A8239086
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754343804; cv=none; b=WfAP7HRTyfP4l8GwkKaktyUl0VFJP0xS7z+QAPsaHXQk8BeVh1eRM2wCANwi9Or+99NdTaNmbxCIUYQHCjXv5G+yI3ajjzW6jQx23x4kjdnpBnegloHdM81VxKMBd/cQ4bgu8YsUCSQ5KszIWIQ7U0Siv2gbkH7SwE9vbvRXjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754343804; c=relaxed/simple;
	bh=CB2Y8BaCKhdCfoJDmALSTSTK4hRfQx5XIImjd7vhr1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5F0smMlUxyMTJD9b2qisBoqL/AqVAfWcsFXHpUh1Je01Lw4WzWFLVs+o2mqI912zXK/GPFuYiBi60dm1xhKcXrEWMarAXqLMGU+czhCKIWh7tMCH12zoqNyfKatgbb6BUKiUBupYIf6Y53Jxyy1j0x1zUw4XFIX+p2l7HNo/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gIvPB8cF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574GJdLU029018
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 21:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4iMQZAqx3JH
	WA1prynQ+6hJlCX8ujFNqsZgwdOw+rDs=; b=gIvPB8cFPv1IRFNTmqYWqEWuixR
	Rwv7bmlaMzqpBylwNtRi/TG3UiM5k84mwatQE10PeUBNVzoEhsZC/kEPjRmRctDC
	+4ryya9XDg//UPR17UUtiH/UY+Becav0ePCMrFVJlEzmhGQalUXJG9cFtGnElobB
	qlSlHwe5N9O8RqWjBAnqJ8u1dxf87h6e8PXE5AZAC8ytxEBqBzKaeLCFYkRG+iXS
	ZPKaXijDwUfqLCd6gmGJkhRVPcGNg/6HUPKEFA9trUtMYvvoMAgwYgrrRcN7XsLw
	7GLN1tfWws+oetwv6VI5XGTLxVbDC8BxqoxJmILgFmZRwmtdCQzjbkQWuKQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489bek6b39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 21:43:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23fd8c99dbfso38138305ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 14:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754343801; x=1754948601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iMQZAqx3JHWA1prynQ+6hJlCX8ujFNqsZgwdOw+rDs=;
        b=u6kPzwvRRvaT7qcyphpp9YWFrF69tUIz1j5hGo2cUCV8abgju1rhTuIF3tTQxkLyeb
         lUMC3uxDPIXQGncBXHM8hoCrSRp3wcjG6n7L3WdIMSjUjxWT9O+pSlB68KahGniUdpta
         7ZH0vVA6A35ZhBhBtkRUfvFGAvIC0NexDeZPDaPNl0vyy7AC5z421W88g95zOsa6FxKO
         GNNw93tRv4Z3HkjP8hTWbOAyizc5aguaTc8YFwWZKRgZEF8TNobiy3ZlLO523nkHKEng
         W2V8o2lfdAQk+ug6ShJE9LjSNWJdDQCbxH3EN6hq2geYfOsLPLJOr/mriy1dhdU27dzm
         n5sA==
X-Forwarded-Encrypted: i=1; AJvYcCUgr3ljEj+KEPhRHQEFxCOnVzOeBqsNLq6vBZqUTB+Rc5coM7JvDouNW0vgIAlc2YPHsZmfxATIGtV2gCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Z0dBCeMQ3DLCVKOFdW/aIVef6Cw9SsBUhkdlVTWzTMGL72pd
	jOXMoUbelSCFyByXtkYd8lW+7LVZbDgHlDRlcaqOmb/u/Bgl1EtGkwkhuM4aXHq2mpcqr/zBv4E
	JJxDlBmN5eKKfL2SxVvHCNlgZa09QG2w7JDT6YwQJU2SNEaZKXny18kDjCdWHh5sZv/Y=
X-Gm-Gg: ASbGncuJk07YI2xPyI7wD6xtVjwkI1RVQYjddBln/vuUEjHSasA1C7Cjn+iZNf6bDp6
	kZ87lx9iIgYmrdzA5hQC3/F8Eo1kiKF39RXI7iH8CO3LCktAGQuSauuWOZQ4Y9mXH2y3TUH9VNw
	MHR6vAVVvju9p9DPSxPeLnGJfc8RFcaWSfGT0mFg/kQSLrTPsU7XTI98WsdPRfVnt3HEMLORbdE
	g3X5Cj7GyXd9qZGToeZnZYAr60vmuArb5H3UCXhw3kKfNg8u64VU49Zk6CJZqS0dx5lTVnChLuv
	s/8gqdWCebKp/Bpn/Y9GPn9wipgML9Sh5/xB0M8z+tUzK8x2raw=
X-Received: by 2002:a17:902:c951:b0:240:25f3:2115 with SMTP id d9443c01a7336-24246f66529mr161881495ad.12.1754343801263;
        Mon, 04 Aug 2025 14:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ42SvcJgCxFfQN88b9q64GCmdPYqi/gv07LLosxuO/N73EtGwR8zNcDRPko1iT53bOia+0w==
X-Received: by 2002:a17:902:c951:b0:240:25f3:2115 with SMTP id d9443c01a7336-24246f66529mr161881165ad.12.1754343800876;
        Mon, 04 Aug 2025 14:43:20 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da57b4sm15506076a91.5.2025.08.04.14.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 14:43:20 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
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
Subject: [PATCH RESEND 1/2] drm/gpuvm: Send in-place re-maps to the driver as remap
Date: Mon,  4 Aug 2025 14:43:15 -0700
Message-ID: <20250804214317.658704-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250804214317.658704-1-robin.clark@oss.qualcomm.com>
References: <20250804214317.658704-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=6891297a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=-LggB1lm2EvgG5rjBn0A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEzMiBTYWx0ZWRfX+Fq1pTXpEwgC
 MEUBX2f9wcfPUd96TmBVkj/D8a4+sf4FuCyHMr3kmL4DR2JW6xvKFz/gu9OnhVI28ZmkzCPAtNK
 kTm6ISTU+BLt45aNNefKX7gv9D0sHqXUy21XK/+L1BI5ggIa7t8rKbs8Btu6jOfoGEh03W0+7Y3
 YjzQz2AHc89XJAJSoksyhLnh6YHHMysbMl1/jKlh7tUdpBgHz+IDBPwYdNrS0yOFSaGJLrqieSO
 bl8xrrS4ahiJajJvsityJ2Oj7Moc7rptWHElq/eNBRGVgJ2KqTF/b0E/nPD/Gg0h2oAHLlTjCmX
 88sE7omU2Iyqy3Vl+LwZ0NEP94+jgKEwFoSB0aEN4k7dgz3pAXYf4fB/VLwUzfara77Te4kGi1U
 myREqfuCAI7dYvTjY14uADPDxL80mGcnqKlsGOJf+59bs8tXRAfsOncS41gUpNd8u4jb/wUs
X-Proofpoint-ORIG-GUID: C46O41sZ4BRTC462p-AURueundHhYUlr
X-Proofpoint-GUID: C46O41sZ4BRTC462p-AURueundHhYUlr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_09,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040132

The 'keep' hint on the unmap is only half useful, without being able to
link it to a map cb.  Instead combine the two ops into a remap op to
give the driver a chance to figure things out.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
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


