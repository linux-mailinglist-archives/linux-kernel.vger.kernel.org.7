Return-Path: <linux-kernel+bounces-792081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09145B3BFEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0007B2E32
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C838345722;
	Fri, 29 Aug 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCsXZhJJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4DC3451D5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482581; cv=none; b=uGof+BfW7Mw1AEGEUfithJt7uFVGQmbylSVv1DTH9ahlOJNoH//f6KAl4WFKFBqrn/Zxj7B6qkPyL2wPCPOpZS8n5Pw5FNW/lVlocqnq0dJOC0bpY8OjvwnRDUL1r+WoQHnASV+W6wVY91nOOUT5MuonNEHelbKmAAm1+/Cqf2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482581; c=relaxed/simple;
	bh=n52cAu7bEMYLK1x1CARbNE9gVHxK/1DrMBlj3TyiG6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2HGndQTMRi/UtkInXnlmq4x1tbVRD07gEMtBYYnFB42aQXU96gLUFWUDtcxQCP6hCP8bgy99bdoGh5av+SuhXOhFanQRVqzkStfijzjWpUFbfbQjFXAp5Ib0wSkptDXYdpp2oivJ7ulRi8x6BaP6VeOdf/lY7XZ+HIvHb2psHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCsXZhJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33CDC4CEF0;
	Fri, 29 Aug 2025 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482581;
	bh=n52cAu7bEMYLK1x1CARbNE9gVHxK/1DrMBlj3TyiG6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCsXZhJJuSzcbOV2emvF2IXQgJKhCJ5oXujhVYoIeYfxonhIaXF1jE2yHzbGZYJXd
	 1Tu8OzFhVZWH7+vWC7MhmuMqTOYc5Fq5Wnw8cNre6suETrByplGsG3SKt04IhqgeND
	 oJDUGuQ/Fau+jhxaHoGCUkrCtVsiWgSI1a21uUFqCIzh3iYNJj2GWhcQqSc2+BIWVH
	 O6sLuILxwt7yS+fb7mNUEAdKUU7pIUJymgQcll6mi70e8TFJYyR3pB2sxFkyOT0zJ1
	 klNAg/j5Ikn09eV0Sqv5cleve0i75Eat0A2vpSXtBZjm0ZVvSwioiUiTK8LveYC+7u
	 jFRGj4rua0aLA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 29/33] kthread: Comment on the purpose and placement of kthread_affine_node() call
Date: Fri, 29 Aug 2025 17:48:10 +0200
Message-ID: <20250829154814.47015-30-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It may not appear obvious why kthread_affine_node() is not called before
the kthread creation completion instead of after the first wake-up.

The reason is that kthread_affine_node() applies a default affinity
behaviour that only takes place if no affinity preference have already
been passed by the kthread creation call site.

Add a comment to clarify that.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 4d3cc04e5e8b..d36bdfbd004e 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -453,6 +453,10 @@ static int kthread(void *_create)
 
 	self->started = 1;
 
+	/*
+	 * Apply default node affinity if no call to kthread_bind[_mask]() nor
+	 * kthread_affine_preferred() was issued before the first wake-up.
+	 */
 	if (!(current->flags & PF_NO_SETAFFINITY) && !self->preferred_affinity)
 		kthread_affine_node();
 
-- 
2.51.0


