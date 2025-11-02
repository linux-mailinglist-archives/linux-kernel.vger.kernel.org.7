Return-Path: <linux-kernel+bounces-882023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E504C29796
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 22:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBA454EB336
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 21:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C06D266B6F;
	Sun,  2 Nov 2025 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0S5LSTA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937F24E4A1;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119879; cv=none; b=uAme7bwPnmBojJ+6hdGWZbCnQKyvVRPp+h7nOeF80eiC5U70z/QpnO+rijWD1ZkqBY3yP0eQpHNBIS5g5k3Ha/TRhYUWUfiKeTDRFGjy0BZEWE+jhy12/vlbZmvAhwwMBnjxR+FozfNGcrxvap+3O7lC5Y7l959JDGSkFgxxPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119879; c=relaxed/simple;
	bh=BK4yD7eyeQ0mHbL7KbeZ8Mx12t+bQxDXJ6lt6IBpXBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gks+wKfDjIGRyTs+/OZ54PsGdh8XfH5s7oL2dNFrlgoBLIfRu4KL+SB2eNTmLYSohlua/v3HmkMO03/6PHZZT3AoHVY+RA3aiwdVrcPDVQBlb45RF+m5fdahPZdBTjrJbK1iHNvF0kP1lrSrlekq5agGenju15/cdIbqnVoZiY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0S5LSTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DB6C19424;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762119879;
	bh=BK4yD7eyeQ0mHbL7KbeZ8Mx12t+bQxDXJ6lt6IBpXBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b0S5LSTAGO2TwFeFUsEWC5bltZQV08z5eZBbq0JSE1PLO53LHTTobxVp2hvPWZG1A
	 EvMxeHiI++c8lmiIVA222nmLMyu+DGL2csoE8G3XLzEZe54T9zt+h0K5t6sJQAo2Vb
	 bQBtNju+CnCSWA8v9cK6jE+2I2K2hsV6bxxoyUkAH6yqDwAvlc8cH8CcM/WiYJYsUq
	 y8bhT+eL9rw7zr06cLZhMqEshXeMkqoqVf+8887PzsKmEhrnvLbzr7Er32+827AzqZ
	 aRZtQznE0AIKx8bRbPNeTuvaMgKPUqYheztex5D4GXqTp60T7lzS99/U/bnjyj78OV
	 XpsxPSkKHaDGQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94712CE15AA; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH 11/19] rcu: Mark diagnostic functions as notrace
Date: Sun,  2 Nov 2025 13:44:28 -0800
Message-Id: <20251102214436.3905633-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_lockdep_current_cpu_online(), rcu_read_lock_sched_held(),
rcu_read_lock_held(), rcu_read_lock_bh_held(), rcu_read_lock_any_held()
are used by tracing-related code paths, so putting traces on them is
unlikely to make anyone happy.  This commit therefore marks them all
"notrace".

Reported-by: Leon Hwang <leon.hwang@linux.dev>
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c   | 2 +-
 kernel/rcu/update.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 31690ffa452a..8ddd07fed363 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4021,7 +4021,7 @@ bool rcu_cpu_online(int cpu)
  * RCU on an offline processor during initial boot, hence the check for
  * rcu_scheduler_fully_active.
  */
-bool rcu_lockdep_current_cpu_online(void)
+bool notrace rcu_lockdep_current_cpu_online(void)
 {
 	struct rcu_data *rdp;
 	bool ret = false;
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c912b594ba98..dfeba9b35395 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -117,7 +117,7 @@ static bool rcu_read_lock_held_common(bool *ret)
 	return false;
 }
 
-int rcu_read_lock_sched_held(void)
+int notrace rcu_read_lock_sched_held(void)
 {
 	bool ret;
 
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
  * Note that rcu_read_lock() is disallowed if the CPU is either idle or
  * offline from an RCU perspective, so check for those as well.
  */
-int rcu_read_lock_held(void)
+int notrace rcu_read_lock_held(void)
 {
 	bool ret;
 
@@ -367,7 +367,7 @@ EXPORT_SYMBOL_GPL(rcu_read_lock_held);
  * Note that rcu_read_lock_bh() is disallowed if the CPU is either idle or
  * offline from an RCU perspective, so check for those as well.
  */
-int rcu_read_lock_bh_held(void)
+int notrace rcu_read_lock_bh_held(void)
 {
 	bool ret;
 
@@ -377,7 +377,7 @@ int rcu_read_lock_bh_held(void)
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
 
-int rcu_read_lock_any_held(void)
+int notrace rcu_read_lock_any_held(void)
 {
 	bool ret;
 
-- 
2.40.1


