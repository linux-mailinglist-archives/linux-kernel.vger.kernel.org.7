Return-Path: <linux-kernel+bounces-853507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E59BDBDD1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 014CB4E11A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A2A2AD25;
	Wed, 15 Oct 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="LpTYOx6h"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A49645
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487020; cv=pass; b=hS+c2v3D7UxJlBBMNo+twihL2Ae0i7E6KDzvm42ImMd47MaQZt9FVPJwfQV9SqLT7km6gV0BLh9slClbU+JyNopF6pP6fJVdEis0vacGA09JiHyLulhFHOlgUTcGSneOcXjl1He83W9DMB7IUFJ+WXJzco2CB5ce1fwiXcF3iho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487020; c=relaxed/simple;
	bh=oCK92j149KARlUf2E7MSt/ZCC5K9BHuQcOPdSPeoOBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MpHJ547O1ocWJN4nXq4jo2uTe6r7bY8OTYPxpmNUzSUWP/BEdQU5kxEezwwZMxMV8NoO6kiMferFK1h6hyGMG41PzpK8R0zs4yTpHOK038sLnXrevGVVTyOvsY1F+qEIBhKfoRoOasnsBFbxaDDA2Kb4/a5LOUBvMo5KzVFaTXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=LpTYOx6h; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760487009; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DFZlO2rPaafOF4HdTWM3y7XJdogQdkURTyEbDJKoSrobdiToH8eZqJ/h4PfeQAqaSOL5P0UZHHbaz+qgjxDcb21yrx9RM1ZjT5x9NoR1VzrXGViDvmi0jseEvSX7kQu1D2nwXXIy8mFbSMf39Ei+1b10eYwFkZGcAVz+AR+hDLQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760487009; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2UtsHH33vBluEeez9ViwFl9II5p9dINHfIGGIsaLZP4=; 
	b=g/aU5thFB7+BJHAn5dEv9IUgtvIoqoP2pZXNxulayNP7Wr14FM3ByVaNFuqNlTRAm7crXi9JTikzzE5sU+8ry/Bzp3M5d4W6c6pcqUYGOglGNiSuhNkhgvOvBG+3wxsW/vgjgf6G36VT+VarXcaFLZF1JUmtpRruUlbUSZgYKCw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760487009;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2UtsHH33vBluEeez9ViwFl9II5p9dINHfIGGIsaLZP4=;
	b=LpTYOx6hPOxXdvF8Mjjdy1IX1V/QBZQoGmKO1QJMqH1Xq309H7bj3V4GspDB+KAW
	rBD94T1LGs1XtAMkYJ0eBN0kaFefG4l2zVABaNvXQscj7CvJ9I1CUTuvKo62g6WyQ/H
	Wwpk5Et/Rl8tZVQJ04DNn4MJupXtJ6rMU66VDLMU=
Received: by mx.zohomail.com with SMTPS id 1760487007316394.625204029311;
	Tue, 14 Oct 2025 17:10:07 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v6 00/12] Some Panfrost fixes and improvements
Date: Wed, 15 Oct 2025 01:09:06 +0100
Message-ID: <20251015000930.356073-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v6 of https://lore.kernel.org/dri-devel/20251007150216.254250-1-adrian.larumbe@collabora.com/

This patch series is a collection of minor fixes and improvements I came up
with while working on driver related stuff.

Changelog:
 v6:
  - Don't optimise page range walk in the event of a double MMU fault
  - Handle some minots and minor style changes
  - Rebase patch series onto latest drm-misc-next
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
  MAINTAINERS: Panfrost: Add Steven Price and Adrian Larumbe

 MAINTAINERS                                   |   3 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |   4 +-
 drivers/gpu/drm/panfrost/panfrost_device.c    |  68 +++++----
 drivers/gpu/drm/panfrost/panfrost_device.h    |  13 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  78 ++++------
 drivers/gpu/drm/panfrost/panfrost_dump.c      |   8 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c       |   8 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |   4 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c       |  64 ++++----
 drivers/gpu/drm/panfrost/panfrost_job.c       | 139 +++++++++---------
 drivers/gpu/drm/panfrost/panfrost_job.h       |  15 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c       | 112 +++++++++-----
 drivers/gpu/drm/panfrost/panfrost_mmu.h       |   3 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c   |  26 ++--
 14 files changed, 301 insertions(+), 244 deletions(-)


base-commit: 7fb19ea1ec6aa85c75905b1fd732d50801e7fb28
--
2.51.0

