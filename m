Return-Path: <linux-kernel+bounces-822054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84249B82EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46DFB4A26A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F95427B339;
	Thu, 18 Sep 2025 05:04:49 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374EA21D3C0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171888; cv=none; b=a43XGbhPkySNPREFvqKiikepii2/mgsDHFYW/rjoLISks8UoDf5znqeNvlwy892IScmTKKo4HN7cqKp4s3nsIz9FUGuaBP1Zpx/wAEvFmGkXG0A9KGYHIFpc3+cBJgpLgAu21VrjhPlfbHLUstBQj+2S+3rRLTFqi08kBYiQ8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171888; c=relaxed/simple;
	bh=aK3MdwjW2lXWQsbk0cMf5dnNfF4C6zN66ifWi95faas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjoUSY9WQ1fcvSwX4MFuRA7d5yw0HUhxoa52LbNY5J44E13MyLAJvwdPGDOoKe2MlSWU+8+b1yOrXUxu3OkQJL0EWjzSormNyKqZ5qBuwS4FoTsJV+RbrcJIGAseUIFobpPzzdn/OrR7s4aYzywac2FGbOBVsJXtVxHWQaxgd6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2313dd86so4131305e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758171885; x=1758776685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aO4ZLiBPFlHh7Ygo8g3PnYlJq/wmpc5eSQsMTQaitaI=;
        b=kLLOr5f0kWQ1Mlf7WdFxeUL2LzS+YJ3N5NOH9e9s22Qu/HfLXlIJnEjwDURg6A1cBY
         z0kGv3PW95nkWI0T0BzmyI+vofkpjgpAJ7YGCD3fnePbZhsvdUTVISKF9M59O4H+oxBn
         UCY9U8TS1FunGDhLLiX1qrHj+OhRCH1HR948bQl6RIohXIHXeR7gRqTPKy19ssc6TwjI
         v/9tlakNQb3I6vjyLTgBcxhdo/js8zLL8yxzJv4SH240bUzEBJ8FEuwjPjZ6i6LyVfqm
         E+xxz/XSqKsYrKbQCYs9AWXgkB0PTuUGi5GcG1hn+X37M59yOgWpCL3HH0v75Y7uCMq+
         uPSw==
X-Forwarded-Encrypted: i=1; AJvYcCWtivs7mkMJfF3Ko3bvHsbR7gEST7AB+dHNwXiPijgDr8uJKtlBDI5wM+EJBnZqgsoyRAeOQYQ+xe67+HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTa8FvcM7P8kuk9fWYSRfMYzF4TuaksA6cXnlr1LVH15PHbm8S
	M76Ji5XiRY1BH3aY+X7dM9wGfPvGnanfY/Dy4oAPQ4C8Z/clm2zeNixO
X-Gm-Gg: ASbGncvGzRUnmCrNn4BDqQdNAj+CX9UxRbPxrf6+cpjsIsqV9Npy3M7i7pRiqOr5X0E
	5LKxw72GJ2t+3AuhEn55u65Qsgajq/FxchaYimr9WLJMZ+7PuX5LE7JSe04IeTIf4zltONNYj3m
	10cuNORL+5xKKp6AHbuFVQY1jzfzmrQ88cpxVjdPennRHKF3szQ/483ScgQObKCnEyd1eOvt+6N
	VtaSKKQ9zwUdoSC5TXuYy7XamRd+00ls4q6cJmz9URUph0YVRt7blv2ijNgME44pejkcJp5Jg7R
	l6EVEMqwf34Oy0uZeNE59cPK8hT72faXnphYJ2P/PzW7ABY3WHCvASto7II7t39aTdcydF6PnpG
	/xug+sivbr8awJNb4LtGvJk+4nkX7qDPlRrg/dA==
X-Google-Smtp-Source: AGHT+IFdC514onBUMagLeO2d/t3qyVfivw2gBfhVFamlNKWcdrfcQDzJVUxOlBsSi0KZGLvniYQVcw==
X-Received: by 2002:a05:6000:26cf:b0:3e7:45c7:828e with SMTP id ffacd0b85a97d-3ecdfa079f7mr4188775f8f.33.1758171885260;
        Wed, 17 Sep 2025 22:04:45 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407aebsm1994409f8f.14.2025.09.17.22.04.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Sep 2025 22:04:45 -0700 (PDT)
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
	Kairui Song <kasong@tencent.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH mm-new v2 1/2] mm: make is_guard_pte_marker() available for hugepage collapse
Date: Thu, 18 Sep 2025 13:04:30 +0800
Message-ID: <20250918050431.36855-2-lance.yang@linux.dev>
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

The hugepage collapsing code needs is_guard_pte_marker() to correctly
handle PTE guard markers. Move the helper to a shared header and expose
it.

While at it, simplify the implementation. The current code is redundant
as it effectively expands to:

  is_swap_pte(pte) &&
  is_pte_marker_entry(...) && // from is_pte_marker()
  is_pte_marker_entry(...)    // from is_guard_swp_entry()

While a modern compiler could likely optimize this away, let's have clean
code and not rely on it.

Cc: Kairui Song <kasong@tencent.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 include/linux/swapops.h | 6 ++++++
 mm/madvise.c            | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 64ea151a7ae3..7475324c7757 100644
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


