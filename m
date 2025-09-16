Return-Path: <linux-kernel+bounces-819215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA7B59CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99275324D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCB2393DDB;
	Tue, 16 Sep 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hkh3y9ey"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2633265626
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038553; cv=none; b=de1aF/8qSKHuJAtGjrSu6+AWza7yax5S6Du/8kRpvlnwFMeu/BObFGpRIZmWYRW1ERHxYCK+5Csh+eoUpjdLiU/sM1fzBxLESHS0tv/N9eAbv7HUXyyy0SCCTjc8W2V7XZTst4S7cHSfcYMRhBugx5gyUdyOaoUNsM5Km6uWgzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038553; c=relaxed/simple;
	bh=WeIeULHdGyzKDZVWKWzPLNPkRpEyEoVtQFcYjcMu7QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODs+4SVkNt3sqycAqiA1C6Q5xTAmcS1wRLup08R5RXHJTZ+KYTwHULhnO2GEa2rAxvVEf2CkHJsg/t0jPaaFQL5h2XwkmyOjYICSztHB1p3Pm1jq1vDuRd9HumCs6bNkP5qdjOJq7ZaDJAparwu6cGKmnGw0VmoBZZaFpSkDbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hkh3y9ey; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-812bc4ff723so524541585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038551; x=1758643351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4hsOmThW2RAYLAuUPY0h11vKmZVrV6aWWNRHy7EaYEQ=;
        b=Hkh3y9ey8noOTz2/v3ue5NWAoNjRq5RuynHMLTQITgs88CMJl5aG2sWrD3HqG7riVn
         UlAU5+aKgR21koXS0Y9yb/xKgIqAO8elACzZ8GKYjlpSmlpsgUNbMBXPoCMUACviD9lp
         ybd060zab4XjyZxdjGE2za4fkHGSolBWxNBaTOuzK9lTd6UOzGlLl7cdChoEKHLBUF95
         awi9vGAVek/TGNvbPnaESES3fLuXMsJHdx5bBlUu6opBFBxhAa7vPr1I0M2Z4SIXlrdP
         3oGn60aoV8xHQKE3f9oMmyohVUj3ntPGIV630gTxx9xrdSEh+ALZUmpp6eCB9PBeZL1h
         na+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038551; x=1758643351;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4hsOmThW2RAYLAuUPY0h11vKmZVrV6aWWNRHy7EaYEQ=;
        b=XgXXlI4oV8bXr08TtE3kDNZMVOoKg235EK6Y6oNmxxma3g8GO71ZlDRA2NorVPOZFo
         0L6y4uuzEMO6rNYABx8PM7vCKljHuiXQdn04LYGSGXGHWhQwNkIqsBY5JS5LiOZJtx42
         SQbdf/evZXVnIqVZSzDzoM7udZgu5yQ8/hC0Gw0U1X7Z1QNgEMzrMJwtRJyZ/lS9ZIAc
         uOjWamypDCxS+38o16DDdLhTPCVpsKX3hcrRICH2rQz9l9doWvVoIs2Hiehex1H4/Wl1
         4OVm+86vUL5lPTQpi0BB5zyCJNm9G1Z4CZpheVCtlcchZwp/F+3bPsR3JUu6YFVwYkWa
         lZww==
X-Forwarded-Encrypted: i=1; AJvYcCWfkCaUsnZVvWcNvkEE43jRuf2cCOhiHL34S3deC+CWVRliwujmuLD6B9d7flKfbVDWQ7pmo7QbFZWQYWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8cCrus3mlEps2KfcRxcJrMFzALmR1r1T4+cUtoVaZiv1/v0U3
	de1vCHn0kQ+/dKlVY4JsWmCVg2rM3G9aokNHl7AhNemTKlZF4oSEMqC2
X-Gm-Gg: ASbGncsFzVT13w4oJG/SFuoJKp652ALe13Xq+96VFZNoRTB6AZsgVLZrrzkKtVIaIjJ
	col5HdJwaDL7HdfRW3REFxWpQTM1c3vVhwOir3c8mxn8X+gOvnhHiAM/SbjMhARHfhw6qmPSYhC
	U8QqvzsxXdDuLv2/ME7kZoKYoGvwtw9GhBR56Uuq627nfHxGEUTDgZfoP8mFzXMKeOOpGiJWagP
	QtiSVh73FbJYwIssKqXztffOSvF1sHMOMxJpOe12gtQmEgSRFmB/XjpAEjV7kJqhJXDQLv2aXDo
	4FlwdwyBjNvTR3lxbPkoH7+7rLTofZrDcQELWBpccjGQT3zf1QjDXQostabx9XU1Kpg1rIDOb5U
	pRwITTJFRo+3h+VcS3eFmC7qzFiUvuzR12yepT60CmDN9F6c=
X-Google-Smtp-Source: AGHT+IEcUJm6HBE67qNWNXwnh1bmV+sbQgFEI8gjzHotd6hHFYJuVK3vbAW+rqvSuL61i7u/HC8DNg==
X-Received: by 2002:a05:620a:370a:b0:7f1:9a91:1dda with SMTP id af79cd13be357-823fb826224mr2074340985a.13.1758038550496;
        Tue, 16 Sep 2025 09:02:30 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd703f54sm969765485a.37.2025.09.16.09.02.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 09:02:29 -0700 (PDT)
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
Subject: [PATCH v4 12/15] mm, swap: mark swap address space ro and add context debug check
Date: Wed, 17 Sep 2025 00:00:57 +0800
Message-ID: <20250916160100.31545-13-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916160100.31545-1-ryncsn@gmail.com>
References: <20250916160100.31545-1-ryncsn@gmail.com>
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
index 2558a648d671..a1478cbff384 100644
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


