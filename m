Return-Path: <linux-kernel+bounces-592551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0442A7EEFB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 22:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D664422F98
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 20:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3BA1FC7D2;
	Mon,  7 Apr 2025 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D1Ie1KFO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2xxSbG9j"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C20221726
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056330; cv=none; b=ZT/BT2bkaVbWZ41NXuZAL4j/vb7qR0j903sn5HO0vQ9YCxLwGKorj/k1luWCRE91MryU8+Tr8Fj8a8jQVZbC6takEAjWh/i47vs8N6W0eEj/4XVQXTXcpnyxvb+Z1crJLqLH+b3veWTSUqI/ZWfvNcTk+tT0gCYFVcB1EFU0Zx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056330; c=relaxed/simple;
	bh=JB8IXb0Ha070M2DawyUQcJGuiY/0q8e7asydtE59Enc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/ZmsZMy2EqOSMYdxZYGPfY89NfE0z25DpUpwWj7ghaia1HFId6ZHZfsdOCtIpexz3O0ah+rALGZGrYDl7kvxYbmGvWP5r+XWqZZpUm13NIZvV+0Nlt7vLb2tbIofolKOXDxmEk+/tQoUXYxqjt3Fm/JJK9z203G/H9+t0ywUsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D1Ie1KFO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2xxSbG9j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9332B21175;
	Mon,  7 Apr 2025 20:05:16 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744056316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mu5Igb6PfT3RoV8eg0e5nAknLnS9vYsWz4r8fKsjoUY=;
	b=D1Ie1KFOxEVQNjQIKeBaZ9iuOJa5S0/UqQY7xoDlOBUN5vgWQvnwcaLoWJdvFuBmYvwjFK
	Ps5kfs8hqSsYXMS2IEDkdtd7nloXhe9V/84I4cblUMhlIh+FvdgieEEfofzHP24zvL8Fp4
	F85ZQOSDpMoModZ4lgNSEaLFw7v9PLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744056316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mu5Igb6PfT3RoV8eg0e5nAknLnS9vYsWz4r8fKsjoUY=;
	b=2xxSbG9jpnqLDLi/et8jRx2Fbz8AlBdiMJimKW2g5606HiZnJwy2/IDYlwr5e5cyO9iwQm
	pkHl/xvWPtmM1tAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7546113AB8;
	Mon,  7 Apr 2025 20:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GPBTHPwv9GclDQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 07 Apr 2025 20:05:16 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@kernel.org>
Subject: [RFC PATCH 2/2] MAINTAINERS: add MM subsection for the page allocator
Date: Mon,  7 Apr 2025 22:05:10 +0200
Message-ID: <20250407200508.121357-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407200508.121357-3-vbabka@suse.cz>
References: <20250407200508.121357-3-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 9332B21175
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Add a subsection for the page allocator, including compaction as it's
crucial for high-order allocations and works together with the
anti-fragmentation features. Volunteer myself as a reviewer.

Cc: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Extra reviewers would be welcome, including/not limited the people I
Cc'd based on my recollection and get_maintainers --git
Also if I missed any related file please lmk. Thanks.

 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fe7cf5fc4ea..610636f622b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15511,6 +15511,16 @@ F:	mm/numa.c
 F:	mm/numa_emulation.c
 F:	mm/numa_memblks.c
 
+MEMORY MANAGEMENT - PAGE ALLOCATOR
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	Vlastimil Babka <vbabka@suse.cz>
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


