Return-Path: <linux-kernel+bounces-779666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06702B2F70B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6221724CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEFC25A2B4;
	Thu, 21 Aug 2025 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdWjF+Mv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6C1C701F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776809; cv=none; b=PHAPUZ8o5a340HGsGxYeYsLtAwPgWeiYyWl8P7ZsKf2Sw0Hvt2tpK6vFUNfUS/yShupdC48eHpZNHBEMbROWBSOGWqRJFuRVzws/azNjVHC6YuYV6HsiRAZILrbdU7tCk0IuhnlJSFaIGqVwobX9Tr22+t8vLJkdeB1PuxXsJPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776809; c=relaxed/simple;
	bh=7uXfokjMPHH00LPtHChffrlYvCk5IWl4R1qCTaEowDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HpwR29qNIRPpwqo7MEO84Z61KkW/83ynyVsXMdTWO4cHH9YEcB1mKcsB2U75oxgf7PARVaLn9e67RVKkqU9RY3NtbTAgpAUHe2JY/LuZNafpNM8gPZpdi9h2h8d0aoJGhq3rtFS7fwDDRTH5dLOyyW+xH+Jx6pem3VFKoDzsAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdWjF+Mv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755776808; x=1787312808;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7uXfokjMPHH00LPtHChffrlYvCk5IWl4R1qCTaEowDw=;
  b=SdWjF+MvzSdARgf7+uj+IpiTVlWtybYUH3o4rVHgOGP3060/GwiLpxjj
   BToDRxbZYgPK+UNUEePZCy/JUGU0u3X1kBuSZAd30fZG5P3wrjY3sDiui
   c7jP6Pwk8oY1/7zwoQwDNAYQnGyedi+/WrEpOyiIzMHji1inTgOFCU1/s
   DeVFXZXpbqJdTg7Wd2zl2qD89XoNk2wUr64FaPKph3XA0Yc+7LLmoEnoq
   BryWbfWiT3fHN+2fvk+hxGXqEmNQeaiIBvVarqtZzT+s3a6f+4mZ/npdM
   gejKTdd2cQwuYqHPlXhDbqBWAHD3li5nAmqSmvGOObyGRQeaMVdstsxjh
   Q==;
X-CSE-ConnectionGUID: Uml7hJIYQLuGpPNRIWTFAg==
X-CSE-MsgGUID: NqCqP+g6SlSwlXmZ3odClg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57989432"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57989432"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 04:46:46 -0700
X-CSE-ConnectionGUID: Y8pJ+9VwQ6G4Wx9YReIMZg==
X-CSE-MsgGUID: MvxPC/g/T2aAKS3JJBXqIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172613623"
Received: from johunt-mobl9.ger.corp.intel.com (HELO fedora) ([10.245.245.201])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 04:46:43 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dave Airlie <airlied@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 0/6] Two-pass MMU interval notifiers
Date: Thu, 21 Aug 2025 13:46:20 +0200
Message-ID: <20250821114626.89818-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GPU use-cases for mmu_interval_notifiers with hmm often involve
starting a gpu operation and then waiting for it to complete.
These operations are typically context preemption or TLB flushing.
    
With single-pass notifiers per GPU this doesn't scale in
multi-gpu scenarios. In those scenarios we'd want to first start
preemption- or TLB flushing on all GPUs and as a second pass wait
for them to complete.
    
One can do this on per-driver basis multiplexing per-driver
notifiers but that would mean sharing the notifier "user" lock
across all GPUs and that doesn't scale well either, so adding support
for two-pass in the core appears like the right choice.

So this series does that, with pach 1 implementing the core support
and also describes the choices made.
The rest of the patches implements a POC with drm_gpusvm, but this
will also come in handy for things like userptr where waiting for
bind completion, starting of preemption and waiting for
preemption completion can pe pipelined across GPUs.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@gmail.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: <dri-devel@lists.freedesktop.org>
Cc: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>

Matthew Brost (5):
  drm/gpusvm, drm/xe: Update GPU SVM / Xe to twopass MMU notifier
  drm/gpusvm: Add drm_gpusvm_in_notifier_* helpers
  drm/xe: Skip waiting on unarmed fences in
    xe_gt_tlb_invalidation_fence_wait
  drm/xe: Add fences argument to xe_vm_range_tilemask_tlb_invalidation
  drm/xe: Implement two pass MMU notifiers for SVM

Thomas Hellström (1):
  mm/mmu_notifier: Allow two-pass struct mmu_interval_notifiers

 drivers/gpu/drm/drm_gpusvm.c                | 18 +++--
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h |  3 +-
 drivers/gpu/drm/xe/xe_svm.c                 | 83 +++++++++++++++++----
 drivers/gpu/drm/xe/xe_vm.c                  | 26 ++++---
 drivers/gpu/drm/xe/xe_vm.h                  |  6 +-
 include/drm/drm_gpusvm.h                    | 33 ++++++--
 include/linux/mmu_notifier.h                | 42 +++++++++++
 mm/mmu_notifier.c                           | 63 +++++++++++++---
 8 files changed, 224 insertions(+), 50 deletions(-)

-- 
2.50.1


