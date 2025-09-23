Return-Path: <linux-kernel+bounces-828686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D17AB95320
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D2F1900F68
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A892F5320;
	Tue, 23 Sep 2025 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="InAwZqWU"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6731BCA3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619009; cv=none; b=bjLdB2JaGUQggqRv7PEViexPyeoQFZuk37HN2QX/EO6tOWciqPmuT08KOqWnq6IdgmONkPTzKyEXdIuCe6BFMJmb7iY2eSod1dRwI6LybMI8uVCW+ODXKpKraCK53JBrYZvaxpC1Kz5CexDL0vUYoOQM9EVrJw/Dg8v8FEu/aCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619009; c=relaxed/simple;
	bh=BqV7fnshOuZOLvnQTQDzPqM3jHRWFgEzs7aBVAUhzrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GaMIblGhHWD+JRt6SQ1hdENCe4v5Q9RiqGpr5nB3AYbclMBOyZKde92T/psHCuhhSlMkdh0vVL8+KlvbHe3HRvUI8zx/BsPQ1UfYiU525qGn7Jc2LB0QSsvgAOyI1r6+EN78KazBA+UvlHqdpNeMcbL6UG/YosAX0mJ4PfPElwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=InAwZqWU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-267fac63459so50715435ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758619007; x=1759223807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mMHBSR6iVN6xpeCcQzalGxMENnFCjeMLhkVbx6JQl4=;
        b=InAwZqWUOV4DkuiebfzFy3YvX3aQIXJCjq5zLEZ8rHuQtg0H6evzj/e1ShkZ3sPMdF
         qRdg4OiUrJzmbV27uBFZGk/ELQQfFI9J5I679TeTwYg6aMAsnLvpCc+7SXLGA4YOItYW
         04sbQbShSfZ/BMcqvGPM94A958muMpUOXR1Dt/D+rYt+x2Iu45Rd39X8uHoszkZYfcqm
         Cu7NLgthrpOiHYgOatWyyPhohuzdrkpnWWBvGwrvu0aWKffwot/8vOm8VxJSTySSaJxO
         gJwfAj2qVjTt2lZmn2dINESgiClWMSzbwR59mZICr+y2xDGXsXsMhrtwIi2xahclwgBJ
         M0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619007; x=1759223807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mMHBSR6iVN6xpeCcQzalGxMENnFCjeMLhkVbx6JQl4=;
        b=fC4jxtc6Y2of4HaM0KFLm1UhKLIC/6PR4CP2cQ33EMFiTincJEsDdr+iwZX2fhsmc/
         LJJLQGf74v5csDCQcOjJB0ZeLlzCheb3mAslNGU994e8E7NLKn2QnryZ414yk8rPTFEU
         1ZFB7EZ4kHrMuHALerQB/0+e/xIfszaBpobt9pG80GWZ9GtVdlu5B64rDeccp+Et25vJ
         Ib4Bu/+tt/Qx3Ra7J5VRQ5M6N/+Em4AuSdiG4armRBHK+LljfdRN/crWehGEpw8URx0s
         lWnLMO1+TG97ThlvJoKRfnNlRRg+DoRXjtJrjwq0fkCXz8QwMUuM0fCKSqyL+DjvLD+r
         y5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCW69L6RQ9wucwmfGSDINoHL2Ij3AdqVYbtFP7OxjVwJPme0F26vXDqvv1GnVtmhGciB/Rf7PF2Dxra8mXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpRTdeLUYgZMyMm2jBkJFZj7mp4jqKiiHpX0DtefiNPfh0HQSf
	mhphSegI/Xm9KX50lNmU3K5f+XQp2OQPGETgOmOxx/FOQee9Uu7V507AlFFIiggn32QvAE8YsKI
	c4Dwd
X-Gm-Gg: ASbGncvbnDuphUOzuCE1TPVXiAlQcr98b18zOCiOUkEzz8+RyuUDbAY6rPn89OvfY8T
	NoyoA+17huMBhNt7bS9M9AMIzuA45T415SoIfvCRWOKxYN/7j5zZ3tMhcASazk+FRX/uw8w6jQn
	prD9dploHYNdanONUtDI/a1Ng1RVuRG4mBLSh/Av08lX8BsJkvBN4cajar716ghfeLvR0/JOS85
	PoPpGzawCqEtve67e4zq7H+NdwdaUPzxLejRf6MHMDnLNVR8AjbZHL9P621+FxMoPOk0+NMuXHm
	4A16QVIbcCBzYP3zXmou3052i/ID4xxk1tYzZqvUvSnU9nXuJyzovs4QKZ0mCPv51y8G70GmTMg
	mMlQmpEPywpu9ok7t5ax/10ZlzIXLC129S9WudWScPoTWzlxb1NGN37yPcNtSciDEvYd/ySV1Bb
	SVjedQ8g==
X-Google-Smtp-Source: AGHT+IE+pTyYnuUeKNBnXn7u5n9qqZquO3ZZc8vyWV1I57TGD6s8tCb5Ogkdy4UaIq5TtfdFMCYfeg==
X-Received: by 2002:a17:903:1983:b0:24c:da3b:7376 with SMTP id d9443c01a7336-27cc2d8ef77mr24868675ad.26.1758619006912;
        Tue, 23 Sep 2025 02:16:46 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26a9993sm18724713a91.11.2025.09.23.02.16.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Sep 2025 02:16:46 -0700 (PDT)
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
Subject: [PATCH v2 0/4] reparent the THP split queue
Date: Tue, 23 Sep 2025 17:16:21 +0800
Message-ID: <cover.1758618527.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 include/linux/huge_mm.h    |   2 +
 include/linux/memcontrol.h |  10 ++
 include/linux/mmzone.h     |   1 +
 mm/huge_memory.c           | 229 +++++++++++++++++++++++++------------
 mm/memcontrol.c            |   1 +
 mm/mm_init.c               |   1 +
 6 files changed, 172 insertions(+), 72 deletions(-)

-- 
2.20.1


