Return-Path: <linux-kernel+bounces-856117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4008CBE3209
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CA304E1607
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F721C9F9;
	Thu, 16 Oct 2025 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sr+tvkMG"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A5332861C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614978; cv=none; b=H0DMCp4zuUzKCiUBoMu9FHSTNFodgCmAUnP1PYK7YxoqnTnIRZHdYTEbe42nNeDxETVyiVTPa9EvaZiw3A2IzSzD/pyjEu/xNKn2v4We7W+uddoNZJaLz7Gc4wptsqhJSrIYQFpvgF1M12JL+J1RHRbouRZHfTbwBJdbxv9gajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614978; c=relaxed/simple;
	bh=TNbOWPpjZ96fYdOUei5Za2Ozo+sBYls3OZ4aBgEbuxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mo1vIdGXBe17FCf4sqKJOXfFz5B/eEo1jgyrQJ4nT2WDgSLOrzprgGEUWMVIFLjkb6+/pa96jTzQTH3pYoBTD90u5BOr3xPofpESYwN/TLEPiBdvPvxC9HbYhhBW4LwEXut9iaRrq5HnjkI+MOSOuamB9iygBbZH7bCKtY+kqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sr+tvkMG; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760614973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S+Rgc8T+WgHelpY6T/bd66cmIHUndzFo81Kh2h13IJI=;
	b=sr+tvkMGIjU2DKovstkr43vtcY4GIRTgsUqbvQgypTZNZnY7SX0LdmMN/zyE3YjiontU8l
	1UHtzFNKxaGSdMmGLr83zUGAC4QAx1hfh+exKR0GFXzx3EF1GEV9JgE66r8bby1Av++xFn
	L1J217YzsStJhrYqCpfDPc1JZQJvL1c=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Eric Piel <eric.piel@tremplin-utc.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: lis3lv02d: Use min to simplify lis3lv02d_misc_read
Date: Thu, 16 Oct 2025 13:42:33 +0200
Message-ID: <20251016114234.72221-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min() to simplify lis3lv02d_misc_read().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/misc/lis3lv02d/lis3lv02d.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 6957091ab6de..1a634ac1a241 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
 #include <linux/dmi.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
@@ -629,10 +630,7 @@ static ssize_t lis3lv02d_misc_read(struct file *file, char __user *buf,
 		schedule();
 	}
 
-	if (data < 255)
-		byte_data = data;
-	else
-		byte_data = 255;
+	byte_data = min(data, 255);
 
 	/* make sure we are not going into copy_to_user() with
 	 * TASK_INTERRUPTIBLE state */
-- 
2.50.1


