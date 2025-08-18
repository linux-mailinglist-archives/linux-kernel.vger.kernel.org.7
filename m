Return-Path: <linux-kernel+bounces-773408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6243B29F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7DA07AC125
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383F27817A;
	Mon, 18 Aug 2025 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sJiA3U+Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5tDbxFiQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sJiA3U+Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5tDbxFiQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F695258ED3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514188; cv=none; b=txW9GCHu/sTlvULQuD5WBd69AcyKjBlSfs12Pg8P2kya90X4RPBShYZJgGXnnsBawH88xIUFakNkNV33+1BfqLn8uXpcnEW1YiCL206CR0TlStPtmFeoILz2+e+7U0RINc03Gh1a5oeY8K5gYuoJAOjoz0rJhKYO4YioiGykSa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514188; c=relaxed/simple;
	bh=0UPhhVP2buaAp3DWsUl0ePEfpnjGlFILwrfVeqCPtOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHNK3pVIs1HEyZX6D2nyA1i2hSB6YQWq9fN89IUUV1K4dkjdsmXckRH5aFImI0RsrtWiY4bfZq1FGLRPeecaD/xA2qa31CvxI/bfKFF5tuY569Jme7HFk6TN1AyR8RYLKXCvE4BcVHCPy2hCO1D3vhVPzjWcIkq/JZ+lrh98S9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sJiA3U+Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5tDbxFiQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sJiA3U+Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5tDbxFiQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45EC91F453;
	Mon, 18 Aug 2025 10:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755514185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlwBaOHMbntngllLxUjfFjKuq9yqNdldF6MaODxPOy0=;
	b=sJiA3U+YIdigkzfeNGN6rSA6X5y7QA5l3KK10Kmq7tLmRWoQ4MFDVEPvbfGqmowbcK0RkW
	VSkmYYCh2F50w/xmSOq6mwci5PHB6pJF8gndrNfavnP1V5WrFTqN869KXGSsJ3AxMFKvIY
	PJV+7AWAzsUkSCCH7atBkThKc7U4n6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755514185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlwBaOHMbntngllLxUjfFjKuq9yqNdldF6MaODxPOy0=;
	b=5tDbxFiQ3zTYfX/mEe/DMBZAn9n++AvUbkzMCb4o7A2nQf8tMEKfFJVCUWWLInDW5hvHk8
	PpBMKawV1Ri3EsAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755514185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlwBaOHMbntngllLxUjfFjKuq9yqNdldF6MaODxPOy0=;
	b=sJiA3U+YIdigkzfeNGN6rSA6X5y7QA5l3KK10Kmq7tLmRWoQ4MFDVEPvbfGqmowbcK0RkW
	VSkmYYCh2F50w/xmSOq6mwci5PHB6pJF8gndrNfavnP1V5WrFTqN869KXGSsJ3AxMFKvIY
	PJV+7AWAzsUkSCCH7atBkThKc7U4n6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755514185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlwBaOHMbntngllLxUjfFjKuq9yqNdldF6MaODxPOy0=;
	b=5tDbxFiQ3zTYfX/mEe/DMBZAn9n++AvUbkzMCb4o7A2nQf8tMEKfFJVCUWWLInDW5hvHk8
	PpBMKawV1Ri3EsAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1522F13A73;
	Mon, 18 Aug 2025 10:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OBTxA0kFo2hQVQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 18 Aug 2025 10:49:45 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch,
	deller@gmx.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/6] fbcon: Fix empty lines in fbcon.h
Date: Mon, 18 Aug 2025 12:36:36 +0200
Message-ID: <20250818104655.235001-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818104655.235001-1-tzimmermann@suse.de>
References: <20250818104655.235001-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[ffwll.ch,gmx.de,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Add and remove empty lines as necessary to fix coding style. No
functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 4d97e6d8a16a..c535d8f84356 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -87,6 +87,7 @@ struct fbcon_ops {
 	u32    cursor_size;
 	u32    fd_size;
 };
+
     /*
      *  Attribute Decoding
      */
@@ -106,7 +107,6 @@ struct fbcon_ops {
 	((s) & 0x400)
 #define attr_blink(s) \
 	((s) & 0x8000)
-	
 
 static inline int mono_col(const struct fb_info *info)
 {
-- 
2.50.1


