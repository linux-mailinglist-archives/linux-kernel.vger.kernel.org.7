Return-Path: <linux-kernel+bounces-887561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7CC38857
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CDD3B2F86
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3B91D61A3;
	Thu,  6 Nov 2025 00:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqXEMfoT"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D833E7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390367; cv=none; b=JjTSynGsYZlAkm5BdhKjKnpFqZES5o52MqkDz4+pVzseXfdJNCXzL4I0YphOkkzjIxHJUmnG1GCgy//mR+1SlXB/fN1BU2nSryMLTn3BARqvdcebkIW2F9UnY7hDEdR/Ex0wbwF6gUuDBI50Ykd/dbR3ZzDLJtZ5pBA/JNLAFkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390367; c=relaxed/simple;
	bh=6OeZWmkLzPTDm0Nogt0/O0+112Y2Ks/sc1xjGQfLCtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ci/RaNaWhRIv7U4URWphRq1Xx9bsvzm06XoHuWLLR6B4Pe3ctlv2BmbBy5awCUcnKix3OO7yCZOUvkVzm2OKHETKEaGvr9cYJCJK7pXug9s2oMRsGSxbXGR4Zc4gusUaUJJ9OycHm58BxHwkuK70AZcsPid9X966cXoLQwI7NSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqXEMfoT; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so515964a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762390364; x=1762995164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4TC3jknw27uusNIMn2p5lG+ecGQ+4uLN2sc869EijWA=;
        b=HqXEMfoT7kF4TVXlp/Hsu51zwuwloi1mrZ+acodJKsyfWxhVDiTNNGGkZGXD+azsWg
         1OXxGLS/V4jlR9QK1TcyrUtlLt3F+ny3ZFHXlzs3/3qgHEuDHKw8ev+TssypIsJHpGBi
         tPGTQrFhLbpguVjZbhe8+g2B7tKMaW/Sxq0EFqBT0iIziJyDcUkTLcek4l9s+cPr7MGB
         bCA+fX2NhSzxbEicep4qIZkQe3UKOG8pemknu59RxCFrxn7B3QOn6Fw+hRBCk2cS9b7U
         VYpeoB85qzQxecmEyaiT8VYcSw/7FQZDgrQec0k7OvBIUyUo8lUdhU0TbV87UEQR1Lx0
         BIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762390364; x=1762995164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TC3jknw27uusNIMn2p5lG+ecGQ+4uLN2sc869EijWA=;
        b=G0ft2laA5v2DG7KalsTrxcuFz4rMQ62TzMDxPyj02n2FBP5AqXxplRbcJr7hF3hk0u
         iNsNs7Zm5S5ifKmoFVkV5uI2IojEDa7vYOOCdz6rKegYZ9EqSvbQIxltFipBBLtw0k87
         DiabTWLa787faB5JO4RGGTPS7MPX69+tqUiyUNby49rIRVDvzHwQ+0bWFrs4qry8fgPA
         FYFiv5YhbBCaG2sOznxGYKt4vG+iTZvPsAw2kJw9gAjki1bg9vVIHH1TB1KVGo3V0EXk
         DhX/NiMYWns3seC6CsKcg0nZ30EakDiJORG0qZ+HsQOzf5fZDhE0Bdhvi0TZ5ReaqqWy
         P4aA==
X-Gm-Message-State: AOJu0YxuB/fTCQ36HfD+EN/cpOGyTMXD0g6C8qChJ6dWv5pHsGVXsEBt
	wNcTm8zPsMxnupagAqqRjw8eHIkMPRHUB5gIr71QWRCCVya8XwY7kUoz
X-Gm-Gg: ASbGncu+PtybdDrczXAyFB9aB7VAF27s8JcG8/HqsQJJt3odZjNHPakR6Uzbxhjad6b
	ms1vKrtORDk5u3BSiqJD0lR0dAA+o9WqNFM4caHp0z2L269JQWcH62wKmgSmBS+drnpizUbj+GF
	cwq2Duu/Flsmozm7eycjOJrf40MyGkkM7luBt2b4d3f2JoytzTm5zf7DHrLGjX4Qg/RQ4fR06Li
	hE17bCbVOXH+0DSZhgEBmoc3YcHkycQKa243SGm9UOAe8MVzrZ5A1eWSPHRsx65HQCluPulv7da
	LBATFKEwAsjcHLHcfRQ0c1Pf25t4r6QJXQxHjpeP2T3nptSJeZnG3j9YPi6e8O/Sps7kt25A87J
	wTJcUB9lYqWaQLfnq0n81p9DoNuUqx3daaQ6zG0Qi1Duk3pLHmiKW9chazU1nP7dv/+V8Ll8psZ
	khloMgFZtOVRL2PAOZIIVx8g==
X-Google-Smtp-Source: AGHT+IGyPw3/1ye6s+MutCB7GxPiniSAjUqQCYxPkECNVoFIt+LeekKL8kDCX7wiOXbyde9uL5l1lQ==
X-Received: by 2002:a05:6402:2417:b0:640:af04:d718 with SMTP id 4fb4d7f45d1cf-64105a5c7c8mr4938545a12.30.1762390363532;
        Wed, 05 Nov 2025 16:52:43 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f862697sm476807a12.25.2025.11.05.16.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:52:42 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D7F1D420A685; Thu, 06 Nov 2025 07:52:32 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Intel Graphics <intel-gfx@lists.freedesktop.org>
Cc: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] drm/ttm: Fix @alloc_flags description
Date: Thu,  6 Nov 2025 07:52:17 +0700
Message-ID: <20251106005217.14026-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3498; i=bagasdotme@gmail.com; h=from:subject; bh=6OeZWmkLzPTDm0Nogt0/O0+112Y2Ks/sc1xjGQfLCtE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJncH/IOLdgTFFyjsmVl+3nljed/3uFbIm99O3GxYOe+J Yz/uRW9O0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRDj2Gf1qX/599FxLc3dGx 1uPH2qyjp6/3i5n+9A76y6zTvG+h0xKgCg67uoPm/TbK4WuldbNmSKTIGj6bW7dO4s5PFstb12V 4AA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reports htmldocs warnings when merging drm-misc tree:

Documentation/gpu/drm-mm:40: include/drm/ttm/ttm_device.h:225: ERROR: Unknown target name: "ttm_allocation". [docutils]
Documentation/gpu/drm-mm:43: drivers/gpu/drm/ttm/ttm_device.c:202: ERROR: Unknown target name: "ttm_allocation". [docutils]
Documentation/gpu/drm-mm:73: include/drm/ttm/ttm_pool.h:68: ERROR: Unknown target name: "ttm_allocation_pool". [docutils]
Documentation/gpu/drm-mm:76: drivers/gpu/drm/ttm/ttm_pool.c:1070: ERROR: Unknown target name: "ttm_allocation_pool". [docutils]

Fix these by adding missing wildcard on TTM_ALLOCATION_* and
TTM_ALLOCATION_POOL_* in @alloc_flags description.

Fixes: 0af5b6a8f8dd ("drm/ttm: Replace multiple booleans with flags in pool init")
Fixes: 77e19f8d3297 ("drm/ttm: Replace multiple booleans with flags in device init")
Fixes: 402b3a865090 ("drm/ttm: Add an allocation flag to propagate -ENOSPC on OOM")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251105161838.55b962a3@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_device.c | 2 +-
 drivers/gpu/drm/ttm/ttm_pool.c   | 2 +-
 include/drm/ttm/ttm_device.h     | 2 +-
 include/drm/ttm/ttm_pool.h       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index 5c10e5fbf43b7f..9a51afaf0749e2 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -199,7 +199,7 @@ EXPORT_SYMBOL(ttm_device_swapout);
  * @dev: The core kernel device pointer for DMA mappings and allocations.
  * @mapping: The address space to use for this bo.
  * @vma_manager: A pointer to a vma manager.
- * @alloc_flags: TTM_ALLOCATION_ flags.
+ * @alloc_flags: TTM_ALLOCATION_* flags.
  *
  * Initializes a struct ttm_device:
  * Returns:
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 97e9ce505cf68d..18b6db015619c0 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1067,7 +1067,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
  * @pool: the pool to initialize
  * @dev: device for DMA allocations and mappings
  * @nid: NUMA node to use for allocations
- * @alloc_flags: TTM_ALLOCATION_POOL_ flags
+ * @alloc_flags: TTM_ALLOCATION_POOL_* flags
  *
  * Initialize the pool and its pool types.
  */
diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h
index d016360e5cebbc..5618aef462f21b 100644
--- a/include/drm/ttm/ttm_device.h
+++ b/include/drm/ttm/ttm_device.h
@@ -221,7 +221,7 @@ struct ttm_device {
 	struct list_head device_list;
 
 	/**
-	 * @alloc_flags: TTM_ALLOCATION_ flags.
+	 * @alloc_flags: TTM_ALLOCATION_* flags.
 	 */
 	unsigned int alloc_flags;
 
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 67c72de913bb9d..233581670e7825 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -64,7 +64,7 @@ struct ttm_pool_type {
  *
  * @dev: the device we allocate pages for
  * @nid: which numa node to use
- * @alloc_flags: TTM_ALLOCATION_POOL_ flags
+ * @alloc_flags: TTM_ALLOCATION_POOL_* flags
  * @caching: pools for each caching/order
  */
 struct ttm_pool {

base-commit: c553832116b8d0039b13ae84d1ed06e7ee4f1fdf
-- 
An old man doll... just what I always wanted! - Clara


