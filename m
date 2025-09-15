Return-Path: <linux-kernel+bounces-817698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC87B5857E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2307B0BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EE9287271;
	Mon, 15 Sep 2025 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxN1XXA8"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C223E229
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965939; cv=none; b=T4nCkVIIAVLtSv6eMQx0tjS1ji7C5UnSrRDuCyFonCthTZ5rl302fiD7rvA2KcIf9v1krqZ3cBRdjSoYKbu347sxHYpcgsgZ0W5q+6UGeoCjYlD4mARw3ezekAjZDlSl5fual/q3ksNR1dfQ6lSc/noncjpaF4dGTW91f/XDb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965939; c=relaxed/simple;
	bh=mnLEvOFae49ZcRXC33PM+fqu9yg8QglX+KQJiDfVOL0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=elTP2q04tiSG18WXJYyGZeGL+CZ8eOrkwqzNq4RIS1qOP6zeJeROIuyI2t7WtNPXbWr4AtjJAKYEcs0ox7NuKCqVdeDXTNG+MenLIZgD32rWjHQy4bIVlbdu8G8s34gDcqeLsWb5qjcXIooIVGGOFCacsvMLpUCj7FPQuX/ve18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxN1XXA8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32e64d4923fso927600a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757965937; x=1758570737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MhJHKPv2MqpneSVyivCmQMh/OX2F4LBu0RtU4TyI0z4=;
        b=HxN1XXA8iLnx2xaMZFBSRyXjpxHL8vP8ufbI6aaAy1yS+5D3T96D66MMgSGadm1ioe
         jYFHm+LCG/Yj82AX6Xs0eJbRfpkY0PqBch1pVsnNQqROIltzY1Lep6INMVsAfcHduXyh
         4QYrvAbAZOzdLwtoklFFJ+TQcuzTybe6UoMlBbwZ5ro8pqESBl/IrNOzbJu8ahf104yb
         dA3qYf21mOI8FyNxE61o72l3rVbM5PfzLE7W8MfMoi8NnTnkpRrJhzanu+RCBD5OYho0
         OLBSAUpinHtv+alpWl5crRMsROCNUwoO2ywskQPHMVKtOYgt/yWTNZZgxY8Lf9WoZj90
         qKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965937; x=1758570737;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MhJHKPv2MqpneSVyivCmQMh/OX2F4LBu0RtU4TyI0z4=;
        b=eH8N014tDD5OWQhzH1jQgeykJT71IsEIHgfz1Z8niK9oVFj8Rxe/nh2Dy3zhcAqlrH
         YBz+FHoBLVCm8hWfeJCPAtUk8QaoQ6KlJsuIieHAc562ctzci2mtgY9cN6P6+uqRCRV6
         H+zUn8TqDl8cYhUqvIYr4KDwydcsY7n4SB7BatnS9uP4GynFFF22kY5usoSigQTGRH/n
         vjA6xic0gECb+YjrQ25a1+ZtougHb527nUcQXRJ18NzljUcnaSSenuaXeIPIFOJU60xs
         IYrlaPb8u0ZWmRoREclL4DqpcBbhxpUrKL1udL1fv/2c3OsHmc1WxBjNx1bGolzpNeId
         p8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCX0qIRMwPLdPVSZB2JtHMHOGe8JtzOgVwllYUaDCI2/FngWpJu5DQJrVJd7LkoGg7GS4SEmAV+Rcdzv8F4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8k1bTjPkHPRt1+h1G1l9nw5jMhKFv/d5tAeFWdKrmmZhC7hE8
	GIe/iTazzJWJxBKADezlsM8KQurUmfmech9X2fx/9A4XDeoq1f9ijPphg3jN0GeX0qFPKEeKng=
	=
X-Google-Smtp-Source: AGHT+IH443Pb4Fka+zvTA5ISbMaozV02kT9kJzPLosmG6Oq62zqdFEn6rcQHRY5FXaXgRwsk70oLGZtW
X-Received: from pjk14.prod.google.com ([2002:a17:90b:558e:b0:32e:27d9:eda1])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d0e:b0:32b:dbf1:31b7
 with SMTP id 98e67ed59e1d1-32de4e7e37emr15999610a91.2.1757965937444; Mon, 15
 Sep 2025 12:52:17 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:51:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915195153.462039-1-fvdl@google.com>
Subject: [RFC PATCH 00/12] CMA balancing
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

This is an RFC on a solution to the long standing problem of OOMs
occuring when the kernel runs out of space for unmovable allocations
in the face of large amounts of CMA.

Introduction
============

When there is a large amount of CMA (e.g. with hugetlb_cma), it is
possible for the kernel to run out of space to get unmovable
allocations from. This is because it cannot use the CMA area.
If the issue is just that there is a large CMA area, and that
there isn't enough space left, that can be considered a
misconfigured system. However, there is a scenario in which
things could have been dealt with better: if the non-CMA area
also has movable allocations in it, and there are CMA pageblocks
still available.

The current mitigation for this issue is to start using CMA
pageblocks for movable allocations first if the amount of
free CMA pageblocks is more than 50% of the total amount
of free memory in a zone. But that may not always work out,
e.g. the system could easily run in to a scenario where
long-lasting movable allocations are made first, which do
not go to CMA before the 50% mark is reached. When the
non-CMA area fills up, these will get in the way of the
kernel's unmovable allocations, and OOMs might occur.

Even always directing movable allocations to CMA first does
not completely fix the issue. Take a scenario where there
is a large amount of CMA through hugetlb_cma. All of that
CMA has been taken up by 1G hugetlb pages. So, movable allocations
end up in the non-CMA area. Now, the number of hugetlb 
pages in the pool is lowered, so some CMA becomes available.
At the same time, increased system activity leads to more unmovable
allocations. Since the movable allocations are still in the non-CMA
area, these kernel allocations might still fail.


Additionally, CMA areas are allocated at the bottom of the zone.
There has been some discussion on this in the past. Originally,
doing allocations from CMA was deemed something that was best
avoided. The arguments were twofold:

1) cma_alloc needs to be quick and should not have to migrate a
   lot of pages.
2) migration might fail, so the fewer pages it has to migrate
   the better

These arguments are why CMA is avoided (until the 50% limit is hit),
and why CMA areas are allocated at the bottom of a zone. But
compaction migrates memory from the bottom to the top of a zone.
That means that compaction will actually end up migrating movable
allocations out of CMA and in to non-CMA, making the issue of
OOMing for unmovable allocations worse.

Solution: CMA balancing
=======================

First, this patch set makes the 50% threshold configurable, which
is useful in any case. vm.cma_first_limit is the percentage of
free CMA, as part of the total amount of free memory in a zone,
above which CMA will be used first for movable allocations. 0 
is always, 100 is never.

Then, it creates an interface that allows for moving movable
allocations from non-CMA to CMA. CMA areas opt in to taking part
in this through a flag. Also, if the flag is set for a CMA area,
it is allocated at the top of a zone instead of the bottom.

Lastly, the hugetlb_cma code was modified to try to migrate
movable allocations from non-CMA to CMA when a hugetlb CMA
page is freed. Only hugetlb CMA areas opt in to CMA balancing,
behavior for all other CMA areas is unchanged.

Discussion
==========

This approach works when tested with a hugetlb_cma setup
where a large number of 1G pages is active, but the number
is sometimes reduced in exchange for larger non-hugetlb
overhead.

Arguments against this approach:

* It's kind of heavy-handed. Since there is no easy way to
  track the amount of movable allocations residing in non-CMA
  pageblocks, it will likely end up scanning too much memory,
  as it only knows the upper bound.
* It should be more integrated with watermark handling in the
  allocation slow path. Again, this would likely require 
  tracking the number of movable allocations in non-CMA
  pageblocks.

Arguments for this approach:

* Yes, it does more, but the work is restricted to the context
  of a process that decreases the hugetlb pool, and is not
  more work than allocating (e.g. freeing a hugetlb page from
  the pool is now as expensive as allocating a new one).
* hugetlb_cma is really the only situation where you have CMA
  areas large enough to trigger the OOM scenario, so restricting
  it to hugetlb should be good enough.

Comments, thoughts?

Frank van der Linden (12):
  mm/cma: add tunable for CMA fallback limit
  mm/cma: clean up flag handling a bit
  mm/cma: add flags argument to init functions
  mm/cma: keep a global sorted list of CMA ranges
  mm/cma: add helper functions for CMA balancing
  mm/cma: define and act on CMA_BALANCE flag
  mm/compaction: optionally use a different isolate function
  mm/compaction: simplify isolation order checks a bit
  mm/cma: introduce CMA balancing
  mm/hugetlb: do explicit CMA balancing
  mm/cma: rebalance CMA when changing cma_first_limit
  mm/cma: add CMA balance VM event counter

 arch/powerpc/kernel/fadump.c         |   2 +-
 arch/powerpc/kvm/book3s_hv_builtin.c |   2 +-
 drivers/s390/char/vmcp.c             |   2 +-
 include/linux/cma.h                  |  64 +++++-
 include/linux/migrate_mode.h         |   1 +
 include/linux/mm.h                   |   4 +
 include/linux/vm_event_item.h        |   3 +
 include/trace/events/migrate.h       |   3 +-
 kernel/dma/contiguous.c              |  10 +-
 mm/cma.c                             | 318 +++++++++++++++++++++++----
 mm/cma.h                             |  13 +-
 mm/compaction.c                      | 199 +++++++++++++++--
 mm/hugetlb.c                         |  14 +-
 mm/hugetlb_cma.c                     |  18 +-
 mm/hugetlb_cma.h                     |   5 +
 mm/internal.h                        |  11 +-
 mm/migrate.c                         |   8 +
 mm/page_alloc.c                      | 104 +++++++--
 mm/vmstat.c                          |   2 +
 19 files changed, 676 insertions(+), 107 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog


