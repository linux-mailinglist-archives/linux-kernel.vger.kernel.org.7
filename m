Return-Path: <linux-kernel+bounces-836436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6141BA9B09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FD8192212D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00E72F0699;
	Mon, 29 Sep 2025 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Q4NM9XOv"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091DD1E1A05
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157338; cv=none; b=jxZ2FYK0hoyN8B66CxkyxY+rkRv2WkSWNK0wSQQ1+aZL6E0y110x0x5G8vx8wodZzvvbf04SqBqICSZUGB/htuLgCS4CQR2SlmNEUnA7ly7wykRXqWdauhy5Lanq6e3P3kEEMSGBWqEjLIYWxNQNmqxUe4zOyXfGgOh24TsGlzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157338; c=relaxed/simple;
	bh=yOEQ5fr5ybj/a97Lbd6DN7OdxDqqM/4bxavbJoYmMpM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OkgksYRB2fpPx8MqJXLdsTHX41K4wq2IMNioYiS46CPso+PFpa5qkPK06TettfR9/ArPij9htC73+Wt6BfpxpS6knkl69uWJoApTw/uqaxzUM7k2ZjVZydatRAxCedpScQD4CWt+pQBzkJcvcAFCPJTnDBpJCgOTb0rLsAyTxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Q4NM9XOv; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=qtKE/Y1loUtNcdp
	dwBREt/hPkR7NXEswPcVlC1w5L+E=; b=Q4NM9XOvwNVdvlc5gEd9VPq73qTvIcW
	bouYNIyCH1PqRWrw5BlL+OLH/HcwxGn9I6vtg+YX0F22Fk+9ufu5vganc2ToNMp1
	Rl0YPjqxIefCIhr/715Ba//dEqHqk9Ml6f+5Zo8CQce9vsYfOWCAX2uxaBSkD9K2
	8ujvEMy5hUDw=
Received: from ubuntu.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3HyMunNpof+KgBQ--.14253S2;
	Mon, 29 Sep 2025 22:48:16 +0800 (CST)
From: buckzhang1212@yeah.net
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: buckzhang1212@yeah.net
Subject: [PATCH v3] locking/rwsem: add DEBUG_RWSEMS_WARN_ON to warn invalid rwsem
Date: Mon, 29 Sep 2025 07:48:12 -0700
Message-Id: <20250929144812.2211-1-buckzhang1212@yeah.net>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:Ms8vCgD3HyMunNpof+KgBQ--.14253S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4rCF4DGr1fGFy3uw18AFb_yoW8Gr4rpF
	1Yk3s2qrZrXF4xWayIq3ZaqFyUWw1rur97GF9xuw1xJ3sxJrnxXrnxtr13try8GF93ArZa
	vFW3uFW5uayUtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5Z2-UUUUU=
X-CM-SenderInfo: pexfy65kdqwiqsrsq5hhdkh0dhw/1tbiCRvXr2jaZkmSDAAAsp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: "buck.zhang" <buckzhang1212@yeah.net>

Add the lock->magic check to warn invalid rwsem without initialization

Signed-off-by: buck.zhang <buckzhang1212@yeah.net>

---
Changes in v3:
  - Use the lock->magic check in __down_read_common/__down_write_common
  - (Suggested by Waiman Long)
---
 kernel/locking/rwsem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 24df4d98f..38d884643 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1256,6 +1256,9 @@ static __always_inline int __down_read_common(struct rw_semaphore *sem, int stat
 	int ret = 0;
 	long count;
 
+	/* add the lock->magic check to warn the invalid rwsem without initialization */
+	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
+
 	preempt_disable();
 	if (!rwsem_read_trylock(sem, &count)) {
 		if (IS_ERR(rwsem_down_read_slowpath(sem, count, state))) {
@@ -1312,6 +1315,9 @@ static __always_inline int __down_write_common(struct rw_semaphore *sem, int sta
 {
 	int ret = 0;
 
+	/* add the lock->magic check to warn the invalid rwsem without initialization */
+	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
+
 	preempt_disable();
 	if (unlikely(!rwsem_write_trylock(sem))) {
 		if (IS_ERR(rwsem_down_write_slowpath(sem, state)))
-- 
2.17.1


