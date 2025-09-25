Return-Path: <linux-kernel+bounces-833162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE1DBA1512
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C61F4A4190
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3528320A08;
	Thu, 25 Sep 2025 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REiD9H2t"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434BA32038B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830793; cv=none; b=RWJhmhhvyuK7yopI8E90udICtgc2r9t3tTiAgFjNNTiwnpQCheBq3YfwjLxun2J1gkHbCgIztDvmuWn3zk6bLBcuWE7lhxPFu81F64Hgct2oK8HBky9VInOQeUbku3zFk3gEprEZCRXyhh6XfB7ggLg6mHtLbQaElIqqaTjQzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830793; c=relaxed/simple;
	bh=A6nkXF/nFFhaNGj7X4Fs3clVICJVm9N4Oe56KlyFY/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WsCME41IVqbGzhoLX15i+ohca1pwft2oSY9lLVilhnOYvHQxG60QfbjhEyKrNwy6tld/H8xsRdBxrF05icONHpuOUvzy2Vriw/iETZ1Fty9nfNT9ylxIH8nAu9zBKfUsLJelklb+8rsLql3rS+fkmMPjeZFXbIAyBc7/0iZolsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REiD9H2t; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f3a47b639aso854678f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758830789; x=1759435589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0bkqtjlf9n6TLED2N6uTdBB8WnIl90DnUC/z2JWcNCs=;
        b=REiD9H2tuTZTp3X5HJp/7ye3GrZ6ufjVYWeiz1AYVt4K2Nb1Wo2R81w1HlRi3I3tj7
         WLSg3wdD9+xru+TRkGYSEUHEOZT6ynTkovb8vTFTCIqTk1kdWBuB4vHXaThq7QsE3FSK
         UcZo+W/5KrjqCwZUO+E8nk5LfGOMFPXEKBGmEZDBk+ANpDyGJAF0hsqeQkPA1MnOfSD/
         7GohfGZY0KbZOLorfzGKYv7DzK/UjykzOmJVSaUSIs93HuNhFmz7ghg9OZeW2UaniGGQ
         ODHW/0cBjl2IxMTFJ9y2zeehFbjASQg6+H3H4ZjiDL5aLJvMUQ3uu6qud+tKRBG/tlI4
         Ypzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758830789; x=1759435589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bkqtjlf9n6TLED2N6uTdBB8WnIl90DnUC/z2JWcNCs=;
        b=lD+dX0AQVSlidKoQyGZzl/UcZ0MbfWgkdrtzTtByUDLgtgGlFirbRrYM1NUkzQTRLI
         +oJuj37yAjX788svIiueQggBwly9W5UrAfSKQstMKHbkfOUi3nhnxyU4JawJbl9NTSl9
         vvRmbbLlr450274bnffGDJVRxf4gLsGXoceyZ1ei/RbhiEYh2jPetLx+KhiGv4lHU2Fi
         90+Ts6bON2WvwtRfWPfVeE8uNrwywhsQgb0pPZunAh342tYURd12A+wSytWXYECVPWi8
         cWdvCaUnhz+slelTCNFa/KDRA5fh9932oH5a9jgJTJ9CTan8uJCbxZvb4qJlmPclw/Xx
         2SWA==
X-Forwarded-Encrypted: i=1; AJvYcCW0HnjuyO8/SjWErCCQWwk+epS78V8aW0XtsLdHd5hTzQWZnyXBP4PbOIVP9vg0x5g8PAvkWzMpq5DcEV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8Hr6Hk6YT3o4UG5QulNTMZ76BmUrDKM2hUITW5i0nezUTJ0x
	vgE/FjfVwH6a5t3nraXjEzL6IQmhlkfHY9OPglBJl9liQ0S5IZhjlcMm
X-Gm-Gg: ASbGncviDhczTLaEkPt4xEswTmyDM65WABMv3F9pBF63dPnaaLL6tGSun+7BPtHRJIA
	WPVjW5D1zo0utaheROtMlCxZZZigP9pfv/1/vQrTVmeyYxfuAhhxfH8pg7cb8zWin+MeTJnQpEO
	Y/hLA1bknMQOTzAtmhyCcdA7SHAhv914+58kn4BJmODS3Zz+xmxxQKsFSjvSN9mFZSMj9WzV2Jq
	MS3gZ73a0G0IuPeBFgYNDqiAqOdJ9quOkHWBTyirUEs3Y8jCo4wvddnth7OKRpuIWifcVbqwAzm
	puS0iH51WozHDHF4moxswWjl+XpFkx+vnh35jXNyOfTmoX6ZHH0thtobOuuitqTC4u3/bKSO6XZ
	i0OAJc3Im9VNMzaO+eHXbajVXQbjIQEld+A==
X-Google-Smtp-Source: AGHT+IGm5p2OFZYRHMpG1LWIjpAJsc2Ei0YFDZH7Y5FaApdjCSa5UwduVKsthgoMsYChaswBxq5scA==
X-Received: by 2002:a05:6000:24c4:b0:3e7:45c7:828e with SMTP id ffacd0b85a97d-40e481be755mr5162838f8f.33.1758830789339;
        Thu, 25 Sep 2025 13:06:29 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e34074983sm43901835e9.10.2025.09.25.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:06:28 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	avifishman70@gmail.com,
	tali.perry1@gmail.com,
	joel@jms.id.au,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 0/3] arm64: dts: nuvoton: add NPCM845 SoC and EVB support
Date: Thu, 25 Sep 2025 23:06:22 +0300
Message-Id: <20250925200625.573902-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fix warnings and adds device tree support for peripherals on 
the Nuvoton NPCM845 SoC and its Evaluation Board (EVB).
The first patch fix warning and arrange node order.
The second patch introduces peripheral nodes for Ethernet, MMC, SPI, USB,
RNG, ADC, PWM-FAN, I2C, and OP-TEE firmware in the NPCM845 SoC device tree.
The third patch enables these peripherals for the NPCM845-EVB, adding
MDIO nodes, reserved memory, aliases, and board-specific configurations
like PHY modes and SPI flash partitions.

The NPCM8XX device tree tested on NPCM845 evaluation board.

Addressed comments from:
	- Andrew Jeffery: https://patchwork.ozlabs.org/project/openbmc/patch/20250908125938.3584927-2-tmaimon77@gmail.com/
					  https://patchwork.ozlabs.org/project/openbmc/patch/20250908125938.3584927-3-tmaimon77@gmail.com/

Changes since version 2:
	- Fix dts warning
	- Arrange node order by ascending unit address.

Changes since version 1:
	- Fix commit message
	- Fix dtbs_check warnings.

Tomer Maimon (3):
  arm64: dts: nuvoton: fix warning and nodes order
  arm64: dts: nuvoton: npcm845: Add peripheral nodes
  arm64: dts: nuvoton: npcm845-evb: Add peripheral nodes

 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 732 +++++++++++++++++-
 .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  | 440 +++++++++++
 .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |   7 +
 3 files changed, 1160 insertions(+), 19 deletions(-)

-- 
2.34.1


