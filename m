Return-Path: <linux-kernel+bounces-829089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD9EB9641A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A14D4A63CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F47732BC0F;
	Tue, 23 Sep 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmsQRlS2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD363294E5;
	Tue, 23 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637316; cv=none; b=L8IKeQsmXEuKjZiyj+Y4Ne8oC2BO294x25NXGyCKttta1aJlLK0ZUB05k1lKJG/OOnZ0hS8nUqOgR9hUPMD7R/Phwp3dri2hizbifxGVgXColLF/qnh11O8SC8y9418f2xPFM6WPq8d9ALrLF2xSBb/RijVw3U0+je4q0O+OBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637316; c=relaxed/simple;
	bh=XhR9e3hqlUudx27Vubeb4TW2DWMcOEhmyHuKz9F2A/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZYsHo0Mllii9bq9lohQ7rFGaYidCvkvSMkUTHZjIhBIZ3gypEfyAlqPrgG4mK3YVMZsiiFCwdAgCyWcKqg2lVRbYuqyVlxLohi2OCtrpl0WURAJ+bLrvRXAUlkdDaFvid8S8koNCQslTez+/5oFwQQ1013Zpwa29tCUv0ER3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmsQRlS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43A4C4CEF5;
	Tue, 23 Sep 2025 14:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637316;
	bh=XhR9e3hqlUudx27Vubeb4TW2DWMcOEhmyHuKz9F2A/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmsQRlS22/evgVeHiGU3FgC2zBql2UQd7beaQa45pTf4fhMxEWXk4mBBBSnu2r6vh
	 7iObu+6ntuaGMaArKy6lZejiXFWVIaYwaqLF99i+iPX6mHFn+3C+U4Z1TSjetR1nTz
	 uf7E4CSj3c3P8mq1X9HZsviftFFKBmcxm9FAynSAvyquQA6qPxxL0gRAydHjvIWcUx
	 jK8KeW7MRsyTx7FbpVs6XIJZJ1nh2uAabf07eB4o4NibebZfnyGDoZz2Q3GUg3VHQj
	 x6PUgkvGrgixV/AQUsS+jHI/c6zyXD8YCEtj8ziLxcQr967mLLOS1lFw8AfQ6V3fZ5
	 uLP65GSme0ndQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 14981CE18B1; Tue, 23 Sep 2025 07:20:38 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 31/34] refscale: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()
Date: Tue, 23 Sep 2025 07:20:33 -0700
Message-Id: <20250923142036.112290-31-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit updates the initialization for the "srcu-fast" scale
type to use DEFINE_STATIC_SRCU_FAST() when reader_flavor is equal to
SRCU_READ_FLAVOR_FAST.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/refscale.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 19841704d8f579..ece77f6d055b85 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -184,6 +184,7 @@ static const struct ref_scale_ops rcu_ops = {
 
 // Definitions for SRCU ref scale testing.
 DEFINE_STATIC_SRCU(srcu_refctl_scale);
+DEFINE_STATIC_SRCU_FAST(srcu_fast_refctl_scale);
 static struct srcu_struct *srcu_ctlp = &srcu_refctl_scale;
 
 static void srcu_ref_scale_read_section(const int nloops)
@@ -216,6 +217,12 @@ static const struct ref_scale_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+static bool srcu_fast_sync_scale_init(void)
+{
+	srcu_ctlp = &srcu_fast_refctl_scale;
+	return true;
+}
+
 static void srcu_fast_ref_scale_read_section(const int nloops)
 {
 	int i;
@@ -240,7 +247,7 @@ static void srcu_fast_ref_scale_delay_section(const int nloops, const int udl, c
 }
 
 static const struct ref_scale_ops srcu_fast_ops = {
-	.init		= rcu_sync_scale_init,
+	.init		= srcu_fast_sync_scale_init,
 	.readsection	= srcu_fast_ref_scale_read_section,
 	.delaysection	= srcu_fast_ref_scale_delay_section,
 	.name		= "srcu-fast"
-- 
2.40.1


