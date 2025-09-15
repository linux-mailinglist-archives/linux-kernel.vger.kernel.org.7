Return-Path: <linux-kernel+bounces-817123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B861B57E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 451667A79C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0772FE571;
	Mon, 15 Sep 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qvP7Z5tU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g6n7DP7i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qvP7Z5tU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g6n7DP7i"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4A3321445
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944526; cv=none; b=L8lM28+d2QFbPi6cWH5Xh8eXb30n0mnPKePJFE0XjMOJ7Xmzv/Nwk6yKXhvX9l9K+GkFf7awWZnN6w3YWzomsv9E1MQRTC7WyMaSaCdDTkbZE9NfM5mCBpPSXgvhf/ht73a14pOYZua3XRqmR62rVeNZl/xkgdskVqFhBGvsb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944526; c=relaxed/simple;
	bh=g4kg/TAwc9RlzfsPj1WGuRdVUmZUwh3CnL8dJNUAVfk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ohcT4MivaJPmKBreYsfYVKXg2ajv71erDxF34los9RiUk4kwpK/FzXlmKNGj8pGm1Gry0NahfRbd5Kw3d26Lu7dwgY8VmUZpVxFKpPAw1UXSd74Q3xpbF61/khKzg5mbXSSToZncoxxXcKieneiVPeHRdV1Foa9fVRiLChuyuow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qvP7Z5tU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g6n7DP7i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qvP7Z5tU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g6n7DP7i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EE131FB3B;
	Mon, 15 Sep 2025 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757944510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+hlNKe50qtnZa/ThWLJhkBfFNuIcFlBMZPRvxg4XaNI=;
	b=qvP7Z5tUSJIzxrKUfNyp8ekIAjuqPljxl0VOCg19zNaoB4dL1Omx2ve8lpzT01PyjNnR/a
	h6nsR/nMiQjEtBGqTS16xb0tjJvgtkLqiQf9bAnagS4F2xQq+0Si2wyf3PDgT/fhwbpzFl
	fO3FXMXJpQ3CwaEgYYn3ZwHVcvTvEUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757944510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+hlNKe50qtnZa/ThWLJhkBfFNuIcFlBMZPRvxg4XaNI=;
	b=g6n7DP7iOfPqsOwY69tuINAVXPLgsQDC9wmn9Ujnhca+gZMxLx2S6Qy2bWtU75ypeMv00G
	uoseyltuEgck1JCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qvP7Z5tU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g6n7DP7i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757944510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+hlNKe50qtnZa/ThWLJhkBfFNuIcFlBMZPRvxg4XaNI=;
	b=qvP7Z5tUSJIzxrKUfNyp8ekIAjuqPljxl0VOCg19zNaoB4dL1Omx2ve8lpzT01PyjNnR/a
	h6nsR/nMiQjEtBGqTS16xb0tjJvgtkLqiQf9bAnagS4F2xQq+0Si2wyf3PDgT/fhwbpzFl
	fO3FXMXJpQ3CwaEgYYn3ZwHVcvTvEUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757944510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+hlNKe50qtnZa/ThWLJhkBfFNuIcFlBMZPRvxg4XaNI=;
	b=g6n7DP7iOfPqsOwY69tuINAVXPLgsQDC9wmn9Ujnhca+gZMxLx2S6Qy2bWtU75ypeMv00G
	uoseyltuEgck1JCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 284761368D;
	Mon, 15 Sep 2025 13:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sw0tCb4ayGhnVgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Sep 2025 13:55:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 0/6] slab: struct slab pointer validation improvements
Date: Mon, 15 Sep 2025 15:55:07 +0200
Message-Id: <20250915-slub-slab-validation-v2-0-314690fc1532@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALsayGgC/4WNTQ6CMBCFr0JmbU1brIor72FY9GeQSQiQDjQq6
 d2tXMDNS76XfO9twBgJGW7VBhETMU1jAX2owPd2fKKgUBi01EY2SgkeVlfCOpHsQMEuRRAST50
 xjZNWBSjqHLGj1z77aAv3xMsU3/tLUr/2z2BSQoqrO1/Q1a4O3tx5ZTz6D7Q55y82cSuDtgAAA
 A==
X-Change-ID: 20250911-slub-slab-validation-0e4f559b0a1d
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 3EE131FB3B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

See below for v2 changelog. I'm going to apply to slab/for-next

This tries to combine the goals of the first 4 patches from Matthew's
series [1] with points raised during review by Christoph and myself.
Patch 4 from [1] is taken as patch 1 here. In other cases the struct
slab pointer validation is better to move to a place where it can be
performed before touching any of the struct slab fields, rather than
removing it completely.

Further we wrap the validation in a function validate_slab_ptr() and
make the impementation use struct page instead of struct folio to be
compatible with the rest of the series [1]. With further changes towards
memdesc the implementation can change accordingly, if it will still make
sense.

The summary is that we validate pointers from the node partial list when
allocating from it or when validation is triggered from sysfs. When
freeing, we always obtain the slab pointer in a way that the page type
is tested in the process, so we don't need to validate.

Based on:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.18/fixes

[1] https://lore.kernel.org/all/20250910115507.1991829-1-willy@infradead.org/

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes in v2:
- Restore remove_partial() in patch 5 (thanks to Harry)
- Add R-b's from Harry
- Change validate_slab_ptr() from static to static inline.
- In patch 5, wrap check added to alloc_single_from_partial() in #ifdef
  SLUB_DEBUG due to using slab_err() (thanks to lkp report).
- Also in patch 5, move validate_slab_ptr() under SLUB_DEBUG as it
  becomes an unused function otherwise and W=1 CC=clang complains
- Verify no warnings/errors at every step with W=1 CC=clang and
  SLUB_DEBUG either enabled or disabled.
- Link to v1: https://patch.msgid.link/20250911-slub-slab-validation-v1-0-8b67eb3b3dc5@suse.cz

---
Matthew Wilcox (Oracle) (1):
      slab: Remove dead code in free_consistency_checks()

Vlastimil Babka (5):
      slab: wrap debug slab validation in validate_slab_ptr()
      slab: move validate_slab_ptr() from check_slab() to its callers
      slab: move validate_slab_ptr() from alloc_consistency_checks() to its caller
      slab: validate slab before using it in alloc_single_from_partial()
      slab: don't validate slab pointer in free_debug_processing()

 mm/slub.c | 62 ++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 22 deletions(-)
---
base-commit: 41534d499e50e23571d6b9960498777d93f817ce
change-id: 20250911-slub-slab-validation-0e4f559b0a1d

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


