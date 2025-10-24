Return-Path: <linux-kernel+bounces-868917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D819C067CC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4220D4FEFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A2C31DDB8;
	Fri, 24 Oct 2025 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF+FP/8+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB631DDA0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312359; cv=none; b=i/0OU0Y71/yj8z4Dc8+qRiJq8m8ukzMvb2wLltKOBPh0W6ytSVHPcEEK8vD5PdW+4jI1Ogwlgl439uPEFUPNKGU/YAG7jARdYnITY3QIK+QgMlZrAHxw1Ih4keTIsMuEbmeMaVsblNyGxreIGOtJRP7T/CuGqTrWGYgWE0VdFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312359; c=relaxed/simple;
	bh=1k6GPfiODPV2ef9SPd16iFtuNoH+CMuvx4kCvmktKNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P47mcCeSXc7T2qqIF6juhBMdSz4lUXHADapvqXiu/m+eo2QAeUNxQdUmtP2CDyeA06gLiBaqpddv6la6nKIbA06Q36tih4EeuTP+necdM8mgwFxYcWPOSpnGxo5NS+YMKqAvKjEm+DUPSxMkGMlkY6injkf+cNEM/O50sUk4pHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF+FP/8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A325FC4CEF5;
	Fri, 24 Oct 2025 13:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761312358;
	bh=1k6GPfiODPV2ef9SPd16iFtuNoH+CMuvx4kCvmktKNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iF+FP/8+eDHFA/VrzHc9LGjGqOLUIo2kNsUGNGN13bKhhIhgHdqoQ1yknILKXXleo
	 8fSWGywDW4VB5HwDTXp0FSYViPpwe9G46UTzRNj0R+EOP1rm8RfW8lcV1n+/WrG1gJ
	 V4qB4oc2IMUP4uJYPVAI+iVGaGx76jGFiAg7/BrndlEU8QUv4rr6PTlk80jzUNkFeR
	 iH8tSnFhAZ2WAhzy16skQOm8WOa7BuuvKlJSl4/kTcR9rvtSHtT9nMHMyM2wTyFGBK
	 0tUyX8zApIRiOK6m4v5eITgR7y1s6jJi2J6DLyh0fCLjk56NmnMwjzmGP5UWXxc6NH
	 hL4nMq/5ememA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 4/6] timers/migration: Assert that hotplug preparing CPU is part of stable active hierarchy
Date: Fri, 24 Oct 2025 15:25:34 +0200
Message-ID: <20251024132536.39841-5-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024132536.39841-1-frederic@kernel.org>
References: <20251024132536.39841-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPU doing the prepare work for a remote target must be online from
the tree point of view and its hierarchy must be active, otherwise
propagating its active state up to the new root branch would be either
incorrect or racy.

Assert those conditions with more sanity checks.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 49635a2b7ee2..bddd816faaeb 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1703,6 +1703,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node,
 
 	if (activate) {
 		struct tmigr_walk data;
+		union tmigr_state state;
 
 		/*
 		 * To prevent inconsistent states, active children need to be active in
@@ -1726,6 +1727,8 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node,
 		 *   the new childmask and parent to subsequent walkers through this
 		 *   @child. Therefore propagate active state unconditionally.
 		 */
+		state.state = atomic_read(&start->migr_state);
+		WARN_ON_ONCE(!state.active);
 		WARN_ON_ONCE(!start->parent);
 		data.childmask = start->groupmask;
 		__walk_groups_from(tmigr_active_up, &data, start, start->parent);
@@ -1768,6 +1771,11 @@ static int tmigr_add_cpu(unsigned int cpu)
 		 * active or not) and/or release an uninitialized childmask.
 		 */
 		WARN_ON_ONCE(cpu == raw_smp_processor_id());
+		/*
+		 * The (likely) current CPU is expected to be online in the hierarchy,
+		 * otherwise the old root may not be active as expected.
+		 */
+		WARN_ON_ONCE(!per_cpu_ptr(&tmigr_cpu, raw_smp_processor_id())->online);
 		ret = tmigr_setup_groups(-1, old_root->numa_node, old_root, true);
 	}
 
-- 
2.51.0


