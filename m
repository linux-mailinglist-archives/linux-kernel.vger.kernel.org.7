Return-Path: <linux-kernel+bounces-663816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C782DAC4DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 13:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AFD17A5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 11:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C634625E80D;
	Tue, 27 May 2025 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B95ynLYm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B95ynLYm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB425D8FA
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748346570; cv=none; b=KXUwVZxrZ0LlzDFBWcbOYoB5XJy80vWjzIq71Cj7d9Q7gYepvfNy1JbIBw4Z6PbH1ynGzCgQu/FvxN5qj0MfBHxhUWMkvNMVc1k4c1Pak74e1JC0Wc4uESPlBHcwRbFEkCotBnrO3NX9x6YEBgdCFSw8/U1W1VdEMGS/imSjGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748346570; c=relaxed/simple;
	bh=sYuK8ZW73WtREcRe3Wixl3SHRL4TOVZ3ohArwMovzZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pPyjMiNhZtyJYHG6QtQ8BSRN/BwnU4Nrwv207gZpyL5y00J+8QHITMR66gCLmv4NSeB8ua6X2Trfy9PkRlNWGJEiWwjR1CVPosqcsKGsyEMPM1C/7gUa39+MxLsFjq+BTCT+yo0AZuQUvm5gIpK9RGSRtkASOaqTwn43NPj8rIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B95ynLYm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B95ynLYm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 459631F7E5;
	Tue, 27 May 2025 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748346566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DKk+Nfm0Pb9igRgn4Q0sKMIabc0OAAHC/skA3hLHvUQ=;
	b=B95ynLYmydgrlK/oVFVKqUQ3zLel9/cA0FIfPdalWOeaR7F5RUD8GxIT6Nzz9enaSw6ap8
	wIANICnbKqatARY+Evz5rgZFbCvWC9h3sJtBT2xrc5gs4+Wq0g27E/1reKI3cPI7VpHTZC
	862sK5VmdOjy8b9E0+m7PVbbbqhyg3c=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=B95ynLYm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748346566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DKk+Nfm0Pb9igRgn4Q0sKMIabc0OAAHC/skA3hLHvUQ=;
	b=B95ynLYmydgrlK/oVFVKqUQ3zLel9/cA0FIfPdalWOeaR7F5RUD8GxIT6Nzz9enaSw6ap8
	wIANICnbKqatARY+Evz5rgZFbCvWC9h3sJtBT2xrc5gs4+Wq0g27E/1reKI3cPI7VpHTZC
	862sK5VmdOjy8b9E0+m7PVbbbqhyg3c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39D47136E0;
	Tue, 27 May 2025 11:49:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yzbJDcamNWjtCgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 May 2025 11:49:26 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixup for 6.16 pull request
Date: Tue, 27 May 2025 13:49:22 +0200
Message-ID: <cover.1748346039.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 459631F7E5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spam-Level: 
X-Spam-Score: -0.01

Hi,

please pull a fixup to the xarray conversion sent in the main 6.16
batch. It was not included because it would cause rebase/refresh of like
80 patches, right before sending the early pull request last week.

It's fixing a bug when zoned mode is enabled on btrfs so it's not
affecting most people.

The commit is fresh but the fix has been tested and verified, no reason
to delay it.

Thanks.

----------------------------------------------------------------
The following changes since commit eeb133a6341280a1315c12b5b24a42e1fbf35487:

  btrfs: move misplaced comment of btrfs_path::keep_locks (2025-05-17 21:15:08 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.16-tag

for you to fetch changes up to b83825a8f56a34e7352e424aae64ffe6b88247d1:

  btrfs: don't drop a reference if btrfs_check_write_meta_pointer() fails (2025-05-27 13:39:15 +0200)

----------------------------------------------------------------
Josef Bacik (1):
      btrfs: don't drop a reference if btrfs_check_write_meta_pointer() fails

 fs/btrfs/extent_io.c | 1 -
 1 file changed, 1 deletion(-)

