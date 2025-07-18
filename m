Return-Path: <linux-kernel+bounces-737215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CEAB0A94F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAAE1C24E63
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB752E716D;
	Fri, 18 Jul 2025 17:21:47 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530C281372
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859306; cv=none; b=BcgDVn8mAN594qEjCBF435MpKpWJHZgKhyaMLAcS6kBY5JquaZPwFCO14H1bAsQ06zp3ZbIajCtYQicbfY2hg0K4d7DxZEDbO4I23XhWgDg41a5pN2oj/SbWCJ98ssEAEUcpJ6/r61tDR05RWrnVnT7+3Jq//2beJD5Ib4zW13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859306; c=relaxed/simple;
	bh=8W5qY0qy3BJhXLjLt7ux3ejf795Tjb7rz3Pu9zxNlEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K80c/XRQfcAIj6D+8MozZmeoJeE3OwuZPBqBy7Su1l8/v76CyawxhqP21vIhnr6D0nzFkrdYUxkD8XaUbnVEHQGjLjcxNgx5j1W6xucu7MMe09FiBt338FCU/jR51SssEDYZOhcAPieXCKPJZ1U0qnvzoJXv5E9jqab6zwnlC7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6ABDA1F789;
	Fri, 18 Jul 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCE7A138D2;
	Fri, 18 Jul 2025 17:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AKqCMqaCemizYQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 18 Jul 2025 17:21:42 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH 2/2] testing/radix-tree/maple: Hack around kfree_rcu not existing
Date: Fri, 18 Jul 2025 18:21:37 +0100
Message-ID: <20250718172138.103116-2-pfalcato@suse.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250718172138.103116-1-pfalcato@suse.de>
References: <20250718172138.103116-1-pfalcato@suse.de>
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
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6ABDA1F789
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

liburcu doesn't have kfree_rcu (or anything similar). Despite that, we
can hack around it in a trivial fashion, by adding a wrapper.

This wrapper only works for maple_nodes, and not anything else (due to
us not being able to know rcu_head offsets in any way), and thus we take
advantage of the type checking to avoid future silent breakage.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 tools/testing/radix-tree/maple.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 172700fb7784..bfdc93c36cf9 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -23,6 +23,23 @@
 #define MODULE_LICENSE(x)
 #define dump_stack()	assert(0)
 
+
+#include <linux/maple_tree.h>
+
+static void free_node(struct rcu_head *head)
+{
+	struct maple_node *node = container_of(head, struct maple_node, rcu);
+
+	free(node);
+}
+
+static void kfree_rcu_node(struct maple_node *node)
+{
+	call_rcu(&node->rcu, free_node);
+}
+
+#define kfree_rcu(ptr, memb) kfree_rcu_node(ptr)
+
 #include "../../../lib/maple_tree.c"
 #include "../../../lib/test_maple_tree.c"
 
-- 
2.50.1


