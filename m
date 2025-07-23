Return-Path: <linux-kernel+bounces-743353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9121B0FDA1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C9B1CC625C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854E2E36FB;
	Wed, 23 Jul 2025 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQSKvJs2"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BC1272E71;
	Wed, 23 Jul 2025 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313425; cv=none; b=lXXxVfSSCMpXx3AtcxPy1sigvHKY+/RA3SxNoB+hfx+huMVbtaVz4vp8TlVs4jWaLz7EtQAAPY79MQ1PL8Hyhe/pVn6hY9bLvaLl7D4i+qMoTwG9Fk//Pj98NRiRuHf5UD/mhikMuQGGSGd662fvgNYcRg3UsKp20Vc2gRjYOj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313425; c=relaxed/simple;
	bh=KnDe4KUgcOvQsFsoxRoE5e1FG2zNcjhDtg7jB/7S+iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJVQllhtN6lfIzqf8cZKdase/DeDcq9fljubLXrf027pUPQt3aiuvWtAFKgCx7OHM+DYyFDM0sn0wzRqTMZXTLWs5MNqGmiKqpVy1oGrVsfBfZa4pM1NGD6XjQLKU7GIP3s2T5w57JtF9x1esky5XBz9QCkPV1u7+ocYgDZtL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQSKvJs2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23dea2e01e4so4928975ad.1;
        Wed, 23 Jul 2025 16:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313422; x=1753918222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJcZT5sTnEC+iZOaFw42qNp6Oam8rPA+kK5DmNYfLB4=;
        b=jQSKvJs2zVLiFTuK8ivo7REQbOOYfhZVW6FrWbEIP0oQqZc0t0TrOydsMTIjRk1e4j
         aEIrxBGeBiwI59+BSsEDdgtgNwj8BDf2qkQNnlFwpteUAfsjVerF4RQ8dkGoGt0aKgqT
         hBur+Y1lhygSPqzKfIXLgJrqBRfGpKxS1Hq617akA49J8XgHBKwXp6adXTAiCVFFAxaV
         TEmvAVd1sg9ukbKi8bjmMKETaNe0fZsn35YweUtf/O/FEAo1KUbYFmKH8wTatCLCx7os
         Q/TV61wLWUfT32c58lsp3zF2Xa6gJIuuH1BH1IEJEVZRZ9q21Gp5UrEk9mPu7fa0TRc+
         C0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313422; x=1753918222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJcZT5sTnEC+iZOaFw42qNp6Oam8rPA+kK5DmNYfLB4=;
        b=wVPh85kizNZAFX4q3BJpAWHuNJYOx27kTP4ho7EEyivtBElrYkJAdGV8ctd4SAy/ny
         FBtSS9oc7cowCYgZemsElx3p1abRw7Eb4c63FbpdrfZxYw2bUhnWZsEKQt0g3Yof9HjK
         7kzyBor9rOEF2l7vZjXoQpKHejuLErD5he+jxAyLjLloXmLIFYRpOkCtR5E1HoYNdoAs
         9YUtKmtin5MbeOVOQjgtjpWPYhCOQMe4uwZMl93fYcC6TY7o8p/Wjas4H8HpYiV/A43n
         XNKXxrQ4cxqHDfsOZhoFyOGMevwJV7exh7iVqamHbLHq870v1vAF+Y5/hIyQGUAJq9bc
         3rYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7zEj2GNmVMDFOw4iMbgaDkPCS4CYPV3YbcNrKqbbyap4jdfpasiIfOp1mlQO/wz8Y7aQlDHNagU8i@vger.kernel.org, AJvYcCXOELKEAy16uuAUhm8zvp+56BJUTNQRhav+gxUDZb+tGM3wZyoTlZV4dVRyVxMYCtcKq2raZZGZrzeGHSeB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4X3CB5xAizFw34TyXtZXaXV7tZri7oKsxt/2JWUs/t3LLjWZg
	3fgHY33l6ktoR2Uz/oYl1fwB69bXMF/yNxG6oblZkEtx3ARlYgUNPd86
X-Gm-Gg: ASbGncsArdq6oXTtxqjTBkWbTQy4iTVzKpNt1/MAwKjCMCqNvlX5FN7LVwKR2G1FUXM
	WrlgpYd9sM1fQjT6UOQpNTbpHTwE/Oq6ZZMcPhz/5rXj1k0s6DaPmKsCRubKpv+pWY2gcS1lWcr
	9zAB3OdSMxlThvoitudVzsHIzpITQoTdw2DlzhwLEBC8d52SSMVxdqN/ZPYN+hNfCwzjhwqdATw
	AvzGdrwdcJXZcKeMtITmNe8iILyq2S/6AAnUM4XZx2BgSiP4VyKifPdx3Qm9dNkYsX4iHL5MUvB
	0VpG5NZyGYe2z/doKfEKXVhyy2/AW6vq+Ow6BBW3tHC/QajcPztalQdogRw7doa1l5Ax50zi5aU
	+i0Pu53zrzdub+OiRMS/TlMNJKx+BVwLO6gKvS8h46GDK4ap0+KXRhZw+6Ry3M6yG412rihpwgr
	E=
X-Google-Smtp-Source: AGHT+IGSyr5vjHqYvqddRwSQUnOAlvyDwmDPLuFwE/6U7+8I2PtDzuTJhVb5R5FfzxoEVDx4YT0l1Q==
X-Received: by 2002:a17:902:f151:b0:237:7802:da30 with SMTP id d9443c01a7336-23f981a83e8mr46507505ad.31.1753313421521;
        Wed, 23 Jul 2025 16:30:21 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:21 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v3 01/13] ARM: dts: aspeed: wedge400: Fix DTB warnings
Date: Wed, 23 Jul 2025 16:29:57 -0700
Message-ID: <20250723233013.142337-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Fix the deprecated spi-gpio properties in wedge400 dts.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2).

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
index 5a8169bbda87..3e4d30f0884d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
@@ -75,9 +75,9 @@ spi_gpio: spi {
 		#size-cells = <0>;
 
 		cs-gpios = <&gpio ASPEED_GPIO(R, 2) GPIO_ACTIVE_LOW>;
-		gpio-sck = <&gpio ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
-		gpio-mosi = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
-		gpio-miso = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
+		sck-gpios = <&gpio ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
 		num-chipselects = <1>;
 
 		tpm@0 {
-- 
2.47.3


