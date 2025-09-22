Return-Path: <linux-kernel+bounces-827271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F12B91553
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E185018A4A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D4C30DEA6;
	Mon, 22 Sep 2025 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO4nwvJH"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BB030DD1B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546783; cv=none; b=pKErkeV6n1A7vZXFlikEdv2kTLV2UZ+18fkS3+eYPvChehv2xxyKYzhLQ08ZPhKcC/1C06WZ0VKqvJtSmmrT32W1etDzcSnZX4YFcTIvhxMHX1egdlMVwCCWxmWHm30Z6XB6V33J4okcYxZfDi8cc8S5ggEKnOJNLW9UOCBkBlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546783; c=relaxed/simple;
	bh=unxmjxm6h4F/9t72n3Zmx6ePZef1LSzn6zgM64G59vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmUtZ53fYVRlamXBHwO96kW7Sf9YZfivUjkmUazKQxTFEZXm6OXQrT+/b9gp4bWrK9A7BcJLKdn/4duNRNox09MYOLZZxf3JgKvHsJaW6diT+aTqADOqg6col7rO1R7KNNEbQASBHZz8wrecCEHNfzzFQ/Y8lIYaWOxx1HN+t6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO4nwvJH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445826fd9dso51665505ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758546781; x=1759151581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BICoezk7Aqii5uI8fB/6RDKEXOngB1t0y1HJi8V6fU=;
        b=lO4nwvJHnSTArmDFKn2QFzlyq2ZF2B+3hE3Fqe+IUO41INfwT46rH9RQYjeLkbGdwL
         AJNKmy6sfpOQnWFezfusoiwyi7jST+PvEBIZIlKd4SnyXdO8vQTRYpewQmkymiJpU/ln
         OqhPXOOkVFQ4nkUoqyuKlidgVYG5ZyJaXS3ZX4b3elQHARTK+5ytuTuWZnOvdfdvEZwH
         YEpl72tScxM7eNuRZ0tcnTere7tZfpn58ZtJhLxZcwUO2SXX/v6IXHfnhPmmL21LKgQr
         lANdHipf1y449d5OVb6eD8bPxw/hR3fDO/qZ1X98DkrhpnkSyMtpe0uWbd4yV0jayNQi
         dZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546781; x=1759151581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BICoezk7Aqii5uI8fB/6RDKEXOngB1t0y1HJi8V6fU=;
        b=cfZypAJWh2xHNvGbD8Sr1h9OBegi7kD1SKxaZ9Uogjfew5PaiZ5MFD9WVAySdMfYic
         oVregoIHF1itLEf86JVVLXbYQ4M/RNp2uekkTx4BBJ0lf6tYw2j+7sjVaLCwt6dlbW7e
         +NH8Xwa+khkdehtdR6GsQfLaARmYm2PuhsvOlfPcnydl8Pijr12Z2vHwcf8waxngc6WR
         Co76JvaILNCbMnQcVSVGLUjII5BOtp9NL+tt8OssY0l18qfF0x1otCuLIXgDA2Jm1OA2
         cO6jMjPXiWxaaQ36WOqvE5u6zjs/Fu9iKxic+4SveQJGHlwgJVjxTMJUBg+DQXVXR6Xc
         yQ+w==
X-Forwarded-Encrypted: i=1; AJvYcCWrnvF5icsids5Y4FPE58sEV/tYQFUCcyZv0thzd//5ucuBGfhy/bQliQAHxajhddxEmoImhT+bce//Gp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVR4jYLnUNT/lbGbU+n826Zj2Xs/J3U9+Qyn9LKBI08lNfAHj
	FvEaolD4/AENs6IyEyFlmmXRyVITYhGbeSGjz31LpKP43G/FaQdTcR34
X-Gm-Gg: ASbGncuiUOG6HmZKxuqviL+7HoTRypddt1PPypwbfUwg6LxR5FgKjdmPKzp00QPqnL7
	jCHeg4x107lgebjTJDJSWvqN/183JnlCVOh6pCGT3DDY65YY+AbpNh6ex4c7GxTNutAUYkuXeq/
	tHdyHZQQGa8LbTC2JjnS4aZs6bjWOwPN9djV6D0tTsZ4WbMMGKwZQr71AIwkSRnU2176fBKJffd
	Q7FEHdLo5bCQLA9m4A1AEsn8A7H/M0zuUjaQO6avf/GSNzFNCuMbUYSjPX9JQEYzkT4sUjTUZ5O
	qi3rh3SNaD8a1Ajm184oFUa+PKSUjhp804d3275YvOnsNi11mEWBJG4FXSzeH9XzoLZ65hHKckr
	f7M6yyAFnMYBbPF7yOa6KhqQKCbF+9w==
X-Google-Smtp-Source: AGHT+IFCaMWxLEAqaH9OP6YhIlxxfOIJkeoBdqxz5qfmubo3eJBUEdY3PUmuBFtbQg3xg9PFsFXEEA==
X-Received: by 2002:a17:903:ac3:b0:274:9dae:6a6d with SMTP id d9443c01a7336-2749dae6c18mr64125005ad.34.1758546781613;
        Mon, 22 Sep 2025 06:13:01 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bff2sm130200055ad.35.2025.09.22.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:13:01 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v11 2/5] net: phy: introduce PHY_INTERFACE_MODE_REVSGMII
Date: Mon, 22 Sep 2025 21:11:40 +0800
Message-ID: <20250922131148.1917856-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922131148.1917856-1-mmyangfl@gmail.com>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "reverse SGMII" protocol name is a personal invention, derived from
"reverse MII" and "reverse RMII", this means: "behave like an SGMII
PHY".

Signed-off-by: David Yang <mmyangfl@gmail.com>
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
index 1b06805f1bd7..e8e237fb9d35 100644
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
index 7da9e19471c9..42d5c1f4d8ad 100644
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
 
@@ -281,6 +283,8 @@ static inline const char *phy_modes(phy_interface_t interface)
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


