Return-Path: <linux-kernel+bounces-862952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FCEBF69F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05D019A3F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFE633893C;
	Tue, 21 Oct 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJtYsFrz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7B33892C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051602; cv=none; b=l4Tp3spVm04/hpYjXwKBD4W28KCq4ITNqEGg87HQV7iC9aN2Y3eZDfKa0rzLWG0vmmwx7UiWuO8JmTtXbw33lkypOZgYjuEhQtHcRAil/w3mwvN4kodlKom/Jls6f6w6OBHKJU9qqoAbyLTD9asFbPHJbE16CmXybbwTvSdACjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051602; c=relaxed/simple;
	bh=kfpHhOMhCTafFElzJiRv8QNBxHxjmeSCOSw1fMkjaaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZ+oeOX00Y2ss/Qw5frAE+Jlf5zs/QxkYQmuEvUBVaaloH5+0jEv10qVFVv80JSGS2ZH1oH0fCmfsGHgxk3Da9Mctb/qGfmq7f4pbeUos/lmqhsh/Oua4QvvGLzhFlcTI2NTr/XUmeiQp57AE8cw2MazLPxTHrXQ2E5sUTCYHWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJtYsFrz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGRFD+OUXBdzIHwpdd8L6KTTXumWjBTMpIxo57Gp8oE=;
	b=ZJtYsFrzzRgGw3xBXxGhVG0rKH2zSQAloChKKhhQr2rbntq8Euqp91zcfinqiwaD0eaT4p
	+oYbCAqlPQq1OW3hq7PcvbLbfMxfhKPnju412pGNpKQ2TzqjTiLDTpp5Iq7QTmIuAzxy3o
	GLh2H4WgcK4gfa4I5y8luwv+Jwwc3Cg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-UkIVgq5rNr2dww6vOtdbFg-1; Tue, 21 Oct 2025 08:59:58 -0400
X-MC-Unique: UkIVgq5rNr2dww6vOtdbFg-1
X-Mimecast-MFC-AGG-ID: UkIVgq5rNr2dww6vOtdbFg_1761051598
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-426ec5e9278so6557359f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051597; x=1761656397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGRFD+OUXBdzIHwpdd8L6KTTXumWjBTMpIxo57Gp8oE=;
        b=Ee4lYrR0DmPTLB2k9kYFY3RX/yCAUZeaEzOVQ2lExQWO5JmSAU2O3B/1gew3ltV744
         Qxuaghi845BmaluSpPqOU4EYZBLjKdyxeJZZYS7mdg/lgPaZFgwKg3mzx++cn+JoYX6Y
         X9eJizIp5HP4ZCgTD/qlBkLgStmi/i1ZAS9FIL13dwINnRBUjVOaBjG6h1+6QI6nna72
         oknzgjh8kbIhTWEAPKA4PkG43cFhjsGOpeGIgEHzzSCfIYeRhq+awJizRaWaLunLqfVQ
         Hl8x9pMKuxmZ7OVbM9JOGyFyHQC8jQ1VCv9hWYfkeWZDXf7eJq1BwxmfsgW5RSLjBJaC
         sSkA==
X-Gm-Message-State: AOJu0YyMQhntrgLiJJjrq4XqvKiNAmC9aJZAyeTtuCuXiNlHdoZGTgDU
	HuhqyuWx7mLS7by9JX7J1jEZeMyiCYNxJohBN/c4Ax2hq8eE21ZDLg40b1s6Wgii1Tl98J+zTXq
	abqoscP62WmB6fb+kiRTl9WTrsddqRRIK9LuxL5y4auRiwOjvQ1V09mA2TCL90ZoqM3LgK8uOBN
	idDL6GUg4I3/FnzCh/8GrXFNeyvduSYGNfUZUoBFRJAhuojg==
X-Gm-Gg: ASbGnct3NDtcrbUvxCkwuj7KJ1y/HkBpnBY+VQZ6ZsZUyzMbNEauMtvK+ryK+22F3r+
	ib6TNx5HugnfEHH65Rng7iqA3Mry/o5uXUzh7KrVPc45mwFq7sdbAt54vcDpQEaVpeuPlYvKogC
	Q6oI08jUU6aJPKyGbD6pZo1NNY4yICLPYVpdA62KuuOT8sF4Rbrz0rlY1nwm8uUxwqRhDbOd0Uc
	cp9B1yXBJLJX/boplSox4RpmMmfA56P/fMluLrd1bGIxv5n9wGVvSGi0xFkJlsY+Nchae+X1z7g
	YBx8R5LUd7sYokDpqlFnkjHTPuG6RLIClUEPYmeURfkSTdiBiwvtW/s0fAlSKFuEuix3w4btm6C
	Q+bfi1L1CT10TrfRTNZFShu9UgLy9v6gmdDdVSsjSc20P3hZwZgJDhPCDvTsG
X-Received: by 2002:a05:6000:2284:b0:400:7e60:7ee0 with SMTP id ffacd0b85a97d-42704c8848cmr11160784f8f.0.1761051597499;
        Tue, 21 Oct 2025 05:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1yccRPZwAQwYfj1DMBRFBsRJJ5k0BROkzwajkMvCNAUgq3lYo09LUN84ZfbVlOv9dAfW2Ig==
X-Received: by 2002:a05:6000:2284:b0:400:7e60:7ee0 with SMTP id ffacd0b85a97d-42704c8848cmr11160739f8f.0.1761051596931;
        Tue, 21 Oct 2025 05:59:56 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00b9f9dsm20357223f8f.39.2025.10.21.05.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:56 -0700 (PDT)
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
Subject: [PATCH v1 11/23] drivers/virtio/virtio_balloon: stop using balloon_page_push/pop()
Date: Tue, 21 Oct 2025 14:59:16 +0200
Message-ID: <20251021125929.377194-12-david@redhat.com>
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

Let's stop using these function so we can remove them. They look like
belonging to the balloon API for managing the device balloon list when
really they are just simple helpers only used by virtio-balloon.

Let's just inline them and switch to a proper
list_for_each_entry_safe().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f7d6a4a6e54f5..4b22de6a5f845 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -242,8 +242,8 @@ static void set_page_pfns(struct virtio_balloon *vb,
 static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 {
 	unsigned int num_allocated_pages;
+	struct page *page, *next;
 	unsigned int num_pfns;
-	struct page *page;
 	LIST_HEAD(pages);
 
 	/* We can only do one array worth at a time. */
@@ -262,14 +262,15 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 			break;
 		}
 
-		balloon_page_push(&pages, page);
+		list_add(&page->lru, &pages);
 	}
 
 	mutex_lock(&vb->balloon_lock);
 
 	vb->num_pfns = 0;
 
-	while ((page = balloon_page_pop(&pages))) {
+	list_for_each_entry_safe(page, next, &pages, lru) {
+		list_del(&page->lru);
 		balloon_page_enqueue(&vb->vb_dev_info, page);
 
 		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
@@ -474,15 +475,19 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
 					     unsigned long num_to_return)
 {
-	struct page *page;
-	unsigned long num_returned;
+	unsigned long num_returned = 0;
+	struct page *page, *next;
+
+	if (unlikely(!num_to_return))
+		return 0;
 
 	spin_lock_irq(&vb->free_page_list_lock);
-	for (num_returned = 0; num_returned < num_to_return; num_returned++) {
-		page = balloon_page_pop(&vb->free_page_list);
-		if (!page)
-			break;
+
+	list_for_each_entry_safe(page, next, &vb->free_page_list, lru) {
+		list_del(&page->lru);
 		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
+		if (++num_returned == num_to_return)
+			break;
 	}
 	vb->num_free_page_blocks -= num_returned;
 	spin_unlock_irq(&vb->free_page_list_lock);
@@ -717,7 +722,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
 		}
 		virtqueue_kick(vq);
 		spin_lock_irq(&vb->free_page_list_lock);
-		balloon_page_push(&vb->free_page_list, page);
+		list_add(&page->lru, &vb->free_page_list);
 		vb->num_free_page_blocks++;
 		spin_unlock_irq(&vb->free_page_list_lock);
 	} else {
-- 
2.51.0


