Return-Path: <linux-kernel+bounces-812570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5C8B539DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F34C1618BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F33C362079;
	Thu, 11 Sep 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qhAFPYM2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YEoQNo6X";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hy24iXSK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="andfp8yJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F53629B1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610160; cv=none; b=hvTNKOJ3jz6yVOB4a8gcUh7v7Y/LygKph9AdYMR6f9R8vGcxxRpgXXotalxHOVxPoSl1MWnFbnjIBbP1piPHcWDcX9vGLr9phDgRlwQ9ELsbXs4hzkmhlfEpPM4/DVJ47JwBo76LrWu4L5MraB3ZUzN77IQg9pgGPAEfl3MtIjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610160; c=relaxed/simple;
	bh=k1LVm34E/55m3o3mkYwJ73lx2gtgc6PL1tEsoCjq874=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qLL+XEQTC2WYBuXjVF65J7MGJ57JpKLK7HajjaaC47lDAWzMdLOF0qn37ydKCasGVHHqHlqsm8kBNE1EpY4eBo4HcXuSu6iHCfS7bSHW/ijJfMEIr9GzQYvPjGk52/udqYZwm/+2JkO9RSRs0S7d7K5iXW7M7CamQpFMmi4vYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qhAFPYM2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YEoQNo6X; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hy24iXSK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=andfp8yJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E965137BDA;
	Thu, 11 Sep 2025 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g2ztmImEtHsUE0xBTiICNacQWE8dOeWq3duroo1FEbU=;
	b=qhAFPYM2SnuLz20qxuhKWKZ0rLm5zhSjQgMRpilJI+3oELqXb1FAyR7L0l3WLUGAUQSJ4+
	jXnhjifyAnjx9rhAS/iu1HyX38WAUfzzg3AE+X0JR9n7cGFFWQe9yZZ6EZ3Nin3A+Ygbfk
	aG+noUgni1g9LTg08jrIRPCs7euWwjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g2ztmImEtHsUE0xBTiICNacQWE8dOeWq3duroo1FEbU=;
	b=YEoQNo6XBUIz4+RdMmKvrzyvMg0Ot/SjXNdv9sLX72iURzS+kvgW7DFerUHcDTjlYA1GLJ
	0nYtarkevwXrEDCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g2ztmImEtHsUE0xBTiICNacQWE8dOeWq3duroo1FEbU=;
	b=Hy24iXSKWvbMWXb+T1YGLxlAStGu8Rm5K7MVyaFiGwojd/43zdw/ILB2JTNNHOADyln8Ec
	wd0Hb5ovxnBTCREti1JqG6sSTSlQT9a5uE1BXCd7Gw/avBKtpG/09/BCd3js2Yfcxh0U14
	s97zbHBto2elSbZ6sJX2BuYM4/NrHeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g2ztmImEtHsUE0xBTiICNacQWE8dOeWq3duroo1FEbU=;
	b=andfp8yJ1dw0dwpnxFUOrF/FONl/dn5PBDVA5KT0szTfKqiaGJ4e1UX8xvU1aX0MF41lYF
	rbqFzcDyaYXnbRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D07C613A56;
	Thu, 11 Sep 2025 17:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qKVIMqoAw2gUJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Sep 2025 17:02:34 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/6] slab: struct slab pointer validation improvements
Date: Thu, 11 Sep 2025 19:02:33 +0200
Message-Id: <20250911-slub-slab-validation-v1-0-8b67eb3b3dc5@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKkAw2gC/x2MQQqAIBAAvxJ7TtDIg30lOqy51YJYaEUQ/r2ly
 8AcZl4olJkKDM0LmW4uvCcR0zYwb5hWUhzEodOd1c4YVeLlBejVjZEDnhIoTf1irfMaTQBJj0w
 LP/92nGr9AGqWyipmAAAA
X-Change-ID: 20250911-slub-slab-validation-0e4f559b0a1d
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

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
allocating from it or when validation is triggered from sysfs.  When
freeing, we always obtain the slab pointer in a way that the page type
is tested in the process, so we don't need to validate.

Based on:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.18/fixes

[1] https://lore.kernel.org/all/20250910115507.1991829-1-willy@infradead.org/

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Matthew Wilcox (Oracle) (1):
      slab: Remove dead code in free_consistency_checks()

Vlastimil Babka (5):
      slab: wrap debug slab validation in validate_slab_ptr()
      slab: move validate_slab_ptr() from check_slab() to its callers
      slab: move validate_slab_ptr() from alloc_consistency_checks() to its caller
      slab: validate slab before using it in alloc_single_from_partial()
      slab: don't validate slab pointer in free_debug_processing()

 mm/slub.c | 61 +++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 24 deletions(-)
---
base-commit: 41534d499e50e23571d6b9960498777d93f817ce
change-id: 20250911-slub-slab-validation-0e4f559b0a1d

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


