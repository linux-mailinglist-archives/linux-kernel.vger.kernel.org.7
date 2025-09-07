Return-Path: <linux-kernel+bounces-804696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FB1B47BAC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EB03C387E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5A223D2AB;
	Sun,  7 Sep 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UcfBxMnd"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD11B5EC8;
	Sun,  7 Sep 2025 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757252617; cv=none; b=mG9sR27012Ws/dxeahvxv3PWLtVX7jYcoQERiGa3lICk2LTqIAij7nsjkoZ/RFBs0W7BgAx00hAY3bRitXjz3oZjfq/86O934oRHoXCtU6xceISOjwJTqNsBDMHH76HsZUHDyENdwgXS9xfUEmgAgD40CLq45hdCeKWYky/Dqt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757252617; c=relaxed/simple;
	bh=b4YzCrMygyvf3DV8YrwG1raJwNNKisBCLGicZGKPf24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhLhax+Ia/tnddMjCvv4xytyrGfHljwFcS5HokCGVJa6RZC9nUWncDlV+kolxaJsg6+pkn0YPZd9BkhG+o9uczbkMmLD7HAP4Nen5kIm7VahqfHF5GvnrJ9Pq2I+0t7pzfKSRrVEGeRi+1UqrhKxkyrNAqHYvc99lHS/jB+115U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UcfBxMnd; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id vFeuu1DSwECYkvFeuu0Mz1; Sun, 07 Sep 2025 15:42:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1757252542;
	bh=2ap9eqNKHrjb2ikA96D2NiiXoAmBGSsCtA7NlR3rYcM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UcfBxMndMvX+7k9SekCbrbLmxPlAJCfkCfjEloogd0dezlieosh4yEr6+y1JTX9Eb
	 jUVfJkoqCy40YuUQ9SW6g7NVsGnEPrCJBlKPqwcYZJ+rkRr9Q7pN1c2iZSNG0tWSn6
	 PBYgR0iA9ygw3glxgQKndaq5F9i+QjOyM8p2GAl1nNfhZ9MPRvaD/KJ0h8suUqKPsB
	 PgLEicMK1nPj02NKb9DhJdsCLam/w/Cd7JjwK/3SGnbBmL/9yM+vmSsCRVN3bODZtR
	 ipCD8UVBCC1KG7fwlq/zTcGzQCZW0q71UtNeb087egEliH/0mXQUho17hopVHGShPN
	 BCxFAljoxZKLA==
X-ME-Helo: fedora
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Sep 2025 15:42:22 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/xe/hwmon: Use devm_mutex_init()
Date: Sun,  7 Sep 2025 15:42:17 +0200
Message-ID: <989e96369e9e1f8a44b816962917ec76877c912d.1757252520.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_mutex_init() instead of hand-writing it.

This saves some LoC, improves readability and saves some space in the
generated .o file.

Before:
======
   text	   data	    bss	    dec	    hex	filename
  36884	  10296	     64	  47244	   b88c	drivers/gpu/drm/xe/xe_hwmon.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  36651	  10224	     64	  46939	   b75b	drivers/gpu/drm/xe/xe_hwmon.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/xe/xe_hwmon.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hwmon.c b/drivers/gpu/drm/xe/xe_hwmon.c
index 32a76ae6e9dc..e65382d4426a 100644
--- a/drivers/gpu/drm/xe/xe_hwmon.c
+++ b/drivers/gpu/drm/xe/xe_hwmon.c
@@ -1294,13 +1294,6 @@ xe_hwmon_get_preregistration_info(struct xe_hwmon *hwmon)
 			xe_hwmon_fan_input_read(hwmon, channel, &fan_speed);
 }
 
-static void xe_hwmon_mutex_destroy(void *arg)
-{
-	struct xe_hwmon *hwmon = arg;
-
-	mutex_destroy(&hwmon->hwmon_lock);
-}
-
 int xe_hwmon_register(struct xe_device *xe)
 {
 	struct device *dev = xe->drm.dev;
@@ -1319,8 +1312,7 @@ int xe_hwmon_register(struct xe_device *xe)
 	if (!hwmon)
 		return -ENOMEM;
 
-	mutex_init(&hwmon->hwmon_lock);
-	ret = devm_add_action_or_reset(dev, xe_hwmon_mutex_destroy, hwmon);
+	ret = devm_mutex_init(dev, &hwmon->hwmon_lock);
 	if (ret)
 		return ret;
 
-- 
2.51.0


