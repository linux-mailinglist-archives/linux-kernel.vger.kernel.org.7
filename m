Return-Path: <linux-kernel+bounces-838338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C10BAEFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276574A22E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62508270ED2;
	Wed,  1 Oct 2025 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="S6vUqYBu"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A622D9E9
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759285283; cv=pass; b=FjV0tQqZ8nRF/j05n5Vn1tP9O48VCmhnsHVOPRuXlDcmvnIOWgkanInQA/NTVrdaF6DlWcdWbaIm2WTnMBwY54mvJvHyxIyZnb/kOSzTa5t8O0IdCQZ5QNlPRmaC9WXarLolM4B8r9Hffw3HRjzUK1wjqG9+NVJaJ6Kj9Sq+vL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759285283; c=relaxed/simple;
	bh=LADZ+K/PHu21iXLJKoaCCWAeh9OWDTGihJIBYHBN1Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sfK6wB8Y6MFKNaOBUql/+oBwe1lXU4bxN6DV3MUwyOro+vLZeGyZehOjQOUDD9H+WD3SWIsHUHkDDqOtJ5fRyYaCFPgsKsy3fphTM8fAtAQrboRwrDgGi1YmcBtiU47QFak/Nu/XA8WwEg7YUBxVB+Tkkk3SeHDuxy0WnsTStUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=S6vUqYBu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759285272; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l/l7YV7ORCItERybZiFWJXdMLC0l7h8VFzBZ8BdjnTEE65naWjH1z2gOWxeFppwLtIdGEA2ar/ojXf1IWfv7Ee4h090Lwpr3guvTgOYGc/9aK8/mO+zFk/ORntpk27yUZHxA3gNJ3tCYrdelr8D+Ta5AEa4mkIhBCoWQt+QMwqo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759285272; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2NrKm8jzRFfGOz2HD5k6YW3Jg0p/MDlsbhOtGWwU+4I=; 
	b=m1q8QcPIIls6kgFivIGP4rSP0KTssPYnalFkgsOMcfaCZaNBeRVn0iMO5DmchQByn1I+0uIP0R0kzsDIsaIWjPa8cDdHMkJ02qf55dOqPhBe+7PEVqHtQtNodyo6sN47fa7EPlVWMhRgQdjJMhi7a+lYcd5ETjmtOPlqdo6rK4A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759285272;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2NrKm8jzRFfGOz2HD5k6YW3Jg0p/MDlsbhOtGWwU+4I=;
	b=S6vUqYBux8zsnB+z8x2tn7Z/E1FZL2oLxaDqvEbv+IoZ/TLWCAeKpW55eCMr8NhA
	GNlVV0qWt19t/6ue2lUq1j9iAUIQ2y+HLFc9z61xqUEvqe4k0KqI9GPqDbolswpU7PC
	PXtxpYhqSZDy6to6YLt3HMGvZRG5F1xep1prIcrE=
Received: by mx.zohomail.com with SMTPS id 1759285270752894.9552940649571;
	Tue, 30 Sep 2025 19:21:10 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v4 00/10]  Some Panfrost fixes and improvements
Date: Wed,  1 Oct 2025 03:20:21 +0100
Message-ID: <20251001022039.1215976-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v4 of https://lore.kernel.org/dri-devel/20241128211223.1805830-1-adrian.larumbe@collabora.com/

This patch series is a collection of minor fixes and improvements I came up
with while working on driver related stuff.

Changelog:

 v4:
  - Rebased older patch series onto latest drm-misc-next
  - Added patch for renaming JM functions to reflect their actual role
  - Fixed treatment of error code in perfcnt when enabling sample buffer AS

 v3:
  - Minor convenience fixes to patches 3 and 4 in the series
  - Move unmapping of maped range of BO to the function's error path
  in case of BO mapping failure, also for putting BO's pages
  - Split patch 6/8 into two: one makes sure the Job IRQ enablement mask
  isn't recalculated at every device reset and uses the same expression
  everywhere in the driver, and another one that breaks the enablement
  function into two stages.

 v2:
  - Removed commit that provided an explicit fence cleanup function
  - Added commit for removing unused Panfrost device structure member
  - Refactored how optional job interrupt reenabling during reset is handled
  - Make the way errors and successful return values are delivered from inside
   panfrost_mmu_as_get more according to standard.
  - Simplify unmapping of already mapped area when mapping the pages of a BO
  - Fixing management of runtime-PM reference counts when failing HW job submission.

Adrián Larumbe (10):
  drm/panfrost: Replace DRM driver allocation method with newer one
  drm/panfrost: Handle inexistent GPU during probe
  drm/panfrost: Handle job HW submit errors
  drm/panfrost: Handle error when allocating AS number
  drm/panfrost: Handle page mapping failure
  drm/panfrost: Don't rework job IRQ enable mask in the enable path
  drm/panfrost: Make re-enabling job interrupts at device reset optional
  drm/panfrost: Add forward declaration and types header
  drm/panfrost: Remove unused device property
  drm/panfrost: Rename panfrost_job functions to reflect real role

 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |   4 +-
 drivers/gpu/drm/panfrost/panfrost_device.c    |  68 ++++-----
 drivers/gpu/drm/panfrost/panfrost_device.h    |  13 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  78 ++++------
 drivers/gpu/drm/panfrost/panfrost_dump.c      |   8 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c       |   8 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |   4 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c       |  64 +++++----
 drivers/gpu/drm/panfrost/panfrost_job.c       | 135 +++++++++---------
 drivers/gpu/drm/panfrost/panfrost_job.h       |  15 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c       | 101 +++++++++----
 drivers/gpu/drm/panfrost/panfrost_mmu.h       |   3 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c   |  27 ++--
 13 files changed, 293 insertions(+), 235 deletions(-)


base-commit: 1a93d70801421ca506807ced45566490976d532a
--
2.51.0

