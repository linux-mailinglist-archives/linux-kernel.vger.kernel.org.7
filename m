Return-Path: <linux-kernel+bounces-892562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B80B0C455D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC87F4E7DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE702F7AD0;
	Mon, 10 Nov 2025 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VRicak9f";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VRicak9f"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF702F49E0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763026; cv=none; b=pHEC0tNBBkLgEG86rfRdT7d9gFmJIbi5By0iK+sCxwBIA46jIp5SVIc6T5Q7gWB9k/kAP5ApKGXg580XTchdPXcmyp4Et/vTFDukDiVCzFhYzfF1fGKl8aR1GBLR5AZRullcK3xaOh0A3XWUSTR9CVws9UOUCYCcj/p7y5/+1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763026; c=relaxed/simple;
	bh=5K3cbhRIv2b9gpQ4xIFbtLwYwxjyQ+Dv82BlRKExFvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRQI6GiELFCGeVJVVqn6pf1G3nsZB3/KgeGKgQvT5eRt5sSjzOBiu0O3wVZ+MhKHfLawCe3qz6wWbSG+DZPb1hI57Z70BYwz5BYFTG3ID2md0ZjxJQynL85Z2ul5q2f1FsRy+QceBxOCA73GKCimipeU1lxchXJXh4mh7qR4bV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VRicak9f; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VRicak9f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AF0C1F391;
	Mon, 10 Nov 2025 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762763022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5Phld49V4Xa1JQf1cr+8LmdV72Vi/NO3suskasOzE8I=;
	b=VRicak9f533L48A3OY93GZb4RF1fvyLNNwgXHI8//YvcOjoL9Pa4W57dwmntm5Anz5ndYH
	XFgGTWZpLKGfUqoMcdqcoWUvqF3bXcE732xVcitmatfMubBbOqbze0Y9tORWYaHDiThJKg
	LURL9C3DHdfmw4pLBimaKqdKtUUMXHY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762763022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5Phld49V4Xa1JQf1cr+8LmdV72Vi/NO3suskasOzE8I=;
	b=VRicak9f533L48A3OY93GZb4RF1fvyLNNwgXHI8//YvcOjoL9Pa4W57dwmntm5Anz5ndYH
	XFgGTWZpLKGfUqoMcdqcoWUvqF3bXcE732xVcitmatfMubBbOqbze0Y9tORWYaHDiThJKg
	LURL9C3DHdfmw4pLBimaKqdKtUUMXHY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DEEC13BAE;
	Mon, 10 Nov 2025 08:23:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qiNcDQ6hEWk1KAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 10 Nov 2025 08:23:42 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 0/3] x86/alternative: Patch a single alternative location only once
Date: Mon, 10 Nov 2025 09:23:36 +0100
Message-ID: <20251110082339.30144-1-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Instead of patching a single location potentially multiple times in
case of nested ALTERNATIVE()s, do the patching only after having
evaluated all alt_instr instances for that location.

Changes in V2:
- complete rework (Boris Petkov)

Changes in V3:
- split former V2 patch into 2 by introducing a helper function (Boris Petkov)
- repost the small cleanup patch 1 which was taken before, but has somehow
  vanished from the tip x86/alternative branch (it is still in the tip
  master branch, but I couldn't find it in any other tip branch).

Juergen Gross (3):
  x86/alternative: Drop not needed test after call of alt_replace_call()
  x86/alternative: Use a helper function for patching alternatives
  x86/alternative: Patch a single alternative location only once

 arch/x86/kernel/alternative.c | 135 +++++++++++++++++++---------------
 1 file changed, 76 insertions(+), 59 deletions(-)

-- 
2.51.0


