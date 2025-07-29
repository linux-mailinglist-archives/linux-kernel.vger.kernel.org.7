Return-Path: <linux-kernel+bounces-749001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634DAB148BC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F924E6220
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9570926F461;
	Tue, 29 Jul 2025 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMlMg9SZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D9A29
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771929; cv=none; b=c+rAKxYlgbOZtzEjoFw0/5SFixwu9Ma/xSyrAq0LOWXdAFoj2J3wniYLHiJUXh7qR4+bzWP/OmgkG0Sq05hnfQzEvQdqVxS7rMJiy9STnC+lEf6mMxdhP7iQGwaMA4hmmYxIx/LWrTnI3krRJkNuO/93cDLh0Hz8fIG5+lFw7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771929; c=relaxed/simple;
	bh=2I87PVh90yHpIaOHwMH7ZWxH3Y5MH2smNr2UTG8cOJs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eGJwYGd43PysinOYvCGhYO/QGxmlLmLpLoHp+l7fydey0hXkFxDxTSZHdj/fwG44/dQuVdpq6Sjyax+zxlqx9xfmyM1VhjlIZSd/wBWER5rxddaykMGL0qz+qJF5E6B6Uj82f2l2CgsqJ76QRnDgJ7w73tnJGcd88nGm1Ab8iJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMlMg9SZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED74C4CEEF;
	Tue, 29 Jul 2025 06:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753771928;
	bh=2I87PVh90yHpIaOHwMH7ZWxH3Y5MH2smNr2UTG8cOJs=;
	h=Date:From:To:Cc:Subject:From;
	b=bMlMg9SZIRzL0DriK/8smK3p4n1delxyEli3fUz7q+eZkUwBrcwCCPjHocrEy8K18
	 lkIwgOKmj2lWlllUE5GbKdgFU6mhhLV2CeR18IwsQ3kDfnQO8xk5IK0BlX9AE0sY3B
	 btR1e8U7Fl8gYBi30QScVNxKWbyE1SZWDp6pkwg8UBHzpoIM1WXMztgbZcdD2XEspH
	 jbyQj0dF87GCbD8KMLYjSMswze/XA3V94WRZ6HvuOkwC6xgMXsait7o2IW+OaKwgsi
	 nuxTjOnigWQfwjgXLuZef/IE4rBu8HQtztz/FZzvWlytr7EdGKDV0yk8vM9vB6QqNG
	 Oant9CWUirCIQ==
Date: Tue, 29 Jul 2025 08:52:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>, Uros Bizjak <ubizjak@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [GIT PULL] locking changes for v6.17
Message-ID: <aIhvlNUoN5KyPzg6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull the latest locking/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2025-07-29

   # HEAD: ba28549bad8ab2b09264ebc8c2ca24af3537ee52 Merge tag 'lockdep-for-tip.2025.07.16' of git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux into locking/core

Locking updates for v6.16:

Locking primitives:

  - Mark devm_mutex_init() as __must_check and fix drivers
    that didn't check the return code. (Thomas Weiﬂschuh)

  - Reorganize <linux/local_lock.h> to better expose the
    internal APIs to local variables. (Sebastian Andrzej Siewior)

  - Remove OWNER_SPINNABLE in rwsem (Jinliang Zheng)

  - Remove redundant #ifdefs in the mutex code (Ran Xiaokai)

Lockdep:

  - Avoid returning struct in lock_stats() (Arnd Bergmann)

  - Change `static const` into enum for LOCKF_*_IRQ_*
    (Arnd Bergmann)

  - Temporarily use synchronize_rcu_expedited() in
    lockdep_unregister_key() to speed things up.
    (Breno Leitao)

Rust runtime:

  - Add #[must_use] to Lock::try_lock() (Jason Devers)

 Thanks,

	Ingo

------------------>
Arnd Bergmann (2):
      locking/lockdep: Avoid struct return in lock_stats()
      locking/lockdep: Change 'static const' variables to enum values

Breno Leitao (1):
      lockdep: Speed up lockdep_unregister_key() with expedited RCU synchronization

Jason Devers (1):
      rust: sync: Add #[must_use] to Lock::try_lock()

Jinliang Zheng (1):
      locking/rwsem: Use OWNER_NONSPINNABLE directly instead of OWNER_SPINNABLE

Ran Xiaokai (1):
      locking/mutex: Remove redundant #ifdefs

Sebastian Andrzej Siewior (1):
      local_lock: Move this_cpu_ptr() notation from internal to main header

Thomas Weiﬂschuh (3):
      spi: spi-nxp-fspi: Check return value of devm_mutex_init()
      leds: lp8860: Check return value of devm_mutex_init()
      locking/mutex: Mark devm_mutex_init() as __must_check


 drivers/leds/leds-lp8860.c          |  4 +++-
 drivers/spi/spi-nxp-fspi.c          |  4 +++-
 include/linux/local_lock.h          | 20 +++++++++----------
 include/linux/local_lock_internal.h | 30 ++++++++++++++--------------
 include/linux/lockdep_types.h       |  2 +-
 include/linux/mutex.h               | 11 +++++++----
 kernel/locking/lockdep.c            | 39 +++++++++++++++++++++----------------
 kernel/locking/lockdep_internals.h  | 18 +++++++++--------
 kernel/locking/lockdep_proc.c       |  2 +-
 kernel/locking/mutex.c              |  4 ----
 kernel/locking/rwsem.c              |  4 +---
 rust/kernel/sync/lock.rs            |  2 ++
 12 files changed, 75 insertions(+), 65 deletions(-)

