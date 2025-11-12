Return-Path: <linux-kernel+bounces-897218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 108A9C524E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 995F54E3B70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8487F33468A;
	Wed, 12 Nov 2025 12:41:11 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651253314A9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951271; cv=none; b=uXondbZ/ZlmISlTndmJyPHEdk+pu4CZCZxbad8acAnxGmN6u6ZlLV/pWavXXyo/Q+a5T7MdEa6BXG2PwuVbo7VMQprmWDyuzhKOWTfg96Nb40HAWnK2tCn4RgReS159VuFiz7b6/9tWJQAYkFLivN4kWxzd+aCZXIhgQzUhMo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951271; c=relaxed/simple;
	bh=r2pr3VOiUxGN2SoGsDXt5nd8YqYlIVTeAfzHgW74/uA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dY47O8S6kFLuJIrRT38cnqyMyQQazQh/EqD46Qq+RwpjBt3CA6JIu4e3pDDH+9v0K3BE0EJwhWIdDR4a2R7UyzcWMeEcGQwefOB7BbPvu12jCFgCUqFjqN+x9KJJCwAxveWiW6Bx+jiUEN9sRtzobTSxXjdKuIRlC+PJO3adYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433795a17c1so23702295ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762951263; x=1763556063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKuVGtU0WsM3wrXAzCwRZsx7aCtD7djQ/vljwXKJo/4=;
        b=GhCxTVZJkfQPgKw2HRRD9bczv4D05fBVbCkO6e24RkK3bI1Dw5SCwzCxO0tG63d0pT
         63bkNiBmfJQfRDJ5ELT8s5Dycm+8AB60kNaJFzuZZMRkm0nyFARhfKZL7fMWCDVMrJxx
         8Qdg1QfkONqh0SjqUlUlw39fK2heyK+pBb4KSE1Ifb93M05xmq5+rm3ITUr/hKAFoL3y
         YKdABIYl4Gru/brMYjq+W7oycMiyOhjJD5GTAuqzK/laZT8xhaWZYyYsMJj3VPfDdvCN
         SPGYizckg/XkB0idtevM0IA7Yli9S37vxnQz7Knc0qmIq3FT2hQRYQuiUdaocKxXSKHQ
         pe0Q==
X-Gm-Message-State: AOJu0YzsktBxUWT0kkJLTUuJGlzH2Kx9d8V0Ih+G4JplHoM7o6QqDOSv
	pD9EM1Nl8VPlOS/RUMqOrRZGUFioqYSa0FPo+0/e820FlAkWmZNC8D4wl16TfH2o6vbEl3d1nGa
	KqNCHAtjTf9NbwMpcYnMw4TXdG79KW69jbro8oZVQXG9J3Xiyz/YyhSK2xe8=
X-Google-Smtp-Source: AGHT+IGAe/Y5q9okNx7HYd6WqG68skEpD3o4eNp7IjFpvdJTIR4UIdkqMPHxoEmSnIJZje1RSBO46J41AaWNuFYB/GZQT1XAnv8H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4b:b0:433:7b22:c2b5 with SMTP id
 e9e14a558f8ab-43473d170a0mr41871095ab.13.1762951263418; Wed, 12 Nov 2025
 04:41:03 -0800 (PST)
Date: Wed, 12 Nov 2025 04:41:03 -0800
In-Reply-To: <69122a59.a70a0220.22f260.00fb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6914805f.a70a0220.3124cb.0001.GAE@google.com>
Subject: Forwarded: [PATCH] mm/memfd: properly initialize hugetlb folios
From: syzbot <syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] mm/memfd: properly initialize hugetlb folios
Author: kartikey406@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


When allocating hugetlb folios for memfd, three initialization steps
are missing:

1. Folios are not zeroed, leading to kernel memory disclosure to userspace
2. Folios are not marked uptodate before adding to page cache
3. hugetlb_fault_mutex is not taken before hugetlb_add_to_page_cache()

The memfd allocation path bypasses the normal page fault handler
(hugetlb_no_page) which would handle all of these initialization steps.
This is problematic especially for udmabuf use cases where folios are
pinned and directly accessed by userspace via DMA.

Fix by matching the initialization pattern used in hugetlb_no_page():
- Zero the folio using folio_zero_user() which is optimized for huge pages
- Mark it uptodate with __folio_mark_uptodate()
- Take hugetlb_fault_mutex before adding to page cache to prevent races

The folio_zero_user() change fixes a security vulnerability where
uninitialized kernel memory could be disclosed to userspace through
read() or mmap() operations on the memfd.

Link: https://lore.kernel.org/all/20251112031631.2315651-1-kartikey406@gmail.com/
Reported-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f64019ba229e3a5c411b
Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Link: https://lore.kernel.org/all/20251112031631.2315651-1-kartikey406@gmail.com/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v1 -> v2:
- Use folio_zero_user() instead of folio_zero_range() per David's feedback
- Add __folio_mark_uptodate() before adding to page cache per Oscar's feedback
- Add hugetlb_fault_mutex locking around hugetlb_add_to_page_cache() per Oscar's feedback
- Add Fixes: tag and Cc: stable for backporting per Hugh's feedback
- Add Suggested-by: tags for Oscar and David
---
 mm/memfd.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index 1d109c1acf21..d32eef58d154 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -96,9 +96,36 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 						    NULL,
 						    gfp_mask);
 		if (folio) {
+			u32 hash;
+
+			/*
+			 * Zero the folio to prevent information leaks to userspace.
+			 * Use folio_zero_user() which is optimized for huge/gigantic
+			 * pages. Pass 0 as addr_hint since this is not a faulting path
+			 *  and we don't have a user virtual address yet.
+			 */
+			folio_zero_user(folio, 0);
+
+			/*
+			 * Mark the folio uptodate before adding to page cache,
+			 * as required by filemap.c and other hugetlb paths.
+			 */
+			__folio_mark_uptodate(folio);
+
+			/*
+			 * Serialize hugepage allocation and instantiation to prevent
+			 * races with concurrent allocations, as required by all other
+			 * callers of hugetlb_add_to_page_cache().
+			 */
+			hash = hugetlb_fault_mutex_hash(memfd->f_mapping, idx);
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
+
 			err = hugetlb_add_to_page_cache(folio,
 							memfd->f_mapping,
 							idx);
+
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+
 			if (err) {
 				folio_put(folio);
 				goto err_unresv;
-- 
2.43.0


