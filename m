Return-Path: <linux-kernel+bounces-761264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 712DCB1F6C7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 23:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843CD1897067
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 21:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677527C152;
	Sat,  9 Aug 2025 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jG4NJyuM"
Received: from smtp.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82321F8725;
	Sat,  9 Aug 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754774552; cv=none; b=EJEi17iZ5eH07W1bWxs61a8u5rgIMz6T25pz0zEbazwLGZgYg2KFL6Obar06/dcTvViGr2qhB2oINcjC/maBd7qwUnGdGsUWPhyaTbAW8WKLuzN72Jkldk2QD/AsIJMI7sit2QyFIXZ9GFDc6W7ji1GkbmElUG7Xi17LZo5x0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754774552; c=relaxed/simple;
	bh=N/Zy4ZhhN7/C53cJBgF9R6NcMuB57XMuRSgaI/LWbUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Op+A+uTSX7KRkvcQ72LBq0ooeb+4KjCZg8q6n9rcByCN3DG1Qm5Qr19+1BwMkRSYkROZr92GWETAINEsly0daFIRsNzB/0S16eVlqfiZlhMFUWdttgqBARvVqmgAC1wO1RaUMkTxrVLnxq76D5GLqJ61lXBIfZIaLq2F+cewnEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jG4NJyuM; arc=none smtp.client-ip=80.12.242.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id kr08uPBBpkYfwkr09uKitS; Sat, 09 Aug 2025 23:21:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1754774479;
	bh=7WPR2/VqKI/KR7A58QvvxXBj2GcycEeUKgOSBlK9y7c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jG4NJyuMu88kcVXlXIfEygsgCwYT/Ss4rV0HcITFwYiknL3F51cNFGmc2wmmyO0i6
	 Ywn6bYsp3H3FPViQ6mR4HMlDB5OSDNXxGQMRMNhiQ5Q8NfhYf2cjLfCTUyq/HTpGYR
	 3bwm9C5ProE0Zgk166e6aym6bJ0IHOF5fCvB6vVe4kD9cepnRskcfqE0y/US2M6JvV
	 nkYWabp5mrnaYJDdRmwMZKSOZ7IhKzKNcRh4mGy5OLIV5EmEdJcyR3zciWXLsFH0gs
	 DKQxCyaeOaZEOQ3T2m9Y5qWINHD/j4+N0evzg6ufjnLHJ3CsGH8SETlJ6wYeXIGYI6
	 SmCHM05GvAYOQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 Aug 2025 23:21:19 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Russell King <linux@armlinux.org.uk>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/armada: Constify struct drm_info_list
Date: Sat,  9 Aug 2025 23:21:12 +0200
Message-ID: <ec8b238d044de971ca99716ca94ddf66a82b018e.1754774445.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct drm_info_list' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   1411	    320	      0	   1731	    6c3	drivers/gpu/drm/armada/armada_debugfs.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   1683	     48	      0	   1731	    6c3	drivers/gpu/drm/armada/armada_debugfs.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/gpu/drm/armada/armada_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_debugfs.c b/drivers/gpu/drm/armada/armada_debugfs.c
index 96aebd56272f..f15b2143279f 100644
--- a/drivers/gpu/drm/armada/armada_debugfs.c
+++ b/drivers/gpu/drm/armada/armada_debugfs.c
@@ -98,7 +98,7 @@ void armada_drm_crtc_debugfs_init(struct armada_crtc *dcrtc)
 			    dcrtc, &armada_debugfs_crtc_reg_fops);
 }
 
-static struct drm_info_list armada_debugfs_list[] = {
+static const struct drm_info_list armada_debugfs_list[] = {
 	{ "gem_linear", armada_debugfs_gem_linear_show, 0 },
 };
 #define ARMADA_DEBUGFS_ENTRIES ARRAY_SIZE(armada_debugfs_list)
-- 
2.50.1


