Return-Path: <linux-kernel+bounces-837425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94963BAC499
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53005321AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE7F2F616B;
	Tue, 30 Sep 2025 09:37:11 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EBE2F5318;
	Tue, 30 Sep 2025 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225030; cv=none; b=P4PzeOJOD1kKQHe+9AtQcXlGiPzIgiFamisg03gKGuKO38VaeS7fFWawE9H6ErZgnkxrZ5MoF7cplFMUPKwhF0OaBXpwD4qVi1qNqmcZDTNxkKHQEdjwYZvOozawgjpEyGXXMm/Zgqmh/DDhcaY9JREJVtjgrcB07zKwWZsQ5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225030; c=relaxed/simple;
	bh=Y6OkhKVDvK21U87dqVq46fEGWxviZwn0EdVpHOKmqME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EzIl7202dh2J7ksHz3yrgP4GZKvFl83oFNd+iH0AYqJ4jRbJdmOoUygIpUu5oKa07ssTVuX26SsymoBdpjep+VLYtxM6h97TzK7UQJBph/u9280WfUd3fpiNcS0bQINzLIMfH7EGDHTZJUyLxWuJK/9IHZdV9hUWZIzdMdQTquU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee768dba403d9f-79e61;
	Tue, 30 Sep 2025 17:33:56 +0800 (CST)
X-RM-TRANSID:2ee768dba403d9f-79e61
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee768dba3feefb-cea1f;
	Tue, 30 Sep 2025 17:33:56 +0800 (CST)
X-RM-TRANSID:2ee768dba3feefb-cea1f
From: tangbinzy <tangbin@cmss.chinamobile.com>
To: shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoc: tas2783A: Remove unneeded variable assignment
Date: Tue, 30 Sep 2025 17:33:49 +0800
Message-Id: <20250930093349.1934-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Bin <tangbin@cmss.chinamobile.com>

In the function tas2783_update_calibdata, 'i' to 0 is repeated,
thus delete one.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/codecs/tas2783-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
index 1fb4227b7..d62667957 100644
--- a/sound/soc/codecs/tas2783-sdw.c
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -693,7 +693,6 @@ static s32 tas2783_update_calibdata(struct tas2783_prv *tas_dev)
 
 	tmp_val = (u32 *)tas_dev->cali_data.data;
 	attr = 0;
-	i = 0;
 
 	/*
 	 * In some cases, the calibration is performed in Windows,
-- 
2.33.0




