Return-Path: <linux-kernel+bounces-736090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A1B098B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B114A77EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AE63C01;
	Fri, 18 Jul 2025 00:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U7WJofQb"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C2AD21
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797027; cv=none; b=USpcwjn7EGd7R+5nPfrloxtj0h1wbZVAtP5Jnv7rrp1VADoml64t6ggXcTMoM/HFUrc2sRDhF0ISBops5UEZgLVEb5zrt8bGlP2WB49j/UMQVkmD+8QQCz4Dw549C+k5UYf8eWjJyD+EZLKiL1aCjq9/mky5E6ctGaT1dvf0H3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797027; c=relaxed/simple;
	bh=j8XoN8wm5vMCLiPaNNF2pggRUi/IpnaqN6r5ZSfiOO0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PKQsXMxZR7JztiuTd5wXwdXdL3Pjn1OdZTkJYJe9p4FafzpkUSu0mQ/FXHQcZMjUXhg3CGjZMcLVy4QcJLT34G38ZfaPorHSCzRlqnA/zCQ/FmImbwQvlKx75yIT6uAFKYHCZpUC3866CmRQZr3yERs8i1G7uxmtKRgsAwaaFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U7WJofQb; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Jul 2025 20:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752797013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RkUy0/eddyr1B+B24sjHKUq1x4/Az8aRCiU5ZGMSaXk=;
	b=U7WJofQb7Q/ChRaWzco0brOEVtq8F3U8H2fip4xDaCZi6014PmxpEK9KuEE6o45ThlA5pt
	2bVyuuIuyxP6rvcWebOwAhCe8uf6Gr7PsbykKVm0DuDOKIkI/vpaPPK7s6mGd0o1XtQWgL
	Sa/pHwI0sfkOROezK2+ep7UKhUd6DzU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.16-rc7
Message-ID: <bgaxbeebayrzhkawwhrxrrdgc6xtsk5h454ejv7py4g74hxjs2@yyvkmakatffx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-07-17

for you to fetch changes up to 89edfcf710875feedc4264a6c9c4e7fb55486422:

  bcachefs: Fix bch2_maybe_casefold() when CONFIG_UTF8=n (2025-07-16 17:32:33 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.16-rc7

- two small syzbot fixes
- fix discard behaviour regression; we no longer wait until the number
  of buckets needing discard is greater than the number of buckets
  available before kicking off discards
- fix a fast_list leak when async object debugging is enabled
- fixes for casefolding when CONFIG_UTF8 != y

----------------------------------------------------------------
Kent Overstreet (7):
      bcachefs: io_read: remove from async obj list in rbio_done()
      bcachefs: Fix triggering of discard by the journal path
      bcachefs: Tweak threshold for allocator triggering discards
      bcachefs: Don't build aux search tree when still repairing node
      bcachefs: Fix reference to invalid bucket in copygc
      bcachefs: Fix build when CONFIG_UNICODE=n
      bcachefs: Fix bch2_maybe_casefold() when CONFIG_UTF8=n

 fs/bcachefs/alloc_foreground.c | 3 ++-
 fs/bcachefs/btree_io.c         | 6 +++---
 fs/bcachefs/dirent.c           | 4 ++++
 fs/bcachefs/dirent.h           | 8 ++++++++
 fs/bcachefs/io_read.c          | 5 +++++
 fs/bcachefs/journal_io.c       | 1 +
 fs/bcachefs/movinggc.c         | 2 +-
 7 files changed, 24 insertions(+), 5 deletions(-)

