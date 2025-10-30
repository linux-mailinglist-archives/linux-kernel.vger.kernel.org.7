Return-Path: <linux-kernel+bounces-877415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C592C1E107
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26EDA4E2DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F22DFF18;
	Thu, 30 Oct 2025 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QkXK9gSl"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3492DEA96
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789412; cv=none; b=LLdo/EKPpWq8LMRkQcNbb3JEFaUCaDdr4xruOy4i4YStcIC0Dpv9IZSx6b0dE+S6GJ42wAwb8xhEjg9E8RnMxOmqyTr39rPTC89YND1PmtDWBQ9PNaEu4imVipj/3FuFK/Qzta+cy5hjQZW+K4JBZuf4hgam8oFNGosBqh8sCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789412; c=relaxed/simple;
	bh=xgI0k1zBj6veilhSe9B7qB0HN8NSz/cs9usom9mrsm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAjb8BIqzFyefrW7maJ7rmRZMqKCIOg7OPoEF5rwKufEPuZML2blC644NS9vUhUBs2cCipvmBJ1Qj0IDnNxQeWkbHslJVeE1RLBCeWcIZHDHPEWa7xxRlKFjZJVEOuzKT5adYCF4musX7plKHsQkiR7h/Di8I8tTuIxKAtGAu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QkXK9gSl; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761789400; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bz3NOx7T4kZd94YviM38jzlgzBI25Whvb17qsPXmPYo=;
	b=QkXK9gSldhIw9GArDWyOFhH7riUxU5MPgyl0iVZj4d39Gei58bni/LKUm+EReiF0t0XZzhSN/zZxzCT4Q530GdUI1NFGkrdMG9n6EdffQi30c2TIFoeqHpgVHD35JmlzdIDWminAVgBSb6MdKH6NoaMEf5SuOnfTsgpTAgwj7AA=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WrI.U.A_1761789393 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 09:56:39 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 3/3] drm/amd/display: remove unneeded semicolon
Date: Thu, 30 Oct 2025 09:56:29 +0800
Message-ID: <20251030015631.3106732-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:7392:3-4: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26821
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bb0fe91a1601..b53a2af1b30d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7389,7 +7389,7 @@ int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
 		default:
 			dm_new_state->abm_sysfs_forbidden = true;
 			dm_new_state->abm_level = val;
-		};
+		}
 		ret = 0;
 	}
 
-- 
2.43.5


