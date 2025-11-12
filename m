Return-Path: <linux-kernel+bounces-897343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D147C52A86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBACD4F2D33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03AC33F8C3;
	Wed, 12 Nov 2025 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKuYFh16"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9A26A088
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955881; cv=none; b=aEvlyrS9tq/iR2sT9QlQ5wUUTDtD6ExIoOjQBwS0MECETCQrelXEgw5g/y1y3+zP7CzaTPlyN9EHPFTzHxwSySOTrQCvAw1W0MVZCebvdDiaXQcLPlXLxpFdph35UiInAFLa12ToMlAo4E9DMhDZwUSQGinx0oZzYREArp3BRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955881; c=relaxed/simple;
	bh=TVib8KoMScZCb+KPT85+QmKKvlCH8lixAtnRmNJ3Neg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8L8LwZQbaLwilY0MN2LqlDK7dUunUHxDn8J/iZn80o7HQib8OOu1NLd75kQ/ObtEIwmGquFzCXLD5pJgcZ/M1lZFFxVwrs0fI7XBXyM1aX72Lyw9ubSD7EYJxDxrHaeaCuo3X1nACdPHMrN+nC7lDGqak92AVeYchaLpGigiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKuYFh16; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so1074677b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762955880; x=1763560680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1/MI7fuOzyKPjB007+f1We8KvicofZrvdYQ3ilyzeo=;
        b=lKuYFh16/6rkyavH4eqTg6FQaEhDKqJQ9T7YdWTLOsH2HVZAG4cmn6wTPORrzSaa76
         YZv6hKrXeQrk64ik8lj1cD1PduE4FtX/J2EjCEOTboCTi0XqeA3/yJ80z98r58pNfCup
         8bLYppRSnhhG4vLiT+SlznkSaqncHb7c/r9j8GQUwBCn3AFtai4U1CmbLVw8C+7HcqMf
         E0TGmlGCAlvSpnJrk5+YtYmEaYjhLblAGsTkRdjtnuBPS0Nq05cpKSYJ2YMee+hEvovE
         kqqdDLSbQttumlkIt4DWZLGexew1tmzChcqLiNfKf/7sIbkOINlRQBsjU8R2VTt+Ky0t
         Rf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955880; x=1763560680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j1/MI7fuOzyKPjB007+f1We8KvicofZrvdYQ3ilyzeo=;
        b=JT2QN/Hkx8OUAz5qmLMGiKnzSntxQVNcHZSdcHFy96aQltr8AlhohZIaK3+DOm8EPO
         UW+RK8gOjisVA0oNNVUrCpWF+yJjYzsO9rHLR2tQxAgTrU1CBPKlHNzXxUXCNy7kQleI
         KipT5nZRH74iGpVR9/LTyV+PW7pmmFTTnBwGIWM2T2xOWC5O/6DQetY3Ij1mElcXOULO
         XiPgqcC2k0WEQT+TfI7qJoXWCz3kvfRCPdjU5TiXhGaAirZfy9NGRhYpOUjJ25Tev7lz
         7xPEltHaPqB4TZzRsDZxOEu8fkjpXpE/EzqHF3owKGldj4CRbKlf1UDyQlKweE7jhufK
         OAJA==
X-Forwarded-Encrypted: i=1; AJvYcCWbBwZJe10jfWb0CJnQrwYumsX7y89qfS4NPTti0x78YmxY5tcRx1RuLGhyr2zwM6A6REhRqUswEK4+nho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMl1xU9VMUZj0SPsVaLzb8QmiAV+5w2/rVzFyferU67BZWqm1T
	CfFphy/M3Bx7C3JINaTGue9C58198NpQdE04Ts3Yb/gzEOcjdOkFbQYZ
X-Gm-Gg: ASbGncsSCV2drBp/lXlfahMKkmJvMNJslNBQ7HsTkqxhma9wlmQ2iBL4Bft/07sjO6H
	kWOFJi0ySymIxsRdJ5igv0r3e3UvQFGATfLhV5tbBztl9fcmNOJ6KwpnSlXiOjnxEexQqJJy8fg
	p4lomoh4RXY/cHjsVpvcqROTIdZkZc4MLhFunxH3flTpWA64ZgIbhCtCeKy9+f46P4wnE1iWnh2
	6lE/rRK4JUQoU6u8cZe/B8+jhGy/JrR84iwJUMBBfcN29uLJO58mRwg78e+Z6SQTmFL8z9QzJPn
	7khl0UQaCTShQu3JUzStCi0ax8fOqLQTZT2XlAPyuHvC+mayLSYipjt98YckWaWSlxHtzmTThF8
	/y5I74DATMyPbK0TUp7iYxpIeo69i3yZnb7v+0Z9ug+QUWqDIJid+IiHULhfJ+MZVSJDtSTvVl2
	nvaqOj1NMqMl76RWsVWDIz
X-Google-Smtp-Source: AGHT+IHyp9NWySH+cDzcnVvq8I6ZIzBl9JYoz2ufTq/3+N/RimV2Z+kLAg6PlRzSKztugHPQfUdG5g==
X-Received: by 2002:a05:6a00:88f:b0:7aa:d1d4:bb68 with SMTP id d2e1a72fcca58-7b7a46ff44bmr3401593b3a.20.1762955879820;
        Wed, 12 Nov 2025 05:57:59 -0800 (PST)
Received: from iku.. ([2401:4900:1c07:5748:1c6:5ce6:4f04:5b55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0f9aabfc0sm18361299b3a.13.2025.11.12.05.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:57:59 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Parthiban.Veerasooran@microchip.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v4 4/4] net: phy: mscc: Handle devm_phy_package_join() failure in vsc85xx_probe_common()
Date: Wed, 12 Nov 2025 13:57:15 +0000
Message-ID: <20251112135715.1017117-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112135715.1017117-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251112135715.1017117-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

devm_phy_package_join() may fail and return a negative error code.
Update vsc85xx_probe_common() to properly handle this failure by
checking the return value and propagating the error to the caller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- New patch
---
 drivers/net/phy/mscc/mscc_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 21fcaf07bc6d..2b9fb8a675a6 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2264,8 +2264,11 @@ static int vsc85xx_probe_common(struct phy_device *phydev,
 	/* Set up package if needed */
 	if (cfg->use_package) {
 		vsc8584_get_base_addr(phydev);
-		devm_phy_package_join(&phydev->mdio.dev, phydev,
-				      vsc8531->base_addr, cfg->shared_size);
+		ret = devm_phy_package_join(&phydev->mdio.dev, phydev,
+					    vsc8531->base_addr,
+					    cfg->shared_size);
+		if (ret)
+			return ret;
 	}
 
 	/* Configure LED settings */
-- 
2.43.0


