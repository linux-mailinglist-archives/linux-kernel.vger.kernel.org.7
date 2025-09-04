Return-Path: <linux-kernel+bounces-801166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 151BDB440C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEFF3B0233
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12535280A5C;
	Thu,  4 Sep 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i7KI+yQX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wbrUx22H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i7KI+yQX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wbrUx22H"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D871B27FB34
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000378; cv=none; b=fZgufNRhHE5RkmGgagj3XsSWsaQWBo82B7qnmY34NrHiLTuRzz2G887iotY4+gKjw/UCLW8NbQgC41eodKeLLuLeCXgjb6+dRi9TgHdlZMr+6W2nO4ma9/5Z2qAA2bSshhozEKKpvOBX3n/sDN44Mpp0BbqwHZXMbjVAvm6SQ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000378; c=relaxed/simple;
	bh=WHx/iY/LhJhCYYCjEmJsGVMyF3rsnxjA0GvZRxhmIG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNy0vFgp64diD33ku58nyeKfpTFX9zgCD71yJgIozlu81J/cOQxUSJi0aCDiMhkk8FcasLClzPisdGj1Yfr7wna6j1qctc2ahvrRZRoRoPpLZIlbnmLYX9QzLuyIlZorqZHyPGB/0caJ7c2RGL1T7jzmTvT4Pq8ZMCN324wEaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i7KI+yQX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wbrUx22H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i7KI+yQX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wbrUx22H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 07AAC60514;
	Thu,  4 Sep 2025 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757000374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z8sxzrJuXBNtMEnHMoIlFnZIkPA9WbfEaLABJW67BbM=;
	b=i7KI+yQX3SUxo0tdViw5y7KnERN3rRUWqTWviFAkMApA9C/wlhJB8cPwOLpkK0/jAhorH5
	c/bHR1/a3U0Oy5Wonaw5VFxU/xYfr7bRtfuhulgWjQ77Zr/52rax1PtwIdhO669LUR1mOR
	9ty2FDW03DbhEWEG3sNH6JKQDcQIJj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757000374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z8sxzrJuXBNtMEnHMoIlFnZIkPA9WbfEaLABJW67BbM=;
	b=wbrUx22HQw7pDRV7iio6szHN4VvAi4yBsHfzBcX4/UxoLXzgJCaRCy9zpeM5JhtpJpd0it
	/w3rvfwc2LWo65BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i7KI+yQX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wbrUx22H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757000374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z8sxzrJuXBNtMEnHMoIlFnZIkPA9WbfEaLABJW67BbM=;
	b=i7KI+yQX3SUxo0tdViw5y7KnERN3rRUWqTWviFAkMApA9C/wlhJB8cPwOLpkK0/jAhorH5
	c/bHR1/a3U0Oy5Wonaw5VFxU/xYfr7bRtfuhulgWjQ77Zr/52rax1PtwIdhO669LUR1mOR
	9ty2FDW03DbhEWEG3sNH6JKQDcQIJj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757000374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z8sxzrJuXBNtMEnHMoIlFnZIkPA9WbfEaLABJW67BbM=;
	b=wbrUx22HQw7pDRV7iio6szHN4VvAi4yBsHfzBcX4/UxoLXzgJCaRCy9zpeM5JhtpJpd0it
	/w3rvfwc2LWo65BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D558C13AA0;
	Thu,  4 Sep 2025 15:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BNPIMrWyuWjmDwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 04 Sep 2025 15:39:33 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: midi2: Fix missing UMP group attributes initialization
Date: Thu,  4 Sep 2025 17:39:24 +0200
Message-ID: <20250904153932.13589-1-tiwai@suse.de>
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
X-Rspamd-Queue-Id: 07AAC60514
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01

The gadget card driver forgot to call snd_ump_update_group_attrs()
after adding FBs, and this leaves the UMP group attributes
uninitialized.  As a result, -ENODEV error is returned at opening a
legacy rawmidi device as an inactive group.

This patch adds the missing call to address the behavior above.

Fixes: 8b645922b223 ("usb: gadget: Add support for USB MIDI 2.0 function driver")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/usb/gadget/function/f_midi2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index 0a800ba53816..b351f9ae0fc5 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -1599,6 +1599,7 @@ static int f_midi2_create_card(struct f_midi2 *midi2)
 			strscpy(fb->info.name, ump_fb_name(b),
 				sizeof(fb->info.name));
 		}
+		snd_ump_update_group_attrs(ump);
 	}
 
 	for (i = 0; i < midi2->num_eps; i++) {
-- 
2.50.1


