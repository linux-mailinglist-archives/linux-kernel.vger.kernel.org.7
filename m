Return-Path: <linux-kernel+bounces-846873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C9BBC94CE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E1819E82E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC132E8B7A;
	Thu,  9 Oct 2025 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbrsIOey"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D32D0625
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016586; cv=none; b=XufjkzUm4fQPq2TzPJpyL99GPp/qmUf0g4PVLOu3GkA41ulhCawBQSTENeE1xeWdJuNzBwW2/54Zsuad5ruexIWYFCxh0Nvi4CzeFnm31QtbrXda6IIXrMhwlJsVN4z0R93GDUazqeZo9XR5xk1q233vxS8IPWQDonFIJ7dqpQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016586; c=relaxed/simple;
	bh=E1h2IymeZxzN8DEA2ATr3BDwi+1E2Uj1VWWEwU62eVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NL1+10soSQq8eanb7XTN1iXVu+GhMsaEYXL8N8GsIUcfYc2xVHkR6hGjiEA1B5rI/XC17AMdZ9wWnpxb1pyyi41VcL3Tr0L5I2yC9Xy53fRhKixA8REeM8q+/cnjKI8YcB+6komaJ57Goa5cAI9qVMn4v0IdIkggzzyx2tIhpm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbrsIOey; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57bf912cbf6so1025329e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760016582; x=1760621382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QoD3OyvkVVLE8lgWVUBgOO0PRXTO7rnUz/rDybwGWOw=;
        b=hbrsIOeyE7lstuSc4qq2WI8N3OXwfrDdCDfz660iAd69eGF4Yw/NTBl2RmFXXt3JUA
         K5NI9xZhIxaOgh4sc/jkC4a3xElxpSCa5/jLHWO6DfOtQ+saYhzjSXakH50R/yRh7kZm
         /iFqPt6BfDKc3FflhS/yPzAL3oZ5TC3xQ+3bx59jP40jiwwHrXYns1lbDyBentOhkLyw
         incDVtmXw8dOQ4gaZYLC6kNuRb0p5LAjEpz1j/xOxvd+VnNKBd6aLAKbroYvfwCnvCR4
         P0UptJ5G8fmvvsZIN+n51DYlVQuboTnZq1D/EKjbG9vqT0eCGW7pA43+reXSx1H2j375
         vknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760016582; x=1760621382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoD3OyvkVVLE8lgWVUBgOO0PRXTO7rnUz/rDybwGWOw=;
        b=jv/HZGdMaBZE/9Q95r4fvBaLAbtSMJJ0sVlrr+GSqVHmjvd+Aodjuu519z07sUjr2E
         1I+H6iQUcS3btYDuKM8y4FiX981Tucn3G94f2Moa20uGn9xp1KWrT0xEcDfZnyhf42mu
         NlggO3UxjErjrQNDq8vW/WXwVDaX1QVChOL67y99CnLbS+pHKwGpqZyn/3ZDAveP7For
         x2y4IHGSzz1tSbY/bw2V85b/Rc4Z+p4NwO+XfZwWvRbBG3bap3ZgvNObc475tTv7lvsL
         WWGZDryHlR9JW4kyMpZ2zAiW+qzYVpjjDsml4OtoJ8VueA4E6V5eDlmx6vMGMkuMOXX2
         vygw==
X-Forwarded-Encrypted: i=1; AJvYcCV216ZgHwrJqvtTpch61N1qJ524zwULkvbKiBERVoTi4QNb88BcZqzqY7I/ef+ftXJgxMXua0JLgV2McDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDalipa7Lx+lrlQwM9aO5iYqvhlFShkg49T/kSJd6EEXFIK9bn
	DsCZad/2hZSIF+snXtO4nxWLW7G9sBdnnDgcNPFELeFPVVMtA1uFb54pm4kxJ8W/
X-Gm-Gg: ASbGnctBPmSc/xJQ7lh8NgdGxeighZ0NEedLUUNgD5npIN/LcE5mVv3R6aALY3mVPeW
	RhDqNELLY0xki3PxSrt+XQIpSbHPUNjE2gRTdbuvSieMJNxgIof6D1D1trA4dUmP0e09V9LaPSC
	+72Qp8hFiVQ7JF9MVfg5XuWowkXNRJV+rI5TH89pavaP1lkO1Z1SYBe0Lj+apvfxpEkREggWBPq
	vwdLdHNDB0QSRETmzFsmt6jqqlyIKCN4oy8hhRcF/ummg5ZGAELti4lHUZyyO1S/PHp3kNTCCEF
	zLgfg15LL8tNZ/HA+ghRme+9H/wJiUysMCoejoOHQrQwkflM4di/afU7NHD+T1u62WC+0HV2mnB
	V1uf6i/u2Ka2wR7eNkKpdD7jHxsEdZkdY9kWZ/VcGFYUPI2jFztWco1btjVRZIXq1KbgkTH6rpg
	==
X-Google-Smtp-Source: AGHT+IH1VIKsG88C3aAeaqwYTWYVqCA6XHMJZDpaPDWK1Emc97Vc5AG1FPkm5MMZ+Hs0OjrfL5bbFw==
X-Received: by 2002:a05:6512:12d1:b0:58b:2b8:f8d0 with SMTP id 2adb3069b0e04-5906de90442mr1868002e87.55.1760016581986;
        Thu, 09 Oct 2025 06:29:41 -0700 (PDT)
Received: from wpc.lan (host-95-152-52-178.dsl.sura.ru. [95.152.52.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907adb28a9sm1042587e87.98.2025.10.09.06.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:29:41 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] pinctrl: mcp23s08: delete regmap reg_defaults to avoid cache sync issues
Date: Thu,  9 Oct 2025 16:26:47 +0300
Message-ID: <20251009132651.649099-2-bigunclemax@gmail.com>
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

Therefore, remove reg_defaults entirely to eliminate the root cause
of these problems.

Also remove the force reset all pins to input at probe as it is no longer
required.

Link: https://lore.kernel.org/all/20251006074934.27180-1-bigunclemax@gmail.com/
Suggested-by: Mike Looijmans <mike.looijmans@topic.nl>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 34 ------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index 78ff7930649d2..0b329661b5978 100644
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
@@ -82,25 +71,12 @@ const struct regmap_config mcp23x08_regmap = {
 	.reg_stride = 1,
 	.volatile_table = &mcp23x08_volatile_table,
 	.precious_table = &mcp23x08_precious_table,
-	.reg_defaults = mcp23x08_defaults,
-	.num_reg_defaults = ARRAY_SIZE(mcp23x08_defaults),
 	.cache_type = REGCACHE_FLAT,
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
@@ -129,8 +105,6 @@ const struct regmap_config mcp23x17_regmap = {
 	.max_register = MCP_OLAT << 1,
 	.volatile_table = &mcp23x17_volatile_table,
 	.precious_table = &mcp23x17_precious_table,
-	.reg_defaults = mcp23x17_defaults,
-	.num_reg_defaults = ARRAY_SIZE(mcp23x17_defaults),
 	.cache_type = REGCACHE_FLAT,
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 	.disable_locking = true, /* mcp->lock protects the regmap */
@@ -614,14 +588,6 @@ int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 
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


