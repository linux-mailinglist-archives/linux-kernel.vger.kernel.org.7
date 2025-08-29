Return-Path: <linux-kernel+bounces-792294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E5DB3C276
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428481C86D83
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1FA341ACA;
	Fri, 29 Aug 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ScgYOxOB"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C415E5D4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492330; cv=none; b=cWeZU0T38jGQGsDDnQ/YIJCjjvCgtw0lmbdaXIF8v7F1UBaRNMb4ejB9gFkOIpKr3rE26PiagKt11sDnNEbrJ5SBYDbFuKhk5xfwRPICES2oucL6SZ9V7/yQBlWk3g3j1xSKaPN6hpLBSnsPP4ceaN+Sei7SiUfcnHkzvCPJgME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492330; c=relaxed/simple;
	bh=CKMD6BKVpD3ysfBdDEZhxhV9XPBHcUP+vRRNVMFOryQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXkHZnIaCaOL3d5+cjRn+smBF/m8dNcRjobc0sY+xvsYp3nu/IhVIOLOd9QbCYEqJXn1I3WtxVu5JWrlwWBLh+YFvGPzg/1jpzuD2A44xe0hgjgugNmwfzwBdp97HXKcJbybZ/3yh8UD4YS2zH2Uj7m9wuh0jKCyxvMZPo/4xXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ScgYOxOB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7a16441so359758466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756492326; x=1757097126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1n0BAT1fuH3lX7MFumBUOjEEjUCMCEsnFKx8em6Be6I=;
        b=ScgYOxOBQeS+73p/QVBxRVbWR1MYn6/PK9AGAMHqsxHFn9JSbn4Zf5B5O+jhdT819E
         lk8QTuf1ZX0m8m5ADCx+Wvw+9ddrPT0uN0VkF1+69tnmYvonht1FKh8XIxkzBnN6iBcC
         Q8BFIVUQaOcUqsDl1Fk9VN+ElUZXD8AADh3MqLdlGlBR9PqTWz/LKaWqtustiKPOFFrN
         KXAt8oTyVX629Qr/bcZwTxTJKbOajvLcwLZ3e9G/SJS6tyMOHaHSwMX/vQyD0NS2VHQZ
         PanP7NtWqz1Z1/spvliwybCmVjIohxcPeppnmQ7YZ8kFpO/2iL4UMJFBA+g5wHZLV30x
         Be3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492326; x=1757097126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1n0BAT1fuH3lX7MFumBUOjEEjUCMCEsnFKx8em6Be6I=;
        b=Bg2QEQ8o0GGn8BtfCaLbqiTy7cxZViOTMZW3Bk725SKUI3DwSsiV9E/naSXam4n3R8
         /vcIYuuT9+HmblUI6ozCD/VQG6xWvcDbFUX/bMnqdd1Gem5Yg76nj5/9y34mogGqAeD9
         rrvyW9UkluUcs1Qmt+DCLHb7AMsvrAz1HderFz81ZtR4ysLuWPx4dgj48/t0rQm3pft2
         64ZIcFaz4oU9pex6IzYH4hBu0mBC2/FymEZ4for7aRqmsaS5RBBrpJfzdOwWvLbOUXGx
         TzpkuJnPxCWH9gi6QjnD1TYgQ7UgwdBVWrGvUtTO5okPty0gwGSkQbZZSzqJJHoibJiz
         T6+A==
X-Forwarded-Encrypted: i=1; AJvYcCVHQZbZZRr9Q7z+LxH8jnx93ycqZQ/bDb4JyAHwsc0JYX7kx7m8xyBMvYmS0796Z7ixe3l7UXHlWfOTKJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8gEYtw7riEHxbYHOSc/zfw4mYQQ3fEmSTSOmhfYSV6civNGzd
	X4KlcdA4/EbGiPN269sINyquPNjNJkp4i32zqnLF2ja2BPr64lCi5BW4BX1MuWnvFaE=
X-Gm-Gg: ASbGncso3DM9dKqqkWYWYdayon4DFGtnYwStDozQeDHsr7Bcim/5x/qTXeekkjqVjbF
	1+Ndd3m7uyudUJDyk7M2v7sFm6Q1y6EEasEbaOpXiP9dceMr0SX9nz2MG50jjLxGZ38Lk5bEQ7l
	1chWl8yOyyZNd6T/hZGLSk+RHlkCTbUN4zBXlbxVdS66cwT8dO1Ngv8Bg4AiEyQISi/7y1vZ6ws
	cPxgK8IfiMvmhZyI4GxPwAtq1nNrXkncpEd14H3WrfGs250Rbc3f84xKcAE4BJxE4jBF68Lej29
	g66PDWciqhVB+SNG6MRIb1Gxb/Ggo3w1z9xXXBbgDGHOKmiPakmajGfAnYGssxVHxyt8uIw1ZnY
	OyH321SxqLeN+VkCJcRkmISYxhgvHdQK+xam+GzupbwE8tlzmB90WgKI/vVyANlLDOFhezEqBft
	KcOKvNKZ8bQSnC3lgTIjPsZ9sFW7qRGMPBxhPVkvBnUK4=
X-Google-Smtp-Source: AGHT+IFM/WcHugYqf6JhyROeecktHrseO8ZMkPb1VybTOz5v843w2YdplzoiMvny80PtOIwil6biOA==
X-Received: by 2002:a17:906:fe45:b0:af9:5766:d1e2 with SMTP id a640c23a62f3a-afe295f1a73mr2279764766b.47.1756492326379;
        Fri, 29 Aug 2025 11:32:06 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f1174sm257964466b.9.2025.08.29.11.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:32:06 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 00/12] mm: add `const` to lots of pointer parameters
Date: Fri, 29 Aug 2025 20:31:47 +0200
Message-ID: <20250829183159.2223948-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

This work was initially posted here:
 https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/

.. but got rejected by Lorenzo Stoakes:
 https://lore.kernel.org/lkml/d6bf808d-7d74-4e22-ac4b-a6d1f4892262@lucifer.local/

David Hildenbrand and Lorenzo Stoakes suggested splitting the patch
into smaller chunks.  My second attempt with one smaller patch was met
with agreement:

 https://lore.kernel.org/lkml/20250828130311.772993-1-max.kellermann@ionos.com/

Now this is the rest of the initial patch in small pieces, plus some
more.

Establishing const-correctness in this low-level part of the kernel
enables doing the same in higher-level parts, e.g. filesystems.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Max Kellermann (12):
  mm/shmem: add `const` to lots of pointer parameters
  include/pagemap.h: add `const` to lots of pointer parameters
  include/mmzone.h: add `const` to lots of pointer parameters
  include/fs.h: add `const` to several pointer parameters
  mm/oom_kill: add `const` to pointer parameter
  mm/util: add `const` to several pointer parameters
  parisc/sys_parisc.c: add `const` to mmap_upper_limit() parameter
  arch, mm/util: add const to arch_pick_mmap_layout() parameter
  include/mm_types.h: add `const` to several pointer parameters
  include/mm_inline.h: add `const` to lots of pointer parameters
  include/mm.h: add `const` to lots of pointer parameters
  mm/highmem: add `const` to lots of pointer parameters

 arch/arm/include/asm/highmem.h      |  6 ++--
 arch/parisc/include/asm/processor.h |  2 +-
 arch/parisc/kernel/sys_parisc.c     |  2 +-
 arch/s390/mm/mmap.c                 |  4 +--
 arch/sparc/kernel/sys_sparc_64.c    |  2 +-
 arch/x86/mm/mmap.c                  |  6 ++--
 arch/xtensa/include/asm/highmem.h   |  2 +-
 include/linux/fs.h                  |  6 ++--
 include/linux/highmem-internal.h    | 34 +++++++++---------
 include/linux/highmem.h             |  8 ++---
 include/linux/mm.h                  | 46 ++++++++++++------------
 include/linux/mm_inline.h           | 25 ++++++-------
 include/linux/mm_types.h            |  4 +--
 include/linux/mmzone.h              | 42 +++++++++++-----------
 include/linux/pagemap.h             | 54 ++++++++++++++---------------
 include/linux/sched/mm.h            |  4 +--
 include/linux/shmem_fs.h            |  4 +--
 mm/highmem.c                        | 10 +++---
 mm/oom_kill.c                       |  2 +-
 mm/shmem.c                          |  6 ++--
 mm/util.c                           | 16 ++++-----
 21 files changed, 143 insertions(+), 142 deletions(-)

-- 
2.47.2


