Return-Path: <linux-kernel+bounces-883979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B275C2EFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 03:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3E414E183C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 02:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E9023EABF;
	Tue,  4 Nov 2025 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FyrwYbpY"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BCB79EA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762223933; cv=none; b=a1MnmXG1DmYcumDYIV/n2wVPt9apqISeu2oZnBWSv7KXZaG2ba8UkEfrXgYChOrcunEU6/8hH9GTUFksHXrs/picCIVtLSO2cyNq1flUXfnF0MpoelT+OqW7Gjl/CUvBdOwtkpe6fDjO5xCPE5yZltauygB4sSKh+363uxszajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762223933; c=relaxed/simple;
	bh=IgvIm04eCbwthsfo8wMC9XxqZ4DK9hE3Nap2kRSNXbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+xsFS/RkQkKa0ujNqhQMy/9LZAPZM/vZ3xdYxaQNEgLQ4PF5q6ksqhrPDsKdOedLB9E0iLZGRaWszRdtKHvAkZ0kiG23SSZx81/teC3W+sp3htybc0ARTnMaqyNvuwoI5jAD1msXkeV1/YSIOaNKnLl/Hilqga8OG0Bw8T5ZDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FyrwYbpY; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762223927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=naNqLpq5EZqLzFsmkG6IghppzeL4JWW6iNluOrAWyLQ=;
	b=FyrwYbpYuPHIrpIxEsmYDIsj+sUsu2x5fLT+oIolzAeI9FW0vn9A24aThJTQN7BSH8rgFi
	QSG0lWwphxjynnvKBY+/C3dYKViRH1aV8Cd4QDZYulgjPrexxc+PlyP+hGARydzVPLIQH3
	phLmlYtW1WucGRtQAuSccJFtwqO3r74=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH v2 0/2] mm/hugetlb: refactor sysfs/sysctl interfaces
Date: Tue,  4 Nov 2025 10:38:31 +0800
Message-ID: <cover.1762221536.git.zhuhui@kylinos.cn>
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
v2:
According to the comments of David, remove the wrong copyright in
the file headers.

Geliang Tang (1):
  mm/hugetlb: extract sysfs into hugetlb_sysfs.c

Hui Zhu (1):
  mm/hugetlb: extract sysctl into hugetlb_sysctl.c

 mm/Makefile           |   2 +-
 mm/hugetlb.c          | 852 +-----------------------------------------
 mm/hugetlb_internal.h | 116 ++++++
 mm/hugetlb_sysctl.c   | 133 +++++++
 mm/hugetlb_sysfs.c    | 629 +++++++++++++++++++++++++++++++
 5 files changed, 888 insertions(+), 844 deletions(-)
 create mode 100644 mm/hugetlb_internal.h
 create mode 100644 mm/hugetlb_sysctl.c
 create mode 100644 mm/hugetlb_sysfs.c

-- 
2.43.0


