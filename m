Return-Path: <linux-kernel+bounces-830287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B02B994DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C717B4533
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F052DC322;
	Wed, 24 Sep 2025 10:02:24 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6400B27F732
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708144; cv=none; b=RGnf3Z8jKnttn+xVLzf0RqAaEpURea/tBY7kZ0byruqtgojkUecWSGPeTL8I/BmaFhgYan2c+m+1vyK4iK/sDLX2MADuLT6L4aJ0czvItzrolJiCn6ayyyALXoPnY8CwzYnrfMn99zcDtkaRHvQk0XexGROAoDicqLQaBjVC4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708144; c=relaxed/simple;
	bh=83BpRuEu9VYzYn04YMIZy0zO8wRBWfxhfKGlb4R5HFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7BSWFkKG9DT7TeuHDGsD+4lhCVlbxo+fCb254IsV/G4xsr7WryG+ilHxOqNJ9siAw69gLOJWPlk5OxA0v9GAJ7UMRc9n+OuFnVcSOIenvs8rHXmjXqqy/UMIqrbh2R0UYwfXyX21YJePEwqp7PZ9WdSNHD5+PYGih7npO5RXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45ed646b656so57355155e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708137; x=1759312937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wfld7yM35iF4eykosNij+4fQzpSY4Hz4bM+X89HdJE=;
        b=LVB3E9kX8S9J04awWDHMVBMm0hL5VuDkTRjPbpAbi3TlJ3uLP/SKzoiDeu6NUo76ms
         oRyUP6GNT047wYEoRCG3Rq1jjGthY5+4Kh9jIqvdnVjiCyq0vE/VyzbkptzyT23isPyv
         mBU2fR0CedHUtlBsGZ8P0LfIS5ltP1N+JmBsTJVnXvqnNH4HRcksO3+wC2bI4/aDTjXY
         mipcp2No9Dic0ZP3pB/Vtgs87CZ1Qh3foXMOtWO/us/mf99+CO2n3ZQjXyDPskHLc61j
         FTuh3+T/acbarDmceBDV0JpbANppsK5iJl2ncPpoyOmy48Znt3wT9/2Apm6IUJlG0A1K
         2UVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH+UQhRFI65DjVn/izawyNaccTEBQNRyB+Pwv6Q3TfbqY6JwPbwTAoDFRwyIQF64U6Qf44u/8/dz7hfdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbt/a2xoe+cOIT8npTFqgryWNctlJSt/9DGg1UBtCwrVrc4YQw
	S8xwhKCH2wnQY8xeO/R5tqItfW5zQix2ck0SNq/oAPLVTBNLNKVvw7oY
X-Gm-Gg: ASbGnct5+wQPEtmkTPh5g1zd+U9qxP7a2Em28PNGLE6GqzPeVJoWewW81/Tmdewp67h
	Bo1ktbKL6GMn8h3Pxv3b3qatuS1IUhjLMFY59Lbs0tzrowYpZxEhn3/Y7pRnkXM1tEwvaAsez+v
	1r2lJ/o6huKLe8ENS+saOd90OJPzCCprInooqCywagkI5HLYD6B97h5Mtcdc8zRn0a02YHq+F9f
	Lqbw9k4YfajUiHeuDhdYfD01D+hKl7jgz/k3Z7Uj1IK5mC4eie79WsKgfsvVyTsgUaI1k8qxOES
	RWF0PIAfNYdHfWfHXjLZM893qOi3M0dKbjxnUwkoben+tl4Cpm1LiYb14CXooc9fpApbOgGNb5n
	XQLRhKtTy
X-Google-Smtp-Source: AGHT+IG0l9FwrHr2FXigUei1Z73tk2/AIuntnaq3hCJrBsDnPmHcKwjEZkFDPT2mKtWHyzEy/pQ/qA==
X-Received: by 2002:a05:600c:620e:b0:46d:27b7:e7ff with SMTP id 5b1f17b1804b1-46e1dacaa19mr54634455e9.36.1758708136399;
        Wed, 24 Sep 2025 03:02:16 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2aae3d58sm27644895e9.21.2025.09.24.03.02.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Sep 2025 03:02:16 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	dev.jain@arm.com,
	hughd@google.com,
	ioworker0@gmail.com,
	kirill@shutemov.name,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mpenttil@redhat.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	richard.weiyang@gmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH mm-new 1/1] mm/khugepaged: abort collapse scan on non-swap entries
Date: Wed, 24 Sep 2025 18:02:07 +0800
Message-ID: <20250924100207.28332-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

The existing check in hpage_collapse_scan_pmd() is specific to uffd-wp
markers. Other special markers (e.g., GUARD, POISONED) would not be caught
early, leading to failures deeper in the swap-in logic.

hpage_collapse_scan_pmd()
 `- collapse_huge_page()
     `- __collapse_huge_page_swapin() -> fails!

As David suggested[1], this patch skips any such non-swap entries early.
If a special marker is found, the scan is aborted immediately with the
SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
work.

[1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com
[2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/khugepaged.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7ab2d1a42df3..e9778e7734b5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1285,16 +1285,19 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
 		if (is_swap_pte(pteval)) {
+			swp_entry_t swp = pte_to_swp_entry(pteval);
 			++unmapped;
 			if (!cc->is_khugepaged ||
 			    unmapped <= khugepaged_max_ptes_swap) {
 				/*
-				 * Always be strict with uffd-wp
-				 * enabled swap entries.  Please see
-				 * comment below for pte_uffd_wp().
+				 * Always be strict with PTE markers, which are
+				 * special non-swap entries (e.g., for UFFD_WP,
+				 * POISONED, GUARD). We cannot collapse over
+				 * them, so just abort the scan here.
 				 */
-				if (pte_swp_uffd_wp_any(pteval)) {
-					result = SCAN_PTE_UFFD_WP;
+				if (is_pte_marker_entry(swp) &&
+				    pte_marker_get(swp)) {
+					result = SCAN_PTE_NON_PRESENT;
 					goto out_unmap;
 				}
 				continue;
-- 
2.49.0


