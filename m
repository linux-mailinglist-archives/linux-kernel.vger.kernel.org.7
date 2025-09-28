Return-Path: <linux-kernel+bounces-835396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F1CBA6FB4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703CC17BD04
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D8E13C914;
	Sun, 28 Sep 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DlYpTOPO"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CC635950
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759058248; cv=none; b=BpMq/9dIElVNcXrVq9JlO11Tdl4oV8gng/gUXfLHZzNv1omux3sKJ1vTe7MfumVOVyodyIvYfWYN476CuVF9NcBZRjCDSYnGMwHAie3aXs6q+X7AE58knKKYk6GABy3oLACyOZjDtwjlEYL5iSpjhXDE+THO/nns2LRxyeyu6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759058248; c=relaxed/simple;
	bh=Lq13RtqmlhJl9Ou+QEU3MieDQg6z9OoQMyTcDYFUOI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bx6/fj8r8cIhkhvbe/LhggIL83gUiijONXJ6LQI5qhho2Ff6KBt4pXgbcZmIneQgloEu6XVq+DUAfd+a62vj1fZ4cFlTLU5mR9ZnBJ0at0B+Iy7h7Q870Z7GWX0CckwIc7wnwQTAGYoTs9hFTfcXUvpsbVpkR8lg8c0bo/7bgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DlYpTOPO; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b553412a19bso2713026a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759058246; x=1759663046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BgJ4Bk/AgLj8OXwTMGRn+fyRsVHIEGunbuVkNEAkF+E=;
        b=DlYpTOPOONNOaAKK/YzDuJDpwCIuB1r8o787VIwJ9zRHu8I/Qb4aknmY4BVlkIH9z9
         uiVAWsB0Kbe4eagHpqSBEgqKxwdmUSGgdnVxSRdugkBvdo1z5wAShDJMMuLj5fhIVTAO
         vKql9FVKyUZtWo+KdC1aJqVN694aoCpqWMQQ38I3XtrDojmLNXQWZnBY7lY1pyhJZq1p
         dwzhJvzQeMhDvKwxeHlUujYgu1Br1udrZrQC8cNoLaCtxm4Vpi+6/6mAiXANHHgZuhVO
         qMybYkShEUvtuzFhmUnWMH1xT8OpQm/zv3z9TiDlwMjNTGo6cvD/PK5DWDz97ky8qBe6
         UYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759058246; x=1759663046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgJ4Bk/AgLj8OXwTMGRn+fyRsVHIEGunbuVkNEAkF+E=;
        b=v3OD6Xt+9Uh8j9ND2ePGqEjCnYacoUc+qpfqTm2K8OORN3IMMDDRn8W5lFmCFATqQO
         bW83oI+F3NZNWCvM/lprHPaTCU2v07ttOzbGmR1DcwR6pqyd4bg/dDbdT20hCvyEouCy
         B12xvqt8/Vs2nI207Qpen7C4S39QfJmegnPvlbmOUOEPFxGnKFPzpFmLdM3eL63jVP0/
         PEBBubpy1EfbqYRtVGxjuImwBtQge5j0NYiDK8BBB1c4s28ox9YW+8vbDb/QASfX9YNy
         S8Q+Cn1sX5Abocic32gEQyyaUK1A4NgTPhO+cGzpE/CTz/h4pxmXcZIWM3FWistJVPWz
         W4mA==
X-Forwarded-Encrypted: i=1; AJvYcCVmhmiwIM8OqRbmAvZYN4RBePUmkK0SfyUu5OD3NJz5iEyle2tubZVd+fgI0NBEPD0Ihuev7KwgEfrMUGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqOCLYLMS6bA3K+yjYOZnqjya7GwseDEkWArx9RTwg8B5JIWV
	veIbe0j0+PZsq0JP1isnSr79rjBWGbiNnWU9wRuVPi+6YFdnSAXI08Ycyks2fww3RiY=
X-Gm-Gg: ASbGncsPZLDU0Fvwkqbj2XO8OTqS02VwYisHmfXMmPnt4H3uY1c68qFgIOjVV/c6cCe
	USpDBnJ0Femn42EHmtW4kMHsB3p1Un7+JL3IYZGty8LpENk9nCx2reLITiZMn7CBs6YtEZUrQUg
	n64adm2QZ0hvS8iJiZ2JCggCzXxAJJO/LNImIOonoYN5dOgCE54TfEuTNnIOOth1hWjM6oHzAMF
	ZmXztglxazECAfECvHes9qLLR/nmJE0e+IxaqkdVCRrWXvp3y8brjbcS0CpAuRRHvxnas0jGroJ
	sGsHzciyZpC3JPqwVnGC5hCrIC0JDLkhnsptr8AZLs1H1HTELdtbPvYLgF/w5makrEVlZxto3fi
	xRxWeoFWM83/Qu/Vctn9sHHvh+xvdRCZzBTQg/ogOxVkXx3skCzYr87ppZN/uLKnUc/DFj4bncx
	4S
X-Google-Smtp-Source: AGHT+IEIBgcE97CoXC2cuv8USSawi1baX2mBvmMGwoHiSnGzF1+jN6Y2AS3XpbKZjXh6B6f41EZZsg==
X-Received: by 2002:a17:903:1b28:b0:269:ba8b:8476 with SMTP id d9443c01a7336-27ed4aea2abmr148101555ad.56.1759058245920;
        Sun, 28 Sep 2025 04:17:25 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a2c45sm8687451a12.45.2025.09.28.04.17.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Sep 2025 04:17:25 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 0/4] reparent the THP split queue
Date: Sun, 28 Sep 2025 19:16:58 +0800
Message-ID: <cover.1759056506.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
 - use css_is_dying() in folio_split_queue_lock*() to check if memcg is dying
   (David Hildenbrand, Shakeel Butt and Zi Yan)
 - modify the commit message in [PATCH v2 4/4]
   (Roman Gushchin)
 - fix the build error in [PATCH v2 4/4]
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20250926

Changes in v2:
 - fix build errors in [PATCH 2/4] and [PATCH 4/4]
 - some cleanups for [PATCH 3/4] (suggested by David Hildenbrand)
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20250922

Hi all,

In the future, we will reparent LRU folios during memcg offline to eliminate
dying memory cgroups, which requires reparenting the THP split queue to its
parent memcg.

Similar to list_lru, the split queue is relatively independent and does not need
to be reparented along with objcg and LRU folios (holding objcg lock and lru
lock). Therefore, we can apply the same mechanism as list_lru to reparent the
split queue first when memcg is offine.

The first three patches in this series are separated from the series
"Eliminate Dying Memory Cgroup" [1], mainly to do some cleanup and preparatory
work.

The last patch reparents the THP split queue to its parent memcg during memcg
offline.

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/all/20250415024532.26632-1-songmuchun@bytedance.com/

Muchun Song (3):
  mm: thp: replace folio_memcg() with folio_memcg_charged()
  mm: thp: introduce folio_split_queue_lock and its variants
  mm: thp: use folio_batch to handle THP splitting in
    deferred_split_scan()

Qi Zheng (1):
  mm: thp: reparent the split queue during memcg offline

 include/linux/huge_mm.h    |   4 +
 include/linux/memcontrol.h |  10 ++
 mm/huge_memory.c           | 236 ++++++++++++++++++++++++++-----------
 mm/memcontrol.c            |   1 +
 4 files changed, 179 insertions(+), 72 deletions(-)

-- 
2.20.1


