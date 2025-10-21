Return-Path: <linux-kernel+bounces-862955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B988FBF6A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C1540195
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AB1339B5A;
	Tue, 21 Oct 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5y2/LFo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A1633B94D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051612; cv=none; b=WIKTf8AXGJbjHTlpaBHSGD52cneP3icVcMlMF+31E3xUmi/mCfjjcEpGkW3Fhn1iZue4ubecMc9ioZ4OOKWpoPXcz8QDH0ODNtrL5eXnBcQAjh/XFKOk03RKFfAxjw+GOwPpGMQ/FIBhUmaam9IKgk+Q45WobKDOGGZP9znjA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051612; c=relaxed/simple;
	bh=I1RjduQwNLAJmKC+Ha7d0wSfsDgz8ai3C7Mi619iPgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M38QbA1zN1+LTkChroi5sAANgaDrf5IO64pNRPc1lxPD0aoj23CvBoULWHwwnrRPp8qw+Lq5e7t/q4Lvu1ViWJzTtASoj+svT80q/99YCQpB5a3EYcplDoPnBBhVoUr1D9BfibgeYmeP8CueEQ9hBSPACLzA9socd4++D5Y2rLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5y2/LFo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyA8pCV8ZcD9NKgO0LjiJR2j4wGQSpAi/OG88VVUt3A=;
	b=f5y2/LFoAutkVN1fS1/H+svGAtdtMc6p/f9saUjYzv0eGZXu/zS7xNtMjyEBsXtkEU6ag2
	fe3DwpHwESJHySAeW3jfzOmICs5dWowMVLXeuFch9xWzXRCn5N13ji0iRWiQrMkY1YuksZ
	rdK5ee5M5JVz9M0A6zw9S2jP8/u2ils=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-2Xc0ZH-4OPqyiddzQ62__g-1; Tue, 21 Oct 2025 09:00:07 -0400
X-MC-Unique: 2Xc0ZH-4OPqyiddzQ62__g-1
X-Mimecast-MFC-AGG-ID: 2Xc0ZH-4OPqyiddzQ62__g_1761051607
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471125c8bc1so61196185e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051606; x=1761656406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyA8pCV8ZcD9NKgO0LjiJR2j4wGQSpAi/OG88VVUt3A=;
        b=UNYXCo36aT4KqJo8KyMwScS2LjpDJWHU4ztkhBHB4297WEPtXpfY+ajvG13cN3m1NS
         QCxYq7U4LD3+R7wg0VCSdnHMBQaB4cqci3u5I4I2Q0BSZUtFP8UjCisgs4PWF4T/1Wex
         62R5eONYgb0uE8+deaJ0I0NX4frWIMmCA0ez63qNJDAS9P5OXnWvzPPfcBvzavKtt7y8
         Rws2BgIw+/5PtQb4yez2eeTbcPLBd2hDtncbZOz1Vh9oaLb1DQlE4VpiqBHlmszqPKRc
         fgygRA3Ma/y8v/3mAoOecUAcd8KPI2vs4/3CdisutqpgMqYXqlDwNNgDlw9+7dNemdpr
         8zoA==
X-Gm-Message-State: AOJu0YxWPSvKsn+d3HWBgGDFpQuaMt7rDkXZO2+xQIvl/gZJwGh0IDOL
	PUcMU68Zj69/bX+fKCQEojzWRLcAeRx4g4iS87dJHZnRfujnOGwbYZqvo0NFsXpyet78srCCP1V
	8AO9RfZ7gMPZDesZlY9KEE/JUdR/5rNBO6ELKewnO7xNFMLNWzpL39lIA4IB56i45UGAsOuTIor
	mOPqfBe2poHn4cVNDAgGImdNFojrEC47OS8Cu1QtSVFi4Y4A==
X-Gm-Gg: ASbGnctqOelJwjbSU3Vxh2OHe6PLJazL7G6zq2IdT4FUOfuwBLsOzdYzoJNyvjdKKnI
	KYYyo7BApVVptgps5CCFaHfxTklsQmk1LHKg8wrklCYtYN9R1wNr9Y5GXIB8T/A5O+ix5EyotB7
	AdT2/23h3nKoOIFeHlHcNQ5CauXD9K30c6OrfnUSItVoGjwDYVA7V9fhd2+PciSjUgomWYTDm/G
	6X90Ge73640vWjvvDmHeVyyxg5m2RIapf9EwzLRuCPCy+7iI7pDfhL7UbT5uybemZLeVo+FVhbs
	niuKfVhl98i4bDZdx12Xt8Aq/mjKxYcJOf0zojU1ZCKT/xH831/teVS2pLjoZAUHvk0nhaBdmzV
	OPnX2W2B1wZ1kBoNrBRWs8tsmGXY5wFT9ht+FN4NI7yBjBAdZNAKStcm6fwyQ
X-Received: by 2002:a05:600c:64cf:b0:46e:3b81:c3f9 with SMTP id 5b1f17b1804b1-471178a80f7mr116647665e9.17.1761051606630;
        Tue, 21 Oct 2025 06:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbkCxQxFQj6JOplMg8GsGSdkTVrb2edAU/Gb4AKN0gQYX2xa+Zptcgj0djfMLZWDQvHioQbg==
X-Received: by 2002:a05:600c:64cf:b0:46e:3b81:c3f9 with SMTP id 5b1f17b1804b1-471178a80f7mr116647115e9.17.1761051606167;
        Tue, 21 Oct 2025 06:00:06 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471144d17cdsm278222645e9.18.2025.10.21.06.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:00:05 -0700 (PDT)
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
Subject: [PATCH v1 15/23] mm/balloon_compaction: assert that the balloon_pages_lock is held
Date: Tue, 21 Oct 2025 14:59:20 +0200
Message-ID: <20251021125929.377194-16-david@redhat.com>
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

Let's add some sanity checks for holding the balloon_pages_lock when
we're effectively inflating/deflating a page.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/balloon_compaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 717bc43732d09..f6e0582bd7ffe 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -33,6 +33,7 @@ static inline struct balloon_dev_info *balloon_page_device(struct page *page)
 static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
+	lockdep_assert_held(&balloon_pages_lock);
 	__SetPageOffline(page);
 	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
 		SetPageMovableOps(page);
@@ -50,6 +51,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
  */
 static inline void balloon_page_finalize(struct page *page)
 {
+	lockdep_assert_held(&balloon_pages_lock);
 	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
 		set_page_private(page, 0);
 	/* PageOffline is sticky until the page is freed to the buddy. */
-- 
2.51.0


