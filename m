Return-Path: <linux-kernel+bounces-834839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B4EBA59F4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CB02A57B7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE58522F177;
	Sat, 27 Sep 2025 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="NuocFDh3"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D81EFF8B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758955722; cv=none; b=siB4hfmN5GjFbS1p4kFkiGtIGmfW1+JgY9AGFxbWd2yw1RuYDjIqtIydJQ8zKNZWDmB6WF5NLXc9d5546+QcAR8lCL4DXQVuhRLzfHYghXhJEFAER/LKrbwOnTeZef5Suut3QILYAUmLE3HdJI7u6n7HZJv85kK6/KwJGYz+Q9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758955722; c=relaxed/simple;
	bh=XQYEYZzl1K7PED5HCo6LIaCwRK6lOlbA9ZQtQ+r6tLo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XaoICbclIlhl41AfQynm9HaDD+68nw7Sjfl/TqHOWCd2nquYwkSb5dcj6MxM8Cr33Ifi21To+vmKAkqX3tygRgU9EXv8RKNo5nz4fZZQxwRSxyA8CqgAh02fujKaLH1vdk2Co4kp7bHHzTeyLk+exPDYWp7xFWS0gFaHXKUiwrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=NuocFDh3; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=GjcJqWSKjlti6k3
	EMHddKW4dVDmtwr+NEk+GeGVCsxo=; b=NuocFDh37bNHjPOtulMyibqO781p/qk
	d/MJR02iixPPthD10FiHqKrfYeNfeF4ZjgWrOXkRqPKYZTF9OUw9oNRG/gEdbs79
	ghdw8CKHujxz/eT4ya1862YZ5PnfuhebsCrYOrHXfuNRwgPdlHAHT3EuJq+RU91r
	31l0Mu3syCo8=
Received: from ubuntu.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDHryGhiNdoXuZ0BQ--.27812S2;
	Sat, 27 Sep 2025 14:48:03 +0800 (CST)
From: buckzhang1212@yeah.net
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: buckzhang1212@yeah.net
Subject: [PATCH v2] locking/rwsem: add DEBUG_RWSEMS_WARN_ON to warn invalid rwsem
Date: Fri, 26 Sep 2025 23:47:56 -0700
Message-Id: <20250927064756.13544-1-buckzhang1212@yeah.net>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:Ms8vCgDHryGhiNdoXuZ0BQ--.27812S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr15GFyrWrWfAryftw1UKFg_yoW5AryxpF
	4Yv3sIgrWvqFWIqr47J3ZakFn0qr4jya47GFZxG348JrZ8GF4DJFnxJFy7ArWYkr97CFZx
	XF4furWY9rWDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5txhUUUUU=
X-CM-SenderInfo: pexfy65kdqwiqsrsq5hhdkh0dhw/1tbiCw3Vr2jXX-hwQAAAsU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: "buck.zhang" <buckzhang1212@yeah.net>

Here is a kernel exception about rwsem and I can recreate it stably.
First We define a struct contains a rwsem.
Then allocate this struct by kmalloc without calling init_rwsem.
Finally when multiple tasks call use rwsem together,kernel will panic.
This lock is used normally when only one task is using  at a time.
the exception reason is that sem->wait_list is an invalid kernel list.
I want to add more warnings when enable CONFIG_DEBUG_RWSEMS
kernel crash log:
Unable to handle kernel NULL pointer dereference at virtual address 0000000
pc: rwsem_down_write_slowpath+0x428/0xccc
lr: rwsem_down_write_slowpath+0x844/0xccc
sp: ffffffc0870abb00
x29: ffffffc0870abb60 x28: 0000000000000000 x27: ffffffffffffff05
........
x2: ffffff809d57d830 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
rwsem_down_write_slowpath+0x428/0xccc
down_write+0xa8/0x108
Test case:
struct chip_rwsema {
	struct rwsema sem;
};
static void work_handler1(struct chip_rwsema *csem)
{
	down_write(&(csem->sem));
}
static void work_handler2(struct chip_rwsema *csem)
{
	down_write(&(csem->sem));
}
static void chip_tsem(void)
{
	struct chip_rwsema *csem;
	csem = kzalloc(sizeof(struct chip_rwsema),GFP_KERNEL);
	work_handler1(csem);
	......
	work_handler2(csem);
}

Signed-off-by: buck.zhang <buckzhang1212@yeah.net>
---
 kernel/locking/rwsem.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 24df4d98f..bfc038573 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -75,7 +75,17 @@
 		list_empty(&(sem)->wait_list) ? "" : "not "))	\
 			debug_locks_off();			\
 	} while (0)
+
+/*
+ * list_invalid - check whether sem->waitlist is invalid
+ * @head: the list to test.
+ */
+static inline int rwsem_waitlist_invalid(const struct list_head *head)
+{
+	return (unsigned long) READ_ONCE(head->next) < PAGE_OFFSET;
+}
 #else
+# define rwsem_waitlist_invalid(sem)
 # define DEBUG_RWSEMS_WARN_ON(c, sem)
 #endif
 
@@ -1034,6 +1044,9 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
 	waiter.handoff_set = false;
 
+	/* In case the rwsem is uninitiated, add more warning */
+	DEBUG_RWSEMS_WARN_ON(rwsem_waitlist_invalid(&sem->wait_list), sem);
+
 	raw_spin_lock_irq(&sem->wait_lock);
 	if (list_empty(&sem->wait_list)) {
 		/*
@@ -1128,6 +1141,9 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
 	waiter.handoff_set = false;
 
+	/* In case the rwsem is uninitiated, add more warning */
+	DEBUG_RWSEMS_WARN_ON(rwsem_waitlist_invalid(&sem->wait_list), sem);
+
 	raw_spin_lock_irq(&sem->wait_lock);
 	rwsem_add_waiter(sem, &waiter);
 
-- 
2.17.1


