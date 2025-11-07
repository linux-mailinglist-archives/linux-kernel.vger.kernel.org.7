Return-Path: <linux-kernel+bounces-890495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDF2C40319
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BF034EF2DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F130E82D;
	Fri,  7 Nov 2025 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QysSwRDl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OiwMZ6Do";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QysSwRDl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OiwMZ6Do"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A01D31B9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523510; cv=none; b=PwEaweinPRSbZuNin2g69kJGsS8OvvckTIGUVYcFly/9EblTaiyKhJRSqSdcNmUtFhd+W3iBXS/IxlBQUy8gyk3DV2/c969cOmLgbyyRPFaiGY3xKSd+GGjznsopiTAzdVhQxSeX0JiqdtnBLzJ6TsIQeoQbIpFHDxfyFXr9QE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523510; c=relaxed/simple;
	bh=lyookCFVfPv1u1BmTcUOzKtlbGGER8Z6Qv7yP+FQmQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dMMLeuF4QhWpK9QXgS9aZON8viTIsWdvAnfWPzvWHvH6G3nbPDIaHT7sjRVFJ9r8h7epiphqjyfIhPwpWKxbB4oQCpViTPvRgNEyPs063ZVie4YjuY4nOAF2QmHXrNp7cPXbLIrkVIAzmyh3x7NtL1MCRDeOqsQbhkhaqAKAJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QysSwRDl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OiwMZ6Do; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QysSwRDl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OiwMZ6Do; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82B381F393;
	Fri,  7 Nov 2025 13:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762523506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZOKUn5/c3sgqBKSdzqv5puBNSGqcxYOY50bMuPQ6FtQ=;
	b=QysSwRDlJjot7XbCTUK4+VwAd0JrkqSAvtQMF01zszePAkvqqnLrVLfCm3pF0w2n4bMzUf
	TbeLdY8Aq3TNYFLOKv0BJdRutQR9sONjqXwDWTr0ZDe8KkxTZ+MGjLYCwHWKinAfW3Hr1l
	rumOGdL+M3CCQ4azzvj6wCCfrh74MOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762523506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZOKUn5/c3sgqBKSdzqv5puBNSGqcxYOY50bMuPQ6FtQ=;
	b=OiwMZ6Do9EnqP6Q8PRpRkv62XnohGr/qpNLg+ZMD5S9pfYyg/2wbEywK7M5skMWj4ViiT9
	rFytoJpbdMwhatDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762523506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZOKUn5/c3sgqBKSdzqv5puBNSGqcxYOY50bMuPQ6FtQ=;
	b=QysSwRDlJjot7XbCTUK4+VwAd0JrkqSAvtQMF01zszePAkvqqnLrVLfCm3pF0w2n4bMzUf
	TbeLdY8Aq3TNYFLOKv0BJdRutQR9sONjqXwDWTr0ZDe8KkxTZ+MGjLYCwHWKinAfW3Hr1l
	rumOGdL+M3CCQ4azzvj6wCCfrh74MOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762523506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZOKUn5/c3sgqBKSdzqv5puBNSGqcxYOY50bMuPQ6FtQ=;
	b=OiwMZ6Do9EnqP6Q8PRpRkv62XnohGr/qpNLg+ZMD5S9pfYyg/2wbEywK7M5skMWj4ViiT9
	rFytoJpbdMwhatDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FB001395F;
	Fri,  7 Nov 2025 13:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f5XvGnL5DWlFCwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 07 Nov 2025 13:51:46 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/4] slab: cmpxchg cleanups enabled by -fms-extensions
Date: Fri, 07 Nov 2025 14:51:22 +0100
Message-Id: <20251107-slab-fms-cleanup-v1-0-650b1491ac9e@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFr5DWkC/x3MQQqAIBBA0avErBvQSIquEi3UxhooC4cikO6et
 HyL/zMIJSaBocqQ6GbhIxbougK/2rgQ8lwMjWqM1qpD2azDsAv6jWy8TuxJe2+CITe3ULIzUeD
 nX47T+37G4gNZYgAAAA==
X-Change-ID: 20251107-slab-fms-cleanup-8e1cc5f5ebd4
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

After learning about -fms-extensions being enabled for 6.19, I realized
there is some cleanup potential in slub code by extending the definition
and usage of freelist_aba_t, as it can now become an unnamed member of
struct slab. This series performs the cleanup, with no functional
changes intended. Additionally we turn freelist_aba_t to struct
freelist_counters as it doesn't meet any criteria for being a typedef,
per Documentation/process/coding-style.rst

It is based on:
- slab/for-next-fixes
- this cleanup patch https://patch.msgid.link/20251103-fix-nolock-loop-v1-1-6e2b3e82b9da@suse.cz
  (first of another series) to avoid conflicts in __slab_free()
- merge 'kbuild-ms-extensions-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux

All of that is provided here:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/slab-fms-cleanup

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Vlastimil Babka (4):
      slab: separate struct freelist_tid from kmem_cache_cpu
      slab: turn freelist_aba_t to a struct and fully define counters there
      slab: use struct freelist_counters for local variables instead of struct slab
      slab: use struct freelist_counters as parameters in relevant functions

 mm/slab.h |  52 ++++++++++-----------
 mm/slub.c | 155 ++++++++++++++++++++++++++++----------------------------------
 2 files changed, 93 insertions(+), 114 deletions(-)
---
base-commit: c77d09928c398df0556e8ef659b4235559e0a374
change-id: 20251107-slab-fms-cleanup-8e1cc5f5ebd4

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


