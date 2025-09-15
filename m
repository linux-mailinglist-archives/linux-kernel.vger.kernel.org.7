Return-Path: <linux-kernel+bounces-817344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB7CB58105
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799D4188566C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26752239085;
	Mon, 15 Sep 2025 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JuKhUUpb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JuKhUUpb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3F21CFFD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950355; cv=none; b=oxZXm4H7ijNOyaSl3rlWPWmjHL8rueHUSuRmsPo4D1KsgGZ0PZIxsl2/E4hyj1sW3pb6EJLUlDWqpWQamtYNSDkAnIYU+AbXQVMr1mD5p3O/BhJRNyPKE31ZprcWRIl5HM9SprgNclX+SSva05f4QovF4e248lYBbl+9VGECSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950355; c=relaxed/simple;
	bh=OLuaaraOsWlg2xGbry+wtyANAtXvxZrhQxxn7u/wLAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=os53Q3tD+Ur+hOs/7XzYchBMgDx5sOzumlftwNtQ2jirrvmT0JiUCDoFRwUGfCXojpIN9A8nT4BrLQNb/wlqNS8+V59njYs2QvupqJJv8SMBEN36Z/t+ksT7i5cDD99FQjc6aZIeSsRbu4aE5YLRZpWX0f5a4EiNUvuLcZYZhqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JuKhUUpb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JuKhUUpb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB6F91FBAB;
	Mon, 15 Sep 2025 15:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757950351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7O6H4yncJtI6jRPxDIzl6fb1efR8GujWZKD7CmF704s=;
	b=JuKhUUpbXUa1W7YY+T5rdcwhDB/7E13XHKiW4CfOyWC87oUWcFiS62vFZZBZsc0Fw/2wCK
	5/5n1tTDzrOjXG0t9lNaB8pxbkDTFf0GWj1FxY/6K4WaTrPDUpOImweNs+ltILsrhoH5nf
	4qKfqWggHCttYdzup5Hb82ydICXMrUQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=JuKhUUpb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757950351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7O6H4yncJtI6jRPxDIzl6fb1efR8GujWZKD7CmF704s=;
	b=JuKhUUpbXUa1W7YY+T5rdcwhDB/7E13XHKiW4CfOyWC87oUWcFiS62vFZZBZsc0Fw/2wCK
	5/5n1tTDzrOjXG0t9lNaB8pxbkDTFf0GWj1FxY/6K4WaTrPDUpOImweNs+ltILsrhoH5nf
	4qKfqWggHCttYdzup5Hb82ydICXMrUQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C8A31368D;
	Mon, 15 Sep 2025 15:32:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U8grB48xyGjVdwAAD6G6ig
	(envelope-from <antonio.feijoo@suse.com>); Mon, 15 Sep 2025 15:32:31 +0000
From: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Subject: [PATCH 1/2] powerpc/boot: Add missing compression methods to usage
Date: Mon, 15 Sep 2025 17:31:14 +0200
Message-ID: <20250915153114.40578-1-antonio.feijoo@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
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
X-Rspamd-Queue-Id: BB6F91FBAB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

lzma and lzo are also supported.

Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
---
 arch/powerpc/boot/wrapper | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 3d8dc822282a..50607bc47d05 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -21,7 +21,7 @@
 #		(default ./arch/powerpc/boot)
 # -W dir	specify working directory for temporary files (default .)
 # -z		use gzip (legacy)
-# -Z zsuffix    compression to use (gz, xz or none)
+# -Z zsuffix    compression to use (gz, xz, lzma, lzo or none)
 
 # Stop execution if any command fails
 set -e
@@ -69,7 +69,7 @@ usage() {
     echo 'Usage: wrapper [-o output] [-p platform] [-i initrd]' >&2
     echo '       [-d devtree] [-s tree.dts] [-e esm_blob]' >&2
     echo '       [-c] [-C cross-prefix] [-D datadir] [-W workingdir]' >&2
-    echo '       [-Z (gz|xz|none)] [--no-compression] [vmlinux]' >&2
+    echo '       [-Z (gz|xz|lzma|lzo|none)] [--no-compression] [vmlinux]' >&2
     exit 1
 }
 
-- 
2.51.0


