Return-Path: <linux-kernel+bounces-882476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD143C2A8D3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0647218918F7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BCA2DBF40;
	Mon,  3 Nov 2025 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N+m2W0nv"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5809271447
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158157; cv=none; b=u+bgwPFKJdnRvv1BUnu0LfDRrdA3NOGWClEQ8iQR74jWue4pJZrbNA7VN6YI/7GSMCKpeLBjJGtHD6Omcj0IBZc7DLfac8cWk+4/gdO0G65RXZs5WrngeJneCXUXoqj4WB6s+3Qa81ei86wRqM+lYAyNmIKV45S9r6ozNNe5r1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158157; c=relaxed/simple;
	bh=2wplEKO2llUv007yjZH0NXgQLPaWL2+OR60SMN096JI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFCJsFbyJ6cksROTgZBCz2T1h6EWeLrHqXKyIgWB8M7dyzkNKKaPVaytQHaXniqbO9F+YTKYWQzFxevk0xb/55uX0GMGS77nOs4DSd47y+vO5cQd/q4h+XxHFpG0d801x/V7kK9lVCj3L7ME4xzozMWoYoOn8abbmPDBTwf2z3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N+m2W0nv; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762158150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nj/c1BzjIxpTO3kgh7+pFVSsAoolfSYT6E1Rg5uvcLQ=;
	b=N+m2W0nvJkFqajogTrfNlWsOh+oMmLYJgIwnKymVk7YFrAfFKO+zhlFnS8Knje4fEW7rMq
	3hchLSWbyt2lZEhGCbtodlWvB1c9rL9Ia5gABeWYUKgJoF/Y1T5Ti/zRmvSpjepyipiD5q
	S3NNljJ5IguKYIOCBvMTi0epqSjcafY=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH 0/2] mm/hugetlb: refactor sysfs/sysctl interfaces
Date: Mon,  3 Nov 2025 16:22:07 +0800
Message-ID: <cover.1762156954.git.zhuhui@kylinos.cn>
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

Geliang Tang (1):
  mm/hugetlb: extract sysfs into hugetlb_sysfs.c

Hui Zhu (1):
  mm/hugetlb: extract sysctl into hugetlb_sysctl.c

 mm/Makefile           |   2 +-
 mm/hugetlb.c          | 852 +-----------------------------------------
 mm/hugetlb_internal.h | 116 ++++++
 mm/hugetlb_sysctl.c   | 136 +++++++
 mm/hugetlb_sysfs.c    | 632 +++++++++++++++++++++++++++++++
 5 files changed, 894 insertions(+), 844 deletions(-)
 create mode 100644 mm/hugetlb_internal.h
 create mode 100644 mm/hugetlb_sysctl.c
 create mode 100644 mm/hugetlb_sysfs.c

-- 
2.43.0


