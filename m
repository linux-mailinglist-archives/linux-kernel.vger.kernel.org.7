Return-Path: <linux-kernel+bounces-834862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691CBA5A9B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E572A7B2C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959A02D47FF;
	Sat, 27 Sep 2025 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="iBVNy6ir"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BDF2D47F1
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758960681; cv=none; b=IADa0L7kND5t4gPz+vD2tfFzoStDbHr7JdbMLFItFbzdkz5twpOspl6I412xn9gppUvDL4HHV97oaEAVnRcn4T6OIcwsMBGdlVs8E0Xi3nNINZYX48Nots1dBB5tOEazfh2LMK/e0/OCO6PvHbypy5cVyJVReRTHeyMKCIIEbRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758960681; c=relaxed/simple;
	bh=00yszAU9TAwpeujI5V9a5zw1S6x0JxtWrBB7b65f77k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JeRIU2WUTg/MSq1etAkUhompjqXfbmn4UFssq6xt1Gfh82bxVM9ooxHh6nRmDaqGWJmaZBluA1pZPwPhOAKzpAWHhm4qhO6570aWsa29H+SEb6ITCVLpDPtSDKua44kGBl9sUGYccGJXc1hI9LgcFPbVIKcF8WKTcYMyDMrwaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=iBVNy6ir; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=MYvbAlBum21oITj
	BlLxXfVanm9za2mhnAyf+H4x2jLw=; b=iBVNy6irr/VWkf2k+wJy7YXVAqbmrI+
	4bsZFIUnTNurhYp9Jbs3Q7EkWF33AWVyyn2Ot8A7oWFxCE0haCsCLdVEuLAw3nbC
	vu/ci12sw2tLVjGVI065TJqRkmo8zLqnSoCinVA8aeFoRwLgcgw9pcYeepzulrs5
	bOTey10pp/q0=
Received: from ubuntu.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAXHbGXmddoAI5eBQ--.36496S2;
	Sat, 27 Sep 2025 16:00:24 +0800 (CST)
From: buckzhang1212@yeah.net
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: buckzhang1212@yeah.net
Subject: [PATCH] locking/mutex:	add MUTEX_WARN_ON to warn invalid mutex
Date: Sat, 27 Sep 2025 01:00:18 -0700
Message-Id: <20250927080018.13909-1-buckzhang1212@yeah.net>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:Mc8vCgAXHbGXmddoAI5eBQ--.36496S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFWrCr1UGryUuF1xAFy3twb_yoWrJryxpF
	4YkFy7Cw48JFW0grWjyr4furWYyw15CFWfCw4fGa4UWF98K3WqqFnrtFyUCrWFgryxXFZx
	tFnYqrWrtr48Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5txhUUUUU=
X-CM-SenderInfo: pexfy65kdqwiqsrsq5hhdkh0dhw/1tbiIhicTGjXmZj-BwAA3s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: "buck.zhang" <buckzhang1212@yeah.net>

Here is a kernel exception about mutex and I can recreate it stably.
First we define a struct contains a mutex.
Then allocate this struct by kmalloc without calling mutex_init.
Finally when multiple tasks call mutex_lock together,kernel will panic.
This lock is used normally when only one task is using  at a time.
the exception reason is that lock->wait_list is an invalid kernel list.
I want to add more warnings when enable CONFIG_DEBUG_MUTEXES
kernel crash log:
Unable to handle kernel NULL pointer dereference at virtual address 0000000
pc: __mutex_add_waiter+0x68/0x160
lr: __mutex_add_waiter+0x128/0x160
sp: ffffffc0866f3ac0
x29: ffffffc0866f3ad0 x28: ffffff8095148000 x27: 0000000000000000
.............
x2: ffffffc0866f3b18 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
__mutex_add_waiter+0x68/0x160
__mutex_lock+0x48c/0x119c
__mutex_lock_slowpath+0x1c/0x2c
mutex_lock+0x48/0x144
Test case:
struct chip_mutex {
	struct mutex tmutex;
};
static void work_handler1(struct chip_mutex *cmutex)
{
        mutex_lock(&(cmutex->tmutex));
}
static void work_handler2(struct chip_mutex *cmutex)
{
         mutex_lock(&(cmutex->tmutex));
}
static void chip_tmutex(void)
{
	struct chip_mutex *cmutex;
	cmutex = kzalloc(sizeof(struct chip_mutex),GFP_KERNEL);
	work_handler1(cmutex);
	------
	work_handler2(cmutex);
}

Signed-off-by: buck.zhang <buckzhang1212@yeah.net>
---
 kernel/locking/mutex.c |  2 ++
 kernel/locking/mutex.h | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index de7d6702c..318d98f2f 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -574,6 +574,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	might_sleep();
 
+	/* In case the mutex is uninitiated, add more warning */
+	MUTEX_WARN_ON(mutex_waitlist_invalid(&lock->wait_list));
 	MUTEX_WARN_ON(lock->magic != lock);
 
 	ww = container_of(lock, struct ww_mutex, base);
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 2e8080a9b..4aaaad10d 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -48,6 +48,7 @@ static inline struct task_struct *__mutex_owner(struct mutex *lock)
 }
 
 #ifdef CONFIG_DEBUG_MUTEXES
+
 extern void debug_mutex_lock_common(struct mutex *lock,
 				    struct mutex_waiter *waiter);
 extern void debug_mutex_wake_waiter(struct mutex *lock,
@@ -61,6 +62,15 @@ extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *w
 extern void debug_mutex_unlock(struct mutex *lock);
 extern void debug_mutex_init(struct mutex *lock, const char *name,
 			     struct lock_class_key *key);
+
+/*
+ * list_invalid - tests whether mutex-> waitlist  is invalid
+ * @head: the list to test.
+ */
+static inline int mutex_waitlist_invalid(const struct list_head *head)
+{
+	return (unsigned long) READ_ONCE(head->next) < PAGE_OFFSET;
+}
 #else /* CONFIG_DEBUG_MUTEXES */
 # define debug_mutex_lock_common(lock, waiter)		do { } while (0)
 # define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
@@ -69,5 +79,6 @@ extern void debug_mutex_init(struct mutex *lock, const char *name,
 # define debug_mutex_remove_waiter(lock, waiter, ti)	do { } while (0)
 # define debug_mutex_unlock(lock)			do { } while (0)
 # define debug_mutex_init(lock, name, key)		do { } while (0)
+# define mutex_waitlist_invalid()			do { } while (0)
 #endif /* !CONFIG_DEBUG_MUTEXES */
 #endif /* CONFIG_PREEMPT_RT */
-- 
2.17.1


