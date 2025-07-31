Return-Path: <linux-kernel+bounces-751674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE82B16C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31D916E483
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A7628D8D1;
	Thu, 31 Jul 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aernMr5V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8DxuG+UY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ril3fGY9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qp5cWG4n"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2C28D85E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753944540; cv=none; b=KE84qle66lgVjc+eTvS5FMEyPySNZajej2G9pLc9weRY/H45BVdi6X3KMmHYa/SKXxQkufmOHxWn7TquT5a1WX58xZyFZYVh2fS3q3IqMQCLSywNFd/v9EYrxAdkK3BGEh6phcKQFIkd5VhaZ9JvK5VPaZwhyP5+DdOtGXrrURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753944540; c=relaxed/simple;
	bh=jm0KKfW+UkMMixI1j6i1ae23s39cnb66Rd/wkQa4kJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKchs9aSxgOoJZ8lV99nK/pRZZhis3OBUY/JoFip/AU9Ty5zjuBkuNJXLGl94atkzip554CRxak487I7Q6dcm2GVX+MdQD0/2kfc+2lqvnlhEMy5NJZwDRRIMQvC7a75X8/Rg07X9qa99tWQKfXvxXto65uzxtrVUMlHUF57yV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aernMr5V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8DxuG+UY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ril3fGY9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qp5cWG4n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3DC321B55;
	Thu, 31 Jul 2025 06:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753944537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UM4z7F7h/IlTuxpRAMwKu0fT5sp1WYVUct/vZOg9cHE=;
	b=aernMr5VwGDOZE4LQ1oletydP1szxtFKp9M7sbMnxiTfa2aiYtAD91Vbrg7mp4qfJUdK98
	fGQXKEJ7mIkJUqGNwgzUURat1lO4LwLfLa56yiwarM36eaBiURAMKTHL4Lyb0vMDUHMFzc
	jS53o5qOJQuDhrSs8wckXqP+b1TWy6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753944537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UM4z7F7h/IlTuxpRAMwKu0fT5sp1WYVUct/vZOg9cHE=;
	b=8DxuG+UYDlpMnOrtjzgEP16yLxgXN/IyN8d+uWJarw0rf1mk64Kxf+XVGyS95wy6qKLKur
	Fs+N9YipX5hEHtBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ril3fGY9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Qp5cWG4n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753944535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UM4z7F7h/IlTuxpRAMwKu0fT5sp1WYVUct/vZOg9cHE=;
	b=ril3fGY9JqFgdzqcQ82DwhV0JFebqsxAKnDXt7q06GsYeOXKKPNmrlhMMP1H6mcqiQoaAS
	xN/5fgt0Xx6FuFnl8Xm+ZyuZGbOTowrOLIcbUpLBJyfAt23EHGSbSnx1hQifRHzlffkint
	l3DdO4mZeiQEGx5zKK81SQ47hAPd33o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753944535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UM4z7F7h/IlTuxpRAMwKu0fT5sp1WYVUct/vZOg9cHE=;
	b=Qp5cWG4nJxi8utjMrWMeGGPgdDdWACmn4/Bxlay+J8rFvRM+EN7Xi+HkBNYD1KbZtPA7q/
	KpFU6hY1SbHQftDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C41CD13876;
	Thu, 31 Jul 2025 06:48:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Iv91LtcRi2hnZAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Jul 2025 06:48:55 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ALSA: hda: Fix arch defconfigs
Date: Thu, 31 Jul 2025 08:48:06 +0200
Message-ID: <20250731064813.1622-1-tiwai@suse.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E3DC321B55
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01

The recent HD-audio kconfig updates require the adaption of arch
defconfig changes, too.

This is a resent of changes I posted shortly [*] ago but split to each
arch change instead.  Since the updates are only in sound git tree as
of now, I'm going to pick those in sound git tree as well.


thanks,

Takashi

[*] https://lore.kernel.org/20250731053031.27121-1-tiwai@suse.de

===

Takashi Iwai (3):
  arm: Update HD-audio configs again
  LoongArch: Update HD-audio codec configs
  mips: Update HD-audio configs again

 arch/arm/configs/multi_v7_defconfig        | 3 ++-
 arch/arm/configs/tegra_defconfig           | 3 +++
 arch/loongarch/configs/loongson3_defconfig | 2 ++
 arch/mips/configs/loongson2k_defconfig     | 1 +
 arch/mips/configs/loongson3_defconfig      | 3 ++-
 5 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.50.1


