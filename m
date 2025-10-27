Return-Path: <linux-kernel+bounces-871780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B50C0E669
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C200503E56
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9D23112C9;
	Mon, 27 Oct 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PJN+i/fv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UYvCBPso";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PJN+i/fv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UYvCBPso"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1F522423A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574014; cv=none; b=k6LCDtcfkTukXbYmr02w7gt9YXIyNgEhyTdycqucfNXLorC8OaPlp/KuLyzZtJLshJ2+a80Gs8szaaID8Jku2QFZK8gaOgBCZT5sA8c5379sDzXvMvc5G39fOC5bGXpTRadMnmqWDCAkLCX8hgWRUGlhfpjB5hvzKx0oCXDJI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574014; c=relaxed/simple;
	bh=Iye0SFXYNk2qLxNGGg7+5T8YgqlaP6DUHwHmcOw0I2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJnjg6MNTw/T0GC7AeN1InmfRhALrdpYeAZDRJIqhr4HKs+VsBuyyewbtZhP5+oExkElx/9Olb1xGU1obYkdbHoy8KcTgnj8936n8K2UYhYkhrG5WZsxGmgYlyP4gqGkBpbufGanQpXNQopIXWthOcW2NuxLitYRhi/WdZ7lcGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PJN+i/fv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UYvCBPso; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PJN+i/fv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UYvCBPso; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21CF41F45B;
	Mon, 27 Oct 2025 14:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761574011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjdzQm5exJwMkoECe+jmGekr6J14A9CfzON8t7SsrV4=;
	b=PJN+i/fvebPtfIVO990VczsvcpPFlX4L+lrKt5cueUHrSZuTOoDpS9XRAXbAFKABtSEWT9
	xg1FnK0GjsoZiDn/cD2mfEpOQmbXhJQWhkTlGe2PIzhYbgZ4eZeLfIyScDDzEzsF2B/cX4
	VAxxIeXRTnVq+WkGTv7KQ49wuvfviCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761574011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjdzQm5exJwMkoECe+jmGekr6J14A9CfzON8t7SsrV4=;
	b=UYvCBPsolpFjoDTCPVJ3UkWAbCXR9XrBURjvdympOicBORo2grSippHdTSCsP52qOalFaV
	pZ1SvPykKPcPNOAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="PJN+i/fv";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UYvCBPso
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761574011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjdzQm5exJwMkoECe+jmGekr6J14A9CfzON8t7SsrV4=;
	b=PJN+i/fvebPtfIVO990VczsvcpPFlX4L+lrKt5cueUHrSZuTOoDpS9XRAXbAFKABtSEWT9
	xg1FnK0GjsoZiDn/cD2mfEpOQmbXhJQWhkTlGe2PIzhYbgZ4eZeLfIyScDDzEzsF2B/cX4
	VAxxIeXRTnVq+WkGTv7KQ49wuvfviCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761574011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjdzQm5exJwMkoECe+jmGekr6J14A9CfzON8t7SsrV4=;
	b=UYvCBPsolpFjoDTCPVJ3UkWAbCXR9XrBURjvdympOicBORo2grSippHdTSCsP52qOalFaV
	pZ1SvPykKPcPNOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF5DF13A9A;
	Mon, 27 Oct 2025 14:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gH6ILXp8/2jMdwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 27 Oct 2025 14:06:50 +0000
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
Subject: [PATCH 1/2] powermac: backlight: Include <linux/of.h>
Date: Mon, 27 Oct 2025 15:05:40 +0100
Message-ID: <20251027140646.227025-2-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 21CF41F45B
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
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linaro.org,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -3.01

Include <linux/of.h> to avoid dependency on backlight header to include
it. Declares of_find_node_by_name(), of_property_match_string() and
of_node_put().

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
 arch/powerpc/platforms/powermac/backlight.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powermac/backlight.c b/arch/powerpc/platforms/powermac/backlight.c
index 79741370c40c..1796327955c6 100644
--- a/arch/powerpc/platforms/powermac/backlight.c
+++ b/arch/powerpc/platforms/powermac/backlight.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/backlight.h>
 #include <linux/adb.h>
+#include <linux/of.h>
 #include <linux/pmu.h>
 #include <linux/atomic.h>
 #include <linux/export.h>
-- 
2.51.1


