Return-Path: <linux-kernel+bounces-768106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCF9B25D05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4927A3B25
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00B4265626;
	Thu, 14 Aug 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CF6xMi0d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0B23AB90
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156132; cv=none; b=Y5nopCMXH/eEhSQrjyoIkaMOcTIM6KO/u1W8ths3UsMhX20iyQXvndiThMaR+5bDV+nzhqTn9xXzFvI4pGeCE2lfelbmUMn21iPCA3LUhRHIQMAFDfjyYiuj0vKCK/4tKKWhzKSzhus3W3d1C36KUxQNdcd517kc2bZZp7qzSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156132; c=relaxed/simple;
	bh=NRKKBVGcPpGKNp4iciJu2sJkaHxMotMpCjNFORNE3Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rdY4m+vaf9RDQ22TLMMBg657CgMNuRvc7lyi1oRcxI5jkDj7acA+vWciXQqcfsJ+6evprYzmMQl3Nt+BuxrRmjopi8CVvSb3AmNefDMviduIiKSOyOv+u6i7yxGPOjWWzziJY2VA2BvkHUevKrvxDP+gY4WrwN/A2lCXq30nyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CF6xMi0d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755156129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HO8ahXGAV9+oYKhXXFg6Hd9BCMtW4wga0zmW/d806gI=;
	b=CF6xMi0dq4A3ekvhe0r4hZqta3gatxhbuWi91BDWUzp8M4viRAB7aQ/QioTGHyPrg/NrgK
	Kn+alV8CWGr9/KrHgVpRik6pI3Bnt1K+YBYxqoA6+66MM41h6o0fzlFJ7e4EmbAYlF9o7u
	jhE/lWQo2B+zbvMpn4ZZxtdN2FcvtX4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-VLgIFyUVMq-DkxRZL87_EQ-1; Thu, 14 Aug 2025 03:22:07 -0400
X-MC-Unique: VLgIFyUVMq-DkxRZL87_EQ-1
X-Mimecast-MFC-AGG-ID: VLgIFyUVMq-DkxRZL87_EQ_1755156126
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-55ce52539daso299583e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156126; x=1755760926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HO8ahXGAV9+oYKhXXFg6Hd9BCMtW4wga0zmW/d806gI=;
        b=BhopNqcafzFgz+rMGRsVln0aa3j3olPr3zWK4KKMalX+NswdivuBLJcN9RnHMthjI/
         VD2cBE0uXFxYLTsCrTMZccCv+KMX0iOfhnV0ux7VICgCm1sn8zl9Ezh3t5m60KZwuV+8
         Vb51XbLVNCkCuwr9owIjlHQtp//Iwh37/asaDM3VEtb5hAXpi6RDO2d1kWTLtnv8+HEv
         3T5ktZc9uxPU+JTwc04kRBIOGbVUaYnYkJAZ866Bry7OxyLP0whCouvxXAoxpo0uMR1b
         CEgagA6PrX4DoCD2OAx8d1pLtpTo2vYPgL8wB1fQuBrsp/VZpFBTPNHF8wnhk6SGraAY
         ny0A==
X-Gm-Message-State: AOJu0Yxg3PQggT1tZRA6FIjmcb8BU+JmymamT6PBB6423BXSi3Mzvhcz
	cM3dWJ85/2h5IO/pNNGTmGYF21Zd7jigxyinqpoIcVLOf3VdEyplvn9szo6pN4rXs6GeeQZsyKl
	+8ei9xoI2BwqWQbkThYMGaas1BNWv6MCoRpKkrKPRMHPQXIA1KXTus1j/CqaI2E5c
X-Gm-Gg: ASbGnctEZqFADUh9kSetqwKKz77MGxMUMrLIPalDIuAVXYYkTTGJnmapMqU73pFpD0K
	fAYxJoVoKjQLpgvQX8+tw3vL1XJKA0e9mGo6uwt3/u/H6pYYco5H7qlGTfMWd6S/DH0CVfJ38mF
	3GeElb4q7Pd8GHLSXD+MFm+YnjSrbVG5MLIh9LrD/ywdZm0EwNlRCSgvRt47ntF1OI5AEZM0dMf
	+MTkN9OCjD7IntGV5MW1Ewd5vp+TBdkjVhxLq6q9W/Sm+spj/5g4bQ4vlI1m2voaAo+k0Ur3cak
	LgDhZpoPZb89xocfX/MPDnEgr0GZARWpp/W4MUIDeJRVfXCG8z98eqc=
X-Received: by 2002:a19:6b19:0:b0:55b:57e8:16ae with SMTP id 2adb3069b0e04-55ce5042db1mr525780e87.42.1755156125951;
        Thu, 14 Aug 2025 00:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5vppBBhHVr3bNEhRLcbKtwJBmqRqouOozh53CEMqraYorHauklrnN+jqy6RCGgiQqQIBMFQ==
X-Received: by 2002:a19:6b19:0:b0:55b:57e8:16ae with SMTP id 2adb3069b0e04-55ce5042db1mr525768e87.42.1755156125414;
        Thu, 14 Aug 2025 00:22:05 -0700 (PDT)
Received: from fedora (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b887f72f4sm5620240e87.0.2025.08.14.00.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:22:04 -0700 (PDT)
From: =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>
Subject: [RFC PATCH 0/4] Migrate on fault for device pages
Date: Thu, 14 Aug 2025 10:19:24 +0300
Message-ID: <20250814072045.3637192-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As of this writing, the way device page faulting and migration
works is not optimal, if you want to do both fault handling
and migration at once.

Being able to migrate not present pages (or pages mapped with incorrect
permissions, eg. COW) to the GPU requires doing either of the following
sequences:

1. hmm_range_fault() - fault in non-present pages with correct
   permissions,etc.
2. migrate_vma_*() - migrate the pages

Or:

1. migrate_vma_*() - migrate present pages
2. If non-present pages detected by migrate_vma_*():
   a) call hmm_range_fault() to fault pages in
   b) call migrate_vma_*() again to migrate now present pages

The problem with the first sequence is that you always have to do two
page walks even when most of the time the pages are present or zero page
mappings so the common case takes a performance hit.

The second sequence is better for the common case, but far worse if
pages aren't present because now you have to walk the page tables three
times (once to find the page is not present, once so hmm_range_fault()
can find a non-present page to fault in and once again to setup the
migration). It also tricky to code correctly.

We should be able to walk the page table once, faulting
pages in as required and replacing them with migration entries if
requested.

These patches add a new flag to HMM APIs, HMM_PFN_REQ_MIGRATE,
which tells to prepare for migration also during fault handling.
Also, for the migrate_vma_setup() call paths, a flag,
MIGRATE_VMA_FAULT, is added to tell to add fault handling to migrate.
The original idea came from Alistair.

These patches are based on 6.16 mainline, and they pass the HMM
selftests. The support for THP pages from Balbir should
not be to hard to integrate into this, and that
is something I am looking at.

Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>

Mika Penttilä (4):
  mm: use current as mmu notifier's owner
  mm: unified fault and migrate device page paths
  mm:/migrate_device.c: remove migrate_vma_collect_*() functions
  mm: add new testcase for the migrate on fault case

 include/linux/hmm.h                    |  10 +-
 include/linux/migrate.h                |   6 +-
 lib/test_hmm.c                         | 105 ++++++-
 lib/test_hmm_uapi.h                    |  17 +-
 mm/hmm.c                               | 351 +++++++++++++++++++++-
 mm/huge_memory.c                       |   6 +-
 mm/migrate_device.c                    | 384 +++++--------------------
 mm/rmap.c                              |   4 +-
 tools/testing/selftests/mm/hmm-tests.c |  53 ++++
 9 files changed, 592 insertions(+), 344 deletions(-)

-- 
2.50.0


