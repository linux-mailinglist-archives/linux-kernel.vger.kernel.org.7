Return-Path: <linux-kernel+bounces-804695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8690BB47BAA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA3C3C3879
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B30125D21A;
	Sun,  7 Sep 2025 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kc4uywrQ"
Received: from smtp.smtpout.orange.fr (smtp-76.smtpout.orange.fr [80.12.242.76])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B979B14BFA2;
	Sun,  7 Sep 2025 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757252499; cv=none; b=YGev/AGOaGN0P4BktzRDveWwm7LDkNpHBeb04KDtV1X8bfvvlzuT5ScS/ytDhAQCShTVjv6BLIafD/wFpgjUjeWAn8aV06CDMEDm1Y17GohoVbmcOiyFEWpbGGLW+t7i7FZC3EvGAvbbPztFDmXn4HlzFndd6tBJhv25dyb3288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757252499; c=relaxed/simple;
	bh=fks/yErO+zPT6GaCw7NtUhIlBUtZvaL7yMeiXmezYSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q352z6wW1IhtjW98sdeHqlwRmAhBeI+6T7KPt/lssl9GWukk6zDvQfH+Vq9Z3rDACa7fX/oM5xV8IlmC0IElpcNRbWPiJg+KdK6MOYsmp/H9PngrLD+TXqU48V0XyFvQGnySFZB6OPuDRgkucKTIreQP/NifTaEyZxAvvHW6+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kc4uywrQ; arc=none smtp.client-ip=80.12.242.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id vFVOuu4g5zvvrvFVOurnYa; Sun, 07 Sep 2025 15:32:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1757251951;
	bh=PuIjx4laPZOZU655RZR+rH1umOM75FsI08aXSYLjLjg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kc4uywrQzv+jq0gebDyoNW5rmgdKXRUob2Rgg2CFfX3hknCerUA8QCwXafVQ9knZ+
	 tYn9pR+tXSVsga1BTqqJW5ytdDXB3j+4QZO3t4KrjbymUI+Riu8g05rTHNBwH7PKJg
	 m/qWxQkUu0jMOirHjUwSD8ZrtKVL9T6QI5xdfgSkqqgfiy9v9mHy0GDSGJCWg2ZniR
	 uX2IDAtwgfOSS0XK7anki4Wwv06p8NHSYI9iF8vzzWfsOqvlxcczoqSIWx7eGQ0VCj
	 pHNK0XPQg9lNBp4f+kdqxEKeOpWAp6VUzBoe+Vsj/OzsvGCtTOty03UDWJqS9xgntr
	 870Tmi7QEE4DQ==
X-ME-Helo: fedora
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Sep 2025 15:32:31 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: quickstart: Use devm_mutex_init()
Date: Sun,  7 Sep 2025 15:32:26 +0200
Message-ID: <530b930c981c436c172c0308b348d4ae4ef72800.1757251867.git.christophe.jaillet@wanadoo.fr>
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
   7607	   2616	     64	  10287	   282f	drivers/platform/x86/quickstart.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   7301	   2544	     64	   9909	   26b5	drivers/platform/x86/quickstart.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/platform/x86/quickstart.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quickstart.c
index c332c7cdaff5..acb58518be37 100644
--- a/drivers/platform/x86/quickstart.c
+++ b/drivers/platform/x86/quickstart.c
@@ -154,13 +154,6 @@ static void quickstart_notify_remove(void *context)
 	acpi_remove_notify_handler(handle, ACPI_DEVICE_NOTIFY, quickstart_notify);
 }
 
-static void quickstart_mutex_destroy(void *data)
-{
-	struct mutex *lock = data;
-
-	mutex_destroy(lock);
-}
-
 static int quickstart_probe(struct platform_device *pdev)
 {
 	struct quickstart_data *data;
@@ -179,8 +172,7 @@ static int quickstart_probe(struct platform_device *pdev)
 	data->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, data);
 
-	mutex_init(&data->input_lock);
-	ret = devm_add_action_or_reset(&pdev->dev, quickstart_mutex_destroy, &data->input_lock);
+	ret = devm_mutex_init(&pdev->dev, &data->input_lock);
 	if (ret < 0)
 		return ret;
 
-- 
2.51.0


