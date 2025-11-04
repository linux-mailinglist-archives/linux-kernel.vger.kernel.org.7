Return-Path: <linux-kernel+bounces-884367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBACC30083
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911BE18941F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DD3313524;
	Tue,  4 Nov 2025 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TTNsfDWP"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11835313275
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245484; cv=none; b=QOoG3oYGJLpEQIqat9uCF3WXlXKXAIpoqylHPeXPuFRdPkGtuVhwhN4hePBKwppX/Hd4jQQMDUQ1Q1jo/QzNuvwVXunykAngxBX5ae61loBaMaEkuxl+xH1KIaH9n1h5KPQJZ8X+qPCkvlRjMntns8hFJPKSra1ZE1tFX/TEAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245484; c=relaxed/simple;
	bh=R6iW/mU31KGdvS84BeKMSKNktsVhPwIhbdJwzaLBxXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzrwbcMfaSZN9UVZUkrLP0/q82mYUW9qUm0jrvviVqzfpEB6QH+23YZMmUNioDAwTj008c/i8wAT8eRbAwum2OONHhl8QORjuConKlsbp1HY4Fng5ffjV2G12JTn+fH9044uUeSrLxZsNJL+963L4LdQzUoOKL5shs3WjpnOFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TTNsfDWP; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762245478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OgNnOMsS50KZEW2Uu5LLuchS1BcFg93kxAnhG0zifF0=;
	b=TTNsfDWPw4SN7MyW7OwQGbloCmpkQ4GOZn86TPZAjHsddPG7e2W8c65FrBum0rATGdfa8H
	0/4NV6WriY+ObP9+5vFDgWgNT4QwnbpZZ6CHvKC5Mw5fWKwM94z3ZOV/y3ymInTCNXuy6u
	lV4zLs2mxsGWY0Uf26e29y97bu5H4Gg=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH v3 0/2] mm/hugetlb: refactor sysfs/sysctl interfaces
Date: Tue,  4 Nov 2025 16:37:41 +0800
Message-ID: <cover.1762245157.git.zhuhui@kylinos.cn>
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
 mm/hugetlb_internal.h | 113 ++++++
 mm/hugetlb_sysctl.c   | 133 +++++++
 mm/hugetlb_sysfs.c    | 629 +++++++++++++++++++++++++++++++
 6 files changed, 887 insertions(+), 844 deletions(-)
 create mode 100644 mm/hugetlb_internal.h
 create mode 100644 mm/hugetlb_sysctl.c
 create mode 100644 mm/hugetlb_sysfs.c

-- 
2.43.0


