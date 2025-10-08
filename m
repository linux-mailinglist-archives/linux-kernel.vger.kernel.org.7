Return-Path: <linux-kernel+bounces-845036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0817BC3550
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAA9B4F0280
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B8E2BEC2A;
	Wed,  8 Oct 2025 04:40:17 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1A2BE7A3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898416; cv=none; b=XaNF7rFbQ7Xyve8Yq2z91ZUduxbT6vnVuW6dJ4qeLNIHpU53Oz1A2eCBv+Sa4ELyKmVijQZlM2BXdn7vMNc3qJnu+85EN069g3JajwyEmMWYXW274xcj6sVTdsbINUjNQaYlSGYyLqI5ghQ7IEkcCOaHnD/wUYAdbn2Ke+0iZf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898416; c=relaxed/simple;
	bh=bZJyIuTDVmo4Y04op6+VtmrFSedVXRPbJQfkp4IkVjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICF+rgCnbNnnba//EB6IdiP/uDzq6rV5pnVNz09gSnvZ4gSaEknTSwwf1PZn5IYZHK7aKAHYBZLrLjn48yVhXvk2xU2CeuSyomPt2ugGPC8b7A5sNA3kQl9dgTc62bGPMM3ofpF53lHR+HffLeLj99RQryRQhecLij5/PaQBNUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso55736665e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759898413; x=1760503213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgeK9txdpLwb4kWStPacRxPPvf5dOZwITmGfD3OrnjM=;
        b=JlZ/1itq3Ld+B0xQBGArDeW/2eSdlVicsffitmFpAmPij0HvdblEPla14YcyyCRxWe
         VXaxLFHG3qLoA43jW+ZE4DaY2N63ffeUCPftwyUcf/+/4fEVJ5NBXJF+H+12Pxv0DEi0
         8s+ZcTxiG2YlA0IQ75H/mEB57Pp1ViPafCS9tmJIiF5ed9QhvbCajT5cDHBnUeIF4v1s
         PWBIG9b4jgTm9MKJ67nXHLjMOZA39pjoDRWjLAhZymXE4nQ8iZNRZ79EHik16zZNlFTQ
         PYlonZQMEkwBq3IG6d65KFI4Wqtf4B1YyxQEUr22DBqrp9MSi7adRoR6GeNRetUlo/zE
         oyNA==
X-Forwarded-Encrypted: i=1; AJvYcCXWPTrETgg3Q5cUXDJ4CyAOI6dvdqSJ3pRByy/6gtMtjMhDdDZiF36qFpLyWqYishlg3VeNs03lwsheYu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOqKZQb50u7TzTCWcsdZmeGVCwGLrjH8J8+G8SxsPJm9CHYvY
	RGYRZ1mAF8QBonnrWXoepWaMKU8bF/oWfRR+j7AMh2BQd0Jv/zD+Fen+
X-Gm-Gg: ASbGncub15yUtNYv0VSNVHGOyVsCe1aMCrxcYmXbp4YTIV0RmAgl+L0R6lst9HLOh5g
	vzVMUKeG3IYQmVAgdUPC6+Nf6TpDF81Dlmo3hAt3dwocU0hxVYtngWQRFSXyyeyfcd12CHGzo5E
	DvoNcQ7GY/EgfMX0d60FjTaUiatkJs0G0eJOB6NZOLzOaqVvYOTbJzHspXY9BYS5+nKtZejlQeV
	7+GDGKKzqkMA1aMvFKSzLdwArbfwUmipcKRdzfFULgFOFMXkPnxXCZgV7gAztzK6jqKcx0s0Nop
	YKkuRxwoC0GJnczvEs9BP8Yc5PhgYp9VE35zh72Q802Fc9/5SgEIgxEGGpYLEa9NZaIgEGX6Grz
	YdF1YwwjoFZVmeLq3SKpe6T/07P9abxJaG3rju5E=
X-Google-Smtp-Source: AGHT+IFFXobL07i2VJMhEzLhFg05M47YN+wsWxZdEN4xGgG8V0Gor51hRV6tBPzlCpXcq9XDuLQd5g==
X-Received: by 2002:a05:600c:37c9:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-46fa9b1b18emr11613395e9.36.1759898413470;
        Tue, 07 Oct 2025 21:40:13 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::30b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6c49sm28159164f8f.3.2025.10.07.21.40.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Oct 2025 21:40:13 -0700 (PDT)
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
Subject: [PATCH mm-new v3 2/3] mm/khugepaged: use VM_WARN_ON_FOLIO instead of VM_BUG_ON_FOLIO for non-anon folios
Date: Wed,  8 Oct 2025 12:37:47 +0800
Message-ID: <20251008043748.45554-3-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251008043748.45554-1-lance.yang@linux.dev>
References: <20251008043748.45554-1-lance.yang@linux.dev>
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
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/khugepaged.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e3e27223137a..b5c0295c3414 100644
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
@@ -1340,6 +1344,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		folio = page_folio(page);
 
 		if (!folio_test_anon(folio)) {
+			VM_WARN_ON_FOLIO(true, folio);
 			result = SCAN_PAGE_ANON;
 			goto out_unmap;
 		}
-- 
2.49.0


