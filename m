Return-Path: <linux-kernel+bounces-781167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD34B30E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B327AA2A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E010284B25;
	Fri, 22 Aug 2025 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/bWOY5p"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5CD21B9DE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842368; cv=none; b=IEKDNjBowQLxSTwgsHiXt/3a3A12O/xUsZDbmn2f6fY894oeQ33rKc4Y2uSPQwW5IIAKVxuzkVVARBG1rx/Yal6bJTwy9QM3OMGB3PHjQ6a1unCEh0HNGEQ6aucPrqSjLrve+k5mTjhiwvA2WCSXggkqnfkaROfPZs1vO0JJ7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842368; c=relaxed/simple;
	bh=TG1Ri7tXxCAgGlmNAFId2EXEAgonDUGmJkvItsCtkk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lk1de0+FdxG4vREjvwDUYEXh26W3nXrlb3tOhN/FIn4oet7+diSLkUGDKu+nimQpLImQjB2DZcRWnlY1IFwnIAmQVNPg8GePVVYHmZeo2na09OC7utgQOMSrjHf8JzeJjKKOFF6E/Wan5+WCbekfn5tiRDGrfK2XfS5hnz9DBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/bWOY5p; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b471740e488so1422792a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755842366; x=1756447166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0/YH7tpqD6R0a1Qoz2f15khTHHnT14HYSHBnDr+ltc=;
        b=a/bWOY5pK9WkKCFf0jasBH6y5p91n/hn1CWhO/wAQz2VwvocL+zYsFpJqvUD7T3i2k
         0Eq/7ZLJLaJrTZbDahl+HT/NXrxy/ZF5VzI/B5pVd5VmvNhsjt0XI0yPWb8hWSUKwPhJ
         9revAMEHqC7LJ/d5Sh+o5J/hurXABq+o9GywdVEilopZjETL8W9mb/aMirsvh1EikzG6
         MQbBZDdj0ZPJSEBKeiBSWDKqUjvstYMYgcR0QF+FSLQy4xBn3SH1FnqQ2UWYbc88368V
         ION7RrrJyxobzybSGjv1ZZjGdn7UT71pdV3+pUuU70Kk3Ef3WXYEyZMv8qYDs9e63LcS
         R9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755842366; x=1756447166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0/YH7tpqD6R0a1Qoz2f15khTHHnT14HYSHBnDr+ltc=;
        b=mseLtiqF53bG2Ve2RHWzhat9gjbupEnNs9comlJ8ozL0rXNyRg7euclbdipA/n7STN
         LKhf9NwIkYyZkOiR9OwNrjL73mrk6wN0+OGx+CAOSYwYsZcpDmdPRcPoJCLC+fRXPdo6
         iHLrny2PNzLWWab5KW4SUqOTbtw0URPEnEomdcE9z+a328pb6ohKnL2WJHvReAOh38Qp
         2KXPdhgl3gjL/+bA028+swjVdMhdwgHmy7SmTHrSoFZzIMVcd84mGP8tEeXfJ5R6G8HU
         +Sh6PDelVUquTel5lcnxK3QUrOEhT2oDpuDBI2GSbHjVuMf234/5CmTIvlOILQ4po7LC
         aw/w==
X-Forwarded-Encrypted: i=1; AJvYcCWxQ7OrBIEaCp4/xKJcNeZ4pvpxo9uq2P7njZi6bOvloZSypMoLQE7sAjJLbNbndjcaJB+YdqpxeAZqL88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKyz+pn9DDZddSaLcfqFJZ8apXiusyNDH9C8Nh5A571F3o11RN
	P9ggTy4SxS/hrUjmmUKMbB1MdHC9O3y90o8cW2ZwvKb8QYvFIKT7NdJC
X-Gm-Gg: ASbGncuPo++ynxPTw++YEzORH8VfInN1NrZV2FD6rCzM4a3qK4sGHBeeCsxlUE+yhRe
	4T2QRpHGWKiukjPcc7CFtCObl+H/zcvqIqwuNyYvPqJ0eXjwrlfa0nGVDqpRDKwcHjLE6gMRv5v
	AZq/yX2CTk9WPQ/Tr3iSWms2lt8qPdZ1MsNOfTiH2Pmmz+Btc7VveStLkMWQHqmn9Owq2PM9MBv
	GlH7Amd6CCp9g9yojKhVVlYGOexvsessZwxBBIpIY/0Rt8HR6LLIaWuQKafT2AWdiNUR7uceAxW
	RbCmoIuJNRmqdkXSpxIHbQbK4Zlmg0NCGIJFx9lRlx9Fx/hm/Kk+CIYqJgXJXJc2b0FjACRhUQG
	/Mal3vwDOhRnp1ZBUFDkd7UbToDd0k1OFRjH0+NtbPChIdY1t6A==
X-Google-Smtp-Source: AGHT+IHu9AgiKmSd6Ip9ikRTzrXIGUl52NPjCcqZHHIbtsA0QL36We+giK2O+7PzugyFlXTU3i/w3w==
X-Received: by 2002:a05:6a20:3948:b0:240:16af:401a with SMTP id adf61e73a8af0-24340cd32b2mr2634360637.32.1755842366455;
        Thu, 21 Aug 2025 22:59:26 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cf7sm9891448b3a.69.2025.08.21.22.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 22:59:26 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	akpm@linux-foundation.org
Cc: leitao@debian.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] mm/hugetlb: add missing hugetlb_lock in __unmap_hugepage_range()
Date: Fri, 22 Aug 2025 14:58:57 +0900
Message-Id: <20250822055857.1142454-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When restoring a reservation for an anonymous page, we need to check to
freeing a surplus. However, __unmap_hugepage_range() causes data race
because it reads h->surplus_huge_pages without the protection of
hugetlb_lock.

Therefore, we need to add missing hugetlb_lock.

Reported-by: syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=417aeb05fd190f3a6da9
Fixes: df7a6d1f6405 ("mm/hugetlb: restore the reservation if needed")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 mm/hugetlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 753f99b4c718..e8d95a314df2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5951,6 +5951,8 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * If there we are freeing a surplus, do not set the restore
 		 * reservation bit.
 		 */
+		spin_lock_irq(&hugetlb_lock);
+
 		if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
 		    folio_test_anon(folio)) {
 			folio_set_hugetlb_restore_reserve(folio);
@@ -5958,6 +5960,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			adjust_reservation = true;
 		}
 
+		spin_unlock_irq(&hugetlb_lock);
 		spin_unlock(ptl);
 
 		/*
--

