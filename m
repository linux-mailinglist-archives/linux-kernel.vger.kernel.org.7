Return-Path: <linux-kernel+bounces-725561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E13AB000C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DC61C251FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB75248865;
	Thu, 10 Jul 2025 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Dl3zp982"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EFB2222AB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148098; cv=none; b=dqDoswm3EsQewVW3owq/rpNsM1nrfxxKqxIoXdvkbvsUQBZkYb8a243r5FzWGNue/yosmqgUy3hqmcERVT1aXsoMep+TV7zM4EXrdQYFqtfYXNTzsy7oTYTxy0v45RKAgf/gwQAKBsR2DEplAV16KDJ1cWmwTgdtePGYLyH70bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148098; c=relaxed/simple;
	bh=zDHPXgfBdkzz4e62ZgSaLbipREdClGNoNA/+oT2RoyU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n40WqHB5IF7MVnF4bYBj/2joeNZ2hOS4e120Brn760US7FfXHiq/1NlR/y9IijdItzyvIje2uzeDyKPRkQA5hO6uriyZUpWISGXNED/Cd1qTit3KZLxSTV1iwzkx2clI1TgzvJZczE4UhtQ3/ZR5vXd3jGGZpHG/EADd+Fqt17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Dl3zp982; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bdClV313Mz9svm
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:48:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1752148086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0i2jRmH7FTcG+To7IWwCAeWfCFZ5GENB6jELYE5N9yo=;
	b=Dl3zp982joycPFqUOBcngzreu9M+X3vwrsROLm59j7OoAVrlIGTAwqZ1Q767onbo59Ak8o
	TQzA6MDMhZgU9cBWARoICozNQSAFeDpvnMRhCT2hdGObyT/pK1WNK5xxSAdQS0Oz84VCSl
	xTAkyGo7n7YFcmuHzRtfhKrczkBWVlL9m20wJGBFNQ8XTaLtTutCBz8fAhRzkq0WNMM2gf
	CJqjDYe3fmPKaUGJIc6Hc1B9SZM9WSs20tEzcXuFd/61LS9GMwA3M4z2n5iTqlwN+xHbER
	c92kEGqkgR0NSD6lcX1PmvrMXh7Wl7V27zwMHNtYuCFiz3+J4SE8tFlAZTrFBA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Stefan Roese's email address
Date: Thu, 10 Jul 2025 13:48:05 +0200
Message-ID: <20250710114805.3680341-1-stefan.roese@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2b7397161207a87e441
X-MBO-RS-META: sksh7yft93owjk4abosxzudpiwq79xxg

Update my email address in MAINTAINERS file.

Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb7616d241b9..ecadf36f4b47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -921,7 +921,7 @@ F:	drivers/mailbox/mailbox-altera.c
 
 ALTERA MSGDMA IP CORE DRIVER
 M:	Olivier Dautricourt <olivierdautricourt@gmail.com>
-R:	Stefan Roese <sr@denx.de>
+R:	Stefan Roese <stefan.roese@mailbox.org>
 L:	dmaengine@vger.kernel.org
 S:	Odd Fixes
 F:	Documentation/devicetree/bindings/dma/altr,msgdma.yaml
@@ -15414,7 +15414,7 @@ F:	Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
 F:	drivers/phy/ralink/phy-mt7621-pci.c
 
 MEDIATEK MT7621/28/88 I2C DRIVER
-M:	Stefan Roese <sr@denx.de>
+R:	Stefan Roese <stefan.roese@mailbox.org>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
-- 
2.50.1


