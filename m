Return-Path: <linux-kernel+bounces-609832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABBEA92C33
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 22:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEE91B6604E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 20:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844DF1FF1B4;
	Thu, 17 Apr 2025 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oMHKWQTf"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02A1DE3BA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744921258; cv=none; b=f9tuxnou8RfBdiW4OySe3qc3n83WJgYu7DGnXwJL4PTcW6+bHg5+Zm3HTuut1KVcD49WvcQA5NZNfSfsQlyzCcN27+X4UZyNaxiv0fXhsKg8wIzJfObd5ZwUGfdsl3He1SQohWWm1QRUdUT6XUI+EROEVKdcYRtyAWyxayZ94zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744921258; c=relaxed/simple;
	bh=NOzKJ16Dq4ZzWO2366ebpR8ZvmkGK2bW/QsNdyRzKsU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WPA9V+FiRXsRQqOny4E1G2XuvGYNGLvAQmKnbbaJm4yiRLbRWtuAjFQ7YtH3VdMoCBgyhsE03Y8JJg80eApDOoPCCe77nB5cBvhpLEb6kH1AN5/AeZmiJM+adX0PCTDl0ogpIJ0XkY2M82UcDwIe12+CGjsy4+/wymGxOimIJGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oMHKWQTf; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Apr 2025 16:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744921252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XVJNXXLirTbmQpT/jz5nyyTQmlMlCWPiIqciJgdTOKU=;
	b=oMHKWQTfnLaHgzDK24CGujoLoSBSHtlbkIHeWjVx/OC0ptx+EkOKdhaOmmhLQS6aojS5Jl
	kxz/+2KRfKMkHBkozgJNhF6r4xaxweF9XJquJkCsq8CXoZvX2VDF6kXEgZbtJR22GevKFA
	qReimPq2HpCjq0tcpXQmGIjDGEfiAF0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vge.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.15-rc3
Message-ID: <jnnywf5k3qydxwrh6ur6ap6wjr7fpb32af3frnqsfvntwrvuba@wpr4uofgwpu5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

6.15 is looking good here.

The following changes since commit 55fd97fbc4744a43fb2d134908e481266cf33bda:

  bcachefs: Use sort_nonatomic() instead of sort() (2025-04-06 19:33:53 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-04-17

for you to fetch changes up to 261592ba06aa44001ab95fd47bafa4225bab25cf:

  bcachefs: Fix snapshotting a subvolume, then renaming it (2025-04-17 14:17:16 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.15-rc3

Usual set of small fixes/logging improvements.

One bigger user reported fix, for inode <-> dirent inconsistencies
reported in fsck, after moving a subvolume that had been snapshotted.

----------------------------------------------------------------
Alan Huang (1):
      bcachefs: Add missing error handling

Gabriel Shahrouzi (1):
      bcachefs: Prevent granting write refs when filesystem is read-only

Kent Overstreet (9):
      bcachefs: Don't print data read retry success on non-errors
      bcachefs: fix bch2_dev_usage_full_read_fast()
      bcachefs: btree_root_unreadable_and_scan_found_nothing now AUTOFIX
      bcachefs: Silence extent_poisoned error messages
      bcachefs: Print version_incompat_allowed on startup
      bcachefs: Log message when incompat version requested but not enabled
      bcachefs: snapshot_node_missing is now autofix
      bcachefs: Add missing READ_ONCE() for metadata replicas
      bcachefs: Fix snapshotting a subvolume, then renaming it

 fs/bcachefs/bcachefs.h              |  2 ++
 fs/bcachefs/btree_update_interior.c |  2 +-
 fs/bcachefs/buckets.c               |  3 ++-
 fs/bcachefs/buckets.h               |  5 -----
 fs/bcachefs/errcode.h               |  2 +-
 fs/bcachefs/extents.c               |  2 +-
 fs/bcachefs/fs-ioctl.c              |  2 +-
 fs/bcachefs/fsck.c                  | 44 ++++++++++++++++++++++++++++++++++++-
 fs/bcachefs/io_read.c               | 24 ++++++++++++--------
 fs/bcachefs/recovery.c              |  5 ++++-
 fs/bcachefs/sb-errors_format.h      |  4 ++--
 fs/bcachefs/super-io.c              | 20 +++++++++++++++--
 fs/bcachefs/super.c                 |  9 +++++++-
 13 files changed, 98 insertions(+), 26 deletions(-)

