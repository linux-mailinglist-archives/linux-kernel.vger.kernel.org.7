Return-Path: <linux-kernel+bounces-873817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D86B1C14CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA46F189407D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980573043AF;
	Tue, 28 Oct 2025 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/I4JA3K"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CD833E7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657741; cv=none; b=bkKGFq9+CoRzfEX+VogcpRG1+9P/CmkJQp+sm0V2QaJBNbyJwZ43SBA+9EWD7nBUMyEse3GAV5i0RhTMIdlJrJobcQ+m7tgonRsbe7AypQjkBSR8nrOJFkZfb0u/7ORF9Z+g/mEGGvEg0AjuuAvInjM7Kdnn++Vl+LsYLQ4Xzoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657741; c=relaxed/simple;
	bh=luTreiuSUXRYE2/UD7Wbmv06pFVE3sTKFW0QvSk8U78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DvebGH9/FQHeQq7UzbyyhALe+1SYQ9/gVTmEGRc8EYaAZAQuxxaN/UfvbFXarrgQofcuz86eDGV5azXDQhRXRGnz/dGpXKX/wBmehm0GLdUKouRFEh+BH9KtYXutR0x/+UCwPLe+4tSusss3AYeX4m3lrvy8uytPulCkKRcIfx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/I4JA3K; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29470bc80ceso66748015ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761657739; x=1762262539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jloGoDgioftfqidIFa4cgHHXNxg9uPjhBuXbiium1FA=;
        b=G/I4JA3KmarKATrNrkwCivyAhSqLgSx7UEafVX9VsMmsF4iYdxog/bakZ3oT4WEJ9+
         vmt8mSgL/4yP6DrDZk8sk5PuHjnkbfqvb/hM72+wt6YJoGdTK3ZUuXEooGJSGyJkw+nD
         utR6FxPos3yIlHUZdJLDDQS5tsVcjX378w8C1VcC8uc7Er2kI9QLnvakGRy+jGgy3Gkn
         b7GVWGe8Im2elNQiuWIyJLA1e2wq1nlQ5EpR1WonnhwdgHiUR8aG4G3v9OyPQrZLkhi4
         SJzFpvD2QblfvFVzmEXnUFxOTczwWyLqzdpeYJqgy/D8TA8wG6LF+O9dfXotwvGsVUGd
         Yktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761657739; x=1762262539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jloGoDgioftfqidIFa4cgHHXNxg9uPjhBuXbiium1FA=;
        b=aViRv0gvy8pPu2G+W/gEHbpAeuXkPMPcMdfscEa/L4NDHWAGSIgzy5VYAzSkrAqJK0
         3hVTQ1fu7+bzLZMzxXNfu2wIyJDwAEUFUP+eSYR0pisAaE9Nvudi+UpLxDXb8BiJodtU
         OZE7Nt48a68TzS+8bDJKuxQ3cfCjgDgSs/LDeiqShWn67S9SqM8x0eoknT5GryhQ8Yda
         SHCQQVer6fV9mEq1+6QHES+aoHTtJgF/TVgPIKzk5/3V9Qje5SBd19GqwhEfmtkhGOCG
         frr2TyUO/krk9/P9WMBbjEpKGWfXqyoQzcgzDdqy3UK8aqq6W4m8XCxqcH+70BFbFYH+
         Ewug==
X-Forwarded-Encrypted: i=1; AJvYcCX0+chn0Z7RUlh55jiSGIV4280wJo07UkrtI5x5xvZrN2HlapYUUYJKculaoFceDlhWAUexPPVmt2+SUOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9Sxg5nFu4uPluuWfDXDJLwg1DhRwZmgGKry7DSJWxlibQ5TM
	YIKQWeV6AQGeaCS2Wl6m3upIEL2tPrH0+lau92aIMg2jZgX9tXOn7UmT
X-Gm-Gg: ASbGncvd20+f+ai/WRa+F9DnjTDjgF0QVKGdlIPxZ6D4sDyH/uv+1IGuFPv5001vS8U
	XVjduYYTanV22Yb5CDLfbOSnDtKc2hkkmvDkEwXQ6LGkIqiaj1MKCbeAwMBkraLg4gazvsTU/IF
	m6oLoWGK4K+9jasx99SSqGSxKFUfB5gSM5Fm6hP3ZV4pseHVYexsYO1rikTWgcqYm/KYylllZQr
	hthqgS2RAvBSPUvAmsml9i41GZX8EyBQYXITxDFGnt8uy1S19CF2RTQYy5Ul3HfAip4PolXjNdW
	y6FYzHjMjkXbDbC997LKu7Y0Rvxn3B59F86zt6RowK7avB6na1rvj5dVkMW41+ZFhgMRsDZ5rq9
	c+VZ/Yd/KIdsMGGYhkaGsc1DGCMHiwwsrYNrZHgieWGiago19KrNMeIjQe9J2bWSqKBX1LkdPG2
	8A4+Uf+7x/dRm79bc4psWPIJFR
X-Google-Smtp-Source: AGHT+IGtbW5N87Fdq/kMZmApEC+rTjGEnrvlNdPpTyAZAg8rxqQg14bT0yJjZHg34xR5/QKF3HFBlQ==
X-Received: by 2002:a17:902:c951:b0:274:506d:7fcc with SMTP id d9443c01a7336-294cc686ba7mr37922375ad.6.1761657738427;
        Tue, 28 Oct 2025 06:22:18 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c6eesm117446235ad.42.2025.10.28.06.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:22:17 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH 0/3] ksm: perform a range-walk to jump over holes in break_ksm
Date: Tue, 28 Oct 2025 10:19:42 -0300
Message-ID: <20251028131945.26445-1-pedrodemargomes@gmail.com>
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

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>

Pedro Demarchi Gomes (3):
  Revert "mm/ksm: convert break_ksm() from walk_page_range_vma() to
    folio_walk"
  ksm: perform a range-walk in break_ksm
  ksm: replace function unmerge_ksm_pages with break_ksm

 mm/ksm.c | 142 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 88 insertions(+), 54 deletions(-)

-- 
2.43.0


