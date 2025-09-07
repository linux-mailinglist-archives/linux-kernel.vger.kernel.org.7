Return-Path: <linux-kernel+bounces-804611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC90B47A72
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE397B063F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14C123C51D;
	Sun,  7 Sep 2025 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Kvz20WYb"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF56A315D45;
	Sun,  7 Sep 2025 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757240497; cv=none; b=Zo88gcCB62YXKstMml8wFC0NVTwaD7WGRzqLZk5oFUa7jE4Tm8os3VTwNgqEdnbmxxHkxkF0FKxqeWjEIGkCcJin63opmfwvJh2KyxUBItQ4DmXi/teCTliLL+sab/G//1Vqh0Y3v7Bpb2vz3b1TeAoP+gdqD1o9ejrqDVMsiCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757240497; c=relaxed/simple;
	bh=1FZw3XLBNxWddQWDGiHb6R2oZ1pRTMmG29b8h/Sjv/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tlkJpEMiXG70/V8RwNNftIvHl6ZAPPRPEP1ofAu8I2uIBGt2ffb+mXxf9Gcazf8c3b1aUxMkoDlIjS2XYaOJMbFDCfwxDRinplNsokLFzJP2gL/4MHkmlKhwU1GOOG93YBndyJ2l0Kpk9CjvBSkStEYWJ9giUyhPgQz8AfeVj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Kvz20WYb; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id vCVUufhb0X5N0vCVUuZLQ2; Sun, 07 Sep 2025 12:20:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1757240424;
	bh=ao1u0LK62psCTkohZj0LictkGzMcdgdJRvSyY0Eybc0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Kvz20WYbMyXyK/059+yiEhW3kCT/1GphyJw5XRpFbrBEN7Sqyhcl5xc5KPbCOfdQg
	 Rwz40/+I90trVFPYV0kD0zDMwLbOPDpNAADuAIvaan+f7fO9srhw331SbEjDavvnqx
	 W13oG7na8Srp4c3Y3OuUZXBw+zHz4v/oOJ4SR8CvXneHy3MNqVD4+WeIXEsPf6hMkB
	 coVsJ3BS0/a1YkVMzxMCnDE24Qv9CB85kY3azidBSNzlA7gX1OYFfy4zxfTMTU7ANN
	 647S2qrkE07fZvBsVLaGQWIcCVjdeJeCte95zs/dHdX8+0OygWTtbQaClGHKDG2+bk
	 WtSwNRK1ZItGQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Sep 2025 12:20:24 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: (nzxt-smart2) Use devm_mutex_init()
Date: Sun,  7 Sep 2025 12:20:20 +0200
Message-ID: <f51fac0871ec7dbe4e28447ee4f774d028a53426.1757240403.git.christophe.jaillet@wanadoo.fr>
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
  25878	  11329	    128	  37335	   91d7	drivers/hwmon/nzxt-smart2.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  25551	  11257	    128	  36936	   9048	drivers/hwmon/nzxt-smart2.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hwmon/nzxt-smart2.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
index c2d1173f42fe..58ef9fa0184b 100644
--- a/drivers/hwmon/nzxt-smart2.c
+++ b/drivers/hwmon/nzxt-smart2.c
@@ -721,11 +721,6 @@ static int __maybe_unused nzxt_smart2_hid_reset_resume(struct hid_device *hdev)
 	return init_device(drvdata, drvdata->update_interval);
 }
 
-static void mutex_fini(void *lock)
-{
-	mutex_destroy(lock);
-}
-
 static int nzxt_smart2_hid_probe(struct hid_device *hdev,
 				 const struct hid_device_id *id)
 {
@@ -741,8 +736,7 @@ static int nzxt_smart2_hid_probe(struct hid_device *hdev,
 
 	init_waitqueue_head(&drvdata->wq);
 
-	mutex_init(&drvdata->mutex);
-	ret = devm_add_action_or_reset(&hdev->dev, mutex_fini, &drvdata->mutex);
+	ret = devm_mutex_init(&hdev->dev, &drvdata->mutex);
 	if (ret)
 		return ret;
 
-- 
2.51.0


