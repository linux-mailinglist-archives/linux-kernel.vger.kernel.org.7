Return-Path: <linux-kernel+bounces-735407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3B4B08EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E663161355
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F32F6F97;
	Thu, 17 Jul 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FeOagNFI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FeOagNFI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22BD78C9C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761585; cv=none; b=hlfH9UeRgxQOH8RIR3A0jZGvjN/y+yb4V5fGesSflPEivA29E9pTK52C2UTHcHjprNvw7VJemW5dRPy20s5hAM/6joctRV6bKw5Z9LLZbeWC2k5iIedaZ0UaW42VPTVwxnW8+bdCiD3nHU4HpslE8zKMMcphtEEGQKacrr1jx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761585; c=relaxed/simple;
	bh=rN99tKa8OXJ2Dh+kbFOwKbAB9dFuqJJoacIWy0uyqw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=anDrjPrAB3hDEayDJ0hAVptpqo9zMe/LegipM0blA6q02gAKCKzahKkZ+4tV3ZxOsI5+tZ3AH24cKGKRK8iuv2u7mb17A9Nh22g4PT8IkOOBL8N3rQJFumtAyiYrUyF8ZFQeYZYgdiIQwfeLP+iu08FzkYuQxEt0bKu2X54RVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FeOagNFI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FeOagNFI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A78591FB85;
	Thu, 17 Jul 2025 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752761581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=okJ80G5AgtEaNhJJl0LXtk8E75/5rCUKj1GlMcKNjds=;
	b=FeOagNFIXCAkTIhSoEF/plAgyT4AolfIc/6bpD8WKy/wUJbdlXPnWHH4g741Yxk+lWULuh
	nd2DGs8QmfG0qvw11A65UAiTjg2n9xP2yxyqmldte6p/94dNC0In2svzeJDB5LsauGz6yr
	IALNfQmNJbyYV29+W3+PZ8WHn3NuSe0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=FeOagNFI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752761581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=okJ80G5AgtEaNhJJl0LXtk8E75/5rCUKj1GlMcKNjds=;
	b=FeOagNFIXCAkTIhSoEF/plAgyT4AolfIc/6bpD8WKy/wUJbdlXPnWHH4g741Yxk+lWULuh
	nd2DGs8QmfG0qvw11A65UAiTjg2n9xP2yxyqmldte6p/94dNC0In2svzeJDB5LsauGz6yr
	IALNfQmNJbyYV29+W3+PZ8WHn3NuSe0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82DE013A6C;
	Thu, 17 Jul 2025 14:13:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qfbAHu0EeWgMLgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 17 Jul 2025 14:13:01 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] cdc-acm: fix race between initial clearing halt and open
Date: Thu, 17 Jul 2025 16:12:50 +0200
Message-ID: <20250717141259.2345605-1-oneukum@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: A78591FB85
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

On the devices that need their endpoints to get an
initial clear_halt, this needs to be done before
the devices can be opened. That means it needs to be
before the devices are registered.

Fixes: 15bf722e6f6c0 ("cdc-acm: Add support of ATOL FPrint fiscal printers")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/class/cdc-acm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index c2ecfa3c8349..5a334e370f4d 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1520,6 +1520,12 @@ static int acm_probe(struct usb_interface *intf,
 			goto err_remove_files;
 	}
 
+	if (quirks & CLEAR_HALT_CONDITIONS) {
+		/* errors intentionally ignored */
+		usb_clear_halt(usb_dev, acm->in);
+		usb_clear_halt(usb_dev, acm->out);
+	}
+
 	tty_dev = tty_port_register_device(&acm->port, acm_tty_driver, minor,
 			&control_interface->dev);
 	if (IS_ERR(tty_dev)) {
@@ -1527,11 +1533,6 @@ static int acm_probe(struct usb_interface *intf,
 		goto err_release_data_interface;
 	}
 
-	if (quirks & CLEAR_HALT_CONDITIONS) {
-		usb_clear_halt(usb_dev, acm->in);
-		usb_clear_halt(usb_dev, acm->out);
-	}
-
 	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
 
 	return 0;
-- 
2.50.1


