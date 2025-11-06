Return-Path: <linux-kernel+bounces-887717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69040C38F17
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A293B607E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B077D1AB6F1;
	Thu,  6 Nov 2025 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DIL/yDdm"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6986A347DD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762398523; cv=none; b=tLsj4L4235xXPvyR/o31ZbQJIwofLVFbYH2FlAP78b4olnxvIBsh+9mdnxeWXEJcNvl3SZRcKdawkETjg6GgNWFaxIIMWUxNos9oNgOMT5O7J+/RbM5vuf5mJIUb51fC4sebB/i1cN5ZdMV52DdRX6tmc24aiKXg3NuwdXxmEGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762398523; c=relaxed/simple;
	bh=x+Ghb7rUuSRbUlcQSKYekTD+8T799t7ahQgTrfgnmVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IG2REiAPxGBVv1jq/i2FkpmO2BHGf4kMtBE/JhiHhRr5b1wPpnvz9rgIjPHmfKeHMqSHUnuZIR0SQogaTAT6b/Pn1c8iKDVTcgLU4fO93c1UZSilaoqAQCjL/Nl5Fm84n0MbkVVUQEpd0Z8Ud48n7i+Y2iQobILaAIEkxiBmw64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DIL/yDdm; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762398519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PEgt8dqODFgqWZubV0P8rSJ5eXEFZvoVCzJWLxN7M9g=;
	b=DIL/yDdmEpqocu9ESUZ8W9uH0Vh1M18a9ktyGr6YFz1Xeg33wl10vdqdtMnUxSz0n8Tz1v
	J0oX93sKbVpg1ERQjL2zMnLSXwPGdaZatEpcBqBmULRgRYC6i0hvSU0olk/Q3El75yX0Bt
	DVHZ5+MQ98DgLhm3nSEYY8NH/oDt9Oo=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH v5 0/2] mm/hugetlb: refactor sysfs/sysctl interfaces
Date: Thu,  6 Nov 2025 11:08:21 +0800
Message-ID: <cover.1762398359.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

The hugetlb.c file has grown significantly and become difficult to
maintain. This patch series extracts the sysfs and sysctl interface
code into separate dedicated files to improve code organization.

The refactoring includes:
- Patch 1: Extract sysfs interface into mm/hugetlb_sysfs.c
- Patch 2: Extract sysctl interface into mm/hugetlb_sysctl.c

No functional changes are introduced in this series. The code is moved
as-is, with only minor formatting adjustments for code style
consistency. This should make future maintenance and enhancements to
the hugetlb subsystem easier.

Testing: The patch series has been compile-tested and maintains the
same functionality as the original code.

Changelog:
v5:
According to the comments of David Hildenbrand and Oscar Salvador,
move demote_free_hugetlb_folios and demote_pool_huge_page back to
hugetlb.c.
v4:
According to the comments of David Hildenbrand, add copyright of
hugetlb.c to hugetlb_internal.h, hugetlb_sysctl.c and hugetlb_sysfs.c.
v3:
According to the comments of SeongJae Park, updated MAINTAINERS to
add new files.
Removed the wrong copyright in hugetlb_internal.h.
v2:
According to the comments of David Hildenbrand, removed the wrong
copyright in the file headers.

Hui Zhu (2):
  mm/hugetlb: extract sysfs into hugetlb_sysfs.c
  mm/hugetlb: extract sysctl into hugetlb_sysctl.c

 MAINTAINERS           |   2 +
 mm/Makefile           |   2 +-
 mm/hugetlb.c          | 728 +-----------------------------------------
 mm/hugetlb_internal.h | 117 +++++++
 mm/hugetlb_sysctl.c   | 134 ++++++++
 mm/hugetlb_sysfs.c    | 502 +++++++++++++++++++++++++++++
 6 files changed, 767 insertions(+), 718 deletions(-)
 create mode 100644 mm/hugetlb_internal.h
 create mode 100644 mm/hugetlb_sysctl.c
 create mode 100644 mm/hugetlb_sysfs.c

-- 
2.43.0


