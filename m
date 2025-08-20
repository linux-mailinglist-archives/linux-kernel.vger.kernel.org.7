Return-Path: <linux-kernel+bounces-777484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF9B2D9FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326517AA6CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827802E0B69;
	Wed, 20 Aug 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qvy1msbG"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F792512E6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685721; cv=none; b=Qqy4Tdj/B8ht7jU0htnE1IPoWqy2OSaReNB8gC5fm8Ww6OtF91h2NE73DCWMonK6olPLQoLlpFFL/any2Fjm/C+8AG+Bn4OujCuhPPbqsF32/lCUseIr/TlkSga44df8236zfjaWMjiAafdps/xi2WWwN63HZElNlYF/Ke6rqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685721; c=relaxed/simple;
	bh=VvBPP1JzxSZ24YX0L1zBg4DhL9aZlsTeaXuWUncsHzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qB1b+t77XyrSFUsARYKzV0UNVHMNHvHyrCOW3DK8ZhdNPfxrASlZtwy9DfjO1U72JkEpdgZ5XGMFdMUZOhIu3M2jpNmlic6F2o2IdIgak+H4nzyZN2cMP+hNw/XRbnY/jWWThbnspXlI8ENJBOtjYyLshnSenIFjlAfbCJidWF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qvy1msbG; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755685715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bK8IIfEe1FOZoRdwos/L/+QGHLxUxijwme8tytQJ0yM=;
	b=qvy1msbGccyFE38vu7ohoidQJBRcEd2iZi1YeiVAO5Z3gF97gSx/TxksEH5Od5hBlFwOxn
	ltiDyUVw9ZHJ65XzIAgl73lxk/i9YsJ7Og/Q2CxjD1z8WtpRI/rmLuBTaj4gM1NLGYnKDe
	cRxdnL1h6sJiERIp7gF6DlCz4tS+I9k=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Michael Hennerich <michael.hennerich@analog.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: ad525x_dpot: Use str_enabled_disabled() in sysfs_show_reg()
Date: Wed, 20 Aug 2025 12:27:34 +0200
Message-ID: <20250820102734.760844-2-thorsten.blum@linux.dev>
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

  opportunity for str_enabled_disabled(..)

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/misc/ad525x_dpot.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/ad525x_dpot.c b/drivers/misc/ad525x_dpot.c
index 756ef6912b5a..04683b981e54 100644
--- a/drivers/misc/ad525x_dpot.c
+++ b/drivers/misc/ad525x_dpot.c
@@ -73,6 +73,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 
 #include "ad525x_dpot.h"
 
@@ -418,10 +419,8 @@ static ssize_t sysfs_show_reg(struct device *dev,
 	s32 value;
 
 	if (reg & DPOT_ADDR_OTP_EN)
-		return sprintf(buf, "%s\n",
-			test_bit(DPOT_RDAC_MASK & reg, data->otp_en_mask) ?
-			"enabled" : "disabled");
-
+		return sprintf(buf, "%s\n", str_enabled_disabled(
+			test_bit(DPOT_RDAC_MASK & reg, data->otp_en_mask)));
 
 	mutex_lock(&data->update_lock);
 	value = dpot_read(data, reg);
-- 
2.50.1


