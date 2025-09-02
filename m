Return-Path: <linux-kernel+bounces-795702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700B4B3F6B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080831A82599
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BB42E6CDD;
	Tue,  2 Sep 2025 07:28:18 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02C2E6CA0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798097; cv=none; b=eZ2ZFuDgWECO5YCGB/J1+iNI3n9KCbwaQqIZmLt2rvIrl5yd0mOdlPJAVRdbVQb/9q5XeDQ+4HuzsYbbHPzZKJRRFRQpE/hAad3BfpPWdnMKm2Fc2wgNn7ogHhSJal5pvlr17kRbBhVSh0eP59OqsMfItD1lfEGnqnhGTnn9pSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798097; c=relaxed/simple;
	bh=URWrBbTfVh31o0fC1g0UUb1X7kjnJDKu+OsuSCMSpgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lp20AyOVZeL+AmOruPMq544qDPTY0GiHbzRNFjl4+Ur+oYYUQEom9U2IGAPOjXqKCMkKTf/1iwNjE2K6jKrVcbd824CoIx/c3PspOH3G34g0q3nq8Ap//S5Ecu8H4ZEnIwk+EeFtF/SRzsIVkGXCIYtSJYBKSLkM6MUeAYzyBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5beafbe887ce11f0b29709d653e92f7d-20250902
X-CID-CACHE: Type:Local,Time:202509021521+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:97ee494f-acb0-40a0-9c80-222f12790ab1,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:c673dd818662abbfa105d80fed711fdb,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5beafbe887ce11f0b29709d653e92f7d-20250902
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xialonglong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2066057203; Tue, 02 Sep 2025 15:28:02 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 9844B160038C0;
	Tue,  2 Sep 2025 15:28:01 +0800 (CST)
X-ns-mid: postfix-68B69C81-361036971
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id E2AAB16001A03;
	Tue,  2 Sep 2025 07:28:00 +0000 (UTC)
From: Longlong Xia <xialonglong@kylinos.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH 1/1] drm/amdgpu: use KMEM_CACHE instead of kmem_cache_create
Date: Tue,  2 Sep 2025 15:27:59 +0800
Message-ID: <20250902072759.2386131-1-xialonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use KMEM_CACHE() instead of kmem_cache_create() to simplify the code.

Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
index c2a983ff23c9..51f51064685f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -37,11 +37,7 @@ static struct kmem_cache *amdgpu_userq_fence_slab;
=20
 int amdgpu_userq_fence_slab_init(void)
 {
-	amdgpu_userq_fence_slab =3D kmem_cache_create("amdgpu_userq_fence",
-						    sizeof(struct amdgpu_userq_fence),
-						    0,
-						    SLAB_HWCACHE_ALIGN,
-						    NULL);
+	amdgpu_userq_fence_slab =3D KMEM_CACHE(amdgpu_userq_fence, SLAB_HWCACHE=
_ALIGN);
 	if (!amdgpu_userq_fence_slab)
 		return -ENOMEM;
=20
--=20
2.43.0


