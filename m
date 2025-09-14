Return-Path: <linux-kernel+bounces-815683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8062B569C6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB0117C93F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DF7214801;
	Sun, 14 Sep 2025 14:38:31 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C81A9F89
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757860710; cv=none; b=M4GEHaRX8/Tbp29OCU3ikqIeC3MOJNes+yzVkAatm0KrNzJIhkGuHg8WtvlC71b6DE9GwxFLt9ADiX7ot7nN5SYPMgaTizz02Auu4RzpsEcN6dFKoaLdDFrA2JY/zMOwq0IuAD3/Gc5t3p6dG+PVj9YGu77dMz7jx4x3If+Vrak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757860710; c=relaxed/simple;
	bh=zv7We02h/KKRbkff89BRUsvl3zXnqLWsAVan1S6PaHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQ5xrXVgYWcyK3hu1oY9gOwYJJ9b5cKYDEntT+HJrd52TNOoWsEPNU5v2i/20FTgDVgFqUAdOFImkS0FaOu9T1d3ObmNBGcNVuCBBsDpRZ3RGAZ0nPsT+0CKEB0tQq9mtzNx66MFo8cUwrsx2LMVBPsXGEYMJH5pUxCnUrx8Pn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54b301d621so1731039a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757860708; x=1758465508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2AnnhYLx0XSVDCP/fVtCwfPUWPDTutSyX5MbFNBOkk=;
        b=fGeJgFgbb0xPcLviQysykkZvnCCsUTBrLr5Y+IiFmDJ3gfmk0anwodJLJ3ZTj2z19Z
         f8r85gcTtoBLKJOLooPfhz8ltfe9PpLisjQhymFrLuZjwgZGKf4s0LCHK9++6ekE8s0w
         xkyZxSvsPoyITn/6rMGbg+JI4hmJtz2Ms6/KqmlT53kpzIU/oXJqmKSxd0jo783oDuAk
         jQOsGtwgBNSUUMerVDkWRgji3vPGDu6MEPEf8ixHIXeorEwGEdtV/wZaAEJ2w8bGhiPM
         5UQzSv1AlTMjcvnsJNKq/mw00IO5CsNE2aQgGVOpIRaOElZ1WHmXTz2vbjhFEbS2Uq6F
         Gs5w==
X-Forwarded-Encrypted: i=1; AJvYcCWk+lCeJ2IQ/xMfOJ7nS6Amd5iigtTOe9Z2lF7YdtD9+cmi8iNhseVS4w1uNtqZQ8X3tH5jjoIoE7EshPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYX+bbSfREbq2ZrgPIi4A8jfuFNk/w/bvLFWsJ8vdtasjiVqg0
	qmNxiHAwH2372aIHMeihDkk+iLe7o0Dr1kwhhk82QsSjVpP8Qj1qw84Z
X-Gm-Gg: ASbGncu/Q8VnfEL/sAtZJ86nEywT7Th2If4F7+ZMTtb4ztzj5CXan6ASjB3gqeM1NPg
	PuRuM1Fo/FQW5Nj30gvx5W8y/NRYAnewYpCIZbODystgfTX0EKJhXJe89vQImKxbG+y8tu91I2v
	W3OkwuYiOMca/+BhRHkXr36+B+y655VNzZDriT56psmTB0YhlLSAOK7+cNGEagICZ9u5fTbgRZ7
	gVnqgO+goM6blFb6xLZDbsepex1JaxvdOFVKH3P+D0dI1MgsiKqUJUL7YkV0JxR0Yt6k+zIKG97
	KBaKrgHL1AKw30EU8gEZBiXuaKV0v3cTx4Lr8Pgi/Na7w7tGrVOTJl7JXQESS0WKr0u5TCNhtvR
	gGP/BuSpRh6dfg/mYaBAJ3g==
X-Google-Smtp-Source: AGHT+IHWR0yW8e7MCVl+UueUYkz+wRrSuXYr4ZxuaiJD4QlW4H6iqFSdA9O7vMH9cF9eM58m3+6pFQ==
X-Received: by 2002:a17:903:ace:b0:24f:dbe7:73a2 with SMTP id d9443c01a7336-25d27623c65mr118373835ad.31.1757860708231;
        Sun, 14 Sep 2025 07:38:28 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::10b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm102571545ad.123.2025.09.14.07.38.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Sep 2025 07:38:27 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH mm-new 3/3] mm/khugepaged: abort collapse scan on guard PTEs
Date: Sun, 14 Sep 2025 22:35:47 +0800
Message-ID: <20250914143547.27687-4-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250914143547.27687-1-lance.yang@linux.dev>
References: <20250914143547.27687-1-lance.yang@linux.dev>
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

IMHO, we can and should detect this much earlier ;)

This patch adds a check directly inside the PTE scan loop. If a guard
marker is found, the scan is aborted immediately with a new SCAN_PTE_GUARD
status, avoiding wasted work.

Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/khugepaged.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e54f99bb0b57..910a6f2ec8a9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -59,6 +59,7 @@ enum scan_result {
 	SCAN_STORE_FAILED,
 	SCAN_COPY_MC,
 	SCAN_PAGE_FILLED,
+	SCAN_PTE_GUARD,
 };
 
 #define CREATE_TRACE_POINTS
@@ -1317,6 +1318,16 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
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
+					result = SCAN_PTE_GUARD;
+					goto out_unmap;
+				}
 				continue;
 			} else {
 				result = SCAN_EXCEED_SWAP_PTE;
@@ -2860,6 +2871,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 		case SCAN_PAGE_COMPOUND:
 		case SCAN_PAGE_LRU:
 		case SCAN_DEL_PAGE_LRU:
+		case SCAN_PTE_GUARD:
 			last_fail = result;
 			break;
 		default:
-- 
2.49.0


