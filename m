Return-Path: <linux-kernel+bounces-897056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DACC1C51EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 046A450195A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B009E30DD14;
	Wed, 12 Nov 2025 11:08:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C65E30274F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945700; cv=none; b=V/Vh8fVbEwEcfa730iQmsqSHOucFzdt+ehaf9cygcio2qiO8+wLa/YMfMNd8Du5d8hcKSzIVhc117SRZna+wwm9xYuT+rXYJfm30tohrlI8Y5ZJAPSf/024MLQYeaN4xHILsKYGlYCzXkIrBTe9/XWUwCvE0wU9SkNXoIeTdc2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945700; c=relaxed/simple;
	bh=8G6LWFyZS6ZBuBopG9CXWV4bFF4XRFtHs9WSGgw0AMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qYLCgMON59DMKqHFeLuSzgPHUXu4V/cvcbqkbBrn6asm7xRPiwiAriuNw7R2Vb6U+Xq5Zm5PfyjH/ulQigzEeMoCAnYnsCi6MVXJGCBFgqj5EG1uwDHzpKAT1E3OL0WXiLMUWKQvrBH8YrAK2rzC8Ng1L6rX7l3DrVQDqvd+H+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F6F31515;
	Wed, 12 Nov 2025 03:08:10 -0800 (PST)
Received: from MacBook-Pro.blr.arm.com.com (unknown [10.164.18.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD24E3F66E;
	Wed, 12 Nov 2025 03:08:12 -0800 (PST)
From: Dev Jain <dev.jain@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	urezki@gmail.com,
	akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	shijie@os.amperecomputing.com,
	yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	npiggin@gmail.com,
	willy@infradead.org,
	david@kernel.org,
	ziy@nvidia.com,
	Dev Jain <dev.jain@arm.com>
Subject: [RFC PATCH 0/2] Enable vmalloc block mappings by default on arm64
Date: Wed, 12 Nov 2025 16:38:05 +0530
Message-Id: <20251112110807.69958-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the quest for reducing TLB pressure via block mappings, enable huge
vmalloc by default on arm64 for BBML2-noabort systems which support kernel
live mapping split.

This series is an RFC, because I cannot get a performance improvement for
the usual benchmarks which we have. Currently, vmalloc follows an opt-in
approach for block mappings - the users calling vmalloc_huge() are the ones
which expect the most advantage from block mappings. Most users of
vmalloc(), kvmalloc() and kvzalloc() map a single page. After applying this
series, it is expected that a considerable number of users will produce
cont mappings, and probably none will produce PMD mappings.

I am asking for help from the community in testing - I believe that one of
the testing methods is xfstests: a lot of code uses the APIs mentioned
above. I am hoping that someone can jump in and run at least xfstests, and
probably some other tests which can take advantage of the reduced TLB
pressure from vmalloc cont mappings.

Dev Jain (2):
  mm/vmalloc: Do not align size to huge size
  arm64/mm: Enable vmalloc-huge by default

 arch/arm64/include/asm/vmalloc.h |  6 +++++
 arch/arm64/mm/pageattr.c         |  4 +--
 include/linux/vmalloc.h          |  7 +++++
 mm/vmalloc.c                     | 44 +++++++++++++++++++++++++-------
 4 files changed, 49 insertions(+), 12 deletions(-)

-- 
2.30.2


