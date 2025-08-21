Return-Path: <linux-kernel+bounces-779671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D95B2F70A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7A31C80E76
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DC73112BD;
	Thu, 21 Aug 2025 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JensetTB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD94A30F53E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776820; cv=none; b=UPFKvRKjJzIVF+SXctuG6AXEg1it4KuP1Gouw3/+95HNhSuCr3RR6vICnzXMO8g3q4PsMcaoLHm3whYKhJHubJGNV3Wf9w+i8JwJru8Jv7chTVOPVQJWNmhxwowRndGXGyvEoWh1L/CQNz5ZJmIsZG/yj/4ri8yU8VssOk+v4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776820; c=relaxed/simple;
	bh=iX+aI4EV6aIpB48ENfwpl4TWhZJPqVgs0W+CzzXlU1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnkU/YXO4kwbEGkUB+pR5CWR2uTcXBgSaG1xYva4fhBV4Z0vxjwiyOtgAlFdYPjF3nODJgcOSoOF5b6JRXrPb44R7ewsVc4hH9cZOS7GQx5NFomQPL9V6QxqZPXraYZgmclVN3McjZdS1aV1SGpyJvm+9Up/8tTdg8vLrZa53R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JensetTB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755776819; x=1787312819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iX+aI4EV6aIpB48ENfwpl4TWhZJPqVgs0W+CzzXlU1w=;
  b=JensetTBRP24duAayxbWJnRlj7ZQGjnu17jtS0bKAbY2Eq7NbOaBl8ZA
   cpCpmptVy2YBIOLjcNpveZNlbKBzWso92PITCltAPQXk4G25qyiCD2I6g
   I/PfK6w47i8tGtOrSoFKl82fKe978DA1/HeYpxea3xncy0eYQOwTOO3f1
   fDatM7y5snmeQXZ4QuoBhjsSQYEbsC8xZlUDwOI5kvec9FqhhDqBu2Kay
   iuoOX5OV/92YGJMcAJqH8rz9LXUAVuahEWa294f1P8mnNmKJSKht6jh2J
   TAdO0lfN2UdBxXBTn7wha/AqityTOdcuAINmjqQFn/nD+T8l9cCSV3AvK
   w==;
X-CSE-ConnectionGUID: Wh0Z0LQOTJqAHhYF1M8uSA==
X-CSE-MsgGUID: tZd+YijlT6GI35ytA0jKxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57989471"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57989471"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 04:46:59 -0700
X-CSE-ConnectionGUID: 2aESyLHIQ3yVR5zRt1Vzfw==
X-CSE-MsgGUID: F6OSijqkS1qWmYbSMZkCTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172613648"
Received: from johunt-mobl9.ger.corp.intel.com (HELO fedora) ([10.245.245.201])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 04:46:56 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dave Airlie <airlied@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] drm/xe: Skip waiting on unarmed fences in xe_gt_tlb_invalidation_fence_wait
Date: Thu, 21 Aug 2025 13:46:24 +0200
Message-ID: <20250821114626.89818-5-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821114626.89818-1-thomas.hellstrom@linux.intel.com>
References: <20250821114626.89818-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

Avoids unnecessary waits when the TLB invalidation fence has not been
armed, simplifying caller logic in cases where the fence status is
uncertain.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h
index f7f0f2eaf4b5..c6d4398d3429 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h
@@ -34,7 +34,8 @@ void xe_gt_tlb_invalidation_fence_signal(struct xe_gt_tlb_invalidation_fence *fe
 static inline void
 xe_gt_tlb_invalidation_fence_wait(struct xe_gt_tlb_invalidation_fence *fence)
 {
-	dma_fence_wait(&fence->base, false);
+	if (fence->seqno)
+		dma_fence_wait(&fence->base, false);
 }
 
 #endif	/* _XE_GT_TLB_INVALIDATION_ */
-- 
2.50.1


