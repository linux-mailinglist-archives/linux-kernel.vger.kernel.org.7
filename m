Return-Path: <linux-kernel+bounces-868423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E28C0530A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14C5A5069C4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14845305E1B;
	Fri, 24 Oct 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmeR/de2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABFA26E6E8
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295396; cv=none; b=sp68mcPBQ2MZILdxN6GLTlLjA3LWaMWztErjaFP5o1vStMVHwaSzV0YvrdJY8LAh8dVYwmycCChTD9TyKQTVaDdw4BsEJ4N/FVUW1TwdiiWtvOTMMWfWXUCuzyhelvcLbZuEXUJiGsWSSBi1Ms5WLU8VcF0bG0FK4zsr3iG86co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295396; c=relaxed/simple;
	bh=W32GXGwDTigmEJXdMhFruHIsunhUEU+QbllkvpbB4D4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iAKKbRXyBfnzZgjd//ZQVEzWbtoDztCOii6Va4lFbnaSJEEmTjhfgQ4MsPf7KpAe5RylDNnYcE4U7O8+UkK1Dub8FpOi9NKExhXj8ULxBY3OnOVDw6E+2SwwlZ5e9m/tvY11ofgzMyyd8kEl2eU70Jqs/4gIHRlkggkuEIgaXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CmeR/de2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761295393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ihAbQbr27WsLP3ns7L6UlAE71u9nLb/VPSGVkAY4Vro=;
	b=CmeR/de2VWCGHccHwd7DD/Hdft6qWVfPSqLuepIdzamfgogpB7YLGrOCblDdYr+1FGQaQu
	GcIQ2sM4YsUcQUOVnlnkitY3cVJkStMredjE7plrTmITUxxupirz/zF7UP8Xg3wiJS1yga
	wrIKjkBd3bij4s2ZcIeOwlIzkyaoA2c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-3YWVbpXtNtmgbSm4glBOHg-1; Fri, 24 Oct 2025 04:43:12 -0400
X-MC-Unique: 3YWVbpXtNtmgbSm4glBOHg-1
X-Mimecast-MFC-AGG-ID: 3YWVbpXtNtmgbSm4glBOHg_1761295391
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b6d58291413so160385866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295391; x=1761900191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihAbQbr27WsLP3ns7L6UlAE71u9nLb/VPSGVkAY4Vro=;
        b=Awv13d1/KV1oQqUu4Cq4N9ybS9Of3k076ZoVO+5Gbc+4jC+TTC6doRh92ibpnZNuP9
         tuOrULpOhtNJ4USshrswO0/aolpPPTVsuJUs6Ksou5fuQ07wi8OrSYHb9j+2imXyrIgO
         FC/I/WOT12I/phrc3j0EqyQ8Ycvk1+v/wd7unycgNJ+EzynM2XPMP6LK0EGKnQ9cePX4
         EqfiBDYP/cGR6yWc3d1uEk08QjWnXAaUzyCaXk3yhCih2sydh1qK8BwRaScAHfwMdY2u
         SGnryReSHAj2x+RnfRPRUdftoYc2v7i8/RkirTi3qcVSVYtrECoqkeTsWor5PqQY/WYF
         lwBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLoNLFGxnktMP5xL6paj6bl8K1VMlnV6a3L1qSOeRoIFg6bQnQJmzMf4ajFG6ctlQxW2PbfrviRT2adDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj1nDuuhLtR/VU07KrQ76E7DIwHNicT3F5OKDMEaiIecoX0buN
	EwFBvRMSsIiLKXLJuKjL3KxYFK0pbUOJ6XzrFM9YvTndlGBt7TsutC9nbgVqVP6Ju42FeJVOdiD
	5ISwmaPHmZgSR2YzHzTDX/7qwUQCoo+GSudlyJDPe0pdhZf6Ot6iN68yw86igrL+iTA==
X-Gm-Gg: ASbGncsdSbeijbktgShGUVEbvmQF1lD8JAPHoLBdCgByJ9gKULU1rOHnpJwUdGWS795
	xkWyS/tu2bMdD3qHFiatEx2wiHrErCMznAl5ooWV4QGt9ETaefrD4gOr1Yh0m6wdS1AqvcEz00Y
	RZ7nujGrq6+50r9l4+Zw/OS4bZamZt2ZfaD7JNfd9JYJysBY5ctBKEg2qaaqKlEhH4xSxiqscqJ
	Z3trcBKYLFzv/BcfksuSBi9nyIcThwqEcTek32sa4kZSqf1BbA+gvlqEuytYBvmvfulTPmRht9F
	FtaZfDzurcQDvm7MJOQGOio6feN/fq4voQ7EwynZVOGQmCZcaphOvDlOwvE5QCHzYaaAdfJMobm
	8qB7GXzk8GHSWpHYvned+Ii+lx6vrTnc3
X-Received: by 2002:a17:906:9f8c:b0:b54:8670:7c2d with SMTP id a640c23a62f3a-b6475511a47mr3482248766b.55.1761295390559;
        Fri, 24 Oct 2025 01:43:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOHnkb1mB3ffZrYlSB2E6fBCurSJStxVjsCwJbw8nBPqLnI6mTwLJLcTU5DTEn063YP8uWQA==
X-Received: by 2002:a17:906:9f8c:b0:b54:8670:7c2d with SMTP id a640c23a62f3a-b6475511a47mr3482245766b.55.1761295390126;
        Fri, 24 Oct 2025 01:43:10 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511d010asm469226866b.11.2025.10.24.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:43:09 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Liam.Howlett@oracle.com,
	amarkuze@redhat.com,
	akpm@linux-foundation.org,
	bsegall@google.com,
	david@redhat.com,
	dietmar.eggemann@arm.com,
	idryomov@gmail.com,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	kees@kernel.org,
	lorenzo.stoakes@oracle.com,
	mgorman@suse.de,
	mhocko@suse.com,
	rppt@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	surenb@google.com,
	vschneid@redhat.com,
	vincent.guittot@linaro.org,
	vbabka@suse.cz,
	xiubli@redhat.com,
	Slava.Dubeyko@ibm.com
Subject: [RFC PATCH 0/5] BLOG: per-task logging contexts with Ceph consumer
Date: Fri, 24 Oct 2025 08:42:54 +0000
Message-Id: <20251024084259.2359693-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Motivation: improve observability in production by providing subsystemsawith 
a logger that keeps up with their verbouse unstructured logs and aggregating
logs at the process context level, akin to userspace TLS. 

Binary LOGging (BLOG) introduces a task-local logging context: each context
owns a single 512 KiB fragment that cycles through “ready → in use → queued for
readers → reset → ready” without re-entering the allocator. Writers copy the
raw parameters they already have; readers format them later when the log is
inspected.

BLOG borrows ideas from ftrace (captureabinary  data now, format later) but 
unlike ftrace there is no global ring. Each module registers its own logger,
manages its own buffers, and keeps the state small enough for production use.

To host the per-module pointers we extend `struct task_struct` with one
additional `void *`, in line with other task extensions already in the kernel.
Each module keeps independent batches: `alloc_batch` for contexts with
refcount 0 and `log_batch` for contexts that have been filled and are waiting
for readers. The batching layer and buffer management were migrated from the
existing Ceph SAN logging code, so the behaviour is battle-tested; we simply
made the buffer inline so every composite stays within a single 512 KiB
allocation.

The patch series lands the BLOG library first, then wires the task lifecycle,
and finally switches Ceph’s `bout*` logging macros to BLOG so we exercise the
new path.

Patch summary:
  1. sched, fork: wire BLOG contexts into task lifecycle
     - Adds `struct blog_tls_ctx *blog_contexts[BLOG_MAX_MODULES]` to
       `struct task_struct`.
     - Fork/exit paths initialise and recycle contexts automatically.

  2. lib: introduce BLOG (Binary LOGging) subsystem
     - Adds `lib/blog/` sources and headers under `include/linux/blog/`.
     - Each composite (`struct blog_tls_pagefrag`) consists of the TLS
       metadata, the pagefrag state, and an inline buffer sized at
       `BLOG_PAGEFRAG_SIZE - sizeof(struct blog_tls_pagefrag)`.

  3. ceph: add BLOG scaffolding
     - Introduces `include/linux/ceph/ceph_blog.h` and `fs/ceph/blog_client.c`.
     - Ceph registers a logger and maintains a client-ID map for the reader
       callback.

  4. ceph: add BLOG debugfs support
     - Adds `fs/ceph/blog_debugfs.c` so filled contexts can be drained.

  5. ceph: activate BLOG logging
     - Switches `bout*` macros to BLOG, making Ceph the first consumer.

With these patches, Ceph now writes its verbose logging to task-local buffers
managed by BLOG, and the infrastructure is ready for other subsystems that need
allocation-free, module-owned logging.

Alex Markuze (5):
  sched, fork: Wire BLOG contexts into task lifecycle
  lib: Introduce BLOG (Binary LOGging) subsystem
  ceph: Add BLOG scaffolding
  ceph: Add BLOG debugfs support
  ceph: Activate BLOG logging

 fs/ceph/Makefile                   |   2 +
 fs/ceph/addr.c                     | 130 ++---
 fs/ceph/blog_client.c              | 244 +++++++++
 fs/ceph/blog_debugfs.c             | 361 +++++++++++++
 fs/ceph/caps.c                     | 242 ++++-----
 fs/ceph/crypto.c                   |  18 +-
 fs/ceph/debugfs.c                  |  33 +-
 fs/ceph/dir.c                      |  88 ++--
 fs/ceph/export.c                   |  20 +-
 fs/ceph/file.c                     | 130 ++---
 fs/ceph/inode.c                    | 182 +++----
 fs/ceph/ioctl.c                    |   6 +-
 fs/ceph/locks.c                    |  22 +-
 fs/ceph/mds_client.c               | 278 +++++-----
 fs/ceph/mdsmap.c                   |   8 +-
 fs/ceph/quota.c                    |   2 +-
 fs/ceph/snap.c                     |  66 +--
 fs/ceph/super.c                    |  82 +--
 fs/ceph/xattr.c                    |  42 +-
 include/linux/blog/blog.h          | 515 +++++++++++++++++++
 include/linux/blog/blog_batch.h    |  54 ++
 include/linux/blog/blog_des.h      |  46 ++
 include/linux/blog/blog_module.h   | 329 ++++++++++++
 include/linux/blog/blog_pagefrag.h |  33 ++
 include/linux/blog/blog_ser.h      | 275 ++++++++++
 include/linux/ceph/ceph_blog.h     | 124 +++++
 include/linux/ceph/ceph_debug.h    |   6 +-
 include/linux/sched.h              |   7 +
 kernel/fork.c                      |  37 ++
 lib/Kconfig                        |   2 +
 lib/Makefile                       |   2 +
 lib/blog/Kconfig                   |  56 +++
 lib/blog/Makefile                  |  15 +
 lib/blog/blog_batch.c              | 311 ++++++++++++
 lib/blog/blog_core.c               | 772 ++++++++++++++++++++++++++++
 lib/blog/blog_des.c                | 385 ++++++++++++++
 lib/blog/blog_module.c             | 781 +++++++++++++++++++++++++++++
 lib/blog/blog_pagefrag.c           | 124 +++++
 38 files changed, 5163 insertions(+), 667 deletions(-)
 create mode 100644 fs/ceph/blog_client.c
 create mode 100644 fs/ceph/blog_debugfs.c
 create mode 100644 include/linux/blog/blog.h
 create mode 100644 include/linux/blog/blog_batch.h
 create mode 100644 include/linux/blog/blog_des.h
 create mode 100644 include/linux/blog/blog_module.h
 create mode 100644 include/linux/blog/blog_pagefrag.h
 create mode 100644 include/linux/blog/blog_ser.h
 create mode 100644 include/linux/ceph/ceph_blog.h
 create mode 100644 lib/blog/Kconfig
 create mode 100644 lib/blog/Makefile
 create mode 100644 lib/blog/blog_batch.c
 create mode 100644 lib/blog/blog_core.c
 create mode 100644 lib/blog/blog_des.c
 create mode 100644 lib/blog/blog_module.c
 create mode 100644 lib/blog/blog_pagefrag.c

-- 
2.34.1


