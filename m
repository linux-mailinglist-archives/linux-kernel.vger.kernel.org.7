Return-Path: <linux-kernel+bounces-796485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C70C4B40141
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969DD1B60BEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EDC2D6623;
	Tue,  2 Sep 2025 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jaZqhi2L"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05BD2C15AC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817427; cv=none; b=Kqx7itUKJtQH2eU4PYm+T6HAVE47JXqinWCpPiLaG5CVmOWjAMk3r0n7XSn1eBZMXFCk1zSP6FGhmX3t04q0AvJefSnDqS7YzNKAR7jpJsWQ0mJpRj0J0XcCqEIj9Jlev/rcHmuO6pEB4akXR1o7ot3JVLWerfheI1/Wo0E4wL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817427; c=relaxed/simple;
	bh=+bj5HWiEhhj3jHkPfkAcQJuEXI9zdw7S8/sYf75HpfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S3rdw3+1Ev7BYHmKq1W8vsM54NA/pddGR6JpOORpkLXIcdJjzR1ZbBBlwZky8Lh27Ns6b+EIrlNzEmytKREtoAfcMBUwpHB7iUrECN9qzC/EQq6qQVRmtxDTXtqcqaZCkxYp9kviGli6gXEOpcbN2fNHV2t/0rD8xgyrcXLxvyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jaZqhi2L; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OCLJ7IL81yMCm3CkgJ6YDqd5R6ee+khIMm++FZhsZD4=; b=jaZqhi2Luu8YSodhuadft0VC/J
	Umw97nj2ZI8vabQRSvpDogs7pWcqH2MdDlg63NSePyMA3ZI70QaVZCYGamLBT5jWSelo5ds4gg/hg
	JUjy8aksdRxUVsIvai2AcRoFzG/meS+XuLJefRPov9ETVNmX7TzO6dbbb1ywAicOIus991UjeNVTs
	DAx9VHfEEDjOy+G0xQYfKFiE6iUs7b+R/DUk9GzDmMNRHUIj3+kgMORFkzIIiKwNN1E8DJnRnaVYP
	tzrTQzkV32QBUh9N8n//3sAgVqPz9/V1uCGztpRkTZsGKRM0kkHAmN4sVGNHhbUzhW8/K5MFAxe2+
	Sb5w6qag==;
Received: from 179-125-64-234-dinamico.pombonet.net.br ([179.125.64.234] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utQST-005hVE-LJ; Tue, 02 Sep 2025 14:49:58 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: [PATCH v2] mm: show_mem: show number of zspages in show_free_areas
Date: Tue,  2 Sep 2025 09:49:21 -0300
Message-ID: <20250902-show_mem_zspages-v2-1-545daaa8b410@igalia.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250902-show_mem_zspages-d090ea0bd1d4
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit

When OOM is triggered, it will show where the pages might be for each zone.
When using zram or zswap, it might look like lots of pages are missing.
After this patch, zspages are shown as below.

[   48.792859] Node 0 DMA free:2812kB boost:0kB min:60kB low:72kB high:84kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zspages:11160kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   48.792962] lowmem_reserve[]: 0 956 956 956 956
[   48.792988] Node 0 DMA32 free:3512kB boost:0kB min:3912kB low:4888kB high:5864kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:28kB active_file:8kB inactive_file:16kB unevictable:0kB writepending:0kB zspages:916780kB present:1032064kB managed:978944kB mlocked:0kB bounce:0kB free_pcp:500kB local_pcp:248kB free_cma:0kB
[   48.793118] lowmem_reserve[]: 0 0 0 0 0

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
v2:
- fix build when CONFIG_ZSMALLOC is not enabled
---
 mm/show_mem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 41999e94a56d623726ea92f3f38785e8b218afe5..c563d9adfa87765a8736e91c1f68d824b03eaea8 100644
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
@@ -332,6 +333,11 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 			K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
 			K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
 			K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
+#if IS_ENABLED(CONFIG_ZSMALLOC)
+			K(zone_page_state(zone, NR_ZSPAGES)),
+#else
+			0UL,
+#endif
 			K(zone->present_pages),
 			K(zone_managed_pages(zone)),
 			K(zone_page_state(zone, NR_MLOCK)),

---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250902-show_mem_zspages-d090ea0bd1d4

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


