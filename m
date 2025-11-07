Return-Path: <linux-kernel+bounces-889975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F832C3EF87
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D253B0A95
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E62631076A;
	Fri,  7 Nov 2025 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3FxmfbX"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A123101CE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504228; cv=none; b=XonhEO8sqADVbjFN6mRCPixkuyZEeOrgpdwbjLvc1WGMBmECYkVipHjsowObR8ValBb94E+pQ/0GtK6wnxh4y2bX7Ywzom0EMunxMAaPP2OMbx4VzJgm5o3ubARI34KTr43n82GYxI+2UqAtjM/Q1qd7gJ2AF/2lSyGf4j0LFFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504228; c=relaxed/simple;
	bh=MdkB/Xow1STZ/vd1dO5sr1mBnWw0IYtYq0tMvW62450=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZRh/CxeURv/qxQP1P4mk7B4byVD2XM/2yV37hiSCkgWVKVDdhcG5diV5w+gLEcr8nN2qLPxW51YY67ey9oePVssDMslq8DD4NHMtLDO+cQWYnGSHYfBqQBucap23HhMd8LejWxg9X8SOBtSi6pyLGHFY9s3Gseys4mTxVoU7xqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3FxmfbX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so879436a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762504225; x=1763109025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fNaNY6SHcDWfyejibfeRml/RW9cl2cli6RWaoB7xA0=;
        b=g3FxmfbX3ungyuv9Y6mlA1WF5pcOTAk5eYiolbOKlUGkjSzxZiFCn+ovNRLWsi7MZa
         vyQ3ZDfz48+KjZsDwytS/x4rFKV24xLhZJ0h2ZavgTFEBD0DJEiuq/3CkvTqGBgFDCX1
         NB5if8suUl4OEZQ/3/ZQQcOGqskuE/KEGvzGdtOkCO33iBFqV7A4EbXf+g4aG3hGj4c9
         2G/d0Cj0FxKc5mnZYXeNcaADt4p6xCRXxmQnY9H/x+pAdmKfSk+a+b7TTt7XE+Y6Mv6f
         /6n+9JF/Fc4CqMJ0ZdhE+GZFvb5MgSacdJICblvqHm7scAqSzpPjjSZSCR+AS9+L6Ebq
         QQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504225; x=1763109025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fNaNY6SHcDWfyejibfeRml/RW9cl2cli6RWaoB7xA0=;
        b=VGV3kP7DHVeGkAiAn4DU4mdd2t9G+5DDpVN9/sfx8N4rsy1sviK7LMxd1gsi5697rB
         Jj+AZXzVK+Q5kgMZmEoXKap8w6MrCRLIPa9wyqj+5fXaB1xI76fu/TbA+IvLx0kJ2rwx
         BUI1aZiFYyJvp3Q5AMlJA2f3gDrr2rHfGPdFKiBn36GjSCdyeXrgQLdd2WpgWDFH79h+
         IEYeBNh3xEv51QIRp0/EKgBZ2LJIot4yUNlsW/TkNtgXYgISPYikYx7WE1/Inc7IJ8gh
         XwshqKU+/rKil5+ytq+IVg/MvqVZ59JEn1hCoOJaBBW3/xwNPCLHrcTNnHk+BZR9KpFE
         w38A==
X-Forwarded-Encrypted: i=1; AJvYcCXJGOCKb2agt+LHuAZ4dDLvENHEKLwmoBrPQfxFzc1NXITV03aY6k4R6VUkvPavXXgSPhrRxsu7DOPmkUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxjQCNn7hSbM2ndbR9PbX9ns1171mSVEfqKSnrrXJwlZxjpMjm
	Y9UxQsAOue0QF+/cNwCob20NFTm5ps8diQykzrzcV1xlJLlyegJJHYeS
X-Gm-Gg: ASbGnctnl2Bn7bwAtfSd/xMNhqRqrkrfTNCdvJDaBagbIPqPvsfhBV0ZyN0aSBkSw7s
	4AQV07Sd3vTTRGCff6X/kuFDQoP+4aL8xf/svDf7uDrwRL8XdbhsLQoWSoBFB+uJypI3HrQ1IGI
	Y8bs4/wRXPt3oGxcxpj3IpNyvUXlMi818LawDmzrYMHFuYVvpdkuQhnePqq/VpNzvNI9oahK/Bu
	WTgCJoourFcQDvJ2Yg7nVD8uLa+owrhb6qdfbLW3k39zB5PyHC2V/RbYye6R6wV3RzfkZLWoq/H
	5fXRGa33CAJx3J9NqNBX7E+mYFslto1j0kdDKN429f6Z6w+rKyI0Nc26ivjNXpsebzsH0lvezIV
	F0fZgrchppufD4S/gFsOxQG/oreD77raUIKZp8ySdGdUyvI6njArVUq4UB64PvK1rPd+SQPP1Y4
	QymqHoc/mfyAC3sdUXDIVUW6LOiRL8a0QX+oLJR2SjNpBtS8FF4GdIjgPNfXDtUybwGfE=
X-Google-Smtp-Source: AGHT+IGUmqnYpbST9RYALAxh5I7SPH5rCK4jGuKHXFkKq4840xhq1+OC7120dFS4djX7wdG2rZX/lg==
X-Received: by 2002:a05:6402:2809:b0:641:3189:a192 with SMTP id 4fb4d7f45d1cf-6413f0763aamr2192820a12.20.1762504224957;
        Fri, 07 Nov 2025 00:30:24 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f85f8c7sm4054682a12.27.2025.11.07.00.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:30:24 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net v2] net: dsa: b53: bcm531x5: fix cpu rgmii mode interpretation
Date: Fri,  7 Nov 2025 09:30:06 +0100
Message-ID: <20251107083006.44604-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

b53_adjust_531x5_rgmii() incorrectly enable delays in rgmii mode, but
disables them in rgmii-id mode. Only rgmii-txid is correctly handled.

Fix this by correctly enabling rx delay in rgmii-rxid and rgmii-id
modes, and tx delay in rgmii-txid and rgmii-id modes.

Since b53_adjust_531x5_rgmii() is only called for fixed-link ports,
these are usually used as the CPU port, connected to a MAC. This means
the chip is assuming the role of the PHY and enabling delays is
expected.

Since this has the potential to break existing setups, treat rgmii
as rgmii-id to keep the old broken behavior.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Reported-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Changes v1 -> v2:
* dropped RFC prefix (since it did the opposite, and I got zero comments)
* dropped the KConfig option and just always treat RGMII as RGMII-ID
* adapted the commit message accordingly

 drivers/net/dsa/b53/b53_common.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index eb767edc4c13..ac476cc6d6db 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1447,6 +1447,13 @@ static void b53_adjust_531x5_rgmii(struct dsa_switch *ds, int port,
 	else
 		off = B53_RGMII_CTRL_P(port);
 
+	/* Older driver versions incorrectly applied delays in
+	 * PHY_INTERFACE_MODE_RGMII mode. In order to not break old users, keep
+	 * interpreting RGMII as RGMII-ID.
+	 */
+	if (interface == PHY_INTERFACE_MODE_RGMII)
+		interface = PHY_INTERFACE_MODE_RGMII_ID;
+
 	/* Configure the port RGMII clock delay by DLL disabled and
 	 * tx_clk aligned timing (restoring to reset defaults)
 	 */
@@ -1458,19 +1465,24 @@ static void b53_adjust_531x5_rgmii(struct dsa_switch *ds, int port,
 	 * account for this internal delay that is inserted, otherwise
 	 * the switch won't be able to receive correctly.
 	 *
+	 * PHY_INTERFACE_MODE_RGMII_RXID means RX internal delay, make
+	 * sure that we enable the port RX clock internal sampling delay
+	 * to account for this internal delay that is inserted, otherwise
+	 * the switch won't be able to send correctly.
+	 *
+	 * PHY_INTERFACE_MODE_RGMII_ID means both RX and TX internal delay,
+	 * make sure that we enable delays for both.
+	 *
 	 * PHY_INTERFACE_MODE_RGMII means that we are not introducing
 	 * any delay neither on transmission nor reception, so the
-	 * BCM53125 must also be configured accordingly to account for
-	 * the lack of delay and introduce
-	 *
-	 * The BCM53125 switch has its RX clock and TX clock control
-	 * swapped, hence the reason why we modify the TX clock path in
-	 * the "RGMII" case
+	 * BCM53125 must also be configured accordingly.
 	 */
-	if (interface == PHY_INTERFACE_MODE_RGMII_TXID)
+	if (interface == PHY_INTERFACE_MODE_RGMII_TXID ||
+	    interface == PHY_INTERFACE_MODE_RGMII_ID)
 		rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
-	if (interface == PHY_INTERFACE_MODE_RGMII)
-		rgmii_ctrl |= RGMII_CTRL_DLL_TXC | RGMII_CTRL_DLL_RXC;
+	if (interface == PHY_INTERFACE_MODE_RGMII_RXID ||
+	    interface == PHY_INTERFACE_MODE_RGMII_ID)
+		rgmii_ctrl |= RGMII_CTRL_DLL_RXC;
 
 	if (dev->chip_id != BCM53115_DEVICE_ID)
 		rgmii_ctrl |= RGMII_CTRL_TIMING_SEL;

base-commit: c2c2ccfd4ba72718266a56f3ecc34c989cb5b7a0
-- 
2.43.0


