Return-Path: <linux-kernel+bounces-834818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92175BA596B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D215E7AB01E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 05:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C52241C8C;
	Sat, 27 Sep 2025 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="A7op7zv4"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4328371
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758952314; cv=none; b=WJ7koQf5ThILeSpbQw0sm06H62vhr8FzB31tUVnmzLsJTZP6rnaWcTfvfmUbG4fWBicZ2aw0hJZYWc3q9f8pOzCAkckoECXBTycFE6ksd9dHwG9o2nvvhC19I7L7q6ptYjKfXLbhokhRrBgZdSNyMzUa2pT2apKFldElhQt7FI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758952314; c=relaxed/simple;
	bh=XQYEYZzl1K7PED5HCo6LIaCwRK6lOlbA9ZQtQ+r6tLo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FgiK0YVLRky9zdPsfsyZF1Q3BKnSYWoF7YMbXtLtWDCl364E7kCa18FJRWE7yRRy5F+ZCxrGsSw0xQTcTnaYt5QklmjlghQmh0Cr6TDMFq48le8YKYGveQpOVLW+AAEttqqjlz4yT0PZSCOY8b8Ilkex0bprzJATk9RQpRNi2gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=A7op7zv4; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=GjcJqWSKjlti6k3
	EMHddKW4dVDmtwr+NEk+GeGVCsxo=; b=A7op7zv4F1F5ZwgnoqpRydBCXQsbKXr
	A3+ahurSWjg1mm4HVfRP9+hW4zeKsRTpXnPnxMau3ApIG+GysI8wkjo4YKhV44n4
	SgtCzRg7pX51JlbUxueExH5XYYf7L7iHnwU4P1yGWvKza0ZRxcdld2apKI4QrRfh
	994l1S9z+r8g=
Received: from ubuntu.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAHlGRNe9do6d1SBQ--.3197S2;
	Sat, 27 Sep 2025 13:51:10 +0800 (CST)
From: buckzhang1212@yeah.net
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: buckzhang1212@yeah.net
Subject: [PATCH] locking/rwsema:add DEBUG_RWSEMS_WARN_ON to warn invalid rwsem
Date: Fri, 26 Sep 2025 22:50:58 -0700
Message-Id: <20250927055058.3772-1-buckzhang1212@yeah.net>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:M88vCgAHlGRNe9do6d1SBQ--.3197S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr15GFyrWrWfAryftw1UKFg_yoW5AryxpF
	4Yv3sIgrWvqFWIqr47J3ZakFn0qr4jya47GFZxG348JrZ8GF4DJFnxJFy7ArWYkr97CFZx
	XF4furWY9rWDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPPE-UUUUU=
X-CM-SenderInfo: pexfy65kdqwiqsrsq5hhdkh0dhw/1tbiNA8CsWjXe09ESgAA3N
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


