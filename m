Return-Path: <linux-kernel+bounces-826807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D809BB8F640
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C34D420B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0D12F747A;
	Mon, 22 Sep 2025 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MbWm1PJ/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UdJ/3zz8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rlCVBaqG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AJwpx3Qm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36677223337
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528087; cv=none; b=aKrc/kITI0OINNblWIsWt4QqrFAUYp7cukjyN/mdjXuv5DYyqJO10hN650mtnGDoaryCO6j0TJJC+9n9KZKbdWw5MGOZxzYvnbGEIRB4Aw5ZA8DuKC6+Wtf7EdDCwReGqDO06rQzrQMNE/KYUa74euFc2ttfS+VHadaH1lVgwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528087; c=relaxed/simple;
	bh=eKPwcbdTOBHUp7SybkcXn0UJNFIVtzbgcFF30ih7ybE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uoRhsafrOPL1K4SVdR8anAmSbtHDzj/VW4W7tup+M1ruVeujZ4FtInZxKHgd/GHaAqifeBP7F9tkVAnCoBX2d5Cu0V/GTH3oYMpPCtAIJhzABy1DyRpQIu/XWMKLrYIqW0xKMdZVBR8YxTTLMruW37fbgoyThJH2ofufO2vrxT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MbWm1PJ/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UdJ/3zz8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rlCVBaqG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AJwpx3Qm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F3061F8B0;
	Mon, 22 Sep 2025 08:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758528079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LeDdhm2PhyHO8oTu+kmY6QT+6VhDFohx1iJw2P7KbGk=;
	b=MbWm1PJ/OUzu/woh1OMAn//CFsGvaV3BeKwlRswtuDBBCFgP8m/jtgaRh8GNXq17uatXls
	DtajUIUnKZl/lz1zmH+SPhK/6u+EDFP+1OhVX9i8bs4K7/nRCqsGMTHMnX7AfkYy66exqH
	k/kVS5aRDxqsVvXXBbLdnZ6H88GRcB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758528079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LeDdhm2PhyHO8oTu+kmY6QT+6VhDFohx1iJw2P7KbGk=;
	b=UdJ/3zz8gdaeUSGYoDO6stTC+VSyFxzqnJ2sd5CfQ3WdB6QOBZzoFViFglyezCYXcFwvXj
	XhECWzng73Hn3iBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758528074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LeDdhm2PhyHO8oTu+kmY6QT+6VhDFohx1iJw2P7KbGk=;
	b=rlCVBaqG5KT/wMA7CnayjpmOq3QnxGlwGXP3pS9gC/sCTBmX7CNmGhsqrqt7E0JyMl8RB1
	WHPFRYnTYMFw4nAZ4a/iCw5m5lL1tstDNxRvlSBegdmlQ1fHS5xjF887yZEpd7StNJkHlH
	HscYPz5bo5hR+O3Wdsx0cW6NWhyEAiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758528074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LeDdhm2PhyHO8oTu+kmY6QT+6VhDFohx1iJw2P7KbGk=;
	b=AJwpx3QmcxfPUXoZfeWCihxzHayww+A7W6KoqJrAb8XmF9FytD73f9+Eel5rHN60o2IcHp
	+ZWg0WRIs2TMufDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11FA71388C;
	Mon, 22 Sep 2025 08:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nXUzA0oC0WjyCQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 22 Sep 2025 08:01:14 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] MAINTAINERS: Add dedicated entry for fbcon
Date: Mon, 22 Sep 2025 09:57:43 +0200
Message-ID: <20250922075821.23236-1-tzimmermann@suse.de>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[ffwll.ch,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

While fbdev as a whole is obsolete, fbcon is still relevant for
most Linux systems. But it's been under-maintained for some time.
I'm volunteering to keep an eye on fbcon.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 MAINTAINERS | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 838ae3c2b6fc..749844664f8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9666,6 +9666,25 @@ S:	Maintained
 W:	https://floatingpoint.billm.au/
 F:	arch/x86/math-emu/
 
+FRAMEBUFFER CONSOLE
+M:	Thomas Zimmermann <tzimmermann@suse.de>
+L:	dri-devel@lists.freedesktop.org
+L:	linux-fbdev@vger.kernel.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/fb/fbcon.rst
+F:	drivers/video/fbdev/core/bitblit.c
+F:	drivers/video/fbdev/core/fb_logo.c
+F:	drivers/video/fbdev/core/fbcon.c
+F:	drivers/video/fbdev/core/fbcon.h
+F:	drivers/video/fbdev/core/fbcon_ccw.c
+F:	drivers/video/fbdev/core/fbcon_cw.c
+F:	drivers/video/fbdev/core/fbcon_rotate.c
+F:	drivers/video/fbdev/core/fbcon_rotate.h
+F:	drivers/video/fbdev/core/fbcon_ud.c
+F:	drivers/video/fbdev/core/softcursor.c
+F:	drivers/video/fbdev/core/tileblit.c
+
 FRAMEBUFFER CORE
 M:	Simona Vetter <simona@ffwll.ch>
 S:	Odd Fixes
-- 
2.51.0


