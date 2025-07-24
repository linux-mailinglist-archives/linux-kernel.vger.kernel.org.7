Return-Path: <linux-kernel+bounces-743599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3052AB100AE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C21B188D286
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D8921FF47;
	Thu, 24 Jul 2025 06:30:21 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC8218599;
	Thu, 24 Jul 2025 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338621; cv=none; b=Qe1e6m1V+JL2l8Wtv5igcOEPklJPRNJJVWOmRDZsfVg3gy0IXIO/FN6EyNTpggnd1UXlZsFsoJlPE8QM+WWmM41PZhc23ldcF7PR4EtvMmQGcbwI7a7feRlyj2uPAliRBz3QvWdv0AyScvcHiXuEwu2FRZIC5kHljelHXOB7/nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338621; c=relaxed/simple;
	bh=zXkpuiggPpV/0ZooOIdHA4JWILB3jJ1cnn113O0RZkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grbjwDrQMeTT5vviqto3HT9WprkJGkDZuGB2C5U2sGfwOWp3SMIVLcCdkEocgEnrrekHT7dn2t3oZ/YgiiYawbIt1bAEGFpgDe6PnvuIdXtOz5CarBMBIou10moqES44Bkul74xAa1pkxsJNqeVyi+gII4ocQOL68e6IE1pCWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a17ca5c6685711f0b29709d653e92f7d-20250724
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:21978154-6b28-4c8e-9784-9cb9348e9ab4,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:66787c1e2ea4020286e7709089bdb7b2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a17ca5c6685711f0b29709d653e92f7d-20250724
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1355048946; Thu, 24 Jul 2025 14:30:02 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B431AE008FAA;
	Thu, 24 Jul 2025 14:30:02 +0800 (CST)
X-ns-mid: postfix-6881D2EA-511152175
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id B95EAE008FA2;
	Thu, 24 Jul 2025 14:30:01 +0800 (CST)
From: Yunshui Jiang <jiangyunshui@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com,
	chriistian.koenig@amd.com,
	linux-doc@vger.kernel.org,
	willy@infradead.org,
	Yunshui Jiang <jiangyunshui@kylinos.cn>
Subject: [PATCH v2] drm/amdgpu: use kmalloc_array() instead of kmalloc()
Date: Thu, 24 Jul 2025 14:29:51 +0800
Message-ID: <20250724062951.328081-1-jiangyunshui@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use kmalloc_array() instead of kmalloc() with multiplication.
kmalloc_array() is a safer way because of its multiply overflow check.

---
Changes in v2:
Fixed incorrect kmalloc usage in v1:
-	*bps =3D kmalloc(data->count, sizeof(struct ras_badpage), GFP_KERNEL);
+	*bps =3D kmalloc_array(data->count, sizeof(struct ras_badpage), GFP_KER=
NEL);

Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
index de0944947eaf..12f5a1b9ff8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2563,7 +2563,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_d=
evice *adev,
 		goto out;
 	}
=20
-	*bps =3D kmalloc(sizeof(struct ras_badpage) * data->count, GFP_KERNEL);
+	*bps =3D kmalloc_array(data->count, sizeof(struct ras_badpage), GFP_KER=
NEL);
 	if (!*bps) {
 		ret =3D -ENOMEM;
 		goto out;
@@ -2719,7 +2719,7 @@ static int amdgpu_ras_realloc_eh_data_space(struct =
amdgpu_device *adev,
 	unsigned int old_space =3D data->count + data->space_left;
 	unsigned int new_space =3D old_space + pages;
 	unsigned int align_space =3D ALIGN(new_space, 512);
-	void *bps =3D kmalloc(align_space * sizeof(*data->bps), GFP_KERNEL);
+	void *bps =3D kmalloc_array(align_space, sizeof(*data->bps), GFP_KERNEL=
);
=20
 	if (!bps) {
 		return -ENOMEM;
--=20
2.47.1


