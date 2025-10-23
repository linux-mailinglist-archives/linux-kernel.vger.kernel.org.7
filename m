Return-Path: <linux-kernel+bounces-867220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3BC01ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C7B3A3D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95A330B2F;
	Thu, 23 Oct 2025 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJOUNYYW"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D081932ED40
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231033; cv=none; b=MQeaDyu9JzHK2OO6aoNtVQoWHYGKrdkvWVp7I8ylzQtqPFsIY4yMaquKN1NYs92LsmakD71UOI7wF+wKFeQDSInE8LBfr8tzMaCiLh3UpGOUKXpMAFpsfF/iCzY/7Ma3LfGADVuncfOxMJRm1/66fnmMD3SZJjyCsTuBKlL6hy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231033; c=relaxed/simple;
	bh=waBTP7RtsmhC1WI2NmWFK1HTs2arG4JeVs+IEMQ0HQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EH6UAp5SU6e0PKjMScgi41hmf8GZtQ8XpY3i3DWiVGzGxkTAfe7IX5y46N1zSf81UC10nAyogxpfnyNPtFDX0lwhuVh3IfdPD7qU944whG7RweO7OfEdrJKPwTLPMh5N69fPTqN4NxHNVGj47Nq6Om1Bhl0Cb26h8WGnbqlWvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJOUNYYW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so7773605e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231030; x=1761835830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FassfAN01QkxVDyy+Sa+b0ImlRDr/lRNphkFcyroU20=;
        b=MJOUNYYWLMw7HcqSw6agbDQdkiAGR+T8i/4u+wu5uRk8mrBejYpLzAvM1XkfyIZNG2
         o3LuQ86oHQgHRBDwFlxX3KVyFPy7gHKSw9+Q/RuvaNlI5OqiIcuOnad+dnUB7KQDx5rP
         N408xobqk5EbAgZHR1xK1shlotJOt1Mxe2+oWx3dEVziSIySyxpMUfboWWRAIIoroOdr
         IB4zXM2VMSWhXyLmAKgXDZfKmZvymHYXQvODPIVHbNzsBEcjL5j8q1LnLKaTrtgCg24B
         Qqbk5xsYBvXFOYaOPXkeEpsL0rMS+0oqsvqztAPiIYIj8pJttI4M1UVM0YFiThTScpIW
         VP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231030; x=1761835830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FassfAN01QkxVDyy+Sa+b0ImlRDr/lRNphkFcyroU20=;
        b=Lu2mn3GTXX88ssLHLJde2N6nBiShvybBBKWl6tK1Xw3AEGI3Dj/A17WyHCkvZdiuNq
         1YvLz+5Uf17h0ckMY0rxtanH/yls704E/lWEMQpQPynNao2H+oJH8OEXnMchgC4VQFxF
         9NVBjRD6KuA3ulFQ97Sgtp/701e+EqBTuyRyxvkZvSgPdneh5EQ5ImHf+KShiRHbQhCe
         WJTWlvKa0nRZc/uwwzfGBC/HSqDAe2xn368AHojPlOftYpNAvbYko7qTwh/6Gdejvd/W
         Ej0lGUfuo++ToHrnJ+TtzEO3vS295ppUX+zNb/XOEKdziSodxRlH9fUhdwlMMpLMKKwG
         Er1g==
X-Forwarded-Encrypted: i=1; AJvYcCXypnAcdhtH8Yt2rewxa7+T8hF9Gz7HhpGfJmAvj9wLlcFntSka/sh6F9u5ynZRW16ttwxxlkE1qyj0ib4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygGj1simdYpb1DwramKCVb1w055aQ8n6zBcXuV/ovexDqu4iVo
	+uSqD9V/H6bNPL3CduMcbz7UjCrHNqvZ8NBikmdr1E43tbUSKBtAh9N0
X-Gm-Gg: ASbGncsl9L4TzRCUe5Ft33Cj0Btgjg31NGoyp3ngY/c4XphvD7UYIGRKTcrr1+fi6vS
	08VK+j+Y63DSMW1FkG9DhEmrJuFNJ71Y3URi0zxxoyBhKQFTD0gbrjq62yQ02gM64nWEWjDiCxB
	vA7JwhBrPcB3Z+ZQGvWc63KE1/8dKhG9++p90lu4p4ZhVqUrVL8IRCZgD0MSAGEmn/pAMajDrzD
	E8dvCHKhc23YIBjOrdnBOK19OSQwBrBsy8NnLk7uch8P1/lr44iRLenwM5oySH7BXZb8B8GmHTt
	4te3dhOayFdNjq1wX12dlyHhM5hZt0ONw8+Z5xbMQu9isGHID3NhyDGoWEt3nE/fWZ8n5HxGOkN
	sqANWZKLXh9I7+Z91pYwylAsa9sZS5prAMfdOxvXtSmnCAvDNyLwcaqBPBdnxM4kNBDt3RwqLHQ
	MAW4tAfEQ0hfGnugpIr+jMKlISuabCJZ/ZxPSJShpXr+A=
X-Google-Smtp-Source: AGHT+IEs+GoltQcKBTrzCzP/DJpfopqS9pIvzCpIjkp1sHlc6JzXCwJNHAdY8xhjwduT8SXTQCUp/w==
X-Received: by 2002:a05:600c:3b03:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-47117874978mr181531815e9.3.1761231030000;
        Thu, 23 Oct 2025 07:50:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:f374:5673:9521:bde3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428f709sm102312175e9.8.2025.10.23.07.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:50:29 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Russell King <linux@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] net: phy: dp83867: Disable EEE support as not implemented
Date: Thu, 23 Oct 2025 16:48:53 +0200
Message-ID: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

While the DP83867 PHYs report EEE capability through their feature
registers, the actual hardware does not support EEE (see Links).
When the connected MAC enables EEE, it causes link instability and
communication failures.

The issue is reproducible with a iMX8MP and relevant stmmac ethernet port.
Since the introduction of phylink-managed EEE support in the stmmac driver,
EEE is now enabled by default, leading to issues on systems using the
DP83867 PHY.

Call phy_disable_eee during phy initialization to prevent EEE from being
enabled on DP83867 PHYs.

Link: https://e2e.ti.com/support/interface-group/interface/f/interface-forum/1445244/dp83867ir-dp83867-disable-eee-lpi
Link: https://e2e.ti.com/support/interface-group/interface/f/interface-forum/658638/dp83867ir-eee-energy-efficient-ethernet
Fixes: 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy")
Cc: stable@vger.kernel.org
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/net/phy/dp83867.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index deeefb962566..36a0c1b7f59c 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -738,6 +738,12 @@ static int dp83867_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* Although the DP83867 reports EEE capability through the
+	 * MDIO_PCS_EEE_ABLE and MDIO_AN_EEE_ADV registers, the feature
+	 * is not actually implemented in hardware.
+	 */
+	phy_disable_eee(phydev);
+
 	if (phy_interface_is_rgmii(phydev) ||
 	    phydev->interface == PHY_INTERFACE_MODE_SGMII) {
 		val = phy_read(phydev, MII_DP83867_PHYCTRL);
-- 
2.43.0


