Return-Path: <linux-kernel+bounces-750290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FE1B15996
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EF518A7E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBC628751A;
	Wed, 30 Jul 2025 07:31:28 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55BE1EB5DB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860688; cv=none; b=pOoGJVj+ve84hNt8edtRohxs2Tnggj7QVypJzWb5CgjjHgtN/qptynALJaZ6AOedHwbONWYFtm20k+GB236AFsW4BVfE04Ax8DQ2LIJBAZV2zThat9WDlyUbKFt4X1lD38MWh4BeKVWPD65WCzao6dwk12a5Q2JKc442jcTzJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860688; c=relaxed/simple;
	bh=lGANFSUGVJuOs7RkjlhNySfv8QsiOn3t9/P2gJicYgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nm64w+kuyvrcuNHQyqx1rfHMEsclADecO5CI8Q3L7mfK62muErucQJCrU5Ak+k7h2+igJt08hRp08GO2qe2n1wFCAxZOVkBc+8UTJbHXXStzA/UsSxzI3I9PA7oVtD55JV4KaYOd8MAAAetS8/wCuZ3/H4vujPRW2BTIOP+9aiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201603.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202507301530076602;
        Wed, 30 Jul 2025 15:30:07 +0800
Received: from localhost.localdomain.com (10.94.10.113) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.57; Wed, 30 Jul 2025 15:30:06 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: <lkp@intel.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	chuguangqing <chuguangqing@inspur.com>
Subject: [PATCH v2 1/1] gpu: drm: fix compilation errors in drm_vram_helper
Date: Wed, 30 Jul 2025 15:29:19 +0800
Message-ID: <20250730072919.3720-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250729060728.82402-1-chuguangqing@inspur.com>
References: <20250729060728.82402-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20257301530073bb4d7eec5c6854491af538e201b4cf4
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

We encountered the following errors while compiling drm_vram_helper.ko

ERROR: modpost: "drm_gem_ttm_print_info" [drivers/gpu/drm/drm_vram_helper.ko] undefined!
ERROR: modpost: "drm_gem_ttm_mmap" [drivers/gpu/drm/drm_vram_helper.ko] undefined!

The functions drm_gem_ttm_mmap and drm_gem_ttm_print_info are defined in drm_gem_ttm_helper.c. This patch select CONFIG_DRM_TTM_HELPER on CONFIG_DRM_VRAM_HELPER to resolve the undefined symbol errors.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 drivers/gpu/drm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index f7ea8e895c0c..01a314fdc9a8 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -226,6 +226,7 @@ config DRM_BUDDY
 config DRM_VRAM_HELPER
 	tristate
 	depends on DRM
+	select DRM_TTM_HELPER if DRM_VRAM_HELPER != n
 	help
 	  Helpers for VRAM memory management
 
-- 
2.43.5


