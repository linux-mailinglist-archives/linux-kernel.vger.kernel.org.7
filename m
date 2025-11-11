Return-Path: <linux-kernel+bounces-894986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B760BC4CA51
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01F5B4F3291
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B49B2EDD69;
	Tue, 11 Nov 2025 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fMQAzDzE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fMQAzDzE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54712D3EC7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852965; cv=none; b=h1YuU9KC3UiHVhrKTATQ2cibiz1zgEcjyy2JKyMqCbQ1tFKNqpJhVyWVjN3Yzmb9EXxamTNAWJziMjlcibUJV5CNVmw53GPGKG95g62tBXpArJUMB6YtzZe4n3mqrNZz99q6d8tX4YtP1ESQOyCI3w8gDzTf6SWIi6Sp27Tg7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852965; c=relaxed/simple;
	bh=qE5TmNdkrg+OPgkxw4VKGtn0S2qpfsMV7Ie//La4l1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTFrFQsNYQjQPWh2xONkCg+4NWJWjRZARRH2vNjh9/lVgEEY8wyP3gsaE39Quh2/9u3WoAeyuqlZynJ/N9zIUapViBr/sWZ+nFG5qdC1M7MXfybt3t9JyJnC1ADi/hKn6lBiy23+CaGYQqgpgeVV4re9d+LorBaVO8TpRuXaF8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fMQAzDzE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fMQAzDzE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A2F91F6E6;
	Tue, 11 Nov 2025 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762852961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=koyI6TVnHTLJu0tGNfRG2MBG55y2xcIEjvrKuUb42Zw=;
	b=fMQAzDzEgr4QabXRni4jJwFAKrgH/1+QqY0XGKaGARK4e9stMjYmDkm5zfsQSflcMtJlwQ
	US9dpgOkxpg9m/ZqKT8lX3jTik589E5QaHY2Gzk3XasnraQJsjKkP+N0/qgaKZMWxrfzCB
	0yw/IIkD9jS6Z/ayGTh1RgTEMIu8JcA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fMQAzDzE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762852961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=koyI6TVnHTLJu0tGNfRG2MBG55y2xcIEjvrKuUb42Zw=;
	b=fMQAzDzEgr4QabXRni4jJwFAKrgH/1+QqY0XGKaGARK4e9stMjYmDkm5zfsQSflcMtJlwQ
	US9dpgOkxpg9m/ZqKT8lX3jTik589E5QaHY2Gzk3XasnraQJsjKkP+N0/qgaKZMWxrfzCB
	0yw/IIkD9jS6Z/ayGTh1RgTEMIu8JcA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83541148A5;
	Tue, 11 Nov 2025 09:22:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vZoKIGEAE2k0ZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 11 Nov 2025 09:22:41 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes fro 6.18-rc6
Date: Tue, 11 Nov 2025 10:22:35 +0100
Message-ID: <cover.1762852601.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8A2F91F6E6
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Hi,

please pull a few more fixes, thanks.

- fix new inode name tracking in tree-llog

- fix conventional zone and stripe calculations in zoned mode

- fix bio reference counts on error paths in relocation and scrub

----------------------------------------------------------------
The following changes since commit 3b1a4a59a2086badab391687a6a0b86e03048393:

  btrfs: mark dirty extent range for out of bound prealloc extents (2025-10-30 19:18:18 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.18-rc5-tag

for you to fetch changes up to c367af440e03eba7beb0c9f3fe540f9bcb69134a:

  btrfs: release root after error in data_reloc_print_warning_inode() (2025-11-05 20:01:12 +0100)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: do not update last_log_commit when logging inode due to a new name

Naohiro Aota (2):
      btrfs: zoned: fix conventional zone capacity calculation
      btrfs: zoned: fix stripe width calculation

Zilin Guan (2):
      btrfs: scrub: put bio after errors in scrub_raid56_parity_stripe()
      btrfs: release root after error in data_reloc_print_warning_inode()

 fs/btrfs/inode.c    |  4 +++-
 fs/btrfs/scrub.c    |  2 ++
 fs/btrfs/tree-log.c |  2 +-
 fs/btrfs/zoned.c    | 60 +++++++++++++++++++++++++----------------------------
 4 files changed, 34 insertions(+), 34 deletions(-)

