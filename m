Return-Path: <linux-kernel+bounces-831489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F8B9CCFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D378E1BC4EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BFBA935;
	Thu, 25 Sep 2025 00:05:33 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A016129A78
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758733; cv=none; b=P4NvEc5UNU//27nifxBR9tpF0eUSKz87CwtKDa/zMO6VkM8sWC2jZM4BEIdiIgNPxSDLiagTm1ercONjjKKecHKEpRCp6wRDXN1MC10ikIzivxnsEXW7cu+zlrnhqHkepxjIwNvLcqGZRqxCs3JWmo9296u3hxBRRu+smoxzMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758733; c=relaxed/simple;
	bh=RH0QEu2d9NccLKNcuR4FBneyMos5qOb+41JpotHZc3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hfiz6xb6Xley4M9AV+nuiV/6H68JbfBWyQF3Ih27hg8oZ+vXH5oQNkT5I57BsOPnfGUvrbQb5AtM7tPWIN4TuLcDxw9o1u7A6cZThUsL7FBi2Fv4Japm4vH0tPTLHjdiV7Rn+KqKnoXeaqBPXnDflhjaslW8t+/Klr5mV/6BF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8ADB3F534;
	Thu, 25 Sep 2025 00:05:21 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE82C1386E;
	Thu, 25 Sep 2025 00:05:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IIA9LECH1GgdNQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 25 Sep 2025 00:05:20 +0000
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
Subject: [PATCH 4/4] arm64: dts: broadcom: Enable RP1 ADC for RPi5
Date: Thu, 25 Sep 2025 03:04:16 +0300
Message-ID: <20250925000416.2408457-5-svarbanov@suse.de>
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
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[dt]
X-Rspamd-Queue-Id: A8ADB3F534
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

Enable RP1 ADC for Raspberry Pi 5.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts | 8 ++++++++
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts         | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
index 6ea3c102e0d6..7943ec3fd6ea 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
@@ -51,6 +51,14 @@ sd_vcc_reg: sd-vcc-reg {
 		enable-active-high;
 		gpios = <&gio_aon 4 GPIO_ACTIVE_HIGH>;
 	};
+
+	rp1_vdd_3v3: rp1_vdd_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 /* The Debug UART, on Rpi5 it's on JST-SH 1.0mm 3-pin connector
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index c70d1cb7f3b6..cb75792b659a 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -24,6 +24,11 @@ &pcie2 {
 	status = "okay";
 };
 
+&rp1_adc {
+	vref-supply = <&rp1_vdd_3v3>;
+	status = "okay";
+};
+
 &rp1_eth {
 	status = "okay";
 	phy-mode = "rgmii-id";
-- 
2.47.0


