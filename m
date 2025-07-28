Return-Path: <linux-kernel+bounces-747380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331EB1332A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A893E17441D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8F61F5434;
	Mon, 28 Jul 2025 02:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsPxrXbB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320047404E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753671084; cv=none; b=iWXuvnf2ev6l8EPE4Ly2ZnWJwuMQljBCIXtfHvpfO/IEiPp4HGzqthnCnlbefhHKrtLuIFKvD+y7zBEPecxAx+gDXila14GuXuw2X3JXSwSmmy7m+pMSh3Yf+QTvKtCIoWCPlwCLTZHTmOuoC0Xol468aog6fzFumtmrOrIT90U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753671084; c=relaxed/simple;
	bh=Ka6HpcbV3v4iMb9TmNQTjH+8ndDpD9uqux9pQEtKHHs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D6dTm3hVhUVgrrH3ZU4BX2in2dq5kU3dBUY1+ueCuAw3QULwgvMRn3Bk8Bi4g/L7fPyoI7/p5Fg+L2u52wxQQin6yhaf5ILDN5SNKxyPle6OW5UVaWXyDmaQBCURKNaGatsmzu5OpSPX4jAsnciWVbql6Xv/Ebs6LYh/RT2VrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsPxrXbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447BFC4CEEB;
	Mon, 28 Jul 2025 02:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753671082;
	bh=Ka6HpcbV3v4iMb9TmNQTjH+8ndDpD9uqux9pQEtKHHs=;
	h=Date:From:To:Cc:Subject:From;
	b=PsPxrXbBdGMIHEzpyoCyyxn+Zjb7ljzpblXmSkEP0ehpURkfbCBQ4gNodymblMm0A
	 4d5gR94vKhoaPeBro7pu2oDwgpmVLcRDyk5lwI+TUFd/3ww/PJ3SWsnlkMt46pxry+
	 81L4J5Nt2PLk9ZdClQuEvrVIOvcZ2k9nzabcyY31mc2ukOq73RksJE1V/a2y/fochA
	 e8SI9qD4KMV5bfNjdXfCkYH27c23HjxBBdE/NfV6yQBaAl59QrbWtOUG7D2fIXHgv4
	 9CWc9SL9laRqrHmy1xbdkD/Yjc68ry3+tkkfus/bnGs1+ygM4lwK7VwM3BAmEvLiv6
	 3qKVQ0tyGycuw==
Date: Mon, 28 Jul 2025 10:51:16 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Bo Liu <liubo03@inspur.com>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [GIT PULL] erofs updates for 6.17-rc1
Message-ID: <aIblpKzSWEEYwQ06@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Bo Liu <liubo03@inspur.com>,
	Hongbo Li <lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider this pull request for 6.17-rc1?

In this cycle, metadata compression is now supported due to user
requests [1].  It can be useful for embedded use cases or archiving
a large number of small files.

Additionally, readdir performance has been improved by enabling
readahead (note that it was already common practice for ext3/4 non-dx
and f2fs directories).  We may consider further improvements later to
align with ext4's s_inode_readahead_blks behavior for slow devices too.

The remaining commits are minor.  All commits have been in -next and no
potential merge conflict is observed.

[1] https://issues.redhat.com/browse/RHEL-75783

Thanks,
Gao Xiang 

The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc1

for you to fetch changes up to df0ce6cefa453d2236381645e529a27ef2f0a573:

  erofs: support to readahead dirent blocks in erofs_readdir() (2025-07-24 19:44:08 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add support for metadata compression;

 - Enable readahead for directories to improve readdir performance;

 - Minor fixes and cleanups.

----------------------------------------------------------------
Bo Liu (OpenAnolis) (2):
      erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
      erofs: implement metadata compression

Chao Yu (2):
      erofs: do sanity check on m->type in z_erofs_load_compact_lcluster()
      erofs: support to readahead dirent blocks in erofs_readdir()

Gao Xiang (6):
      erofs: get rid of {get,put}_page() for ztailpacking data
      erofs: remove need_kmap in erofs_read_metabuf()
      erofs: unify meta buffers in z_erofs_fill_inode()
      erofs: refine erofs_iomap_begin()
      erofs: remove ENOATTR definition
      erofs: add on-disk definition for metadata compression

 Documentation/ABI/testing/sysfs-fs-erofs |  10 ++-
 fs/erofs/Kconfig                         |   2 +
 fs/erofs/data.c                          |  64 ++++++++------
 fs/erofs/decompressor.c                  |   2 +-
 fs/erofs/dir.c                           |  17 +++-
 fs/erofs/erofs_fs.h                      |  15 +++-
 fs/erofs/fileio.c                        |   2 +-
 fs/erofs/fscache.c                       |   3 +-
 fs/erofs/inode.c                         |  21 ++---
 fs/erofs/internal.h                      |  40 ++++++++-
 fs/erofs/super.c                         |  23 ++++-
 fs/erofs/sysfs.c                         |   4 +
 fs/erofs/xattr.c                         |  56 +++++++------
 fs/erofs/xattr.h                         |   3 -
 fs/erofs/zdata.c                         |  20 +++--
 fs/erofs/zmap.c                          | 140 +++++++++++++------------------
 16 files changed, 255 insertions(+), 167 deletions(-)

