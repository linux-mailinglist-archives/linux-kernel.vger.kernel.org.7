Return-Path: <linux-kernel+bounces-841694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF4BB8021
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 21:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886B41887B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 19:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A70F219A8A;
	Fri,  3 Oct 2025 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLfPlPVW"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D3E1E9B0D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521257; cv=none; b=C1Ms+pnnzk3vH1EGVOYELuzpxWhjGmeNTixYOLULEp6e3oJ9112P8MPHVjBIJTRXE8+VSbYgI+erSff/82APS23Bwo76Nf2cGWCfek0t/HniT6INlt3xWJu0zxnYYGmWyYvnjNo0yPkZB/aaUA9Qil6QB7QHC2U1VOr1fpiWvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521257; c=relaxed/simple;
	bh=3K823tYxu+EOxyhNwRSXRES8yLRLq/KrBfQp1aHVubU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGczo20IK8SS34+wUt8radLBL3A0jQnZSUvM7duxlumyjUiviF+aUFIbKUV6KC2MVXkrc2HE7wrCEJ5aSMfGLlK9gDVnJ1J5Hv1tr46ZvwOjIjs733agA4mVKojUDAVdKM2uSO/3iqVCjQ+bK9CrO1qYbWCnCRUL5L26wf0SPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLfPlPVW; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42e2c336adcso8696745ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 12:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759521255; x=1760126055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u0L2Oqr5RTVnRh3O5em1BjzA6S3sfBfJoXImhkw26IA=;
        b=nLfPlPVWnhi/my+Nj795EjQjjkoq3kkjKeWauumTTR4n7ihu55lrWnLjP6wxJ/DdGq
         rjaZT05CT408BKrcq0+iO/kcbsqkaqIki+XRAEJo+I9v0Dg6Q8TuKFEBYrzrHTtq/Bxc
         0FvDhkTZgU2KscQMFHQP782Jh0Q7poBUOOSkAML0zFi/UbjXI53/Xa5LoJ4DkVhKZXGs
         kBoI7S/mh9jbIYgdgci0EZxeSyKTyg36SbHiDIReWlXLpZmehGHPrdzB27iURgRgtKOQ
         0eVXHjZJILx+R5BEO0jGcDd1yDNd2Joonf6EwsaW7zhlEm2shvpovZ541KVK/X/Pt+S0
         wB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759521255; x=1760126055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0L2Oqr5RTVnRh3O5em1BjzA6S3sfBfJoXImhkw26IA=;
        b=SoB6/hIJyAHqwg2NpZAV0YsX2IOy971qsg/BjmFO2bRVLhFLYRCdmxN2QOsUe1cHyK
         javlfAyvDsizeIKK1qhjyV/lvTzstTvL68yYYA9qkQsvlDXiucY1rFROSmcQDADdbel7
         tUbvhYLzZwEx+v85LnIpgtNrQ73lQOUHOHJ24Un6468T9ErN4MceooVUKjDIAD/VyBpY
         i8cmD9bUxTJfXmJyVCvn5UUaxOZy/bOYioAKiGynFQbnrezB63e3KMGnRy+dGKaZ4rPo
         78KFmt+31BJXUZ5jK9RNSmGeAmHJ2cUm8w0XzFvwZOPZ2FSy8JtcsELvocBwzXXsrZKt
         F0fQ==
X-Gm-Message-State: AOJu0YwyF5+Dg22M0qZR4h9fJO9B9CzQAe7mjBZRpHrFjcwW8cDSQ3uY
	zQdwnr5Okxhg/kO0KbOGWLjjhFICeglPLsUYAS4cokMv6vuOQeWoaJ2mKFd6xHrt
X-Gm-Gg: ASbGnct+ZYa3BHVfdZExcaUK8PMf9KfaLEADiIxWJHh5JqCN3E6rwBDCNtS3rKj4Kkr
	Z6+utSA3fk8T+m+3fqe0otEi5GLhpaoeE8VLFknqygm38KUoh/IhNR2CedeBd4EIt4Orolgfpiv
	iTz9tyXujRER8cmiEADdBpOBit/sg7w66DgcP6Njrf/tcOA/P3DbR+KaDMgq6OvfGqq8WNsK4pQ
	/S29KqFE24qHp45AonFkCuiwjzg0T4QT86R/2DH6cE40LH4M55DGd6pZaPyOI8dpz53A0mgPZky
	lw6XGYa6bTtPCiiKrfltJrLK8cHSiJDlytrBvz13C1Fj8nANjhbG/BzndNBtvNKqFyJ92K/5zQd
	OWAbFp0KRXdtJqCdfGg+mRxo4w/75xYtcpSPnwGa4iePb4rlpGN9fBKWKH9yLioIjYtDDgB0ocE
	mO8q5rn/8xh31j7KXO5NqkoL0HoAaaMTGeulY2tJtXPNh7+Q==
X-Google-Smtp-Source: AGHT+IHYWf7TBZMd7+AnFhpQcDy/kuwjkaHEMhx+yMRMCzbyJQDph6lKINnlXrNWtZlJ6FNzGYkDYw==
X-Received: by 2002:a05:6e02:12e8:b0:42d:bb9d:5358 with SMTP id e9e14a558f8ab-42e7ada8fbcmr52663385ab.27.1759521254621;
        Fri, 03 Oct 2025 12:54:14 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ebc8181sm2296390173.47.2025.10.03.12.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:54:13 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	arighi@nvidia.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v2 0/3] sched_ext: lockless peek operation for DSQs
Date: Fri,  3 Oct 2025 15:54:05 -0400
Message-ID: <20251003195408.675527-1-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows sched_ext schedulers an inexpensive operation to peek
at the first element in a queue (DSQ), without creating an iterator 
and acquiring the lock on that queue.

Note that manual testing has thus far included a modified version of the
example qmap scheduler that exercises peek, as well as a modified
modified LAVD (from the SCX repo) that exercises peek. The attached test
passes >1000 stress tests when run in concurrent VMs, and when run
sequentially on the host kernel. Presently, tested on the below
workstation and server processors.
- AMD Ryzen Threadripper PRO 7975WX 32-Cores
- AMD EPYC 9D64 88-Core Processor

Initial experiments indicate a substantial speedup (on schbench) when
running an SCX scheduler with per-cpu DSQs and peeking each queue to
retrieve the task with the minimum vruntime across all the CPUs.

---
Changes in v2:
 - make peek() only work for user DSQs and error otherwise
 - added a stress test component to the selftest that performs many peeks
 - responded to review comments from tj@kernel.org and arighi@nvidia.com 

Link to v1: https://lkml.org/lkml/2025/10/1/1375

Ryan Newton (3):
  sched_ext: Add lockless peek operation for DSQs
  sched_ext: optimize first_task update logic
  sched_ext: Add a selftest for scx_bpf_dsq_peek

 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext.c                            |  73 ++++-
 tools/sched_ext/include/scx/common.bpf.h      |   1 +
 tools/sched_ext/include/scx/compat.bpf.h      |  19 ++
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/peek_dsq.bpf.c        | 268 ++++++++++++++++++
 tools/testing/selftests/sched_ext/peek_dsq.c  | 235 +++++++++++++++
 7 files changed, 596 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c

-- 
2.51.0


