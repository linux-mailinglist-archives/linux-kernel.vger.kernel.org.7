Return-Path: <linux-kernel+bounces-587790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B22A7B060
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 23:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385C13A7549
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 21:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6651F9F5C;
	Thu,  3 Apr 2025 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VYIFNzKn"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4991C1F9AA6
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712079; cv=none; b=S90N23Hij3RrOE3f0FDoa09ZYZwwtgYyHJGG/hY5U8U8IfT5MiTEJtwEu1m0jGchmVID6J3DEGt0O9ti96HioRbUU3gIGKhmVSYEO8QRofK1q4jrtJVmoEmXko6I9XsHFwLbvT1lb+eg80bM4E5Av+bmUdDREEimDcFi4HA3FMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712079; c=relaxed/simple;
	bh=o34Wm7N9yvonWKFJ1FAFCqSY8wLl2H0sf0PCziZvgZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j8qsQ95Gq4i4NKPAUgXVgRyQ2+G0B/28pcwk2PdZK5mlv5VGEP3AR8DHcmtWht5uzWXqAmIsisW7mgFPvWMjRFdq7c9fnNKjh5yiKbS65xp0AZSStxDykBU4FaQd4lVlG1rOuY9/R1s0dW9Q4ck5hTg2WM3dnenUlzlJgKY4NwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VYIFNzKn; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 3 Apr 2025 16:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743712073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Qfyn75EUB+C3hjqxdtPQcTgA+wSvijx5zHVJq88++QU=;
	b=VYIFNzKn5YY6Ntl+YyuuRgwQaGalweqhxWmlJr2gsfXjFkjhE7WOQ+bcrX5srLnZo2aDQZ
	ArgUlsO/WbX2fhqGFygp9dH6PwOLl++ATE9T41izB5nzBv4EzXGiMWL4ivN5q/oDyQEmLm
	NQQrFxdxibMeOP64dls3q0Zjuhu36Rs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.15-rc1
Message-ID: <6xmil47xtrx6n7aimj4jf3yvobcyfqqfljj2d2fju7etuguquy@r4j6oyqaicmo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

this looks bigger than it is, thanks to the 'kill btree_iter.trans'
patch...

The following changes since commit 650f5353dcc9b6e690a1c763754fa1e98d217bfc:

  bcachefs: fix bch2_write_point_to_text() units (2025-03-30 20:04:16 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-04-03

for you to fetch changes up to 77ad1df82b9e8d169e3ec9ee8b7caabfa45872ce:

  bcachefs: Fix "journal stuck" during recovery (2025-04-03 12:11:43 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.15-rc1

More notable fixes:

- Fix for striping behaviour on tiering filesystems where replicas
  exceeds durability on destination target
- Fix a race in device removal where deleting alloc info races with the
  discard worker
- Some small stack usage improvements: this is just enough for KMSAN
  builds to not blow the stack, more is queued up for 6.16.

----------------------------------------------------------------
Bharadwaj Raju (1):
      bcachefs: use nonblocking variant of print_string_as_lines in error path

Eric Biggers (1):
      bcachefs: add missing selection of XARRAY_MULTI

Kent Overstreet (13):
      bcachefs: Fix striping behaviour
      bcachefs: Fix field spanning write warning
      bcachefs: Fix null ptr deref in bch2_write_endio()
      bcachefs: fix ref leak in btree_node_read_all_replicas
      bcachefs: Split up bch_dev.io_ref
      bcachefs: do_trace_key_cache_fill()
      bcachefs: Kill btree_iter.trans
      bcachefs: bch_dev_usage_full
      bcachefs: Fix scheduling while atomic from logging changes
      bcachefs: Fix check_snapshot_exists() restart handling
      bcachefs: Fix null ptr deref in invalidate_one_bucket()
      bcachefs: backpointer_get_key: check for null from peek_slot()
      bcachefs: Fix "journal stuck" during recovery

Wentao Liang (1):
      bcachefs: Add error handling for zlib_deflateInit2()

 fs/bcachefs/Kconfig                 |   1 +
 fs/bcachefs/acl.c                   |   4 +-
 fs/bcachefs/alloc_background.c      |  95 +++++++++---------
 fs/bcachefs/alloc_background.h      |   6 +-
 fs/bcachefs/alloc_foreground.c      |  79 +++++++++++----
 fs/bcachefs/backpointers.c          |  24 +++--
 fs/bcachefs/bcachefs.h              |   7 +-
 fs/bcachefs/btree_gc.c              |   4 +-
 fs/bcachefs/btree_io.c              |  17 +++-
 fs/bcachefs/btree_iter.c            | 188 ++++++++++++++++++------------------
 fs/bcachefs/btree_iter.h            | 122 ++++++++++++-----------
 fs/bcachefs/btree_key_cache.c       |  32 +++---
 fs/bcachefs/btree_node_scan.c       |   8 +-
 fs/bcachefs/btree_types.h           |   1 -
 fs/bcachefs/btree_update.c          |  26 ++---
 fs/bcachefs/btree_update_interior.c |  12 +--
 fs/bcachefs/btree_write_buffer.c    |  10 +-
 fs/bcachefs/buckets.c               |  16 ++-
 fs/bcachefs/buckets.h               |  21 ++--
 fs/bcachefs/buckets_types.h         |   5 +
 fs/bcachefs/chardev.c               |  14 +--
 fs/bcachefs/compress.c              |   5 +-
 fs/bcachefs/data_update.c           |   8 +-
 fs/bcachefs/debug.c                 |   4 +-
 fs/bcachefs/dirent.c                |  16 +--
 fs/bcachefs/disk_accounting.c       |   4 +-
 fs/bcachefs/disk_groups.c           |   4 +-
 fs/bcachefs/ec.c                    |  18 ++--
 fs/bcachefs/error.c                 |   7 +-
 fs/bcachefs/extent_update.c         |   6 +-
 fs/bcachefs/fs-io-buffered.c        |   6 +-
 fs/bcachefs/fs-io.c                 |  14 +--
 fs/bcachefs/fs.c                    |  24 ++---
 fs/bcachefs/fsck.c                  |  30 +++---
 fs/bcachefs/inode.c                 |  18 ++--
 fs/bcachefs/io_misc.c               |  18 ++--
 fs/bcachefs/io_read.c               |  14 +--
 fs/bcachefs/io_write.c              |  40 +++++---
 fs/bcachefs/journal.c               |  14 ++-
 fs/bcachefs/journal_io.c            |   8 +-
 fs/bcachefs/migrate.c               |   4 +-
 fs/bcachefs/move.c                  |  14 +--
 fs/bcachefs/movinggc.c              |   8 +-
 fs/bcachefs/namei.c                 |  38 ++++----
 fs/bcachefs/quota.c                 |   2 +-
 fs/bcachefs/rebalance.c             |  12 +--
 fs/bcachefs/recovery.c              |   6 +-
 fs/bcachefs/reflink.c               |  23 ++---
 fs/bcachefs/sb-members.h            |  23 ++---
 fs/bcachefs/snapshot.c              |  13 +--
 fs/bcachefs/str_hash.c              |   2 +-
 fs/bcachefs/str_hash.h              |   8 +-
 fs/bcachefs/subvolume.c             |   4 +-
 fs/bcachefs/subvolume.h             |  14 +--
 fs/bcachefs/super-io.c              |  21 ++--
 fs/bcachefs/super.c                 |  85 +++++++++++-----
 fs/bcachefs/tests.c                 |  30 +++---
 fs/bcachefs/xattr.c                 |   2 +-
 58 files changed, 710 insertions(+), 549 deletions(-)

