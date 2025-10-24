Return-Path: <linux-kernel+bounces-868918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3574AC067CF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB2024F365E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F5F3203AF;
	Fri, 24 Oct 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJQxfl9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB1B31E0FD
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312360; cv=none; b=S9SddsHz+cw40yWmfnY58cka5TgyFU+XjBpCzTc92iz+TyoZZB0Yp6kXnH/Ev8dzPPrIYVX19o9WhcI4US72bLuumvBoWZvM+WbzzmG/E+XXx68R3O8+RisQY/wgkPZHFzwcak/rkEDaoZWWan5Tb6S7eOzNrB/O+MyIQLEOmdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312360; c=relaxed/simple;
	bh=fY1ij3id1DmAx5iQpPb3kIdcEzsoQu3dp77o1unz2j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+7YXHd1oOJJAqk/8T1jMJvShN5AP2ra8Diy0D5weVDOHjOxOF/TrwUVB3D1BQ3fguxqQZ3WpOdY9eZYe8aLOn5uC0oztEwCuOQBHJBBcOXjOJ62+Gau9SP52TztRd5KALCr2vOtx2HPnLNcVO70wWiZNgsa1qPEXYzKeYNKi5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJQxfl9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C0BC4CEFF;
	Fri, 24 Oct 2025 13:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761312360;
	bh=fY1ij3id1DmAx5iQpPb3kIdcEzsoQu3dp77o1unz2j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJQxfl9UCaK0s46rGdxuoczHrOPUep51SUbri8lupcN82mCmB2oncyAl9MgtEe5V1
	 9NLzXJapBrM17B+cXA+H7fX4BNSJs+c6MHT/+3CJHTKPGwQCyrnSbbUiVQnLAg1U9+
	 64AZq5tDSZDzqTpgRtH3c/AyVYd++O7xN/2uQdM/rIdqaz02NgMGyz0snGgIiSiPcD
	 0R+N9OEfEOy3mrx5omr5/gs0+sSNTmc3aQ2/3PZAsyAjBrPE+ST/BNujPWw4ic+RUS
	 vxAlAkIsIARTFTvXAM20Zs9rjMsG+48DwaZbgHXK7OY+6ALocWMJpOGe83O1VI8x4R
	 +mdB8SS+nPoaw==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 5/6] timers/migration: Remove unused "cpu" parameter from tmigr_get_group()
Date: Fri, 24 Oct 2025 15:25:35 +0200
Message-ID: <20251024132536.39841-6-frederic@kernel.org>
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

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index bddd816faaeb..73d9b0648116 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1511,8 +1511,7 @@ static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 	group->groupevt.ignore = true;
 }
 
-static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
-					   unsigned int lvl)
+static struct tmigr_group *tmigr_get_group(int node, unsigned int lvl)
 {
 	struct tmigr_group *tmp, *group = NULL;
 
@@ -1636,7 +1635,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node,
 		root_mismatch = tmigr_root->numa_node != node;
 
 	for (i = start_lvl; i < tmigr_hierarchy_levels; i++) {
-		group = tmigr_get_group(cpu, node, i);
+		group = tmigr_get_group(node, i);
 		if (IS_ERR(group)) {
 			err = PTR_ERR(group);
 			i--;
-- 
2.51.0


