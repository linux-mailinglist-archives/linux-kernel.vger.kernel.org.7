Return-Path: <linux-kernel+bounces-750060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA768B156CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2021E3B83E4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0053B18BC0C;
	Wed, 30 Jul 2025 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aVc1Ye7L"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA01862BB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753837110; cv=none; b=vEaWbhYVQ7SpR3L8fpJ3Yf7XNfUG1gl7QJ6j2LaPyzyOhKbP8gejpzzlA0Oqis2++CJLxEgoUCJdZxk+jAm6zkXZX/FhjLtMlSEGT2xrK/+lBq/6db/x/PWJwk/EmDRwJxS6NU2Ymt03yLd7RIE9/Tk53G1GI7jUMMOa5P3grzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753837110; c=relaxed/simple;
	bh=8krCprYrUMdOZ3h034xFumycFTtvtQ8rNBxl0XROG6M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Zx/EYp6yhhOGylEbcTJh/XLYiVf1tXlgSyMI/+7x12EbCtiIbS9gvv5BZZX3FIsxMK8SOR1D0teXGFF7/5KmhnCTsLpWhqkCJKhIZnnsu/8N7JZITg9fT2v2tyfQVXiB3OvmmvbP5535y0SqOOL16hbL2pY0G9t1VAFZWJVQpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aVc1Ye7L; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24011ceafc8so3190805ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753837108; x=1754441908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BvzOHnKibLB3ltRouRfCtD2c5Lgi+zp48cQKPXu7/xE=;
        b=aVc1Ye7LBjhQvOM4uerN+DgUwFaQw9DTwyqp9kBgDkeAsaMv7K0b4Sksh8DWPPJJxz
         zVQuIsjWSiYsqlGXObYXiGi/r1e5iWileTW+B50c10TmmFD24yX4SU4T9+esEvbtrYHj
         tHzSITotoe3W+pHSiQBR6sKhYSm8INdu0G5IIKf0/DVxRilvUqXSf+p4+I3ZITJelMw0
         o5SIP/0CePZN3SmC19k7Je1e2hhrCLUzMIkn2UisZf8O0C9sP8qGKV0yDZziDbSNJWAf
         B76HQNt7I8ePF2T1UuBrZrVIcK0tphsrZBwNLsUYM9SvESPZIJHvwXVmeD8ofY5ztJys
         JCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753837108; x=1754441908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvzOHnKibLB3ltRouRfCtD2c5Lgi+zp48cQKPXu7/xE=;
        b=PfLKhbiCQ6DpGhs44vXZ96wOTvX34TnIYnasMZxtItVym+f9fhZMc0WdZokXqeVIEq
         zNgFWq/+FMU5MmSWL6etDujkhEX56NhO1qlzyLpZ9+ynORQ034prCayAePMgISLnq+UB
         8D6xecPjzVxlKKzzYimFjuH1Dl5I0XoUiYyETjWoVlShQFP8P4CfATI6uuwr48u4tYUF
         1DMUP0Lr4yMdd8NDqTvxLBGWhMAB1pxV4h0zatj6QzFt8kDHm+qlYaeStWA0//EFzXLX
         LkPSBCiccvMx8cXgvlcKKdiNHG5C64E9RKNKqhYlVLXNAwJoxNtr4YoAyq/0SfU6Mex1
         rHCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4w0mYCc0pimJN0frV9MtMx6SohRRlAHnHg2d4U6VaPOtMW/N8mF2zpB9N02/B0be0xppeu7sOgdvMzAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvMRGCot+EnOnqzzd7EMu73O6SartMaz2CDyFg7QFtAYeP7zj0
	D612At3bSqY9EH8jlTNldR58+gBbxllndXwVwgg8kotJl1gqwxq0djacfLvewxpWpAi9KyPI/BM
	0nCzc/w4xVOu4oK561eVg6kpVBc7anVJwr/a86w==
X-Google-Smtp-Source: AGHT+IEE1T/Er3sKrygau3w97VIOA/QCJAiAB2wozTO9pbOU/DTR6qrzKjpzklTM5AEwRfki5E7dO/OqrMcPg2dtONxW4w==
X-Received: from pjbsz11.prod.google.com ([2002:a17:90b:2d4b:b0:315:b7f8:7ff])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f145:b0:240:721e:a406 with SMTP id d9443c01a7336-24096b06962mr15696795ad.35.1753837108130;
 Tue, 29 Jul 2025 17:58:28 -0700 (PDT)
Date: Tue, 29 Jul 2025 17:58:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730005818.2793577-1-isaacmanjarres@google.com>
Subject: [PATCH 5.4.y 0/3] Backport series: "permit write-sealed memfd
 read-only shared mappings"
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: aliceryhl@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Until kernel version 6.7, a write-sealed memfd could not be mapped as
shared and read-only. This was clearly a bug, and was not inline with
the description of F_SEAL_WRITE in the man page for fcntl()[1].

Lorenzo's series [2] fixed that issue and was merged in kernel version
6.7, but was not backported to older kernels. So, this issue is still
present on kernels 5.4, 5.10, 5.15, 6.1, and 6.6.

This series backports Lorenzo's series to the 5.4 kernel.

[1] https://man7.org/linux/man-pages/man2/fcntl.2.html
[2] https://lore.kernel.org/all/913628168ce6cce77df7d13a63970bae06a526e0.1697116581.git.lstoakes@gmail.com/T/#m28fbfb0d5727e5693e54a7fb2e0c9ac30e95eca5

Lorenzo Stoakes (3):
  mm: drop the assumption that VM_SHARED always implies writable
  mm: update memfd seal write check to include F_SEAL_WRITE
  mm: perform the mapping_map_writable() check after call_mmap()

 fs/hugetlbfs/inode.c |  2 +-
 include/linux/fs.h   |  4 ++--
 include/linux/mm.h   | 26 +++++++++++++++++++-------
 kernel/fork.c        |  2 +-
 mm/filemap.c         |  2 +-
 mm/madvise.c         |  2 +-
 mm/mmap.c            | 26 ++++++++++++++++----------
 mm/shmem.c           |  2 +-
 8 files changed, 42 insertions(+), 24 deletions(-)

-- 
2.50.1.552.g942d659e1b-goog


