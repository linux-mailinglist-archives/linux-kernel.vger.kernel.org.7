Return-Path: <linux-kernel+bounces-797202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 456A0B40D49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDD91B658AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5933B3469E0;
	Tue,  2 Sep 2025 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tjGU4e1h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tjGU4e1h"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA518296BDD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838679; cv=none; b=slnjuI2OjhT8yl0LtQ8E9SqLAfymQBPgMZtCjCQnk0EqlXHUIGuUBWVzrHTtMWryTm4b8/3xlZ8VLYJTqq4d7bolV3b+WiYLCUn0RU6CErnEIpPqmluEGpIhAU7ls4Zp+Nwnz4gEOPL85qqiKgV7dWdmJctSczT6BRMr5c5752E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838679; c=relaxed/simple;
	bh=c0KvMlpRTrDWt2PKfU9beKq1pJgi0axvCL0PTCpgJfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f96gzM+wRskYMTjFzVV31spM6I367HIKKNvozuZIPRyKZaZ4zOkWZxBYSHaZI3vqlc3FotEwxiX+aQ3woE8TlqdKQ/ZEjW2PKQuBbmgL5Tprf3e0Fp06uCwueuMcYrws7+AEHBGwLTKabO4W0O7eHRTvg/ef9ZVfQytFSt6dxhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tjGU4e1h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tjGU4e1h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 237F02118B;
	Tue,  2 Sep 2025 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756838676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Spzwe8DfNddPyKOgzEGQ0l/Q2dY4bv3Op5peq02VFN8=;
	b=tjGU4e1hw6CKKCfRYEK7sxvUWNX2Sx+XosnM9oNx2RrGsvzRwMQgrNNnZFiEzMp3T97dd9
	STfacMu5NyrITLgbidjBy0fGR4JYQlSf48FrvwZtpmrhVMNXAMCLQiuRclMy0Vtp9O3p83
	Uz7z+qW1tz1zK3yZyWdid/ery5nibK8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756838676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Spzwe8DfNddPyKOgzEGQ0l/Q2dY4bv3Op5peq02VFN8=;
	b=tjGU4e1hw6CKKCfRYEK7sxvUWNX2Sx+XosnM9oNx2RrGsvzRwMQgrNNnZFiEzMp3T97dd9
	STfacMu5NyrITLgbidjBy0fGR4JYQlSf48FrvwZtpmrhVMNXAMCLQiuRclMy0Vtp9O3p83
	Uz7z+qW1tz1zK3yZyWdid/ery5nibK8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D4A813888;
	Tue,  2 Sep 2025 18:44:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jLAjBxQ7t2g3agAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 02 Sep 2025 18:44:36 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.17-rc5
Date: Tue,  2 Sep 2025 20:44:31 +0200
Message-ID: <cover.1756838388.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Hi,

please pull a few inode logging fixes in tree-log. Thanks.

- fix a few races related to inode link count

- fix inode leak on failure to add link to inode

- move transaction aborts closer to where they happen

----------------------------------------------------------------
The following changes since commit 74857fdc5dd2cdcdeb6e99bdf26976fd9299d2bb:

  btrfs: fix printing of mount info messages for NODATACOW/NODATASUM (2025-08-13 14:08:58 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc4-tag

for you to fetch changes up to 986bf6ed44dff7fbae7b43a0882757ee7f5ba21b:

  btrfs: avoid load/store tearing races when checking if an inode was logged (2025-08-22 00:58:55 +0200)

----------------------------------------------------------------
Filipe Manana (6):
      btrfs: abort transaction on failure to add link to inode
      btrfs: fix inode leak on failure to add link to inode
      btrfs: simplify error handling logic for btrfs_link()
      btrfs: fix race between logging inode and checking if it was logged before
      btrfs: fix race between setting last_dir_index_offset and inode logging
      btrfs: avoid load/store tearing races when checking if an inode was logged

 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/inode.c       | 50 ++++++++++++++++----------------
 fs/btrfs/tree-log.c    | 78 ++++++++++++++++++++++++++++++++++----------------
 3 files changed, 79 insertions(+), 51 deletions(-)

