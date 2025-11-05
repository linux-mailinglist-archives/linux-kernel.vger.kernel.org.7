Return-Path: <linux-kernel+bounces-887147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EADC37640
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28233B9958
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E493431B113;
	Wed,  5 Nov 2025 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA+d8Vy7"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929CF31353C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368701; cv=none; b=CWKUm7lMmix9c6c9U7t3SqzXO2FQt1CqHdMHT29hOAl+5vBKK/AfciAVL7moF6ev65rM7DBOzW9UV9870/lXJyud1jCmIVlEKHjnVztJu3Wbtl5vquZK9sdirwgXBb68wYm6D6Ll2iKsZJPcNFv1nyHa2tr2eovX0bCcC6E+BZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368701; c=relaxed/simple;
	bh=L3DkX6Lg46Z42WFYbp+UMajS5k67tLiRkxotX/2lXE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBDPm3rkKWkrEeJYb+PZ18GKwqyW+m1VrBP5/O7qqxHke75d4hAXf0CEPY1l7D4wYhloTTkk6FTwvvhFwMt3WEQZQZy37wxtzELfQpdPZ7VtxxMq8GL7TPdIXCu6oTSu5FaJtI8XxIMIJH7mz4Gi/z6VxF8iMIAyFxnw2QEA6go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA+d8Vy7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aab7623f42so228533b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762368698; x=1762973498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLlMdw1Nm+C7REWuktjxD0DSS7TOxd5dWldBw0pjFb4=;
        b=UA+d8Vy76vuXmX1ESn4rsmmxmKYCoMCFRvu7rM02yLxr/0CEBGC9hQb88BshB1bZj0
         tSR7Nu4GLyNiUO+36yGn65Be/EukUcS4Y8k+of6NYNT2xpMjlDKx+HOchvayf5YYibe9
         MGsqTHWBTm9A/QoXACk1loNbbC6zjvoyuWtGO+y4t+wlExulk78wHhMb9Isy0wv9Dabj
         RaRrT1WTktAyxZ5GqnsJsKxn0aDuKIaGRr34c3tMBe6+Xafz1TYUXo9LnVhgfyBirDud
         lpMAx4yos6c3FbaaFkfGGoXv4HlCWyufWzh+q0ZkLaH798GD15rr2M9HUI/49gwoTDrw
         Q7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762368698; x=1762973498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLlMdw1Nm+C7REWuktjxD0DSS7TOxd5dWldBw0pjFb4=;
        b=VtLuqSeJJNEXyoiqqqfbUJy16ELYrALYRhFctrbqoga+26z2C1evCzt/O0a3FxWx9y
         f7RG3LQPtdIn2ah6noDtIVBgBnSBwb/hQQVBTNi7YLKhfk6DVnSliecXgMBoGy7HizWD
         nNSCHyEH5jzKvpQvkKi9WZlGD73gkeZ3St9J4S7fbpKGWYykKk59JMkVnL8bAVG7Eajq
         Xurxsdz7iJpiObZSbPAzr79NH9FRMLWHb3Yr0EGn9h6B9L7QRKfS0TXSTx0adJ++VtKU
         v11JHd+RFoTFFoxqTiWsWwIK1ZLYH/DsWkHUIoG8ji601c3xxUuMUYyOf2xPcNiJn+ek
         C11Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZCO2erBXmmgCBaXwhXQ9Aa9wRgr8LqHsACrbnFDJnuFEqwAfh5GLdaa8tyUC1TDw5HbboBXZgJstvCbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymjmSz5fJdap2stW929FfvcO6AVEzCjf3gleNjFw98r6wGQoG2
	nxdCNiDfy+GFrLqWrL6DWwnGqRxt8HIEPQ08b/FLRSoyQS1f0UEFM8sM
X-Gm-Gg: ASbGncthjMXOWEj131pvbi/WJmORbyh/Cv625BiPLxzpNFhMGql5J2QlydEZbzEqrL+
	lCgDKt6k/+asrNxh11FjF1Yva4CubQsmLnelPdroNaH0TvK6f0vYGy+eFlyIiIu73TugFZ26Zz5
	Rp5qoIYYztw79Vmky6zJ6YQ0+iy4I95X1DeudzGufrb/28oCkN7U3Qyo2YWAep4YtjPFncjScGf
	v1YYEhFAiwwkLf/Dvk5eeCtxxdQxa+vBKxtxTy2URR6rCjnj1JKnef+DGYbQcc8W1JyQQ4bZ8tB
	xUsubdzlbT79u4BEIRUdOXKQjzKlk6PohcI8oiHrC7rf8+oQhrAF4c+Wo3ZcdGNCr1t5k/VFhgR
	oO1xpGcQZS4T0P1N9pCsnOdxClwmUY6r4gcTb5ihebYbAdXvRLonebP4KhGiksvl4zdcOLcx7hm
	XP1j3kI0qZ4ukLMdqkGdeWyce6+kz+q48YyBsTh47kYGfyZ9429x45oXaT
X-Google-Smtp-Source: AGHT+IHk3g1K5XoxvDuiQoNx+Td8bjnuXSjXPO5+IwUUPwS057rA+90Avur6GhqGIhH2gjTmcX2sUA==
X-Received: by 2002:a05:6a00:98f:b0:7ad:1e4:bef0 with SMTP id d2e1a72fcca58-7ae1cd59fe0mr5182720b3a.4.1762368698462;
        Wed, 05 Nov 2025 10:51:38 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af827effebsm118409b3a.57.2025.11.05.10.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:51:38 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	David Hildenbrand <david@kernel.org>
Subject: [PATCH v4 0/3] ksm: perform a range-walk to jump over holes in break_ksm
Date: Wed,  5 Nov 2025 15:49:09 -0300
Message-ID: <20251105184912.186329-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When unmerging an address range, unmerge_ksm_pages function walks every
page address in the specified range to locate ksm pages. This becomes
highly inefficient when scanning large virtual memory areas that contain
mostly unmapped regions, causing the process to get blocked for several
minutes.

This patch makes break_ksm, function called by unmerge_ksm_pages for
every page in an address range, perform a range walk, allowing it to skip
over entire unmapped holes in a VMA, avoiding unnecessary lookups.

As pointed by David Hildenbrand in [1], unmerge_ksm_pages() is called
from:

* ksm_madvise() through madvise(MADV_UNMERGEABLE). There are not a lot
of users of that function.

* __ksm_del_vma() through ksm_del_vmas(). Effectively called when
disabling KSM for a process either through the sysctl or from s390x gmap
code when enabling storage keys for a VM.

Consider the following test program which creates a 32 TiB mapping in
the virtual address space but only populates a single page:

#include <unistd.h>
#include <stdio.h>
#include <sys/mman.h>

/* 32 TiB */
const size_t size = 32ul * 1024 * 1024 * 1024 * 1024;

int main() {
        char *area = mmap(NULL, size, PROT_READ | PROT_WRITE,
                          MAP_NORESERVE | MAP_PRIVATE | MAP_ANON, -1, 0);

        if (area == MAP_FAILED) {
                perror("mmap() failed\n");
                return -1;
        }

        /* Populate a single page such that we get an anon_vma. */
        *area = 0;

        /* Enable KSM. */
        madvise(area, size, MADV_MERGEABLE);
        madvise(area, size, MADV_UNMERGEABLE);
        return 0;
}


Without this patch, this program takes 9 minutes to finish, while with
this patch it finishes in less then 5 seconds.

[1] https://lore.kernel.org/linux-mm/e0886fdf-d198-4130-bd9a-be276c59da37@redhat.com/

Changelog:

v4:
  - Fix few nits

v3: https://lore.kernel.org/all/20251105172756.167009-1-pedrodemargomes@gmail.com/
  - Remove leftover code from previous version
  - Call is_ksm_zero_pte() only if the folio is present
  - Rename variable ret to found in first patch

v2: https://lore.kernel.org/all/20251031174625.127417-1-pedrodemargomes@gmail.com/
  - Use folios in break_ksm_pmd_entry
  - Pass address pointer to walk_page_range_vma private parameter
    instead of struct break_ksm_arg
  - Do not unnecessarily initialize start_ptep
  - Order local variable declarations from longest to shortest line
  - Improve patch 2 description (do not reference the cover letter)
  - Quite a few styling fixes and improvements as suggested by reviewer

v1: https://lore.kernel.org/all/20251028131945.26445-1-pedrodemargomes@gmail.com/

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>

Pedro Demarchi Gomes (3):
  Revert "mm/ksm: convert break_ksm() from walk_page_range_vma() to
    folio_walk"
  ksm: perform a range-walk in break_ksm
  ksm: replace function unmerge_ksm_pages with break_ksm

 mm/ksm.c | 137 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 82 insertions(+), 55 deletions(-)

-- 
2.43.0


