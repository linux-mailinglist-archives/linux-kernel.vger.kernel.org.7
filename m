Return-Path: <linux-kernel+bounces-880757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C24C267AF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055C71898853
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2772FF15A;
	Fri, 31 Oct 2025 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoLnUxrn"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E42F6581
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932914; cv=none; b=SJciplO6tr+3rGj4voD10X+Ye6yFyKvpNGSscZFPy3t14P4XkoM3EqFdY8Ajzrki05IAN2qTjTmAHDEGrH4f9u23fPY8o45LK9n2mBaWtNliD61g5G87aMa1kFPpLWj3dmI25l58+8qTiIiu8/QOoKf4p6Vydvx0NfX2cUXYqeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932914; c=relaxed/simple;
	bh=fFlFA8G66O3AhcJzTF9pfT+MExGCfTmf4oe7oWIRGOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQnMCk5JPkne8s31PMh7kxBnpJNRdS4AvmonzYY6wmiuvbaFmy53lP+z06kU0gpP0xMvRjcGjfSrwVa0gyF4XdZvv/eTTzHvGcvt/3SdtsYupJJlEjIHwEBNLa6PDjBtSaAsoL41I33i9vrtCz1INZzwe0bHasoJhCi3Of5n+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoLnUxrn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-294fd2ca6acso18453245ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932912; x=1762537712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=098F261HYE62bz4EbLCakXKNMD6yEDzP+rbKPhuk2BI=;
        b=MoLnUxrnNKP7t1AnBITiJK9jjshNCQC56mtVddx1KrFPWxDad+UQw3oe6JfBdFgXRM
         16bK45Rm5VNPKsBs9gHpcQPbQEGy5JXFpPzHBaABvDkjb+U75eGDKUbkOJU8PgW+BB12
         p8l8GE7cUUlvgCrR+zqyHnO++QNfX7UwyvEXgiY5vfr6U0R97d2SdjPZ57grvxJ8TDiR
         WaltgCf34j5FtVKQQ96S0GypgKRJJfs0xSjJi9G1k9Me1qTr1CmHaUVSASRFrCWktAks
         ACl4efnJYT43sWfqSb2KFNqm4TDjVNG1FK0VIRd1vxJ1n0q5nQTZTZyEc+zaDGNW/38W
         Oipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932912; x=1762537712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=098F261HYE62bz4EbLCakXKNMD6yEDzP+rbKPhuk2BI=;
        b=aRbx/ZiAa0/CPYGyPaN0BopZVjhgRGmR5qBTvAVHxFZr1WCyeIf7uf5yVKj7R4qQrn
         SA9GRZm1P6XkaftPYErEEQSUxrcDBUglrNS1nx6KHmMS0sbM+GoAg1PR0Yb248cXglGJ
         ykIIHVcpmm0wGMwktuB9mp1lz4tRehWiIhlW0woCYAl6giiuHvuy13oJn2RVHEJ3wGhB
         B2pK/2KCH+TXwB5E/cbbmUebWiMUeu15pLM9EgIo4DGXe8qoBZhnwQvT53T3+4enYDRD
         GGw1AT+S5G2U1E6RgI4aDVUS3VBdBDd0ccqDrqxyKYNxGx1CWEzbEVFgCyweExuQRXvO
         hXUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAWBA/sRyAdlyPs9YnoFd/5PUieRxwmI78bY5ZmN6j6EnZ58z4JyVFVyxEzIX1yBdvDjwi9dlvCkboUpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIgCLZ1KeZLwSwncRHr9h95rTdmIQ3R5YLjPb4CgtGx9ZI5MTG
	x1doWEfZyX6edSyrySN0HSolo4jpRV31UnSjjuVI14hUYg1OV7DxQUax
X-Gm-Gg: ASbGncsupOLHZa+GxLsFzKp8iAD6hqH8DlRG45mR9Dq4vuQ2xEauV1lFfINxLRalLFv
	e+W+fqByV2br2J8IAKAuwJU3pxv2IsNv23fygRnaa9sDU5TKpOl2RUVCJsTDzQcFIB5cVfZdldO
	8ysb2hliSfg9E+jXg0BDb3FNi5X9wOP7pYeaQ07uB2fHnh5D+oy92BeqMPS17gTVaTSAo9piiOU
	8ascKnofZdytoponSjTlh1jy751icPT1nY9R15YpTYyLuMEZFUuZiW8OsTWdXqgfn+DJHfzn8+9
	+lWEtTY/QIcZAoIKB3kFbOHGrjqAXvqeQhcPNRDHbXA0A9wAKcWxm3d16Zg0BFkJxNUEfzb1Ggt
	5y/f8WMjEucIe5CwcHnUyU0lUlbM3SnfEzDgmDMdAHAwqoRDC9rSDWIIyygLkIa8VXIPjJmAe7h
	RKC7e7zKxIndCEThqLrCBvLW3xLgUCPg58nas=
X-Google-Smtp-Source: AGHT+IE5ZC1i8KnkDoMeuHdmVM+WBof0Tvfw9Q+Bnfn74KlqAm8f7TNwkIf30NrJPjEKzPvI2EG3Fg==
X-Received: by 2002:a17:902:f60d:b0:295:28a4:f0ba with SMTP id d9443c01a7336-29528a4f69cmr30095965ad.14.1761932912206;
        Fri, 31 Oct 2025 10:48:32 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871693sm30113185ad.20.2025.10.31.10.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:48:31 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH v2 0/3] ksm: perform a range-walk to jump over holes in break_ksm
Date: Fri, 31 Oct 2025 14:46:22 -0300
Message-ID: <20251031174625.127417-1-pedrodemargomes@gmail.com>
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

v2:
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

 mm/ksm.c | 141 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 55 deletions(-)

-- 
2.43.0


