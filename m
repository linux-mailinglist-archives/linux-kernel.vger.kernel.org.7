Return-Path: <linux-kernel+bounces-856306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 922B7BE3CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1FEB50251B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ED333CE89;
	Thu, 16 Oct 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wixXXyK3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xAe0d+B4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wixXXyK3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xAe0d+B4"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1DC2E6135
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622646; cv=none; b=T+qDD5IQ7nOTPC8Wcmvm47rPXOkRBckzFF0v2ERl/6FSKRfwrrllDEdNcmtSCtY0cWi4EmaFlQbyiM8Z/BbM6WxWLdDu6EAGdkb7CXOf6HotqFN1fSzk1cBylMh4sp4KtDD8VrpTSWSrfG7lB6a76IHkbFecDH8SvJNdSYHS2Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622646; c=relaxed/simple;
	bh=XAsMQFLE0fTyNMl1Z1Qzl60x+Ga0C1c6zzhPuExBNvE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=py10VwTH4a+KXyJI+o7kUSRo51v5HPLv5+aRzcJgauVmW/yOH6UnMf5I10Y2x17AC85Plc0q7Xm4dYlIJ4X0Il3mqHXxFYd0ZrUnPuew9ueacbbplxqanHQ1wF7jYccDOLblJ8B9ouoDO7spmLTdvV7uDbhLhNaeAGPgeQUUJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wixXXyK3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xAe0d+B4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wixXXyK3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xAe0d+B4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E014C1F86B;
	Thu, 16 Oct 2025 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760622642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=icHXQs680W+jzQEGnLveCSGPU7Byawy8szTj+S6HcR8=;
	b=wixXXyK33pnK2yqHg+17/jR1H5iVozs7B4nFlt40aL+GeQhlphpRPjTdiWk1VeQ2l25jId
	at6ylPFmEGrZ1jlzwiE7GMc019iIDXQCUZJhW9vn0zMEOKBCHDY4GeH67MtSALfXt6fGXd
	o8J0OKnFYE62EdzUsyW8w07XD+KGzKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760622642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=icHXQs680W+jzQEGnLveCSGPU7Byawy8szTj+S6HcR8=;
	b=xAe0d+B4lN7jmsK6eGrmb/Yw5fb8GXftnsXriBbg3QBGeJ3vC6f9jE1ELwjitOulw3gLtI
	tO/dwEug8qN6gwCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wixXXyK3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xAe0d+B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760622642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=icHXQs680W+jzQEGnLveCSGPU7Byawy8szTj+S6HcR8=;
	b=wixXXyK33pnK2yqHg+17/jR1H5iVozs7B4nFlt40aL+GeQhlphpRPjTdiWk1VeQ2l25jId
	at6ylPFmEGrZ1jlzwiE7GMc019iIDXQCUZJhW9vn0zMEOKBCHDY4GeH67MtSALfXt6fGXd
	o8J0OKnFYE62EdzUsyW8w07XD+KGzKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760622642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=icHXQs680W+jzQEGnLveCSGPU7Byawy8szTj+S6HcR8=;
	b=xAe0d+B4lN7jmsK6eGrmb/Yw5fb8GXftnsXriBbg3QBGeJ3vC6f9jE1ELwjitOulw3gLtI
	tO/dwEug8qN6gwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3C301340C;
	Thu, 16 Oct 2025 13:50:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JtcVJjL48GgZWwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 16 Oct 2025 13:50:42 +0000
Date: Thu, 16 Oct 2025 15:50:40 +0200
From: Jean Delvare <jdelvare@suse.de>
To: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Naveen Krishna Chatradhi
 <naveenkrishna.chatradhi@amd.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] misc: amd-sbi: Clarify that this is a BMC driver
Message-ID: <20251016155040.0e86c102@endymion>
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
X-Rspamd-Queue-Id: E014C1F86B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

Add a sentence to the driver description to clarify that the sbrmi-i2c
driver is intended to run on the BMC and not on the managed node. Add
platform dependencies accordingly.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Link: https://lore.kernel.org/r/5c9f7100-0e59-4237-a252-43c3ee4802a2@amd.com
---
Changes in v2:
 * Rebase on top of kernel v6.16.12.

 drivers/misc/amd-sbi/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- linux-6.16.orig/drivers/misc/amd-sbi/Kconfig
+++ linux-6.16/drivers/misc/amd-sbi/Kconfig
@@ -2,9 +2,11 @@
 config AMD_SBRMI_I2C
 	tristate "AMD side band RMI support"
 	depends on I2C
+	depends on ARM || ARM64 || COMPILE_TEST
 	select REGMAP_I2C
 	help
 	  Side band RMI over I2C support for AMD out of band management.
+	  This driver is intended to run on the BMC, not the managed node.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called sbrmi-i2c.


-- 
Jean Delvare
SUSE L3 Support

