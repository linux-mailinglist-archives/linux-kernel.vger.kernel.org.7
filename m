Return-Path: <linux-kernel+bounces-871353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F042C0D028
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F2864E80C9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3472F362F;
	Mon, 27 Oct 2025 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1rMB5vz"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDD5366
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562136; cv=none; b=JTfStL0qzH0aARnHIkSHKq6RKa3VdWIxwpQqn2Rwd9FnUhUDd7rrqfh3b0W+7dpJJWrgcd1PstelTY0gQWWMAu+n6RL3UqtYyPzTVgR2KO9MOkVpSsvN76mKruXMsj279jnmn0nnQrqUeKFp8JWLaa9nfuWLzNIeJ7pUYlDB5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562136; c=relaxed/simple;
	bh=EIhTa266DKtgmotEipXcoJ2pNlQVu707lDOQMlu8pCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lg6BWcfKT+wJ9kKgzXsze0BIqT0cdxyLr/727CEy3VazcqVQznDMdb0NUg+Rpc/RXFg5OydP/HuJUEKncoi86ryOQbQ3sJGr8xAU/oxggFvpmT7oXepZKsnR67VWKAH4N++TqMWeRq5tdsJ5jkdxGHuuttyW4QAtQqpR9EgiJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1rMB5vz; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4e89ac45e61so44241111cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761562134; x=1762166934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SxzI7NDwCRsXq1m+WzfDT7lhcGD9O88pOGkXVsZVyO8=;
        b=F1rMB5vzWU7/9M+A1XtVORfB/17jTlpHMr52gNbazjfxPH7KKcXfqs+F7grmSa9ZGG
         Jcz4uqMXahDbnewjEr1OmCq7OXejvcgwno7MiQh7SeFt34S+Z2FBQMprVki6kbO6aoa6
         jjl3+xx7xbC1rB1S6nqS6vw8TupvweMa8pnl4xU/XczrXearHtlpQ7AeKUtychlAxxls
         GRYgcYaMM2e+ayq9OwS7b4iZ9xjXiP1glSIhb4IGq/mbhVsrrD3w4ol11tGc7u/WhRap
         3yiVVTTJyQSQhVqAIO+PVOQVCUFI7zN6DrBuuOxPAormllgspq8xHXWj1GknEd9tCW6Y
         2XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761562134; x=1762166934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxzI7NDwCRsXq1m+WzfDT7lhcGD9O88pOGkXVsZVyO8=;
        b=U2IMD+T/tD5Zk8+37oA3MPqzJYovKyayrzaBFiIv8beSSN/uac1HZ/joXdQHZDnbkA
         ThH5Feo/Z3oDSDxFzjmFTRIk/4/WD74zXFTCAApEGZq+jbLY9xBdnM29yT8KdIOVgvUA
         J2m+D/+zxKE1MJhYelbN3vkKfqaLLTVQ57QnBdoER2y2IyhxQ3hOZz7+mBC4XArzIV7e
         feFz56VZyIrLiNd0JQJzVaF/WZjLaBoD1QB3agHDAutu7fpbVHMtYItajGvdeBGC94Ls
         64uMINuW5MJVhDj1Q5767WL9KTq7EC0ioWLZ4IoLPQqDpn5KQCnZhXvas15FihrKblGC
         bKqw==
X-Forwarded-Encrypted: i=1; AJvYcCVYX6kwYHQgSQVh82xGTP1z2WJYjNbB3NRBGrmLHdy3SPS/nAA+wcRENgkmQogWdjUOVLiiubY59a8Yle4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhD9TCZ5bhqDMghbOMLXedbx/7wbPg5JcMEfPQEayovzpAYR6y
	mh+kRP1M+vLTGVKcm0KAAKurU1ghzbenKmDCNYOLvGBJryL4OkC+DNko
X-Gm-Gg: ASbGncuxfN8b0LJnGsFo2/fY11nM3/hXFalg7c3Z0DJfEeT6pPCagSlzUrc1Jfby8W6
	8C2xV9fFjYlezb8Uzj65Q6LJSHxrIqXMSTxOnqMPKUgRsTlY5B4dnyhc6OUOnqpp6yS2a4w9BZ1
	9STMD3Vx89cN7Kpp/MNxZP2muA4aEHpZVrtFZwQIF4QpCrTWHptKVbn6mDla4saJRJNrUxSp/Ra
	w50DM77Bwqs5sixvAQcw+KCIMUcC6/L6YXqGdJdhUYvp0FCB//Rh77JTY4Nept7UQPs/H8BFX9b
	eYUIZbEqBlddy4ZUiXRnhXc4OjYp07KyWEx0LRi3oWaAVt3iZsMctvJpPm1LExdKWREySbSRNz9
	gak0RRX/TH6WDkTM1V1//J0F40K8yIKtCnkK+rMreg9TlKshTg98zDgqx98N3ISS73hIFRl05mk
	6tHVb2HmRniIHTnoSU+22EUtyrtk8n8Ke63w1F6cF11KnaoQ==
X-Google-Smtp-Source: AGHT+IFaf8biHm1k9C9IbLJBFVhgyzdTCX16gPQL7GVUpD1HWkBNtLCfKnLaOxvFByRY+UJbU/RjdA==
X-Received: by 2002:ac8:7e88:0:b0:4ec:f285:4256 with SMTP id d75a77b69052e-4ecf2854e7amr45615501cf.25.1761562133703;
        Mon, 27 Oct 2025 03:48:53 -0700 (PDT)
Received: from wpc.yadro.com (host-95-152-62-139.dsl.sura.ru. [95.152.62.139])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3816faesm49455611cf.20.2025.10.27.03.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 03:48:52 -0700 (PDT)
From: bigunclemax@gmail.com
To: linux-gpio@vger.kernel.org
Cc: bigunclemax@gmail.com,
	akaessens@gmail.com,
	arturas.moskvinas@gmail.com,
	e.shatokhin@yadro.com,
	linus.walleij@linaro.org,
	linux-kernel@vger.kernel.org,
	mastichi@gmail.com,
	mike.looijmans@topic.nl,
	radim.pavlik@tbs-biometrics.com,
	u.kleine-koenig@pengutronix.de,
	zou_wei@huawei.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v3] pinctrl: mcp23s08: init reg_defaults from HW at probe and switch cache type
Date: Mon, 27 Oct 2025 13:46:26 +0300
Message-ID: <20251027104746.282351-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maksim Kiselev <bigunclemax@gmail.com>

The probe function does not guarantee that chip registers are in their
default state. Thus using reg_defaults for regmap is incorrect.

For example, the chip may have already been configured by the bootloader
before the Linux driver loads, or the mcp might not have a reset at all
and not reset a state between reboots.

In such cases, using reg_defaults leads to the cache values diverging
from the actual registers values in the chip.

Previous attempts to fix consequences of this issue were made in
'commit 3ede3f8b4b4b ("pinctrl: mcp23s08: Reset all pins to input at
probe")', but this is insufficient. The OLAT register reset is also
required. And there's still potential for new issues arising due to cache
desynchronization of other registers.

Therefore, remove reg_defaults and provide num_reg_defaults_raw. In that
case the cache defaults being initialized from hardware.

Also switch cache type to REGCACHE_MAPLE, which is aware of (in)valid
cache entries.

And remove the force reset all pins to input at probe as it is no longer
required.

Link: https://lore.kernel.org/all/20251009132651.649099-2-bigunclemax@gmail.com/
Suggested-by: Mike Looijmans <mike.looijmans@topic.nl>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Sander Vanheule <sander@svanheule.net>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 40 +++---------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index 78ff7930649d..edda2893945d 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -44,17 +44,6 @@
 #define MCP_GPIO	0x09
 #define MCP_OLAT	0x0a
 
-static const struct reg_default mcp23x08_defaults[] = {
-	{.reg = MCP_IODIR,		.def = 0xff},
-	{.reg = MCP_IPOL,		.def = 0x00},
-	{.reg = MCP_GPINTEN,		.def = 0x00},
-	{.reg = MCP_DEFVAL,		.def = 0x00},
-	{.reg = MCP_INTCON,		.def = 0x00},
-	{.reg = MCP_IOCON,		.def = 0x00},
-	{.reg = MCP_GPPU,		.def = 0x00},
-	{.reg = MCP_OLAT,		.def = 0x00},
-};
-
 static const struct regmap_range mcp23x08_volatile_range = {
 	.range_min = MCP_INTF,
 	.range_max = MCP_GPIO,
@@ -82,25 +71,13 @@ const struct regmap_config mcp23x08_regmap = {
 	.reg_stride = 1,
 	.volatile_table = &mcp23x08_volatile_table,
 	.precious_table = &mcp23x08_precious_table,
-	.reg_defaults = mcp23x08_defaults,
-	.num_reg_defaults = ARRAY_SIZE(mcp23x08_defaults),
-	.cache_type = REGCACHE_FLAT,
+	.num_reg_defaults_raw = MCP_OLAT + 1,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = MCP_OLAT,
 	.disable_locking = true, /* mcp->lock protects the regmap */
 };
 EXPORT_SYMBOL_GPL(mcp23x08_regmap);
 
-static const struct reg_default mcp23x17_defaults[] = {
-	{.reg = MCP_IODIR << 1,		.def = 0xffff},
-	{.reg = MCP_IPOL << 1,		.def = 0x0000},
-	{.reg = MCP_GPINTEN << 1,	.def = 0x0000},
-	{.reg = MCP_DEFVAL << 1,	.def = 0x0000},
-	{.reg = MCP_INTCON << 1,	.def = 0x0000},
-	{.reg = MCP_IOCON << 1,		.def = 0x0000},
-	{.reg = MCP_GPPU << 1,		.def = 0x0000},
-	{.reg = MCP_OLAT << 1,		.def = 0x0000},
-};
-
 static const struct regmap_range mcp23x17_volatile_range = {
 	.range_min = MCP_INTF << 1,
 	.range_max = MCP_GPIO << 1,
@@ -129,9 +106,8 @@ const struct regmap_config mcp23x17_regmap = {
 	.max_register = MCP_OLAT << 1,
 	.volatile_table = &mcp23x17_volatile_table,
 	.precious_table = &mcp23x17_precious_table,
-	.reg_defaults = mcp23x17_defaults,
-	.num_reg_defaults = ARRAY_SIZE(mcp23x17_defaults),
-	.cache_type = REGCACHE_FLAT,
+	.num_reg_defaults_raw = MCP_OLAT + 1,
+	.cache_type = REGCACHE_MAPLE,
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 	.disable_locking = true, /* mcp->lock protects the regmap */
 };
@@ -614,14 +590,6 @@ int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 
 	mcp->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 
-	/*
-	 * Reset the chip - we don't really know what state it's in, so reset
-	 * all pins to input first to prevent surprises.
-	 */
-	ret = mcp_write(mcp, MCP_IODIR, mcp->chip.ngpio == 16 ? 0xFFFF : 0xFF);
-	if (ret < 0)
-		return ret;
-
 	/* verify MCP_IOCON.SEQOP = 0, so sequential reads work,
 	 * and MCP_IOCON.HAEN = 1, so we work with all chips.
 	 */
-- 
2.48.1


