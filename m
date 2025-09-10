Return-Path: <linux-kernel+bounces-810633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F17B51D24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E7018883C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320C337681;
	Wed, 10 Sep 2025 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7ze4DPH"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C623375D0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520587; cv=none; b=a3H20wLA+HUWb2Xpz7FPTAN+ukK6RQ087GGt1Au4qhI9e7m891x5Gy9zSSejE75YZFOWbEQzxjhVOR6chaJfSJtLEsqqg7m+vYiTSaUq+HvN/Ajxe0Xt4+N3LgfZLVHp6GA+KzUzX1Tk7ySZN31vWhnOCT0OAA0F4hYetuG0VvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520587; c=relaxed/simple;
	bh=J0AulNAsnT8Ymo6KtZvstHEj395E13+pa9k9CH/G17A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQwHKtW6rcmn+p7DhQUPsOmv5KlQPQksMEuAF5F10a4RLvr3642283YsZKJz5ix9clj40hgFT2yBYxu3ycMZtZshYguBAaHk94H1urobYYVhSRK8qPM5rm6ijvNv/XcmYvnre+Wn99+TmlwYUf919zmdfEsGdw6BnUxiUk2kO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7ze4DPH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77256200f1bso6152005b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520585; x=1758125385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mUMwPFkC6/4gEbz67OObm145GGunBjCLIUgwlHXltYw=;
        b=X7ze4DPHIL9G2/u0D2EduOXBFsDg5u9+SrMhfRt67fIb9vSfrWCRT2ADvD1xlUMMk5
         i2X75MT/qd31NZUfkyfFhDG+nWLqSCoJ5rsxmDt4alPYP9DUi+WhABW+V4ngoI3Pjy4A
         rj8alK9uXwzWeKq3k70BxCSuqkBsEeeZm1mJpsSxwCevzupJd5sIPaBNWM0lvFD04DuW
         DmdFc1h9lImeQyoW5gYDAHJKEOgSlxlc+i9SXYNWASgJstIo/D6LWNjEDJRaDEJ+Q04v
         wiKPKD1JGayTxxBBVv/tk3/jISg3sgO9TMwb60IH1cNCGSkqia1nLXGEbCvvypYqQ8ZB
         fpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520585; x=1758125385;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUMwPFkC6/4gEbz67OObm145GGunBjCLIUgwlHXltYw=;
        b=StscRIiRo27eGwodOA8XlS/TUF1mCrU/LAY4JdFh4g2VMmLtD7/5ac0SMFjhR7a1SF
         9sUc1xGW41JhPUdO2dQvVNfKQZhWdjVOr76P6ruFX7skgEiDcql5jh/6N+lIA9Sonleg
         AtqE52HLee2W1d5eeFez+U0zFtUVW2m+/Z6ZewbeLdE5VIkNXQKSrmhUt4wyqstp0Lyc
         aVDguRTBUCPHn2zc67P9o0UdBXXkAH35Ti5lsJ+CZdI/HW4SdqI3Sz/ImVI5wq2I6zK1
         qItZC7Djec+ofNYSKShp+ys/JwxQoiZsi/ZAjU4vdiHlRM+4zPNbEtVnwhdvt4RJAXIu
         5OcA==
X-Forwarded-Encrypted: i=1; AJvYcCUAVCXFJnUH1URt0Zkm80cZoKrrlkpFqBcudNdSQmJNOWxV4wEoW6IFtCoZEWfnXmuTu9sW10fll6NyvGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6jq2gJHwxUaJMix/hNjwhY4afyGTCwsjYD0Z+Kver4JdUrb5M
	ztXPdQNmJfqxTn8qPrxRToPOz7dbIK4VyRy84eq1/N+MnF1FBROQG7Lc
X-Gm-Gg: ASbGncsxcqo+If/RCQe3D3jUleNlW6CySFm/DTe25aHtaiDR69BZMpxLS/20yiRh8Fy
	N1OROmcuEvODxkzkGedXlDmwqDH/ixiuRUjuWsREvsjiatDH5ttlS3CyBQGFqWQud2LF4FpzWWD
	/dxm+fokVeLy7UlUuC5Qsrz60tex8Pa8xDRTg7/fdZsnAT3UDHsBhm1MIGTEv1XrPnEdg1eYqRV
	q4QhCDQ8FxBaMVeuodZbHPXe3xCXnIeO8LXnuPRXoDKMJMZd4KthLVqXziA/mDmyxayXZTGn1tm
	+eltWVQprV1Z1qMDGJ3b6oEBQzYgklUva3y3recjEeDPJME5LH3t3hvezpfXWofmY73LzNSv74z
	5slS7hUXSm282zDXz+oXrNYJdoYBatSkjMQv3Rk8/ltpm9F4=
X-Google-Smtp-Source: AGHT+IF4aEJFdwdzqld0Qv3VuyHOHub7zXw74OiqWKQuRHCc9dAp9UkKKUX0sq6k06ILw38fGnOA9Q==
X-Received: by 2002:a05:6a20:2584:b0:246:3a6:3e45 with SMTP id adf61e73a8af0-2534557cb54mr23558299637.46.1757520585439;
        Wed, 10 Sep 2025 09:09:45 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54998a1068sm1000142a12.31.2025.09.10.09.09.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 09:09:45 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Kairui Song <ryncsn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 12/15] mm, swap: mark swap address space ro and add context debug check
Date: Thu, 11 Sep 2025 00:08:30 +0800
Message-ID: <20250910160833.3464-13-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910160833.3464-1-ryncsn@gmail.com>
References: <20250910160833.3464-1-ryncsn@gmail.com>
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Swap cache is now backed by swap table, and the address space is not
holding any mutable data anymore. And swap cache is now protected by
the swap cluster lock, instead of the XArray lock. All access to swap
cache are wrapped by swap cache helpers. Locking is mostly handled
internally by swap cache helpers, only a few __swap_cache_* helpers
require the caller to lock the cluster by themselves.

Worth noting that, unlike XArray, the cluster lock is not IRQ safe.
The swap cache was very different compared to filemap, and now it's
completely separated from filemap. Nothing wants to mark or change
anything or do a writeback callback in IRQ.

So explicitly document this and add a debug check to avoid further
potential misuse. And mark the swap cache space as read-only to avoid
any user wrongly mixing unexpected filemap helpers with swap cache.

Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Chris Li <chrisl@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/swap.h       | 12 +++++++++++-
 mm/swap_state.c |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 742db4d46d23..adcd85fa8538 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -99,6 +99,16 @@ static __always_inline struct swap_cluster_info *__swap_cluster_lock(
 {
 	struct swap_cluster_info *ci = __swap_offset_to_cluster(si, offset);
 
+	/*
+	 * Nothing modifies swap cache in an IRQ context. All access to
+	 * swap cache is wrapped by swap_cache_* helpers, and swap cache
+	 * writeback is handled outside of IRQs. Swapin or swapout never
+	 * occurs in IRQ, and neither does in-place split or replace.
+	 *
+	 * Besides, modifying swap cache requires synchronization with
+	 * swap_map, which was never IRQ safe.
+	 */
+	VM_WARN_ON_ONCE(!in_task());
 	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
 	if (irq)
 		spin_lock_irq(&ci->lock);
@@ -192,7 +202,7 @@ void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug);
 #define SWAP_ADDRESS_SPACE_SHIFT	14
 #define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)
 #define SWAP_ADDRESS_SPACE_MASK		(SWAP_ADDRESS_SPACE_PAGES - 1)
-extern struct address_space swap_space;
+extern struct address_space swap_space __ro_after_init;
 static inline struct address_space *swap_address_space(swp_entry_t entry)
 {
 	return &swap_space;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index f4a579c23087..97372539a575 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -37,7 +37,8 @@ static const struct address_space_operations swap_aops = {
 #endif
 };
 
-struct address_space swap_space __read_mostly = {
+/* Set swap_space as read only as swap cache is handled by swap table */
+struct address_space swap_space __ro_after_init = {
 	.a_ops = &swap_aops,
 };
 
-- 
2.51.0


