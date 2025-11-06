Return-Path: <linux-kernel+bounces-887626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3000C38BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9D93B47C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B048F20E023;
	Thu,  6 Nov 2025 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ux/u5mvj"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222701C3BF7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393689; cv=none; b=VDPf/Hm+MmRBBkIc9u/N0xPQLPYKo5+kNbOE4MRkKalwS5oVQynbyPT9nqmxvCfRGKrFw5jVFrtgwgMaIrxFK9NngMjO8yIoMQPUcSy70P5h73FUrNIdx6giHEfwRaGP9VEm+67A1OxRCLhFXAySHWykWYLxy8hueOIWrdeza1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393689; c=relaxed/simple;
	bh=N9Z6x/+q9VV8d1+/g2yquSGB5fui5IKT2Juq43OZErU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WkUFtWlv4YNrkOM7eIo7VTbV9lFpVXRUwYKdndedBBwrDOJLhdO28+1X1w91k5YZ3zwXtVPhJysaVCmzyQ09Q4AgDrWzMCzybMrnuzoI0tU8SlgYGq7AOpq8GEqwm4yOktBYrKKnHZXOcermdd37tfqgl9VR5FTKRS4fAM4QbUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ux/u5mvj; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762393676; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JleXV2cElTuz2OqNV5twzdb7cDT+l16Orn/ETYLhCd4=;
	b=ux/u5mvjes1KIZ200OHwEK0oMtJw7GYWOR7DiF6b6/P8kfGDlQWbDT1uMr26Fm7onMYnIboGh8I2SB4xY6u4zM7Ovh3HMtuly5Tk4LeejAKwKYxDBZ4liWZVSJ+K4MKYHO1ypaR4iMwVWprteutR+AOw0hiaGvk9jC9pIc4H2gg=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WrnXrhY_1762393669 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Nov 2025 09:47:56 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amdgpu/userqueue: Remove duplicate amdgpu_reset.h header
Date: Thu,  6 Nov 2025 09:47:47 +0800
Message-ID: <20251106014747.46768-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c: amdgpu_reset.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26930
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 836a14ef0052..9a969175900e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -32,7 +32,6 @@
 #include "amdgpu_vm.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_hmm.h"
-#include "amdgpu_reset.h"
 #include "amdgpu_userq_fence.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
-- 
2.43.5


