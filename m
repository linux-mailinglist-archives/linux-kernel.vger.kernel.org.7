Return-Path: <linux-kernel+bounces-798358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 155FEB41CE2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C063C1891F66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3803327C872;
	Wed,  3 Sep 2025 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoItjqdG"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78DF27A476
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898179; cv=none; b=K0vqywRUcrVnRywOgYngOTVNyYXC0aZ2FlU3idNMWJ1RLlbBrTKK/Wx/wd+aCE5ZJRozdk9VbgeViF6ew44cop8A2a6PqhoyfjFQQjoRRnAQ8feUhRNCqXoE0o3Bw9a6Xuj8zDGS7WfPpfe+LovC/Ndo54KC9vM9zdJrJC4ipD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898179; c=relaxed/simple;
	bh=X1m9re2xsUopW+/uXEtIzl27y2I/unOofU4D4qv8Cek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgQ4oyvYWPlTARh28/XVTq3eao6UYRAOfxVXZtxv3dL9IGujlXmSJkldDTSMUF2BI5KyYspucsvGbWFUq5zwZVdUMX6gNOE8EIGvYa5c+ELxJ3qgVN3P+ylYnX6EM15XoSSyT+/JN5y7jinT67KNrHjhfZ6JtkI4c3MlDBzIo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoItjqdG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3d1bf79d758so3404991f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756898176; x=1757502976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IawJPEnnD+zQoWDwMg2PB+cX173xGR9WtQhvZ5+6Z1A=;
        b=BoItjqdG02/zXDlqRiSVBSOBIWiOsOqaRVqSMcmFumZeOpUFZMkXd6GH/Fb1JtJSpp
         mXP6f1ZXzLurAMLS8krNosteXUm4vNJLhbIIyIZlxQ+xORiAfGjj1oZwGCxBve/xgLUI
         jJ7bKX4dbxYtqd/Ir3oTT8WU0Ib08ybdPZLYgBvlpKdJQGpFHQwVM0o5IU+V7mw99FQt
         //dUCNt90P6W9sHsew0SbLYZaKZzWTv0h7u+yd8sxiTYUHET3NN/LJIlU75/wFB+K4pN
         zgW1c0jW2uXAqkYopvS9iLRZxPkxDUMakICp70RpAwbPj45jf1qbUscsnZJcOt80tDco
         7xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756898176; x=1757502976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IawJPEnnD+zQoWDwMg2PB+cX173xGR9WtQhvZ5+6Z1A=;
        b=FQGJ0mjNSG3Yjfrd/mP1Aspidn8/35tJbnwUjwbikDW6wrWQthIpY8mZ9VclGhp9/Y
         dYbJvy/yzXf7/NBE6lsVjvvUIMfJshK7vAhvn2lnh/hdwAThrbB4SDXtVVM9rmDPr6jg
         vl6bOx9QqfcEnAmaStN/4F0A6YDmXik0a2Bw2JtPCxTGmm5/4ebRjC6TUdfDSWfhBCdq
         qmuWYrRzs5ews8zFWbB+YglEVnQaDaUKQh3L+HQpkfDKCjKvovixXWEnOWv4p60ndETM
         Bd6lNRba8LMOKPnsHBD9U3MAd1u+PiYKFwOEl9OWbXNFJ1PxWmew5H+9LoDFJI9dljYN
         0l8g==
X-Forwarded-Encrypted: i=1; AJvYcCW9Rq9NAIokgUeG+d+LB+9pele/cjWUPzYuq1XTFb9EiRegZvj/KtYG/qS78EmCZU2ytJphwg4sqf8/r5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbHs172C7X6C9WEnCtB/xX9lLP7YIZB8gSkX/XK+Vpa1YTN/yE
	T2ZELkLkLPg8eE6xhdgdHDB/5UT4RkWJwdNqH+BXMut+IzABkWz1tjHe
X-Gm-Gg: ASbGncsbRz1bC6/ITuceZugbxpz5pc4y8mdO/pROC9NeOobkNBw7R5sNycC+VVz9sax
	pSITNa0NxqB/7W7r2Ar3hxeCE84lcArRPKwgj53bRRIohwAGNHNi0jE7LZGGkgjJf1oGVAV2fuR
	vEeSFWIgpgObS2wDnQFYXE5WKKaMrUk9lA5B3RAaYuA1IeV7KjtjPZ8W7QPEAdwgn+l65bhGsJo
	mIRQuCjz5tJaiBsmdNP4fW6yJJOGKzNelM3lIeCSXj4o13lmZ8615SptCtPXgfzBfQ8yWMcdVgJ
	essOaclbnPyi94hydSQ/yXHGmTTozZNNKqqbJdrrTlh+cLcA/RFyM9CV046fDtskMV5qTMCPiSa
	CDT8Frrhzy9YKng==
X-Google-Smtp-Source: AGHT+IHNQ21LyL2/gZs64T7xHnH8p7OTsvdJjGM0qkn1zGoDSIWZgH+oIJasMsXQJ3GSsanQDA6gig==
X-Received: by 2002:a05:6000:4203:b0:3dd:ab51:d979 with SMTP id ffacd0b85a97d-3ddab51daacmr1895318f8f.10.1756898175758;
        Wed, 03 Sep 2025 04:16:15 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d92d51982bsm8038216f8f.21.2025.09.03.04.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:16:15 -0700 (PDT)
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
Subject: [PATCH v3 0/2] mm/show_mem: Bug fix for print mem alloc info
Date: Wed,  3 Sep 2025 04:16:12 -0700
Message-ID: <cover.1756897825.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set fixes two issues we saw in production rollout. 

The first issue is that we saw all zero output of memory allocation 
profiling information from show_mem() if CONFIG_MEM_ALLOC_PROFILING 
is set and sysctl.vm.mem_profiling=0. This cause ambiguity as we 
don't know what 0B actually means in the output. It can mean either 
memory allocation profiling is temporary disabled or the allocation 
at that position is actually 0. Such ambiguity will make further 
parsing harder as we cannot differentiate between two case.

The second issue is that multiple entities can call show_mem() 
which messed up the allocation info in dmesg. We saw outputs like this:  
```
    327 MiB    83635 mm/compaction.c:1880 func:compaction_alloc
   48.4 GiB 12684937 mm/memory.c:1061 func:folio_prealloc
   7.48 GiB    10899 mm/huge_memory.c:1159 func:vma_alloc_anon_folio_pmd
    298 MiB    95216 kernel/fork.c:318 func:alloc_thread_stack_node
    250 MiB    63901 mm/zsmalloc.c:987 func:alloc_zspage
    1.42 GiB   372527 mm/memory.c:1063 func:folio_prealloc
    1.17 GiB    95693 mm/slub.c:2424 func:alloc_slab_page
     651 MiB   166732 mm/readahead.c:270 func:page_cache_ra_unbounded
     419 MiB   107261 net/core/page_pool.c:572 func:__page_pool_alloc_pages_slow
     404 MiB   103425 arch/x86/mm/pgtable.c:25 func:pte_alloc_one
```
The above example is because one kthread invokes show_mem() 
from __alloc_pages_slowpath while kernel itself calls 
oom_kill_process()

Revision History
=================
Changes from v2 [2]
- Merge status dump with "Memory allocations:" starting line
- Move the definition of spinlock within ifdef 

Changes from v1 [1]
- Dump status of memory allocation profiling instead of disabling 
the output following Vishal's advise.
- Move lock from file scope to within __show_mem() and replace mutex 
with spinlock following Andrew, Vlastimil and Shakeel's advice.

[1] https://lore.kernel.org/linux-mm/cover.1756318426.git.pyyjason@gmail.com/
[2] https://lore.kernel.org/linux-mm/cover.1756827906.git.pyyjason@gmail.com/

Yueyang Pan (2):
  mm/show_mem: Dump the status of the mem alloc profiling  before
    printing
  mm/show_mem: Add trylock while printing alloc info

 mm/show_mem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.47.3


