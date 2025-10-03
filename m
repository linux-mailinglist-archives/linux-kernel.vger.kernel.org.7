Return-Path: <linux-kernel+bounces-841608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 922A1BB7CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CB504E5585
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC102DC761;
	Fri,  3 Oct 2025 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC0WLvIV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D002DC339
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514189; cv=none; b=rSWWNZO0W1a5H5CAIJnMED3d1xulWUKdjUQaMA4LvJiAZg4gt1Fiew+5Pc+1k7RvIuQJKdGQ5whFazHmvmcBzAi5jgSh77HsBUMcUDH/NHXFu9M4IWGdXCJ9kTKpPq+EAsJbjj6/pl/iwsdQSR1nAdMSsRSzEAw7dxrQx05L1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514189; c=relaxed/simple;
	bh=9KCW7Uhqm+iyr1CXL3CkWO3+4qhqMUAqI/DIsF6l3nI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UpxF4Dpm4CRyinKMOewkg2x4sFLzf2ke6vuqM//rmUMTdd5xQWcG6OEctJd+nN46viwtG04bUwipB5sfXp1GaK7eKsi8hp2klR2DOaQX+4xSlcHWFLbNs3LvM4RdsKWv1UCtMxQC413So+Z52OCMqUb25qB5tS+kkSvjULGyoRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pC0WLvIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE387C4CEF9;
	Fri,  3 Oct 2025 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759514189;
	bh=9KCW7Uhqm+iyr1CXL3CkWO3+4qhqMUAqI/DIsF6l3nI=;
	h=Date:From:To:Cc:Subject:From;
	b=pC0WLvIVXeOkIrbvsKc/+0RtR2M/bGdoIt1liZCWpCZkGiIS+bU7hBMImTmNsEqTv
	 gKbuw/s/ph+E7xdh19KhNgLuNopdn6MsYG82LMMUzkvUm19OCLXp6l4VvItUI39BSt
	 DUlXYS6uZqN3YK9my2ppDQ+EcAUmYTBh03PadSjo33DrN9Dkyuelk31fJ2uMX23pVq
	 hKbkMm68czq756FG8ZVOS+OGIONp4nRNOtBeMYM+Mw5wgefOev+SspXnVtIr1Gx6+n
	 dVOZ4+B5UOWE9YFNGoDu4ueQ2tmkPDFA9SlnY4R2OKe49Lt8pT6LplqZsVEzWv+GZX
	 PCZmQfAPxuCyw==
Date: Fri, 3 Oct 2025 17:56:27 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs for 6.18-rc1
Message-ID: <aOAOS864BmSwjfGm@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.18-rc1

for you to fetch changes up to 4e715744bf7b4e5521cc3b77f310060f862cb719:

  f2fs: add missing dput() when printing the donation list (2025-10-03 03:16:10 +0000)

----------------------------------------------------------------
f2fs-for-6.18-rc1

This release focuses on two primary updates for Android devices. First, it sets
hash-based file name lookup as the default method to improve performance, while
retaining an option to fall back to a linear lookup. Second, it resolves a
persistent issue with the checkpoint=enable feature. The update further boosts
performance by prefetching node blocks, merging FUA writes more efficiently, and
optimizing block allocation policies.

The release is rounded out by a comprehensive set of bug fixes that address
memory safety, data integrity, and potential system hangs, along with minor
documentation and code clean-ups.

Enhancement:
 - add mount option and sysfs entry to tune the lookup mode
 - dump more information and add a timeout when enabling/disabling checkpoints
 - readahead node blocks in F2FS_GET_BLOCK_PRECACHE mode
 - merge FUA command with the existing writes
 - allocate HOT_DATA for IPU writes
 - Use allocate_section_policy to control write priority in multi-devices setups
 - add reserved nodes for privileged users
 - Add bggc_io_aware to adjust the priority of BG_GC when issuing IO
 - show the list of donation files

Bug fix:
 - add missing dput() when printing the donation list
 - fix UAF issue in f2fs_merge_page_bio()
 - add sanity check on ei.len in __update_extent_tree_range()
 - fix infinite loop in __insert_extent_tree()
 - fix zero-sized extent for precache extents
 - fix to mitigate overhead of f2fs_zero_post_eof_page()
 - fix to avoid migrating empty section
 - fix to truncate first page in error path of f2fs_truncate()
 - fix to update map->m_next_extent correctly in f2fs_map_blocks()
 - fix wrong layout information on 16KB page
 - fix to do sanity check on node footer for non inode dnode
 - fix to avoid NULL pointer dereference in f2fs_check_quota_consistency()
 - fix to detect potential corrupted nid in free_nid_list
 - fix to clear unusable_cap for checkpoint=enable
 - fix to zero data after EOF for compressed file correctly
 - fix to avoid overflow while left shift operation
 - fix condition in __allow_reserved_blocks()

----------------------------------------------------------------
Bagas Sanjaya (6):
      Documentation: f2fs: Separate errors mode subtable
      Documentation: f2fs: Format compression level subtable
      Documentation: f2fs: Span write hint table section rows
      Documentation: f2fs: Wrap snippets in literal code blocks
      Documentation: f2fs: Indent compression_mode option list
      Documentation: f2fs: Reword title

Chao Yu (22):
      f2fs: dump more information when checkpoint was blocked for long time
      f2fs: add time stats of checkpoint for debug
      f2fs: fix condition in __allow_reserved_blocks()
      f2fs: fix to avoid overflow while left shift operation
      f2fs: fix to zero data after EOF for compressed file correctly
      f2fs: clean up f2fs_truncate_partial_cluster()
      f2fs: fix to clear unusable_cap for checkpoint=enable
      f2fs: fix to detect potential corrupted nid in free_nid_list
      f2fs: add timeout in f2fs_enable_checkpoint()
      f2fs: dump more information for f2fs_{enable,disable}_checkpoint()
      f2fs: clean up w/ get_left_section_blocks()
      f2fs: fix to avoid NULL pointer dereference in f2fs_check_quota_consistency()
      f2fs: fix to allow removing qf_name
      f2fs: fix to do sanity check on node footer for non inode dnode
      f2fs: avoid unnecessary folio_clear_uptodate() for cleanup
      f2fs: clean up error handing of f2fs_submit_page_read()
      f2fs: fix to update map->m_next_extent correctly in f2fs_map_blocks()
      f2fs: fix to truncate first page in error path of f2fs_truncate()
      f2fs: fix to avoid migrating empty section
      f2fs: fix to mitigate overhead of f2fs_zero_post_eof_page()
      f2fs: add sanity check on ei.len in __update_extent_tree_range()
      f2fs: fix UAF issue in f2fs_merge_page_bio()

Chunhai Guo (1):
      f2fs: add reserved nodes for privileged users

Daniel Lee (2):
      f2fs: add lookup_mode mount option
      f2fs: add sysfs entry for effective lookup mode

Jaegeuk Kim (5):
      f2fs: show the list of donation files
      f2fs: allocate HOT_DATA for IPU writes
      f2fs: merge FUA command with the existing writes
      f2fs: fix wrong layout information on 16KB page
      f2fs: add missing dput() when printing the donation list

Liao Yuanhong (2):
      f2fs: Add bggc_io_aware to adjust the priority of BG_GC when issuing IO
      f2fs: Use allocate_section_policy to control write priority in multi-devices setups

Soham Metha (1):
      docs: f2fs: fixed spelling mistakes in documentation

Yunji Kang (1):
      f2fs: readahead node blocks in F2FS_GET_BLOCK_PRECACHE mode

mason.zhang (1):
      f2fs: add error checking in do_write_page()

wangzijie (2):
      f2fs: fix zero-sized extent for precache extents
      f2fs: fix infinite loop in __insert_extent_tree()

 Documentation/ABI/testing/sysfs-fs-f2fs |  56 ++++++++++++++-
 Documentation/filesystems/f2fs.rst      | 122 ++++++++++++++++++++------------
 fs/f2fs/checkpoint.c                    |  53 ++++++++++++++
 fs/f2fs/compress.c                      |  43 ++++++-----
 fs/f2fs/data.c                          |  59 ++++++---------
 fs/f2fs/dir.c                           |  17 ++++-
 fs/f2fs/extent_cache.c                  |  15 ++++
 fs/f2fs/f2fs.h                          |  88 ++++++++++++++++++-----
 fs/f2fs/file.c                          |  49 +++++++------
 fs/f2fs/gc.c                            |  25 ++++++-
 fs/f2fs/node.c                          |  77 ++++++++++++++------
 fs/f2fs/node.h                          |   1 +
 fs/f2fs/recovery.c                      |   2 +-
 fs/f2fs/segment.c                       |  30 +++++++-
 fs/f2fs/segment.h                       |  28 ++++----
 fs/f2fs/super.c                         | 121 +++++++++++++++++++++++++++----
 fs/f2fs/sysfs.c                         | 119 ++++++++++++++++++++++++++++++-
 include/linux/f2fs_fs.h                 |   1 +
 18 files changed, 702 insertions(+), 204 deletions(-)

