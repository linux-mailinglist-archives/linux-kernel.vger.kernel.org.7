Return-Path: <linux-kernel+bounces-822055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCD2B82EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58CB4A26A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B5E27FD71;
	Thu, 18 Sep 2025 05:04:53 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266921D3C0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171892; cv=none; b=jyumIlK8uKgLWu4SCyRs7COMpCgoOrAR50ZyjWZqmV173HRPmQzOJZ8sfeYc8pQ2io71afsY2PXhqVTIAQfhmFXUMm7Xgq+bAAe+HhZC91Zrb9xq9sKNG2mTwNSZ2WyE/XGNolb3Vme+KWyXjVBLnjO+kW6chZayG2rGWLdK6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171892; c=relaxed/simple;
	bh=KYmdvRUHDcevlfn07rnh5hYBCV/BniJ3XvgTxEcd6bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ7BsBXk1Uc1mdrGttAdVN2w7z81s+A59hs0cUZTz5NrF759yU/UTXLsfxaeb0ym0tk39d2MRZU2iQlLsX++erHBVrSYEJbgcuiVG9SWbtLD/OyD54hqopifLQGxRjt9/n2KoIqXZghOGf/8mHLcE6uqnVnnfpmlBNeHuprcx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso78954f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758171889; x=1758776689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haDiPSY51WpyxaPZb1knOMrIoT8o6NHcAH5Q6EVWoj0=;
        b=hwAX9Ioj5Et0XaxQHcrRZ43qwak8KcSz+Hkm85ia1N61YLkOL+jDNypsz2AM/WB0jn
         PGxWR9jLBp56ptMJrT5f9WpX/qNM0XYhsVQnG6dIdGqv+3PFcHyVl5Sr8N3ZwvonK9wR
         IsjipOyeFX3t0aGNtGRFXzWWrXBsZmNjoMrUgzNeimwqxhCCTglurmq0TMayi/tU1rf1
         fKuNIEYdDJ2XmxUUqPNomSY43MRo+yFFFQdRRhsUNeE3K3lknQQLbu1er1EepVlkEapI
         yVPrCTBDAnCod1uV+uviXKckUNio0gyukP6h6WhDgKiRr3hebDarqG6Vu2Y9R1NpsLA3
         oBJw==
X-Forwarded-Encrypted: i=1; AJvYcCVj6h4wWjmGaVvxtYkP3x7uu/uV9gQEQ4NTBfYoGpo7dMDYI8fXm88n4LX/oURzxgE7QHE1SjEXWula5yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymsUUgoPFYZewD5ZdGGNlYNKaeUNrSlAy/W8G8oGgH+EUc4c4I
	lv4myI1UsL+FSRzzBzniv4zPuniULpqm6dmiK3yoVVQf6lJ/1l1FyM8i
X-Gm-Gg: ASbGncuRL9oy60iuVtNU5mF2agpSN5woBT1HpW457+1TJ1/7pTXbNVlq3CJ2PBXBGtt
	YEe/qcYbtExsEDN8s76/TY/lQBcrkyeq1tJKztpajJVCPyWYNGJunhyJ5ZZ+D6S41iyvXU5BUrV
	EQmZRYwpa1TT26UJbU94wnaQdJzAad86MmltNzZmsraivOVWeK+mnycGvR5UZLyB95Or0LOzBjN
	XMnnf2QT8D7QRfKHMRHTQ4UF+20tEmGCduf0GOGQFpCByvTcWdCCdXIqJHejtj8WfoeGlQWHcOA
	jeXok8O0Pmn3VAPe3IJ+LlNzDdBMcnyD7c/9NII7UEuIxRn31LNIIW40QSx1A45MlvzxS6IiQHq
	YUToL+ZQgK07M2alWBU5r8hqF8p8=
X-Google-Smtp-Source: AGHT+IGKPgASo0zj6nOd7C1PVcpDYMiRoBAUkpl4xN92bmh7D2grzC8f307rD3nF/krqA7stBkuhXw==
X-Received: by 2002:a05:6000:200c:b0:3ec:d789:b35e with SMTP id ffacd0b85a97d-3ecdf9f3e2bmr2809812f8f.8.1758171889281;
        Wed, 17 Sep 2025 22:04:49 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407aebsm1994409f8f.14.2025.09.17.22.04.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Sep 2025 22:04:49 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	kirill@shutemov.name,
	hughd@google.com,
	mpenttil@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH mm-new v2 2/2] mm/khugepaged: abort collapse scan on guard PTEs
Date: Thu, 18 Sep 2025 13:04:31 +0800
Message-ID: <20250918050431.36855-3-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250918050431.36855-1-lance.yang@linux.dev>
References: <20250918050431.36855-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

Guard PTE markers are installed via MADV_GUARD_INSTALL to create
lightweight guard regions.

Currently, any collapse path (khugepaged or MADV_COLLAPSE) will fail when
encountering such a range.

MADV_COLLAPSE fails deep inside the collapse logic when trying to swap-in
the special marker in __collapse_huge_page_swapin().

hpage_collapse_scan_pmd()
 `- collapse_huge_page()
     `- __collapse_huge_page_swapin() -> fails!

khugepaged's behavior is slightly different due to its max_ptes_swap limit
(default 64). It won't fail as deep, but it will still needlessly scan up
to 64 swap entries before bailing out.

IMHO, we can and should detect this much earlier.

This patch adds a check directly inside the PTE scan loop. If a guard
marker is found, the scan is aborted immediately with SCAN_PTE_NON_PRESENT,
avoiding wasted work.

Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/khugepaged.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 9ed1af2b5c38..70ebfc7c1f3e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1306,6 +1306,16 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 					result = SCAN_PTE_UFFD_WP;
 					goto out_unmap;
 				}
+				/*
+				 * Guard PTE markers are installed by
+				 * MADV_GUARD_INSTALL. Any collapse path must
+				 * not touch them, so abort the scan immediately
+				 * if one is found.
+				 */
+				if (is_guard_pte_marker(pteval)) {
+					result = SCAN_PTE_NON_PRESENT;
+					goto out_unmap;
+				}
 				continue;
 			} else {
 				result = SCAN_EXCEED_SWAP_PTE;
-- 
2.49.0


