Return-Path: <linux-kernel+bounces-788743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFC2B389A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102EE1BA117B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5345A2C235E;
	Wed, 27 Aug 2025 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbSGMTes"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6F72628
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319668; cv=none; b=tFle4mXTh6jz9SLcaq4pDBuhUgXLXnBCjKLRhCdTG2lyQ8W/8f8pZ32xIbG2AEqjA5xuisj8msPVV+r7r+roCQmrMnn8umvVa7/Dq9zdYLkuRLIkAUhMlZi20SuoT8oxuKMr1TqMCn1LvFGidSxlt9Nd5DB7qogEJc/8OuLSE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319668; c=relaxed/simple;
	bh=1L0iR/4MmMtkkrf0ardlTxbsnVpRv1UGT2VXQ7XQOPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0GbL/2MLXO5DSpnZ5Jdri8b+tQqg2es7t3PqFMzkHH/qBqu/KQvR07XCtOch/thDId4szIy9fkk/xDl4BTEpqX3oR0QXI6Wa7f0+tO5wexYcrTPzjRV0J+qo84cuJvtv36LJrNkwy0mPn6jTZlBNZ5I9SDOd/C2gHBVClw0VM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbSGMTes; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c8fe6bd038so73930f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756319665; x=1756924465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8hewu2I4eznp92bIJ77drWHJ5q2PS95ZOTmNM9Op0es=;
        b=EbSGMTes6tOWJQi2E43VeFwqmZFJruhdWeJbRflAkJlyjtH5ziGqfHdM4mzGvlnWV7
         mTcAAe9f861dS8D94Uq2kRy5qVUBFfeLloggLkOb2grc6ZPbwA1pbkFGK68/wYAllOaf
         DuqtPVjnIZY0NVrC4s/L/bn6ZFLL63EqPTA4Vzr4NsONldtedrTkH0E3faJ5rROKnP4E
         BNxn7ub0yj6TetCa3qPL/9GAlmB111SfcjWz0AfFLG+aC4SlUVJEhmOB96G9ZMVl7Roi
         fnHVO6eBG2Q6Re1fIqFXlHW8ESILnmWPlCBqN3bN9VoI+2Z2Yf7VQclChA21LUqxFV0v
         /5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756319665; x=1756924465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hewu2I4eznp92bIJ77drWHJ5q2PS95ZOTmNM9Op0es=;
        b=RBUEXLQEXhIYcjzQ66T7gWbOgEIkA7HgVnuwT+vnebvI5v0Mgi9MEMw+WXZrSCynhV
         iGrI+nqv5lJLmDoccl3qDLDkcmFwabciLU6SVPt5d1tzt6bD1EtPmqCP7OxcY6sudqRY
         Cqm8LcPi4dX+xK4BMA9U4zq8Q96KS18VxL5fA3SMV9ufGX4TVELKx9GlF0y8Qu9jcxkB
         uigI+scVNJnywJAIRrhV/F+xXudQGwiB+t6Xox+QlQJWafpMd1Ta0D3n8QffXiYknRR6
         3SVClOpd+5d/ICpk03n/tHaTqAIE8gG8TdSIbobYLUOu1d09r2N7QkvptAez6JrNTEFb
         oUSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuB/n9n6mxbPrXUcbz8NbXuhMo6STz72XH58m9feSpCSlbDMdr+c0f4v/P1DZ3tZ83SPuf3xzKmmaOgCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9p4m+2Po6Ttu5UjJZ8nD+3zp+xaSUvWvow/X3En45lhaATP3z
	uWctuJ+FhFHQ/yiZ/AWhisPy/Z4IWR/2AJYHw1IG0nYxv6YvoTqdSlS3JuefeK7YHm0=
X-Gm-Gg: ASbGncsh3PwaNrYcVcT6XtMiuS+vfechbajwiITB2ZD7wgzP2jumXkoJQI7LNj5tHYz
	ASSoIjh8fZBpgCftVGrky95k3rSCskDVrFnv5ewte5+DZ+IG7hiAasd1HF0Do4Qvsr0SsIbMxbq
	/kx5/poO+hgtUcccnQRiThBhiCAzeDhrRiF6gDbmNZn7z3+bizw3jeKcj3T0iNYmThJyMzgnKiY
	T/xWHRw2ah2HvN4f1JMOtRSFBDOru+uvJqkV9E59HE2E2oyaZvCB0Am0I8fCAfpTjaZetfbLfJ3
	tKp2+rJ/3Mes35Rsv3iNqnu8fwTVW0sypbd0NJngNrySnXYPMpuc8o06mX6rm5iV/46LpbcgrYK
	8whgc3DXuOclCQYX/vePYm0YyYg==
X-Google-Smtp-Source: AGHT+IFvz83WXqrMhGngWZt5jAMD7RqcJWs7fdyEccaxQf2mlcp1tYWLaJIG6b4613PVwXsig7wB6w==
X-Received: by 2002:a05:6000:2386:b0:3cb:46fc:8ea6 with SMTP id ffacd0b85a97d-3cb46fc9122mr5146385f8f.3.1756319665116;
        Wed, 27 Aug 2025 11:34:25 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:43::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc18f762b1sm5697732f8f.65.2025.08.27.11.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:34:24 -0700 (PDT)
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
Subject: [PATCH v1 0/2] mm/show_mem: Bug fix for print mem alloc info
Date: Wed, 27 Aug 2025 11:34:21 -0700
Message-ID: <cover.1756318426.git.pyyjason@gmail.com>
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
is set and sysctl.vm.mem_profiling=0. In this case, the behaviour 
should be the same as when CONFIG_MEM_ALLOC_PROFILING is unset, 
where show_mem prints nothing about the information. This will make 
further parse easier as we don't have to differentiate what a all 
zero line actually means (Does it mean  0 bytes are allocated 
or simply memory allocation profiling is disabled).

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

Yueyang Pan (2):
  mm/show_mem: No print when not mem_alloc_profiling_enabled()
  mm/show_mem: Add trylock while printing alloc info

 mm/show_mem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.47.3


