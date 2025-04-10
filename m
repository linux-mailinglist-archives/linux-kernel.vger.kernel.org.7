Return-Path: <linux-kernel+bounces-597729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B14A83DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 11:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4AE9173B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 09:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC3B20C476;
	Thu, 10 Apr 2025 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s1ghZdpu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VBwc9V0/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DDA20C013
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275647; cv=none; b=ju+kxsOYTUVkEZHBIhvYUXqpFuRkX94hUP2YfQ/s9YQlH9d6/4o3xv9YQZDxWoR6YY+xA9XNtilk8Jf9S+RJAynJgFKU26BI7Kl1oAbVj3Y1jEgJqKdaxGGITR0Dyw+fi2ptdG59Q4l7hVpCNCV1SpoAXeJk5FJSXKGWeXi0tkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275647; c=relaxed/simple;
	bh=FEmHElBJejrokSd3xPs1QE7Yqwkl0UlhvxBJEg5WwdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQNh2YmNBFwzos6KA++Wia3oJR+G6gVLIsBl27tfSkkBa9olQcp0xfujfSCYyyYhNi+dyATl4AnpNDBqmLW8PsEqwuoNsRdiN/TvSCl5gnfklI3m4RhAbJnN5/bqZd+sKZ6Z0OBzB51eDw4KTigU6URLI3J+E30tA44ZXU9zTtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s1ghZdpu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VBwc9V0/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3669F1F445;
	Thu, 10 Apr 2025 09:00:35 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744275635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYDDnEV5Y0MeLaY+3FjAC6bXywrccw7v4r0ePjrHs5k=;
	b=s1ghZdpu+xhULAeLE4Dgse5uziK3ThzHlmvr2r/EJjOGH/Ww65kvBmM65q2xVAPX/9bj0E
	pJ37uWyfZjM9khhxECYTqK95MtJyw0XRF1LPQ4WRJ9BMduVcwKKidTdFe1uBq3okQxjhFz
	AEuZ2WzGT/i3GoH8925G2vbIuFvcZ3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744275635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYDDnEV5Y0MeLaY+3FjAC6bXywrccw7v4r0ePjrHs5k=;
	b=VBwc9V0/jyN841sMjBuTGmasKx+1//3t5sQjLyHqoVaLr7prKqAAy2QilMLP3olf8X3zDn
	KiZjpw+p6llcPmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A46B13A4B;
	Thu, 10 Apr 2025 09:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6E0jBrOI92fqEQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 10 Apr 2025 09:00:35 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 2/2] MAINTAINERS: add MM subsection for the page allocator
Date: Thu, 10 Apr 2025 11:00:23 +0200
Message-ID: <20250410090021.72296-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410090021.72296-3-vbabka@suse.cz>
References: <20250410090021.72296-3-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3669F1F445
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Add a subsection for the page allocator, including compaction as it's
crucial for high-order allocations and works together with the
anti-fragmentation features. Add reviewers (including myself) who
voluteered.

Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fe7cf5fc4ea..c0dbe29b9e45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15511,6 +15511,21 @@ F:	mm/numa.c
 F:	mm/numa_emulation.c
 F:	mm/numa_memblks.c
 
+MEMORY MANAGEMENT - PAGE ALLOCATOR
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	Vlastimil Babka <vbabka@suse.cz>
+R:	Suren Baghdasaryan <surenb@google.com>
+R:	Michal Hocko <mhocko@suse.com>
+R:	Brendan Jackman <jackmanb@google.com>
+R:	Johannes Weiner <hannes@cmpxchg.org>
+R:	Zi Yan <ziy@nvidia.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	mm/compaction.c
+F:	mm/page_alloc.c
+F:	include/linux/gfp.h
+F:	include/linux/compaction.h
+
 MEMORY MANAGEMENT - SECRETMEM
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Mike Rapoport <rppt@kernel.org>
-- 
2.49.0


