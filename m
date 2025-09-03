Return-Path: <linux-kernel+bounces-798360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F06B41CE4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537B668074B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA92F9C29;
	Wed,  3 Sep 2025 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvsNiyI+"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B62ED865
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898182; cv=none; b=rQ9DMTCU8LrCdMZM9mSkqQVIhKRcwvDEzKHudeuYqq2xBjlnv/2A3ORgqu8ssBmuRMlXfmezFq8qkPCOUHhuW4WWg24sOF89ocx3fHr/mGBGQduOFdO+R8q6ZDUhr+460XsPr5tHdLs+aDFwUOz5GrjVETgGDdWqwLGdrCDW9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898182; c=relaxed/simple;
	bh=0MbW27vGMan4p11LIYYvJ5eAYHxjXLPoS4aEwEKlJTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCdFE++t4vO/dPzyk76HkpVGpg8c+Yynw8cVV3Q2pLGD+ffRNVgckDSWyXO91pb16IzyIKcOIOyzHJPucC5zaObWEDcHuQAwdqs6RN6qx8nkEfBpTcVb3/z/QkE5HljatlsO3B31SG4ByEjyyXPEjrwMu8nn3FBUR3cFM9DltVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvsNiyI+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3d48b45f9deso2279020f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756898179; x=1757502979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/J6B5kO21qmim3edptXX1lboSXT3A4ICQCYNPP7b6E=;
        b=MvsNiyI+LZc/2PU1krxw4Vg+P37iwaydnUs+RqSzmUArmpYL/GjKs25kWlv+21GUjD
         /rrYGQRTm0RG2UMi2YQqc2uGinnRT0Qq77sNDGNq8zEsjlbAXSeLwR2AMpKWb68fcE5F
         xYAQZsUF0HOnI7Rl07xZ8WUnTihUxO0Sbx2YWiTZapGPGA+6NKySdUKwNwdXwfLkEEVA
         hJQGokTRdWF97i7uBTolB2R13dcVTOt+ai1bHXiMuZ88m4JCPEkbVZXWHEqsOFwUtP3x
         w9LarpdHZ7r5NYBkj+4K5ZF/mhPQNKdPLO+p4c8fXJlY78ssd+7BfMB16gKkMwvrI0Rw
         xfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756898179; x=1757502979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/J6B5kO21qmim3edptXX1lboSXT3A4ICQCYNPP7b6E=;
        b=k+mFseg2F9y0RiKVB3koFZRHpLJ0mFkaJ0NOCS3V1vGDGnfhQBKTWnDJXCxJnE0cOC
         K1XoU2fnM1E8QdBlCqVaSSyhxMsj+wFPe8EfIvEwzhq3m/WquRG6zajcNDgx3vEJnc2B
         U5HgGxbcrkJG+rYKWBJh+0u36jOt+sSZepafYWJHc9XYG1ap24shFLDY81aXTCDbu6Qi
         H1aFhw+ywQLS7ToAHYagEg/25l/K1O43f17t5o04jZ6Lr/Q7EvlshSxQ10NJSC8pt7vw
         CjA7UY974TlDX2G/Fb/+ZbiIWtIAz6VPAJoPIfTSz/knjSRu0cwqnPfBB0dTxd19MsQ2
         OUrw==
X-Forwarded-Encrypted: i=1; AJvYcCVWIZLctOiNfx3AK+5bY1XFvpajt+Ukwb5t5EAzijxIG/ag0Z3vZOCO5nL0ppzvVm5G2tywuvSgodqp8GA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk+7JG81e+TUoYa5QNMJ8qIMngfo2k+XCjePQtOZjNxT/LkLL4
	wHo0LXPIWwoVZNxnP8+GUn8ZVxACBGJpuhakdq24dAqsWchxSqOa4o6J
X-Gm-Gg: ASbGnctUFnOkmsLoInnDtzIR5eE8vom74r9OJv4HB92p4UODa5uzA+M4cuexCujGEfh
	FemZBv6ALFARGuHgcJjOdarmg50fikewNuuisJ6h71lRZHs6Sh4CJ7mDCfnKL4zQ7FrM5tukNMW
	ZWFks+zEG96EZzlN+6JUhsjaw1QMReRFHiROrX6MIrHG8Q+N2TUC/Fdfe444HvOcqgmgH6yhAf7
	4ABcgmfBAgPTj1ondnjhIB542JO9hu+u1yQImzpn5fj8YEnXaBDMgoYW3D98vmTEFZHurBZ8aD+
	ee4k8P7KeX5RiklMC+FCCfU0jDxZPxzmdd1KJxc6UVR1waDlLE0d07sAxuQXnEVubbRHE0e7qtT
	eeGfAgJSDOE6Yg5PvhsY6G7tgZg==
X-Google-Smtp-Source: AGHT+IE4XJp50UJAl1TyaOPKdT+BVYrcIKTmTgL9yNbuNNlBknPz1bjnwok/rktMidIrBE8JQNXNTA==
X-Received: by 2002:a05:6000:2909:b0:3d0:e72d:867d with SMTP id ffacd0b85a97d-3d1def6a593mr11880201f8f.53.1756898179208;
        Wed, 03 Sep 2025 04:16:19 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4e::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7c461edasm144127605e9.9.2025.09.03.04.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:16:18 -0700 (PDT)
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
Subject: [PATCH v3 2/2] mm/show_mem: Add trylock while printing alloc info
Date: Wed,  3 Sep 2025 04:16:14 -0700
Message-ID: <4ed91296e0c595d945a38458f7a8d9611b0c1e52.1756897825.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756897825.git.pyyjason@gmail.com>
References: <cover.1756897825.git.pyyjason@gmail.com>
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
 mm/show_mem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index fd85a028a926..e9701d07549b 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -421,7 +421,9 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
 #ifdef CONFIG_MEM_ALLOC_PROFILING
-	{
+	static DEFINE_SPINLOCK(mem_alloc_profiling_spinlock);
+
+	if (spin_trylock(&mem_alloc_profiling_spinlock)) {
 		struct codetag_bytes tags[10];
 		size_t i, nr;
 
@@ -448,6 +450,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 						  ct->lineno, ct->function);
 			}
 		}
+		spin_unlock(&mem_alloc_profiling_spinlock);
 	}
 #endif
 }
-- 
2.47.3


