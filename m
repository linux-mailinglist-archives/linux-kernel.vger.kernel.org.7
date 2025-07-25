Return-Path: <linux-kernel+bounces-745478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EFEB11A85
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B80AE1809
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05467272E48;
	Fri, 25 Jul 2025 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2d9UnIM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658672727ED
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434374; cv=none; b=QaEia9Dj8btGiX+7Jx+zVphgux9woUbJEPV87BuzCSU/uBV2EYOpyGc9e/P9DPvremls6RqJmDX3LX54PA+LBmb3udfigYJee7+7jcn+9Pf40DReFdqwl4TP4X9zqF30z/XwXdacduOjmLECC9DnQaRosFl3IIYysSUYS1dsn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434374; c=relaxed/simple;
	bh=aIZGN0x63wAzy9/izY9Hgw3KlM1G2FyR9sBBcONzThw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rmTnd+zowk0HwKIjK0ts+iDj19fY7n0xuWf27t8HcBmJIXac1l6Dee2GxlC28ZkrY6xa3oOtZSDuzi8l8iWe9ZYn9AZuISqRv2BC2FL5KDgTlp+UOVAzgW7xbnnf9ZeMzYi2FQU4KrcqCOo9KeF9ViV68YNbw2bTl8iXFa/szdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2d9UnIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B7EC4CEE7;
	Fri, 25 Jul 2025 09:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753434373;
	bh=aIZGN0x63wAzy9/izY9Hgw3KlM1G2FyR9sBBcONzThw=;
	h=From:To:Cc:Subject:Date:From;
	b=D2d9UnIM60QaFebEMj+S6SB8Bh9lHPpnvwc2yIQ1HF8px9t6IPzmzCHM594VjTMbP
	 2zPdGRtKGwox0jlZXMkitrEjk3eRMy4Qf9sH5OyvP9aewEI197ZDXV8THfOVkHQrwx
	 +gQmFubtvNmWFDKxnm9IZFjzYm90KpsWwcUbvJ9yqQcnzHs5iff3sH/fpBCsO6IZjV
	 vlQb/dpoIjaLiV28aqJXZUta74NVGxzsMWdvmTqvsKepmpTc6pEnoWIPF/NZ09Iyv4
	 XilQ3sNRfBOH2MAmhmtqmyOCqY/V3QmaBzbuuJ91h7t0meQDRIGZJlediKxU/HAYFg
	 Tl7LzUoEtD5yw==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: fix module_i3c_i2c_driver() with I3C=n
Date: Fri, 25 Jul 2025 11:06:03 +0200
Message-Id: <20250725090609.2456262-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_I3C is disabled and the i3c_i2c_driver_register() happens
to not be inlined, any driver calling it still references the i3c_driver
instance, which then causes a link failure:

x86_64-linux-ld: drivers/hwmon/lm75.o: in function `lm75_i3c_reg_read':
lm75.c:(.text+0xc61): undefined reference to `i3cdev_to_dev'
x86_64-linux-ld: lm75.c:(.text+0xd25): undefined reference to `i3c_device_do_priv_xfers'
x86_64-linux-ld: lm75.c:(.text+0xdd8): undefined reference to `i3c_device_do_priv_xfers'

This issue was part of the original i3c code, but only now caused problems
when i3c support got added to lm75.

Change the 'inline' annotations in the header to '__always_inline' to
ensure that the dead-code-elimination pass in the compiler can optimize
it out as intended.

Fixes: 6071d10413ff ("hwmon: (lm75) add I3C support for P3T1755")
Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/i3c/device.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index b674f64d0822..7f136de4b73e 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -245,7 +245,7 @@ void i3c_driver_unregister(struct i3c_driver *drv);
  *
  * Return: 0 if both registrations succeeds, a negative error code otherwise.
  */
-static inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
+static __always_inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
 					  struct i2c_driver *i2cdrv)
 {
 	int ret;
@@ -270,7 +270,7 @@ static inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
  * Note that when CONFIG_I3C is not enabled, this function only unregisters the
  * @i2cdrv.
  */
-static inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
+static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
 					     struct i2c_driver *i2cdrv)
 {
 	if (IS_ENABLED(CONFIG_I3C))
-- 
2.39.5


