Return-Path: <linux-kernel+bounces-767313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C703B252B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FEA189F188
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EBB2C0F90;
	Wed, 13 Aug 2025 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iiD4jyZC"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71662C0F7C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108107; cv=none; b=jxK/qMrnyYS+CnZxn2RXUlF42WhISpdwMirEQs9KSriduJOwiOVitayy/pgNqiBFgbr2AqMbpHwWsI7BNjFj7BNjKLTD9cdJcMFcWQYM4IQ7jS6wciJzpL+mhDjOdaiIO2F1/qm1bg1NJpUKc6awHZIIvWj07o1tZU5jLbJqiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108107; c=relaxed/simple;
	bh=DdGQvARGYSfRF9WXUaETVJF+UPWm09ofprzI+9IXM1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYraPd7PTDUWLHtV8KhNHc/J1YGQnsS25iZyxrZPAZ+jQTlhhweyuyauhzjUzYb8PdcBm3HvN2k07qDCDODRnevds2Z9RL0MiWx1tLeRm+dwsEABQnJGE3L4RbM6WNbQ9V0Er+pBJBXhok24jnytu8E+v9exUMjX/2vmnRKw3rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iiD4jyZC; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755108102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gbmgmwoLMK/HrRVMf3/l2v9tAJPLP87f8kRpLch6vIE=;
	b=iiD4jyZCzJlsBNEUYkGHYv0IbcxeyYdsx4ipmNrSf1gXn6Cy1vTrGZQ/HzMae/mSLzId9H
	uvg/ku0R6mV+15wGuyaA0ueJjkSonFwix6+062WeDY3vcLIPdIxn8ig5dLNjYWc/cpe7hy
	EHV11didhdTszbF2kxV/nZ8pYtZ0YUs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Stultz <jstultz@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: hisi_hikey_usb: Use str_enabled_disabled() in hub_power_ctrl()
Date: Wed, 13 Aug 2025 20:01:08 +0200
Message-ID: <20250813180108.209096-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_enabled_disabled() helper
function and silence the following Coccinelle/coccicheck warning
reported by string_choices.cocci:

  opportunity for str_enabled_disabled(value)

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/misc/hisi_hikey_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index ffe7b945a298..2c6e448a47f1 100644
--- a/drivers/misc/hisi_hikey_usb.c
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -18,6 +18,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/usb/role.h>
 
 #define DEVICE_DRIVER_NAME "hisi_hikey_usb"
@@ -67,7 +68,7 @@ static void hub_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb, int value)
 	if (ret)
 		dev_err(hisi_hikey_usb->dev,
 			"Can't switch regulator state to %s\n",
-			value ? "enabled" : "disabled");
+			str_enabled_disabled(value));
 }
 
 static void usb_switch_ctrl(struct hisi_hikey_usb *hisi_hikey_usb,
-- 
2.50.1


