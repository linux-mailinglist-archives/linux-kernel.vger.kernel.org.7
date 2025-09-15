Return-Path: <linux-kernel+bounces-817339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCA7B580EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05371204988
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A538C18FDBE;
	Mon, 15 Sep 2025 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bCJY872m";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FV50nokF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B5E38DD8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950252; cv=none; b=I3kRpPezhq3Ofe9aNNeatG02lYt0PwdZZ8sanSIvc1nrAcp+zQbc1D2nI7NcE0dWBNUkypdR+seWAx1odsXSyViQY9U/IPsClblaSvJMqcdQfMiaNOV+So9fN7bxCFIc7iid1F0qq/OzE5ecmmNYM0exA5wrxgK6ENzKWZEhU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950252; c=relaxed/simple;
	bh=BfJvulmhkjMpKie4H3pe9laeqxd/C7gmJ5joqDs0Mgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXe3zRCQRc7TTZcrBxMsp6iFpByMLR768pONxYWVhXGvL3XHRzoPqWgQ57VH3UrFy8Gan1JzBgED01Q1ElX8/Ex6DbKFfMF3oIY0J3II7lemgv/Fvu6vWSfcenk/eJJhveZNM2I5FA1/g/JzaUTt28YtlT15PUU2O8CSsJGd5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bCJY872m; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FV50nokF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4DDE1FBAB;
	Mon, 15 Sep 2025 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757950246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gnpp7yykBMu415Och8szW/n2ntzL+rYn469m57fFnFs=;
	b=bCJY872mXHDXETNHNhDYQsrjwuBnkcN5HPTxf6UmJPoANlDiNMLKh4XOWtK7jItX3Cp0VF
	k9wH7XyPk6m33poMqh8grve+dFcXum023rO/aJLLEscoLZ20wT9r7seHrWeQdI4TcBJG5X
	huwNPcWXSAoKqQoCMFHgF0gt8cb4DSk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=FV50nokF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757950245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gnpp7yykBMu415Och8szW/n2ntzL+rYn469m57fFnFs=;
	b=FV50nokFLmUNK60m6RPXfupYsn4T5PZ/I+9ut6WJaddVBvMAUGk9FRVkA6NYC9IoQPxDBQ
	HKpNwyVBPJ4VXxRnK1XKdqQuT69vklitz7D3asOt1ZLVouyMETKLIuGromhGJwVpT+TyT1
	LX+5YVgVX448m/j81XFhAKQoRnfjZtI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 312481368D;
	Mon, 15 Sep 2025 15:30:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jcQ6CCUxyGhNdwAAD6G6ig
	(envelope-from <antonio.feijoo@suse.com>); Mon, 15 Sep 2025 15:30:45 +0000
From: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Subject: [PATCH] powerpc/boot: Fix check of supported compression methods
Date: Mon, 15 Sep 2025 17:25:30 +0200
Message-ID: <20250915152530.40256-1-antonio.feijoo@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,csgroup.eu,vger.kernel.org,lists.ozlabs.org,suse.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D4DDE1FBAB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

The current check is bogus and would allow to pass any value with the -Z
option.

Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
---
 arch/powerpc/boot/wrapper | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 50607bc47d05..8fbc4b98cfce 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -148,7 +148,7 @@ while [ "$#" -gt 0 ]; do
     -Z)
 	shift
 	[ "$#" -gt 0 ] || usage
-        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "lzma" -o "$1" != "lzo" -o "$1" != "none" ] || usage
+        [ "$1" = "gz" -o "$1" = "xz" -o "$1" = "lzma" -o "$1" = "lzo" -o "$1" = "none" ] || usage
 
 	compression=".$1"
 	uboot_comp=$1
-- 
2.51.0


