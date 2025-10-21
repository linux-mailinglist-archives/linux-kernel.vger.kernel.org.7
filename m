Return-Path: <linux-kernel+bounces-862954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51438BF6A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC513486E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C304D339714;
	Tue, 21 Oct 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXzQ5bjq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C3339B35
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051607; cv=none; b=H7KxyOpufQQTN5QnTRfpr+T6UNnuv3yBOv4SF7LOxfGaapPJYEeikXhR/uD8WOAECSuCMhLLc3eh/DJwxd1VKGeI9gF5CWx8kyXzl24Hv5GKPmBPAxOdW9uNIm4xJfxUjhu5PmUaGWuGa0GYqOntpOPRVdaFL/ZXi/n+cxjgRSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051607; c=relaxed/simple;
	bh=3cTNUMp4o+oVBONpNTtzXmzjCS7SNewteQ5np8WUWzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LY0unpR4N9RIGneVa8mwGtf5EhiXfJC1GFWWhjDv1JYAGcpky/KXjOq7c0eKNyJjo+qJq5iCsQc3GXqKLo1/RJBgIb5h6xUnCG6ddXxbn1rdqyrmDGpbNGhSsT+WimFIhhQR3DcK+ZT3QjvvSkClSeQ6L67XbYF3KP0pESf0rVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXzQ5bjq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mx8PDzlnYvvbZ0yUyMmWAvQGgV0mnv7F+nCFHBKHb98=;
	b=bXzQ5bjqRvdkMGA2TIK6E2zLWIjmMsFf9VG7TQhX8sSS2AaMrtkEECQ7u/CpW/5KR1T1Vb
	Y7saSO5DYjvpZu4rEC3ptHnoqJhZRwTtg7EU7L+8yvrijLzHdi9frthni9SFe7uHwrhxio
	iZTtxl8GSHEA/mH9PLw7cMjsWZwGZM4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-QLMC-qk1M8qQ3MTtIvFyUA-1; Tue, 21 Oct 2025 09:00:04 -0400
X-MC-Unique: QLMC-qk1M8qQ3MTtIvFyUA-1
X-Mimecast-MFC-AGG-ID: QLMC-qk1M8qQ3MTtIvFyUA_1761051603
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-427060bc12dso5744542f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051602; x=1761656402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx8PDzlnYvvbZ0yUyMmWAvQGgV0mnv7F+nCFHBKHb98=;
        b=m9fpyKYoBrE3ek6fI8jTHY8KeuofNqWV5fkKMRZ/mPqP6LNY4NSMeXvNDYqziJwQz9
         VPiOAnUFWDdC+btHwMOtGyop5+a+ed2sKluSlYJMfxHUT+xLeQ1VqNJuE8/POQB165XU
         g0KvRgaD1UqNERO3snTM9bqUz6zwr0J7tqcmaEmV+vEcOxIHrGeOdQ2M1p9xaY3PI9D5
         fuUDOsNsijKcmZfX8BDUcJEzRjVqlNuyKoXbSxZ0gzGpEH20r6dq+tH/hM7n6jqGGyMp
         pK5f6A3aygFqbd+V6WSPGL5VXA3K9DaUmkkssSOPwJkBD1LwR7fdnJZaZyGhCUhq1YBP
         IDbQ==
X-Gm-Message-State: AOJu0Ywy9fIIK4l7O/3QcbwVieMecB13Jp6i64UrIbUnq0VIf2qBrS9n
	Vd8JDAtTBfwUAIKQYMibnN7vz4SIb5mLNibgjZq3/g1xCdd0Wk93ElN7Qht/k5yyDYTISxFSXo8
	3rnbIZ8OMqbJaJDtJSLukkcnLz49HJ5uuNPeErpN2roXNuuyB+WY44eXOMuWO5XMeVXvMDE/hvp
	OB+ghTywdCEbOA1VzBJFulkg217sdylzNBHBj87g1mTUCoXQ==
X-Gm-Gg: ASbGncuEeJVNKrrZCCAv1F+4+qHGSa/wfSVu/ldaF3mT/9R9JVwkzn84sreOy9yWESo
	4jsvukQOmMAdF7IBKU4ZHOOojJy/Kk1Qw74m2cQeRbBztMtjnENla/4X+Q50yipoibIj8b2opli
	pMk9ab8lQe2SiCiSbVFjF7kcWckZ0B60XazuvOJK2K6d1GLWt08iBTyJPhHKtUJMafVFKBn6DYc
	B/wwRrwWFQa8h6FK7Nd7gHpc6scE9+B2NQtDRnZT1+ZGoztdLYLQOvxJzA2gccDLgPXl29VI9hF
	Y/b412oxGw3f0p6rAQ2qCZPn8t6I5UlwMPbfsP0a588g3gq0Crh9XEzHy3jp9XCEGJdpEcUk3Nz
	NRtPJfUtTtCv+jwFS4qlBg8phzgYSFv+llzgLyp9JglGiCMGpHZkhpB8Lxgsg
X-Received: by 2002:a05:6000:2010:b0:426:ff7c:86e4 with SMTP id ffacd0b85a97d-42704d8df97mr11013387f8f.19.1761051602079;
        Tue, 21 Oct 2025 06:00:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQe2AF3cxcaLPsgMe+jA1+DvC9OUXEqv94FS7Gua6OqWlPAIEXZjpDAmImXhD8jvhjJ6PszQ==
X-Received: by 2002:a05:6000:2010:b0:426:ff7c:86e4 with SMTP id ffacd0b85a97d-42704d8df97mr11013339f8f.19.1761051601543;
        Tue, 21 Oct 2025 06:00:01 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00b985esm20896549f8f.34.2025.10.21.06.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:00:01 -0700 (PDT)
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
Subject: [PATCH v1 13/23] mm/balloon_compaction: fold balloon_mapping_gfp_mask() into balloon_page_alloc()
Date: Tue, 21 Oct 2025 14:59:18 +0200
Message-ID: <20251021125929.377194-14-david@redhat.com>
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

Let's just remove balloon_mapping_gfp_mask().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h |  7 -------
 mm/balloon_compaction.c            | 12 ++++++++----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index e5451cf1f6589..d1d4739398978 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -106,13 +106,6 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 	list_add(&page->lru, &balloon->pages);
 }
 
-static inline gfp_t balloon_mapping_gfp_mask(void)
-{
-	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
-		return GFP_HIGHUSER_MOVABLE;
-	return GFP_HIGHUSER;
-}
-
 /*
  * balloon_page_finalize - prepare a balloon page that was removed from the
  *			   balloon list for release to the page allocator
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 90b2d61a593b7..709c57c00b481 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -112,10 +112,14 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
  */
 struct page *balloon_page_alloc(void)
 {
-	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY |
-				       __GFP_NOWARN);
-	return page;
+	gfp_t gfp_flags = __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
+
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+		gfp_flags |= GFP_HIGHUSER_MOVABLE;
+	else
+		gfp_flags |= GFP_HIGHUSER;
+
+	return alloc_page(gfp_flags);
 }
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
 
-- 
2.51.0


