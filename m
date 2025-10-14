Return-Path: <linux-kernel+bounces-852123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACC5BD8398
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B9442647F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C7430FC1F;
	Tue, 14 Oct 2025 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ivPmnqiV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5neRTWO+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qfEVIgkQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+hcqb1bq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2732630F53D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431265; cv=none; b=XDX596JXd7Rl+LO3boVMUgqkvrN+rp8FJJetSVsJiwo4f/PwEg1/KgDscHFZJB3HScw2zUfCZja6NBj0w15RAY6Tmzmdrb9MhWrKQ/5eUi9kTaLui26PgPNV8elfTb0gw/oH77C+CBNkyBEp7QY11KDR4f5G4i5y4b/Enar0PYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431265; c=relaxed/simple;
	bh=pPl6RhapejOsMg81F6RD18xhwMoZrS5BV8bYDWQ519A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pl/gKvdyqvy8iwBLRECRPhDjy0dsiQpJ57wX7lqc6ERFEF7FREglMMy2YVpsbwF5jdhsyen6nxKV3M5Q8oL6SgOSiAT0vACT9HJH8ohJmdRTdQvwuUOZfvNwn1GmyLiUFLTyiRIIxRkI3SSzoQDRk8sA/C2lmY4UJMmeTMCnilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ivPmnqiV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5neRTWO+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qfEVIgkQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+hcqb1bq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E48A41F7B9;
	Tue, 14 Oct 2025 08:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760431261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oD4N98xqKoKzh5mdGTCdnVsbHNjiWYye8KSN/sZHlMo=;
	b=ivPmnqiVD3lW6jQtv5IXSI6u5paQvz6x5PzlMIRpvkecw9HYw29HXFVkuA3TKyDYn1Z92E
	zLt37ChvkwBQpypkjMZRtY+aPZ0gm3UtRDtDua2d6HPvc1CHVlkJF0Y14GNE/OmW4BK65d
	o1Wto531LjdoSVYZywG0DKuSNEgR4qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760431261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oD4N98xqKoKzh5mdGTCdnVsbHNjiWYye8KSN/sZHlMo=;
	b=5neRTWO+ATqOjBCTRINXXRjrSI3gGlw1SSYXbB1BZqstYzTpvbUsvM/PbD5iUH/a/9M14U
	bsIHj7dks+8Q5bCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760431260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oD4N98xqKoKzh5mdGTCdnVsbHNjiWYye8KSN/sZHlMo=;
	b=qfEVIgkQ6o1sjqnc/Fe1/M8RBgZ5CyPLyFHFFahDDSqNve1L2QZemFc8anbNSIey5dmbo/
	RZBJiPu7AhwdGmcX03BlRuBWSRALYSUVqPlnTNE489bYdYOnXLMYRXTkizv6MgqmSfTo1d
	IqUyykSGOJ9ugU5dOW0ZN7RV4nBws4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760431260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oD4N98xqKoKzh5mdGTCdnVsbHNjiWYye8KSN/sZHlMo=;
	b=+hcqb1bqPU4mvm3h4A0Qx6ro8PLXOpwb3KsRtMV8dZ+GA22ZHLY+UKDeTKdxO4zF7epyDH
	OOVSZ/mlRdpHf8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D04A813A44;
	Tue, 14 Oct 2025 08:41:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G1uFMpwM7mg1IAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 14 Oct 2025 08:41:00 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 14 Oct 2025 10:40:57 +0200
Subject: [PATCH] slab: fix clearing freelist in free_deferred_objects()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-fix-freelist-v1-1-e402301f276d@suse.cz>
X-B4-Tracking: v=1; b=H4sIAJgM7mgC/x2MQQqAIBAAvyJ7TlDRg30lOoSutRAWuxFB+Pek4
 zDMvCDIhAKjeoHxJqGjdrCDgrQtdUVNuTM444I11utCjy6MuJNc2sVoA+aUXPHQk5Ox+383za1
 9wZAMpF4AAAA=
X-Change-ID: 20251014-fix-freelist-29915edcc2f4
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
Cc: kernel test robot <oliver.sang@intel.com>, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=pPl6RhapejOsMg81F6RD18xhwMoZrS5BV8bYDWQ519A=;
 b=owEBiQF2/pANAwAIAbvgsHXSRYiaAcsmYgBo7gyZePWrRv20PZ4gtsekRnTDi/+wx3O6/MQId
 xlDIfKeSv6JAU8EAAEIADkWIQR7u8hBFZkjSJZITfG74LB10kWImgUCaO4MmRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQu+CwddJFiJriLwgAnf3jwUayx0cBRT96peMbd7s7WEPHx6C
 LMsjWXyIMckLoLLip3RhZfPU3p+/e2zr/i7qR0ZRuef2J156WM40iqlqlIvUBRWDb6vu9Pp2dQi
 Fueb68BrxnZNVX4pp7Yl/oNIWMKaHZvlYOKiXDdLgMdiK13YyefYBY4iW29lioG9CWzM0nVob0s
 CSenTaTXRczmjAHlU+7cG5TJ5zAUkKWJVHUAMSzBEcyTSTJgsBOC5jGeMfBdIz/b56xpIcLpxRN
 5oe/zNFWvI+cLTFDXDfcZSPb4C4q58GPQsH/31SIZw7/7ygcaB8ixJbd3NGVTmZPxE8lREJSLuV
 ITcFp8oqpJg==
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,intel.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

defer_free() links pending objects using the slab's freelist offset
which is fine as they are not free yet. free_deferred_objects() then
clears this pointer to avoid confusing the debugging consistency checks
that may be enabled for the cache.

However, with CONFIG_SLAB_FREELIST_HARDENED, even the NULL pointer needs
to be encoded appropriately using set_freepointer(), otherwise it's
decoded as something else and triggers the consistency checks, as found
by the kernel test robot.

Use set_freepointer() to prevent the issue.

Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202510101652.7921fdc6-lkp@intel.com
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
will be added to slab/for-next-fixes and sent later this week
---
 mm/slub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b1f15598fbfd..64c17afc375b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6443,15 +6443,16 @@ static void free_deferred_objects(struct irq_work *work)
 		slab = virt_to_slab(x);
 		s = slab->slab_cache;
 
+
+		/* Point 'x' back to the beginning of allocated object */
+		x -= s->offset;
 		/*
 		 * We used freepointer in 'x' to link 'x' into df->objects.
 		 * Clear it to NULL to avoid false positive detection
 		 * of "Freepointer corruption".
 		 */
-		*(void **)x = NULL;
+		set_freepointer(s, x, NULL);
 
-		/* Point 'x' back to the beginning of allocated object */
-		x -= s->offset;
 		__slab_free(s, slab, x, x, 1, _THIS_IP_);
 	}
 

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251014-fix-freelist-29915edcc2f4

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


