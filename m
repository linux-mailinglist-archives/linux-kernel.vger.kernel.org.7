Return-Path: <linux-kernel+bounces-863733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E85BF8F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09ABA18946AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA60828D836;
	Tue, 21 Oct 2025 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yt2y+70B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8827CCE0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082798; cv=none; b=jCRrnT14TQeAR+8B6z4NLdXFugqsqRFPOKZo1tlt9qK2lMIqavLoX019mhfo2bl8ecXhETaX9UH7WylQ91Dq3z4zL6c0M7PkWfUylOEplE6pmecKe06n2aKeTp0NVtjI/3bcxqEUz5T6HyqyDhFMB+G7cavLnO/RUhmS2Np2SMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082798; c=relaxed/simple;
	bh=Dm7fBJrmeRqUOd7SUAITD1ocwsj7sewHlX2fP6+4l4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VhCaqxYukWac/l9FexLiVE8rj0oHaKa7E9z2+PMS3F7RakIz2M0+tWSWBhca9b07FOFHM8fvP2VhJB5yE5/h6xt/rzhrFJC4yGUXTPPji11pL/UViiJVDdhOkYQ3HoFMbZW6djy9FHpEkGUQp6TCRSTPlPUrWdwOpsQDHYmkNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yt2y+70B; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761082797; x=1792618797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dm7fBJrmeRqUOd7SUAITD1ocwsj7sewHlX2fP6+4l4U=;
  b=Yt2y+70BKUv4Rb7Rb3MYSTvDZeC/KMCi7GLBt0XnoJZPrsWdFh+H6fQj
   csA3UmwFLuqd3CnjdbLEn/m9K7TmMgmRVhwo3oxrXkx6By6Zs9KJTxD3g
   pZu60K5Jje17gcBV1dSp4CWShXdcWfpTK/Uao/YOcfTvwtpq62d9TR5u1
   0bz1mPoxHxXhEt78unNqUCMuHe+QZDsIRwUJoZssuYGv4CWSO2feqcn01
   gXfh9e7x06sG/qh4fIBJwlA9JUhQsF1Xe51rHY8Gl248bzRexvLO2wTO3
   8nwxD67E57U7CYkmpX1Vt7kVx738wzQ8B3QU0hzf3tDeqUZJVvEuZ97YI
   Q==;
X-CSE-ConnectionGUID: 0cYTu3rNTziqZx8ynF8MjQ==
X-CSE-MsgGUID: jlTnikGtR9KdVFsPKDpsxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62923171"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="62923171"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 14:39:56 -0700
X-CSE-ConnectionGUID: L5qe20RJQYe7LvDpnTGhug==
X-CSE-MsgGUID: uUtmQBFUSd6ASgZ6DIQjkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="184099253"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 14:39:55 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: jiangshanlai@gmail.com,
	tj@kernel.org,
	simona.vetter@ffwll.ch,
	christian.koenig@amd.com,
	pstanner@redhat.com,
	dakr@kernel.org
Subject: [RFC PATCH 0/3] Enforce DRM scheduler reclaim rules
Date: Tue, 21 Oct 2025 14:39:49 -0700
Message-Id: <20251021213952.746900-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Over the past year, I've randomly reviewed new drivers using the DRM
scheduler and repeatedly spotted misuses related to reclaim. This update
to the DRM scheduler aims to catch some of these misuses.

It's quite possible that this change will expose bugs in upstream
drivers, which is why it's being submitted as an RFC."

Matt

Matthew Brost (3):
  workqueue: Add an interface to taint workqueue lockdep with reclaim
  drm/sched: Taint workqueues with reclaim
  drm/sched: Prevent adding dependencies to an armed job

 drivers/gpu/drm/scheduler/sched_main.c | 10 +++++++++-
 include/linux/workqueue.h              | 19 +++++++++++++++++++
 kernel/workqueue.c                     |  9 +++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.34.1


