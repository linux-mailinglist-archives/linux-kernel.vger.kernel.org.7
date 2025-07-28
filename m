Return-Path: <linux-kernel+bounces-747508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB8AB134A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDAFE7A9DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBEC2206B2;
	Mon, 28 Jul 2025 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jx5NMleA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="szmbmlG2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42821CC44
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682785; cv=none; b=fu2yLjrQe2MQOEb5RiYx6HtMOyJw0FreKik9Mk525U23dt4BBrwhQU8+V+tM7orckxyTgGUMEBsyCJSHFiDPvop+mqIbXqi56t90vxYndDKgVuh+Sv+JPKOL/SOJFyGgtJ9y+VGtNdilthbnNa/YnJKkBTuNgbdzcUsuA3+EYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682785; c=relaxed/simple;
	bh=/MOGhL1naZv0C+l6p3luEogLWWM+KwheHTNHnT3XDaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkZpyDhPgtilrga+ykz/wgB9wlPkbEnsE+kyBHZZu56VSyI57vTRpKq0vozrxguwzTnC0sSYWpLThggUvoYrl9qwSxBdTp+MzarJJgV2/TDk5pEAl4a5dOb7RubBozWsoUoNLwk5I81QwQghaeeuvq+tSjZqHPVwBemMk3f0A0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jx5NMleA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=szmbmlG2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96ED41F7FD;
	Mon, 28 Jul 2025 06:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753682776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3n8KTJ9XQxHiiQiPEZNY8Dlf+2L80OyLJ/0a+7zM3BM=;
	b=jx5NMleALgYxKjWMjCvWq1BNj7/qQ10JXpksYyiZ7Tl0A/1kqtGXvt1OEIPwCAQ5fm2agJ
	KLpwgxV8s896L7rsMocR9bl5XYXeoMYZwfbAZyhDe/8Vk0TnVPQGjtRoOrkX4i8mrMOeyP
	7z2SekU2GIuO8L04TG7iXQNvADapHXs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753682775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3n8KTJ9XQxHiiQiPEZNY8Dlf+2L80OyLJ/0a+7zM3BM=;
	b=szmbmlG2MUPu/Jag4zu2tgYUm+uPmEGYHFBfkakCspELZQFmIQqspbxRHsvFqJkmrYjuPL
	oiVQRhs59yFMpkJRA4olyonL8NZm3U9Y+kHWktz2KMw0tL7+Gwfoi4TjW3Q+/1RAbx6VGb
	UcRRacw/OPqi4Xu2DFrL4af+m7OfVCc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E0251368A;
	Mon, 28 Jul 2025 06:06:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y31tGVcTh2iYcAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 28 Jul 2025 06:06:15 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.17-rc1
Date: Mon, 28 Jul 2025 08:06:14 +0200
Message-ID: <20250728060614.4875-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.17-rc1-tag

xen: branch for v6.17-rc1

It contains the following patches:

- A fix for a UAF in the xen gntdev-dmabuf driver
- A fix in the xen netfront driver avoiding spurious interrupts
- A fix in the gntdev driver avoiding a large stack allocation
- A cleanup removing some dead code
- A build warning fix
- A cleanup of the sysfs code in the xen-pciback driver

Thanks.

Juergen

 drivers/net/xen-netfront.c         |  5 ---
 drivers/xen/gntdev-common.h        |  4 +++
 drivers/xen/gntdev-dmabuf.c        | 28 ++++++---------
 drivers/xen/gntdev.c               | 71 +++++++++++++++++++++++++++-----------
 drivers/xen/manage.c               |  6 ----
 drivers/xen/time.c                 |  8 -----
 drivers/xen/xen-pciback/pci_stub.c | 12 +++----
 drivers/xen/xenbus/xenbus_client.c |  2 ++
 drivers/xen/xenbus/xenbus_xs.c     | 17 ---------
 include/xen/xen-ops.h              |  2 --
 include/xen/xenbus.h               |  2 --
 11 files changed, 72 insertions(+), 85 deletions(-)

Al Viro (1):
      xen: fix UAF in dmabuf_exp_from_pages()

Anthoine Bourgeois (1):
      xen/netfront: Fix TX response spurious interrupts

Dr. David Alan Gilbert (1):
      xen: Remove some deadcode (x)

Juergen Gross (1):
      xen/gntdev: remove struct gntdev_copy_batch from stack

Peng Jiang (1):
      xen/xenbus: fix W=1 build warning in xenbus_va_dev_error function

Ryan Chung (1):
      xen-pciback: Replace scnprintf() with sysfs_emit_at()

