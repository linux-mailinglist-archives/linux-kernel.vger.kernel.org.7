Return-Path: <linux-kernel+bounces-724323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B09B6AFF156
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B651C84008
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E106923E25B;
	Wed,  9 Jul 2025 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Mlh2kdJx"
Received: from smtp.smtpout.orange.fr (smtp-65.smtpout.orange.fr [80.12.242.65])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465051F63D9;
	Wed,  9 Jul 2025 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087785; cv=none; b=HcdP6zkAfxKo9f0oG0vKqKqAfQpq/3IIj3HdglVOvSZwx1+/Zeb9ttj12Thw6lqjX2N1y63ya6DxzY5KrRBKttkFtDmgrO7Y+JGnbCiFLq7pCQffdKgrwvOKCO0vwU2uLQWLxAKIJfoDgslOs7FgKp5CVn2m4S9dv+4o1rYoyIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087785; c=relaxed/simple;
	bh=G519BjdkDY1+Rfyc181KLiDG1zEMN5MlAxYWGwUIhis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MAmzoU6eiIfj3EnPW5nwrL+0vS+X4Zn/XEiC5BL8Vg1pAyB7jjd+aP/+S47sMQZQmQ+kjIfDxTMpIxlMMyxN7ks4bDRu9d6tPubrsJTbkVGKoZhJ8JzuF8z+mMo8eL4GPQrszUUq9GbWinSxZNIL2qPEOtMleXfuBNXEAWypkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Mlh2kdJx; arc=none smtp.client-ip=80.12.242.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id Za4EuohZXIU3AZa4EuA5yn; Wed, 09 Jul 2025 21:02:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752087775;
	bh=DU9gqi8o4hCHl2YklDSYazmq20NfmNbWp6osbg8n6+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Mlh2kdJxE+2erlXyzB/j9fcd3pgNavt+mSXgVyTlrnsdyBa8hroweuI5b02zmojTn
	 EtE2Vo1N3KAOkVUhGsaYTo+pvW8n289lT5osOgU4qNReL2KwJvlPBzh+x3jCJmVvjK
	 4n0igQnj4ahsFbXXCeVQUMFKN3jwAlqiPbrBpoLdvvUkspqsp/59NIZfZ7eUSGr8ni
	 ZemDE8hf8A5LKzDbJ+8tZfJ8cWjwygSbh3ddibSPEgVmFfHFDIKt6fJEkPgY1Y1axe
	 ZGvW0fbydjgZMsRaSahXv8w/1a0N/2HxWS7BeMbh+cmzebsqF77EJ79fpPW7/DpF47
	 1PZQl8lLuWWlg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 09 Jul 2025 21:02:55 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sunil Khatri <sunil.khatri@amd.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix missing unlocking in an error path in amdgpu_userq_create()
Date: Wed,  9 Jul 2025 21:02:51 +0200
Message-ID: <366557fa7ca8173fd78c58336986ca56953369b9.1752087753.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kasprintf() fails, some mutex still need to be released to avoid locking
issue, as already done in all other error handling path.

Fixes: c03ea34cbf88 ("drm/amdgpu: add support of debugfs for mqd information")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 513bbc543f40..bce97318965c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -520,8 +520,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	queue_name = kasprintf(GFP_KERNEL, "queue-%d", qid);
-	if (!queue_name)
-		return -ENOMEM;
+	if (!queue_name) {
+		r = -ENOMEM;
+		goto unlock;
+	}
 
 	/* Queue dentry per client to hold MQD information   */
 	queue->debugfs_queue = debugfs_create_dir(queue_name, filp->debugfs_client);
-- 
2.50.0


