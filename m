Return-Path: <linux-kernel+bounces-770397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC4DB27A49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C803B08F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352CE22A4F4;
	Fri, 15 Aug 2025 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YPDOcRAq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YPDOcRAq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA242253E9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243660; cv=none; b=Y2yGz9AFZonypX9ij+J1WvDAF8LpidM73aqHbsmysqH9FP7/tUI8Q71JJ+BlEHvJio26FMWeDUc2FNsE+Etg1ai3hcGdKpSPKG17tI+BVeH7dXufvBdPV+hrMUUjHDkwgvvjf+xpp8/QbiRnKwivsylmt5xacFsrC21pSmoDHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243660; c=relaxed/simple;
	bh=T0K0SUC2ViLOQ/1YnV/9UMLt+zepT9xejrrXcsB8MGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1gbA/dGipwJ0rL24pn8g2y6EBi+gyofRUCJvc3mKBzBMlFgePfjUmLCMswYmNQ3hqtAYQaXeZRx8omJM8mA/sAVCgOEoEE/qFhor2aYszL1aGBWatcGjXdSmTXDWnrVoDeO3OnjqplckCbWHBbnQX2Zhh+E4IUkEyr1EDI3FeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YPDOcRAq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YPDOcRAq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 699EA1F840;
	Fri, 15 Aug 2025 07:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755243655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VlazP9btikB8NJpiu0YBPgFKLXh5P4NJfwM/KmYNni0=;
	b=YPDOcRAqIO/Irub2iFSLUb3I8osWAfM7JgI2sbx4rlr8mjKsI2u8MLbMf+Aox4gqjOHEb8
	PBi9wdjlu7shKPe0CTcCg7W/f2MSmcCwwbQtkUQsZeAxz1KWHvIl7u5zRGpx/hAygq1jhl
	BIUGJFvQONNka5x0nSTifBbtYxf4QSU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YPDOcRAq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755243655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VlazP9btikB8NJpiu0YBPgFKLXh5P4NJfwM/KmYNni0=;
	b=YPDOcRAqIO/Irub2iFSLUb3I8osWAfM7JgI2sbx4rlr8mjKsI2u8MLbMf+Aox4gqjOHEb8
	PBi9wdjlu7shKPe0CTcCg7W/f2MSmcCwwbQtkUQsZeAxz1KWHvIl7u5zRGpx/hAygq1jhl
	BIUGJFvQONNka5x0nSTifBbtYxf4QSU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3090B13876;
	Fri, 15 Aug 2025 07:40:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g7mKCYfknmiiDAAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 15 Aug 2025 07:40:55 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH] drivers/xen/xenbus: remove quirk for Xen 3.x
Date: Fri, 15 Aug 2025 09:40:52 +0200
Message-ID: <20250815074052.13792-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 699EA1F840
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

The kernel is not supported to run as a Xen guest on Xen versions
older than 4.0.

Remove xen_strict_xenbus_quirk() which is testing the Xen version to be
at least 4.0.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xenbus/xenbus_xs.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 3c9da446b85d..528682bf0c7f 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -718,26 +718,6 @@ int xs_watch_msg(struct xs_watch_event *event)
 	return 0;
 }
 
-/*
- * Certain older XenBus toolstack cannot handle reading values that are
- * not populated. Some Xen 3.4 installation are incapable of doing this
- * so if we are running on anything older than 4 do not attempt to read
- * control/platform-feature-xs_reset_watches.
- */
-static bool xen_strict_xenbus_quirk(void)
-{
-#ifdef CONFIG_X86
-	uint32_t eax, ebx, ecx, edx, base;
-
-	base = xen_cpuid_base();
-	cpuid(base + 1, &eax, &ebx, &ecx, &edx);
-
-	if ((eax >> 16) < 4)
-		return true;
-#endif
-	return false;
-
-}
 static void xs_reset_watches(void)
 {
 	int err;
@@ -745,9 +725,6 @@ static void xs_reset_watches(void)
 	if (!xen_hvm_domain() || xen_initial_domain())
 		return;
 
-	if (xen_strict_xenbus_quirk())
-		return;
-
 	if (!xenbus_read_unsigned("control",
 				  "platform-feature-xs_reset_watches", 0))
 		return;
-- 
2.43.0


