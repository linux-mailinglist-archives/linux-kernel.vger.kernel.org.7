Return-Path: <linux-kernel+bounces-619465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1EDA9BD05
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 04:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0FB1BA1A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D79149C7B;
	Fri, 25 Apr 2025 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p2b0bGHa"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44222301
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745549212; cv=none; b=kK442HAvUWLcTTnEc0pw9RK5TIw054IcG+V+wn4h8jc1Sf89h76o0n9OyX9droeCD5WpkPv0uX67vXbUKNvOAkarPR/L1vLvSzM9XWbOrqJBaAD1Be44XjkBcMoiNwwJA8BzRujv3DoHFImhUjCHYS0Xl1Kku9Q1f4XzZewRVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745549212; c=relaxed/simple;
	bh=5dEn1plV5SFiE2PW7pLlDnazK1bNogo2iAFwMfX8Dk4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cskloc1u3IoF0vxRJGS1SrDXXlDGqk+qhaBtENU4AOKz4kIqEvybpi/NcCbeC1XQiZXwWQ5yp37LyFNfzUYN1vhxvRG/5MxAZEv16kkRFuI+FY9hE/rqwGjqa2QpHtN09ozluSXVhZUM3RfqlX6pmEqSbmGpF04bSndF5Z+wCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p2b0bGHa; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Apr 2025 22:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745549206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ycMFYWYKO4MM+P9nKNfIq2LiY2lRzD5QgAqzAbjZCxY=;
	b=p2b0bGHaGjiHm/w0wYFpsbs7qR52yMq+/WbfGpd2TDjeE1WGQsPjjF1pHtoUNYHnAPd4vQ
	EcDQQjU0Zp1g4dHAr/5d0duHfYXJmehKJziiX9vj+ER1Sm5MGdGpo3YAJvpfF+692L5j4R
	7s6gYBR1Nq+LpZvkAhydz5W8oXRdpyM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

There's a story behind the case insensitive directory fixes, and lessons
to be learned.

When I was discussing with the developer who did the implementation, I
noted that fstests should already have tests.

However, it seems I neglected to tell him to make sure the tests
actually run. So, there's a lesson here, and since inadequate testing
keeps coming up, let me state it now:

It is _not_ enough to simply rely on the automated tests.

You have to have eyes on what your code is doing. That means that until
you've thoroughly Familiarized yourself with the code you're working on
and the test suites, you need to look - with your eyes - and confirm
that the tests are doing what you think they're doing and your code is
doing what you think it's doing.

If you're not 100% sure that your code is doing what you think it's
doing, it's your responsibility to dig in and verify - add printks,
tracepoints, counters, whatever it takes.

Automated test infrastructure is a backstop because there are times when
we are all forgetful and miss things.

You have to run your code locally, and look at what it does. I've
provided good tools for this. If you're working on my code, make sure
you're using them.

The following changes since commit 9c32cda43eb78f78c73aee4aa344b777714e259b:

  Linux 6.15-rc3 (2025-04-20 13:43:47 -0700)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-04-24

for you to fetch changes up to d1b0f9aa73fe50ee5276708e33d77c4e7054e555:

  bcachefs: Rework fiemap transaction restart handling (2025-04-24 19:10:29 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.15-rc4

- Case insensitive directories now work
- Ciemap now correctly reports on unwritten pagecache data
- bcachefs tools 1.25.1 was incorrectly picking unaligned bucket sizes;
  fix journal and write path bugs this uncovered

And assorted smaller fixes...

----------------------------------------------------------------
Brian Foster (4):
      bcachefs: drop duplicate fiemap sync flag
      bcachefs: track current fiemap offset in start variable
      bcachefs: refactor fiemap processing into extent helper and struct
      bcachefs: add fiemap delalloc extent detection

Kent Overstreet (20):
      bcachefs: Fix early startup error path
      bcachefs: Fix null ptr deref in bch2_snapshot_tree_oldest_subvol()
      bcachefs: Error ratelimiting is no longer only during fsck
      bcachefs: Stricter checks on "key allowed in this btree"
      bcachefs: Ensure journal space is block size aligned
      bcachefs: Change __journal_entry_close() assert to ERO
      bcachefs: Fix ref leak in write_super()
      bcachefs: bch2_copygc_wakeup()
      bcachefs: Refactor bch2_run_recovery_passes()
      bcachefs: Start copygc, rebalance threads earlier
      bcachefs: Allocator now copes with unaligned buckets
      bcachefs: Implement fileattr_(get|set)
      bcachefs: Casefold is now a regular opts.h option
      bcachefs: Fix casefold lookups
      bcachefs: unlink: casefold d_invalidate
      bcachefs: Print mount opts earlier
      bcachefs: Unit test fixes
      bcachefs: Make btree_iter_peek_prev() assert more precise
      bcachefs: Fix btree_iter_peek_prev() at end of inode
      bcachefs: Rework fiemap transaction restart handling

 fs/bcachefs/alloc_foreground.c |   2 +
 fs/bcachefs/alloc_foreground.h |   4 +-
 fs/bcachefs/bcachefs_format.h  |  81 +++----
 fs/bcachefs/bkey_methods.c     |  24 ++-
 fs/bcachefs/btree_iter.c       |   7 +-
 fs/bcachefs/dirent.c           |  16 +-
 fs/bcachefs/dirent.h           |  15 ++
 fs/bcachefs/error.c            |  17 +-
 fs/bcachefs/error.h            |   1 +
 fs/bcachefs/fs-ioctl.c         | 217 -------------------
 fs/bcachefs/fs-ioctl.h         |  75 -------
 fs/bcachefs/fs.c               | 469 ++++++++++++++++++++++++++++++++++-------
 fs/bcachefs/inode.h            |   8 +
 fs/bcachefs/inode_format.h     |   9 +-
 fs/bcachefs/journal.c          |  36 +++-
 fs/bcachefs/journal.h          |   7 +-
 fs/bcachefs/journal_reclaim.c  |   5 +-
 fs/bcachefs/movinggc.c         |   7 +
 fs/bcachefs/movinggc.h         |   9 +
 fs/bcachefs/namei.c            |   4 -
 fs/bcachefs/opts.h             |   5 +
 fs/bcachefs/rebalance.c        |  11 +-
 fs/bcachefs/rebalance.h        |   2 +-
 fs/bcachefs/recovery.c         |  10 +-
 fs/bcachefs/recovery_passes.c  |  70 +++---
 fs/bcachefs/snapshot.c         |   2 +-
 fs/bcachefs/str_hash.h         |   5 +-
 fs/bcachefs/super-io.c         |   3 +-
 fs/bcachefs/super.c            | 150 ++++++-------
 fs/bcachefs/sysfs.c            |   7 +-
 fs/bcachefs/tests.c            |   4 +
 fs/bcachefs/util.h             |  38 ++++
 32 files changed, 735 insertions(+), 585 deletions(-)

