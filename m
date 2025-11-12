Return-Path: <linux-kernel+bounces-897978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F973C540F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4643B0463
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C8034BA40;
	Wed, 12 Nov 2025 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GVPdv8gB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PoKOchBr"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72352882DB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974361; cv=none; b=VGMs7dtBS4TAA+z7p4MTDZ5YKdYCWJDB+gxd+EI5RR7SfGBcKQXTdoK16fn1hoCeItzfoeYzdUBqOzeZoOTePq1aCeXrBX3eSLjYwSqcQR07mbc5X1MAeX7v09VqiymWHPYUV7oeXcSTklhehLAek4PCnk/VDUPgfMmy3PE49Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974361; c=relaxed/simple;
	bh=cwN5kO2Ls027QfCOlQPW2RJOjgl8AQy2vyfF7N+Ineo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKK/m57oIs0mAwI0AfY0CzTyvk+Nlkvjs9t9gfDRULIkMI+MwHMks0Sicbfixpz7ap9SBzye7yOk66bMd+Ve+QbWO/AbKYET9kaoc/c2D+SU+/vpdm2EPs+GBm9Skx2irI8k5eOs+HfU0LHP2LtdPXJD0S9KZirBy8QSp7khmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GVPdv8gB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PoKOchBr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A03E51F798;
	Wed, 12 Nov 2025 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762974357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yRGLWkpQa9uIYX/AtD4vSt1Y1M+PHzn5XHA/2nTHW+Q=;
	b=GVPdv8gB32yLoDbqgldwsWI2Yq7rEF9pzMOcuVx0YEANf/Go+weh+mSYdQ9vSaOYEbOfts
	7fgxAyr3JVc9fGWPiYCuXu4YjutLTq4HMR1rsm+16vszcjN4LYH8dFAcx7JE5LT3eCsoES
	7LbUVnoh73MmWTjB60+yMlvYSIbtFYA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PoKOchBr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762974356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yRGLWkpQa9uIYX/AtD4vSt1Y1M+PHzn5XHA/2nTHW+Q=;
	b=PoKOchBra2IZNufGdLOgWwqyThP91P0VSISk2gcRL84cgQgy53YWwCC4JZollVnTQJtqAt
	SgPxYkTX4u5xfBI1mv7SyvbgzpGxG1prQcmwpmXmN7nEolT12W5gtyWXgu7VQAxEZaG5oV
	vUe3ddzZxdmAQnxOoESby9aG1rdGoLY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B0A53EA61;
	Wed, 12 Nov 2025 19:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e+88O5PaFGn+RQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Wed, 12 Nov 2025 19:05:55 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: x86@kernel.org
Cc: dave.hansen@linux.intel.com,
	mhocko@suse.de,
	asit.k.mallick@intel.com,
	linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [RESEND PATCH v2] x86/tsx: Set default TSX mode to auto
Date: Wed, 12 Nov 2025 21:05:48 +0200
Message-ID: <20251112190548.750746-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A03E51F798
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
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

At SUSE we've been releasing our kernels with TSX enabled for the past 6
years and some customers have started to rely on it. Furthermore, the last
known vulnerability concerning TSX was TAA (CVE-2019-11135) and a
significant amount time has passed since then without anyone reporting any
issues. Intel has released numerous processors which do not have the
TAA vulnerability (Cooper/Ice Lake, Sapphire/Emerald/Granite Rappids)
yet TSX remains being disabled by default.

The main aim of this patch is to reduce the divergence between SUSE's
configuration and the upstream by switching the default TSX mode to
auto. I believe this strikes the right balance between keeping it
enabled where appropriate (i.e every machine which doesn't contain the
TAA vulnerability) and disabling it preventively.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---

Changes since v2:

 * Reworded the changelog log to hopefully make it clear that this has been in
 use for quite some time.
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a..83f5132e2212 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1812,7 +1812,7 @@ config ARCH_PKEY_BITS
 choice
 	prompt "TSX enable mode"
 	depends on CPU_SUP_INTEL
-	default X86_INTEL_TSX_MODE_OFF
+	default X86_INTEL_TSX_MODE_AUTO
 	help
 	  Intel's TSX (Transactional Synchronization Extensions) feature
 	  allows to optimize locking protocols through lock elision which
--
2.51.1


