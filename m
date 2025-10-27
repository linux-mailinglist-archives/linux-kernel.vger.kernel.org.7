Return-Path: <linux-kernel+bounces-871781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BF8C0E5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9565B42343D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573E6311966;
	Mon, 27 Oct 2025 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gUnzp/E5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wy72e1WP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gUnzp/E5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wy72e1WP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F1308F11
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574021; cv=none; b=mbj3+aW+MGJFaCWJIZuXnOX4l6t6gxTdxK4gbbXrPvTtJkqOF5JOLCb4gZRb/plQI6jjvCMVD7yN/43sZ6lmMjkMJ/jljQh0PBofWtLD7OVKT3xjQYQZeiJ8QDvieJGcgVsSbUA3cST+ow0EGC+4kQCB8LGv3f5MwnJ8d4UbCo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574021; c=relaxed/simple;
	bh=EpBeB+ivRdAb2nMpb1oGK2kBF3RTo82Uac6SA2VLrmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVXaM9SlBF2WUqcIci3bBwkf9kus1e/anRh6MczsS2J8JgH/Gu2+IFYNZBuYCeuzj8XzjlkUbCOmYONvZLEql/biHfipI8JHyTaE+obHiGuO8zcPph3LfvAD6tZp3d/Ups3ffSDG039Kb5oRSqyIpF4h9OF1nrEM7pNfoacEKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gUnzp/E5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wy72e1WP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gUnzp/E5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wy72e1WP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 844F51F460;
	Mon, 27 Oct 2025 14:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761574011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMBRz3/kIbljTwwKsAee9oUPo7ZO+qDa/VXbEIyCMYc=;
	b=gUnzp/E5dgeNK4utjFx35ty+Oa/lR5jZzNWH4TjgFhibqHBCP2KK6hphD4ZSyD9hALnG5R
	lkKNqPIkgiDPmIF2LfNZDN/Gz+xP8TzUIuFEqQJFmhW7u3/hvL884lf8SKRH5oDs8M+zA8
	rAQh91cHYU1RaF+b+KXKOTvu4p5XvMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761574011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMBRz3/kIbljTwwKsAee9oUPo7ZO+qDa/VXbEIyCMYc=;
	b=wy72e1WP2bK7cNl5kZIo3AjYLeGz49QHkkmiG04jKEEgglYWm6HYgIIDbWWbcJLEkNpG5Q
	jbNsOpoJpagUaPBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761574011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMBRz3/kIbljTwwKsAee9oUPo7ZO+qDa/VXbEIyCMYc=;
	b=gUnzp/E5dgeNK4utjFx35ty+Oa/lR5jZzNWH4TjgFhibqHBCP2KK6hphD4ZSyD9hALnG5R
	lkKNqPIkgiDPmIF2LfNZDN/Gz+xP8TzUIuFEqQJFmhW7u3/hvL884lf8SKRH5oDs8M+zA8
	rAQh91cHYU1RaF+b+KXKOTvu4p5XvMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761574011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMBRz3/kIbljTwwKsAee9oUPo7ZO+qDa/VXbEIyCMYc=;
	b=wy72e1WP2bK7cNl5kZIo3AjYLeGz49QHkkmiG04jKEEgglYWm6HYgIIDbWWbcJLEkNpG5Q
	jbNsOpoJpagUaPBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27FBC13693;
	Mon, 27 Oct 2025 14:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MMhUCHt8/2jMdwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 27 Oct 2025 14:06:51 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: naresh.kamboju@linaro.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH 2/2] macintosh/via-pmu-backlight: Include <linux/fb.h> and <linux/of.h>
Date: Mon, 27 Oct 2025 15:05:41 +0100
Message-ID: <20251027140646.227025-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027140646.227025-1-tzimmermann@suse.de>
References: <20251027140646.227025-1-tzimmermann@suse.de>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,linaro.org:email,suse.de:email,suse.de:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[linaro.org,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Include <linux/fb.h> and <linux/of.h> to avoid dependency on backlight
header to include them. Declares of_machine_is_compatible() and defines
FB_BACKLIGHT_MAX.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 243ce64b2b37 ("backlight: Do not include <linux/fb.h> in header file")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/linuxppc-dev/CA+G9fYs8fn5URQx2+s2oNxdUgZkSrdLC0P1tNBW_n-6BaBkK2Q@mail.gmail.com/
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniel Thompson (RISCstar) <danielt@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/macintosh/via-pmu-backlight.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/macintosh/via-pmu-backlight.c b/drivers/macintosh/via-pmu-backlight.c
index 26bd9ed5e664..d91825bb0a5c 100644
--- a/drivers/macintosh/via-pmu-backlight.c
+++ b/drivers/macintosh/via-pmu-backlight.c
@@ -11,6 +11,8 @@
 #include <asm/ptrace.h>
 #include <linux/adb.h>
 #include <linux/backlight.h>
+#include <linux/fb.h>
+#include <linux/of.h>
 #include <linux/pmu.h>
 #include <asm/backlight.h>
 
-- 
2.51.1


