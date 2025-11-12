Return-Path: <linux-kernel+bounces-896367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0F1C50350
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5EA3AFE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90332239085;
	Wed, 12 Nov 2025 01:27:59 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CEDF72
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762910879; cv=none; b=XCei1DeVN2GQ6Ait+AAkpegCqay+FxV8kyZjule6LSgpAlzhNlJ7OjA6DsIT4EuMNp3qxlRRTFemgsCxw0aL+MTQIDzw1IxUpm9BkScPDn4+kdMMT+7F5IHBM/CbOXci6gqXQ8EaGRUAC8U0flMEk9IvjPLT7J21vUXA+Md0hmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762910879; c=relaxed/simple;
	bh=L+M82fIquqeS9wYnTjLzsF+btLsvGyL8qJa9E61A1JU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oAHcH6lq2uDTKGKZt/MCXAK6Ej91MOPnjvKysCEIo7HHm5iPnyIZJDcxHStYx9ccg+fKAISXMCGWLzpa/VHk3y4OUSLChonKMXzApKtAlNTS7s/OSpOIFUNphsn6LBzI6s8QBaxN4xY4/zwSNwt7j5sYS2E3qxzvDJHNbo/QWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-945c705df24so35392639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762910877; x=1763515677;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/Sa8zuNK+2iEby7YBu76thTeiXaXUTKwCAYfHb7zZU=;
        b=d6+DzjqZIfAfSk9ai6RSnZ2bxlND+VQ+3qp0NUdMfifwDIaqz3/bqh/1DhT/6PUIGF
         EUU9yyBk/AADrseAU9WwUAZYbb9iqK/wpyfUkkochm4DNB29gZD8mocFH+rDsg9+ERRx
         VYt6dTr0kJ3I3sBBU53WT4/Axry5FzZ8nZuxcRK/ArBWtp8E1XCihZesxG2FvTeh+dYg
         wyzPYn04n27UNNedKA4ouZ2uHU2wR+rHzNfp+eRMnZA+TSu5TTgl5dAZkaPPfuhn+h22
         GMNwirn8/QG0+ak2f262KCMnR8ybYXeEa1rNaF+a6epkLVBY8bRaXrvX5ktd7zRQeZJ8
         P4aw==
X-Gm-Message-State: AOJu0YyXmP+EixrjVV3RIeYdOPiG3S2oTWQ4ut06N/kPAQQg9hS5jbD/
	ByUsb71H1o9CefLo4Yhd3hR/3tVj61ggI26C8KmNReKhhi6/mdzIT7KPsM8N6iT/YD6NDbYjjYo
	A4NbjlQnF8ePc2rstTulTlNJo4pIst1xQfaadAbr6GTeCw4veQyzTUDb5Nmc=
X-Google-Smtp-Source: AGHT+IF6LTafiFPMr5USwc1Ao1eqizfmZBPN42UqoAUDSU9Z0IxIqRuFAnB+nyCnVl1y7XR+XxDFAfFYhgMa9PSNzN6h+RpHGRb8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2684:b0:433:7929:e7a8 with SMTP id
 e9e14a558f8ab-4338bef5dd9mr83063065ab.12.1762910876847; Tue, 11 Nov 2025
 17:27:56 -0800 (PST)
Date: Tue, 11 Nov 2025 17:27:56 -0800
In-Reply-To: <69122a59.a70a0220.22f260.00fb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6913e29c.a70a0220.22f260.0153.GAE@google.com>
Subject: Forwarded: [PATCH] mm/memfd: clear hugetlb pages on allocation
From: syzbot <syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] mm/memfd: clear hugetlb pages on allocation
Author: kartikey406@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

When allocating hugetlb pages for memfd, the pages are not zeroed,
which leads to uninitialized kernel memory being exposed to userspace
through read() or mmap() operations.

The issue arises because hugetlb_reserve_pages() can allocate pages
through the surplus allocation path without the __GFP_ZERO flag. These
pages are added to the reservation pool and later returned by
alloc_hugetlb_folio_reserve() without being cleared, resulting in
uninitialized memory being accessible to userspace.

This is a security vulnerability as it allows information disclosure of
potentially sensitive kernel data. Fix it by explicitly zeroing the
folio after allocation using folio_zero_range().

This is particularly important for udmabuf use cases where these pages
are pinned and directly accessed by userspace via DMA buffers.

Reproducer:
 - Create memfd with MFD_HUGETLB flag
 - Use UDMABUF_CREATE ioctl to pin the hugetlb pages
 - Read from the memfd using preadv()
 - KMSAN detects uninitialized memory being copied to userspace

Reported-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f64019ba229e3a5c411b
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 mm/memfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index 1d109c1acf21..cdef16ef1011 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -96,6 +96,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 						    NULL,
 						    gfp_mask);
 		if (folio) {
+			folio_zero_range(folio, 0, folio_size(folio));
 			err = hugetlb_add_to_page_cache(folio,
 							memfd->f_mapping,
 							idx);
-- 
2.43.0


