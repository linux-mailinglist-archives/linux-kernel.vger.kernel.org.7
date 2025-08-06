Return-Path: <linux-kernel+bounces-758006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D74B1C9A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B796518C2077
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC81522F767;
	Wed,  6 Aug 2025 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfULq2hg"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277DB2E36FE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497117; cv=none; b=Sw7aHcI65UDklZ0Swzv/zREmZjgu+aZa2qBwtyW9oSvPnKiEpFdHG9U4u9g5pDyqztNxh7xoH/hFHr3+SlBnhiR3HlXKK6aOMgey/KcFE+pyHCk9/HCVLFdfaQqHsWC+b+MuDfFTp2YQsqYeryVWnVMJ9ujwKSh/2QWNePpOR3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497117; c=relaxed/simple;
	bh=naVnFxDk3uReKELnYSZtlUkGZf8C6x9xgQeQnB2kXos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VHr+GThCUYxxlUOHvZKbFcAJnb0JmkJc/Ta2+sYOClE+JraX7ac7trl68Ft3htc6xCsx3/ueSdRTqjaPI9zE+E8UmGisqTq+ng2KtH1QbxYS9Bv0sDGK2mP6p+RNdMNnk2kTJa9AEW4TLGnKsuk6wEXo/sYDJ4RaUI9pGMS5sTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfULq2hg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e81074ae83so3785485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754497114; x=1755101914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m7Uvcgab86Z6ZLa6sJF+QuCkUEpCn18pclHA8j6Pkpo=;
        b=lfULq2hgAM3yxGGiCSshOP+BqbDux+6Z0kj7GmZgOGo+h0qDJ6y3XbrIz212Bix3LB
         CY2zGQNGDEgLN6SYQzKhdxyNugFSnKLZW4elEAU4aMuTi8janXROvJmD9VYAiQpv974k
         EqFhp0NiLc1UIaNoS/C8rUmVpm8PgIRx1EgNjTFcmT/k1ve3BBzxZqGCyRNABtfPywRA
         +QPnOpJeppRTuyliQug1c67PyK7h9ggqWo91eTsysFaUYO3z5hq1/BGRVdB/xPZGclX6
         Cp/9MlZZ8+KrBTdItPmVG6WX3JaQ9OgC5xZCqvthJb3fLmrj1vNfBkoqouva96NgULOq
         rUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497114; x=1755101914;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7Uvcgab86Z6ZLa6sJF+QuCkUEpCn18pclHA8j6Pkpo=;
        b=kOzvvGp6RwhgN77Vas7ccHUWbHOUgyi0CQWsWLJMx5APoj/K8vjh4RUlwQ6EEqY23Z
         8b1KvNnEE/9HIr0H8tulyQXsr+A3nVPXSBTu/Fy7J2MZZ0dNJxX9GFNcbvnSMwlLcH0Q
         6eqx6DpOFaG7L9Tow0XUZU9uhiOnMc9zdPOWoyPdEKVsbPbUvNjfvjzHffjvTRWn5Hbz
         Lz1kA1d3bMt6M+j9UQzK8ug8hBXRDl6kcr04tKMSX0Pqi1yzUW7AS3HP1y77z+NZEd2k
         F9apHGnlhPjLsZt6VFU8wT5X0ADqMW0nFtF2qOC2WiOdcAMxCV6kPDDwbxtx01Jmmd1T
         vWJw==
X-Forwarded-Encrypted: i=1; AJvYcCUKKbKsrOJNM8JLM7sYRIZ0xzPYnBfEns+TG4r4//6DryETexpHzq6LBbMFRzXpeApke9j82ZTMtIRcuQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdwONH+wS40iC9aIIOtNxhRS2rUBCYV36gE7IFPULyC8h9UPmr
	Cw6zddBLMnPx2xwog+hVMz/vy8mHU1l5KurmuHaDD6DlZMQabx1r+8COvmhSlsbZuTw=
X-Gm-Gg: ASbGncuAWvWxqjQug/aEJDZkHGXvUMlcQSGnnB1DiQ2iQMzYwEzr0nSmvN1+XUU+1rw
	IClNKY77mGZziCVR6GaivoK0Vb7CIrRJc40eoRTjPlQm/dKl/e/hwFcIV7wnXTc/OU+awpK/TS7
	k/s2khu5qLlxguOhZ5KALrHtR9If5QHnupdrUrw68+WZRX3nCldbiVuTtDv1GbxrPZxJVSRYOa6
	Y9rfyo255JZLCWSck4rcLT+OuScaHSE6niZ3htDQTTHZ8htmC4kR56qLUaOGrQ4oBcV1WMwOwfL
	Hs0cYfyOLyGD1oxrExQTI+OwKahyvwId21tGqTaZ3jMQ8siZ+8KgvTQ8z0XKBpIF/q2biUCup5H
	+vJlSHPBJEOJXj8xpQx+R7BfPgs4=
X-Google-Smtp-Source: AGHT+IEQ2Law8vL1y7Vuz+VNuoQ/RSeFNfbn3pHNy90CB+MigBUyaVvg/Ws06nsyrs4igPZnHH5M9w==
X-Received: by 2002:a05:620a:268f:b0:7e3:37b6:bec8 with SMTP id af79cd13be357-7e814eebf69mr588609885a.33.1754497113784;
        Wed, 06 Aug 2025 09:18:33 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e7fa35144esm464081885a.48.2025.08.06.09.18.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 09:18:33 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 0/3] mm, swap: improve cluster scan strategy
Date: Thu,  7 Aug 2025 00:17:45 +0800
Message-ID: <20250806161748.76651-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

This series improves the large allocation performance and reduces
the failure rate. Some design of the cluster alloactor was later
found to be improvable after thorough testing.

The allocator spent too much effort scanning the fragment list, which
is not helpful in most setups, but causes serious contention of the
list lock (si->lock). Besides, the allocator prefers free clusters
when searching for a new cluster due to historical reasons, which
causes fragmentation issues.

So make the allocator only scan one cluster for high order allocation,
and prefer nonfull cluster. This both improves the performance and
reduces fragmentation.

For example, build kernel test with make -j96 and 10G ZRAM with 64kB
mTHP enabled shows better performance and a lower failure rate:

Before: sys time: 11609.69s  64kB/swpout: 1787051  64kB/swpout_fallback: 20917
After:  sys time: 5587.53s   64kB/swpout: 1811598  64kB/swpout_fallback: 0

System time is cut in half, and the failure rate drops to zero. Larger
allocations in a hybrid workload also showed a major improvement:

512kB swap failure rate:
Before: swpout:11663  swpout_fallback:1767
After:  swpout:14480  swpout_fallback:6

2M swap failure rate:
Before: swpout:24     swpout_fallback:1442
After:  swpout:1329   swpout_fallback:7

Kairui Song (3):
  mm, swap: only scan one cluster in fragment list
  mm, swap: remove fragment clusters counter
  mm, swap: prefer nonfull over free clusters

 include/linux/swap.h |  1 -
 mm/swapfile.c        | 68 +++++++++++++++++++++++---------------------
 2 files changed, 36 insertions(+), 33 deletions(-)

---

V1: https://lore.kernel.org/linux-mm/20250804172439.2331-1-ryncsn@gmail.com/
Changelog:
- Split into 3 patches, no code change [ Chris Li ]
- Rebase and rerun the test to see if removing the fragment cluster counter
  helps to improve the performance, as expected, it's marginal.
- Collect Ack/Review-by [ Nhat Pham, Chris Li ]

-- 
2.50.1


