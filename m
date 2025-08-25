Return-Path: <linux-kernel+bounces-785040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF71EB34511
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7AB5E6E79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FE93002CA;
	Mon, 25 Aug 2025 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mRM7fmOi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CmzkVPYx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pOP60BC/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8luhPKG/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF650230BD9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134057; cv=none; b=YRkx5Na+yyfLP02spMx4rIuHRpfK3bRZz5hp/wnHtvoawfLP6iF8Pk2rU1+9koDGQCk35HqgU5uGyRTg+xqDD890PhlxrqJMPsMcyjg30NqCZcbv8//IC35gQKUssSuTOJbLHVoe2QgVklHNMkJuXfNu0CSw+B6xDFHqK+j8mQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134057; c=relaxed/simple;
	bh=lHgApdEq9vbif+QsOoKsZxUmG08DK9veeuItqG77wKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i8O9P05AR7BgdflWek7uyE/oe7Kp2ho/P3o7qLzSTuaa5ZRxAPC64U1dc0ZYqV9n9r0oJgL31QAt/V7dsniq2mdJThMSXyihtRR2pRIrGplxWWqOFnXWq41lIKUFAhG4W3OmdvNHVxM1JEctR1KEyhidvQRk1sJqMkP3qkWZyGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mRM7fmOi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CmzkVPYx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pOP60BC/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8luhPKG/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1D7E1F788;
	Mon, 25 Aug 2025 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756134054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=htmUL+gC5WGFM/mXOJEztNxhNjH40j2U3LkYWEwqsA4=;
	b=mRM7fmOi5dSw+rvZ4q5u+Hz42rA4KDAgyQ64rgN7/a0F32oMSnFNosDOWi0sYzOX4qY+r0
	ID9jEHMud8hazgFSEveWA4ua2Ou9xF69S0XZQe1hQGbPHQF52Kf6MEQ2YwpJo2FGENVCDa
	Ra/J6vne+u7W8FXklH7Uxp1WPAyrPf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756134054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=htmUL+gC5WGFM/mXOJEztNxhNjH40j2U3LkYWEwqsA4=;
	b=CmzkVPYxz5ZsuX/LL7IFR3yymMc1vWpxjv+BuaWZ8kbfMe/rDuviaQ78WqPHw+GrbnEVJT
	UBXky7NE4FOgyBBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="pOP60BC/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="8luhPKG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756134053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=htmUL+gC5WGFM/mXOJEztNxhNjH40j2U3LkYWEwqsA4=;
	b=pOP60BC/ZLIfLOLdCGXW9JZC9Tp+/hJkAfwKOVYDBwtZ1kj91kswVSGCfPI3iRqxs5vNAx
	YxY+7BryTGX3kO+k52b3HlbOrUQdzORaFLYQYVCuIReXmLJsQrykOzXvf+qCxiK3jAxPXu
	HBvUqhVMLRX6AafHtxKvVV3UKXfRjj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756134053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=htmUL+gC5WGFM/mXOJEztNxhNjH40j2U3LkYWEwqsA4=;
	b=8luhPKG/j9uI0iWmMg0T1NbCFaVmAsroRoCRsLlHZsmWo9fWxG8UvsHMqMeCTA2zbu0zh3
	jdjier4q5lCP/FAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D17F0136DB;
	Mon, 25 Aug 2025 15:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BMrVMqV6rGi8PgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 25 Aug 2025 15:00:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 25 Aug 2025 17:00:37 +0200
Subject: [PATCH] scripts/misc-check: update export checks for
 EXPORT_SYMBOL_FOR_MODULES()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-export_modules_fix-v1-1-5c331e949538@suse.cz>
X-B4-Tracking: v=1; b=H4sIAJR6rGgC/x2MQQqAIBAAvyJ7TtgEMftKRERutVApWhGEf086z
 sDMC4kiU4JWvBDp5sT+KFBXAqZ1PBaS7AqDQqWxUVrSE3w8h927a6M0zPxINM5qa2aLaKGEIVL
 R/7Trc/4AzJZypGQAAAA=
X-Change-ID: 20250825-export_modules_fix-07d9597f9009
To: Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, 
 Daniel Gomez <da.gomez@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2138; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=lHgApdEq9vbif+QsOoKsZxUmG08DK9veeuItqG77wKA=;
 b=owGbwMvMwMG4+8GG0kuuHbMYT6slMWSsqVq07ecPBcHTK1plNz++N9ld5ENk0uN9CjZVQUsry
 z4eOSr/qZPRn4WBkYPBUkyRpXr3CUfRmcoe0zx8P8IMYmUCmSIt0sAABCwMfLmJeaVGOkZ6ptqG
 eoaGOkAmAxenAEz1jnL2/9FJXeJahSLvbRI8167znzhDWpR3d8ryO6Uzuc9vmzLRb21Xzc06qbo
 L+wXVQsSiMg6c9BaLNG1bNms1+4TURvH15pnLTzSsmefjvTE15WalQc7x/FvSVsk73wdacX8ojF
 LWr9qee21z/IVj3eLiHHMaXa6wTCzyaFD+v3gjX/0aXt9Jf+cc6p39gOEaq7f9qVB176VLwk9sv
 dHLcvhrvfOqhUq5OwqlUh4xGdzvzP1p7xZ65R7XFsMzZ5+rfNBzmMffHe2R4r1Ryqdlinf85+WN
 Uy+zyGrn5Brzi1/en3voEaf6SeFJgat2S/zl/bQgK89IxoOvNsafMVr5i9lqb4tz27PncbuKtOx
 gyFgGAA==
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E1D7E1F788
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.51

The module export checks are looking for EXPORT_SYMBOL_GPL_FOR_MODULES()
which was renamed to EXPORT_SYMBOL_FOR_MODULES(). Update the checks.

Fixes: 6d3c3ca4c77e ("module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to EXPORT_SYMBOL_FOR_MODULES")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
I've missed these new checks when renaming the export macro due to my
git grep being too narrow. My commit went through Christian's vfs tree
but seems the script is part of kbuild (which is currently Odd fixes).
---
 scripts/misc-check | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/misc-check b/scripts/misc-check
index 84f08da17b2c0508b5c2471a6ffb2ab7e36592a4..40e5a4b01ff473a7bfd2fdc156ae06c8cf18f504 100755
--- a/scripts/misc-check
+++ b/scripts/misc-check
@@ -45,7 +45,7 @@ check_tracked_ignored_files () {
 # does not automatically fix it.
 check_missing_include_linux_export_h () {
 
-	git -C "${srctree:-.}" grep --files-with-matches -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_GPL_FOR_MODULES)\(.*\)' \
+	git -C "${srctree:-.}" grep --files-with-matches -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' \
 	    -- '*.[ch]' :^tools/ :^include/linux/export.h |
 	xargs -r git -C "${srctree:-.}" grep --files-without-match '#include[[:space:]]*<linux/export\.h>' |
 	xargs -r printf "%s: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing\n" >&2
@@ -58,7 +58,7 @@ check_unnecessary_include_linux_export_h () {
 
 	git -C "${srctree:-.}" grep --files-with-matches '#include[[:space:]]*<linux/export\.h>' \
 	    -- '*.[c]' :^tools/ |
-	xargs -r git -C "${srctree:-.}" grep --files-without-match -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_GPL_FOR_MODULES)\(.*\)' |
+	xargs -r git -C "${srctree:-.}" grep --files-without-match -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' |
 	xargs -r printf "%s: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present\n" >&2
 }
 

---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250825-export_modules_fix-07d9597f9009

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


