Return-Path: <linux-kernel+bounces-844406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C999BC1D66
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1986E19A18FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EBA1E32B7;
	Tue,  7 Oct 2025 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Ro9yLJ/2"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB78BEC
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849370; cv=pass; b=hPWjrWF/MnZ48Sk192IjZbJ0RDRj5ar3ozjKaIiqFelG4BCQRovpnP4vcDkV4KUNJLI1JnL52SWX+yLdoP/qZfR7whmCQxxw1uGUwFdPU/gHdP6MTsnD8BPW8HKEQ8MFwyXgQ/Avv224+WDGuV2ndmLn8yp/ig0u+xol3FRZzos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849370; c=relaxed/simple;
	bh=sfqFXEOQGJ6lvXzzDaLUOqIhq+iZxbTvHVI0Cr4zzL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lIgSEUM1vfnYsldYHpibz6kSTlQh8WEr1zWnVYLbe1vNn7MFhZWJHegfh2G5gN3lQ1WKHmY2w3iMG5szFfkMUwveGF62nxuvhYVmluNlH0zUakWHG9JfEGyoQW+oM4oezQ5GCIHryx0iKMzBcOY4JGvOGMKZcwvGrEk7hcwcOP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Ro9yLJ/2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759849360; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M50HM7e4rrY4ttTqgW4yR3p1dKwc4ucsxPdWmEZQc23nLhIYdCayBcEuL8Km097DqTD0ysrRORoTdxYHlNvdw6UYddM66xN8DZPu6q70Yhqr8KohXzg3fPNf63ZNpdFgKHnXR9gOf/f644Kcxv7siLC9yN7iRpADHX+EKoOWWwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759849360; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=g+HW6MfkUt7E20j/Xt2mgSDYhDTXOKhdIRu4lYcnmRo=; 
	b=f2mhktMbRD5kq/IbjjcKz5aHDdD7pojtxWEjeQoR6opmeHjpK8HIwhkGTlrqbxlT/70i7PDi482OkVLcDvX8XP3Tcc2oaMFhN4oPrHXJ0QF3SBgqRW41cV61sNsrWzPOZebFTrLUkNV/Z+5TuJFN6+VC2Zj+Bc4KS0ysQb7Vk8E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759849360;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=g+HW6MfkUt7E20j/Xt2mgSDYhDTXOKhdIRu4lYcnmRo=;
	b=Ro9yLJ/2gdTFF3KDEriH4YCzhVMIMQ9wkHjmqnzVQATVQScB1aZqTNcfhznj1vng
	niRBUQ70q0zZnvBphWuF52qJ33HtH5jvSQ3zQN54Hb82VddBvjD36en8fEcquilI1fT
	UKNXJvH4ONp29rueqM/PJTPEdsCpVI63P1XyAgTA=
Received: by mx.zohomail.com with SMTPS id 1759849357913151.85939094255968;
	Tue, 7 Oct 2025 08:02:37 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v5 00/12] Some Panfrost fixes and improvements
Date: Tue,  7 Oct 2025 16:01:42 +0100
Message-ID: <20251007150216.254250-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v5 of https://lore.kernel.org/dri-devel/20251001022039.1215976-1-adrian.larumbe@collabora.com/

This patch series is a collection of minor fixes and improvements I came up
with while working on driver related stuff.

Changelog:
 v5:
 - Move devfreq record keeping further down job submission function to
 keep busy count balanced in case of an early bail-out.
 - In MMU page fault ISR, bail out when sgt for 2MiB page is not assigned,
 rather than when the page array is populated. Add new commit for this.
 - Add commit with myself as a new Panfrost maintainer

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

Adrián Larumbe (12):
  drm/panfrost: Replace DRM driver allocation method with newer one
  drm/panfrost: Handle inexistent GPU during probe
  drm/panfrost: Handle job HW submit errors
  drm/panfrost: Handle error when allocating AS number
  drm/panfrost: Check sgt to know whether pages are already mapped
  drm/panfrost: Handle page mapping failure
  drm/panfrost: Don't rework job IRQ enable mask in the enable path
  drm/panfrost: Make re-enabling job interrupts at device reset optional
  drm/panfrost: Add forward declaration and types header
  drm/panfrost: Remove unused device property
  drm/panfrost: Rename panfrost_job functions to reflect real role
  MAINTAINERS: Add Adrian Larumbe as Panfrost driver maintainer

 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |   4 +-
 drivers/gpu/drm/panfrost/panfrost_device.c    |  68 +++++----
 drivers/gpu/drm/panfrost/panfrost_device.h    |  13 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  78 ++++------
 drivers/gpu/drm/panfrost/panfrost_dump.c      |   8 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c       |   8 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |   4 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c       |  64 ++++----
 drivers/gpu/drm/panfrost/panfrost_job.c       | 139 ++++++++---------
 drivers/gpu/drm/panfrost/panfrost_job.h       |  15 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c       | 142 ++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_mmu.h       |   3 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c   |  27 ++--
 14 files changed, 320 insertions(+), 254 deletions(-)

--
2.51.0

