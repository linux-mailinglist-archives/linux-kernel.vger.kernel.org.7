Return-Path: <linux-kernel+bounces-764745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C8FB226B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7A51B648DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C91C54AF;
	Tue, 12 Aug 2025 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l9yJ3zWD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l9yJ3zWD"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F91A9B58
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001605; cv=none; b=DjJ0V9KtOv3ZtxKUL75mrD7zXqn1O7orINkTUAfJADRmLTMBThAqkznDgOJQTZr1qjG6hQjFEqLRGVW5ffuuiwXXxjzdgJcBrbUS6+B5kGgO+8RT8VhZUJ6hga8Un147O3tin4PYvXIcl0C6BdD5bmNu9v22BmObcDNMTH/zIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001605; c=relaxed/simple;
	bh=xiY3feb0wz5EeV+g5XshHNCyhSV8PSsnwMztbuz7wXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofmfTNalI6HH4YMg7ebzK5v9+Ln7uPupf2aAJT+0NiGzYafJT91m1o4WTomAPWXmx/eu7TIqS7Y2AM++8GTarhFReplPyCRn+Jx3Y+7BxOSW6kVCf3jUfigBJ1jv6sFFL1Q/Ru1EcHZV3Fwg8qwtfevsBhgXaJKSqy5g04Zw79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l9yJ3zWD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l9yJ3zWD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E377021AAB;
	Tue, 12 Aug 2025 12:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755001595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oUHoQJtgTgpCibMe32s5xgdJYqGY6tL9bRq+ICGCErE=;
	b=l9yJ3zWDyeHByoRkACNVYH8TtOiWgWFUkuvR4+FPdBAPUoJbv9zLV3nCZxY1cE6e2gC/0p
	0D8FlPViOjf1pgzbDWXySl7xK2UMuyDLKLMjybQGptvZcTrsCKX+EV8+GIpGxYANBePWhA
	cup8y5q2lW3fZaWHDEIfZgJADzOpfVk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755001595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oUHoQJtgTgpCibMe32s5xgdJYqGY6tL9bRq+ICGCErE=;
	b=l9yJ3zWDyeHByoRkACNVYH8TtOiWgWFUkuvR4+FPdBAPUoJbv9zLV3nCZxY1cE6e2gC/0p
	0D8FlPViOjf1pgzbDWXySl7xK2UMuyDLKLMjybQGptvZcTrsCKX+EV8+GIpGxYANBePWhA
	cup8y5q2lW3fZaWHDEIfZgJADzOpfVk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA2931351A;
	Tue, 12 Aug 2025 12:26:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yvT5NPsym2jSKwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 12 Aug 2025 12:26:35 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.17-rc2
Date: Tue, 12 Aug 2025 14:26:32 +0200
Message-ID: <cover.1755000200.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi,

please pull a few regression fixes and other usual fixes. Thanks.

- fix bug in qgroups reporting incorrect usage for higher level qgroups

- in zoned mode, do not select metadata group as finish target

- convert xarray lock to RCU when trying to release extent buffer to
  avoid a deadlock

- do not allow relocation on partially dropped subvolumes, which is
  normally not possible but has been reported on old filesystems

- in tree-log, report errors on missing block group when unaccounting
  log tree extent buffers

- with large folios, fix range length when processing ordered extents

----------------------------------------------------------------
The following changes since commit 0a32e4f0025a74c70dcab4478e9b29c22f5ecf2f:

  btrfs: fix log tree replay failure due to file with 0 links and extents (2025-08-06 13:01:38 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc1-tag

for you to fetch changes up to 7b632596188e1973c6b3ac1c9f8252f735e1039f:

  btrfs: fix iteration bug in __qgroup_excl_accounting() (2025-08-07 17:07:16 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: fix iteration bug in __qgroup_excl_accounting()

Filipe Manana (1):
      btrfs: error on missing block group when unaccounting log tree extent buffers

Leo Martins (1):
      btrfs: fix subpage deadlock in try_release_subpage_extent_buffer()

Naohiro Aota (1):
      btrfs: zoned: do not select metadata BG as finish target

Qu Wenruo (3):
      btrfs: make btrfs_cleanup_ordered_extents() support large folios
      btrfs: fix wrong length parameter for btrfs_cleanup_ordered_extents()
      btrfs: do not allow relocation of partially dropped subvolumes

 fs/btrfs/extent_io.c  | 11 ++++++-----
 fs/btrfs/inode.c      |  8 +++++---
 fs/btrfs/qgroup.c     |  3 +--
 fs/btrfs/relocation.c | 19 +++++++++++++++++++
 fs/btrfs/tree-log.c   | 19 +++++++------------
 fs/btrfs/zoned.c      |  2 +-
 6 files changed, 39 insertions(+), 23 deletions(-)

