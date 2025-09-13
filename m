Return-Path: <linux-kernel+bounces-815316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B210BB5628B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 20:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F13E1B248C9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 18:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCD3212D7C;
	Sat, 13 Sep 2025 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzT1G6/c"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD81D5146
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757788121; cv=none; b=e9Bc82a3okKWdBE4Q/Tl/1dLup4YS0CGbVR8zRKwrrlSENhzHf+Tn6eRgLN0uz2j6XApFx//2QCH6NRUJt0dRzccUrnc9jkBZLt2WaWXdbZgLQfRlbOfl3RoMiAwOelVGaZCnrm4dLZAXWjRCS+zRrnDMoYCoavvY0Y6C53hftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757788121; c=relaxed/simple;
	bh=gKcQeUu8cSavcrreJY9MpCvt84gelAsJxkM9T047X/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bj/NS2lYD+F1YmDBUOkoPIkRd1HU8gO530oQm0gmc6NDvSMwFFSQvfGN6V1yKGz31yRn4n1zd6EukqaXrwydbSREf6hszpj2CbJZ0BtrNhqMQBivhUZGgwpbbfv963kiPQaTfC6/38SyG80+TslrdRH/6aRMTvosHAlJJmPWdfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzT1G6/c; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-72ce9790acdso26547987b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757788119; x=1758392919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2nCFUKUNYumkIxFj5PydzJTHinQbopV5LDcYIB4n3Xw=;
        b=bzT1G6/c0AAIXet2nYBXQaLljAsfF8Zq6D65Vn5p3UcIMA7rRypprkWZFwnUMADc85
         UzcNU8eQ1XC+NVvF7U0w71cJcXixrY0ql2mX8CfgVO1aRWbFR3OXjya9H4fp6W3HFaNf
         /QBjyxmc+nQQ2Hk8AqPrI6U8e8ubXmcYweenKH5PYLVThL0r26d/u9R6Zl60OngRxnsP
         7XU2x5uKmhvBagMKK6fo/qpC+O4BEsyZLDZWENHv6NuFsOBSZShqGb8dYzddAkbt2nOd
         BQ8oO4OkwcX8PkomvPRB88mUnR/2R5iQoPgkXJW+mkCFUISpMRzeFO1i1tPbcgIJIpL4
         6QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757788119; x=1758392919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nCFUKUNYumkIxFj5PydzJTHinQbopV5LDcYIB4n3Xw=;
        b=uC18rEEw1PCfNEKIyQunbQmudkwRCQQp5aY+2mApilxwdd5L4crFN+Vu+yx49+TO/d
         zOOqKiAQFNSkwfgFWOW2lroOBkR7vYIJpRVak+jjD5ivLjCNVSDArHMOKcTXS90i7BLi
         wofaQ/RqBadZhLUEy0Ol4+SFX68F5FmzyYZEzyjXgqE/X8ndwzbV74ZsrzcCKu2A61tU
         6O0roE83H9xNwHzhSz1glHnwxmB7jkeUOONtgi9xXDYpYYTyhvXGiJced6I0A/WI/OsL
         BXipIsLzJTiq2njrRiRZND8jXByEH6Svqwy6OyU9sgnSX/CTgEXUUGWH1eXjKOW0jYFp
         2EGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4eF9xZRWws/glfSMFT4UhyrpoUotq6wJyVOapX+cOeaMRvaa/P5oXZOeCmxm6Y98Sg7/TeKa+PTEiwrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dubw2ezjx0793djnNFglc1uC/CAn749wjRO/X/WbNr4gfv6M
	OfccBFgpnX1aYl01k6aIge3iMULiiO/zgSAEumUsW5uMecqEpLNOiuT0
X-Gm-Gg: ASbGncuCagyoGtCvo5Wy6g23sSveZFUz8Rlqy6XPboKFIyAoo8VZzgwQ0gIPp01/uPT
	+jUimuhUTdh8x4sut2WL7upjaAhjTe4OyQ0h+XSrC7QEqNhgJp7PV9Sm+BFV0T+kLRd9rRxYTzV
	6nr4IKFbRTxstAL9ZPLQd6SmhKuk7tOdBBoD6tQSDP1LSgCULQ3/lSUXv1VcAEodA3HljM+Uwdk
	SvVr4ieoLjyvHSwAisu+jOZtCrGu3upR/JNb01ipL59P/9Kd/Q+4lxd8wWmnkYobeMNIGw6wsIh
	tDrDfGasqEcPniaYkGGrjphH+1NezOqjG+HIrEkp2OqL5jkciVZcYRv67hj+czWxaT8gOIArJFq
	c5cUedkwSOGXb0D6vXuJYY/FxdrFYolM2S2rOY9YoSaXHNgbfyY/0h4tE6qqbFplxqZZX
X-Google-Smtp-Source: AGHT+IEr6TyIbto1lC165e2SsnhAZ4im9LgfNIlYS/9s75aaY/CPhmgjgyslAAEUaftUYJeDHyRk9Q==
X-Received: by 2002:a05:690c:e0d:b0:71f:b944:100e with SMTP id 00721157ae682-73065cb1982mr69611127b3.53.1757788119092;
        Sat, 13 Sep 2025 11:28:39 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f79a8c8f7sm19966357b3.69.2025.09.13.11.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 11:28:38 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Andrei Botila <andrei.botila@oss.nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH] net: phy: nxp-c45-tja11xx: use bitmap_empty() where appropriate
Date: Sat, 13 Sep 2025 14:28:36 -0400
Message-ID: <20250913182837.206800-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver opencodes bitmap_empty() in a couple of funcitons. Switch to
the proper and more verbose API.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index 550ef08970f4..fc897ba79b03 100644
--- a/drivers/net/phy/nxp-c45-tja11xx-macsec.c
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -926,7 +926,6 @@ static int nxp_c45_mdo_dev_open(struct macsec_context *ctx)
 	struct phy_device *phydev = ctx->phydev;
 	struct nxp_c45_phy *priv = phydev->priv;
 	struct nxp_c45_secy *phy_secy;
-	int any_bit_set;
 
 	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
 	if (IS_ERR(phy_secy))
@@ -939,8 +938,7 @@ static int nxp_c45_mdo_dev_open(struct macsec_context *ctx)
 	if (phy_secy->rx_sc)
 		nxp_c45_rx_sc_en(phydev, phy_secy->rx_sc, true);
 
-	any_bit_set = find_first_bit(priv->macsec->secy_bitmap, TX_SC_MAX);
-	if (any_bit_set == TX_SC_MAX)
+	if (bitmap_empty(priv->macsec->secy_bitmap, TX_SC_MAX))
 		nxp_c45_macsec_en(phydev, true);
 
 	set_bit(phy_secy->secy_id, priv->macsec->secy_bitmap);
@@ -953,7 +951,6 @@ static int nxp_c45_mdo_dev_stop(struct macsec_context *ctx)
 	struct phy_device *phydev = ctx->phydev;
 	struct nxp_c45_phy *priv = phydev->priv;
 	struct nxp_c45_secy *phy_secy;
-	int any_bit_set;
 
 	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
 	if (IS_ERR(phy_secy))
@@ -967,8 +964,7 @@ static int nxp_c45_mdo_dev_stop(struct macsec_context *ctx)
 	nxp_c45_set_rx_sc0_impl(phydev, false);
 
 	clear_bit(phy_secy->secy_id, priv->macsec->secy_bitmap);
-	any_bit_set = find_first_bit(priv->macsec->secy_bitmap, TX_SC_MAX);
-	if (any_bit_set == TX_SC_MAX)
+	if (bitmap_empty(priv->macsec->secy_bitmap, TX_SC_MAX))
 		nxp_c45_macsec_en(phydev, false);
 
 	return 0;
-- 
2.43.0


