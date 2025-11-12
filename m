Return-Path: <linux-kernel+bounces-896345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AF8C50283
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 693C934BF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879C71C6FEC;
	Wed, 12 Nov 2025 00:54:36 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9C14B96E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762908876; cv=none; b=tok3/iDrsSpL+Y6VuEkMsDfnM1lxuhKbbJ/b09GFraLtPPE/iK3T4V7XapCqeqTSSsKayLNlz1fin4eCqNyOJRxTmCa6IcbRSFDNGayoFdBLGcJXLLvbYeVWB+/WJ9TAoczXur9j7UJj4xLmrNY5KSLWjptALC7ToyIg2OUdSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762908876; c=relaxed/simple;
	bh=uoxQnkelWMZqJYWExlWbfWwuUWYxgFbnCfJTLxhFaC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gqeRXACSJJ+3drpq7T0Oi+u7nfK0I+plS41Tf/iHoPU+6zi68NpZa9akedQsnTZ5iDdRpoYARJROxIhdk1erslVuN1qCNWFE17CLjH3xl4tOqLHz9R0fQ1rfzu/opX2T9362BYEcG3SNMXY5LDJZYB8AdSniWbI+xcER1I4C+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-433154d39abso10607875ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762908872; x=1763513672;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLXmTytxRNxVD3cnXXyaulNop43UUQ/iKdMn7WFCRpE=;
        b=vGydPpPV0Uw/iSOtq03S/U7PhTraNUV4Gzjd614RahMS4ziWE8CUhfc7/ls3KTgFyq
         sr22HWmlgU/hPyCXb4vZ+EXLxaGFeBvi+W8v5qgoPeT8RGEjNXVHNnck/BpMZ0QnG5Os
         uvqjR/OKrZVQ+J9zwjgxFJ2wXVoRnYdtUvEvbM2WKrTAnSgJO+bdvNWNOD3SbBE+6E+M
         OnSQyZ/TWpFqQdtdqU0lKQkT7ZTu1KGDdMNotOUzjIJxQog/qxCMUmo0o29ksH9Ofgsz
         SxXq1E14vgHwcdeJ7gZkZ6BqW20KwJe2DTkEzvS962XXEgmoUHLMu2Ol80LrRdolXNNn
         Uyjg==
X-Gm-Message-State: AOJu0Yyzp1cPqH9346V/mBvuiBf457Z02UmI5d2PN5QM9wv1qtTyJqAE
	Ij1dKFPJk+JquRvKUF0cv5xTBANtSlwMrL+qNx1fIKgOeCngpHKQMMYs2rXmhTLW37Ex/NJqnpi
	MYPs9i+XBFcXKx8vQOgrlsSp6LWA42bopkuSMTuGLExVfqczPdHerGKHdn2I=
X-Google-Smtp-Source: AGHT+IEjScsTStp66jhTfMPBIMwk+Pa+fK6kV1eXGxnPVfRYcW5G6dkt0/uznE9QN5nj4H3iet951EmhdrXSNxEEo8WG0BO42o2c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:433:2d7e:3076 with SMTP id
 e9e14a558f8ab-43473d9b030mr16104925ab.18.1762908872623; Tue, 11 Nov 2025
 16:54:32 -0800 (PST)
Date: Tue, 11 Nov 2025 16:54:32 -0800
In-Reply-To: <69122a59.a70a0220.22f260.00fb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6913dac8.a70a0220.22f260.0150.GAE@google.com>
Subject: Forwarded: [PATCH] mm/memfd: zero hugetlb pages on allocation
From: syzbot <syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] mm/memfd: zero hugetlb pages on allocation
Author: kartikey406@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


When allocating hugetlb pages for memfd, the pages were not being
zeroed, which could lead to uninitialized kernel memory being exposed
to userspace through read() or mmap() operations.

This is a security issue as it allows information disclosure of
potentially sensitive kernel data. Add __GFP_ZERO to the gfp_mask
to ensure pages are cleared before being made accessible to userspace.

This is particularly important for udmabuf use cases where these
pages are pinned and directly accessed by userspace via DMA buffers.

Reproducer:
 - Create memfd with MFD_HUGETLB flag
 - Use udmabuf ioctl to pin the pages
 - Read from the memfd using preadv()
 - KMSAN detects uninitialized memory leak to userspace

Reported-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f64019ba229e3a5c411b
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 mm/memfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index 1d109c1acf21..0095b9f4fe00 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -85,6 +85,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 
 		gfp_mask = htlb_alloc_mask(h);
 		gfp_mask &= ~(__GFP_HIGHMEM | __GFP_MOVABLE);
+		gfp_mask |= __GFP_ZERO;
 		idx >>= huge_page_order(h);
 
 		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, 0);
-- 
2.43.0


