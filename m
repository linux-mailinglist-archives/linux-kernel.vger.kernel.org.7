Return-Path: <linux-kernel+bounces-885733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AD9C33CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D00D4F8627
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D0223D7EB;
	Wed,  5 Nov 2025 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e5TgTHzA"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339087260F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 02:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310584; cv=none; b=AvAIV2FIdKV7tZDHp1NC0fDH95MvAMAljIUH6NJWwXbTPVuf0j+6HAcFJnHbcndHd68vi0K+f7zY2KzpqmP+hTQ2BNLZYt4HD1tYj5r3S194HEqGB+N1+PnJtRxVwKtBGr5+9xIB+SpcowEIMTs9wpjChDu/t9ZsMR6k2Zpo8nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310584; c=relaxed/simple;
	bh=dDnBHWLHUt3xINGTHHPS5dDCcuRqSfahn7SDYv7Xfnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+dk78zFBqjNZRfHYRKY24TPMUUPKTSLzrvE+kZtfPa0FgleHYCZVIDi7/9+oyRhLcIpgVQAPq9GjJUvK5SUzUdYIEspuWIjWEccW3WwM7t66WBFwJW7XYsRESKfcVD1VO3DpRcGPDzVZ5YgH/bE/+68hA3fstI8nSg55cEkZts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e5TgTHzA; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762310580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q296D2qx12EQHPobfdWeDRQ2wlvOioDM4RhRYWBCXbQ=;
	b=e5TgTHzADd7kbEG7v6Ro73cCg1AsJ1JHeXS33eXNBK4l7d8c1GXga5BI4fZTe1vBz/Hbns
	iJEu9FbAFk2OxP/54+8XqWnyn4VUJ07chlIyG4c12fFNUFSw48gVRy+bRCSKWzMAIHq5BL
	HeuZ1XNYByZ6mAy7K6jXIwWItQ3K4v8=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH v4 0/2] mm/hugetlb: refactor sysfs/sysctl interfaces
Date: Wed,  5 Nov 2025 10:42:42 +0800
Message-ID: <cover.1762310125.git.zhuhui@kylinos.cn>
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
 mm/hugetlb.c          | 852 +-----------------------------------------
 mm/hugetlb_internal.h | 114 ++++++
 mm/hugetlb_sysctl.c   | 134 +++++++
 mm/hugetlb_sysfs.c    | 630 +++++++++++++++++++++++++++++++
 6 files changed, 890 insertions(+), 844 deletions(-)
 create mode 100644 mm/hugetlb_internal.h
 create mode 100644 mm/hugetlb_sysctl.c
 create mode 100644 mm/hugetlb_sysfs.c

-- 
2.43.0


