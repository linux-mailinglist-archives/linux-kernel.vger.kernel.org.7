Return-Path: <linux-kernel+bounces-795933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB027B3F9A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3B91A8872D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967622E9EC3;
	Tue,  2 Sep 2025 09:05:22 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094052EA141
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803922; cv=none; b=IS+O5+W/wdLvQiADSVumtP4KCf7MaxMPM3sAGl1CCcWGhpbZ1qgHnTCsPJ20gjkVmB1UZTbBzBRYo577zdlGh7Gdcbzcuiy5qgGKUc19VxWq8Yd5rhP4FmdVRCmZiLeBx10lv7yqzwPqJNdbZSLcayIJcE+KcX+7GoKgY15IkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803922; c=relaxed/simple;
	bh=7DB9dvFCTC/2+WuIBeyHXuLEjXab5F91qYgtlWSoeT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1oGSSAhQ01qNJ4B8QtshAU4BNW3PmMI/BhxxEzDpE6bSaYmRS/EfUe0IOS2Nwr3/VYozAuYuHlCLeUfpa6CLjVOq3hRbswWwQ4zz4IzfGqTPZcpMSHLzXN1Ms+wUf7W02yS1zlVe6GPQ95Y9WswQor8fgLSbLdgZtPnzRMAwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f056b9c287db11f0b29709d653e92f7d-20250902
X-CID-CACHE: Type:Local,Time:202509021702+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:bac2d166-d185-437e-9dc0-16ec6f6871bd,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:0f66d23fdd1b665893fc7a0fe8b5542a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f056b9c287db11f0b29709d653e92f7d-20250902
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xialonglong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1325050762; Tue, 02 Sep 2025 17:05:14 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 980C4160038C1;
	Tue,  2 Sep 2025 17:05:14 +0800 (CST)
X-ns-mid: postfix-68B6B34A-3201431671
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id BE459160038C0;
	Tue,  2 Sep 2025 09:05:13 +0000 (UTC)
From: Longlong Xia <xialonglong@kylinos.cn>
To: yuq825@gmail.com,
	maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH 1/1] drm/sched: Use KMEM_CACHE instead of kmem_cache_create
Date: Tue,  2 Sep 2025 17:05:11 +0800
Message-ID: <20250902090511.2447679-1-xialonglong@kylinos.cn>
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
 drivers/gpu/drm/lima/lima_sched.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lim=
a_sched.c
index 739e8c6c6d90..b079ac198d59 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -28,9 +28,7 @@ static int lima_fence_slab_refcnt;
 int lima_sched_slab_init(void)
 {
 	if (!lima_fence_slab) {
-		lima_fence_slab =3D kmem_cache_create(
-			"lima_fence", sizeof(struct lima_fence), 0,
-			SLAB_HWCACHE_ALIGN, NULL);
+		lima_fence_slab =3D KMEM_CACHE(lima_fence, SLAB_HWCACHE_ALIGN);
 		if (!lima_fence_slab)
 			return -ENOMEM;
 	}
--=20
2.43.0


