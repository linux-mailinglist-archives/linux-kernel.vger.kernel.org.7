Return-Path: <linux-kernel+bounces-871512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DF0C0D7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43275189ED63
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD23002B9;
	Mon, 27 Oct 2025 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hqwl73ze";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4JJ8vfEQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hqwl73ze";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4JJ8vfEQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B713019AD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567747; cv=none; b=MxH6uxsDQ6ZuiufLBaFRD3iFFUezSEp4X2XNnuH1r2miYUyObYYtLJjnBTLJ2eC5xfTWz/bP1m5NG6NSn2lCFguvGE+rjQHcouZSAyFQ/p6yL/0tvi8PKOrXMDjWi2UZTU1iB8RnTqzOqcr8yrvfa0S68n8rEU8jdMY4duuBGGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567747; c=relaxed/simple;
	bh=wklBSxlYFPH4ehGNgfItw0mg1sN0At+V0vO153soUfE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WX1PvhbGGaiJ0ohPkUazlPs9cO3zZJ9svUnvA156JpsgTfb+fFD1oizugg9rTbyoAMxXmTtaVljXZQNI9rwhZbEcGu0ftWdXwpq4kMdva0/gU7o5U7qRfVp94kmyTW9R9yCjihnVNBulk6624XLwx//j8MrWu5ZFJmRZtFBUKM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hqwl73ze; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4JJ8vfEQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hqwl73ze; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4JJ8vfEQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CD951F45B;
	Mon, 27 Oct 2025 12:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761567744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2yDrc8KAXYzzuXLapf9I3dz+qempeGT0obqSKelVbhM=;
	b=hqwl73zeGObFtmoDQmXEyl9M8zjy3U/dWFiCT7yQlWyjpTQKiMoToaV5w6CUETyhCl1h4p
	nqZOd9iRNMg4PAPoYaeory86Dk+WFd1It9rhWLNZNZ6mZw9EHzoPRbLvb/Wpt9o1nSzm3r
	gJ+2/ucaTk1beKgVVSCzlQwXzvfRjLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761567744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2yDrc8KAXYzzuXLapf9I3dz+qempeGT0obqSKelVbhM=;
	b=4JJ8vfEQlnz1tpH2/Z7ZNY+EzxFhRjnNrfzrRjoKYhlXLoweU4pxBuWq6+6CwtKZbtUBGu
	U8+AWBPgSuQYl+Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hqwl73ze;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4JJ8vfEQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761567744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2yDrc8KAXYzzuXLapf9I3dz+qempeGT0obqSKelVbhM=;
	b=hqwl73zeGObFtmoDQmXEyl9M8zjy3U/dWFiCT7yQlWyjpTQKiMoToaV5w6CUETyhCl1h4p
	nqZOd9iRNMg4PAPoYaeory86Dk+WFd1It9rhWLNZNZ6mZw9EHzoPRbLvb/Wpt9o1nSzm3r
	gJ+2/ucaTk1beKgVVSCzlQwXzvfRjLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761567744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2yDrc8KAXYzzuXLapf9I3dz+qempeGT0obqSKelVbhM=;
	b=4JJ8vfEQlnz1tpH2/Z7ZNY+EzxFhRjnNrfzrRjoKYhlXLoweU4pxBuWq6+6CwtKZbtUBGu
	U8+AWBPgSuQYl+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C10DE13693;
	Mon, 27 Oct 2025 12:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 60HQLP9j/2hwDgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 27 Oct 2025 12:22:23 +0000
Date: Mon, 27 Oct 2025 13:22:19 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Marek Vasut <marex@denx.de>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] regulator: Let raspberrypi drivers depend on ARM
Message-ID: <20251027132219.2f3274f0@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0CD951F45B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

The Raspberry Pi drivers aren't useful on other architectures, so
only offer them on ARM and ARM64, except for build testing purposes.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
Marek, Dave, would you be OK with that change?

 drivers/regulator/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- linux-6.17.orig/drivers/regulator/Kconfig
+++ linux-6.17/drivers/regulator/Kconfig
@@ -1144,6 +1144,7 @@ config REGULATOR_RAA215300
 
 config REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY
 	tristate "Raspberry Pi 7-inch touchscreen panel ATTINY regulator"
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on I2C
 	depends on OF_GPIO
@@ -1155,6 +1156,7 @@ config REGULATOR_RASPBERRYPI_TOUCHSCREEN
 
 config REGULATOR_RASPBERRYPI_TOUCHSCREEN_V2
 	tristate "Raspberry Pi 7-inch touchscreen panel V2 regulator"
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on GPIOLIB
 	depends on I2C && OF
 	select GPIO_REGMAP


-- 
Jean Delvare
SUSE L3 Support

