Return-Path: <linux-kernel+bounces-765239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 264ADB22D70
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B888616DD61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79D2F8BCE;
	Tue, 12 Aug 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gpPVVMLP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9WvZBY+0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gpPVVMLP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9WvZBY+0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123D52F7461
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015695; cv=none; b=jOGPbd7HJywJFIWstY1Td/YE+6OmDdM0k3QQ1+yVeI18HUFqdwFLPeFOZaRB2FDlTFrsx/cNmZDZmjdthVMpN/kNj1+WHg2pAM0h7APU22A9vaqFqjEAX08LaNjLaPRaT+juafLjU0ydVEfhbXr9uxvgh5ANvbOCMJ0eyudgMYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015695; c=relaxed/simple;
	bh=9YoOWIoYOmNGFsg7OSNu6IU/2A5eJLalRw/wv4MnVOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJ0MQ6xXjJLZyQJboI0R52yaGemle4671dCciSrP+xfKbWhGSdcbF0XcNZ3igkN7LRFyhSDnTJuBzZnpVLnNA7Gx/p54o9m4GwFcy1IX2qmVTxpVcSaf0z5RC9xgdwvQoo9bv7+n9lrvl/Yri/ol/EY5a30IqEQEfNPTWpfSMbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gpPVVMLP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9WvZBY+0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gpPVVMLP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9WvZBY+0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E62A1F390;
	Tue, 12 Aug 2025 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755015691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lf4UXJNFktuHhLrkAqGviaiOGJGDRn0u7MGzFHCiLBI=;
	b=gpPVVMLPhDFut0H+ebndSd81pOCSzFedUQF3wAy8DW3FBq8NbhZe0Yiz1ot72foS7v/cf7
	mt7eOUV/IV4bn2zx3HT82cpnnmlyiw5cPjWWGS+EufwfXFecXvjiP3ngBO8c3l4ptHEXpr
	xEe/Wc/vWyqI4Z2GO8K/+xycIxJCb6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755015691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lf4UXJNFktuHhLrkAqGviaiOGJGDRn0u7MGzFHCiLBI=;
	b=9WvZBY+0egmTrc77DcmH/Z9uHpoX1aX7wT4n9HJws1/sOTpuX8E6sEpa2tgyRPbqdNjuIg
	rdC0Z8lAc8E163Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gpPVVMLP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9WvZBY+0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755015691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lf4UXJNFktuHhLrkAqGviaiOGJGDRn0u7MGzFHCiLBI=;
	b=gpPVVMLPhDFut0H+ebndSd81pOCSzFedUQF3wAy8DW3FBq8NbhZe0Yiz1ot72foS7v/cf7
	mt7eOUV/IV4bn2zx3HT82cpnnmlyiw5cPjWWGS+EufwfXFecXvjiP3ngBO8c3l4ptHEXpr
	xEe/Wc/vWyqI4Z2GO8K/+xycIxJCb6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755015691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lf4UXJNFktuHhLrkAqGviaiOGJGDRn0u7MGzFHCiLBI=;
	b=9WvZBY+0egmTrc77DcmH/Z9uHpoX1aX7wT4n9HJws1/sOTpuX8E6sEpa2tgyRPbqdNjuIg
	rdC0Z8lAc8E163Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 889E21351A;
	Tue, 12 Aug 2025 16:21:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z5MsHgpqm2iCbgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 12 Aug 2025 16:21:30 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH v2 1/3] testing/radix-tree/maple: Hack around kfree_rcu not existing
Date: Tue, 12 Aug 2025 17:21:22 +0100
Message-ID: <20250812162124.59417-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1E62A1F390
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Spam-Score: -3.01

liburcu doesn't have kfree_rcu (or anything similar). Despite that, we
can hack around it in a trivial fashion, by adding a wrapper.

This wrapper only works for maple_nodes, and not anything else (due to
us not being able to know rcu_head offsets in any way), and thus we take
advantage of the type checking to avoid future silent breakage.

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
v2:
 - Move kfree_rcu hack to maple-shared.h, to fix userland VMA tests, per
   Lorenzo

 tools/testing/shared/maple-shared.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
index dc4d30f3860b..572cd2580123 100644
--- a/tools/testing/shared/maple-shared.h
+++ b/tools/testing/shared/maple-shared.h
@@ -9,5 +9,20 @@
 #include <stdlib.h>
 #include <time.h>
 #include "linux/init.h"
+#include <linux/maple_tree.h>
+
+static inline void free_node(struct rcu_head *head)
+{
+	struct maple_node *node = container_of(head, struct maple_node, rcu);
+
+	free(node);
+}
+
+static inline void kfree_rcu_node(struct maple_node *node)
+{
+	call_rcu(&node->rcu, free_node);
+}
+
+#define kfree_rcu(ptr, memb) kfree_rcu_node(ptr)
 
 #endif /* __MAPLE_SHARED_H__ */
-- 
2.50.1


