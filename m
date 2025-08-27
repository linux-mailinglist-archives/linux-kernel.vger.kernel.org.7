Return-Path: <linux-kernel+bounces-788745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F8AB389A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477BE7C1B32
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971EC2EB85D;
	Wed, 27 Aug 2025 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY4/5mdE"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4152D0C8E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319671; cv=none; b=mSgclw0fXKJ9xHCcbtZv5dEIjR45/Zyt0uuu7uXITa2e21P4m5eyDaAXLL0BpXDEuWl9Y33KSJsdhJXFQIX6TyHXnCQ5lgfiezoNQR/ZEhJrqmJRPr2CFJjJXLNg9H49+PrhVma+0cL0knE/CHXDu5MQekqW7Q0DxSwoEtt1RCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319671; c=relaxed/simple;
	bh=nJq64zCCsCh4Yq3xI6XA8YnoA3McWGqAk1X/hBQmSN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ri8xfTMg08iLMc22DXyZAmteIr5e8FCwnDD8ArlYgguoA0uKrorLQPyd4DcLOyOpC8OTMQrYGf7YPzscMtLr14L63BnDnZkMiABwdc9SdCqP9LJxynqosV2//8nTfJedgLwCWPi39ox3onX+qsRwCh/wwGK54QRnwzz3QVPe5y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY4/5mdE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b627ea685so955335e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756319667; x=1756924467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YA6lB2OHRh04z8ztLcpTUu2sKqTDk2Id/2bOxOEc5ac=;
        b=NY4/5mdELCgn0ABh67K1V3lzc/T7Y1/JJ1J5UWBZE3mN4b6NGYQMFeAB8bNFpNbUqT
         wmfSFdJuAnBRUggvsowiUSuTw7bd5T2tYZdmSYpeTqoKK53kiNjF4dhLKOSukghh3aK8
         TRY4hBkjoLywX9PKhfq5w+7hretnqx0Y7rpXwRqqx1z56g0+7NGzXBriqq76qCxDlS1y
         sSyOOmOeQSOxZiDaVCe8LoQi0t6mg907GMBIi21p2/BeYukUk4wMFd1FagEahhHQQ9iB
         SmzJcX3DGoxuEUePLr9AK1P7yoJD5Fz0CMZgJBrHkaff5/CWQ0IK/3mMK8UQsvM74o8q
         q3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756319667; x=1756924467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YA6lB2OHRh04z8ztLcpTUu2sKqTDk2Id/2bOxOEc5ac=;
        b=mN4oYAPLtfHxrv85+pqZZB7ruKmX5v3Er45wEW8yGPVBsw2kMpZPrBRsplLazEA+Ov
         5aDeHxdmN2r2HChXprEmpLvORtCSBC0Ipn/IaNxuLZn2ZuXgpq07gI2VQQ9qMufJRiuB
         NLdoIhxBQIiqVvRxlZD1dcYrhB6jKVQ69VDI51KpLGJENO4h+A4T8C0OAqWaQrGvmb8Z
         KrsLfzZYUmku1ppjT9u6fR60PtqkALv3p+l/SZrNIRDiML2LU7Mew39ThAu8DYqRjTzR
         cB2ehcLJ9OAqoQJyhsB1hXAs46SWIKJ3qGCW/QMDW9Qw4X6GnDP7xtx6KJtOEbI48h52
         C9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVtLqr/h1/ILlcrE7IxzbxSsdiJQgNTgsVnh6BrVbcC2S50ASVExO1QY1ByniNx+9t6tR3Zb3JOraFf8HI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRKFnxuO2v7q1qt/CLEf4S6qWsOrVjcVUDUD7c6GkHkR5kSIWo
	dtHe4AViFkQLU8PGB+tyg1zdlQ7ZjBD/vc6FA0GpOeYbon0PwTAKRv2Z
X-Gm-Gg: ASbGnctpzIkUfmFsf3LcYBpf50Kuyzdd86MKKU0ZZrN7B2s3koyFwgwShi25qRSCCym
	dSfNPtNaYfu5gbnfj0ZZ8obgkvB0ggh6QELg7RrycTeBSxOFHPjh79O3/TV2akK9025W9GoXJU9
	qCQ2xJdLpOyeKhpTe4KgW8HPVBPPhD+kF8v54bZB/+46slI5Cyehat22D9HFroo4DjtMhhKnYDz
	NnuArCyCN1ERJGZDB0vSYlKseAjrK73W7EGMGGERv+vh41/vkZ/hkMYWe0IxDr7BwgLHePF/qX0
	2NaIfHZebtedZe/kJxDa5DyVYBxgRspRN9FD+Dx/7Hz4VZno4Kq247kXL7FiMECU+WsiC60jLqh
	dEAHVuNJaaCA=
X-Google-Smtp-Source: AGHT+IE0hXtxhpjlhfM+hRo7ji39tkDJ8DWU2BUHg+pIVaprTDiApHeE6ZCxx0FjYX9RgVOZ2NgUxA==
X-Received: by 2002:a05:600c:1c14:b0:459:d780:3604 with SMTP id 5b1f17b1804b1-45b771b5ca1mr1652945e9.3.1756319667550;
        Wed, 27 Aug 2025 11:34:27 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cce1724939sm3580972f8f.26.2025.08.27.11.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:34:27 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Usama Arif <usamaarif642@gmail.com>
Cc: linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] mm/show_mem: Add trylock while printing alloc info
Date: Wed, 27 Aug 2025 11:34:23 -0700
Message-ID: <7e2bc96faab1a338829e549246189ad96e6c866b.1756318426.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756318426.git.pyyjason@gmail.com>
References: <cover.1756318426.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In production, show_mem() can be called concurrently from two
different entities, for example one from oom_kill_process()
another from __alloc_pages_slowpath from another kthread. This
patch adds a mutex and invokes trylock before printing out the
kernel alloc info in show_mem(). This way two alloc info won't
interleave with each other, which then makes parsing easier.

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/show_mem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index b71e222fde86..8814b5f8a7dc 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -23,6 +23,8 @@ EXPORT_SYMBOL(_totalram_pages);
 unsigned long totalreserve_pages __read_mostly;
 unsigned long totalcma_pages __read_mostly;
 
+static DEFINE_MUTEX(mem_alloc_profiling_mutex);
+
 static inline void show_node(struct zone *zone)
 {
 	if (IS_ENABLED(CONFIG_NUMA))
@@ -419,7 +421,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
 #ifdef CONFIG_MEM_ALLOC_PROFILING
-	if (mem_alloc_profiling_enabled()) {
+	if (mem_alloc_profiling_enabled() && mutex_trylock(&mem_alloc_profiling_mutex)) {
 		struct codetag_bytes tags[10];
 		size_t i, nr;
 
@@ -445,6 +447,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 						  ct->lineno, ct->function);
 			}
 		}
+		mutex_unlock(&mem_alloc_profiling_mutex);
 	}
 #endif
 }
-- 
2.47.3


