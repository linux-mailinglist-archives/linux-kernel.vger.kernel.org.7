Return-Path: <linux-kernel+bounces-601753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76041A871F2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 14:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55ED617511C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 12:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B091B041E;
	Sun, 13 Apr 2025 12:37:49 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6DB1990AF
	for <linux-kernel@vger.kernel.org>; Sun, 13 Apr 2025 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744547869; cv=none; b=UpzJY/6zhtm89KqwCsss5dllyyLYp2rwtjQmWYiyI6eJtewITKE3JKQ6JX1IOns/TcqThvry4DfJLA+2a9dZAHKIs9nEdQHnhVOBEqpamp7rLLBcl6LtgHnGe1tM8X6vy/QVQhraJfK9RljcTbcheIl6cXATh8wmWSD35YcZdf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744547869; c=relaxed/simple;
	bh=H/Zwrzyw0D8VXwhrddeUW3ZXA2N5G0mJ/+sbNP1LMnA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qyX/o0nG1tPU3yZbLo/Kq77NJaBuB8UzAGzXBQxVXKqDuXgHuPMPLfG/higM6JF/lPw2tLlO3SH+tyRcUupTI1SJcscAjGBG1Uhp6/s3UB9DMfn0IcB0l71S+s+9wdiHxu6jqlasjCCXvgRo/CyCMhrVuHTUr+G/WfRBHvF843w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-137.bstnma.fios.verizon.net [173.48.82.137])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53DCbb2Z008458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Apr 2025 08:37:38 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 5205B2E00E9; Sun, 13 Apr 2025 08:37:37 -0400 (EDT)
Date: Sun, 13 Apr 2025 08:37:37 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ext4 bug fixes for v6.15-rc2
Message-ID: <20250413123737.GA1116899@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d5e206778e96e8667d3bde695ad372c296dc9353:

  ext4: fix OOB read when checking dotdot dir (2025-03-21 01:33:11 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.15-rc2

for you to fetch changes up to 94824ac9a8aaf2fb3c54b4bdde842db80ffa555d:

  ext4: fix off-by-one error in do_split (2025-04-12 22:07:36 -0400)

----------------------------------------------------------------
A few more miscellaneous ext4 bug fixes and cleanups including some
syzbot failures and fixing a stale file handing refeencing an inode
previously used as a regular file, but which has been deleted and
reused as an ea_inode would result in ext4 erroneously consider this a
case of fs corrupotion.

----------------------------------------------------------------
Artem Sadovnikov (1):
      ext4: fix off-by-one error in do_split

Gustavo A. R. Silva (1):
      ext4: avoid -Wflex-array-member-not-at-end warning

Jann Horn (1):
      ext4: don't treat fhandle lookup of ea_inode as FS corruption

Ojaswin Mujoo (1):
      ext4: make block validity check resistent to sb bh corruption

Tom Vierjahn (1):
      Documentation: ext4: Add fields to ext4_super_block documentation

 Documentation/filesystems/ext4/super.rst | 20 ++++++++++++-----
 fs/ext4/block_validity.c                 |  5 ++---
 fs/ext4/inode.c                          | 75 +++++++++++++++++++++++++++++++++++++++++++-------------------
 fs/ext4/mballoc.c                        | 18 +++++++--------
 fs/ext4/namei.c                          |  2 +-
 5 files changed, 77 insertions(+), 43 deletions(-)

