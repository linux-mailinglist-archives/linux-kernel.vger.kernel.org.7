Return-Path: <linux-kernel+bounces-798564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD71CB41FD5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BC63A4A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1483064B4;
	Wed,  3 Sep 2025 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MMsVVr8/"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDDF302770
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903678; cv=none; b=sB7ZrFb5czKkarJZTEQvLoFMDDAnQBBwN8gJDlpUugCNTwpsdvzZJNW3e65FphDHZg3pFfwhL74pYZEZVeS+WyEBn8kz/PIp6skBXTrTDpOCY5OBiTRVi7SY/LHTI91+9oO5VTqomtUz+pXnX3IfhArzNp2LugOb69/raxVPyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903678; c=relaxed/simple;
	bh=tkW5x3xXgltuqbCsN7rkr+c/J/FoTke8ujqu3am9bUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHpmjpXi4XQbWpc3/S4jQcXFKjpnPGFlgdcYMdFmarJgn9cJajMvzOXWrtC4eJxtNHnA5/AvNm+DMANAVOY82vGTamRVsHVS4+nG2x9VSMrd2nTyiEMiCUIWtz6zQ+7856b0JXJXDM14iOd1LAGjnBR+CWR7nJy+SaC/6ZG0dhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MMsVVr8/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EA4A3C8EC51;
	Wed,  3 Sep 2025 12:47:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 06F94606C3;
	Wed,  3 Sep 2025 12:47:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 482C51C22DBAD;
	Wed,  3 Sep 2025 14:47:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756903672; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zu15Dv3rwzhMYuygTnnYcdnEv58fMlFkI0F/4ADcw+s=;
	b=MMsVVr8/kQM8Ys1kXWXlOx653qiHZ/L2OR9Wi2bumgdoXhP2WwfnCYrBAUuNhng+jo5eWe
	ZkE2ud/tcvf8gxGe4ajMSMSYyKdzZFdNl72MhiWAjF6lEsJ8SkkrdisuMNElHhcnMsj0vx
	McOLrjh2paiPyLrkXztMd/dAGFF1NGlJ+iF+dzfeAX8nraGxvP+4tGrz74Dzb8EinVs7z5
	/aHi/w6FK4G8zaYXKNAot0GTFaPi6rdUcVZ1Kp2JUF10RzY02d194RT3APjhhLfVKmU/Ar
	7MKB3K4aWpNRuJXp0YjZmxNIdli92A2bY/hJ+RGs8VaKcb6YZoQV7OLY0Jf/bw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Wed, 03 Sep 2025 14:47:16 +0200
Subject: [PATCH 09/19] clk: divider: check validity of flags when a table
 is provided
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250903-clk-eyeq7-v1-9-3f5024b5d6e2@bootlin.com>
References: <20250903-clk-eyeq7-v1-0-3f5024b5d6e2@bootlin.com>
In-Reply-To: <20250903-clk-eyeq7-v1-0-3f5024b5d6e2@bootlin.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Sari Khoury <sari.khoury@mobileye.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

If any of the flag CLK_DIVIDER_ONE_BASED, CLK_DIVIDER_POWER_OF_TWO,
CLK_DIVIDER_MAX_AT_ZERO or CLK_DIVIDER_EVEN_INTEGERS is set, the divider
table will be ignored in _get_div and _get_val. This can lead to subtle
bug when a clock is registered with some flags and an optional table,
with the clock rate and register value being computed with the wrong
type of conversion.

Prevent this by refusing to register a divider with both the flag and
the table set.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/clk/clk-divider.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 8e8f87024e76625f348f1d66c15a7a938fa0c4db..b4861d519bac2121dd015d094c94a5fee2480148 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -561,6 +561,13 @@ struct clk_hw *__clk_hw_register_divider(struct device *dev,
 			return ERR_PTR(-EINVAL);
 		}
 	}
+	if (table && (clk_divider_flags & (CLK_DIVIDER_ONE_BASED |
+					   CLK_DIVIDER_POWER_OF_TWO |
+					   CLK_DIVIDER_MAX_AT_ZERO |
+					   CLK_DIVIDER_EVEN_INTEGERS))) {
+		pr_warn("divider table and flags incompatible\n");
+		return ERR_PTR(-EINVAL);
+	}
 
 	/* allocate the divider */
 	div = kzalloc(sizeof(*div), GFP_KERNEL);

-- 
2.51.0


