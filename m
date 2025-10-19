Return-Path: <linux-kernel+bounces-859746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94513BEE791
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7E5404145
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDB72EA15F;
	Sun, 19 Oct 2025 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="QwWhg18D"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C635966
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885569; cv=pass; b=KXA3n3zHqA52cW7Cvb1qTR+7ZA4xem4w01s5uOHM5E3xtMNW13Ed3SQobxzIhlvUXWlkTDK9exL6FN5BrWC1VxP9glKpOiuI1MjBcwUXXrkhEjKOAZCN42BfJx907x57lGQMbahx3xJI+luijBtauEUxoY9jL6csgoaeY7PUQJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885569; c=relaxed/simple;
	bh=f9Sxv6zCQAtYdUzq+3IgoSwZYu9WH8V19uAQIhF2HIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MtPvCJJWaHTNU50Yn0LJqKe6LmH3VGjrJTmLc1Oc+qRmZlfrX4dvuzeKap1OnL3ypib9/inWi5AZLCJNHiy3dzmeT0Cpkdj6VhW1qWwCJ68oD6XZCaq9Ydf8GPfr4GzwpsoxIjrkwNwqDnDGtE3VITNQfUYmrPyiNZ0oSC0NG+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=QwWhg18D; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760885560; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MW0z5lXqGzY3HhFMvgY4TQD0/J7cFZ//82rwPuk1DdcqH7ShmiPlQULjLRZznIpeg1JHm/OfELKnYUucsoJZ78Qx93T6QDFcPk+Gb9XCyHEt3JT28Dp33ralT998CWdMM6z4yaFCo5c/TMvti5GjekBmIG2PPnfxpHXak0yYHlY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760885560; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wN+rxbaSCw9jCmSv6yZ8kOmNpKpd4tFt8gHerSfTPLU=; 
	b=RrBIwMsnkHF2X7BYBvwh3gxKAcy70SXEeKqwFcmuPFHECk9VNM9FQeToBg0Z0vwccjB909ixwL3ABa7xkPzu2vahjn8bCDjmHGxsLJODselYzGP9tfuyPWVpidviDlCTrJ/4bC7/ysI49cArx1RgSlpjHtKMP22Qne5REFmxc6E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760885560;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wN+rxbaSCw9jCmSv6yZ8kOmNpKpd4tFt8gHerSfTPLU=;
	b=QwWhg18DZCJoHUUyQ9auOTXdDoVHePhoDGiSwonoAF0kcNJWwk694U79EjtTqZqG
	TXgQqlpqVT0KbOpNcfXg5e5FoUkO8fBJl33Q/YxiDHO48To3bztZGEtzYroS1bwf6dC
	D5heGaRcgnsUCfLagoAj2UiqpPa/KIabJfDSnZGg=
Received: by mx.zohomail.com with SMTPS id 1760885558544294.76544827797716;
	Sun, 19 Oct 2025 07:52:38 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v7 00/12] Some Panfrost fixes and improvements
Date: Sun, 19 Oct 2025 15:52:05 +0100
Message-ID: <20251019145225.3621989-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v7 of https://lore.kernel.org/dri-devel/20251015000930.356073-1-adrian.larumbe@collabora.com/

This patch series is a collection of minor fixes and improvements I came up
with while working on driver related stuff.

Changelog:
 v7:
  - Fixed bug when handling AS number allocation. In case of error and early
  bail-out, AS lock was being left in held state. This was uncovered by smart.
  - Added new R-b tags.
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
 drivers/gpu/drm/panfrost/panfrost_mmu.c       | 114 +++++++++-----
 drivers/gpu/drm/panfrost/panfrost_mmu.h       |   3 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c   |  26 ++--
 14 files changed, 303 insertions(+), 244 deletions(-)


base-commit: 7fb19ea1ec6aa85c75905b1fd732d50801e7fb28
--
2.51.0

