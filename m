Return-Path: <linux-kernel+bounces-824053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5778EB88049
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C013567020
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D41A2BE7A7;
	Fri, 19 Sep 2025 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyBwHguv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F972BEFE5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264303; cv=none; b=RZyIXDDDMasWsJBthTGFh5zjpQ6Rdy6Bsa5qYa0EZ8nnljggvC63LuaHMC4QoKbrkyQ0MXVRgQHsOz8TpvFL3IoWau/sVkwSsUhEE1pHgAS9vCUmiZGfz+WcmtvF33YxyDAZNqAr2DEnzoCH7Q/iIMBiNqinHXsUsdVqYZgS8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264303; c=relaxed/simple;
	bh=KIA8ppq75AqYjHD54M5PYbqoYphNBHtZ2oKI5v22ZqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQQEf2FIiujve+4kSAQc//jImAPsTQ1V3LpjBKprZgYh3ifiiCR3uO/LyXCwq5hOB2RLtUNK63Q12epCkp32jPKEsnxpspKrtwC4JRxfmrQ/CJh0MnNZHqa+5mpbqLMt/qgt61QH4fa0ORImwbeeBLHrtVavGqEYdfn9SzIsMdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyBwHguv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1524DC4CEF0;
	Fri, 19 Sep 2025 06:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758264302;
	bh=KIA8ppq75AqYjHD54M5PYbqoYphNBHtZ2oKI5v22ZqU=;
	h=From:To:Cc:Subject:Date:From;
	b=dyBwHguvoM78TJs5sViPOZnCVV/sDlfpQLmH69bIhmJYgrUl8I3ePjSfRE0WqZnAz
	 lHHsWG2wmj7HyeEfMiV+Vkxmu3WmSpszgR/QQXraK2wbUTnOkPx/5+TOWq88S+JYTV
	 bhs5XyPRVmuYr6pjVyo/PK3Zq/BcKsYw+GCqrqtVaWva5fzjkPdTQ+BLLW/6JkDVt4
	 7y6hpuRWe370SOwrZEXHrZe9dZZ9rqN6D3OVdUSNyQq6JhmkJLLRThTYtEP3vNCzGp
	 hHhuLUb5aV0OFGFXfMZR5sNU7QuZOnK1A5v4UylVhMTnI/HDtMV8sK8NNxvYcLMXIv
	 bdSvkqQAh6d7Q==
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
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sched/tests: Remove relict of done_list
Date: Fri, 19 Sep 2025 08:44:51 +0200
Message-ID: <20250919064450.147176-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A rework of the scheduler unit tests removed the done_list. That list is
still mentioned in the mock test header.

Remove that relict.

Fixes: 4576de9b7977 ("drm/sched/tests: Implement cancel_job() callback")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/tests/sched_tests.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/tests/sched_tests.h b/drivers/gpu/drm/scheduler/tests/sched_tests.h
index 7f31d35780cc..553d45abd057 100644
--- a/drivers/gpu/drm/scheduler/tests/sched_tests.h
+++ b/drivers/gpu/drm/scheduler/tests/sched_tests.h
@@ -31,9 +31,8 @@
  *
  * @base: DRM scheduler base class
  * @test: Backpointer to owning the kunit test case
- * @lock: Lock to protect the simulated @hw_timeline, @job_list and @done_list
+ * @lock: Lock to protect the simulated @hw_timeline and @job_list
  * @job_list: List of jobs submitted to the mock GPU
- * @done_list: List of jobs completed by the mock GPU
  * @hw_timeline: Simulated hardware timeline has a @context, @next_seqno and
  *		 @cur_seqno for implementing a struct dma_fence signaling the
  *		 simulated job completion.
-- 
2.49.0


