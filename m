Return-Path: <linux-kernel+bounces-761134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ABAB1F4CF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3088E189F36D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4163FE7;
	Sat,  9 Aug 2025 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8NNhEVt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11BE1D61BC
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754747533; cv=none; b=XsKDlaJintAm4+nD1cxJu703WdzQPvHshWcregV+kfqN6+r8FKdG1q496DAKJBIic+B9B5A1Z6b07P4+0H0mn47pE4+PIwEc9KvN27RECSbTz/x0UuTuAAaawUrKthC6T7UzoPfuSkw3wdmXUZxrpXjrqQ6+eKmvrUas5lhodbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754747533; c=relaxed/simple;
	bh=q1E+6movKrkbWWn1YIxowCcpYwpJzZ4S/2KgkpxsTZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gOWXFTu/fNYjk6qJkqSlWcKYkpSjG4fwtWyCfrAxcX+y+BUVTzZLTov6U88vqQE+uJofw4ZMjYWtASw77rWx4uY7NHS5R8UjKTrR/yiUQaqiGV+5/Yg/99EKvM4gi7OtKZtRnOGFfWgLbEj4m+nNf/HPkqohihzrmBexO7y/3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8NNhEVt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754747531; x=1786283531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q1E+6movKrkbWWn1YIxowCcpYwpJzZ4S/2KgkpxsTZ0=;
  b=I8NNhEVtaHTg86D3haV1i2lsT3VyaR/A3Vq55KURGYW+KWJZQ7RziVrv
   CvToi/E3gTGT2VnWgxmjj2v2dlRj0kxFbiELY+7A2nA4TG5hEGjfhdO/g
   7tjHI7/CL4A34FWmutpuwEUPbGbhGtw68qHk81aarBA/N4En9FWF0N+fU
   O8eGemPJhn4bUmb+kkxSgDtIEOXhlVVt1VmvZfgqJiNhPe1mwreJCznAc
   3Q58ex4qqld5kidOWqWPgPiKJEIan/3nO6zMWhhD3rMVcq/lWtBmTjRho
   9eoJA9mY/ak4NDrGy8UGJYyUIxEsRa1+VOiY6k8EzTjmmU2BIQF97mGTh
   g==;
X-CSE-ConnectionGUID: AQ/ly2PGQiCKhrGQplC00g==
X-CSE-MsgGUID: TQOmusf0Q526SqpwlH9ibQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68153539"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68153539"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 06:52:11 -0700
X-CSE-ConnectionGUID: 25aNQBvOS2m/jcr0ygh+aQ==
X-CSE-MsgGUID: 3sTbtFcQRkOaj6hFjq2FBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165903733"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.244.28])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 06:52:09 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dave Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC PATCH 0/6] Multi-pass MMU interval notifiers
Date: Sat,  9 Aug 2025 15:51:31 +0200
Message-ID: <20250809135137.259427-1-thomas.hellstrom@linux.intel.com>
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
for them to complete on all GPUs.
    
One can do this on per-driver basis multiplexing per-driver
notifiers but that would mean sharing the notifier "user" lock
across all GPUs and that doesn't scale well either, so adding support
for multi-pass in the core appears like the right choice.

So this series does that, with pach 1 implementing the core support
and also describes the choices made.
The rest of the patches implements a POC with drm_gpusvm, but this
will also come in handy for things like userptr where waiting for
bind completion, starting of preemption and waiting for
preemption completion can pe pipelined across GPUs.

Any feedback or suggestions for alternative approches appreciated.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@gmail.com>
Cc: <dri-devel@lists.freedesktop.org>
Cc: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>

Matthew Brost (5):
  drm/gpusvm: Update GPU SVM / Xe to twopass MMU notifier
  drm/gpusvm: Add drm_gpusvm_in_notifier_* helpers
  drm/xe: Skip waiting on unarmed fences in
    xe_gt_tlb_invalidation_fence_wait
  drm/xe: Add fences argument to xe_vm_range_tilemask_tlb_invalidation
  drm/xe: Implement two pass MMU notifiers for SVM

Thomas Hellström (1):
  mm/mmu_notifier: Allow multiple struct mmu_interval_notifier passes

 drivers/gpu/drm/drm_gpusvm.c                | 18 +++--
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h |  3 +-
 drivers/gpu/drm/xe/xe_svm.c                 | 84 +++++++++++++++++----
 drivers/gpu/drm/xe/xe_vm.c                  | 26 ++++---
 drivers/gpu/drm/xe/xe_vm.h                  |  6 +-
 include/drm/drm_gpusvm.h                    | 33 ++++++--
 include/linux/mmu_notifier.h                | 30 ++++++++
 mm/mmu_notifier.c                           | 67 +++++++++++++---
 8 files changed, 217 insertions(+), 50 deletions(-)

-- 
2.50.1


