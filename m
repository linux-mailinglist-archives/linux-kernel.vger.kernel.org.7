Return-Path: <linux-kernel+bounces-735969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A53B09613
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B62316D483
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9685E22A4D6;
	Thu, 17 Jul 2025 20:58:26 +0000 (UTC)
Received: from erminea.space (erminea.space [51.250.125.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC379EEBB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.125.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785906; cv=none; b=H8Q2WApx1eBDldg+OBqQdTtqJOM/dID0IRXIht9VntiNz8EtSKcv6YcIlmpy/R7BpjitCuWriuAwHiMtwzs3vIaqdwXM801sSfCLL6VQ7TYMOe2kJNyBNE3kLMx3fYyCCACjiBg8TNfzpoU70pRpigvIDIJALl6epRDeu+vFqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785906; c=relaxed/simple;
	bh=q8dxv91agcB5amds5q5rEuc+Gx0fAE3N0DKkgW2QDEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYoJRsVjZTX37wo337hw6XAY7wKtrKH6YS6WlIyGdaBe0AhEMk+or4c6blVSrUwnaU8y+rERXYJa+sakStd2//8C9aHUbXGK7s0xHzaKxd/Zod0nJ9rJ0Bg5Ca48ZfPpLJK/21e8KiPahIxa1G8jF+YfTj+jGH95evmk233XTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=erminea.space; spf=pass smtp.mailfrom=erminea.space; arc=none smtp.client-ip=51.250.125.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=erminea.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=erminea.space
Received: from alyaptyap (unknown [37.204.49.201])
	by erminea.space (Postfix) with ESMTPSA id 9ACAA13CF;
	Thu, 17 Jul 2025 23:48:34 +0300 (MSK)
From: Peter Shkenev <mustela@erminea.space>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: check if hubbub is NULL in debugfs/amdgpu_dm_capabilities
Date: Thu, 17 Jul 2025 23:48:17 +0300
Message-ID: <20250717204819.731936-1-mustela@erminea.space>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HUBBUB structure is not initialized on DCE hardware, so check if it is NULL
to avoid null dereference while accessing amdgpu_dm_capabilities file in
debugfs.

Signed-off-by: Peter Shkenev <mustela@erminea.space>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index c7d13e743e6c..b726bcd18e29 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3988,7 +3988,7 @@ static int capabilities_show(struct seq_file *m, void *unused)
 
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 
-	if (hubbub->funcs->get_mall_en)
+	if (hubbub && hubbub->funcs->get_mall_en)
 		hubbub->funcs->get_mall_en(hubbub, &mall_in_use);
 
 	if (dc->cap_funcs.get_subvp_en)
-- 
2.50.1


