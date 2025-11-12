Return-Path: <linux-kernel+bounces-896800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE07C513BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A76D34DC70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F3E2FD680;
	Wed, 12 Nov 2025 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cSISo1XM"
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651C23BD1B;
	Wed, 12 Nov 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937910; cv=none; b=oCbHqqNPy3OJLH+Mt8pTDGfaI1H2LAMO7jYeMXrZXBQ0NQPkY5YpgAPCOZVyx50kztG7yc72it6piWvQk7D2tikjz5VbXVyb9qzgcvRr+QStajTE6/Dgj0wpLH0xffVRdUAWS6TRB3IN9LlIlMsTBWIrjV84zyd0LJUHAqeyt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937910; c=relaxed/simple;
	bh=tXQQ4fbAuXxhZPSt4x5JFH51z5E6Ui5SnezzUVyUs0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E83Hv78QW94Js9rZ+IjsULnzrCRWHm91SWa9D8msypb8LubCp2Vd/RU6znnPrXEoV8XjnGEzUPvFyiNLV+e1pjmC5DFIgAj6RE4Rqz9ZxAa9KFry0h4e+Ah/GWrRxJnEn2gz0UbWy6v/1myUCfG7DW0A3EBRUsC7Z3Sa3pQY9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cSISo1XM; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Hz2aMp+91k8drL/1UYCq22RzQW2AqN5GlR5SyTfP0gA=;
	b=cSISo1XMw2EC8v0zcWAfcmYUzMYKUx+W/3+tPEmzuqeB5OzmsImS/AF1ag7fEUWaapJcUkYvi
	LJ8jzciLEbZFRCDm0lNmNdHUvJSwr6KCXRM1IMDLFQ0LirCf2LuSwTCMXRDsKgDQQBt/i7k5gaK
	pkT4Wrnx8j1kk3eHs8Lnu98=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5y241JHMzKmTk;
	Wed, 12 Nov 2025 16:56:44 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4698E1A0188;
	Wed, 12 Nov 2025 16:58:24 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Nov
 2025 16:58:23 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: gus: Remove unused declarations
Date: Wed, 12 Nov 2025 17:20:07 +0800
Message-ID: <20251112092007.3546539-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

snd_gf1_synth_init() and snd_gf1_synth_done() were declared but never
implenmented and used since the beginning of kernel git history.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 sound/isa/gus/gus_reset.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/isa/gus/gus_reset.c b/sound/isa/gus/gus_reset.c
index 5cbace8369f8..a7a3e764bb77 100644
--- a/sound/isa/gus/gus_reset.c
+++ b/sound/isa/gus/gus_reset.c
@@ -9,9 +9,6 @@
 #include <sound/core.h>
 #include <sound/gus.h>
 
-extern int snd_gf1_synth_init(struct snd_gus_card * gus);
-extern void snd_gf1_synth_done(struct snd_gus_card * gus);
-
 /*
  *  ok.. default interrupt handlers...
  */
-- 
2.34.1


