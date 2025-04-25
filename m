Return-Path: <linux-kernel+bounces-619602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA6FA9BEDB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 08:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 540FE7B4C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 06:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C63D22D4DC;
	Fri, 25 Apr 2025 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drowEy3X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454E4414;
	Fri, 25 Apr 2025 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563811; cv=none; b=jzuNNwbaePuvrEkEgJS5w7f41vE1Lsm00m+1RQXbcNHMXvxJLdbphhP1PGcHBXyaUyRZQLydmWl1HcnAKggukFqVMKMaWhH0YFVk7p/Vyn9NQPsAz1QKNioIq1tzgGFFRvTasMuJS1t/tCziUATg9GcZid1djDXukFjU7uuZdj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563811; c=relaxed/simple;
	bh=tWFVfX9AgzXZgcJhmEXPnukTFm6Kvx9Tj8LyEKCB960=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QQVFlf6o0nxIzML4KVa6jCKzCg/fos0Yryg8pUMPIgrInUKg74qnlEdtiI1px+gZiLKV5rifo6NYQMjlcjieg0L7CFOo4ZGAe8+sUUa65eTWZm/dRNiw2bu/p/SbkcqLoF6X1irZTKqttrSCiPD6eNF1/c5z6B3vkTX+hMr0lcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drowEy3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA9EAC4CEE4;
	Fri, 25 Apr 2025 06:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745563810;
	bh=tWFVfX9AgzXZgcJhmEXPnukTFm6Kvx9Tj8LyEKCB960=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=drowEy3XApE8Cf59j/GT5tDJ5du3O9U7siw78gzE19ZCAEHqClOahSRcE95QfrK1O
	 ID8rstAKt/9ZHh0X4DDVb1otTge+YKAV/Ux/h/E/LeAF7cAiAYAssZ32T+jNAXTCG5
	 ninrrcq6crwwUJegHo6TkpUsEFfSSz9kbz9St7DBwzeS+d6gyBMYQTvfDDuIC9TaWX
	 viWl3BwmYt9hLGLRdVh3rkvMyRI7hY2y0Bzr0FBFauo8Vvlt6DAGTWh/HRqzrBO75/
	 XWnAB5QotQhyte3Gup84PfD2Hh413lEmJ5UrGGkzMH8PJ/EAVsVMYSiPl/yINdFeJd
	 yO7a+6F2YdrPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E5CC369D1;
	Fri, 25 Apr 2025 06:50:10 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Fri, 25 Apr 2025 10:49:55 +0400
Subject: [PATCH] net: dsa: qca8k: fix led devicename when using external
 mdio bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-qca8k-leds-v1-1-6316ad36ad22@outlook.com>
X-B4-Tracking: v=1; b=H4sIAJIwC2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyNT3cLkRIts3ZzUlGJdY9NUY8Mky0RjQ8s0JaCGgqLUtMwKsGHRsbW
 1AApG7MZcAAAA
X-Change-ID: 20250425-qca8k-leds-35e31b9a319f
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745563809; l=3227;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=oy2ijsO0Jdzv/lMO4bEI94Kv6WkE/CDMJyR+pOfZnZo=;
 b=an93rtCJQBDy/8TuNabCYkj0kVB73yjz8c0Oq0AvyjBvEoJ8xW3Tg3b7vxaoIil+lW0lRJljL
 Wo/OHf6sLbFAYSTTyjz80QTOhkSWWhmxfMsZxQJiZmgE/R5p3vGb5CM
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

The qca8k dsa switch can use either an external or internal mdio bus.
This depends on whether the mdio node is defined under the switch node
itself and, as such, the internal_mdio_mask is populated with its
internal phys. Upon registering the internal mdio bus, the slave_mii_bus
of the dsa switch is assigned to this bus. When an external mdio bus is
used, it is left unassigned, though its id is used to create the device
names of the leds.
This leads to the leds being named '(efault):00:green:lan' and so on as
the slave_mii_bus is null. So let's fix this by adding a null check and
use the devicename of the external bus instead when an external bus is
configured.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
Fix the led device names when an external mdio is configured.
The current codepath for registering led device names 'assumes' that the
internal mdio bus is used. Therefore, add a check and fallback to the
device name of the external mdio bus while creating the led device
names.

Wrong device names:
root@OpenWrt:~# ls -l /sys/class/leds                                           
lrwxrwxrwx    1 root     root             0 Jan  1  1970 (efault):00:green:lan -> ../../devices/platform/soc@0/90000.mdio/mdio_bus/90000.mdio-1/90000.n
lrwxrwxrwx    1 root     root             0 Jan  1  1970 (efault):01:green:lan -> ../../devices/platform/soc@0/90000.mdio/mdio_bus/90000.mdio-1/90000.n
lrwxrwxrwx    1 root     root             0 Jan  1  1970 (efault):02:green:lan -> ../../devices/platform/soc@0/90000.mdio/mdio_bus/90000.mdio-1/90000.n

Correct device names:
root@OpenWrt:~# ls -l /sys/class/leds                                                                                                                      
lrwxrwxrwx    1 root     root             0 Jan  1  1970 90000.mdio-1:00:green:lan -> ../../devices/platform/soc@0/90000.mdio/mdio_bus/90000.mdio-1/90000.n
lrwxrwxrwx    1 root     root             0 Jan  1  1970 90000.mdio-1:01:green:lan -> ../../devices/platform/soc@0/90000.mdio/mdio_bus/90000.mdio-1/90000.n
lrwxrwxrwx    1 root     root             0 Jan  1  1970 90000.mdio-1:02:green:lan -> ../../devices/platform/soc@0/90000.mdio/mdio_bus/90000.mdio-1/90000.n
---
 drivers/net/dsa/qca/qca8k-leds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index 43ac68052baf9f9926aaf4a9d8d09640f9022fcd..abe5beae330ef316113a8f1931671b0191b54218 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -429,7 +429,8 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
 		init_data.fwnode = led;
 		init_data.devname_mandatory = true;
 		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d",
-						 priv->internal_mdio_bus->id,
+						 ds->slave_mii_bus ?
+						 ds->slave_mii_bus->id : dev_name(&priv->bus->dev),
 						 port_num);
 		if (!init_data.devicename) {
 			fwnode_handle_put(led);

---
base-commit: 02ddfb981de88a2c15621115dd7be2431252c568
change-id: 20250425-qca8k-leds-35e31b9a319f

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



