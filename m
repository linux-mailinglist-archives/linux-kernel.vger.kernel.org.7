Return-Path: <linux-kernel+bounces-624371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B88A0AA02B7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 08:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C14FC7A4500
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 06:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FB027585A;
	Tue, 29 Apr 2025 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G8K50aPa"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C90274673
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907169; cv=none; b=uEnoXvHhdJWtwqSCKkN6CWSozCeNLOYKLhcP1pyd1hV4Ljiz6WKNYnUd331yiIP5EqiWKt8B/Ac5rNaeyGOgzeqXSIlTpac46WCpPkF6VfL2ooO92Pec6bni13BeaHIIqOVtOYKHDpxxBSWrMbwlhf8BCTT+DGHqmI69BymDuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907169; c=relaxed/simple;
	bh=W9SL5KFSJmqJZuSS/587Qh/rBTqa7zPcpqtTWeuTBIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpMqpAEYhLfRaIq0TlfC8t14azfomSBLZkDuaK5LcKDDNuPy7Rh34XjtkhpOorBulHUI4lYWwtaW56bfml/qtF74UkfFcl1p5ZqxYAp7TFxcgfo8s1skA6nrZb/E1IBA2LQRJvRevb3lue2NBxvu/LztykOjVDp6wVdXLePF+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G8K50aPa; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745907155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0GCrjGtquPsOI35plGdgUQW448xZcx6HHNt3mxji6M=;
	b=G8K50aPalxCurXCs8MzqUCxqQtHVl+V5W1N6WLfUGShF4gMmsaZp5t2m85tfP429t0pyBD
	vdHZ6EKbajUKl9WNEtwoLC8OHw67tekWbbtELBZOeKkCRAUdBwDEC2lRDp8XwDcykT/Nfg
	2vP6HBmWrLpf01hxCtxfiMZrS+itV34=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	JP Kobryn <inwardvessel@gmail.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [RFC PATCH 1/3] llist: add list_add_iff_not_on_list()
Date: Mon, 28 Apr 2025 23:12:07 -0700
Message-ID: <20250429061211.1295443-2-shakeel.butt@linux.dev>
In-Reply-To: <20250429061211.1295443-1-shakeel.butt@linux.dev>
References: <20250429061211.1295443-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As the name implies, list_add_iff_not_on_list() adds the given node to
the given only if the node is not on any list. Many CPUs can call this
concurrently on the same node and only one of them will succeed.

This is also useful to be used by different contexts like task, irq and
nmi. In the case of failure either the node as already present on some
list or the caller can lost the race to add the given node to a list.
That node will eventually be added to a list by the winner.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/llist.h |  3 +++
 lib/llist.c           | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 2c982ff7475a..030cfec8778b 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -236,6 +236,9 @@ static inline bool __llist_add_batch(struct llist_node *new_first,
 	return new_last->next == NULL;
 }
 
+extern bool llist_add_iff_not_on_list(struct llist_node *new,
+				      struct llist_head *head);
+
 /**
  * llist_add - add a new entry
  * @new:	new entry to be added
diff --git a/lib/llist.c b/lib/llist.c
index f21d0cfbbaaa..9d743164720f 100644
--- a/lib/llist.c
+++ b/lib/llist.c
@@ -36,6 +36,36 @@ bool llist_add_batch(struct llist_node *new_first, struct llist_node *new_last,
 }
 EXPORT_SYMBOL_GPL(llist_add_batch);
 
+/**
+ * llist_add_iff_not_on_list - add an entry if it is not on list
+ * @new:	entry to be added
+ * @head:	the head for your lock-less list
+ *
+ * Adds the given entry to the given list only if the entry is not on any list.
+ * This is useful for cases where multiple CPUs tries to add the same node to
+ * the list or multiple contexts (process, irq or nmi) may add the same node to
+ * the list.
+ *
+ * Return true only if the caller has successfully added the given node to the
+ * list. Returns false if entry is already on some list or if another inserter
+ * wins the race to eventually add the given node to the list.
+ */
+bool llist_add_iff_not_on_list(struct llist_node *new, struct llist_head *head)
+{
+	struct llist_node *first = READ_ONCE(head->first);
+
+	if (llist_on_list(new))
+		return false;
+
+	if (cmpxchg(&new->next, new, first) != new)
+		return false;
+
+	while (!try_cmpxchg(&head->first, &first, new))
+		new->next = first;
+	return true;
+}
+EXPORT_SYMBOL_GPL(llist_add_iff_not_on_list);
+
 /**
  * llist_del_first - delete the first entry of lock-less list
  * @head:	the head for your lock-less list
-- 
2.47.1


