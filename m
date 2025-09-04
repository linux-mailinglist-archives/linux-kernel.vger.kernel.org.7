Return-Path: <linux-kernel+bounces-799824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE2B430AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF714200856
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51B7225A35;
	Thu,  4 Sep 2025 03:54:16 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB8DF9CB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958056; cv=none; b=TOVNZN1BIBuR2BHiSidb07cd9D8GS210CcYxaAztVFZmCAEVveHBRawK0Sl/k1VsLsxqk4u1S0yjW2qwpqMl7PI62m9TqWCxtwuZmNUFrRAP5WiefFD636aZ3tYvqkVER7ioavawnibc7ABY8lc0XOB5Viymf2oBzZ23dJX9BP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958056; c=relaxed/simple;
	bh=V+hJ1fP7uf/nGq8/27YZ5i+4npXqTJlURF/TPTEPL6c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N/D3jHICeQagIsTm7nvJKgUABpmEB3CsoWyRLu1jbgDHXrrR6cl9SocMgbi7XLytDgPEPzTeaYyuyZ9f821sFxL4Rf4CTlMz2O50AAGMb/i2cIKpwm6XWXqwTrjsEEQF3DmNpsyqjXuIPmV4YPbAeyLY+UEqW9RHEJ7T2GY9/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cHQTN4HjBzPqgK;
	Thu,  4 Sep 2025 11:49:28 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C2D6140109;
	Thu,  4 Sep 2025 11:54:05 +0800 (CST)
Received: from kwepemn200010.china.huawei.com (7.202.194.133) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Sep 2025 11:54:05 +0800
Received: from huawei.com (10.44.142.84) by kwepemn200010.china.huawei.com
 (7.202.194.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Sep
 2025 11:54:04 +0800
From: Qi Xi <xiqi2@huawei.com>
To: <bobo.shaobowang@huawei.com>, <xiqi2@huawei.com>,
	<andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
	<Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <lumag@kernel.org>, <dianders@chromium.org>,
	<lyude@redhat.com>, <luca.ceresoli@bootlin.com>, <andy.yan@rock-chips.com>,
	<viro@zeniv.linux.org.uk>, <mordan@ispras.ru>, <amishin@t-argos.ru>,
	<dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: bridge: cdns-mhdp8546: Fix missing mutex unlock on error path
Date: Thu, 4 Sep 2025 11:44:47 +0800
Message-ID: <20250904034447.665427-1-xiqi2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn200010.china.huawei.com (7.202.194.133)

Add missing mutex unlock before returning from the error path in
cdns_mhdp_atomic_enable().

Fixes: 935a92a1c400 ("drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qi Xi <xiqi2@huawei.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index a614d1384f71..38726ae1bf15 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1984,8 +1984,10 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	mhdp_state = to_cdns_mhdp_bridge_state(new_state);
 
 	mhdp_state->current_mode = drm_mode_duplicate(bridge->dev, mode);
-	if (!mhdp_state->current_mode)
-		return;
+	if (!mhdp_state->current_mode) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	drm_mode_set_name(mhdp_state->current_mode);
 
-- 
2.33.0


