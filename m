Return-Path: <linux-kernel+bounces-866334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A945BFF7F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A40B3AA323
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CB52E0417;
	Thu, 23 Oct 2025 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="plQG8p3L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dg8o9OGs"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C12DF6F4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203820; cv=none; b=BXmxG3OsT+INxPP/w4xBhrHNYupTN0fG6+tARNhEEtYzXPS1Mtb1ZS6FSd1apl7lOA9FQ44A8BKkhW3HyRTFRajrvCyJ2RcHwqaCKDpUQJ1mz5cg5VF92xxRzhL0ZvYf6Y6P8tHedx+rEwzE4laOt2kWBnW3U2LdM9vg6caFlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203820; c=relaxed/simple;
	bh=ypSJqeekZgf5O+2c4uKMeyWNcaUMCSwrdj4Z4jmFTB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCRoVqrnHJcdKR8umOpf4XA2ccruD0ibRvZiV3PtUATI7f9du0COLha6/qnPmhZ3Flf1NHduHwXqVX4r+839VuKFtgvlDkXyckvpdWna0njvO3fVGmsib7B60drLl9zvYzxORwD4Wy2DM7/AdNiKetZQS6O61Uo1i7HM4STtaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=plQG8p3L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dg8o9OGs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1593B1F38D;
	Thu, 23 Oct 2025 07:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761203806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ljXa6fFm6MKyoAZiWZm7qbUvg2RgHW5M1AdCNJCtXoM=;
	b=plQG8p3LNqRwYwraFXOYYU/x6KcHF2k1JYSbTbVfdbGX7TwWf0SJoQgBghHgSAsmIvql7S
	N3w92ljMS7uXMeNfp8i+TJvgvnuNAEv7IIYC7NQEIQKL9VzWv7FFS6Wr/xiJGQ/aplQrum
	XRLVV2U4vJjqu5ZaPbDNS979JKZGomc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dg8o9OGs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761203802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ljXa6fFm6MKyoAZiWZm7qbUvg2RgHW5M1AdCNJCtXoM=;
	b=dg8o9OGsxIb7QFrZLj362y1TOfAjbsnXMgTVYNrdhnpHs+rAHYw4SU4uyuH50xGzquAacw
	fFoHInsoPenlEhVbwjBiTWjIVHXAbZYzulitPElTNrwdmyeZp2fLk5+PXiNlJ2CM2QHdBG
	wUXpKFHcHOEDOkXQdNoLOEHkSNjCjiY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 082F6136CF;
	Thu, 23 Oct 2025 07:16:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wru1AVrW+Wh0QQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 23 Oct 2025 07:16:42 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.18-rc3
Date: Thu, 23 Oct 2025 09:16:23 +0200
Message-ID: <cover.1761202410.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1593B1F38D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Hi,

please pull a few btrfs fixes. Thanks.

- in send, fix duplicated rmdir operations when using extrefs
  (hardlinks), receive can fail with ENOENT

- fixup of error check when reading extent root in ref-verify and
  damaged roots are allowed by mount option (found by smatch)

- fix freeing partially initialized fs info (found by syzkaller)

- fix use-after-free when printing ref_tracking status of delayed inodes

----------------------------------------------------------------
The following changes since commit 8aec9dbf2db2e958de5bd20e23b8fbb8f2aa1fa6:

  btrfs: send: fix -Wflex-array-member-not-at-end warning in struct send_ctx (2025-10-13 22:36:38 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-rc2-tag

for you to fetch changes up to ada7d45b568abe4f1fd9c53d66e05fbea300674b:

  btrfs: ref-verify: fix IS_ERR() vs NULL check in btrfs_build_ref_tree() (2025-10-22 09:40:07 +0200)

----------------------------------------------------------------
Amit Dhingra (1):
      btrfs: ref-verify: fix IS_ERR() vs NULL check in btrfs_build_ref_tree()

Dewei Meng (1):
      btrfs: directly free partially initialized fs_info in btrfs_check_leaked_roots()

Leo Martins (1):
      btrfs: fix delayed_node ref_tracker use after free

Ting-Chang Hou (1):
      btrfs: send: fix duplicated rmdir operations when using extrefs

 fs/btrfs/delayed-inode.c |  2 +-
 fs/btrfs/delayed-inode.h |  7 ++++++
 fs/btrfs/ref-verify.c    |  2 +-
 fs/btrfs/send.c          | 56 +++++++++++++++++++++++++++++++++++++++++-------
 fs/btrfs/super.c         |  8 ++++++-
 5 files changed, 64 insertions(+), 11 deletions(-)

