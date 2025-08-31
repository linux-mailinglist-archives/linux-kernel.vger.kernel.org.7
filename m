Return-Path: <linux-kernel+bounces-793294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C8EB3D1A4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C2344108D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE0245010;
	Sun, 31 Aug 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MmIWLg23"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5DE1F09AC
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633179; cv=none; b=mNNO+mh+8YXYTC/Ob4n+jXhOeDQwComJt3h+ZDcWCOlI5yJoBVz6gMoO+xk4FyB1YKqwfpJJMOM1NyGTCD02ZSD/bfNA5evC+oziAsWZHEH3vZu6wCtBeZ0oee27E3/SagpKREz2wT6zUSz1uVJLih3yApfAsJMav/mXClqMO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633179; c=relaxed/simple;
	bh=xzNmljUVfv0CKhGpx1yf8BS3A7mLdvDC3nodota5Zr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGJnMe7hWxTjyQ00I/cQP66LtxjGOH63Gye8s1M99JMOtAyGkyA/y9RE6wNfvjmpl/2Utwo3QoHoWeeFcY2dKX5hA34soZcTNyoFmdqKFDPmv9LL6CbGYXmFElfOLmrxwKqhvnse2E7t2iD9sd+UOQHVQbd0G3j5XF4s/yeEtHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MmIWLg23; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0225483ca0so153327566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756633176; x=1757237976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tARiBeQKogmSx6ScuL3aeyFoXa1hfJ2x9S0wEBpMSiY=;
        b=MmIWLg23KfT4PyGEas6eybxR6F7I1KH88qftyB3DUX9whlBmEKFV7ozeTEPB19dD5m
         sDpdzFV3FfjTDxZPd0SlKwPjIz3FH6uWgHAFA5xPKICXfPjGKXF6Cz2vJ+7O+WfvanqC
         hIPRBeUPf85iS8Xq7OXH9JkXP9ASy4C2oQkrzfST1CpHsGyle73xLonlKi8DMzH9+aOb
         ADOQolgSHYt2QERLGnQsocPOILc+a/VjjbfDUuh4NLsh0pkS6HVOcFnzgL0Qb01ROfvd
         tr9bDqwy9BXsv5n4rovlOPmKdBh15byFKOASq3zW3gVkNwLzNN11X7QMBzbv45Q1LaY1
         TyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756633176; x=1757237976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tARiBeQKogmSx6ScuL3aeyFoXa1hfJ2x9S0wEBpMSiY=;
        b=Qc9h1QhYtvo2hfIB6gT2AkTurXyiSj9QP/urjNL8FRMjxHNRCAO0we4om6p2z7uk6r
         tJ7pCLmRJU6AkzdbuknVvNGAxCqgP6c7xCd2906u/fvjPzvE81rD0/Sp5/2YeySQICLt
         hRJO3jr6JvU1wJ+m1Nr6k2M+yzZkcD1cfI3nKezVltmoY1t064OYtNeo//EdcA7EH1W8
         mQ8e29Z+rzeTqkxsTnMoVCKcg0xGn0/jn3WEgV3Nxd9XuLFeZoBl8QURu7EJ58n88GxB
         KPqxk8fi2iQp2A7qCRmY2n1k+eSNNk7ZAV3CIPanWSVBOinPpZIhS1ezS47k0ULksgoj
         xYHA==
X-Forwarded-Encrypted: i=1; AJvYcCXMoVTpgdUaUsQ5Shnz0XQXg/rfEIkVSQXsGRLRNYf6wbAPvRa+nou9KbnvNNzfgz2eNK6WiZlMppuGMuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuPKEPUtVVumh2rZePzfraZ83faYFOg7fdcY8u+jO6ejsDXD13
	ArNWStJ7N9JtDqJ8Y6D5QZjTdNLtpgwID0FbDBK87Dj/UWRGuqiEl6ylCbzTKiDxDX4=
X-Gm-Gg: ASbGncscL8kIRvk6SgbcMv5KjVkY7Yd+AAOjmcdE2QU6Wt6kyWgwV9NeF6cFnX1GDP7
	JCngINGJU+HS9096GEkOASb1WhELV8mWeDMu2XlLTF6DpshqfOWdPF0nTGtOAak+WG85J3E3htq
	jdZfkenaAN1hsrv1Sp7GnBXsC8qI2YdWjFN1LpMIO0WgZ/9x4LkB/7g2z5JEpPTEq/qMKHZe3u2
	rURIQ/WjyOc42NWrTjK47sWrv2x/fTLm36gKJbBg26TUz+1WYhefVIUYc3YsJ00NN60EDnqArgc
	cLmW5ut9HzygCSqBnqcIeZ9rWBEx6Q0J7Ic4xkCr1rqHCqSZo/PZLvhtBRj35MTnclMirt8BrPI
	+yCYTfJ1oDRiG3/uTGqtXab4bpE8ED1DqUUzhAodlzvAfHD8HX/0C9a/kxNZUGANxA8X+eCx/+U
	mUDwAZnrKLFJPwzEztUM9x5Bq3mo7J8VNf
X-Google-Smtp-Source: AGHT+IHG4PxpmR9awAfjHMroFIHguhhrmpkWm97SaLqlciSkKd+OCg3v9JMQYZPVhQ3cfJwo9Iu/1g==
X-Received: by 2002:a17:906:7314:b0:afe:8af3:2ac2 with SMTP id a640c23a62f3a-b01d9730706mr425692466b.39.1756633175692;
        Sun, 31 Aug 2025 02:39:35 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8656sm597512566b.56.2025.08.31.02.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:39:35 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 00/12] mm: add `const` to lots of pointer parameters
Date: Sun, 31 Aug 2025 11:39:06 +0200
Message-ID: <20250831093918.2815332-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

This work was initially posted here:
 https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/

.. but got rejected by Lorenzo Stoakes:
 https://lore.kernel.org/lkml/d6bf808d-7d74-4e22-ac4b-a6d1f4892262@lucifer.local/

David Hildenbrand and Lorenzo Stoakes suggested splitting the patch
into smaller chunks.  My second attempt with one smaller patch was met
with agreement:

 https://lore.kernel.org/lkml/20250828130311.772993-1-max.kellermann@ionos.com/

Now this is the rest of the initial patch in small pieces, plus some
more.

Establishing const-correctness in this low-level part of the kernel
enables doing the same in higher-level parts, e.g. filesystems.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1-> v2:
- made several parameter values const (i.e. the pointer address, not
  just the pointed-to memory), as suggested by Andrew Morton and
  Yuanchu Xie
- drop existing+obsolete "extern" keywords on lines modified by these
  patches (suggested by Vishal Moola)
- add missing parameter names on lines modified by these patches
  (suggested by Vishal Moola)
- more "const" pointers (e.g. the task_struct passed to
  process_shares_mm())
- add missing "const" to s390, fixing s390 build failure
- moved the mmap_is_legacy() change in arch/s390/mm/mmap.c from 08/12
  to 06/12 (suggested by Vishal Moola)

Max Kellermann (12):
  mm/shmem: add `const` to lots of pointer parameters
  include/pagemap.h: add `const` to lots of pointer parameters
  include/mmzone.h: add `const` to lots of pointer parameters
  include/fs.h: add `const` to several pointer parameters
  mm/oom_kill: add `const` to pointer parameter
  mm/util: add `const` to several pointer parameters
  parisc/sys_parisc.c: add `const` to mmap_upper_limit() parameter
  arch, mm/util: add const to arch_pick_mmap_layout() parameter
  include/mm_types.h: add `const` to several pointer parameters
  include/mm_inline.h: add `const` to lots of pointer parameters
  include/mm.h: add `const` to lots of pointer parameters
  mm/highmem: add `const` to lots of pointer parameters

 arch/arm/include/asm/highmem.h      |  6 +--
 arch/parisc/include/asm/processor.h |  2 +-
 arch/parisc/kernel/sys_parisc.c     |  2 +-
 arch/s390/mm/mmap.c                 |  7 ++--
 arch/sparc/kernel/sys_sparc_64.c    |  5 ++-
 arch/x86/mm/mmap.c                  |  7 ++--
 arch/xtensa/include/asm/highmem.h   |  2 +-
 include/linux/fs.h                  |  7 ++--
 include/linux/highmem-internal.h    | 38 ++++++++++---------
 include/linux/highmem.h             |  8 ++--
 include/linux/mm.h                  | 48 +++++++++++------------
 include/linux/mm_inline.h           | 26 +++++++------
 include/linux/mm_types.h            |  4 +-
 include/linux/mmzone.h              | 42 ++++++++++----------
 include/linux/pagemap.h             | 59 +++++++++++++++--------------
 include/linux/sched/mm.h            |  4 +-
 include/linux/shmem_fs.h            |  4 +-
 mm/highmem.c                        | 10 ++---
 mm/oom_kill.c                       |  3 +-
 mm/shmem.c                          |  6 +--
 mm/util.c                           | 20 ++++++----
 21 files changed, 163 insertions(+), 147 deletions(-)

-- 
2.47.2


