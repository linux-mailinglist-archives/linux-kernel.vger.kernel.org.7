Return-Path: <linux-kernel+bounces-891002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F25C418FF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FCE42338F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E495330DD00;
	Fri,  7 Nov 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THw0g3s9"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B230C60B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546377; cv=none; b=Y9YhfynZb/ELTRIYWxfhDxs65T3GvDUatKxo2YasclrJiHAru7uy5XetEeUtqlf0JfFVBQp209Js4SECh46qH+WRHDMS0fkipEcXUFF+67mLkzn+VSuBJejPQIL/bIY/eIq9+8wIjbi/GSC94NJVGCeGks5Ao6Z+OUW6y9bNy6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546377; c=relaxed/simple;
	bh=v8yHUl2VCCuFa3tLr/Bqru4Xwe8KeevfdbbJgX94SXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAQGMcImwXKf30LbNgKFifxNtkcF0qJuKDs6nscOduPS48N9gC4Xu+RWIJpHi4P3MmKzWSp+19KSVVSJDPJmEITVf4sDUt+yacohIot2k2icvQtyf6ETneM1KrJ78leyTARx5S7f3EAyFlbFEa3ZXkX/6NXx+RXnXT336QdxWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THw0g3s9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so972189b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762546375; x=1763151175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2jIm/CZCkZaBbDnD9nBZsgOURxlF1+5kGMORETVnug=;
        b=THw0g3s9UQva+8taWcK6ba8UJMs1DBvHYodryLlafUTTYVlRjvXFotDRAYOFQqqrMN
         o07BobtetTsBgomyv0rTGFj10qRzehQhgjx4WuidbnpnuHpVs5DgLILTAJN1yaUME6Qz
         3odAEfZt0QaZlfDMsBffUw1VaxFWUhSfI8gQYXIct8w90k77lVKfpyjL3ARFZoVI8hVO
         5P+FgtDt5eVg6fxGZPpAJA/OX3UKPLA1X9ATCPixKjLa3TfiLue2yopk23DwUdBlLMlW
         5sZN+X6NfD6p9Xdb21GdPcnDNZJhRH5XxrFkVLvpEQjfbmevtWdxcv4TI3uzfLXojGnk
         IfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546375; x=1763151175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+2jIm/CZCkZaBbDnD9nBZsgOURxlF1+5kGMORETVnug=;
        b=uDWU55krZhIQXM7nboDqq+2nb/JYkqmMUqfz+j5KjnCfPJGhy5osg8d4bTPqc88+be
         jYaRz3c6OQ29ZFVhVGtQZiU2IbsY1Wnec6RTousEVvPvN0KhVVnYb6g5qkgVvnhZMSn5
         Ie6Q2eTRybnVHDmF4Jyi1OFcxQr6jsh3lw78W1O7riq4IiErhFzT3RIykof8HdgJqocj
         O6l7jK49FyJnS3VI3dFPSf8TErZka5/mIT4A/5ADHK9rCJRw/IBsggsB1mOKcyrAy7Gv
         cRvxPW/D7Xx3vfFYpWywv/44ZGGhqlvNBZeSj5JVuVdxi4xL+y9tKFE+qeRfZ6eOeE+5
         Ksow==
X-Forwarded-Encrypted: i=1; AJvYcCWhj30lO/gZa8M8pgQCYKUfpiPSrEhlKg37CAgEE7+21yqutRosewMr8e3YtNT1S4VbOwXlkbJfG8jhAH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnknyWpUbBLx67rVvlRQz2/JxcZLP6f95JJ1pTx6se1fQ57BH5
	4Jy2gFfFaj1QAkkYjpoqgtpiK1GcO/Kqy2JU0oB7666lqBUr1J4DM4ZY
X-Gm-Gg: ASbGncvjZMrKjPC+kdkvuto74nrAvUaqw+pfJ3FGQaigU1upx+I25AAzv0XJUDEbMMO
	s6UIVma06X5NuBL6CVoMQwos3w56cn3FeYiS41a+3g6LdXhVVq3CfyPxSt9n3ETI6xkYfJk1BjI
	9RNJ+KviMmr5MHD+WnZysPOJfJWStLdAvDbafBkDWaeCMQXEXcnJfmTKFIad18s2MgGbRQ4nhuR
	dVzeqediS+uMyeSOfi7iD8qLucXUsTL0k2zPkE1zNb+Tloc7dU+xc1THuudYgpjYZJNJ2hIZVRP
	9nu9pw/ndakqXGRWQFJo/91Vxvmss/kcZvD25slJH7b68fbrjsyj1y4m/J86/mBpI7Etq4aEZgP
	KSZKFRsFNcpgcdCw9nuzgDzM3ndIM9Fz02q+h9rHwhX5ZlZtIPLnxbVNgGRv2ukjs6bnB1vZwA4
	KR9MQcbUfX5d4xH1OuFZEHaA==
X-Google-Smtp-Source: AGHT+IH8khfZJBhTJpXLTO5Gb4RSM+k9uIEQChjCn5mDLXBQUnyR83c66GjH4StNfJo9F5kUwk9slw==
X-Received: by 2002:a05:6a00:1892:b0:7ac:6c3e:e918 with SMTP id d2e1a72fcca58-7b225b50453mr562311b3a.11.1762546374902;
        Fri, 07 Nov 2025 12:12:54 -0800 (PST)
Received: from iku.. ([2401:4900:1c07:5fe8:9724:b1da:3d06:ab48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17784bsm3828553b3a.47.2025.11.07.12.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:12:54 -0800 (PST)
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v2 1/3] net: phy: mscc: Simplify LED mode update using phy_modify()
Date: Fri,  7 Nov 2025 20:12:30 +0000
Message-ID: <20251107201232.282152-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107201232.282152-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251107201232.282152-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
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
-
-	mutex_lock(&phydev->lock);
-	reg_val = phy_read(phydev, MSCC_PHY_LED_MODE_SEL);
-	reg_val &= ~LED_MODE_SEL_MASK(led_num);
-	reg_val |= LED_MODE_SEL(led_num, (u16)mode);
-	rc = phy_write(phydev, MSCC_PHY_LED_MODE_SEL, reg_val);
-	mutex_unlock(&phydev->lock);
+	u16 mask = LED_MODE_SEL_MASK(led_num);
+	u16 val = LED_MODE_SEL(led_num, mode);
 
-	return rc;
+	return phy_modify(phydev, MSCC_PHY_LED_MODE_SEL, mask, val);
 }
 
 static int vsc85xx_mdix_get(struct phy_device *phydev, u8 *mdix)
-- 
2.43.0


