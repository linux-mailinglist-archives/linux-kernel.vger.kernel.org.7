Return-Path: <linux-kernel+bounces-881309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1487C27F67
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 330BC4EDAC2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CD22FA0C7;
	Sat,  1 Nov 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9eYnHcQ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC612F693E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003699; cv=none; b=In+DdiQbH3geFZypExEZR9RZlYxlX+PLJADRk9sXLMmXdLLKSwmzS7XHyANHRbSPeKjIrHQkYNOhv5t1SdxKxOOv1hEdt2EYZxzTuGRSV+WWUPuQxo2VW0R5RlYY3r/kuiQseUJgz1lhjAYTdVRjh48980RYOZdYKadD15+GCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003699; c=relaxed/simple;
	bh=GuA+isXe74pCMi5AagYqigBBFtYLC8iDrtT+Rj/v+/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTAa4PV4kJCQbqWM8UBYD9y09UjMgds8AaoUxq2xmToAgM9QQRm3bfi5dN9EoyPLm1GuxaGdoI3uHVExCKA6RuzH7qHs9ts1XCVSpW8J4iNyTokoRuBq4VSWSp90tBaDx9oLooSkt5T21v1uE6mgo4GPRlly5FlWNOXa0rN/nag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9eYnHcQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b4f323cf89bso721533866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762003696; x=1762608496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsQWwaTBYaXaYYeBhg0oOm1XDOfz/d4zqdv0JWj9rWk=;
        b=U9eYnHcQOCoJN3AkeOc0eOPBcQzwGy2sr8czqaD/cqlS3II1+pDKQgvEyouhUFLDWm
         bvbBOEgR0fG71n4XTskzpYduGWtavL6dJ/9B7Q+wgBsUEWmFA5RmLYYPGi1FL/2gQCyk
         Wj9sWzXyFd+jblBopFapTYXwc/xMJLMtAKPAOHh9xxNF2AToAXxrwUanlzfqz0+oAfp1
         eIcfKDazSVmTJ5nhp5o79RyhiRO+NaYFg0hqDZgrjQvh/hqMriR6yq+xI1MuKzq5lKB1
         zlBT0S4um5Ot9FqWilzB8oM/r4ZqhgxqiHOS478WQUDAa+oXw7aAaLT+NUy+0SxuO0jK
         g4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003696; x=1762608496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsQWwaTBYaXaYYeBhg0oOm1XDOfz/d4zqdv0JWj9rWk=;
        b=KwtnE3YYuoBjrUhcRrcDPcDwCm6GwIOiWiJGHS/gs7INY0+ERZv/iIJW7Y+Tf5yx28
         5+oZbuyrIg/btmz/5N+ORPWz/4jQBexmX9DZLMElsZdBi+GbD/gXfw0E0OsAJSy4F2pa
         X1HkXzOdr4LJ8Kx+TAGyqAaEA1Ar8sX+4kRaQz7PayRd+a8NKiY2g/i2xa0qJbsUfTqL
         AB1Ce2gh97T+Q4pa0b1pj9lws35ikTsPvHSEUWvEJBZ/o3f8ZYjI02MNfuVazAD9IW96
         eXwRZb0GiDEnqcl4kvzBp733fFb3KivY9BArN48WQ3BAFdxGfCM+bdiCKBJ4k1ZgWBmw
         sZ8A==
X-Forwarded-Encrypted: i=1; AJvYcCVITm6+IRqjGKMe96TZPuwEYUR2tyUvyqeQxeYr96KcmcusfvR4rTPy0AOa7H029SpSIl6oLBBBzYWLbz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzvvzARvjZxKt82C9FUcZ+dLcR7yZ7aHNZ2PqG0xXYR81NEVXl
	ALRl+CNTZgr6W294bBVEVpiTTPjJhBpKXjI+tVqYL/o9zHhR+A8NyZcr
X-Gm-Gg: ASbGncsu5+NFMi18W7xTHPaVGpEp3poVg6npswiFM7WbQEcW4jZEqc9bLF5ouaMTwlc
	B4NAcUUvnDZErFrTc4lQ+oDtI7SRVNArlSDgm7m55qMSW/xFLpvCFhl162JFLW2f0u4QiPU/T2O
	n19Lm+McoigF4NGkGH4mTgQh3TqRR3pZ+RDxrhG6MIjrKrHwW9uA1e7mOdtS1+NAmSvMGancCxH
	qMLtGsqu3uthzqR5DIjoLqZREzj37FvVSuSs4j2r+im2uKYrnxi7+aOpdAyhu+soiSg8bXMDKYe
	Tjbjrlm8gvHDQp1LKJLS3LbzScOz1j5858DA8PIAAm/BMWRdWM44SDNbsmskoOFhigLV2A6GXw0
	+MNNMiaR+ZrK0lkW52GQnGfNTfh3oDeR6jgFbC3d3NPy7j4A0IZfm1uHj5/JET/Ll1ZrPyE8kU4
	wEq4BX+KOL5Gq0NP5hF0wBcocuq0MDqE0nNA16x16S4zUaNRcUV6Lmh2BvY/hi0P4R55U=
X-Google-Smtp-Source: AGHT+IGZSQM2I289mbdiKbtsD737lwC5ysxlXKrslabDruRymOPxxKq14HayHZfu2hGtyjjE+PL15g==
X-Received: by 2002:a17:907:72c8:b0:b3f:9b9c:d499 with SMTP id a640c23a62f3a-b7070735de0mr699584566b.51.1762003695965;
        Sat, 01 Nov 2025 06:28:15 -0700 (PDT)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077cfa966sm453741766b.65.2025.11.01.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:28:15 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: dsa: b53: fix bcm63xx RGMII port link adjustment
Date: Sat,  1 Nov 2025 14:28:07 +0100
Message-ID: <20251101132807.50419-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251101132807.50419-1-jonas.gorski@gmail.com>
References: <20251101132807.50419-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BCM63XX's switch does not support MDIO scanning of external phys, so its
MACs needs to be manually configured for autonegotiated link speeds.

So b53_force_port_config() and b53_force_link() accordingly also when
mode is MLO_AN_PHY for those ports.

Fixes lower speeds than 1000/full on rgmii ports 4 - 7.

This aligns the behaviour with the old bcm63xx_enetsw driver for those
ports.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index cb28256ef3cc..bb2c6dfa7835 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1602,8 +1602,11 @@ static void b53_phylink_mac_link_down(struct phylink_config *config,
 	struct b53_device *dev = dp->ds->priv;
 	int port = dp->index;
 
-	if (mode == MLO_AN_PHY)
+	if (mode == MLO_AN_PHY) {
+		if (is63xx(dev) && in_range(port, B53_63XX_RGMII0, 4))
+			b53_force_link(dev, port, false);
 		return;
+	}
 
 	if (mode == MLO_AN_FIXED) {
 		b53_force_link(dev, port, false);
@@ -1631,6 +1634,13 @@ static void b53_phylink_mac_link_up(struct phylink_config *config,
 	if (mode == MLO_AN_PHY) {
 		/* Re-negotiate EEE if it was enabled already */
 		p->eee_enabled = b53_eee_init(ds, port, phydev);
+
+		if (is63xx(dev) && in_range(port, B53_63XX_RGMII0, 4)) {
+			b53_force_port_config(dev, port, speed, duplex,
+					      tx_pause, rx_pause);
+			b53_force_link(dev, port, true);
+		}
+
 		return;
 	}
 
-- 
2.43.0


