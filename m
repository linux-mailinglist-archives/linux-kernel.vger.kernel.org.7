Return-Path: <linux-kernel+bounces-804701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B050B47BBA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 16:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B94172D6D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB60C262FED;
	Sun,  7 Sep 2025 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="RndfxGtH"
Received: from smtp134-32.sina.com.cn (smtp134-32.sina.com.cn [180.149.134.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF80126C02
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757253726; cv=none; b=om+mCWKj6wsLVg2motVRhU0Vcq2hKjV8zkxB0eZVZ2QCGhvPoj74Ekd25/iPJ+SzCj2BGrs9WJgqQG9XdU+dPcSr3bTYCzhiTKclWO6ccF5MJ+0yAxF2Xp+DxrvHejFmEbP9/Y7San6aJ4GaGx1DAHI8MF9cpU9yncMi/q90nAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757253726; c=relaxed/simple;
	bh=uG1Jkf/u9EMldF97dncH5aRZZNOhTA2dYNcpzI5hMZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yn38PgkovtwS/bMWQbec8hOEBx6K7YOJBBeT8+M+9xTQ4XHpWwV5hWeNFr8TwVw8YFQcm0t0gJSRpRdyAmCz4mlR5SvJbQCNGHNYegjr6HElgqEZG9sE52JQih0Qu16oZwNmLRSgxW1sU7OoergVAAc4cVlZjSvKINKXKK6IM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=RndfxGtH; arc=none smtp.client-ip=180.149.134.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757253716;
	bh=9FZz83ytcuXFk2CAxAf/otiWAiJLxGCf4fEcEtIN62E=;
	h=From:Subject:Date:Message-Id;
	b=RndfxGtH1sBNnw67c3Dkh1MZlUf7Ab+bdU9BssD6DrXLFwHpTGyfMQQfeK0lQU/fB
	 JsBNp1A5k9IxCV1NDwPybQJZh/mS/16ecun9bQmMJFuGyrcgEQEI9E1UyaheOw9hC/
	 /+vEMDwznsAxOdpolG5YkqLfb8Y/Xyw5oBz51yVg=
X-SMAIL-HELO: Yoga..
Received: from unknown (HELO Yoga..)([182.100.33.65])
	by sina.com (10.185.250.21) with ESMTP
	id 68BD902900006A34; Sun, 7 Sep 2025 22:01:15 +0800 (CST)
X-Sender: landegao@sina.com
X-Auth-ID: landegao@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=landegao@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=landegao@sina.com
X-SMAIL-MID: 602283408288
X-SMAIL-UIID: 5C638566D76A4FBAAE1C332FAD87E68B-20250907-220115-1
From: Degao Lan <landegao@sina.com>
To: wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Degao Lan <landegao@sina.com>
Subject: [PATCH] i2c: fix comment typo in i2c.h
Date: Sun,  7 Sep 2025 22:01:11 +0800
Message-Id: <20250907140111.40925-1-landegao@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a typo in comment. We should fix this.

Signed-off-by: Degao Lan <landegao@sina.com>
---
 include/linux/i2c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51..f1136cff0 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -335,7 +335,7 @@ struct i2c_client {
 					/* Must equal I2C_M_TEN below */
 #define I2C_CLIENT_SLAVE	0x20	/* we are the slave */
 #define I2C_CLIENT_HOST_NOTIFY	0x40	/* We want to use I2C host notify */
-#define I2C_CLIENT_WAKE		0x80	/* for board_info; true iff can wake */
+#define I2C_CLIENT_WAKE		0x80	/* for board_info; true if can wake */
 #define I2C_CLIENT_SCCB		0x9000	/* Use Omnivision SCCB protocol */
 					/* Must match I2C_M_STOP|IGNORE_NAK */
 
-- 
2.34.1


