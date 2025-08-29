Return-Path: <linux-kernel+bounces-792297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3DFB3C279
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E4B585007
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41201345758;
	Fri, 29 Aug 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XeMb6rzl"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60072342CA7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492333; cv=none; b=QdmUA4lnE4cumfQTnwZaUrdZ2q80HPpytFkfjwRxOuwADt0BKGsABHrZ3tQPRstcliEd5hi2LMcK42DLp650vujtCxn/5sAGU5zvLqkZ36jv8r/K4Wney03eIiX8PvEDQRztEDj85SD3JiN6wFK493W/q0116Jq1WRZzswluewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492333; c=relaxed/simple;
	bh=aXwi7Ga+vY1+/XPJOpk+/THT/DrRsDPnsU7q5jxV2hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRYeboATU3qLPmYtF02HgjOPnjOpyQIAqCGw/1/cdjtku10OdWlgJ3j+C6Z60YF2OipcU4hr0VlSB1/CeYEiDBAZINv0APiVPNnYLqaObKIBFIT5zAAFcNLhRELv0egcf4MJvLkRAHKq6FDrP2QYnxGrNf1RdRLFyS8ztSY6nfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XeMb6rzl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae31caso453203866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756492330; x=1757097130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oibqmI8v+HWCWZ9ViDRReAYoAk04POfRsF79xWQhEJY=;
        b=XeMb6rzlkRk+6lqykoG2kqkMubLoB3X+9A9mlDDvWv6qZ4fKsN4JtQ4Us9J7A1hl9d
         5mw0947sZ0ZX1CZTPq1xLottFCtcYKxH8xobEShRlf066XnAQtZTv5eRb45Hl9zH8dzt
         cNPX3dKELeBURHRB6UXxv85TWu53JiwOB+vmUXaKLR6/nGPnssxbGnsS7piHd2pVlGq+
         MewtVyCpeZc2PPREBghEf3igBxJlGjSJK/G3vbKnLvjf9GTc0ZLUnNVeIprlfe/MKcGm
         iu7yRZVNAy5e2wUl18yR41LBb682L06gHIRSagCmJ9qq616EwaA+bs3ESdRCNDLCWrr+
         e6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492330; x=1757097130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oibqmI8v+HWCWZ9ViDRReAYoAk04POfRsF79xWQhEJY=;
        b=Ola5Ukfk9/+SyVLf4TNU55+230q+oR4XIs19xDRRN6Jnvhe72bqEoyP8P1gOx+8nPO
         0UKuHqRFELp4bczEzcuDcA1eblfqQIoUKahL42RE1/J3urBoUpXaAuvtPF+HXqVSdzUs
         KVow34n9wxprXCOGupyW+hRsRnTAjSc5OhhVxTT4GcNe86nXS1gH1xUenFyYpQu7B016
         VnCCC7V/+p4gWksJkQStwStMN+oA4FBVzhzEDOgBYR0zrnCicyu3Nul1P/3hmpyzmHim
         XRn9BPEV2ADZWFvzezZQmLt8aT/tI0B5w7O2H/aLTF0WeHnGM6QzHgXA8bwd81eue8mZ
         9haw==
X-Forwarded-Encrypted: i=1; AJvYcCWIuIHAstCoVpw9raF7+1qixpW+V1YRKfx0V7kIRiQFkrRq68b498M361o9Lo+4MkcRa2BMTgYciD4hMkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEN/N6MtCYQC7IUu4F7URxdzjOxx79MVyEK2xCPQF08GkE3cOf
	RA6tgH/0rqJDQHHN5EH09FrAhItVC5f6KZ6TTUFCpmVB7agw356/Ar/8v5Y0wK0RhnM=
X-Gm-Gg: ASbGncsjcFe19DEZz50yYV0i8GyVeaegF9KJQeAgBlK7bYPpyDyVYlghzrul3rB5K8w
	P48F82R/hdXi47xr1gethu53hAWDqJnp0GWQm/Ifg5AIkkWZ+xZlnPhgWsFCp2EU+zyLj/xGsrQ
	LZik2vJsV+Eop3HFXGSEbhmcKFHqERA7EK1wNhZHda+0UCyZbGT6Rg+TGpK2rACvb64njNSf5Ny
	l8zEES/awo+OItslA2nyFY/Ou7ezV9xmdHLfWySRYjoOHxOAiyOBy6S5fYwal0DOIj4gz6dkxR+
	Ar8EYLEHIdIYZkwSQzxAkrokRo0RzKco5K1QrT0NOA1UU4apdApZ0i37C/TQCN4rC2o919tqRQG
	FURvDY7/tR969TC16fNi5w02s4CLoggX/CRyv1JEbfF06RET+DBiiyorj8WQF4ihti/wt/Bh3Cc
	OK5Cxo2FAnC6yN9KsFEvu7S/5gdued8i3v
X-Google-Smtp-Source: AGHT+IGUw1aZ9x71ac6zJGO7aTmEWDSQk81WmXJEAyxTzFCvKu5HR8+0UP39oGUMJnx4qlOTNYHCGg==
X-Received: by 2002:a17:907:3f12:b0:afe:c564:32e5 with SMTP id a640c23a62f3a-afec56519d3mr1113660366b.15.1756492329546;
        Fri, 29 Aug 2025 11:32:09 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f1174sm257964466b.9.2025.08.29.11.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:32:09 -0700 (PDT)
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
	surenb@google.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 03/12] include/mmzone.h: add `const` to lots of pointer parameters
Date: Fri, 29 Aug 2025 20:31:50 +0200
Message-ID: <20250829183159.2223948-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250829183159.2223948-1-max.kellermann@ionos.com>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mmzone.h | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fe13ad175fed..3e16578767b0 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1103,7 +1103,7 @@ static inline unsigned long promo_wmark_pages(const struct zone *z)
 	return wmark_pages(z, WMARK_PROMO);
 }
 
-static inline unsigned long zone_managed_pages(struct zone *zone)
+static inline unsigned long zone_managed_pages(const struct zone *zone)
 {
 	return (unsigned long)atomic_long_read(&zone->managed_pages);
 }
@@ -1127,12 +1127,12 @@ static inline bool zone_spans_pfn(const struct zone *zone, unsigned long pfn)
 	return zone->zone_start_pfn <= pfn && pfn < zone_end_pfn(zone);
 }
 
-static inline bool zone_is_initialized(struct zone *zone)
+static inline bool zone_is_initialized(const struct zone *zone)
 {
 	return zone->initialized;
 }
 
-static inline bool zone_is_empty(struct zone *zone)
+static inline bool zone_is_empty(const struct zone *zone)
 {
 	return zone->spanned_pages == 0;
 }
@@ -1272,7 +1272,7 @@ static inline bool folio_is_zone_movable(const struct folio *folio)
  * Return true if [start_pfn, start_pfn + nr_pages) range has a non-empty
  * intersection with the given zone
  */
-static inline bool zone_intersects(struct zone *zone,
+static inline bool zone_intersects(const struct zone *zone,
 		unsigned long start_pfn, unsigned long nr_pages)
 {
 	if (zone_is_empty(zone))
@@ -1580,12 +1580,12 @@ static inline int local_memory_node(int node_id) { return node_id; };
 #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
 
 #ifdef CONFIG_ZONE_DEVICE
-static inline bool zone_is_zone_device(struct zone *zone)
+static inline bool zone_is_zone_device(const struct zone *zone)
 {
 	return zone_idx(zone) == ZONE_DEVICE;
 }
 #else
-static inline bool zone_is_zone_device(struct zone *zone)
+static inline bool zone_is_zone_device(const struct zone *zone)
 {
 	return false;
 }
@@ -1597,19 +1597,19 @@ static inline bool zone_is_zone_device(struct zone *zone)
  * populated_zone(). If the whole zone is reserved then we can easily
  * end up with populated_zone() && !managed_zone().
  */
-static inline bool managed_zone(struct zone *zone)
+static inline bool managed_zone(const struct zone *zone)
 {
 	return zone_managed_pages(zone);
 }
 
 /* Returns true if a zone has memory */
-static inline bool populated_zone(struct zone *zone)
+static inline bool populated_zone(const struct zone *zone)
 {
 	return zone->present_pages;
 }
 
 #ifdef CONFIG_NUMA
-static inline int zone_to_nid(struct zone *zone)
+static inline int zone_to_nid(const struct zone *zone)
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
+static inline int is_highmem(const struct zone *zone)
 {
 	return is_highmem_idx(zone_idx(zone));
 }
@@ -1712,12 +1712,12 @@ static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 	return zoneref->zone;
 }
 
-static inline int zonelist_zone_idx(struct zoneref *zoneref)
+static inline int zonelist_zone_idx(const struct zoneref *zoneref)
 {
 	return zoneref->zone_idx;
 }
 
-static inline int zonelist_node_idx(struct zoneref *zoneref)
+static inline int zonelist_node_idx(const struct zoneref *zoneref)
 {
 	return zone_to_nid(zoneref->zone);
 }
@@ -2020,7 +2020,7 @@ static inline struct page *__section_mem_map_addr(struct mem_section *section)
 	return (struct page *)map;
 }
 
-static inline int present_section(struct mem_section *section)
+static inline int present_section(const struct mem_section *section)
 {
 	return (section && (section->section_mem_map & SECTION_MARKED_PRESENT));
 }
@@ -2030,12 +2030,12 @@ static inline int present_section_nr(unsigned long nr)
 	return present_section(__nr_to_section(nr));
 }
 
-static inline int valid_section(struct mem_section *section)
+static inline int valid_section(const struct mem_section *section)
 {
 	return (section && (section->section_mem_map & SECTION_HAS_MEM_MAP));
 }
 
-static inline int early_section(struct mem_section *section)
+static inline int early_section(const struct mem_section *section)
 {
 	return (section && (section->section_mem_map & SECTION_IS_EARLY));
 }
@@ -2045,27 +2045,27 @@ static inline int valid_section_nr(unsigned long nr)
 	return valid_section(__nr_to_section(nr));
 }
 
-static inline int online_section(struct mem_section *section)
+static inline int online_section(const struct mem_section *section)
 {
 	return (section && (section->section_mem_map & SECTION_IS_ONLINE));
 }
 
 #ifdef CONFIG_ZONE_DEVICE
-static inline int online_device_section(struct mem_section *section)
+static inline int online_device_section(const struct mem_section *section)
 {
 	unsigned long flags = SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE;
 
 	return section && ((section->section_mem_map & flags) == flags);
 }
 #else
-static inline int online_device_section(struct mem_section *section)
+static inline int online_device_section(const struct mem_section *section)
 {
 	return 0;
 }
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-static inline int preinited_vmemmap_section(struct mem_section *section)
+static inline int preinited_vmemmap_section(const struct mem_section *section)
 {
 	return (section &&
 		(section->section_mem_map & SECTION_IS_VMEMMAP_PREINIT));
@@ -2075,7 +2075,7 @@ void sparse_vmemmap_init_nid_early(int nid);
 void sparse_vmemmap_init_nid_late(int nid);
 
 #else
-static inline int preinited_vmemmap_section(struct mem_section *section)
+static inline int preinited_vmemmap_section(const struct mem_section *section)
 {
 	return 0;
 }
-- 
2.47.2


