Return-Path: <linux-kernel+bounces-724386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD950AFF1F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC791BC777A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819BB24336B;
	Wed,  9 Jul 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmPSwzDZ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984CD242907
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752090122; cv=none; b=ihEECZo5qoEyqOtbr5ro2CoNPHIAqZ2evjxZLOkNyQO9rq1Cnhy4G4TNUyNRT4axy/wYPDM0AfKVJFoldv/R/5HyepFpIbxsrXOwCUyligMWj0LXgipFDIFSFwJJqid+FwYDhgJWHjQfdCKL/HnNmL00s1wq1r3D8yXNs2qjkLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752090122; c=relaxed/simple;
	bh=1oMOCOSsJyTAXSjzznh9jX18iO7kxSYKqDC/vX7sBZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCgIdKofNz4EPwiP9cU3YZQ1OJIjSdRyHjaIRwT1l2TqxExOUdiJh9y0eLSEJdFfW/PL6Qe9KSlgvpUCIGQ+1rY6HK6eeIXQDNHwwuLHeO7jcXgcXABaekdcv09QvfqLPaX/zixkVyVizXKWTLoDHsZj5Y4I7rIs7PJ5fCTpXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmPSwzDZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748d982e92cso186641b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752090121; x=1752694921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKvpWjKgmDJLBGUkp9Wbs95QT2/tWm3HhCqZBNEMNsg=;
        b=lmPSwzDZQlgwh++AHOUrZb3yUM8hxE9qOmFv5IKzNPMM1bJGrJfL5JMqBE0svcPuvp
         00sv9c7Jok4K/hVbFJ1ijAyZekvnoHBs885zzbFY1+nDyHEcb0qCgquJufxLtWGT00yt
         IO6cltrdGFIOgBxGBdvVmNqrXKPCDrV5Pb3FwP6BCliplgmNOoUIrcb1yS6Dtnr9oREq
         S0iQX6cnPdzFG12sUL9/3B2hv+3s23BP3eGsyw/eTkeANsmoss/noC6WNGez4NAJqXsT
         OrQtfIG24jXSGt4WR9ANDTm/aYOM3HnOy5KB6vtrArfNj3NOi28RDCE3lt9bc57A5Lt+
         6rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752090121; x=1752694921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKvpWjKgmDJLBGUkp9Wbs95QT2/tWm3HhCqZBNEMNsg=;
        b=By31Zx/SvjOmniX5WS9BL5guclfSrs53YrzCx+Nin6horerz8/CNkuGOaQ5824orvH
         10NXVqnUdeOc+ftoIcItvCpOdxgJcLLb5sch8zGYV1nAUcLhbIeOipzsSClQas+vKvt+
         fnZL0m+kskUDliBrOowpiFcn2mSuGC3Vt3zgmPxTGrYxP4/UPEcHbNbpSlK+qunJaGYR
         t8ijMD+BlNShHZn93nJsuB8niAVWcRnIDJh6frcOQbGinEPj2mNRbBtpcgQM9W+Ca9CU
         A1mxgWoa0i0x+brxZa4VwlrO9U3gdJANyqxFds+OtRlUnsZd9mzj8P+XTNhQfI6nTyl8
         n4Jw==
X-Gm-Message-State: AOJu0YxCZnKdtDeF73SpOqQRw+pApSTFNElN5WVOG9jXm1W6ua2Mr6np
	9Hv1AjI29iwS03/8EpOKo2N1+lmjuvDdqvXLumaq6zqzgghdBjs/RmDF
X-Gm-Gg: ASbGnct+8KzZHKpwTAB7FihOA62ehDNW2DnMXUTPpMpdsxU68t+/A3XAdoVE8s9CN1u
	4wDco23nHrgKKFhp4C6tMxgn5dw/nKgZ1fMwaF3MaPmw4UFb+w2c8np/zM6d7lCO5HpFVk9zSfB
	93FQx+/3LckkrcjGSSf+rZm5zkQdzscEazrQ5sa7MQ62mUGyjGiL/emtEF7CO+fBRvtB85k6UNV
	i6xDwea7P+D3VVg0i6hcxeS+n67TNNf/XfDoqw1ygRZMZtnO+c7vL794VO1uXsEitcHQWDtGDsc
	oHrU29dtoNfJ7ckuIhVatV01GNJxZfHH0ChUOQ30V5jxb5uGQlWygboSoRkz1B8i/WmH5jv6hiB
	PB/4LPLAj5IvRZzEfGQ==
X-Google-Smtp-Source: AGHT+IGZVxyQx4fXlif2fiJObqAzi1x6ui3X+Z45EQzna/PQfppivzMYYUiBInRoJAqy74N5Yzfnow==
X-Received: by 2002:a05:6a00:ad3:b0:742:a77b:8c3 with SMTP id d2e1a72fcca58-74ea6411205mr5337243b3a.4.1752090120790;
        Wed, 09 Jul 2025 12:42:00 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b38ee4794f4sm15169458a12.25.2025.07.09.12.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:42:00 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Jordan Rome <linux@jordanrome.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/3] mm/memory.c: Use folios in __access_remote_vm()
Date: Wed,  9 Jul 2025 12:40:17 -0700
Message-ID: <20250709194017.927978-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250709194017.927978-3-vishal.moola@gmail.com>
References: <20250709194017.927978-3-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kmap_local_folio() instead of kmap_local_page().
Replaces 2 calls to compound_head() with one.

This prepares us for the removal of unmap_and_put_page().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/memory.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d63f0d5abcc9..3dd6c57e6511 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6691,6 +6691,7 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 	while (len) {
 		int bytes, offset;
 		void *maddr;
+		struct folio *folio;
 		struct vm_area_struct *vma = NULL;
 		struct page *page = get_user_page_vma_remote(mm, addr,
 							     gup_flags, &vma);
@@ -6722,21 +6723,22 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 			if (bytes <= 0)
 				break;
 		} else {
+			folio = page_folio(page);
 			bytes = len;
 			offset = addr & (PAGE_SIZE-1);
 			if (bytes > PAGE_SIZE-offset)
 				bytes = PAGE_SIZE-offset;
 
-			maddr = kmap_local_page(page);
+			maddr = kmap_local_folio(folio, folio_page_idx(folio, page) * PAGE_SIZE);
 			if (write) {
 				copy_to_user_page(vma, page, addr,
 						  maddr + offset, buf, bytes);
-				set_page_dirty_lock(page);
+				folio_mark_dirty_lock(folio);
 			} else {
 				copy_from_user_page(vma, page, addr,
 						    buf, maddr + offset, bytes);
 			}
-			unmap_and_put_page(page, maddr);
+			folio_release_kmap(folio, maddr);
 		}
 		len -= bytes;
 		buf += bytes;
-- 
2.50.0


