Return-Path: <linux-kernel+bounces-854786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4393FBDF657
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E301A20863
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B0D3176E7;
	Wed, 15 Oct 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jeeeN8Bx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E50730C37E;
	Wed, 15 Oct 2025 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542248; cv=none; b=WlHjSRLIsU7aJEJbVfffBaRjdjva9ATcGTp4PgIUn2xasYZRltqYICLvPH327K7kLcEWvCbcZ3i/Xuxovu6zAxnokGti4qmQP1jtVS7raprVcdeO9Sr7RaJuDUsXc4W/+Tfy94Bh8nSKr883uhZyPJL25FWLNqSaKfo21teRPm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542248; c=relaxed/simple;
	bh=UPaCf2ud0ScDDITxAmGIS91OLHTTJaUwZwLkZIUbeUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDlB9R6duMDs92H1DpvkAm3DIAW+eoPyNImKdUMEaeww0ucAITciOPwLCfdMm9f/PSwhEwCcka15HcjVgJhwnpKMXaVO4H3gEx+TOvGCYAD643ejtDh0sxNLn2npEyFwye7TCBqu7TbE28mRIFBN/Q4ZeE2fBMX3x/E1XqI0mbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jeeeN8Bx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760542245;
	bh=UPaCf2ud0ScDDITxAmGIS91OLHTTJaUwZwLkZIUbeUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jeeeN8BxcXaTgnHKIpiYrn+CKNf3vzZAwdLoR0Jbg0cLukwhxxryk1mNoaHnmNpLR
	 tJi2gd9VdiUhAVVPlo52Kli1RsxYYbfe8Jhe+s303YZRmAOsQcgPgQGLB8eqdLvO0N
	 wo037Pz+BKczYBMKpsPgLSgoxRj4rPWV2Q6l2/4Ye6bbBwR+6+dWa2NtojiXOZgQcs
	 wVZpQRvNzPtq2jy0E5uDXIFv2IZ3jiljNtn006VVEx2yz7INFAeIBkzXrfr6Svv8xe
	 ArQ4AZpx1jwe2iPIK6a1wtLoE3BkoMuXQB94OH0CXBi+RCki/6rz83FkeunpUZMgD0
	 3YtRzPYkV6Qhw==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:826d:bc07:e98c:84a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 28D5317E1340;
	Wed, 15 Oct 2025 17:30:44 +0200 (CEST)
From: =?UTF-8?q?Lo=C3=AFc=20Molinari?= <loic.molinari@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Lo=C3=AFc=20Molinari?= <loic.molinari@collabora.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?UTF-8?q?Miko=C5=82aj=20Wasiak?= <mikolaj.wasiak@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christopher Healy <healych@amazon.com>,
	Matthew Wilcox <willy@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v4 08/13] drm/v3d: Fix builds with CONFIG_TRANSPARENT_HUGEPAGE=n
Date: Wed, 15 Oct 2025 17:30:12 +0200
Message-ID: <20251015153018.43735-9-loic.molinari@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015153018.43735-1-loic.molinari@collabora.com>
References: <20251015153018.43735-1-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Don't declare "super_pages" on builds with CONFIG_TRANSPARENT_HUGEPAGE
disabled to prevent build error:

ERROR: modpost: "super_pages" [drivers/gpu/drm/v3d/v3d.ko] undefined!

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h | 2 ++
 drivers/gpu/drm/v3d/v3d_gem.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 99a39329bb85..481502104391 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -564,7 +564,9 @@ extern const struct dma_fence_ops v3d_fence_ops;
 struct dma_fence *v3d_fence_create(struct v3d_dev *v3d, enum v3d_queue q);
 
 /* v3d_gem.c */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern bool super_pages;
+#endif
 int v3d_gem_init(struct drm_device *dev);
 void v3d_gem_destroy(struct drm_device *dev);
 void v3d_reset_sms(struct v3d_dev *v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 635ff0fabe7e..0039063eb8b2 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -269,7 +269,9 @@ v3d_huge_mnt_init(struct v3d_dev *v3d)
 	 * match our usecase.
 	 */
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (super_pages)
+#endif
 		err = drm_gem_huge_mnt_create(&v3d->drm, "within_size");
 
 	if (v3d->drm.huge_mnt)
-- 
2.47.3


