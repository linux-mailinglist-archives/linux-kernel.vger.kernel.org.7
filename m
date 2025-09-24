Return-Path: <linux-kernel+bounces-829863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D528B98149
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF86F2E5E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C9B21B9F1;
	Wed, 24 Sep 2025 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="AFkggTn/"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016B5215043
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758681377; cv=none; b=ew4eSDCiiEonySIMEI0riRGE1RsRC48lQQqmFwkzIxJjAU9KbjJTsRkfN4AHkowrazzomzQ5cLv2Q30IM73b5mnc+UqtaJRfCJRbp6MZXAf98KAsCBJOgSqfbD90UZUAU11QCFodxA/mckzDJAofm9ylN/nOjuiWeC6XrVGf4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758681377; c=relaxed/simple;
	bh=01wT68UNSwhfpWdAlgiDuuwwdgfaU330mgxCbo3eZNw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hpQe2ieEY5Z6V6w+lJ+LV0FjAMQrPgABeMNyGjUiiSvBpM2U/+ABh3TsBsfAYN8NOxQ0YRA2mtyGHiAbf+/IOivWJ6ynn5vOFm6Ei5Us7nkwEVirvDx8pYkmXiOJQSS+FHjrdpaEh13lmB0TQlKSm/dNM2q/ZWwE7WhwFX3qQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=AFkggTn/; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=7ZJyqM6KWG4H2x+DYnhtJLfhL6WirxnLjJxoGlstssw=;
	b=AFkggTn/hbkhm5HDuXtcJibPy/6RpGAm2JLDcuSeiU5mig+Wd2+mb2a30rulsq
	1gOySdgBmvoQpj4jvqDXTaym77zs6oRj+dDajbgQHaqI83isQUir7HCvT66bkO0T
	hIPrFSMqa9/3GYGXkjxlMzyyh/TtxZ5h56CyQtz/HIKyU=
Received: from ubuntu.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDHD7qDVtNoA0cVBQ--.36297S2;
	Wed, 24 Sep 2025 10:25:09 +0800 (CST)
From: buckzhang1212@yeah.net
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: buckzhang1212@yeah.net
Subject: [PATCH] locking/mutex:add MUTEX_CHCEK_INIT to detect uninitialized mutex lock
Date: Tue, 23 Sep 2025 19:25:00 -0700
Message-Id: <20250924022500.2577-1-buckzhang1212@yeah.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:M88vCgDHD7qDVtNoA0cVBQ--.36297S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryfWF1rWr17JrW7ZF47urg_yoW5Ary8pr
	4Ykw17ur48XF10vr4UAF1fur4Yyw48CFW7CrZ3Ja48ZFnxKFnFqFnrta1UurWFgryxXFZ3
	tF1jqrWrtr45Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_kucUUUUU=
X-CM-SenderInfo: pexfy65kdqwiqsrsq5hhdkh0dhw/1tbiNAXFdWjTVoVTSwAA3x

From: "buck.zhang" <buckzhang1212@yeah.net>

Here is a kernel exception about mutex and I can recreate it stably.
First we define a custome struct that includes a mutex lock.
Then allocate this struct by kmalloc without calling mutex_init.
Finally when multiple tasks call mutex_lock together,kernel will panic.
But Kernel is good  if only one task call this mutex at the same time.
the exception reason is that lock->wait_list is an invalid kernel list.
kernel crash log: 
Unable to handle kernel NULL pointer dereference at virtual address 0000000
pc: __mutex_add_waiter+0x68/0x160
lr: __mutex_add_waiter+0x128/0x160
sp: ffffffc0866f3ac0
x29: ffffffc0866f3ad0 x28: ffffff8095148000 x27: 0000000000000000
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
 kernel/locking/mutex.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index de7d6702c..8fbe858c8 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -42,6 +42,16 @@
 #else
 # define MUTEX_WARN_ON(cond)
 #endif
+#define MUTEX_CHCEK_INIT(lock)  mutex_check_waitlist(lock)
+static void mutex_check_waitlist(struct mutex *lock)
+{
+	struct list_head *list = &lock->wait_list;
+
+	if ((unsigned long)list->next < PAGE_OFFSET) {
+		pr_err("BUG: mutex lock is uninitialized，wait_list is Error\n");
+		MUTEX_WARN_ON("mutex lock is uninitialized");
+	}
+}
 
 void
 __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
@@ -269,6 +279,7 @@ static void __sched __mutex_lock_slowpath(struct mutex *lock);
 void __sched mutex_lock(struct mutex *lock)
 {
 	might_sleep();
+	MUTEX_CHCEK_INIT(lock);
 
 	if (!__mutex_trylock_fast(lock))
 		__mutex_lock_slowpath(lock);
@@ -991,6 +1002,7 @@ __mutex_lock_interruptible_slowpath(struct mutex *lock);
 int __sched mutex_lock_interruptible(struct mutex *lock)
 {
 	might_sleep();
+	MUTEX_CHCEK_INIT(lock);
 
 	if (__mutex_trylock_fast(lock))
 		return 0;
@@ -1015,6 +1027,7 @@ EXPORT_SYMBOL(mutex_lock_interruptible);
 int __sched mutex_lock_killable(struct mutex *lock)
 {
 	might_sleep();
+	MUTEX_CHCEK_INIT(lock);
 
 	if (__mutex_trylock_fast(lock))
 		return 0;
-- 
2.17.1


