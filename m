Return-Path: <linux-kernel+bounces-880054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0597C24C43
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF543B280F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3996634572B;
	Fri, 31 Oct 2025 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FrAfpZ81";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nSHxtqUZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FrAfpZ81";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nSHxtqUZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44513191DA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909771; cv=none; b=Bk2mikc1LMjfvOiwDEwLQMmI3pflKEqLebcdbEQGx8YdtOMNLQ45cgmBq5JbO43+QvS3xMABtO/04M7MbnD3qd4hB/yPGtXVamG/0ENXfqz0tHG0+GU9hAzJAQQ0FOzpFa9MawDUgbuEt/Tz09267LOsKHEKrDyKxUgOJytQq98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909771; c=relaxed/simple;
	bh=PLlU+2lXCMBeRfEItViZ1qjg2X0CS7+oNhR6439GPLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CWzwPLBOUa0XhnnBd1xJXM2bRxfEhHJc2WTPEI6qscibH1ExJayodrBK6GEe+e779oVojYNvqyKxi/ZH/RrsV/7HEJ5+R5edZ+bBY9w7sqEGGraxz9KCijYCmADq96DZHZY5VIUwJFfDG4bxCT0sYncyrpaZCCu7j/9KiRr1Fd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FrAfpZ81; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nSHxtqUZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FrAfpZ81; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nSHxtqUZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E27D1F79A;
	Fri, 31 Oct 2025 11:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761909766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BcnJIvSwDZhs7ECp6zYOD/Q72ZYy8BvgDp8BJdvIbgc=;
	b=FrAfpZ81CatnXX99hYcuVHm9zf6EDXCBOtvxZX55dZIj3BFEmAU4L+ONQgrEYuLem4AJvI
	P2uz32iLuyMDamQ4rUeoLnM3DbYXhNWvuNKeNkzJKwhwFak/d8UrybsJlkjtilWMO8CDHi
	YfnjFW5svbXS4fQg5LIYlfuqw6R3N6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761909766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BcnJIvSwDZhs7ECp6zYOD/Q72ZYy8BvgDp8BJdvIbgc=;
	b=nSHxtqUZwbSJY+T8FtWIIYEiqZjqk+rOcdHCIxiTljG446k6xdxxCAXRMiylCYdUvwD/V6
	JAr+sxtm4WHpIDCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FrAfpZ81;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nSHxtqUZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761909766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BcnJIvSwDZhs7ECp6zYOD/Q72ZYy8BvgDp8BJdvIbgc=;
	b=FrAfpZ81CatnXX99hYcuVHm9zf6EDXCBOtvxZX55dZIj3BFEmAU4L+ONQgrEYuLem4AJvI
	P2uz32iLuyMDamQ4rUeoLnM3DbYXhNWvuNKeNkzJKwhwFak/d8UrybsJlkjtilWMO8CDHi
	YfnjFW5svbXS4fQg5LIYlfuqw6R3N6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761909766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BcnJIvSwDZhs7ECp6zYOD/Q72ZYy8BvgDp8BJdvIbgc=;
	b=nSHxtqUZwbSJY+T8FtWIIYEiqZjqk+rOcdHCIxiTljG446k6xdxxCAXRMiylCYdUvwD/V6
	JAr+sxtm4WHpIDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E7B13393;
	Fri, 31 Oct 2025 11:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CeIDBwacBGnhSwAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 31 Oct 2025 11:22:46 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] checkpatch: add IDR to the deprecated list
Date: Fri, 31 Oct 2025 12:19:09 +0100
Message-ID: <20251031111908.2266077-2-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9E27D1F79A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[infradead.org,suse.de,intel.com,canonical.com,perches.com,gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Spam-Score: -2.01

As of commit 85656ec193e9, the IDR interface is marked as deprecated
in the documentation, but no checks are made in that regard for new
code. Add the existing IDR initialization APIs to the deprecated list
in checkpatch, so that if new code is introduced using these APIs, a
warning is emitted.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Carlos López <clopez@suse.de>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92669904eecc..bc72fa66c0ef 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -860,6 +860,10 @@ our %deprecated_apis = (
 	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
 	"kunmap_atomic"				=> "kunmap_local",
+	#These should be enough to drive away new IDR users
+	"DEFINE_IDR"				=> "DEFINE_XARRAY",
+	"idr_init"				=> "xa_init",
+	"idr_init_base"				=> "xa_init_flags"
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.51.0


