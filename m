Return-Path: <linux-kernel+bounces-836407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2253DBA999E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24653A2672
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C71A309DCC;
	Mon, 29 Sep 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3vVNnhO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6196309DCF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156508; cv=none; b=JxwM1oJUf+oDGCVPs0WvMSYjg3k1bnsmChGhOAgGC6pHxTV0xH1jlXpUryC+iaN7uXWBcsM4LeNgMqTq3VJX/Y9k4K2rSJeo6iS2blvUCKvfOYzIj81pcld0b6HbGgQq836MLg8QS3fA0nAnSICHYt2Iv0FhuvifbU/6Y/PzN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156508; c=relaxed/simple;
	bh=DRSihkHoMG81fVQdMHQHT+bezqKWPcqqJdII+FwnuCM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l5TeszaMPQrirHeDH0nvQ5E78El+KtMTLBygpTk1ct8QEuDsceWdVpeNF3rUS8h2GYgbsvxlFUpdZypSkyh+ViuQh7tp2Nj2hClDPtjo12ztat8oPeHmR+hw/Cvy5UQjXHynA0apnNNQLTKe+myqJ4KIW+sqmTsQ7VaArpnkIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3vVNnhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EFFC4CEF7;
	Mon, 29 Sep 2025 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759156508;
	bh=DRSihkHoMG81fVQdMHQHT+bezqKWPcqqJdII+FwnuCM=;
	h=Date:From:To:Cc:Subject:From;
	b=F3vVNnhONYoBUjn+EAL66VwRehAnkHJF+jLdZoi44sIK7DSBu98nkX4IlYnSn156B
	 EwD6yJCad7V/zjuXY5WSbxHd930TIqIGGKX1992hdX3ASfwjm9KFq/OIQjxAqtspTL
	 8HGPyaP8B6mrO7VFMfe1r2FPtMlRUHR4lKP16FODsTzq7y0TjVrqy7S/nLh59V2rjb
	 sEsv2EXwn6CTWv1NsRn2F5vDWrCHB960wc0fAjYqgJdZIrNrvmuqMWYpuYNctSDqjw
	 cglP55NaAFo0m78GZfy3mZt/cdbIJkEsj8PqPF7CiOzzTRm6OZmVqLFTTkCSJahU4t
	 ygWoA+JzhDBiA==
Date: Mon, 29 Sep 2025 22:34:59 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Bo Liu <liubo03@inspur.com>, Chao Yu <chao@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [GIT PULL] erofs updates for 6.18-rc1
Message-ID: <aNqZE+ex0ci1etXU@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Bo Liu <liubo03@inspur.com>, Chao Yu <chao@kernel.org>,
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

Could you consider this pull request for 6.18-rc1?

There is no outstanding feature for this cycle.  One change adds
support for FS_IOC_GETFSLABEL, and the others are fixes and cleanups.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc1

for you to fetch changes up to e2d3af0d64e5fe2ee269e8f082642f82bcca3903:

  erofs: drop redundant sanity check for ztailpacking inline (2025-09-25 11:26:39 +0800)

----------------------------------------------------------------
Changes since last update:

 - Support FS_IOC_GETFSLABEL ioctl;

 - Stop meaningless read-more policy on fragment extents;

 - Remove a duplicate check for ztailpacking inline.

----------------------------------------------------------------
Bo Liu (OpenAnolis) (1):
      erofs: Add support for FS_IOC_GETFSLABEL

Gao Xiang (2):
      erofs: avoid reading more for fragment maps
      erofs: drop redundant sanity check for ztailpacking inline

 fs/erofs/data.c     |  4 ++++
 fs/erofs/dir.c      |  4 ++++
 fs/erofs/inode.c    | 40 ++++++++++++++++++++++++++++++++++++----
 fs/erofs/internal.h |  5 +++++
 fs/erofs/super.c    |  8 ++++++++
 fs/erofs/zdata.c    |  7 ++-----
 fs/erofs/zmap.c     |  4 ++--
 7 files changed, 61 insertions(+), 11 deletions(-)

