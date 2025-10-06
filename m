Return-Path: <linux-kernel+bounces-843090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7AFBBE639
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4AB4188F13E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96672D6E4A;
	Mon,  6 Oct 2025 14:46:14 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB22D6623
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761974; cv=none; b=qf7ukwSkpy08B0q0Wxck0N4unAqKS5TMrBvdsddQZOtGWgVOL3aHqkJzM61YNuImhHfUB+HJad5A3tRWu2MUCKjq55A40Wx2tDsIqPLWY3JCXQPBQkhAY2Ak5FW2/hRqvtF+1GX4T0QmRRA05h2CPc8PDu18iZYlAZQhIEWsBPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761974; c=relaxed/simple;
	bh=RJfAISuoRU9pOFHNu5zvP+Dgz5yWVv0xMg9TgeUEa58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7GqcYjiM0L1Gvxo3hEOYMKJNxPFZFQN1FUd5WtUf0wjTju5qbTG7pGMiV0DTejSRqnytpF6KzY2uF/ONTWdLui+XHh8mj29pLkhBD9pNc90obKw4QTT9nLHd8wt0qCJ2CjU4ubGAS+zOwQbZcMf3OnGyrWSJW4+LB0RW8Pz9WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f0308469a4so2851754f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759761970; x=1760366770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=649nZTMG4mv8/3awtUVARgVLbCDTskFROC1ICZKpw3o=;
        b=mGl/dkburwJWPn7ZgGUVNPLOi5e+wZ0Wc3ktsBdhDBTT9d5xScmyst4sCYgeA57MNf
         03nRNu0Xotb8zsh7HNyJiCvRGfy8yGNShylzq3/FmRx7KLVr5JCJ3Fm0a5JGVFY3omWI
         WEzkk6WCIcW9q6pkENnef0lB94GUXrMRvTLRu6USHJILizQLZX7x43AST2OR1CmU0eDq
         O0TnxVedjXOl6OTGD5+wO0ThvO39W53fE7oKzN+yuZ2vLHcWt5D2RAnrj1zNC2LpY6or
         Q3a9Jgl4Xfov4TiZJbRwtbVEqJwmDe4miloE80eDPNGXyzzjHDt8DH21yrHaqKjW7CL5
         iWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkvIZAY8eL/cXX3ladFZoo7P/+ndD0LofGJ8x8zxEeEeH2Qwk1QSsI75sWDyXuU6P8FELQpWaJb0Rhxow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGWOHuI4KMtNa3Fcxj/WFjPckuEJXTm3NIXgLA0aCDkNpLxJBZ
	RqTlQucjSoYUInA8mQO3yxJB9DrdDKBnuEw2N84f8sXG7+HNZGg6xbpT
X-Gm-Gg: ASbGncu1ZlRRGSAlflN0v1ZHDa0qatByByfeQDfIWuW/F0UkZxaSSm05Jz6lOzQSymA
	VOydHkgo8AFeDENohyzIV3TizxINUKKfxtIg55vjo4cwGZHt3NU4IsuVF2Z1FZmlpcr8x6o+Fj0
	3kN0xyfx9CspttH4CALhBjGRPgDWgmCDRo2MZj15NlS1+Z0xS3jtoYk2UfVKcr409qWArFAbyE/
	9XaNS0N7VKhtbTjGKnSM+m9wnMTwoC0y3t9acY3rBMXtlNgRuFFqyAP/W8/8ztBiFQqLn7EazMc
	R9ycbcTeb3pMzuTvm+I61GJobPnuqOy9ssgCdTydtjlsv0McA2UtEKEFKm++PWa8muNsemnifU4
	cCtNAfDC9XDTrNFWeMTjHW3WDloVccEdzJ5CU1yYGb1rTl3pkcw==
X-Google-Smtp-Source: AGHT+IHsvo1NFjf4HpsLiEoWsR+LDPyy+zHQNwaRaqIbmEz4o2SjKSjK/jE9Hcm/iL4OkfOeqSHQKw==
X-Received: by 2002:a05:6000:186f:b0:3e7:6104:35a8 with SMTP id ffacd0b85a97d-425671c0deemr8140370f8f.35.1759761969743;
        Mon, 06 Oct 2025 07:46:09 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8b0sm21242624f8f.18.2025.10.06.07.46.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Oct 2025 07:46:09 -0700 (PDT)
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
	richard.weiyang@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH mm-new v2 2/3] mm/khugepaged: use VM_WARN_ON_FOLIO instead of VM_BUG_ON_FOLIO for non-anon folios
Date: Mon,  6 Oct 2025 22:43:37 +0800
Message-ID: <20251006144338.96519-3-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251006144338.96519-1-lance.yang@linux.dev>
References: <20251006144338.96519-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

As Zi pointed out, we should avoid crashing the kernel for conditions
that can be handled gracefully. Encountering a non-anonymous folio in an
anonymous VMA is a bug, but a warning is sufficient.

This patch changes the VM_BUG_ON_FOLIO(!folio_test_anon(folio)) to a
VM_WARN_ON_FOLIO() in both __collapse_huge_page_isolate() and
hpage_collapse_scan_pmd(), and then aborts the scan with SCAN_PAGE_ANON.

Making more of the scanning logic common between hpage_collapse_scan_pmd()
and __collapse_huge_page_isolate(), as suggested by Dev.

Suggested-by: Dev Jain <dev.jain@arm.com>
Suggested-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/khugepaged.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 808523f92c7b..87a8df90b3a6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -573,7 +573,11 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		}
 
 		folio = page_folio(page);
-		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
+		if (!folio_test_anon(folio)) {
+			VM_WARN_ON_FOLIO(true, folio);
+			result = SCAN_PAGE_ANON;
+			goto out;
+		}
 
 		/* See hpage_collapse_scan_pmd(). */
 		if (folio_maybe_mapped_shared(folio)) {
@@ -1335,6 +1339,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		folio = page_folio(page);
 
 		if (!folio_test_anon(folio)) {
+			VM_WARN_ON_FOLIO(true, folio);
 			result = SCAN_PAGE_ANON;
 			goto out_unmap;
 		}
-- 
2.49.0


