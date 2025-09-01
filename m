Return-Path: <linux-kernel+bounces-793877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B025B3D994
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6E5178F76
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAFE2550CC;
	Mon,  1 Sep 2025 06:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="V8uPAiF/"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580524418E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707158; cv=none; b=KfA2r+QH6eYfoLh32qq2+cJ5o4lYIcpO8Z2//s1BEoRLdoqG/ltMS94rHifkRZ5S6p2GWspnxemNFe1Q/6wro43EBUbWfTnnD8GGws4oe/tEKs5Jnelk341un1wA2TS5qSkDzdDJxsQtwfq4MR6h508LO+E+T1NmP9rsxkIf76Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707158; c=relaxed/simple;
	bh=Kfoj9/UJ7RA/TyQsl5xCzxk5d79w+3LX6i4bau2kbag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrJu3WHBDoe8R1T57z/IPJZTK12VAmeZKgfolFk3BOmGlsILe/+8EtkHYTsO/yB4tDbCeKOgjVQo+cEPTBNu+hPKozHyJBMF4rQTd7gU52GuguDOGDT5bcVsSASYacMldiRyBbjB7QOSd8uqRVOVcPi0FS/w/i0dJVsi/AJYe8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=V8uPAiF/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61cb9e039d9so7775609a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756707155; x=1757311955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfDRUXm7GSZttX/qoKcpbZzZfAWEleydE7MZKpAlbdg=;
        b=V8uPAiF/068hcSXgP0QzKp3fTC7bF+Q1Zawxe1fnGVXB1Poq5DyAh3IUWt8RcQ/4QD
         n7iSrtSvawjCmSmQNIP3DouYIoWKtB9HAkMSPBLRzUujj1yfia46CvnV285zAGmfxBNv
         yhepNLbhpIgVsKK68F/3B/4YhvnxS82lkWFKa734QsHrnvVXY3y3XYBJ7KXrJoM5gQZR
         LzRINIkWeQB0w/P7CSn2fNpP/2mNPKdJnDxCZmwqMVKDIJH+kpgicg8q96LjrfNvocIm
         MF/mMGIKbEDSDAYZmWKL7HAarT0kWBcNany/t2H39iMKCsXH5owlJHAueZRcNPoTuzID
         si3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707155; x=1757311955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfDRUXm7GSZttX/qoKcpbZzZfAWEleydE7MZKpAlbdg=;
        b=goLmlgJQzgOM/99WhB0CuK9z1Hy4aCQsjLBoGEakEbwS50BYx4coqwrYehSKlv6I47
         k3qGrkqSnnBuFc2PksxcUbmqmHUvOJ7Zb/ZSifAOCl7B2aKGPYPHGWkgQ/DBsjTBMtl/
         eOeVy39tPo720k/cod2QX8pHurkncCG6QJ+/PB3xBufQI7gw65PeZQoyPlAgViLdJVdh
         mqJfPMfGcKAfMHHjVITEc6l+e3NuSzqqA1OYUtD1CqMDpH6mpTg5azCl4tJBX1y69K4Y
         EFi/x4/nOD4opNDD0KmbJUmvPbGoNMg+mghAtb47KpFds1kR8qxn7AqzgFZjTs1fazrW
         Nz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/aobV2MrbFsgjIEUcjJ3K8uIGbl0Y4bf8sryZl5UaAl/w2KhHzet0u6NGcWnZsKBMFIxzc9L0wrp6s3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXcjLOzGTolzd0gfpBpJmIUiPk8hEZCO+2c+echLqO2WQnICGR
	6dlA/Q+4EjcQENXGQJTBD/eJXEGQzDp4NBZKhFn3ZKlh91JmIoE/+N0O8Mbz88QXEBw=
X-Gm-Gg: ASbGncv7rrUO25j9jcWnYTBgEGoqi8MHv7olnfYG/wTWZM2W8YPopBPTEOiEKrBP0GH
	RZ9U5xxpohM1j+dfb94pxQh6E2f86K5NOxebf5fE2FX3BxJZfM6HWTwYowK5bg3ZqZ8V3YL9vCg
	sSLUWJ0Env+vrnQIpA/5XdL63/6q3hTbIoYoXQCmDhfCGBhLflBaTzeEgTOfUyi1xc2qH29Zpee
	5I9LDN3aiQNFUOvdQWPF3sBBZnqORhpjuT7ooZA9l5j3EPFtmeBDcJy7eWsbj0rJmot5oED9M6B
	+AH2DY1lv7Dkp8zzknfidBp337tme28d9IsOsZAcITwXaE5n6HN3nyPrKUhmgcpuVn6EZgT9oAH
	FDXR0AqMLza5w10TWM5nvxnFOV+5eDYwu01VOZCyjmK+RQr6b/hQ7b1mHx2cpqgSMTZv6xAOo62
	OwMZ30LTgRZ+Z3osjmdXzw5A==
X-Google-Smtp-Source: AGHT+IEI+/052EQvn2HkQ3uPQ4HOT/tEpF37FK5n5389qJs3n9FMvOvIqD4njM7OvECWY8CWysAFtA==
X-Received: by 2002:a05:6402:51cb:b0:618:2733:1a52 with SMTP id 4fb4d7f45d1cf-61d26997500mr5190269a12.8.1756707155269;
        Sun, 31 Aug 2025 23:12:35 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm6374533a12.23.2025.08.31.23.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:12:35 -0700 (PDT)
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
Subject: [PATCH v3 03/12] mm/mmzone: add `const` to lots of pointer parameters
Date: Mon,  1 Sep 2025 08:12:14 +0200
Message-ID: <20250901061223.2939097-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901061223.2939097-1-max.kellermann@ionos.com>
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
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
index f3272ef5131b..9a25fb1ade82 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1104,7 +1104,7 @@ static inline unsigned long promo_wmark_pages(const struct zone *z)
 	return wmark_pages(z, WMARK_PROMO);
 }
 
-static inline unsigned long zone_managed_pages(struct zone *zone)
+static inline unsigned long zone_managed_pages(const struct zone *const zone)
 {
 	return (unsigned long)atomic_long_read(&zone->managed_pages);
 }
@@ -1128,12 +1128,12 @@ static inline bool zone_spans_pfn(const struct zone *zone, unsigned long pfn)
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
@@ -1273,7 +1273,7 @@ static inline bool folio_is_zone_movable(const struct folio *folio)
  * Return true if [start_pfn, start_pfn + nr_pages) range has a non-empty
  * intersection with the given zone
  */
-static inline bool zone_intersects(struct zone *zone,
+static inline bool zone_intersects(const struct zone *const zone,
 		unsigned long start_pfn, unsigned long nr_pages)
 {
 	if (zone_is_empty(zone))
@@ -1581,12 +1581,12 @@ static inline int local_memory_node(int node_id) { return node_id; };
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
@@ -1598,19 +1598,19 @@ static inline bool zone_is_zone_device(struct zone *zone)
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
@@ -1620,7 +1620,7 @@ static inline void zone_set_nid(struct zone *zone, int nid)
 	zone->node = nid;
 }
 #else
-static inline int zone_to_nid(struct zone *zone)
+static inline int zone_to_nid(const struct zone *zone)
 {
 	return 0;
 }
@@ -1647,7 +1647,7 @@ static inline int is_highmem_idx(enum zone_type idx)
  * @zone: pointer to struct zone variable
  * Return: 1 for a highmem zone, 0 otherwise
  */
-static inline int is_highmem(struct zone *zone)
+static inline int is_highmem(const struct zone *const zone)
 {
 	return is_highmem_idx(zone_idx(zone));
 }
@@ -1713,12 +1713,12 @@ static inline struct zone *zonelist_zone(struct zoneref *zoneref)
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
@@ -2021,7 +2021,7 @@ static inline struct page *__section_mem_map_addr(struct mem_section *section)
 	return (struct page *)map;
 }
 
-static inline int present_section(struct mem_section *section)
+static inline int present_section(const struct mem_section *const section)
 {
 	return (section && (section->section_mem_map & SECTION_MARKED_PRESENT));
 }
@@ -2031,12 +2031,12 @@ static inline int present_section_nr(unsigned long nr)
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
@@ -2046,27 +2046,27 @@ static inline int valid_section_nr(unsigned long nr)
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
@@ -2076,7 +2076,7 @@ void sparse_vmemmap_init_nid_early(int nid);
 void sparse_vmemmap_init_nid_late(int nid);
 
 #else
-static inline int preinited_vmemmap_section(struct mem_section *section)
+static inline int preinited_vmemmap_section(const struct mem_section *const section)
 {
 	return 0;
 }
-- 
2.47.2


