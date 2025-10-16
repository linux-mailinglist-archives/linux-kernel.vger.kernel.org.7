Return-Path: <linux-kernel+bounces-856678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFF5BE4C82
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF353544B92
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E3A32B9A7;
	Thu, 16 Oct 2025 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HwL5axzh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ayEvP9Ut"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EBD342C94
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760634007; cv=none; b=ufx6YJKkLV2/Fd4il7XJv33G1tcL+7thgeLcRld3oF105bACLddSL6XDyW5ApFhNtO3KuEZp5zScE2fV1hNht+U5kA1jc+yOLpTDFyuUofM++mLvJanQ/8lF+Q23J918Ea543XFwtDfEHyzpKK4UrqloxtsetBr5wnx+BaM6rlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760634007; c=relaxed/simple;
	bh=sivryJrPjReGnlWmYtKi5udAC26+vKKoayWHpdR2ECw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KxNkCRREjnkcEfNtWMlJUM21855jObvKV43ZfAc58eGXy8ZTRonomaPqT70/VDPXsJesudniVOK//t588McPpD4iv8rOojg4hzmIxwlcXYDLlJ7EIxe+1nB1z7hZ8BUA7m21TnEXF9fCUIv4AdftK47w5Lj/dRMez0rcIB7lA3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HwL5axzh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ayEvP9Ut; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C78A321DB7;
	Thu, 16 Oct 2025 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760634004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S6zbXKDVUFK7amAboXywKiOC9TFFHhphEzVjQ+Y//wE=;
	b=HwL5axzhUgqFXnujKFnGmPZ+Xhs074Xwb44Bo/29lRuxMrJY3CW0D+EVm73MkaTbtbmTnz
	0M6sL9GJTX8Bo2XsKoXSVIK3uQeEWFYHp5tHdgZp6KDIdQ3Ii5m5hWYLaXYV7wM/MidDNe
	I6chl3+c+SqZtVvmoK/7u5u546mrIWU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ayEvP9Ut
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760634002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S6zbXKDVUFK7amAboXywKiOC9TFFHhphEzVjQ+Y//wE=;
	b=ayEvP9Ut9NS9xUGB1/e97Dz/aRxqLZxeuLxnnRRY/ya0AfJn94zP5OUc8HF2Ov+tF8+5QZ
	P9bDeDrLOJWdi1hOsXqPqpNiPnfexk07HydWiLI/w365J4+mCCurw9fggLC7Sai0BiuKCq
	iAg+FvuNfR6nyFBnhGukAHy6NKYMgCw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C16531376E;
	Thu, 16 Oct 2025 17:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C74xL5Ik8WiEFgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 16 Oct 2025 17:00:02 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.18-rc2
Date: Thu, 16 Oct 2025 18:59:52 +0200
Message-ID: <cover.1760633129.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C78A321DB7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.51

Hi,

please pull a bunch of one-liners and short fixes. Thanks.

- in tree-checker fix extref bounds check

- reorder send context structure to avoid -Wflex-array-member-not-at-end
  warning

- fix extent readahead length for compressed extents

- fix memory leaks on error paths (qgroup assign ioctl, zone loading
  with raid stripe tree enabled)

- fix how device specific mount options are applied, in particular the
  'ssd' option will be set unexpectedly

- fix tracking of relocation state when tasks are running and
  cancellation is attempted

- adjust assertion condition for folios allocated for scrub

- remove incorrect assertion checking for block group when populating
  free space tree

----------------------------------------------------------------
The following changes since commit 4335c4496b1bcf8e85761af23550a180e937bac6:

  btrfs: fix PAGE_SIZE format specifier in open_ctree() (2025-10-01 16:27:28 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-rc1-tag

for you to fetch changes up to 8aec9dbf2db2e958de5bd20e23b8fbb8f2aa1fa6:

  btrfs: send: fix -Wflex-array-member-not-at-end warning in struct send_ctx (2025-10-13 22:36:38 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: fix incorrect readahead expansion length

Dan Carpenter (1):
      btrfs: tree-checker: fix bounds check in check_inode_extref()

Filipe Manana (2):
      btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if relocation already running
      btrfs: do not assert we found block group item when creating free space tree

Gustavo A. R. Silva (1):
      btrfs: send: fix -Wflex-array-member-not-at-end warning in struct send_ctx

Miquel Sabaté Solà (2):
      btrfs: fix memory leak on duplicated memory in the qgroup assign ioctl
      btrfs: fix memory leaks when rejecting a non SINGLE data profile without an RST

Qu Wenruo (2):
      btrfs: only set the device specific options after devices are opened
      btrfs: do not use folio_test_partial_kmap() in ASSERT()s

 fs/btrfs/extent_io.c       |  2 +-
 fs/btrfs/free-space-tree.c | 15 ++++++++-------
 fs/btrfs/ioctl.c           |  2 +-
 fs/btrfs/relocation.c      | 13 +++++++------
 fs/btrfs/scrub.c           |  4 ++--
 fs/btrfs/send.c            |  4 +++-
 fs/btrfs/super.c           |  3 +--
 fs/btrfs/tree-checker.c    |  2 +-
 fs/btrfs/zoned.c           |  2 +-
 9 files changed, 25 insertions(+), 22 deletions(-)

