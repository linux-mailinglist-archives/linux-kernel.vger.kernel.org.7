Return-Path: <linux-kernel+bounces-896455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4ACC506A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBAE04E3172
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98D625A64C;
	Wed, 12 Nov 2025 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2oD0YrC"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D441D5160
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762917405; cv=none; b=ghdqyoz09/1LkLKcM7ft5wtPb8JZnWq53KG/L42nocUOWom3AQiAStYkUh3ieu2OexsTtJfY7x18NOlBlrc6LUF7ITVvhYWarx57kd8lWf9dMsbH0cpdyuy32wXPcy/C6zm9kx29iSM8koMg2RdmlWzZiHUoGuUfjIXP7XCAmRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762917405; c=relaxed/simple;
	bh=iEpTZFmWsno+Tm566n/qPZio3fhXh+bZM/ZhMWIsEWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrGjGYGtnGxkvbwBJrNVNB3Vuyp7RhLuWUIlxfOfxJY8wTAQB7LjnjRYq4JtaErp5Dzd1hkSbo8FrBIKIxxy0CHm8jNIDJ4KtnQUESXc8PSbvM2SEQwQEaNh+H3EAqvs42HGqILMCsHQ4Y7zUcoSNTCFbYHUI2y9tBkjLvRqtz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2oD0YrC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b0246b27b2so492293b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762917403; x=1763522203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=54geGydfN2rDn2LihShjRD3xq+QXkZulAFyru1X2fZY=;
        b=b2oD0YrCWTdzpmCdSZ5+Kpy5VTCW0FF8sKxpUTULAjWEUYioVPWXBU8Yqnc/+hFA6/
         UVmO91MVCSc9RmvW8nSgkYqynZIYt67VbW9Y16cFi6XD/4Su/NDruLNcAmKGHbB6fmKk
         FBDs8Bhcycs451B2XSIVN5Q0StIS92mbIYN1mNYmXAyFTyPOdvzo0nxToTCwpAsf8qfL
         y/+R7KhSXASK1RqgQVEUO5IqenS1smiunpD7tYw+MzoFPfvFL4QLjWZ4WqWW3ciDEPZn
         KvpR6yr/1xaNV1jaoKQs9dDqzwubBES023ZZ8sCGdE76utNpL853fmDsTSWndQ/ZZTYV
         Vdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762917403; x=1763522203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54geGydfN2rDn2LihShjRD3xq+QXkZulAFyru1X2fZY=;
        b=Lx+wIo3l8xPBxr3MIzrqbNVzsMRA9VvEmSph8sQaTedVdKKRfiPe9HnAKFmw2stntE
         ATqXWctWJ1porEVhaC+lpi5vRSRtf/qdKFfDUmvapOwm2tQPqqWKjBXf4e/y3hiF6jqc
         NL65LtFoN8RrO2VjC9lD4pK+ulxJjF4/63dGqV6Z0ZE5/M6N0GA4oUoZQvrHxWIu5JBo
         iQ+JxhcFQ2c/gjcbTzJPcQd8G807LSx68ghuENa71+Cxm8SgXyyE8k1Vt8wSOY+zzXpv
         RXw4s2iXKvfztqez65OmNa/0lMyyB/+9t4BJ1qieMWzQ1sdWjalfbyYRrXeTEuu5bWfp
         S/vA==
X-Forwarded-Encrypted: i=1; AJvYcCWzTXxelIYVZqhB0yrQrBf4JPeFQ+WqnZodnAeg1x+gNNyxDR6iWuvXNlAwqqH9wp/+/Rallb9dLPK9O/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YybqRCiNCC2YM4alZArz1yN3s7kkaHdSVXyX1DsD2CQk+yxk4eT
	Xocw08xEphg4XVuTjCCsxxFIY+OSkfCcl4pSYW4ivYtIkFuMcncU5HgS
X-Gm-Gg: ASbGncu3hPUv9Iz4Ud0JEqtiMCWmysUi2Yml1IgGaThbbEIu+UHA7AGPTmFesoa4Egt
	aKvzDFbB+J8QpiJnRcY8pqkBBm4FhWBm0mFZ4hcCksAQ9c1k6I4xBdA5KugZungFgaxsIJYTM9s
	rfJTF1fv1BFq1UZxujzty1vfoQbyaj3jw73M6fwq9191o1J+LHrcX95bBsM5KeBB2+J4aioF16S
	ASwiTohJ2yHBXkh9yhUv3Do4yErUozxy4k7sjbA8YC/6W9AMcANr06t50a2KT+TYNs+XOjNMfTi
	p0/SgUd3Cv778+azNN+tg/dQwCLOX7/dPbob9ztlDnF/XEWhA3jvUG9dzoWU30SNw1qYjmIUZIB
	m0gB8QhAzsGdSmPr3swkanxNssqpU9MRkyYuDmCHx4VEGbSEv6pqTMv2DmHbZBJqqMVAGgQbSuA
	i3GPCwFqswVV4y5nIdsm88hnaf
X-Google-Smtp-Source: AGHT+IEkMliJ7qBKQYrIHSvOIWpab75LmuQu3zIzehn3oSgIEMLML+jJyMlJs4LMkYWAbU+iGIXGbA==
X-Received: by 2002:a05:6a00:b8e:b0:7aa:93d5:822c with SMTP id d2e1a72fcca58-7b7a55b7542mr1319175b3a.23.1762917402869;
        Tue, 11 Nov 2025 19:16:42 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:1574:2bdf:5190:94ba])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17b0c4sm16967241b3a.48.2025.11.11.19.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 19:16:42 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Subject: [PATCH] mm/memfd: clear hugetlb pages on allocation
Date: Wed, 12 Nov 2025 08:46:31 +0530
Message-ID: <20251112031631.2315651-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Tested-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 mm/memfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index 1d109c1acf21..f8cfc2909507 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -96,6 +96,12 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 						    NULL,
 						    gfp_mask);
 		if (folio) {
+			/*
+			 * Zero the folio to prevent information leaks to userspace.
+			 * The folio may have been allocated during hugetlb_reserve_pages()
+			 * without __GFP_ZERO, so explicitly clear it here.
+			 */
+			folio_zero_range(folio, 0, folio_size(folio));
 			err = hugetlb_add_to_page_cache(folio,
 							memfd->f_mapping,
 							idx);
-- 
2.43.0


