Return-Path: <linux-kernel+bounces-786455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BEDB35A11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC497A8194
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500112BE7D1;
	Tue, 26 Aug 2025 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="P22KnrD7"
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAE0199FAB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204068; cv=none; b=ei5MmYcFfb01IvQFHP77TLUMoyIYrU/ZKPSICUoZdCJpezi55//xwqWxq9M+2c6ZVDlBTHGoIvUlO6UWUPCmSaLKFRpp5v5+qScyvE5jUb1unwLJNHF/UdlbTYgJM+D2NlPhP50K8QfK1+KnSB1IL1fJWF5MQIIa0+j2leUXIng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204068; c=relaxed/simple;
	bh=IesqIGnB9Ffo5uqYC6nyaFAQHscROhBN/53NzNHTVys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOvJhPyT467r5fvCTnR7Ftx/8JX98cWGyql0uNPF1jqHkBzCr1mTzc+Tk1G+Ik4sIVNg5qx5B2rILyRMQw/FNBXNSPWDf1a6Kstaff1zJE07ciWatUjzTLhnQTa7ccCE9gepM19BjYRHLFe9iflC7xcHYUerI2QWg/yf+z/yyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=P22KnrD7; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250826102741e6a38a615d000207dc
        for <linux-kernel@vger.kernel.org>;
        Tue, 26 Aug 2025 12:27:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=I/4BVzGU//6o8w11JEpBafkAVNTi3A37k7IOe6GBXws=;
 b=P22KnrD7K2eLtlFSFdKekh9i2IMMpIplqPFKWTX0OT22i4CJXQfd39EDkaV/yDKtBnd1gU
 6Hb2/hcwDuZMwCNB3QhypM/bfUjEflgvTwsaXuixrAvsbdh0k58WhsUNOM4I5TcxXOCsPENM
 xXNnVzVKs7SQcNJuHn3p/TOtA+orgZsqWcW3EN4B3c7cvHrs15t37emEt3BWWQty0HCj2gD0
 1bBFpG22jKbS8oOb/yAdUmX5y8Sk+Qn6dKH7f2M6lWFbp8ysYY/CCMcMObPY8qtykaWGVmOK
 UN0fT89QKpi32/J0JwfIZA6Md325NSqB8oN88tvcuYqQNWVPC6PC37BQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	stable@vger.kernel.org,
	Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH RESEND] locking/spinlock/debug: Fix data-race in do_raw_write_lock
Date: Tue, 26 Aug 2025 12:27:27 +0200
Message-ID: <20250826102731.52507-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

KCSAN reports:

BUG: KCSAN: data-race in do_raw_write_lock / do_raw_write_lock

write (marked) to 0xffff800009cf504c of 4 bytes by task 1102 on cpu 1:
 do_raw_write_lock+0x120/0x204
 _raw_write_lock_irq
 do_exit
 call_usermodehelper_exec_async
 ret_from_fork

read to 0xffff800009cf504c of 4 bytes by task 1103 on cpu 0:
 do_raw_write_lock+0x88/0x204
 _raw_write_lock_irq
 do_exit
 call_usermodehelper_exec_async
 ret_from_fork

value changed: 0xffffffff -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 1103 Comm: kworker/u4:1 6.1.111

Commit 1a365e822372 ("locking/spinlock/debug: Fix various data races") has
adressed most of these races, but seems to be not consistent/not complete.

From do_raw_write_lock() only debug_write_lock_after() part has been
converted to WRITE_ONCE(), but not debug_write_lock_before() part.
Do it now.

Cc: stable@vger.kernel.org
Fixes: 1a365e822372 ("locking/spinlock/debug: Fix various data races")
Reported-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
There are still some inconsistencies remaining IMO:
- lock->magic is sometimes accessed with READ_ONCE() even though it's only
being plain-written;
- debug_spin_unlock() and debug_write_unlock() both do WRITE_ONCE() on
lock->owner and lock->owner_cpu, but examine them with plain read accesses.

 kernel/locking/spinlock_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 87b03d2e41dbb..2338b3adfb55f 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -184,8 +184,8 @@ void do_raw_read_unlock(rwlock_t *lock)
 static inline void debug_write_lock_before(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
-	RWLOCK_BUG_ON(lock->owner == current, lock, "recursion");
-	RWLOCK_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
+	RWLOCK_BUG_ON(READ_ONCE(lock->owner) == current, lock, "recursion");
+	RWLOCK_BUG_ON(READ_ONCE(lock->owner_cpu) == raw_smp_processor_id(),
 							lock, "cpu recursion");
 }
 
-- 
2.47.1


