Return-Path: <linux-kernel+bounces-796953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 344F2B409ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4933AD992
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D888E2D5C8B;
	Tue,  2 Sep 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEBErQXk"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8730D31DDAF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828676; cv=none; b=icim5heeWudsfOHjNJajIAIkhJ8bOqBn+/BEIVi+EGaba+5iSk+2S+wJpdx9tmPaVtr0jwCu6Vv+oX684NSRaJwddS87D6nFNn02KJ0fuqZU6Kedw6CT56AZnFVNe4ZZ8N9Y21TYDiIAHo8oTAHjMY1iL550TYLfzjktA7P6FPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828676; c=relaxed/simple;
	bh=prb4MEvcS6IwQvXSdzOlkkvEzD4Ne+Soh7lgw2XUmmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eFdC8Q8rLAcX3gW4KikaC5GNCo+Giz2Xci9/6OxhAWqmVuiQ3rMCq3ZeyTdaLZ/ROR94Gc4plLLwhySrtv2PSY7m9rZKgcaWcKW3TbCr3iNhGtCclc89KwnW9718Sd0UXkkAYbvWvW2ASrm6XgiCgdRvza04XiX9OgsMvDP96Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEBErQXk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b869d3571so7857175e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756828673; x=1757433473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qpTWgweWXwv5CYoYaJX9o8zOdS7aXfoq/fg/YbFm8l0=;
        b=cEBErQXktyeZD4G4+7ji1uZ4GVTGMfqZFfrQihkgeRT85GMvLN2hc3EE9rWMRUfb9y
         5ty0+W2UIsu884hM5TiRZxWphqgXL3gJM25zqKnNu/lZGY5Ij1hHjgN/+fNuIovSfbWg
         ajZ6XKz3Y8QKpnLPBhCkhTNKiyGDZ71ZxYv97pH32xquUBmYi/86ncYEmQQKPKq5ZyB0
         FtkpAvKP6jGZYXm8lS/XJ1sOudvy6/e8EcrixZn5WTXJi5l7auKNBKEw2bvPlGJ43/36
         P5m+t4+4x4IvcawmwU4xQ1TUST/6r+7r5rlo1s82wXd+L4BzivedRTn3FR0uQqjK77rG
         gzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756828673; x=1757433473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpTWgweWXwv5CYoYaJX9o8zOdS7aXfoq/fg/YbFm8l0=;
        b=Z7wjgumvY+LlmRgRYhwkDgYceMNPA1uGMb4Xbq+A0lAX24Nhi3wHbR0S0hoDM7yzQ+
         K5WT3R2ejRqNLwT4zqv7eJt+iJ4/PZ4fEp0OzzY7T8JnAWeynesyNcoPdIkaD6ak3Ezp
         B0697Shp5nnCPD7AsBQybZYQyCHQVrUU3I2QzT2DfVJL09660j1ycfpYbwWeYWvrx0co
         e9OZnlZjHo1mVQzcYSdcYPF4AUfHmRnEl/zXgdmfVq/TnrzJyb9JzsmeULt089VIhPI+
         YQJoCiNgi4SuXFQQHDtxeKQZUQRE1LeJj8bvNWtAJENn1vpU3+72eM+xp4NUb/AbOgdA
         cxpg==
X-Forwarded-Encrypted: i=1; AJvYcCWuvPkPUlDZrGbtzaim/by6eaEY44jbCJvDuS1/Hgd3oMLU4r6/ONyE7dP5VNRgB30Cbcbe/SxyytuyVGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvj3w/sIIugh62fQov3hvRX6+7JkHBVWvSTTxjpw67bPZLSdhz
	/zLTl2tcKhrOYK+N6ynFAu4/9TCsX7e4gqYE5DH3e99SZc76UW6Gse1T
X-Gm-Gg: ASbGncvcTl3e2Nv84jnrulO7KFu/koLMcIhFxuGz+htWTtaETOLl50L9oOfKvYTyejx
	/hbBoHZ0MP/dXY0hhXOQR5BwoZQO9w/igGUX1tYb+x8HXwz8YfLOlsVfiqtJ+EvR/bLPDZrVwJK
	7s2v0WXV24pJQrB2vrL0bNKmfeFAnqebFL/j/P8+oxlivdjKCTYUD2kfQwgW7ggkPU3DDwmJZYA
	wDcUBIsMGbzIemScogl/MIk8nrNqWDnhjih0niVdFNNL7zJ9/C+cb6sAUoWVnGv1pHoUbc4sORQ
	+b0ujltpc2QlnuJn15yxLbAmb9TE7QGFi2HBzGeeVQBibJLWBN69fP+iiZF0dsPROGcPAaE3ue7
	8vA/58GsPPFWhpQ==
X-Google-Smtp-Source: AGHT+IEfZqY6+K9hdaYp/KwtiA903hmxnO0Hf1TH8HCjk64cyXTMeAACSnf/1A0NKMe8smJT7hSwSw==
X-Received: by 2002:a05:600c:4694:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-45c8e6d4cd9mr2987095e9.11.1756828672646;
        Tue, 02 Sep 2025 08:57:52 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:7::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm253623785e9.17.2025.09.02.08.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:57:52 -0700 (PDT)
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
Subject: [PATCH v2 0/2] mm/show_mem: Bug fix for print mem alloc info
Date: Tue,  2 Sep 2025 08:57:49 -0700
Message-ID: <cover.1756827906.git.pyyjason@gmail.com>
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
Changes from v1 [1]
- Dump status of memory allocation profiling instead of disabling 
the output following Vishal's advise.
- Move lock from file scope to within __show_mem() and replace mutex 
with spinlock following Andrew, Vlastimil and Shakeel's advice.

[1] https://lore.kernel.org/linux-mm/cover.1756318426.git.pyyjason@gmail.com/

Yueyang Pan (2):
  mm/show_mem: Dump the status of the mem alloc profiling  before
    printing
  mm/show_mem: Add trylock while printing alloc info

 mm/show_mem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.47.3


