Return-Path: <linux-kernel+bounces-883046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C79C2C638
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657DD3BB2D7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967E8311592;
	Mon,  3 Nov 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V4m2OYo3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K7PCYHg6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V4m2OYo3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K7PCYHg6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB93130504A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179069; cv=none; b=o4OEo443QTDp+i92u4UAbz7x+7AuP7dggDgJIXUzZ7FFaOIDVYwoAmJtine0AX6q8E8hmZuNbSyBSXSTqMh9HeVOmQaXMpweu8wmDqLSUXfCF0Ez5YGxzZR6m1NBTYog/haNBMzDJZfxHfmASqF5Hdr3sYRrbUpbno8Jca6fZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179069; c=relaxed/simple;
	bh=+YEVZxygZgxmNHunDCzdusGVKgDqV9hCNMC2sOEK7lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fPT6cKlvj1T1PkSvNaIGlgUgSGHqEpqPkdkihnEGlKDCHoD/njke5Iy3GSHf2CFTOkZnVabVbaEzSHOQVeW3zo7Cg9mYUK4q/bvAsyds6PC0iN8l4inOWKRC86ImZ1ZBF+U6ECIk5lsppc8NwLVNqLS442r+nQUWLTzkAqaRChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V4m2OYo3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K7PCYHg6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V4m2OYo3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K7PCYHg6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9358219CD;
	Mon,  3 Nov 2025 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762179065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nrz2ITbLZdpVOLmGCyaWsChGpB/Z49FUPAiNxCRis/o=;
	b=V4m2OYo3YtjwqMR5HfT02lbhM3S2O8BHRCapOAkeDdacEi39Cn7oIr+VCjSnpWLBut5a3J
	w+y4wsyqeN1UAY69OjQHUh2YAXV7EWRRz5Tn6cdTQDrY2BrPzefJqdW35vFw8J2jX9CGaN
	HiuohOAURM5y5wer+i1113dCjvSOwjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762179065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nrz2ITbLZdpVOLmGCyaWsChGpB/Z49FUPAiNxCRis/o=;
	b=K7PCYHg6sWbBprdyKC4wNQZApQQOMfPJ3hSR3Ej3KerzkPvQofVVvR1sUs/bgvDmTwQ9ds
	h3KRqZ1RCT6l4QDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V4m2OYo3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K7PCYHg6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762179065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nrz2ITbLZdpVOLmGCyaWsChGpB/Z49FUPAiNxCRis/o=;
	b=V4m2OYo3YtjwqMR5HfT02lbhM3S2O8BHRCapOAkeDdacEi39Cn7oIr+VCjSnpWLBut5a3J
	w+y4wsyqeN1UAY69OjQHUh2YAXV7EWRRz5Tn6cdTQDrY2BrPzefJqdW35vFw8J2jX9CGaN
	HiuohOAURM5y5wer+i1113dCjvSOwjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762179065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nrz2ITbLZdpVOLmGCyaWsChGpB/Z49FUPAiNxCRis/o=;
	b=K7PCYHg6sWbBprdyKC4wNQZApQQOMfPJ3hSR3Ej3KerzkPvQofVVvR1sUs/bgvDmTwQ9ds
	h3KRqZ1RCT6l4QDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A83D61364F;
	Mon,  3 Nov 2025 14:11:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yjygKPm3CGkBSwAAD6G6ig
	(envelope-from <fvogt@suse.de>); Mon, 03 Nov 2025 14:11:05 +0000
From: Fabian Vogt <fvogt@suse.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, Gabriel Somlo <somlo@cmu.edu>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.de>
Subject:
 [PATCH v2] firmware: qemu_fw_cfg: Do not hard depend on CONFIG_HAS_IOPORT_MAP
Date: Mon, 03 Nov 2025 15:11:05 +0100
Message-ID: <24142953.6Emhk5qWAg@fvogt-thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B9358219CD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
X-Spam-Score: -3.51

Some configs have CONFIG_NO_IOPORT_MAP=y but support qemu_fw_cfg over
MMIO. Currently the qemu_fw_cfg module can't be built for those as it
needs HAS_IOPORT_MAP=y for ioport remapping.

This patch allows to build qemu_fw_cfg in those cases. If
CONFIG_HAS_IOPORT_MAP=n, qemu_fw_cfg is just built without support for
ioport based access.

Signed-off-by: Fabian Vogt <fvogt@suse.de>
---
v2: Guard ioport_unmap as well, which makes it work on archs like arm64
in the !PCI case. Unlike arm, arm64 has no stub for ioport_unmap.
Reword description.

 drivers/firmware/Kconfig       | 1 -
 drivers/firmware/qemu_fw_cfg.c | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bbd2155d8483..91442f85f0f0 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -122,7 +122,6 @@ config RASPBERRYPI_FIRMWARE
 config FW_CFG_SYSFS
 	tristate "QEMU fw_cfg device support in sysfs"
 	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV || SPARC || X86)
-	depends on HAS_IOPORT_MAP
 	default n
 	help
 	  Say Y or M here to enable the exporting of the QEMU firmware
diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 0eebd572f9a5..fa4385339824 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -204,8 +204,10 @@ static void fw_cfg_io_cleanup(void)
 		iounmap(fw_cfg_dev_base);
 		release_mem_region(fw_cfg_p_base, fw_cfg_p_size);
 	} else {
+#ifdef CONFIG_HAS_IOPORT_MAP
 		ioport_unmap(fw_cfg_dev_base);
 		release_region(fw_cfg_p_base, fw_cfg_p_size);
+#endif
 	}
 }
 
@@ -258,6 +260,7 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 			return -EFAULT;
 		}
 	} else {
+#ifdef CONFIG_HAS_IOPORT_MAP
 		if (!request_region(fw_cfg_p_base,
 				    fw_cfg_p_size, "fw_cfg_io"))
 			return -EBUSY;
@@ -266,6 +269,10 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 			release_region(fw_cfg_p_base, fw_cfg_p_size);
 			return -EFAULT;
 		}
+#else
+		dev_err(&pdev->dev, "IO region given but CONFIG_HAS_IOPORT_MAP=n");
+		return -EINVAL;
+#endif
 	}
 
 	/* were custom register offsets provided (e.g. on the command line)? */
-- 
2.51.1



