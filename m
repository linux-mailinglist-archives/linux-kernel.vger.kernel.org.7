Return-Path: <linux-kernel+bounces-781541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 601AAB313D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645CCA2304A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6952E2F83D6;
	Fri, 22 Aug 2025 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zLcinxX0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8/w9DcCA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zLcinxX0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8/w9DcCA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F772F068A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855327; cv=none; b=QGuAer78t92YH6uQPYjA4DlGgQfeXOJKKeKWMP8ndaMo5ImzIdKhJAkDUu2kgGUABj5WPimY+gYKTkPJgTEA5bBnpw+uvfhr1vopVl9ZmwePoSIIvhPaNdKw6DUD2RzPY7FZEWNMFPydorT0B8gYzSC7exPmUcNW4cWgODACQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855327; c=relaxed/simple;
	bh=pbSym0LfOCATgwe7XQkDBw4pyZJXZau3y3lP22KDO10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaXdHGOJG1eVhgy6JGf1nPTvhrFRGDQ/Wpbx7TDt3nJAwxgzxQ/xHGR9nt0B1lZn5GJrcs0HuJ1vqZVX07SMar1AdPHE8ZYTnFfKTYK8kgvP6MHpCg3RoCxq9hL1e/BXdpO5cuIoumtP0z0efYDsVZupIg2wVpVmqUM20qVolHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zLcinxX0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8/w9DcCA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zLcinxX0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8/w9DcCA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E9BF21EF3;
	Fri, 22 Aug 2025 09:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755855313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TlYOfY0dl+A/eQtThLwUT3frjd2gD6bRiSPLpxaq34=;
	b=zLcinxX03u9IzLm4zjTZmhf+ujXrm51QlfH5zsSofPYSwA8h4a3WCinpEGthq1/5z4lyb0
	QHpmncvHtJvIgqXav7bRL0zznGrWlIL94W0czxzEK2PujoBf3VCL5gpmvIbqFFT3IXeCzV
	MyEzLSzPXdYhyEyqR+D57O2JOPcXCg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755855313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TlYOfY0dl+A/eQtThLwUT3frjd2gD6bRiSPLpxaq34=;
	b=8/w9DcCAIp9HIEPKAVsuHm5hcb7nCtQNogsztFBzpwO5QVSYLyEnO0u6cNLK0ED55t5t5T
	izmS9IsWp8ZUztDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755855313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TlYOfY0dl+A/eQtThLwUT3frjd2gD6bRiSPLpxaq34=;
	b=zLcinxX03u9IzLm4zjTZmhf+ujXrm51QlfH5zsSofPYSwA8h4a3WCinpEGthq1/5z4lyb0
	QHpmncvHtJvIgqXav7bRL0zznGrWlIL94W0czxzEK2PujoBf3VCL5gpmvIbqFFT3IXeCzV
	MyEzLSzPXdYhyEyqR+D57O2JOPcXCg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755855313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TlYOfY0dl+A/eQtThLwUT3frjd2gD6bRiSPLpxaq34=;
	b=8/w9DcCAIp9HIEPKAVsuHm5hcb7nCtQNogsztFBzpwO5QVSYLyEnO0u6cNLK0ED55t5t5T
	izmS9IsWp8ZUztDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22C0A13A31;
	Fri, 22 Aug 2025 09:35:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4LYNAdA5qGihMAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 22 Aug 2025 09:35:12 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 3/5] net: cadence: macb: Add support for Raspberry Pi RP1 ethernet controller
Date: Fri, 22 Aug 2025 12:34:38 +0300
Message-ID: <20250822093440.53941-4-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250822093440.53941-1-svarbanov@suse.de>
References: <20250822093440.53941-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -5.30

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The RP1 chip has the Cadence GEM block, but wants the tx_clock
to always run at 125MHz, in the same way as sama7g5.
Add the relevant configuration.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 36717e7e5811..260fdac46f4b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5135,6 +5135,17 @@ static const struct macb_config versal_config = {
 	.usrio = &macb_default_usrio,
 };
 
+static const struct macb_config raspberrypi_rp1_config = {
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
+		MACB_CAPS_JUMBO |
+		MACB_CAPS_GEM_HAS_PTP,
+	.dma_burst_length = 16,
+	.clk_init = macb_clk_init,
+	.init = macb_init,
+	.usrio = &macb_default_usrio,
+	.jumbo_max_len = 10240,
+};
+
 static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,at91sam9260-macb", .data = &at91sam9260_config },
 	{ .compatible = "cdns,macb" },
@@ -5155,6 +5166,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "microchip,mpfs-macb", .data = &mpfs_config },
 	{ .compatible = "microchip,sama7g5-gem", .data = &sama7g5_gem_config },
 	{ .compatible = "microchip,sama7g5-emac", .data = &sama7g5_emac_config },
+	{ .compatible = "raspberrypi,rp1-gem", .data = &raspberrypi_rp1_config },
 	{ .compatible = "xlnx,zynqmp-gem", .data = &zynqmp_config},
 	{ .compatible = "xlnx,zynq-gem", .data = &zynq_config },
 	{ .compatible = "xlnx,versal-gem", .data = &versal_config},
-- 
2.47.0


