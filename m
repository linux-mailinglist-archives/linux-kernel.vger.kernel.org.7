Return-Path: <linux-kernel+bounces-742571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA3DB0F3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FEDF1892961
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932592E6D0A;
	Wed, 23 Jul 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i6SA9LjT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZpvuUxIh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i6SA9LjT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZpvuUxIh"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394482DEA89
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276923; cv=none; b=VPl4kEoRnbzjlBts7kFQxzxIkuIaJgl/DDUvcc7tv5HJVMd1qAhp/NoOxtncHVEygtplzKujyM6ajdS/mQuoQnKrpvGjemw7rVHcHRjiof/XDAqS3PvIYAKY4Z3C6c8EJbdH0T8sHLwVduTJC3DBeXHJRloXNF8TvXm0Pwu0kPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276923; c=relaxed/simple;
	bh=9QQmdfIEgUyM9n5x1fkoF40Zf2zzO4CHkfit4KIbmWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dfG9GyVG2RAj/uChtlPFxdh3j/IcIcmFBCbNMyRUf8e2ZNhpoMyI6zy9y9Cd3EPwpR4/L6x3BwAUKb5dMBSqlFDxmr+CdzPDZOHsT72E9/FLpXl1u3g9Wvy0VbwkBxVpOvJWVEF//zSHDvRchjfC+QwE8xZcUc8waPBcN9ohW90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i6SA9LjT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZpvuUxIh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i6SA9LjT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZpvuUxIh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 704491F78C;
	Wed, 23 Jul 2025 13:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753276920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i4NYr0kbK/ZVzHo53a7+hXGqtRRJAslzBId6sdThN7k=;
	b=i6SA9LjTJI5ePEOV72TyDb4JhYdrFL9L2QJoaJtJ8Ku5mkN5RomcpBXDkDdplvkRG3PXfa
	qRf7nCiLh3C7L7pR0eLgXxh0bH1IXLptLgWWt/PhQnFELjGrNjPtcSX91gel1+/BDHTr4s
	bwrGGrLEvNs6ieHrlqUyHCGOjuxj/WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753276920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i4NYr0kbK/ZVzHo53a7+hXGqtRRJAslzBId6sdThN7k=;
	b=ZpvuUxIhHCYiIeeLJxxODYBV6cJFDdhoCs6M4BsqXLsoBs4Rpvowrggj18cLycQ24oc+G+
	rzDtCvKHmno9qiCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753276920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i4NYr0kbK/ZVzHo53a7+hXGqtRRJAslzBId6sdThN7k=;
	b=i6SA9LjTJI5ePEOV72TyDb4JhYdrFL9L2QJoaJtJ8Ku5mkN5RomcpBXDkDdplvkRG3PXfa
	qRf7nCiLh3C7L7pR0eLgXxh0bH1IXLptLgWWt/PhQnFELjGrNjPtcSX91gel1+/BDHTr4s
	bwrGGrLEvNs6ieHrlqUyHCGOjuxj/WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753276920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i4NYr0kbK/ZVzHo53a7+hXGqtRRJAslzBId6sdThN7k=;
	b=ZpvuUxIhHCYiIeeLJxxODYBV6cJFDdhoCs6M4BsqXLsoBs4Rpvowrggj18cLycQ24oc+G+
	rzDtCvKHmno9qiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C88F913302;
	Wed, 23 Jul 2025 13:21:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9ojnLPfhgGhnHwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 23 Jul 2025 13:21:59 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH 0/3] fs: Remove old mount API helpers
Date: Wed, 23 Jul 2025 14:21:53 +0100
Message-ID: <20250723132156.225410-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.50.1
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Based on linux-next as of 23 July 2025.

This patchset contains a very small cleanup, where we remove mount_nodev
(unused since 6.15) and mount_bdev (unused since f2fs converted their
mount API usage, still in -next). Obviously depends on the f2fs patches
(maybe should be merged through their tree? I don't know.).

While we're at it, we also get to removing some stale mount API docs.

I did look into removing ->mount() altogether, but sadly 9pfs is still
using it.

Pedro Falcato (3):
  fs: Remove mount_nodev
  fs: Remove mount_bdev
  docs/vfs: Remove mentions to the old mount API helpers

 Documentation/filesystems/vfs.rst | 27 +------------
 fs/super.c                        | 63 -------------------------------
 include/linux/fs.h                |  6 ---
 3 files changed, 2 insertions(+), 94 deletions(-)

-- 
2.50.1


