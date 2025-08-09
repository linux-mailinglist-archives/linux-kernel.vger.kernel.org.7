Return-Path: <linux-kernel+bounces-761267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37651B1F6CC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 23:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564EA189E79D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2004027CB35;
	Sat,  9 Aug 2025 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="F8R0mMZZ"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A11F8725;
	Sat,  9 Aug 2025 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754774793; cv=none; b=QtxzaKMaLercUvTTi4JOkBNPFsDvuTKi6DcXly8ryU+gisQEtaG8Oy9KwYu3+vIQQafxVEoLH2W2+sPQ/XrjAef8Jsc2cJLMCbUk3ofUPszOYpl9mXY85pFms2eRChBX0RF5Ei5Rba0jr69K7oZGffRQ2Hr09t3RnUWeZgYw/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754774793; c=relaxed/simple;
	bh=hnfjCHnQaU33x2fRHAj1738Ecz7tv9QWfCs2jXcb5j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPifiQRuvnX+eMhsg05HoPnDQ5/RyTZhgYGzi7gVGcuewAow5n6beylqn1nmzKhuvshob2Ot6DXTJ2baNlRG8GT+Nj78h4sRdZN36cEo5+eJFZUrlAZHiHm7LA+xz3xmVYnFJysGXkJrgtx/kvczCCgmt/jTZp25tnMwgmDvhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=F8R0mMZZ; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id kqvxuMZTICThEkqvxuji24; Sat, 09 Aug 2025 23:16:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1754774219;
	bh=gRjOuSVm0vyW/KeKNVV0XzdhAD9WM43tL7z8dD//4s4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=F8R0mMZZGRWpLzWwCxgv62qxAjuqJWsym4+TnvQVLvmtATFUS34JS2O2ip+29jtNN
	 yO9lzwk8sEJTlyXHRag0oxxNTzbJd+Jpou2QSVFWCEgD/MH2Ke2TBFkTSchWtJNraH
	 1q4+bTik6NmpOnNnm+WDmmOhmXUlzveAVl//CHFnwVNLNzTOTanzMaqiHAfBVOPv0m
	 EKcrvmONPj1KZMQ9BKt+fsMknHX+KZxdsK5xz1JX6S/iO1cp97Fsu8kX3x2UvqSIcx
	 uguG+QTySiKVvEAe3dmafLaiTFx6yoAXj72FvTqUPueqhaC41y8zkkF6zNpMAUkpqW
	 cREoK2XtF6Pmw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 Aug 2025 23:16:59 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Russell King <linux@armlinux.org.uk>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/armada: Use the correct prototype for a struct file_operations .write function
Date: Sat,  9 Aug 2025 23:16:52 +0200
Message-ID: <8085f9c18ab06158b9adbbdadb8554c85972d390.1754774176.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

.write functions from struct file_operations return a ssize_t not an int.

This is maybe not an issue for architectures that use this driver, but it
is nicer to explicitly use the correct return type.

Fixes: 96f60e37dc66 ("DRM: Armada: Add Armada DRM driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Spotted while looking at something else and trying to compile the file on a
x86_64 using:
  make -j8 drivers/gpu/drm/armada/armada_debugfs.o
---
 drivers/gpu/drm/armada/armada_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_debugfs.c b/drivers/gpu/drm/armada/armada_debugfs.c
index a763349dd89f..96aebd56272f 100644
--- a/drivers/gpu/drm/armada/armada_debugfs.c
+++ b/drivers/gpu/drm/armada/armada_debugfs.c
@@ -49,7 +49,7 @@ static int armada_debugfs_crtc_reg_open(struct inode *inode, struct file *file)
 			   inode->i_private);
 }
 
-static int armada_debugfs_crtc_reg_write(struct file *file,
+static ssize_t armada_debugfs_crtc_reg_write(struct file *file,
 	const char __user *ptr, size_t len, loff_t *off)
 {
 	struct armada_crtc *dcrtc;
-- 
2.50.1


