Return-Path: <linux-kernel+bounces-724853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92324AFF79A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B91F1C4690F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184AD28152B;
	Thu, 10 Jul 2025 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljl1ud3p"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AF8236A73
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118656; cv=none; b=beaZ4LByatb2VOcBuaJ1VaPkGjR/niuyRgNarlrRpUisKTFpU/2ibZdh4AVPm1jTeCK+yjdxPKkkcbRoHyEEzISeVNMdLftX4gMogkMU1RV2vfLbrldMEKcjM4RdPVneDPX/jprUbeQRqWibzzZ+OnzBdPmJxY0GINhX6tFIxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118656; c=relaxed/simple;
	bh=0IDcHJy9FpbAEeSkqkiaKYDaNmuHZDO/p2eqo60R/ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jf0N+IplPagM0uYxE7/nosmLLGwTcJZ50oxmv3uMLktNJSc04H7+4ZmMUVeeTUT7mocPRyX1waONGsF1fb6cmJYsb1nw0zwB4a1P1TN6HStLttUCkhAcQDZf0aYlBVvLJq+oe+3dmzG76wS+EMRAMNkcBV0cesqTyNrn+7Gbz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljl1ud3p; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235ef62066eso9231215ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 20:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752118654; x=1752723454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L7oCOOALe1LrYdPFtNVGk/i/koqxWAk4W7m8zK9PpmM=;
        b=ljl1ud3p821Zn+rx+c2thBZO6cywuMoNycptEJ1L6GcggpEFxkcJIblNYGCMsWUXu8
         SV39oKrBI5fvvjjbUCvfEU43azIKw0hf5Ot0S6Nw8sRatRnFq1bTK68zoMfZSE1yY2aV
         wMeYnLgN7XGs3mwqZe8l0CVN0FYCq3VdC6c4z5BwUlASXtJSUNkDlQeAIvOZtCOIlITt
         mjHllaPWP6g/JISG+FQ9KjH8yYPfX0rN/nQY5KS7oPjbERcsZbB5kM+7JLTuUgYfVqK6
         B1/QHvs4RjQ4phDeqXI5rk2dCshkUfVh6ensZ21zXnA7n/vZOa356ummSeJ8i1n8d9+z
         hCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752118654; x=1752723454;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7oCOOALe1LrYdPFtNVGk/i/koqxWAk4W7m8zK9PpmM=;
        b=cqzPVr4Utz9PDMarUy7RFVq4Og9qB7yhvl/r+3xOcSZlFxmuyJ2coTFpvf608AliUh
         DAQTk3WzmYQRGxTBxllx/K52XS/xz8HiILTLjZFKJnvEzwqYYW95BljyOLnGw2rQnomb
         eyn81rgIfZjgfNmNfQJ4y+nT5nnrydtJpQWQsSKqrImNqn2rWOoFCsfm1VC04pGPuZ8c
         pBbsZb2lAz1uPtwnm/0L5Dz5a2IOHCXDxesdiF3ys5B46Qj7ZTa1YY/jOM9SZxD+fhqW
         uKNPKgcUxhekutasHYrRR45fKp46g58/OLR1d0jMCwKo2gABNkUrWOjNRDPNlFOb6Dbg
         meig==
X-Forwarded-Encrypted: i=1; AJvYcCWbmM0IeNtk8MlSzYFDTsUyoNqQweBTb+pvdKhbF6OZx3grEbCkC+vKt+7YoTe4Nl124hLkxfS1RL+nrQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbrvygsix9jzLulHZ+ghhPon0PSCsd4ohKL5XmsBKbHpbIeaJ8
	d9vQyCY5H18gERPMtpLXAkK8b1pc7wE11ubVmoYeiKxTCegbLvzfyzW/
X-Gm-Gg: ASbGncv77Mg3orQThkCKiMt4OCUea8VH6zmh7ycu/aXFnn/F041M3RiHynvI+LAuqIr
	0v1YOQYUWKBFrl/JuYyB+1o4dcFlMWx6nXUnsxtp2w+r96A8c93pynH0chYW/6KRnuDxlBVdL6H
	Lv0ocCJbMKGgTjxbkWbpkFZ2TRG+Xxf2PubTpEp2Nv6PyE3JxDGFprBQWZtD1wnl5TlgI0aGX6X
	6RTUnAoc2eV3wnqF1r0aOWD37hq9GnaRFgN7eED2Q3ncRQ3UDvNxvRHa3uNs6v5ZCeWkGm0vB70
	tOuo15bJvHX/qFZ5BYyJzMg8x6KmJGR+JdXxFyCEHD8td0SrWcS7GqFU6+aClJWbOhN2p1iyQvA
	2
X-Google-Smtp-Source: AGHT+IG7cIHscPSKgzqgeYs1L9w153XiD/rnRx3GdHz3vwqkTKkgWIbvbXDVnLJfaWyDbJ38PgCx1A==
X-Received: by 2002:a17:90a:c884:b0:313:f6fa:5bb3 with SMTP id 98e67ed59e1d1-31c2fdd0494mr6948497a91.26.1752118653616;
        Wed, 09 Jul 2025 20:37:33 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300689aasm3716320a91.13.2025.07.09.20.37.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Jul 2025 20:37:32 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v5 0/8] mm/shmem, swap: bugfix and improvement of mTHP swap in
Date: Thu, 10 Jul 2025 11:36:58 +0800
Message-ID: <20250710033706.71042-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The current mTHP swapin path have several problems. It may potentially
hang, may cause redundant faults due to false positive swap cache lookup,
and it will involve at least 4 Xarray tree walks (get order, get order
again, confirm swap, insert folio). And for !CONFIG_TRANSPARENT_HUGEPAGE
builds, it will performs some mTHP related checks.

This series fixes all of the mentioned issues, and the code should be more
robust and prepared for the swap table series. Now tree walks is reduced
to twice (get order & confirm, insert folio), !CONFIG_TRANSPARENT_HUGEPAGE
build overhead is also minimized, and comes with a sanity check now.

The performance is slightly better after this series, sequential swap in of
24G data from ZRAM, using transparent_hugepage_tmpfs=always (24 samples each):

Before:         Avg: 10.67s,  stddev: 0.04
After patch 1:  Avg: 10.49s,  stddev: 0.04
After patch 2:  Avg: 10.42s,  stddev: 0.05
After patch 3:  Avg: 10.45s,  stddev: 0.05
After patch 4:  Avg: 10.49s,  stddev: 0.04
After patch 5:  Avg: 9.67s,   stddev: 0.03
After patch 6:  Avg: 9.67s,   stddev: 0.04
After patch 7:  Avg: 9.68s,   stddev: 0.05
After patch 8:  Avg: 9.66s,   stddev: 0.04

Several patches improve the performance by a little, which is about
~10% faster in total.

Build kernel test showed very slightly improvement, testing with
make -j48 with defconfig in a 768M memcg also using ZRAM as swap,
and transparent_hugepage_tmpfs=always (6 test runs):

Before:         avg: 3353.66s, stddev: 33.73
After patch 1:  avg: 3354.19s, stddev: 42.54
After patch 2:  avg: 3364.16s, stddev: 52.74
After patch 3:  avg: 3355.73s, stddev: 36.17
After patch 4:  avg: 3352.78s, stddev: 39.80
After patch 5:  avg: 3355.19s, stddev: 50.78
After patch 6:  avg: 3333.63s, stddev: 32.50
After patch 7:  avg: 3297.70s, stddev: 38.93
After patch 8:  avg: 3302.35s, stddev: 50.61

---

V4: https://lore.kernel.org/linux-mm/20250704181748.63181-1-ryncsn@gmail.com/
Updates:
- Merge patch 5 into patch 8 to fix a intermediate code error. [ Baolin
  Wang ]
- Instead of passing two swap entries, calculate the new order 0 entry
  in shmem_swap_alloc_folio, to improve code readability. [ Baolin Wang ]
- Rebase on top of mm-new.

V3: https://lore.kernel.org/linux-mm/20250627062020.534-1-ryncsn@gmail.com/
Updates:
- Split and reorganize a few intermediate patches [ Baolin Wang ]
- Fix a duplicated fault issue that may occur in one intermediate patch
  [ Baolin Wang ]
- Improve variable naming [ Baolin Wang ]
- Fix a wrong error value problem, return proper error value when direct
  swapin failed.
- No major code change from V3.

V2: https://lore.kernel.org/linux-mm/20250619175538.15799-1-ryncsn@gmail.com/
Updates:
- Split the clean up patch into 3 individual patches [ Baolin Wang ]
- Fix a code error in the first patch [ Baolin Wang ]
- I found there are some other remaining issue that can be fixed after
  the clean up so includes these too: fix major fault counter, and clean
  up the goto labels.

V1: https://lore.kernel.org/linux-mm/20250617183503.10527-1-ryncsn@gmail.com/
Updates:
- Improve of funtion name and variable names, also commit message [ Kemeng Shi,
  Dev Jain ]
- Correct Fixes: tag [ Andrew Morton ]
- Collect Reviewed-by.

Two of the patches in this series comes from the swap table series [1],
and worth noting that the performance gain of this series is independent
to the swap table series, we'll see another bigger performance gain and
reduce of memory usage after the swap table series.

I found these issues while trying to split the shmem changes out of the
swap table series for easier reviewing, and found several more issues
while doing stress tests for performance comparision. Barry also mentioned
that CONFIG_TRANSPARENT_HUGEPAGE may have redundant checks [2] and I
managed to clean them up properly too.

No issue is found with a few days of stress testing.

Link: https://lore.kernel.org/linux-mm/20250514201729.48420-1-ryncsn@gmail.com/ [1]
Link: https://lore.kernel.org/linux-mm/CAMgjq7AsKFz7UN+seR5atznE_RBTDC9qjDmwN5saMe+KL3b1mQ@mail.gmail.com/ [2]


Kairui Song (8):
  mm/shmem, swap: improve cached mTHP handling and fix potential hung
  mm/shmem, swap: avoid redundant Xarray lookup during swapin
  mm/shmem, swap: tidy up THP swapin checks
  mm/shmem, swap: tidy up swap entry splitting
  mm/shmem, swap: never use swap cache and readahead for
    SWP_SYNCHRONOUS_IO
  mm/shmem, swap: simplify swapin path and result handling
  mm/shmem, swap: rework swap entry and index calculation for large
    swapin
  mm/shmem, swap: fix major fault counting

 mm/shmem.c | 267 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 143 insertions(+), 124 deletions(-)

-- 
2.50.0


