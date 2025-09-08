Return-Path: <linux-kernel+bounces-805381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B599FB487D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670907AF3EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A15D27F4F5;
	Mon,  8 Sep 2025 09:07:56 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB651E1E1E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322476; cv=none; b=jpqteXlSUIkKZFfD7qkVUCgMT2bsxqeHtXRwbg4fu6rpEVJTSakteMq42BCR1sasvnewEWxrlpIRtet+R/hsBSiZZXcb67Xw+kc0+EJO+Dca+ftQecnrioxnmRNeOwOOmMxbydi5YuKTzEaFMr2bWwtaE/kdRvcwpu9lhaYeAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322476; c=relaxed/simple;
	bh=cAcZhiuvo89v2qlhvhHCDxV6eb7Nq94XloQp0Hmgv6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJ7x4hK6/7jlVgsHyctTsDeMt7vD/w55JN4/5c4Qer5wdUvlG16DzalOjjQgU0ubDxvUX5BVjoNFQnbeAWnqyi+teUoB6ZHxb3x89OOBq8aUPhC35i6eb1ZbOj3zDI0DP8vFvAvH3bEY841vs+5uq2lIQcHr7uu76rX565t7B1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso35050495e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757322472; x=1757927272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ePUuqfJLoDiY7BpIFN/k/UJrFka4KzF3ZCmiecQuNA=;
        b=LzgiqIUxwADABMQRP6CtBV7+7fY0RhY1FyOwrA8vAaBKIK3z4v3LFGqIIS0O3WLkOt
         i6bmSvrqU/Iy6yZnBHnSn3wuju8EunuX/7VHPbtmySac+y+FLjH7ucnt0IAqI9vDVsRI
         Q3rmiU41DsP2IewmrgXdgsFtcTpsjMwPAcqLnVMdlbg7CqE3VHFglfY7e3ctKw2UmMDy
         xqKZf3NByGosy+XHd/B2YLuaQ9WvM8xWb8NXKDw+Th33g1YevUqLUe4c9t46JQ+1EER7
         2HRVq3FifEMBmYWDhVF1QJdzIWlOzJBavZOEwX6/HRxI1U5KqxnJaXcMMDlMLDKdTXwE
         z36w==
X-Forwarded-Encrypted: i=1; AJvYcCXvwDZ53kxqOqogttZugldSIUxcemnAHGe2C+kv+Y9P17znh6rRxa8bzgkXbF+d/auPyScINfeEixeQ9ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7GZLhpvwck9K9Gwc+ksE4wduRiMs1xYmRjGRvNZVr33zjHzLR
	GoxkCsIHApkVS1C58CLzgdevHb1chgWCALrB4frEQ2w7FaRR4a+8GaQI
X-Gm-Gg: ASbGncvJsVDZ+wfyfmVyGiBwVyfuoxr/zOGEatOKAanTTTBKCZsvbrsondJ/m10Mgmv
	ULTenijgFX7sA4I1RSt8veV4i+/LEuE4zcbFsnz7FUK7YQBGhLYn0IPBn+105qWQE+Jm49GWe6A
	rer6b6T24RNHlASmAAdBSumf4vlDh5vEE2U2C/VvElcVJcwBMN6f1EE4exWvIa1V+9INg1L6KW5
	0zmwMdpWVbGZUA2qbyPibVvK3Hbbd0yyg3Y5dYW8CXYuDjboszvq2M39QptZLOs3Rf2tWKLQ454
	swRMqaUMwWiz+KJSnIpgmth9aRH12fIBeSPamEGBjWa06tXYW2ARfyZ13DjWJkMiIgqFC1OXJYF
	dFBt8B9089+q7ELHwD8W4CA6koLA=
X-Google-Smtp-Source: AGHT+IH0+ICOxefFaTyrK8j/rqO0fXTDvCT4zajhIOcL46RN1YgcDsvxFgZ4MmXhn4WtQbMKXhOCLA==
X-Received: by 2002:a05:600c:4711:b0:45b:4282:7b60 with SMTP id 5b1f17b1804b1-45dddf01a4fmr50850205e9.34.1757322472311;
        Mon, 08 Sep 2025 02:07:52 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a04:6f00:1::ee:b:1086])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e543e9f444sm9075487f8f.60.2025.09.08.02.07.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Sep 2025 02:07:52 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: Liam.Howlett@oracle.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	dev.jain@arm.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	usamaarif642@gmail.com,
	ziy@nvidia.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v2 1/1] mm: skip mlocked THPs that are underused early in deferred_split_scan()
Date: Mon,  8 Sep 2025 17:07:41 +0800
Message-ID: <20250908090741.61519-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When we stumble over a fully-mapped mlocked THP in the deferred shrinker,
it does not make sense to try to detect whether it is underused, because
try_to_map_unused_to_zeropage(), called while splitting the folio, will not
actually replace any zeroed pages by the shared zeropage.

Splitting the folio in that case does not make any sense, so let's not even
scan to check if the folio is underused.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v1 -> v2:
 - Update subject and changelog (per David, thanks!)
 - https://lore.kernel.org/linux-mm/20250908040713.42960-1-lance.yang@linux.dev

 mm/huge_memory.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 77f0c3417973..6d99893c18e8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4183,6 +4183,13 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		bool underused = false;
 
 		if (!folio_test_partially_mapped(folio)) {
+			/*
+			 * See try_to_map_unused_to_zeropage(): we cannot
+			 * optimize zero-filled pages after splitting an
+			 * mlocked folio.
+			 */
+			if (folio_test_mlocked(folio))
+				goto next;
 			underused = thp_underused(folio);
 			if (!underused)
 				goto next;
-- 
2.49.0


