Return-Path: <linux-kernel+bounces-887057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73CFC372A9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522E06E08E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AB33358AA;
	Wed,  5 Nov 2025 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzQVUyXg"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E34133BBD7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363809; cv=none; b=I/G9dR0Bl64imhI4qmoaQHc/XFJxnkCJQLo9y4y4ZUhFao8g1fgMIhKcaEe1v3jzqcJjaAq3sdsYBs7x6eWVnysDItu5clTj2UxoRDWFXT7wxzkPGmh7yhlMNRQSDpvBpYm0Thfja+Is79FCyNvA1JpJ1nRt2P/2VmHMixggAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363809; c=relaxed/simple;
	bh=Uu7dpBjXjSMpPZJYtKEgjOA6WR8IM4iTqwL54hJ8Cao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/1bR+CkHmurRPhPbFKox8JHh6ieH9XItCsrTxXzJ+hAIgPiRY05REZgIweIjPp6xsbLSPh2IHSA6woBrnLKWXLn5zPyJ0JaVbyLL2vKmQ8xnKtYM4pjAES+qNMBx73EnawzcIa0CEdlGDwNI0ptVR8Sfc0IU7m1f3bx+msrqlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzQVUyXg; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c2878bdf27so3927711a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762363806; x=1762968606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECvbQOCleXWV41glKff6TwUAo/ctHSkBw2CY6tJdeAU=;
        b=jzQVUyXg4+cc7mSRhVbZ8wATr4zHNSyy72lXaDILEmPgw9oCo5/FYbECtTok490a9e
         JGa3rdYPGArCM0kaHJ2Mt+S7hAJQxK+XWFiVWFGnWNeTRokNXWzvyoqjg1VLmy8uRYTv
         rkvf+hJNYvzKNEwf+dlnkWmUaOBq8+r0J/BWdExNe7Q0MWRQemzw5jrTMjscEmlh7cde
         RWk7JzJTtiR4J+sjQ+5SdkMC5UzyXrMzYkm3SmN+rv7ot5hGw1A+8aHOXjxR4wVay3Om
         lyy/yROD1HpGcj/ZI8u7mGt0BVmJM3GxX0BpqBFiz3RGhof617IujniDrvyLNpDMXvmj
         qwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762363806; x=1762968606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECvbQOCleXWV41glKff6TwUAo/ctHSkBw2CY6tJdeAU=;
        b=RtQvAc1PwgwMeh6YtF7mY7cFUo2neTfQyQlrkkNng2gaFH/tQyuB11myROAqk3VnYM
         M1gi2Tu4cq0F8iBES91SP9kuuQKZ5Ca+rPPDKd2+68WL+7liT/+RdYB/VGSBA/+cSpSn
         3MQRTnCbtyAi7xqxdwsm35zcmmpDO6GXgUhAmPP04AzAYlXgex5s7ser9r+0m66qrVfc
         4Za4BcvVrjcacH6TTIF0Z7NwOUBT6BH02Zqo4zdZBCU4Uw2Ky/v+xQXD4Dad+Em41N0i
         NMXBtgg37ekInptFDfgXPcnaY1gBBFlEgpD4u7yQoOMxNbnShSBokq4a8GnmekiZMvio
         jR5A==
X-Forwarded-Encrypted: i=1; AJvYcCUQCm1lcgp+jf3KoVkj+QG+kmpEJqBYiBwTrLwYhXQt4NeBPB9CalNL0+/5xKwaWDGpo44y+5GdeLLq+Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqdI+3HU/nMi0YyiSJev5ZEGNbImIj45+aYjjgAIYBG9V2lIkp
	9gNhlUUEC40OuYFJQc0E9d+n+aPVrFhj55WyZ75rt2nE9IFvgh23q1MBPgF+/poUOus=
X-Gm-Gg: ASbGncuy8ayVRP9O0yQJODQF8NWASE40GF++JuQazOhJphEppz9kgGhs5c/M4TxwcCL
	svKisBgZozCQ8JfhehHa6B2+aT7NNRV5T5LGDRAy/ghqgwyeKNygjF1GQRrMyV6ZW9uHwV+a/Fg
	jNyQwLzVlilb3I8tGO0q5HmY1oXcVRCwpj7qWS/Zcv8V7V3DlfNA4GxDcbW5SCF3NChn5oEjXZo
	cFuGtbN3jiMHCebk+mBe8WeE1ZHDQOyKs5cInDthx5k4XerNeHX+1dYFPtTDX7iYOHslwDoFlS2
	dGjFwz/7AarUYWVY0/H90t6GI7vjbjMNTH2L/Tehil481NQcF/JVwCkBrvfOEIyD8hgLZ75TOnO
	DzcUkhkjDfQ05ZEVb3wMc7rLtGtAeBUx0qxbRc+rRrp17sx9t+0rV6jblyni1FRy5JZop+NlkGU
	X60kGB0qs8S7ayPPymxosgq110nVZ72NKV863YoDYDRKo9IXDodkQPcK9aN+5wCHOGuu8=
X-Google-Smtp-Source: AGHT+IEEGoBFr8oSk1ZccH795h94yD/tdE3zaD5H9+9COL+gtAHu17GIo7aa9d7OyusPpetKtRbniQ==
X-Received: by 2002:a05:6830:63cb:b0:7c6:a6fd:fcd6 with SMTP id 46e09a7af769-7c6d132f342mr2506695a34.11.1762363806080;
        Wed, 05 Nov 2025 09:30:06 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6c25108b3sm2248313a34.30.2025.11.05.09.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:30:05 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH v3 0/3] ksm: perform a range-walk to jump over holes in break_ksm
Date: Wed,  5 Nov 2025 14:27:53 -0300
Message-ID: <20251105172756.167009-1-pedrodemargomes@gmail.com>
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

v3:
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

Suggested-by: David Hildenbrand <david@redhat.com>
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


