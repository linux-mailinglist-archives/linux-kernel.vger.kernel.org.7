Return-Path: <linux-kernel+bounces-640936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BE7AB0B2F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 09:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD3AE7B38B1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 07:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697BD2701C6;
	Fri,  9 May 2025 07:06:59 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13026FD9A
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746774419; cv=none; b=WarO8RUDTlPZsX7slP3G5wJiE11MNE1zQkbasH8VrOKw3qCOiXxiQ0RbWZ2uFIfr5tC53XaqsfKSEgZeZCiirmW1wmU/lgi2+KSb96HtHwr/6Tr0EbUXNcvNYwLe8usAr5iWGyO3jVUs4AUiEyGD4NOVVzpRSM+iUF+AbRyO6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746774419; c=relaxed/simple;
	bh=xuh3+d3PyJHPLx/vRAjNd3dPRlG+l4xvonJuqToDVxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m9nTJWentX99VOiDNGojb6GhEhfdJu3LA93sNhszATm6FtU6U94l3b6621b4Z7+Ea1pGEJQtKfutWIlSZRY1bDThsSHyiQLehEDzIi3ty0pwCTSGd0xmDrskSNozDlbXvpBjbhq5zzyqBioqQ7ys+3Ma0rXIp4JqQirc5w5yE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zv0R757jFz4f3lWG
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 15:06:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B8E771A1C20
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 15:06:53 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgAnesR4qR1ofcXLLg--.60961S5;
	Fri, 09 May 2025 15:06:53 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	paulmck@kernel.org,
	bigeasy@linutronix.de,
	legion@kernel.org,
	roman.gushchin@linux.dev,
	brauner@kernel.org,
	tglx@linutronix.de,
	frederic@kernel.org,
	peterz@infradead.org,
	oleg@redhat.com,
	joel.granados@kernel.org,
	viro@zeniv.linux.org.uk,
	lorenzo.stoakes@oracle.com,
	avagin@google.com,
	mengensun@tencent.com,
	linux@weissschuh.net,
	jlayton@kernel.org,
	ruanjinjie@huawei.com,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [RFC next 3/5] user_namespace: add user_ns iteration helper
Date: Fri,  9 May 2025 06:54:09 +0000
Message-Id: <20250509065417.147515-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509065417.147515-1-chenridong@huaweicloud.com>
References: <20250509065417.147515-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnesR4qR1ofcXLLg--.60961S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGF43KFWfZF1Utry7Gw4fGrg_yoW5XFWDpF
	4Skr9xAw47JrnrKwn8ZFs5u34fWr10vFy8JFyxu3s3tF1agFy5Arn7A3WrZr9xGr4UGrW5
	XFWUKws8Kr4Uu37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRM6wCDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Add a helper function named 'ns_next_child_pre' that performs
a pre-order traversal of a namespace's descendants.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/user_namespace.h |  9 +++++++
 kernel/user_namespace.c        | 44 ++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index d84b2703caab..823df9267a4a 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -169,6 +169,15 @@ static inline void set_userns_rlimit_max(struct user_namespace *ns,
 	ns->rlimit_max[type] = max <= LONG_MAX ? max : LONG_MAX;
 }
 
+struct user_namespace *ns_next_child(struct user_namespace *pos,
+					   struct user_namespace *parent);
+struct user_namespace *ns_next_child_pre(struct user_namespace *pos,
+						    struct user_namespace *root);
+
+#define ns_for_each_child_pre(pos, ns)				\
+	for ((pos) = ns_next_child_pre(NULL, (ns)); (pos);	\
+	     (pos) = ns_next_child_pre((pos), (ns)))
+
 #ifdef CONFIG_USER_NS
 
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index cbe8f96c3e60..9a2e77505b97 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -30,6 +30,50 @@ static bool new_idmap_permitted(const struct file *file,
 				struct uid_gid_map *map);
 static void free_user_ns(struct work_struct *work);
 
+struct user_namespace *ns_next_child(struct user_namespace *pos,
+					   struct user_namespace *parent)
+{
+	struct user_namespace *next;
+
+	if (!pos)
+		/* Get the first child of the parent. */
+		next = list_entry_rcu(parent->children.next, struct user_namespace, ns_node);
+	else
+		next = list_entry_rcu(pos->ns_node.next, struct user_namespace, ns_node);
+
+	if (&next->ns_node != &parent->children)
+		return next;
+
+	return NULL;
+}
+
+/* Should be called under rcu_read_lock() */
+struct user_namespace *ns_next_child_pre(struct user_namespace *pos,
+						    struct user_namespace *root)
+{
+	struct user_namespace *next;
+
+
+	/* if first iteration, visit @root */
+	if (!pos)
+		return root;
+
+	/* visit the first child if exists */
+	next = ns_next_child(NULL, pos);
+	if (next)
+		return next;
+
+	/* no child, visit my or the closest ancestor's next ns_node */
+	while (pos != root) {
+		next = ns_next_child(pos, pos->parent);
+		if (next)
+			return next;
+		pos = pos->parent;
+	}
+
+	return NULL;
+}
+
 static struct ucounts *inc_user_namespaces(struct user_namespace *ns, kuid_t uid)
 {
 	return inc_ucount(ns, uid, UCOUNT_USER_NAMESPACES);
-- 
2.34.1


