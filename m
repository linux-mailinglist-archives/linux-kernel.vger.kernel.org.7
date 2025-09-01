Return-Path: <linux-kernel+bounces-795183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA097B3EDF0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D59A483040
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CDB324B07;
	Mon,  1 Sep 2025 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IFgZvYXk"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11734CDD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756751876; cv=none; b=mvgb0BOB9lrgzVERe2XE/ujGS+SJlHwos0ukCa2OPNxVJev63ggkxNroCBJ/SAojrsKxSzLQO+goqi/VuoNoX3e7Nmvev+OGWC5EXNMNBkgaa4zoeaokC/fmQFBnHvPFEueY1VwwoXAnAT5WnYWiOBJeUz+TcglZYh7Tb7LJIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756751876; c=relaxed/simple;
	bh=jflA4KKvdEKboLEf3KkUNt8Mmf15f4f7H187gFzHrkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abPpi/cv3gcwqosaBQgJPF/O8XfOzANRIr00uhruwVxL3za9/6xUwNFNND5Lygrr8rTVTQsyZjBTOwCbtFKEp4Fqc9X7uLIMKbGzktUNhPOyKz9etG1YCx0GCKrCsEStjJex2z2klYg8RcLIldNjnLtjUATVyx+TjtA6Oi8GTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IFgZvYXk; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oBLVwqjZ9ozuQvAMG2IXEqSvWHfxO3m3fGuPczFQRQg=; b=IFgZvYXkggEb1ow5yxf/KGJbZ/
	x5Wg7L4Ye33R00WYkqPItOz3yetWNs0A2liQxWzjh8MfBm13wWL1ZMgJ1JrfbZgGaeLqychhWXpGV
	upmItKwf5+/oUVYn8OQKMrZ+EV3uArtsxP7bErpBz4CxX9xAk4qWJefJ6oChQvPw2t9KZ/vEjPfi9
	A6lDy3U177zvNRBTOugg7VLaobc3Ct3uZ55HNU3zeIJt/Qr258QMikECG0HGCXFBHRHPBXAd3Xw+f
	uy95H/xMV077c6ZSDMNM+FsVv7hChs8bXD1Dm4KMM8h0EFuSbjz7yVFVOi2x7eRlUDwjRtjl6UoIA
	UA/wa3UQ==;
Received: from 179-125-64-234-dinamico.pombonet.net.br ([179.125.64.234] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ut9PX-005Oj2-F0; Mon, 01 Sep 2025 20:37:47 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH] mm: show_mem: show number of zspages in show_free_areas
Date: Mon,  1 Sep 2025 15:37:28 -0300
Message-ID: <20250901183729.3900578-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When OOM is triggered, it will show where the pages might be for each zone.
When using zram, it might look like lots of pages are missing. After this
patch, zspages are shown as below.

[   48.792859] Node 0 DMA free:2812kB boost:0kB min:60kB low:72kB high:84kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zspages:11160kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   48.792962] lowmem_reserve[]: 0 956 956 956 956
[   48.792988] Node 0 DMA32 free:3512kB boost:0kB min:3912kB low:4888kB high:5864kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:28kB active_file:8kB inactive_file:16kB unevictable:0kB writepending:0kB zspages:916780kB present:1032064kB managed:978944kB mlocked:0kB bounce:0kB free_pcp:500kB local_pcp:248kB free_cma:0kB
[   48.793118] lowmem_reserve[]: 0 0 0 0 0

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 mm/show_mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 41999e94a56d..ecf20a93ea54 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -310,6 +310,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 			" inactive_file:%lukB"
 			" unevictable:%lukB"
 			" writepending:%lukB"
+			" zspages:%lukB"
 			" present:%lukB"
 			" managed:%lukB"
 			" mlocked:%lukB"
@@ -332,6 +333,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 			K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
 			K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
 			K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
+			K(zone_page_state(zone, NR_ZSPAGES)),
 			K(zone->present_pages),
 			K(zone_managed_pages(zone)),
 			K(zone_page_state(zone, NR_MLOCK)),
-- 
2.47.2


