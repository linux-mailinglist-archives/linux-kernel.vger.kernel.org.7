Return-Path: <linux-kernel+bounces-747606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29702B135DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884BE3A2B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E316221F38;
	Mon, 28 Jul 2025 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwyEM9YG"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B262153D2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689215; cv=none; b=AujHsshVKdvbeX8WsR58OGYsjpocJEoSARX3SNmdGG+WCE3zkMMxoxeeqzOIAhdtqaD3E8h4QJZQYHJC+sXO32XbkiudC9jCCdaDMbL6lfUvNxrDPHHIpC9OYkEZhnoWw1YpExk8UWTsdSf6EBNSc31rjZmdxaDfZ6Uk7uS/tds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689215; c=relaxed/simple;
	bh=VicJlHgsfxvS0D78zlYt4b9NuI6xwuiXgQC+5ImzMD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBVu3dgdj7budmk77UAw9tLuT+d4Y4D77LtJNUBd1dU9wyUSMUqGmWQN4LYTuj5ZtWrYb70+/DNuHPto4CBHQrj5B1wmOc0KuJLtdjW/xN9hRrUoK4NpL//EYdNvb1t11PrdyTGSwwaI1qYcIpCaTiP1FcjAwArD7ngebxd4/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwyEM9YG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23636167b30so37392905ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 00:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753689213; x=1754294013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5loWCTi8sLWbfgpjr5FUZEJQZnH2H/eS0KaFqLlVPog=;
        b=DwyEM9YGsyJV7zpkg8AlznGAfO60mgXjPbPMA4kJRwaLtCQK6CKK4mUD3JQVynEmEa
         VyM5Xb37k2EBm04yewtl2ow4y/xZAubjBmf9raA2IDsSGurSecqFQ+s8NBeDfaCF3Ncx
         wTBw7Yy8G06Xo2Pi02ZwZOTTOwZbRTSvRAx9V20uRk04SMPrTij0ABK85j8WSjzFxAhj
         YhChkCWnsmbcBX0AxpJYozqAndVChlkLwyAW+iqKQ1iexXZ2uzsdc6TGO8L5lku9i4qa
         rTpXqZumAZbSxkEr3pxdycoykextJFw8Cro4eGX6DnzCaf4UjJ/rhrgI76kbvRrXXcON
         Reog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753689213; x=1754294013;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5loWCTi8sLWbfgpjr5FUZEJQZnH2H/eS0KaFqLlVPog=;
        b=aaIBWI/wJfafSyMo8NmYgBHmkyYJfrLbb2B3iSivGxWlFGkKX4uTMjYc0UejRvdShJ
         yEwY1l+M0hNknFBr/cc1FgYxaA4S5AwJT/MnbKuIVvf2IEO7zmOtu1QGAAhbkQHFMLEz
         PexTsKLxvFS2DaOWkgzGK6P17Vpb75pd2G3RYQmxpMdapwdoK8jxkifUPtANoAnq5sYn
         qgVsUz6tggN0nRzv1MY4LI3syzGJlGohhyVdTdQWrsY31XpXgVhCkXPR38PDIQcT+IC9
         z2DZ6EjjKW0QKWo4Ph+eXYBYYVLA6RUCud8pTCVtj8HXXdvgI+Ycp/aGrO83tUqub3og
         VoEA==
X-Forwarded-Encrypted: i=1; AJvYcCXw/1ll2lJbpVN5D5iKPw1MNZrFG8uwfIJ0MBFmNqr4Y8d+dWXDSpp6KI5GpsV/Tfm6QeaYK5iOeyAe/Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywAcItdK/Tea3yA875WuPU7GCowKbPCaiBwtq17PSmmfAQjmLW
	ZQG4Mh9GTNqSmuIwQx1bnn1qzlhU5eqE299ykwDlHlmdfgku3P/7PByi
X-Gm-Gg: ASbGnctj27PH2SUSEQ3bJWb/DALER6yB6dk1dA3fClGBZCoGFyz404pP7upLxhHLDv5
	5LbsCmLJqxcl1p69NGuFMheSbUc0Fy8dEfuIK4fwtSOQzWICqS3Tl6jvgCAYSi/6+KSJw170beC
	nv7OUjYfN3hmzWn+ck5TiR0ypot5EDklZNdrc10P+huzWo+PYQWcZ54qCsKqgjqSPorKqZ3IoSr
	OUw5Er8iFfIpLoMWzqVM1knHWiDsgJVsSKF5EVYQTHg4Dy2t4YxfRSdmk2t8zh9LDejrNlCGS8c
	TOZGV+iUw8ajV3jXF8LewocLnallI/FYBXBsKk6NC371V4SIdcaDOxvhffaQNz2F0abr3nnaZdx
	nwp0w4QM8JAH9vrkR2A6ej4DWOsfjyueK3tJv
X-Google-Smtp-Source: AGHT+IHKusCfnBHmQMl6Lm7RUhK/1UT4+sICv+y5w2HRMYDAS5IxSyY8hGfomfsZiBcJ+xqMKxUYxQ==
X-Received: by 2002:a17:903:2a83:b0:235:1171:6d1d with SMTP id d9443c01a7336-23fb2ff9598mr142678195ad.9.1753689212918;
        Mon, 28 Jul 2025 00:53:32 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401866c2a1sm20272305ad.4.2025.07.28.00.53.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Jul 2025 00:53:32 -0700 (PDT)
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
Subject: [PATCH v6 0/8] mm/shmem, swap: bugfix and improvement of mTHP swap in
Date: Mon, 28 Jul 2025 15:52:58 +0800
Message-ID: <20250728075306.12704-1-ryncsn@gmail.com>
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

The current THP swapin path have several problems. It may potentially
hang, may cause redundant faults due to false positive swap cache lookup,
and it issues redundant Xarray walks. !CONFIG_TRANSPARENT_HUGEPAGE
builds may also contain unnecessary THP checks.

This series fixes all of the mentioned issues, the code should be more
robust and prepared for the swap table series. Now 4 walks is reduced
to 3 (get order & confirm, confirm, insert folio), !CONFIG_TRANSPARENT_HUGEPAGE
build overhead is also minimized, and comes with a sanity check now.

The performance is slightly better after this series, sequential swap in of
24G data from ZRAM, using transparent_hugepage_tmpfs=always (24 samples each):

Before:         avg: 10.66s, stddev: 0.04
After patch 1:  avg: 10.58s, stddev: 0.04
After patch 2:  avg: 10.65s, stddev: 0.05
After patch 3:  avg: 10.65s, stddev: 0.04
After patch 4:  avg: 10.67s, stddev: 0.04
After patch 5:  avg: 9.79s,  stddev: 0.04
After patch 6:  avg: 9.79s,  stddev: 0.05
After patch 7:  avg: 9.78s,  stddev: 0.05
After patch 8:  avg: 9.79s,  stddev: 0.04

Several patches improve the performance by a little, which is about
~8% faster in total.

Build kernel test showed very slightly improvement, testing with
make -j48 with defconfig in a 768M memcg also using ZRAM as swap,
and transparent_hugepage_tmpfs=always (6 test runs):

Before:         avg: 3334.66s, stddev: 43.76
After patch 1:  avg: 3349.77s, stddev: 18.55
After patch 2:  avg: 3325.01s, stddev: 42.96
After patch 3:  avg: 3354.58s, stddev: 14.62
After patch 4:  avg: 3336.24s, stddev: 32.15
After patch 5:  avg: 3325.13s, stddev: 22.14
After patch 6:  avg: 3285.03s, stddev: 38.95
After patch 7:  avg: 3287.32s, stddev: 26.37
After patch 8:  avg: 3295.87s, stddev: 46.24

---

V5: https://lore.kernel.org/linux-mm/20250710033706.71042-1-ryncsn@gmail.com/
Updates:
- Add shmem_confirm_swap back for Patch 1, and fix xas_nomem handling:
  https://lore.kernel.org/linux-mm/CAMgjq7DfPXS4PkpGK-zem2L1gZD0dekbAyHa-CPHjf=eonoFXg@mail.gmail.com/
- Fix typo and comments [ Baolin Wang, Hugh Dickins ]
- Rebase the rest of this series. There is basically no change to follow
  up patches except trivial conflicts. Only patch 1 is a bit different
  from before.
- Adding the shmem_confirm_swap back in Patch 1 V6 slowed down shmem
  swapin by about ~2% compares to V5 but it's still a ~8% gain.

V4: https://lore.kernel.org/linux-mm/20250704181748.63181-1-ryncsn@gmail.com/
Updates:
- Merge patch 5 into patch 8 to fix a intermediate code error. [ Baolin
  Wang ]
-6517755a04ae4d82d1220d690944359f1dbea686 Instead of passing two swap entries, calculate the new order 0 entry
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

No issue found with a few days of stress testing.

Link: https://lore.kernel.org/linux-mm/20250514201729.48420-1-ryncsn@gmail.com/ [1]
Link: https://lore.kernel.org/linux-mm/CAMgjq7AsKFz7UN+seR5atznE_RBTDC9qjDmwN5saMe+KL3b1mQ@mail.gmail.com/ [2]

Kairui Song (8):
  mm/shmem, swap: improve cached mTHP handling and fix potential hang
  mm/shmem, swap: avoid redundant Xarray lookup during swapin
  mm/shmem, swap: tidy up THP swapin checks
  mm/shmem, swap: tidy up swap entry splitting
  mm/shmem, swap: never use swap cache and readahead for
    SWP_SYNCHRONOUS_IO
  mm/shmem, swap: simplify swapin path and result handling
  mm/shmem, swap: rework swap entry and index calculation for large
    swapin
  mm/shmem, swap: fix major fault counting

 mm/shmem.c | 275 +++++++++++++++++++++++++++++------------------------
 1 file changed, 152 insertions(+), 123 deletions(-)

-- 
2.50.1


