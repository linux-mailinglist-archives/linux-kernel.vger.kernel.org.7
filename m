Return-Path: <linux-kernel+bounces-743414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66645B0FE61
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB5C1C27A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D74D187332;
	Thu, 24 Jul 2025 01:38:16 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49714B08A;
	Thu, 24 Jul 2025 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753321095; cv=none; b=nz+Sxi2pLAzPmlvjEv5PoI9yliRQ/vhzJH42YgVcs2P/1F8MAmk9V0Fzj6B1vXkM/I/RKUOq5wx8gd6J1O6Rzx98fGH6fhVlYGaSIncRTIH45Nno5XKW01+R2mBtGn4KLJhfgAr5UTmND9qvVwwrSAaY3qwQKOyfYIsovn926WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753321095; c=relaxed/simple;
	bh=E/cu5hc6fvoB3H2h8mHPslJpGH+A+7L3GT/Zsv4qgoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8VdJ82aWeHril00x7C9kbtNX0N47PHZh8nicBzCK+gLt7pcJQdolaiZmxxlUKoKe3qmI42bok8gl3xjo7PcbU9SElkkO0WIOahgj/675lT4a05r1AhEBesq6+nbYGACbLNo0DWMy7PgBD1BctrRzZ2i5tKHLNGSTUtxNPi2scg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d6d8845c682e11f0b29709d653e92f7d-20250724
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:9d8addc9-c6e2-4086-af87-0c7df1a40a98,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:6493067,CLOUDID:0a74c468cf89dc1c6f2ad09f5e1d6ec3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d6d8845c682e11f0b29709d653e92f7d-20250724
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1077835242; Thu, 24 Jul 2025 09:38:03 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 01E18E008FAA;
	Thu, 24 Jul 2025 09:38:01 +0800 (CST)
X-ns-mid: postfix-68818E77-905892132
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 092B8E008FA2;
	Thu, 24 Jul 2025 09:37:56 +0800 (CST)
From: Yunshui Jiang <jiangyunshui@kylinos.cn>
To: willy@infradead.org
Cc: alexander.deucher@amd.com,
	chriistian.koenig@amd.com,
	jiangyunshui@kylinos.cn,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: use kmalloc_array() instead of kmalloc()
Date: Thu, 24 Jul 2025 09:37:53 +0800
Message-ID: <20250724013754.3429608-1-jiangyunshui@kylinos.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aE-ML8rLXnLaqHVA@casper.infradead.org>
References: <aE-ML8rLXnLaqHVA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use kmalloc_array() instead of kmalloc() with multiplication.
kmalloc_array() is a safer way because of its multiply overflow check.

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


