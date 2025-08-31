Return-Path: <linux-kernel+bounces-793297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8998B3D1A7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA06B3AD877
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732D12561C2;
	Sun, 31 Aug 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RTVpPv6J"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A5C1D63E6
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633182; cv=none; b=m+gE0dCCFKtAk7VsKF7JR0r3uU6MlozmuQHYzZIAMlE/XNW8So2AEgcQN8i5JCAKgvELoK15VWB8mGuQIFPXYleoi/yGsjqwBKsu/7utSYlHm3dRN+nOssiXN+RZO4Yr5fN8/qWofAHopHF8sKk+xj4J9bMbO6mO0LhIXmukOJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633182; c=relaxed/simple;
	bh=/Nm5XGhdzQkNpKwR7Ib3TKLhoGMiX2JymV2ELO5tYH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGQxSsVSNrokQMqN2Qj55TSndQNRAn2kRXyHPZ7egHD4zzObf+bai21ZHPYyKk8PTwAahX8teEXrfu1+GdMfHW1ijTVaYk0g0YYvLoSOvjeoaDubdGGPr/4Mql+bsu/RdOBfLYtCuTuT2DsgUI6KI70YeFl6XYjCzhkDEECa8kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RTVpPv6J; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a8dd3dso480769866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756633179; x=1757237979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agcUJTbetPLLC7T8VbmvLYEfBB6utcDRFF105PwkvnA=;
        b=RTVpPv6J/GXAFNjxWTXhYdfVw+SnRjQt0TZ6qoHbKRjLUrNU6i5bsj6td9FjU1+/Wp
         CcMZtviFpdPJFxyGIV96g4331+S2ZwqTo/EgXo5k28IMfxfqApD6rR+0NJLf/P2FZ8Ut
         Ilx2jX873YYFMHuu4EWDekqDW9VB59A7ZcuyK0nQ63AKzxqQOIHY1ofjhZEAecbmtJV+
         484npgBX/u1Llf1vwXck7rRZbM0DO7hn/6acR/TwfM7N0+vW3MV0XZud8V7MJl4MZKLV
         RNSYbL/2n+TezZ0FPnL003ZK4vDIcFkAp2SzWjI4zgJ8QHzR6xNrFjobxojPcBusB+1x
         u40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756633179; x=1757237979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agcUJTbetPLLC7T8VbmvLYEfBB6utcDRFF105PwkvnA=;
        b=dov0FroMm22c1qjW/Uyfw8ExoUnmBcPeVDK1bY5tBGfsWis7uaJOR0XQlalu2dd3Uz
         T0eC78A6LjzLMdNTNxd6O+1iqGnxnJF5eSTTvBc5YF4A7ZPURHAUoxWpSQM6EyRZiop+
         QkRLdrANTRm23B5i5EbTKwM7JqxGcLKrF8QkUyohE2vS9Hy7cqEvsNjAR1+3+gec/yoz
         qxD2yrJiL5ez/3KH86VMYPK0b7xMzk4x2V3t+dBUWkKdFe8+k3XgdWg2r4a0cYOxH8gf
         sMhFBwZOhykqtGjz/Ur6kqNouw1m2vlJPZxF4cKxhQPE6ivGCL3fsq9H8UU3bPMaE3eU
         snSw==
X-Forwarded-Encrypted: i=1; AJvYcCVDNdv0LBFYtcW83QPFwLYv4oOTgx0+kQ+cpq7e3N5IQRbLjf/rHzf4uWyf0wUwEdBFdgo6lMzSayOqtiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFtQhv/gSYHJHHFdZPfxsNbmafSPuVG9NrHMnisWTOYq09Ssur
	8C6HPdiMhbWdr93cqSi3fahpdM8vqmlvBn0O/HdfmuEZRAAvHIAvmV7bvk7h/MEFccISWfwNmAR
	mcbbi
X-Gm-Gg: ASbGnctZpeVUvLd3NlLOdUzb4LAQqSofBTZ2vJ5WzAT5c0WWxLnGABWIX6Ij0TMcZWz
	bY4X2oeMQnzF7ivUd8iMQF1Y4bInzWk0FOzT4dStXJERQ1qIphWvKNfzbHCWHSeahWqhpdGz9HZ
	Lk4Xsq1K10DYOlQdyNaogKTf4j6p+BznOj5mvgZ0Ze2/6En57hq+M9lTlGHUe+EfkQYdQlLv7PW
	MSvXdVFGQU1W/K6Vm/KOeLg98cNapoHYBkFB6AHr2jmMDFvb5hbKh+MrQrzs2WYDZtk0UbSgupk
	HIpLzYk1eZGgJSdy4x8OvmYQgDEIF55LmmV0NXz27V+b+yWRM/EGEKOdEvyuNpeW7OEjQ2Xt9bv
	AO2+klGNQ2UL/sOX+LVL+ANY4c95KOFKxFdXJDRlLUGXUXTinU3s0PvAggjLmCiV5o2Gd5mOgGY
	HccuIzBbPjI2ZZ8MA9k+3aEzcX/W22rh70
X-Google-Smtp-Source: AGHT+IGOcaYq6pdvf8qss0FJ69VWFSUVu6c1gqKvRxFyz1rOmWyTevdbJuT1tri9g/lRb4gUoiv96w==
X-Received: by 2002:a17:907:3d0c:b0:afe:c099:aea8 with SMTP id a640c23a62f3a-b01d8a266abmr378742166b.9.1756633178673;
        Sun, 31 Aug 2025 02:39:38 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8656sm597512566b.56.2025.08.31.02.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:39:38 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 03/12] include/mmzone.h: add `const` to lots of pointer parameters
Date: Sun, 31 Aug 2025 11:39:09 +0200
Message-ID: <20250831093918.2815332-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250831093918.2815332-1-max.kellermann@ionos.com>
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mmzone.h | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fe13ad175fed..7228f3231f37 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1103,7 +1103,7 @@ static inline unsigned long promo_wmark_pages(const struct zone *z)
 	return wmark_pages(z, WMARK_PROMO);
 }
 
-static inline unsigned long zone_managed_pages(struct zone *zone)
+static inline unsigned long zone_managed_pages(const struct zone *const zone)
 {
 	return (unsigned long)atomic_long_read(&zone->managed_pages);
 }
@@ -1127,12 +1127,12 @@ static inline bool zone_spans_pfn(const struct zone *zone, unsigned long pfn)
 	return zone->zone_start_pfn <= pfn && pfn < zone_end_pfn(zone);
 }
 
-static inline bool zone_is_initialized(struct zone *zone)
+static inline bool zone_is_initialized(const struct zone *const zone)
 {
 	return zone->initialized;
 }
 
-static inline bool zone_is_empty(struct zone *zone)
+static inline bool zone_is_empty(const struct zone *const zone)
 {
 	return zone->spanned_pages == 0;
 }
@@ -1272,7 +1272,7 @@ static inline bool folio_is_zone_movable(const struct folio *folio)
  * Return true if [start_pfn, start_pfn + nr_pages) range has a non-empty
  * intersection with the given zone
  */
-static inline bool zone_intersects(struct zone *zone,
+static inline bool zone_intersects(const struct zone *const zone,
 		unsigned long start_pfn, unsigned long nr_pages)
 {
 	if (zone_is_empty(zone))
@@ -1580,12 +1580,12 @@ static inline int local_memory_node(int node_id) { return node_id; };
 #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
 
 #ifdef CONFIG_ZONE_DEVICE
-static inline bool zone_is_zone_device(struct zone *zone)
+static inline bool zone_is_zone_device(const struct zone *const zone)
 {
 	return zone_idx(zone) == ZONE_DEVICE;
 }
 #else
-static inline bool zone_is_zone_device(struct zone *zone)
+static inline bool zone_is_zone_device(const struct zone *const zone)
 {
 	return false;
 }
@@ -1597,19 +1597,19 @@ static inline bool zone_is_zone_device(struct zone *zone)
  * populated_zone(). If the whole zone is reserved then we can easily
  * end up with populated_zone() && !managed_zone().
  */
-static inline bool managed_zone(struct zone *zone)
+static inline bool managed_zone(const struct zone *const zone)
 {
 	return zone_managed_pages(zone);
 }
 
 /* Returns true if a zone has memory */
-static inline bool populated_zone(struct zone *zone)
+static inline bool populated_zone(const struct zone *const zone)
 {
 	return zone->present_pages;
 }
 
 #ifdef CONFIG_NUMA
-static inline int zone_to_nid(struct zone *zone)
+static inline int zone_to_nid(const struct zone *const zone)
 {
 	return zone->node;
 }
@@ -1619,7 +1619,7 @@ static inline void zone_set_nid(struct zone *zone, int nid)
 	zone->node = nid;
 }
 #else
-static inline int zone_to_nid(struct zone *zone)
+static inline int zone_to_nid(const struct zone *zone)
 {
 	return 0;
 }
@@ -1646,7 +1646,7 @@ static inline int is_highmem_idx(enum zone_type idx)
  * @zone: pointer to struct zone variable
  * Return: 1 for a highmem zone, 0 otherwise
  */
-static inline int is_highmem(struct zone *zone)
+static inline int is_highmem(const struct zone *const zone)
 {
 	return is_highmem_idx(zone_idx(zone));
 }
@@ -1712,12 +1712,12 @@ static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 	return zoneref->zone;
 }
 
-static inline int zonelist_zone_idx(struct zoneref *zoneref)
+static inline int zonelist_zone_idx(const struct zoneref *const zoneref)
 {
 	return zoneref->zone_idx;
 }
 
-static inline int zonelist_node_idx(struct zoneref *zoneref)
+static inline int zonelist_node_idx(const struct zoneref *const zoneref)
 {
 	return zone_to_nid(zoneref->zone);
 }
@@ -2020,7 +2020,7 @@ static inline struct page *__section_mem_map_addr(struct mem_section *section)
 	return (struct page *)map;
 }
 
-static inline int present_section(struct mem_section *section)
+static inline int present_section(const struct mem_section *const section)
 {
 	return (section && (section->section_mem_map & SECTION_MARKED_PRESENT));
 }
@@ -2030,12 +2030,12 @@ static inline int present_section_nr(unsigned long nr)
 	return present_section(__nr_to_section(nr));
 }
 
-static inline int valid_section(struct mem_section *section)
+static inline int valid_section(const struct mem_section *const section)
 {
 	return (section && (section->section_mem_map & SECTION_HAS_MEM_MAP));
 }
 
-static inline int early_section(struct mem_section *section)
+static inline int early_section(const struct mem_section *const section)
 {
 	return (section && (section->section_mem_map & SECTION_IS_EARLY));
 }
@@ -2045,27 +2045,27 @@ static inline int valid_section_nr(unsigned long nr)
 	return valid_section(__nr_to_section(nr));
 }
 
-static inline int online_section(struct mem_section *section)
+static inline int online_section(const struct mem_section *const section)
 {
 	return (section && (section->section_mem_map & SECTION_IS_ONLINE));
 }
 
 #ifdef CONFIG_ZONE_DEVICE
-static inline int online_device_section(struct mem_section *section)
+static inline int online_device_section(const struct mem_section *const section)
 {
 	unsigned long flags = SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE;
 
 	return section && ((section->section_mem_map & flags) == flags);
 }
 #else
-static inline int online_device_section(struct mem_section *section)
+static inline int online_device_section(const struct mem_section *const section)
 {
 	return 0;
 }
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-static inline int preinited_vmemmap_section(struct mem_section *section)
+static inline int preinited_vmemmap_section(const struct mem_section *const section)
 {
 	return (section &&
 		(section->section_mem_map & SECTION_IS_VMEMMAP_PREINIT));
@@ -2075,7 +2075,7 @@ void sparse_vmemmap_init_nid_early(int nid);
 void sparse_vmemmap_init_nid_late(int nid);
 
 #else
-static inline int preinited_vmemmap_section(struct mem_section *section)
+static inline int preinited_vmemmap_section(const struct mem_section *const section)
 {
 	return 0;
 }
-- 
2.47.2


