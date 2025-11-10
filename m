Return-Path: <linux-kernel+bounces-892698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF18C45A45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90A344E9CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F5E30146F;
	Mon, 10 Nov 2025 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lnxNBCka"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DF128CF6F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766710; cv=none; b=tEeOMaUKv0tKMeTJGRn41hJT5BKKbRbRg3FC3iEyXelFTP8ozsknm2Fr3PoPafitmCBBOcZFLsxZ926eppFaeDkbpF9UU91/U18YhCzqPo1SlKUOCSf2q6BSUv5mEdTOsGsiLVVSIperJR+ltdqzfM6ji2QU7c22GkRgR6wKHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766710; c=relaxed/simple;
	bh=VF0B808n4szjmm435IxRlwSJgInTyKl/Z+XdCuwycps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I0yjy5e+1rCNSN8Yf7pRWXJk8M6yzPJ8azKaON347K2FxikYPWmrf2N4RqxvMSPgqVFWqiaxCjCypXOzV+DnNYJxvqQd1czxnFAq6IfshTe/tN6VMdj8uHlW7ZHyLDS+whpUDQtS5fEk0YqIkcI/X754lgoHrcDcD43wnl8RcYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lnxNBCka; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 843D54E41607;
	Mon, 10 Nov 2025 09:25:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 59113606F5;
	Mon, 10 Nov 2025 09:25:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8AA66103718C5;
	Mon, 10 Nov 2025 10:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762766702; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ahBjE0dA+/iYnH6oOmoggBaMYIM7enJhfD8WAtxUp38=;
	b=lnxNBCkaOxOFAp54kUer4L+fRnjhmQIZTtcp/oI2mUQGrCw1m9pF5QCRlnlrRz0ImBZTrZ
	smxx6vxaCtlvdD9uqdhZFYd1FSbNJsGPf5pRo/tMx713ONCRAC6tqw5svQdXn+Sf0DKMP2
	uICt6xTocnUPNjW7PHEF6peM5xgjU7wiiV89OtDe2ElvwFN+ChM87Jb8gAt8Yoy0Fg4I3t
	OVORZSmikwH6Z3x0pmsaRpw6VkSuWogq/kYGIRkXKQ49cGHVjDBIE9a+Mr70n+UjG/m2Nc
	T4H8yW6bvXtclCnURAZZCKGb1DTIrb1Y9fOb4aZmZdHxgzzDSxPfnGrmtxiWoA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 10 Nov 2025 10:24:53 +0100
Subject: [PATCH net-next v2 1/3] net: phy: dp83869: Restart PHY when
 configuring mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-sfp-1000basex-v2-1-dd5e8c1f5652@bootlin.com>
References: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
In-Reply-To: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The DP83869 PHY requires a software restart when the OP_MODE is changed.

Add this restart in dp83869_configure_mode().

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 1f381d7b13ff..309bf608d630 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -792,11 +792,17 @@ static int dp83869_configure_mode(struct phy_device *phydev,
 	case DP83869_RGMII_1000_BASE:
 	case DP83869_RGMII_100_BASE:
 		ret = dp83869_configure_fiber(phydev, dp83869);
+		if (ret)
+			return ret;
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	ret = phy_write(phydev, DP83869_CTRL, DP83869_SW_RESTART);
+
+	usleep_range(10, 20);
+
 	return ret;
 }
 

-- 
2.51.2


