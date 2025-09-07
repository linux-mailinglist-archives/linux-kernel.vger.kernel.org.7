Return-Path: <linux-kernel+bounces-804609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 539C4B47A6C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B431189D1D9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0156C221F12;
	Sun,  7 Sep 2025 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRLAtjph"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610CC1F0994
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757240212; cv=none; b=PX7SK+3kbbI5D75m8C2am7oDXWQ8Vftdzqy1dOp75X7z9vAUtJ+oFnHa+cgM0dv1WHWYByNVxg9ZP3W+EO07C9lQx2/xE6so182vaqim8ITFR4YdT3YUNCYCgPYsHoHvCwkxHQzcM8RQkvAm15cgfcON3PQQlRccYpMDkjjZ6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757240212; c=relaxed/simple;
	bh=ToirCarSyby33Z9r+lpDSNyHCXgfVCJ+QEwxKQqoQgU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HmzND5ey26Umdq1+accrjtC/jXz/Y9hiwPVf2f9nxQ3+/kXdDXvsrkntNwU2xld51AhorMk8dlVIP8y7xBzXF42NwjfaUuQ/lRi8a/kGfcpK6g/O7/qzbRDttVt5YOUtq3K9vFG/v6NGRLkvZyMkpqVxFh6HoUEaY289ZZooux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRLAtjph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB72C4CEF0;
	Sun,  7 Sep 2025 10:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757240210;
	bh=ToirCarSyby33Z9r+lpDSNyHCXgfVCJ+QEwxKQqoQgU=;
	h=Date:From:To:Cc:Subject:From;
	b=iRLAtjphaLbilbKrlnjGx9kDW5HCh6c2dN+CSEYxu25yAfaTrla6+j7HG29ldHj4H
	 +2nDcu1/FthIenjc9Q95GlvIjWR1Vlf52zKxaU8KiD2XsiwrO/kxJplbMoLnJ8x7+p
	 iao/EbivkBKwDAVDwCEJturxymYz2prT0RBtCAlsgrj8TuuOKGiMjT7Fu6F/QzHfNz
	 8IW9e6p/UzTn8MlomxMZ3Mp4b4lSVoUmj953W/JRUU/vyPkNxAH1p87xvd/IMSmztZ
	 jFTL3prH/1s90cwqENo67wdn0dVX6T05eLy8lgI7oLGJLDqOq4VvYMsvS8N6DTPn7u
	 ath5ss+VyHjuw==
Date: Sun, 7 Sep 2025 12:16:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] locking fix
Message-ID: <aL1bjoRQEfRZ4-Gn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest locking/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-09-07

   # HEAD: d9b05321e21e4b218de4ce8a590bf375f58b6346 futex: Move futex_hash_free() back to __mmput()

Fix an 'allocation from atomic context' regression in the futex vmalloc
variant.

 Thanks,

	Ingo

------------------>
Sebastian Andrzej Siewior (1):
      futex: Move futex_hash_free() back to __mmput()


 kernel/fork.c       |  2 +-
 kernel/futex/core.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

