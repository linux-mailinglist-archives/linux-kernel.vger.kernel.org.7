Return-Path: <linux-kernel+bounces-862956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500DBBF6A54
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D47540E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6433A013;
	Tue, 21 Oct 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZTD+nac"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DA2339B35
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051614; cv=none; b=IPQWZtrpsZ1nS+pPljgF+4EVfHGFi/NSHwUYiBjdYtQ0H43rP2T3u2LB/OffO1JWPqWAB+lfVnOwam3K8y3dh3ZF33kmVVl8+QEwLXfKSDm9tw0qphYZDmQ6gO+JaBgNMvawhozOofXzyjORhOHYpjMZW2NEpyPl6wd53w4tlZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051614; c=relaxed/simple;
	bh=3g40vwKIgUFnbs436ZCx9Q+N4KveSscj8YcW5wyilic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfD3OccJiwx3xuI+ResYUpP2DoZI/TTH/3L/t/QFX1lbeGb/OWdWQXyik4aheoNVH7Y4a039cqCXRD3rb+DRXbBH1WWHZHSxjis8W6pxVlwRWG/JuZEsRKwF+Dds+FGN4mEwJwAtSd1Dt7LaWJDaV8F0OCY0Bxj32/Jwi1tU2JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZTD+nac; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Pfle03AoZbMZzwKNT9cqn8RCz4Fl59OlkWq00/g7dM=;
	b=bZTD+nacieGTYh+n8mFqcxUexbB6zyEC61Nh2OY3cPK4OLC2L2BcKRDSBEC/Dj3lKa7MAX
	Z6mrPsTj5y6ujwu/1Uv3F3KZrY5H7GoHgfbMXBKTHrfw9V0xHOrN19H7Ir155DjmuSKerU
	lfCk7Il36SYx70BDoOkj9z9GAr6omKw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-mXjGFT6SPyuP89PPrzYbWg-1; Tue, 21 Oct 2025 09:00:10 -0400
X-MC-Unique: mXjGFT6SPyuP89PPrzYbWg-1
X-Mimecast-MFC-AGG-ID: mXjGFT6SPyuP89PPrzYbWg_1761051609
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47113dcc1e0so46435735e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051609; x=1761656409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Pfle03AoZbMZzwKNT9cqn8RCz4Fl59OlkWq00/g7dM=;
        b=SuGr9aOr8Lrd6A69FS1+i29V/iRxgfm21YR/2MCEGThjPEC/oSvz5hwEjZvMEkn2G0
         s6/w71vNKuYUzoVQA6wbb+Ahbd+q/kl+cpTuPUIsT0/sAIcc+Chezy3/xXDkNii++ckk
         Yf9X7tcVDfZlzrsWwACIyY/QNHHqc82af5/AGAf1iRvS3FvQijayfITwwanboBoCKLQB
         gYn6CbcyjSPUAQsA8Z6LOsRbsrA8ibxOKGZxWtCOFTT6RD7jT6ta6PSb9I4rMfLnrSn/
         19aExUn9FlfUR1LtKE7W9urVRd6otv2lbIzMwQR28X51/vKylEUYxcuEWh5KxvEOSSMd
         LOow==
X-Gm-Message-State: AOJu0YzDOvxKSwM3YD38WmRM4XFNy9S43vFK+DHOlm/tCyZo5nat5/CT
	Gcu++SbDu1Z9mb55QP+ME6lvRlQ++oiHr+MjyZRYZBAG29d99gbalp+ip7YrVoL7D8wdK612kSu
	na6IV6elZEqfA/1FNvBTzhVvWS5lM61JJreLaE7af42ERF5bPrFI63YLuMgE9cliML4u7gT0p3w
	MBYxdm196zbcm3F69CfpZTkbznNA+mE3Fj4aXIxZop889cUA==
X-Gm-Gg: ASbGnctIZmoeaXjVGZJqDyzOiVcdwqPhlmYx63BmZG1lVe2ZcFHLCR4lyL+6r+++17y
	PXDZi8qnSXCTi5veknMjaq4S/QwwZcogd29G+6MhsD+xA6Dn+OhidY0jj+FPoLGbjkjUSU98Pu4
	k3oEe81nUla49Vo7/NMYOnaQ+6FdwKT2xgAqYok1Rzv5ehhd8x/H5872PFKh9p8Ie9TAR5q3GTz
	I6MxeSegIQKxrVTeI/7U4vteL5wcaVy0eNPeIqEeI5ov9uLeC7r8q/z/zDoH2Ak0p6IxLvvA6SN
	7WzlflQnX+fHVDzZSqdCZAyQWbaAiWJi5ukA1yFxK9YB6V4MWpI7MBazGPLKJbGvFHkrsRPPTer
	PqO2UV4gRIJSnomGFEtygRKxD0fuxErWa/uYBEWJErU9+lV0mTrr+9dJyfh/m
X-Received: by 2002:a05:600c:3544:b0:471:c72:c80b with SMTP id 5b1f17b1804b1-471178ad7b3mr117596225e9.18.1761051608692;
        Tue, 21 Oct 2025 06:00:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYkNMmF6KwTjIi+haTZNa/bZuoGNP9fBOncPRUCNa1fBr3A4oaQbG8grM5Ui4vLJ4xvDadAQ==
X-Received: by 2002:a05:600c:3544:b0:471:c72:c80b with SMTP id 5b1f17b1804b1-471178ad7b3mr117595585e9.18.1761051608200;
        Tue, 21 Oct 2025 06:00:08 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471143663afsm278506055e9.0.2025.10.21.06.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:00:07 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 16/23] mm/balloon_compaction: mark remaining functions for having proper kerneldoc
Date: Tue, 21 Oct 2025 14:59:21 +0200
Message-ID: <20251021125929.377194-17-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021125929.377194-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks like all we are missing for proper kerneldoc is another "*".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/balloon_compaction.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index f6e0582bd7ffe..f41e4a179a431 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -22,7 +22,7 @@ static inline struct balloon_dev_info *balloon_page_device(struct page *page)
 	return (struct balloon_dev_info *)page_private(page);
 }
 
-/*
+/**
  * balloon_page_insert - insert a page into the balloon's page list and make
  *			 the page->private assignment accordingly.
  * @balloon : pointer to balloon device
@@ -42,7 +42,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 	list_add(&page->lru, &balloon->pages);
 }
 
-/*
+/**
  * balloon_page_finalize - prepare a balloon page that was removed from the
  *			   balloon list for release to the page allocator
  * @page: page to be released to the page allocator
@@ -140,7 +140,7 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 }
 EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
 
-/*
+/**
  * balloon_page_alloc - allocates a new page for insertion into the balloon
  *			page list.
  *
@@ -163,7 +163,7 @@ struct page *balloon_page_alloc(void)
 }
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
 
-/*
+/**
  * balloon_page_enqueue - inserts a new page into the balloon page list.
  *
  * @b_dev_info: balloon device descriptor where we will insert a new page
@@ -186,7 +186,7 @@ void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 }
 EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 
-/*
+/**
  * balloon_page_dequeue - removes a page from balloon's page list and returns
  *			  its address to allow the driver to release the page.
  * @b_dev_info: balloon device descriptor where we will grab a page from.
-- 
2.51.0


