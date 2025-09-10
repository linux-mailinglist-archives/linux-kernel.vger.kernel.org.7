Return-Path: <linux-kernel+bounces-810327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B63B518C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B92224E36B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED823218CD;
	Wed, 10 Sep 2025 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GWuVcwdf"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C266326D4D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513014; cv=none; b=FgkmCs9p0UKypm8mpvmYvmQZL/7iaC2f2rjZo5qnyj0KjLT1av2NKzTYcom7GkvbHjjoB3BYb07i/fL/jTckvmifj8XM/f4i0mrppww7a+uANek9ztW8eOZQvUU+N0HFMQhzmPOSl9LSCIMO/cB2xLW7thW7I+in9CRwRHdJvrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513014; c=relaxed/simple;
	bh=ZAVAGITvUw55XhUkxrz8oUWZkXF27JoqfN9DE8oUYOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1byUlXqM5zvcWg0cZ6ofPFlomuHhhtQxb2dx2GczBr9Vglep6hrPrTHBQlWnTh6dQfsG/u/i12ybOhvw/AKgxtg+toAuDsQxBzKrYuzaprmSMwAuog/XOaoTMV5Xm6jD56ZfLSu3U4xBSRTOcRZcl9JKfXkhjSp+41z9frmg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GWuVcwdf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dfb6cadf3so2879415e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757513011; x=1758117811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAGLW0vGkRdepqvJWWr00In33Dyb9aFFqzfsMejvGVw=;
        b=GWuVcwdf2tn93Ctt+wzjh2pKjKzjJrQ6cI9e3kS9NuUyKC8IdVYaBLa1IRu1cuEuBm
         0I7NCa2AQx224OjUq/vvXhDzmm2aEjCs4uhUyCjvPbJ2yGHQvVLtpX5NI18rjHEBWI8S
         z1dC+ojbAYmV5vhfdJP6dejBLU7GzQ0bImWreSd6RUdZZwEQfJjzkIxx5P79JJQL05ar
         do9TYQekoRB654G8AmgLECgozbh0oWpsMn2OnRW09Jzfw4yfPsatoJJE/wK1rW53K10W
         /K6uhWBZ4L2VVz2ckkXNxaZy1JuaoRf4VaY10bkfJ2J7evE/IWs6p9J1vI8OZTLeQDEk
         wH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513011; x=1758117811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAGLW0vGkRdepqvJWWr00In33Dyb9aFFqzfsMejvGVw=;
        b=K35C1gvtP2Y9cWwuSagbSm+t0jxbC7W7JBA7EytzWBkf7ZM6HQ4lib9kTgXnkXpX+1
         xsuWQeNJI/EStuw3ehit8XY6GmudfzWj6773XrqjxzvlxI3iGdMD8gQxoQE0YNU7Tq1G
         mLfMWTmwIPw8VPE/q6l6rdXzsD0AiEECTMYXjMDFwRxjm1zs7TpXc/xoD4Gni6M8HD0i
         twYhqR0eZqiS5uRLYB3RwwgLTWdfyw1/thvtMOBAykD71wuI2thuyZ5fTrkepmO0CuXo
         jqBGaPwvOI412L06p1p/jCUyO7ayJx1LWiyHN3/AiJT4mpaCHTbvmiO7WyiblwzuGWR2
         bfLA==
X-Forwarded-Encrypted: i=1; AJvYcCUUts1SwoHyhuMVB5OvWY0jIY4tkCDNWAY0onojzNgWbmO7tEowiOhkyhVllUC6h6n0HYfZQOOIhjSuOeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKG/zjsRPN7XDxRgtN1Y0+odrKle8UoCwR9F3xKKUcfqV9shn
	HuwDQ46MsgjNjP1W/PJeYkMFFkJKAFXo40Nwua3mCCQb0HHn+75mlZshx4s6kYgMS6g=
X-Gm-Gg: ASbGncu0KRCEZ83ddv6j61GYsIp+RQgfQa0jQOQnTZ44qmB5s+uO0EBuzv0/C+Dg+la
	viKr5qIiR5Xe2NacT8dmKRJDICGRidQMjW70Mwjmx+o2PJ9nuidKBL18a6ZfWk31jgD2CKFt5wn
	GG83jOaQqw/HpZEKVxqbyczpzr0yexWEB9DgZ8qlzfkTgZyXfKfP7HLwLP4j8v6d0WBgSPU2OXF
	ejokqD6ooibUk2MLxJhHHf+wnY06xbWDKof01LzzJm/SHYxSSGp+pLS7mx1Bvof/N01WwHcZyIq
	1PLnPElKDyn+ZsLiMs47r9Q61jOJQdu9uaksQqEIF3Bd6PWDfFQGMx8DYJl7bT0VDyEzr1Zb1Fd
	2BGuAdz7uC1ImRtanopyP9eop3T9nn069jUcTAQFtytgMWRc4HOaWN7U6SExB/UQmIhaY8ULmCg
	==
X-Google-Smtp-Source: AGHT+IEowrawYHNa29PlMo3qPWXJ3OP72+rWfZLK8gTMTF1VH5JFTzYqdz15w3e8YqJzXojdc6C1CA==
X-Received: by 2002:a05:600c:1d16:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-45dddec9927mr191640485e9.16.1757513010776;
        Wed, 10 Sep 2025 07:03:30 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df804bce3sm29523875e9.0.2025.09.10.07.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:03:30 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v6 5/7] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S SoC
Date: Wed, 10 Sep 2025 17:03:03 +0300
Message-ID: <20250910140305.541961-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910140305.541961-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250910140305.541961-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC USB PHY HW block receives as input the USB PWRRDY
signal from the system controller. Add support for the Renesas RZ/G3S SoC.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- collected tags

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none; this patch is new

 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index c58bf19993c1..a7fbf5c50940 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -108,6 +108,10 @@ static int rzg2l_usbphy_ctrl_status(struct reset_controller_dev *rcdev,
 
 static const struct of_device_id rzg2l_usbphy_ctrl_match_table[] = {
 	{ .compatible = "renesas,rzg2l-usbphy-ctrl" },
+	{
+		.compatible = "renesas,r9a08g045-usbphy-ctrl",
+		.data = (void *)RZG2L_USBPHY_CTRL_PWRRDY
+	},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_usbphy_ctrl_match_table);
-- 
2.43.0


