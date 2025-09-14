Return-Path: <linux-kernel+bounces-815682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA5B569C5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C12117AC4F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B8B202C46;
	Sun, 14 Sep 2025 14:38:22 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC21EB5D6
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757860702; cv=none; b=qVQgih2f7nq/1ln1g7mpP18DGIgEkyt4id3Pdq7tBYo08T8sRSvTSuM6o4Y4y/B45Y84Wr6g4bSGw38zLf1yvaSjsgOfCavqehzlWdPvQVhpMimBI+uQphghsFthy3ZB0PTjCpHoDV+hXmz5CdrpgHtNPXY3fuZeV3b29Qpr/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757860702; c=relaxed/simple;
	bh=J9cLNsJfyur8O+nkDKHmFCE1YE+4wOO3Ei/ieq0Ccn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXST7SwjC2xdQRiP6RseJp21PdlDe+e+8WlHG0Z8m7fLYa3ttdwYdAl8nemf+beG2phPVPTDJMiLwJzq2wOaEFulvUoSjp1bly06JcJQL3fGS56hCwtwB+NBKsyGJIoBrGW8n5fx6RKlgHv3q6R1G/lYS3cAOnRKO/yfsOK7jVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so2302910a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757860700; x=1758465500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9wU/W+z4HWlBo+SMsLu49fjjkbDPftXMJWXc0qCbjY=;
        b=r5fLREjk5rKSu1idNaDohsPD7nKF+oWZbqoU+Ci0CSnCBtirXFbJdxJn4HVjsqztri
         NpVIkrAmW/8BV0fNtfBN8X6nWk19TxAK4j0ZwxYZuEzhclMXoq4h1Mv3bEJ0ksq6zGkk
         3VV3Q/14XqzzF7YfeXjMT6Fd7ttTTjndAnd7TtItFC+UMc8YVI+MdQPJY119+XEA7i4I
         rCCojqAZxW9TWlDTtMEpHkUL6xkZIuaNkrdL93BP2AmxNeEbzkH/CF39k6RvkQ1Uo8Lp
         emYcaG5TnDWz7rVG76ryV4kxRi+r3nwyJmtvy50r1zovatBRVfEux/q/NcVJfW9RFJBo
         B2Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUZAcv+iIRuff+8zGOM9q9cBH9DboUBDb33YnxtdZvyxZGxhW/bNM4kHEN+Ib6xCGWCbEp3jD7lhM5XbK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW02d3/Ftw5RAvfNPniVtw+G5YXCYXSHqVpMRbwkrMrb8tc/nk
	QZXd3Rla8YfTEmGv3RmUD0TjFgxNW7ZUNOn94hQxqF35Kj3MZ8D6FO1/
X-Gm-Gg: ASbGncvIoJm2W/YWvuK0T4/Mhfa/8b60rFGAq+3naTCETDcAO35R+YD+lMmgvs0oKqC
	tpIytQqgwAQ4U7N8W01bASPi2XmX2568O9Xt6VHexjasDXJLykDGKb4bVUBz1bSWWvyaSCH9zwZ
	v4I+RUP44gt/RgWSlR8CR7uIyuQenNUOOCGE8kd3VrNLnXXK5tdeal4YjMnkqc4azv9OOgv6ikw
	P0RzzA+87FFtgv5ldIv/kIBOFGN3PGHd73V0cFUPSw3PU5/4pCQgWyeAcnzINRq6QOSJbZBbVzj
	0arskD84+v3d/bNPQB+H6HRACjRbCffVkEMIHYvaom4igjEt0923TOAw9kn73UNsrlO+ZKaUog3
	TDuUiXWOZ7i8KOdhGTVcqyA==
X-Google-Smtp-Source: AGHT+IFE+Wpu/pBUtNagskZ5QY9uGCvmN51O/TiqoKWmlQZLPEx1SxIwpA5S3oFgwluS1EavPOZLkg==
X-Received: by 2002:a17:902:ebc2:b0:24b:25f:5f7f with SMTP id d9443c01a7336-25d2801094emr94123065ad.60.1757860699829;
        Sun, 14 Sep 2025 07:38:19 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::10b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm102571545ad.123.2025.09.14.07.38.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Sep 2025 07:38:19 -0700 (PDT)
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
	Kairui Song <kasong@tencent.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH mm-new 2/3] mm: clean up and expose is_guard_pte_marker()
Date: Sun, 14 Sep 2025 22:35:46 +0800
Message-ID: <20250914143547.27687-3-lance.yang@linux.dev>
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

is_guard_pte_marker() performs a redundant check because it calls both
is_pte_marker() and is_guard_swp_entry(), both of which internally check
for a PTE marker.

is_guard_pte_marker()
 |- is_pte_marker()
 |   `- is_pte_marker_entry()  // First check
 `- is_guard_swp_entry()
     `- is_pte_marker_entry()  // Second, redundant check

While a modern compiler could likely optimize this away, let's have clean
code and not rely on it ;)

Also, make it available for hugepage collapsing code.

Cc: Kairui Song <kasong@tencent.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 include/linux/swapops.h | 6 ++++++
 mm/madvise.c            | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 59c5889a4d54..7f5684fa043b 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -469,6 +469,12 @@ static inline int is_guard_swp_entry(swp_entry_t entry)
 		(pte_marker_get(entry) & PTE_MARKER_GUARD);
 }
 
+static inline bool is_guard_pte_marker(pte_t ptent)
+{
+	return is_swap_pte(ptent) &&
+	       is_guard_swp_entry(pte_to_swp_entry(ptent));
+}
+
 /*
  * This is a special version to check pte_none() just to cover the case when
  * the pte is a pte marker.  It existed because in many cases the pte marker
diff --git a/mm/madvise.c b/mm/madvise.c
index 35ed4ab0d7c5..bd46e6788fac 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1069,12 +1069,6 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
 	return !(vma->vm_flags & disallowed);
 }
 
-static bool is_guard_pte_marker(pte_t ptent)
-{
-	return is_pte_marker(ptent) &&
-		is_guard_swp_entry(pte_to_swp_entry(ptent));
-}
-
 static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
 				   unsigned long next, struct mm_walk *walk)
 {
-- 
2.49.0


