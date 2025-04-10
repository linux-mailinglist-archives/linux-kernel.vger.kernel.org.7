Return-Path: <linux-kernel+bounces-597728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B5A83DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 11:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88D967B1D68
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 09:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F1220C470;
	Thu, 10 Apr 2025 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FGv+AO9m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oHlkGmum";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FGv+AO9m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oHlkGmum"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3E20C013
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275639; cv=none; b=ZCHcjfG1BjUD6NmXscM5+sqMOA21TWGzdmL63noRErPRcxNrTkm1ZhZwJtsRlULaF8JWSSSY7dBvtuWoftpeRF5q8um5kz59r6jXbnM4vIMu7yf4Lg2Zgptl41rsXOizNsvQdBaaZ9pUHHhpC9WIXb1YslUdzNs+MHqqQWHs5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275639; c=relaxed/simple;
	bh=t7BOttEgzanFiW6Dc+oFJ7dUkC97wSoKW4/xNET1DTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZk0iGWnlMEoVnkkstyuxRvvgZdnbbr4ILAjQMjk9av89n6pNa7Z4bzFBdH9RaTn61GF0ckAy2QHUlEdP+/jOqdthRvug6PKdu0MuK506P62aEopQgCIcl81FxYGl+BFT9f7DnyhFky29bAZDi/HGByeY7/1w3RJvYBMyVYI79c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FGv+AO9m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oHlkGmum; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FGv+AO9m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oHlkGmum; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C03E1F441;
	Thu, 10 Apr 2025 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744275635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NCW58uFTAN5+TrdqG7ZoxLkVoRVXQjENEOy4DXJ/hG4=;
	b=FGv+AO9mdjLjWwAUCCnC6XlklYeOyepRbypdjRIu0nkMdLRpMy1NB2AHXGUBkUQMAmBS2F
	K9CxXx9ht9m5OMIzUEXbpRTdgzLb2TQUEUY2sRxbXDgk6k+BizRliXY6hjfcqCrbpGP5V4
	LFkIHkSru/CfD0WNZTZXhjKxyh7f+Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744275635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NCW58uFTAN5+TrdqG7ZoxLkVoRVXQjENEOy4DXJ/hG4=;
	b=oHlkGmume1mmRpAdFaakLb3YTwAhuHIMZrq8gqAZNJe0mMdL8oAViSOuigfi7J3iVHE0vt
	zwdPqg1S9CogJBAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744275635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NCW58uFTAN5+TrdqG7ZoxLkVoRVXQjENEOy4DXJ/hG4=;
	b=FGv+AO9mdjLjWwAUCCnC6XlklYeOyepRbypdjRIu0nkMdLRpMy1NB2AHXGUBkUQMAmBS2F
	K9CxXx9ht9m5OMIzUEXbpRTdgzLb2TQUEUY2sRxbXDgk6k+BizRliXY6hjfcqCrbpGP5V4
	LFkIHkSru/CfD0WNZTZXhjKxyh7f+Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744275635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NCW58uFTAN5+TrdqG7ZoxLkVoRVXQjENEOy4DXJ/hG4=;
	b=oHlkGmume1mmRpAdFaakLb3YTwAhuHIMZrq8gqAZNJe0mMdL8oAViSOuigfi7J3iVHE0vt
	zwdPqg1S9CogJBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04EF813886;
	Thu, 10 Apr 2025 09:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C3zpALOI92fqEQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 10 Apr 2025 09:00:35 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Christoph Lameter (Ampere)" <cl@linux.com>,
	David Rientjes <rientjes@google.com>
Subject: [PATCH 1/2] MAINTAINERS: update SLAB ALLOCATOR maintainers
Date: Thu, 10 Apr 2025 11:00:22 +0200
Message-ID: <20250410090021.72296-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

With permission, reduce the number of maintainers. Create a CREDITS
entry for Joonsoo (Pekka already has one). Thanks for all the work!

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: Christoph Lameter (Ampere) <cl@linux.com>
Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index 1b77fba6c27e..f74d230992d6 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2071,6 +2071,10 @@ S: 660 Harvard Ave. #7
 S: Santa Clara, CA 95051
 S: USA
 
+N: Joonsoo Kim
+E: iamjoonsoo.kim@lge.com
+D: Slab allocators
+
 N: Kukjin Kim
 E: kgene@kernel.org
 D: Samsung S3C, S5P and Exynos ARM architectures
diff --git a/MAINTAINERS b/MAINTAINERS
index de97cd54ff24..4fe7cf5fc4ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22240,9 +22240,7 @@ F:	drivers/nvmem/layouts/sl28vpd.c
 
 SLAB ALLOCATOR
 M:	Christoph Lameter <cl@linux.com>
-M:	Pekka Enberg <penberg@kernel.org>
 M:	David Rientjes <rientjes@google.com>
-M:	Joonsoo Kim <iamjoonsoo.kim@lge.com>
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Vlastimil Babka <vbabka@suse.cz>
 R:	Roman Gushchin <roman.gushchin@linux.dev>
-- 
2.49.0


