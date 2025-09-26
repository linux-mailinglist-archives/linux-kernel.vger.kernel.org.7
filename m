Return-Path: <linux-kernel+bounces-833983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9FDBA37DA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0829D561F79
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEF725742C;
	Fri, 26 Sep 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kvmGIKnQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kvmGIKnQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89611713
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758886272; cv=none; b=jY7h6guT/IEhqMqW7rGRb8Cy5W9szuCqsbsrT8qGm5g2nfnZZyduTpbYgnSYqi7E0TLcLePE1X/j6WFGpMv/U9qr9mY+4v4TguwS0aSgzZsBy/LU3Qh/p/m+TMdgXCZQQAfySoJ5SegE26Ma0HSY7gKCSexsRlUH6n0tz8Vm/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758886272; c=relaxed/simple;
	bh=JDq1jb5CsnPFmid0bz16t3QdZzou3rRjug4BHu5Gh00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZMlA04ax8fAe7o+Zn5k7P6qrcRRAbj10uyWMElHwFhVYbAgZ9bdITWEo7gojpMWkjvKV4AEhfxl7KFR0RcF3ChCAevzPiAhGQz3OiCimpZYwTEYlZh23LiVIt3J3f1j9SEivDiPYTMHfOxlxiDA8MBe2bzz88dJKOwGfdTjNtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kvmGIKnQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kvmGIKnQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0873721B3F;
	Fri, 26 Sep 2025 11:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758886268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CgfZTkOg3UTNmDXa9dluiKewI2hBakJjDBZ7pJ3NgXk=;
	b=kvmGIKnQKcGRJuFxwa4kkAh1Osv+y4oFv+ED1kEO6fP/m6ic+rfzroR1znLMEa6fis9tve
	x5b7pR12w67QybUUCbShzr6ICMoVJY1PH6nqZ90ew0YOmm+2j9XmqTkiGHWVjlml5FPcS+
	HW9T79njMNeUP/sRFnqMF2UzRJWK7O4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758886268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CgfZTkOg3UTNmDXa9dluiKewI2hBakJjDBZ7pJ3NgXk=;
	b=kvmGIKnQKcGRJuFxwa4kkAh1Osv+y4oFv+ED1kEO6fP/m6ic+rfzroR1znLMEa6fis9tve
	x5b7pR12w67QybUUCbShzr6ICMoVJY1PH6nqZ90ew0YOmm+2j9XmqTkiGHWVjlml5FPcS+
	HW9T79njMNeUP/sRFnqMF2UzRJWK7O4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEF1F1386E;
	Fri, 26 Sep 2025 11:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oHKFMHt51mgVMgAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 26 Sep 2025 11:31:07 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.18-rc1
Date: Fri, 26 Sep 2025 13:31:05 +0200
Message-ID: <20250926113107.22638-1-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.18-rc1-tag

xen: branch for v6.18-rc1

It contains the following patches:

- a 3 patch series fixing the migration of a Xen virq to another cpu
  plus some related cleanup work

- a 3 patch series cleaning up Xen-PV mode specific code, resulting in
  removing some of that code in the resulting binary in case
  CONFIG_XEN_PV is not set

- 2 fixes and 1 cleanup patch for suspend handling under Xen


Thanks.

Juergen

 arch/x86/configs/xen.config        |  1 -
 arch/x86/include/asm/xen/page.h    | 14 +++++++-------
 arch/x86/xen/Kconfig               |  7 +------
 arch/x86/xen/enlighten_pv.c        |  2 +-
 arch/x86/xen/mmu.c                 |  2 +-
 arch/x86/xen/p2m.c                 |  4 ++--
 drivers/xen/balloon.c              |  4 ++--
 drivers/xen/events/events_base.c   | 37 +++++++++++++++++++++++++++++--------
 drivers/xen/gntdev-dmabuf.c        |  7 +++----
 drivers/xen/gntdev-dmabuf.h        |  2 +-
 drivers/xen/gntdev.c               | 33 ++++++++++++++-------------------
 drivers/xen/grant-table.c          |  6 +++---
 drivers/xen/manage.c               | 14 ++++++++++++--
 drivers/xen/privcmd.c              | 14 ++++++--------
 drivers/xen/unpopulated-alloc.c    |  4 ++--
 drivers/xen/xenbus/xenbus_client.c |  2 +-
 include/xen/grant_table.h          |  4 ++--
 include/xen/mem-reservation.h      |  4 ++--
 include/xen/xen-ops.h              |  7 ++++---
 include/xen/xen.h                  |  9 ++++++++-
 20 files changed, 101 insertions(+), 76 deletions(-)

Jason Andryuk (3):
      xen/events: Cleanup find_virq() return codes
      xen/events: Return -EEXIST for bound VIRQs
      xen/events: Update virq_to_irq on migration

Juergen Gross (3):
      xen: rework xen_pv_domain()
      xen: replace XENFEAT_auto_translated_physmap with xen_pv_domain()
      drivers/xen/gntdev: use xen_pv_domain() instead of cached value

Lukas Bulwahn (1):
      x86/xen: select HIBERNATE_CALLBACKS more directly

Lukas Wunner (1):
      xen/manage: Fix suspend error path

Marek Marczykowski-Górecki (1):
      xen: take system_transition_mutex on suspend

