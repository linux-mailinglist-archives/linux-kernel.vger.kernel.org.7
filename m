Return-Path: <linux-kernel+bounces-844216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60449BC1527
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E6774F5487
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1222DE6F7;
	Tue,  7 Oct 2025 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="f6VbaBm8"
Received: from mx-relay48-hz3.antispameurope.com (mx-relay48-hz3.antispameurope.com [94.100.134.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5212DCF72
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.237
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839067; cv=pass; b=PS6EhdQprxuYUNa0qP3RX2U1N9JsY2RPuGuYGchrIuaC7NIWquPQZTkxZDOMJYrqVnUrk9iuSswz2LrJn5QNiGwXNVYEr80waR4RqQViy9xQLlS3X8YdKUX/cWWT3vObyd8PXjQxOnSMiqbitWtIjj255USqCYO5W0h8f04O/1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839067; c=relaxed/simple;
	bh=k42zL3JTM7BE3x6dKMZ2jKfGQCJubStuzW5boFB9jvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kn3zxMC5SeU/KgkDx1qFOT+EHpKw4zf1wM7eDg09X+a5rbbFhcGpIlBi5QQ6/yUORcfP//WgHtJBCqtRVDK0RftdOI1QdnFoMYwSw2HRdEaLypAQDaB5FJpN512EX3xOAxUgipyAUdUuurHjdVyYnIuxLvND5N12yg8AsNtmVU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=f6VbaBm8; arc=pass smtp.client-ip=94.100.134.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=YRNQG6F3jarHI4ENArdLBZZ+Hm3muMDeZmbNRaGdu7g=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1759839008;
 b=GwA86wRBPUYUjb2irdMNojNKMiHF6A/Iqpj5kgqMhZBcNB6VU/gYjRro7FRrYbaKqlT5BFE6
 oC7/kLQ2PCF1r+0vpkgGYmT7JkbJ8jX7q0Jcp+lL/+qaK01ZFSSG0l7fHG7I85JyQrmPXS1JZnD
 MqaHiD38lD16NpGbEivbejAIQlpzP05SgIVjWL0XuVBsy1Hj4YyPvpTyvs9kfjoOfLltCyC5Jqd
 iG4hclGBKZbX/5ZSYjyoxWlajOH4ESIcbGc1ZAB2kalvpb2Ed/w35eEK8OVFp49Prkb5LD455lQ
 QqWcWdsUOrz48JF7fQHLCaQaPU23jYg7x8D0CXPg6maYw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1759839008;
 b=gCLwdgB4T6Sd1svVjW0moLBhefDmKCStFOaNPGmdkTsHMXAzQ6Rinwmga6QINkCQtnJt0ZpX
 PcofOC1P3Ddk+GbTJQKIyYRFRbihRyXYcbTQTzhZd0ghxS5fUl8tXm+5G8ngRMek92EV8UkIaS4
 7SLMd99mykN6cCy4UAoUYd9a2Rh52egmB3ivRCD/eOPAQ0kCddyCfkPrZByCr6JTGud1b3aMFdv
 aZDju6gXDx7J+TfLYtj/s5jHzz3YuoGQ76nLuhDkfmLDzoLgeaQhBGcPdS4geu0JoL1Yeb6V65O
 qpBQbT30UnGDTeErwkuAd5lqPilvKGxULh85Kl7Mlcyrw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay48-hz3.antispameurope.com;
 Tue, 07 Oct 2025 14:10:08 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 5C7EBCC0E50;
	Tue,  7 Oct 2025 14:09:57 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Peter Korsgaard <peter@korsgaard.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/2] i2c: ocores: respect adapter timeout in IRQ mode
Date: Tue,  7 Oct 2025 14:09:25 +0200
Message-ID: <9be9d4bef9fd6d0b66534a3731b4bc6b86cc79ab.1759838476.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <1eb320b6b7d3a12e62785893ea68c4d16aa2560d.1759838476.git.matthias.schiffer@ew.tq-group.com>
References: <1eb320b6b7d3a12e62785893ea68c4d16aa2560d.1759838476.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay48-hz3.antispameurope.com with 4cgw1d6HSqz1kKP2P
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:748d84c8fdd2790a6e1d6e662b8d81e2
X-cloud-security:scantime:2.114
DKIM-Signature: a=rsa-sha256;
 bh=YRNQG6F3jarHI4ENArdLBZZ+Hm3muMDeZmbNRaGdu7g=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1759839007; v=1;
 b=f6VbaBm8OELD17v9+jNd42w+MNCVOWZv0IxXoJmiq2pnwhQED5k5NXs5o2U3aZv8uhdi0s1z
 6sgwDdTSSXJo5pbCJHBYjD7pfa5gsLNiuxKXKRTQs10LWiuagiR0JrskhIlMi8agp72dwNghU1O
 I/kOLdzcvs905eYoRga+6fXRGKmK27FUoYdzORG5a4ca2bBUz9E4SAR/Fsa4y9hpPyO+QtOQuyY
 m+SNOP+rlTRASbb1brL8sMTV3BPEcSoU7+hTETXOmz2af/EOcWAuo+cOlqhUY/XoYON026pRwkk
 hrZ52KwZ923pR18HsyodwFQl7qEp2mJfRLeGZsbwPdc0g==

While the timeout field of the i2c_adapter defaults to 1s, it can be
changed, for example using the I2C_TIMEOUT ioctl. Change the ocores
driver to use this timeout instead of hardcoding 1s, also making it
consistent with polling mode.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/i2c/busses/i2c-ocores.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 1746c8821a149..518e4cf821a7a 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -380,7 +380,8 @@ static int ocores_xfer_core(struct ocores_i2c *i2c,
 	} else {
 		if (wait_event_timeout(i2c->wait,
 				       (i2c->state == STATE_ERROR) ||
-				       (i2c->state == STATE_DONE), HZ) == 0)
+				       (i2c->state == STATE_DONE),
+				       i2c->adap.timeout) == 0)
 			ret = -ETIMEDOUT;
 	}
 	if (ret) {
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


