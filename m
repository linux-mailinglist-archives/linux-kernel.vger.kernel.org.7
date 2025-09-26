Return-Path: <linux-kernel+bounces-834123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE9ABA3EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5CA2A5A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDE413D503;
	Fri, 26 Sep 2025 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXe0h6Oe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C62557A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894417; cv=none; b=oj9knAH/Lb52BuQCI/VuIJfcTkuz8YU/3kG8Wzqqm01qv2C+nbewXmHKVB7TfMxr78vO8/ugeA8++zK3A4tjLXRboly0gscyCseUOYCXu1aUfjWwXlC7b03uGSbeOqdn5Zoflite7FWo7Amef4dEwf2BQJQmc8qyfp6YiNEO0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894417; c=relaxed/simple;
	bh=Uil5RxYj3B6Y04gkxtNp85CMZou3iFkcl0DLi/G3aUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hPhZNRYJDWK1bN9VQClO9EnZeoc6TbfChYRyIhpCiTMhZI7AJdViDylTCBnH2UBiWG/1WG4ML0HEnS+5oRJv/4wmYrqRXdLy7UqKXEdzGghhX2+dhXK4M20svXVuFmhjagiwWmkDUCGMILwNGghv8FVqLvYgqsj9SySioMkZis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXe0h6Oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7099C4CEF4;
	Fri, 26 Sep 2025 13:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894416;
	bh=Uil5RxYj3B6Y04gkxtNp85CMZou3iFkcl0DLi/G3aUo=;
	h=Date:From:To:Cc:Subject:From;
	b=sXe0h6Oe8+Gj9jybzGHOSxHaFrzTrW7wXAb06Zt1bgWiL0weV0xMYyPfuXbyH8dhy
	 ZRyHUByVp8IW9o7/jZpY7UlpT7WbG825A50shSnDXXMQeGeg0ueUD7oErpz2lPL0o/
	 /DkrZ0OC9fjnW90sxf4P9mGwG73N2wnGOHefQUfOZ/lDNFT9sjXmJExZfDGAzA7wdr
	 dVTWKKUTkffNylpH9AMjoB8vUsjOI+NrolKn/oEbZXDtoWrh8BFYEQf549Bwc6fR3x
	 KWMsNVMEgZpE7r8TA07pPutisgZ+7swjfQqIS6nYWCU9cEggwf0H+CuUPGODFK89dJ
	 voCWNc7F5hYBQ==
Date: Fri, 26 Sep 2025 15:46:51 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] locking fixes
Message-ID: <aNaZSyaGxaEnKArg@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-09-26

   # HEAD: 4ec3c15462b9f44562f45723a92e2807746ba7d1 futex: Use correct exit on failure from futex_hash_allocate_default()

Fix a PI-futexes race, and fix a copy_process() futex
cleanup bug.

 Thanks,

	Ingo

------------------>
Sebastian Andrzej Siewior (2):
      futex: Prevent use-after-free during requeue-PI
      futex: Use correct exit on failure from futex_hash_allocate_default()


 kernel/fork.c          | 2 +-
 kernel/futex/requeue.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

