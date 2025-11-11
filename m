Return-Path: <linux-kernel+bounces-894967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED51FC4C949
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 485044F5C87
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABF527AC4C;
	Tue, 11 Nov 2025 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCJj3DaH"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7954261B62
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852273; cv=none; b=YvCXXLvp/ck4vn5YMF+GvbbfF7CuS74kr4nzInTyNy3lMNEbkpNRukYHZPV6YHTf8C1pQM73+DxQASTyvpqugpyX4caNv4UvZdyD+q2OZwdDjtSt/T18OCUcN/aVkMAg+hkPupwkHSsuLETtIxsS8GD7wn6EAVSIXa2ExvbJcx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852273; c=relaxed/simple;
	bh=lqV5WRM2NSFAJWw74e2ONru1rtp/SZ+WcUnGqRa/bLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dh6XXrJAf0kkeJrUtwCWTiSbpn6EWk3uNoej/b0zO2WwDNHGZokIVyacQNsYJxqC0ieR1sy0r9WD64x3jAMDCT2Z0dL3wBSCE60t76Bzxo9lutszZgMEQ6pxG7VcmKmT3nFns6U7PkP5SmIwp/a4vu2bdCB5V+tMVqoZeiCERlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCJj3DaH; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b679450ecb6so3218956a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762852270; x=1763457070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdoqcLpLAaqwgFbl0QBXFrgUcQK68Y6GkxJRdLyp9fM=;
        b=kCJj3DaHT80ENJiaozJoMP0mxBtxgNFmxAKXxX+CDMOi2JXXcdsk0Odxi9y3bvX5uP
         gEuLehrSe0Kh6Z530CA6MvfzvB9UQpmZI5IRCiq4ggfhutLdTL/E+XTELXl7T/c+c/2q
         Sr5SNqGIIY4KrDVAb9jnHa7x6TJ1vcvrrIuoOxd6CSm2Sgu0jU4XvmS9U44oCWB7tc/Y
         FBEOYmkWfR6o6MhNsC1qXy5Z687mzpis35OiYn8qpEeLxcXpB8BbkGWpJ4dpgpmh83pe
         KsRvw5vCX98hMjLe2xthpiD8LCDTP9vP5InNvDizw1ve1YRm5d2Feigs19iLmmy0F/Gz
         PwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762852270; x=1763457070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DdoqcLpLAaqwgFbl0QBXFrgUcQK68Y6GkxJRdLyp9fM=;
        b=lMo9ZU3rob6PCfBfQ0mRVC0OHyxB1hBotqBZeUMbv42WboBRIpufnFztC/gZFgCVGx
         a7+cg0eH9fE9lRCXTjfmu/Iobg0tU4MP6YA5cwrg3QnBTk5FoLJVMeiAwIgKwNvmu3hb
         lDfvVGHs35N7QwrqkVUAEakiVDf3CfRUCmm9CVUy8uaB65nX26F+0P7nVMIDCbIZAuL0
         SpVpaN/8wAHd4cr1Nx4DNWRNgLTer7tuEqAESJpX9R67rASaVfDfv+ebjgJyE0czypZe
         jboLwc+j3SG34ccq0ThMRHMWxJ0M0yldXwxcecR5DkUyMtRTsnNlzH4zuW+UjvYtD/tK
         kAYA==
X-Forwarded-Encrypted: i=1; AJvYcCWBZWJ8L2Pp9kbYagIGhtyNuF8Rpg7X/OjmKu7MG9tqEtRSuYLXR3C1eZ1FdWE4aeeeifVGyWj6iEnSa+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaNyvX5UrAnV7PZYPwykIEBHMlenXg+F19a9eNZsmGMnMNmB//
	+06DgKWfUv370uvK9YC9CLE6umjrDHzweM8caZ+hmN0fsuKGT1OgCtff
X-Gm-Gg: ASbGncsVO4W824hS716J1jJg5foBO1Hz15g/UqQb6ieK5nbC/6pi1hMj9W+yxS2ro3N
	qvlnSzAvBDctb/I6BrL0Cxigf3yBSyqXoRMLEQT+c/SEIjcN1O/TnQgL8gu9wpGcS1SWDYKJhU2
	Fw3R/fs0g/nwYBVlCoD9eBdUyGsEb3D4p0Q7KOh+rq3Vkm3uST2IAOdPhVkanES6KgSMqXneOAf
	EotWqhhbRjG993glzyhj65+kl+zGNQh5YRGTVtBDkIaBYQFpzqQBtDR5tt+9MtkLajYK81gsVvo
	uvi5SNl++sIRjXLN4szxLTSw22uS/RdBqnatKv2DRbxgzwp2zEo6uWk/zgD4ANjiOXVymloqvTY
	FZEIqIlz1GSfIETre24Cumks9dbxmzxVg43uzNPo8LOhadrgFyBFd6xWLTGGdZvEfXb9mQ/j+Zo
	h4Df8M6TF9o5HOCWVgoK9yQA==
X-Google-Smtp-Source: AGHT+IEplxamzvFzNgi3OD1pMrtWSJCi9ogRE5FJIgYLTfsbriTNnGpDHIDuvjqeLpXuDDLdxABm5w==
X-Received: by 2002:a17:902:f684:b0:290:dc5d:c0d0 with SMTP id d9443c01a7336-297e56d0e12mr165153635ad.49.1762852269852;
        Tue, 11 Nov 2025 01:11:09 -0800 (PST)
Received: from iku.. ([2401:4900:1c06:79c0:4ab7:69ea:ca5e:a64f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5cf37sm172715415ad.35.2025.11.11.01.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:11:09 -0800 (PST)
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v3 1/3] net: phy: mscc: Simplify LED mode update using phy_modify()
Date: Tue, 11 Nov 2025 09:10:45 +0000
Message-ID: <20251111091047.831005-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The vsc85xx_led_cntl_set() function currently performs a manual
read-modify-write sequence protected by the PHY lock to update the
LED mode register (MSCC_PHY_LED_MODE_SEL).

Replace this sequence with a call to phy_modify(), which already
handles read-modify-write operations with proper locking inside
the PHY core.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2->v3:
- Added Reviewed-by tag.

v1->v2:
- New patch
---
 drivers/net/phy/mscc/mscc_main.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 8678ebf89cca..032050ec0bc9 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -177,17 +177,10 @@ static int vsc85xx_led_cntl_set(struct phy_device *phydev,
 				u8 led_num,
 				u8 mode)
 {
-	int rc;
-	u16 reg_val;
+	u16 mask = LED_MODE_SEL_MASK(led_num);
+	u16 val = LED_MODE_SEL(led_num, mode);
 
-	mutex_lock(&phydev->lock);
-	reg_val = phy_read(phydev, MSCC_PHY_LED_MODE_SEL);
-	reg_val &= ~LED_MODE_SEL_MASK(led_num);
-	reg_val |= LED_MODE_SEL(led_num, (u16)mode);
-	rc = phy_write(phydev, MSCC_PHY_LED_MODE_SEL, reg_val);
-	mutex_unlock(&phydev->lock);
-
-	return rc;
+	return phy_modify(phydev, MSCC_PHY_LED_MODE_SEL, mask, val);
 }
 
 static int vsc85xx_mdix_get(struct phy_device *phydev, u8 *mdix)
-- 
2.43.0


