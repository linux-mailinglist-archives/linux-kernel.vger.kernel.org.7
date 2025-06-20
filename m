Return-Path: <linux-kernel+bounces-694714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB7AE0FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 01:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18371BC4325
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 23:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF3E28C870;
	Thu, 19 Jun 2025 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RbHjnOUG"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A5B30E826;
	Thu, 19 Jun 2025 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750374375; cv=none; b=Bkg+3ZY5J27pPiNEg7wgLSuLFqDhwLqOtyaeqNPbbieRdSIOfmBwenFtvqVxguS5u5RLf08fE05g8JoiDgnWv+9PjZa0Y5+psVpK0rVn7cBSI+0Ro9ZSbjtAtCzmb47mpFGAwlEmaGWIx9ok+fKm91vsq5sNjDqJy9N20v085js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750374375; c=relaxed/simple;
	bh=xLSzef8OBKp8WdSidUaWKWCzj3aDKaduxackxq7J+rw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sE22zodF922u2lx6l2/tIudjSyOpC6zFN5C39f/EagK2hdj+BaDdE+VyHi41QWC6Zi833+OqWX0bezmmEWzVlvuoa67srqDt8rTxG2pEAL78BDGo5J57AVgg33d7xkpPF1TjHxY4P600HAfmDUhAzmhwRW1Enku8Fwg+2cVTmYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RbHjnOUG; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 19 Jun 2025 19:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750374369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5LTGIqYt6iAiPr4P7jFH6TzoG7BfNPLA+2XxRHz76y4=;
	b=RbHjnOUGIRQOiSZ3X3qm6q6z0BJ81fDvVlm3U+XdPWGD/bJ+iy7U3LKuE0kQ/Of91H4LgY
	HQXsw+4fGxdy9l+BPBTh53hPMdLb/+m36OWAzEcg7pBYNrmSYgmCGtqkTzIq/9axTgRo/a
	qu86og7+6IS1A33Aa38P0AZ+s7eaQv0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.16-rc3
Message-ID: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Entirely too many patches, but mostly check/repair, and related.

6.16 looks to be shaping up well, knock on wood.

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-06-19

for you to fetch changes up to b2e2bed119809a5ca384241e0631f04c6142ae08:

  bcachefs: Add missing key type checks to check_snapshot_exists() (2025-06-19 14:37:04 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.16-rc3

- Lots of small check/repair fixes, primarily in subvol loop and
  directory structure loop (when involving snapshots).

- Fix a few 6.16 regressions: rare UAF in the foreground allocator path
  when taking a transaction restart from the transaction bump allocator,
  and some small fallout from the change to log the error being
  corrected in the journal when repairing errors, also some fallout from
  the btree node read error logging improvements.

  (Alan, Bharadwaj)

- New option: journal_rewind

  This lets the entire filesystem be reset to an earlier point in time.

  Note that this is only a disaster recovery tool, and right now there
  are major caveats to using it (discards should be disabled, in
  particular), but it successfully restored the filesystem of one of the
  users who was bit by the subvolume deletion bug and didn't have
  backups. I'll likely be making some changes to the discard path in the
  future to make this a reliable recovery tool.

- Some new btree iterator tracepoints, for tracking down some
  livelock-ish behaviour we've been seeing in the main data write path.

----------------------------------------------------------------
Alan Huang (6):
      bcachefs: Don't allocate new memory when mempool is exhausted
      bcachefs: Fix alloc_req use after free
      bcachefs: Add missing EBUG_ON
      bcachefs: Delay calculation of trans->journal_u64s
      bcachefs: Move bset size check before csum check
      bcachefs: Fix pool->alloc NULL pointer dereference

Bharadwaj Raju (1):
      bcachefs: don't return fsck_fix for unfixable node errors in __btree_err

Kent Overstreet (33):
      bcachefs: trace_extent_trim_atomic
      bcachefs: btree iter tracepoints
      bcachefs: Fix bch2_journal_keys_peek_prev_min()
      bcachefs: btree_iter: fix updates, journal overlay
      bcachefs: better __bch2_snapshot_is_ancestor() assert
      bcachefs: pass last_seq into fs_journal_start()
      bcachefs: Fix "now allowing incompatible features" message
      bcachefs: Fix snapshot_key_missing_inode_snapshot repair
      bcachefs: fsck: fix add_inode()
      bcachefs: fsck: fix extent past end of inode repair
      bcachefs: opts.journal_rewind
      bcachefs: Kill unused tracepoints
      bcachefs: mark more errors autofix
      bcachefs: fsck: Improve check_key_has_inode()
      bcachefs: Call bch2_fs_init_rw() early if we'll be going rw
      bcachefs: Fix __bch2_inum_to_path() when crossing subvol boundaries
      bcachefs: fsck: Print path when we find a subvol loop
      bcachefs: fsck: Fix remove_backpointer() for subvol roots
      bcachefs: fsck: Fix reattach_inode() for subvol roots
      bcachefs: fsck: check_directory_structure runs in reverse order
      bcachefs: fsck: additional diagnostics for reattach_inode()
      bcachefs: fsck: check_subdir_count logs path
      bcachefs: fsck: Fix check_path_loop() + snapshots
      bcachefs: Fix bch2_read_bio_to_text()
      bcachefs: Fix restart handling in btree_node_scrub_work()
      bcachefs: fsck: Fix check_directory_structure when no check_dirents
      bcachefs: fsck: fix unhandled restart in topology repair
      bcachefs: fsck: Fix oops in key_visible_in_snapshot()
      bcachefs: fix spurious error in read_btree_roots()
      bcachefs: Fix missing newlines before ero
      bcachefs: Fix *__bch2_trans_subbuf_alloc() error path
      bcachefs: Don't log fsck err in the journal if doing repair elsewhere
      bcachefs: Add missing key type checks to check_snapshot_exists()

 fs/bcachefs/alloc_background.c         |  13 +-
 fs/bcachefs/bcachefs.h                 |   3 +-
 fs/bcachefs/btree_gc.c                 |   8 +-
 fs/bcachefs/btree_io.c                 |  74 ++++----
 fs/bcachefs/btree_iter.c               | 173 ++++++++++++------
 fs/bcachefs/btree_journal_iter.c       |  64 ++++---
 fs/bcachefs/btree_journal_iter_types.h |   5 +-
 fs/bcachefs/btree_trans_commit.c       |  18 +-
 fs/bcachefs/btree_types.h              |   1 +
 fs/bcachefs/btree_update.c             |  16 +-
 fs/bcachefs/btree_update_interior.c    |  11 +-
 fs/bcachefs/btree_update_interior.h    |   3 +
 fs/bcachefs/btree_write_buffer.c       |   3 +
 fs/bcachefs/chardev.c                  |  29 ++-
 fs/bcachefs/data_update.c              |   1 +
 fs/bcachefs/errcode.h                  |   5 -
 fs/bcachefs/error.c                    |   4 +-
 fs/bcachefs/extent_update.c            |  13 +-
 fs/bcachefs/fsck.c                     | 317 +++++++++++++++++++++++----------
 fs/bcachefs/inode.h                    |   5 +
 fs/bcachefs/io_read.c                  |   7 +-
 fs/bcachefs/journal.c                  |  18 +-
 fs/bcachefs/journal.h                  |   2 +-
 fs/bcachefs/journal_io.c               |  26 ++-
 fs/bcachefs/namei.c                    |  30 +++-
 fs/bcachefs/opts.h                     |   5 +
 fs/bcachefs/recovery.c                 |  24 ++-
 fs/bcachefs/recovery_passes.c          |   6 +-
 fs/bcachefs/recovery_passes.h          |   9 +
 fs/bcachefs/sb-errors_format.h         |  17 +-
 fs/bcachefs/snapshot.c                 |  14 +-
 fs/bcachefs/super.c                    |  13 +-
 fs/bcachefs/super.h                    |   1 +
 fs/bcachefs/trace.h                    | 125 +++----------
 34 files changed, 657 insertions(+), 406 deletions(-)

