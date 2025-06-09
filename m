Return-Path: <linux-kernel+bounces-677426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441B8AD1A72
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 11:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF833AB6B5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 09:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04402512E6;
	Mon,  9 Jun 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iuZ5blFO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b0Nn0ifN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iuZ5blFO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b0Nn0ifN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500A92522A7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749460946; cv=none; b=nnPWIzm78AoGyvXeFJxJ1F81CPynkw8kTGRWpIkxQzd9HyRHoVcj1YD5BDID/l/6d5ELrtgdjerzILOoizSVfD0/PjwUasb3LgnFj59LZy9APXLeXZOL0Qo27NZb8/DGEmnbhFln8XHkUFbpdAjBE7lBt2OJ+WhblWcKc+59VkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749460946; c=relaxed/simple;
	bh=Y5CCXn0yH9xQsKMcSabpadDUYGZVEg4hlsmpApc6AEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk4UfNZt+4IYl7agGc0lfblrQS25UH9h1iLB5Crk5JRfeFeBfPwLKRa7D4Cc95+ssIKWjCCoWgUJDCKc2L757WPbd8raDtZ3AjYAZc2D5zTnKfhuabs30z4OW7OTnLbTguJu5PfnlAF50/3KojB0mOAVXwB49zq9jiweSAkVcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iuZ5blFO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b0Nn0ifN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iuZ5blFO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b0Nn0ifN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A32FB211A6;
	Mon,  9 Jun 2025 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749460922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWXDq3Hw68Rmcv8TD0ZwYxd1S9tRIPh7GzBpxSevUo0=;
	b=iuZ5blFO5gvNGhdIpjvm0iU4w3Wo2a88eg4Ql+XA5PiHdsyBZQJrKqr0OK/V9BBxz4xMSA
	BOBbhoI380bytTR4dHuylCV7IrBpednqfDd/AQ0iVcnxw4M9Z2B1BZvADoTEbw3R6PrsJz
	X4PHiUkK7XHWc+N1CjXHQ1gCcKDnW0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749460922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWXDq3Hw68Rmcv8TD0ZwYxd1S9tRIPh7GzBpxSevUo0=;
	b=b0Nn0ifNCIEamv+7diePdsryToYOBaPLzEOQ/9Ey2hWcYJWYZSNo/bDe97xVNTJquSwoQ7
	5yVmsC4/yz/4dqAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749460922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWXDq3Hw68Rmcv8TD0ZwYxd1S9tRIPh7GzBpxSevUo0=;
	b=iuZ5blFO5gvNGhdIpjvm0iU4w3Wo2a88eg4Ql+XA5PiHdsyBZQJrKqr0OK/V9BBxz4xMSA
	BOBbhoI380bytTR4dHuylCV7IrBpednqfDd/AQ0iVcnxw4M9Z2B1BZvADoTEbw3R6PrsJz
	X4PHiUkK7XHWc+N1CjXHQ1gCcKDnW0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749460922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWXDq3Hw68Rmcv8TD0ZwYxd1S9tRIPh7GzBpxSevUo0=;
	b=b0Nn0ifNCIEamv+7diePdsryToYOBaPLzEOQ/9Ey2hWcYJWYZSNo/bDe97xVNTJquSwoQ7
	5yVmsC4/yz/4dqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2CC613A85;
	Mon,  9 Jun 2025 09:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4A9BOLmnRmjJGAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 09 Jun 2025 09:22:01 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v6 03/10] mm,memory_hotplug: Implement numa node notifier
Date: Mon,  9 Jun 2025 11:21:40 +0200
Message-ID: <20250609092149.312114-4-osalvador@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609092149.312114-1-osalvador@suse.de>
References: <20250609092149.312114-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.de:mid,suse.de:email];
	FREEMAIL_CC(0.00)[redhat.com,suse.cz,huawei.com,oracle.com,sk.com,gmail.com,kvack.org,vger.kernel.org,suse.de];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 

There are at least six consumers of hotplug_memory_notifier that what they
really are interested in is whether any numa node changed its state, e.g: going
from having memory to not having memory and vice versa.

Implement a specific notifier for numa nodes when their state gets changed,
which will later be used by those consumers that are only interested
in numa node state changes.

Add documentation as well.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 Documentation/core-api/memory-hotplug.rst |  66 +++++++++
 drivers/base/node.c                       |  21 +++
 include/linux/node.h                      |  40 ++++++
 mm/memory_hotplug.c                       | 155 ++++++++++------------
 4 files changed, 200 insertions(+), 82 deletions(-)

diff --git a/Documentation/core-api/memory-hotplug.rst b/Documentation/core-api/memory-hotplug.rst
index d1b8eb9add8a..b19c3be7437d 100644
--- a/Documentation/core-api/memory-hotplug.rst
+++ b/Documentation/core-api/memory-hotplug.rst
@@ -9,6 +9,9 @@ Memory hotplug event notifier
 
 Hotplugging events are sent to a notification queue.
 
+Memory notifier
+----------------
+
 There are six types of notification defined in ``include/linux/memory.h``:
 
 MEM_GOING_ONLINE
@@ -80,6 +83,69 @@ further processing of the notification queue.
 
 NOTIFY_STOP stops further processing of the notification queue.
 
+Numa node notifier
+------------------
+
+There are six types of notification defined in ``include/linux/node.h``:
+
+NODE_ADDING_FIRST_MEMORY
+ Generated before memory becomes available to this node for the first time.
+
+NODE_CANCEL_ADDING_FIRST_MEMORY
+ Generated if NODE_ADDING_FIRST_MEMORY fails.
+
+NODE_ADDED_FIRST_MEMORY
+ Generated when memory has become available fo this node for the first time.
+
+NODE_REMOVING_LAST_MEMORY
+ Generated when the last memory available to this node is about to be offlined.
+
+NODE_CANCEL_REMOVING_LAST_MEMORY
+ Generated when NODE_CANCEL_REMOVING_LAST_MEMORY fails.
+
+NODE_REMOVED_LAST_MEMORY
+ Generated when the last memory available to this node has been offlined.
+
+A callback routine can be registered by calling::
+
+  hotplug_node_notifier(callback_func, priority)
+
+Callback functions with higher values of priority are called before callback
+functions with lower values.
+
+A callback function must have the following prototype::
+
+  int callback_func(
+
+    struct notifier_block *self, unsigned long action, void *arg);
+
+The first argument of the callback function (self) is a pointer to the block
+of the notifier chain that points to the callback function itself.
+The second argument (action) is one of the event types described above.
+The third argument (arg) passes a pointer of struct node_notify::
+
+        struct node_notify {
+                int nid;
+        }
+
+- nid is the node we are adding or removing memory to.
+
+  If nid >= 0, callback should create/discard structures for the
+  node if necessary.
+
+The callback routine shall return one of the values
+NOTIFY_DONE, NOTIFY_OK, NOTIFY_BAD, NOTIFY_STOP
+defined in ``include/linux/notifier.h``
+
+NOTIFY_DONE and NOTIFY_OK have no effect on the further processing.
+
+NOTIFY_BAD is used as response to the NODE_ADDING_FIRST_MEMORY,
+NODE_REMOVING_LAST_MEMORY, NODE_ADDED_FIRST_MEMORY or
+NODE_REMOVED_LAST_MEMORY action to cancel hotplugging.
+It stops further processing of the notification queue.
+
+NOTIFY_STOP stops further processing of the notification queue.
+
 Locking Internals
 =================
 
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 25ab9ec14eb8..c5b0859d846d 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -111,6 +111,27 @@ static const struct attribute_group *node_access_node_groups[] = {
 	NULL,
 };
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+static BLOCKING_NOTIFIER_HEAD(node_chain);
+
+int register_node_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&node_chain, nb);
+}
+EXPORT_SYMBOL(register_node_notifier);
+
+void unregister_node_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&node_chain, nb);
+}
+EXPORT_SYMBOL(unregister_node_notifier);
+
+int node_notify(unsigned long val, void *v)
+{
+	return blocking_notifier_call_chain(&node_chain, val, v);
+}
+#endif
+
 static void node_remove_accesses(struct node *node)
 {
 	struct node_access_nodes *c, *cnext;
diff --git a/include/linux/node.h b/include/linux/node.h
index 2b7517892230..d7aa2636d948 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -123,6 +123,46 @@ static inline void register_memory_blocks_under_node(int nid, unsigned long star
 #endif
 
 extern void unregister_node(struct node *node);
+
+struct node_notify {
+	int nid;
+};
+
+#define NODE_ADDING_FIRST_MEMORY                (1<<0)
+#define NODE_ADDED_FIRST_MEMORY                 (1<<1)
+#define NODE_CANCEL_ADDING_FIRST_MEMORY         (1<<2)
+#define NODE_REMOVING_LAST_MEMORY               (1<<3)
+#define NODE_REMOVED_LAST_MEMORY                (1<<4)
+#define NODE_CANCEL_REMOVING_LAST_MEMORY        (1<<5)
+
+#if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_NUMA)
+extern int register_node_notifier(struct notifier_block *nb);
+extern void unregister_node_notifier(struct notifier_block *nb);
+extern int node_notify(unsigned long val, void *v);
+
+#define hotplug_node_notifier(fn, pri) ({		\
+	static __meminitdata struct notifier_block fn##_node_nb =\
+		{ .notifier_call = fn, .priority = pri };\
+	register_node_notifier(&fn##_node_nb);			\
+})
+#else
+static inline int register_node_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+static inline void unregister_node_notifier(struct notifier_block *nb)
+{
+}
+static inline int node_notify(unsigned long val, void *v)
+{
+	return 0;
+}
+static inline int hotplug_node_notifier(notifier_fn_t fn, int pri)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_NUMA
 extern void node_dev_init(void);
 /* Core of the node registration - only memory hotplug should use this */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 94ae0ca37021..0550f3061fc4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -35,6 +35,7 @@
 #include <linux/compaction.h>
 #include <linux/rmap.h>
 #include <linux/module.h>
+#include <linux/node.h>
 
 #include <asm/tlbflush.h>
 
@@ -699,24 +700,6 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 	online_mem_sections(start_pfn, end_pfn);
 }
 
-/* check which state of node_states will be changed when online memory */
-static void node_states_check_changes_online(unsigned long nr_pages,
-	struct zone *zone, struct memory_notify *arg)
-{
-	int nid = zone_to_nid(zone);
-
-	arg->status_change_nid = NUMA_NO_NODE;
-
-	if (!node_state(nid, N_MEMORY))
-		arg->status_change_nid = nid;
-}
-
-static void node_states_set_node(int node, struct memory_notify *arg)
-{
-	if (arg->status_change_nid >= 0)
-		node_set_state(node, N_MEMORY);
-}
-
 static void __meminit resize_zone_range(struct zone *zone, unsigned long start_pfn,
 		unsigned long nr_pages)
 {
@@ -1171,7 +1154,9 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	int need_zonelists_rebuild = 0;
 	const int nid = zone_to_nid(zone);
 	int ret;
-	struct memory_notify arg;
+	struct memory_notify mem_arg;
+	struct node_notify node_arg;
+	bool cancel_mem_notifier_on_err = false, cancel_node_notifier_on_err = false;
 
 	/*
 	 * {on,off}lining is constrained to full memory sections (or more
@@ -1188,11 +1173,22 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	/* associate pfn range with the zone */
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
 
-	arg.start_pfn = pfn;
-	arg.nr_pages = nr_pages;
-	node_states_check_changes_online(nr_pages, zone, &arg);
+	node_arg.nid = NUMA_NO_NODE;
+	if (!node_state(nid, N_MEMORY)) {
+		/* Adding memory to the node for the first time */
+		cancel_node_notifier_on_err = true;
+		node_arg.nid = nid;
+		ret = node_notify(NODE_ADDING_FIRST_MEMORY, &node_arg);
+		ret = notifier_to_errno(ret);
+		if (ret)
+			goto failed_addition;
+	}
 
-	ret = memory_notify(MEM_GOING_ONLINE, &arg);
+	mem_arg.start_pfn = pfn;
+	mem_arg.nr_pages = nr_pages;
+	mem_arg.status_change_nid = node_arg.nid;
+	cancel_mem_notifier_on_err = true;
+	ret = memory_notify(MEM_GOING_ONLINE, &mem_arg);
 	ret = notifier_to_errno(ret);
 	if (ret)
 		goto failed_addition;
@@ -1218,7 +1214,8 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	online_pages_range(pfn, nr_pages);
 	adjust_present_page_count(pfn_to_page(pfn), group, nr_pages);
 
-	node_states_set_node(nid, &arg);
+	if (node_arg.nid >= 0)
+		node_set_state(nid, N_MEMORY);
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
 
@@ -1239,16 +1236,23 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	kswapd_run(nid);
 	kcompactd_run(nid);
 
+	if (node_arg.nid >= 0)
+		/* First memory added successfully. Notify consumers. */
+		node_notify(NODE_ADDED_FIRST_MEMORY, &node_arg);
+
 	writeback_set_ratelimit();
 
-	memory_notify(MEM_ONLINE, &arg);
+	memory_notify(MEM_ONLINE, &mem_arg);
 	return 0;
 
 failed_addition:
 	pr_debug("online_pages [mem %#010llx-%#010llx] failed\n",
 		 (unsigned long long) pfn << PAGE_SHIFT,
 		 (((unsigned long long) pfn + nr_pages) << PAGE_SHIFT) - 1);
-	memory_notify(MEM_CANCEL_ONLINE, &arg);
+	if (cancel_mem_notifier_on_err)
+		memory_notify(MEM_CANCEL_ONLINE, &mem_arg);
+	if (cancel_node_notifier_on_err)
+		node_notify(NODE_CANCEL_ADDING_FIRST_MEMORY, &node_arg);
 	remove_pfn_range_from_zone(zone, pfn, nr_pages);
 	return ret;
 }
@@ -1880,48 +1884,6 @@ static int __init cmdline_parse_movable_node(char *p)
 }
 early_param("movable_node", cmdline_parse_movable_node);
 
-/* check which state of node_states will be changed when offline memory */
-static void node_states_check_changes_offline(unsigned long nr_pages,
-		struct zone *zone, struct memory_notify *arg)
-{
-	struct pglist_data *pgdat = zone->zone_pgdat;
-	unsigned long present_pages = 0;
-	enum zone_type zt;
-
-	arg->status_change_nid = NUMA_NO_NODE;
-
-	/*
-	 * Check whether node_states[N_NORMAL_MEMORY] will be changed.
-	 * If the memory to be offline is within the range
-	 * [0..ZONE_NORMAL], and it is the last present memory there,
-	 * the zones in that range will become empty after the offlining,
-	 * thus we can determine that we need to clear the node from
-	 * node_states[N_NORMAL_MEMORY].
-	 */
-	for (zt = 0; zt <= ZONE_NORMAL; zt++)
-		present_pages += pgdat->node_zones[zt].present_pages;
-
-	/*
-	 * We have accounted the pages from [0..ZONE_NORMAL); ZONE_HIGHMEM
-	 * does not apply as we don't support 32bit.
-	 * Here we count the possible pages from ZONE_MOVABLE.
-	 * If after having accounted all the pages, we see that the nr_pages
-	 * to be offlined is over or equal to the accounted pages,
-	 * we know that the node will become empty, and so, we can clear
-	 * it for N_MEMORY as well.
-	 */
-	present_pages += pgdat->node_zones[ZONE_MOVABLE].present_pages;
-
-	if (nr_pages >= present_pages)
-		arg->status_change_nid = zone_to_nid(zone);
-}
-
-static void node_states_clear_node(int node, struct memory_notify *arg)
-{
-	if (arg->status_change_nid >= 0)
-		node_clear_state(node, N_MEMORY);
-}
-
 static int count_system_ram_pages_cb(unsigned long start_pfn,
 				     unsigned long nr_pages, void *data)
 {
@@ -1937,13 +1899,17 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			struct zone *zone, struct memory_group *group)
 {
-	const unsigned long end_pfn = start_pfn + nr_pages;
-	unsigned long pfn, managed_pages, system_ram_pages = 0;
-	const int node = zone_to_nid(zone);
-	unsigned long flags;
-	struct memory_notify arg;
-	char *reason;
 	int ret;
+	char *reason;
+	enum zone_type zt;
+	unsigned long flags;
+	struct memory_notify mem_arg;
+	struct node_notify node_arg;
+	const int node = zone_to_nid(zone);
+	struct pglist_data *pgdat = zone->zone_pgdat;
+	const unsigned long end_pfn = start_pfn + nr_pages;
+	unsigned long pfn, managed_pages, system_ram_pages = 0, present_pages = 0;
+	bool cancel_mem_notifier_on_err = false, cancel_node_notifier_on_err = false;
 
 	/*
 	 * {on,off}lining is constrained to full memory sections (or more
@@ -2000,11 +1966,30 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 		goto failed_removal_pcplists_disabled;
 	}
 
-	arg.start_pfn = start_pfn;
-	arg.nr_pages = nr_pages;
-	node_states_check_changes_offline(nr_pages, zone, &arg);
+	/*
+	 * Here we count the possible pages within the range [0..ZONE_MOVABLE].
+	 * If after having accounted all the pages, we see that the nr_pages to
+	 * be offlined is greater or equal to the accounted pages, we know that the
+	 * node will become empty, and so, we will clear N_MEMORY for it.
+	 */
+	node_arg.nid = NUMA_NO_NODE;
+	for (zt = 0; zt <= ZONE_MOVABLE; zt++)
+		present_pages += pgdat->node_zones[zt].present_pages;
+
+	if (nr_pages >= present_pages) {
+		node_arg.nid = node;
+		cancel_node_notifier_on_err = true;
+		ret = node_notify(NODE_REMOVING_LAST_MEMORY, &node_arg);
+		ret = notifier_to_errno(ret);
+		if (ret)
+			goto failed_removal_isolated;
+	}
 
-	ret = memory_notify(MEM_GOING_OFFLINE, &arg);
+	mem_arg.start_pfn = start_pfn;
+	mem_arg.nr_pages = nr_pages;
+	mem_arg.status_change_nid = node_arg.nid;
+	cancel_mem_notifier_on_err = true;
+	ret = memory_notify(MEM_GOING_OFFLINE, &mem_arg);
 	ret = notifier_to_errno(ret);
 	if (ret) {
 		reason = "notifier failure";
@@ -2084,27 +2069,33 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	 * Make sure to mark the node as memory-less before rebuilding the zone
 	 * list. Otherwise this node would still appear in the fallback lists.
 	 */
-	node_states_clear_node(node, &arg);
+	if (node_arg.nid >= 0)
+		node_clear_state(node, N_MEMORY);
 	if (!populated_zone(zone)) {
 		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
 	}
 
-	if (arg.status_change_nid >= 0) {
+	if (node_arg.nid >= 0) {
 		kcompactd_stop(node);
 		kswapd_stop(node);
+		/* Node went memoryless. Notify consumers */
+		node_notify(NODE_REMOVED_LAST_MEMORY, &node_arg);
 	}
 
 	writeback_set_ratelimit();
 
-	memory_notify(MEM_OFFLINE, &arg);
+	memory_notify(MEM_OFFLINE, &mem_arg);
 	remove_pfn_range_from_zone(zone, start_pfn, nr_pages);
 	return 0;
 
 failed_removal_isolated:
 	/* pushback to free area */
 	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
-	memory_notify(MEM_CANCEL_OFFLINE, &arg);
+	if (cancel_mem_notifier_on_err)
+		memory_notify(MEM_CANCEL_OFFLINE, &mem_arg);
+	if (cancel_node_notifier_on_err)
+		node_notify(NODE_CANCEL_REMOVING_LAST_MEMORY, &node_arg);
 failed_removal_pcplists_disabled:
 	lru_cache_enable();
 	zone_pcp_enable(zone);
-- 
2.49.0


