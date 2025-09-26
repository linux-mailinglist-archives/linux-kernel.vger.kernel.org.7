Return-Path: <linux-kernel+bounces-834135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D977BA3F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 900F94E1CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B772FB0A9;
	Fri, 26 Sep 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luOtdh2U"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04F42FAC0A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894750; cv=none; b=U5AcvE8rGl+/yRtebiv4Z5mH4qwjlZiKjbB73MHsHRGx1oMjaweq4IeM0NxfkO21lMwxdLnTcasZ6gUqWBTEvis9xk9GssVq+VrKp0gvPkTGH51uCpTwlAhA0ALjwKWzaJWketZ6n5aeMpHHeGhCrj3FPaxoG3yLv72aFs3XGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894750; c=relaxed/simple;
	bh=pYZQpUJPMGf8MVnNwvrUQMZ2K9Ux1Wp8HvLTstdvSho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0GpxyjZnED/0lD4ckL+iubz1tUMqOXYQOStplxWBd6h99iCMyJG1lVg29al6805yvdVskQH1yhsLaWBBQ0KbhMcUxQYymd8u2axRelqGi31Q+H9e0xrRMyDpOu16MWtnZs0fU6r4EpGBEJcY7uFckB8Cko/fl91u+CI8+vP2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luOtdh2U; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso1706527a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758894748; x=1759499548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEKSAxHIaZ2dAPPdObIjDi5Y1C1RNP0QTmbclRtQCys=;
        b=luOtdh2U03kK44bkrpGc3rBlO/s7ncM26Hq1iSPB4rNxJfL4KZLE/8Q61P6AtE/Twe
         dOA6MwQpOgEmBGoRvv3a2PjneowegY+K1hYNMUUZNl30fqNjTZ5yibIePWOtnYF1iW/l
         /Z7Qrs3E5XfBoI/HTLkir4du6giz3frKx8Rfew3/CCp1e7mOrMg8m0bxFWcbv9Eif/iR
         yUj67KYwKEGyPpyLhHlt/RP4KuFcDqHr2B7sqU4LocpUpoPUtUk5HIM9zZTnYOhv/m5/
         0DNDFB9nXdKHL+ZaYUw+vvL3e4vHSLLmXECUYKlvXSO8ObLM3NhuD6tdE7HzOtH2TEAr
         ABuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894748; x=1759499548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEKSAxHIaZ2dAPPdObIjDi5Y1C1RNP0QTmbclRtQCys=;
        b=mPjsCe6qsJEd0emItnwF2hibetm0bm/UBtf1Wxv0gnt7fYp5IaDItuJ2RpOLcMnYLO
         TtCrqx5h18v1p/EoWBW4yvOFJljXnBKP4rpo28Lf9DBQn0H3IPjg2KI6IrVBEQFPcNZC
         svnMGhHm13qHm6rVszjVdDSbYnTBT5wzfvuAOW8/ci3w4Ygip15sbXGLVq5R6rCSg1DZ
         3LRah9aTXA+f1H3VvRhhhZ3vOEZIUqI8ui6Ki0hNKp9kHYm+HwQH/Gip44kMqDUZwo6D
         idzNU8x1mqXQcP+kG+uHMs9SIF1RHMrOsAGX2mU1bO89pcQ6SVtzPb2aA7Z+rg98Un8z
         ndGA==
X-Forwarded-Encrypted: i=1; AJvYcCXEt1eto+d6rZaodyLsZmKAS+GAQtCB1++mSGSTCHAB1uUVKvGFlDJ6ziwNAwuK78sTDnWJX2Zsj9D+5V4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97K6WBF4TBegPdurQNYeKes4tOKVI99hXf8xANcGacGy/OZHW
	oS9LZMu3h4hSKGRCTvhFFERuWSy/lSn7YLEDjkliWm++v9/pm9PLwTX0
X-Gm-Gg: ASbGncvvYGwt54JdlcW5QBUaYSjoyxRVN0wXuFMcWgkzScadykjq2vBK4zkN9SbTgB8
	YhbVNqDTsudacEzc5iBFAOGZBZCKofo0g7OJiuLlfsGrnrDzkSZhwYEussPGK0Hcfi2xXCBjNiG
	ci5/Y+dFjqRiZfTI/jWahetoJi8xecanQANHorhKKbfpyYLsE4iHQH2VeBgHXhyT3GRILDw8jo4
	HIEMEMsOpeSwsFQAOILIHVeZR291OesuU49wP6J7gzx3/LZvL53Fc+gIQsGHc/Kqzr9j+hzYIHP
	CyXcOhJUFnUfjeJXlX9JYVWB3b83x6CNxwrBgdTy73JlJgTe/9iwK4hxwL4ioUbbykLA3MMlq/7
	aEQd6fcDZRO1UZ58I2nY4Euz6tVihYYsfhDzf6XhZ
X-Google-Smtp-Source: AGHT+IFZMIg/Ar1Z0pV1M1I58ur02r7foZdrErtZ79axk8ozapAxAqe6voMH8FRHNzkb6K/iiIMLuw==
X-Received: by 2002:a17:90b:4b10:b0:32b:ab04:291e with SMTP id 98e67ed59e1d1-3342a2af4b5mr7555021a91.25.1758894747749;
        Fri, 26 Sep 2025 06:52:27 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be2338csm8997217a91.22.2025.09.26.06.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:52:27 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v12 2/5] net: phy: introduce PHY_INTERFACE_MODE_REVSGMII
Date: Fri, 26 Sep 2025 21:50:49 +0800
Message-ID: <20250926135057.2323738-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926135057.2323738-1-mmyangfl@gmail.com>
References: <20250926135057.2323738-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "reverse SGMII" protocol name is an invention derived from
"reverse MII" and "reverse RMII", this means: "behave like an SGMII
PHY".

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-core.c | 1 +
 drivers/net/phy/phy_caps.c | 1 +
 drivers/net/phy/phylink.c  | 1 +
 include/linux/phy.h        | 4 ++++
 4 files changed, 7 insertions(+)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 605ca20ae192..074645840cd5 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -132,6 +132,7 @@ int phy_interface_num_ports(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_TRGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_REVSGMII:
 	case PHY_INTERFACE_MODE_SMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
 	case PHY_INTERFACE_MODE_2500BASEX:
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 2cc9ee97e867..9a9a8afc056f 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -299,6 +299,7 @@ unsigned long phy_caps_from_interface(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_PSGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_REVSGMII:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_GMII:
 		link_caps |= BIT(LINK_CAPA_1000HD) | BIT(LINK_CAPA_1000FD);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 9d7799ea1c17..910e93d2a324 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -255,6 +255,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_PSGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_REVSGMII:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_GMII:
 		return SPEED_1000;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index d09fc42e61f3..7390014fccb5 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -107,6 +107,7 @@ extern const int phy_basic_ports_array[3];
  * @PHY_INTERFACE_MODE_LAUI: 50 Gigabit Attachment Unit Interface
  * @PHY_INTERFACE_MODE_100GBASEP: 100GBase-P - with Clause 134 FEC
  * @PHY_INTERFACE_MODE_MIILITE: MII-Lite - MII without RXER TXER CRS COL
+ * @PHY_INTERFACE_MODE_REVSGMII: Serial gigabit media-independent interface in PHY role
  * @PHY_INTERFACE_MODE_MAX: Book keeping
  *
  * Describes the interface between the MAC and PHY.
@@ -152,6 +153,7 @@ typedef enum {
 	PHY_INTERFACE_MODE_LAUI,
 	PHY_INTERFACE_MODE_100GBASEP,
 	PHY_INTERFACE_MODE_MIILITE,
+	PHY_INTERFACE_MODE_REVSGMII,
 	PHY_INTERFACE_MODE_MAX,
 } phy_interface_t;
 
@@ -286,6 +288,8 @@ static inline const char *phy_modes(phy_interface_t interface)
 		return "100gbase-p";
 	case PHY_INTERFACE_MODE_MIILITE:
 		return "mii-lite";
+	case PHY_INTERFACE_MODE_REVSGMII:
+		return "rev-sgmii";
 	default:
 		return "unknown";
 	}
-- 
2.51.0


