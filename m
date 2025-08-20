Return-Path: <linux-kernel+bounces-777776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F238FB2DDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFC53AE7DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3976731CA78;
	Wed, 20 Aug 2025 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bKh8wWpK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bKh8wWpK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72931CA7D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696082; cv=none; b=gwlNYp0Eo/aveS0fa5vnK7v4zEyf+v/3prPpE5MwsvuxuvjN8meLPeKD8Do/YiFg8YQE08FCQWHqSyO6Pb/5gC2ahgmUZusHJXyITRZMTWIF116wfqXB8M7Pi4dIvKVNBbqRKoiJi5eNH+BVsTEsSfCl8EeJwPZOfAiJGlrE4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696082; c=relaxed/simple;
	bh=n8aN7MlbDwfpayeeicghvduY3pDeeHRjJ+BV1DQvPiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ctt2VbTFvccuB3KjhuHFfKisK3e1jeI4PCzcld66ntrAFO0po01DR3f06AeaJZ+VgxDr+M4oW20Mr7UsugwQ4nmWG/ppD/DhgLODAcYkoeqyPZUwfJEgJPFjfRurqZ1zCtXTV8jvqiFVV/qUfe7mof2fOiK9GiqM0zQYg5kohyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bKh8wWpK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bKh8wWpK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95FFB203F3;
	Wed, 20 Aug 2025 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755696077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0smMTVXZ8SuwCvFhEKw3PTnUff8TJavWD4ZfEN2Z6nw=;
	b=bKh8wWpKOuY4d1nsiSrbXraADgB9shhShDrktUo5czHAV5EyXWry5oMdSj8jNTgC/Vagax
	hiV0oY/XLnSmlmesVMckBcgTXWinJMJDV88s63mQEuktqQA6zRNnSP6Rq7jkwzEee4SPGO
	irZuC/l7dMmr3mcdiIlhW9Xf/lnaaBI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bKh8wWpK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755696077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0smMTVXZ8SuwCvFhEKw3PTnUff8TJavWD4ZfEN2Z6nw=;
	b=bKh8wWpKOuY4d1nsiSrbXraADgB9shhShDrktUo5czHAV5EyXWry5oMdSj8jNTgC/Vagax
	hiV0oY/XLnSmlmesVMckBcgTXWinJMJDV88s63mQEuktqQA6zRNnSP6Rq7jkwzEee4SPGO
	irZuC/l7dMmr3mcdiIlhW9Xf/lnaaBI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A52F13867;
	Wed, 20 Aug 2025 13:21:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3s+6BM3LpWj+RwAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Wed, 20 Aug 2025 13:21:17 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: x86@kernel.org
Cc: dave.hansen@linux.intel.comd,
	linux-kernel@vger.kernel.org,
	mhocko@suse.de,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/tsx: Set default TSX mode to auto
Date: Wed, 20 Aug 2025 16:21:04 +0300
Message-Id: <20250820132104.8633-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 95FFB203F3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
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
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

The last known vulnerability concerning TSX was TAA (CVE-2019-11135) a
lot of time has passed since then and Intel has released a numerous
processor which do not have the TAA vulnerability (Cooper/Ice Lake,
Sapphire/Emerald/Granite Rappids) yet have TSX disable by default.

I believe having the default to AUTO rather than OFF strikes a good
balance between mitigation and reaping the benefits of the TSX feature.
So let's switch the default to AUTO.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..d1c4a8840d7c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1810,7 +1810,7 @@ config ARCH_PKEY_BITS
 choice
 	prompt "TSX enable mode"
 	depends on CPU_SUP_INTEL
-	default X86_INTEL_TSX_MODE_OFF
+	default X86_INTEL_TSX_MODE_AUTO
 	help
 	  Intel's TSX (Transactional Synchronization Extensions) feature
 	  allows to optimize locking protocols through lock elision which
-- 
2.34.1


