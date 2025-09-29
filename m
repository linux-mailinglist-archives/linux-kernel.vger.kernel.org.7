Return-Path: <linux-kernel+bounces-836213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E09BA904E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235F5188EBB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1193F3002AE;
	Mon, 29 Sep 2025 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f4fGRBa8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f4fGRBa8"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D22FFFA2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145395; cv=none; b=G7VUUgtkZv75H+EfH9HEg6vmagwfOEBim89Bpm1LGDjvdp7lZIQT1pzm+4NMTqf/bzXB3u0Q4NJpTlJHqCLvWRNmg8OsrnLYu5HwsuHWzwISLIr3IK/sMbqRZoCsfctVmpsTXzReJHuucK7Glb1lW9kE87KvLaPresfpMYvVY+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145395; c=relaxed/simple;
	bh=obfhAsHGEGBqVy7kQQOajTlzlE8emXP3UxTc/P5HQGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sbxk2F5R/yZDQQCw9imuGW0v2LrlRx79RgYiKRZ0fQb1BMe2JwGfA+sR1IyoJd5RXwRVkvCNzPDlAn6upP69yBrftDdIZRuWeFkEj/7rsAcxC3YH1xx81y/XCHa7oGWJrLcto93zbqWvUIpKJrMfNrz5A0IuCQCi9pyqHap+ZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f4fGRBa8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f4fGRBa8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 776F831843;
	Mon, 29 Sep 2025 11:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759145390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zZvqEcXqWhiHPdrmp6kMjF9XPXUT65WMevLczPYp35s=;
	b=f4fGRBa8GvGXHnOsGDjuVWO6EVNPUQtUA/iRaTlveznywpTBzy0rLRWah/Nmm/i7PR6cNp
	WIDZ7FAvPmwv06WAUd2Bsku5FBGVq2i8u8mNwjboWJhVyECQznxjZhCNQPPmdjh7zGBG7n
	2TV+cSpkTTd670a2KAlwpE/lTVRQoRY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=f4fGRBa8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759145390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zZvqEcXqWhiHPdrmp6kMjF9XPXUT65WMevLczPYp35s=;
	b=f4fGRBa8GvGXHnOsGDjuVWO6EVNPUQtUA/iRaTlveznywpTBzy0rLRWah/Nmm/i7PR6cNp
	WIDZ7FAvPmwv06WAUd2Bsku5FBGVq2i8u8mNwjboWJhVyECQznxjZhCNQPPmdjh7zGBG7n
	2TV+cSpkTTd670a2KAlwpE/lTVRQoRY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3569413782;
	Mon, 29 Sep 2025 11:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eIugC65t2mg2cAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Sep 2025 11:29:50 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/3] x86/alternative: Make alternative patching more robust
Date: Mon, 29 Sep 2025 13:29:44 +0200
Message-ID: <20250929112947.27267-1-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 776F831843
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid]
X-Spam-Score: -3.01

This small series makes alternative patching a little bit more robust
for ALTERNATIVE_<n>() use cases by using a local buffer for merging
multiple patch actions of the same location.

With this series applied intermediate patch results due to multiple
features matching in a ALTERNATIVE_<n>() invocation won't be visible
to e.g. interrupt handlers being invoked between the single patching
operations.

Additionally any indirect call replacements with their direct call
equivalents no longer need to be placed carefully to be the first
executed patch action of an ALTERNATIVE_<n>() invocation, as the
needed reference of the indirect call of the original instruction
will still see the original code.

These patches have been sent before as part of my MSR paravirt rework
series. I'm sending them now as an independent series, as V2 of the
MSR series is no longer relying on them.

Juergen Gross (3):
  x86/alternative: Drop not needed test after call of alt_replace_call()
  x86/alternative: Refactor apply_alternatives()
  x86/alternative: Patch a single alternative location only once

 arch/x86/kernel/alternative.c | 86 ++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 37 deletions(-)

-- 
2.51.0


