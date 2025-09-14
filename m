Return-Path: <linux-kernel+bounces-815420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4F4B56401
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 02:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8642D3A8003
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092AA320F;
	Sun, 14 Sep 2025 00:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YonLBBL9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974C163
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 00:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757808293; cv=none; b=NbxBwjOuPJP7ZKO9TOHnclEwASakHOXMH+FOWbqCbk9Yxun9yX7vYpSODx6JuvXAtiGe0W/dq/pYADG5FZRHCeyrhYtQqhWVycsfqgJB4wtaJgDCNE2XQNIkHFSzRZZW4hG3gwPb0ehACSBfytouzMfija5QT1aIP+Gm85PDVJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757808293; c=relaxed/simple;
	bh=jhxlJQ1D3aXAHnveeb4Bqd8Arf+9bkmDUaPFFpf52EY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CMSOsfufbp+2UQUXkp97I9ZnakQiowYUCQ6FpUVWqAmHQ0XmN5iQR4SWNybXhbKh8AUZT/iGz1/nYB4bb2Z71IzmrzYaoxNvGAjmugzS66mSdueeRmAc5Iowe7VS96LjGVvWtKAamd0onO7N9R7q7mHc34gISYhaLSTy4qTHrm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YonLBBL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D9EC4CEEB;
	Sun, 14 Sep 2025 00:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757808292;
	bh=jhxlJQ1D3aXAHnveeb4Bqd8Arf+9bkmDUaPFFpf52EY=;
	h=Date:From:To:Cc:Subject:From;
	b=YonLBBL9XtJ+Z0e/O+tCbfXvL6N+OUUSx0O+4ZY8zkbqFYwwcuGwb2DQzzvMViBOW
	 eJr3CoHMaKPAqlWFmGWX6Mas2AmXCk77nBobHu1BO1j4fBwqSJ8EydCWmneA2gEBlP
	 ig/rjUXLR8YnHz2BWaaeKaSjyXMtHbZRraBeGF7HY04+K6ckCdplV9V7jqKDvdMsVp
	 vcixJuiiHTFjqePvV5DqEudbzflM+waY/0r8P4ZUG3wCCRj8aMHiapYZpuFs6cl8ea
	 7ZKn+DHyu69hW42bOSXoxvS/PSsu1bDnzbOBXrZMm+2iDENxhktNDGDDx0U9wifgBa
	 dw553Bv7E3xKg==
Date: Sun, 14 Sep 2025 08:04:47 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>, Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs fixes for 6.17-rc6
Message-ID: <aMYGn1hQjWaQCaiM@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>, Chao Yu <chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider those fixes for 6.17-rc6?

A few new random fixes as shown below..

Thanks,
Gao Xiang

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc6-fixes

for you to fetch changes up to 1fcf686def19064a7b5cfaeb28c1f1a119900a2b:

  erofs: fix long xattr name prefix placement (2025-09-12 03:37:07 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix invalid algorithm dereference in encoded extents;

 - Add missing dax_break_layout_final(), since recent FSDAX fixes
   didn't cover EROFS;

 - Arrange long xattr name prefixes more properly.

----------------------------------------------------------------
Gao Xiang (2):
      erofs: fix invalid algorithm for encoded extents
      erofs: fix long xattr name prefix placement

Yuezhang Mo (1):
      erofs: fix runtime warning on truncate_folio_batch_exceptionals()

 fs/erofs/erofs_fs.h |  8 ++++---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 12 ++++++++++
 fs/erofs/xattr.c    | 13 ++++++++---
 fs/erofs/zmap.c     | 67 +++++++++++++++++++++++++++++------------------------
 5 files changed, 65 insertions(+), 36 deletions(-)

