Return-Path: <linux-kernel+bounces-816920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ED4B57AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A393A1884D03
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0823074B1;
	Mon, 15 Sep 2025 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ThRu1bzQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dbh2BhxZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="guzOSLqq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PrMZiaxx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6B2FB962
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939040; cv=none; b=UUEYIA+TLtOu26XssJB4Szqnp8KG81IL+wYhuvsjaj2YrAbwgAWKEvC1GzpWdSaaksSvSXWNp083lw8gG2/AQOyrcWIYCD/a4eYai396QQxSReasSPlxG1N8faYOh9TYU/RCcAYaVOoeo17TEKi/xHryulTM6813WVSAPcv3qT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939040; c=relaxed/simple;
	bh=frDJVEJiNHxFXsWu5GTXLFKeqg2/y+WyGJH+MVu1Mhw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IExkv3JeGMJRNzuq3YVMxDKPTHli7KCxoGcC2Cnu8TGy6Xu0wyasWDuQhZHNflsQd7Z0UqKD1UW0BI0LlMRE5JGdoBMNaTxQw3gZoXQIC8HKFNRgcelckQQZx3Ri3ICbU+l9VawEKVxuNbjcjbkegX8d5zq2GFRQzA3vXBazlfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ThRu1bzQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dbh2BhxZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=guzOSLqq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PrMZiaxx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC3A81F8D6;
	Mon, 15 Sep 2025 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757939036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8nr8yKmTfTQBJ9M+fCCz0sg+2OU4Znt5fCB6eWP19oA=;
	b=ThRu1bzQweGZWKNGtKDRPFimGML4CVIyr1nza0WGM1UmlecmdXkDBxKEzIBq342NhDkIAL
	ohiDLFDqfpgxQVEw7+MW2nioFSc/HiF1B2L22gSpp2kDwBr6jZMKx+yPmwjzIgCw7LFaL5
	yRk+ITNKi32FkkccBdqoAfDcnI16HvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757939036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8nr8yKmTfTQBJ9M+fCCz0sg+2OU4Znt5fCB6eWP19oA=;
	b=dbh2BhxZsQi1K4xbiMwZFcs5blMhSfbZUCanLw9S5Ui1df+r8FoGBhON+4lxY0+MW1zrZU
	tyYPLEyePZFR0GDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757939035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8nr8yKmTfTQBJ9M+fCCz0sg+2OU4Znt5fCB6eWP19oA=;
	b=guzOSLqq8+eb5qC65gMtbpbynG63XO66qd4jIsMqm7nl58YTVH3/9bJv1YtQLullBVvxEj
	a+RB662UIeoXdOzRz+dGHxMSOZ8nRKcwzijhg8s+cTV1fN/4qLh9sp/0dgKKZy6Jfd5nmY
	wVxRiT976n69Ef9Lm+XVuoFQ4MII1uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757939035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8nr8yKmTfTQBJ9M+fCCz0sg+2OU4Znt5fCB6eWP19oA=;
	b=PrMZiaxxHJHgfCzmQPX66zN90J2ExvoBGkVt09gYk4jaeW1CtnKZxQYMT2LJb7qEMEz/gU
	ZJT8F08ygUXiN4CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD5211368D;
	Mon, 15 Sep 2025 12:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8qZFKFsFyGg5OAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 15 Sep 2025 12:23:55 +0000
Date: Mon, 15 Sep 2025 14:23:54 +0200
From: Jean Delvare <jdelvare@suse.de>
To: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Naveen Krishna Chatradhi
 <naveenkrishna.chatradhi@amd.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: amd-sbi: Clarify that this is a BMC driver
Message-ID: <20250915142354.1643780a@endymion>
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
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

Add a sentence to the driver description to clarify that the sbrmi-i2c
driver is intended to run on the BMC and not on the managed node. Add
platform dependencies accordingly.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Link: https://lore.kernel.org/r/5c9f7100-0e59-4237-a252-43c3ee4802a2@amd.com
---
 drivers/misc/amd-sbi/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- linux-6.16.orig/drivers/misc/amd-sbi/Kconfig
+++ linux-6.16/drivers/misc/amd-sbi/Kconfig
@@ -2,8 +2,10 @@
 config AMD_SBRMI_I2C
 	tristate "AMD side band RMI support"
 	depends on I2C
+	depends on ARM || ARM64 || COMPILE_TEST
 	help
 	  Side band RMI over I2C support for AMD out of band management.
+	  This driver is intended to run on the BMC, not the managed node.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called sbrmi-i2c.


-- 
Jean Delvare
SUSE L3 Support

