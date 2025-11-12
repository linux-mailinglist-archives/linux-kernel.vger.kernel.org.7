Return-Path: <linux-kernel+bounces-897339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED8C52AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51BD3A2BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E266339B41;
	Wed, 12 Nov 2025 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH5g/mvo"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ACD3396F4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955861; cv=none; b=fhGshvF6NJpCacqCVRF7vZ8IlMgWQDhDGa/omjO330zZZ1YcNEwdfaAZ7siIZDKA4Eo7r9GYqtXa8b92AN+f0oCFGwa8LtX6zVpjnk4TOorE4F2jMf1bz1EMVB7nsvGc6V/3OBFoUReKfoZHPGgDTsce59NyrHyAoDwYcPnK9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955861; c=relaxed/simple;
	bh=x1YSbtYbRyTPSIhv0/6W+8ceVWJJTyabUu/t8xJbjYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KejPZ4qj/zUQWcxbWBeFdAVSQp2kbu12zREpjgn4QPhXpbd2R0XAolvSXUq580Xn0nGvXkWJLzvHZrRQRlyEHtBjx9QSrexsXpF2vZqC+xOr7HTBNVtRFgf3un2DK2m3yf658mNKb62DbXLHracp0QXaZee0OuJGDYt6FlYi0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH5g/mvo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so634334b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762955860; x=1763560660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSrL1EoqDUfnyHQYh0k/jlWwCZWampIQnukH68EzSFQ=;
        b=mH5g/mvo8k/a/WwAJJt9PSQAQFLYAC0cqhaA7TwV5ElIHX0pTFAN1/MG2YyiIQdPrM
         ay44YH6e2Wb9fzij2PfoWALQ0QeaG4v9QWJVTOPb+yTKbKnxFQmXRxjjfigIwIXBaa6L
         Oxtpw8Q6mDm8O/GGFFFpykzAzutcWkw2chJbckiChhLl+JvKr9o4IqRDovJviMq8zlEk
         RZx6HAoMrKM7dL8wNQE9bG2NcCQfKVZYHz/btbIXhd3vJZnvEi35/kLM8VKnNl01DQeL
         YRRmI0MhbVjjJMjF3zSu1lYePRqfBBQRl6ZbIlAOtc1Wcl1aj+9MM9F9cSXdMgtkYsd5
         GT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955860; x=1763560660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iSrL1EoqDUfnyHQYh0k/jlWwCZWampIQnukH68EzSFQ=;
        b=USpeZKHEfOuvQV2VrR4rtqeM+8kSNSnSeDYxGCOTYt3OFq9zEEdPAzIFrlcBuyqFxg
         LGVF4jsecDcXI0TxL6WGTcKMzq9TRC+s7yAGaf0hJKNQgXxM0orIC6sxfzKuJP4a06qI
         KYYYoW7sclSS9GGU6VjuX7WyIO/Qq13Ix15Wl+WJ+ZDipyauh3IKQ6wvBexRtb0C9ZTi
         eNiojh0W3EnEOAz6Nui9O7TscLr1+5Hx7RhBkWucFk69JOWuLRbW4oO5QKqyTJX9/FyC
         HBxrls6OMRUX3Otvkkpb0MPKcETGqAH/uBbMiWPHV+HmtQnmuaaKUvG6Kkvjh/7kqJ1Q
         JACg==
X-Forwarded-Encrypted: i=1; AJvYcCVWbLzEACvjAeGYIkOOlu/btwMcuWUiO3VrHTAhCGFvhHA8Z1A9HLhfYyzdPTLFFOdr81/0TBrnRi2oAjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBRtrL24Mtu6jw9bybYEJVGYJfsO+cQm0v18wtoNFvK3vnNxWc
	OMpTNY8129IxVvZysqpTrKRcSFivI2pIGGxsZhn2Pssa6vXAIA92kVJ8
X-Gm-Gg: ASbGnctDcfeDJvyE8sdGWOd3Bz3dSPGybkkV4EO65XtJfQzcomJG3Tv6g/+gW/Zn7eJ
	ItKVGp2DhrW4j7Wr52Fa39WO0ndj0ttaE93tXQlUYFYs1BjaYBsYr6anZZet2rjT2kX8ixx7eaG
	stFid7PR6UWIyq8lkPHNUF+O46bJeUHTrqODd2yaN4BDCi7FdCX7TkSnqurS0pc1F1K9zczFobG
	vqPwu01TqAv2SRkbJx4pzGDAe1BNqnYmVxBQqGH8/zA4ArEBp1U4+Ns+5BV25AHYL3lxstTZEeK
	URooWAaBNC3AsJlyVBHoCJXpgcQaEO9H/zUJOFUE0xWxCAW50idPt9UpoVbY6flO0ePDlGPOn+0
	3ua7XzdvuvRlAcB+pCl9jT1Qa0ur0WWRoC8n3Nvtqfa8Mlj5iijicv1UmCIPpH4mndkDmvlt6ZC
	aH1yHIAtjBZxU1fceJ1K4d
X-Google-Smtp-Source: AGHT+IH8wA3xt+CQCkNui2Syc/fmlLx07b5o60cQDt4Q0PQIytlU1FHXoiYwxMvPJRREYg1Iq4EEZg==
X-Received: by 2002:a05:6a00:855:b0:7ab:78be:3212 with SMTP id d2e1a72fcca58-7b7a4af65bdmr3263452b3a.19.1762955859786;
        Wed, 12 Nov 2025 05:57:39 -0800 (PST)
Received: from iku.. ([2401:4900:1c07:5748:1c6:5ce6:4f04:5b55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0f9aabfc0sm18361299b3a.13.2025.11.12.05.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:57:39 -0800 (PST)
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
Subject: [PATCH net-next v4 1/4] net: phy: mscc: Simplify LED mode update using phy_modify()
Date: Wed, 12 Nov 2025 13:57:12 +0000
Message-ID: <20251112135715.1017117-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The vsc85xx_led_cntl_set() function currently performs a manual
read-modify-write sequence protected by the PHY lock to update the
LED mode register (MSCC_PHY_LED_MODE_SEL).

Replace this sequence with a call to phy_modify(), which already
handles read-modify-write operations with proper locking inside
the PHY core.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v3->v4:
- No change

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


