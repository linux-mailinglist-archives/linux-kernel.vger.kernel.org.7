Return-Path: <linux-kernel+bounces-831488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58352B9CCEE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF307B42E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86392628D;
	Thu, 25 Sep 2025 00:05:29 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF272639
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758729; cv=none; b=l/PIa53WBEMIQgMsECntaJnNfhfzAQUG3oJOng3lbDK4i0u0GgY8ENF0AaNhwLb/4sGln/HR0AOwNq0E8h2Hb7dNxELvtRdFEK7sv5ImzNUWnzDYGnMaSo/IrayXQxvEe+4l6dh0uBuf8C7K4vK8DzC6bOwIWgc3Lv1FltcRA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758729; c=relaxed/simple;
	bh=gkjRbBYbeFFfZZgNQHCZf9VD0rEAhTe2UfEcodk1ePc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdHxQ4VmNReO3iGDw7aG6AtnjpqLSmho6ScBmL5Jw6JzJyulzM8z5r+5ROHuUkO4XU02s0/lb4zn7w1LMU5HSVrmJnHJbW9ScRAJpQ6mM52vmlByd9IReSIJAfVaPA+7D3PpkAMG0a39qcliGc3c5Nf4i52EHAuEYTpI02faFTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B069E67EA7;
	Thu, 25 Sep 2025 00:05:20 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C78F01386E;
	Thu, 25 Sep 2025 00:05:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WLxdLj+H1GgdNQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 25 Sep 2025 00:05:19 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-hwmon@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>,
	Saenz Julienne <nsaenz@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH 3/4] arm64: dts: rp1: Add Raspberry Pi's RP1 ADC DT node
Date: Thu, 25 Sep 2025 03:04:15 +0300
Message-ID: <20250925000416.2408457-4-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250925000416.2408457-1-svarbanov@suse.de>
References: <20250925000416.2408457-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[dt]
X-Rspamd-Queue-Id: B069E67EA7
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

Add Raspberry Pi's RP1 ADC DT controller node.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
index 6bdc304c5f24..a0b06d7ce9f2 100644
--- a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
+++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
@@ -40,6 +40,13 @@ rp1_gpio: pinctrl@400d0000 {
 			     <2 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	rp1_adc: adc@400c8000 {
+		compatible = "raspberrypi,rp1-adc";
+		reg = <0x00 0x400c8000 0x0 0x4000>;
+		clocks = <&rp1_clocks RP1_CLK_ADC>;
+		status = "disabled";
+	};
+
 	rp1_eth: ethernet@40100000 {
 		compatible = "raspberrypi,rp1-gem";
 		reg = <0x00 0x40100000  0x0 0x4000>;
-- 
2.47.0


