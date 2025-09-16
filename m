Return-Path: <linux-kernel+bounces-819258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3076B59D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945273B0517
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D264C3728BE;
	Tue, 16 Sep 2025 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg/NP985"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6629B78E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039822; cv=none; b=CVggsz2tEjm6KjHKg4ZIBQIwU3E6+vajf8XBW3YY/NwUhyKrtddgnPGpWr4HtkTL5d92G1zZra948XiG+rCOUqgCNAI6xVkLm3U1HcY9bcNGdit3Pm/fiGBTJ8d2BfZvwLpUpyR3G6AZnEa6nTdCgexaK+W/Qmu9xefbdWiyAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039822; c=relaxed/simple;
	bh=LrD6BrLgpUvSdcLR7Skt26zZgEQ2s0Ux2XOn4YPB7Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5f+kvZfClGmLL1EixZS8P2PjzMWwAwCfqWZzCjKs/GMdweIkbVHIlVg929+R9ipWCgtOCWsD/RWam7YBVV1LFn8cirFGxYB64J+GMqXDZJ3V/nSUj9RcXAi+cV4mU7E8h54n525C3WNuNx7QGILC/ThJlKBBaih2i1qQ3+y3ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg/NP985; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so328445e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758039819; x=1758644619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K/7fckWG4F5rhCUIhkg35WDPQwJJKTQY1bkq1rzEfW4=;
        b=Rg/NP985qniJZy3QUCuAo6thS9AAPa08TGk6Vbr024serU+stSllIgdaQcy/BK55fF
         knf56vz1cWIOssfKS2VZEc1R6c1durXcX1dcUz/b0+wLlXZRt6Cb+AIM67bUzWL5k+ok
         TCaKX4JtfYOoz69vc5UqOR4Yo+sSRPIWK2C8yXuv3t02yTud/EfYu0sRudaNaXgT9Gvc
         mOs7ot7NrTnR9/hPq3t/nyT4sWjGmcw2ua7ILhqLoyPK1WSHLIY1by95n7fsrn36kKNv
         486/YNUTXVPM3SQgDi0nQWbwPduSOX1ejvSDbrFXms9jRfifr156AdKsDzXZLij2JOuO
         +RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039819; x=1758644619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/7fckWG4F5rhCUIhkg35WDPQwJJKTQY1bkq1rzEfW4=;
        b=OXZq+hL35gYxOQqij2unxUXbRof4mc4g4teNmbL5Y402KTMv8qyVzC694Lma8ByBbx
         N22kRUc4fVrCun0WgizkuHGUhViNA1NMrHvFpLyXIY1R0QYV6nAIxsI6tSYmFgzViEza
         wYylEbSHKMHfpVNOu8zyknk6kR5suss5kqZAzGiJeKGY/L9P9cdM95+lqeek8RuKah31
         0H7F1krzhePI2u2KN5H+ao5cvOyTSOBpkJuvqeV8alnCQVzHKVPvYMKTvKArVxVV4TnY
         YCWXl5ydPiTEH31dju35VasMxF8bSv6CBL4wssnQy9L7HQJ+W5r1Kus3snrqs9R/xmLT
         Dj2g==
X-Forwarded-Encrypted: i=1; AJvYcCU1xYZuXj6H8PoBVg9LcHrJTdyB3l+jkNtZEd0tReCB2jZXt1Ayw0kKBEoL2emqPPo8wF4YAIwHjwFUQWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwufoHhvAixEDDAs2O8UYGNnRGvTEh8bhS7RKa6UpcFycbTz3iU
	Zn2KjThn7qPvu7BQg4d0ZldgD/EX1vnN9G5Rv7+xap8/jQieecm5LkCp
X-Gm-Gg: ASbGnctE7W5r5L3R/Fav0qB7g8RA/rCOkD/MLDeB66xi00yG9U1X9VnwmMPco8DCWi8
	m8lkUcMYraCHFN0EC8N4BPDxWxW62im381YfdGMOp6VQ0oLf7fvbFvxcn+TO+/ZdX/sFhAfJ6zE
	dfS5fBROzWPvzLmRll3WUmsV64DbE8CxBI1W8sWiheCcbP0+a2wpovWv/nJ4JVJjFQtqUbN/KdT
	sJRFlcy58RpdJcPrGQbmqjDrpnaNBisgzxMAJlo/f5nrG64EVOl2iNIE1dPxwvvJUsG3GvsV74n
	kU6MKXTdVFwVR8TzmNqkHMaHUz34Wbsox/i1c1+rnmxv/Ngr081nCtUb4+PUe2ktGZ80BiF9ObE
	amKaNsGUhkMUcO72vsltR8cHu5pPDEMDki7t42FM8MqUByQM=
X-Google-Smtp-Source: AGHT+IHHuSYAzUDnzV8A0W3K4WH+E5KPEEi2k/OrYuXUvaclai/18lUV90Qfo4UZxkj86ARB8Jf7Jg==
X-Received: by 2002:a05:600c:3505:b0:45f:2d7b:7953 with SMTP id 5b1f17b1804b1-45f32d512b8mr29544545e9.18.1758039818697;
        Tue, 16 Sep 2025 09:23:38 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:ddad:97b9:9e9b:bb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32083729sm21385035e9.0.2025.09.16.09.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 09:23:38 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH net-next] net: pcs: Kconfig: Fix unmet dependency warning
Date: Tue, 16 Sep 2025 17:23:35 +0100
Message-ID: <20250916162335.3339558-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fix the Kconfig dependencies for PCS_RZN1_MIIC to avoid the unmet direct
dependency warning when enabling DWMAC_RENESAS_GBETH. The PCS driver is
used on multiple Renesas SoCs including RZ/N1, RZ/N2H and RZ/T2H, but the
existing condition only allowed ARCH_RZN1, ARCH_R9A09G077, or
ARCH_R9A09G087. This conflicted with the GBETH/GMAC driver which selects
PCS_RZN1_MIIC under ARCH_RENESAS.

Update the dependency to ARCH_RENESAS || COMPILE_TEST so that the PCS
driver is available on all Renesas platforms.

Fixes: 08f89e42121d ("net: pcs: rzn1-miic: Add RZ/T2H MIIC support")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/aMlgg_QpJOEDGcEA@monster/
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/pcs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index 76dbc11d9575..ecbc3530e780 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -28,7 +28,7 @@ config PCS_MTK_LYNXI
 config PCS_RZN1_MIIC
 	tristate "Renesas RZ/N1, RZ/N2H, RZ/T2H MII converter"
 	depends on OF
-	depends on ARCH_RZN1 || ARCH_R9A09G077 || ARCH_R9A09G087 || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	help
 	  This module provides a driver for the MII converter available on
 	  Renesas RZ/N1, RZ/N2H, and RZ/T2H SoCs. This PCS converts MII to
-- 
2.51.0


