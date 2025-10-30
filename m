Return-Path: <linux-kernel+bounces-878032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 672C2C1F9B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668B3188EBD9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE7434D92C;
	Thu, 30 Oct 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWxnrBI4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF3C23D2B2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820965; cv=none; b=HCSEqIVkPO+xU/FDMBQmPDPFdDuSdi7pRTUcK1vUowS9IILEko0FftogQMLJbvKDgMyreh2kZmSjsFgF2jrpWPaAwEnKvpSamFX6bJ5F9CFxB7clwOoYKhL/I97fiuCPSnPyUtg/gNsiHGaLClHoRGKn7i1GqzLtMIgUuz0hVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820965; c=relaxed/simple;
	bh=G9W7fptY1OBNfQ3kQqrC8Ke7TKS8aSvFyr6gkJbxgUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+j1KGlYiCSznIMxJkpqL1ljhwE53VFttotjaBg0Hv+46s8+3Oxq5Fo8oa3fxhtesp9j0Z9l0v7urQBMN0c+5FOglDMOQJPk/1Oi92WInHpedfTghtQi2riIH1jK2P5grgqSJLrsx01zftHsllCdLMl4nTwXvnCEgMyy2su+lIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWxnrBI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCDFC4CEF1;
	Thu, 30 Oct 2025 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761820965;
	bh=G9W7fptY1OBNfQ3kQqrC8Ke7TKS8aSvFyr6gkJbxgUg=;
	h=From:To:Cc:Subject:Date:From;
	b=UWxnrBI4ivtJN0Jwz6QcrF6kihuKvTd0MeM43P/V2bB7GGlr8K+GC+QX80bw5jfk0
	 aPFGS1/TOmBBPhxB8UpGzj3dx2PI51JsVNvR0wRcEqTRuEyOib1mg+MUBWB07IO/yG
	 jourJZHBYoYHrf+w9Ce9dm3ICl9tfKVltmpjOHRhaAPAN+BGogpyZDxMEqKhC+Foip
	 +STsayyFPtSgD49XjkrpXP/fyoGHX/5FSoIiy7NT4Oq4/wD3sNkSSRORiWnaigSnIw
	 DmRIJhDfcGsgyu8a0tEdGygTTys0v0D66tIMqAnGgwtePRJyJ/IC0DfHT77DBAWFGT
	 gNEsZweoPC1Zw==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Melissa Wen <mwen@igalia.com>,
	Steven Price <steven.price@arm.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/sched: Add bloody spinlocks
Date: Thu, 30 Oct 2025 11:42:18 +0100
Message-ID: <20251030104219.181704-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scheduler wouldn't be the scheduler if there weren't functions like
drm_sched_job_arm() being called probably a few thousand times per
second without taking proper locks, just racing wildly.

This series adds the proper locks to drm_sched_job_init() and
drm_sched_job_arm().

Philipp Stanner (2):
  drm/sched: Use proper locks in drm_sched_job_arm()
  drm/sched: Use proper locks for drm_sched_job_init()

 drivers/gpu/drm/scheduler/sched_main.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.49.0


