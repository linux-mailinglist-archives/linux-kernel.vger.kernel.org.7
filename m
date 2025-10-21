Return-Path: <linux-kernel+bounces-862944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E41C9BF6976
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0C8B4F7DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3134334C3B;
	Tue, 21 Oct 2025 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qet9rZsH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83892334370
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051582; cv=none; b=XN2af1oXD08vQ1MPVwUaGaxjFiY5QE/4lyiXKDGJTfOIJzDN94BrPFc/0oPYrbA2K4lZ40IE/Nkfo6PpGx2r8qslpoiWsGAhVoQlweV4kSLBNJCxZ4hvzb2f23AOutI+zxexAVmD1W6qASSahoF1yQxE8Hkj/Qmn14iMfun5J4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051582; c=relaxed/simple;
	bh=L+63bx9D11EYkqLrccK+lnT9JaJRwWO+dQ0bdJZ2z3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZm5lNUo/qQHeeOgjZfV76nD/ypE0OkDjXI3024xfTcys1hGNf9djOrD8HxEaMcOlxGVTsc+4fA3oxV3nQjiiJSzXS4JehabosFt39XUL0qJijwLipdjaRRJAIuMsMciO5ADAzOS508AUSC6pawFlxMq4rcDgVGNh886pZA43dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qet9rZsH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8R/9+ffq24GRtsamw+sO0Dq3xyN1P0TNXMmPfo3y584=;
	b=Qet9rZsHaGY2/tFTW0KcZRfOtnUpt4m7baMThLJYyaR+fpkOXPKO61UGlEZtF7XsQsEhrA
	7090Koe+ZiSwEyAW/J3Yi2zr8j97jo+Q4mhXxYm50JblBVzdoLkV7BYwXLqtJJdn/GLRHd
	ilibnQgDUt8Eg+neooU/46kQATWGEmM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-KrIkFGwGP-Gly2Pyj8Dodw-1; Tue, 21 Oct 2025 08:59:38 -0400
X-MC-Unique: KrIkFGwGP-Gly2Pyj8Dodw-1
X-Mimecast-MFC-AGG-ID: KrIkFGwGP-Gly2Pyj8Dodw_1761051577
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471193dacffso37638675e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051577; x=1761656377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8R/9+ffq24GRtsamw+sO0Dq3xyN1P0TNXMmPfo3y584=;
        b=m2MFcN7ZfbWPTuM4xXN8gFZOX9kt1w++9jJBZrW/uvQKLCs7av9xNgZcijsBgc35/U
         sKrJdn/fddTKIw63I2DJEfa8ueNjou0TPz824jDz3+3KGx8KMwKjsYyyG/a80bcMKRAd
         iftNkqSbxinhMjhKuVJzgyFtKJm788dTg7P4wJMXBKR9u6oxRgSW1k54tkzLr/XLaDTu
         +z8pwJD73eElh+vj0FExv2AIonHE8UL/Iy1VhrI/WzTM9bDqDtyNo9TjvhrkO3uAiznu
         LAvEx4t/uDVA/d2wEK2LeTDugE3VqIBylo9mo4oatyyjLGGzCEpUtl6s3ixZq1+9/Jhe
         4XYA==
X-Gm-Message-State: AOJu0YzNUlPYgpVNV8seP1ajiXlT3mrods2cvsW6dUbP4E4VAVqXvc7f
	xNBilvXlbvkZJQPGIFCixRextXvhWnPx6Gzge2GOCA0f2VxtRHNMpWR9/8AtZHztQwDQuZc0pDB
	fHlR2VNSwSDvRJwJrwR1dQWbYQ1Rx9oqk+oMs61Nj5GNWRMBkOOyh8i247V5w3U8C8eAfnrZNj1
	xfVCbFeHHpihW8sati4HG1SROk1Ep/5FQctTXSDr0CzBiJVg==
X-Gm-Gg: ASbGncvkkjBfAQGq0UEsAsdpry7qQvgBNiGRzm594byAbbr/23mqINJDaZMCaOW+qvq
	wJJd9DamXiaq2sbQCRgwg2epSU+5WBM6xB86CTXqOsQurIx45ezhRW0JJEjHh6m8ntOu8d53kmV
	tHGXaLgxFqBnnVN//PC+C2bX7HEV9G4WqXUlVjB1cB18/f8QWP/AcJiBe+qr8NJvJAcEPG5Q8VX
	B6VOEXfe4yeC/im5g5A2C2m0HN2o3A68ZHQsTPL3xwYFiWh+wg+ydpiEdlJ7qrnzdOIdGMkbiLO
	rtJJLB4bCSMB15s1OTeaH2EvBUBV71fmgqpbZHzQrz3WlzyDdeEtyIRM3iy8JckBs0d57xVvkph
	0Za6T9HfW+aJxMECi8UYY5OwIlsy4QTe/4H1sSNwdDwzCABfrmNbCCCYXRSbD
X-Received: by 2002:a05:600c:444d:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-471179202famr118678485e9.36.1761051577022;
        Tue, 21 Oct 2025 05:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEokGBhUzCRsmptihAjBHDZlL2+6LwM1McdhB6sS9tCAS0C96fTIUzPBBNJE//85lgKmaBsaA==
X-Received: by 2002:a05:600c:444d:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-471179202famr118678045e9.36.1761051576500;
        Tue, 21 Oct 2025 05:59:36 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47496be2eb6sm16562465e9.2.2025.10.21.05.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:36 -0700 (PDT)
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
Subject: [PATCH v1 02/23] vmw_balloon: remove vmballoon_compaction_init()
Date: Tue, 21 Oct 2025 14:59:07 +0200
Message-ID: <20251021125929.377194-3-david@redhat.com>
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

Now that there is not a lot of logic left, let's just inline setting up
the migration function and drop all these excessive comments that are
not really required (or true) anymore.

To avoid #ifdef in the caller we can instead use IS_ENABLED() and make
the compiler happy by only providing the function declaration.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/misc/vmw_balloon.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 2cc34c4968fac..07e60a4b846aa 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1833,27 +1833,10 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 	up_read(&b->conf_sem);
 	return ret;
 }
-
-/**
- * vmballoon_compaction_init() - initialized compaction for the balloon.
- *
- * @b: pointer to the balloon.
- *
- * If during the initialization a failure occurred, this function does not
- * perform cleanup. The caller must call vmballoon_compaction_deinit() in this
- * case.
- *
- * Return: zero on success or error code on failure.
- */
-static __init void vmballoon_compaction_init(struct vmballoon *b)
-{
-	b->b_dev_info.migratepage = vmballoon_migratepage;
-}
-
 #else /* CONFIG_BALLOON_COMPACTION */
-static inline void vmballoon_compaction_init(struct vmballoon *b)
-{
-}
+int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
+			  struct page *newpage, struct page *page,
+			  enum migrate_mode mode);
 #endif /* CONFIG_BALLOON_COMPACTION */
 
 static int __init vmballoon_init(void)
@@ -1873,12 +1856,9 @@ static int __init vmballoon_init(void)
 	if (error)
 		return error;
 
-	/*
-	 * Initialization of compaction must be done after the call to
-	 * balloon_devinfo_init() .
-	 */
 	balloon_devinfo_init(&balloon.b_dev_info);
-	vmballoon_compaction_init(&balloon);
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+		balloon.b_dev_info.migratepage = vmballoon_migratepage;
 
 	INIT_LIST_HEAD(&balloon.huge_pages);
 	spin_lock_init(&balloon.comm_lock);
-- 
2.51.0


