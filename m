Return-Path: <linux-kernel+bounces-796955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A28EB409EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF56754366E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B33C338F35;
	Tue,  2 Sep 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnjJfQZ7"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA6A32ED54
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828678; cv=none; b=Zxgyu3qmb6Y9sdjuCqm7jc+Xu1rosUbeWyLRd9bgEL2EPx0pjjoXnx7Wy1BKcpx3jaYDgJ+5bCjczWH2NBwRxJedy7/1Gi9sGBJTuqMkoeMAAxo8N9Jw3cgy/pqEEIWeRrV5F52CxVy4CMS4qMgFhBdrqJrjSfwbD6Tel5vVKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828678; c=relaxed/simple;
	bh=mPMWDz+8h3MDqxJqY4ZbFAjRY2qvbs6Q/t61BwH0aSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLUhiStYZjWcjaK7AebTAgBXD5K93jpXSjyZ/ljWyKFSpTvupj6Y5dg+77j2IwAE1uXExziJwEyEhmcQOWj9VtkRTAv3nTAOhRctogLrJbYAq61i0hqFZN3VGdXOshMGpVmRPfPBc5CLbIuwV5jmkMdVEbtNhBtrj49R5n3/j4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnjJfQZ7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so38468475e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756828675; x=1757433475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6y56X8OUTmSoo3VKz8VzAATzZ9BTMxyuZT6xksXOKo=;
        b=nnjJfQZ7LFv8ENIBnbdD5M/HUw3rNFm82wrf3kFPfpRaIRZEdy19QOnOLGrt+Hoo16
         KF4ooNT3DmCRy6CFREQFANLafJiuNJ/5wp78olqBy7pBsG4t2mwJdyKLhrUDGzM6LsRM
         DV6tkI5PxM0rFP3+UevwWVa3i9AxbZh5Oicn3cSXyJAxG2wdKa+LwGokCVTdFNVNIeyQ
         2ew/XxdeeU9OIy3kCpSJOuTzg7AWrzyNvn7uEmxOOMBBYQUJgvsAA2sJHE5H2lALjg/P
         fjwZIQ/DiDhYx4HqPnQwAUH9EmsArICtrlPaXvJSR+QcOw1M80wNwoN8eXn5qezFU8ls
         WlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756828675; x=1757433475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6y56X8OUTmSoo3VKz8VzAATzZ9BTMxyuZT6xksXOKo=;
        b=j55dZJo6iJxnG0fy5CbOz+7vJM0YYDguWrizbd6QuWQKqrcnOJ/XzSdOrgDeD7Al57
         nmwf8QxgOanlzHWQs1oQHrPpb3ph0LSbiYp2uTCijiyiPpsmk61lVdz88vHudiPp6r9m
         M7LysWo5YxiFZAbAxDS7Ene6WvmmFPd/Wqb97btZfA6OJfZ1A4SBLMZNW7rneaQ5bXJG
         +YMs/SLiczUQXzfDt+viGWhHsmsK2z9fxfBS3Hf+8Z12yZ22W3YqWFno1Y++sb30Bdbq
         +H+sKkTUQ8t0/p49PZkIJmDpir0s+YDTdoozcDYU5Efar9M5uCxnE23fjRl4GBZrEk7D
         Jwsg==
X-Forwarded-Encrypted: i=1; AJvYcCVOwG5xxCpLvRrAv5XSX8wvPQ1ljnD1NWu2zEk2uyhXylkNroAVhHVCXSusvvvZqSpslZr+8KD/Rgn/iWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ywcUKiWC0Hjb+bOUW2yyZOZmgaOjZazY87Yo2FZpEm2mn2aU
	HK2hkREEpR9LqrjXYeiriLAhYvvmpedIUH4SQSLiYfYIShGgP5y5qC9q
X-Gm-Gg: ASbGncupZ7+FZtCu4y1Ng9PKzXV4IvQllqtLl/123y/WYkEdkGA9E/yuceD43py0UYU
	Sl9TF33yTwaQJ99v35OfLhZWwoAcH++XugV9rpxlcCU+x0iU/ARuVEqwWg+kQAOvxLxglkZnJqt
	OmYw7j1G5klmtydCEB+GKCU8Mzz9wtWN1GZmf0Jbn5RY4gayjx76Rjc4oExiuUlai+ReESzqrjk
	8E0JVwlUAnQN4nnWhvwoQBJSo5KFpphKhMn0EUX1gJT/aAaRfKBsGWrSD3cX+E+HlEru8wDzAhx
	ZjtBATMUx44p+6p+yxr1x+vY5d31lBHIeUJZ0Jw3wRpV3rVGDmZrAzmwmJMqfp3R8QH7/kEYQwK
	mwhmyLuLv/FOvepKMczKF956GTA==
X-Google-Smtp-Source: AGHT+IHdPfNYaH9+9Q+ni6q5vuGRLRXreFcdRGX5aH2suTfhR9z0SYDmT0xWmddLPp0M60fE9SBktA==
X-Received: by 2002:a05:6000:2283:b0:3c8:e9d3:c392 with SMTP id ffacd0b85a97d-3d1de3bc74dmr8652135f8f.19.1756828675091;
        Tue, 02 Sep 2025 08:57:55 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34491a7fsm19642743f8f.57.2025.09.02.08.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:57:54 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>
Cc: linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/show_mem: Add trylock while printing alloc info
Date: Tue,  2 Sep 2025 08:57:51 -0700
Message-ID: <1491df0ac12a7626b7c9b00e26a6e10adb8c9045.1756827906.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756827906.git.pyyjason@gmail.com>
References: <cover.1756827906.git.pyyjason@gmail.com>
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
patch adds a spinlock and invokes trylock before printing out the
kernel alloc info in show_mem(). This way two alloc info won't
interleave with each other, which then makes parsing easier.

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/show_mem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 51892ce2efc4..4c876ea2b66f 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -396,6 +396,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 
 void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 {
+	static DEFINE_SPINLOCK(mem_alloc_profiling_spinlock);
 	unsigned long total = 0, reserved = 0, highmem = 0;
 	struct zone *zone;
 
@@ -421,7 +422,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
 #ifdef CONFIG_MEM_ALLOC_PROFILING
-	{
+	if (spin_trylock(&mem_alloc_profiling_spinlock)) {
 		struct codetag_bytes tags[10];
 		size_t i, nr;
 
@@ -449,6 +450,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 						  ct->lineno, ct->function);
 			}
 		}
+		spin_unlock(&mem_alloc_profiling_spinlock);
 	}
 #endif
 }
-- 
2.47.3


