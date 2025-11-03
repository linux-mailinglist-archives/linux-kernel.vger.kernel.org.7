Return-Path: <linux-kernel+bounces-883578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C58EC2DCAF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98A6A4ECAE2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7D13164AF;
	Mon,  3 Nov 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBCwQ7q1"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E17F1F4188
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196685; cv=none; b=o9mUEcZlGfcvUc3wQXWFUBVLFPoS+OXhP9Dw6OkdVexc8Yb6LzseWCdjn7WKJiIf/mGmEPBrt8OiDNBkfHj7RE7jK5QHeDYTmi4tOjL6zcg7vPKRNcifS1r9llHfGaZhShMgE8+UFOCcF0BNiqrBQoXC/OBR31mEp6TmFjL9+FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196685; c=relaxed/simple;
	bh=9H+pzZQEsGk3G/iQiRh+MqpqGOO6f5ZXiXGqZ+rJlVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TN1e325AdAfMQm1AuQbFvdJD5i1biqyWkKAjAnPHlDqI8uIUkfhcESxa1TlQ4anEaCBI8KO5iqUBC57Fea2RKJo37d2JlRexv4zwco7WBO8GxyZIUwgFUWmpoRAG6vj6hnCX+YlpcVKz+APTeyc4GfqUaQCF37PcwwTfJpZfH38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBCwQ7q1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ece1102998so3158325f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196682; x=1762801482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2JErKPUbhdtqVigURIODPe07ACqA80/yWkDmYy0qIg=;
        b=eBCwQ7q1J4qhizj7XNzCqorxdkRKjFI6tOmZQ8D44GmiEm6rJ+oiVX0IRyVLfetfN4
         NN5qvrmrP0eNPXrTa6w67FY2RWO1NsgyTTDVSfXVQN/DpFaq+NdhAEWugGrzHvPsEfK3
         W7AzyPfIRm53oTAehYnIh6L2dzxpHPvVWRcXaAkpnxTkJUNBCS32qeoCmQ0KKPTYDB8i
         IQWOxv2TKdqkZqoqLAAefa3tNtf/3NniBTm/wbl1LsfyWdL4zS0AqLrEJw4sojC7sHpy
         yuTlDKiFwEZ/+UUmqqcTxAMv/4XIzgA1seFFkaffnUXfkxVrrokBnE3LtRu3NOFsEt1s
         3bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196682; x=1762801482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2JErKPUbhdtqVigURIODPe07ACqA80/yWkDmYy0qIg=;
        b=LURqVc6ofG498gmCkZnNkYiYtbY1BsWnBOw/NuZIKn9PqzIsXRdu2UwVwgbx2w2Knr
         TSqWvySU5Dq5SDwr5aW6A8nbODarnX5shbUUK6YfLtCTbW/7409sOtK65RzjRT5b1wJ4
         mf23ikLIDB2T9zOqnaLcjoz6rpQ6Znu4WnJIo9NpyTVF/kssTznnAIwsu9GBqjBGPCZl
         YgnZCukyenlyS7KZW+byB4E4IT0xB3gI2iKkmFo7rxWQTaxd/7dcl/OlpJupRpznAx/Q
         lIKqdK7BILEHt1ReVxTrZ2ACxXZ+SyIAL1AeHyJnxdaxIykEokXi0qbrHCZlSbpdnacI
         GsrQ==
X-Gm-Message-State: AOJu0YxnAa6QFZsaNGSRZpO+pFjUu8IZLAYlTVk2ZIZ2RAsl7MpMCciq
	UweeQVebyyoHmES93odLVjESIMME5NCRNifzmF8h2jwDmGY0d8vmR77AYndBzS5C
X-Gm-Gg: ASbGnctAtv32V8ITWoavKqoa68auoELFqxorMRlrGDPEQjWadrmDkQcQDFn2Hi3uMVS
	9ch/wtegNDGc2POtR55YQkLNmDylGIvXpN/u1A9wRnXT6Z/pVG56Z3JimUeAFP1iq7dgZJD1In9
	iUcFYZT81smieikFJ1Gq2TFMY8TUxdusX3Ms2p4m0LZ227lfPk87h/OmkOlk+ABWzFYXYDTe5if
	xLPVyDLmztYhZ4SEGkJ5Ip9xmA6iVt49RX0apQIeCcGQVm93J3VfNhABfD0jJsJiP7ZPaiSG/NL
	FzdlYI2DH/wzw89lA1WNYN9WK9Zyzh1ORmUr3T8e+BFt8ikY/VCgtSk/ZDmpe5A1o0tC2QA15gm
	6NfDqOkLHbqRdpAIgWflJoKgoVDcrifViDabyJcFtdW0cfjxxJ7M2/8FAYlcPHAjh3dmuLboBe1
	k9DOD6l0CE8hnH7c7vq4jrppfUsWWnSJmMiXA38C2S/TmsWN3Fv+mmXap2tFqTMEbeLK2Ey92F
X-Google-Smtp-Source: AGHT+IGx2X1I7UandDMAz4ApQdJWh1VyEyHr6OEnpPMtBW19p5E0ww3g5wJgZQFaxc7zmXMMym582Q==
X-Received: by 2002:a05:6000:40ca:b0:427:854:770 with SMTP id ffacd0b85a97d-429bd6a5ec5mr10631734f8f.43.1762196682204;
        Mon, 03 Nov 2025 11:04:42 -0800 (PST)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429dc192ac4sm327407f8f.17.2025.11.03.11.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:04:41 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH v2 2/4] mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
Date: Mon,  3 Nov 2025 11:04:27 -0800
Message-ID: <20251103190429.104747-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103190429.104747-1-vishal.moola@gmail.com>
References: <20251103190429.104747-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vm_area_alloc_pages() attempts to use different gfp flags as a way
to optimize allocations. This has been done inline which makes things
harder to read.

Add a helper function to make the code more readable.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/vmalloc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 290016c7fb58..38d94c0c8153 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3614,6 +3614,17 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
 EXPORT_SYMBOL_GPL(vmap_pfn);
 #endif /* CONFIG_VMAP_PFN */
 
+/*
+ * Helper for vmalloc to adjust the gfp flags for certain allocations.
+ */
+static inline gfp_t vmalloc_gfp_adjust(gfp_t flags, const bool large)
+{
+	flags |= __GFP_NOWARN;
+	if (large)
+		flags &= ~__GFP_NOFAIL;
+	return flags;
+}
+
 static inline unsigned int
 vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
@@ -3852,9 +3863,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	 * Please note, the __vmalloc_node_range_noprof() falls-back
 	 * to order-0 pages if high-order attempt is unsuccessful.
 	 */
-	area->nr_pages = vm_area_alloc_pages((page_order ?
-		gfp_mask & ~__GFP_NOFAIL : gfp_mask) | __GFP_NOWARN,
-		node, page_order, nr_small_pages, area->pages);
+	area->nr_pages = vm_area_alloc_pages(
+			vmalloc_gfp_adjust(gfp_mask, page_order), node,
+			page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 	/* All pages of vm should be charged to same memcg, so use first one. */
-- 
2.51.1


